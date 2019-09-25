package cn.com.controller.admin;

import cn.com.common.FileManager;
import cn.com.domain.Resource;
import cn.com.service.IResourceService;
import cn.com.utils.PropertiesUtil;
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

@Controller
@RequestMapping("/resource")
public class ResourcesController {
    @javax.annotation.Resource(name = "resourcesService")
    private IResourceService resourceService;


    @Autowired
    private PropertiesUtil propertiesUtil;
    /**
     * ======================================
     *                  后台
     * ======================================
     */
    /**
     * 显示资源列表
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
        ModelAndView modelAndView = new ModelAndView("admin/resources/resourcesList");
        if (!StringUtils.isEmpty(key)) key = URLDecoder.decode(key.replaceAll("\\.", "%"), "utf-8");
        if (key == null || key.trim().equals("")) {
            modelAndView.addObject("resources", resourceService.getResourcesByPage(page));
        } else {
            modelAndView.addObject("resources", resourceService.searchResourceDetail(key, page));
            modelAndView.addObject("searchKey", key);
        }
        if(authority!=null){
            request.getSession().setAttribute("authority",authority);
        }
        return modelAndView;
    }

    /**
     * 新增或修改资源页面
     *
     * @param  id ,为空则为新增资源
     * @return
     */
    @RequestMapping("/resourceInfo.do")
    public ModelAndView info(@RequestParam(required = false) Integer id) {
        ModelAndView mav = new ModelAndView("admin/resources/resourcesInfo");
        String msg = "";
        if (id != null) {
            cn.com.domain.Resource resource = resourceService.selectResources(id);
            if (resource == null) {
                msg = "资源不存在";
            } else {
                mav.addObject("resources", resource);
            }
        }
        mav.addObject("msg", msg);
        return mav;
    }

    /**
     * 插入或者更新资源信息
     *
     * @param resource
     * @return
     */
    @RequestMapping("/upset.do")
    @ResponseBody
    public String upset(@ModelAttribute Resource resource, HttpServletRequest request,
                         @RequestParam(value = "excel", required = false) MultipartFile file) {
        if (file != null && file.getSize() > 0) {
            String storeDirectoryRel = "/upload/";
            String storeDirectoryAbs = propertiesUtil.getProperty("upload.path.base")+storeDirectoryRel;
            try {
                String newFilename = FileManager.saveFile(file, storeDirectoryAbs);
                resource.setResourceUrl(storeDirectoryRel + newFilename);
            } catch (IOException e) {
                return "ERROR";
            }
        }
        if (resource.getId() == null) {//插入
            resourceService.saveResource(resource);
        } else {
            resourceService.updateResource(resource);
        }
        return "SUCCESS";
    }

    /**
     * 资源删除
     * @param id
     * @return
     */
    @RequestMapping("/del.do")
    public String delete(int id) {
        resourceService.deleteResource(id);
        return "redirect:/resource/list.do";
    }

    /**
     * 修改发布状态
     * @param id 资源id
     * @param rel 资源修改到的发布状态
     * @return
     */

    @RequestMapping("/updateRel.do")
    public String updateRel(@RequestParam Integer id,@RequestParam String rel){
        resourceService.updateRel(id,rel);
        return "redirect:/resource/list.do";
    }


    /**
     * 资源下载
     * @param id
     * @param response
     */
   @RequestMapping("/down.do")
    public void download(int id,HttpServletResponse response){
       String path = resourceService.selectResources(id).getResourceUrl();
       path=propertiesUtil.getProperty("upload.path.base")+path;
       response.reset();
       try {
           // path是指欲下载的文件的路径。
           File file = new File(path);
           //
           if (!file.exists()) {
               response.sendError(404, "file not found!");
               return;
           }
           // 取得文件名。
           String filename = file.getName();
           // 取得文件的后缀名。
           String ext = filename.substring(filename.lastIndexOf(".") + 1).toUpperCase();

           // 以流的形式下载文件。
           InputStream fis = new BufferedInputStream(new FileInputStream(path));
           byte[] buffer = new byte[fis.available()];
           fis.read(buffer);
           fis.close();
           // 清空response
           response.reset();
           // 设置response的Header
           response.addHeader("Content-Disposition", "attachment;filename=" + new String(filename.getBytes("UTF-8"), "iso-8859-1"));
           response.addHeader("Content-Length", "" + file.length());
           OutputStream toClient = new BufferedOutputStream(response.getOutputStream());
           response.setContentType("application/octet-stream");
           toClient.write(buffer);
           toClient.flush();
           toClient.close();
       } catch (IOException ex) {
           ex.printStackTrace();
       }
   }


}
