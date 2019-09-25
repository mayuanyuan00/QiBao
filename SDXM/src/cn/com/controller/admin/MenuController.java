/*
 * UserController.java
 * Version: 1.0
 * Copyright 2017 by 上海大学出版社
 * ALL Rights Reserved.
*/
package cn.com.controller.admin;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import cn.com.domain.Columnlist;
import cn.com.domain.News;
import cn.com.service.INewsKeywordsService;
import cn.com.service.INewsService;
import cn.com.utils.RandomStringUtil;
import cn.com.vo.ColumnInfo;
import cn.com.vo.NewsWithKeywords;
import cn.com.vo.Pair;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import cn.com.service.IMenuService;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 后台栏目相关控制类
 * @author 张铁男　2017/09/13
*/

@Controller
@RequestMapping("/menu")
public class MenuController {
	/** service接口定义 */
	@Resource(name="menuService")
	private IMenuService menuService;
	@Resource(name="newsService")
	private INewsService newsService;
	@Resource(name="newsKeywordsService")
	private INewsKeywordsService newsKeywordsService;

	@RequestMapping("/menuList.do")
	public ModelAndView menuList(String searchStr,@RequestParam(required = false) String authority,HttpServletRequest request) {
		//menuService.getAllColumns()
		ModelAndView mav = new ModelAndView("admin/menu/menuList");
		if(searchStr == null) {
			mav.addObject("columns", menuService.columnsByLevel());
			mav.addObject("isSearch", false);
		}
		else {
			mav.addObject("columns", menuService.searchColumnsByLevel(searchStr));
			mav.addObject("isSearch", true);
		}
		if(authority!=null){
			request.getSession().setAttribute("authority",authority);
		}
		return mav;
	}

	//到修改栏目页面
	@RequestMapping("/updateMenu.do")
	public ModelAndView updateMenu(ColumnInfo columnInfo) throws Exception{
		ModelAndView mav = new ModelAndView("admin/menu/menuUpdate");
		mav.addObject("isParent", columnInfo.getFirstColumnId() == 0);
		mav.addObject("firstColumnId", columnInfo.getFirstColumnId());
		mav.addObject("secondColumnId", columnInfo.getSecondColumnId());
		mav.addObject("secondColumnName", columnInfo.getSecondColumnName());
		mav.addObject("hasContent", columnInfo.getHasContent());
		mav.addObject("columns", menuService.allParentColumns());
		return mav;
	}

    //修改栏目
	@RequestMapping("/updateMenuInfo.do")
	public ModelAndView updateMenuInfo(ColumnInfo columnInfo,HttpServletRequest request) {
		if (columnInfo.getFirstColumnId() == null){
			//修改的是一级栏目
			menuService.updateColumn(columnInfo.getSecondColumnId(), columnInfo.getSecondColumnName(), columnInfo.getHasContent());
		} else {
			//修改的是二级栏目
			menuService.updateColumn(columnInfo.getSecondColumnId(), columnInfo.getSecondColumnName(), columnInfo.getFirstColumnId(), columnInfo.getHasContent());
		}
		return this.menuList(null,(String)request.getSession().getAttribute("authority"),request);
	}

	//到添加栏目页面
	@RequestMapping("/menuInfo.do")
	public ModelAndView menuInfo(Integer menuType) throws Exception{
		ModelAndView mav = new ModelAndView("admin/menu/menuInfo");
		mav.addObject("columns", menuService.allParentColumns());
		mav.addObject("menuType", menuType);
		return mav;
	}

	//删除栏目
	@RequestMapping("/deleteMenu.do")
	public ModelAndView deleteMenu(Integer columnId,HttpServletRequest request) throws Exception{
		this.menuService.deleteColumn(columnId);
		return this.menuList(null,(String)request.getSession().getAttribute("authority"),request);
	}

