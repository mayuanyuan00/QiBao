<%@ page import="cn.com.common.CServletListener" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%--<link rel="stylesheet" href="${pageContext.request.contextPath}/new_style/css/reset.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/new_style/css/main.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/new_style/css/swiper.min.css" />--%>

<div class="footer">
    <div class="footer-inner">
        <div class="link-list-box">
            <div class="link-list">
                <div class="list-title">友情链接</div>
                <ul>
                        <c:forEach end="4" var="links" items="${urlList}" varStatus="status">
                            <li><a target="_blank" href="http://${links.url}" style="color: white">${links.title}</a></li>
                        </c:forEach>
                </ul>
            </div>
            <div class="link-list">
                <div class="list-title">关于我们</div>
                <ul>
                    <li><a href="${pageContext.request.contextPath}/home/newsList.do" style="color: whitesmoke">企业新闻</a></li>
                    <li><a href="${pageContext.request.contextPath}/home/systemdetail.do?id=21&homeType=home" style="color: whitesmoke">社长致辞</a></li>
                    <li><a href="${pageContext.request.contextPath}/home/systemdetail.do?id=QGsUQMbzA06kqqYaPI486s1ppS7CajLI" style="color: whitesmoke">企业简介</a></li>
                    <li><a href="${pageContext.request.contextPath}/home/structure.do" style="color: whitesmoke">组织机构</a></li>
                </ul>
            </div>
            <div class="link-list">
                <div class="list-title">联系我们</div>
                <ul>
                    <li><a>地址：上大路99号</a></li>
                    <li><a>邮政编码：200444</a></li>
                    <li><a>电话：021-66135122</a></li>
                </ul>
            </div>
        </div><!--link-list-box-->
        <div class="code-box">
            <div class="code">
                <img src="${pageContext.request.contextPath}/new_style/img/bottom_01.png"/>
                <span>上海大学出版社淘宝店</span>
            </div>
            <div class="code">
                <img src="${pageContext.request.contextPath}/new_style/img/bottom_02.png"/>
                <span>扫码关注微博公众号</span>
            </div>
            <div class="code">
                <img src="${pageContext.request.contextPath}/new_style/img/bottom_03.png"/>
                <span>扫码关注微信公众号</span>
            </div>
        </div><!--code-box-->
        <p class="copyright">Copyright © 2017 <a>www.shupress.cn</a> Inc. All Rights Reserved. 上海大学出版社 版权所有  <a href="http://www.beian.gov.cn/portal/registerSystemInfo?recordcode=17050402"><font color="#e5dfda">沪ICP备17050402号</font></a><i class="uesrAccessInfo">访问量： <%=CServletListener.count.get() %></i></p>
    </div><!--footer-inner-->
</div>


