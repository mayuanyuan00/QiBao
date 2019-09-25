<!DOCTYPE html>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <link rel="icon"
          href="${pageContext.request.contextPath}/favicon.ico" type="image/x-icon" />
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/favicon.ico" type="image/x-icon" />
    <title>上大出版社-新闻列表</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/new_style/css/reset.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/new_style/css/main.css"/>

</head>
<body>
<div class="container">
    <jsp:include page="header.jsp"/>
    <div class="mainbody">
        <div class="second-banner"></div>
        <div class="new-list-box">
            <div class="new-list-nav">
                <ul id="newstype">
                    <c:forEach items="${newsType}" var="type" varStatus="status">
                        <c:choose>
                            <c:when test="${status.index == showColumn}">
                                <li data-id="${type.key}" data-page=${page}><a>${type.value}</a></li>
                            </c:when>
                            <c:otherwise>
                                <li data-id="${type.key}" data-page=1><a>${type.value}</a></li>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </ul>
                <div class="new-list-navtip">
                    <a href="${pageContext.request.contextPath}/home/homeIndex.do">首页</a>
                    <c:choose>
                        <c:when test="${fn:length(newsType) == 3}">
                            <a href="${pageContext.request.contextPath}/home/newsList.do">${topColumn}</a>
                            <a id="change">${secondColumn}</a>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/home/pressCulture.do">${topColumn}</a>
                            <a id="change">${secondColumn}</a>
                        </c:otherwise>
                    </c:choose>
                    <%--<a href="${pageContext.request.contextPath}/home/newsList.do">新闻公告</a>--%>
                    <%--<a id="change">最新资讯</a>--%>
                </div>
            </div>

            <!--最新资讯-->
            <div class="news-type">
                <div class="news-list clearfix">
                </div>
                <div class="page-box pb30">
                    <ul>
                        <li><a>上一页</a></li>
                        <li><a>1</a></li>
                        <li><a>2</a></li>
                        <li><a>3</a></li>
                        <li><a>下一页</a></li>
                    </ul>
                </div>
            </div>

            <!--重要活动-->
            <div class="news-type">
                <div class="news-list clearfix">
                </div>
                <div class="page-box pb30">
                    <ul>
                        <li><a>上一页</a></li>
                        <li><a>1</a></li>
                        <li><a>2</a></li>
                        <li><a>3</a></li>
                        <li><a>下一页</a></li>
                    </ul>
                </div>
            </div>

            <!--社内公告-->
            <div class="news-type">
                <div class="news-list clearfix">
                </div>
                <div class="page-box pb30">
                    <ul>
                        <li><a>上一页</a></li>
                        <li><a>1</a></li>
                        <li><a>2</a></li>
                        <li><a>3</a></li>
                        <li><a>下一页</a></li>
                    </ul>
                </div>
            </div>

        </div>


    </div>
    <jsp:include page="footer.jsp"/>
