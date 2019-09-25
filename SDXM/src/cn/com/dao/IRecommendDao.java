package cn.com.dao;

import cn.com.dao.base.IBaseDao;
import cn.com.domain.Book;
import cn.com.domain.Recommend;

import java.util.List;

public interface IRecommendDao extends IBaseDao<Recommend>{

    /**
     * 插入或者更新
     */
    public int insertOrUpdate(Recommend recommend);

    /**
     * 获取首页热门图书参数 isbn 存评论
     */
    public List<Book> getHomeHotBook();

}
