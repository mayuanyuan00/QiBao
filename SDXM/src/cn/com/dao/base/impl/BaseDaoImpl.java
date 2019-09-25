package cn.com.dao.base.impl;

import java.io.Serializable;
import java.math.BigInteger;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.ScrollableResults;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.CriteriaSpecification;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.util.StringUtils;

import cn.com.dao.base.IBaseDao;
import cn.com.utils.GenericClass;
import cn.com.vo.PageResults;

@SuppressWarnings("unchecked")
public class BaseDaoImpl<T> implements IBaseDao<T> {

    private Class clazz = GenericClass.getGenericClass(this.getClass());

    @Resource(name = "hibernateTemplate")
    public HibernateTemplate hibernateTemplate;

    @Resource
    private SessionFactory sessionFactory;


    public Collection<T> getAllEntry() {
        String whereHql = "from " + clazz.getName();
        List<T> list = this.hibernateTemplate.find(whereHql);
        return list;
    }

    public Session getSession() {
        return sessionFactory.getCurrentSession();
    }

    /**
     * <根据HQL得到记录数>
     *
     * @param hql
     * @param values
     * @return
     */
    public Long countByHql(String hql, Object[] values, boolean isHql) {
        Query query;
        if (isHql) query = getSession().createQuery(hql);
        else query = getSession().createSQLQuery(hql);

        if (values != null) {
            for (int i = 0; i < values.length; i++) {
                query.setParameter(i, values[i]);
            }
        }
        Object result = query.uniqueResult();
        if (result instanceof BigInteger) {
            return ((BigInteger) result).longValue();
        }
        return (Long) result;
    }

    /**
     * <HQL分页查询>
     *
     * @param hql
     * @param countHql 查询记录条数的HQL语句
     * @param pageNo   下一页
     * @param pageSize 一页总条数
     * @param values
     * @return
     */
    public PageResults<T> findPageByFetchedHql(String hql, String countHql,
                                               int pageNo, int pageSize, Object[] values) {
        PageResults<T> retValue = new PageResults<T>();
        Query query = getSession().createQuery(hql);
        if (values != null) {
            for (int i = 0; i < values.length; i++) {
                query.setParameter(i, values[i]);
            }
        }
        int currentPage = pageNo > 1 ? pageNo : 1;
        retValue.setCurrentPage(currentPage);
        retValue.setPageSize(pageSize);
        if (countHql == null) {
            ScrollableResults results = query.scroll();
            results.last();
            retValue.setTotalCount(results.getRowNumber() + 1);// 设置总记录数
        } else {
            Long count = countByHql(countHql, values, true);
            retValue.setTotalCount(count.intValue());
        }
        List<T> itemList = query.setFirstResult((currentPage - 1) * pageSize).setMaxResults(pageSize).list();
        if (itemList == null) {
            itemList = new ArrayList<T>();
        }
        retValue.setResults(itemList);
        return retValue;
    }

    @Override
    public PageResults<T> findPageByFetchedSql(String sql, String countSql, Class<T> entity, int pageNo, int pageSize, Object[] values) {
        PageResults<T> retValue = new PageResults<T>();
        Query query = getSession().createSQLQuery(sql).addEntity(entity);
        if (values != null) {
            for (int i = 0; i < values.length; i++) {
                query.setParameter(i, values[i]);
            }
        }
        int currentPage = pageNo > 1 ? pageNo : 1;
        retValue.setCurrentPage(currentPage);
        retValue.setPageSize(pageSize);
        if (countSql == null) {
            ScrollableResults results = query.scroll();
            results.last();
            retValue.setTotalCount(results.getRowNumber() + 1);// 设置总记录数
        } else {
            Long count = countByHql(countSql, values, false);
            retValue.setTotalCount(count.intValue());
        }
        List<T> itemList = query.setFirstResult((currentPage - 1) * pageSize)
                .setMaxResults(pageSize)
                .list();
        if (itemList == null) {
            itemList = new ArrayList<T>();
        }
        retValue.setResults(itemList);
        return retValue;
    }

