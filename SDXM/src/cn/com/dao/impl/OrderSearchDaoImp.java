package cn.com.dao.impl;

import cn.com.common.Constants;
import cn.com.dao.IOrderSearchDao;
import cn.com.dao.base.impl.BaseDaoImpl;
import cn.com.vo.OrderInfo;
import cn.com.vo.PageResults;
import org.apache.poi.ss.formula.functions.T;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Repository("orderSearchDao")
public class OrderSearchDaoImp extends BaseDaoImpl<OrderInfo> implements IOrderSearchDao{

    @Override
    @Transactional()
    public  PageResults<OrderInfo> selectOrder(int year,int month, int page) {
        StringBuffer buf=new StringBuffer();
        String s1="SELECT count(*) FROM (SELECT ols.orderno,ols.amount,ols.create_date as `date`,b.book_name " +
                "AS `name`,b.price,sum(ols.amount*b.price) AS num,ols.status,ols.id " +
                "FROM (SELECT o.orderno,o.create_date,ol.itemid,ol.amount,o.status,o.id " +
                "FROM `torder` AS o JOIN order_detail ol ON o.id=ol.orderid " +
                "WHERE o.`status`!=9 ";
        buf.append(s1);
        if(year!=0){
            String s2="and month(o.create_date)=? and year(o.create_date)=? ";
            buf.append(s2);
        }
        String s3=") AS ols LEFT JOIN book b on b.id=ols.itemid " +
                "GROUP BY ols.amount,ols.create_date,ols.orderno,b.book_name,b.price,ols.status,ols.id) as a";
        buf.append(s3);

        String sqlCount=buf.toString();
        Session session = this.getSession();
        Query query = session.createSQLQuery(sqlCount);
        if(year!=0){
            query.setParameter(0,month);
            query.setParameter(1,year);
        }
        PageResults<OrderInfo> retValue = new PageResults<OrderInfo>();
        int currentPage = page > 1 ? page : 1;
        retValue.setCurrentPage(currentPage);
        retValue.setPageSize(Constants.PAGE_SIZE);
        Object result=query.uniqueResult();
        Long count;
        if (result instanceof BigInteger) {
            count=((BigInteger) result).longValue();
        }
        else {
            count=(Long)result;
        }
        retValue.setTotalCount(count.intValue());
        int start=(currentPage-1)*Constants.PAGE_SIZE;
        int size=Constants.PAGE_SIZE;
        StringBuffer buf1=new StringBuffer();
        String s4="SELECT ols.orderno,ols.amount,ols.create_date as `date`,b.book_name,b.price,sum(ols.amount*b.price) " +
                "AS num,ols.status,ols.id " +
                "FROM (SELECT o.orderno,o.create_date,ol.itemid,ol.amount,o.status,o.id " +
                "FROM `torder` AS o JOIN order_detail ol ON o.id=ol.orderid " +
                "WHERE o.`status`!=9 ";
        buf1.append(s4);
        if(year!=0){
            String s5="and month(o.create_date)=? and year(o.create_date)=? ";
            buf1.append(s5);
        }
        String s6=") AS ols LEFT JOIN book AS b on b.id=ols.itemid " +
                "GROUP BY ols.amount,ols.create_date,ols.orderno,b.book_name,b.price,ols.status,ols.id ORDER BY ols.create_date DESC LIMIT ?,?";
        buf1.append(s6);
        String sql=buf1.toString();
        SQLQuery sqlquery = session.createSQLQuery(sql);
        if(year!=0){
            sqlquery.setParameter(0,month);
            sqlquery.setParameter(1,year);
            sqlquery.setParameter(2,start);
            sqlquery.setParameter(3,size);
        }else {
            sqlquery.setParameter(0,start);
            sqlquery.setParameter(1,size);
        }

        List<OrderInfo> list = new ArrayList<>();
        List<Object[]> objects = (List<Object[]>) sqlquery.list();
        for (int i = 0; i < objects.size(); i++) {
           OrderInfo order= new OrderInfo();
            Object[] o = objects.get(i);
            order.setOrderno((String) o[0]);
            order.setAmount((Integer)o[1]);
            order.setDate((Date) o[2]);
            order.setName((String) o[3]);
            order.setPrice(o[4]);
            order.setNum(o[5]);
            order.setStatus((String)o[6]);
            order.setId((Integer)o[7]);
            list.add(i, order);
        }
        retValue.setResults(list);
        return retValue;
    }

}
