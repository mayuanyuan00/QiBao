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
	<title>上大出版社-我的收藏</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/new_style/css/reset.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/new_style/css/main.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/new_style/css/personal-center.css" />
	<style>
		.search_input{
			width: 226px;
			height: 38px;
			line-height: 48px;
			border: 1px solid #898989;
			border-right: none;
			padding: 0px 10px;
			float: left;
			font-size: 14px;
		}
	</style>
</head>
<body>
	<div class="container">
		<jsp:include page="header.jsp" />
		<div class="mainbody">
			<div class="my_collection_inner">
				<div class="active-box">
					<a href="${pageContext.request.contextPath}/home/personalInformation.do">个人中心</a>
					<a href="${pageContext.request.contextPath}/home/personalInformation.do">个人信息</a>
					<a>我的收藏</a>
				</div>
				<div class="my_collection_head">我的收藏</div>
				<ul class="my_collection_list clearfix">
					<c:forEach var="book" items="${collection}" varStatus="status">
						<li>
							<div class="my_collection_item_checkbox_container">
								<label>
									<input type="hidden" value="${book.id}">
									<input type="checkbox" name="my_collection_list_checkbox" class="my_collection_item_checkbox"/>
								</label>
							</div>
							<div class="my_collection_book_pic">
								<a href="###"><img src="${pageContext.request.contextPath}${book.imageurl}" alt="" /></a>
							</div>
							<h4 class="my_collection_book_title"><a href="###">${book.bookName}</a></h4>
							<div class="my_collection_book_content clearfix">
								<span class="my_collection_book_writer">作者: ${book.author}</span>
								<span class="my_collection_book_type">开本: ${book.folio}开</span>
							</div>
							<div class="my_collection_item_price">￥<span>${book.price}</span></div>

							<div class="my_collection_item_bottom clearfix">
								<span href="###" class="my_collection_add_cart" onclick="_addCart(${book.id})">加入购物车</span>
								<span href="###" class="my_collection_delete_item" onclick="_collectionRemove(${book.id})">删除</span>
							</div>
						</li>
					</c:forEach>
				</ul>
				<div class="my_collection_tool_bar">
					<div class="my_collection_tool_bar_checkbox">
						<div class="my_collection_tool_bar_checkbox_container">
							<input type="checkbox" class="my_collection_checkbox_all_choose"/>
						</div>
						全选
					</div>
					<div class="my_collection_chosen_delete">
						<!--<input type="button" value="批量删除" />-->
						批量删除
					</div>
					<div class="my_collection_pay">
						<!--<input type="button" value="加入购物车" />-->
						加入购物车
					</div>
				</div>
			</div>
		</div><!--mainbody-->
		
		<jsp:include page="footer.jsp" />
		</div>
	</div>
	<script type="text/javascript" src="${pageContext.request.contextPath}/new_style/js/jquery-1.8.0.min.js" ></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/new_style/js/main.js" ></script>
	<script type="text/javascript">

		//删除某收藏
		$('.my_collection_delete_item').click(function(){
		    var flag = confirm("确认删除");
		    if (flag){
                $(this).parent().parent().remove();
			}
		});
		//批量删除
		$('.my_collection_chosen_delete').click(function(){
		    var flag = confirm("确认删除");
		    if(flag){
                $('.my_collection_list').find(':checkbox').each(function () {
                    if ($(this).is(":checked")) {
                        //操作
                        _collectionRemove($(this).siblings().val());
                        $(this).parent().parent().parent().remove();

                    }
                });
			}
            });

		//全选
		$('.my_collection_checkbox_all_choose').click(function(){
			if($(this).prop("checked")){ 
				$("[name='my_collection_list_checkbox']").prop("checked",'true');
				$("[name='my_collection_list_checkbox']").parent().addClass('on');
			} 
			else{ 
				$("[name='my_collection_list_checkbox']").removeProp("checked"); 
				$("[name='my_collection_list_checkbox']").parent().removeClass('on');
			} 
		});
		//单选
		$('.my_collection_item_checkbox').click(function(){
			if($(this).prop("checked")){ 
				$(this).parent().addClass('on');
			} 
			else{ 
				$(this).parent().removeClass('on');
			}
		});

        function _collectionRemove(id){
                $.post("${pageContext.request.contextPath}/collection/remove.do",
                    {itemid:id},function(result){
                        if(result == "success"){
                            $("#collection"+id).remove();
                        }
                    });
        }

        //加入购物车
        function _addCart(id){
            var amount = 1;
            amount = amount < 1 ? 1:amount;
            $.post("${pageContext.request.contextPath}/cart/add.do",
                {itemid:id,amount:amount},function(result){
                    if(result == "success"){
                        _collectionRemove(id);
                    }
                });
            alert("成功加入购物车");
        }

        //多选加入购物车
        $('.my_collection_pay').click(function(){
            $('.my_collection_list clearfix').find(':checkbox').each(function () {
                if ($(this).is(":checked")) {
                    //操作
                    _addCart($(this).siblings().var());
                }
            });
            alert("成功加入购物车")
        });



	</script>
</body>
</html>
