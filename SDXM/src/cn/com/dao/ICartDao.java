package cn.com.dao;

import java.util.List;

import cn.com.dao.base.IBaseDao;
import cn.com.domain.Cart;
/**
 * 购物车功能的DAO接口
 * @author 常东旭/张炜婕
 *
 */
public interface ICartDao extends IBaseDao<Cart>{

	public void deleteAllByUserid(Integer userid);
	
	public List<Cart> getAllByUserid(Integer userid);
	
	
}
