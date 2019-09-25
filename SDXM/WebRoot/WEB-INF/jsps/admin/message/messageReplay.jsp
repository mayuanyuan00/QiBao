<%@ page language="java" import="java.util.*" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>左侧导航menu</title>
    <link href="${pageContext.request.contextPath}/css/css.css" type="text/css" rel="stylesheet"/>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/sdmenu.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/ckeditor/ckeditor.js"></script>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/images/favicon.ico"/>
    <link href="${pageContext.request.contextPath}/css/css.css" type="text/css" rel="stylesheet"/>
    <style>
        body {
            overflow-x: hidden;
            background: #f2f0f5;
            padding: 15px 0px 10px 5px;
        }

        #searchmain {
            font-size: 12px;
        }

        #search {
            font-size: 12px;
            background: #548fc9;
            margin: 10px 10px 0 0;
            display: inline;
            width: 100%;
            color: #FFF
        }

        #search form span {
            height: 40px;
            line-height: 40px;
            padding: 0 0px 0 10px;
            float: left;
        }

        #search form input.text-word {
            height: 24px;
            line-height: 24px;
            width: 180px;
            margin: 8px 0 6px 0;
            padding: 0 0px 0 10px;
            float: left;
            border: 1px solid #FFF;
        }

        #search form input.text-but {
            height: 24px;
            line-height: 24px;
            width: 55px;
            background: url(images/main/list_input.jpg) no-repeat left top;
            border: none;
            cursor: pointer;
            font-family: "Microsoft YaHei", "Tahoma", "Arial", '宋体';
            color: #666;
            float: left;
            margin: 8px 0 0 6px;
            display: inline;
        }

        #search a.add {
            background: url(images/main/add.jpg) no-repeat 0px 6px;
            padding: 0 10px 0 26px;
            height: 40px;
            line-height: 40px;
            font-size: 14px;
            font-weight: bold;
            color: #FFF
        }

        #search a:hover.add {
            text-decoration: underline;
            color: #d2e9ff;
        }

        #main-tab {
            border: 1px solid #eaeaea;
            background: #FFF;
            font-size: 12px;
        }

        #main-tab th {
            font-size: 12px;
            background: url(images/main/list_bg.jpg) repeat-x;
            height: 32px;
            line-height: 32px;
        }

        #main-tab td {
            font-size: 12px;
            line-height: 40px;
        }

        #main-tab td a {
            font-size: 12px;
            color: #548fc9;
        }

        #main-tab td a:hover {
            color: #565656;
            text-decoration: underline;
        }

        .bordertop {
            border-top: 1px solid #ebebeb
        }

        .borderright {
            border-right: 1px solid #ebebeb
        }

        .borderbottom {
            border-bottom: 1px solid #ebebeb
        }

        .borderleft {
            border-left: 1px solid #ebebeb
        }

        .gray {
            color: #dbdbdb;
        }

        td.fenye {
            padding: 10px 0 0 0;
            text-align: right;
        }

        .bggray {
            background: #f9f9f9;
            font-size: 14px;
            font-weight: bold;
            padding: 10px 10px 10px 0;
            width: 120px;
        }

        .main-for {
            padding: 10px;
        }

        .main-for input.text-word {
            width: 310px;
            height: 36px;
            line-height: 36px;
            border: #ebebeb 1px solid;
            background: #FFF;
            font-family: "Microsoft YaHei", "Tahoma", "Arial", '宋体';
            padding: 0 10px;
        }

        .main-for select {
            width: 310px;
            height: 36px;
            line-height: 36px;
            border: #ebebeb 1px solid;
            background: #FFF;
            font-family: "Microsoft YaHei", "Tahoma", "Arial", '宋体';
            color: #666;
        }

        .main-for input.text-but {
            width: 100px;
            height: 40px;
            line-height: 30px;
            border: 1px solid #cdcdcd;
            background: #e6e6e6;
            font-family: "Microsoft YaHei", "Tahoma", "Arial", '宋体';
            color: #969696;
            float: left;
            margin: 0 10px 0 0;
            display: inline;
            cursor: pointer;
            font-size: 14px;
            font-weight: bold;
        }

        #addinfo a {
            font-size: 14px;
            font-weight: bold;
            background: url(images/main/replayblack.jpg) no-repeat 0 0px;
            padding: 0px 0 0px 20px;
            line-height: 45px;
        }

        #addinfo a:hover {
            background: url(images/main/replayblue.jpg) no-repeat 0 0px;
        }
    </style>
