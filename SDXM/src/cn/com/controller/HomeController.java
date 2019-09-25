package cn.com.controller;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.net.URL;
import java.util.*;
import java.util.Collection;

import javax.annotation.Resource;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import cn.com.common.FileManager;
import cn.com.domain.*;
import cn.com.service.*;
import cn.com.service.impl.BooktypeServiceImpl;
import cn.com.utils.JsonUtil;
import cn.com.utils.StringUtils;
import cn.com.vo.Pair;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;

import cn.com.common.BehaviourLogService;
import cn.com.utils.SessionUtils;
import cn.com.vo.PageResults;

@Controller
@RequestMapping("home")
public class HomeController {
    @Resource(name = "bookService")
    private IBookService bookService;
    @Resource(name = "booktypeService")
    private IBooktypeService booktypeService;

    @Resource(name = "linksService")
    private ILinksService linksService;

    @Resource(name = "newsService")
    private INewsService newsService;

    @Resource(name = "recommendService")
    private IRecommendService recommendService;

    @Resource(name = "newsKeywordsService")
    private INewsKeywordsService newsKeywordsService;

    @Resource(name = "shippingAddressService")
    private IShippingAddressService shippingAddressService;

    @Resource(name = "orderService")
    private IOrderService orderService;

    @Resource(name="menuService")
    private IMenuService menuService;

    @Resource(name="resourcesService")
    private IResourceService resourceService;

    @Autowired
	private BehaviourLogService bs;

    @RequestMapping("/enter.do")
    public String toEnter() throws Exception {
        return "website/enter";
    }

    @RequestMapping("/header.do")
    public String toHeader() throws Exception {
        return "website/header";
    }

    @RequestMapping("/homeIndex.do")
    public ModelAndView toIndex(HttpSession session) throws Exception {
        ModelAndView mav = new ModelAndView("website/index");
        session.setAttribute("type",1);

        //news   社内公告type=11?  重要活动type=10 我社风采type=14?
        List<News> videoNews = newsService.findWithPicOrVideosOrederByTime( 1);
        List<News> latestNews = newsService.getNewsLimited(new ArrayList<Integer>(Arrays.asList(9,10,11)), 5);
        latestNews.removeAll(videoNews);
        mav.addObject("videoNews", videoNews);
        mav.addObject("latestNews", latestNews);

        //author
        Recommend author=recommendService.getAllRecommend().get(0);

        //new book
        List<Book> book = bookService.getNewBook();

        //hot book
        List<Book> recommend = recommendService.getHomeHotBook();

        List<Book> newTypeBook=new ArrayList<>();
        if(recommend.size()>0) {
            for (Book oldbook : recommend) {
                Book temp = (Book) oldbook.clone();
                if (oldbook.getContentvalidity() != null) {
                    temp.setContentvalidity(StringUtils.removeHtml(oldbook.getContentvalidity()));
                }
                if (oldbook.getAuthorIntro() != null) {
                    temp.setAuthorIntro(StringUtils.removeHtml(oldbook.getAuthorIntro()));
                }
                newTypeBook.add(temp);
            }
        }

        List<cn.com.domain.Resource> resources = resourceService.getResourcesReleasedByPage(1).getResults();
        mav.addObject("author",author);
        mav.addObject("newBook", book);
        mav.addObject("recommend", newTypeBook);
        mav.addObject("download", ((resources != null) && (resources.size() > 0)) ?resources.get(0):null);
        return mav;
    }

    @RequestMapping("/bookArtTypeList.do")
    public ModelAndView bookArtTypeList(@RequestParam int type, @RequestParam(defaultValue = "1") int page) throws Exception {
        if (page < 1) page = 1;
        final int countPerPage = 6;//每页6个

        ModelAndView modelAndView = new ModelAndView("website/book_art_type_list");
        Booktype booktype = booktypeService.selectBookTypeById(type);
        if (booktype == null) {
            modelAndView.addObject("errormsg", "类型ID不存在");
        } else {
            PageResults<Book> result;
            List<Booktype> booktypes = new ArrayList<>();
            booktypes.add(booktype);

            if (booktype.getParentid() == 0) {//父级，可能有子层级，一起包含了
                result = bookService.getResultOfParentType(booktype.getId().toString(), page);
            } else {
                booktypes.add(0, booktypeService.selectBookTypeById(booktype.getParentid()));
                result = bookService.getResultOfType(booktype.getId().toString(), page);
            }
            modelAndView.addObject("books", result);
            modelAndView.addObject("booktypes", booktypes);
        }
        return modelAndView;
    }

