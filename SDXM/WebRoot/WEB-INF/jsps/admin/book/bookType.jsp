<%@ page language="java" import="java.util.*" pageEncoding="utf-8" %>
<%@ page import="cn.com.domain.Booktype" %>
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
    </style>
</head>
<body onselectstart="return false;" ondragstart="return false;" oncontextmenu="return false;">
<table width="99%" border="0" cellspacing="0" cellpadding="0" id="searchmain">
    <tr>
        <td width="99%" align="left" valign="top">
            您的位置：<a href="/book/bookType/list.do">图书分类管理</a>&nbsp;&nbsp;>&nbsp;&nbsp;<span id="labelTitle">添加图书分类</span>
        </td>
        <input id="deleteResult" style="display: none;" value="${msg}"/>
    </tr>
    <tr>
        <td align="left" valign="top">
            <form method="post" action="${pageContext.request.contextPath}/book/bookType/post.do" id="form1" onsubmit="return submitForm(this)">
                <table width="100%" border="0" cellspacing="0" cellpadding="0" id="main-tab2">
                    <tr onMouseOut="this.style.backgroundColor='#ffffff'"
                        onMouseOver="this.style.backgroundColor='#edf5ff'">
                        <td align="right" valign="middle" class="borderright borderbottom bggray">图书分类名称名称：</td>
                        <td align="left" valign="middle" class="borderright borderbottom main-for">
                            <input type="text" name="typeName" value="" id="typeName"
                                   onblur="checkName(this.value)" class="text-word"><span id="msg"></span>
                        </td>
                    </tr>
                    <tr style="display: none">
                        <td align="right" valign="middle" class="borderright borderbottom bggray">图书分类：</td>
                        <td align="left" valign="middle" class="borderright borderbottom main-for">
                            <input type="text" name="id" value="" id="id"
                                   class="text-word">
                        </td>
                    </tr>
                    <tr style="display: none">
                        <td align="right" valign="middle" class="borderright borderbottom bggray">图书分类：</td>
                        <td align="left" valign="middle" class="borderright borderbottom main-for">
                            <input id="state" type="text" name="state" value=""
                                   class="text-word">
                        </td>
                    </tr>
                    <tr style="display: none">
                        <td align="right" valign="middle" class="borderright borderbottom bggray">图书分类：</td>
                        <td align="left" valign="middle" class="borderright borderbottom main-for">
                            <input type="text" name="isDelete" value="" id="isDelete"
                                   class="text-word">
                        </td>
                    </tr>
                    <tr onMouseOut="this.style.backgroundColor='#ffffff'"
                        onMouseOver="this.style.backgroundColor='#edf5ff'">
                        <td align="right" valign="middle" class="borderright borderbottom bggray">备注信息：</td>
                        <td align="left" valign="middle" class="borderright borderbottom main-for">
                            <input type="text" name="remarks" value="" id="remarks"
                                   class="text-word">
                            <input name="parentid" id="parentid" value="0" style="display: none;"/>
                        </td>
                    </tr>
                    <c:if test="${(not empty updateBookType and updateBookType.parentid != 0) or empty updateBookType}">
                        <tr onMouseOut="this.style.backgroundColor='#ffffff'"
                            onMouseOver="this.style.backgroundColor='#edf5ff'">
                            <td align="right" valign="middle" class="borderright borderbottom bggray">上一级：</td>
                            <td align="left" valign="middle" class="borderright borderbottom main-for">
                                <select class="type-select" id="type1" onchange="changetype(this)">
                                    <option value="0" selected>--请选择--</option>
                                    <c:forEach items="${types}" var="t">
                                        <option value="${t.id}">${t.typeName}</option>
                                    </c:forEach>
                                </select>
                            </td>
                        </tr>
                    </c:if>
                    <tr onMouseOut="this.style.backgroundColor='#ffffff'"
                        onMouseOver="this.style.backgroundColor='#edf5ff'">
                        <td align="right" valign="middle" class="borderright borderbottom bggray">&nbsp;</td>
                        <td align="left" valign="middle" class="borderright borderbottom main-for">
                            <input id="Submit" name="UpdateSubmit" type="submit" value="提交" class="text-but"
                                   onclick="return checkSubmit()">
                            <input name="" type="reset" value="重置" class="text-but"></td>
                    </tr>
                </table>
            </form>
        </td>
    </tr>
    <%--</c:if>--%>
</table>

