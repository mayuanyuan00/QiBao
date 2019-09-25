package cn.com.service;


import cn.com.vo.Charts;
import cn.com.vo.OrderInfo;
import cn.com.vo.PageResults;

import java.util.Date;
import java.util.List;

public interface IChartService {
    List<Charts> getOderDetail(String year);
    PageResults<OrderInfo> getOrderList(int year,int month, int page);
}