	//新增栏目
	@RequestMapping("/saveMenu.do")
	public ModelAndView saveMenu(ColumnInfo columnInfo,HttpServletRequest request) throws Exception{
		if(columnInfo.getParent()){
			menuService.saveColumn(new Columnlist(columnInfo.getSecondColumnName(), 1, 0, columnInfo.getHasContent()));
		} else {
			menuService.saveColumn(new Columnlist(columnInfo.getSecondColumnName(), 2,
					columnInfo.getFirstColumnId(), columnInfo.getHasContent()));
		}
		return this.menuList(null,(String)request.getSession().getAttribute("authority"),request);
	}

	//编辑栏目内容页面（比如新增新闻）
	@RequestMapping("/editMenu.do")
	public ModelAndView editMenu(Integer columnId) {
		ModelAndView mav = new ModelAndView("admin/menu/newsEdit");
		List<String> keywords = new ArrayList<>();
		keywords.add("");
		keywords.add("");
		keywords.add("");
		mav.addObject("oneNews", new News(columnId));
		mav.addObject("keywords", keywords);
		Columnlist columnlist = menuService.findComlumnById(columnId);
		mav.addObject("titleName", columnlist != null ? columnlist.getName() : "标题");
		mav.addObject("hasVideo", columnlist != null && columnlist.getName().equals("重要活动"));
		return mav;
	}

	//保存栏目内容
	@RequestMapping(value = "/saveMenuContent.do", method = RequestMethod.POST)
	@ResponseBody
	public String saveMenuContent(@RequestBody NewsWithKeywords news){
		//news.setCreateTime(new Date());
		if(("").equals(news.getId())) {
			String newsId = RandomStringUtil.getRandomCode(32, 6);
			news.setId(newsId);
			// 保存新闻
			newsService.saveNews(news.getNewsObj());
			// 保存关键词
			newsKeywordsService.updateKeywordsOfNews(newsId, news.getKeywords());
		} else {
			// 更新新闻
			newsService.updateNews(news.getNewsObj());
			newsKeywordsService.updateKeywordsOfNews(news.getId(), news.getKeywords());
		}
		return "SUCCESS";
	}



	//查看新闻列表
	@RequestMapping("/showNews.do")
	public ModelAndView showNews(Integer type, String searchStr,
								 @RequestParam(defaultValue = "1") int page) {
		ModelAndView mav = new ModelAndView("admin/menu/newsList");
		if(searchStr == null){
			mav.addObject("news", newsService.newsOfType(type));
		} else {
			mav.addObject("news", newsService.searchNews(searchStr, type, page).getResults());
		}
		mav.addObject("type", type);
		return mav;
	}

	//删除新闻
	@RequestMapping("/deleteNews.do")
	public ModelAndView deleteNews(String id, Integer type) {
		newsService.deleteById(id);
		return this.showNews(type, null, 1);
	}

	//更新新闻页面
	@RequestMapping("/updateNews.do")
	public ModelAndView updateNews(String id) {
		ModelAndView mav = new ModelAndView("admin/menu/newsEdit");
		// 获取新闻的关键词
		List<String> keywords = newsKeywordsService.keywordsNameOfNews(id);
		int remain = 3 - keywords.size();
		for(int i = 0; i < remain; i++){
			keywords.add("");
		}
		mav.addObject("keywords", keywords);
		mav.addObject("oneNews", newsService.findById(id));
		return mav;
	}

	@RequestMapping("/newsContent.do")
	@ResponseBody
	public String getContent(String id ){
		return newsService.findById(id).getContent();
	}

	/**
	 * 判断栏目是否存在子栏目
	 * @param id
	 * @return
	 */
	@RequestMapping("/hasChild.do")
	@ResponseBody
	public Boolean hasChild(Integer id){
		return menuService.childrenOfColumn(id).size() != 0;
	}

	/**
	 * 判断栏目是否存在内容（比如新闻）
	 * @param id
	 * @return
	 */
	@RequestMapping("/hasNews.do")
	@ResponseBody
	public Boolean hasNews(Integer id){
		return newsService.newsOfType(id).size() != 0;
	}
}
