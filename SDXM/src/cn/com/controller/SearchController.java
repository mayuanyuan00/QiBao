package cn.com.controller;

import java.net.URLDecoder;
import java.util.List;

import cn.com.domain.Links;
import cn.com.service.ILinksService;
import cn.com.vo.PageResults;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import cn.com.domain.Book;
import cn.com.lucene.LuceneSearchResult;
import cn.com.service.IBookLuceneService;

import javax.annotation.Resource;

@Controller
@RequestMapping("search")
public class SearchController {
    @Autowired
    private IBookLuceneService bookLuceneService;

    @Resource(name = "linksService")
    private ILinksService linksService;
    @RequestMapping("/search.do")
    public ModelAndView search(@RequestParam(value = "page",defaultValue = "1") int page,@RequestParam(value = "keyword") String keyword) throws Exception {
        if(page<1) page = 1;
        final int countPerPage = 10;
        ModelAndView modelAndView = new ModelAndView("website/book_search");
        keyword = URLDecoder.decode(keyword.replaceAll("\\.", "%"), "utf-8");
        LuceneSearchResult<Book> bookPageResults = bookLuceneService.doSeacher(keyword,page,countPerPage);
        modelAndView.addObject("books",bookPageResults);
        return modelAndView;
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