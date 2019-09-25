package cn.com.dao.impl;


import cn.com.dao.IResourcesDao;
import cn.com.dao.base.impl.BaseDaoImpl;
import cn.com.domain.Resource;
import org.springframework.stereotype.Repository;

@Repository("resourcesDao")
public class ResourcesDaoImpl extends BaseDaoImpl<Resource> implements IResourcesDao {
}
