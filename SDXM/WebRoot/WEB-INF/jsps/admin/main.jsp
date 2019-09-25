<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page trimDirectiveWhitespaces="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>主要内容区main</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/ckeditor/ckeditor.js"></script>
<link rel="shortcut icon" href="${pageContext.request.contextPath}/images/favicon.ico" />
<link href="${pageContext.request.contextPath}/css/css.css" type="text/css" rel="stylesheet" />
<style>
body{overflow-x:hidden; background:#f2f0f5; padding:15px 0px 10px 5px;}
#main{ font-size:12px;}
#main span.time{ font-size:14px; color:#528dc5; width:100%; padding-bottom:10px; float:left}
#main div.top{ width:100%; background:url(${pageContext.request.contextPath}/images/main/main_r2_c2.jpg) no-repeat 0 10px; padding:0 0 0 15px; line-height:35px; float:left}
#main div.sec{ width:100%; background:url(${pageContext.request.contextPath}/images/main/main_r2_c2.jpg) no-repeat 0 15px; padding:0 0 0 15px; line-height:35px; float:left}
.left{ float:left}
#main div a{ float:left}
#main span.num{  font-size:30px; color:#538ec6; font-family:"Georgia","Tahoma","Arial";}
.left{ float:left}
div.main-tit{ font-size:14px; font-weight:bold; color:#4e4e4e; background:url(${pageContext.request.contextPath}/images/main/main_r4_c2.jpg) no-repeat 0 33px; width:100%; padding:30px 0 0 20px; float:left}
div.main-con{ width:100%; float:left; padding:10px 0 0 20px; line-height:36px;}
div.main-corpy{ font-size:14px; font-weight:bold; color:#4e4e4e; background:url(${pageContext.request.contextPath}/images/main/main_r6_c2.jpg) no-repeat 0 33px; width:100%; padding:30px 0 0 20px; float:left}
div.main-order{ line-height:30px; padding:10px 0 0 0;}
</style>
</head>

<body>
<!--main_top-->
<table width="99%" border="0" cellspacing="0" cellpadding="0" id="main">
  <tr>
    <td colspan="2" align="left" valign="top">
    <span class="time"><strong>你好！${adminUser.userName}</strong><u>[<c:choose><c:when test="${adminUser.groupCode eq 0}">超级管理员</c:when>
            <c:when test="${adminUser.groupCode eq 1}">图书管理员</c:when>
            <c:when test="${adminUser.groupCode eq 2}">信息录入员</c:when></c:choose>]</u></span>

    <div class="sec"></div>
    </td>
  </tr>
  <tr>
    <td align="left" valign="top" width="50%">
    <div class="main-tit">网站信息</div>
    <div class="main-con">
    会员注册：开启<br/>
会员投稿：开启<br/>
管理员个数：<font color="#538ec6"><strong>${count}</strong></font> 人<br/>
登陆者IP：${ip}<br/>
程序编码：UTF-8<br/>
版本信息：1.0<br/>
更新日期：<SCRIPT type=text/javascript src="${pageContext.request.contextPath}/js/clock.js"></SCRIPT><SCRIPT type=text/javascript>showDate();</SCRIPT><br/>
    </div>
    </td>
    <td align="left" valign="top" width="49%">
    <div class="main-tit">服务器信息</div>
    <div class="main-con">
服务器软件：TomCat (Win64)<br/>

MYSQL版本：5.0.45-community-nt<br/>
使用域名：202.120.117.23 <br/>
    </div>
    </td>
  </tr>
  <tr>
    <td colspan="2" align="left" valign="top">
    <div class="main-corpy">系统提示</div>
    <div class="main-order">1=>如您在使用过程有发现出错请及时与我们取得联系；为保证您得到我们的后续服务，强烈建议您购买我们的正版系统或向我们定制系统！<br/>
2=>强烈建议您将IE8以上版本或其他的浏览器</div>
    </td>
  </tr>
</table>
</body>
</html>
