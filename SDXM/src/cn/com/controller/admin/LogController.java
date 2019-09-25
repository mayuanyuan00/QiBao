package cn.com.controller.admin;

import cn.com.common.FileManager;
import cn.com.domain.Log;
import cn.com.domain.Resource;
import cn.com.service.ILogService;
import cn.com.service.IResourceService;
import cn.com.utils.PropertiesUtil;
import cn.com.vo.LogVO;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RequestMapping("/log")
public class LogController {
    @javax.annotation.Resource(name = "logService")
    private ILogService logService;


    @Autowired
    private PropertiesUtil propertiesUtil;
    /**
     * ======================================
     *                  后台
     * ======================================
     */
    /**
     * 显示日志列表
     *
     * @param key  有key为搜索条件
     * @param page 页码
     * @return
     * @throws Exception
     */
    @RequestMapping("/list.do")
    public ModelAndView resourceList(
            @RequestParam(required = false) String authority,
            HttpServletRequest request,
            @RequestParam(required = false) String key,
            @RequestParam(defaultValue = "1") int page) throws Exception {
        ModelAndView modelAndView = new ModelAndView("admin/log/logList");
        if (!StringUtils.isEmpty(key)) key = URLDecoder.decode(key.replaceAll("\\.", "%"), "utf-8");
        if (key == null || key.trim().equals("")) {
            modelAndView.addObject("log", logService.getLogsByPage(page));
        } else {
            modelAndView.addObject("log", logService.searchLogDetail(key, page));
            modelAndView.addObject("searchKey", key);
        }
        if(authority!=null){
            request.getSession().setAttribute("authority",authority);
        }
        return modelAndView;
    }

    /**
     * 资源删除
     * @param id
     * @return
     */
    @RequestMapping("/del.do")
    public String delete(String id) {
        logService.deleteLog(id);
        return "redirect:/log/list.do";
    }


}
