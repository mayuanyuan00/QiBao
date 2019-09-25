/*
 * UserController.java
 * Version: 1.0
 * Copyright 2017 by 上海大学出版社
 * ALL Rights Reserved.
*/
package cn.com.controller.admin;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.com.domain.Menu;
import cn.com.domain.Usergroup;
import cn.com.utils.Json2Object;
import cn.com.utils.SessionUtils;
import cn.com.vo.AuthorityVO;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import cn.com.domain.User;
import cn.com.service.IUserService;

import cn.com.utils.AESUtil;

/**
 * 后台用户相关控制类
 *
 * @author 柏贵雷　2017/09/13
 */

@Controller
@RequestMapping("/adminUser")
public class AdminUserController {
    /**
     * service接口定义
     */
    @Resource(name = "userService")
    private IUserService userService;
    private String key = "1031";
//    private String key = "1031";

    @RequestMapping("/userList.do")
    public ModelAndView userList(@RequestParam(defaultValue = "1") int page, HttpServletRequest request,
                                 @RequestParam(required = false) String authority) throws Exception {
        ModelAndView mav = new ModelAndView("admin/user/userList");
        String group = request.getParameter("group");
        if (group == null) {
            mav.addObject("user", userService.getUserOfPage(page));
            mav.addObject("msg", "admin");
        } else {
            mav.addObject("user", userService.getGroupUserOfPage(page, group));
            mav.addObject("msg", "user");
        }
        if(authority!=null){
            request.getSession().setAttribute("authority",authority);
        }
        return mav;
    }

    @RequestMapping("/userInfo.do")
    public ModelAndView info(@RequestParam("op") Integer op, @RequestParam(required = false, value = "id") Integer id, HttpServletRequest request) throws Exception {
        ModelAndView mav = new ModelAndView("admin/user/userInfo");
        request.getSession().setAttribute("op", op);
        request.getSession().setAttribute("id", id);
        request.setAttribute("meunList", userService.findAllAuthority());
        request.getSession().setAttribute("level", "-1");
        if (id != null) {
            List<AuthorityVO> groupList = userService.selectByid(id);
            User user = userService.findUserById(id);
            request.setAttribute("groupList", groupList);
            request.getSession().setAttribute("userName",user.getUserName());
            request.getSession().setAttribute("level", user.getGroupCode());
        }
        return mav;
    }

    /**
     * 新增用户
     *
     * @param username
     * @param password
     * @param level
     * @return
     * @throws Exception
     */
    @RequestMapping("/userSave.do")
    @ResponseBody
    public String saveUser(@RequestParam("name") String username, @RequestParam("password") String password,
                           @RequestParam("level") String level, @RequestParam("authority") String authority) throws Exception {
        String encodedPassword = AESUtil.encode(password, key);
        User user = new User();
        user.setUserName(username);
        user.setPassword(encodedPassword);
        user.setCreateDate(new Date());
        user.setIsDelete("0");
        user.setGroupCode(level);
        int id = userService.saveUser(user);
        if(!"{}".equals(authority)){
            Map<String, Object> map = Json2Object.jsonToMap(authority);
            for (String menu : map.keySet()) {
                userService.addAuthority(new Usergroup(Integer.parseInt(menu), map.get(menu).toString(), id));
            }
        }
        return "/adminUser/userList.do";
    }

    @RequestMapping("/userUpdate.do")
    @ResponseBody
    public String update(@RequestParam("id") Integer id, @RequestParam("level") String level,@RequestParam("password")String password,
                         HttpServletRequest request, @RequestParam("authority") String authority) throws Exception {
        if(!"{}".equals(authority)){
            Map<String, Object> map = Json2Object.jsonToMap(authority);
            userService.deleteByUser(id);
            for (String menu : map.keySet()) {
                userService.addAuthority(new Usergroup(Integer.parseInt(menu), map.get(menu).toString(), id));
            }
        }
        User user = userService.findUserById(id);
        if(!"".equals(password.trim())){
            String encodedPassword = AESUtil.encode(password, key);
            if (password != null && !"".equals(password)) {
                user.setPassword(encodedPassword);
            }
        }
        user.setCreateDate(new Date());
        user.setIsDelete("0");
        user.setGroupCode(level);
        userService.updateUser(user);
        if ("3".equals(level)) {
            return "/adminUser/userList.do?group=3";
        }
        return "/adminUser/userList.do";

    }

