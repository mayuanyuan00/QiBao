<%@ page language="java" import="java.util.*" pageEncoding="utf-8" contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>上海大学出版社-后台管理系统</title>
    <!-- CSS -->
    <link href="${pageContext.request.contextPath}/css/alogin.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath}/css/supersized.css" rel="stylesheet" type="text/css">
    <style>
        .topB img {
            margin-top: 35px;
        }
    </style>
</head>
<body background="${pageContext.request.contextPath}/images/login/bg.gif" >
<%--<form action="<c:url value='/user/login.do?loginType=admin'/>" method="post" id="theForm" name="theForm">--%>
<form  action="<c:url value='/adminUser/loginAdmin.do?loginType=admin'/>" method="post" id="theForm" name="theForm" onsubmit="return checkUser()">
    <input type="hidden" name="error" value="${error}">
    <input type="hidden" name="groupCode" value="0">
    <div class="Main">
        <ul>
            <li class="top"></li>
            <li class="top2"><span>上海大学出版社后台管理系统</span></li>
            <li class="topA"></li>
            <li class="topB"><span><span><img
                    src="${pageContext.request.contextPath}/images/login/logo.jpg" width="140px;" height="140px;"/></span></span></li>
            <li class="topC"></li>
            <li class="topD">
                <ul class="login">
                    <li><span class="left login-text">用户名：</span> <span style="left:0;">
                        <input id="Text1" type="text" class="txt" name="userName"/>
                    </span></li>
                    <li><span class="left login-text">密码：</span> <span style="left:0;">
                       <input id="Text2" type="password" class="txt" name="password"/>
                    </span></li>

                </ul>
            </li>
            <li class="topE"></li>
            <li class="middle_A"></li>
            <li class="middle_B"></li>
            <li class="middle_C">
                <span class="btn1">
                    <input name="submit" id="submit" type="image"
                           src="${pageContext.request.contextPath}/images/login/btnlogin.gif"/>
                </span>
            </li>
            <li class="middle_D"></li>
            <li class="bottom_A"></li>
            <li class="bottom_B"></li>
        </ul>
    </div>
    <div class="alert" style="display:none">
        <h2>消息</h2>
        <div class="alert_con">
            <p id="ts" style="text-align:center;"></p>
            <p style="line-height:70px"><a class="btn">确定</a></p>
        </div>
    </div>
</form>
<script src="<c:url value='${pageContext.request.contextPath}/js/supersized.3.2.7.min.js'/>"></script>
<script>
    $(function () {
        var u = $("input[name=userName]");
        u.blur(function () {
            if (u.val() != '') {
                $.ajax({
                    url: "/adminUser/userCheck.do?name=" + u.val(),
                    success: function (data) {
                        if (data == "success") {
                            $("#ts").html("用户名不存在");
                            is_show();
                        }
                    }
                });
            }
        });
        var e = $("input[name=error]");
        if(e.val()=="error") {
            $("#ts").html("密码不正确");
            is_show();
        }

    })
    function checkUser() {
        var u = $("input[name=userName]");
        var p = $("input[name=password]");
        if (u.val() == '' || p.val() == '') {
            $("#ts").html("用户名或密码不能为空~");
            is_show();
            return false;
        }
    }

    $(".btn").bind('click', function () {
        is_hide();
    })
    function is_hide() {
        $(".alert").animate({"top": "-40%"}, 300);
    }

    function is_show() {
        $(".alert").show().animate({"top": "45%"}, 300);
    }

    //    window.onload = function () {
    //        $(".connect p").eq(0).animate({"left": "0%"}, 600);
    //        $(".connect p").eq(1).animate({"left": "0%"}, 400);
    //        if (e.val() == "error") {
    //            $("#ts").html("用户不存在！");
    //            is_show();
    //            return false;
    //        }
    //    };
    //

    <%--jQuery(function($){--%>
    <%----%>
    <%--$.supersized({--%>
    <%----%>
    <%--// Functionality--%>
    <%--slide_interval     : 6000,    // Length between transitions--%>
    <%--transition         : 1,    // 0-None, 1-Fade, 2-Slide Top, 3-Slide Right, 4-Slide Bottom, 5-Slide Left, 6-Carousel Right, 7-Carousel Left--%>
    <%--transition_speed   : 3000,    // Speed of transition--%>
    <%--performance        : 1,    // 0-Normal, 1-Hybrid speed/quality, 2-Optimizes image quality, 3-Optimizes transition speed // (Only works for Firefox/IE, not Webkit)--%>
    <%----%>
    <%--// Size & Position--%>
    <%--min_width          : 0,    // Min width allowed (in pixels)--%>
    <%--min_height         : 0,    // Min height allowed (in pixels)--%>
    <%--vertical_center    : 1,    // Vertically center background--%>
    <%--horizontal_center  : 1,    // Horizontally center background--%>
    <%--fit_always         : 0,    // Image will never exceed browser width or height (Ignores min. dimensions)--%>
    <%--fit_portrait       : 1,    // Portrait images will not exceed browser height--%>
    <%--fit_landscape      : 0,    // Landscape images will not exceed browser width--%>
    <%----%>
    <%--// Components--%>
    <%--slide_links        : 'blank',    // Individual links for each slide (Options: false, 'num', 'name', 'blank')--%>
    <%--slides             : [    // Slideshow Images--%>
    <%--{image : '${pageContext.request.contextPath}/images/1.jpg'},--%>
    <%--{image : '${pageContext.request.contextPath}/images/2.jpg'},--%>
    <%--{image : '${pageContext.request.contextPath}/images/3.jpg'}--%>
    <%--]--%>
    <%--});--%>
    <%--}); --%>
    //判断当前窗口是否有顶级窗口，如果有就让当前的窗口的地址栏发生变化，
    //function loadTopWindow(){
        if (window.top!=null && window.top.document.URL!=document.URL){
            window.top.location= document.URL; //这样就可以让登陆窗口显示在整个窗口了
        }
    //}
</script>
</body>
</html>

