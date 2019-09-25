package cn.com.dao.impl;

import cn.com.dao.IReleaseBookDao;
import cn.com.dao.base.impl.BaseDaoImpl;
import cn.com.domain.ReleaseBook;
import org.springframework.stereotype.Repository;

/**
 * Created by Ting on 2018/4/25
 */
@Repository("releaseBookDao")
public class ReleaseBookDaoImpl extends BaseDaoImpl<ReleaseBook> implements IReleaseBookDao {

}
