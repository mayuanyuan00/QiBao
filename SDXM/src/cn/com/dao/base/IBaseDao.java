package cn.com.dao.base;

import java.io.Serializable;
import java.util.Collection;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import cn.com.vo.PageResults;
import org.hibernate.Session;

/**
 * 这里面发的都是一些共有方法类
 *
 * @param <T>
 * @author Administrator
 */
public interface IBaseDao<T> {
    Session getSession();

    /**
     * 获得所有实体
     *
     * @return 返回所有的实体对象
     */
    Collection<T> getAllEntry();

    /**
     * 通过id来获取实体对象
     *
     * @param id 实体id
     * @return 返回实体
     */
    T getEntryById(Serializable id);

    /**
     * 保存实体
     *
     * @param t 先添加的实体
     */
    void saveEntry(T t);

    /**
     * 保存实体并返回Id
     */
    public Integer saveReturnId(T t);
    /**
     * 更新实体对象
     *
     * @param t 需要更新的实体
     */
    void updateEntry(T t);

    /**
     * 删除实体对象
     *
     * @param ids 实体对象id
     */
    void deleteByIds(Serializable... ids);

    /**
     * 根据条件返回实体集合
     *
     * @param whereHql hql语句
     * @param params   参数
     * @param orderBy  对应排序方式
     * @return 实体集合
     */
    List<T> findObjectsByConditionWithNoPage(String whereHql,
                                             Object[] params, LinkedHashMap<String, String> orderBy);

    List<T> findObjectsByConditionWithNoPage(String whereHql, final Object[] params);

    List<T> findObjectsByConditionWithNoPage(String whereHql);

    List<T> findObjectsWithPage(String hql, int start, int count);

    List<T> findObjectsWithPage(String hql, final Object[] params, int start, int count);

    PageResults<T> findPageByFetchedHql(String hql, String countHql,
                                        int pageNo, int pageSize, Object[] values);

    PageResults<T> findPageByFetchedSql(String sql, String countSql, Class<T> entity,
                                        int pageNo, int pageSize, Object[] values);

    PageResults<Map> findMapByFetchSql(String sql, String countSql,
                                       int pageNo, int pageSize, Object[] values);
}
