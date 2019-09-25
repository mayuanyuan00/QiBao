/*
 * UserController.java
 * Version: 1.0
 * Copyright 2017 by 上海大学出版社
 * ALL Rights Reserved.
*/
package cn.com.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.text.SimpleDateFormat;

import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.*;

import cn.com.common.*;
import cn.com.domain.Menu;
import cn.com.domain.ShippingAddress;
import cn.com.service.IChartService;
import cn.com.service.IShippingAddressService;
import cn.com.utils.AESUtil;
import cn.com.vo.AuthorityVO;
import cn.com.vo.Charts;
import com.google.gson.Gson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.com.domain.User;
import cn.com.service.IUserService;
import cn.com.utils.RandomStringUtil;
import cn.com.utils.SaveImageFile;
import cn.com.utils.SessionUtils;
import cn.com.utils.senders.SNSSender;
import org.springframework.web.multipart.MultipartFile;

/**
 * 用户相关控制类
 *
 * @author 柏贵雷 2017/09/13
 * @author 张炜婕 2017-09-27 修改
 * @author 常东旭 2017-09-27 重构
 */

@Controller
@RequestMapping("/user")
public class UserController {

    /**
     * service接口定义
     */
    @Resource(name = "userService")
    private IUserService userService;

    @Resource(name = "chartService")
    private IChartService chartService;

    @Resource(name = "shippingAddressService")
    private IShippingAddressService shippingAddressService;

    private String key = "1031";
    private AESUtil aesUtil;

    @Autowired
    private BehaviourLogService bs;

    @Autowired
    private SNSSender snsSender;

    // 用户和Session绑定关系
    public static final Map<String, HttpSession> USR_SESSION = new HashMap<String, HttpSession>();

    @RequestMapping("/toLogin.do")
    public String toLogin() throws Exception {
        return "website/login";
    }

    @RequestMapping("/top.do")
    public String top() throws Exception {
        return "admin/top";
    }

    @RequestMapping("/bottom.do")
    public String bottom() throws Exception {
        return "admin/bottom";
    }

    @RequestMapping("/left.do")
    public String left(HttpServletRequest request) throws Exception {
        User _user = (User)request.getSession().getAttribute("adminUser");
        if(Integer.parseInt(_user.getGroupCode()) != 0){
            List<AuthorityVO> voList = userService.selectByid(_user.getId());
            request.setAttribute("voList", voList);
        }
        request.setAttribute("meunList", userService.findAllAuthority());
        return "admin/left";
    }

    @RequestMapping("/swich.do")
    public String swich() throws Exception {
        return "admin/swich";
    }

    @RequestMapping("/main.do")
    public String main() throws Exception {
        return "admin/main";
    }

    @RequestMapping("/column.do")
    public String column(HttpServletRequest request) throws Exception {
        request.setAttribute("menuList", userService.findAllAuthority());
        return "admin/column/columnlist";
    }

    @RequestMapping("/addColumn.do")
    public String addColumn() throws Exception {
        return "admin/column/columnInfo";
    }

    @RequestMapping("/toAdminLogin.do")
    public String toAdminLogin() {
        return "admin/login";
    }

    @RequestMapping("/chart.do")
    public String charts(@RequestParam(required = false) String authority,HttpServletRequest request) {
        if(authority!=null){
            request.getSession().setAttribute("authority",authority);
        }
        return "admin/chart";
    }

    /**
     * 注册
     */
    @RequestMapping("/register.do")
    public @ResponseBody
    String register(HttpServletRequest request, HttpSession session) throws Exception {
        //  验证码已在前端验证
//        if (verifycode == null) {
//            return "verifycode";
//        }
//        if (!verifycode.equalsIgnoreCase((String) session.getAttribute(Constants.SESSION.VERIFYCODE))) {
//            return "verifycode";
//        }
        User user = new User();
        SaveImageFile.save(request, user);
        request.getSession().setAttribute("user", user);
        user.setStatus("0");
        this.userService.saveUser(user);
        return "success";
    }

    /**
     * 校验邮箱或电话是否重复
     *
     * @return
     */
    @RequestMapping("/checkrepeat.do")
    public @ResponseBody
    String checkRepeat(String content) {
        if (userService.checkRepeat(content)) {
            return "success";
        }
        return "repeat";
    }

    @RequestMapping("/captcha.do")
    public @ResponseBody
    String sendCaptcha(HttpServletRequest request, String tel) {
        // 校验重复次数,一分钟之内只能发送一次
        Long timeout = (Long) request.getSession().getAttribute(Constants.SESSION.CAPTCHATIMEOUT);
        if (timeout == null || timeout - (new Date()).getTime() >= 60 * 1000) {
            String random = RandomStringUtil.getRandomCode(4, 0);
            snsSender.send(tel, random, "5");
            request.getSession().setAttribute(Constants.SESSION.CAPTCHA, random);
            request.getSession().setAttribute(Constants.SESSION.CAPTCHATEl, tel);
            request.getSession().setAttribute(Constants.SESSION.CAPTCHATIMEOUT, (new Date()).getTime());
            return "success";
        }
        return "wait";
    }


