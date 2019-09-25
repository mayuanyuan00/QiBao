package cn.com.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;

import javax.annotation.Resource;

import cn.com.vo.PageResults;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.com.dao.IMessageDao;
import cn.com.domain.Message;
import cn.com.service.IMessageService;

@Service("messageService")
public class MessageServiceImpl implements IMessageService{

	@Resource(name="messageDao")
	private IMessageDao messageDao;

	@Transactional(readOnly=false)
	public void saveMessage(Message message) {
		if (message.getIsDelete()==null) {
			message.setIsDelete("0");
		}
		message.setCreateTime(new Date(System.currentTimeMillis()));
		this.messageDao.saveEntry(message);
	}

	@Transactional(readOnly=false)
	public void updateMessage(Message message) {
		if (message.getIsDelete()==null) {
			message.setIsDelete("0");
		}
		this.messageDao.updateEntry(message);
	}
	/**
	 * 获取其他人的聊天信息
	 * @return
	 */
	@Transactional
	public Message getMessageByUserId(Integer UserId) {
		String whereHql="and o.userId !=? and o.type='群聊'";
		Object[] params={UserId};
		LinkedHashMap<String, String> orderBy=new LinkedHashMap<String, String>();
		orderBy.put("o.id", "desc");
		List<Message> list=this.messageDao.findObjectsByConditionWithNoPage(whereHql, params, orderBy);
		if(list!=null&&list.size()>0){
			return list.get(0);
		}
		return null;
	}
	/**
	 * 获得其他人给你的私信
	 * @param username	用户名
	 * @return
	 */
	public Message getOtherToYouPrivilegeMessage(String username) {
		String whereHql=" and o.toPerson like ? and o.type='私聊'";
		Object[] params={"%"+username+"%"};
		LinkedHashMap<String, String> orderBy=new LinkedHashMap<String, String>();
		orderBy.put("o.id", "desc");
		List<Message> list=this.messageDao.findObjectsByConditionWithNoPage(whereHql, params, orderBy);
		if(list!=null&&list.size()>0){
			return list.get(0);
		}
		return null;
	}
	/**
	 *
	 * @param id
	 * @return 若没有找到 返回null；
	 */
	@Override
	@Transactional
	public Message getMessageById(Integer id) {
		return messageDao.getEntryById(id);
	}
	/**
	 * 修改delete 逻辑删除
	 * @param id
	 */
	@Override
	@Transactional
	public void logicDelete(Integer id) {
		 messageDao.logicDelete(id);
	}
	/**
	 * 插入回复
	 */
	@Override
	@Transactional
	public void insertReply(Message message){
		if (message.getCreateTime()==null){
			message.setCreateTime(new Date(System.currentTimeMillis()));
		}
		if (message.getIsDelete()==null){
			message.setIsDelete("0");
		}
		messageDao.insertReply(message);
	}

	/**
	 * 获取某信息的回复
	 * @param id 信息id
	 * @return 回复信息 不返回null
	 */
	@Override
	@Transactional
	public List<Message> getMessageReplay(Integer id) {
		String wql="and replyId=? and isDelete !='1'";
		Integer[] params=new Integer[]{id};
		List<Message> replay=new ArrayList<>();
		replay=messageDao.findObjectsByConditionWithNoPage(wql,params);
		if (replay==null){
			return new ArrayList<>();
		}
		return replay;
	}

	/**
	 *获取所有message 不包括回复
	 * @return
	 */
	@Override
	@Transactional
	public PageResults<Message> getAdminMessageByPage(Integer page){
		return this.messageDao.findPageByFetchedHql(
				"from Message message where replyId=0  and isDelete != '1'  order by createTime desc", "select count(*) from Message  where replyId=0  and isDelete !='1'",
				page, 10, null);
	}

	/**
	 * 修改显示
	 */
	@Override
	public void changeShow(Integer id) {
		messageDao.changeShow(id);
	}
}
