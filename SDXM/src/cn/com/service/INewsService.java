package cn.com.service;

import cn.com.domain.Columnlist;
import cn.com.domain.News;
import cn.com.vo.NewsTriple;
import cn.com.vo.PageResults;

import java.util.Collection;
import java.util.List;

/**
 * Created by ironman on 2017/9/29.
 */
public interface INewsService {

    //获取所有新闻
    public Collection<News> getAllNews();

    /**
     * 返回类别type的新闻的第page页
     * @param type 新闻类别
     * @param page 页码
     * @return
     */
    public PageResults<News> newsOfTypeByPage(int type, int page);

    /**
     * 返回类别type的新闻的第page页,每页数量为pageSize
     * @param type
     * @param page
     * @param pageSize
     * @return
     */
    public PageResults<News> newsOfTypeByPage(int type, int page, int pageSize);

    // 返回某一类型的文章的id列表，最新的文章放在最前面
    public List<String> newsIdList(int type);

    // 获取最新的新闻
    public List<NewsTriple> latestNews(int type);

    //获取某个类别的新闻
    public Collection<News> newsOfType(int type);

    //获取所有的新闻类别
    public Collection<Columnlist> newsTypes();

    //获取某一条新闻
    public News findById(String id);

    //保存一条新闻
    public void saveNews(News news);

    //更新一条新闻
    public void updateNews(News news);

    //删除一条新闻
    public void deleteById(String id);

    //搜索新闻
    public Collection<News> searchNews(String searchStr, Integer type);

    //搜索新闻
    public PageResults<News> searchNews(String searchStr, Integer type, Integer pageNo);

    //获取指定type的news type=-10时获取最新
    public List<News> getNewsLimited(Integer type, Integer limit);

    public List<News> getNewsLimited(List<Integer> types, Integer limit);

    List<News> newsOfIds(List<String> ids);

    // 获取一组类型的文章
    List<News> newsOfTypes(List<Integer> types);



    List<News> findWithPicOrVideosOrederByTime(Integer limit);

}
