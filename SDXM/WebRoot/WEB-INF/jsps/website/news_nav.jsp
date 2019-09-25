<%--
  Created by IntelliJ IDEA.
  User: gx007
  Date: 2017/11/3
  Time: 18:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="cn.com.utils.SpringContextHolder" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.List" %>
<%@ page import="cn.com.service.IBooktypeService" %>
<%@ page import="cn.com.service.IMenuService" %>
<%@ page import="cn.com.domain.Columnlist" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    List<Columnlist> columnlist = SpringContextHolder.getBean(IMenuService.class).columnsOfNews();
    session.setAttribute("nav", columnlist);
%>
<div class="main_banner_nav">
    <div class="main_banner_nav_title">
        <p>新闻公告</p>
        <i>News</i>
    </div>
    <div class="main_banner_nav_list clearfix">
        <div class="main_banner_nav_list clearfix">
            <ul class="nav_list_first">
                <c:forEach items="${nav}" var="item">
                    <li><a href="${pageContext.request.contextPath}/home/newsList.do?type=${item.id}">${item.name}</a></li>
                </c:forEach>
            </ul>
        </div>
    </div>
</div>
<!--main_banner_nav-->
<div class="main_container">

</div>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<script>
    $('.nav_list_first li').hover(function () {
        $(this).addClass('on').siblings().removeClass('on');
        var liindex = $(this).index();
        $('.nav_second_list:eq(' + liindex + ')').slideDown().siblings('.nav_second_list').hide();
    });
    $('.main_banner_nav').mouseleave(function () {
        $('.nav_second_list').each(function () {
            $(this).slideUp();
        })
    })
</script>
