package cn.com.dao.impl;

import cn.com.dao.IUserMenuDao;
import cn.com.dao.base.impl.BaseDaoImpl;
import cn.com.domain.Menu;
import org.hibernate.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Ting on 2018/4/18
 */

@Repository("userMenuDao")
public class UserMenuDaoImpl extends BaseDaoImpl<Menu> implements IUserMenuDao {

    @Override
    @Transactional
    public List<Menu> findAllAuthority() {
        return ( List<Menu>)getAllEntry();
    }
}

