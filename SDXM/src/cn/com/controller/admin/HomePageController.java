package cn.com.controller.admin;

import cn.com.common.FileManager;
import cn.com.domain.Book;
import cn.com.domain.Recommend;
import cn.com.service.IBookService;
import cn.com.service.IRecommendService;
import cn.com.utils.JsonUtil;
import cn.com.utils.PropertiesUtil;
import cn.com.utils.SaveImageFile;
import cn.com.utils.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/home")
public class HomePageController {
    @Resource(name = "bookService")
    private IBookService bookService;
    @Resource(name = "recommendService")
    private IRecommendService recommendService;
    @Autowired
    private PropertiesUtil propertiesUtil;



    /**
     *=========================================================
     *                     首页维护
     * ======================================================
     */
    @RequestMapping("/imgUpload.do")
    public ModelAndView upload(@RequestParam(required = false) String authority,HttpServletRequest request){
        ModelAndView mav=new ModelAndView("admin/imageUpload");
        List<Book> allbook=bookService.getAllBooks();
        List<Book> books=new ArrayList<>();
        for (Book temp:allbook){
            Book book = new Book();
            book.setId(temp.getId());
            book.setBookName(temp.getBookName());
            book.setAuthor(temp.getAuthor());
            books.add(book);
        }
        List<Recommend> recommends=recommendService.getAllRecommend();
        mav.addObject("books",books);
        if (recommends.size()>0){
            mav.addObject("recommend",recommends);
        }
        if(authority!=null){
            request.getSession().setAttribute("authority",authority);
        }
        return mav;
    }

    @RequestMapping("/setHot.do")
    public
    @ResponseBody
    String setHotBook(@RequestParam("ids") String json,@RequestParam("words")String words,@RequestParam("id")Integer reId)
    {
        String[] id= json.split(",");
        for (String val1:id){
            Integer sum=0;
            for (String val2:id){
                if (val1.equals(val2)){
                    sum+=1;
                }
            }
            if (sum>1){
               return "请勿重复推荐图书";
            }
        }

        try {
            words = URLDecoder.decode(words, "utf-8");
        } catch (UnsupportedEncodingException e) {
            return "ERROR";
        }
        List<Recommend> recommends = new ArrayList<>();
        if (id.length>0){
            for (int i=0;i<id.length;i++){
                Recommend recommend=new Recommend();
                recommend.setId(i+1);
                recommend.setHotBook(Integer.parseInt(id[i]));
                recommend.setComment("");
                recommends.add(recommend);
            }
        }
        recommends.add(new Recommend(10,reId,words));
        recommendService.insertAll(recommends);
        return "成功";
    }

    @RequestMapping(value = "/setRecommend.do",method = RequestMethod.POST)
    public
    @ResponseBody
    String setHotBook(@RequestBody Recommend[] recommends)
    {
        List<Recommend> re=new ArrayList<>();
        for (Recommend recommend:recommends){
            Recommend temp=new Recommend();
            temp.setId(recommend.getId());
            temp.setHotBook(recommend.getHotBook());
            String words=recommend.getComment();
            String authorName=recommend.getAuthorName();
            try {
                words = URLDecoder.decode(words, "utf-8");
                authorName = URLDecoder.decode(authorName, "utf-8");

            } catch (UnsupportedEncodingException e) {
                return "ERROR";
            }
            temp.setComment(words);
            temp.setAuthorName(authorName);
            re.add(temp);
        }
        recommendService.insertAll(re);
        return "成功";
    }

    /**
     * 上传图片
     * @param file 图片文件
     * @param fileName 图片名字
     * @param request 请求
     * @return 上传结果信息
     */
    @RequestMapping(value = "/saveImages.do",method = RequestMethod.POST)
    public
    @ResponseBody
    String upload(@RequestParam MultipartFile file, @RequestParam("fileName")String fileName, HttpServletRequest request){

        fileName="useByHome"+fileName;
        if (file != null && file.getSize() > 0) {
            //获取配置路径
//            String storeDirectoryAbs = propertiesUtil.getProperty("upload.path.base");
//            if (StringUtils.isEmpty(directory)) return "系统错误";、
            //获取url路径
            String storeDirectoryRel = "/images/home/";
            String storeDirectoryAbs = request.getSession().getServletContext().getRealPath(storeDirectoryRel);
            String msg = FileManager.postImg(file, fileName,storeDirectoryAbs);
            return msg;
        }
        return "ERROR";
    }


    @RequestMapping(value = "/saveNewMedia.do",method = RequestMethod.POST)
    public @ResponseBody String uploadHomeNewMedia(@RequestParam MultipartFile file, HttpServletRequest request){
        if (file != null && file.getSize() > 0) {
            String storeDirectoryRel = "/images/home/";
            String storeDirectoryAbs = request.getSession().getServletContext().getRealPath(storeDirectoryRel);


            String filename = file.getOriginalFilename();
            String suffix = filename.substring(filename.lastIndexOf("."));
            File directory=new File(storeDirectoryAbs);
            if (!directory.exists()) {
                directory.mkdirs();
            }
            File deleteFile=new File(storeDirectoryAbs,"homenewsMedia.t");
            if (deleteFile.exists()){
                deleteFile.delete();
            }
            deleteFile=new File(storeDirectoryAbs,"homenewsMedia"+".mp4");
            if (deleteFile.exists()){
                deleteFile.delete();
            }
            String filePath=storeDirectoryAbs+File.separator+"homenewsMedia"+(".mp4".equalsIgnoreCase(suffix)?".mp4":".t");
            File newFile=new File(filePath);
            try {
                file.transferTo(newFile);
            } catch (IOException e) {
                e.printStackTrace();
                return "上传失败";
            }
            return "success";
        }
        return "ERROR";
    }

}
