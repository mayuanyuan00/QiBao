package cn.com.utils;

import cn.com.domain.Book;
import cn.com.domain.ReleaseBook;
import cn.com.service.IBooktypeService;
import cn.com.vo.BookVO;
import cn.com.vo.PageResults;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * @author Yao
 * @Description:
 * @Date: Created on 2018/1/12
 * @Modefied By
 */
@Component
public class GetBookTypeUtil {

    @Autowired
    private  IBooktypeService BooktypeService;

    public  PageResults<BookVO> getBookType(PageResults<ReleaseBook> pageResults) {
       List<ReleaseBook> list = pageResults.getResults();
       PageResults<BookVO> pages = new PageResults<>();
       pages.setTotalCount(pageResults.getTotalCount());
       pages.setCurrentPage(pageResults.getCurrentPage());
       pages.setPageSize(pageResults.getPageSize());
       List<BookVO> list1 = new ArrayList<>();
       for(ReleaseBook book : list) {
           StringBuilder myType = new StringBuilder();
           BookVO bookVO = new BookVO();
           BeanUtils.copyProperties(book,bookVO);
           String[] types = book.getType().split(",");
           for(int i = 0;i<types.length;i++) {
               String t = BooktypeService.selectBookTypeById(Integer.parseInt(types[i])).getTypeName();
               if(i == types.length-1){
                   myType.append(t);
               }else {
                   myType.append(t).append(",");
               }
           }
           bookVO.setBookType(myType.toString());
           list1.add(bookVO);
       }
       pages.setResults(list1);
        return pages;
    }


}
