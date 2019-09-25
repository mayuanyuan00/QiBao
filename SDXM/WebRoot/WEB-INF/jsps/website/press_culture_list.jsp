<!DOCTYPE html>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<link rel="icon"
		  href="${pageContext.request.contextPath}/favicon.ico" type="image/x-icon" />
	<link rel="shortcut icon" href="${pageContext.request.contextPath}/favicon.ico" type="image/x-icon" />
    <title>我社文化</title>
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
								<a href="${pageContext.request.contextPath}/home/pressIntroduction.do">关于我们</a>
								<img src="${pageContext.request.contextPath}/websit_style/img/arrow_right2.jpg" alt="" />
								<a href="/home/pressCulture.do">我社文化</a>
								<img src="${pageContext.request.contextPath}/websit_style/img/arrow_right2.jpg" alt="" />
								<a href="###" class="taggerkx">科研文化</a>
							</div><!--网页小目录-->
							<div class="culture_list_tab">
								<div class="hd">
									<ul class="clearfix"><li>科研文化</li><li>学术文化</li></ul>
								</div>
								<div class="bd">
									<ul class="scientific">
										<ul class="news_list">
										<li>
											<h3></h3>
										</li>
										</ul>
											<ul class="page_box">

											</ul>
									</ul>
									<ul class="academic">
										<ul class="news_list">
										<li>
											<h3></h3>
										</li>
										</ul>
										<ul class="page_box">

										</ul>
									</ul>

								</div>
							</div>
							
						</div> 
					</div><!--main_banner_inner-->
					
				</div>
				
			</div>
			 <jsp:include page="footer.jsp"/>

		</div>
		<script type="text/javascript" src="${pageContext.request.contextPath}/websit_style/js/jquery-1.8.0.min.js" ></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/websit_style/js/main.js" ></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/websit_style/js/jquery.SuperSlide.2.1.1.source.js" ></script>
		<script>
            window.onload = function () {scientific(1); }
            $('.nav_list_first li').click(function(){
                $(this).addClass('on').siblings().removeClass('on');
                var liindex = $(this).index();
                $('.nav_second_list:eq('+liindex+')').slideDown().siblings('.nav_second_list').hide();
            });
			$('.news_picture_right p').txtCur({n:70});
			//科研文化tab切换
			jQuery(".culture_list_tab").slide({trigger:"click"});
			$(".clearfix>li:eq(0)").click(function () {
                $(".taggerkx").text("科研文化");
                scientific(1);
            })
			$(".clearfix>li:eq(1)").click(function () {
                $(".taggerkx").text("学术文化");
             	academic(1);
            })
			function academic(cutpage) {
                $.ajax({
                    url:"${pageContext.request.contextPath}/home/academicJson.do?type=19&page="+cutpage,
                    dataType:"json",
                    success:function (data) {
                        data=eval("("+data+")");
                        if(cutpage==1) {
                            var totalPages = (data.length / 5) + 1;
                            $(".academic .page_box").children("li").remove();
                            var a_li = $("<li><a href='#'onclick='academic(1)'>首页</a></li>");
                            $(".academic .page_box").append(a_li);
                            for (var i = 1; i <= totalPages; i++) {
                                var c_li = $("<li><a href='#'onclick='academic(" + i + ")'>" + i + "</a></li>");
                                if (i == cutpage) {
                                    c_li.addClass("on");
                                }
                                $(".academic .page_box").append(c_li);
                            }
                            b_li = $("<li><a href='#'onclick='academic(" + (totalPages) + ")'>尾页</a></li>");
                            $(".academic .page_box").append(b_li);
                        }
                        $(".academic .page_box li:eq("+cutpage+")").css("background-color","#939393");
                        $(".academic .page_box li").not(".academic .page_box li:eq("+cutpage+")").css("background-color","");
                        $(".academic .news_list").children("li").remove();
                        if(data==null){
                            $(".academic h3").text("暂无新闻");
                        }else {
                            for(var i=0;i<data.length;i++){
                                var value=data[i];
                                // 新建li元素
                                var li = $("<li class='clearfix'></li>");
                                // href
                                var href = "${pageContext.request.contextPath}/news/detail.do?id=" + value.id + "&type=19" + "&page=" +${currentPage};
                                // 新建 a元素（存放img）
                                var a_img = $("<a class='news_picture'></a>");
                                a_img.attr("href", href);
                                if(value.pics != null) {
                                    // 新建 img 元素
                                    var img = $("<img />");
                                    img.attr("src", "${pageContext.request.contextPath}" + value.pics);
                                    a_img.append(img);
                                }
                                //新建div
                                var div = $("<div class='news_picture_right'></div>");
                                // 新建a元素（title)
                                var a_title = $("<a class='news_title'></a>");
                                a_title.attr("href", href);
                                // 新建h3
                                var h3 = $("<h3></h3>");
                                h3.text(value.title);
                                // h3插入a_title
                                a_title.append(h3);
                                // 新建span
                                var span = $("<span></span>");
                                span.html(value.createTime);
                                // 新建p
                                var p = $("<p></p>");
                                p.text(value.summary + "...");
                                // a（阅读详情）
                                var a_detail = $("<a class='read_details'>阅读详情</a>");
                                a_detail.attr("href", href);
                                //a_title插入div
                                div.append(a_title);
                                div.append(span);
                                div.append(p);
                                div.append(a_detail);
                                //
                                li.append(a_img);
                                li.append(div);
                                $(".academic .news_list").append(li);
                            }
                        }
                    }
                })
            }
			function scientific(cutpage) {
                $.ajax({
                    url:"${pageContext.request.contextPath}/home/academicJson.do?type=18&page="+cutpage,
                    dataType:"json",
                    success:function (data) {
                        data=eval("("+data+")");
                        if(cutpage==1) {
                            var totalPages = (data.length / 5) + 1;
                            $(".scientific .page_box").children("li").remove();
                            var a_li = $("<li><a href='#'onclick='scientific(1)'>首页</a></li>");
                            $(".scientific .page_box").append(a_li);
                            for (var i = 1; i <= totalPages; i++) {
                                var c_li = $("<li><a href='#'onclick='scientific(" + i + ")'>" + i + "</a></li>");
                                $(".scientific .page_box").append(c_li);
                            }
                            b_li = $("<li><a href='#'onclick='scientific(" + (totalPages) + ")'>尾页</a></li>");
                            $(".scientific .page_box").append(b_li);
                        }
                        $(".scientific .page_box li:eq("+cutpage+")").css("background-color","#939393");
                        $(".scientific .page_box li").not(".scientific .page_box li:eq("+cutpage+")").css("background-color","");
                        $(".scientific .news_list").children("li").remove();
                        if(data==null){
                            $(".scientific h3").text("暂无新闻");
                        }else {
                            for(var i=0;i<data.length;i++){
                                var value=data[i];
                                // 新建li元素
                                var li = $("<li class='clearfix'></li>");
                                // href
                                var href = "${pageContext.request.contextPath}/news/detail.do?id=" + value.id + "&type=18" + "&page=" +${currentPage};
                                // 新建 a元素（存放img）
                                var a_img = $("<a class='news_picture'></a>");
                                a_img.attr("href", href);
                                if(value.pics != null) {
                                    // 新建 img 元素
                                    var img = $("<img />");
                                    img.attr("src", "${pageContext.request.contextPath}" + value.pics);
                                    a_img.append(img);
                                }
                                //新建div
                                var div = $("<div class='news_picture_right'></div>");
                                // 新建a元素（title)
                                var a_title = $("<a class='news_title'></a>");
                                a_title.attr("href", href);
                                // 新建h3
                                var h3 = $("<h3></h3>");
                                h3.text(value.title);
                                // h3插入a_title
                                a_title.append(h3);
                                // 新建span
                                var span = $("<span></span>");
                                span.html(value.createTime);
                                // 新建p
                                var p = $("<p></p>");
                                p.text(value.summary + "...");
                                // a（阅读详情）
                                var a_detail = $("<a class='read_details'>阅读详情</a>");
                                a_detail.attr("href", href);
                                //a_title插入div
                                div.append(a_title);
                                div.append(span);
                                div.append(p);
                                div.append(a_detail);
                                //
                                li.append(a_img);
                                li.append(div);
                                $(".scientific .news_list").append(li);
                            }
                        }
                    }
                })
            }


		</script>
	</body>
</html>

