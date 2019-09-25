<!DOCTYPE html>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="cn.com.common.Counter" %>
<html>
<head>
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
	    <jsp:include page="header.jsp"></jsp:include>
	    <div class="mainbody">
			<div class="second-banner"></div>
			<div class="active-box">
				<a href="${pageContext.request.contextPath}/home/honmeIndex.do">首页</a>
				<a>关于我社</a>
			</div>
			<div class="section clearfix">
				<div class="about-left">
					<c:choose>
						<c:when test="${fn:startsWith(about.pics,'http')}">
							<img src="${about.pics}"/>
						</c:when>
						<c:otherwise>
							<img src="${pageContext.request.contextPath}${about.pics}"/>
						</c:otherwise>
					</c:choose>
				</div>
				<div class="about-right">
					<p class="about-title">关于我们</p>
					<p class="about-en">ABOUT US</p>
					<div class="about-word">
						${about.summary}
						<%--上海大学出版社成立于1996年，其创始人为我国著名科学家、教育家和社会活动家、上海大学原校长钱伟长院士。--%>
						<%--2009年底出版社完成“转企改制”，正式更名为上海大学出版社有限公司（简称“上海大学出版社”）。--%>
						<%--作为一家融文、理、工于一体的综合性高校出版社，上海大学出版社始终突出为教育、教学和科研服务的宗旨，多年来为学校和社会提供--%>
						<%--了一大批学术价值较高和社会影响显著的优秀图书。近年来，上海大学出版社共获2010年“中华优秀出版物提名奖”--%>
						<%--一项、国家出版基金资助项目二项、上海市文化发展基金会图书出版项目资助二十余项，在“十一五”国家级规划教材的出版工作中，也有几十部优秀教材获得国家、省、部委等的嘉奖。--%>
					</div>
					<span class="readmore"><a href="${pageContext.request.contextPath}/home/systemdetail.do?id=${about.id}" style="color: white">阅读更多</a></span>
				</div>
			</div>
			<div class="bg-pic">
				<div class="section">
					<div class="section-title white">
						<p>组织结构</p>
						<span>ORGANIZATIONAL STRUCTURE</span>
					</div>
					<div class="section-more clearfix white"><a href="${pageContext.request.contextPath}/home/structure.do">更多</a></div>
					<div class="structure-pic"><img src="${pageContext.request.contextPath}/new_style/img/about/about.png"/></div>
				</div>
			</div>
			<div class="section">
				<div class="section-title">
					<p>我社文化</p>
					<span>OUR CULTURE</span>
				</div>
				<div class="about-nav-list clearfix">
					<ul>
						<li class="on">科研文化</li><li>学术文化</li>
					</ul>
					<a class="more" href="${pageContext.request.contextPath}/home/newsList.do?type=-1">更多</a>
				</div>
				<div class="news-list about-nav-tab clearfix">
					<ul>
						<c:forEach var="news" items="${research}" varStatus="status">
							<li class="clearfix">
								<span class="news-pic">
										<img src="${pageContext.request.contextPath}${news.pics}"/>
								</span>
								<div class="news-info">
									<p class="news-time"><span>${news.createTime}</span><i></i></p>
									<p class="news-title">${news.title}</p>
									<p class="news-intro">${news.summary}</p>
									<a class="more-btn" href="${pageContext.request.contextPath}/home/systemdetail.do?id=${news.id}">阅读更多</a>
								</div>

							</li>
						</c:forEach>
					</ul>
				</div>
				<div class="news-list about-nav-tab clearfix">
					<ul>
						<c:forEach var="aca" items="${academic}" varStatus="status">
							<li class="clearfix">
								<span class="news-pic"><img src="${pageContext.request.contextPath}${aca.pics}" /></span>
								<div class="news-info">
									<p class="news-time"><span>${aca.dateStr}</span><i>${news.yearStr}</i></p>
									<p class="news-title">${aca.title}</p>
									<p class="news-intro">${aca.summary}</p>
									<a class="more-btn" href="${pageContext.request.contextPath}/home/systemdetail.do?id=${aca.id}">阅读更多</a>
								</div>
							</li>
						</c:forEach>
					</ul>
				</div>
			</div>

			<div class="bg-gray">
				<div class="section">
					<div class="section-title">
						<p>联系我们</p>
						<span>CONTACT US</span>
					</div>
					
					<div class="contact-list clearfix">
						<ul>
							<li>
								<p class="contact-icon"><img src="${pageContext.request.contextPath}/new_style/img/about/icon_address.png"/></p>
								<p class="contact-title">公司地址</p>
								<p class="contact-word">上海市宝山区上大路99号</p>
							</li>
							<li>
								<p class="contact-icon"><img src="${pageContext.request.contextPath}/new_style/img/about/icon_phone.png"/></p>
								<p class="contact-title">公司电话</p>
								<p class="contact-word">021-66135122</p>

							</li>
							<li>
								<p class="contact-icon"><img src="${pageContext.request.contextPath}/new_style/img/about/icon_fax.png"/></p>
								<p class="contact-title">公司传真</p>
								<p class="contact-word">021-66135122</p>
							</li>
						</ul>
					</div>
					
				</div>
			</div>


			<div class="section">
				<div class="map" id="allmap"></div>
			</div>
		</div>
	    <jsp:include page="footer.jsp" />
    </div>

	<script type="text/javascript" src="${pageContext.request.contextPath}/new_style/js/jquery-1.8.0.min.js" ></script>
	<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=oB7bO3nOgHVIz8IUsAsO6ZI59Gqb4mne"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/new_style/js/main.js" ></script>
	<script>
		$(function () {
			<c:if test="${lastType eq 19}">
            $('.about-nav-list li').eq(1).addClass('on').siblings('li').removeClass('on');
            $('.about-nav-tab').eq(1).show().siblings('.about-nav-tab').hide();
			</c:if>
        })
		$('.about-nav-list li').click(function(){
			var liindex = $(this).index();
			$(this).addClass('on').siblings('li').removeClass('on');
			$('.about-nav-tab').eq(liindex).show().siblings('.about-nav-tab').hide();
		});
		$('.about-nav-list li:first-child').trigger('click');

		//地图
		// 百度地图API功能
		var map = new BMap.Map("allmap");
		var point = new BMap.Point(116.331398,39.897445);
		map.centerAndZoom(point,12);
		// 创建地址解析器实例
		var myGeo = new BMap.Geocoder();
		// 将地址解析结果显示在地图上,并调整地图视野
		myGeo.getPoint("上海市宝山区锦秋路928号", function(point){
			if (point) {
				map.centerAndZoom(point, 16);
				map.addOverlay(new BMap.Marker(point));
			}else{
				alert("您选择地址没有解析到结果!");
			}
		}, "北京市");
	</script>
</body>
</html>