/*
 * UserController.java
 * Version: 1.0
 * Copyright 2017 by 上海大学出版社
 * ALL Rights Reserved.
*/
package cn.com.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import cn.com.common.sensitive.SensitivewordFilter;
import cn.com.domain.Links;
import cn.com.service.ILinksService;
import cn.com.vo.PageResults;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import cn.com.domain.Message;
import cn.com.domain.User;
import cn.com.service.IMessageService;
import cn.com.utils.DateUtils;
import cn.com.utils.SessionUtils;
import cn.com.utils.SpringContextHolder;
import org.springframework.web.servlet.ModelAndView;

/**
 * 留言管理相关控制类
 * @author 柏贵雷　2017/09/13
*/

@Controller
@RequestMapping("/message")
public class MessageController {
	
	private int id=0;
	
	private int id2=0;
	
	@Resource(name="messageService")
	private IMessageService messageService;

	@Resource(name = "linksService")
	private ILinksService linksService;
	
	@RequestMapping("/saveMessage.do")
	public @ResponseBody void saveMessage(HttpServletRequest request){
		User user=SessionUtils.getSysUserFromSession(request);
		String Personmessage=request.getParameter("message");
		String type=request.getParameter("type");
		Message message=new Message();
		if(type!=null){
			message.setUserName("匿名用户");
		}else{
			message.setUserName(user.getUserName());
		}
		message.setType("群聊");
		message.setCreateTime(DateUtils.getNowDate());
		message.setUserId(user.getId());
		message.setToPerson("所有");
		message.setMessage(Personmessage);
		
		((IMessageService) SpringContextHolder.getBean("messageService")).saveMessage(message);
	}
	
	@RequestMapping("/getOthersMessage.do")
	public @ResponseBody Message getOthersMessage(HttpServletRequest request){
		User user=SessionUtils.getSysUserFromSession(request);
		Message message=this.messageService.getMessageByUserId(user.getId());
		if(message!=null&&message.getId()>id){
			id=message.getId();
			return message;
		}
		return null;
	}
	
	@RequestMapping("/savePrivilegeChatMessage.do")
	public @ResponseBody void savePrivilegeChatMessage(HttpServletRequest request) throws UnsupportedEncodingException{
		request.setCharacterEncoding("utf-8");
		User user=SessionUtils.getSysUserFromSession(request);
		Message message=new Message();
		String username=request.getParameter("username");
		String privilegeMessage=request.getParameter("message");
		message.setMessage(privilegeMessage);
		message.setToPerson(username);
		message.setUserId(user.getId());
		message.setType("私聊");
		message.setUserName(user.getUserName());
		message.setCreateTime(DateUtils.getNowDate());
		((IMessageService) SpringContextHolder.getBean("messageService")).saveMessage(message);
	}
	
	@RequestMapping("/getOtherToYouPrivilegeMessage.do")
	public @ResponseBody Message getOtherToYouPrivilegeMessage(HttpServletRequest request){
		User user=SessionUtils.getSysUserFromSession(request);
		Message message=((IMessageService) SpringContextHolder.getBean("messageService")).getOtherToYouPrivilegeMessage(user.getUserName());
		if(message!=null&&message.getId()>id2){
			id2=message.getId();
			return message;
		}
		return null;
	}

	@RequestMapping("/save.do")
	public
	@ResponseBody
	String saveWords(@RequestParam("list0")String name,@RequestParam("list1")String tel,@RequestParam("list2")String words,HttpServletRequest req){
		User user=SessionUtils.getSysUserFromSession(req);
		if (null==user){
			return "请先登录";
		}
		try {
			name=URLDecoder.decode(name, "utf-8");
			tel=URLDecoder.decode(tel, "utf-8");
			words=URLDecoder.decode(words, "utf-8");
		}catch (UnsupportedEncodingException e) {
			return "您输入的信息不和规范，亲检查您的输入或者浏览器设置";
		}
		Message message=new Message();
		message.setMessage(words);
		message.setTel(tel);
		message.setUserId(user.getId());
		message.setUserName(name);
		message.setReplyId(0);
		messageService.insertReply(message);
		return "留言成功！";
	}


	/**
	 * =============================================================================
	 *
	 *                                 后台
	 *
	 * ===========================================================================
	 */

	/**
     * 后台留言内容回复页
     */
	@RequestMapping("/messageReplay.do")
	public ModelAndView messageReplay(@RequestParam("id")Integer id){
		ModelAndView mav=new ModelAndView("admin/message/messageReplay");
		mav.addObject("message",messageService.getMessageById(id));
		mav.addObject("replays",messageService.getMessageReplay(id));
		return mav;
	}

	@RequestMapping("/list.do")
	public ModelAndView getAdminMessageByPage(@RequestParam(defaultValue = "1") Integer page,
											  @RequestParam(required = false) String authority,HttpServletRequest request){
		ModelAndView mav = new ModelAndView("/admin/message/mainMessage");
		mav.addObject("messages",messageService.getAdminMessageByPage(page));
		if(authority!=null){
			request.getSession().setAttribute("authority",authority);
		}
		return mav;
	}

	@RequestMapping("/messageInfo.do")
	public ModelAndView getMessageInfo(@RequestParam(defaultValue = "0")Integer id){
		ModelAndView mav=new ModelAndView("/admin/message/messageInfo");
		if (id==0){
			mav.addObject("message",new Message());
			mav.addObject("msg","留言不存在");
			return mav;
		}
		mav.addObject("message",messageService.getMessageById(id));
		return mav;
	}

	@RequestMapping("/delete.do")
	public String deleteMessage(@RequestParam(defaultValue = "0") Integer id,@RequestParam(defaultValue = "0")Integer replyId){
		if (id!=0) {
			messageService.logicDelete(id);
		}
		if (replyId!=0) {
			return "redirect:/message/messageReplay.do?id="+replyId.toString();

		}else {
			return "redirect:/message/list.do";
		}
	}

	@RequestMapping("/changeShow.do")
	public String changeSHow(@RequestParam(defaultValue = "0") Integer id){
		if (id!=0) {
			messageService.changeShow(id);
		}
		return "redirect:/message/list.do";
	}

	@RequestMapping(value = "/reply.do",method = RequestMethod.POST)
	public String addReply(Message message){
		String messagea="";
		message.setCreateTime(new Date(System.currentTimeMillis()));
		message.setIsDelete("0");
		if(null!=message.getMessage()){
			SensitivewordFilter Filter=new SensitivewordFilter();
			message.setMessage(Filter.replaceSensitiveWord(message.getMessage(),1,"*"));
		}
		messageService.insertReply(message);
		return "redirect:/message/messageReplay.do?id="+message.getReplyId().toString();
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
