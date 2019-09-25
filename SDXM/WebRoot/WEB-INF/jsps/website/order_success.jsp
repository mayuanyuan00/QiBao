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
					<div class="submit_order_address">
						<h3>确认收货地址</h3>
					<c:if test="${not empty sessionScope.address}">
						<ul class="submit_order_address_list clearfix">
							<c:forEach items="${sessionScope.address}" var="address" varStatus="status">
								<li <c:if test="${status.count==1}"> class="active"</c:if>>
								<span style="display: none" class="shipAddress_id">${address.id}</span>
								<div class="submit_order_address_list_top">
									<span class="submit_order_address_list_province">${address.province}</span>
									<span class="submit_order_address_list_city">${address.city}</span>
									<span class="submit_order_address_list_receiver">（${address.consignee}收）</span>
								</div>
								<span class="submit_order_address_list_address">${address.area} ${address.addressDetail}</span>
								<span class="submit_order_address_list_phone">${address.tel}</span>
								<span class="submit_order_address_list_modification">修改地址</span>
							</li>
							</c:forEach>
						</ul>
					</c:if>
						<!--<div class="submit_order_address_list_manage_address">管理收货地址</div>-->
						<input type="button" value="使用新地址" class="submit_order_address_list_add_btn"/>
					</div>
					<div class="submit_order_confirm">
						<h3>确认订单地址</h3>
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
						<input type="button" value="返回购物车" onclick="backshipping();" class="submit_order_back_btn"/><input type="button" value="提交订单" class="submit_order_submit_btn" onclick="tradepay();"/>
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
            (function(){
                refreshAdderss();
                $('.submit_order_address_list_address').txtCur({n:50});

                $('.submit_order_address_list li').click(function(){
                    $(this).addClass('active').siblings().removeClass('active');
                    refreshAdderss()

                })
            })();
            //提交支付
            function tradepay(){
                var orderno = "${order.orderno}";
                var url = "${pageContext.request.contextPath}/pay/tradepay.do?orderno="+orderno;
                // 取订单地址，收货人等信息，然后跳转地址
                // 订单收货人
//				var radioActive = $("input[name='submit_order_address_list_radio'][checked='checked']");
//				var info = radioActive.parent().parent().find("p[name='info']");
//				var owner = info.find("span[name='owner']").text();
//				var tel = radioActive.parent().parent().find("b[name='tel']").text();
                var owner=$("#new_owner").text();
                if(owner != null && (owner.replace(/(^\s*)|(\s*$)/g, "")) != "" ){
//					url += "&owner="+encodeURI(owner)+"("+tel+")";
                    url += "&owner="+encodeURI(owner);
                }

                // 订单收地址
//				var address = info.find("span[name='address']").text();
                var address = $("#new_address").text();
                if(address != null && (address.replace(/(^\s*)|(\s*$)/g, "")) != "" ){
                    url += "&address="+encodeURI(address);
                }else{
                    alert("地址不能为空 ！");
                    return;
                }
                //TODO 订单主题
                var subject = "";
                if(subject != null && (subject.replace(/(^\s*)|(\s*$)/g, "")) != "" ){
                    url += "&subject="+encodeURI(subject);
                }
                //TODO 订单描述
                var desc = "";
                if(desc != null && (desc.replace(/(^\s*)|(\s*$)/g, "")) != "" ){
                    url += "&desc="+encodeURI(desc);
                }
                window.location.href = url;
            }
			//返回购物车
            function backshipping() {
                window.location.href = "${pageContext.request.contextPath}/cart/shoppingcart.do";
            }
			//新增收货地址
            $('.submit_order_address_list_add_btn').click(function(){
                shade.addAddressShade();
                $('#area_box').distpicker();
            });
            //修改某地址
            $(".submit_order_address_list_modification").click(function () {
                shade.addAddressShade();
                var address_id = $(this).siblings(".shipAddress_id").html();
                $.ajax({
                    url:"${pageContext.request.contextPath}/user/getShippingAddress.do?id="+address_id,
                    type:"GET",
                    success:function (address) {
                        $("#address_id_not_show").val(address.id);
                        $("#add_new_address_address").val(address.addressDetail);
                        $("#add_new_address_code").val(address.code);
                        $("#add_new_address_receiver").val(address.consignee);
                        $("#add_new_address_phone").val(address.tel);
                        var phone = address.phone.split("-");
                        $("#add_new_address_phone1").val(phone[0]);
                        $("#add_new_address_phone2").val(phone[1]);
                        $("#add_new_address_phone3").val(phone[2]);
                        $('#area_box').distpicker({
                            province: address.province,
                            city: address.city,
                            district: address.area
                        });
                    }
				})
            })
			//更新地址
			function refreshAdderss(){
				var address_id = $('li.active>span.shipAddress_id').html();
                $.ajax({
                    url:"${pageContext.request.contextPath}/user/getShippingAddress.do?id="+address_id,
                    type:"GET",
					success: function (address) {
						$('#new_address').html(address.province+"-"+address.city+"-"+address.area+"  "+address.addressDetail);
						$('#new_owner').html(address.consignee+"("+address.tel+")");
                    }
				})
            }
		</script>
	</body>
</html>

