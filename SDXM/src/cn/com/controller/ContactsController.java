package cn.com.controller;

import cn.com.common.BehaviourLogService;
import cn.com.domain.Contacts;
import cn.com.domain.Links;
import cn.com.domain.User;
import cn.com.service.IContactsService;
import cn.com.service.ILinksService;
import cn.com.utils.SessionUtils;
import cn.com.vo.PageResults;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * 互动相关管理类
 */
@Controller
@RequestMapping("contacts")
public class ContactsController {
    @Resource(name = "contactsService")
    private IContactsService contactsService;

    @Autowired
    private BehaviourLogService bs;

    @Resource(name = "linksService")
    private ILinksService linksService;
    /**
     *互动留言
     */
    @RequestMapping(value = "/submit_contacts.do",method = RequestMethod.POST)
    @ResponseBody
    public ModelAndView Contact(@ModelAttribute Contacts contacts, HttpServletRequest req) throws Exception{
//        contactsService.saveContacts(contacts);
        ModelAndView modelAndView = new ModelAndView("website/contactus");
        //行为记录
        User user= SessionUtils.getSysUserFromSession(req);
//
//        String flag =(String) req.getSession().getAttribute("flag");
//        String f = req.getParameter("flag");
//        if(f.equals(flag)){
            contactsService.saveContacts(contacts);
            modelAndView.addObject("message","提交成功！");
            if(user!=null){
                bs.log(user.getUserName(), "互动专区，提交成功");
            }else{
                bs.log("游客", "互动专区，提交成功");
            }
//            req.getSession().removeAttribute("flag");
//        }
//        else{
//            req.getSession().removeAttribute("flag");
            modelAndView.addObject("message","成功");
//        }

        return modelAndView;
    }
    /**
     * =============================================================================
     *
     *                                 后台
     *
     * ===========================================================================
     */
    @RequestMapping("/list.do")
    public ModelAndView getAdminContactsByPage(@RequestParam(defaultValue = "1") Integer page,
                                               @RequestParam(required = false) String authority,HttpServletRequest request){
        ModelAndView mav = new ModelAndView("/admin/contacts/mainContacts");
        mav.addObject("contacts",contactsService.getAdminContactsByPage(page));
        mav.addObject("page",page);
        if(authority!=null){
            request.getSession().setAttribute("authority",authority);
        }
        return mav;
    }

    @RequestMapping("/contactsInfo.do")
    public ModelAndView getContactInfo(@RequestParam(defaultValue = "0")Integer id,@RequestParam(defaultValue = "1") Integer page){
        ModelAndView mav=new ModelAndView("/admin/contacts/contactsInfo");
        if (id==0){
            mav.addObject("contacts",new Contacts());
            mav.addObject("con","留言不存在");
            return mav;
        }
        mav.addObject("page", page);
        mav.addObject("contacts",contactsService.getContactById(id));
        return mav;
    }

    @RequestMapping("/delete.do")
    public String deleteContact(@RequestParam(defaultValue = "0") Integer id){
        if (id != 0) {
            contactsService.deleteContacts(id);
            return "redirect:/contacts/list.do";
        }
        else {
            return "redirect:/contacts/list.do";
        }
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
