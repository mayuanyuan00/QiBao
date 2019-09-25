<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
	.ins_list_first li a {
		line-height: 40px;
		color: #333;
		font-size: 16px;
		font-weight: bold;
	}
	.ins_list_first li {
		width: 200px;
		text-indent: 30px;
	}
	.ins_list_first li a:hover {
		color: #8b6c50 !important;
	}
</style>
<div class="main_banner_nav">
<div class="main_banner_nav_title">
	<p>互动专区</p>
	<i>INTERACTION</i>
</div>
<div class="main_banner_nav_list clearfix">
	<ul class="ins_list_first">
		<li><a href="<c:url value='/home/bookwork.do'/>">出书业务</a></li>
		<li><a href="<c:url value='/home/contact.do'/>">联系人及联系方式</a></li>
		<li><a href="<c:url value='/home/institution.do'/>">出版社规章制度</a></li>
		</ul>
	</div>
</div><!--main_banner_nav-->

