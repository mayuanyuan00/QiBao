<%@ page language="java" import="java.util.*" pageEncoding="utf-8" %>
<%@ page import="java.io.File" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    String storeDirectoryAbs = request.getSession().getServletContext().getRealPath("/images/home/");
    File mp4 = new File(storeDirectoryAbs,"homenewsMedia"+".mp4");

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>左侧导航menu</title>
    <link href="${pageContext.request.contextPath}/css/css.css" type="text/css" rel="stylesheet"/>
    <link href="${pageContext.request.contextPath}/css/jquery.searchableSelect.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/sdmenu.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script  type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.searchableSelect.js"></script>
    <script src="${pageContext.request.contextPath}/ckeditor/ckeditor.js"></script>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/images/favicon.ico"/>
    <link href="${pageContext.request.contextPath}/css/css.css" type="text/css" rel="stylesheet"/>
    <style>
        body {
            overflow-x: hidden;
            background: #f2f0f5;
            padding: 15px 0px 10px 5px;
        }

        .borderright {
            border-right: 1px solid #ebebeb
        }

        .borderbottom {
            border-bottom: 1px solid #ebebeb
        }

        .bggray {
            background: #f9f9f9;
            font-size: 14px;
            font-weight: bold;
            padding: 10px 10px 10px 0;
            width: 120px;
        }

        .main-for {
            background: #f9f9f9;
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

        #searchmain {
            font-size: 12px;
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


        #addinfo {
            padding: 0 0 10px 0;
        }

        .file-form {
            box-sizing: border-box;
            margin-bottom: 1em;
            margin-top: 0;
            text-align: center;
            font-family: 'Raleway', sans-serif;
            font-weight: 300;
            font-size: 1em;
        }

        .imgBox {
           text-align: left;
        }

        .imgArea {
            max-width: 100%;
            max-height: 450px;
            opacity: 1;
            width: auto;
            height: auto;

        }
        .imgArea2 {
            max-width: 100%;
            max-height: 300px;
            opacity: 1;
            width: auto;
            height: auto;

        }
    </style>
