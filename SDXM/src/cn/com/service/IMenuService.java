package cn.com.service;

import java.io.Serializable;
import java.util.Collection;
import java.util.List;

import cn.com.domain.Columnlist;
import cn.com.vo.ColumnCascade;
import cn.com.vo.ColumnInfo;
import cn.com.vo.PageResults;

public interface IMenuService {
	/**
	 * 增加新栏目
	 * @param columnList
	 */
	public void saveColumn(Columnlist columnList);
	
	/**
	 * 更新栏目
	 * @param columnList
	 */
	public void updateColumn(Columnlist columnList);
	
	/**
	 * 删除栏目
	 * @param id	栏目id
	 */
	public void deleteColumn(Serializable id);
	
	/**
	 * 查询栏目
	 * @param id	栏目id
	 * @return
	 */
	public Columnlist findComlumnById(Serializable id);
	
	/**
	 * 获取所有栏目
	 * @param id 栏目id
	 */
	public Collection<Columnlist> getAllColumns();



	/**
	 * 获取所有栏目（按照层级返回）
	 */
	public List<ColumnCascade> columnsByLevel();

	/**
	 * 搜索栏目(用于后台展示）
	 */

	public List<ColumnCascade> searchColumnsByLevel(String searchStr);

	/**
	 * 搜索栏目
	 *
	 */
	public Collection<Columnlist> searchColumns(String searchStr);

 	/**
	 * 获取所有一级栏目
	 * @return
	 */
	public Collection<Columnlist> allParentColumns();

	/**
	 * 获取二级栏目的父栏目
	 * @return 如果不存在，返回null
	 */
	public Columnlist parentOfColumn(Integer columnId);

	/**
	 * 插入二级栏目
	 * @param columnInfo
	 * @return
	 */
	public boolean saveSecondColumn(ColumnInfo columnInfo);


	/**
	 * 获取指定页的栏目
	 */
	public PageResults<Columnlist> columnsOfPage(int page);

	/**
	 * 获取首页栏目
	 */
	public PageResults<Columnlist> columnsOfFirstPage();

	/**
	 * 获取尾页栏目
	 */
	public PageResults<Columnlist> columnsOfLastPage();



	/**
	 * 获取一级栏目的子栏目
	 */
	public List<Columnlist> childrenOfColumn(Integer id);

	/**
	 * 修改栏目名称
	 */
	public boolean updateColumn(Integer id, String name, Boolean hasContent);

	public boolean updateColumn(Integer id, String name, Integer parent, Boolean hasContent);

	//根据栏目名获取栏目
	public List<Columnlist> findByName(String name);

	//获取新闻公告下面的栏目
	public List<Columnlist> columnsOfNews();


}
