package cn.com.dao;

import cn.com.dao.base.IBaseDao;
import cn.com.domain.Keywords;
import cn.com.domain.News;
import cn.com.domain.NewsKeywords;
import cn.com.vo.PageResults;

import java.util.List;

/**
 * Created by ironman on 2017/11/8.
 */
public interface INewsKeywordsDao extends IBaseDao<NewsKeywords> {

    void insertEntries(List<NewsKeywords> newsKeywordsList);

    void insertEntriesOfOneNews(String news, List<Keywords> keywords);

    void deleteEntries(List<Integer> ids);

    PageResults<NewsKeywords> keywordsOfNewsByPage(String hql, String countHql, int page, int pageSize);

    PageResults<NewsKeywords> newsOfKeywordsByPage(String hql, String countHql, int page, int pageSize);

    List<String> getNewsByKeywordsAndPage(List<Integer> keywords, int start, int pageSize);

    long numOfConcerningNews(List<Integer> keywords);

}
