<!DOCTYPE html>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<link rel="icon"
		  href="${pageContext.request.contextPath}/favicon.ico" type="image/x-icon" />
	<link rel="shortcut icon" href="${pageContext.request.contextPath}/favicon.ico" type="image/x-icon" />
    <title>我社文化详细</title>
    <!-- CSS -->
    <link href="${pageContext.request.contextPath}/websit_style/css/reset.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath}/websit_style/css/main.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath}/websit_style/css/book_detail2.css" rel="stylesheet" type="text/css">

</head>

<body>
		<div class="container">
			<jsp:include page="header.jsp"/>
			<div class="mianbody">
				<div class="main_banner clearfix">
					<div class="main_banner_bg"></div>
					<div class="main_banner_inner clearfix w1200">
						<jsp:include page="press_links.jsp"/>
						<div class="main_container">
							<div class="main_container_content2 icon_06">
								<a href="${pageContext.request.contextPath}/home/pressIntroduction.do">关于我们</a>
								<img src="${pageContext.request.contextPath}/websit_style/img/arrow_right2.jpg" alt="" />
								<a href="${pageContext.request.contextPath}/home/pressCulture.do">我社文化</a>
								<c:choose>
									<c:when test="${ not empty msg}">
										<h3 id="newsmsg">该页内容已被删除</h3>
									</c:when>
									<c:otherwise>
										<img src="${pageContext.request.contextPath}/websit_style/img/arrow_right2.jpg" alt="" />
										<a href="${pageContext.request.contextPath}/home/pressCulture.do?type=${news.type}">${type}</a>
										<img src="${pageContext.request.contextPath}/websit_style/img/arrow_right2.jpg" alt="" />
										<a href="###">详情</a>
									</c:otherwise>
								</c:choose>
							</div><!--网页小目录-->
							<p class="introduction_title_">${news.title}</p>
							<span class="title_time_">撰稿：${news.publisher}<span class="title_time2_">时间：${news.createTime}</span></span>
							<ul class="text_content_">
								<li>
									${news.content}
								</li>
							</ul>
							
							
							<div class="back_btn">
								<a href="${pageContext.request.contextPath}/home/pressCulture.do?type=${news.type}">返回</a>
							</div><!--返回按钮-->
						</div> 
					</div><!--main_banner_inner-->
					
				</div>
				
			</div>
			<jsp:include page="footer.jsp"/>
		</div>
		<script type="text/javascript" src="${pageContext.request.contextPath}/websit_style/js/jquery-1.8.0.min.js" ></script>
		<script>
			$('.nav_list_first li').click(function(){
				$(this).addClass('on').siblings().removeClass('on');
				var liindex = $(this).index();
				$('.nav_second_list:eq('+liindex+')').slideDown().siblings('.nav_second_list').hide();
			});
		</script>
	</body>

</html>

