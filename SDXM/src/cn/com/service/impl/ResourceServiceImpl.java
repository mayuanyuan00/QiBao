package cn.com.service.impl;


import cn.com.common.Constants;
import cn.com.dao.IResourcesDao;


import cn.com.domain.Resource;
import cn.com.service.IResourceService;
import cn.com.vo.PageResults;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.Serializable;

import java.util.Map;

@Service("resourcesService")
public class ResourceServiceImpl implements IResourceService{
    @javax.annotation.Resource(name="resourcesDao")
    private IResourcesDao resourcesDao;

    @Override
    @Transactional
    public PageResults<Resource> getResourcesReleasedByPage(Integer page) {
        return this.resourcesDao.findPageByFetchedSql(
                "SELECT * FROM resource WHERE rel = 1",
                "select count(*) from resource",Resource.class,
                page, 20, null);
    }

    @Override
    @Transactional
    public PageResults<Resource> getResourcesByPage(Integer page) {
        return this.resourcesDao.findPageByFetchedSql(
                "SELECT * FROM resource",
                "select count(*) from resource",Resource.class,
                page, 20, null);
    }

    @Override
    @Transactional
    public Resource selectResources(Serializable id) {
       return resourcesDao.getEntryById(id);
    }

//    @Override
//    @Transactional
//    public List<Resource> getResouecesByLimited(Integer limited) {
//        Object[] parems = new Object[1];
//        String whql = "and o.isDelete != '1'LIMIT ?";
//        parems = new Object[]{limited};
//        List<Links> list = new ArrayList<>();
//        list.addAll(resourcesDao.findObjectsByConditionWithNoPage(whql, parems, null));
//        return list;
//    }

    @Override
    @Transactional
    public void deleteResource(Serializable id) {
      resourcesDao.deleteByIds(id);
    }



    @Override
    @Transactional
    public void updateResource(Resource resource) {
        resourcesDao.updateEntry(resource);
    }

    @Override
    @Transactional
    public void updateRel(Integer id, String rel) {
        Resource resource=this.selectResources(id);
        resource.setRelease(rel);
        this.updateResource(resource);
    }

    @Override
    @Transactional(readOnly = false)
    public void saveResource(Resource resource) {
//        if (links.getIsDelete()==null||links.getIsDelete().length()>1){
//            links.setIsDelete("0");
//        }
         resourcesDao.saveEntry(resource);
    }

    @Override
    @Transactional
    public PageResults<Resource> searchResourceDetail(String key, int page) {
        return this.resourcesDao.findPageByFetchedSql(
                "select * from resource WHERE resource_name like ?",
                "select count(*) from resource  WHERE resource_name like ?",Resource.class,
                page, Constants.PAGE_SIZE, new Object[]{"%" + key + "%"}
        );
    }
}
