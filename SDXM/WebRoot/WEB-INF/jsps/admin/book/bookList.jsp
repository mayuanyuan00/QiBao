<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    response.setHeader("Pragma","No-cache");
    response.setHeader("Cache-Control","No-cache");
    response.setDateHeader("Expires", -1);
    response.setHeader("Cache-Control", "No-store");
%>

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

        td.fenye {
            padding: 10px 0 0 0;
            text-align: right;
        }

        .bggray {
            background: #f9f9f9
        }
    </style>
</head>
<body onselectstart="return false;" ondragstart="return false;" oncontextmenu="return false;">
<input type="hidden" id="refreshed" value="no">
<script type="text/javascript">
    $(function(){
        debugger;
        var e=$("#refreshed");
        if(e.val()=="no") {
            e.val('yes');
        }else{
            e.val('no');
            location.reload();
        }
    });
</script>
<!--main_top-->
<table width="99%" border="0" cellspacing="0" cellpadding="0" id="searchmain">
    <tr>
        <td width="99%" align="left" valign="top">您的位置：图书管理</td>
    </tr>
    <tr>
        <td align="left" valign="top">
            <table width="100%" border="0" cellspacing="0" cellpadding="0" id="search">
                <tr>
                    <td width="80%" align="left" valign="middle" class="_search">
                        <form method="get" action=""
                              enctype="application/x-www-form-urlencoded">
                            <span>书名：</span>
                            <input type="text" name="key" id="searchKey" value="" class="text-word">
                            <input name="" type="button" value="查询" class="text-but" onclick="doSearch()">
                        </form>
                    </td>
                    <td width="20%" align="center" valign="middle" style="text-align:right; width:150px;" ><a
                            href="<c:url value='/book/bookInfo.do'/>" target="mainFrame" onFocus="this.blur()"
                            class="add _add">新增图书</a></td>
                    <td width="20%" align="center" valign="middle" style="text-align:right; width:150px;" ><a
                            href="<c:url value='/book/bookType/list.do'/>" target="mainFrame" onFocus="this.blur()"
                            class="add _search">图书分类</a></td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td align="left" valign="top">

            <table width="100%" border="0" cellspacing="0" cellpadding="0" id="main-tab">
                <tr>
                    <th align="center" valign="middle" class="borderright">编号</th>
                    <th align="center" valign="middle" class="borderright">图书名称</th>
                    <th align="center" valign="middle" class="borderright">图书类别</th>
                    <th align="center" valign="middle" class="borderright">作者</th>
                    <th align="center" valign="middle" class="borderright">出版日期</th>
                    <th align="center" valign="middle" class="borderright _check">状态</th>
                    <th align="center" valign="middle" class="_all">操作</th>
                </tr>
                <c:forEach items="${books.results}" var="book">
                    <tr onMouseOut="this.style.backgroundColor='#ffffff'"
                        onMouseOver="this.style.backgroundColor='#edf5ff'">
                        <td align="center" valign="middle" class="borderright borderbottom">${book.id}</td>
                        <td align="center" valign="middle" class="borderright borderbottom">${book.bookName}</td>
                        <td align="center" valign="middle" class="borderright borderbottom">${book.bookType}</td>
                        <td align="center" valign="middle" class="borderright borderbottom">${book.author}</td>
                        <td align="center" valign="middle"
                            class="borderright borderbottom">${book.publicationDate}
                        </td>
                        <td align="center" valign="middle" class="borderright borderbottom _check">

                            <a href="<c:url value='/book/bookInfo.do?bookid=${book.id}&opType=0'/>" target="mainFrame"
                               onFocus="this.blur()" class="add">
                                <c:choose>
                                    <c:when test="${book.auditing eq 0}">待审核</c:when>
                                    <c:when test="${book.auditing eq 1}">已审核</c:when>
                                    <c:when test="${book.auditing eq 2}">审核未通过</c:when>
                                    <c:when test="${book.auditing eq 3}">已发布</c:when>
                                </c:choose>
                            </a>
                        </td>
                        <td align="center" valign="middle" class="borderbottom _all">
                            <c:if test="${book.auditing eq 1}">
                                <a href="<c:url value='/book/bookRelease.do?bookid=${book.id}'/>" target="mainFrame"
                                   onFocus="this.blur()" class="add _release">发布</a>
                                <span class="gray">&nbsp;<span class="_divide_1">|</span>&nbsp;</span>
                            </c:if>
                            <a href="<c:url value='/book/bookInfo.do?bookid=${book.id}&opType=1'/>" target="mainFrame"
                               onFocus="this.blur()" class="add _edit">编辑</a>
                            <span class="gray">&nbsp;<span class="_divide_2">|</span>&nbsp;</span>
                            <a href="javascript:void(0)" target="mainFrame" onclick="return deleteBook(${book.id})"
                               class="add _delete">删除</a>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </td>
    </tr>
    <tr>
        <td align="left" valign="top" class="fenye">${books.totalCount} 条数据 ${books.currentPage}/${books.pageCount} 页&nbsp;&nbsp;
            <c:forEach items="${books.pages}" var="page">
                <a href='<c:url value="/book/list.do"/>?${qs}page=${page.second}' target="mainFrame"
                   onFocus="this.blur()">${page.first}</a>&nbsp;&nbsp;
            </c:forEach>
            <input id="_pagenum" size="3">
            <input type="button" onclick="jumpPage()" value="跳"/>
        </td>
    </tr>
</table>
<script type="text/javascript">
    function jumpPage() {
        location.href='<c:url value="/book/list.do"/>?${qs}page='+$("#_pagenum").val();
    }
    function isContains(str, substr) {
        return str.indexOf(substr) >= 0;
    }
    function deleteBook(bookid) {
        if (this.confirm("确定要删除ID为" + bookid + "的图书吗?")) {
            this.location.href = "<c:url value="/book/del.do"/>?bookid=" + bookid;
        }
    }

    function doSearch() {
        var key = $("#searchKey").val().trim();
        this.location.href = '<c:url value="/book/list.do"/>?key=' + encodeURI(key).replace(/%/g,".");
    }

    $(document).ready(function () {
        $("#searchKey").val("${searchKey}")
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
        if(!isContains(array,"5")){
            $('._release').hide();
        }
        if(!((isContains(array,"6")||isContains(array,"7"))&&isContains(array,"3"))){
            $('._divide_1').hide();
        }
        if(!((isContains(array,"6")&&isContains(array,"3"))||isContains(array,"7"))){
            $('._divide_2').hide();
        }
        if(!isContains(array,"3")&&!isContains(array,"7")&&!isContains(array,"6")&&!isContains(array,"5")){
            $('._all').hide();
        }
        if(!isContains(array,"4")){
            $('._check').hide();
        }

    })
</script>
</body>

</html>