<c:if test="${not empty updateBookType}">
    <script type="text/javascript">
        $(document).ready(function () {
            $("#id").val("${updateBookType.id}");
            $("#typeName").val("${updateBookType.typeName}");
            $("#state").val("${updateBookType.state}");
            $("#remarks").val("${updateBookType.remarks}");
            $("#isDelete").val("${updateBookType.isDelete}");
            $("#type1").val("${updateBookType.parentid}");
            $("#parentid").val("${updateBookType.parentid}");
            $("#labelTitle").html("更新图书分类");

            <c:if test="${not empty superType}">
            (function () {
                var _types = JSON.parse("${superType}");
                var _level = 0;
                _types.shift();
                _types.pop();

                function setTypes() {
                    if (_types.length > 0) {
                        var _value = _types.shift();
                        var ele = $("#type" + ++_level);
                        ele.val(_value);
                        changetype(ele, setTypes);
                    }
                }

                setTypes();
            })();
            </c:if>
        })
    </script>
</c:if>

</body>
<script type="application/javascript">
    var start = setTimeout(myfun, 100);
    function myfun() {
        var result = document.getElementById("deleteResult").value;
        if (result != '') {
            alert(result);
        }
    }
    window.onload = start;

    function checkName(name) {
        var Url = "/book/bookType/checkName.do?name=" + name;
        var id = $("#id").value;
        if (id != undefined && id != '') {
            var checkUrl = Url.concat("&type=1");
            Url = checkUrl;
        }
        $.get(Url, function (str) {
            if (str == 'true') {
                $("#msg").html("分类名已存在！请重新输入");
                $("#Submit").attr("disabled", "disabled");
            } else {
                $("#msg").html("");
                $("#Submit").removeAttr("disabled");
            }
        });
    }

    function checkSubmit() {
        var name = document.getElementById("typeName").value;

        if (name.trim() == '') {
            document.getElementById("msg").innerHTML = "分类名不允许为空";
            return false;
        }
        return true;
    }
</script>

<script type="text/javascript">
    //多级级联菜单
    function changetype(ele, callback) {
        ele = $(ele);
        var ele_id = ele.attr('id');
        var level = parseInt(ele_id.substr(ele_id.length - 1, 1));
        var val = $(ele).val();
        var parentid = '0';
        var temp = level - 1;
        if (level > 1) {
            parentid = $("#type" + temp.toString()).val();
        }
        if (val && val != parentid) {
            //检查选中
            <c:if test="${not empty updateBookType}">
            if (val =="${updateBookType.id}") {
                alert("您不能这样选择");
                return;
            }
            </c:if>
            $.get('<c:url value="/book/typeof.do"/>?parent=' + val, function (result) {
                if (result && result != '[]') {
                    var newid = "type" + (level + 1);
                    setOption($("#" + newid));
                    var ele_new_select = $('<select class="type-select" id="nameid" onchange="changetype(this)"></select>'
                        .replace("nameid", newid))[0];
                    $(ele).parent().append(ele_new_select);
                    setOption($("#" + newid), JSON.parse(result), val);
                } else {
                    setOption($("#type" + (level + 1)),JSON.parse(result), val);
                }
                callFun(callback);
            })
        } else {//选中的是请选择
            setOption($("#type" + (level + 1)));
        }
    }
    //设置select的选项
    function setOption(ele, opts, parent) {
        ele = $(ele);
        if (ele.length == 0) return;
        if (opts) {
            ele.html('<option value="0">&nbsp;&nbsp;请选择</option>'.replace("0", parent));
            for (var i = 0; i < opts.length; ++i) {
                ele.append('<option value="kkkk">&nbsp;&nbsp;vvvv</option>'
                    .replace("kkkk", opts[i].id)
                    .replace("vvvv", opts[i].typeName))
            }
        } else {
            var id = ele.attr('id');
            var level = parseInt(id.substr(id.length - 1, 1));
            ele.remove();
            setOption($("#type" + (level + 1)))
        }
    }

    function submitForm(form) {
        var ele_sel_last = $(".type-select:last-of-type");
        if (ele_sel_last == undefined || ele_sel_last == "") {
            return false;
        }
        <c:if test="${(not empty updateBookType and updateBookType.parentid != 0) or empty updateBookType}">
        	$("#parentid").val(ele_sel_last.val());
        </c:if>

        <c:if test="${not empty updateBookType}">
        if ($("#parentid").val() =="${updateBookType.id}") {
            alert("请重新选择上一级");
            return false;
        }
        </c:if>

        return true;
    }

    function callFun(func, param) {
        if (func) func(param);
    }
</script>

</html>
