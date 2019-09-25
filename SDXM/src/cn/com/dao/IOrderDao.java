package cn.com.dao;

import cn.com.dao.base.IBaseDao;
import cn.com.domain.Order;
import cn.com.vo.PageResults;

public interface IOrderDao extends IBaseDao<Order>{

	 Long getOrderCount(int status, int userid);
	
	 Order getByOrderNo(String orderno);

	 void deleteOrder(int id,String status);

	 PageResults<Order> getOrderList(int status, int userid,int page);



}
