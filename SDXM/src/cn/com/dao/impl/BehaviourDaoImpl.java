package cn.com.dao.impl;

import org.springframework.stereotype.Repository;

import cn.com.dao.IBehaviourDao;
import cn.com.dao.base.impl.BaseDaoImpl;
import cn.com.domain.Log;


@Repository("behaviourDao")
public class BehaviourDaoImpl extends BaseDaoImpl<Log> implements IBehaviourDao{

}
