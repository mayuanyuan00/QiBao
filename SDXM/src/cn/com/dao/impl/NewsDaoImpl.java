package cn.com.dao.impl;

import cn.com.dao.IMessageDao;
import cn.com.dao.INewsDao;
import cn.com.dao.base.impl.BaseDaoImpl;

import cn.com.domain.News;
import cn.com.vo.PageResults;
import org.hibernate.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by ironman on 2017/9/29.
 */
@Repository("newsDao")
public class NewsDaoImpl extends BaseDaoImpl<News> implements INewsDao {
    @Override
    @Transactional
    public PageResults<News> newsOfTypeByPage(String hql, String countHql, int page, int pageSize) {
        return this.findPageByFetchedHql(hql, countHql, page, pageSize, null);
    }

    @Override
    @Transactional
    public List<News> findByIds(List<String> ids) {
        if(ids.size() == 0) return new ArrayList<>();
        String query = " from News news where news.id in( ";
        for(String id: ids) {
            query += "'" +id + "',";
        }
        query = query.substring(0, query.length() - 1);
        query += ")";
        return this.hibernateTemplate.find(query);
    }

    @Override
    @Transactional
    public List<News> findByTypes(List<Integer> types) {
        if(types.size() == 0) return new ArrayList<>();
        String query = " from News news where news.type in( ";
        for(int type: types) {
            query += type + ",";
        }
        query = query.substring(0, query.length() - 1);
        query += ")";
        return this.hibernateTemplate.find(query);
    }

    @Override
    @Transactional
    public List<News> findLimit(List<Integer> types, Integer limit) {
        if(types.size() == 0) return new ArrayList<>();
        String query = " from News news where news.type in( ";
        for(int type: types) {
            query += type + ",";
        }
        query = query.substring(0, query.length() - 1);
        query += ")";
        query+=" order by news.createTime desc ";
        return this.hibernateTemplate.find(query);
    }

    @Override
    @Transactional
    public List<News> findLimit(Integer type, Integer limit) {
        String hql ="";
        if(type>0) {
            hql = " from News news where news.type="+type +" order by news.createTime desc ";
        }else if (type==-10){
//            hql = " from News news where news.type in (10,11,9) order by news.createTime desc ";
            hql = " from News news  order by news.createTime desc ";
        }
        Query query = this.getSession().createQuery(hql);
        query.setMaxResults(limit);
        return query.list();
    }

    @Override
    @Transactional
    public List<String> newsListofType(Integer type) {
        String hql ="";
        if(type>0) {
            hql = "select id from News news where news.type="+type;
        }else if (type==-10){
            hql = "select id from News news where news.type in (10,11,9)";
        }
        hql += "order by news.createTime desc";
        Query query = this.getSession().createQuery(hql);
        return query.list();
    }


    @Override
    @Transactional
    public List<News> findWithPicOrVideosOrederByTime(Integer limit) {
        String hql= "from News news where news.pics is not null or news.videos is not null and news.type in (10,11,9) order by  news.createTime desc ";
        Query query = this.getSession().createQuery(hql);
        query.setMaxResults(limit);
        return query.list();
    }
}
