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
    <title>上大出版社-相关制度详情</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/new_style/css/reset.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/new_style/css/main.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/new_style/css/about.css" />

</head>


<body>
<div class="container">
    <jsp:include page="header.jsp"></jsp:include>
        <div class="mainbody">
            <div class="active-box">
                <a>首页</a>
                <a>${par}</a>
                <a>${chi}</a>
            </div>
            <div class="about-box">
                <div class="about-detail-title">
                    <p class="iTitle">${news.title}</p>
                    <p><c:if test="${not empty news.publisher}"><span id="s_author">作者：${news.publisher}</span></c:if><span>时间：${news.createTime}</span></p>
                </div>
                <div class="about-detail-box">
                    ${news.content}
                </div>
                <c:choose>
                    <c:when test="${par ne '关于我们'}">
                        <div class="about-back">
                            <a href=”#” onClick="window.history.back(-1); return false">返回上一页</a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="about-back">
                            <a href=”#” onClick="window.history.back(-1); return false">返回上一页</a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    <jsp:include page="footer.jsp"></jsp:include>
</div>
<script type="text/javascript" src="${pageContext.request.contextPath}/new_style/js/jquery-1.8.0.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/new_style/js/main.js"></script>
</body>

</html>

