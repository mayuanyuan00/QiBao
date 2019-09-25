package cn.com.dao;

import cn.com.dao.base.IBaseDao;
import cn.com.domain.BookContacts;

/**
 * @author Yao
 * @Description:
 * @Date: Created on 2018/1/16
 * @Modefied By
 */
public interface IBookContactsDao extends IBaseDao<BookContacts> {

        void deleteByBookId(int bookId);

}
