package cn.com.service;


import cn.com.domain.Log;
import cn.com.domain.Resource;
import cn.com.vo.PageResults;

import java.io.Serializable;

/**
 * 资源管理
 */
public interface ILogService {
    /**
     * 按页获取日志
     * @param page 页码 不允许为null
     * @return 返回资源
     */
    PageResults<Log> getLogsByPage(Integer page);

    /**
     * 根据id获取日志
     * @param id 资源id
     * @return 资源 未查询到返回 null
     */
    Log selectLog(Serializable id);

    /**
     * 删除日志
     * @param id 需要删除的日志id
     */
    void deleteLog(Serializable id);

    /**
     * 更新日志
     * @param log 需要更新的 log id不允许为null
     */
    void updateLog(Log log);

    /**
     * 插入日志
     * @param log 需要插入的日志
     */
    void saveLog(Log log);


    /**
     *
     * 搜索 分页
     * @param key 搜索关键字
     * @param page 页数
     * @return 分页
     */
    PageResults<Log> searchLogDetail(String key, int page);
}