        @RequestMapping("/bookArtList.do")
    public ModelAndView bookArtListTypeFirst(@RequestParam("ptype") int ptype, @RequestParam(defaultValue = "-1") int jumpType, @RequestParam(defaultValue = "1") int page){
        if(page<0){
            page=1;
        }
        ModelAndView mav = new ModelAndView("website/book_art_type_list");
        List<Pair<Integer, Booktype>> booktypes = booktypeService.selectAllBookTypeAsTree();
        List<Booktype> parentTypes=new ArrayList<>();
        List<Booktype> childTypes=new ArrayList<>();
        List<Booktype> showTypes=new ArrayList<>();
        Boolean flag=false;
        Integer type=0;
        for (Pair<Integer, Booktype> temp :booktypes){
           if (temp.getKey()==1){
               parentTypes.add(temp.getValue());
               if (ptype==temp.getValue().getId()){
                   flag=true;
               }
           }
        }
        PageResults<Book> books=new PageResults<>();
        if (!flag){
            mav.addObject("errormsg", "类型ID不存在");
            ptype=12;
        }
        for (Pair<Integer, Booktype> temp :booktypes){
            if (temp.getKey()==2){
                childTypes.add(temp.getValue());
                if (temp.getValue().getParentid()==ptype){
                    showTypes.add(temp.getValue());
                }
            }
        }
        if (showTypes.size()==0){
            type=ptype;
        }else {
            type = showTypes.get(0).getId();
        }
        mav.addObject("jumpType",jumpType);
        mav.addObject("ptype",ptype);
        mav.addObject("type",type);
//        mav.addObject("books",getBookByType(type,page,16));
        mav.addObject("parentTypes",parentTypes);
        mav.addObject("showTypes",showTypes);
        return mav;
    }

    @RequestMapping("/bookSearch/books.do")
    @ResponseBody
    public List<Booktype> getBookTypes(){
        List<Booktype> booktypes = booktypeService.getAllTypes(0);
        return booktypes;
    }



    @RequestMapping("/bookArtList/books.do")
    @ResponseBody
    public PageResults<Book> getBooks(@RequestParam("type") Integer type,@RequestParam(defaultValue = "1") int page,
                                      @RequestParam(value = "jumpType",defaultValue = "-1")int jumpType){
        if(jumpType == -1) {
            return getBookByType(type,page,16);
        }else {
            return bookService.getResultOfType(type.toString(),page);
        }
    }



    private PageResults<Book> getBookByType(Integer type,int page,int size){
        return bookService.getResultOfParentType(type.toString(),page,size);
    }

    @RequestMapping("/bookDetail.do")
    public ModelAndView bookDetail(@RequestParam int id) throws Exception {
        Book book=bookService.findBookById(id);
        String[] strType=book.getType().split(",");
        List<Integer> listBookType=booktypeService.getParentList(Integer.parseInt(strType[0]));
        Booktype booktype=booktypeService.selectBookTypeById(Integer.parseInt(strType[0]));
        String type="";
        for (Integer str:listBookType){
            type=type+",";
            type+=str.toString();
        }
        type=type.substring(1);
        PageResults<Book> books= bookService.getResultOfParentType(type,1);
        ModelAndView modelAndView = new ModelAndView("website/book_detail");
        modelAndView.addObject("type",booktype);
        modelAndView.addObject("book", bookService.findBookById(id));
        modelAndView.addObject("books",books);
        return modelAndView;
    }

    @RequestMapping("/bookTypeList.do")
    public ModelAndView bookTypeList(ServletRequest request) throws Exception {
    	//行为记录
    	HttpServletRequest req=(HttpServletRequest) request;
    	req.getSession().setAttribute("type",3);

        ModelAndView modelAndView = new ModelAndView("website/book_type_list");
        List<Booktype> booktypes = booktypeService.getAllTypes(null);
        List<Map<String, Object>> bookTypeResults = new ArrayList<>();
        modelAndView.addObject("result", bookTypeResults);
        for (Booktype booktype : booktypes) {
            Map<String, Object> result = new HashMap<>();
            bookTypeResults.add(result);

            result.put("id", booktype.getId());
            result.put("name", booktype.getTypeName());
            result.put("books", bookService.getResultOfParentType(booktype.getId().toString(), 1, 3));
        }
        User user=SessionUtils.getSysUserFromSession(req);
        if(user!=null){
            bs.log(user.getUserName(), "图书专区");
        }else{
            bs.log("游客", "图书专区");
        }

        return modelAndView;
    }

