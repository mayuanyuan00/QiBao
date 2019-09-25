package cn.com.dao.impl;

import cn.com.dao.IContactsDao;
import cn.com.dao.base.impl.BaseDaoImpl;
import cn.com.domain.Contacts;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository("contactsDao")
public class ContactsDaoImpl extends BaseDaoImpl<Contacts> implements IContactsDao {
    @Override
    @Transactional
    public int insertContacts(Contacts contacts) {
        String sql = "insert into contacts (linkman, phone, mail, message) values (?, ?, ?,?)";
        Session session = this.getSession();
        SQLQuery sqlQuery = session.createSQLQuery(sql);
        Object[] items;
        items = new Object[]{contacts.getLinkman(), contacts.getPhone(), contacts.getMail(), contacts.getMessage()};
        if (items != null && items.length > 0) {
            for (int i = 0; i < items.length; i++) {
                sqlQuery.setParameter(i, items[i]);
            }
        }
        return sqlQuery.executeUpdate();
    }

    @Override
    @Transactional
    public void deleteContacts(Integer id) {
        String sql = "delete from contacts where id= ?";
        Session session = this.getSession();
        SQLQuery sqlQuery = session.createSQLQuery(sql);
        Object[] items;
        items = new Object[]{id};
        if (items != null && items.length > 0) {
            for (int i = 0; i < items.length; i++) {
                sqlQuery.setParameter(i, items[i]);
            }
        }
        sqlQuery.executeUpdate();
    }
}
