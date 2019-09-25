package cn.com.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.com.dao.ICollectionDao;
import cn.com.domain.Collection;
import cn.com.service.ICollectionService;

@Service("collectionService")
public class CollectionServiceImpl implements ICollectionService{

	@Autowired
	private ICollectionDao collectionDao;
	
	@Override
	public void refreshCollection(Map<Integer, Collection> collection, Integer userid) {
		// 删除所有用户之前的收藏信息
		collectionDao.deleteAllByUserid(userid);
		// 存储当前收藏信息
		for (Entry<Integer, Collection> entry : collection.entrySet()) {
			collectionDao.saveEntry(entry.getValue());
		}
		
	}

	@Override
	public Map<Integer, Collection> getCollectionDetail(Integer userid) {
		List<Collection> list  = collectionDao.getAllByUserid(userid);
		Map<Integer, Collection> collection = new HashMap<Integer, Collection>();
		for (Collection c : list) {
			collection.put(c.getItemid(), c);
		}
		return collection;
	}

}