    // type是新闻类型，因为首先加载的是最新资讯，所以defaultValue = 9
    @RequestMapping("/newsList")
    public synchronized ModelAndView newsListCol(@RequestParam(value = "type", defaultValue = "9") int type,
                                                 @RequestParam(value = "page", defaultValue = "1") int page,
                                                 @RequestParam(value="recommendation", defaultValue = "false") boolean recommendation,
                                                 @RequestParam(value="id", defaultValue = "0") String newsId,
                                                 ServletRequest request) throws Exception {
        //行为记录
        HttpServletRequest req=(HttpServletRequest) request;
        req.getSession().setAttribute("type",2);

    	ModelAndView mav = new ModelAndView("website/news_list");
        // 获取 新闻公告-最新资讯 文章列表
        List<Pair<Integer,String>> typeNames = new ArrayList<>();
        if(type == -1) {
            // 关于我社
            typeNames.add(new Pair<>(18,"科研文化"));
            typeNames.add(new Pair<>(19,"学术文化"));
            mav.addObject("topColumn","关于我社");
            mav.addObject("secondColumn", "科研文化");
        } else {
            typeNames.add(new Pair<Integer, String>(9,"最新资讯"));
            typeNames.add(new Pair<Integer, String>(10,"重要活动"));
            typeNames.add(new Pair<Integer, String>(11,"社内公告"));
            mav.addObject("topColumn", "新闻公告");
            mav.addObject("secondColumn", "最新资讯");
        }
        if(!recommendation) {
            PageResults<News> newsList = newsService.newsOfTypeByPage(type, page);
            List<News> newses = newsList.getResults();
            for(News news: newses) {
                news.resolveDate();
            }
            int totalPages = newsList.getTotalCount() / newsList.getPageSize();
            if (newsList.getTotalCount() % newsList.getPageSize() > 0) {
                totalPages++;
            }
            // 确定文章列表显示哪一栏
            int showColumn = 0;
            switch (type){
                case 19:
                case 10:
                    showColumn = 1;
                    break;
                case 11:
                    showColumn = 2;
                    break;
                default:
            }
            mav.addObject("type", type);
            mav.addObject("showColumn", showColumn);
            mav.addObject("page", page);
            mav.addObject("pageCount", totalPages);
            mav.addObject("currentPage", newsList.getCurrentPage());
            mav.addObject("newsList", newsList.getResults());
            mav.addObject("recommendation", false);
        } else {
            //获取文章的延伸
            List<News> recommendationNews = newsKeywordsService.getConcerningNewsByPage(newsId, page);
            //获取相关文章的总数
            long sum = newsKeywordsService.pagesOfConcerningNews(newsId);
            mav.addObject("type", type);
            mav.addObject("page", page);
            mav.addObject("pageCount", sum);
            mav.addObject("currentPage", page);
            mav.addObject("newsList", recommendationNews);
            mav.addObject("recommendation", true);
        }
        mav.addObject("newsId", newsId);
        mav.addObject("newsType", typeNames);
        User user=SessionUtils.getSysUserFromSession(req);
        if(user!=null){
            bs.log(user.getUserName(), "新闻公告");
        }else{
            bs.log("游客", "新闻公告");
        }
      
        return mav;
    }

    @RequestMapping("/contact.do")
    public String toContact(ServletRequest request,@RequestParam(defaultValue = "1") Integer page,
                            @RequestParam(defaultValue = "5")Integer lastType) throws Exception {
        //行为记录
        HttpServletRequest req=(HttpServletRequest) request;
        req.getSession().setAttribute("type",5);
        User user=SessionUtils.getSysUserFromSession(req);
        if(user!=null){
            bs.log(user.getUserName(), "互动专区");
        }else{
            bs.log("游客", "互动专区");
        }
        request.setAttribute("page",page);
        request.setAttribute("lastType",lastType);
        return "website/contactus";
    }
    
