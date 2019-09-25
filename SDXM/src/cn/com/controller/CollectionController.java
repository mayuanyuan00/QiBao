package cn.com.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import cn.com.domain.*;
import cn.com.service.ILinksService;
import cn.com.vo.PageResults;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import cn.com.common.Constants;
import cn.com.service.IBookService;
import cn.com.service.ICollectionService;
import cn.com.vo.CartInfo;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("collection")
public class CollectionController {

	@Autowired
	private ICollectionService collectionService;
	
	@Autowired
	private IBookService bookService;

	@Resource(name = "linksService")
	private ILinksService linksService;
	
	//Map<Integer, Collection> cart = collectionService.getCollectionDetail(userid);	
	private Integer getUserId(HttpSession session){
		//获取用户id
		User us = (User) session.getAttribute("user");
		return us.getId();
	}

	@RequestMapping("myCollection.do")
	public String toCollection(HttpServletRequest request,HttpSession session) {
		int userid = getUserId(session);
		Map<Integer, Collection> collection = collectionService.getCollectionDetail(userid);
		ArrayList<Book> re = new ArrayList<>();
		for (Integer in : collection.keySet()) {
			Collection tCollection = collection.get(in);
			Book b = bookService.findBookById(in);
			re.add(b);
		}
		request.setAttribute("collection", re);
		return "website/my_collection";
	}

	@RequestMapping("add.do")
	public @ResponseBody String add(HttpSession session, Integer itemid) {
		int userid = getUserId(session);
		Map<Integer, Collection> collection = collectionService.getCollectionDetail(userid);
		Collection cl = new Collection(userid, itemid);
		collection.put(itemid, cl);
		collectionService.refreshCollection(collection, userid);
		return "success";
	}
	
	@RequestMapping("remove.do")
	public @ResponseBody String remove(HttpSession session, Integer itemid) {
		int userid = getUserId(session);
		Map<Integer, Collection> collection = collectionService.getCollectionDetail(userid);
		// 确保session有cart
		collection.remove(itemid);
		//调用service 存储进入数据库
		collectionService.refreshCollection(collection, userid);
		return "success";
	}

	/**
	 * footer链接传送
	 * @param model
	 */
	@ModelAttribute
	public void links(Model model) {
		PageResults<Links> linksResults = linksService.getLinksByPage(1);
		List<Links> urlList = linksResults.getResults();
		model.addAttribute("urlList", urlList);
	}


}
