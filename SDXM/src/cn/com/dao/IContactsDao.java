package cn.com.dao;

import cn.com.dao.base.IBaseDao;
import cn.com.domain.Contacts;

public interface IContactsDao extends IBaseDao<Contacts> {
    int insertContacts(Contacts contacts);
    void deleteContacts(Integer id);
}
