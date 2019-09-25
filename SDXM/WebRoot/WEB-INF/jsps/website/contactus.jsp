<!DOCTYPE html>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <link rel="icon"
          href="${pageContext.request.contextPath}/favicon.ico" type="image/x-icon" />
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/favicon.ico" type="image/x-icon" />
    <title>上大出版社-联系我们</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/new_style/css/reset.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/new_style/css/main.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/new_style/css/about.css" />
</head>
<body>
<div class="container">
    <jsp:include page="header.jsp"></jsp:include>
    <div class="mainbody">
        <div class="contact-banner"></div>
        <div class="active-box">
            <a>首页</a>
            <a>互动专区</a>
        </div>

        <div class="contact-tab clearfix">
            <ul>
                <li><a>图书业务</a></li>
                <li class="on"><a>联系人及联系方式</a></li>
                <li><a>相关业务</a></li>
            </ul>
        </div>
        <div class="bg-gray contact-tab-box">
            <div class="section">
                <ul class="stystem-list">
                    <li>
                        <p class="stystem-title">关于出版的规章制度这是一个大标题</p>
                        <p class="stystem-info">规范期刊出版活动规范期刊出版活动规范期刊出版活动规范期刊出版活动规范期刊出版活动,加强期刊出版管理,根据国务院《出版管理条例》及相关法律法规,...健全期刊出版质量评估制度、期刊年度核验制度</p>
                        <a class="readmore">阅读更多</a>
                    </li>
                    <li>
                        <p class="stystem-title">关于出版的规章制度这是一个大标题</p>
                        <p class="stystem-info">规范期刊出版活动规范期刊出版活动规范期刊出版活动规范期刊出版活动规范期刊出版活动,加强期刊出版管理,根据国务院《出版管理条例》及相关法律法规,...健全期刊出版质量评估制度、期刊年度核验制度</p>
                        <a class="readmore">阅读更多</a>
                    </li>
                    <li>
                        <p class="stystem-title">关于出版的规章制度这是一个大标题</p>
                        <p class="stystem-info">规范期刊出版活动规范期刊出版活动规范期刊出版活动规范期刊出版活动规范期刊出版活动,加强期刊出版管理,根据国务院《出版管理条例》及相关法律法规,...健全期刊出版质量评估制度、期刊年度核验制度</p>
                        <a class="readmore">阅读更多</a>
                    </li>
                    <li>
                        <p class="stystem-title">关于出版的规章制度这是一个大标题</p>
                        <p class="stystem-info">规范期刊出版活动规范期刊出版活动规范期刊出版活动规范期刊出版活动规范期刊出版活动,加强期刊出版管理,根据国务院《出版管理条例》及相关法律法规,...健全期刊出版质量评估制度、期刊年度核验制度</p>
                        <a class="readmore">阅读更多</a>
                    </li>
                </ul>
            </div>
            <div class="page-box pb30">
                <ul>
                    <li><a>上一页</a></li>
                    <li><a>1</a></li>
                    <li><a>2</a></li>
                    <li><a>3</a></li>
                    <li><a>下一页</a></li>
                </ul>
            </div>
        </div>
        <div class="section bg-gray mb70 contact-tab-box">
            <div class="contact-box clearfix">
                <div class="contact-input clearfix">
                    <span>姓名</span>
                    <input type="text"  name="linkman" class="linkman" placeholder="请输入您的姓名"  />
                </div>
                <div class="contact-input clearfix">
                    <span>电话</span>
                    <input type="text"  name="phone" class="phone" placeholder="请输入您的电话" />
                    <span  class="warming_of_phone" style='color: red'>您的电话有误</span>
                </div>
                <div class="contact-input clearfix">
                    <span>邮箱</span>
                    <input type="text"   name="mail" class="mail" placeholder="请输入您的邮箱" />
                    <span  class="warming_of_mail" style='color: red'>您的邮箱有误</span>
                </div>
                <div class="contact-input w100 clearfix">
                    <span>留言</span>
                    <textarea  id="text_message" name="message" placeholder="请输入您的留言信息" ></textarea>
                </div>
            </div>
            <span class="btn" id="message_submit">提交</span>
            <input type="hidden" value="">
        </div>
        <div class="bg-gray contact-tab-box">
            <div class="section">
                <ul class="stystem-list">
                    <li>
                        <p class="stystem-title">关于出版的规章制度这是一个大标题</p>
                        <p class="stystem-info">规范期刊出版活动规范期刊出版活动规范期刊出版活动规范期刊出版活动规范期刊出版活动,加强期刊出版管理,根据国务院《出版管理条例》及相关法律法规,...健全期刊出版质量评估制度、期刊年度核验制度</p>
                        <a class="readmore">阅读更多</a>
                    </li>
                    <li>
                        <p class="stystem-title">关于出版的规章制度这是一个大标题</p>
                        <p class="stystem-info">规范期刊出版活动规范期刊出版活动规范期刊出版活动规范期刊出版活动规范期刊出版活动,加强期刊出版管理,根据国务院《出版管理条例》及相关法律法规,...健全期刊出版质量评估制度、期刊年度核验制度</p>
                        <a class="readmore">阅读更多</a>
                    </li>
                    <li>
                        <p class="stystem-title">关于出版的规章制度这是一个大标题</p>
                        <p class="stystem-info">规范期刊出版活动规范期刊出版活动规范期刊出版活动规范期刊出版活动规范期刊出版活动,加强期刊出版管理,根据国务院《出版管理条例》及相关法律法规,...健全期刊出版质量评估制度、期刊年度核验制度</p>
                        <a class="readmore">阅读更多</a>
                    </li>
                    <li>
                        <p class="stystem-title">关于出版的规章制度这是一个大标题</p>
                        <p class="stystem-info">规范期刊出版活动规范期刊出版活动规范期刊出版活动规范期刊出版活动规范期刊出版活动,加强期刊出版管理,根据国务院《出版管理条例》及相关法律法规,...健全期刊出版质量评估制度、期刊年度核验制度</p>
                        <a class="readmore">阅读更多</a>
                    </li>
                </ul>
            </div>
            <div class="page-box pb30">
                <ul>
                    <li><a>上一页</a></li>
                    <li><a>1</a></li>
                    <li><a>2</a></li>
                    <li><a>3</a></li>
                    <li><a>下一页</a></li>
                </ul>
            </div>
        </div>
        </div>
    <jsp:include page="footer.jsp"></jsp:include>
    </div>

