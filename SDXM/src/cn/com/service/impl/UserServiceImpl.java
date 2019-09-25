package cn.com.service.impl;

import java.io.Serializable;
import java.util.LinkedHashMap;
import java.util.List;

import javax.annotation.Resource;

import cn.com.dao.IMenusDao;
import cn.com.dao.IUserGroupDao;
import cn.com.dao.IUserMenuDao;
import cn.com.domain.Menu;
import cn.com.domain.Usergroup;
import cn.com.vo.AuthorityVO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.com.dao.IUserDao;
import cn.com.domain.User;
import cn.com.service.IUserService;
import cn.com.utils.StringUtils;
import cn.com.vo.PageResults;

@Service("userService")
public class UserServiceImpl implements IUserService {

	@Resource(name="userDao")
	private IUserDao userDao;

	@Resource(name = "userMenuDao")
	private IUserMenuDao userMenuDao;

	@Resource(name = "userGroupDao")
	private IUserGroupDao userGroupDao;

	@Resource(name = "menusDao")
	private IMenusDao menusDao;
	
	@Transactional(readOnly=false)
	public Integer saveUser(User user) {
		return this.userDao.saveReturnId(user);
	}

	@Transactional(readOnly=false)
	public void updateUser(User user) {
		this.userDao.updateEntry(user);
	}

	@Transactional(readOnly=false)
	public void deleteUser(Serializable id) {
		this.userDao.deleteByIds(id);
	}

	public User findUserById(Serializable id) {
		return this.userDao.getEntryById(id);
	}

	public User checkUser(User user,String groupCode) {
		String whereHql;
		if("3".equals(groupCode)){
			 whereHql=" and o.userName=? and o.password=? and is_delete = '0' and group_code = '3'";
		}else {
			whereHql=" and o.userName=? and o.password=? and is_delete = '0' and group_code != '3'";
		}
		Object[] params={user.getUserName(),user.getPassword()};
		LinkedHashMap<String, String> orderBy=new LinkedHashMap<String, String>();
		orderBy.put("o.id", "asc");
		List<User> list=this.userDao.findObjectsByConditionWithNoPage(whereHql, params, orderBy);
		if(list.size()>0&&list.get(0)!=null){
			User User=list.get(0);
			User.setStatus("1");
			this.userDao.updateEntry(User);
			return User;
		}
		return null;
	}
	
	/**
	 * 
	 * @param username 用户名或者邮箱或者电话
	 * @param password
	 * @return
	 */
	public User checkUser(String username,String password,String groupCode) {
		String whereHql;
		if("3".equals(groupCode)) {
			 whereHql=" and (o.userName=? or o.phone = ? or o.email = ?) and o.password=? and is_delete = '0' and group_code = '3'";
		}else {
			 whereHql=" and (o.userName=? or o.phone = ? or o.email = ?) and o.password=? and is_delete = '0' and group_code != '3'";
		}
		Object[] params={username,username,username,password};
		LinkedHashMap<String, String> orderBy=new LinkedHashMap<String, String>();
		orderBy.put("o.id", "asc");
		List<User> list=this.userDao.findObjectsByConditionWithNoPage(whereHql, params, orderBy);
		if(list.size()>0&&list.get(0)!=null){
			User User=list.get(0);
			//User.setStatus("1");
			this.userDao.updateEntry(User);
			return User;
		}
		return null;
	}

	@Override
	public List<Menu> findAllAuthority() {
		return userMenuDao.findAllAuthority();
	}

	@Override
	@Transactional
	public void addAuthority(Usergroup usergroup) {
		 userGroupDao.addAuthority(usergroup);
	}

	@Override
	@Transactional
	public void updateAuthority(Usergroup usergroup) {
		userGroupDao.updateAuthority(usergroup);
	}

	@Override
	public List<AuthorityVO> selectByid(int id) {
		return userGroupDao.selectByid(id);
	}

	@Override
	@Transactional
	public void deleteByUser(int authority) {
		userGroupDao.deleteByUser(authority);
	}

	@Override
	public List<Menu> selectByName(String name) {
		return menusDao.selectByName(name);
	}

	@Override
	public List<Menu> selectByUrl(String url) {
		return menusDao.selectByUrl(url);
	}

	@Override
	@Transactional
	public void addColumn(Menu menu) {
		menusDao.addColumn(menu);
	}

	@Override
	@Transactional
	public void deleteColumn(int id) {
		menusDao.deleteColumn(id);
	}

	@Transactional(readOnly=false)
	public void loginout(User user) {
		if(user!=null){
			user.setStatus("0");
			this.userDao.updateEntry(user);
		}
	}

	public List<User> getAllOnLineUser() {
		String whereHql="and o.status='1'";
		List<User> list=this.userDao.findObjectsByConditionWithNoPage(whereHql, null, null);
		return list;
	}

	@Override 
	public boolean checkRepeat(String content) {
		//  判断content是什么？
		User user = null;
		if (StringUtils.checkEmail(content)) {
			user = userDao.findByEmail(content);
		} else if (StringUtils.checkMobileNumber(content)) {
			user = userDao.findByPhone(content);
		} else {
			throw new IllegalArgumentException("无法判断类型");
		}
		return user == null ? true:false;
	}
	
	public List<User> findUserByName(String name,String groupCode){
		String whereHql;
		if("3".equals(groupCode)){
			 whereHql=" and userName=? and isDelete='0'and group_code = '3'";
		}else {
			 whereHql=" and userName=? and isDelete='0'and group_code != '3'";
		}
		Object[] params={name};
		List<User> list=this.userDao.findObjectsByConditionWithNoPage(whereHql, params, null);
		return list;
	}

	@Override
	@Transactional
	public PageResults<User> getUserOfPage(int page){
		return this.userDao.findPageByFetchedHql(
				"from User user WHERE is_delete = 0 and group_code != '3'","select count(*) from User WHERE is_delete = 0 and group_code != '3'",
				page,11,null);
	}

	@Override
	@Transactional
	public PageResults<User> getGroupUserOfPage(int page,String group){
		Object[] params={group};
		return this.userDao.findPageByFetchedHql(
				"from User user WHERE is_delete = 0 and group_code= ? ","select count(*) from User WHERE is_delete = 0 and group_code=?",
				page,11,params);
	}

	@Override
	@Transactional
	public PageResults<User> getSearchUserOfPage(int page,String name,String group) {
		if (group == null||"".equals(group)) {
			return this.userDao.findPageByFetchedHql(
					"from User user WHERE userName LIKE '%" + name + "%' AND isDelete = 0 and groupCode!= '3'", "select count(*) from User where userName LIKE '%" + name + "%'  AND isDelete = 0 and groupCode!= '3'",
					page, 11, null);
		}else {
			Object[] params={group};
			return this.userDao.findPageByFetchedHql(
					"from User user WHERE userName LIKE '%" + name + "%' AND isDelete = 0 and groupCode=?", "select count(*) from User where userName LIKE '%" + name + "%'  AND isDelete = 0 and groupCode=?",
					page, 11, params);
		}
	}

	@Override
	@Transactional
	public List<User> getAllAdminUser(){
		String whereHql="and o.isDelete='0' and o.groupCode <> '3'";
		List<User> list=this.userDao.findObjectsByConditionWithNoPage(whereHql, null, null);
		return list;
	}
}
