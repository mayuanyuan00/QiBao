<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>后台登录首页</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/ckeditor/ckeditor.js"></script>
<link rel="shortcut icon" href="${pageContext.request.contextPath}/images/favicon.ico" />
<link href="${pageContext.request.contextPath}/css/css.css" type="text/css" rel="stylesheet" />
</head>

<!--框架样式-->
<frameset rows="95,*,30" cols="*" frameborder="no" border="0" framespacing="0">
<!--top样式-->
	<frame src="<c:url value='/user/top.do'/>" name="topframe" scrolling="no" noresize id="topframe" title="topframe" />
<!--contact样式-->
	<frameset id="attachucp" framespacing="0" border="0" frameborder="no" cols="194,12,*" rows="*">
		<frame scrolling="auto" noresize="" frameborder="no" name="leftFrame" src="<c:url value='/user/left.do'/>"></frame>
		<frame id="leftbar" scrolling="no" noresize="" name="switchFrame" src="<c:url value='/user/swich.do' />"></frame>
		<frame scrolling="auto" noresize="" border="0" name="mainFrame" src="<c:url value='/user/main.do' />"></frame>
	</frameset>
<!--bottom样式-->
	<frame src="<c:url value='/user/bottom.do'/>" name="bottomFrame" scrolling="No" noresize="noresize" id="bottomFrame" title="bottomFrame" />
</frameset><noframes></noframes>
<!--不可以删除-->
</html>
