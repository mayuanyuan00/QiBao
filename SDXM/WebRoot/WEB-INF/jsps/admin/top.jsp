<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/ckeditor/ckeditor.js"></script>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>后台管理</title>

<link rel="shortcut icon" href="${pageContext.request.contextPath}/images/favicon.ico" />
<link href="${pageContext.request.contextPath}/css/css.css" type="text/css" rel="stylesheet" />
</head>
<body onselectstart="return false" oncontextmenu=return(false) style="overflow-x:hidden;">
<!--禁止网页另存为-->
<noscript><iframe scr="*.htm"></iframe></noscript>
<!--禁止网页另存为-->
 <div class="mainmenu-area">
<table width="100%" border="0" cellspacing="0" cellpadding="0" id="header">
  <tr>
    <td rowspan="2" align="left" valign="top" id="logo"></td>
    <td align="left" valign="bottom">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td align="left" valign="bottom" id="header-name">上海大学出版社</td>
        <td align="right" valign="top" id="header-right">
        	<a  href="${pageContext.request.contextPath}/adminUser/logout.do?logoutType=admin" onFocus="this.blur()" class="admin-out" target="main">注销</a>
           
        	<a href="${pageContext.request.contextPath}/home/homeIndex.do" target="_blank" onFocus="this.blur()" class="admin-index">网站首页</a>       	
            <span>
<!-- 日历 -->
<SCRIPT type=text/javascript src="${pageContext.request.contextPath}/js/clock.js"></SCRIPT>
<SCRIPT type=text/javascript>showcal();</SCRIPT>
            </span>
        </td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td align="left" valign="bottom">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td align="left" valign="top" id="header-admin">后台管理系统</td>
        <td align="left" valign="bottom" id="header-menu" style="display:none;">
        <a href="<c:url value='/user/main.do'/>" target="mainFrame" onFocus="this.blur()" class="menuon">后台首页</a>
        <a href="<c:url value='/book/list.do'/>" target="mainFrame" onFocus="this.blur()" >用户管理</a>
        <a href="index.html" target="left" onFocus="this.blur()">栏目管理</a>
        <a href="index.html" target="left" onFocus="this.blur()">信息管理</a>
        <a href="/message/list.do" target="left" onFocus="this.blur()">留言管理</a>
        <a href="index.html" target="left" onFocus="this.blur()">附件管理</a>
        <a href="index.html" target="left" onFocus="this.blur()">站点管理</a>
        </td>
      </tr>
    </table></td>
  </tr>
</table>
</body>

</html>