    @RequestMapping("/pressIntroduction.do")
    public ModelAndView toPressIntroduction(HttpServletRequest request){
        String type = "";
        if(request.getParameter("type")==null){
            type = "13";
        }else{
            type = request.getParameter("type");
        }
        String url = "";
        if("13".equals(type)){
            url = "website/press_introduction";
        }else if("16".equals(type)){
            url = "website/organization";
        }else{
            url = "website/press_introduction";
        }
        ModelAndView modelAndView = new ModelAndView(url);
        modelAndView.addObject("collecttion",newsService.newsOfType(Integer.parseInt(type)));
        return modelAndView;
    }
    
    @RequestMapping("/contactUs.do")
    public String toContactUs() throws Exception {
        return "website/contact_us";
    }

    /**
     * 关于我社
     * @param type
     * @param page
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping("/pressCulture.do")
    public ModelAndView toPressCulture(@RequestParam(value = "type", defaultValue = "13") int type,
                                 @RequestParam(value = "page", defaultValue = "1") int page,HttpServletRequest request) throws Exception {
        ModelAndView mav = new ModelAndView("website/about");
        request.getSession().setAttribute("type",6);
        List<News> news = newsService.getNewsLimited(13,1);
        News about = news.get(0);
        List<News> a = newsService.getNewsLimited(18,4);
        for (News ne:a){
            ne.resolveDate();
        }
        List<News> b = newsService.getNewsLimited(19,4);
        for (News nf : b){
            nf.resolveDate();
        }
        mav.addObject("about",about);
        mav.addObject("research",a);
        mav.addObject("academic",b);
        mav.addObject("lastType",type);
//        return this.getNewsList(mav, type, page);
        return mav;
    }

    /**
     * 出版社组织结构
     * @return
     * @throws Exception
     */
    @RequestMapping("/structure.do")
    public ModelAndView toStructure() throws Exception {
        return new ModelAndView("website/structure");
    }


    @RequestMapping("/institution.do")
    public ModelAndView toPressInstitution(@RequestParam(value = "type", defaultValue = "12") int type,
                                           @RequestParam(value = "page", defaultValue = "1") int page) throws Exception{
        ModelAndView mav = new ModelAndView("website/institution_list");
        return this.getNewsList(mav, type, page);
    }


    @RequestMapping("bookwork.do")
    public ModelAndView toBookWork(@RequestParam(value = "type", defaultValue = "20") int type,
                                           @RequestParam(value = "page", defaultValue = "1") int page) throws Exception{
        ModelAndView mav = new ModelAndView("website/bookwork_list");
        return this.getNewsList(mav, type, page);
    }

    @RequestMapping("/type_news.do")
    @ResponseBody
    public    PageResults<News>  getNewsByType(@RequestParam(value = "type", defaultValue = "20") int type,
                                           @RequestParam(value = "page", defaultValue = "1") int page)throws Exception{
        PageResults<News> newsPageResult= newsService.newsOfTypeByPage(type, page);
        return  newsPageResult;
    }



    private ModelAndView getNewsList(ModelAndView mav, int type, int page){
        // 获取新闻公告文章列表
        PageResults<News> newsList = newsService.newsOfTypeByPage(type, page);
        int totalPages = newsList.getTotalCount() / newsList.getPageSize();
        if (newsList.getTotalCount() % newsList.getPageSize() > 0) {
            totalPages++;
        }
        mav.addObject("type", type);
        mav.addObject("pageCount", totalPages);
        mav.addObject("currentPage", newsList.getCurrentPage());
        mav.addObject("newsList", newsList.getResults());
        return mav;
    }
    @RequestMapping("/academicJson.do")
    @ResponseBody
    public String academicJson(@RequestParam(value = "type", defaultValue = "18") int type,
                               @RequestParam(value = "page", defaultValue = "1") int page,
                               HttpServletRequest request) throws Exception {

        // 获取新闻公告文章列表
        PageResults<News> newsList = newsService.newsOfTypeByPage(type, page);
        int totalPages = newsList.getTotalCount() / newsList.getPageSize();
        if (newsList.getTotalCount() % newsList.getPageSize() > 0) {
            totalPages++;
        }
        request.setAttribute("pageCount",totalPages);
        request.setAttribute("currentPage",newsList.getCurrentPage());
        List<News> news=newsList.getResults();
        Gson gson=new Gson();
        return gson.toJson(news);
    }
    
    @RequestMapping("/gopage.do")
    public String gotopage(String page){
        System.out.println(page);
        return "website/"+page;
    }
    
