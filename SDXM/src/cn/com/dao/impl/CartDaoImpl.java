package cn.com.dao.impl;

import java.sql.SQLException;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.stereotype.Repository;

import cn.com.dao.ICartDao;
import cn.com.dao.base.impl.BaseDaoImpl;
import cn.com.domain.Cart;
/**
 * 购物车DAO实现类
 * @author 常东旭/张炜婕
 *
 */
@Repository("cartDao")
public class CartDaoImpl extends BaseDaoImpl<Cart> implements ICartDao{

	@Override
	public void deleteAllByUserid(final Integer userid) {
		this.hibernateTemplate.execute(new HibernateCallback<Cart>() {

			@Override
			public Cart doInHibernate(Session session) throws HibernateException, SQLException {
				Query query = session.createQuery(
			            "delete Cart where userid = ? ");
			        query.setLong(0, userid);
			        query.executeUpdate();
				return null;
			}
			
		});
		
	}

	@Override
	public List<Cart> getAllByUserid(Integer userid) {
		List<Cart> cart = this.hibernateTemplate.find("from Cart where userid = " + userid);
		return cart;
	}

}
