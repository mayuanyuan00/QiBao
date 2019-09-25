<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: cqc
  Date: 2017/11/1
  Time: 19:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="header" id="header">
    <div class="header_inner">
        <div class="clearfix">
            <a class="logo" href="${pageContext.request.contextPath}/home/homeIndex.do"><img src="${pageContext.request.contextPath}/websit_style/img/logo.png"></a>
            <div class="header_rightbox">

                    <p class="header_login" style="visibility: hidden;"><a href="${pageContext.request.contextPath}/home/personalInformation.do">${sessionScope.user.userName}</a><a  href="javascript:void(0)" onclick="loginOut()">注销</a></p>

                <div class="header_operate">
                    <a class="shopping_btn" href="${pageContext.request.contextPath}/cart/shoppingcart.do" onclick="return checkLogin()">购书通道</a>
                    <div class="search_box">
                        <form method="post" action="${pageContext.request.contextPath}/search/search.do" onsubmit="return checkNull()">
                            <input type="text" id="key" name="keyword" class="search_input" placeholder="请输入图书关键词"/>
                            <input type="submit" id="submit" class="search_btn" value="搜索" />
                        </form>

                    </div>
                </div><!--header_operate-->
            </div><!--header_rightbox-->
        </div>
        <div class="nav_box">
            <ul>
                <li><a href="${pageContext.request.contextPath}/home/homeIndex.do" >首页</a></li>
                <li><a href="${pageContext.request.contextPath}/home/newsList.do">新闻公告</a></li>
                <li><a href="${pageContext.request.contextPath}/home/bookTypeList.do">图书专区</a></li>
                <li><a href="#">数字出版</a></li>
                <li><a href="${pageContext.request.contextPath}/home/contact.do">互动专区</a></li>
                <li><a href="${pageContext.request.contextPath}/home/pressIntroduction.do">关于我们</a></li>
            </ul>

        </div><!--nav_box-->
    </div><!--header_inner-->
</div>
<script type="text/javascript" src="${pageContext.request.contextPath}/websit_style/js/jquery-1.8.0.min.js" ></script>
<script type="text/javascript">
    function checkNull() {
        var t = $("#key");
        if ($.trim(t.val()) == ""){
            alert("不能输入为空");
            return false;
        }
    }
    $(function () {
        var pageUrl = window.location.href;
        var aArray= $('.nav_box ul li a');
        for (var i = 0; i < aArray.length; i++) {
           var a=aArray[i].href;
        if (pageUrl.search(a)!=-1) {
                $(aArray[i]).css({'background':'#fff','color':'#7c5028'});
            }
        }
    });
    
   $('.nav_box ul li a').click(function () {
       $('.nav_box ul li a').not($(this)).css({'background':'#fff','color':'#333'});
        $(this).css({'background':'#816a52','color':'#fff'});
    });
   function checkLogin() {
       <c:if test="${empty sessionScope.user}">
       alert("请先登陆");
       return false;
       </c:if>
       <c:if test="${not empty sessionScope.user}">
       return true;
       </c:if>

   }
    
   
</script>
