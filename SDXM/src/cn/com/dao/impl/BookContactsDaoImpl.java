package cn.com.dao.impl;

import cn.com.dao.IBookContactsDao;
import cn.com.dao.base.impl.BaseDaoImpl;
import cn.com.domain.BookContacts;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

/**
 * @author Yao
 * @Description:
 * @Date: Created on 2018/1/16
 * @Modefied By
 */
@Repository("bookContactsDao")
public class BookContactsDaoImpl extends BaseDaoImpl<BookContacts> implements IBookContactsDao {


    @Transactional
    @Override
    public void deleteByBookId(int bookId) {
        String sql = "delete from bookcontacts where bookid=?";
        Session session = this.getSession();
        SQLQuery sqlQuery = session.createSQLQuery(sql);
        sqlQuery.setParameter(0,bookId);
        sqlQuery.executeUpdate();
    }
}
