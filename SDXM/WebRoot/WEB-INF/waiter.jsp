<!DOCTYPE html>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
	<link rel="icon"
		  href="${pageContext.request.contextPath}/favicon.ico" type="image/x-icon" />
	<link rel="shortcut icon" href="${pageContext.request.contextPath}/favicon.ico" type="image/x-icon" />
	<title>上大出版社-首页</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/new_style/css/reset.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/new_style/css/main.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/new_style/css/about.css" />
</head>
<body>
	<div class="container">
		<jsp:include page="/WEB-INF/jsps/website/header.jsp"></jsp:include>
		<div class="mainbody">
			<p class="waiter">敬请期待</p>
		</div>
		<%@page import="org.springframework.web.context.support.WebApplicationContextUtils" %>
		<%@page import="org.springframework.web.context.WebApplicationContext" %>
		<%@ page import="cn.com.service.ILinksService" %>
		<%@ page import="cn.com.domain.Links" %>
		<%@ page import="cn.com.vo.PageResults" %>
		<%
			WebApplicationContext context=WebApplicationContextUtils.getWebApplicationContext(session.getServletContext());
			ILinksService linksService = (ILinksService) context.getBean("linksService");
			PageResults<Links> linksResults = linksService.getLinksByPage(1);
			List<Links> urlList = linksResults.getResults();
			request.setAttribute("urlList",urlList);
		%>


		<jsp:include page="/WEB-INF/jsps/website/footer.jsp" />
		
	</div>

</body>
</html>