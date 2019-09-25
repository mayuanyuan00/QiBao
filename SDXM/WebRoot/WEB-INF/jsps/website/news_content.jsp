<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
	<link rel="icon"
		  href="${pageContext.request.contextPath}/favicon.ico" type="image/x-icon" />
	<link rel="shortcut icon" href="${pageContext.request.contextPath}/favicon.ico" type="image/x-icon" />
	<title>上大出版社-新闻详情</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/new_style/css/reset.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/new_style/css/main.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/new_style/css/about.css" />
</head>
<body>
<div class="container">
	<jsp:include page="header.jsp"></jsp:include>
	<div class="mainbody">
		<div class="active-box">
			<a href="${pageContext.request.contextPath}/home/homeIndex.do">首页</a>
			<a href="${pageContext.request.contextPath}/home/newsList.do">新闻公告</a>
			<a href="${pageContext.request.contextPath}/home/newsList.do?type=${news.type}">${type}</a>
		</div>
		<div class="new-box clearfix">
			<div class="new-detail-title">
				<p class="nTitle">${news.title}</p>
				<p><c:if test="${not empty news.publisher}"><span id="s_author">作者：${news.publisher}</span></c:if><span id="s_createTime">时间：${news.createTime}</span></p>
			</div>
			<div class="new-left-box">

				<div class="new-detail-box">
					${news.content}
				</div>
				<div class="about-back">
				<%--<a href="javascript:void(0)" onclick="goback()">返回</a>--%>
				<c:choose>
				<c:when test="${previousPage<0}">
				<a href="${pageContext.request.contextPath}/home/homeIndex.do">返回</a>
				</c:when>
				<c:otherwise>
				<a href="${pageContext.request.contextPath}/home/newsList.do?type=${previousType}&page=${previousPage}">返回</a>
				</c:otherwise>
				</c:choose>
				</div><!--返回按钮-->

				<div class="new-detail-nav">
					<c:choose>
						<c:when test="${news.id != preNewsId}">
							<p>上一篇：<a href="${pageContext.request.contextPath}/news/detail.do?id=${preNewsId}&type=${news.type}&listType=${news.type}">${preNews}</a></p>

						</c:when>
					</c:choose>
					<c:choose>
						<c:when test="${news.id != nextNewsId}">
							<p>下一篇：<a href="${pageContext.request.contextPath}/news/detail.do?id=${nextNewsId}&type=${news.type}&listType=${news.type}">${nextNews}</a></p>

						</c:when>
					</c:choose>
				</div>

			</div>
			<div class="new-right-box">
				<div class="recommend-list">
					<p class="recommend-title">热点资讯</p>
					<c:choose>
						<c:when test="${latestNews != null}">
							<ul>
							<c:forEach items="${latestNews}" var="newsa" varStatus="status">
								<li>
									<a href="${pageContext.request.contextPath}/news/detail.do?id=${newsa.id}&type=${news.type}">${newsa.title}</a>
									<a href="${pageContext.request.contextPath}/news/detail.do?id=${newsa.id}&type=${news.type}">${newsa.createTime}</a>
								</li>
							</c:forEach>
							</ul>
						</c:when>
					</c:choose>
				</div>
				<div class="recommend-list">
					<p class="recommend-title">排行榜</p>
					<c:choose>
						<c:when test="${hotBooks != null}">
							<ul>
								<c:forEach items="${hotBooks}" var="book" varStatus="status">
									<li>
										<a href="${pageContext.request.contextPath}/home/bookDetail.do?id=${book.id}">${book.bookName}</a>
										<a href="${pageContext.request.contextPath}/home/bookDetail.do?id=${book.id}">${book.publicationDate}</a>
									</li>
								</c:forEach>
							</ul>
						</c:when>
					</c:choose>
				</div>
			</div>
		</div>
	</div>

	<jsp:include page="footer.jsp" />

