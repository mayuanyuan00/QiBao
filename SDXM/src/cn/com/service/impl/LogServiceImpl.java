package cn.com.service.impl;


import cn.com.common.Constants;
import cn.com.dao.ILogDao;
import cn.com.dao.IResourcesDao;
import cn.com.domain.Log;
import cn.com.domain.Resource;
import cn.com.service.ILogService;
import cn.com.service.IResourceService;
import cn.com.vo.PageResults;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.Serializable;

@Service("logService")
public class LogServiceImpl implements ILogService{
    @javax.annotation.Resource(name="logDao")
    private ILogDao logDao;

    @Override
    @Transactional
    public PageResults<Log> getLogsByPage(Integer page) {
        return this.logDao.findPageByFetchedSql(
                "SELECT * FROM log order by operation_date desc",
                "select count(*) from log",Log.class,
                page, 20, null);
    }

    @Override
    @Transactional
    public Log selectLog(Serializable id) {
       return logDao.getEntryById(id);
    }

    @Override
    @Transactional
    public void deleteLog(Serializable id) {
      logDao.deleteByIds(id);
    }



    @Override
    @Transactional
    public void updateLog(Log log) {
        logDao.updateEntry(log);
    }

    @Override
    @Transactional(readOnly = false)
    public void saveLog(Log log) {
         logDao.saveEntry(log);
    }

    @Override
    @Transactional
    public PageResults<Log> searchLogDetail(String key, int page) {
        return this.logDao.findPageByFetchedSql(
                "select * from log WHERE operation_content like ?",
                "select count(*) from log  WHERE operation_content like ?",Log.class,
                page, Constants.PAGE_SIZE, new Object[]{"%" + key + "%"}
        );
    }
}
