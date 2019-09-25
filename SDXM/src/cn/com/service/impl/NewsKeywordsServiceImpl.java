package cn.com.service.impl;

import cn.com.dao.IKeywordsDao;
import cn.com.dao.INewsDao;
import cn.com.dao.INewsKeywordsDao;
import cn.com.domain.Keywords;
import cn.com.domain.News;
import cn.com.domain.NewsKeywords;
import cn.com.service.INewsKeywordsService;
import cn.com.vo.NewsTriple;
import cn.com.vo.PageResults;
import cn.com.vo.Pair;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by ironman on 2017/11/8.
 */
@Service("newsKeywordsService")
public class NewsKeywordsServiceImpl implements INewsKeywordsService{

    @Resource(name="newsKeywordsDao")
    private INewsKeywordsDao newsKeywordsDao;

    @Resource(name="keywordsDao")
    private IKeywordsDao keywordsDao;

    @Resource(name="newsDao")
    private INewsDao newsDao;

    private final int PAGE_SIZE = 10;

    private final int PAGE_SIZE_FOR_MORE = 5;

    @Override
    public void insertEntry(NewsKeywords newsKeywords) {
        newsKeywordsDao.saveEntry(newsKeywords);
    }

    @Override
    public void insertEntries(List<NewsKeywords> newsKeywordsList) {
        newsKeywordsDao.insertEntries(newsKeywordsList);
    }

    @Override
    public void deleteEntry(int id) {
        newsKeywordsDao.deleteByIds(id);
    }

    @Override
    public void deleteEntriesById(List<Integer> ids) {
        newsKeywordsDao.deleteEntries(ids);
    }

    @Override
    public void deleteEntries(List<NewsKeywords> newsKeywordsList) {
        List<Integer> ids = new ArrayList<Integer>();
        for(NewsKeywords newsKeywords: newsKeywordsList){
            ids.add(newsKeywords.getId());
        }
        this.newsKeywordsDao.deleteEntries(ids);
    }

    @Override
    public void updateOneEntry(NewsKeywords newsKeywords) {
        newsKeywordsDao.saveEntry(newsKeywords);
    }

    @Override
    public PageResults<NewsKeywords> keywordsOfNews(String news) {
        return this.keywordsOfNewsByPage(news, 1, PAGE_SIZE);
    }

    @Override
    public List<String> keywordsNameOfNews(String news) {
        List<Integer> keywordsIds = this.keywordsIdsOfNews(news);
        ArrayList<String> keywordsNames = new ArrayList<>();
        if(keywordsIds.size() > 0) {
            List<Keywords> keywordsList = this.keywordsDao.findByIds(keywordsIds);
            for (Keywords keywords : keywordsList) {
                keywordsNames.add(keywords.getName());
            }
        }
        return keywordsNames;
    }

    @Override
    public List<Integer> keywordsIdsOfNews(String news) {
        PageResults<NewsKeywords> newsKeywordsPageResults = this.keywordsOfNews(news);
        ArrayList<Integer> keywordsIds = new ArrayList<>();
        if(newsKeywordsPageResults.getTotalCount() > 0){
            for(NewsKeywords newsKeywords: newsKeywordsPageResults.getResults()) {
                keywordsIds.add(newsKeywords.getKeywords());
            }
        }
        return keywordsIds;
    }

    @Override
    public PageResults<NewsKeywords> newsOfKeywords(int keywords) {
        return this.newsOfKeywordsByPage(keywords, 1, PAGE_SIZE);
    }

    @Override
    public PageResults<NewsKeywords> keywordsOfNewsByPage(String news, int page, int pageSize) {
        String hql = "from NewsKeywords newskeywords where newskeywords.news = '" + news + "' order by newskeywords.createTime desc";
        String countHql = " select count(*) from NewsKeywords newskeywords where newskeywords.news = '" + news + "'";
        return this.newsKeywordsDao.keywordsOfNewsByPage(hql, countHql, page, pageSize);
    }

