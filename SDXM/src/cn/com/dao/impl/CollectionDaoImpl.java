package cn.com.dao.impl;

import java.sql.SQLException;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.stereotype.Repository;

import cn.com.dao.ICollectionDao;
import cn.com.dao.base.impl.BaseDaoImpl;
import cn.com.domain.Collection;

@Repository("collectionDao")
public class CollectionDaoImpl extends BaseDaoImpl<Collection> implements ICollectionDao{

	@Override
	public void deleteAllByUserid(final Integer userid) {
		this.hibernateTemplate.execute(new HibernateCallback<Collection>() {

			@Override
			public Collection doInHibernate(Session session) throws HibernateException, SQLException {
				Query query = session.createQuery(
			            "delete Collection where userid = ? ");
			        query.setLong(0, userid);
			        query.executeUpdate();
				return null;
			}
			
		});
		
	}

	@Override
	public List<Collection> getAllByUserid(Integer userid) {
		List<Collection> collection = this.hibernateTemplate.find("from Collection where userid = " + userid);
		return collection;
	}

}
