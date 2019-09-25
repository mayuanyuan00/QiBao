<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
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
    #search{ font-size:12px; background:#548fc9; margin:10px 10px 0 0; display:inline; width:100%; color:#FFF}
    #search form span{height:40px; line-height:40px; padding:0 0px 0 10px; float:left;}
    #search form input.text-word{height:24px; line-height:24px; width:180px; margin:8px 0 6px 0; padding:0 0px 0 10px; float:left; border:1px solid #FFF;}
    #search form input.text-but{height:24px; line-height:24px; width:55px; background:url(images/main/list_input.jpg) no-repeat left top; border:none; cursor:pointer; font-family:"Microsoft YaHei","Tahoma","Arial",'宋体'; color:#666; float:left; margin:8px 0 0 6px; display:inline;}
    #search a.add{ background:url(images/main/add.jpg) no-repeat 0px 6px; padding:0 10px 0 26px; height:40px; line-height:40px; font-size:14px; font-weight:bold; color:#FFF}
    #search a:hover.add{ text-decoration:underline; color:#d2e9ff;}
    #main-tab{ border:1px solid #eaeaea; background: #ffffff; font-size:12px;}
    #main-tab th{ font-size:12px; background:url(images/main/list_bg.jpg) repeat-x; height:32px; line-height:32px;}
    #main-tab td{ font-size:12px; line-height:40px;}
    #main-tab td a{ font-size:12px; color:#548fc9;}
    #main-tab td a:hover{color:#565656; text-decoration:underline;}
    #main-tab tr:hover{background-color: #edf5ff;}
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
<%--<body onselectstart="return false;" ondragstart="return false;" oncontextmenu="return false;">--%>
<body onselectstart="return false;">
<table width="99%" border="0" cellspacing="0" cellpadding="0" id="searchmain">
  <tr>
    <td width="99%" align="left" valign="top">您的位置：<a href="<c:url value='${pageContext.request.contextPath}/resource/list.do'/>">资源管理</a> &nbsp;&nbsp;>&nbsp;&nbsp;新增资源</td>
  </tr>

  <tr>
    <td align="left" valign="top">
      <form method="post" onsubmit="return submitForm(this);">
        <table width="100%" border="0" cellspacing="0" cellpadding="0" id="main-tab">
          <input type="hidden" name="id" id="resourceId"/>
          <tr>
            <td align="right" valign="middle" class="borderright borderbottom bggray">*资源名：</td>
            <td align="left" valign="middle" class="borderright borderbottom main-for">
              <input type="text" name="resourceName" id="resourceName" class="text-word" required>
            </td>
          </tr>
          <tr>
            <td align="right" valign="middle" class="borderright borderbottom bggray">*Type：</td>
            <td align="left" valign="middle" class="borderright borderbottom main-for">
              <input type="text" name="resourceType" id="resourceTYpe" value="excel" class="text-word" readonly/>
            </td>
          </tr>
          <tr>
            <td align="right" valign="middle" class="borderright borderbottom bggray">文件：</td>
            <td align="left" valign="middle" class="borderright borderbottom main-for">
              <input type="file" name="excel" id="excel" accept="application/vnd.ms-excel, application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" required/>
            </td>
          </tr>
          <tr>
            <td align="right" valign="middle" class="borderright borderbottom bggray">是否发布：</td>
            <td align="left" valign="middle" class="borderright borderbottom main-for">
              是<input type="radio" name="release"   value="1"/>
              否<input type="radio" name="release"   value="0" checked/>
            </td>
          </tr>
          <tr>
            <td align="right" valign="middle" class="borderright borderbottom bggray">&nbsp;</td>
            <td align="left" valign="middle" class="borderright borderbottom main-for">
              <input type="submit" value="提交" class="text-but"/>
              <input type="reset" value="重置" class="text-but"/>
            </td>
          </tr>
        </table>
      </form>
    </td>
  </tr>
</table>
<!--初始化表单数据-->
<c:if test="${not empty resources}">
  <script type="text/javascript">
      $(document).ready(function () {
          $("#resourceId").val(${resources.id});
          $("#resourceName").val("${resources.resource_name}");
          $("#resourceUrl").val("${resources.resource_url}");
          $("#resourceTYpe").val("${resources.resource_type}");
      })
  </script>
</c:if>
<script type="application/javascript">
    function submitForm(form) {
        var formdata = new FormData(form);

        if ($("#excel").val().indexOf(".xlsx")>0 || $("#excel").val().indexOf(".xls")>0 || $("#excel").val().indexOf(".xlsm")>0 || $("#excel").val().indexOf(".xlt")>0){
            $.ajax({
                url: '<c:url value="/resource/upset.do"/>',
                type: 'POST',
                cache: false,
                data: formdata,
                processData: false,
                contentType: false,
                success: function (data) {
                    if ("SUCCESS" == data) {
                        alert("上传成功");
                        form.reset();
                        window.location.href="${pageContext.request.contextPath}/resource/list.do";
                    } else {
                        alert(data)
                    }
                }
            });

        } else{
            alert("请上传EXCEL文件！");
        }

        return false;
    }
</script>
</body>

</html>
