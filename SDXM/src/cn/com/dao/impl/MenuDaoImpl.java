package cn.com.dao.impl;


import cn.com.dao.IMenuDao;
import cn.com.dao.base.impl.BaseDaoImpl;
import cn.com.domain.Columnlist;
import cn.com.utils.GenericClass;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.stereotype.Repository;

import javax.annotation.Resource;
import java.sql.SQLException;
import java.util.Collection;
import java.util.List;

@Repository("menuDao")
public class MenuDaoImpl extends BaseDaoImpl<Columnlist> implements IMenuDao {
    private Class clazz = GenericClass.getGenericClass(this.getClass());

    @Resource(name = "hibernateTemplate")
    public HibernateTemplate hibernateTemplate;

    @Resource
    private SessionFactory sessionFactory;

    @Override
    public boolean updateColumn(Integer id, String name, Boolean hasContent) {
        String hql = "update Columnlist set name = ? , hasContent = ? where id = ?";
        Object[] params = {name, hasContent, id};
        return updateColumn(hql, params);

    }

    @Override
    public boolean updateColumn(Integer id, String name, Integer parent, Boolean hasContent) {
        String hql = "update Columnlist c set c.name = ? , c.parent = ? , hasContent = ? where c.id = ?";
        Object[] params = {name, parent, hasContent, id};
        return updateColumn(hql, params);
    }

    private boolean updateColumn(String hql, Object[] params){
		Session session = sessionFactory.openSession();
        Query query = session.createQuery(hql);
        setParam(query, params);
        query.executeUpdate();
        session.close();
        return true;
    }

    @Override
    public List<Columnlist> findByName(String name) {
        String query = "from Columnlist columnlist where columnlist.name = '" + name + "'";
        return this.hibernateTemplate.find(query);
    }

}
