package cn.com.dao;

import cn.com.dao.base.IBaseDao;
import cn.com.domain.Message;

import java.util.List;

public interface IMessageDao extends IBaseDao<Message> {

    int logicDelete(Integer id);
    int changeShow(Integer id);
    int insertReply(Message message);
}
