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
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    List<Map<String, Object>> nav = SpringContextHolder.getBean(IBooktypeService.class).getParentMappedTypes();
    session.setAttribute("nav", nav);
%>
<div class="main_banner_nav">
    <div class="main_banner_nav_title">
        <p>图书分类</p>
        <i>BOOK CLASSFICATION</i>
    </div>
    <div class="main_banner_nav_list clearfix">
        <div class="main_banner_nav_list clearfix">
            <ul class="nav_list_first">
                <c:forEach items="${nav}" var="item">
                    <li><a href="javascript:void(0)">${item.name}</a></li>
                </c:forEach>
            </ul>
            <c:forEach items="${nav}" var="nav_item">
                <div class="nav_second_list">
                    <c:forEach items="${nav_item.sub}" var="type_item">
                        <a class="nav_second"
                           href="${pageContext.request.contextPath}/home/bookArtTypeList.do?type=${type_item.id}">${type_item.typeName}</a>
                    </c:forEach>
                </div>
            </c:forEach>
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
        $('.nav_second_list:eq(' + liindex + ')').show().siblings('.nav_second_list').hide();
    });
    $('.main_banner_nav').mouseleave(function () {
        $('.nav_second_list').each(function () {
            $(this).slideUp();
        })
    })
</script>
