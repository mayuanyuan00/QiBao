package cn.com.service.impl;

import java.util.List;

import cn.com.common.Constants;
import cn.com.vo.PageResults;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.com.dao.IOderDetailDao;
import cn.com.dao.IOrderDao;
import cn.com.domain.Order;
import cn.com.domain.OrderDetail;
import cn.com.service.IOrderService;
import cn.com.vo.OderInfo;
import org.springframework.transaction.annotation.Transactional;

@Service("orderService")
public class OrderServiceImpl implements IOrderService{

	@Autowired
	private IOrderDao orderDao;
	@Autowired
	private IOderDetailDao orderDetailDao;
	
	@Override
	public int orderCreate(List<OderInfo> list, int userid ,String orderno) {
		//计算价格
		double sum = 0;
		for (int i = 0; i < list.size(); i++) {
			OderInfo _o = list.get(i);
			sum = sum + _o.getCount() * _o.getBook().getPrice().doubleValue();
		}
		Order order = new Order(userid, sum, "1", 0, "");
		order.setOrderno(orderno);
		orderDao.saveEntry(order);
		//存储订单详情
		for (int i = 0; i < list.size(); i++) {
			OderInfo _o = list.get(i);
			OrderDetail _od = new OrderDetail(order.getId(), _o.getBook().getId(), _o.getCount(), _o.getBook().getPrice().doubleValue(), _o.getCount() * _o.getBook().getPrice().doubleValue());
			orderDetailDao.saveEntry(_od);
		}
		return order.getId();
	}

	@Override
	public List<OrderDetail> getOrderDetail(int orderid) {
		String hql = "and orderid = ?";
		List<OrderDetail> list = orderDetailDao.findObjectsByConditionWithNoPage(hql, new Object[]{orderid});
		return list;
	}

	@Override
	public PageResults<Order> getOrderList(int status, int userid,int page) {
		return orderDao.getOrderList(status,userid,page);
	}

	@Override
	public Long getOrderCount(int status, int userId) {
		return orderDao.getOrderCount(status, userId);
	}

	@Override
	public Order getOrder(int orderid){
		return orderDao.getEntryById(orderid);
	}
	
	@Override
	public Order getOrder(String orderno){
		return orderDao.getByOrderNo(orderno);
	}

	@Override
	public void updateAddress(String orderno ,String address, String owner) {
		Order order = orderDao.getByOrderNo(orderno);
		order.setAddress(address);
		order.setOwner(owner);
		orderDao.updateEntry(order);
	}

	@Override
	public void updateStatus(String orderno, int status) {
		Order order = orderDao.getByOrderNo(orderno);
		if (Integer.parseInt(order.getStatus()) > status) {
			return ;
		}
		order.setStatus(status+"");
		orderDao.updateEntry(order);
	}
	@Override
	public void deleteOrder(int id,String status) {
		orderDao.deleteOrder(id,status);
	}

	@Override
	public void updateOrder(Order order) {
		orderDao.updateEntry(order);
	}

}
