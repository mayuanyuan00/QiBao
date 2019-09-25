package cn.com.dao.impl;


import cn.com.dao.ILogDao;
import cn.com.dao.base.impl.BaseDaoImpl;
import cn.com.domain.Log;
import org.springframework.stereotype.Repository;

@Repository("logDao")
public class LogDaoImpl extends BaseDaoImpl<Log> implements ILogDao {
}
