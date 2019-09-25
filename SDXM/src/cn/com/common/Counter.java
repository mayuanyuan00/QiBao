/*
 * Counter.java 
 * Version: 1.0
 * Copyright 
 * ALL Rights Reserved.
 */

package cn.com.common;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.Date;
/**
 * 网站访问次数统计
 * @author  bail 2017/12/25
*/

public class Counter {
	private final static String TABLE_NAME = "visitorcounter";
	 private static String today = null;
	 private static long today_num = 0;
	 private static long total_num = 0;
	 //加载访问量
	 public static void loadNum(){
	  if(total_num<1)
	   loadTotalNum();
	  if(today_num<1)
	   loadToadyNum();
	 }
	 //加载今日访问量
	 private static void loadToadyNum() {
	  // TODO Auto-generated method stub
	  DBConnect db = null;
	  ResultSet rs = null;
	  if(today==null)
	   today = getTodayDate();
	  String sql = "select vnum from "+TABLE_NAME+" where vdate='"+today+"'";
	  try {
	   db = new DBConnect();
	   rs = db.statement.executeQuery(sql);
	   if(rs.next()){
	    today_num = rs.getLong("vnum");
	   }
	   else
	   {    
	    sql = "insert into "+TABLE_NAME+"(vdate,vnum) values('"+today+"',0)";
	    db.statement.executeUpdate(sql);
	    today_num = 0;
	   }
	  } catch (Exception e) {
	   // TODO: handle exception
	   today_num = 0;
	   System.out.println("com.hdzx.pub~VisitorCounter.incTotalCounter:获得访问人数");
	  }
	 }
	 //加载总访问量
	 private static void loadTotalNum() {
	  // TODO Auto-generated method stub
	  // TODO Auto-generated method stub
	  DBConnect db = null;
	  ResultSet rs = null;
	  if(today==null)
	   today = getTodayDate();
	  String sql = "select vnum from "+TABLE_NAME+" where id=1";
	  try {
	   db = new DBConnect();
	   rs = db.statement.executeQuery(sql);
	   if(rs.next()){
	    total_num = rs.getLong("vnum");
	   }
	   else
	   {
	    total_num = 0;
	   }
	  } catch (Exception e) {
	   // TODO: handle exception
	   total_num = 0;
	   System.out.println("com.hdzx.pub~VisitorCounter.incTotalCounter:获得访问人数");
	  }
	 }
	 //增加总的访问量
	 private static int incTotalCounter(){
	  int k = 0;
	  DBConnect db = null;
	  loadNum(); 
	  total_num = total_num+1;
	  String sql = "update "+TABLE_NAME+" set vnum="+total_num+" where id=1";
	  try {
	   db = new DBConnect();
	   k = db.statement.executeUpdate(sql);
	  } catch (Exception e) {
	   // TODO: handle exception
	   System.out.println("com.hdzx.pub~VisitorCounter.incTotalCounter:增加访问人数");
	  }
	  return k;
	 }
	 //增加今日的访问量
	 public static int incTodayCounter(){
	  int k  = 0;
	  DBConnect db = null;
	  String sql = null;
	  loadNum();
	  today_num += 1;
	  sql = "update "+TABLE_NAME+" set vnum="+today_num+" where vdate='"+today+"'";
	  try {
	   db = new DBConnect();
	   k = db.statement.executeUpdate(sql);
	   if(k > 0)
	    incTotalCounter();
	  } catch (Exception e) {
	   // TODO: handle exception
	   System.out.println("com.hdzx.pub~VisitorCounter.incTotalCounter:增加访问人数");
	  }
	  return k;
	 }
	 //获得今天的日期
	 private static String getTodayDate(){
	  SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	  return sdf.format(new Date());
	 }
	 ///获得今日访问量
	 public static long getTodayNum(){
	  loadNum();
	  return today_num;
	 }
	 //获得总的访问量
	 public static long getTotalNum(){
	  loadNum();
	  return total_num;
	 } 
}
