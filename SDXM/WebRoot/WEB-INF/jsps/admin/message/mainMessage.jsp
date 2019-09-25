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

        .search {
            font-size: 12px;
            background: #548fc9;
            margin: 10px 10px 0 0;
            display: inline;
            width: 100%;
            color: #FFF
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
            background: url(${pageContext.request.contextPath}/images/main/list_bg.jpg) repeat-x;
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
            background: #f9f9f9
        }

        #addinfo {
            padding: 0 0 10px 0;
        }
    </style>
</head>
<body onselectstart="return false;" ondragstart="return false;" oncontextmenu="return false;">
<!--main_top-->
<table width="99%" border="0" cellspacing="0" cellpadding="0" id="searchmain">
    <tr>
        <td width="99%" align="left" valign="top" id="addinfo">您的位置：留言板</td>
    </tr>
    <tr>
        <td align="left" valign="top" id="search" class="search" >
        </td>
    </tr>
    <tr>
        <td align="left" valign="top">

            <table width="100%" border="0" cellspacing="0" cellpadding="0" id="main-tab">
                <tr>
                    <th align="center" valign="middle" class="borderright">编号</th>
                    <th align="center" valign="middle" class="borderright">标题</th>
                    <th align="center" valign="middle" class="borderright">用户名</th>
                    <th align="center" valign="middle" class="borderright">留言时间</th>
                    <th align="center" valign="middle _all">操作</th>
                </tr>
                <c:forEach items="${messages.results}" var="message">
                    <tr onMouseOut="this.style.backgroundColor='#ffffff'"
                        onMouseOver="this.style.backgroundColor='#edf5ff'">
                        <td align="center" valign="middle" class="borderright borderbottom">${message.id}</td>
                        <td align="center" valign="middle" class="borderright borderbottom"><a
                                href="<c:url value='/message/messageInfo.do?id=${message.id}'/>" target="mainFrame"
                                onFocus="this.blur()">${message.title}</a>
                        </td>
                        <td align="center" valign="middle" class="borderright borderbottom">${message.userName}</td>
                        <td align="center" valign="middle" class="borderright borderbottom">${message.createTime}</td>
                        <td align="center" valign="middle" class="borderbottom">
                            <a href="<c:url value='/message/messageReplay.do?id=${message.id}'/>" target="mainFrame"
                                onFocus="this.blur()" class="add _edit">回复</a>
                            <span class="gray">&nbsp;<span class="_divide_1">|</span>&nbsp;</span>
                            <a href="${pageContext.request.contextPath}/message/changeShow.do?id=${message.id}"  target="mainFrame" onFocus="this.blur()"
                               class="add _release">
                                <c:if test="${message.show}">
                                    显示
                                </c:if>
                                <c:if test="${!message.show}">
                                    不显示
                                </c:if>
                            </a>
                            <span class="gray">&nbsp;<span class="_divide_2">|</span>&nbsp;</span>
                          <a href="${pageContext.request.contextPath}/message/delete.do?id=${message.id}"  target="mainFrame" onFocus="this.blur()"
                             class="add _delete">删除</a>
                            <span class="gray">&nbsp;<span class="_divide_3">|</span>&nbsp;</span>
                            <a href="<c:url value='/message/messageInfo.do?id=${message.id}'/>"  target="mainFrame" onFocus="this.blur()"
                               class="add __search">查看</a></td>
                    </tr>
                </c:forEach>
            </table>
        </td>
    </tr>
    <tr>
        <td align="left" valign="top" class="fenye">${messages.totalCount}
            条数据 ${messages.currentPage}/${messages.pageCount} 页&nbsp;&nbsp;
            <c:forEach items="${messages.pages}" var="page">
                <a href='<c:url value="/message/list.do"/>?page=${page.second}' target="mainFrame"
                   onFocus="this.blur()">${page.first}</a>&nbsp;&nbsp;
            </c:forEach>
        </td>
    </tr>
</table>
</body>
<script type="text/javascript">
    $(function () {
        var array = "${sessionScope.authority}";
        if(!isContains(array,"1")&&!isContains(array,"7")){
            $('._search').hide();
        }
        if(!isContains(array,"5")){
            $('._release').hide();
        }
        if(!isContains(array,"6")&&!isContains(array,"7")){
            $('._delete').hide();
        }
        if(!isContains(array,"3")&&!isContains(array,"7")){
            $('._edit').hide();
        }
        if(!((isContains(array,"3")||isContains(array,"7"))&&isContains(array,"5"))){
            $('._divide_1').hide();
        }
        if(!((isContains(array,"6")||isContains(array,"7"))&&isContains(array,"5"))){
            $('._divide_2').hide();
        }
        if(!((isContains(array,"6")&&isContains(array,"1"))||isContains(array,"7"))){
            $('._divide_3').hide();
        }
        if(!isContains(array,"3")&&!isContains(array,"7")&&!isContains(array,"6")
            &&!isContains(array,"1")&&!isContains(array,"5")){
            $('._all').hide();
        }
    })
    function isContains(str, substr) {
        return str.indexOf(substr) >= 0;
    }
</script>
</html>