    @Override
    public PageResults<Map> findMapByFetchSql(String sql, String countSql, int pageNo, int pageSize, Object[] values) {
        PageResults<Map> retValue = new PageResults<>();
        Query query = getSession().createSQLQuery(sql);
        if (values != null) {
            for (int i = 0; i < values.length; i++) {
                query.setParameter(i, values[i]);
            }
        }
        int currentPage = pageNo > 1 ? pageNo : 1;
        retValue.setCurrentPage(currentPage);
        retValue.setPageSize(pageSize);
        if (countSql == null) {
            ScrollableResults results = query.scroll();
            results.last();
            retValue.setTotalCount(results.getRowNumber() + 1);// 设置总记录数
        } else {
            Query countQuery = getSession().createSQLQuery(countSql);
            if (values != null) {
                for (int i = 0; i < values.length; i++) {
                    countQuery.setParameter(i, values[i]);
                }
            }
            BigInteger count = (BigInteger) countQuery.uniqueResult();
            retValue.setTotalCount(count.intValue());
        }
        List itemList = query.setFirstResult((currentPage - 1) * pageSize)
                .setMaxResults(pageSize)
                .setResultTransformer(CriteriaSpecification.ALIAS_TO_ENTITY_MAP)
                .list();
        if (itemList == null) {
            itemList = new ArrayList<>();
        }
        //noinspection unchecked
        retValue.setResults(itemList);
        return retValue;
    }


    public T getEntryById(Serializable id) {
        if (id == null) {
            throw new RuntimeException("您要查找的[" + id + "]不能为空");
        }
        T t = (T) this.hibernateTemplate.get(clazz, id);
        return t;
    }


    public void saveEntry(T t) {
         this.hibernateTemplate.save(t);
    }

    public Integer saveReturnId(T t) {
        return (Integer)this.hibernateTemplate.save(t);
    }

    public void updateEntry(T t) {
        this.hibernateTemplate.update(t);
    }

    public void deleteByIds(Serializable... ids) {
        if (ids != null && ids.length > 0) {
            for (Serializable id : ids) {
                Object obj = this.hibernateTemplate.get(clazz, id);
                if (obj == null) {
                    throw new RuntimeException("您要查找的[" + id + "]不存在");
                }
                this.hibernateTemplate.delete(obj);
            }
        }
    }

    @Override
    public List<T> findObjectsByConditionWithNoPage(String whereHql, final Object[] params,
                                                    LinkedHashMap<String, String> orderBy) {
        // 组织hql语句
        String hql = "from " + clazz.getSimpleName() + " o where 1=1 ";
        if (StringUtils.hasText(whereHql)) {
            hql = hql + whereHql;
        }
        // 处理排序
        if (orderBy != null && orderBy.size() != 0) {
            String orderbystr = buildOrderBy(orderBy);
            hql = hql + orderbystr;
        }
        final String fhql = hql;
        List<T> list = (List<T>) this.hibernateTemplate.execute(new HibernateCallback() {
            public Object doInHibernate(Session session) throws HibernateException, SQLException {
                Query query = session.createQuery(fhql);
                if (params != null && params.length != 0) {
                    setParam(query, params);
                }
                return query.list();
            }

        });
        return list;
    }

    public List<T> findObjectsByConditionWithNoPage(String whereHql, final Object[] params) {
        return findObjectsByConditionWithNoPage(whereHql, params, new LinkedHashMap<String, String>());
    }

    public List<T> findObjectsByConditionWithNoPage(String whereHql) {
        Object[] params = {};
        return findObjectsByConditionWithNoPage(whereHql, params, new LinkedHashMap<String, String>());
    }

    @Override
    public List<T> findObjectsWithPage(String hql, int start, int count) {
        return findObjectsWithPage(hql, null, start, count);
    }

    @Override
    public List<T> findObjectsWithPage(final String hql, final Object[] params, final int start, final int count) {
        return (List<T>) this.hibernateTemplate.execute(new HibernateCallback() {
            public Object doInHibernate(Session session) throws HibernateException, SQLException {
                Query query = session.createQuery(hql);
                if (params != null && params.length != 0) {
                    setParam(query, params);
                }
                return query.setFirstResult(start).setMaxResults(count).list();
            }
        });
    }


    public void setParam(Query query, Object[] params) {
        if (params != null && params.length > 0) {
            for (int i = 0; i < params.length; i++) {
                query.setParameter(i, params[i]);
            }
        }
    }

    private String buildOrderBy(LinkedHashMap<String, String> orderBy) {
        StringBuffer buf = new StringBuffer();
        if (orderBy != null && !orderBy.isEmpty()) {
            buf.append(" order by ");
            for (Map.Entry<String, String> em : orderBy.entrySet()) {
                buf.append(em.getKey() + " " + em.getValue() + ",");
            }
            // 去掉最后一个逗号
            buf.deleteCharAt(buf.length() - 1);
        }
        return buf.toString();
    }

}
