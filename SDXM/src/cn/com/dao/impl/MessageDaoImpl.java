package cn.com.dao.impl;

import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.springframework.stereotype.Repository;

import cn.com.dao.IMessageDao;
import cn.com.dao.base.impl.BaseDaoImpl;
import cn.com.domain.Message;
import org.springframework.transaction.annotation.Transactional;

@Repository("messageDao")
public class MessageDaoImpl extends BaseDaoImpl<Message> implements IMessageDao {

    @Transactional
    public int logicDelete(Integer id) {
        String sql = "update  message set is_delete = '1'" +
                "where id= ?";
        Session session = this.getSession();
        SQLQuery sqlQuery = session.createSQLQuery(sql);
        Object[] items;
        items = new Object[]{id};
        if (items != null && items.length > 0) {
            for (int i = 0; i < items.length; i++) {
                sqlQuery.setParameter(i, items[i]);
            }
        }
        return sqlQuery.executeUpdate();
    }

    @Transactional
    public int changeShow(Integer id){
        String sql = "update  message set `show` = !`show` where id= ?";
        Session session = this.getSession();
        SQLQuery sqlQuery = session.createSQLQuery(sql);
        Object[] items;
        items = new Object[]{id};
        if (items != null && items.length > 0) {
            for (int i = 0; i < items.length; i++) {
                sqlQuery.setParameter(i, items[i]);
            }
        }
        return sqlQuery.executeUpdate();
    }

    @Override
    @Transactional
    public int insertReply(Message message) {
        String sql="insert into message (title, message, create_time, is_delete, reply_id,toPerson,user_id,user_name,tel) values (?, ?, ?,?, ?,?,?,?,?)";
        Session session = this.getSession();
        SQLQuery sqlQuery = session.createSQLQuery(sql);
        Object[] items;
        items = new Object[]{message.getTitle(),message.getMessage(),message.getCreateTime(),message.getIsDelete(),message.getReplyId(),
                                message.getToPerson(),message.getUserId(),message.getUserName(),message.getTel()};
        if (items != null && items.length > 0) {
            for (int i = 0; i < items.length; i++) {
                sqlQuery.setParameter(i, items[i]);
            }
        }
        return sqlQuery.executeUpdate();
    }
}