</div>
<script type="text/javascript" src="${pageContext.request.contextPath}/new_style/js/jquery-1.8.0.min.js" ></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/new_style/js/main.js" ></script>
<script>
	<%--$(function () {--%>
		<%----%>
		<%--// 文章上一篇和下一篇的链接--%>
		<%--$("div.new-detail-nav").children("p").each(function(index, element){--%>
			<%--var url;--%>
			<%--if (index == 0){--%>
				<%--url = "${pageContext.request.contextPath}/news/detail.do"--%>
			<%--} else {--%>
				<%--url = "${pageContext.request.contextPath}/news/detail.do"--%>
			<%--}--%>
			<%--var update = function() {--%>
				<%--var newsId;--%>
				<%--var type = ${news.type};--%>
				<%--var listType = ${news.type};--%>
				<%--if(index == 0) {--%>
					<%--newsId = "${preNewsId}"--%>
				<%--} else{--%>
					<%--newsId = "${nextNewsId}"--%>
				<%--}--%>
				<%--$.ajax({--%>
					<%--url: url,--%>
					<%--data: {id: newsId, type: type, listType: listType},--%>
					<%--type: 'GET',--%>
					<%--success: function(value) {--%>
						<%--var news = value.news;--%>
						<%--var preNewsId = value.preNewsId;--%>
						<%--var nextNewsId = value.nextNewsId;--%>
						<%--$("P.nTitle").text(news.title);--%>
						<%--$("span#s_author").text("作者："+ news.publisher);--%>
						<%--$("span#s_createTime").text("时间："+ news.createTime);--%>
						<%--$("div.new-detail-box").text(news.content);--%>
						<%--// 移除上一篇和下一篇标签--%>
						<%--$("div.new-detail-nav").children("p").remove();--%>
						<%--if (news.id != preNewsId) {--%>
							<%--var p = $("<p></p>");--%>
							<%--var a = $("<a></a>");--%>
							<%--//a.click(update);--%>
							<%--p.text("上一篇：");--%>
							<%--p.append(a);--%>
							<%--$("div.new-detail-nav").append(p);--%>
						<%--}--%>
						<%--if (news.id != nextNewsId) {--%>
							<%--var p = $("<p></p>");--%>
							<%--var a = $("<a></a>");--%>
							<%--//a.click(update);--%>
							<%--p.text("下一篇：");--%>
							<%--p.append(a);--%>
							<%--$("div.new-detail-nav").append(p);--%>
						<%--}--%>
					<%--},--%>
					<%--error: function (err) {--%>

					<%--}--%>
				<%--})--%>
			<%--}--%>
			<%--$(this).children("a").click(update)--%>
		<%--})--%>
	<%--})--%>
</script>
</body>
</html>















<%--<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>--%>
<%--<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>--%>
<%--<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.7.2.min.js"></script>--%>

