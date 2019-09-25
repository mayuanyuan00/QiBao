<!DOCTYPE html>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<link rel="icon"
		  href="${pageContext.request.contextPath}/favicon.ico" type="image/x-icon" />
	<link rel="shortcut icon" href="${pageContext.request.contextPath}/favicon.ico" type="image/x-icon" />
	<title>规章制度列表</title>
	<!-- CSS -->
	<link  href="${pageContext.request.contextPath}/websit_style/css/reset.css" rel="stylesheet" type="text/css">
	<link  href="${pageContext.request.contextPath}/websit_style/css/main.css" rel="stylesheet" type="text/css">

	<link  href="${pageContext.request.contextPath}/css/paginate.css" rel="stylesheet" type="text/css">
	<link  href="${pageContext.request.contextPath}/websit_style/css/book_detail2.css" rel="stylesheet" type="text/css">
	<style>
		#page_number{
			height: 30px;
			line-height: 30px;
			font-size: 16px;
			position: relative;
			margin-top:20px;
			margin-bottom: 20px;
		}

	</style>
</head>

<body>
<div class="container">
	<jsp:include page="header.jsp"></jsp:include>
	<div class="mianbody">
		<div class="main_banner clearfix">
			<div class="main_banner_bg"></div>
			<div class="main_banner_inner clearfix w1200">
				<jsp:include page="contact_links.jsp"/><!--main_banner_nav-->
				<div class="main_container">
					<div class="main_container_content2 icon_03">
						<a href="###">互动专区</a>><a href="###">相关出版规章制度</a>
					</div><!--网页小目录-->
					<c:choose>
						<c:when test="${newsList != null}">
							<ul class="news_list">
								<c:forEach items="${newsList}" var="news" varStatus="status">
									<li class="clearfix">
										<c:choose>
											<c:when test="${not empty news.pics}">
												<a class="news_picture" href="${pageContext.request.contextPath}/news/detail.do?id=${news.id}&type=${news.type}&listType=${type}&page=${currentPage}"><img src="${pageContext.request.contextPath}${news.pics}" alt="" /></a>
											</c:when>
											<c:otherwise>
												<a class="news_picture" href="${pageContext.request.contextPath}/news/detail.do?id=${news.id}&type=${news.type}&listType=${type}&page=${currentPage}"></a>
											</c:otherwise>
										</c:choose>
										<div class="news_picture_right">
											<a href="${pageContext.request.contextPath}/news/detail.do?id=${news.id}&type=${news.type}&listType=${type}&page=${currentPage}" class="news_title"><h3>${news.title}</h3></a>
											<span>${news.createTime}</span>
											<p>${news.summary}...</p>
											<a href="${pageContext.request.contextPath}/news/detail.do?id=${news.id}&type=${news.type}&listType=${type}&page=${currentPage}" class="read_details">阅读详情</a>
										</div>
									</li>
								</c:forEach>
							</ul>
						</c:when>
						<c:otherwise>
							<h3>暂无新闻</h3>
						</c:otherwise>
					</c:choose>

					<div id="page_number">
					</div>

				</div>
			</div><!--main_banner_inner-->

		</div>

	</div>
	<jsp:include page="footer.jsp"></jsp:include>
</div>


<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js" ></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.paginate.js"></script>
<script>
    $(function(){
        var totalPages = ${pageCount};
        var currentPage = ${currentPage};
        var type = ${type};
       // $('.news_picture_right p').txtCur({n:70});
        $('.nav_list_first li').click(function(){
            $(this).addClass('on').siblings().removeClass('on');
            var liindex = $(this).index();
           // $('.nav_second_list:eq('+liindex+')').slideDown().siblings('.nav_second_list').hide();
        });

        $("#page_number").paginate({
            count: totalPages,
            start: currentPage,
            display: 7,
            border: true,
            border_color: '#b8b8b8',
            text_color: '#000',
            background_color: '#FFF',
            text_hover_color: '#FFF',
            background_hover_color: '#b2b2b2',
            onChange: function(page) {
                $.ajax({
                    url: '${pageContext.request.contextPath}/news/newsList.do',
                    data: {type: type, page: page},
                    type: "GET",
                    success: function(newsList) {
                        //删除所有的li
                        $("ul.news_list").children("li").remove();
                        newsList.forEach(function(value, index){
                            // 新建li元素
                            var li = $("<li class='clearfix'></li>");
                            // href
                            var href = "${pageContext.request.contextPath}/news/detail.do?id=" + value.id + "&type=" + value.type + "&page=" + page;
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
                            $("ul.news_list").append(li);
                        })
                    },
                    error: function() {

                    }
                })

            }

        });


    })

</script>
</body>

</html>

