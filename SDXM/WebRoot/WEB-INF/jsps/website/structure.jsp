<!DOCTYPE html>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
	<link rel="icon"
		  href="${pageContext.request.contextPath}/favicon.ico" type="image/x-icon" />
	<link rel="shortcut icon" href="${pageContext.request.contextPath}/favicon.ico" type="image/x-icon" />
    <title>上大出版社-组织架构</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/new_style/css/reset.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/new_style/css/main.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/new_style/css/about.css" />
</head>
<body>
	<div class="container">
			<jsp:include page="header.jsp" />
		<div class="mainbody">
			<div class="active-box">
				<a href="${pageContext.request.contextPath}/home/homeIndex.do">首页</a>
				<a href="${pageContext.request.contextPath}/home.pressCulture.do">关于我社</a>
				<a>组织架构</a>
			</div>
			<div class="section">
				<div class="section-title">
					<p>组织架构</p>
					<span>ORGANIZATIONAL STRUCTURE</span>
				</div>
				<div class="structure-detail"><img src="${pageContext.request.contextPath}/new_style/img/about/aboutus.png"/></div>
			</div>

		</div>
		<div class="footer">
			<jsp:include page="footer.jsp" />
		</div>
	</div>
</body>
</html>