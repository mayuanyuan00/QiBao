package cn.com.dao.impl;

import cn.com.dao.IBooktypeDao;
import cn.com.dao.base.impl.BaseDaoImpl;
import cn.com.domain.Booktype;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository("booktypeDao")
public class BookTypeDaoImpl extends BaseDaoImpl<Booktype> implements IBooktypeDao {

    @Transactional
    public int logicDelete(Integer id) {
        String sql = "update  booktype as a set a.is_delete = '1'" +
                "where a.id= ? AND not EXISTS " +
                "(SELECT * from (select parentid ,is_delete from booktype) as b where b.parentid= ? and b.is_delete!='1')" +
                "and not EXISTS (select * from book as c where FIND_IN_SET(?,c.type) )";
        Session session = this.getSession();
        SQLQuery sqlQuery = session.createSQLQuery(sql);
        Object[] items;
        items = new Object[]{id, id, id+""};
        if (items != null && items.length > 0) {
            for (int i = 0; i < items.length; i++) {
                sqlQuery.setParameter(i, items[i]);
            }
        }
        return sqlQuery.executeUpdate();
    }
}
