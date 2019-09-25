package cn.com.service;

import cn.com.domain.ReleaseBook;
import cn.com.vo.PageResults;

import java.io.Serializable;
import java.util.List;

/**
 * Created by Ting on 2018/4/25
 */
public interface IReleaseBookService {

    ReleaseBook getReleaseBook(int id);

    void saveReleaseBook(ReleaseBook releaseBook);

    void updateReleaseBook(ReleaseBook releaseBook);

    void deleteReleaseBook(int id);

    List<ReleaseBook> getAllReleaseBook();

    PageResults<ReleaseBook> getReleaseBookOfPage(int page);

    PageResults<ReleaseBook> searchBook(String key, int page);

    void auditingBook(Serializable id, String state);

}
