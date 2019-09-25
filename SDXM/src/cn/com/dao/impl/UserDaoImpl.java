package cn.com.dao.impl;

import java.sql.SQLException;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.stereotype.Repository;

import cn.com.dao.IUserDao;
import cn.com.dao.base.impl.BaseDaoImpl;
import cn.com.domain.User;

@Repository("userDao")
public class UserDaoImpl extends BaseDaoImpl<User>implements IUserDao {

	/**
	 * 按照电话查找User
	 * @author 张炜婕
	 */
	@Override
	public User findByPhone(final String phone) {
		// 组织hql语句
		String hql = "from User where phone = ?";
		final String fhql = hql;
		User user = (User) this.hibernateTemplate.execute(new HibernateCallback<User>() {
			public User doInHibernate(Session session) throws HibernateException, SQLException {
				Query query = session.createQuery(fhql);
				query.setString(0, phone);
				List<User> list = query.list();
				if (list==null || list.isEmpty()) {
					return null;
				}
				return list.get(0);
			}
		});
		return user;
	}
	/**
	 * 按照邮箱查找User
	 * @author 张炜婕
	 */
	@Override
	public User findByEmail(final String email) {
		// 组织hql语句
		String hql = "from User where phone = ?";
		final String fhql = hql;
		User user = (User) this.hibernateTemplate.execute(new HibernateCallback<User>() {
			public User doInHibernate(Session session) throws HibernateException, SQLException {
				Query query = session.createQuery(fhql);
				query.setString(0, email);
				List<User> list = query.list();
				if (list==null || list.isEmpty()) {
					return null;
				}
				return list.get(0);
			}
		});
		return user;
	}




}

