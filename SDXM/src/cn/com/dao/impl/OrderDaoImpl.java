package cn.com.dao.impl;

import cn.com.common.Constants;
import cn.com.vo.PageResults;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.springframework.stereotype.Repository;

import cn.com.dao.IOrderDao;
import cn.com.dao.base.impl.BaseDaoImpl;
import cn.com.domain.Order;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository("orderDao")
public class OrderDaoImpl extends BaseDaoImpl<Order>implements IOrderDao {

    @Override
	@Transactional
    public Long getOrderCount(int status, int userid) {
        String hql="select count(*) from Order order where order.status = "+status+" and order.userid = "+userid;
        Query query = this.getSession().createQuery(hql);
        return (Long)query.uniqueResult();
    }
	@Override
	public Order getByOrderNo(String orderno) {
		String query = "from Order where orderno = ?";
		List<Order> orders = this.hibernateTemplate.find(query, orderno);
		if (orders == null || orders.size() < 1) {
			return null;
		}
		return orders.get(0);
	}

	@Override
	@Transactional
	public void deleteOrder(int id, String status) {
		String sql="update torder set status=? where id=?";
		SQLQuery query=this.getSession().createSQLQuery(sql);
		query.setParameter(0,status);
		query.setParameter(1,id);
		query.executeUpdate();
	}

	@Override
	@Transactional
	public PageResults<Order> getOrderList(int status, int userid, int page) {
		String sql = "select * from torder o where o.status = "+status+" and o.userid = "+userid+" order by o.create_date desc";
		String countSql = "select count(*) from torder o where o.status = "+status+" and o.userid = "+userid;
		if (status == -1) {
			sql = "select * from torder o where o.userid = "+userid+" and o.status != '9' order by o.create_date desc";
			countSql = "select count(*) from torder o where o.userid = "+userid+" and o.status != '9'";
		}
		PageResults<Order> list = findPageByFetchedSql(sql,countSql,Order.class,page, Constants.PAGE_SHORET_SIZE, null);
		return list;
	}

}
