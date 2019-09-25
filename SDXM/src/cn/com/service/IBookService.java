package cn.com.service;


import cn.com.domain.Book;
import cn.com.vo.PageResults;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

public interface IBookService {

    void saveBook(Book book);

    int saveReturnId(Book book);

    void updateBook(Book book);

    void auditingBook(Serializable id, String state);

    void deleteBook(Serializable id);

    Book findBookById(Serializable id);

    List<Book> getAllBooks();

    List<Book> getNewBook();

    List<Book> getHotBook();

    /**
     * 获取某一父分类下指定位置的几本书
     * 根据ID排序
     *
     * @return
     */
    PageResults<Book> getResultOfParentType(String topType, int page);

    PageResults<Book> getResultOfParentType(String topType, int page, int size);

    /**
     * 获取某一指定分类下指定位置的几本书
     *
     * @param type
     * @param page
     * @return
     */
    PageResults<Book> getResultOfType(String type, int page);

    PageResults<Book> getResultByType(int type, int page, int size);

    PageResults<Book> getBookOfPage(int page);

    PageResults<Book> searchBook(String key, int page);

    PageResults<Map> getBooksDetail(int page);

    PageResults<Map> searchBooksDetail(String key, int page);

}
