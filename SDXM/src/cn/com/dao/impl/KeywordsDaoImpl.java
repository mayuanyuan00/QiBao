package cn.com.dao.impl;

import cn.com.dao.IKeywordsDao;
import cn.com.dao.base.impl.BaseDaoImpl;
import cn.com.domain.Keywords;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;


/**
 * Created by ironman on 2017/11/8.
 */
@Repository("keywordsDao")
public class KeywordsDaoImpl extends BaseDaoImpl<Keywords> implements IKeywordsDao{

    @Override
    @Transactional
    public void deleteByIds(List<Integer> ids) {
        Session session = this.hibernateTemplate.getSessionFactory().openSession();
        Transaction trans = session.beginTransaction();
        String hql = "delete from Keywords keywords where keywords.id in (:ids)";
        session.createQuery(hql).setParameterList("ids", ids).executeUpdate();
        trans.commit();
        session.close();
    }

    @Override
    @Transactional
    public void deleteByNames(List<String> names) {
        Session session = this.hibernateTemplate.getSessionFactory().openSession();
        Transaction trans = session.beginTransaction();
        String hql = "delete from Keywords keywords where keywords.name in (:names)";
        session.createQuery(hql).setParameterList("names", names).executeUpdate();
        trans.commit();
        session.close();
    }

    @Override
    @Transactional
    public void deleteByName(String name) {
        Session session = this.hibernateTemplate.getSessionFactory().openSession();
        Transaction trans = session.beginTransaction();
        String hql = "delete from Keywords keywords where keywords.name=?";
        session.createQuery(hql).setParameter(0, name).executeUpdate();
        trans.commit();
        session.close();
    }

    @Override
    public List<Keywords> findByIds(List<Integer> ids) {
        String query = " from Keywords keywords where keywords.id in( ";
        for(int id: ids) {
            query += id + ",";
        }
        query = query.substring(0, query.length() - 1);
        query += ")";
        return this.hibernateTemplate.find(query);
    }

    @Override
    public List<Keywords> findByName(String keyword) {
        String query = "from Keywords keywords where keywords.name = '" + keyword + "'";
        return this.hibernateTemplate.find(query);
    }

    @Override
    public List<Keywords> findByNames(List<String> keywords) {
        String query = " from Keywords keywords where keywords.name in( ";
        for(String keyword: keywords) {
            query += "'" + keyword + "',";
        }
        query = query.substring(0, query.length() - 1);
        query += ")";
        return this.hibernateTemplate.find(query);
    }

    @Override
    @Transactional
    public void addKeywords(List<String> keywords) {
        Session session = this.hibernateTemplate.getSessionFactory().openSession();
        Transaction trans = session.beginTransaction();
        for(int i = 0; i < keywords.size(); i++) {
            Keywords keyword = new Keywords(keywords.get(i));
            session.save(keyword);
            if(i % 20 == 0) {
                session.flush();
                session.clear();
            }
        }
        trans.commit();
        session.close();
    }
}
