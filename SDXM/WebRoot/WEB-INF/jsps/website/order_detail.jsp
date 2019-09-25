<!DOCTYPE html>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
	<link rel="icon"
		  href="${pageContext.request.contextPath}/favicon.ico" type="image/x-icon" />
	<link rel="shortcut icon" href="${pageContext.request.contextPath}/favicon.ico" type="image/x-icon" />
	<title>上大出版社-订单确认</title>
	<!-- CSS -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/new_style/css/reset.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/new_style/css/main.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/new_style/css/personal-center.css" />
</head>

<body>
<div class="container">
	<jsp:include page="header.jsp"/>
	<div class="mainbody">
		<div class="order_confirm">
			<div class="submit_order_confirm">
				<h3>订单详细</h3>
				<div class="submit_order_confirm_head">
					<div class="submit_order_confirm_goods column">商品信息</div>
					<div class="submit_order_confirm_price column">单价</div>
					<div class="submit_order_confirm_number column">数量</div>
					<div class="submit_order_confirm_sum column">金额</div>
				</div>
				<ul class="submit_order_confirm_list">
					<c:forEach var="item" items="${detail}" varStatus="status">
						<li class="clearfix">
							<div class="submit_order_confirm_book_pic column">
								<div class="submit_order_confirm_book_pic_BG">
									<a href="###"><img src="${pageContext.request.contextPath}${item.book.imageurl}" alt="" /></a>
								</div>
							</div>
							<div class="submit_order_confirm_goods column">
								<a href="###">${item.book.bookName}</a>
								<span>作者：${item.book.author}</span>
							</div>
							<div class="submit_order_confirm_price column">
								<p>￥${item.unit}</p>
							</div>
							<div class="submit_order_confirm_number column">
								<p>${item.amount}</p>
							</div>
							<div class="submit_order_confirm_sum column">
								<p>￥${item.count}</p>
							</div>
						</li>
					</c:forEach>
				</ul>
			</div>
			<div class="submit_order_list_price_sum">
				<p>合计 ￥<i>${order.count }</i></p>
			</div>
			<div class="submit_order_operation">
				<div class="submit_order_information">
					<p class="submit_order_information_sum">实付款: ￥<span>${order.count }</span></p>
					<p class="submit_order_information_add"><span>寄送至： </span> <span id="new_address">${order.address}<span></span></p>
					<p class="submit_order_information_receiver"><span>收货人：</span><span id="new_owner">${order.owner }<span></span></p>
				</div>
			</div>
			<div class="submit_order_btn">
			</div>
		</div>
	</div><!--mainbody-->

	<jsp:include page="footer.jsp" />
</div>
<script type="text/javascript" src="${pageContext.request.contextPath}/new_style/js/jquery-1.8.0.min.js" ></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/new_style/js/main.js" ></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/new_style/js/distpicker.data.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/new_style/js/distpicker.js"></script>
<script type="text/javascript">
</script>
</body>
</html>

