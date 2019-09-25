<!DOCTYPE html>
<%@ page language="java" import="java.util.HashMap" pageEncoding="utf-8" %>
<%@ page import="java.util.Map" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<link rel="icon"
		  href="${pageContext.request.contextPath}/favicon.ico" type="image/x-icon" />
	<link rel="shortcut icon" href="${pageContext.request.contextPath}/favicon.ico" type="image/x-icon" />
	<title>联系人及联系方式</title>

	<!-- CSS -->
	<link href="${pageContext.request.contextPath}/websit_style/css/reset.css" rel="stylesheet" type="text/css">
	<link href="${pageContext.request.contextPath}/websit_style/css/main.css" rel="stylesheet" type="text/css">
	<link href="${pageContext.request.contextPath}/websit_style/css/book_detail.css" rel="stylesheet" type="text/css">

	<style type="text/css">
		.ellipsis {
			overflow: hidden;
			text-overflow: ellipsis;
			white-space: nowrap;
		}
	</style>

</head>

<body>
<div class="container">
	<jsp:include page="header.jsp"/>
	<div class="mianbody">
		<div class="main_banner clearfix">
			<div class="main_banner_bg"></div>
			<div class="main_banner_inner clearfix w1200">
				<jsp:include page="contact_links.jsp"/>
				<div class="main_container" >
				<div class="main_container_content2 icon_03">
					<a href="###">互动专区</a>
					<img src="${pageContext.request.contextPath}/websit_style/img/arrow_right2.jpg" alt="" />
					<a href="###">联系人及联系方式</a>
				</div><!--网页小目录-->
				<div class="fill_in_your_information">
					<input type="hidden" value="${message}">
					<h3>请填写您的信息</h3>
					<form action="<c:url value='/contacts/submit_contacts.do'/>" method="post">
						<div class="fill_in_your_name clearfix">
							<p>姓名</p>
							<input type="text" name="linkman" placeholder="请输入您的姓名" required/>
						</div>
						<div class="fill_in_your_phone_number clearfix">
							<p>电话</p>
							<input type="text" name="phone" class="phone" placeholder="请输入您的电话" required/>
						</div>
						<div class="fill_in_your_email clearfix">
							<p>邮箱</p>
							<input type="text" name="mail" class="mail" placeholder="请输入您的邮箱" required/>
						</div>
						<div class="fill_in_your_words clearfix" >
							<p>留言</p>
							<input type="text" name="message" placeholder="请输入您的留言信息" required/>
						</div>
						<input type="submit" value="提交" class="submit_btn" style="cursor: hand;"/>
						<%
							double d = Math.random();
							String flag = Double.toString(d);
							session.setAttribute("flag",flag);
						%>
						<input type="hidden" name="flag" value="<%=flag%>">
					</form>
				</div>
				<div class="back_btn">
					<a href="${pageContext.request.contextPath}/home/homeIndex.do">返回</a>
				</div><!--返回按钮-->
			</div>
			</div><!--main_banner_inner-->

		</div>

	</div>
	<jsp:include page="footer.jsp"/>
</div>
<script type="text/javascript" src="${pageContext.request.contextPath}/websit_style/js/jquery-1.8.0.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/websit_style/js/gverify.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/websit_style/js/jquery.SuperSlide.2.1.1.source.logintab.js" ></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/websit_style/js/login.js"></script>
<script type="text/javascript">
    /*$('.nav_list_first li').click(function(){
        $(this).addClass('on').siblings().removeClass('on');
        var liindex = $(this).index();
        $('.nav_second_list:eq('+liindex+')').slideDown().siblings('.nav_second_list').hide();
    });*/
    $(function () {
        if($("input[type=hidden]").val() != ""){
            alert($("input[type=hidden]").val());
        }
    });
    $(".phone").blur(function () {
            var pattern=/^\d{7,11}$/g;
            if(pattern.test($(this).val())){
                $(this).css("color","#333");
            }else {
                alert("您的电话有误！");
                return false;
            }
        });
    $(".mail").blur(
        function () {
            var pattern=/^(\w)+(\.\w+)*@(\w)+((\.\w+)+)$/;
            if(pattern.test($(this).val())){
                $(this).css("color","#333");
            }else {
                alert("您的邮箱有误！");
            }
        }
    );
</script>
</body>

</html>

