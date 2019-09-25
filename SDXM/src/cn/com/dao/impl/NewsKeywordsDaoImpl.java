package cn.com.dao.impl;

import cn.com.dao.INewsKeywordsDao;
import cn.com.dao.base.impl.BaseDaoImpl;
import cn.com.domain.Keywords;
import cn.com.domain.News;
import cn.com.domain.NewsKeywords;
import cn.com.vo.PageResults;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by ironman on 2017/11/8.
 */
@Repository("newsKeywordsDao")
public class NewsKeywordsDaoImpl extends BaseDaoImpl<NewsKeywords> implements INewsKeywordsDao {

    @Override
    @Transactional
    public void insertEntries(List<NewsKeywords> newsKeywordsList) {
        Session session = this.hibernateTemplate.getSessionFactory().openSession();
        Transaction trans = session.beginTransaction();
        for(int i = 0; i < newsKeywordsList.size(); i++) {
            session.save(newsKeywordsList.get(i));
            if(i % 20 == 0) {
                session.flush();
                session.clear();
            }
        }
        trans.commit();
        session.close();
    }

    @Override
    public void insertEntriesOfOneNews(String news, List<Keywords> keywords) {
        List<NewsKeywords> newsKeywordsList = new ArrayList<NewsKeywords>();
        for(Keywords keyword : keywords){
            newsKeywordsList.add(new NewsKeywords(news, keyword.getId()));
        }
        this.insertEntries(newsKeywordsList);
    }

    @Override
    public void deleteEntries(List<Integer> ids) {
        Session session = this.hibernateTemplate.getSessionFactory().openSession();
        Transaction trans = session.beginTransaction();
        String hql = "delete from NewsKeywords newskeywords where newskeywords.id in (:ids)";
        session.createQuery(hql).setParameterList("ids", ids).executeUpdate();
        trans.commit();
        session.close();
    }

    @Override
    @Transactional
    public PageResults<NewsKeywords> keywordsOfNewsByPage(String hql, String countHql, int page, int pageSize) {
        return this.findPageByFetchedHql(hql, countHql, page, pageSize, null);
    }

    @Override
    @Transactional
    public PageResults<NewsKeywords> newsOfKeywordsByPage(String hql, String countHql, int page, int pageSize) {
        return this.findPageByFetchedHql(hql, countHql, page, pageSize, null);
    }

    @Override
    public List<String> getNewsByKeywordsAndPage(List<Integer> keywords, int start, int pageSize) {
        if(keywords.size() == 0) return new ArrayList<>();
        Session session = this.hibernateTemplate.getSessionFactory().openSession();
        final String hql = "select distinct news.news from NewsKeywords news where news.keywords in (:keywords)";
        List<String> results = session.createQuery(hql).setParameterList("keywords", keywords).setFirstResult(start).setMaxResults(pageSize).list();
        session.close();
        return results;
       /* String query = "select distinct news.news from NewsKeywords news where news.keywords in( ";
        for(Integer keyword: keywords) {
            query += keyword + ",";
        }
        query = query.substring(0, query.length() - 1);
        query += ") limit " + start + ", " + pageSize;
        return this.hibernateTemplate.find(query);*/
    }

    @Override
    public long numOfConcerningNews(List<Integer> keywords) {
        String query = "select count(distinct news.news) from NewsKeywords news where news.keywords in( ";
        for(Integer keyword: keywords) {
            query += keyword + ",";
        }
        query = query.substring(0, query.length() - 1);
        query += ")";
        List<Long> nums = this.hibernateTemplate.find(query);
        return nums.size() > 0 ? nums.get(0) : 0;
    }
}
