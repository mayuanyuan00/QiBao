package cn.com.dao;

import cn.com.dao.base.IBaseDao;
import cn.com.domain.News;
import cn.com.vo.PageResults;

import java.util.List;

/**
 * Created by ironman on 2017/9/29.
 */
public interface INewsDao extends IBaseDao<News> {
    PageResults<News> newsOfTypeByPage(String hql, String countHql, int page, int pageSize);

    List<News> findByIds(List<String> ids);

    List<News> findByTypes(List<Integer> types);

    List<News> findLimit(Integer type, Integer limit);

    List<News> findLimit(List<Integer> type, Integer limit);

    // 得到某个类型的文章的id列表
    List<String> newsListofType(Integer type);


    List<News> findWithPicOrVideosOrederByTime(Integer limit);
}
