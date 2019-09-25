package cn.com.dao;


import cn.com.dao.base.IBaseDao;
import cn.com.domain.User;

public interface IUserDao extends IBaseDao<User> {
	/**
	 * 按照电话查找User
	 * @param phone 电话号码
	 * @return 如果 return null 表示没有找到对应的User
	 * @author 张炜婕
	 */
	 User findByPhone(String phone);
	
	/**
	 * 按照邮箱查找User
	 * @param email 邮箱
	 * @return 如果 return null 表示没有找到对应的User
	 * @author 张炜婕
	 */
	 User findByEmail(String email);




}
