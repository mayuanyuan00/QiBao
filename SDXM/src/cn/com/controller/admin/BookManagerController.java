/*
 * UserController.java
 * Version: 1.0
 * Copyright 2017 by 上海大学出版社
 * ALL Rights Reserved.
*/
package cn.com.controller.admin;

import cn.com.common.BehaviourLogService;
import cn.com.common.FileManager;
import cn.com.domain.Book;
import cn.com.domain.Booktype;
import cn.com.domain.ReleaseBook;
import cn.com.domain.User;
import cn.com.service.IBookContactsService;
import cn.com.service.IBookService;
import cn.com.service.IBooktypeService;
import cn.com.service.IReleaseBookService;
import cn.com.utils.GetBookTypeUtil;
import cn.com.utils.JsonUtil;
import cn.com.utils.SessionUtils;
import cn.com.vo.Pair;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * 图书管理相关控制类
 *
 * @author 柏贵雷　2017/09/13
 */
@Controller
@RequestMapping("/book")
public class BookManagerController {
    @Autowired
    private IBookService bookService;

    @Autowired
    private IBooktypeService booktypeService;

    @Autowired
    private GetBookTypeUtil getBookTypeUtil;

    @Autowired
    private IBookContactsService bookContactsService;

    @Autowired
    private IReleaseBookService releaseBookService;

    @Autowired
    private BehaviourLogService bs;

    /**
     * 显示书籍列表
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
        ModelAndView modelAndView = new ModelAndView("admin/book/bookList");
        if (!StringUtils.isEmpty(key)) key = URLDecoder.decode(key.replaceAll("\\.", "%"), "utf-8");
        if (key == null || key.trim().equals("")) {
            modelAndView.addObject("books",getBookTypeUtil.getBookType(releaseBookService.getReleaseBookOfPage(page)));
        } else {
            modelAndView.addObject("books",getBookTypeUtil.getBookType(releaseBookService.searchBook(key, page)));
            modelAndView.addObject("searchKey", key);
        }
        String qs = request.getQueryString();
        StringBuilder newQs = new StringBuilder();
        String[] qss = new String[]{};
        if (qs != null) qss = qs.split("&");
        for (String _qs : qss) {
            if (!_qs.startsWith("page=")) {
                newQs.append(_qs).append("&");
            }
        }
        if(authority!=null){
            request.getSession().setAttribute("authority",authority);
        }
        modelAndView.addObject("qs", newQs.toString());
        return modelAndView;
    }

    /**
     * 新增或修改图书页面
     *
     * @param bookid 图书ID,为空则为新增图书
     * @return
     */
    @RequestMapping("/bookInfo.do")
    public ModelAndView info(@RequestParam(required = false) Integer bookid,@RequestParam(required = false) Integer opType) {
        ModelAndView mav = new ModelAndView("admin/book/bookInfo");
        String msg = "";
        if(opType!=null){
            mav.addObject("opType",opType);
        }
        if (bookid != null) {
            ReleaseBook book = releaseBookService.getReleaseBook(bookid);
            if (book == null) {
                msg = "图书不存在";
            } else {
                mav.addObject("book", book);
                if (book.getType() != null) {
                    String[] types = book.getType().split(",");
                    List<Integer> list = new ArrayList<>();
                    for (String type : types){
                        list.addAll(booktypeService.getParentList(Integer.parseInt(type)));
                    }
                    mav.addObject("superType",
                            JsonUtil.toJson(list));
                }
            }
        }
        mav.addObject("msg", msg);
        mav.addObject("types", booktypeService.getAllTypes(null));
        return mav;
    }

    @RequestMapping("/bookIntro.do")
    @ResponseBody
    public Map<String, Object> bookIntro(Integer bookId) {
        Map<String, Object> result = new HashMap<>();
        if (bookId != null) {
            //Book book = bookService.findBookById(bookId);
            ReleaseBook book = releaseBookService.getReleaseBook(bookId);
            if (book != null) {
                result.put("intro", book.getContentvalidity());
                result.put("catalog", book.getCatalog());
                result.put("authorIntro",book.getAuthorIntro());
                result.put("sampleChapters",book.getSampleChapters());
                result.put("editorial",book.getEditorial());
                result.put("review",book.getReview());
                result.put("extention",book.getExtention());
            }
        }
        return result;
    }

