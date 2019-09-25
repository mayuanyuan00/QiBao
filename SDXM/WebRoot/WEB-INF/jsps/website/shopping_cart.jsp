<%@ page language="java" import="java.util.*" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>

	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<link rel="icon"
		  href="${pageContext.request.contextPath}/favicon.ico" type="image/x-icon" />
	<link rel="shortcut icon" href="${pageContext.request.contextPath}/favicon.ico" type="image/x-icon" />
	<title>上大出版社—购物车</title>
	<!-- CSS -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/new_style/css/reset.css"/>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/new_style/css/main.css"/>
	<link href="${pageContext.request.contextPath}/new_style/css/personal-center.css" rel="stylesheet" type="text/css">

</head>

<body>

<div class="container">
	<jsp:include page="header.jsp"></jsp:include>
	<div class="mianbody pb465">
		<div class="shopping_cart_inner">
			<div class="active-box">
				<a href="${pageContext.request.contextPath}/home/personalInformation.do">个人中心</a>
				<a href="${pageContext.request.contextPath}/home/personalInformation.do">个人信息</a>
				<a href="${pageContext.request.contextPath}/cart/shoppingcart.do">购物车</a>
			</div>
			<div class="shopping_list_head">所有商品</div>
			<div class="shopping_list_title">
				<div class="shopping_title_checkbox column">
					<div class="shopping_title_checkbox_container">
						<label>
							<input type="checkbox" name="cart_list_checkbox" class="checkbox_all_choose"
								   style="vertical-align:middle;"/>
							<span style="vertical-align:middle;">全选</span>
						</label>
					</div>
				</div>
				<div class="shopping_title_goods column">商品信息</div>
				<div class="shopping_title_price column">单价</div>
				<div class="shopping_title_number column">数量</div>
				<div class="shopping_title_sum column">金额</div>
				<div class="shopping_title_action column">操作</div>
			</div>
			<ul class="shopping_items">

				<c:forEach var="item" items="${cart}" varStatus="status">

					<li id="item${item.book.id}" class="clearfix">
						<div class="shopping_items_checkbox column">
							<label>
								<input type="checkbox" name="cart_list_checkbox" class="checkbox_item_amount"/>
							</label>
						</div>
						<div class="shopping_items_goods column">
							<div class="cart_book_BG">
								<a href="###">
									<img src="${pageContext.request.contextPath}${item.book.imageurl}" alt=""/>
								</a>
							</div>
							<div class="cart_book_BG_right">
								<h4><a href="###">${item.book.bookName}</a></h4>
								<p>作者: ${item.book.author}</p>
							</div>
						</div>
						<div class="shopping_items_price column">
							<em data-price="${item.book.price}"
								class="item_single_price_num">￥<span>${item.book.price}</span></em>
						</div>
						<div class="shopping_items_number column">
							<a class="cart_num_minus">-</a>
							<input type="text" value="${item.count}" class="cart_num_input" style="height:38px;"
								   readonly="readonly"/>
							<a class="cart_num_add">+</a>
						</div>
						<div class="shopping_items_sum column">
							<em data-price="${item.count * item.book.price}"
								class="item_sum_price_num">￥<span>${item.count * item.book.price}</span></em>
						</div>
						<div class="shopping_items_action column">
							<a href="javascript:void(0)" onclick="collection(${item.book.id})" class="add_into_favourites">移入收藏夹</a>
							<a href="javascript:_removeItem(${item.book.id},this);" class="delete_items">删除</a>
						</div>
					</li>

				</c:forEach>
			</ul>

			<div class="shopping_cart_operation">
				<div class="shopping_cart_operation_inner shopping_cart_operation_inner_fixed">
					<div class="shopping_cart_operation_left">
						<div class="shopping_operation_checkbox column">
							<div class="shopping_operation_checkbox_container">
								<label>
									<input type="checkbox" name="cart_list_checkbox" class="checkbox_all_choose"
										   style="vertical-align:middle;"/>
									<span style="vertical-align:middle;">全选</span>
								</label>
							</div>
						</div>
					</div>
					<div class="shopping_cart_operation_right">
						<input type="button" value="结算" class="shopping_operation_btn" onclick="_count_()"/>
						<div class="shopping_operation_price_sum">
							应付总额
							<em>￥</em>
							<em class="Allmoney">0.00</em>
						</div>
						<div class="shopping_operation_amount_sum">
							已选择
							<em class="items_total_amount">0</em>
							件商品
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="footer.jsp"></jsp:include>
</div>
</div>
<script type="text/javascript" src="${pageContext.request.contextPath}/new_style/js/jquery-1.8.0.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/new_style/js/main.js"></script>
<script type="text/javascript">
    //结算工具条
    $(window).scroll(function () {
        var scrollTop = $(window).scrollTop(),
            offsetTop = $('.footer').offset().top,
            item = $('.shopping_cart_operation_inner');
        if (scrollTop <= offsetTop - 90 - window.innerHeight) {
            if (!item.hasClass('shopping_cart_operation_inner_fixed')) {
                item.addClass('shopping_cart_operation_inner_fixed');
            }
        } else {
            if (item.hasClass('shopping_cart_operation_inner_fixed')) {
                item.removeClass('shopping_cart_operation_inner_fixed');
            }
        }
    });

    //添加数量
    $('.cart_num_add').click(function () {
        var nownum = parseInt($(this).prev().attr("value"));//获取原有购买数量
        var nowPrice = $(this).parent().prev().find(".item_single_price_num span");//获取商品单价对象
        var nowPriceSum = $(this).parent().next().find(".item_sum_price_num span");//获取商品总价对象
        var nowCheck = $(this).parents('li').find(".checkbox_item_amount");//获取当前商品的checkbox对象
        var allNum = parseInt($('.items_total_amount').text());//获取现有订单数量
        var allMoney = parseFloat($('.Allmoney').text());//获取现有订单价格
        if (nownum <= 99) {//数量判断
            nownum++;//数量增加
            $(this).prev().attr("value", nownum);//数量改变
            var Price = (parseFloat(nowPrice.text()) * nownum).toFixed(2);//保留两位小数
            nowPriceSum.text(Price);//价格赋值
            if (nowCheck.is(':checked') ) {//是否选中判断
                $('.items_total_amount').text(allNum+1);
                $('.Allmoney').text((allMoney + parseFloat(nowPrice.text())).toFixed(2));
            }
        } else {
            alert('已达最大购买数量');
        }
    });
    //减少数量
    $('.cart_num_minus').click(function () {
        var nownum = parseInt($(this).next().attr("value"));//获取原有购买数量
        var nowPrice = $(this).parent().prev().find(".item_single_price_num span");//获取商品单价对象
        var nowPriceSum = $(this).parent().next().find(".item_sum_price_num span");//获取商品总价对象
        var nowCheck = $(this).parents('li').find(".checkbox_item_amount");//获取当前商品的checkbox对象
        var allNum = parseInt($('.items_total_amount').text());//获取现有订单数量
        var allMoney = parseFloat($('.Allmoney').text());//获取现有订单价格
        if (nownum > 1) {//数量判断
            nownum--;//数量减少
            $(this).next().attr("value", nownum);
            var Price = (parseFloat(nowPrice.text()) * nownum).toFixed(2);//保留两位小数
            nowPriceSum.text(Price);//价格赋值
            if (nowCheck.is(':checked') ) {//是否选中判断
                $('.items_total_amount').text(allNum-1);
                $('.Allmoney').text((allMoney - parseFloat(nowPrice.text())).toFixed(2));
            }
        } else {
            alert('不能减少');
        }
    });
    //手动修改数量
    $('.cart_num_input').change(function () {
        var nownum = parseInt($(this).val());//获取原有购买数量
        var nowPrice = $(this).parent().prev().find(".item_single_price_num span");//获取商品单价对象
        var nowPriceSum = $(this).parent().next().find(".item_sum_price_num span");//获取商品总价对象
        var oldPriceSum = parseFloat($(this).parent().next().find(".item_sum_price_num span").text());//记录现在当前商品总价
        var nowCheck = $(this).parents('li').find(".checkbox_item_amount");//获取当前商品的checkbox对象
        var allNum = parseInt($('.items_total_amount').text());//获取现有订单数量
        var allMoney = parseFloat($('.Allmoney').text());//获取现有订单价格
        if (Number.isInteger(nownum)) {
            if (nownum > 0 && nownum < 100) {
                $(this).attr("value", nownum);
                var Price = (parseFloat(nowPrice.text()) * nownum).toFixed(2);//保留两位小数
                nowPriceSum.text(Price);//价格赋值
                if (nowCheck.is(':checked') ) {//是否选中判断
                    $('.Allmoney').text((allMoney - oldPriceSum + parseFloat(nowPriceSum.text())).toFixed(2));
                }
            } else {
                alert('请输入1-99范围内的整数');
            }
        } else {
            alert('请输入整数');
        }

    });

    //删除商品
    $('.delete_items').click(function () {
        var nownum = parseInt($(this).parents('li').find('.cart_num_input').val());//获取该商品数量
        var nowPrice = parseFloat($(this).parents('li').find('.item_sum_price_num span').text());//获取该商品总价
        var nowCheck = $(this).parents('li').find(".checkbox_item_amount");//获取该商品选择框状态
        var allNum = parseInt($('.items_total_amount').text());//获取现有订单数量
        var allMoney = parseFloat($('.Allmoney').text());//获取现有订单价格
        if (nowCheck.is(':checked') ) {//判断是否选中
            $('.items_total_amount').text(allNum -nownum);
            $('.Allmoney').text((allMoney - nowPrice).toFixed(2));
        }
        $(this).parent().parent().remove();//删除这个商品
    });

    function _removeItem(id,my){

        $.post("${pageContext.request.contextPath}/cart/remove.do",
            {itemid:id},function(result){
                if(result == "success"){
                    $("#item"+id).remove();
                }
            });
    }

    function add_num(id,amount){
        $.post("${pageContext.request.contextPath}/cart/add.do",
            {itemid:id,amount:amount},function(result){
                //TODO 判断成功了增加数量


            });
    }

    //全选
    $('.checkbox_all_choose').click(function () {
        if ($(this).prop("checked")) { //全选
            var allPrice = 0;//初始价格
            var bookNum = 0;//初始数量
            for (var i = 0; i < $('.item_sum_price_num').length; i++) {//轮询取价格相加
                allPrice = allPrice + parseFloat($('.item_sum_price_num:eq(' + i + ') span').text());//商品价格累加
                bookNum = bookNum + parseInt($('.cart_num_input:eq(' + i + ')').val());//商品件数累加
            }
            allPrice = allPrice.toFixed(2);//保留两位小数
            $('.Allmoney').text(allPrice);//价格赋值
            $('.items_total_amount').text(bookNum);//商品件数
            $("[name='cart_list_checkbox']").prop("checked", true);//全选
            $("[name='cart_list_checkbox']").parent().addClass("on");
        }
        else { //移除全选
            $('.Allmoney').text('0.00');//价格赋值
            $('.items_total_amount').text('0');//商品件数
            $("[name='cart_list_checkbox']").removeProp("checked");
            $("[name='cart_list_checkbox']").parent().removeClass("on");
        }
    });

    //单独勾选
    $('.checkbox_item_amount').click(function () {
        var bookNum = parseInt($(this).parents('li').find('.cart_num_input').val());//获取书本数量
        var bookPrice = parseFloat($(this).parents('li').find('.item_sum_price_num span').text());//获取单个商品总价
        var allNum = parseInt($('.items_total_amount').text());//获取现有订单数量
        var allMoney = parseFloat($('.Allmoney').text());//获取现有订单价格
        if ($(this).prop('checked')) {//判断是否选中
            $('.items_total_amount').text(allNum + bookNum);
            $('.Allmoney').text((allMoney + bookPrice).toFixed(2));
            $(this).prop("checked", true);
            $(this).parent().addClass("on");
        } else {
            $('.items_total_amount').text(allNum - bookNum);
            $('.Allmoney').text((allMoney - bookPrice).toFixed(2));
            $(this).removeProp("checked");
            $(this).parent().removeClass("on");
        }
    });

    //结算
    function _count_() {
        //TODO取出选中，判断是否全选
        var items = [];
        $('.checkbox_item_amount:checked').each(function (i) {
            var _id = $(this).parent().parent().parent().attr("id").replace("item","");
            var bookNum = parseInt($(this).parents('li').find('.cart_num_input').val());//获取书本数量
            add_num(_id,bookNum);
            items.push(parseInt(_id));
        });
        if (items.length == 0) {
            alert("请选择您要购买的项目！");
        } else {
            alert("提交成功！");
            window.location.href = '${pageContext.request.contextPath}/order/cartcommit.do?items=' + items.join(',');
        }
    }

    //移入收夹藏
    function collection(id) {
        $.ajax({
            url:"${pageContext.request.contextPath}/collection/add.do?itemid="+id,
            type:"get",
            success:function (data) {
                alert("收藏成功！")
            }
        })
    }

</script>
</body>

</html>