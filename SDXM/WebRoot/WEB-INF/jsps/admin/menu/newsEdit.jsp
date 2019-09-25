<%@ page language="java" import="java.util.*" pageEncoding="utf-8" contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title></title>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/images/favicon.ico" />
    <link href="${pageContext.request.contextPath}/css/css.css" type="text/css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/css/jquery-ui.min.css" type="text/css" rel="stylesheet" />

    <meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js" ></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-ui.min.js" ></script>
    <script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3_3-utf8-jsp/utf8-jsp/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3_3-utf8-jsp/utf8-jsp/ueditor.all.min.js"> </script>
    <script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3_3-utf8-jsp/utf8-jsp/lang/zh-cn/zh-cn.js"></script>

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
<body onselectstart="return false;" ondragstart="return false;" oncontextmenu="return false;">

    <table width="99%" border="0" cellspacing="0" cellpadding="0" id="searchmain">
        <tr>
            <%--<td width="99%" align="left" valign="top">您的位置：新闻公告&nbsp;&nbsp;>&nbsp;&nbsp;${titleName}</td>--%>
        </tr>
        <tr>
            <td align="left" valign="top">
                <form id = "ueditor" method="post" action="" onsubmit="return submitForm(this)">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" id="main-tab">
                        <tr>
                            <td align="right" valign="middle" class="borderright borderbottom bggray">*标题：</td>
                            <td align="left" valign="middle" class="borderright borderbottom main-for">
                                <input id="title" class="text-word" type="text" name="title" value="${oneNews.title}" required/>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" valign="middle" class="borderright borderbottom bggray">发表者：</td>
                            <td align="left" valign="middle" class="borderright borderbottom main-for">
                                <input id="publisher" class="text-word" type="text" name="publisher" value="${oneNews.publisher}"/>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" valign="middle" class="borderright borderbottom bggray">*发布时间：</td>
                            <td align="left" valign="middle" class="borderright borderbottom main-for">
                                <input id="createTime"  style="z-index:1000;position:relative;"  class="text-word" type="text" name="createTime" value="${oneNews.createTime}"/>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" valign="middle" class="borderright borderbottom bggray">关键词：</td>
                            <td align="left" valign="middle" class="borderright borderbottom main-for">
                                <c:forEach items="${keywords}" var="keyword" varStatus="status">
                                    <input class="text-word keywords" type="text" value="${keyword}"/>
                                </c:forEach>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" valign="middle" class="borderright borderbottom bggray">*内容：</td>
                            <td align="left" valign="middle" class="borderright borderbottom main-for">
                                <div id="editor" class="text-word" name ="content" type="text/plain" style="width:1024px;height:500px;"></div>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" valign="middle" class="borderright borderbottom bggray">&nbsp;</td>
                            <td align="left" valign="middle" class="borderright borderbottom main-for">
                                <input type="submit" value="提交" class="text-but" onfocus="this.blur()" onclick="return checkContent()"/>
                                <input id="reset" type="reset" value="重置" class="text-but"/>
                            </td>
                        </tr>
                    </table>
                </form>
            </td>
        </tr>
    </table>


<script type="text/javascript">

    $(function () {
            //绑定发布时间控件
            $("#createTime").datepicker({
                maxDate:new Date(),
                dateFormat:"yy-mm-dd",

            });
            var ue = UE.getEditor('editor');
            var id = '${oneNews.id}';
            setTimeout(function(){
                $.ajax({
                    url: '${pageContext.request.contextPath}/menu/newsContent.do',
                    data: {id: id, post: Math.random()},
                    type: "GET",
                    success: function(result){
                        ue.setContent(result);
                    },
                    error: function(){

                    }
                })
            }, 1000);

            $("#reset").click(function () {
                UE.getEditor('editor').setContent("")
            });
    });

    function submitForm(form){
        // 检查
        if(!checkContent()){
            return false;
        }
        // 获取关键词
        var keywords = [];
        $(".keywords").each(function(index, element){
            var keyword = $(this).val().trim();
            if(keyword != ""){
                keywords.push($(this).val());
            }
        });
        //获取图片的src
        var pics = null;
        var reg = /<img\b(?=(?:(?!src=).)*src=(['"]?)([^'"\s>]+)\1)[^>]*>/i;
        if(reg.test(UE.getEditor('editor').getContent())){
            pics = RegExp.$2;
        }
        //获取视频src
        var videos=null;
        var reg=/<video\b(?=(?:(?!src=).)*src=(['"]?)([^'"\s>]+)\1)[^>]*>/i;
        if(reg.test(UE.getEditor('editor').getContent())){
            videos = RegExp.$2;
        }
        //设置文章摘要（提取前30个文字）
        var summary = UE.getEditor('editor').getContentTxt().substr(0, 100);
        // 类型和文章id
        var type = 0, id = "";
        type = '${oneNews.type}';
        id = '${oneNews.id}';
        var data = {
            keywords: keywords,
            title: $("#title").val(),
            type: type,
            id: id,
            publisher: $("#publisher").val(),
            createTime:$("#createTime").val(),
            content: UE.getEditor('editor').getContent().trim(),
            pics: pics,
            summary: summary,
            videos:videos
        };

        $.ajax({
            url: '<c:url value='/menu/saveMenuContent.do'/>',
            type: "POST",
            data: JSON.stringify(data),
            dataType: 'json',
            contentType: "application/json; charset=utf-8",
            success: function(data){
                if ("SUCCESS" == data) {
                    if(!history) {
                        alert("提交成功");
                        form.reset();
                    }else {
                        self.location = document.referrer//后退刷新
                    }
                } else {
                    alert(data)
                }
            },
            error: function(err) {
                alert('提交失败！');
            }
        });
        return false;
    }

    function checkContent(){
        if($("#title").val().trim() == "") alert('标题不能为空！');
        if($("#createTime").val().trim() == "") alert('发布日期不能为空！');
        if(UE.getEditor('editor').getContent().trim() == "") alert('内容不能为空！');
        //获取图片的src
        var reg = /<img\b(?=(?:(?!src=).)*src=(['"]?)([^'"\s>]+)\1)[^>]*>/i;
        if(reg.test(UE.getEditor('editor').getContent())){
            //
            var pics = RegExp.$2;
            $("#pics").val(pics);
        }
        //设置文章摘要（提取前30个文字）
        $("#summary").val(UE.getEditor('editor').getContentTxt().substr(0, 100));
        return $("#title").val().trim() != "" && UE.getEditor('editor').getContent().trim() != "";

    }
</script>
</body>
</html>