    /**
     * 插入或者更新图书信息
     *
     * @param book
     * @return
     */
    @RequestMapping("/upsert.do")
    @ResponseBody
    public String upsert(@ModelAttribute ReleaseBook book, HttpServletRequest request,
                         @RequestParam(value = "image", required = false) MultipartFile file,
                         @RequestParam(value = "authorImage", required = false) MultipartFile file2,
                         @RequestParam(value = "extentionpdf", required = false) MultipartFile file3) {
        ReleaseBook book1 = book;
        if (book.getId() != null) {
            book1 = releaseBookService.getReleaseBook(book.getId());
            if (book1 == null) {
                return "书籍不存在";
            }
            book.setImageurl(book1.getImageurl());
            book.setAuthorImg(book1.getAuthorImg());
            book.setAuditing("0"); //编辑后图书的继续待审核
        }
        if (file != null && file.getSize() > 0) {
            String storeDirectoryRel = "/image/book/";
            String storeDirectoryAbs = request.getSession().getServletContext().getRealPath(storeDirectoryRel);
            try {
                String newFilename = FileManager.saveFile(file, storeDirectoryAbs);
                book.setImageurl(storeDirectoryRel + newFilename);
            } catch (IOException e) {
                return "ERROR";
            }
        }
        if (file2 != null && file2.getSize() > 0) {
            String storeDirectoryRel = "/image/author/";
            String storeDirectoryAbs = request.getSession().getServletContext().getRealPath(storeDirectoryRel);
            try {
                String newFilename = FileManager.saveFile(file2, storeDirectoryAbs);
                book.setAuthorImg(storeDirectoryRel + newFilename);
            } catch (IOException e) {
                return "ERROR";
            }
        }

        if (file3 != null && file3.getSize() > 0) {
            String storeDirectoryRel = "/image/pdf/";
            String storeDirectoryAbs = request.getSession().getServletContext().getRealPath(storeDirectoryRel);
            try {
                String newFilename = FileManager.saveFile(file3, storeDirectoryAbs);
                book.setExtention(storeDirectoryRel + newFilename);
            } catch (IOException e) {
                return "ERROR";
            }
        }else{
            String storeDirectoryRel = "/image/pdf/";
            String storeDirectoryAbs = request.getSession().getServletContext().getRealPath(storeDirectoryRel);
            String defualtname = (book1.getExtention()!=null && book1.getExtention().length()>8)?book1.getExtention():"default.pdf";
            book.setExtention(storeDirectoryRel + defualtname);
        }
        Book book2 = new Book();
        BeanUtils.copyProperties(book,book2);
        if (book.getId() == null) {//插入
            book.setAuditing("0"); //设置初始图书状态为未审核
            book.setId(bookService.saveReturnId(book2));
            releaseBookService.saveReleaseBook(book);
            bookContactsService.addContacts(book2);
            HttpSession session=request.getSession();
            bs.log(((User) session.getAttribute("adminUser")).getUserName(),"图书创建-书名："+book.getBookName());
        } else {
            releaseBookService.updateReleaseBook(book);
            bookContactsService.updateContacts(book2);
        }
        return "SUCCESS";
    }

    /**
     * 插入或者更新图书信息
     *
     * @param bookId 图书编号，
     * @param state 审核状态：1表示审核通过；2 表示审核不通过
     * @return 返回图书列表
     */
    @RequestMapping("/auditingBook.do")
    public String auditingBook(int bookId,String state) {
        releaseBookService.auditingBook(bookId,state);
        return "redirect:/book/list.do";
    }
    /**
     * 删除图书信息
     *
     * @param bookid 图书编号，
     * @return 返回图书列表
     */
    @RequestMapping("/del.do")
    public String delete(int bookid) {
        bookService.deleteBook(bookid);
        releaseBookService.deleteReleaseBook(bookid);
        bookContactsService.deleteByBookId(bookid);
        return "redirect:/book/list.do";
    }

    /**
     * 获取某一个图书类型的子级
     */
    @RequestMapping("/typeof.do")
    @ResponseBody
    public String booktypeof(int parent) {
        return JsonUtil.toJson(this.booktypeService.getAllTypes(parent));
    }


    /**
     * =======================
     * 图书分类管理
     * =======================
     */

    /**
     * 显示列表页
     *
     * @param msg 传入的信息
     * @return 视图
     */

    @RequestMapping("/bookType/list.do")
    public ModelAndView getBookTypeList(@RequestParam(defaultValue = "") String msg) {
        ModelAndView mav = new ModelAndView("admin/book/bookTypeList");
        List<Pair<Integer, Booktype>> treeBookType = booktypeService.selectAllBookTypeAsTree();
        mav.addObject("list", treeBookType);
        mav.addObject("msg", msg);
        return mav;
    }