</div>
<script type="text/javascript" src="${pageContext.request.contextPath}/new_style/js/jquery-1.8.0.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/new_style/js/main.js"></script>
<script>
    if ( !Array.prototype.forEach ) {
        Array.prototype.forEach = function forEach( callback, thisArg ) {
            var T, k;
            if ( this == null ) {
                throw new TypeError( "this is null or not defined" );
            }
            var O = Object(this);
            var len = O.length >>> 0;
            if ( typeof callback !== "function" ) {
                throw new TypeError( callback + " is not a function" );
            }
            if ( arguments.length > 1 ) {
                T = thisArg;
            }
            k = 0;
            while( k < len ) {
                var kValue;
                if ( k in O ) {
                    kValue = O[ k ];
                    callback.call( T, kValue, k, O );
                }
                k++;
            }
        };
    }





    // 重新加载新闻列表
    function getNewsList(data, index, page) {
        var newsList = data.results;
        //删除div下的子元素
        $("div.news-list").eq(index).children().remove();
        //新建ul元素
        var ul = $("<ul></ul>");
        ul.addClass("news_list");
        newsList.forEach(function (value, index) {
            // 新建li元素
            var li = $("<li class='clearfix'></li>");
            var span_img = $("<span class='news-pic'></span>");
            if (value.pics != null) {
                var img = $("<img />");
                img.attr("src", "${pageContext.request.contextPath}" + value.pics);
                span_img.append(img);
            }
            //新建div
            var div = $("<div class='news-info'></div>");
            //新建p时间元素
            var p_time = $("<p class='news-time'></p>");
            var span_date = $("<span></span>");
            span_date.text(value.dateStr);
            var i_year = $("<i></i>");
            i_year.text(value.yearStr);
            p_time.append(span_date);
            p_time.append(i_year);
            // 新建p标题
            var p_title = $("<p class='news-title'></p>");
            p_title.text(value.title);
            // 新建p简介
            var p_intro = $("<p class='news-intro'></p>");

            p_intro.text(value.summary);
            p_intro.txtCur({n: 50});
            // 阅读更多
            var a_more = $("<a class='more-btn'></a>");
            if(value.type != 18 && value.type != 19){
                var href = "${pageContext.request.contextPath}/news/detail.do?id=" + value.id + "&type=" + value.type +"&page=" + page + "&listType=" + value.type;
            } else {
                var href = "${pageContext.request.contextPath}/home/systemdetail.do?id=" + value.id;
            }
            a_more.attr("href", href);
            a_more.text("阅读更多");
            //a_title插入div
            div.append(p_time);
            div.append(p_title);
            div.append(p_intro);
            div.append(a_more);
            li.append(span_img);
            li.append(div);
            ul.append(li);
        })
        $("div.news-list").eq(index).append(ul);
        $('.news-list li:nth-child(2n)').css('margin-right','0px');

    }

    function updateNews(type, page, index) {
        $(".new-list-box .news-type").hide();
        $.ajax({
            url: "${pageContext.request.contextPath}/news/newsList.do?type=" + type + "&page=" + page,
            type: "get",
            success: function (data) {
                //console.log(data);
                if (index == 3) {
                    index -= 1;
                }
                getNewsList(data, index, page);
                var totolPage = Math.ceil(data.totalCount / data.pageSize);
                var str = "<ul>";


                var pages = [];

                function getNewPageItem(_page, name) {
                    return {page: _page, name: name, active: page == _page};
                }

                if (totolPage > 1) pages.push(getNewPageItem(1, "首页"));
                if (page - 4 > 0) page.push(getNewPageItem(null, "..."));
                if (page - 2 > 0) pages.push(getNewPageItem(page - 2, page - 2 + ""));
                if (page - 1 > 0) pages.push(getNewPageItem(page - 1, page - 1 + ""));
                pages.push(getNewPageItem(page, page + ""));
                if (page + 1 <= totolPage) pages.push(getNewPageItem(page + 1, page + 1 + ""));
                if (page + 2 <= totolPage) pages.push(getNewPageItem(page + 2, page + 2 + ""));
                if (page + 4 < totolPage) page.push(getNewPageItem(null, "..."));
                if (totolPage > 1) pages.push(getNewPageItem(totolPage, "尾页"));
                for (var i = 0; i < pages.length; ++i) {
                    var item = pages[i];
                    var _str = "<li class='111'><a onclick='updateNews(222,333,444)'>555</a></li>"
                        .replace("111", item.active ? 'on' : "")
                        .replace("222", type)
                        .replace("333", item.page)
                        .replace("444", index)
                        .replace("555", item.name);
                    if(item.page == null){
                        _str.replace("onclick","ooooo");//不可点
                    }
                    str += _str;
                }
                str += "</ul>";

//                if (totolPage < 6) {
//                    if (page != 1) {
//                        str += "<li><a onclick='updateNews(" + type + "," + (page - 1) + "," + index + ")'>上一页</a></li>";
//                    }
//                    for (var i = 1; i <= totolPage; i++) {
//                        if (page == i) {
//                            str += "<li class='on'><a onclick='updateNews(" + type + "," + i + "," + index + ")'>" + i + "</a></li>";
//                        } else {
//                            str += "<li><a onclick='updateNews(" + type + "," + i + "," + index + ")'>" + i + "</a></li>";
//                        }
//                    }
//                    if (page != totolPage) {
//                        str += "<li><a onclick='updateNews(" + type + "," + (page + 1) + "," + index + ")'>下一页</a></li>";
//                    }
//                } else {
//                    if (page > 3) {
//                        str += "<li><a onclick='updateNews(" + type + "," + 1 + "," + index + ")'>首页</a></li>";
//                    }
//                    if (page != 1) {
//                        str += "<li><a onclick='updateNews(" + type + "," + (page - 1) + "," + index + ")'>上一页</a></li>";
//                    }
//                    if (page > 3) {
//                        str += "<li><a >...</a></li>";
//                    }
//                    for (var j = page - 2; j <= page + 2; j++) {
//                        if (page == j) {
//                            str += "<li class='on'><a onclick='updateNews(" + type + "," + j + "," + index + ")'>" + j + "</a></li>";
//                        } else {
//                            str += "<li><a onclick='updateNews(" + type + "," + j + "," + index + ")'>" + j + "</a></li>";
//                        }
//                    }
//                    if (page < totolPage - 3) {
//                        str += "<li><a >...</a></li>";
//                    }
//                    if (page != totolPage) {
//                        str += "<li><a onclick='updateNews(" + type + "," + (page + 1) + "," + index + ")'>下一页</a></li>";
//                    }
//                    if (page < totolPage - 3) {
//                        str += "<li><a onclick='updateNews(" + type + "," + totolPage + "," + index + ")'>末页</a></li>";
//                    }
//                }
//                str += "</ul>";

                $(".page-box").eq(index).children().remove();
                $(".page-box").eq(index).prepend(str);
                $('div.news-type').eq(index).show();
                $("#newstype li").eq(index).data('page', page);
//                $(".page-box li").eq(page-1).addClass("on").sibling().removeClass("on");
            }
        })
    }

    $(function () {
        var newsId = "${newsId}";
        var showColumn = ${showColumn}
        var page = ${page}
            $('ul#newstype li').click(function () {
                var _this = $(this);
                var liindex = _this.index();
                updateNews(_this.data("id"), _this.data('page'), liindex);
                $(this).addClass('on').siblings('li').removeClass('on');
                $("#change").text($(this).children('a').eq(0).text());
            });
        $('ul#newstype li').eq(showColumn).trigger('click');

        <%--<c:choose>--%>
        <%--<c:when test="${fn:length(newsType) == 3}">--%>
        <%--updateNews(9, 1, 0);--%>
        <%--updateNews(10, 1, 1);--%>
        <%--updateNews(11, 1, 2);--%>
        <%--</c:when>--%>
        <%--<c:otherwise>--%>
        <%--updateNews(18, 1, 0);--%>
        <%--updateNews(19, 1, 0);--%>
        <%--// 移除第三个--%>
        <%--$('div.news-type').eq(2).remove();--%>
        <%--</c:otherwise>--%>
        <%--</c:choose>--%>



//	switch(type){
//		case 11:
//			$("a#inner").parent().addClass('on').siblings().remove('on');
//				break;
//		case 10:
//			$("a#important").parent().addClass('on').siblings().remove('on');
//			break;
//		default:
//			$("a#newest").parent().addClass('on').siblings().remove('on');
//	}




        // $('.news_picture_right p').txtCur({n:70});
        $('.nav_list_first li').click(function () {
            $(this).addClass('on').siblings().removeClass('on');
            var liindex = $(this).index();
            $('.nav_second_list:eq(' + liindex + ')').slideDown().siblings('.nav_second_list').hide();
        });


        $('.news-intro').txtCur({n: 50});

    })

