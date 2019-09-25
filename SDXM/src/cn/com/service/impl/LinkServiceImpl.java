package cn.com.service.impl;


import cn.com.common.Constants;
import cn.com.dao.ILinksDao;
import cn.com.domain.Links;
import cn.com.service.ILinksService;
import cn.com.vo.PageResults;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Service("linksService")
public class LinkServiceImpl implements ILinksService{
    @Resource(name="linksDao")
    private ILinksDao linksDao;

    @Override
    @Transactional
    public PageResults<Links> getLinksByPage(Integer page) {
        return this.linksDao.findPageByFetchedHql(
                "from Links links where links.isDelete = '0'",
                "select count(*) from Links links where links.isDelete = '0'",
                page, 20, null);
    }

    @Override
    @Transactional
    public Links selectLinks(Serializable id) {
       return linksDao.getEntryById(id);
    }

    @Override
    @Transactional
    public List<Links> getLinksByLimited(Integer limited) {
        Object[] parems = new Object[1];
        String whql = "and o.isDelete != '1'LIMIT ?";
        parems = new Object[]{limited};
        List<Links> list = new ArrayList<>();
        list.addAll(linksDao.findObjectsByConditionWithNoPage(whql, parems, null));
        return list;
    }

    @Override
    @Transactional
    public void deleteLinks(Serializable id) {
      linksDao.deleteByIds(id);
    }

    @Override
    @Transactional
    public void logicDeleteLinks(Serializable id) {
       Links links=this.linksDao.getEntryById(id);
       if (links!=null){
           links.setIsDelete("1");
           linksDao.updateEntry(links);
       }
    }

    @Override
    @Transactional
    public void updateLinks(Links links) {
        if (links.getIsDelete()==null||links.getIsDelete().length()>1){
            links.setIsDelete("0");
        }
        linksDao.updateEntry(links);
    }

    @Override
    @Transactional(readOnly = false)
    public void saveLinks(Links links) {
        if (links.getIsDelete()==null||links.getIsDelete().length()>1){
            links.setIsDelete("0");
        }
         linksDao.saveEntry(links);
    }

    @Override
    @Transactional
    public PageResults<Map> searchLinksDetail(String key, int page) {
        return this.linksDao.findMapByFetchSql(
                "select * from links WHERE is_delete = '0' and title like ?",
                "select count(*) from links  WHERE is_delete = '0' and title like ?",
                page, Constants.PAGE_SIZE, new Object[]{"%" + key + "%"}
        );
    }
}
