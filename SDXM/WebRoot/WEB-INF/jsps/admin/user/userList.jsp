<%@ page language="java" import="java.util.*" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>用户管理</title>
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
            color: #FFF;
            float: left
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
            background: url(${pageContext.request.contextPath}/images/main/list_input.jpg) no-repeat left top;
            border: none;
            cursor: pointer;
            font-family: "Microsoft YaHei", "Tahoma", "Arial", '宋体';
            color: #666;
            float: left;
            margin: 8px 0 0 6px;
            display: inline;
        }

        #search a.add {
            background: url(${pageContext.request.contextPath}/images/main/add.jpg) no-repeat -3px 7px #548fc9;
            padding: 0 10px 0 26px;
            height: 40px;
            line-height: 40px;
            font-size: 14px;
            font-weight: bold;
            color: #FFF;
            float: right
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

        td.paginate {
            padding: 10px 0 0 0;
            text-align: right;
        }

        .bggray {
            background: #f9f9f9
        }
    </style>
</head>
<body onselectstart="return false;" ondragstart="return false;" oncontextmenu="return false;">
<!--main_top-->
<table width="99%" border="0" cellspacing="0" cellpadding="0" id="searchmain">
    <tr>
        <td width="99%" align="left" valign="top">您的位置：<c:if test="${not empty msg and msg == 'user'}">前台</c:if>用户管理</td>
    </tr>
    <tr>
        <td align="left" valign="top">
            <table width="100%" border="0" cellspacing="0" cellpadding="0" id="search">
                <tr>
                    <td width="90%" align="left" valign="middle" class="_search">
                       <form method="post" action="${pageContext.request.contextPath}/adminUser/userSearch.do<c:if test="${not empty msg and msg == 'user'}">?group=3</c:if>">
                                <span>管理员：</span>
                                <input type="text" name="name" value="" class="text-word">
                                <input name="test" type="submit" value="查询" class="text-but">
                       </form>
                    </td>
                    <c:if test="${empty msg or msg != 'user'}">
                        <td width="10%" align="center" valign="middle" style="text-align:right; width:150px;" class="_add"><a
                                href="<c:url value='/adminUser/userInfo.do?op=0'/>" target="mainFrame"
                                onFocus="this.blur()" class="add">新增管理员</a></td>
                    </c:if>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td align="left" valign="top">

            <table width="100%" border="0" cellspacing="0" cellpadding="0" id="main-tab">
                <tr>
                    <th align="center" valign="middle" class="borderright">编号</th>
                    <th align="center" valign="middle" class="borderright">管理帐号</th>
                    <c:if test="${empty msg or msg != 'user'}">
                    <th align="center" valign="middle" class="borderright">用户权限</th>
                    </c:if>
                    <th align="center" valign="middle" class="borderright">更新时间</th>
                    <th align="center" valign="middle" class="edit_delete">操作</th>
                </tr>

                <c:forEach var="items" items="${user.results}">
                    <tr onMouseOut="this.style.backgroundColor='#ffffff'"
                        onMouseOver="this.style.backgroundColor='#edf5ff'">
                        <td align="center" valign="middle" class="borderright borderbottom">${items.id}</td>
                        <td align="center" valign="middle" class="borderright borderbottom">${items.userName}</td>
                        <c:if test="${empty msg or msg != 'user'}">
                        <td align="center" valign="middle" class="borderright borderbottom">
                            <c:choose>
                                <c:when test="${items.groupCode eq 0}">超级管理员</c:when>
                                <c:when test="${items.groupCode eq 1}">图书管理员</c:when>
                                <c:when test="${items.groupCode eq 2}">信息管理员</c:when>
                            </c:choose></td>
                        </c:if>
                        <td align="center" valign="middle" class="borderright borderbottom">${items.createDate}</td>
                        <td align="center" valign="middle" class="borderbottom edit_delete"><a
                                href="<c:url value='/adminUser/userInfo.do?op=1&id=${items.id}'/>" target="mainFrame"
                                onFocus="this.blur()" class="add _edit">编辑</a><span class="gray">&nbsp;<span class="_divide">|</span>&nbsp;</span>
                            <a href="javascript:void(0)" target="mainFrame"
                               onclick="return deleteUser(${items.id},'${items.userName}')" class="add _delete">删除</a></td>
                    </tr>
                </c:forEach>

            </table>
        </td>
    </tr>
    <tr>
        <td align="left" valign="top" class="paginate">${user.totalCount} 条数据 ${user.currentPage}/${user.pageCount} 页&nbsp;&nbsp;
            <c:forEach items="${user.pages}" var="page">
                <a href='<c:url value="/adminUser/userList.do"/>?<c:if test="${msg eq 'user'}">group=3&</c:if>page=${page.second}' target="mainFrame"
                   onFocus="this.blur()">${page.first}</a>&nbsp;&nbsp;
            </c:forEach>
        </td>
    </tr>
</table>
<script type="text/javascript">
    $(function () {
       var array = "${sessionScope.authority}";
//        var array = "1";
       if(!isContains(array,"1")&&!isContains(array,"7")){
            $('._search').hide();
       }
       if(!isContains(array,"2")&&!isContains(array,"7")){
            $('._add').hide();
        }
        if(!isContains(array,"6")&&!isContains(array,"7")){
            $('._delete').hide();
        }
        if(!isContains(array,"3")&&!isContains(array,"7")){
            $('._edit').hide();
        }
        if(!((isContains(array,"6")&&isContains(array,"3"))||isContains(array,"7"))){
            $('._divide').hide();
        }
        if(!isContains(array,"3")&&!isContains(array,"7")&&!isContains(array,"6")){
            $('.edit_delete').hide();
        }
    })
    function deleteUser(id, name) {
        var uname = name.toString();
        if (this.confirm("确定要删除" + uname + "吗?")) {
            this.location.href = "<c:url value="/adminUser/userDelete.do"/>?uid=" + id;
        }
    }

    function isContains(str, substr) {
        return str.indexOf(substr) >= 0;
    }
</script>
</body>

</html>