</script>
</body>
</html>


<%--<html>--%>
<%--<head>--%>
<%--<meta http-equiv="Content-Type" content="text/html; charset=utf-8">--%>
<%--<title>业内动态列表</title>--%>
<%--<!-- CSS -->   --%>
<%--<link  href="${pageContext.request.contextPath}/websit_style/css/reset.css" rel="stylesheet" type="text/css">--%>
<%--<link  href="${pageContext.request.contextPath}/websit_style/css/main.css" rel="stylesheet" type="text/css">--%>

<%--<link  href="${pageContext.request.contextPath}/css/paginate.css" rel="stylesheet" type="text/css">--%>
<%--<link  href="${pageContext.request.contextPath}/websit_style/css/book_detail2.css" rel="stylesheet" type="text/css">--%>
<%--<style>--%>
<%--#page_number{--%>
<%--height: 30px;--%>
<%--line-height: 30px;--%>
<%--font-size: 16px;--%>
<%--position: relative;--%>
<%--margin-top:20px;--%>
<%--margin-bottom: 20px;--%>
<%--}--%>

<%--</style>--%>
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
<%--<div class="main_container">--%>
<%--<div class="main_container_content2 icon_01">--%>
<%--<a href="###">新闻公告</a>><a href="###">资讯列表</a>--%>
<%--</div><!--网页小目录-->--%>
<%--<c:choose>--%>
<%--<c:when test="${newsList != null}">--%>
<%--<ul class="news_list">--%>
<%--<c:forEach items="${newsList}" var="news" varStatus="status">--%>
<%--<li class="clearfix">--%>
<%--<c:choose>--%>
<%--<c:when test="${not empty news.pics}">--%>
<%--<a class="news_picture" href="${pageContext.request.contextPath}/news/detail.do?id=${news.id}&type=${news.type}&listType=${type}&page=${currentPage}"><img src="${pageContext.request.contextPath}${news.pics}" alt="" /></a>--%>
<%--</c:when>--%>
<%--<c:otherwise>--%>
<%--<a class="news_picture" href="${pageContext.request.contextPath}/news/detail.do?id=${news.id}&type=${news.type}&listType=${type}&page=${currentPage}"></a>--%>
<%--</c:otherwise>--%>
<%--</c:choose>--%>
<%--<div class="news_picture_right">--%>
<%--<a href="${pageContext.request.contextPath}/news/detail.do?id=${news.id}&type=${news.type}&listType=${type}&page=${currentPage}" class="news_title"><h3>${news.title}</h3></a>--%>
<%--<span>${news.createTime}</span>--%>
<%--<p>${news.summary}...</p>--%>
<%--<a href="${pageContext.request.contextPath}/news/detail.do?id=${news.id}&type=${news.type}&listType=${type}&page=${currentPage}" class="read_details">阅读详情</a>--%>
<%--</div>--%>
<%--</li>--%>
<%--</c:forEach>--%>
<%--</ul>--%>
<%--</c:when>--%>
<%--<c:otherwise>--%>
<%--<h3>暂无新闻</h3>--%>
<%--</c:otherwise>--%>
<%--</c:choose>--%>

