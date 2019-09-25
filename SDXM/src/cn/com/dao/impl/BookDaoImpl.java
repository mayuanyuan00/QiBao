package cn.com.dao.impl;

import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.springframework.stereotype.Repository;

import cn.com.dao.IBookDao;
import cn.com.dao.base.impl.BaseDaoImpl;
import cn.com.domain.Book;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Repository("bookDao")
public class BookDaoImpl extends BaseDaoImpl<Book> implements IBookDao {
    @Override
    @Transactional
    public List<Book> getHotBook() {
        String sql = "SELECT a.id,a.book_name,a.publication_date from book a join  (SELECT itemid,count(itemid) as sum from order_detail GROUP BY itemid ) b on a.id=b.itemid" +
                " ORDER BY b.sum desc LIMIT 8;";
        Session session = this.getSession();
        Query sqlQuery = session.createSQLQuery(sql);
        List<Object[]> objects=sqlQuery.list();
        List<Book> books=new ArrayList<>();
        for (Object[] o :objects){
            Book book=new Book();
            book.setId((Integer)o[0]);
            book.setBookName((String) o[1]);
            book.setPublicationDate((String) o[2]);
            books.add(book);
        }
        return  books;
    }
}