    /**
     * 搜索（查找分类名）
     */
    @RequestMapping("/bookType/search.do")
    public ModelAndView BookTypeSearch(@RequestParam(defaultValue = "") String name) {
        ModelAndView mav = new ModelAndView("admin/book/bookTypeList");
        try {
            name = URLDecoder.decode(name, "utf-8");
        } catch (UnsupportedEncodingException e) {
            mav.addObject("list", new ArrayList<Booktype>());
            return mav;
        }
        List<Pair<Integer, Booktype>> BookType = booktypeService.getTypesByLikeName(name);

        mav.addObject("list", BookType);
        return mav;
    }

    /**
     * 检查名字是否存在
     *
     * @param name     名字
     * @param type     类型
     * @param response 返回
     * @throws IOException
     */
    @RequestMapping("/bookType/checkName.do")
    public void checkName(@RequestParam(defaultValue = "") String name, @RequestParam(defaultValue = "0") Integer type,
                          HttpServletResponse response) throws IOException {
        response.setContentType("text/html");
        String flag = "false";
        List<Booktype> booktype = booktypeService.getTypesByName(name);
        if (type == 0) {
            if (booktype.size() > 0) {//名已经存在了
                flag = "true";
            }
        } else {
            if (booktype.size() > 1) {//名已经存在了
                flag = "true";
            }
        }
        try (PrintWriter out = response.getWriter()) {
            out.print(flag);
        }
    }

    /**
     * 新增分类页面
     *
     * @return 视图
     */
    @RequestMapping("/bookType/save.do")
    public ModelAndView saveBookTypePage(@RequestParam(defaultValue = "") String msg) {
        ModelAndView mav = new ModelAndView("admin/book/bookType");
        List<Booktype> treeBookType = booktypeService.getAllTypes(null);
        mav.addObject("types", treeBookType);
        mav.addObject("msg", msg);
        mav.addObject("thisType", "ADD");
        return mav;
    }

    /**
     * 更新或者插入（有id时跟新 无id是插入）
     *
     * @param booktype 需要更新的分类
     * @return 反射回列表页
     */
    @RequestMapping(value = "/bookType/post.do", method = RequestMethod.POST)
    public String updateBookType(Booktype booktype) {
        if (booktype.getId() != null) {
            booktypeService.updateBookType(booktype);
        } else {
            booktypeService.saveBookType(booktype);
        }
        return "redirect:/book/bookType/list.do";
    }

    /**
     * 更新分类页面
     *
     * @param id 需要跟新的分类id
     * @return 视图
     */
    @RequestMapping("/bookType/update.do")
    public ModelAndView updateBookTypePage(@RequestParam(defaultValue = "0") Integer id) {
        ModelAndView mav = new ModelAndView("admin/book/bookType");
        Booktype booktype = null;
        List<Booktype> treeBookType = booktypeService.getAllTypes(null);
        List<Integer> parent = booktypeService.getParentList(id);
        mav.addObject("types", treeBookType);
        if (id != 0) {
            booktype = booktypeService.selectBookTypeById(id);
        }
        if (booktype == null) {
            mav.addObject("msg", "图书分类不存在");
        }
        mav.addObject("superType", parent);
        mav.addObject("msg", "");
        mav.addObject("thisType", "UPDATE");
        mav.addObject("updateBookType", booktype);
        return mav;
    }

    /**
     * 删除分类操作
     *
     * @param id 需要删除的id
     * @return 反射回列表页 若失败传参msg=failed；
     */
    @RequestMapping("/bookType/delete.do")
    public String deleteBookType(@RequestParam(defaultValue = "0") Integer id) {
        int result = 0;
        if (id != 0) {
            releaseBookService.deleteReleaseBook(id);
            result = booktypeService.deleteBookType(id);
        }
        if (result == 0) {
            return "redirect:/book/bookType/list.do?msg=failed";
        }
        return "redirect:/book/bookType/list.do";
    }

    /**
     * 图书发布
     */
    @RequestMapping("/bookRelease.do")
    public String bookRelease(@RequestParam Integer bookid) {
        if(bookid!=null) {
            ReleaseBook releaseBook = releaseBookService.getReleaseBook(bookid);
            if(releaseBook!=null){
                releaseBook.setAuditing("3");
                Book book = new Book();
                BeanUtils.copyProperties(releaseBook, book);
                bookService.updateBook(book);
                releaseBookService.updateReleaseBook(releaseBook);
            }
        }
        return "redirect:/book/list.do";
    }
}
