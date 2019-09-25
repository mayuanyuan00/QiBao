package cn.com.dao;

import cn.com.dao.base.IBaseDao;
import cn.com.domain.Book;

import java.util.List;

public interface IBookDao extends IBaseDao<Book> {
    List<Book> getHotBook();
}
