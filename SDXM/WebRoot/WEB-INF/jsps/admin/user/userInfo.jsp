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
    </style>
</head>
<body onselectstart="return false;" ondragstart="return false;" oncontextmenu="return false;">

<c:choose>
    <c:when test="${sessionScope.op==0}">
        <table width="99%" border="0" cellspacing="0" cellpadding="0" id="searchmain">
            <tr>
                <td width="99%" align="left" valign="top">您的位置：用户管理&nbsp;&nbsp;>&nbsp;&nbsp;添加用户</td>
            </tr>
            <tr>
                <td align="left" valign="top">
                    <form method="post" action="<c:url value='/adminUser/userSave.do'/>"
                          onsubmit="return submitUser();">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0" id="main-tab">
                            <tr onMouseOut="this.style.backgroundColor='#ffffff'"
                                onMouseOver="this.style.backgroundColor='#edf5ff'">
                                <td align="right" valign="middle" class="borderright borderbottom bggray">用户名：</td>
                                <td align="left" valign="middle" class="borderright borderbottom main-for">
                                    <input type="text" name="name" value="" id="name" class="text-word"
                                           required="required" maxlength="10" onblur="checkName()"><span
                                        id="nameMsg" style="color: red"></span>
                                </td>
                            </tr>
                            <tr onMouseOut="this.style.backgroundColor='#ffffff'"
                                onMouseOver="this.style.backgroundColor='#edf5ff'">
                                <td align="right" valign="middle" class="borderright borderbottom bggray">用户密码：</td>
                                <td align="left" valign="middle" class="borderright borderbottom main-for">
                                    <input type="password" name="password" id="password" value="" class="text-word"
                                           maxlength="30" required="required">
                                </td>
                            </tr>
                            <tr onMouseOut="this.style.backgroundColor='#ffffff'"
                                onMouseOver="this.style.backgroundColor='#edf5ff'">
                                <td align="right" valign="middle" class="borderright borderbottom bggray">确认密码：</td>
                                <td align="left" valign="middle" class="borderright borderbottom main-for">
                                    <input type="password" id="repassword" name="repassword" value="" class="text-word"
                                           maxlength="30" required="required"><span name="passwordMsg"></span>
                                </td>
                            </tr>
                            <tr onMouseOut="this.style.backgroundColor='#ffffff'"
                                onMouseOver="this.style.backgroundColor='#edf5ff'">
                                <td align="right" valign="middle" class="borderright borderbottom bggray">用户类别：</td>
                                <td align="left" valign="middle" class="borderright borderbottom main-for">
                                    <select name="level" id="level">
                                        <option value="2">&nbsp;&nbsp;信息管理员</option>
                                        <option value="1">&nbsp;&nbsp;图书管理员</option>
                                        <option value="0">&nbsp;&nbsp;超级管理员</option>
                                    </select>
                                </td>
                            </tr>
                            <tr onMouseOut="this.style.backgroundColor='#ffffff'"
                                onMouseOver="this.style.backgroundColor='#edf5ff'">
                                <td align="right" valign="middle" class="borderright borderbottom bggray">权限选择：</td>
                                <td align="left" valign="middle" class="borderright borderbottom bggray " id="_box0">

                                </td>
                            </tr>
                            <tr onMouseOut="this.style.backgroundColor='#ffffff'"
                                onMouseOver="this.style.backgroundColor='#edf5ff'">
                                <td align="right" valign="middle" class="borderright borderbottom bggray">&nbsp;</td>
                                <td align="left" valign="middle" class="borderright borderbottom main-for">
                                    <input name="submit" type="submit" id="submitButton" value="提交"
                                           onclick="return checkPassword()" class="text-but">
                                    <input name="" type="reset" value="重置" class="text-but"></td>
                            </tr>
                        </table>
                    </form>
                </td>
            </tr>
        </table>
        <input type="hidden" value="${meunList}" id="_meunList"/>
        <input type="hidden" value="${voList}" id="_voList"/>
    </c:when>
    <c:otherwise>

        <table width="99%" border="0" cellspacing="0" cellpadding="0" id="searchmain">
            <tr>
                <td width="99%" align="left" valign="top">您的位置：用户管理&nbsp;&nbsp;>&nbsp;&nbsp;编辑用户</td>
            </tr>
            <tr>
                <td align="left" valign="top">
                    <form method="post" action="<c:url value='/adminUser/userUpdate.do?id=${sessionScope.id}'/> "
                          onsubmit="return submitUser();">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0" id="main-tab">
                            <tr onMouseOut="this.style.backgroundColor='#ffffff'"
                                onMouseOver="this.style.backgroundColor='#edf5ff'">
                                <td align="right" valign="middle" class="borderright borderbottom bggray">用户名：</td>
                                <td align="left" valign="middle" class="borderright borderbottom main-for">
                                    <input type="text" name="name" id="name" value="${userName}" class="text-word"
                                           placeholder="${userName}" disabled="disabled" required="required"><span
                                        id="nameMsg"></span>
                                </td>
                            </tr>
                            <tr onMouseOut="this.style.backgroundColor='#ffffff'"
                                onMouseOver="this.style.backgroundColor='#edf5ff'">
                                <td align="right" valign="middle" class="borderright borderbottom bggray">用户密码：</td>
                                <td align="left" valign="middle" class="borderright borderbottom main-for">
                                    <input type="password" name="password" value="" class="text-word">
                                        <%-- required="required"--%>
                                </td>
                            </tr>
                            <tr onMouseOut="this.style.backgroundColor='#ffffff'"
                                onMouseOver="this.style.backgroundColor='#edf5ff'">
                                <td align="right" valign="middle" class="borderright borderbottom bggray">确认密码：</td>
                                <td align="left" valign="middle" class="borderright borderbottom main-for">
                                    <input type="password" name="repassword" value="" class="text-word"><span
                                        name="passwordMsg" style="color: red" ></span>
                                        <%--required="required"--%>
                                </td>
                            </tr>
                            <tr onMouseOut="this.style.backgroundColor='#ffffff'"
                                onMouseOver="this.style.backgroundColor='#edf5ff'"
                                <c:if test="${level==3}">style="display: none" </c:if>>
                                <td align="right" valign="middle" class="borderright borderbottom bggray">用户类别：</td>
                                <td align="left" valign="middle" class="borderright borderbottom main-for">
                                    <select name="level" id="level">
                                        <option value="2" <c:if test="${level==2}">selected="selected"</c:if>>&nbsp;&nbsp;信息管理员</option>
                                        <option value="1" <c:if test="${level==1}">selected="selected"</c:if>>&nbsp;&nbsp;图书管理员</option>
                                        <option value="0" <c:if test="${level==0}">selected="selected"</c:if>>&nbsp;&nbsp;超级管理员</option>
                                            <%--<c:if test="${level==3}"><option value="3" selected="selected">&nbsp;&nbsp;前台用户</option></c:if>>--%>
                                    </select>
                                </td>
                            </tr>
                            <c:if test="${level!=3}">
                            <tr onMouseOut="this.style.backgroundColor='#ffffff'"
                                onMouseOver="this.style.backgroundColor='#edf5ff'">
                                <td align="right" valign="middle" class="borderright borderbottom bggray">权限选择：</td>
                                <td align="left" valign="middle" class="borderright borderbottom bggray " id="_box1">

                                </td>
                            </tr>
                            </c:if>
                            <tr onMouseOut="this.style.backgroundColor='#ffffff'"
                                onMouseOver="this.style.backgroundColor='#edf5ff'">
                                <td align="right" valign="middle" class="borderright borderbottom bggray">&nbsp;</td>
                                <td align="left" valign="middle" class="borderright borderbottom main-for">
                                    <input name="submit" type="submit" value="提交" class="text-but"
                                           onclick="return checkPassword()">
                                    <input name="" type="reset" value="重置" class="text-but"></td>
                            </tr>
                        </table>
                    </form>
                </td>
            </tr>
        </table>
    </c:otherwise>
