package cn.com.service;

import cn.com.domain.Keywords;
import cn.com.domain.News;
import cn.com.domain.NewsKeywords;
import cn.com.vo.NewsTriple;
import cn.com.vo.PageResults;
import cn.com.vo.Pair;

import java.util.Date;
import java.util.List;

/**
 * Created by ironman on 2017/11/8.
 */
public interface INewsKeywordsService {
    // 新增记录
    void insertEntry(NewsKeywords newsKeywords);

    // 批量新增记录
    void insertEntries(List<NewsKeywords> newsKeywordsList);

    // 删除记录
    void deleteEntry(int id);

    // 批量删除记录
    void deleteEntriesById(List<Integer> ids);

    // 批量删除记录
    void deleteEntries(List<NewsKeywords> newsKeywordsList);

    // 更新记录
    void updateOneEntry(NewsKeywords newsKeywords);

    // 根据新闻获取关键字
    PageResults<NewsKeywords> keywordsOfNews(String news);

    List<String> keywordsNameOfNews(String news);

    List<Integer> keywordsIdsOfNews(String news);

    // 根据关键字获取新闻
    PageResults<NewsKeywords> newsOfKeywords(int keywords);

    PageResults<NewsKeywords> keywordsOfNewsByPage(String news, int page, int pageSize);

    PageResults<NewsKeywords> newsOfKeywordsByPage(int keywords, int page, int pageSize);

    // 按照一组关键字获取新闻(返回的是新闻的id)
    List<String> newsOfKeywordIds(List<Integer> keywords);

    List<String> newsOfKeywordNames(List<String> keywords);

    List<String> newsOfKeywordIdsByPage(List<Integer> keywords, int pageSize);

    List<String> newsOfKeywordNamesByPage(List<String> keywords, int pageSize);

    // 新闻延伸阅读(返回新闻标题)
    List<NewsTriple> concerningNews(String news);

    List<NewsTriple> concerningNews(String news, int pageSize);

    List<NewsTriple> recommendNewsByPage(String news, int page, int pageSize);



    // 删除某条新闻的关键词
    void deleteKeywordsOfNews(String news);

    // 跟新某条新闻的关键词
    void updateKeywordsOfNews(String news, List<String> Keywords);

    // 按照一组关键词获取新闻的ids（按页）
    List<String> getNewsByKeywordsAndPage(List<Integer> keywords, int page, int pageSize);

    List<String> getNewsByKeywordsAndPage(List<Integer> keywords, int page);

    List<News> getConcerningNewsByPage(String news, int page, int pageSize);

    List<News> getConcerningNewsByPage(String news, int page);

    List<NewsTriple> getConcerningNewsForList(String news);

    long numOfConcerningNews(String news);

    long pagesOfConcerningNews(String news);

}
