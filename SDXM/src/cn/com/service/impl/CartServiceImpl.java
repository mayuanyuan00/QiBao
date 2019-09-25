package cn.com.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.com.dao.ICartDao;
import cn.com.domain.Cart;
import cn.com.service.ICartService;
/**
 * 购物车业务层实现
 * @author 常东旭/张炜婕
 *
 */
@Service("cartService")
public class CartServiceImpl implements ICartService {

	@Autowired
	private ICartDao cartdao;

	@Transactional(readOnly=false)
	@Override
	public void refreshCart(Map<Integer, Cart> cart, Integer userid) {
		// 删除所有用户之前的购物车信息
		cartdao.deleteAllByUserid(userid);
		// 存储当前购物车信息
		for (Entry<Integer, Cart> entry : cart.entrySet()) {
			cartdao.saveEntry(entry.getValue());
		}

	}

	@Transactional(readOnly=true)
	@Override
	public Map<Integer, Cart> getCartDetail(Integer userid) {
		List<Cart> list  = cartdao.getAllByUserid(userid);
		Map<Integer, Cart> cart = new HashMap<Integer, Cart>();
		for (Cart c : list) {
			cart.put(c.getItemid(), c);
		}
		return cart;
	}

}
