package cn.com.service.impl;

import cn.com.dao.IKeywordsDao;
import cn.com.domain.Keywords;
import cn.com.service.IKeywordsService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by ironman on 2017/11/8.
 */
@Service("KeywordsService")
public class KeywordsServiceImpl implements IKeywordsService {
    @Resource(name="keywordsDao")
    private IKeywordsDao keywordsDao;

    @Override
    public void addKeyword(String keyword) {
        keywordsDao.saveEntry(new Keywords(keyword));
    }

    @Override
    public void addKeywords(List<String> keywords) {
        keywordsDao.addKeywords(keywords);
    }

    @Override
    public void deleteKeywordById(int id) {
        keywordsDao.deleteByIds(id);
    }

    @Override
    public void deleteKeywordByName(String keyword) {
        keywordsDao.deleteByName(keyword);
    }

    @Override
    public void deleteKeywordsByIds(List<Integer> id) {
        keywordsDao.deleteByIds(id);
    }

    @Override
    public void deleteKeywordsByName(List<String> keywords) {
        keywordsDao.deleteByNames(keywords);
    }

    @Override
    public void updateKeyword(Keywords keywords) {
        keywordsDao.updateEntry(keywords);
    }

    @Override
    public Keywords keywordOfId(int id) {
        return keywordsDao.getEntryById(id);
    }

    @Override
    public Keywords keywordOfName(String keyword) {
        List<Keywords> keywords= keywordsDao.findByName(keyword);
        return keywords.size() > 0 ? keywords.get(0) : null;
    }

    @Override
    public List<Keywords> keywordsOfIds(List<Integer> ids) {
        return keywordsDao.findByIds(ids);
    }

    @Override
    public List<Keywords> keywordsOfNames(List<String> keywords) {
        return keywordsDao.findByNames(keywords);
    }
}