<script>
    $('.contact-tab li').click(function(){
        var liindex = $(this).index();
        $(this).addClass('on').siblings('li').removeClass('on');
        if(liindex < 0){
            return false;
        }
        $('.contact-tab-box').eq(liindex).show().siblings('.contact-tab-box').hide();
    });
//    $('.contact-tab li').eq(1).trigger('click');
</script>
<script type="text/javascript">
    /*$('.nav_list_first li').click(function(){
        $(this).addClass('on').siblings().removeClass('on');
        var liindex = $(this).index();
        $('.nav_second_list:eq('+liindex+')').slideDown().siblings('.nav_second_list').hide();
    });*/
    $(function () {
        $(".warming_of_phone").hide();
        $(".warming_of_mail").hide();
        var liindex = {"8":-1,"20":2}[${lastType}] || 1;
        if(liindex == -1){
            liindex =0;
        }
        var firstPage = {'${lastType}':${page}}[${lastType}] || 1;
        $('.contact-tab li').eq(liindex).addClass('on').siblings('li').removeClass('on');
        $('.contact-tab-box').eq(liindex).show().siblings('.contact-tab-box').hide();
        if(${lastType eq 8}){
            updateNews(8,firstPage,0);
            updateNews(20,1,2);
        }else if(${lastType eq 20}){
            updateNews(8,1,0);
            updateNews(20,firstPage,2);
        }else {
            updateNews(8,1,0);
            updateNews(20,1,2);
        }
    });
    function updateNews(type,page,index) {
        $.ajax({
            url:"${pageContext.request.contextPath}/home/type_news.do?type="+type+"&page="+page,
            type:"get",
            success:function (data) {
                console.log(data);
                if(index==2){
                    index-=1;
                }
                $(".stystem-list").eq(index).children().remove();
                jQuery.each(data.results,function (i,news) {
                    $(".stystem-list").eq(index).prepend("<li>" +
                        "<p class='stystem-title'>"+news.title+"</p>" +
                        "<p class='stystem-info'>"+news.summary+"</p>" +
                        "<a class='readmore' href='${pageContext.request.contextPath}/home/systemdetail.do?id="+news.id+"&page="+page+"'>阅读更多</a>" +
                        "</li>")
                });
                var totolPage=Math.ceil(data.totalCount/data.pageSize);
                var str="<ul>";

                if (totolPage<6){
                    if(page!=1) {
                        str += "<li><a onclick='updateNews("+type+","+(page-1)+","+index+")'>上一页</a></li>";
                    }
                    for (var i=1;i<=totolPage;i++){
                        if (page==i) {
                            str += "<li class='on'><a onclick='updateNews(" + type + "," + i + "," + index + ")'>" + i + "</a></li>";
                        }else {
                            str += "<li><a onclick='updateNews(" + type + "," + i + "," + index + ")'>" + i + "</a></li>";
                        }
                     }
                    if(page!=totolPage) {
                        str += "<li><a onclick='updateNews("+type+","+(page+1)+","+index+")'>下一页</a></li>";
                    }
                }else {
                    if(page>3){
                        str += "<li><a onclick='updateNews("+type+","+1+","+index+")'>首页</a></li>";
                    }
                    if(page!=1) {
                        str += "<li><a onclick='updateNews("+type+","+(page-1)+","+index+")'>上一页</a></li>";
                    }
                    if(page>3){
                        str += "<li><a >...</a></li>";
                    }
                    for (var j=page-2;j<=page+2;j++){
                        if (page==j) {
                            str += "<li class='on'><a onclick='updateNews(" + type + "," + j + "," + index + ")'>" + j + "</a></li>";
                        }else {
                            str += "<li><a onclick='updateNews(" + type + "," + j + "," + index + ")'>" + j + "</a></li>";
                        }
                    }
                    if(page<totolPage-3){
                        str += "<li><a >...</a></li>";
                    }
                    if(page!=totolPage) {
                        str += "<li><a onclick='updateNews("+type+","+(page+1)+","+index+")'>下一页</a></li>";
                    }
                    if(page<totolPage-3){
                        str += "<li><a onclick='updateNews("+type+","+totolPage+","+index+")'>末页</a></li>";
                    }
                }
                str+="</ul>";

                $(".page-box").eq(index).children().remove();
                $(".page-box").eq(index).prepend(str);
//                $(".page-box li").eq(page-1).addClass("on").sibling().removeClass("on");
            }
        })
    }
    $(".phone").blur(function () {
        var pattern=/^\d{7,11}$/g;
        if(pattern.test($(this).val())){
            $(this).css("color","#333");
            $("input[type=hidden]").val("true");
            $(".warming_of_phone").hide();
        }else {
            $(".warming_of_phone").show();
            $("input[type=hidden]").val("false");
        }
    });
    $(".mail").blur(
        function () {
            var pattern=/^(\w)+(\.\w+)*@(\w)+((\.\w+)+)$/;
            if(pattern.test($(this).val())){
                $(this).css("color","#333");
                $("input[type=hidden]").val("true");
                $(".warming_of_mail").hide();
            }else {
                $(".warming_of_mail").show();
                $("input[type=hidden]").val("false");
            }
        }
    );
    $("#message_submit").click(function () {
        var linkman = $(".linkman").val();
        var phone = $(".phone").val();
        var mail = $(".mail").val();
        var message = $("#text_message").val();
        if($("input[type=hidden]").val()=="true" && linkman!=='' && message!='' ){
          var formdata = new FormData();
          formdata.append("linkman",linkman);
          formdata.append("phone",phone);
          formdata.append("mail",mail);
          formdata.append("message",message);
          $.ajax({
              url:"${pageContext.request.contextPath}/contacts/submit_contacts.do",
              type:"POST",
              data:formdata,
              processData: false,
              contentType: false,
              success:function (data) {
                  alert("成功");
                  location.reload();
              },
              error:function (data) {
                  location.reload();
              }
          })
        }else {
            alert("您的输入有误");
        }

    });
</script>
<script type="text/javascript" src="${pageContext.request.contextPath}/new_style/js/jquery-1.8.0.min.js" ></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/new_style/js/main.js" ></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/new_style/js/gverify.js" ></script>
</body>
</html>