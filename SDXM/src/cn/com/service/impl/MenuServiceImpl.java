package cn.com.service.impl;

import java.io.Serializable;
import java.sql.SQLException;
import java.util.*;

import javax.annotation.Resource;

import cn.com.domain.Book;
import cn.com.utils.GenericClass;
import cn.com.utils.RandomStringUtil;
import cn.com.vo.ColumnCascade;
import cn.com.vo.ColumnInfo;
import cn.com.vo.PageResults;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.hibernate.classic.Session;
import org.springframework.orm.ObjectOptimisticLockingFailureException;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import cn.com.service.IMenuService;
import cn.com.dao.IMenuDao;
import cn.com.domain.Columnlist;
import cn.com.domain.User;

@Service("menuService")
public class MenuServiceImpl implements IMenuService {

	@Resource(name="menuDao")
	private IMenuDao menuDao;

	private final String NEWS_COLUMN = "新闻公告";

	@Transactional(readOnly=false)
	public void saveColumn(Columnlist columnList){
		this.menuDao.saveEntry(columnList);
	}
	
	@Transactional(readOnly=false)
	public void updateColumn(Columnlist columnList){
		this.menuDao.updateEntry(columnList);
	}
	
	@Transactional(readOnly=false)
	public void deleteColumn(Serializable id){
		this.menuDao.deleteByIds(id);
	}
	
	public Columnlist findComlumnById(Serializable id){
		return this.menuDao.getEntryById(id);
	}
	


	@Override
	public Collection<Columnlist> searchColumns(String searchStr) {
		return this.menuDao.findObjectsByConditionWithNoPage(" and name like '%" + searchStr +"%'");

	}

	@Override
	public Collection<Columnlist> allParentColumns() {
		return this.menuDao.findObjectsByConditionWithNoPage(" and level = 1");
	}

	@Override
	public Columnlist parentOfColumn(Integer columnId) {
		Columnlist columnlist = this.menuDao.getEntryById(columnId);
		if(columnlist == null) return null;
		return this.menuDao.getEntryById(columnlist.getParent());
	}

	public boolean saveSecondColumn(ColumnInfo columnInfo){
		//查找二级栏目是否存在
		String hql = " and o.name = ? and o.level = 2";
		Object[] params = {columnInfo.getSecondColumnName()};
		LinkedHashMap<String, String> orderBy=new LinkedHashMap<String, String>();
		orderBy.put("o.id", "asc");
		List<Columnlist> columns = this.menuDao.findObjectsByConditionWithNoPage(hql, params, orderBy);
		if (columns.size() > 0){
			return false;
		}
		this.menuDao.saveEntry(new Columnlist(columnInfo.getSecondColumnName(), 2, columnInfo.getFirstColumnId(), false));
		return true;
	}

	@Override
	public boolean updateColumn(Integer id, String name, Boolean hasContent) {
		return menuDao.updateColumn(id, name, hasContent);
	}

	@Override
	public boolean updateColumn(Integer id, String name, Integer parent, Boolean hasContent) {
		return menuDao.updateColumn(id, name, parent, hasContent);
	}

	@Override
	public PageResults<Columnlist> columnsOfPage(int pageNo) {
		return menuDao.findPageByFetchedHql("from Columnlist c ",
				"select count(*) from Columnlist", pageNo,
				10, null);
	}

	@Override
	public List<Columnlist> childrenOfColumn(Integer id) {
		return menuDao.findObjectsByConditionWithNoPage(" and parent = ?", new Object[]{id});
	}

	@Override
	public PageResults<Columnlist> columnsOfFirstPage() {
		return null;
	}

	@Override
	public PageResults<Columnlist> columnsOfLastPage() {
		return null;
	}

	@Override
	public List<ColumnCascade> searchColumnsByLevel(String searchStr) {
		return this.columnCascadesSolve(this.searchColumns(searchStr));
	}

	private List<ColumnCascade> columnCascadesSolve(Collection<Columnlist> columns){
		List<Columnlist> columnlist = new ArrayList<Columnlist>(columns);
		Collections.sort(columnlist, new ColumnCascade());
		List<ColumnCascade> columnCascade = new ArrayList<>();
		int firstLevel = 1;
		for(Columnlist column: columnlist){
			if(column.getLevel() == firstLevel){
				columnCascade.add(new ColumnCascade(column.getId(), column.getName(), column.getParent(), column.getHasContent()));
			} else {
				boolean hasParent = false;
				for(ColumnCascade parentColumn: columnCascade){
					if(parentColumn.getId().equals(column.getParent())){
						parentColumn.getChildren().add(new ColumnCascade(column.getId(), column.getName(), column.getParent(), column.getHasContent()));
						hasParent = !hasParent;
						break;
					}
				}
				if(!hasParent){
					//查找column的父column
					Columnlist parentColumn = this.findComlumnById(column.getParent());
					if(parentColumn != null){
						ColumnCascade parent = new ColumnCascade(parentColumn.getId(), parentColumn.getName(),
								parentColumn.getParent(), parentColumn.getHasContent());
						parent.getChildren().add(new ColumnCascade(column.getId(), column.getName(), column.getParent(), column.getHasContent()));
						columnCascade.add(parent);
					} else {
						columnCascade.add(new ColumnCascade(column.getId(), column.getName(), column.getParent(), column.getHasContent()));
					}
				}
			}
		}
		return columnCascade;
	}

	@Override
	public List<ColumnCascade> columnsByLevel() {
		return this.columnCascadesSolve(this.getAllColumns());
	}

	/**
	 * 获取所有栏目（按照层级返回）
	 */
	public Collection<Columnlist> getAllColumns(){
		return menuDao.getAllEntry();
	}

	@Override
	public List<Columnlist> findByName(String name) {
		return this.menuDao.findByName(name);
	}

	@Override
	public List<Columnlist> columnsOfNews() {
		List<Columnlist> columnlists = this.findByName(NEWS_COLUMN);
		if(columnlists.size() == 0) return null;
		return this.childrenOfColumn(columnlists.get(0).getId());
	}
}
