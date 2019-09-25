package cn.com.service.impl;

import cn.com.dao.IShippingAddressDao;
import cn.com.domain.ShippingAddress;
import cn.com.service.IShippingAddressService;
import com.sun.org.apache.bcel.internal.generic.SIPUSH;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

@Service("shippingAddressService")
public class ShippingAddressServiceImpl implements IShippingAddressService {
    @Resource(name="shippingAddressDao")
    private IShippingAddressDao shippingAddressDao;

    @Override
    @Transactional(readOnly=false)
    public List<ShippingAddress> findByUser(Integer userId) {
        String wql="and userid="+userId.toString();
        return shippingAddressDao.findObjectsByConditionWithNoPage(wql,null);
    }

    @Override
    public ShippingAddress findById(Integer id) {
        List<ShippingAddress> addresses=shippingAddressDao.findById(id);
        if (addresses.size()>0){
            return addresses.get(0);
        }
        return null;
    }

    @Override
    public void insert(ShippingAddress shippingAddress) {
         shippingAddressDao.saveEntry(shippingAddress);
    }

    @Override
    public void delete(Integer id) {
        shippingAddressDao.deleteByIds(id);
    }

    @Override
    public void update(ShippingAddress shippingAddress) {
        shippingAddressDao.updateEntry(shippingAddress);
    }
}
