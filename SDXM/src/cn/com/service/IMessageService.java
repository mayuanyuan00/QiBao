package cn.com.service;

import cn.com.domain.Message;
import cn.com.domain.User;
import cn.com.vo.PageResults;

import java.util.List;


public interface IMessageService {
	
	public void saveMessage(Message message);
	
	public void updateMessage(Message message);
	
	/**
	 * 获取其他人的聊天信息
	 * @return
	 */
	public Message getMessageByUserId(Integer UserId);

	/**
	 * 获得其他人给你的私信
	 * @param username	用户名
	 * @return
	 */
	public Message getOtherToYouPrivilegeMessage(String username);

	/**
	 *
	 * @param id
	 * @return 若没有找到 返回null；
	 */
	Message getMessageById(Integer id);

	/**
	 * 修改delete 逻辑删除
	 * @param id
	 */
	void logicDelete(Integer id);

	/**
	 * 插入回复
	 */
	void insertReply(Message message);


	/**
	 * 获取某信息的回复
	 * @param id 信息id
	 * @return 回复信息 不返回null
	 */
	 List<Message> getMessageReplay(Integer id);

	/**
	 *获取所有message 不包括回复
	 * @return
	 */
	 PageResults<Message> getAdminMessageByPage(Integer page);

	/**
	 * 修改显示
	 */
	void changeShow(Integer id);

}

