<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 4/15/2018
  Time: 10:26 PM
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8" %>
<%@ page import="java.util.Map" %>
<%@ page import="cn.com.domain.Booktype" %>
<%@ page import="cn.com.service.IBooktypeService" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="cn.com.utils.SpringContextHolder" %>
<%@ page import="cn.com.domain.Booktype" %>
<%@ page import="cn.com.service.IBookService" %>

<%
    List<Booktype> booktypes = SpringContextHolder.getBean(IBooktypeService.class).getAllTypes(null);
    List<Map<String, Object>> bookTypeResults = new ArrayList<Map<String, Object>>();
    session.setAttribute("result", bookTypeResults);
    for (Booktype booktype : booktypes) {
        Map<String, Object> result = new HashMap<String, Object>();
        bookTypeResults.add(result);

        result.put("id", booktype.getId());
        result.put("name", booktype.getTypeName());
        result.put("books", SpringContextHolder.getBean(IBookService.class).getResultOfParentType(booktype.getId().toString(), 1, 3));
    }
%>
<ul class="book_section_nav clearfix" id="bookNav">
    <li class="active"><a href="${pageContext.request.contextPath}/home/bookTypeList.do">所有图书</a></li>
    <c:forEach items="${result}" var="item">
        <li id="${item.id}">
            <a href="${pageContext.request.contextPath}/home/bookArtList.do?ptype=${item.id}">${item.name}</a>
        </li>
    </c:forEach>
</ul>

<script>
    $("#bookNav li a").each(function () {
        $this = $(this);
        if($this[0].href==String(window.location)){
            $this.parent().addClass("active");
        }
    });
//    $(".book_section_nav li").click(function () {
//        $(this).addClass("active").sibling("li").removeClass("active");
//    });
</script>

