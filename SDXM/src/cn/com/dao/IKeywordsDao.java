package cn.com.dao;

import cn.com.dao.base.IBaseDao;
import cn.com.domain.Keywords;

import java.util.List;

/**
 * Created by ironman on 2017/11/8.
 */
public interface IKeywordsDao extends IBaseDao<Keywords> {
    void deleteByIds(List<Integer> ids);

    void deleteByNames(List<String> names);

    void deleteByName(String name);

    List<Keywords> findByIds(List<Integer> ids);

    List<Keywords> findByName(String keyword);

    List<Keywords> findByNames(List<String> keywords);

    void addKeywords(List<String> keywords);

}
