package cn.com.service;

import cn.com.domain.Contacts;
import cn.com.vo.PageResults;



public interface IContactsService {

	/**
	 *保存互动信息
	 */
	 void saveContacts(Contacts contacts);

	/**
	 *删除互动信息
	 */
	void deleteContacts(Integer id);

	/**
	 *根据Id获取信息
	 */
	Contacts getContactById(Integer id);

	/**
	 *获取所有互动信息
	 * @return
	 */
	 PageResults<Contacts> getAdminContactsByPage(Integer page);


}

