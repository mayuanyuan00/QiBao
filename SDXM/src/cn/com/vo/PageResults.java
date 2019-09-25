package cn.com.vo;

import org.hibernate.envers.tools.Pair;

import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

/**
 * 分页实体类
 *
 * @author 柏贵雷
 */
public class PageResults<T> {
    // 当前页
    private int currentPage;

    // 每页个个数
    private int pageSize;

    // 总条数
    private int totalCount;

    // 记录
    private List<T> results;

    public int getPageCount() {
        int pageCount = totalCount / pageSize;
        if (totalCount % pageSize != 0) ++pageCount;
        return pageCount;
    }


    public int getPageNo() {
        return currentPage + 1;
    }

    public List<T> getResults() {
        return results;
    }

    public void setResults(List<T> results) {
        this.results = results;
    }

    public int getCurrentPage() {
        return currentPage;
    }

    public void setCurrentPage(int currentPage) {
        this.currentPage = currentPage;
    }

    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize <= 0 ? 10 : pageSize;
    }

    public int getTotalCount() {
        return totalCount;
    }

    public void setTotalCount(int totalCount) {
        this.totalCount = totalCount;
    }

    /**
     * 显示的分页的每一项,Pair的第一项为名，第二项为页码
     *
     * @return
     */
    public List<Pair<String, String>> getPages() {
        List<Pair<String, String>> pages = new LinkedList<>();
        pages.add(new Pair<>("首页", "1"));
        if (this.currentPage > 1) pages.add(new Pair<>("上一页", Integer.toString(this.currentPage - 1)));
        if (this.currentPage > 2) pages.add(new Pair( Integer.toString(this.currentPage - 2),Integer.toString(this.currentPage - 2)));
        if (this.currentPage > 1) pages.add(new Pair( Integer.toString(this.currentPage - 1),Integer.toString(this.currentPage - 1)));
        pages.add(new Pair(Integer.toString(currentPage), Integer.toString(currentPage)));
        if (currentPage + 1 <= this.getPageCount()) {
            pages.add(new Pair( Integer.toString(this.currentPage + 1),Integer.toString(this.currentPage + 1)));
        }
        if (currentPage + 2 <= this.getPageCount()) {
            pages.add(new Pair( Integer.toString(this.currentPage + 2),Integer.toString(this.currentPage + 2)));
        }
        if (this.currentPage < this.getPageCount()) {
            pages.add(new Pair<>("下一页", Integer.toString(this.currentPage + 1)));
        }
        pages.add(new Pair<>("尾页", Integer.toString(this.getPageCount())));
        return pages;
    }

}
