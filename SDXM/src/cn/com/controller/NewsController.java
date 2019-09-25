package cn.com.controller;

import cn.com.common.BehaviourLogService;
import cn.com.domain.*;
import cn.com.service.*;
import cn.com.utils.SessionUtils;
import cn.com.vo.NewsTriple;
import cn.com.vo.PageResults;
import cn.com.vo.Pair;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("news")
public class NewsController {
    @Resource(name = "userService")
    private IUserService userService;
    @Resource(name = "linksService")
    private ILinksService linksService;
    @Resource(name="newsService")
    private INewsService newsService;
    @Resource(name="menuService")
    private IMenuService menuService;
    @Resource(name="newsKeywordsService")
    private INewsKeywordsService newsKeywordsService;
    @Resource(name="bookService")
    private IBookService bookService;
    
    @Autowired
	private BehaviourLogService bs;


    /**
     * ====================================================================
     * 详情页
     * =====================================================================
     */
    @RequestMapping("detail.do")
    public ModelAndView getNewsDetail(@RequestParam("id") String id, @RequestParam(value="type",
            defaultValue = "1") int type, @RequestParam(value="listType", defaultValue = "1") int listType,
                                      @RequestParam(value="page", defaultValue = "1") int page,
                                      ServletRequest request){
        ModelAndView mav;
        //行为记录
        HttpServletRequest req=(HttpServletRequest) request;
        User user= SessionUtils.getSysUserFromSession(req);
        if(user!=null){
            bs.log(user.getUserName(), "阅读详情");
        }else{
            bs.log("游客", "阅读详情");
        }
       
        if(type==18||type==19) {
           mav = new ModelAndView("website/press_culture_detail");
        }else if(type == 12) {
            mav = new ModelAndView("website/institution_detail");
        }else if (type==20){
            mav=new ModelAndView("website/bookworkDetail");
        }
        else{
            mav = new ModelAndView("website/news_content");
        }
        if ("".equals(id)||null==id){
            mav.addObject("msg","非法请求");
        }else {
            // 按照时间返回文章的id列表
            List<String> newsList = newsService.newsIdList(type);
            News news=newsService.findById(id);

            String preNews = newsList.get(0);
            String posNews = newsList.get(0);
            for(int i = 0; i < newsList.size(); i++) {
                if(newsList.get(i).equals(id)){
                    preNews = newsList.get(i == 0 ? 0 : i - 1);
                    posNews = newsList.get(i == newsList.size() - 1 ? i : i + 1);
                    break;
                }
            }
            News previousNews = newsService.findById(preNews);
            News nextNews = newsService.findById(posNews);

            if (null==news){
                mav.addObject("msg","文章不存在");
            }else {
                Columnlist columnlist = menuService.findComlumnById(news.getType());
                if(columnlist == null) {
                    mav.addObject("msg", "该新闻栏目已被删除");
                }
                else {
                    mav.addObject("previousType", listType);
                    mav.addObject("previousPage", page);
                    mav.addObject("type", columnlist.getName());
                    mav.addObject("news", news);
                    mav.addObject("preNews", previousNews.getTitle());
                    mav.addObject("preNewsId", previousNews.getId());
                    mav.addObject("nextNews", nextNews.getTitle());
                    mav.addObject("nextNewsId", nextNews.getId());
                }
            }
            List<NewsTriple> latestNews = newsService.latestNews(type);
            mav.addObject("latestNews", latestNews);
        }
        List<Book> books=bookService.getHotBook();
        if (books.size()>0){
            mav.addObject("hotBooks", books);
        }
        List<NewsTriple> recommendation = newsKeywordsService.getConcerningNewsForList(id);
        mav.addObject("recommendation", recommendation);
        return mav;
    }

    @RequestMapping("/newsList.do")
    @ResponseBody
    public PageResults<News> newsOfTypeByPage(@RequestParam(value="type", defaultValue = "1") int type, @RequestParam(value="page", defaultValue = "1") int page, @RequestParam(value="recommendation", defaultValue = "false") boolean recommendation, @RequestParam(value="id", defaultValue = "0") String newsId){
    	PageResults<News> newsList = newsService.newsOfTypeByPage(type, page);
        for (News news: newsList.getResults()){
            news.resolveDate();
            news.resolvePic();
        }
        return newsList;
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
