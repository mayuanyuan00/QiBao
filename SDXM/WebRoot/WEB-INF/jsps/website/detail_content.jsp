<!DOCTYPE html>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.7.2.min.js"></script>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<link rel="icon"
			  href="${pageContext.request.contextPath}/favicon.ico" type="image/x-icon" />
		<link rel="shortcut icon" href="${pageContext.request.contextPath}/favicon.ico" type="image/x-icon" />
        <title>图书专区二级</title>
        <!-- CSS -->   
        <link  href="${pageContext.request.contextPath}/websit_style/css/reset.css" rel="stylesheet" type="text/css">
        <link  href="${pageContext.request.contextPath}/websit_style/css/main.css" rel="stylesheet" type="text/css">
        <link  href="${pageContext.request.contextPath}/websit_style/css/book_detail.css" rel="stylesheet" type="text/css">
    
    </head>
   
  <body>
		<div class="container">
			<jsp:include page="header.jsp"></jsp:include>
			<div class="mianbody">
				<div class="main_container center">
					<div class="main_container_content2 icon_02">
						<a href="###">首页</a>>
						<a href="###">行业动态</a>
					</div><!--网页小目录-->
					<div class="word_box">
						
					</div>
					<div class="change_page">
						<a href="###" class="last_page">上一条:动态标题</a>
						<a href="###" class="next_page">下一条:动态标题</a>
					</div><!--页面转换-->
					<div class="back_btn">
						<a href="###">返回</a>
					</div><!--返回按钮-->
				</div> 
				
			</div>
				<jsp:include page="footer.jsp"></jsp:include>
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

