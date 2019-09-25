<%@ page language="java" import="java.util.*" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<html>
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
            background: url(images/main/addinfoblack.jpg) no-repeat 0 1px;
            padding: 0px 0 0px 20px;
            line-height: 45px;
        }

        #addinfo a:hover {
            background: url(images/main/addinfoblue.jpg) no-repeat 0 1px;
        }

        .meun {
            margin-left: 15px;
            margin-right: 5px;
        }

        input[type=checkbox] {
            width: 16px;
            height: 16px;
        }
        input[name=groupcode] {
            margin: 0 5px;
        }
    </style>
</head>
<body onselectstart="return false;" ondragstart="return false;" oncontextmenu="return false;">
        <table width="99%" border="0" cellspacing="0" cellpadding="0" id="searchmain">
            <tr>
                <td width="99%" align="left" valign="top">您的位置：栏目管理&nbsp;&nbsp;>&nbsp;&nbsp;添加栏目</td>
            </tr>
            <tr>
                <td align="left" valign="top">
                    <form method="post" action="<c:url value='/adminUser/addColumn.do'/>"
                          onsubmit="return submitColumn();">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0" id="main-tab">
                            <tr onMouseOut="this.style.backgroundColor='#ffffff'"
                                onMouseOver="this.style.backgroundColor='#edf5ff'">
                                <td align="right" valign="middle" class="borderright borderbottom bggray">栏目名称：</td>
                                <td align="left" valign="middle" class="borderright borderbottom main-for">
                                    <input type="text" name="name" value="" id="name" class="text-word"
                                           required="required" maxlength="10" onblur="checkName()"><span
                                        id="nameMsg" style="color: red"></span>
                                </td>
                            </tr>
                            <tr onMouseOut="this.style.backgroundColor='#ffffff'"
                                onMouseOver="this.style.backgroundColor='#edf5ff'">
                                <td align="right" valign="middle" class="borderright borderbottom bggray">栏目URL：</td>
                                <td align="left" valign="middle" class="borderright borderbottom main-for">
                                    <input type="text" name="url" id="url" value="" class="text-word"
                                           maxlength="50" required="required" onblur="checkUrl()">
                                </td>
                            </tr>
                            <tr onMouseOut="this.style.backgroundColor='#ffffff'"
                                onMouseOver="this.style.backgroundColor='#edf5ff'">
                                <td align="right" valign="middle" class="borderright borderbottom bggray">栏目操作：</td>
                                <td align="left" valign="middle" class="borderright borderbottom main-for">
                                    <input type="checkbox" value="1" name="groupcode">查看
                                    <input type="checkbox" value="2" name="groupcode">新建
                                    <input type="checkbox" value="3" name="groupcode">编辑
                                    <input type="checkbox" value="4" name="groupcode">审批
                                    <input type="checkbox" value="5" name="groupcode">发布
                                    <input type="checkbox" value="6" name="groupcode">删除
                                    <input type="checkbox" value="7" name="groupcode">操作
                                </td>
                            </tr>
                            <tr onMouseOut="this.style.backgroundColor='#ffffff'"
                                onMouseOver="this.style.backgroundColor='#edf5ff'">
                                <td align="right" valign="middle" class="borderright borderbottom bggray">&nbsp;</td>
                                <td align="left" valign="middle" class="borderright borderbottom main-for">
                                    <input name="submit" type="submit" id="submitButton" value="提交" class="text-but">
                                    <input name="" type="reset" value="重置" class="text-but"></td>
                            </tr>
                        </table>
                    </form>
                </td>
            </tr>
        </table>
<script type="text/javascript">
    function checkName() {
        $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/adminUser/ColumnCheck.do",
            data: "name=" + $("#name").val(),
            dataType: "text",
            success: function (data) {
                if (data == "success") {
                    $("#nameMsg").html("");
                    $("input[name='submit']").removeAttr('disabled');
                } else {
                    $("#nameMsg").html("该用户名已被占用");
                    $("input[name='submit']").attr("disabled", 'disabled');
                }
            },
            error: function (data) {
                alert("请联系网站管理员");
            }
        });
    }


    function checkUrl() {
        $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/adminUser/ColumnCheck.do",
            data: "url=" + $("#url").val(),
            dataType: "text",
            success: function (data) {
                if (data == "success") {
                    $("#nameMsg").html("");
                    $("input[name='submit']").removeAttr('disabled');
                } else {
                    $("#nameMsg").html("该url已被占用");
                    $("input[name='submit']").attr("disabled", 'disabled');
                }
            },
            error: function (data) {
                alert("请联系网站管理员");
            }
        });
    }
    function submitColumn() {
        if($('input:checkbox:checked').length==0){
            alert('请至少勾选一个栏目操作！');
            return false;
        }
        return;
    }
</script>
</body>
</html>
