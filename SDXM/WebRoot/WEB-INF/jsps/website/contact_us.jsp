<!DOCTYPE html>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<link rel="icon"
		  href="${pageContext.request.contextPath}/favicon.ico" type="image/x-icon" />
	<link rel="shortcut icon" href="${pageContext.request.contextPath}/favicon.ico" type="image/x-icon" />
    <title>联系我们</title>
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
								<a href="###">联系方式</a>
							</div><!--网页小目录-->
							<div class="contact_us">
								<h2>上海大学出版社</h2>
								<div class="map_box_big" id="allmap"></div>
								<ul class="contact_information_list clearfix">
									<li class="contact_us_address">
										<p>公司地址</p>
										<div></div>
										<span>上海市宝山区上大路99号</span>
									</li>
									<li class="contact_us_phone">
										<p>公司电话</p>
										<div></div>
										<span>66135122 &nbsp 66135211</span>
									</li>
									<li class="contact_us_fax">
										<p>公司传真</p>
										<div></div>
										<span>66135211345</span>
									</li>
								</ul>
								<div class="contact_barcode clearfix">
									<img class="contact_barcode_pic" src="${pageContext.request.contextPath}/websit_style/img/code.png" />
									<div class="contact_barcode_content">
										<h4>微信公众平台</h4>
										<p>请扫描左侧二维码</p>
									</div>
									<div class="contact_barcode_content">
										<h4>新浪微博</h4>
										<p>@上海大学出版社</p>
									</div>
								</div>
							</div>
							
							<div class="back_btn">
								<%--<a href="###">返回</a>--%>
							</div><!--返回按钮-->
						</div> 
					</div><!--main_banner_inner-->
					
				</div>
				
			</div>
			 <jsp:include page="footer.jsp"/>
		</div>
		<script type="text/javascript" src="${pageContext.request.contextPath}/websit_style/js/jquery-1.8.0.min.js" ></script>
		<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=wil0NU4tz8qZrAiKdYPMgeh6fKhSBuFo"></script>
		<script>
			$('.nav_list_first li').click(function(){
				$(this).addClass('on').siblings().removeClass('on');
				var liindex = $(this).index();
				$('.nav_second_list:eq('+liindex+')').slideDown().siblings('.nav_second_list').hide();
			});
			
			//地图
			// 百度地图API功能
			var map = new BMap.Map("allmap");
			var point = new BMap.Point(116.331398,39.897445);
			map.centerAndZoom(point,12);
			// 创建地址解析器实例
			var myGeo = new BMap.Geocoder();
			// 将地址解析结果显示在地图上,并调整地图视野
			myGeo.getPoint("上海市宝山区上大路99号", function(point){
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

