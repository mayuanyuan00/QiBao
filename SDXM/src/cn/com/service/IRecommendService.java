package cn.com.service;

import cn.com.domain.Book;
import cn.com.domain.Recommend;

import java.util.List;

public interface IRecommendService {
    /**
     * 获取全部
     * @return
     */
    List<Recommend> getAllRecommend();

    /**
     * 插入 若主键id已经存在则执行更新操作
     * @param recommend
     * @return
     */
    int insert(Recommend recommend);

    /**
     * 批量执行上述insert操作
     */
    int insertAll(List<Recommend> recommends);


    /**
     * 获取首页热门图书参数
     */
    List<Book> getHomeHotBook();
}
