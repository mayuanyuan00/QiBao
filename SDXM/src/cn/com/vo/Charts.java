package cn.com.vo;

import java.util.Date;

public class Charts {
    Integer parentid;
    String bookType;
    Object month;
    Object count;

    public Integer getParentid() {
        return parentid;
    }

    public String getBookType() {
        return bookType;
    }

    public Object getMonth() {
        return month;
    }

    public  Object  getCount() {
        return count;
    }

    public void setParentid(Integer parentid) {
        this.parentid = parentid;
    }

    public void setBookType(String bookType) {
        this.bookType = bookType;
    }

    public void setMonth(Object month) {
        this.month = month;
    }

    public void setCount( Object count) {
        this.count = count;
    }
}
