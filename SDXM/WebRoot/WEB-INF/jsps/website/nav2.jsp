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
<%@ page import="cn.com.domain.Book" %>
<%@ page import="cn.com.vo.PageResults" %>
<%@ page import="cn.com.service.IBookService" %>
<%@ page import="cn.com.domain.Booktype" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    List<Map<String, Object>> nav = SpringContextHolder.getBean(IBooktypeService.class).getParentMappedTypes();
    session.setAttribute("nav", nav);
%>
<div class="section-more clearfix"><a href="${pageContext.request.contextPath}/home/bookTypeList.do">更多</a></div>
<div class="book-nav">
    <div class="book-left-nav">
        <ul>
            <%--href="${pageContext.request.contextPath}/home/bookTypeList.do"--%>
            <li class="nav-first on"><a  data-id="all">所有分类</a> <ul class="nav-second-box"></ul></li>
            <c:forEach items="${nav}" var="item">
                <li class="nav-first <c:if test='${not empty item.sub and item.sub.size()>0}'>have-child</c:if> ">
                    <a data-id="${item.id}">${item.name}</a>
                    <%--href="${pageContext.request.contextPath}/home/bookArtList.do?ptype=${item.id}"--%>
                    <ul class="nav-second-box">
                    <c:if test="${not empty item.sub}">
                        <c:forEach items="${item.sub}" var="item_sub">
                        <li class="nav-second">
                            <a href="${pageContext.request.contextPath}/home/bookArtList.do?ptype=${item.id}&jumpType=${item_sub.id}">${item_sub.typeName}</a>
                        </li>
                        </c:forEach>
                    </c:if>
                    </ul>
                </li>
            </c:forEach>
        </ul>
    </div>
    <div class="book-right-list show">
        <ul>
            <c:forEach items="${recommend}" var="book">
                <c:if test="${book.auditing=='improt_book_abcdefgh'}">
                     <li class="clearfix">
                         <a href="${pageContext.request.contextPath}/home/bookDetail.do?id=${book.id}"  title="${book.bookName}">
                            <div class="clearfix">
                             <div class="book-pic">
                                <img style="width: 100%" src="${pageContext.request.contextPath}${book.imageurl}" />
                             </div>
                         <div class="book-info-box">
                            <p class="book-title">${book.bookName}</p>
                            <p>作者：${book.author}</p>
                            <p>书号：${book.isbn}</p>
                            <p>定价：${book.price}</p>
                             <p>出版日期：${book.publicationDate}</p>
                            <p class="book-intro">${book.contentvalidity}</p>
                         </div>
                            </div>
                         </a>
                     </li>
                </c:if>
            </c:forEach>
        </ul>
    </div>


</div><!--book-nav-->
<script type="text/javascript"
        src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<script>
    $(".nav-first a").click(function (e) {
        var str=$(this).attr("data-id");
        if(str=='all'){
            window.location.href="${pageContext.request.contextPath}/home/bookTypeList.do"
        }else {
        window.location.href="${pageContext.request.contextPath}/home/bookArtList.do?ptype="+str;
        }
    })
</script>
