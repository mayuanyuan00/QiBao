package cn.com.service;


import cn.com.domain.Links;
import cn.com.vo.PageResults;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

/**
 * 友情链接
 */
public interface ILinksService {
    /**
     * 按页获取友情链接
     * @param page 页码 不允许为null
     * @return 返回连接
     */
    PageResults<Links> getLinksByPage(Integer page);

    /**
     * 根据id获取链接
     * @param id 友情链接id
     * @return 友情链接 未查询到返回 null
     */
    Links selectLinks(Serializable id);

    /**
     * 获取前几条未删除的连接
     * @param limited 获取的连接条数
     * @return 返回的连接
     */
    List<Links> getLinksByLimited(Integer limited);

    /**
     * 删除友情链接
     * @param id 需要删除的友情链接id
     */
    void deleteLinks(Serializable id);

    /**
     * 逻辑删除（is_delete字段变为“1”）
     * @param id 需要删除的id
     */
    void logicDeleteLinks(Serializable id);

    /**
     * 更新Links
     * @param links 需要更新的links id不允许为null
     */
    void updateLinks(Links links);

    /**
     * 插入链接
     * @param links 需要插入的连接
     */
    void saveLinks(Links links);


    /**
     *
     * 搜索 分页
     * @param key 搜索关键字
     * @param page 页数
     * @return 分页
     */
    PageResults<Map> searchLinksDetail(String key, int page);
}
