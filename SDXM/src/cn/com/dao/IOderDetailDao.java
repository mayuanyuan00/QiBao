package cn.com.dao;

import cn.com.dao.base.IBaseDao;
import cn.com.domain.OrderDetail;
import cn.com.vo.Charts;

import java.util.List;

public interface IOderDetailDao extends IBaseDao<OrderDetail>{
    /**
     * 按月份查找书的类别和销量
     */
    List<Charts> selectCharts(String year);

}
