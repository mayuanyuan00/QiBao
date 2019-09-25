<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>栏目管理</title>
    <link href="${pageContext.request.contextPath}/css/css.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/sdmenu.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js" ></script>
    <script src="${pageContext.request.contextPath}/ckeditor/ckeditor.js"></script>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/images/favicon.ico" />
    <link href="${pageContext.request.contextPath}/css/css.css" type="text/css" rel="stylesheet" />
    <style>
        body{overflow-x:hidden; background:#f2f0f5; padding:15px 0px 10px 5px;}
        #searchmain{ font-size:12px;}
        #search{ font-size:12px; background:#548fc9; margin:10px 10px 0 0; display:inline; width:100%; color:#FFF}
        #search form span{height:40px; line-height:40px; padding:0 0px 0 10px; float:left;}
        #search form input.text-word{height:24px; line-height:24px; width:180px; margin:8px 0 6px 0; padding:0 0px 0 10px; float:left; border:1px solid #FFF;}
        #search form input.text-but{height:24px; line-height:24px; width:55px; background:url(images/main/list_input.jpg) no-repeat left top; border:none; cursor:pointer; font-family:"Microsoft YaHei","Tahoma","Arial",'宋体'; color:#666; float:left; margin:8px 0 0 6px; display:inline;}
        #search a.add{ background:url(images/main/add.jpg) no-repeat 0px 6px; padding:0 10px 0 26px; height:40px; line-height:40px; font-size:14px; font-weight:bold; color:#FFF}
        #search a:hover.add{ text-decoration:underline; color:#d2e9ff;}
        #main-tab{ border:1px solid #eaeaea; background:#FFF; font-size:12px;}
        #main-tab th{ font-size:12px; background:url(images/main/list_bg.jpg) repeat-x; height:32px; line-height:32px;}
        #main-tab td{ font-size:12px; line-height:40px;}
        #main-tab td a{ font-size:12px; color:#548fc9;}
        #main-tab td a:hover{color:#565656; text-decoration:underline;}
        .bordertop{ border-top:1px solid #ebebeb}
        .borderright{ border-right:1px solid #ebebeb}
        .borderbottom{ border-bottom:1px solid #ebebeb}
        .borderleft{ border-left:1px solid #ebebeb}
        .gray{ color:#dbdbdb;}
        td.fenye{ padding:10px 0 0 0; text-align:right;}
        .bggray{ background:#f9f9f9; font-size:14px; font-weight:bold; padding:10px 10px 10px 0; width:120px;}
        .main-for{ padding:10px;}
        .main-for input.text-word{ width:310px; height:36px; line-height:36px; border:#ebebeb 1px solid; background:#FFF; font-family:"Microsoft YaHei","Tahoma","Arial",'宋体'; padding:0 10px;}
        .main-for select{ width:310px; height:36px; line-height:36px; border:#ebebeb 1px solid; background:#FFF; font-family:"Microsoft YaHei","Tahoma","Arial",'宋体'; color:#666;}
        .main-for input.text-but{ width:100px; height:40px; line-height:30px; border: 1px solid #cdcdcd; background:#e6e6e6; font-family:"Microsoft YaHei","Tahoma","Arial",'宋体'; color:#969696; float:left; margin:0 10px 0 0; display:inline; cursor:pointer; font-size:14px; font-weight:bold;}
        #addinfo a{ font-size:14px; font-weight:bold; background:url(images/main/addinfoblack.jpg) no-repeat 0 1px; padding:0px 0 0px 20px; line-height:45px;}
        #addinfo a:hover{ background:url(images/main/addinfoblue.jpg) no-repeat 0 1px;}
    </style>
</head>
<body onselectstart="return false;" ondragstart="return false;" oncontextmenu="return false;">
<table width="99%" border="0" cellspacing="0" cellpadding="0" id="searchmain">
    <tr>
        <td width="99%" align="left" valign="top">您的位置：栏目管理&nbsp;&nbsp;>&nbsp;&nbsp;修改栏目</td>
    </tr>

    <tr>
        <td align="left" valign="top">
            <form method="post" action="<c:url value='/menu/updateMenuInfo.do'/>">
                <table width="100%" border="0" cellspacing="0" cellpadding="0" id="main-tab">
                    <c:choose>
                        <c:when test="${isParent == false}">
                    <tr onMouseOut="this.style.backgroundColor='#ffffff'" onMouseOver="this.style.backgroundColor='#edf5ff'">
                        <td align="right" valign="middle" class="borderright borderbottom bggray">一级栏目：</td>
                        <td align="left" valign="middle" class="borderright borderbottom main-for">
                            <select name="firstColumnId" id="type">
                                <c:choose>
                                    <c:when test="${columns != null}">
                                        <c:forEach items="${columns}" var="column"  varStatus="status">
                                            <c:choose>
                                                <c:when test="${firstColumnId == column.id}">
                                                    <option value="${column.id}" selected="selected">${column.name}</option>
                                                </c:when>
                                                <c:otherwise>
                                                    <option value="${column.id}">${column.name}</option>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <option value="">无栏目信息</option>
                                    </c:otherwise>
                                </c:choose>
                            </select>
                            <!-- <input type="text" name="firstColumnName" value="" class="text-word"> -->
                        </td>
                    </tr>
                        </c:when>
                    </c:choose>
                    <tr onMouseOut="this.style.backgroundColor='#ffffff'" onMouseOver="this.style.backgroundColor='#edf5ff'">
                        <td align="right" valign="middle" class="borderright borderbottom bggray">
                            <c:choose>
                                <c:when test="${isParent}">
                                    一级栏目：
                                </c:when>
                                <c:otherwise>
                                    二级栏目：
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td align="left" valign="middle" class="borderright borderbottom main-for">

                            <input type="text" name="secondColumnName" value="${secondColumnName}" class="text-word">
                            <input type="hidden" name = "secondColumnId" value="${secondColumnId}" >
                        </td>
                    </tr>
                    <tr onMouseOut="this.style.backgroundColor='#ffffff'" onMouseOver="this.style.backgroundColor='#edf5ff'">
                        <td align="right" valign="middle" class="borderright borderbottom bggray">
                            编辑内容：
                        </td>

                        <td align="left" valign="middle" class="borderright borderbottom main-for">
                            <select name="hasContent">
                                <c:choose>
                                    <c:when test="${hasContent}">
                                        <option value="true">是</option>
                                        <option value="false">否</option>
                                    </c:when>
                                    <c:otherwise>
                                        <option value="false">否</option>
                                        <option value="true">是</option>
                                    </c:otherwise>
                                </c:choose>
                            </select>
                        </td>

                    </tr>
                    <!--  <tr onMouseOut="this.style.backgroundColor='#ffffff'" onMouseOver="this.style.backgroundColor='#edf5ff'">
                      <td align="right" valign="middle" class="borderright borderbottom bggray">栏目类型：</td>
                      <td align="left" valign="middle" class="borderright borderbottom main-for">
                      <select name="type" id="type">
                      <option value="1" >&nbsp;&nbsp;历史</option>
                      <option value="2" >&nbsp;&nbsp;现代</option>
                      <option value="3" >&nbsp;&nbsp;科幻</option>
                      </select>
                      </td>
                    </tr> -->
                    <tr onMouseOut="this.style.backgroundColor='#ffffff'" onMouseOver="this.style.backgroundColor='#edf5ff'">
                        <td align="right" valign="middle" class="borderright borderbottom bggray">&nbsp;</td>
                        <td align="left" valign="middle" class="borderright borderbottom main-for">
                            <input name="" type="submit" value="提交" class="text-but">
                            <input name="" type="reset" value="重置" class="text-but"></td>
                    </tr>
                </table>
            </form>
        </td>
    </tr>
</table>
</body>

</html>
