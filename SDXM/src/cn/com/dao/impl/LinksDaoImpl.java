package cn.com.dao.impl;

import cn.com.dao.ILinksDao;
import cn.com.dao.base.impl.BaseDaoImpl;
import cn.com.domain.Links;
import org.springframework.stereotype.Repository;

@Repository("linksDao")
public class LinksDaoImpl extends BaseDaoImpl<Links> implements ILinksDao {
}
