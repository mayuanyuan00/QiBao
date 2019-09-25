package cn.com.common;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class DBConnect {
	//声明Connection对象
	Connection conn;
	//驱动程序名
	String driver = "com.mysql.jdbc.Driver";
	//URL指向要访问的数据库名
	String url = "jdbc:mysql://101.132.189.117:3306/SDXM?useSSL=false&amp;useUnicode=true&amp;characterEncoding=UTF-8";
	//MySQL配置时的用户名
	String user = "itoffice";
	//MySQL配置时的密码
	String password = "It_Office_123";
	Statement statement = null;

	 public DBConnect() throws Exception{
         init();
     }
	 public void init() throws Exception{
     try{
	      Class.forName(driver);
	      conn=DriverManager.getConnection(url,user,password);
	      statement=conn.createStatement();
	     }catch(ClassNotFoundException e){
	      System.out.println("加载数据库驱动失败！");
	      e.printStackTrace();
	     }catch (SQLException e) {
	      System.out.println("创建数据库连接失败！");
	      conn=null;
      e.printStackTrace();
	     }
	 }
}
