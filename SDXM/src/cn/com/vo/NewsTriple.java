package cn.com.vo;

import java.util.Date;

/**
 * Created by ironman on 2017/11/8.
 */
public class NewsTriple {
    private String id;
    private String title;
    private Date createTime;

    public NewsTriple(String id, String title, Date createTime) {
        this.id = id;
        this.title = title;
        this.createTime = createTime;
    }

    public NewsTriple(){

    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }
}
