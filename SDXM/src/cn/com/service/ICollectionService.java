package cn.com.service;

import java.util.Map;

import cn.com.domain.Collection;

public interface ICollectionService {
	public void refreshCollection(Map<Integer, Collection> collection,Integer userid);
	
	public Map<Integer, Collection> getCollectionDetail(Integer userid);
}
