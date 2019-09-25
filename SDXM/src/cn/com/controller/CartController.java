package cn.com.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import cn.com.domain.Links;
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
import cn.com.domain.Book;
import cn.com.domain.Cart;
import cn.com.domain.User;
import cn.com.service.IBookService;
import cn.com.service.ICartService;
import cn.com.vo.CartInfo;

/**
 * 购物车Controller<br>
 * 
 * @author 常东旭/张炜婕
 */
@Controller
@RequestMapping("cart")
public class CartController {

	@Autowired
	private ICartService cartService;
	
	@Autowired
	private IBookService bookService;

	@Resource(name = "linksService")
	private ILinksService linksService;
	
	
	/**
	 * 添加购物车,更新购物车接口<br>
	 * TODO 用户登录后需要加载购物车信息到session中
	 * 
	 * @return
	 */
	@RequestMapping("add.do")
	public @ResponseBody String add(HttpSession session, Integer itemid, Integer amount) {
		// 登录确认(交给过滤器)
//		if (check_login(session)) {
//		}
		int userid = getUserId(session);
		Map<Integer, Cart> cart = (Map<Integer, Cart>) session.getAttribute(Constants.SESSION.CARTINFO);
		// 确保session有cart
		if (cart == null) {
			cart = new HashMap<Integer, Cart>();
		}
		// itemid 和 amount 需要check

		//amount = amount + (cart.get(itemid) == null ? 0:cart.get(itemid).getAmount());
		if (check_add(itemid, amount)) {
			if(cart.get(itemid)!=null){
				cart.remove(itemid);
			}
			Cart ct = new Cart(userid, itemid, amount);
			cart.put(itemid, ct);
			session.setAttribute(Constants.SESSION.CARTINFO, cart);
			//  调用service 存储进入数据库
			cartService.refreshCart(cart, userid);
		}
		return "success";
	}

	/**
	 * itemid 和 amount 需要check<br>
	 * TODO 1)itemid 是否合法(库存中是否存在这么一个item) 
	 * TODO 2)amount 是否合法(存量是否足够)
	 * 
	 * @param itemid
	 * @param amount
	 * @return
	 */
	private boolean check_add(Integer itemid, Integer amount) {
		// FIXME 校验逻辑添加 暂不实现
		return true;
	}
	
	private boolean check_login(HttpSession session){
		// 是否登录校验（交给过滤器）
		return true;
	}
	
	private Integer getUserId(HttpSession session){
		//获取用户id
		User us = (User) session.getAttribute("user");
		return us.getId();
	}

	/**
	 * 从购物车移除
	 * 
	 * @return
	 */
	@RequestMapping("remove.do")
	public @ResponseBody String remove(HttpSession session, Integer itemid) {
		// 登录确认(交给过滤器)
//		if (check_login(session)) {
//			
//		}
		int userid = getUserId(session);

		Map<Integer, Cart> cart = (Map<Integer, Cart>) session.getAttribute(Constants.SESSION.CARTINFO);
		// 确保session有cart
		if (cart != null) {
			cart.remove(itemid);
			//调用service 存储进入数据库
			cartService.refreshCart(cart, userid);
		}
		return "success";
	}

	/**
	 * 获取购物车详情
	 * 
	 * @return
	 */
	@RequestMapping("detail.do")
	public @ResponseBody String detail(HttpSession session) {
		//  登录确认(交给拦截器)
//		if (check_login(session)) {
//			
//		}
		int userid = getUserId(session);
		//暂时不从session取
//		Map<Integer, Cart> cart = (Map<Integer, Cart>) session.getAttribute(Constants.SESSION.CARTINFO);
		// 调用service 查购物车信息 把购物车信息更新到session
		Map<Integer, Cart> cart = cartService.getCartDetail(userid);
		session.setAttribute(Constants.SESSION.CARTINFO, cart);
		Gson gson = new Gson();
		return gson.toJson(cart);
	}
	
	/**
	 * 获取购物车详情(含商品信息)
	 * 
	 * @return
	 */
	@RequestMapping("detail2.do")
	public @ResponseBody String detail2(HttpSession session) {
		//  登录确认(交给拦截器)
//		if (check_login(session)) {
//			
//		}
		int userid = getUserId(session);
		//暂时不从session取
//		Map<Integer, Cart> cart = (Map<Integer, Cart>) session.getAttribute(Constants.SESSION.CARTINFO);
		// 调用service 查购物车信息 把购物车信息更新到session
		Map<Integer, Cart> cart = cartService.getCartDetail(userid);
		session.setAttribute(Constants.SESSION.CARTINFO, cart);
		ArrayList<CartInfo> re = new ArrayList<>();
		for (Integer in : cart.keySet()) {
			Cart tCart = cart.get(in);
			Book b = bookService.findBookById(in);
			re.add(new CartInfo(b, tCart.getAmount()));
		}
		Gson gson = new Gson();
		return gson.toJson(re);
	}
	
	@RequestMapping("shoppingcart.do")
	public String shoppingCart(HttpServletRequest request,HttpSession session) {
		//  登录确认(交给拦截器)
//		if (check_login(session)) {
//			
//		}
		int userid = getUserId(session);
		//暂时不从session取
//		Map<Integer, Cart> cart = (Map<Integer, Cart>) session.getAttribute(Constants.SESSION.CARTINFO);
		// 调用service 查购物车信息 把购物车信息更新到session
		Map<Integer, Cart> cart = cartService.getCartDetail(userid);
		session.setAttribute(Constants.SESSION.CARTINFO, cart);
		ArrayList<CartInfo> re = new ArrayList<>();
		for (Integer in : cart.keySet()) {
			Cart tCart = cart.get(in);
			Book b = bookService.findBookById(in);
			re.add(new CartInfo(b, tCart.getAmount()));
		}
		request.setAttribute("cart", re);
		return "website/shopping_cart";
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