    @RequestMapping("/verifycode.do")
    public void verifyCode(HttpServletResponse response, HttpSession session) throws IOException {
        response.setHeader("Pragma", "No-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setDateHeader("Expires", 0);
        response.setContentType("image/jpeg");

        // 生成随机字串
        String verifyCode = VerifyCodeUtils.generateVerifyCode(4);
        // 删除以前的
        session.removeAttribute(Constants.SESSION.VERIFYCODE);
        session.setAttribute(Constants.SESSION.VERIFYCODE, verifyCode.toLowerCase());
        // 生成图片
        int w = 100, h = 30;
        VerifyCodeUtils.outputImage(w, h, response.getOutputStream(), verifyCode);
    }

    /**
     * 注册注销
     *
     * @return
     */
    @RequestMapping("/logout.do")
    public String logout(HttpServletRequest request, HttpServletResponse response) {

//		ServletContext sc = request.getSession().getServletContext();
//		sc.removeAttribute(username);
//		//删除Cookie
//		Cookie cookie = new Cookie(username,username);
//		cookie.setMaxAge(0);
//		response.addCookie(cookie);

        User user = SessionUtils.getSysUserFromSession(request);
        this.userService.loginout(user);
        request.getSession().removeAttribute("user");
        return "website/index";

    }

    @RequestMapping("/toRegister.do")
    public String toRegister() {
        return "website/register";
    }


    @RequestMapping("/login.do")
    public @ResponseBody
    String login(String username, String password, HttpServletRequest request) {
        String key = "1031";
        String encodedPassword = AESUtil.encode(password, key);
        User User = this.userService.checkUser(username, encodedPassword,"3");

        if (User != null && (Integer.parseInt(User.getGroupCode()) == 3)) {

            HttpSession lastSession = USR_SESSION.get(username);
            //if (lastSession != null) lastSession.invalidate();
            /*if (lastSession != null) lastSession.removeAttribute("user");*/
            USR_SESSION.put(username, request.getSession());

//			request.getSession().setAttribute("ip",request.getRemoteAddr());
//			request.getSession().setAttribute("count",this.userService.getAllAdminUser().size());
//			List<User> list = this.userService.getAllOnLineUser();
//			request.setAttribute("OnlineUsers", list);
            request.getSession().setAttribute("user", User);
//			request.setAttribute("User", User);
//			String path = request.getSession().getServletContext().getRealPath("/");
//			request.setAttribute("contextPath", path);

//			if (!"admin".equals(request.getParameter("loginType"))) {
//				return "/user/main";
//			} else {
//				return "/admin/index";
//			}
//				sc.setAttribute("user",User);
//				Cookie cookie = new Cookie("username",User.getUserName());
//				response.addCookie(cookie);
            //TODO 登录成功后向事件调度发送登录成功事件信息
            HashMap<String, Object> m = new HashMap<>();
            m.put(Constants.COMMONPARAM.HTTPSESSION, request.getSession());
            JobDispatcher.notify(Constants.EVENT.LOGIN, m);
            User.setStatus("1");
            userService.updateUser(User);
            return "success";
        } else {
//			request.setAttribute("error", "error");
//			if (!"admin".equals(request.getParameter("loginType"))) {
//				return "website/login";
//			} else {
//				return "admin/login";
//			}
            return "error";
        }
    }

    /**
     * 判断用户是否同时登陆同一个用户
     */
    @RequestMapping(value = "/checkUserOnline.do")
    @ResponseBody
    public void checkUserOnline(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        PrintWriter out = response.getWriter();
        out.print(session.getAttribute("msg"));
    }

    @RequestMapping("/getOnLineUser.do")
    public @ResponseBody
    List<User> getData() {
        List<User> list = this.userService.getAllOnLineUser();
        return list;
    }

    @RequestMapping("/getShippingAddress.do")
    public @ResponseBody
    ShippingAddress getShippingAddress(@RequestParam("id") Integer id) {
        ShippingAddress shippingAddress = shippingAddressService.findById(id);
        return shippingAddress;
    }

    @RequestMapping("/userCharts.do")
    @ResponseBody
    public String userCharts(@RequestParam String year) {
        if (year.equals("undefined")) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy");

            Date date = new Date();

            String formatDate = sdf.format(date);
            year = formatDate;
        }
        List<Charts> charts = chartService.getOderDetail(year);
        Gson gson = new Gson();
        return gson.toJson(charts);
    }

    @RequestMapping("/userUpdate.do")
    @ResponseBody
    public String userUpadate(@RequestParam("uid") int uid,
                              @RequestParam(value = "name",required = false) String name,
                              @RequestParam(value = "phone",required = false) String phone,
                              @RequestParam(value = "email",required = false) String email,
                              @RequestParam(value = "avatar_file_after",required = false) MultipartFile avatar,
                              HttpServletRequest request) throws Exception {
//		MultipartFile avatar = (MultipartFile) request.getAttribute("avatar_file_after");
        String avatarRel = "/images/avatar/";
        User user1 = (User) request.getSession().getAttribute("user");
        User user = userService.findUserById(uid);
        if (avatar != null && !avatar.isEmpty()) {
            if (avatar.getSize() < 1000000) {
                String avatarFileName = FileManager.saveFile(avatar, request.getSession().getServletContext().getRealPath(avatarRel), uid + "person.jpg");
                if (user1.getImageUrl() != null && !"".equals(user1.getImageUrl())) {
                    String oldPath = request.getSession().getServletContext().getRealPath(user1.getImageUrl());
                    File file = new File(oldPath);
                    file.delete();
                }
                user.setImageUrl(avatarRel + avatarFileName);
            } else {
                return "msg";
            }
        }
        if (phone != null && !"".equals(phone)) {
            user.setPhone(phone);
        }
        if (email != null && !"".equals(email)) {
            user.setEmail(email);
        }if(name !=null && !"".equals(name)){
            user.setUserName(name);
        }
        request.getSession().removeAttribute("user");
        request.getSession().setAttribute("user", user);
        userService.updateUser(user);
        //(User)request.getSession().getAttribute("user");
        //SaveImageFile.save(request,user);
        //request.setAttribute("_user",user);
        return "success";
    }

}
