<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page trimDirectiveWhitespaces="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>左侧导航menu</title>
<link href="${pageContext.request.contextPath}/css/css.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="${pageContext.request.contextPath}/js/sdmenu.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js" ></script>
<script src="${pageContext.request.contextPath}/ckeditor/ckeditor.js"></script>
<script type="text/javascript">
	// <![CDATA[
	var myMenu;
	window.onload = function() {
		myMenu = new SDMenu("my_menu");
		myMenu.init();
	};
	// ]]>
</script>
<style type="text/css">
html{ SCROLLBAR-FACE-COLOR: #538ec6; SCROLLBAR-HIGHLIGHT-COLOR: #dce5f0; SCROLLBAR-SHADOW-COLOR: #2c6daa; SCROLLBAR-3DLIGHT-COLOR: #dce5f0; SCROLLBAR-ARROW-COLOR: #2c6daa;  SCROLLBAR-TRACK-COLOR: #dce5f0;  SCROLLBAR-DARKSHADOW-COLOR: #dce5f0; overflow-x:hidden;}
body{overflow-x:hidden; background:url(${pageContext.request.contextPath}/images/main/leftbg.jpg) left top repeat-y #f2f0f5; width:194px;}
</style>
</head>
<body onselectstart="return false;" ondragstart="return false;" oncontextmenu="return false;">
<div id="left-top">
	<div><img src="${pageContext.request.contextPath}/images/main/member.gif" width="44" height="44" /></div>
    <span>用户：${adminUser.userName}<br>角色：<c:choose><c:when test="${adminUser.groupCode eq 0}">超级管理员</c:when>
            <c:when test="${adminUser.groupCode eq 1}">图书管理员</c:when>
            <c:when test="${adminUser.groupCode eq 2}">信息管理员</c:when>
        </c:choose>
    </span>
</div>
    <div style="float: left" id="my_menu" class="sdmenu">
      <div id="_father">
        <span>系统设置</span>
          <a href="<c:url value='/user/main.do'/>" target="mainFrame" onfocus="this.blur()" style="display:none;">后台首页</a>
          <c:if test="${adminUser.groupCode eq 0}">
              <c:forEach var="val" items="${meunList}">
                  <c:if test="${val.url eq '/adminUser/userList.do?group=3'}">
                      <a href="<c:url value='${val.url}&authority=${val.groupcode}'/>" target="mainFrame" onfocus="this.blur()">${val.groupname}</a>
                  </c:if>
                  <c:if test="${val.url ne '/adminUser/userList.do?group=3'}">
                      <a href="<c:url value='${val.url}?authority=${val.groupcode}'/>" target="mainFrame" onfocus="this.blur()">${val.groupname}</a>
                  </c:if>
              </c:forEach>
              <a href="<c:url value='/user/column.do'/>" target="mainFrame" onfocus="this.blur()" style="display:none;">栏目管理</a>
          </c:if>
          <c:if test="${adminUser.groupCode != 0}">
              <c:forEach var="val" items="${voList}">
                  <c:if test="${val.url eq '/adminUser/userList.do?group=3'}">
                      <a href="<c:url value='${val.url}&authority=${val.groupcode}'/>" target="mainFrame" onfocus="this.blur()">${val.menuname}</a>
                  </c:if>
                  <c:if test="${val.url ne '/adminUser/userList.do?group=3'}">
                  <a href="<c:url value='${val.url}?authority=${val.groupcode}'/>" target="mainFrame" onfocus="this.blur()">${val.menuname}</a>
                  </c:if>
              </c:forEach>
          </c:if>
      </div>
    </div>
</body>
</html>
