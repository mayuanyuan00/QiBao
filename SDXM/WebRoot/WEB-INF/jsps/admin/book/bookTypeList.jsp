<%--suppress ALL --%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>左侧导航menu</title>
    <link href="${pageContext.request.contextPath}/css/css.css" type="text/css" rel="stylesheet"/>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/sdmenu.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.js"></script>
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

        #addinfo {
            padding: 0 0 10px 0;
        }

        input.text-word {
            width: 50px;
            height: 24px;
            line-height: 20px;
            border: #ebebeb 1px solid;
            background: #FFF;
            font-family: "Microsoft YaHei", "Tahoma", "Arial", '宋体';
            text-align: center;
            color: #666
        }

        .tda {
            width: 40%;
        }

        .tdb {
            padding-left: 20px;
        }

        td#xiugai {
            padding: 10px 0 0 0;
        }

        td#xiugai input {
            width: 100px;
            height: 40px;
            line-height: 30px;
            border: none;
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
    </style>
    <script type="application/javascript">
        var start = setTimeout(myfun, 1000);
        function myfun() {
            var result = document.getElementById("deleteResult").value;
            if (result == 'failed') {
                alert("删除失败,该分类下有下级分类或者该分类下游图书！");
            } else if (result != '') {
                if (result != undefined) {
                    alert(result);
                }
            }
        }
        ;
        window.onload = start;


        function search() {
            var reslut = document.getElementById("searchName").value;
            if (reslut.trim() == '') {
                window.location.href = "${pageContext.request.contextPath}/book/bookType/list.do";
            } else {
                window.location.href = "${pageContext.request.contextPath}/book/bookType/search.do?name=" + encodeURI(encodeURI(reslut.trim()));
            }
        }
    </script>

</head>
<body onselectstart="return false;" ondragstart="return false;" oncontextmenu="return false;">
<!--main_top-->

<input id="deleteResult" style="display: none;" value="<c:if test="${not empty msg}">${msg}</c:if>"/>
<table width="99%" border="0" cellspacing="0" cellpadding="0" id="searchmain">
    <tr>
        <td width="99%" align="left" valign="top">您的位置：<a href="${pageContext.request.contextPath}/book/bookType/list.do"> 图书分类管理</a></td>
    </tr>
    <tr>
        <td align="left" valign="top">
            <table width="100%" border="0" cellspacing="0" cellpadding="0" id="search">
                <tr>
                    <td width="90%" align="left" valign="middle">
                        <form method="post" action="">
                            <span>图书分类名称：</span>
                            <input id="searchName" type="text" name="searchName" value=" " class="text-word">
                            <input name="" type="button" value="查询" class="text-but" onclick="search()">
                        </form>
                    </td>
                    <td width="10%" align="center" valign="middle" style="text-align:right; width:150px;"><a
                            href="<c:url value='/book/bookType/save.do'/>" target="mainFrame"
                            onFocus="this.blur()"
                            class="add _add">新增图书分类</a></td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td align="left" valign="top">
            <table width="100%" border="0" cellspacing="0" cellpadding="0" id="main-tab">
                <tr>
                    <th align="center" valign="middle" class="borderright tda">分类名称</th>
                    <th align="center" valign="middle" class="borderright tda">分类备注</th>
                    <th align="center" valign="middle edit_delete">分类管理</th>
                </tr>
                <%--<c:forEach items="${list}" var="t">--%>
                <%--<tr class="bggray" >--%>
                <%--&lt;%&ndash;onclick="getSub(${t.id},this)"&ndash;%&gt;--%>
                <%--<td align="left" valign="middle" class="borderright borderbottom">${t.typeName}</td>--%>
                <%--<td align="left" valign="middle" class="borderright borderbottom tdb">${t.remarks}</td>--%>
                <%--<td align="center" valign="middle" class="borderbottom">--%>
                <%--<a href="<c:url value='/book/bookType/update.do?id=${t.id}'/>" target="mainFrame"--%>
                <%--onFocus="this.blur()" class="add">修改</a>--%>
                <%--<span class="gray">&nbsp;|&nbsp;</span>--%>
                <%--<a href="<c:url value='/book/bookType/delete.do?id=${t.id}'/>" target="mainFrame"--%>
                <%--onFocus="this.blur()"--%>
                <%--class="add">删除</a>--%>
                <%--</td>--%>
                <%--</tr>--%>
                <%--</c:forEach>--%>
                <c:forEach items="${list}" var="t">
                    <tr class="bggray" id="${t.value.id}" name="${t.value.parentid}">
                        <%--<c:if test="${t.value.parentid!=0}">style="display: none" </c:if>--%>
                        <td align="left" valign="middle" class="borderright borderbottom">
                            <c:if test="${empty typeMsg or typeMsg != 'search'}">
                                <span id="${t.value.parentid.toString()}and${t.value.id.toString()}key" value="true">
                                <c:forEach var="x" begin="0" end="${t.key}">
                                    &nbsp;&nbsp;&nbsp;&nbsp;
                                </c:forEach>
                            </span>
                            <img onclick="gogo('${t.value.parentid.toString()}and${t.value.id.toString()}')"
                                 style="width: 2em;height: 2em;vertical-align:middle;"
                                 id="${t.value.parentid.toString()}and${t.value.id.toString()}first"
                                 src="${pageContext.request.contextPath}/images/main/openFolder.svg"/>
                            <img onclick="gogo('${t.value.parentid.toString()}and${t.value.id.toString()}')"
                                 style="width: 2em;height: 2em;vertical-align:middle;;display: none"
                                 id="${t.value.parentid.toString()}and${t.value.id.toString()}second"
                                 src="${pageContext.request.contextPath}/images/main/closeFolder.svg"/>
                            <img onclick="gogo('${t.value.parentid.toString()}and${t.value.id.toString()}')"
                                 style=" display: none;width: 2em;height: 2em;vertical-align:middle;"
                                 id="${t.value.parentid.toString()}and${t.value.id.toString()}third"
                                 src="${pageContext.request.contextPath}/images/main/file.svg"/>
                            </c:if>
                        ${t.value.typeName}</td>
                        <td align="left" valign="middle" class="borderright borderbottom tdb">${t.value.remarks}</td>
                        <td align="center" valign="middle" class="borderbottom edit_delete">
                            <a href="<c:url value='/book/bookType/update.do?id=${t.value.id}'/>" target="mainFrame"
                               onFocus="this.blur()" class="add _edit">修改</a>
                            <span class="gray">&nbsp;<span class="_divide">|</span>&nbsp;</span>
                            <a target="mainFrame" onFocus="this.blur()" onclick="return deleteBookType(${t.value.id})"
                               class="add _delete">删除</a>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </td>
    </tr>
