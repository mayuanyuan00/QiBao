package cn.com.controller.admin;

import cn.com.common.FileManager;

import cn.com.domain.Book;
import cn.com.domain.Links;
import cn.com.service.IBookService;
import cn.com.service.ILinksService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/links")
public class LinksController {
    @Resource(name = "linksService")
    private ILinksService linksService;
    @Resource(name = "bookService")
    private IBookService bookService;
    /**
     * ======================================
     *                  后台
     * ======================================
     */
    /**
     * 显示连接列表
     *
     * @param key  有key为搜索
     * @param page 页码
     * @return
     * @throws Exception
     */
    @RequestMapping("/list.do")
    public ModelAndView bookList(
            @RequestParam(required = false) String authority,
            HttpServletRequest request,
            @RequestParam(required = false) String key,
            @RequestParam(defaultValue = "1") int page) throws Exception {
        ModelAndView modelAndView = new ModelAndView("admin/links/linksList");
        if (!StringUtils.isEmpty(key)) key = URLDecoder.decode(key.replaceAll("\\.", "%"), "utf-8");
        if (key == null || key.trim().equals("")) {
            modelAndView.addObject("links", linksService.getLinksByPage(page));
        } else {
            modelAndView.addObject("links", linksService.searchLinksDetail(key, page));
            modelAndView.addObject("searchKey", key);
        }
        if(authority!=null){
            request.getSession().setAttribute("authority",authority);
        }
        return modelAndView;
    }

    /**
     * 新增或修改连接页面
     *
     * @param  id ,为空则为新增连接
     * @return
     */
    @RequestMapping("/linksInfo.do")
    public ModelAndView info(@RequestParam(required = false) Integer id) {
        ModelAndView mav = new ModelAndView("admin/links/linksInfo");
        String msg = "";
        if (id != null) {
            Links links = linksService.selectLinks(id);
            if (links == null) {
                msg = "连接不存在";
            } else {
                mav.addObject("links", links);
            }
        }
        mav.addObject("msg", msg);
        return mav;
    }

    /**
     * 插入或者更新连接信息
     *
     * @param links
     * @return
     */
    @RequestMapping("/upset.do")
    @ResponseBody
    public String upsert(@ModelAttribute Links links, HttpServletRequest request,
                         @RequestParam(value = "image", required = false) MultipartFile file) {
        if (file != null && file.getSize() > 0) {
            String storeDirectoryRel = "/image/links/";
            String storeDirectoryAbs = request.getSession().getServletContext().getRealPath(storeDirectoryRel);
            try {
                String newFilename = FileManager.saveFile(file, storeDirectoryAbs);
                links.setImgsrc(storeDirectoryRel + newFilename);
            } catch (IOException e) {
                return "ERROR";
            }
        }
        if (links.getId() == null) {//插入
            linksService.saveLinks(links);
        } else {
            linksService.updateLinks(links);
        }
        return "SUCCESS";
    }



    @RequestMapping("/del.do")
    public String delete(int id) {
        linksService.logicDeleteLinks(id);
        return "redirect:/links/list.do";
    }




}