    @Override
    public PageResults<NewsKeywords> newsOfKeywordsByPage(int keywords, int page, int pageSize) {
        String hql = "from NewsKeywords newskeywords where newskeywords.keywords = '" + keywords + "' order by newskeywords.createTime desc";
        String countHql = " select count(*) from NewsKeywords newskeywords where newskeywords.keywords = '" + keywords + "'";
        PageResults<NewsKeywords> pageResults = this.newsKeywordsDao.newsOfKeywordsByPage(hql, countHql, page, pageSize);
        return pageResults;

    }

    @Override
    public List<String> newsOfKeywordIds(List<Integer> keywords) {
        return this.newsOfKeywordIdsByPage(keywords, PAGE_SIZE);
    }

    @Override
    public List<String> newsOfKeywordNames(List<String> keywords) {
        return this.newsOfKeywordNamesByPage(keywords, PAGE_SIZE);
    }

    @Override
    @Transactional
    public List<String> newsOfKeywordIdsByPage(List<Integer> keywords, int pageSize) {
        // 尽量做到每个关键词文章数量等分
        List<String> newsIds = new ArrayList<String>();
        List<List<NewsKeywords>> news = new ArrayList<List<NewsKeywords>>();
        for(int keyword: keywords) {
            List<NewsKeywords> newsList = this.newsOfKeywordsByPage(keyword, 1, pageSize + 1).getResults();
            news.add(newsList);
        }
        int turn = 0;
        int group = keywords.size();
        boolean exhausted = false;
        int left = group;
        int[] indice = new int[group];
        if(group == 0){
            return new ArrayList<String>();
        }
        for(int i = 0 ; i < pageSize + 1; i ++) {
            while (indice[turn] >= news.get(turn).size()) {
                //该组元素已经耗尽
                turn = (turn + 1) % group;
                left --;
                if(left <= 0) {
                    exhausted = true;
                    break;
                }
            }
            if(exhausted) break;
            String id = news.get(turn).get(indice[turn]).getNews();
            if(!this.newsInList(id, newsIds)){
                newsIds.add(id);
            }
            indice[turn] ++;
            turn = (turn + 1) % group;
        }
        return newsIds;
    }

    private boolean newsInList(String news, List<String> newsList){
        for(String oneNews: newsList){
            if (news.equals(oneNews))
                return true;
        }
        return false;
    }

    @Override
    public List<String> newsOfKeywordNamesByPage(List<String> keywords, int pageSize) {
        // 按名获取keywords
        List<Keywords> keywordList = keywordsDao.findByNames(keywords);
        List<Integer> keywordsIds = new ArrayList<Integer>();
        for(Keywords keyword: keywordList){
            keywordsIds.add(keyword.getId());
        }
        return this.newsOfKeywordIdsByPage(keywordsIds, pageSize);
    }

    @Override
    public List<NewsTriple> concerningNews(String news) {
        return this.concerningNews(news, PAGE_SIZE);
    }

    @Override
    public List<NewsTriple> recommendNewsByPage(String news, int page, int pageSize) {
        return this.recommendNewsByPage(news, page, PAGE_SIZE_FOR_MORE);
    }



    @Override
    public List<NewsTriple> concerningNews(String news, int pageSize) {
        List<Integer> keywordsIds = new ArrayList<Integer>();
        for(NewsKeywords newsKeyword: this.keywordsOfNews(news).getResults()) {
            keywordsIds.add(newsKeyword.getKeywords());
        }
        List<String> result = this.newsOfKeywordIdsByPage(keywordsIds, pageSize);
        if(result.size() == 0){
            return new ArrayList<NewsTriple>();
        }
        boolean hasOriginalNews = false;
        for(int i = 0; i < result.size(); i++) {
            if(news.equals(result.get(i))) {
                result.remove(i);
                hasOriginalNews = true;
                break;
            }
        }
        if(result.size() > 0 && !hasOriginalNews){
            result.remove(result.size() - 1);
        }
        // 根据新闻id获取新闻标题和发布时间
        List<NewsTriple> resultPair = new ArrayList<NewsTriple>();
        if(result.size() > 0) {
            List<News> newsList = newsDao.findByIds(result);
            for (News oneNews : newsList) {
                resultPair.add(new NewsTriple(oneNews.getId(), oneNews.getTitle(), oneNews.getCreateTime()));
            }
        }
        return resultPair;
    }

