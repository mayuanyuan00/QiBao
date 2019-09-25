package cn.com.service;

import java.util.List;

import cn.com.domain.Order;
import cn.com.domain.OrderDetail;
import cn.com.vo.OderInfo;
import cn.com.vo.PageResults;

public interface IOrderService {
	
	public List<OrderDetail> getOrderDetail(int orderid);
	
	public PageResults<Order> getOrderList(int status, int userid, int page);

	public Long getOrderCount(int status,int userId);

	Order getOrder(int orderid);
	
	Order getOrder(String orderno);

	int orderCreate(List<OderInfo> list, int userid, String orderno);
	
	void updateAddress(String orderno, String address,String owner);
	
	void updateStatus(String orderno,int status);

	void deleteOrder(int id,String status);

	void updateOrder(Order order);

}
