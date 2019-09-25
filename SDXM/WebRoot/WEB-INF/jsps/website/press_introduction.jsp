<!DOCTYPE html>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<link rel="icon"
		  href="${pageContext.request.contextPath}/favicon.ico" type="image/x-icon" />
	<link rel="shortcut icon" href="${pageContext.request.contextPath}/favicon.ico" type="image/x-icon" />
    <title>出版社介绍</title>
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
								<a href="###">关于我们</a>
								<img src="${pageContext.request.contextPath}/websit_style/img/arrow_right2.jpg" alt="" />
								<a href="###">出版社介绍</a>
							</div><!--网页小目录-->
							<p class="introduction_title_">上海大学出版社介绍</p>
							<c:forEach items="${collecttion}" var="news">
								<span class="title_time_" style="margin-bottom:-20px;">时间：${news.createTime}</span>
								<ul class="text_content_" >
									${news.content}
								</ul>
							</c:forEach>
							<%--<span class="title_time_">时间：2017年10月26日</span>--%>
							<%--<img class="blueimg_" src="${pageContext.request.contextPath}/websit_style/img/images/press_building.png" alt="" />--%>
							<%--<ul class="text_content_">--%>
								<%--<li>上海大学出版社成立于1996年，其创始人为我国著名科学家、教育家和社会活动家、上海大学原校长钱伟长院士。2009年底出版社完成“转企改制”，正式更名为上海大学出版社有限公司（简称“上海大学出版社”）。</li>--%>
								<%--<li>作为一家融文、理、工于一体的综合性高校出版社，上海大学出版社始终突出为教育、教学和科研服务的宗旨，多年来为学校和社会提供了一大批学术价值较高和社会影响显著的优秀图书。近年来，上海大学出版社共获2010年“中华优秀出版物提名奖”一项、国家出版基金资助项目二项、上海市文化发展基金会图书出版项目资助二十余项，在“十一五”国家级规划教材的出版工作中，也有几十部优秀教材获得国家、省、部委等的嘉奖。</li>--%>
								<%--<li>2010年底出版社新一届领导班子成立后，更加明确地提出了“十二五”时期出版社“两个服务，四个优先”的发展战略，即服务于上海大学及其他高校广大师生教学科研工作，服务于上海建设“四个中心”的城市发展战略，坚持优先满足本校教材及学术专著出版、优先支持重大项目及重点选题出版、优先开发优质合作出版项目、优先鼓励数字出版项目。</li>--%>
								<%--<li>今天的上海大学出版社，将继续发扬“团结、务实、勤奋、创新”的精神，努力成为一家具有学术影响力和品牌号召力，在国内外具有较大影响的高校出版社。</li>--%>
							<%--</ul>--%>
							<div class="back_btn">
								<%--<a href="###">返回</a>--%>
							</div><!--返回按钮-->
						</div> 
					</div><!--main_banner_inner-->
					
				</div>
				
			</div>
			 <jsp:include page="footer.jsp"/>
		</div>
		<jsp:include page="login.jsp"></jsp:include>
	
		<script type="text/javascript" src="${pageContext.request.contextPath}/websit_style/js/jquery.SuperSlide.2.1.1.source.logintab.js" ></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/websit_style/js/gverify.js" ></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/websit_style/js/login.js" ></script>
		<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=wil0NU4tz8qZrAiKdYPMgeh6fKhSBuFo"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/websit_style/js/jquery.SuperSlide.2.1.1.source.js" ></script>
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

