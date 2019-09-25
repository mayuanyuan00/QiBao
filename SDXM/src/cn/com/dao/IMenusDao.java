package cn.com.dao;

import cn.com.dao.base.IBaseDao;
import cn.com.domain.Menu;

import java.util.List;

/**
 * Created by Ting on 2018/4/20
 */
public interface IMenusDao extends IBaseDao<Menu> {

    /**
     * 查询栏目by name
     */
    List<Menu> selectByName(String name);

    /**
     * 查询栏目by url
     */
    List<Menu> selectByUrl(String url);

    /**
     * 增加栏目
     */
    void addColumn(Menu menu);

    /**
     * 删除栏目
     */

    void deleteColumn(int id);
}
