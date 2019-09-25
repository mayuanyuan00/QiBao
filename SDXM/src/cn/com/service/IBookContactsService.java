package cn.com.service;

import cn.com.domain.Book;

/**
 * @author Yao
 * @Description:
 * @Date: Created on 2018/1/16
 * @Modefied By
 */
public interface IBookContactsService {

    void addContacts(Book book);

    void updateContacts(Book book);

    void deleteByBookId(int bookId);

}