    @Override
    public void deleteKeywordsOfNews(String news) {
        PageResults<NewsKeywords> newskeywords = this.keywordsOfNews(news);
        if (newskeywords.getTotalCount() == 0){
            return;
        }
        this.deleteEntries(this.keywordsOfNews(news).getResults());
    }

    @Override
    public void updateKeywordsOfNews(String news, List<String> keywords) {
        this.deleteKeywordsOfNews(news);
        // 按名获取keyword names
        if (keywords.size() == 0) return;
        List<Keywords> existed_keywords = this.keywordsDao.findByNames(keywords);
        List<String> nonexisted_keywords = new ArrayList<String>();
        if(keywords.size() > existed_keywords.size()) {
            int left = keywords.size() - existed_keywords.size();
            for(String keyword: keywords) {
                if (left <= 0) break;
                int count = 0;
                for(Keywords exsited_keyword: existed_keywords) {
                    if(keyword.equals(exsited_keyword.getName())) break;
                    count ++;
                }
                if(count == existed_keywords.size()){
                    nonexisted_keywords.add(keyword);
                    left --;
                }
            }
        }
        if(nonexisted_keywords.size() > 0) {
            // 将新的keywords插入到数据库中
            this.keywordsDao.addKeywords(nonexisted_keywords);
            // 获取keywords
            existed_keywords.addAll(this.keywordsDao.findByNames(nonexisted_keywords));
        }
        // 插入NewsKeywords中的数据
        this.newsKeywordsDao.insertEntriesOfOneNews(news, existed_keywords);
    }

    @Override
    public List<String> getNewsByKeywordsAndPage(List<Integer> keywords, int page, int pageSize) {
        return this.newsKeywordsDao.getNewsByKeywordsAndPage(keywords, (page - 1) * pageSize, pageSize);

    }

    @Override
    public List<String> getNewsByKeywordsAndPage(List<Integer> keywords, int page) {
        return this.getNewsByKeywordsAndPage(keywords, page, PAGE_SIZE_FOR_MORE);
    }

    @Override
    public List<News> getConcerningNewsByPage(String news, int page, int pageSize) {
        // 获取文章的关键词
        List<Integer> keywordsIds = this.keywordsIdsOfNews(news);
        List<String> newsIds = this.getNewsByKeywordsAndPage(keywordsIds, page);
        return newsDao.findByIds(newsIds);
    }

    @Override
    public List<News> getConcerningNewsByPage(String news, int page) {
        return this.getConcerningNewsByPage(news, page, PAGE_SIZE_FOR_MORE);
    }

    @Override
    public List<NewsTriple> getConcerningNewsForList(String news) {
        List<News> newsList = this.getConcerningNewsByPage(news, 1, PAGE_SIZE + 1);
        List<NewsTriple> newsTriples = new ArrayList<>();
        for(News news1 : newsList) {
            if(!news1.getId().equals(news)) {
                newsTriples.add(new NewsTriple(news1.getId(), news1.getTitle(), news1.getCreateTime()));
            }
        }
        if(newsTriples.size() > PAGE_SIZE){
            newsTriples.remove(newsTriples.size() - 1);
        }
        return newsTriples;
    }

    @Override
    public long numOfConcerningNews(String news) {
        List<Integer> keywordsIds = this.keywordsIdsOfNews(news);
        if(keywordsIds.size() == 0) return 0;
        return newsKeywordsDao.numOfConcerningNews(keywordsIds);
    }

    @Override
    public long pagesOfConcerningNews(String news) {
        return this.numOfConcerningNews(news) / PAGE_SIZE + 1;
    }
}
