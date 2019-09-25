<!DOCTYPE html>
<%@page import="cn.com.utils.RandomStringUtil"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8" contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<link rel="icon"
		  href="${pageContext.request.contextPath}/favicon.ico" type="image/x-icon" />
	<link rel="shortcut icon" href="${pageContext.request.contextPath}/favicon.ico" type="image/x-icon" />
	<title>点击进入</title>
	<!-- CSS -->
	<link  href="${pageContext.request.contextPath}/websit_style/css/reset.css" rel="stylesheet" type="text/css">
	<link  href="${pageContext.request.contextPath}/websit_style/css/main.css" rel="stylesheet" type="text/css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/websit_style/css/animate.css" />

</head>

<body>
<div class="enter_box">
	<div class="enter_inner">
		<div class="enter_center">
			<div class="enter_center_inner">
				<img class="enter_ani enter_logo" src="${pageContext.request.contextPath}/websit_style/img/enter_logo.jpg" />
				<img class="enter_ani enter_pic" src="${pageContext.request.contextPath}/websit_style/img/enter_pic.jpg" />
				<img class="enter_ani enter_icon" src="${pageContext.request.contextPath}/websit_style/img/enter_icon.jpg" />
				<img class="enter_ani enter_arrow" src="${pageContext.request.contextPath}/websit_style/img/enter_arrow.jpg" />
				<a class="enter_ani enter_a" href="${pageContext.request.contextPath}/home/homeIndex.do">
					<span>点击进入</span>
					<span>ENTER</span>
				</a>
			</div>
		</div>
	</div>
</div>
<div class="enter_footer">
	<span class="enter_footer_left">发行热线：021-66135109 总编办电话：021-66135122 地址：上海市宝山区上大路99号 </span>
	<span class="enter_footer_left" style="margin-left:100px">  <a href="http://www.beian.gov.cn/portal/registerSystemInfo?recordcode=17050402"><font color="#271e1b">沪ICP备17050402号</font></a>  </span>
	<span class="enter_footer_right" style="color: #271e1b;">Copyright © 2017 <a>www.shupress.cn</a> Inc. All Rights Reserved. 上海大学出版社 版权所有</span>
</div>
<script type="text/javascript" src="${pageContext.request.contextPath}/websit_style/js/jquery-1.8.0.min.js" ></script>
<script>
    ani();
    function ani(){
        adcl('enter_logo','show animated fadeInDownBig');
        setTimeout("adcl('enter_pic','show animated fadeInLeftBig')",500);
        setTimeout("adcl('enter_icon','show animated bounceIn')",1500);
        setTimeout("adcl('enter_arrow','show animated bounceIn')",1500);
        setTimeout("adcl('enter_a','show animated bounceIn')",1500);
    }




    function adcl(tag,cl){
        $('.'+tag).addClass(cl);
    }
</script>
</body>

</html>

