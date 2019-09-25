<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>左侧导航menu</title>
    <link href="${pageContext.request.contextPath}/css/css.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/sdmenu.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js" ></script>
    <script src="${pageContext.request.contextPath}/ckeditor/ckeditor.js"></script>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/images/favicon.ico" />
    <link href="${pageContext.request.contextPath}/css/css.css" type="text/css" rel="stylesheet" />
    <style>
        body{overflow-x:hidden; background:#f2f0f5; padding:15px 0px 10px 5px;}
        #searchmain{ font-size:12px;}
        #search{ font-size:12px; background:#548fc9; margin:10px 10px 0 0; display:inline; width:100%; color:#FFF; float:left}
        #search form span{height:40px; line-height:40px; padding:0 0px 0 10px; float:left;}
        #search form input.text-word{height:24px; line-height:24px; width:180px; margin:8px 0 6px 0; padding:0 0px 0 10px; float:left; border:1px solid #FFF;}
        #search form input.text-but{height:24px; line-height:24px; width:55px; background:url(${pageContext.request.contextPath}/images/main/list_input.jpg) no-repeat left top; border:none; cursor:pointer; font-family:"Microsoft YaHei","Tahoma","Arial",'宋体'; color:#666; float:left; margin:8px 0 0 6px; display:inline;}
        #search a.add{ background:url(${pageContext.request.contextPath}/images/main/add.jpg) no-repeat -3px 7px #548fc9; padding:0 10px 0 26px; height:40px; line-height:40px; font-size:14px; font-weight:bold; color:#FFF; float:right}
        #search a:hover.add{ text-decoration:underline; color:#d2e9ff;}
        #main-tab{ border:1px solid #eaeaea; background:#FFF; font-size:12px;}
        #main-tab th{ font-size:12px; background:url(${pageContext.request.contextPath}/images/main/list_bg.jpg) repeat-x; height:32px; line-height:32px;}
        #main-tab td{ font-size:12px; line-height:40px;}
        #main-tab td a{ font-size:12px; color:#548fc9;}
        #main-tab td a:hover{color:#565656; text-decoration:underline;}
        .bordertop{ border-top:1px solid #ebebeb}
        .borderright{ border-right:1px solid #ebebeb}
        .borderbottom{ border-bottom:1px solid #ebebeb}
        .borderleft{ border-left:1px solid #ebebeb}
        .gray{ color:#dbdbdb;}
        tr.list td{
            text-align: center ;

        }
        td.fenye{ padding:10px 0 0 0; text-align:right;}
        .bggray{ background:#f9f9f9}
        #addinfo{ padding:0 0 10px 0;}
        input.text-word{ width:50px; height:24px; line-height:20px; border:#ebebeb 1px solid; background:#FFF; font-family:"Microsoft YaHei","Tahoma","Arial",'宋体'; text-align:center; color:#666}
        .tda{width:100px;}
        .tdb{ padding-left:20px;}
        td#xiugai{ padding:10px 0 0 0;}
        td#xiugai input{ width:100px; height:40px; line-height:30px; border:none; border:1px solid #cdcdcd; background:#e6e6e6; font-family:"Microsoft YaHei","Tahoma","Arial",'宋体'; color:#969696; float:left; margin:0 10px 0 0; display:inline; cursor:pointer; font-size:14px; font-weight:bold;}
    </style>
</head>
<body onselectstart="return false;" ondragstart="return false;" oncontextmenu="return false;">
<!--main_top-->

<table width="99%" border="0" cellspacing="0" cellpadding="0" id="searchmain">
    <tr>
        <td width="99%" align="left" valign="top">您的位置：内容维护</td>
    </tr>
    <tr>
        <td align="left" valign="top">

            <table width="100%" border="0" cellspacing="0" cellpadding="0" id="search">
                <tr>
                    <td width="90%" align="left" valign="middle">
                        <form method="post" action="<c:url value='${pageContext.request.contextPath}/menu/showNews.do'/>">
                            <span>标题：</span>
                            <input type="text" name="searchStr" value="" class="text-word">
                            <input name="" type="submit" value="查询" class="text-but">
                            <input type="hidden" name="type" value="${type}" />
                        </form>
                    </td>
                    <td width="10%" align="center" valign="middle" style="text-align:right; width:150px;"><a href="<c:url value='/menu/editMenu.do?columnId=${type}'/>" target="mainFrame" onFocus="this.blur()" class="add">新增</a></td>
                </tr>
            </table>

        </td>
    </tr>
    <tr>
        <td align="left" valign="top">

            <table width="100%" border="0" cellspacing="0" cellpadding="0" id="main-tab">
                <tr>
                    <th align="center" valign="middle" class="borderright">标题</th>
                    <th align="center" valign="middle" class="borderright tda">发布时间</th>
                    <th align="center" valign="middle">内容管理</th>
                </tr>
                <c:choose>
                    <c:when test="${news != null}">
                        <c:forEach items="${news}" var="oneNews"  varStatus="status">
                            <tr class="list" onMouseOut="this.style.backgroundColor='#ffffff'"
                                onMouseOver="this.style.backgroundColor='#edf5ff'">
                                <td>${oneNews.title}</td>
                                <td>${oneNews.createTime}</td>
                                <td><a href="<c:url value='/menu/deleteNews.do?id=${oneNews.id}&type=${oneNews.type}'/>" onfocus="this.blur()">删除</a><span class="gray">&nbsp;|&nbsp;</span>
                                    <a href="<c:url value='/menu/updateNews.do?id=${oneNews.id}'/>" onfocus="this.blur()">修改</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="3">暂无新闻</td>
                        </tr>
                    </c:otherwise>
                </c:choose>
                <!-- DB search -->
                <!--
                 <tr>
                 <td align="left" valign="top" id="xiugai"><input name="" type="submit" value="提交" class="text-but" /></td>
                 </tr>-->
            </table>


        </td>
    </tr>
</table>
</body>

</html>
