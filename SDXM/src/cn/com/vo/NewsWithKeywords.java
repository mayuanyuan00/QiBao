package cn.com.vo;

import cn.com.domain.News;

import java.util.List;

/**
 * Created by ironman on 2017/11/9.
 */
public class NewsWithKeywords extends News {
    private List<String> keywords;

    public List<String> getKeywords() {
        return keywords;
    }

    public void setKeywords(List<String> keywords) {
        this.keywords = keywords;
    }

    public News getNewsObj(){
        return new News(this.getId(), this.getTitle(), this.getContent(), this.getType(), this.getCreateTime(), this.getPublisher(), this.getPics(), this.getVideos(), this.getSummary());
    }
}