<%--<div id="page_number">--%>
<%--</div>--%>


<%--</div> --%>
<%--</div><!--main_banner_inner-->--%>
<%----%>
<%--</div>--%>
<%----%>
<%--</div>--%>
<%--<jsp:include page="footer.jsp"></jsp:include>--%>
<%--</div>--%>


<%--<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js" ></script>--%>

<%--<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.paginate.js"></script>--%>
<%--<jsp:include page="login.jsp"></jsp:include>--%>


<%--<script>--%>
<%--$(function(){--%>
<%--var totalPages = ${pageCount};--%>
<%--var currentPage = ${currentPage};--%>
<%--var recommendation = ${recommendation};--%>
<%--var newsId = "${newsId}";--%>
<%--var type = ${type};--%>
<%--// $('.news_picture_right p').txtCur({n:70});--%>
<%--$('.nav_list_first li').click(function(){--%>
<%--$(this).addClass('on').siblings().removeClass('on');--%>
<%--var liindex = $(this).index();--%>
<%--$('.nav_second_list:eq('+liindex+')').slideDown().siblings('.nav_second_list').hide();--%>
<%--});--%>

<%--$("#page_number").paginate({--%>
<%--count: totalPages,--%>
<%--start: currentPage,--%>
<%--display: 7,--%>
<%--border: true,--%>
<%--border_color: '#b8b8b8',--%>
<%--text_color: '#000',--%>
<%--background_color: '#FFF',--%>
<%--text_hover_color: '#FFF',--%>
<%--background_hover_color: '#b2b2b2',--%>
<%--onChange: function(page) {--%>
<%--$.ajax({--%>
<%--url: '${pageContext.request.contextPath}/news/newsList.do',--%>
<%--data: {type: type, page: page, recommendation:recommendation, id: newsId},--%>
<%--type: "GET",--%>
<%--success: function(newsList) {--%>
<%--//删除所有的li--%>
<%--$("ul.news_list").children("li").remove();--%>
<%--newsList.forEach(function(value, index){--%>
<%--// 新建li元素--%>
<%--var li = $("<li class='clearfix'></li>");--%>
<%--// href--%>
<%--var href = "${pageContext.request.contextPath}/news/detail.do?id=" + value.id + "&type=" + value.type + "&page=" + page;--%>
<%--// 新建 a元素（存放img）--%>
<%--var a_img = $("<a class='news_picture'></a>");--%>
<%--a_img.attr("href", href);--%>
<%--if(value.pics != null) {--%>
<%--// 新建 img 元素--%>
<%--var img = $("<img />");--%>
<%--img.attr("src", "${pageContext.request.contextPath}" + value.pics);--%>
<%--a_img.append(img);--%>
<%--}--%>
<%--//新建div--%>
<%--var div = $("<div class='news_picture_right'></div>");--%>
<%--// 新建a元素（title)--%>
<%--var a_title = $("<a class='news_title'></a>");--%>
<%--a_title.attr("href", href);--%>
<%--// 新建h3--%>
<%--var h3 = $("<h3></h3>");--%>
<%--h3.text(value.title);--%>
<%--// h3插入a_title--%>
<%--a_title.append(h3);--%>
<%--// 新建span--%>
<%--var span = $("<span></span>");--%>
<%--span.html(value.createTime);--%>
<%--// 新建p--%>
<%--var p = $("<p></p>");--%>
<%--p.text(value.summary + "...");--%>
<%--// a（阅读详情）--%>
<%--var a_detail = $("<a class='read_details'>阅读详情</a>");--%>
<%--a_detail.attr("href", href);--%>
<%--//a_title插入div--%>
<%--div.append(a_title);--%>
<%--div.append(span);--%>
<%--div.append(p);--%>
<%--div.append(a_detail);--%>
<%--//--%>
<%--li.append(a_img);--%>
<%--li.append(div);--%>
<%--$("ul.news_list").append(li);--%>
<%--})--%>
<%--},--%>
<%--error: function() {--%>

<%--}--%>
<%--})--%>

<%--}--%>

<%--});--%>


<%--})--%>

<%--</script>--%>
<%--</body>--%>

<%--</html>--%>

