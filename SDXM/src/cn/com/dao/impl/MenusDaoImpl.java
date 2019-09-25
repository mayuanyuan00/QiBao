package cn.com.dao.impl;

import cn.com.dao.IMenusDao;
import cn.com.dao.base.impl.BaseDaoImpl;
import cn.com.domain.Menu;
import org.hibernate.SQLQuery;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;


/**
 * Created by Ting on 2018/4/20
 */
@Repository("menusDao")
public class MenusDaoImpl extends BaseDaoImpl<Menu> implements IMenusDao {
    @Override
    @Transactional
    public List<Menu> selectByName(String name) {
        String sql = "select * from menu where is_delete = '0' and groupname = ?";
        SQLQuery query = this.getSession().createSQLQuery(sql).addEntity(Menu.class);
        query.setParameter(0,name);
        return query.list();
    }

    @Override
    @Transactional
    public List<Menu> selectByUrl(String url) {
        String sql = "select * from menu where is_delete = '0' and url = ?";
        SQLQuery query = this.getSession().createSQLQuery(sql).addEntity(Menu.class);
        query.setParameter(0,url);
        return query.list();
    }

    @Override
    @Transactional
    public void addColumn(Menu menu) {
        this.saveEntry(menu);
    }

    @Override
    @Transactional
    public void deleteColumn(int id) {
        this.deleteByIds(id);
    }
}
