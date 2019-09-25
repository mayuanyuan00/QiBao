package cn.com.service.impl;

import cn.com.dao.IMenuDao;
import cn.com.dao.INewsDao;
import cn.com.domain.Columnlist;
import cn.com.domain.News;
import cn.com.service.INewsService;
import cn.com.vo.NewsTriple;
import cn.com.vo.PageResults;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

@Service("newsService")
public class NewsServiceImpl implements INewsService {

    private final String NEWS_COLUMN = "新闻公告";

    private final Integer PAGE_SIZE = 4;

    @Resource(name="menuDao")
    private IMenuDao menuDao;

    @Resource(name="newsDao")
    private INewsDao newsDao;

    @Override
    public Collection<News> getAllNews() {
        return newsDao.getAllEntry();
    }

    @Override
    public Collection<News> newsOfType(int type) {
       return newsDao.findObjectsByConditionWithNoPage(" and type = " + type);
    }

    @Override
    public List<NewsTriple> latestNews(int type) {
        PageResults<News> newsList = this.newsOfTypeByPage(type, 1);
        List<NewsTriple> newsTriples = new ArrayList<>();
        for(News news: newsList.getResults()){
            newsTriples.add(new NewsTriple(news.getId(), news.getTitle(), news.getCreateTime()));
        }
        return newsTriples;
    }

    @Override
    public List<String> newsIdList(int type) {
        return this.newsDao.newsListofType(type);
    }

    @Override
    public Collection<Columnlist> newsTypes() {
        List<Columnlist> columnlist = menuDao.findObjectsByConditionWithNoPage(" and name = '" + NEWS_COLUMN + "'");
        if (columnlist.size() == 0) return new ArrayList<>();
        return menuDao.findObjectsByConditionWithNoPage(" and parent = '" + columnlist.get(0).getParent() + "'");
    }

    @Override
    public News findById(String id) {
        return newsDao.getEntryById(id);
    }

    @Override
    @Transactional(readOnly=false)
    public void saveNews(News news) {
        newsDao.saveEntry(news);
    }

    @Override
    @Transactional(readOnly=false)
    public void updateNews(News news) {
        newsDao.updateEntry(news);
    }

    @Override
    @Transactional(readOnly=false)
    public void deleteById(String id) {
        newsDao.deleteByIds(id);
    }

    @Override
    public Collection<News> searchNews(String searchStr, Integer type) {
        return newsDao.findObjectsByConditionWithNoPage(" and type = " + type + " and title like '%" + searchStr +"%'");
    }

    @Override
    @Transactional(readOnly=false)
    public PageResults<News> searchNews(String searchStr, Integer type, Integer pageNo) {
        return newsDao.findPageByFetchedHql(" from News news where news.type = " + type + " and news.title like '%" + searchStr + "%'",
                "select count(*) from News news where news.type = " + type + " and news.title like '%" + searchStr + "%'",
                pageNo, 10, null);
    }

    @Override
    public PageResults<News> newsOfTypeByPage(int type, int page) {
        return this.newsOfTypeByPage(type, page, PAGE_SIZE);
    }

    @Override
    @Transactional
    public PageResults<News> newsOfTypeByPage(int type, int page, int pageSize) {
        //找到新闻公告栏目的id
        List<Columnlist> columnlist = this.menuDao.findByName(NEWS_COLUMN);
        if(columnlist.size() == 0) return null;
        Integer columnId = columnlist.get(0).getId();
        String hql = "from News news";
        String countHql = " select count(*) from News news";
        if (type != columnId) {
            //不是全部类型的新闻
            hql += " where news.type = " + type;
            countHql += " where news.type = " + type;
        } else {
            // 获取新闻公告下面的子栏目
            List<Columnlist> columnlists = this.menuDao.findObjectsByConditionWithNoPage(" and parent = ?", new Object[]{columnId});
            // 获取指定类型的文章
            hql += " where news.type in (";
            countHql +=" where news.type in (";
            for(Columnlist columnlist1: columnlists) {
                hql += columnlist1.getId() + ",";
                countHql += columnlist1.getId() + ",";
            }
            hql = hql.substring(0, hql.length() - 1);
            hql += ")";
            countHql = countHql.substring(0, countHql.length() - 1);
            countHql += ")";
        }
        hql += " order by news.createTime desc";
        //return null;
        return this.newsDao.newsOfTypeByPage(hql, countHql, page, pageSize);
    }


    @Override
    @Transactional(readOnly=false)
    public List<News> getNewsLimited(Integer type, Integer limit) {
        List<News> news=this.newsDao.findLimit(type,limit);
        if (news==null||news.size()==0) {
            return new ArrayList<>();
        }
        return news;
    }

    @Override
    @Transactional(readOnly=false)
    public List<News> getNewsLimited(List<Integer> types, Integer limit) {
        List<News> news=this.newsDao.findLimit(types,limit);
        if (news==null||news.size()==0) {
            return new ArrayList<>();
        }
        return news;
    }

    @Override
    public List<News> newsOfIds(List<String> ids) {
        return newsDao.findByIds(ids);
    }

    @Override
    public List<News> newsOfTypes(List<Integer> types) {
        return newsDao.findByTypes(types);
    }

    @Override
    public List<News> findWithPicOrVideosOrederByTime(Integer limit){
        return newsDao.findWithPicOrVideosOrederByTime(limit);
    }
}