</head>
<body onselectstart="return false;" ondragstart="return false;" >
<!--main_top-->
<table width="99%" border="0" cellspacing="0" cellpadding="0" id="searchmain">
    <tr>
        <td width="99%" align="left" valign="top" id="addinfo"> <font size="4" color="red" ><b>首页轮播图片管理</b></font></td>
    </tr>
    <tr class="_edit">
        <td align="left" valign="top">
            <table  border="0" cellspacing="0" cellpadding="0" id="main-tab">
                <%--<tr>
                    <th align="center" valign="middle" style="width: 30%" class="borderright"></th>
                    <th align="center" valign="middle" style="width: 70%" class="borderright"></th>
                </tr>--%>
                    <tr>
                        <td  class="borderright borderbottom bggray">
                            <div style="box-sizing: border-box;">
                                <p></p>
                                <strong style="font-weight: bold;">请选择图片1(png格式,建议比例为1920*600)</strong>
                                <p></p>
                                <input type="file" class="file-form" onchange="return selectFile(this,1);"
                                       style="max-width: 80%; margin: 0;">
                                <p></p>
                            </div>
                        </td>
                        <td>
                            <div class="imgBox">
                                <img id="imageArea1" class="imgArea2" src="">
                            </div>
                        </td>
                    </tr>
                <tr>
                    <td  class="borderright borderbottom bggray">
                        <div style="box-sizing: border-box;">
                            <p></p>
                            <strong style="font-weight: bold;">请选择图片2(png格式,建议比例为1920*600)</strong>
                            <p></p>
                            <input type="file" class="file-form" onchange="return selectFile(this,2);"
                                   style="max-width: 80%; margin: 0;">
                            <p></p>
                        </div>
                    </td>
                    <td>
                        <div class="imgBox">
                        <img id="imageArea2" class="imgArea2" src="">
                        </div>
                    </td>
                </tr>

                    <tr>
                        <td  class="borderright borderbottom bggray">
                            <div style="box-sizing: border-box;">
                                <p></p>
                                <strong style="font-weight: bold;">请选择图片3(png格式,建议比例为1920*600)</strong>
                                <p></p>
                                <input type="file" class="file-form" onchange="return selectFile(this,3);"
                                       style="max-width: 80%; margin: 0;">
                                <p></p>
                            </div>
                        </td>
                        <td>
                            <div class="imgBox">
                                <img id="imageArea3" class="imgArea2" src="">
                            </div>
                        </td>
                    </tr>

                    <tr>
                        <td  class="borderright borderbottom bggray">
                            <div style="box-sizing: border-box;">
                                <p></p>
                                <strong style="font-weight: bold;">请选择图片4(png格式,建议比例为1920*600)</strong>
                                <p></p>
                                <input type="file" class="file-form" onchange="return selectFile(this,4);"
                                       style="max-width: 80%; margin: 0;">
                                <p></p>
                            </div>
                        </td>
                        <td>
                            <div class="imgBox">
                                <img id="imageArea4" class="imgArea2" src="">
                            </div>
                        </td>
                    </tr>

            </table>
        </td>
    </tr>
    
    <tr class="_edit">
        <td >
            <table width="100%"  border="0" cellspacing="0" cellpadding="0"  id="hotTable">
                <tr>
                    <th width="30%" height="50" colspan="3" align="left">
                       		 <font size="4" color="red" >首页作者管理</font>
                    </th>

                </tr>
                <tr>
                    <td class="borderright borderbottom bggray">
                        <span>热门作者</span>
                    </td>
                    <td class="borderright borderbottom main-for">
                        <input class="hotBookName" value="${recommend.get(0).authorName}"/>
                    </td>
                    <td class="borderright borderbottom main-for">
                        <textarea rows="10" cols="50" id="recommend0" onkeyup="totalCharSize('wordCount',0,200)"><c:if test="${not empty recommend.get(0) and recommend.get(0) .comment!=''}">${recommend.get(0).comment}</c:if></textarea>
                        <div>已输入 <a id="wordCount0" style="color: green"><font>0</font></a>个字符。最多可填写200个字符</div>
                    </td>
                </tr>
                <tr>
                    <td class="borderright borderbottom bggray">
                        <div style="box-sizing: border-box;">
                            <p></p>
                            <strong style="font-weight: bold;">作者图片(png)</strong>
                            <p></p>
                            <input type="file" class="file-form" onchange="return selectFile(this,5);"
                                   style="max-width: 80%; margin: 0;">
                            <p></p>
                        </div>
                    </td>
                    <td class="borderright borderbottom bggray">
                        <div class="imgBox" >
                            <img id="imageArea5" class="imgArea" src="">
                        </div>
                    </td>
                     <td class="borderright borderbottom bggray">

                    </td>
                </tr>
                <tr>
                    <td  height="50" colspan="3">
                    <button  class="btn1 hotAuthorSubmit" onclick="">热门作者提交</button>

                    </td>
                </tr>
                <tr>
                    <th  height="50" colspan="3" align="left" >
                       		<font size="4" color="red" >精彩书评管理</font>
                    </th>

                </tr>
                <c:forEach begin="2" end="5" step="1" varStatus="status">
                    <tr>
                      <td class="borderright borderbottom bggray">
                          <span>精彩书评${status.index-1}</span>
                      </td>
                        <td class="borderright borderbottom main-for">
                            <select class="type-select" id="selectHot${status.index}" >
                                <c:forEach items="${books}" var="book">
                                        <option value="${book.id}"
                                                <c:if test="${not empty recommend.get(status.index-1) and recommend.get(status.index-1).hotBook==book.id}">selected</c:if>>
                                                ${book.bookName}
                                        </option>
                                </c:forEach>
                            </select>
                            <script type="application/javascript">
                                $(function () {
                                    $("#selectHot${status.index}").searchableSelect();
                                });
                            </script>
                        </td>
                        <td class="borderright borderbottom main-for">
                        <textarea rows="10" cols="50" id="recommend${status.index}" onkeyup="totalCharSize('wordCount',${status.index},100)"><c:if test="${not empty recommend.get(status.index-1) and recommend.get(status.index-1) .comment!=''}">${recommend.get(status.index-1).comment}</c:if></textarea>

                            <div>已输入 <a id="wordCount${status.index}" style="color: green"><font>0</font></a>个字符。最多可填写100个字符</div>
                        </td>
                    </tr>
                 </c:forEach>
                <tr>
                    <td height="50" colspan="3">
                        <button  class="btn1"  onclick="submitHot()">精彩书评提交</button>
                    </td>
                </tr>
                <tr>
                    <th width="30%" height="50" colspan="3" align="left" >
                       		<font size="4" color="red" >图书重点推荐管理</font>
                    </th>

                </tr>
                <c:forEach   begin="1" end="6" step="1" varStatus="status">
                    <tr>
                        <td class="borderright borderbottom bggray">
                            <span>重点推荐${status.index}</span>
                        </td>
                        <td class="borderright borderbottom main-for" colspan="2">
                            <select class="type-select" id="selectImportant${status.index}">
                                <option value="0"
                                        <c:if test="${not empty recommend.get(status.index+4) and recommend.get(status.index+4).hotBook==book.id}">selected</c:if>
                                >不选择</option>
                                <c:forEach items="${books}" var="book">
                                    <option value="${book.id}"
                                            <c:if test="${not empty recommend.get(status.index+4) and recommend.get(status.index+4).hotBook==book.id}">selected</c:if>
                                    >
                                            ${book.bookName}
                                    </option>
                                </c:forEach>
                            </select>
                            <script type="application/javascript">
                                $(function () {
                                    $("#selectImportant${status.index}").searchableSelect();
                                });
                            </script>
                        </td>
                    </tr>
                </c:forEach>
                 <tr>
                    <td height="50" colspan="3">
                        <button  class="btn1 import_book_submit" >重点推荐提交</button>
                    </td>
                </tr>
            </table>
        </td>
    </tr>


    <tr>
        <th width="30%" height="50" colspan="3" align="left" >
            <font size="4" color="red" >首页新闻媒体栏</font>
        </th>

    </tr>
    <tr class="_edit">
        <td align="left" valign="top">
            <table  border="0" cellspacing="0" cellpadding="0" id="main-tab">
                <tr>
                    <td  class="borderright borderbottom bggray">
                        <div style="box-sizing: border-box;">
                            <p></p>
                            <strong style="font-weight: bold;">请选择</strong>
                            <p></p>
                            <input type="file" class="file-form" onchange="return selectFile2(this);"
                                   style="max-width: 80%; margin: 0;">
                            <p></p>
                        </div>
                    </td>
                    <td>
                        <div class="imgBox">
                            <div id="newsmediaimg" style="display: none">
                                <img id="imageAreanews" class="imgArea2" src="">
                            </div>
                            <div id="newsmediavideo" style="display: none">

                            </div>
                        </div>
                    </td>
                </tr>
            </table>
        </td>
    </tr>


