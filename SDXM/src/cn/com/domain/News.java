package cn.com.domain;


import java.util.Calendar;
import java.util.Date;


public class News implements java.io.Serializable {
    private String id;
    private String title;
    private String content;
    private int type;
    private Date createTime;
    private String publisher;
    //2018年6月7日 默认图片设置（为减少由于对代码不了解而导致的问题，在此更改初始值，权宜之计）
    private String pics = "/new_style/img/sdxm_default.jpg";
    private String videos;
    private String yearStr;
    private String dateStr;
    private static String default_pic_path = "/new_style/img/useByHome1.png";

    private String summary;

    public News() {

    }

    public String getYearStr() {
        return yearStr;
    }

    public void setYearStr(String yearStr) {
        this.yearStr = yearStr;
    }

    public String getDateStr() {
        return dateStr;
    }

    public void setDateStr(String dateStr) {
        this.dateStr = dateStr;
    }

    public News(String id, String title, String content, int type, Date createTime, String publisher, String pics, String videos, String summary) {
        this.id = id;
        this.title = title;
        this.content = content;
        this.type = type;
        this.publisher = publisher;
        this.pics = pics;
        this.videos = videos;
        this.summary = summary;
        this.createTime = createTime;
        resolveDate(this.createTime);
        resolvePic();
    }

    public void resolveDate(){
        this.resolveDate(this.createTime);
    }

    public void resolvePic() {
        if (this.getPics() == null || this.getPics().trim().equals("")) {
            this.setPics(default_pic_path);
        }
    }
    private void resolveDate(Date createTime) {
        Calendar cl = Calendar.getInstance();
        cl.setTime(createTime);
        int year = cl.get(Calendar.YEAR);
        int month = cl.get(Calendar.MONTH) + 1;
        int day = cl.get(Calendar.DAY_OF_MONTH);
        this.yearStr = "" + year + "";
        this.dateStr = "" + (month < 10 ? "0" + month : month) + "-" + (day < 10 ? "0" + day : day);
    }
    public News(int type) {
        this.type = type;
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

    public String getPublisher() {
        return publisher;
    }

    public void setPublisher(String publisher) {
        this.publisher = publisher;
    }

    public String getPics() {
        return pics;
    }

    public void setPics(String pics) {
        this.pics = pics;
    }

    public String getVideos() {
        return videos;
    }

    public void setVideos(String videos) {
        this.videos = videos;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getSummary() {
        return summary;
    }

    public void setSummary(String summary) {
        this.summary = summary;
    }
}
