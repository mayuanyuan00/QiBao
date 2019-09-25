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
tr.headings{padding: 10px 15px; background-color: #AEEEEE; margin-bottom: 1px; box-sizing: border-box; font-size: 18px; color: #4c4c4c; text-transform: uppercase; transition: 0.3s;}
tr.contents{background-color: #fff; box-shadow: 0 8px 8px #d2d2d2; padding: 15px; box-sizing: border-box;}
</style>
</head>
<body onselectstart="return false;" ondragstart="return false;" oncontextmenu="return false;">
<!--main_top-->

<!-- jstree example -->

<table width="99%" border="0" cellspacing="0" cellpadding="0" id="searchmain">
  <tr>
    <td width="99%" align="left" valign="top">您的位置：栏目管理</td>
  </tr>
  <tr>
    <td align="left" valign="top">

    <table width="100%" border="0" cellspacing="0" cellpadding="0" id="search">
  		<tr>
   		 <td width="90%" align="left" valign="middle _search">
	         <form method="post" action="<c:url value='/menu/menuList.do'/>">
	         <span>栏目名称：</span>
	         <input type="text" name="searchStr" value="" class="text-word">
             <input name="" type="submit" value="查询" class="text-but">
	         </form>
         </td>
  		  <td width="10%" align="center" valign="middle" style="text-align:right; width:150px;"><a href="<c:url value='/menu/menuInfo.do?menuType=1'/>" target="mainFrame" onFocus="this.blur()" class="add _add">新增栏目</a></td>
  		</tr>
	</table>


    </td>
  </tr>
  <tr>
    <td align="left" valign="top">
     
    <table width="100%" border="0" cellspacing="0" cellpadding="0" id="main-tab">
      <tr>
        <th align="center" valign="middle" class="borderright tda"></th>
        <th align="center" valign="middle" class="borderright tda">ID</th>
        <th align="center" valign="middle" class="borderright">栏目名</th>
        <th align="center" valign="middle _all">栏目管理</th>
      </tr>

      <!-- DB search -->
        <c:choose>
            <c:when test="${columns != null}">
                <c:forEach items="${columns}" var="column"  varStatus="status">
                    <tr class="list headings">
                        <c:choose>
                            <c:when test="${column.parent == 0}">
                                <td><img src="${pageContext.request.contextPath}/images/main/dirfirst.gif" alt=""/></td>
                            </c:when>
                            <c:otherwise>
                                <td><img src="${pageContext.request.contextPath}/images/main/why.gif" alt=""/></td>
                            </c:otherwise>
                        </c:choose>

                        <td class="columnid">${column.id}</td>
                        <td class="columnname">${column.name}</td>
                        <td class="columnparent" style="display:none;">${column.parent}</td>
                        <td class="_all"><a class="columndelete _delete" onfocus="this.blur()">删除</a><span class="gray">&nbsp;<span class="_divide_1">|</span>&nbsp;</span>
                            <a class="columnupdate _edit" onfocus="this.blur()">修改</a>
                            <form action="<c:url value='/menu/updateMenu.do'/>" method="post" style="display: none;">
                                <input type="hidden" class="inputId" name="secondColumnId"/>
                                <input type="hidden" class="inputParent" name="firstColumnId"/>
                                <input type="hidden" class="inputName" name="secondColumnName"/>
                                <input type="hidden" class="inputHasContent" name="hasContent" value="${column.hasContent}"/>
                            </form>
                            <c:choose>
                                <c:when test="${column.hasContent == true}">
                                    <%--<span class="gray">&nbsp;|&nbsp;</span><a class="editContent" onfocus="this.blur()">编辑内容</a>--%>
                                    <span class="gray">&nbsp<span class="_divide_2">|</span>&nbsp;</span><a class="editContent _edit"  onfocus="this.blur()">编辑内容</a>
                                </c:when>
                            </c:choose>
                        </td>
                    </tr>
                    <c:choose>
                        <c:when test="${not empty column.children}">
                            <c:forEach items="${column.children}" var="child"  varStatus="status">
                                <tr  class="list contents" onMouseOut="this.style.backgroundColor='#ffffff'"
                                onMouseOver="this.style.backgroundColor='#edf5ff'" >
                                <td><img src="${pageContext.request.contextPath}/images/main/dirsecond.gif" alt=""/></td>
                                <td class="columnid">${child.id}</td>
                                <td class="columnname">${child.name}</td>
                                <td class="columnparent" style="display:none;">${child.parent}</td>
                                <td class="_all"><a class="columndelete _delete" onfocus="this.blur()">删除</a><span class="gray">&nbsp;<span class="_divide_1">|</span>&nbsp;</span>
                                    <a class="columnupdate _edit" onfocus="this.blur()">修改</a>
                                    <form action="<c:url value='/menu/updateMenu.do'/>" method="post" style="display: none;">
                                        <input type="hidden" class="inputId" name="secondColumnId"/>
                                        <input type="hidden" class="inputParent" name="firstColumnId"/>
                                        <input type="hidden" class="inputName" name="secondColumnName"/>
                                        <input type="hidden" class="inputHasContent" name="hasContent" value="${child.hasContent}"/>
                                    </form>
                                    <c:choose>
                                        <c:when test="${child.hasContent == true}">
                                            <%--<span class="gray">&nbsp;|&nbsp;</span><a class="editContent"  onfocus="this.blur()">编辑内容</a>--%>
                                            <span class="gray">&nbsp;<span class="_divide_2">|</span>&nbsp;</span><a class="showContent _search"  onfocus="this.blur()">查看内容</a>
                                        </c:when>
                                    </c:choose>
                                </td>
                                </tr>
                            </c:forEach>

                        </c:when>
                    </c:choose>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <tr>
                    <td colspan="3">暂无栏目信息</td>
                </tr>
            </c:otherwise>
        </c:choose>
   <!--
    <tr>
    <td align="left" valign="top" id="xiugai"><input name="" type="submit" value="提交" class="text-but" /></td>
    </tr>-->
   </table>

  
    </td>
  </tr>
  </table>
<script type="application/javascript">
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
            $('._divide_1').hide();
        }
        if(!((isContains(array,"1")&&isContains(array,"3"))||isContains(array,"7"))){
            $('._divide_2').hide();
        }
        if(!isContains(array,"3")&&!isContains(array,"7")&&!isContains(array,"6")&&!isContains(array,"1")){
            $('.all').hide();
        }
    })
    function isContains(str, substr) {
        return str.indexOf(substr) >= 0;
    }
    var isSearch = ${isSearch};
    $(window).load(function(){
        if(isSearch){
           // $("tr.contents").toggle();
        }
        $("tr.headings").click(function(){
            var nextSibling = $(this).next();
            while(nextSibling.hasClass("contents")){
                $(nextSibling).toggle();
                nextSibling = $(nextSibling).next();
            }
        });
        $("a.editContent").click(function(){
            var columnId = $(this).parent().parent().children("td.columnid").text();
            window.location.href="/menu/editMenu.do?columnId=" + encodeURI(encodeURI(columnId));
        });
        $("a.showContent").click(function() {
            var type = $(this).parent().parent().children("td.columnid").text();
            window.location.href="${pageContext.request.contextPath}/menu/showNews.do?type=" + encodeURI(encodeURI(type));
        })
        $("a.columnupdate").click(function(){
            var columnId = $(this).parent("td").parent("tr").children(".columnid").text();
            var columnName = $(this).parent("td").parent("tr").children(".columnname").text();
            var columnParent = $(this).parent("td").parent("tr").children(".columnparent").text();
            $(this).next().children(".inputId").val(columnId);
            $(this).next().children(".inputParent").val(columnParent);
            $(this).next().children(".inputName").val(columnName);
            if(columnName.trim() !== ""){
                $(this).parent().children("form").submit();
            } else {
                alert("内容不能为空");
            }
        });
        $("a.columndelete").click(function(){
            var columnParent = $(this).parent().parent().children(".columnparent").text();
            var columnId = $(this).parent("td").parent("tr").children(".columnid").text();
            if (columnParent != 0) {
                //删除的是二级栏目
                $.ajax({
                    url: '${pageContext.request.contextPath}/menu/hasNews.do',
                    data: {id: columnId, post: Math.random()},
                    type: "GET",
                    success: function(data){
                        if (!data){
                            window.location.href = "${pageContext.request.contextPath}/menu/deleteMenu.do?columnId=" + columnId;
                        } else {
                            alert("该栏目存在新闻，不允许删除！");
                        }
                    },
                    error: function(err){
                        alert("删除出错！");
                    }
                })
            } else {
                $.ajax({
                    url: "${pageContext.request.contextPath}/menu/hasChild.do",
                    data: {id: columnId},
                    type: "GET",
                    success: function(data){
                        if(!data){
                            $.ajax({
                                url: '/menu/hasNews.do',
                                data: {id: columnIdRand, postRand: Math.random()},
                                type: "GET",
                                success: function(data){
                                    if (!data){
                                        window.location.href = "/menu/deleteMenu.do?columnId=" + columnId;
                                    } else {
                                        alert("该栏目存在新闻，不允许删除！");
                                    }
                                },
                                error: function(err){
                                    alert("删除出错！");
                                }
                            })
                        } else {
                            alert("存在子栏目，不允许删除！");
                        }
                    },
                    error: function(err){
                        alert("删除出错！");
                    }
                });
            }
        })

    });

</script>
</body>

</html>
