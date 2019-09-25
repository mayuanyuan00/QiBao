package cn.com.service;

import cn.com.domain.ShippingAddress;

import java.util.List;

public interface IShippingAddressService {

    /**
     * 获取某用户所有地址
     */
    List<ShippingAddress> findByUser(Integer userId);

    /**
     * 获取某个地址
     * 若没找到 就返回null
     */
    ShippingAddress findById(Integer id);

    /**
     * 增加信息
     */
    void insert(ShippingAddress shippingAddress);

    /**
     * 删除信息
     */
    void delete(Integer id);

    /**
     * 修改
     */
    void update(ShippingAddress shippingAddress);
}
