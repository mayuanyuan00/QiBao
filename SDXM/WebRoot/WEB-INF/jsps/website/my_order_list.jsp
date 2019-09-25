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
	<title>上大出版社-我的订单</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/new_style/css/reset.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/new_style/css/main.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/new_style/css/personal-center.css" />
</head>

<body>
		<div class="container">
			<jsp:include page="header.jsp"></jsp:include>
			<div class="mainbody">
				<div class="my_order_inner">
					<div class="active-box">
						<a>个人中心</a>
						<a href="${pageContext.request.contextPath}/home/personalInformation.do">个人信息</a>
						<a>我的订单</a>
					</div>
					<div class="my_order_list_head">我的订单</div>
					<div class="my_order_list_title">
						<div class="my_order_list_goods column">宝贝</div>
						<div class="my_order_list_price column">单价</div>
						<div class="my_order_list_number column">数量</div>
						<div class="my_order_list_sum column">金额</div>
						<div class="my_order_list_status column">交易状态</div>
						<div class="my_order_list_action column">交易操作</div>
					</div>
					<div class="my_order_search">
						<div class="my_order_list_title_checkbox">
							<div class="my_order_list_title_checkbox_container">
								<label>
									<input type="checkbox" name="my_order_list_checkbox" style="margin-top: 22px" class="my_order_checkbox_all_choose"/>
								</label>
							</div>
							全选
						</div>
						<div class="my_order_search_box">
							<input type="text" class="my_order_search_input" placeholder="请输入订单号"/>
							<span class="my_order_search_btn" onclick="return searchOrder();">订单搜索</span>
						</div>
					</div>
					<ul class="my_order_list">
					<c:forEach var="item" items="${order}" varStatus="status">
						<li class="clearfix">
							<div class="my_order_item_code">
								<div class="my_order_item_code_left">
									<div class="my_order_item_checkbox_box">
										<label>
											<input type="checkbox" name="my_order_list_checkbox" class="my_order_item_checkbox"/>
										</label>
									</div>
									<strong>下单编号</strong>
									<span>${item.orderno }</span>
								</div>
								<div class="my_order_item_code_right">
									<strong>下单时间</strong>
									<span>${item.create_date}</span>
								</div>
							</div>
						<c:forEach var="detail" items="${item.detail}" varStatus="status">
							<div class="my_order_item_content clearfix">
								<div class="my_order_list_book_pic column">
									<div class="my_order_list_book_pic_gray_circle">
										<a href="${pageContext.request.contextPath}/home/bookDetail.do?id=${detail.book.id}">
											<img src="${pageContext.request.contextPath}${detail.book.imageurl}" alt="" />
										</a>
									</div>
								</div>
								<div class="my_order_list_goods column">
									<a href="###">${detail.book.bookName}</a>
									<a href="###">作者 : ${detail.book.author}</a>
								</div>
								<div class="my_order_list_price column"><div class="my_order_list_price_inner">￥ ${detail.unit}</div></div>
								<div class="my_order_list_number column">${detail.amount}</div>
								<div class="my_order_list_sum column">￥${detail.count}</div>
								<c:if test="${status.count eq 1}">
								<div class="my_order_list_status column">
									<c:if test="${item.status==1}">
										<a class="status">提交未支付</a>
									</c:if>
									<c:if test="${item.status==2}">
										<a class="status">支付未确认</a>
									</c:if>
									<c:if test="${item.status==3}">
										<a class="status">支付已确认</a>
									</c:if>
									<c:if test="${item.status==4}">
										<a class="status">确认未发货</a>
									</c:if>
									<c:if test="${item.status==5}">
										<a class="status">发货未收货</a>
									</c:if>
									<c:if test="${item.status==6}">
										<a class="status">收货未评价</a>
									</c:if>
									<c:if test="${item.status==7}">
										<a class="status">完成</a>
									</c:if>
									<c:if test="${item.status==8}">
										<a class="status">已取消</a>
									</c:if>
								</div>
								<div class="my_order_list_action column" >
									<a href="${pageContext.request.contextPath}/order/orderdetailpage.do?orderid=${item.id}" class="">查看详情</a>
									<a href="javascript:void(0)" class="delete_this_order" onclick="deleteOder(this,${item.id})">删除订单</a>
									<c:if test="${item.status==1}">
										<a href="javascript:void(0)" class="delete_this_order" onclick="pay('${item.orderno}','${item.owner}','${item.address}')">去支付</a>
									</c:if>
								</div>
								</c:if>
								<c:if test="${status.count gt 1}">
									<div class="my_order_list_status column"></div>
									<div class="my_order_list_action column"></div>
								</c:if>
							</div>
						</c:forEach>
						</li>
					</c:forEach>
					</ul>
					<div class="page-box">
						<ul>
						<c:forEach items="${pages.pages}" var="page">
							<li><a href='<c:url value="/order/myorderlist.do"/>?page=${page.second}&status=${status}' style="color:#707070;">${page.first}</a></li>
						</c:forEach>
						</ul>
					</div>
				</div>
			</div><!--mainbody-->

			<jsp:include page="footer.jsp" />
		</div>
		<script type="text/javascript" src="${pageContext.request.contextPath}/new_style/js/jquery-1.8.0.min.js" ></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/new_style/js/main.js" ></script>
		<script type="text/javascript">
			function pay(orderno,owner,address){
                var url = "${pageContext.request.contextPath}/pay/tradepay.do?orderno="+orderno;
                // 取订单地址，收货人等信息，然后跳转地址
                // 订单收货人
//				var radioActive = $("input[name='submit_order_address_list_radio'][checked='checked']");
//				var info = radioActive.parent().parent().find("p[name='info']");
//				var owner = info.find("span[name='owner']").text();
//				var tel = radioActive.parent().parent().find("b[name='tel']").text();
                if(owner != null && (owner.replace(/(^\s*)|(\s*$)/g, "")) != "" ){
//					url += "&owner="+encodeURI(owner)+"("+tel+")";
                    url += "&owner="+encodeURI(owner);
                }

                // 订单收地址
//				var address = info.find("span[name='address']").text();
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


            //删除某订单
            function deleteOder(_this,OderId){
                var flag = confirm("确定要删除？");
                if(flag) {
                    $(_this).parent().parent().parent().remove();
                    $.get("${pageContext.request.contextPath}/order/deleteOrder.do",{id:OderId});
				}
            };
            //全选
            $('.my_order_checkbox_all_choose').click(function(){
                if($(this).prop("checked")){
                    $("[name='my_order_list_checkbox']").prop("checked",'true');
                    $("[name='my_order_list_checkbox']").parent().addClass('on');
                }
                else{
                    $("[name='my_order_list_checkbox']").removeProp("checked");
                    $("[name='my_order_list_checkbox']").parent().removeClass('on');
                }
            });
            //单选
            $('.my_order_item_checkbox').click(function(){
                if($(this).prop("checked")){
                    $(this).parent().addClass('on');
                }
                else{
                    $(this).parent().removeClass('on');
                }
            });
            //搜索订单
			function searchOrder() {
				var orderno = $('.my_order_search_input').val();
				if(orderno.trim()==""){
				    alert("订单号不能为空");
				    return;
				}
				window.location = "${pageContext.request.contextPath}/order/myorderlist.do?orderno="+orderno;
            }
		</script>
	</body>

</html>