</table>

<c:if test="${not empty list}">
    <script type="text/javascript">
        $(document).ready(function () {
            var array = "${sessionScope.authority}";
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
            <c:forEach items="${list}" var="temp">
            if (checkChild("${temp.value.parentid.toString()}and${temp.value.id.toString()}")){
            $("#${temp.value.parentid.toString()}and${temp.value.id.toString()}first")[0].style.display="none";
            $("#${temp.value.parentid.toString()}and${temp.value.id.toString()}third")[0].style.display="";
            }
            </c:forEach>
            function isContains(str, substr) {
                return str.indexOf(substr) >= 0;
            }
        })
    </script>
</c:if>

<script type="application/javascript">
    function deleteBookType(id) {
        if (this.confirm("确定要删除的图书分类吗?")) {
            this.location.href = "<c:url value="/book/bookType/delete.do"/>?id=" + id;
        }
    }
    function showSub(trId) {
        var key1=trId+"key";
        $("#"+key1).val("true");
        var img1=trId+"first";
        var img2=trId+"second";
        var img3=trId+"third";
        if (checkChild(trId)){
            $("#" + img1)[0].style.display = "none";
            $("#" + img2)[0].style.display = "none";
            $("#" + img3)[0].style.display = "";
        }else {
            $("#" + img1)[0].style.display = "";
            $("#" + img2)[0].style.display = "none";
            $("#" + img3)[0].style.display = "none";
        }
        var i = trId.indexOf("and");
        var parentId=trId.substring(0,i);
        var id=trId.substring(i+3);
        var list=document.getElementsByName(id);
        for(var n=0;n<list.length;n++){
            var temp=list[n];
            temp.style.display="";
            var strId=id.toString()+"and"+temp.id.toString();
            if (checkChild(strId)){
                $("#" + strId+"first")[0].style.display = "none";
                $("#" + strId+"second")[0].style.display = "none";
                $("#" + strId+"third")[0].style.display = "";
            }else {
                $("#" + strId+"first")[0].style.display = "none";
                $("#" + strId+"second")[0].style.display = "";
                $("#" + strId+"third")[0].style.display = "none";
            }
        }
    }

    function hideSub(trId) {
        var key=trId+"key";
        $("#"+key).val("false");
        var img1=trId+"first";
        var img2=trId+"second";
        var img3=trId+"third";
        if (checkChild(trId)){
            $("#" + img1)[0].style.display = "none";
            $("#" + img2)[0].style.display = "none";
            $("#" + img3)[0].style.display = "";
        }else {
            $("#"+img1)[0].style.display="none";
            $("#"+img2)[0].style.display="";
            $("#" + img3)[0].style.display = "none";
        }
        var i = trId.indexOf("and");
        var id=trId.substring(i+3);
        var list=document.getElementsByName(id);
        for(var n=0;n<list.length;n++){
            var temp=list[n];
            var t=temp.id;
            var sub=id.toString()+"and"+t.toString();
            temp.style.display="none";
            if (checkChild(sub)){
                $("#" + sub+"first")[0].style.display = "none";
                $("#" + sub+"second")[0].style.display = "none";
                $("#" + sub+"third")[0].style.display = "";
            }else {
                $("#" + sub+"first")[0].style.display = "none";
                $("#" + sub+"second")[0].style.display = "";
                $("#" + sub+"third")[0].style.display = "none";
            }
            hideSub(sub);
        }
//        list.forEach(function (temp,index,array) {
//            var i=temp.id;
//            var sub=id.toString()+"and"+i.toString();
//            temp.style.display="none";
//            hideSub(sub);
//        })
    }
    function checkChild(trId) {
        var i = trId.indexOf("and");
        var id=trId.substring(i+3);
        var list=document.getElementsByName(id);
        if (list.length==0){
            return true;
        }else {
            return false;
        }
    }

    function gogo(trId) {
        var key=trId+"key";
        var flag= $("#"+key).val();
        if (flag=="false"){
            showSub(trId);
        }else {
            hideSub(trId);
        }
    }

</script>
</body>

</html>