    @RequestMapping("/personalInformation.do")
    public String toPersonalInformation(HttpServletRequest request) throws Exception {
        User user=(User) request.getSession().getAttribute("user");
        if (user==null){
            return "redirect:/home/homeIndex.do";
        }
        List<ShippingAddress> add=new ArrayList<>();
        List<ShippingAddress> addresses=shippingAddressService.findByUser(user.getId());
        //获取三个未收货订单
        List<Order> tempList=orderService.getOrderList(5,user.getId(),1).getResults();
        List<Order> orders=new ArrayList<>();
       for(int i=0;i<Math.min(tempList.size(),3);i++){
           orders.add(tempList.get(i));
       }
        request.getSession().setAttribute("orders",orders);
       //获取未支付订单数目
        Long count1 =orderService.getOrderCount(1,user.getId());
        request.getSession().setAttribute("count1",count1);
        //获取待发货订单数目
        Long count2=orderService.getOrderCount(4,user.getId());
        request.getSession().setAttribute("count2",count2);
        //获取待收货订单数目
        Long count3=orderService.getOrderCount(5,user.getId());
        request.getSession().setAttribute("count3",count3);
        //地址
        for(ShippingAddress temp:addresses){
            temp.setTel(temp.getTel().replaceAll("(\\d{3})\\d{4}(\\d{4})", "$1****$2"));
            add.add(temp);
        }
        request.getSession().setAttribute("address",add);
        return "website/personal_information";
    }

    /**
     *互动专区和关于我们news详情页
     * * @param id 新闻ID
     * @param page 页
     * @param homeType 判断类型
     */
        @RequestMapping("/systemdetail.do")
    public ModelAndView ContactsDetial(@RequestParam String id,
                                       @RequestParam(required = false)String page,
                                       @RequestParam(required = false)String homeType){
        ModelAndView mav;
        if("home".equals(homeType)) {
             mav = new ModelAndView("website/systemdetail2");
        }else{
             mav = new ModelAndView("website/systemdetail");
        }
        News news;
        //取得校长致辞内容
        if("21".equals(id)){
             news = newsService.getNewsLimited(21,1).get(0);
        }else{
             news=newsService.findById(id);
        }

        mav.addObject("news",news);
        Integer type=news.getType();
        Columnlist columnlist=menuService.findComlumnById(type);
        if (columnlist.getParent()==0){
            mav.addObject("par",columnlist.getName());
            mav.addObject("chi","");
        }else {
            Columnlist parent=menuService.findComlumnById(columnlist.getParent());
            mav.addObject("par",parent.getName());
            mav.addObject("chi",columnlist.getName());
        }
        if(!"".equals(page)&&page!=null) {
            mav.addObject("page",page);
        }
        return mav;
    }

    /**
     * =======================
     * 用户地址
     * =====================
     */

    /**
     * 获取用户地址
     */
    @RequestMapping("/address.do")
    public @ResponseBody
    ShippingAddress getAddress(@RequestParam("id")Integer id){
        ShippingAddress addresses=shippingAddressService.findById(id);
        return addresses;
    }

    /**
     * 删除地址
     */

    @RequestMapping("/address/delete.do")
    @ResponseBody
    public String deleteAddress(@RequestParam("id")Integer id,HttpServletRequest request){
        User user=((User)request.getSession().getAttribute("user"));
        if (user==null){
            return "用户未登录";
        }
        shippingAddressService.delete(id);
        return "删除成功";
    }

    /**
     * 新增
     */
    @RequestMapping("/address/upset.do")
    @ResponseBody
    public String upsetAddress(ShippingAddress shippingAddress,HttpServletRequest request){
        Integer userId=((User)request.getSession().getAttribute("user")).getId();
        if (userId==null){
            return "用户未登录，请重新登录";
        }
        shippingAddress.setUserid(userId);
        if (shippingAddress.getId()==null){
            shippingAddressService.insert(shippingAddress);
        }else {
            shippingAddressService.update(shippingAddress);
        }
        return "成功";
    }

    /**
     * 文件下载
     */
    @RequestMapping("/download/file.do")
    public void downloadFile(HttpServletRequest request,HttpServletResponse response,@RequestParam("file")String filePath) throws Exception {
        String storeDirectoryRel = "/images/home/";
        String storeDirectoryAbs = request.getSession().getServletContext().getRealPath(storeDirectoryRel);
        String path=storeDirectoryAbs+"useByHome1.png";
        FileManager.downLoad(path,response,false);
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