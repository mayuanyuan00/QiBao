package cn.com.service;

import java.util.Map;

import cn.com.domain.Cart;
/**
 * 购物车业务层接口
 * @author 常东旭
 *
 */
public interface ICartService {
	
	public void refreshCart(Map<Integer, Cart> cart,Integer userid);
	
	public Map<Integer, Cart> getCartDetail(Integer userid);
}
