package cn.com.service.impl;

import cn.com.common.Constants;
import cn.com.dao.IReleaseBookDao;
import cn.com.domain.ReleaseBook;
import cn.com.service.IReleaseBookService;
import cn.com.vo.PageResults;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.io.Serializable;
import java.util.List;

/**
 * Created by Ting on 2018/4/25
 */
@Service("releaseBookService")
public class ReleaseBookServiceImpl implements IReleaseBookService {

    @Resource(name = "releaseBookDao")
    IReleaseBookDao releaseBookDao;

    @Transactional
    @Override
    public ReleaseBook getReleaseBook(int id) {
        return releaseBookDao.getEntryById(id);
    }

    @Transactional(readOnly = false)
    @Override
    public void saveReleaseBook(ReleaseBook releaseBook) {
        if (releaseBook.getIsDelete() == null || releaseBook.getIsDelete().length() > 1) releaseBook.setIsDelete("0");
        releaseBookDao.saveEntry(releaseBook);
    }

    @Transactional
    @Override
    public void updateReleaseBook(ReleaseBook releaseBook) {
        if (releaseBook.getIsDelete() == null) releaseBook.setIsDelete("0");
        releaseBookDao.updateEntry(releaseBook);
    }

    @Override
    @Transactional
    public void deleteReleaseBook(int id) {
        ReleaseBook book = this.releaseBookDao.getEntryById(id);
        if (book != null) {
            book.setIsDelete("1");
            this.releaseBookDao.saveEntry(book);
        }
    }

    @Override
    @Transactional
    public List<ReleaseBook> getAllReleaseBook() {
        return this.releaseBookDao.findObjectsByConditionWithNoPage("and isDelete = '0'");
    }

    @Override
    @Transactional
    public PageResults<ReleaseBook> getReleaseBookOfPage(int page) {
        return this.releaseBookDao.findPageByFetchedHql(
                "from ReleaseBook book where book.isDelete = '0' order by book.id desc",
                "select count(*) from ReleaseBook book where book.isDelete = '0'",
                page, 10, null);
    }

    @Override
    @Transactional
    public PageResults<ReleaseBook> searchBook(String key, int page) {
        return this.releaseBookDao.findPageByFetchedHql(
                "from ReleaseBook book where book.isDelete = '0' and book.bookName like ? ",
                "select count(*) from ReleaseBook book where book.isDelete = '0' and book.bookName like ?",
                page, Constants.PAGE_SIZE,
                new Object[]{"%" + key + "%"}
        );
    }

    @Override
    @Transactional
    public void auditingBook(Serializable id, String state) {
        ReleaseBook book = this.releaseBookDao.getEntryById(id);
        if (book != null) {
            book.setAuditing(state);
            this.releaseBookDao.updateEntry(book);
        }
    }
}
