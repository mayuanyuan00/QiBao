package cn.com.service.impl;

import cn.com.dao.IContactsDao;
import cn.com.domain.Contacts;
import cn.com.service.IContactsService;
import cn.com.vo.PageResults;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import javax.annotation.Resource;


@Service("contactsService")
public class ContactsServiceImpl implements IContactsService{
	@Resource(name="contactsDao")
	private IContactsDao contactsDao;

	//保存互动信息
	@Transactional
	public void saveContacts(Contacts contacts) {
		this.contactsDao.saveEntry(contacts);
	}
	//删除互动信息
	@Transactional
	public void deleteContacts(Integer id) {
		this.contactsDao.deleteByIds(id);
	}
	//获取互动信息
	@Transactional
	public Contacts getContactById(Integer id){
		return this.contactsDao.getEntryById(id);
	}

	//获取所有互动信息
	@Override
	@Transactional
	public PageResults<Contacts> getAdminContactsByPage(Integer page){
		return this.contactsDao.findPageByFetchedHql(
				"from Contacts contacts order by id desc", "select count(*) from Contacts",
				page, 10, null);
	}

}
