package cn.com.service;


import cn.com.domain.Resource;
import cn.com.vo.PageResults;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

/**
 * 资源管理
 */
public interface IResourceService {


    PageResults<Resource> getResourcesReleasedByPage(Integer page);
    /**
     * 按页获取友资源
     * @param page 页码 不允许为null
     * @return 返回资源
     */
    PageResults<Resource> getResourcesByPage(Integer page);

    /**
     * 根据id获取资源
     * @param id 资源id
     * @return 资源 未查询到返回 null
     */
    Resource selectResources(Serializable id);

//    /**
//     * 获取前几条未删除的资源
//     * @param limited 获取的资源条数
//     * @return 返回的资源
//     */
//    List<Resource> getResouecesByLimited(Integer limited);

    /**
     * 删除资源
     * @param id 需要删除的资源id
     */
    void deleteResource(Serializable id);


//    /**
//     * 逻辑删除（is_delete字段变为“1”）
//     * @param id 需要删除的id
//     */
//    void logicDeleteResource(Serializable id);

    /**
     * 更新Resource
     * @param resource 需要更新的 resource id不允许为null
     */
    void updateResource(Resource resource);

    /**
     * 修改发布状态
     */
    void updateRel(Integer id,String rel);

    /**
     * 插入资源
     * @param resource 需要插入的资源
     */
    void saveResource(Resource resource);


    /**
     *
     * 搜索 分页
     * @param key 搜索关键字
     * @param page 页数
     * @return 分页
     */
    PageResults<Resource> searchResourceDetail(String key, int page);
}
