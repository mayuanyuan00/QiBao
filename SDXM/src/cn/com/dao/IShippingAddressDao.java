package cn.com.dao;

import cn.com.dao.base.IBaseDao;
import cn.com.domain.ShippingAddress;

import java.util.List;

public interface IShippingAddressDao extends IBaseDao<ShippingAddress>{

    /**
     * 通过UserID获取地址
     * @param id
     * @return
     */
    List<ShippingAddress> findById(Integer id);
}
