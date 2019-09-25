package cn.com.dao;

import cn.com.dao.base.IBaseDao;
import cn.com.domain.Booktype;

public interface IBooktypeDao extends IBaseDao<Booktype> {
    /**
     * 逻辑删除 设置bookType isDelete字段为“1” 其子节点及以下的节点做相同修改
     * @param id 需要修改的图书类型id
     * @return 返回值为0则代表操作失败 否则返回改变的条数
     */
    int logicDelete(Integer id);
}
