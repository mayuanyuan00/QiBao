package cn.com.dao;

import cn.com.dao.base.IBaseDao;
import cn.com.domain.Columnlist;

import java.util.Collection;
import java.util.List;

public interface IMenuDao extends IBaseDao<Columnlist>{

    public boolean updateColumn(Integer id, String name, Boolean hasContent);

    public boolean updateColumn(Integer id, String name, Integer parent, Boolean hasContent);

    public List<Columnlist> findByName(String name);
}
