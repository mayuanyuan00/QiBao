<!DOCTYPE html>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <link rel="icon"
          href="${pageContext.request.contextPath}/favicon.ico" type="image/x-icon" />
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/favicon.ico" type="image/x-icon" />
    <title>用户管理</title>
    <link href="${pageContext.request.contextPath}/css/css.css" type="text/css" rel="stylesheet"/>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/sdmenu.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-ui.min.js"></script>
    <script src="${pageContext.request.contextPath}/ckeditor/ckeditor.js"></script>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/images/favicon.ico"/>
    <link href="${pageContext.request.contextPath}/css/jquery-ui.min.css" type="text/css" rel="stylesheet"/>
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
        <td width="99%" align="left" valign="top">您的位置：订单管理</td>
    </tr>
    <tr>
        <td align="left" valign="top">
            <table width="100%" border="0" cellspacing="0" cellpadding="0" id="search">
                <tr>
                    <td width="90%" align="left" valign="middle _search">
                       <form method="post" action="${pageContext.request.contextPath}/order/selectOrder.do">
                                <span>日期：</span>
                                <input type="text" name="date1"  id="publicationDate"  class="text-word" required>
                                <input name="test" type="submit" value="查询" class="text-but">
                       </form>
                    </td>
                    <td width="10%" align="center" valign="middle" style="text-align:right; width:150px;" class="_search"><a
                            href='<c:url value="/order/downloadOrder.do"/>?page=${pages.currentPage}&<c:if test="${not empty date}">date1=${date}</c:if>' target="mainFrame"
                            onFocus="this.blur()" class="add">导出Excel表</a></td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td align="left" valign="top">

            <table width="100%" border="0" cellspacing="0" cellpadding="0" id="main-tab">
                <tr>
                    <th align="center" valign="middle" class="borderright">订单号</th>
                    <th align="center" valign="middle" class="borderright">书名</th>
                    <th align="center" valign="middle" class="borderright">订单日期</th>
                    <th align="center" valign="middle" class="borderright">订单状态</th>
                    <th align="center" valign="middle" class="borderright">数量</th>
                    <th align="center" valign="middle" class="borderright">单价</th>
                    <th align="center" valign="middle" class="borderright">金额</th>
                    <th align="center" valign="middle" class="borderright edit_delete">操作</th>
                </tr>

                <c:forEach var="items" items="${list}">
                    <tr onMouseOut="this.style.backgroundColor='#ffffff'"
                        onMouseOver="this.style.backgroundColor='#edf5ff'">
                        <td align="center" valign="middle" class="borderright borderbottom">${items.orderno}</td>
                        <td align="center" valign="middle" class="borderright borderbottom">${items.name}</td>
                        <td align="center" valign="middle" class="borderright borderbottom">${items.date}</td>
                        <c:if test="${items.status==1}">
                        <td align="center" valign="middle" class="borderright borderbottom">提交未支付</td>
                        </c:if>
                        <c:if test="${items.status==2}">
                            <td align="center" valign="middle" class="borderright borderbottom">支付未确认</td>
                        </c:if>
                        <c:if test="${items.status==3}">
                            <td align="center" valign="middle" class="borderright borderbottom">支付已确认</td>
                        </c:if>
                        <c:if test="${items.status==4}">
                            <td align="center" valign="middle" class="borderright borderbottom">确认未发货</td>
                        </c:if>
                        <c:if test="${items.status==5}">
                            <td align="center" valign="middle" class="borderright borderbottom">发货未收货</td>
                        </c:if>
                        <c:if test="${items.status==6}">
                            <td align="center" valign="middle" class="borderright borderbottom">收货未评价</td>
                        </c:if>
                        <c:if test="${items.status==7}">
                            <td align="center" valign="middle" class="borderright borderbottom">完成</td>
                        </c:if>
                        <c:if test="${items.status==8}">
                            <td align="center" valign="middle" class="borderright borderbottom">已取消</td>
                        </c:if>
                        <td align="center" valign="middle" class="borderright borderbottom">${items.amount}</td>
                        <td align="center" valign="middle" class="borderright borderbottom">${items.price}</td>
                        <td align="center" valign="middle" class="borderright borderbottom">${items.num}</td>
                        <td align="center" valign="middle" class="borderbottom edit_delete">
                            <a href="<c:url value='/order/orderInfo.do?id=${items.id}'/>" target="mainFrame"
                                    onFocus="this.blur()" class="add _edit">编辑</a><span class="gray">&nbsp;<span class="_divide">|</span>&nbsp;</span>
                            <a target="mainFrame" class="add _delete" href="javascript:if(confirm('确实要删除吗?'))
                            location='${pageContext.request.contextPath}/order/deleteOrder.do?id=${items.id}&page=${pages.currentPage}&<c:if test="${not empty date}">date1=${date}</c:if>'">删除</a></td>
                    </tr>
                </c:forEach>

            </table>
        </td>
    </tr>
    <tr>
        <td align="left" valign="top" class="paginate">${pages.totalCount} 条数据 ${pages.currentPage}/${pages.pageCount} 页&nbsp;&nbsp;
            <c:forEach items="${pages.pages}" var="page">
                <a href='<c:url value="/order/selectOrder.do"/>?page=${page.second}&<c:if test="${not empty date}">date1=${date}</c:if>' target="mainFrame"
                   onFocus="this.blur()">${page.first}</a>&nbsp;&nbsp;
            </c:forEach>
        </td>
    </tr>
</table>
</body>
<script type="text/javascript">
    $(function () {
        $("#publicationDate").datepicker({
            maxDate: new Date(),
            dateFormat: "yy-mm",
            changeYear: true
        })
        var array = "${sessionScope.authority}";
        if(!isContains(array,"1")&&!isContains(array,"7")){
            $('._search').hide();
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
    function isContains(str, substr) {
        return str.indexOf(substr) >= 0;
    }
</script>
</html>
