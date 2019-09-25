package cn.com.service.impl;

import cn.com.common.Constants;
import cn.com.dao.IBookDao;
import cn.com.domain.Book;
import cn.com.service.IBookService;
import cn.com.vo.PageResults;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.io.Serializable;
import java.util.List;
import java.util.Map;

@Service("bookService")
public class BookServiceImpl implements IBookService {

    @Resource(name = "bookDao")
    private IBookDao bookDao;

    @Transactional(readOnly = false)
    public void saveBook(Book book) {
        if (book.getIsDelete() == null || book.getIsDelete().length() > 1) book.setIsDelete("0");
        this.bookDao.saveEntry(book);
    }

    @Override
    @Transactional
    public int saveReturnId(Book book) {
        if (book.getIsDelete() == null || book.getIsDelete().length() > 1) book.setIsDelete("0");
        return this.bookDao.saveReturnId(book);
    }

    @Override
    @Transactional
    public void updateBook(Book book) {
        if (book.getIsDelete() == null) book.setIsDelete("0");
        this.bookDao.updateEntry(book);
    }

    @Override
    @Transactional
    public void auditingBook(Serializable id,String state) {
        Book book = this.bookDao.getEntryById(id);
        if (book != null) {
            book.setAuditing(state);
            this.bookDao.saveEntry(book);
        }
    }

    @Override
    @Transactional
    public void deleteBook(Serializable id) {
//        this.bookDao.deleteByIds(id);
        Book book = this.bookDao.getEntryById(id);
        if (book != null) {
            book.setIsDelete("1");
            this.bookDao.saveEntry(book);
        }
    }

    @Override
    @Transactional
    public Book findBookById(Serializable id) {
        return this.bookDao.getEntryById(id);
    }

    @Override
    @Transactional
    public List<Book> getAllBooks() {
        return this.bookDao.findObjectsByConditionWithNoPage("and isDelete = '0' and auditing = '3'");
    }

    @Override
    @Transactional
    public List<Book> getNewBook() {
        return this.bookDao.findObjectsByConditionWithNoPage("and isNew = '1' and isDelete = '0' and auditing = '3'");
    }

    @Override
    @Transactional
    public List<Book> getHotBook() {
        return bookDao.getHotBook();
    }

    @Override
    @Transactional
    public PageResults<Book> getResultOfParentType(String topType, int page) {
        return this.getResultOfParentType(topType, page, Constants.PAGE_SIZE);
    }


    @Override
    @Transactional
    public PageResults<Book> getResultOfParentType(String topType, int page, int size) {
        return this.bookDao.findPageByFetchedSql(
                "SELECT b.* FROM book b,view_booktypemap btm WHERE b.is_delete = 0 AND b.auditing = '3' AND b.type = btm.childid AND btm.parentid in(" + topType +") order by b.id desc",
                "SELECT count(*) FROM book b,view_booktypemap btm WHERE b.is_delete = 0 AND b.auditing = '3' AND b.type = btm.childid AND btm.parentid in(" + topType +")",
                Book.class, page, size, null
        );
    }

    @Override
    @Transactional
    public PageResults<Book> getResultOfType(String type, int page) {
        return this.bookDao.findPageByFetchedHql(
                "from Book b where b.isDelete = 0 and b.auditing = '3' and find_in_set("+type+", b.type)>0 order by b.id desc",
                "select count(*) from Book b where b.isDelete = 0 and b.auditing = '3' and find_in_set("+type+", b.type)>0",
                page, Constants.PAGE_SIZE, null);
    }

    @Override
    @Transactional
    public PageResults<Book> getResultByType(int type, int page,int size) {
        return this.bookDao.findPageByFetchedHql(
                "from Book b where b.isDelete = 0 and b.auditing = '3' and b.type ="+type,
                "select count(*) from Book b where b.isDelete = 0 and b.auditing = '3' and b.type =" + type ,
                page, size,null);
    }


    @Override
    @Transactional
    public PageResults<Book> getBookOfPage(int page) {
        return this.bookDao.findPageByFetchedHql(
                "from Book book where book.isDelete = '0' order by book.id desc",
                "select count(*) from Book book where book.isDelete = '0'",
                page, 10, null);
    }

    @Override
    @Transactional
    public PageResults<Book> searchBook(String key, int page) {
        return this.bookDao.findPageByFetchedHql(
                "from Book book where book.isDelete = '0' and book.bookName like ? ",
                "select count(*) from Book book where book.isDelete = '0' and book.bookName like ?",
                page, Constants.PAGE_SIZE,
                new Object[]{"%" + key + "%"}
        );
    }

    @Override
    @Transactional
    public PageResults<Map> getBooksDetail(int page) {
        return this.bookDao.findMapByFetchSql(
                "select b.*,bt.type_name from book b left join booktype bt on b.type = bt.id where b.is_delete = '0'",
                "SELECT count(*) c FROM book where is_delete = '0'",
                page, Constants.PAGE_SIZE, null);
    }

    @Override
    @Transactional
    public PageResults<Map> searchBooksDetail(String key, int page) {
        return this.bookDao.findMapByFetchSql(
                "select b.*,bt.type_name from book b left join booktype bt on b.type = bt.id WHERE b.is_delete = '0' and b.book_name like ?",
                "select count(*) from book b WHERE b.is_delete = '0' and b.book_name like ?",
                page, Constants.PAGE_SIZE, new Object[]{"%" + key + "%"}
        );
    }
}