</table>



<script type="text/javascript">

    $(".import_book_submit").click( function submitImportantBook() {
        var recommends=[];
        for(var i=1;i<7;i++){
            var temp={
                id:i+6,
                hotBook:$("#selectImportant"+i).val(),
                comment:"improt_book_abcdefgh",
                authorName:""
            };
           
            for(var j=i+1;j<7;j++){
            	if($("#selectImportant"+j).val()!="0"||$("#selectImportant"+i).val()!="0"){
	            	if($("#selectImportant"+j).val()===$("#selectImportant"+i).val()){
	            		alert("热门推荐的图书重复！");
	            		return false;
	            	}
            	}
            }
            recommends.push(temp);
        }
     
        
        $.ajax({
                url:"${pageContext.request.contextPath}/home/setRecommend.do",
                type:"post",
                contentType:"application/json",
                data:JSON.stringify(recommends),
                traditional: true,
                success:function (data) {
                    alert(data);
                }
            }
        );
    });

    $(".hotAuthorSubmit").click(function () {
        var recommends=[];
        var temp={
            id:1,
            hotBook:1,
            comment:encodeURI($("#recommend0").val()),
            authorName:encodeURI($(".hotBookName").val())
        };
        recommends.push(temp);
        $.ajax({
                url:"${pageContext.request.contextPath}/home/setRecommend.do",
                type:"post",
                contentType:"application/json",
                data:JSON.stringify(recommends),
                traditional: true,
                success:function (data) {
                    alert(data);
                }
            }
        );

    });

    function submitHot() {
        var recommends=[];
       for(var i=2;i<6;i++){
           var temp={
               id:i,
               hotBook:$("#selectHot"+i).val(),
               comment:encodeURI($("#recommend"+i).val()),
               authorName:""
           };
           
           for(var j=i+1;j<6;j++){
        	   if($("#selectHot"+j).val()===$("#selectHot"+i).val()){
        		   alert("精彩书评的图书重复！");
        		   return false;
        	   }
           }
           recommends.push(temp);
       }
      
            $.ajax({
                    url:"${pageContext.request.contextPath}/home/setRecommend.do",
                    type:"post",
                    contentType:"application/json",
                    data:JSON.stringify(recommends),
                    traditional: true,
                    success:function (data) {
                        alert(data);
                    }
                }
            );
    }

    function totalCharSize(to,str, num) {
        var obj= $("#recommend"+str);
        if (obj.val().length > num) {
            alert("不能超过"+num+"个字");
            obj.val(obj.val().substring(0, num));
            $("#"+to+str).html( "<font>"+num+"</font>");
        } else {
            $("#"+to+str).html( "<font>"+obj.val().length+"</font>");
        }
    }

    $(document).ready(function () {
        var array = "${sessionScope.authority}";
        if(!isContains(array,"3")){
            $('._edit').hide();
        }
        for (var i=1;i<6;i++){
         $("#imageArea"+i).css('width', 'auto');
         $("#imageArea"+i).css('height', 'auto');
         $("#imageArea"+i).attr("src", "${pageContext.request.contextPath}/images/home/useByHome"+i+".png");
        }

        if(<%=mp4.exists()?"true":"false" %>){
            appenvideo();
        }else{
            showimg();
        }
        totalCharSize('wordCount',0, 200);
        for (var j=2;j<6;j++) {
            totalCharSize('wordCount',j, 200);
        }
    });
    function isContains(str, substr) {
        return str.indexOf(substr) >= 0;
    }

    function selectFile(input,name) {
        if (input.files && input.files[0]) {
            console.log('in select file!!');
            var reader = new FileReader();
            $('#centerDiv').show();
            $('#url').val('http://');
            reader.readAsDataURL(input.files[0]);
            var formData = new FormData();
            formData.append("file", input.files[0]);
            $.ajax({
                url: '${pageContext.request.contextPath}/home/saveImages.do?fileName='+name,
                type: "POST",
                data: formData,
                processData: false, contentType: false,
                beforeSend: function () {
                },
                success: function (responseStr) {
                    if(responseStr=='success'){
                        $("#imageAreanews").attr("src", reader.result);
                        alert("上传成功");
                    }else {
                        alert(responseStr);
                    }
                },
                error: function (responseStr) {
                    console.log("error");
                }
            })
        }
    }


    function selectFile2(input) {
        if (input.files && input.files[0]) {
            console.log('in select file!!');
            var reader = new FileReader();
            $('#centerDiv').show();
            $('#url').val('http://');
            reader.readAsDataURL(input.files[0]);
            var filename = input.files[0].name;
            var suffix = filename.substring(filename.lastIndexOf("."));
            var formData = new FormData();
            formData.append("file", input.files[0]);
            $.ajax({
                url: '${pageContext.request.contextPath}/home/saveNewMedia.do',
                type: "POST",
                data: formData,
                processData: false, contentType: false,
                beforeSend: function () {
                },
                success: function (responseStr) {
                    if(responseStr=='success'){
                        if (suffix.toLowerCase() !=".mp4"){
                            showimg();
                        }else {
                            appenvideo();
                        }
                        alert("上传成功");
                    }else {
                        alert(responseStr);
                    }
                },
                error: function (responseStr) {
                    console.log("error");
                }
            })
        }
    }
    
    function appenvideo() {
        var url = "${pageContext.request.contextPath}/images/home/homenewsMedia.mp4";
        var node = "<video  class=\"video\" width='1200' height='322' controls=\"controls\"><source type=\"video/mp4\" id = \"videoAreanews\" src=\""+url+"\"></source>Your browser does not support HTML5 video.</video >";
        $("#newsmediavideo").empty();
        $("#newsmediavideo").append(node);
        $("#newsmediavideo").show();
        $("#newsmediaimg").hide();
    }

    function showimg() {
        $("#imageAreanews").attr("src", "${pageContext.request.contextPath}/images/home/homenewsMedia.t?v="+Math.random());
        $("#newsmediavideo").hide();
        $("#newsmediaimg").show();
    }
</script>
</body>

</html>
