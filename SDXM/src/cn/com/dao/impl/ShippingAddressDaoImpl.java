package cn.com.dao.impl;

import cn.com.dao.IShippingAddressDao;
import cn.com.dao.base.impl.BaseDaoImpl;
import cn.com.domain.ShippingAddress;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("shippingAddressDao")
public class ShippingAddressDaoImpl extends BaseDaoImpl<ShippingAddress> implements IShippingAddressDao{
    @Override
    public List<ShippingAddress> findById(Integer userId) {
        String query="FROM ShippingAddress address where address.id="+userId.toString();
        return this.hibernateTemplate.find(query);
    }
}
