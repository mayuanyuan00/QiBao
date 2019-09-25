package cn.com.dao.impl;


import cn.com.dao.IRecommendDao;
import cn.com.dao.base.impl.BaseDaoImpl;
import cn.com.domain.Book;
import cn.com.domain.Recommend;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

@Repository("recommendDao")
public class RecommendDaoImpl  extends BaseDaoImpl<Recommend> implements IRecommendDao{
    @Override
    @Transactional
    public int insertOrUpdate(Recommend recommend) {
        String sql = "insert into recommend (id,hot_book,`comment`,`author_name`) VALUES (?,?,?,?)" +
                "on DUPLICATE key update hot_book=?,`comment`=?,`author_name`=?";
        Object[] items=new Object[]{recommend.getId(),recommend.getHotBook(),recommend.getComment(),recommend.getAuthorName(),recommend.getHotBook(),recommend.getComment(),recommend.getAuthorName()};
        Session session = this.getSession();
        SQLQuery sqlQuery = session.createSQLQuery(sql);
        if (items != null && items.length > 0) {
            for (int i = 0; i < items.length; i++) {
                sqlQuery.setParameter(i, items[i]);
            }
        }
        return sqlQuery.executeUpdate();
    }

    @Override
    @Transactional
    public List<Book> getHomeHotBook() {
        String sql ="SELECT b.id,b.book_name,b.imageurl,b.author,b.author_img,b.author_intro,a.`comment`,b.contentvalidity,b.ISBN,b.price,b.publication_date " +
                "from recommend a JOIN book b on a.hot_book=b.id WHERE b.is_delete='0' and b.auditing = '3' ORDER BY a.id";
        Session session = this.getSession();
        SQLQuery sqlQuery = session.createSQLQuery(sql);
        List<Object[]> objects=sqlQuery.list();
        List<Book> books=new ArrayList<>();
        for (int i=0;i<objects.size();i++){
            Object[] o = objects.get(i);
            Book book=new Book();
            book.setId((Integer) o[0]);
            book.setBookName((String) o[1]);
            book.setImageurl((String) o[2]);
            book.setAuthor((String) o[3]);
            book.setAuthorImg((String)o[4]);
            book.setAuthorIntro((String)o[5]);
            book.setAuditing((String)o[6]);
            book.setContentvalidity((String)o[7]);
            book.setIsbn((String)o[8]);
            book.setPrice((BigDecimal) o[9]);
            book.setPublicationDate((String)o[10]);
            books.add(book);
        }
        return books;
    }
}
