package cn.com.dao;

import cn.com.dao.base.IBaseDao;
import cn.com.domain.Menu;

import java.util.List;

/**
 * Created by Ting on 2018/4/18
 */
public interface IUserMenuDao extends IBaseDao<Menu> {

    /**
     * 查找所有用户权限
     */
    List<Menu> findAllAuthority();

}
