package cn.com.service.impl;

import cn.com.dao.IRecommendDao;
import cn.com.domain.Book;
import cn.com.domain.Recommend;
import cn.com.service.IRecommendService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

@Service("recommendService")
public class RecommendServiceImpl implements IRecommendService{
    @Resource(name="recommendDao")
    private IRecommendDao recommendDao;

    @Override
    public List<Recommend> getAllRecommend() {
        List<Recommend> recommends= (List<Recommend>) recommendDao.getAllEntry();
        Collections.sort(recommends,new Comparator<Recommend>(){
            public int compare(Recommend arg0, Recommend arg1) {
                return arg0.getId().compareTo(arg1.getId());
            }
        });
        return recommends;
    }

    @Override
    public int insert(Recommend recommend) {
        return recommendDao.insertOrUpdate(recommend);
    }

    @Override
    public int insertAll(List<Recommend> recommends) {
        for (Recommend recommend:recommends){
            int result=this.insert(recommend);
            if (result<0){
                return -1;
            }
        }
        return 1;
    }

    @Override
    public List<Book> getHomeHotBook() {
        return recommendDao.getHomeHotBook();
    }
}
