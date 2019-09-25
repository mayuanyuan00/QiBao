<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <title>左侧导航menu</title>
  <link href="${pageContext.request.contextPath}/css/css.css" type="text/css" rel="stylesheet"/>
  <script type="text/javascript" src="${pageContext.request.contextPath}/js/sdmenu.js"></script>
  <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
  <script type="text/javascript" src="${pageContext.request.contextPath}/js/webuploader.min.js"></script>
  <script src="${pageContext.request.contextPath}/ckeditor/ckeditor.js"></script>

  <script type="text/javascript" charset="utf-8"
          src="${pageContext.request.contextPath}/ueditor1_4_3_3-utf8-jsp/utf8-jsp/ueditor.config.js"></script>
  <script type="text/javascript" charset="utf-8"
          src="${pageContext.request.contextPath}/ueditor1_4_3_3-utf8-jsp/utf8-jsp/ueditor.all.min.js"></script>
  <script type="text/javascript" charset="utf-8"
          src="${pageContext.request.contextPath}/ueditor1_4_3_3-utf8-jsp/utf8-jsp/lang/zh-cn/zh-cn.js"></script>

  <link rel="shortcut icon" href="${pageContext.request.contextPath}/images/favicon.ico"/>
  <link href="${pageContext.request.contextPath}/css/css.css" type="text/css" rel="stylesheet"/>
  <link href="${pageContext.request.contextPath}/css/webuploader.css" type="text/css" rel="stylesheet"/>
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

    #main-tab tr:hover {
      background-color: #edf5ff;
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

    .main-for textarea.text-word {
      width: 310px;
      height: 100px;
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

    #ebookurlUploader > * {
      display: inline-block;
    }
  </style>
</head>
<body onselectstart="return false;" ondragstart="return false;">
<table width="99%" border="0" cellspacing="0" cellpadding="0" id="searchmain">
  <tr>
    <td width="99%" align="left" valign="top">您的位置：订单管理&nbsp;&nbsp;>&nbsp;&nbsp;修改订单</td>
  </tr>

  <tr>
    <td align="left" valign="top">
      <form method="post" action="${pageContext.request.contextPath}/order/updateStatus.do">
        <input name="id" value="${order.id}" type="hidden">
        <input name="date1" value="${order.create_date}" type="hidden">
        <table width="100%" border="0" cellspacing="0" cellpadding="0" id="main-tab">
          <tr>
            <td align="right" valign="middle" class="borderright borderbottom bggray">*订单号：</td>
            <td align="left" valign="middle" class="borderright borderbottom main-for">
              <input type="text" name="oderid"  class="text-word" value="${order.orderno}" disabled>
            </td>
          </tr>
          <tr>
            <td align="right" valign="middle" class="borderright borderbottom bggray">*订单状态：</td>
            <td align="left" valign="middle" class="borderright borderbottom main-for">
              <select name="status">
                <option <c:if test="${order.status==1}">selected</c:if> value="1">提交未支付</option>
                <option <c:if test="${order.status==2}">selected</c:if> value="2">支付未确认</option>
                <option <c:if test="${order.status==3}">selected</c:if> value="3">支付已确认</option>
                <option <c:if test="${order.status==4}">selected</c:if> value="4">确认未发货</option>
                <option <c:if test="${order.status==5}">selected</c:if> value="5">发货未收货</option>
                <option <c:if test="${order.status==6}">selected</c:if> value="6">收货未评价</option>
                <option <c:if test="${order.status==7}">selected</c:if> value="7">完成</option>
                <option <c:if test="${order.status==8}">selected</c:if> value="8">已取消</option>
              </select>
            </td>
          </tr>
          <tr>
            <td align="right" valign="middle" class="borderright borderbottom bggray">*订单时间：</td>
            <td align="left" valign="middle" class="borderright borderbottom main-for">
              <input type="text" name="date1"  value="${order.create_date}" class="text-word" disabled/>
            </td>
          </tr>
          <tr>
            <td align="right" valign="middle" class="borderright borderbottom bggray">*收货人：</td>
            <td align="left" valign="middle" class="borderright borderbottom main-for">
              <input type="text" name="owner"  value="${order.owner}" class="text-word" disabled/>
            </td>
          </tr>
          <tr>
            <td align="right" valign="middle" class="borderright borderbottom bggray">*收货地址：</td>
            <td align="left" valign="middle" class="borderright borderbottom main-for">
              <input type="text" name="address"  value="${order.address}" class="text-word" disabled/>
            </td>
          </tr>
          <tr>
            <td align="right" valign="middle" class="borderright borderbottom bggray">*快递公司：</td>
            <td align="left" valign="middle" class="borderright borderbottom main-for">
              <input type="text" name="express"  value="${order.express}" class="text-word" required/>
            </td>
          </tr>
          <tr>
            <td align="right" valign="middle" class="borderright borderbottom bggray">*快递单号：</td>
            <td align="left" valign="middle" class="borderright borderbottom main-for">
              <input type="text" name="expno"  value="${order.expno}" class="text-word" required/>
            </td>
          </tr>
          <tr>
            <td align="right" valign="middle" class="borderright borderbottom bggray">&nbsp;</td>
            <td align="left" valign="middle" class="borderright borderbottom main-for">
              <input type="submit" value="提交" class="text-but"/>
              <input id="reset" type="reset" value="重置" class="text-but"/>
            </td>
          </tr>
        </table>
      </form>
    </td>
  </tr>
</table>
</body>

</html>
