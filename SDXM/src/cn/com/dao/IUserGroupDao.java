package cn.com.dao;

import cn.com.dao.base.IBaseDao;
import cn.com.domain.Usergroup;
import cn.com.vo.AuthorityVO;

import java.util.List;

/**
 * Created by Ting on 2018/4/18
 */
public interface IUserGroupDao extends IBaseDao<Usergroup> {

    /**
     * 添加权限
     */

    void addAuthority(Usergroup usergroup);

    /**
     * 更新权限
     */

    void updateAuthority(Usergroup usergroup);

    /**
     * 查找权限
     */
    List<AuthorityVO> selectByid(int id);

    /**
     * 删除权限
     */
    void deleteByUser(int authority);
}
