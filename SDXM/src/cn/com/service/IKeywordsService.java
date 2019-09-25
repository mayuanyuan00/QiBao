package cn.com.service;

import cn.com.domain.Keywords;

import java.util.List;

/**
 * Created by ironman on 2017/11/8.
 */
public interface IKeywordsService {
    // 新增一个keyword
    void addKeyword(String keyword);

    // 批量新增keywords
    void addKeywords(List<String> keywords);

    // 按照id删除一个keyword
    void deleteKeywordById(int id);

    // 按照名删除一个keyword
    void deleteKeywordByName(String keyword);

    // 按照id批量删除keywords
    void deleteKeywordsByIds(List<Integer> id);

    // 按照名批量删除keywords
    void deleteKeywordsByName(List<String> keywords);

    // 修改keyword
    void updateKeyword(Keywords keywords);

    // 按id获取一个keyword
    Keywords keywordOfId(int id);

    // 按名获取一个keyword
    Keywords keywordOfName(String keyword);

    // 按一组id获取keywords
    List<Keywords> keywordsOfIds(List<Integer> ids);

    // 按照一组名获取keywords
    List<Keywords> keywordsOfNames(List<String> keywords);

}