<%--<html>--%>
    <%--<head>--%>
        <%--<meta http-equiv="Content-Type" content="text/html; charset=utf-8">--%>
        <%--<title>业内动态详情</title>--%>
        <%--<!-- CSS -->--%>
        <%--<link  href="${pageContext.request.contextPath}/websit_style/css/reset.css" rel="stylesheet" type="text/css">--%>
        <%--<link  href="${pageContext.request.contextPath}/websit_style/css/main.css" rel="stylesheet" type="text/css">--%>
		<%--<link  href="${pageContext.request.contextPath}/websit_style/css/book_detail.css" rel="stylesheet" type="text/css">--%>

    <%----%>
    <%--</head>--%>
   <%----%>
 <%--<body>--%>
		<%--<div class="container">--%>
				<%--<jsp:include page="header.jsp"></jsp:include>--%>

				<%--<div class="mianbody">--%>
				<%--<div class="main_banner clearfix">--%>
					<%--<div class="main_banner_bg"></div>--%>
					<%--<div class="main_banner_inner clearfix w1200">--%>
						<%--<jsp:include page="news_nav.jsp"/><!--main_banner_nav-->--%>
						<%--<div class="main_container_special">--%>
							<%--<div class="main_left_">--%>
                            	<%--<div class="main_container_content2 icon_01">--%>
									<%--<a href="${pageContext.request.contextPath}/home/newsList.do">新闻公告</a>>--%>
									<%--<c:choose>--%>
										<%--<c:when test="${ not empty msg}">--%>
											<%--<h3 id="newsmsg">该页内容已被删除</h3>--%>
										<%--</c:when>--%>
										<%--<c:otherwise>--%>
											<%--<a href="${pageContext.request.contextPath}/home/newsList.do?type=${news.type}">${type}</a>--%>
										<%--</c:otherwise>--%>
									<%--</c:choose>--%>
								<%--</div>--%>
									<%--<c:choose>--%>
										<%--<c:when test="${ empty msg}">--%>
											<%--<div class="word_box">--%>
												<%--<h2 class="title">${news.title}</h2>--%>
												<%--<ul>--%>
													<%--<li>发布日期：${news.createTime}</li>--%>
													<%--&lt;%&ndash;<li>发布人：${news.publisher}</li>&ndash;%&gt;--%>
												<%--</ul>--%>
												<%--<div class="news_content">--%>
														<%--${news.content}--%>
												<%--</div>--%>

											<%--</div>--%>
										<%--</c:when>--%>
									<%--</c:choose>--%>

                                <%--<div class="back_btn">--%>
									<%--&lt;%&ndash;<a href="javascript:void(0)" onclick="goback()">返回</a>&ndash;%&gt;--%>
									<%--<c:choose>--%>
									<%--<c:when test="${previousPage<0}">--%>
										<%--<a href="${pageContext.request.contextPath}/home/homeIndex.do">返回</a>--%>
									<%--</c:when>--%>
										<%--<c:otherwise>--%>
											<%--<a href="${pageContext.request.contextPath}/home/newsList.do?type=${previousType}&page=${previousPage}">返回</a>--%>
										<%--</c:otherwise>--%>
									<%--</c:choose>--%>
								<%--</div><!--返回按钮-->--%>
                        	<%--</div>--%>
                            <%--<div class="main_rightbox">--%>
                            	<%--<div class="main_right_w">--%>
	                            	<%--<div class="div_">--%>
	                                	<%--<p class="title_">延伸阅读</p>--%>
	                                <%--</div>--%>
									<%--<c:choose>--%>
									<%--<c:when test="${not empty recommendation}">--%>
										<%--<a class="more" href="${pageContext.request.contextPath}/home/newsList.do?id=${news.id}&recommendation=true">更多&gt;&gt;</a>--%>
									<%--</c:when>--%>
									<%--</c:choose>--%>
	                                <%--<ul class="consultation">--%>
										<%--<c:forEach items="${recommendation}" var="onenews" varStatus="status">--%>
											<%--<li class="consultation_li clearfix">--%>
												<%--<p><a href="${pageContext.request.contextPath}/news/detail.do?id=${onenews.id}">${onenews.title}</a></p>--%>
												<%--<span>${onenews.createTime}</span>--%>
											<%--</li>--%>
										<%--</c:forEach>--%>
	                                <%--</ul>--%>
	                            <%--</div>   --%>
	                            <%--<div class="main_right_w">--%>
	                            	<%--<div class="div_">--%>
	                                	<%--<p class="title_">热点资讯</p>--%>
	                                <%--</div>--%>
									<%--<c:choose>--%>
										<%--<c:when test="${not empty latestNews}">--%>
											<%--<a class="more" href="${pageContext.request.contextPath}/home/newsList.do?id=${news.id}&type=${news.type}">更多&gt;&gt;</a>--%>
										<%--</c:when>--%>
									<%--</c:choose>--%>
									<%--<ul class="consultation">--%>
										<%--<c:forEach items="${latestNews}" var="onenews" varStatus="status">--%>
											<%--<li class="consultation_li clearfix">--%>
												<%--<p><a href="${pageContext.request.contextPath}/news/detail.do?id=${onenews.id}&type=${news.type}&listType=${previousType}&page=${previousPage}">${onenews.title}</a></p>--%>
												<%--<span>${onenews.createTime}</span>--%>
											<%--</li>--%>
										<%--</c:forEach>--%>
	                                	<%--<!--<li class="consultation_li clearfix">--%>
	                                    	<%--<p><a href="###">艺术气息高档名图书形状......</a></p><span>2017/10/23</span>--%>
	                                    <%--</li>--%>
	                                    <%--<li class="consultation_li clearfix">--%>
	                                    	<%--<p><a href="###">艺术气息高档名图书形状......</a></p><span>2017/10/23</span>--%>
	                                    <%--</li>--%>
	                                   <%--<li class="consultation_li clearfix">--%>
	                                    	<%--<p><a href="###">艺术气息高档名图书形状......</a></p><span>2017/10/23</span>--%>
	                                    <%--</li>--%>
	                                    <%--<li class="consultation_li clearfix">--%>
	                                    	<%--<p><a href="###">艺术气息高档名图书形状......</a></p><span>2017/10/23</span>--%>
	                                    <%--</li>--%>
	                                    <%--<li class="consultation_li clearfix">--%>
	                                    	<%--<p><a href="###">艺术气息高档名图书形状......</a></p><span>2017/10/23</span>--%>
	                                    <%--</li>--%>
	                                    <%--<li class="consultation_li clearfix">--%>
	                                    	<%--<p><a href="###">艺术气息高档名图书形状......</a></p><span>2017/10/23</span>--%>
	                                    <%--</li>--%>
	                                    <%--<li class="consultation_li clearfix">--%>
	                                    	<%--<p><a href="###">艺术气息高档名图书形状......</a></p><span>2017/10/23</span>--%>
	                                    <%--</li>--%>
	                                    <%--<li class="consultation_li clearfix">--%>
	                                    	<%--<p><a href="###">艺术气息高档名图书形状艺术气息高档名图书形状......</a></p><span>2017/10/23</span>--%>
	                                    <%--</li>-->--%>
	                                <%--</ul>--%>
	                                <%----%>
	                            <%--</div>--%>
								<%--<c:if test="${not empty hotBooks}">--%>
									<%--<div class="main_right_s">--%>
	                            	<%--<div class="div_">--%>
	                                	<%--<p class="title_">排行榜</p>--%>
	                                <%--</div>--%>
	                                <%--<ul class="ranking_list">--%>
										<%--<c:forEach items="${hotBooks}" var="book" varStatus="st">--%>
											<%--<li class="clearfix">--%>
												<%--<p class="icon_no0${st.index+1}"><a href="${pageContext.request.contextPath}/home/bookDetail.do?id=${book.id}">${book.bookName}</a></p>--%>
												<%--<span>${book.publicationDate}</span>--%>
											<%--</li>--%>
										<%--</c:forEach>--%>
	                                    <%--&lt;%&ndash;<li class="clearfix">&ndash;%&gt;--%>
	                                        <%--&lt;%&ndash;<p class="icon_no02"><a href="###">钢铁是怎样炼成的</a></p>&ndash;%&gt;--%>
	                                        <%--&lt;%&ndash;<span>2017/10/23</span>&ndash;%&gt;--%>
	                                    <%--&lt;%&ndash;</li>&ndash;%&gt;--%>
	                                     <%--&lt;%&ndash;<li class="clearfix">&ndash;%&gt;--%>
	                                        <%--&lt;%&ndash;<p class="icon_no03"><a href="###">钢铁是怎样炼成的</a></p>&ndash;%&gt;--%>
	                                        <%--&lt;%&ndash;<span>2017/10/23</span>&ndash;%&gt;--%>
	                                    <%--&lt;%&ndash;</li>&ndash;%&gt;--%>
	                                     <%--&lt;%&ndash;<li class="clearfix">&ndash;%&gt;--%>
	                                        <%--&lt;%&ndash;<p class="icon_no04"><a href="###">钢铁是怎样炼成的</a></p>&ndash;%&gt;--%>
	                                        <%--&lt;%&ndash;<span>2017/10/23</span>&ndash;%&gt;--%>
	                                    <%--&lt;%&ndash;</li>&ndash;%&gt;--%>
	                                     <%--&lt;%&ndash;<li class="clearfix">&ndash;%&gt;--%>
	                                        <%--&lt;%&ndash;<p class="icon_no05"><a href="###">钢铁是怎样炼成的钢铁是怎样炼成的钢铁是怎样炼成的钢铁是怎样炼成的</a></p>&ndash;%&gt;--%>
	                                        <%--&lt;%&ndash;<span>2017/10/23</span>&ndash;%&gt;--%>
	                                    <%--&lt;%&ndash;</li>&ndash;%&gt;--%>
	                                    <%--&lt;%&ndash;<li class="clearfix">&ndash;%&gt;--%>
	                                        <%--&lt;%&ndash;<p class="icon_no06"><a href="###">钢铁是怎样炼成的</a></p>&ndash;%&gt;--%>
	                                        <%--&lt;%&ndash;<span>2017/10/23</span>&ndash;%&gt;--%>
	                                    <%--&lt;%&ndash;</li>&ndash;%&gt;--%>
	                                    <%--&lt;%&ndash;<li class="clearfix">&ndash;%&gt;--%>
	                                        <%--&lt;%&ndash;<p class="icon_no07"><a href="###">钢铁是怎样炼成的</a></p>&ndash;%&gt;--%>
	                                        <%--&lt;%&ndash;<span>2017/10/23</span>&ndash;%&gt;--%>
	                                    <%--&lt;%&ndash;</li>&ndash;%&gt;--%>
	                                    <%--&lt;%&ndash;<li class="clearfix">&ndash;%&gt;--%>
	                                        <%--&lt;%&ndash;<p class="icon_no08"><a href="###">钢铁是怎样炼成的</a></p>&ndash;%&gt;--%>
	                                        <%--&lt;%&ndash;<span>2017/10/23</span>&ndash;%&gt;--%>
	                                    <%--&lt;%&ndash;</li>&ndash;%&gt;--%>
	                                <%--</ul>--%>
	                            <%--</div>--%>
								<%--</c:if>--%>
                            <%--</div>--%>
						<%--</div> --%>
					<%--</div><!--main_banner_inner-->--%>
					<%----%>
				<%--</div>--%>
				<%----%>
			<%--</div>--%>
			<%--<jsp:include page="footer.jsp"></jsp:include>--%>
		<%--<script type="text/javascript" src="src="${pageContext.request.contextPath}/websit_style/js/jquery-1.8.0.min.js" />--%>
		<%--<script>--%>
			<%--$('.nav_list_first li').click(function(){--%>
				<%--$(this).addClass('on').siblings().removeClass('on');--%>
				<%--var liindex = $(this).index();--%>
				<%--$('.nav_second_list:eq('+liindex+')').slideDown().siblings('.nav_second_list').hide();--%>
			<%--});--%>
			<%--var msg = ${msg};--%>
			<%--if ($("#newsmsg")[0]) {--%>
				<%--alert(msg);--%>
			<%--}--%>
		<%--</script>--%>
			<%--</div>--%>
	<%--</body>--%>

<%--</html>--%>

