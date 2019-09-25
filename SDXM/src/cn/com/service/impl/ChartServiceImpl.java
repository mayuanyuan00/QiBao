package cn.com.service.impl;

import cn.com.dao.IOderDetailDao;
import cn.com.dao.IOrderSearchDao;
import cn.com.service.IChartService;
import cn.com.vo.Charts;
import cn.com.vo.OrderInfo;
import cn.com.vo.PageResults;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

@Service("chartService")
public class ChartServiceImpl implements IChartService {

    @Autowired
    IOderDetailDao oderDetailDao;
    @Autowired
    IOrderSearchDao orderSearchDao;

    @Transactional(readOnly = true)
    @Override
    public List<Charts> getOderDetail(String year) {
        List<Charts> charts=oderDetailDao.selectCharts(year);
        for (Charts chart:charts){
            if(chart.getParentid()==0){
                chart.setBookType("其他");
            }
            if(chart.getParentid()==12){
                chart.setBookType("教材专著");
            }
            if(chart.getParentid()==13){
                chart.setBookType("人文社科");
            }
            if(chart.getParentid()==14){
                chart.setBookType("艺术类");
            }
            if(chart.getParentid()==15){
                chart.setBookType("海派文化");
            }
            if(chart.getParentid()==16){
                chart.setBookType("工具书");
            }
            if(chart.getParentid()==17){
                chart.setBookType("中小学教辅");
            }
            if(chart.getParentid()==18){
                chart.setBookType("其他");
            }
        }
        return charts;
    }

    @Override
    public PageResults<OrderInfo> getOrderList(int year,int month, int page) {
        return orderSearchDao.selectOrder(year,month,page);
    }
}