    @RequestMapping("userDelete.do")
    public String delete(@RequestParam("uid") Integer id) throws Exception {
        User user = userService.findUserById(id);
        user.setIsDelete("1");
        userService.updateUser(user);
        userService.deleteByUser(id);
        if ("3".equals(user.getGroupCode())) {
            return "redirect:/adminUser/userList.do?group=3";
        }
        return "redirect:/adminUser/userList.do";
    }

    @RequestMapping("userSearch.do")
    public ModelAndView search(@RequestParam(defaultValue = "1") int page, @RequestParam("name") String name, HttpServletRequest request) throws Exception {
        String group = request.getParameter("group");
        ModelAndView modelAndView = new ModelAndView("admin/user/userList");
        if (name == null) {
            return modelAndView;
        }
        modelAndView.addObject("user", userService.getSearchUserOfPage(page, name, group));
        if (group != null) {
            modelAndView.addObject("msg", "user");
        } else {
            modelAndView.addObject("msg", "admin");
        }
        return modelAndView;
    }


    @RequestMapping("userCheck.do")
    @ResponseBody
    public String userCheck(@RequestParam("name") String name,@RequestParam(required = false)String groupCode) {
        if(groupCode == null){
            groupCode = "-1";
        }
        List<User> list = userService.findUserByName(name,groupCode);
        String string = new String();
        if (list.isEmpty()) {
            string = "success";
            return string;
        }
        return string;
    }

    @RequestMapping("/loginAdmin.do")
    public String loginAdmin(User user, HttpServletRequest request) {
        String encodedPassword = AESUtil.encode(user.getPassword(), key);
        user.setPassword(encodedPassword);
        User _user = this.userService.checkUser(user,"-1");
        if ("admin".equals(request.getParameter("loginType"))) {
            if (_user != null && Integer.parseInt(_user.getGroupCode()) != 3) {
                request.getSession().setAttribute("ip", request.getRemoteAddr());
                request.getSession().setAttribute("count", this.userService.getAllAdminUser().size());
                List<User> list = this.userService.getAllOnLineUser();
                request.setAttribute("OnlineUsers", list);
                request.getSession().setAttribute("adminUser", _user);
                //request.setAttribute("User", _user);
                String path = request.getSession().getServletContext().getRealPath("/");
                request.setAttribute("contextPath", path);
                return "/admin/index";
            } else {
                request.setAttribute("error", "error");
                return "admin/login";
            }
        } else {
            request.setAttribute("error", "error");
            return "website/login";
        }
    }

    /**
     * 管理用户注销
     *
     * @return
     */
    @RequestMapping("/logout.do")
    public String logout(HttpServletRequest request, HttpServletResponse response) {
        User user = SessionUtils.getSysUserFromSession(request);
        this.userService.loginout(user);
        request.getSession().removeAttribute("adminUser");
        return "admin/login";
    }

    @RequestMapping("ColumnCheck.do")
    @ResponseBody
    public String ColumnCheck(@RequestParam(value = "name",required = false) String name,
                              @RequestParam(value = "url",required = false) String url) {
        List<Menu> list = new ArrayList<>();
        if(name!=null){
             list= userService.selectByName(name);
        }
        if(url!=null){
            list = userService.selectByUrl(url);
        }
        String string = new String();
        if (list.isEmpty()) {
            string = "success";
            return string;
        }
        return string;
    }

    @RequestMapping("selectColumn.do")
    public String selectColumn(@RequestParam String name,HttpServletRequest request) {
        List<Menu> list = userService.selectByName(name);
        request.setAttribute("menuList",list);
        return "/admin/column/columnlist";
    }

    @RequestMapping("addColumn.do")
    public String addColumn(@RequestParam String name,@RequestParam String groupcode,@RequestParam String url) {
        userService.addColumn(new Menu(name,groupcode,url));
        return "redirect:/user/column.do";
    }

    @RequestMapping("columnDelete.do")
    public String columnDelete(@RequestParam int id){
        userService.deleteColumn(id);
        return "redirect:/user/column.do";
    }
}
