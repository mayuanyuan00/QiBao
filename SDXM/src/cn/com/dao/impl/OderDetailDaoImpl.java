package cn.com.dao.impl;

import cn.com.dao.IOderDetailDao;
import cn.com.dao.base.impl.BaseDaoImpl;
import cn.com.domain.OrderDetail;
import cn.com.vo.Charts;
import org.hibernate.Session;
import org.hibernate.SQLQuery;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Repository("oderDetailDao")
public class OderDetailDaoImpl extends BaseDaoImpl<OrderDetail> implements IOderDetailDao {

    @Override
    @Transactional()
    public List<Charts> selectCharts(String myYear) {
        String sql = "SELECT bb.parentid,f.`month`,SUM(f.`count`) as `count` FROM " +
                "(SELECT c.`month`,c.count,d.booktypeid as type from " +
                "(SELECT aaa.id,aaa.`month`,sum(aaa.num*book.price) as count from book " +
                "left join (SELECT b.itemid as `id`,month(a.create_date) as `month`,sum(b.amount) as num " +
                "from `torder` as a JOIN order_detail b on a.id=b.orderid " +
                "where a.`status`=7 and YEAR(a.create_date)=? GROUP BY MONTH(a.create_date),b.itemid) as aaa on book.id=aaa.id " +
                "GROUP BY  book.id,aaa.`month`) as c JOIN bookcontacts as d on c.id=d.bookid GROUP BY c.`month`,c.count,d.booktypeid) AS f " +
                "JOIN booktype as bb ON bb.id=f.type GROUP BY f.`month`,bb.parentid";
        Session session = this.getSession();
        SQLQuery sqlquery = session.createSQLQuery(sql);
        sqlquery.setParameter(0,myYear);
        List<Charts> list = new ArrayList<>();
        List<Object[]> objects = (List<Object[]>) sqlquery.list();
        for (int i = 0; i < objects.size(); i++) {
            Charts charts = new Charts();
            Object[] o = objects.get(i);
            charts.setParentid((Integer) o[0]);
            charts.setMonth(o[1]);
            charts.setCount(o[2]);
            list.add(i, charts);
        }
        return list;
    }
}
