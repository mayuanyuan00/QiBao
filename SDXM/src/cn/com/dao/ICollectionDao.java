package cn.com.dao;

import java.util.List;

import cn.com.dao.base.IBaseDao;
import cn.com.domain.Collection;


public interface ICollectionDao extends IBaseDao<Collection>{

	public void deleteAllByUserid(Integer userid);
	
	public List<Collection> getAllByUserid(Integer userid);
}