</head>
<body>
<!--main_top-->
<table width="99%" border="0" cellspacing="0" cellpadding="0" id="searchmain">
    <tr>
        <td width="99%" align="left" valign="top">您的位置：留言板&nbsp;&nbsp;>&nbsp;&nbsp;留言回复</td>
    </tr>
    <tr>
        <td align="left" valign="top" id="addinfo">
            <a href="<c:url value='/message/list.do'/>" target="mainFrame" onFocus="this.blur()" class="add">返回上一级</a>
        </td>
    </tr>
    <tr>
        <td align="left" valign="top">
            <form method="post" action="${pageContext.request.contextPath}/message/reply.do">
                <table width="100%" border="0" cellspacing="0" cellpadding="0" id="main-tab">
                    <tr onMouseOut="this.style.backgroundColor='#ffffff'"
                        onMouseOver="this.style.backgroundColor='#edf5ff'">
                        <td align="right" valign="middle" class="borderright borderbottom bggray">留言id：</td>
                        <td align="left" valign="middle" class="borderright borderbottom main-for">${message.id}</td>
                    </tr>
                    <tr onMouseOut="this.style.backgroundColor='#ffffff'"
                        onMouseOver="this.style.backgroundColor='#edf5ff'">
                        <td align="right" valign="middle" class="borderright borderbottom bggray">留言用户：</td>
                        <td align="left" valign="middle" class="borderright borderbottom main-for">${message.userName}</td>
                    </tr>
                    <tr onMouseOut="this.style.backgroundColor='#ffffff'"
                        onMouseOver="this.style.backgroundColor='#edf5ff'">
                        <td align="right" valign="middle" class="borderright borderbottom bggray">留言时间：</td>
                        <td align="left" valign="middle" class="borderright borderbottom main-for">${message.createTime}
                        </td>
                    </tr>
                    <tr onMouseOut="this.style.backgroundColor='#ffffff'"
                        onMouseOver="this.style.backgroundColor='#edf5ff'">
                        <td align="right" valign="middle" class="borderright borderbottom bggray">留言标题：</td>
                        <td align="left" valign="middle" class="borderright borderbottom main-for">${message.title}
                        </td>
                    </tr>
                    <tr onMouseOut="this.style.backgroundColor='#ffffff'"
                        onMouseOver="this.style.backgroundColor='#edf5ff'">
                        <td align="right" valign="middle" class="borderright borderbottom bggray">留言内容：</td>
                        <td align="left" valign="middle" class="borderright borderbottom main-for"
                            style="line-height:24px;">${message.message}</td>
                    </tr>
                    <c:forEach items="${replays}" var ="replay">
                    <tr onMouseOut="this.style.backgroundColor='#ffffff'"
                        onMouseOver="this.style.backgroundColor='#edf5ff'">
                        <td align="right" valign="middle" class="borderright borderbottom bggray">回复时间：</td>
                        <td align="left" valign="middle" class="borderright borderbottom main-for">${replay.createTime}&nbsp;&nbsp;<a
                                href="${pageContext.request.contextPath}/message/delete.do?id=${replay.id}&replyId=${message.id}" target="mainFrame" onFocus="this.blur()" class="add">删除</a></td>
                    </tr>
                    <tr onMouseOut="this.style.backgroundColor='#ffffff'"
                        onMouseOver="this.style.backgroundColor='#edf5ff'">
                        <td align="right" valign="middle" class="borderright borderbottom bggray">回复内容：</td>
                        <td align="left" valign="middle" class="borderright borderbottom main-for">${replay.message}</td>
                    </tr>
                    </c:forEach>
                    <tr onMouseOut="this.style.backgroundColor='#ffffff'"
                        onMouseOver="this.style.backgroundColor='#edf5ff'">
                        <td align="right" valign="middle" class="borderright borderbottom bggray">回复名称：</td>
                        <td align="left" valign="middle" class="borderright borderbottom main-for">
                            <input type="text"  name="title"   id="title" value=""   class="text-word">
                        </td>
                    </tr>
                    <input name="replyId" id="replyId" value="${message.id}" style="display: none"/>
                    <tr onMouseOut="this.style.backgroundColor='#ffffff'"
                        onMouseOver="this.style.backgroundColor='#edf5ff'">
                        <td align="right" valign="middle" class="borderright borderbottom bggray">回复内容：</td>
                        <td align="left" valign="middle" class="borderright borderbottom main-for">
                                <textarea name="message" id="message" cols="100" rows="10"></textarea>
                        </td>
                    </tr>
                    <tr onMouseOut="this.style.backgroundColor='#ffffff'"
                        onMouseOver="this.style.backgroundColor='#edf5ff'">
                        <td align="right" valign="middle" class="borderright borderbottom bggray">&nbsp;</td>
                        <td align="left" valign="middle" class="borderright borderbottom main-for">
                            <input name="" type="submit" value="确定" class="text-but" onclick="return submitCheck()">
                            <input name="" type="reset" value="重置" class="text-but"></td>
                    </tr>
                </table>
            </form>
        </td>
    </tr>
</table>
<script type="application/javascript">
    function submitCheck() {
        var messageContent=$("#message").val();
        var replyId=$("#replyId").val();
        var title=$("#title").val();
        if (messageContent==''||messageContent==undefined){
            alert("请输入回复内容");
            return false;
        }
        if (replyId==''||replyId==undefined){
            alert("操作错误");
            return false;
        }
        if (title==''||title==undefined){
            alert("请输入回复标题");
            return false;
        }
        return true;
    }
</script>
</body>
</html>
