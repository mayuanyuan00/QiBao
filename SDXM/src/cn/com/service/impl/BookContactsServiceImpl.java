package cn.com.service.impl;


import cn.com.dao.IBookContactsDao;
import cn.com.domain.Book;
import cn.com.domain.BookContacts;
import cn.com.service.IBookContactsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @author Yao
 * @Description:
 * @Date: Created on 2018/1/16
 * @Modefied By
 */
@Service("bookContactsService")
public class BookContactsServiceImpl implements IBookContactsService {

    @Autowired
    IBookContactsDao bookContactsDao;
    @Override
    public void addContacts(Book book) {
        String[] types = book.getType().split(",");
        for(String type : types) {
            BookContacts bookContacts = new BookContacts();
            bookContacts.setBookid(book.getId());
            bookContacts.setBooktypeid(Integer.parseInt(type));
            bookContactsDao.saveEntry(bookContacts);
        }
    }

    @Override
    public void updateContacts(Book book) {
        this.deleteByBookId(book.getId());
        this.addContacts(book);
    }

    @Override
    public void deleteByBookId(int bookId) {
        bookContactsDao.deleteByBookId(bookId);
    }
}
