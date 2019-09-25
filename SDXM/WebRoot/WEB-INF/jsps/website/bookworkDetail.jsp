<!DOCTYPE html>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.7.2.min.js"></script>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <link rel="icon"
          href="${pageContext.request.contextPath}/favicon.ico" type="image/x-icon" />
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/favicon.ico" type="image/x-icon" />
    <title>业内动态详情</title>
    <!-- CSS -->
    <link  href="${pageContext.request.contextPath}/websit_style/css/reset.css" rel="stylesheet" type="text/css">
    <link  href="${pageContext.request.contextPath}/websit_style/css/main.css" rel="stylesheet" type="text/css">
    <link  href="${pageContext.request.contextPath}/websit_style/css/book_detail.css" rel="stylesheet" type="text/css">


</head>

<body>
<div class="container">
    <jsp:include page="header.jsp"></jsp:include>

    <div class="mianbody">
        <div class="main_banner clearfix">
            <div class="main_banner_bg"></div>
            <div class="main_banner_inner clearfix w1200">
                <jsp:include page="contact_links.jsp"/><!--main_banner_nav-->
                <div class="main_container_special">
                    <div class="main_left_">
                        <div class="main_container_content2 icon_01">
                            <a href="${pageContext.request.contextPath}/home/contact.do">互动专区</a>>
                            <c:choose>
                                <c:when test="${ not empty msg}">
                                    <h3 id="newsmsg">该页内容已被删除</h3>
                                </c:when>
                                <c:otherwise>
                                    <a href="${pageContext.request.contextPath}/home/newsList.do?type=${news.type}">${type}</a>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <c:choose>
                            <c:when test="${ empty msg}">
                                <div class="word_box">
                                    <h2 class="title">${news.title}</h2>
                                    <ul>
                                        <li>发布日期：${news.createTime}</li>
                                    </ul>
                                    <div class="news_content">
                                            ${news.content}
                                    </div>

                                </div>
                            </c:when>
                        </c:choose>

                        <div class="back_btn">
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
                    </div>
                    <div class="main_rightbox">
                        <div class="main_right_w">
                            <div class="div_">
                                <p class="title_">延伸阅读</p>
                            </div>
                            <c:choose>
                                <c:when test="${not empty recommendation}">
                                    <a class="more" href="${pageContext.request.contextPath}/home/newsList.do?id=${news.id}&recommendation=true">更多&gt;&gt;</a>
                                </c:when>
                            </c:choose>
                            <ul class="consultation">
                                <c:forEach items="${recommendation}" var="onenews" varStatus="status">
                                    <li class="consultation_li clearfix">
                                        <p><a href="${pageContext.request.contextPath}/news/detail.do?id=${onenews.id}">${onenews.title}</a></p>
                                        <span>${onenews.createTime}</span>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                        <div class="main_right_w">
                            <div class="div_">
                                <p class="title_">热点资讯</p>
                            </div>
                            <c:choose>
                                <c:when test="${not empty latestNews}">
                                    <a class="more" href="${pageContext.request.contextPath}/home/newsList.do?id=${news.id}&type=${news.type}">更多&gt;&gt;</a>
                                </c:when>
                            </c:choose>
                            <ul class="consultation">
                                <c:forEach items="${latestNews}" var="onenews" varStatus="status">
                                    <li class="consultation_li clearfix">
                                        <p><a href="${pageContext.request.contextPath}/news/detail.do?id=${onenews.id}&type=${news.type}&listType=${previousType}&page=${previousPage}">${onenews.title}</a></p>
                                        <span>${onenews.createTime}</span>
                                    </li>
                                </c:forEach>
                            </ul>

                        </div>
                        <c:if test="${not empty hotBooks}">
                            <div class="main_right_s">
                                <div class="div_">
                                    <p class="title_">排行榜</p>
                                </div>
                                <ul class="ranking_list">
                                    <c:forEach items="${hotBooks}" var="book" varStatus="st">
                                        <li class="clearfix">
                                            <p class="icon_no0${st.index+1}"><a href="${pageContext.request.contextPath}/home/bookDetail.do?id=${book.id}">${book.bookName}</a></p>
                                            <span>${book.publicationDate}</span>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div><!--main_banner_inner-->

        </div>

    </div>
    <jsp:include page="footer.jsp"></jsp:include>
    <script type="text/javascript" src="src="${pageContext.request.contextPath}/websit_style/js/jquery-1.8.0.min.js" />
    <script>
        $('.nav_list_first li').click(function(){
            $(this).addClass('on').siblings().removeClass('on');
            var liindex = $(this).index();
            $('.nav_second_list:eq('+liindex+')').slideDown().siblings('.nav_second_list').hide();
        });
        var msg = ${msg};
        if ($("#newsmsg")[0]) {
            alert(msg);
        }
    </script>
</div>
</body>

</html>

