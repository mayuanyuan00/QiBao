<!DOCTYPE html>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8" %>
<%@ page import="java.util.Map" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  <link rel="icon"
        href="${pageContext.request.contextPath}/favicon.ico" type="image/x-icon" />
  <link rel="shortcut icon" href="${pageContext.request.contextPath}/favicon.ico" type="image/x-icon" />
  <title>图书专区</title>

  <!-- CSS -->
  <link href="${pageContext.request.contextPath}/new_style/css/reset.css" rel="stylesheet" type="text/css">
  <link href="${pageContext.request.contextPath}/new_style/css/main.css" rel="stylesheet" type="text/css">
  <link href="${pageContext.request.contextPath}/new_style/css/book-section.css" rel="stylesheet" type="text/css">

  <style type="text/css">
    .ellipsis {
      overflow: hidden;
      text-overflow: ellipsis;
      white-space: nowrap;
    }
  </style>
  <%
    /// 这儿设置的是booktype的class名字，若第一级的booktype有更改，需要改此处
    Map<Integer, String> booktypeCls = new HashMap<Integer, String>();
    booktypeCls.put(12, "book_classification_teach");//教材专著
    booktypeCls.put(13, "book_classification_human");//人文社科
    booktypeCls.put(14, "book_classification_art");//艺术类
    booktypeCls.put(15, "book_classification_sea");//海派文化
    booktypeCls.put(18, "book_classification_tool");//工具书
    booktypeCls.put(16, "book_classification_school");//基础教育
    booktypeCls.put(17, "book_classification_ancient");//古籍文献
    booktypeCls.put(19, "book_classification_others");//其他
    request.setAttribute("booktypeCls", booktypeCls);
  %>

</head>

<body>
<div class="container">
  <jsp:include page="header.jsp"/>
  <%--<div class="mianbody">--%>
    <%--<div class="main_banner clearfix">--%>
      <%--<div class="main_banner_bg"></div>--%>
      <%--<div class="main_banner_inner clearfix w1200">--%>
        <%--<jsp:include page="nav.jsp"/>--%>
        <%--<div class="main_container_special">--%>
          <%--<ul class="book_type_list clearfix">--%>
            <%--<c:forEach items="${result}" var="item">--%>
              <%--<li>--%>
                <%--<div class="book_type_name">--%>
                  <%--<div class="book_type_name_left ${booktypeCls[item.id]}">${item.name}</div>--%>
                  <%--<div class="book_type_name_right"><a--%>
                      <%--href="${pageContext.request.contextPath}/home/bookArtTypeList.do?type=${item.id}">更多--%>
                    <%--&gt&gt</a></div>--%>
                  <%--<ul class="book_list">--%>
                    <%--<c:forEach items="${item.books.results}" var="book">--%>
                      <%--<li>--%>
                        <%--<div class="book_BG"><a--%>
                            <%--href="${pageContext.request.contextPath}/home/bookDetail.do?id=${book.id}"><img--%>
                            <%--src="${pageContext.request.contextPath}${book.imageurl}"--%>
                            <%--alt=""/></a></div>--%>
                        <%--<a href="${pageContext.request.contextPath}/home/bookDetail.do?id=${book.id}"--%>
                           <%--class="ellipsis" title="${book.bookName}"--%>
                        <%-->${book.bookName}</a>--%>
                      <%--</li>--%>
                    <%--</c:forEach>--%>
                  <%--</ul>--%>
                <%--</div>--%>

              <%--</li>--%>
            <%--</c:forEach>--%>
          <%--</ul>--%>
          <%--<div class="back_btn">--%>
            <%--<a href="javascript:void(0)" onclick="goback()">返回</a>--%>
          <%--</div><!--返回按钮-->--%>
          <%--<div class="blank"></div>--%>
        <%--</div>--%>
      <%--</div><!--main_banner_inner-->--%>

    <%--</div>--%>

  <%--</div>--%>

  <div class="mainbody">
    <div class="book_section_banner">
    </div>
    <div class="book_section">
      <div class="active-box no-border">
        <a href="${pageContext.request.contextPath}/home/enter.do">首页</a>
        <a href="${pageContext.request.contextPath}/home/bookTypeList.do">图书专区</a>
      </div>

      <jsp:include page="book_navigation.jsp"/>

      <ul class="book_section_all_book_classification clearfix">
        <c:forEach items="${result}" var="item">
        <li>
          <div class="book_section_all_book_title ${booktypeCls.get(item.id)}">
            <%--<div class="book_section_all_book_title book_classification_teach">--%>

            <h4>${item.name}</h4>
            <span>NEWS CENTER</span>
            <a href="${pageContext.request.contextPath}/home/bookArtList.do?ptype=${item.id}" class="book_section_all_book_title_more">更多 >></a>
          </div>

          <ul class="book_section_all_book_book_list clearfix">
            <c:forEach items="${item.books.results}" var="book">
            <li>
              <a href="${pageContext.request.contextPath}/home/bookDetail.do?id=${book.id}">
              <div>
                <img src="${pageContext.request.contextPath}${book.imageurl}" alt="" />
              </div>
              <span>${book.bookName}</span>
              </a>
            </li>
            </c:forEach>
          </ul>

        </li>
        </c:forEach>
      </ul>
    </div>
  </div><!--mainbody-->
  <jsp:include page="footer.jsp"/>
</div>
<script type="text/javascript" src="${pageContext.request.contextPath}/new_style/js/jquery-1.8.0.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/new_style/js/gverify.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/new_style/js/main.js" ></script>
<%--<script type="text/javascript" src="${pageContext.request.contextPath}/new_style/js/jquery.SuperSlide.2.1.1.source.logintab.js" ></script>--%>
<%--<script type="text/javascript" src="${pageContext.request.contextPath}/new_style/js/login.js"></script>--%>
</body>

</html>