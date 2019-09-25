<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 4/20/2018
  Time: 12:39 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <link rel="icon"
          href="${pageContext.request.contextPath}/favicon.ico" type="image/x-icon" />
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/favicon.ico" type="image/x-icon" />
    <title>图书搜索页面</title>
    <!-- CSS -->
    <link href="${pageContext.request.contextPath}/new_style/css/reset.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath}/new_style/css/main.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath}/new_style/css/book-section.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath}/new_style/css/swiper.min.css" rel="stylesheet" type="text/css">
    <style>
        .book_section_sub_list li em span{
            display: inline;
        }
        .book_section_sub_nav li a{
            color: #999;
        }
    </style>
</head>
<body>
<div class="container">
    <jsp:include page="header.jsp"/>
    <div class="mainbody">
        <div class="book_section_banner">
            <img src="${pageContext.request.contextPath}/new_style/img/book_section/book_banner.png" alt="" />
        </div>
        <div class="book_section">
                <div class="active-box no-border">
                    <a href="${pageContext.request.contextPath}/home/enter.do">首页</a>
                    <a href="${pageContext.request.contextPath}/home/bookTypeList.do">图书专区</a>
                    <a href="###">搜索结果</a>
                </div>
                <ul class="book_section_nav clearfix" id="bookNav">
                    <li ><a href="${pageContext.request.contextPath}/home/bookTypeList.do">所有图书</a></li>
                </ul>

            <div class="book_section_content clearfix">
                    <div class="book_section_left">
                        <div class="book_section_sub_nav_title_teach_material">
                            搜索结果
                        </div>

                        <div class="book_section_sub_nav">
                            <ul class="clearfix">

                            </ul>
                        </div>
                    </div>

                <div class="book_section_right">
                    <div class="book_section_sub_list">
                        <div class="swiper-wrapper">
                            <div class="swiper-slide">
                                <ul class="clearfix">
                                    <c:forEach items="${books.results}" var="books">
                                        <li>
                                            <a href="${pageContext.request.contextPath}/home/bookDetail.do?id=${books.id}"></a>
                                            <div>
                                                <img src="${pageContext.request.contextPath}${books.imageurl}" alt="" />
                                            </div>
                                            <em>${books.bookName}</em>
                                            <span>${books.author}</span>
                                            <span>定价：${books.price}元</span>
                                        </li>
                                    </c:forEach>
                                    <c:if test="${empty books.results}">
                                        <span style="color: red">无相关书籍</span>
                                    </c:if>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="page-box page-box-special">

                    </div>
                </div>
            </div>
        </div>
    </div><!--mainbody-->
    <jsp:include page="footer.jsp"/></div>

<script type="text/javascript" src="${pageContext.request.contextPath}/new_style/js/gverify.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/new_style/js/login.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/new_style/js/jquery-1.8.0.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/new_style/js/jquery.SuperSlide.2.1.1.source.logintab.js" ></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/new_style/js/swiper.js" ></script>
<script>
    $(document).ready(function () {
        fillNav();
    });

    function fillNav() {
        $.ajax({
            url:"${pageContext.request.contextPath}/home/bookSearch/books.do",
            type:"get",
            success:function (data) {
                jQuery.each(data,function (i,bookType) {
                    $(".book_section_sub_nav ul").append(
                        '<li class="swiper-slide">' +
                        '<a href="${pageContext.request.contextPath}/home/bookArtList.do?ptype=' +
                            bookType.id +
                            '">'+
                            bookType.typeName +
                            '</a></li>'
                    )
                    $("#bookNav").append(
                        '<li ><a href="${pageContext.request.contextPath}/home/bookArtList.do?ptype='+
                        bookType.id +
                        '">' +
                        bookType.typeName +
                        '</a></li>'
                    )
                });
                $(".book_section_sub_nav ul").prepend('<li class="swiper-slide"><a href="${pageContext.request.contextPath}/home/bookTypeList.do">所有图书</a></li>')
            }
        })

    }

    function tabs(obj,swiperObj,className) {
        var tabSwiper = new Swiper(swiperObj, {
            effect : 'slide',//切换效果
            speed : 0, //滑动速度，单位ms
            autoHeight: true, // 高度随内容变化
            allowTouchMove:false, //鼠标拖动无效
            onSlideChangeStart : function() {
                $(obj+"."+className).removeClass(className); /*有当前类名的删除类名,给下一个添加当前类名*/
                $(obj).eq(tabSwiper.activeIndex).addClass(className);/*activeIndex是过渡后的slide索引*/
            }
        });
        // 模拟点击事件，如果是移入事件，将mousedown 改为 mouseenter
        $(obj).on('touchstart mousedown', function(e) {
            e.preventDefault();/*清除默认事件*/
            $(obj+"."+className).removeClass(className);
            $(this).addClass(className); /*点击当前导航 改变当前样式*/
            tabSwiper.slideTo($(this).index());/*滑动到对应的滑块*/
        });
        $(obj).click(function(e) {
            e.preventDefault();/*清除默认点击事件*/
        });
    }
</script>
</body>
</html>
