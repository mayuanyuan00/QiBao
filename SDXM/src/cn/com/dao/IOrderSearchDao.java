package cn.com.dao;

import cn.com.dao.base.IBaseDao;
import cn.com.vo.OrderInfo;
import cn.com.vo.PageResults;


public interface IOrderSearchDao extends IBaseDao<OrderInfo> {
    /**
     * 按月份查找订单(订单号 书名 订单日期 数量  单价  金额)
     */
    PageResults<OrderInfo> selectOrder(int year,int month,int page);
}
