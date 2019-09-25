package cn.com.service;

import java.io.Serializable;
import java.util.List;

import cn.com.domain.Menu;
import cn.com.domain.User;
import cn.com.domain.Usergroup;
import cn.com.vo.AuthorityVO;
import cn.com.vo.PageResults;

public interface IUserService {
	
	/**
	 * 增加新用户
	 * @param user
	 */
	public Integer saveUser(User user);
	
	/**
	 * 更新用户
	 * @param user
	 */
	public void updateUser(User user);
	
	/**
	 * 删除用户
	 * @param id	用户id
	 */
	public void deleteUser(Serializable id);
	
	/**
	 * 查询用户
	 * @param id	用户id
	 * @return
	 */
	public User findUserById(Serializable id);

	/**
	 * 检查用户是否存在
	 * @param user	用户信息
	 * @return		如果存在返回true，不存在返回false
	 */
	public User checkUser(User user,String groupCode);

	/**
	 * 用户退出，修改用户状态为0
	 * @param user	用户信息
	 */
	public void loginout(User user);
	
	/**
	 * 获得所有在线用户
	 * @return
	 */
	public List<User> getAllOnLineUser();
	
	/**
	 * 
	 */
	public boolean checkRepeat(String content);
	
	/**
	 * 检查用户名是否存在
	 *
	 * @param name
	 */
	public List<User> findUserByName(String name,String groupCode);

	/**
	 * 获取用户分页
	 *
	 * @param page
	 */
	public PageResults<User> getUserOfPage(int page);
	/**
	 * 获取用户分页
	 *
	 * @param page
	 */
	public PageResults<User> getGroupUserOfPage(int page,String group);

	/**
	 * 获取搜索用户分页
	 * @param page
	 *
	 */
	public PageResults<User> getSearchUserOfPage(int page,String name,String group);

	/**
	 * 获取所有超级管理员用户
	 * @return
	 */
	public List<User> getAllAdminUser();

	public cn.com.domain.User checkUser(String username, String encodedPassword,String groupCode);

	/**
	 * 查找所有用户权限
	 */
	List<Menu> findAllAuthority();

	/**
	 * 添加权限
	 */

	void addAuthority(Usergroup usergroup);

	/**
	 * 更新权限
	 */

	void updateAuthority(Usergroup usergroup);

	/**
	 * 查找权限
	 */
	List<AuthorityVO> selectByid(int id);

	/**
	 * 删除权限
	 */
	void deleteByUser(int authority);

	/**
	 * 查询栏目by name
	 */
	List<Menu> selectByName(String name);

	/**
	 * 查询栏目by url
	 */
	List<Menu> selectByUrl(String url);

	/**
	 * 增加栏目
	 */
	void addColumn(Menu menu);

	/**
	 * 删除栏目
	 */

	void deleteColumn(int id);

}