</c:choose>
<script type="text/javascript">
    $(function () {
        <c:if test="${sessionScope.level ne '3'}">
        showAuthority();
        <c:if test="${sessionScope.op ne 0}">
        <c:if test="${sessionScope.level eq '0'}">
        $('#_box1').empty();
        $('#_box1').append($('<span>所有权限</span>'))
        </c:if>
        <c:if test="${not empty groupList}">
        <c:forEach var="aa" items="${groupList}">
        var meunlist = [${aa.groupcode}];
        $.each(meunlist, function (i, val) {
            var id = '#enum_${aa.groupname}_' + val;
            $(id).prop('checked', true);
        })
        </c:forEach>
        </c:if>
        </c:if>
        </c:if>
    })

    function checkName() {
        $.ajax({
            type: "POST",
            url: "${pageContext.request.contextPath}/adminUser/userCheck.do",
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


    function checkPassword() {
        var password = document.getElementsByName("password")[0].value;
        var repassword = document.getElementsByName("repassword")[0].value;
        if (password != repassword) {
            console.log(document.getElementsByName("passwordMsg"));
            document.getElementsByName("passwordMsg")[0].innerHTML = "两次密码不一致";
            // document.getElementsByName("submit")[0].disabled=true;
            return false;
        }
        else {
            document.getElementsByName('passwordMsg')[0].innerHTML = "";
            return true;
        }
    }

    //权限显示
    function showAuthority() {
        var _father = $('#_box1')
        <c:if test="${sessionScope.op==0}">
        _father = $('#_box0');
        </c:if>
        <c:forEach var="val" items="${meunList}" varStatus="status">
        var new_span = $('<c:if test="${status.count>1}"><br></c:if><span>&nbsp;&nbsp;${val.groupname}:</span>');
        _father.append(new_span);
        var child_enum = [${val.groupcode}];
        $.each(child_enum, function (j, cval) {
            var enumName = getEnumName(cval);
            var new_label = $('<label class="meun" for="enum_${val.id}_' + cval + '">' + enumName + '</label>');
            var new_checkbox = $('<input id="enum_${val.id}_' + cval + '" type="checkbox"/>');
            _father.append(new_label);
            _father.append(new_checkbox);
        })
        </c:forEach>
    }

    function getEnumName(i) {
        switch (i) {
            case 1:
                return "查看";
                break;
            case 2:
                return "新建";
                break;
            case 3:
                return "编辑";
                break;
            case 4:
                return "审批";
                break;
            case 5:
                return "发布";
                break;
            case 6:
                return "删除";
                break;
            case 7:
                return "操作";
                break;
            default:
                return "";
                break;
        }
    }

    $('#level').change(function () {
        var _father = $('#_box1')
        <c:if test="${sessionScope.op==0}">
        _father = $('#_box0');
        </c:if>
        if ($(this).val() == 0) {
            _father.empty();
            _father.append($('<span>所有权限</span>'))
        } else {
            _father.empty();
            showAuthority();
        }
    })

    function submitUser() {
        var name = $('#name').val();
        var password = $('input[name=password]').val();
        var level = '3';
        var str = {};
        <c:if test="${sessionScope.level!=3}">
         level = $('#level').val();
        if($('input:checkbox:checked').length==0&&$('#level').val()!='0'&&${sessionScope.level ne '3'}){
            alert('请选择权限！');
            return false;
        }
        var column;
        var operation = "";
        var temp;
        $('input:checkbox:checked').each(function (i) {
            temp = $(this).attr("id").substring(5, $(this).attr("id").lastIndexOf("_"));
            if (i == 0) {
                column = temp;
            }
            if (temp == column) {
                operation = operation + "," + $(this).attr("id").substring($(this).attr("id").length - 1);
            } else {
                operation = "," + $(this).attr("id").substring($(this).attr("id").length - 1);
            }
            str[temp] = operation.substring(1);
            column = temp
        });
        </c:if>
        <c:if test="${sessionScope.op==0}">
        $.get("<c:url value='/adminUser/userSave.do'/>",
            {"name": name, "password": password, "level": level, "authority": JSON.stringify(str)}, function (t) {
                location.href = t;
            })
        </c:if>
        <c:if test="${sessionScope.op!=0}">
        $.get("<c:url value='/adminUser/userUpdate.do?id=${sessionScope.id}'/>", {
            "level": level,
            "password": password,
            "authority": JSON.stringify(str)
        },function (t) {
            location.href = t;
        })
        </c:if>
        return false;
    }


</script>
</body>
</html>
