package cn.com.dao.impl;

import cn.com.dao.IUserGroupDao;
import cn.com.dao.base.impl.BaseDaoImpl;
import cn.com.domain.Usergroup;
import cn.com.vo.AuthorityVO;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.transform.Transformers;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;


/**
 * Created by Ting on 2018/4/18
 */
@Repository("userGroupDao")
public class UserGroupDaoImpl extends BaseDaoImpl<Usergroup> implements IUserGroupDao {
    @Override
    @Transactional
    public void addAuthority(Usergroup usergroup) {
        saveEntry(usergroup);
    }

    @Override
    @Transactional
    public void updateAuthority(Usergroup usergroup) {
        updateEntry(usergroup);
    }

    @Override
    @Transactional
    public List<AuthorityVO> selectByid(int id) {
        String sql = "select m.groupname,n.groupcode,n.menuid,m.url from usergroup as n join " +
                "menu as m on m.id = n.menuid where m.is_delete = '0' and n.is_delete = '0'and authority = ?";
        Query query = this.getSession().createSQLQuery(sql);
        query.setParameter(0,id);
        List<Object[]> objects = query.list();
        List<AuthorityVO> list = new ArrayList<>();
        for (Object[] o :objects){
            list.add(new AuthorityVO((Integer)o[2],(String)o[1],(String)o[0],(String)o[3]));
        }
        return list;
    }

    @Override
    @Transactional
    public void deleteByUser(int authority) {
        String sql = "update usergroup set is_delete = '1' where authority = ?";
        Query query = this.getSession().createSQLQuery(sql);
        query.setParameter(0,authority);
        query.executeUpdate();
    }


}
