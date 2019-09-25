package cn.com.common;

import java.util.Date;

import cn.com.utils.DateUtils;
import cn.com.utils.RandomStringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.com.dao.IBehaviourDao;
import cn.com.domain.Log;
import org.joda.time.DateTime;

/**
 * 行为日志记录service
 * @author 常东旭
 *
 */
@Service
@Transactional
public class BehaviourLogService {
	
	@Autowired
	private IBehaviourDao behaviourDao; 
	
	/**
	 * 异步记录日志
	 * @param who 当前系统操作人
	 * @param what 操作名（参考文档--编码表.xls）	
	 */
	@Async
	@Transactional(readOnly=false)
	public void log(String who,String what){
		RandomStringUtil randomStringUtil = new RandomStringUtil();
		Log log = new Log();
		log.setId(randomStringUtil.getRandomCode(20,6));
		log.setOperationContent(what);
		log.setOperator(who);
		//log.setOperationDate(new Date());
		log.setOperationDate(DateTime.now().toDate());
		this.behaviourDao.saveEntry(log);
	}
	
}
