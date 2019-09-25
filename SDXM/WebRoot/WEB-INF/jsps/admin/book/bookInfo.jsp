<%@ page language="java" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <title>图书管理</title>
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
    #preview_wrapper{
      display:inline-block;
      width:300px;
      height:300px;
      background-color:#CCC;
    }
    #preview_fake{
      filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale);
    }
    #preview_size_fake{
      filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=image);
      visibility:hidden;
    }
    #preview{
      width:300px;
      height:300px;
    }
    .bookfooter{
        height: 80px;
        width: 100%;
        background-color: #ebebeb;
        z-index: 9999;
        position: fixed;
        text-align: center;
        padding-left: 500px;
        bottom: 0;
    }
    .bookfooter input.text-but {
        width: 100px;
        height: 40px;
        line-height: 30px;
        border: 1px solid #cdcdcd;
        background: #e6e6e6;
        font-family: "Microsoft YaHei", "Tahoma", "Arial", '宋体';
        color: #969696;
        float: left;
        margin: 20px 10px 0 0;
        display: inline;
        cursor: pointer;
        font-size: 14px;
        font-weight: bold;
    }

  </style>
</head>
<body onselectstart="return false;" ondragstart="return false;">
<form method="post" action="" onsubmit="return submitForm(this);">
<table width="99%" border="0" cellspacing="0" cellpadding="0" id="searchmain">
  <tr>
    <td width="99%" align="left" valign="top">您的位置：图书管理&nbsp;&nbsp;>&nbsp;&nbsp;添加图书</td>
  </tr>

  <tr>
    <td align="left" valign="top">

        <input type="hidden" name="id" id="bookid"/>

      <table width="100%" border="0" cellspacing="0" cellpadding="0" id="main-tab" >
          <tr>
            <td align="right" valign="middle" class="borderright borderbottom bggray">*图书名称：</td>
            <td align="left" valign="middle" class="borderright borderbottom main-for">
              <input type="text" name="bookName" id="bookname" class="text-word" required>
            </td>
          </tr>
          <tr>
            <td align="right" valign="middle" class="borderright borderbottom bggray">*价格：</td>
            <td align="left" valign="middle" class="borderright borderbottom main-for">
              <input type="number"  step="0.01" name="price" id="price" value="" class="text-word" required/>
            </td>
          </tr>
          <tr>
            <td align="right" valign="middle" class="borderright borderbottom bggray">图书类型：</td>
            <td align="left" valign="middle" class="borderright borderbottom main-for">
              <select class="type-select" id="type1" onchange="changetype(this)">
                <option value="0">&nbsp;&nbsp;请选择</option>
                <c:forEach var="booktype" items="${types}">
                  <option value="${booktype.id}">&nbsp;&nbsp;${booktype.typeName}</option>
                </c:forEach>
              </select>
            </td>

          </tr>
          <tr>
            <td align="right" valign="middle" class="borderright borderbottom bggray">新书发布：</td>
            <td align="left" valign="middle" class="borderright borderbottom main-for">
              <input type="radio" name="isNew" value="1">是
              <input type="radio" name="isNew" value="0" checked>否
            </td>
          </tr>
          <tr>
            <td align="right" valign="middle" class="borderright borderbottom bggray">封面图片：</td>
            <td>
              <table>
                <tr>
                <td align="left" valign="middle" class="borderright borderbottom main-for">
                  <input type="file" name="image" style="color:transparent;"  onchange="checkImage(this,'')"/>
                  <div id="imgDiv" style="display: none;">
                    <img id="pimg" width='120px' height='100px' src="${pageContext.request.contextPath}${book.imageurl}" alt=""/>
                  </div>
                </td>
                <td valign="middle">
                  <!--以下是预览图片用的-->
                  <div id="imgPreview" style='width:120px; height:150px;display:none;'>
                    预览：<img id="img1" src="" width="120" height="100" />
                  </div>
                  <div id="outerdiv" style="position:fixed;top:0;left:0;background:rgba(0,0,0,0.7);z-index:999;width:100%;height:100%;display:none;"><div id="innerdiv" style="position:absolute;"><img id="bigimg" style="border:5px solid #fff;" src="" /></div></div>
                </td>
               </tr>
              </table>
            </td>
          </tr>
          <tr>
            <td align="right" valign="middle" class="borderright borderbottom bggray">作者图片：</td>
            <td>
              <table>
                <tr>
                  <td align="left" valign="middle" class="borderright borderbottom main-for">
                    <input type="file" name="authorImage" style="color:transparent;"  onchange="checkImage(this,'_a')"/>
                    <div id="imgDiv_a" style="display: none;">
                      <img id="pimg_a" width='120px' height='100px' src="${pageContext.request.contextPath}${book.authorImg}" alt=""/>
                    </div>
                  </td>
                  <td valign="middle">
                    <!--以下是预览图片用的-->
                    <div id="imgPreview_a" style='width:120px; height:150px;display:none;'>
                      预览：<img id="img1_a" src="" width="120" height="100" />
                    </div>
                    <div id="outerdiv_a" style="position:fixed;top:0;left:0;background:rgba(0,0,0,0.7);z-index:999;width:100%;height:100%;display:none;"><div id="innerdiv_a" style="position:absolute;"><img id="bigimg_a" style="border:5px solid #fff;" src="" /></div></div>
                  </td>
                </tr>
              </table>
            </td>
          </tr>
          <tr>
            <td align="right" valign="middle" class="borderright borderbottom bggray">电子书：</td>
            <td align="left" valign="middle" class="borderright borderbottom main-for">
              <input type="hidden" name="ebookurl" id="ebookurl">
              <div id="ebookurlUploader">
                <div class="btns">
                  <div id="picker">选择文件</div>
                </div>
                <!--用来存放文件信息-->
                <div id="thelist" class="uploader-list">
                </div>
              </div>
            </td>
          </tr>
          <tr>
            <td align="right" valign="middle" class="borderright borderbottom bggray">*作者：</td>
            <td align="left" valign="middle" class="borderright borderbottom main-for">
              <input type="text" name="author" id="author" class="text-word" required>
            </td>
          </tr>
          <tr>
            <td align="right" valign="middle" class="borderright borderbottom bggray">ISBN：</td>
            <td align="left" valign="middle" class="borderright borderbottom main-for">
              <input type="text" name="isbn" id="isbn" class="text-word" >
            </td>
          </tr>
          <tr>
            <td align="right" valign="middle" class="borderright borderbottom bggray">出版社：</td>
            <td align="left" valign="middle" class="borderright borderbottom main-for">
              <input type="text" name="press" id="press" class="text-word">
            </td>
          </tr>
          <tr>
            <td align="right" valign="middle" class="borderright borderbottom bggray">*出版时间：</td>
            <td align="left" valign="middle" class="borderright borderbottom main-for">
              <input type="text" name="publicationDate" id="publicationDate" class="text-word"
                     required onblur="checkFormat(this,'#publicationDateInfo')" placeholder="样例：2016-10-24 或 2016-10">
              <span id="publicationDateInfo" style="display: none;color: red;">格式错误，样例：2016-10-24 或 2016-10</span>
              <script>
                  function checkFormat(ele, infoId) {
                      var _ele = $(ele);
                      var value = _ele.val();
                      var infoEle = $(infoId);
                      infoEle.css('display', 'none');
                      if (value) {
                          if (!/^[1-9][0-9]{3}-[0-9]{1,2}(-[0-9]{1,2})?$/.test(value)) {
                              ele.focus();
                              infoEle.css("display",'');
                          }
                      }
                  }
              </script>
            </td>
          </tr>
          <tr>
            <td align="right" valign="middle" class="borderright borderbottom bggray">版本：</td>
            <td align="left" valign="middle" class="borderright borderbottom main-for">
              <input type="text" name="revision" id="revision" class="text-word">
            </td>
          </tr>
          <tr>
            <td align="right" valign="middle" class="borderright borderbottom bggray">页数：</td>
            <td align="left" valign="middle" class="borderright borderbottom main-for">
              <input type="text" name="pages" id="pages" class="text-word">
            </td>
          </tr>
          <tr>
            <td align="right" valign="middle" class="borderright borderbottom bggray">字数：</td>
            <td align="left" valign="middle" class="borderright borderbottom main-for">
              <input type="text" name="wordcount" id="wordcount" class="text-word">
            </td>
          </tr>
          <tr>
            <td align="right" valign="middle" class="borderright borderbottom bggray">印次：</td>
            <td align="left" valign="middle" class="borderright borderbottom main-for">
              <input type="text" name="impression" id="impression" class="text-word">
            </td>
          </tr>
          <tr>
            <td align="right" valign="middle" class="borderright borderbottom bggray">开本：</td>
            <td align="left" valign="middle" class="borderright borderbottom main-for">
              <input type="text" name="folio" id="folio" class="text-word">
            </td>
          </tr>
          <tr>
            <td align="right" valign="middle" class="borderright borderbottom bggray">印张：</td>
            <td align="left" valign="middle" class="borderright borderbottom main-for">
              <input type="text" name="sheet" id="sheet" class="text-word">
            </td>
          </tr>
          <tr>
            <td align="right" valign="middle" class="borderright borderbottom bggray">内容简介：</td>
            <td align="left" valign="middle" class="borderright borderbottom main-for">
              <!--<textarea name="contentvalidity" id="contentvalidity" ></textarea>-->
              <div id="editor" name="contentvalidity" type="text/plain"
                   style="width:1024px;height:500px;"></div>
            </td>
          </tr>
          <tr>
            <td align="right" valign="middle" class="borderright borderbottom bggray">目录：</td>
            <td align="left" valign="middle" class="borderright borderbottom main-for">
              <div id="catalogEditor" name="catalog" type="text/plain"
                   style="width:1024px;height:500px;"></div>
            </td>
          </tr>
          <tr>
            <td align="right" valign="middle" class="borderright borderbottom bggray">编辑推荐：</td>
            <td align="left" valign="middle" class="borderright borderbottom main-for">
              <textarea name="editorial" id="editorial" class="text-word" style="width:1000px;height:500px;"></textarea>
            </td>
          </tr>
          <tr>
            <td align="right" valign="middle" class="borderright borderbottom bggray">精彩书评：</td>
            <td align="left" valign="middle" class="borderright borderbottom main-for">
              <!--<textarea name="contentvalidity" id="contentvalidity" ></textarea>-->
              <div id="reviewEditor" name="review" type="text/plain"
                   style="width:1024px;height:500px;"></div>
            </td>
          </tr>
          <tr>
            <td align="right" valign="middle" class="borderright borderbottom bggray">延伸阅读：</td>
            <td align="left" valign="middle" class="borderright borderbottom main-for">
                <input type="file" name="extentionpdf" style="color:transparent;"  onchange="checkPDF(this,'')"/> 文件大小不能超过10M
            </td>
          </tr>
          <tr>
            <td align="right" valign="middle" class="borderright borderbottom bggray">作者简介：</td>
            <td align="left" valign="middle" class="borderright borderbottom main-for">
              <div id="authorIntroEditor" name="authorIntro" type="text/plain"
                   style="width:1024px;height:500px;"></div>
            </td>
          </tr>
          <tr>
            <td align="right" valign="middle" class="borderright borderbottom bggray">试读章节：</td>
            <td align="left" valign="middle" class="borderright borderbottom main-for">
              <div id="sampleChaptersEditor" name="sampleChapters" type="text/plain"
                   style="width:1024px;height:500px;"></div>
            </td>
          </tr>

        </table>

    </td>
  </tr>
  <tr>

    <td align="left" valign="middle" class="borderright borderbottom main-for">

    </td>
  </tr>
</table>
    <div class="bookfooter" >
        <div id="editDiv">
        <input type="submit" value="提交" class="text-but"/>
        <input id="reset" type="reset" value="重置" class="text-but"/>
        </div>
        <div id="auditingBtn" style="display: none;">
            <input type="button"  value="审核通过" onclick="return auditingBook(${book.id},'1')" class="text-but"/>
            <input type="submit"  value="审核不通过" onclick="return auditingBook(${book.id},'2')" class="text-but"/>
        </div>
    </div>
</form>
<script>
    var ue = UE.getEditor('editor');
    var catalogEditor = UE.getEditor("catalogEditor");
    var authorIntroEditor = UE.getEditor("authorIntroEditor");
    var sampleChaptersEditor = UE.getEditor("sampleChaptersEditor");
    var reviewEditor = UE.getEditor("reviewEditor");
    //var extentionEditor = UE.getEditor("extentionEditor");
</script>
<!--初始化表单数据-->
<c:if test="${not empty book}">
  <script type="text/javascript">
      $(document).ready(function () {
          $.ajax({
              url: "${pageContext.request.contextPath}/book/bookIntro.do",
              data: {bookId: ${book.id}},
              type: "GET",
              success: function (data) {
                  setTimeout(function () {
                      ue.setContent(data.intro || "");
                      catalogEditor.setContent(data.catalog ||"");
                      authorIntroEditor.setContent(data.authorIntro||"");
                      sampleChaptersEditor.setContent(data.sampleChapters||"");
                      reviewEditor.setContent(data.review||"");
                      //extentionEditor.setContent(data.extention||"");
                      $("#editorial").val(data.editorial||"");
                  }, 1000);
              },
              error: function (error) {
              }
          });
          $("#imgDiv").show();
          $("#pimg").click(function(){
              var _this = $(this);//将当前的pimg元素作为_this传入函数
              imgShow("#outerdiv", "#innerdiv", "#bigimg", _this);
          });
          $("#imgDiv_a").show();
          $("#pimg_a").click(function(){
              var _this = $(this);//将当前的pimg元素作为_this传入函数
              imgShow("#outerdiv_a", "#innerdiv_a", "#bigimg_a", _this);
          });

          $("#bookid").val(${book.id});
          $("#bookname").val("${book.bookName}");
          $("#price").val("${book.price}");
          $("#author").val("${book.author}");
          $("#isbn").val("${book.isbn}");
          $("#press").val("${book.press}");
          $("#publicationDate").val("${book.publicationDate}");
          $("#revision").val("${book.revision}");
          $("#pages").val("${book.pages}");
          $("#wordcount").val("${book.wordcount}");
          $("#impression").val("${book.impression}");
          $("#folio").val("${book.folio}");
          $("#sheet").val("${book.sheet}");
          $("input[name='isNew'][value='${book.isNew?'1':'0'}']").attr("checked", 'checked');
          //判断审核状态
          <c:choose>
            <c:when test="${book.auditing eq 0 && opType eq 0}">
                $("#editDiv").hide();
                $("#auditingBtn").show();
            </c:when>
            <c:when test="${(book.auditing eq 1 || book.auditing eq 3) && opType eq 0}">
                $("#editDiv").hide();
            </c:when>
            <c:when test="${book.auditing eq 2 && opType eq 0}">
                $("#editDiv").hide();
                $("#auditingBtn").show();
            </c:when>
          </c:choose>


          ///设置Type
          <c:if test="${not empty superType}">
          var myNum=1;
          var _types = JSON.parse("${superType}");
          for(var j=0;j<_types.length;j++){
              if((j+1)%3 != 1){
                  if(myNum==1){
                      $("#type1").val(_types[j]);
                  }
                  if(myNum!=1&&myNum%2){
                      var newid = "type" + myNum;
                      var add_tr = $(' <tr>\n' +
                          '<td align="right" valign="middle" class="borderright borderbottom bggray"></td></tr>');
                      var add_td = $('<td align="left" valign="middle" class="borderright borderbottom main-for"></td>');
                      var new_select = $('<select class="type-select" id="'+newid+'" onchange="changetype(this)"></select>');
                      var add_ele_option = $(' <option value="0">&nbsp;&nbsp;请选择</option>\n' +
                          '<c:forEach var="booktype" items="${types}">\n' +
                          '<option value="${booktype.id}">&nbsp;&nbsp;${booktype.typeName}</option>\n' +
                          '</c:forEach>');
                      new_select.append(add_ele_option);
                      add_td.append(new_select);
                      add_tr.append(add_td);
                      $('#type'+(myNum-2)).parent().parent().after(add_tr);
                      $('#'+newid).val(_types[j]);
                  }
                  if(myNum!=1&&myNum%2==0){
                      getType(_types[j-1],myNum,_types[j],_types.length);
                  }
                  myNum++;
              }
          }
          </c:if>
          function getType(val,myNum,myVal,myLength) {
              $.get('<c:url value="/book/typeof.do"/>?parent=' + val, function (result) {
                          var newid = "type" + myNum;
                          var ele_new_select = $('<select class="type-select" id="'+newid+'" onchange="changetype(this)"></select>');
                          $('#type'+(myNum-1)).parent().append(ele_new_select);
                          if((myLength-(myNum/2))==myNum){
                              var addnewid = "add_ele" +(myNum-1);
                              var add_img = $('<img id="add_ele" class="add_ele" onclick="addEle(this)" src="${pageContext.request.contextPath}/images/main/addinfoblack.jpg" alt=""> '
                                  .replace("add_ele",addnewid))[0];
                              $('#type'+(myNum-1)).parent().append(add_img);
                          }
                          setOption($("#" + newid), JSON.parse(result));
                          $('#'+newid).val(myVal);

              })
          }
      })
  </script>

</c:if>
<script type="text/javascript">

    var BASE_URL = "http://" + location.host + "/${pageContext.request.contextPath}";
    $(function () {

        var infoEle = $("#thelist");
        var uploader = WebUploader.create({
            // swf文件路径
            swf: BASE_URL + '/css/Uploader.swf',
            server: BASE_URL + "/upload/file.do",
            pick: {id: "#picker", multiple: false},
            chunked: true,
            chunkSize: 2000000,
            fileNumLimit: 1
        });
        uploader.on('fileQueued', function (file) {
            //上传文件
            uploader.upload(file)
        });
        uploader.on('startUpload', function () {
            infoEle.html("正在上传，请稍后....");
            var ele_picker = $("#picker");
//            ele_picker.css("display", "none");
            ele_picker.find("input:file").attr('name', "");
        });
        uploader.on('uploadProgress', function (file, percentage) {
            infoEle.html("已上传文件" + file.name + "   " + Math.ceil(percentage * 100) + "%")
        });
        uploader.on("uploadSuccess", function (file, response) {
            response = response._raw;
            if (response == "系统错误") {
                infoEle.html("系统错误");
                $("#picker").css("display", "");
                return
            }
            infoEle.html(
                '<span>' +
                '<span>文件上传成功aaaa</span>'.replace("aaaa", file.name) +
                '<a href="${pageContext.request.contextPath}/aaaa" target="_blank">下载文件</a>'.replace('aaaa', response) +
                '<a class="removeFile" href="javascript:void(0)" style="margin-left:1rem;">移除</a>' +
                '</span>');
            infoEle.find(".removeFile").click(function () {
                uploader.removeFile(uploader.getFiles()[0], true);
                $("#ebookurl").val('');
                infoEle.html("");
                $("#picker").css("display", "");
            });
            $("#ebookurl").val(response);
        });
        uploader.on("uploadError", function (file, reason) {
            alert("上传失败，错误码：" + reason);
            $("#picker").css("display", "");
        });
        <c:if test="${not empty book}">
        var bookURL = "${book.ebookurl}";
        if (bookURL) {
            var bookname = bookURL.split("/");
            if (bookname.length == 0) return;
            bookname = bookname[bookname.length - 1];
            var ele_picker = $("#picker");
//            ele_picker.css("display", "none");
            ele_picker.find("input:file").attr('name', "");
            infoEle.html(
                '<span>' +
                '<span>文件上传成功aaaa</span>'.replace("aaaa", bookname) +
                '<a href="${pageContext.request.contextPath}/aaaa" target="_blank">下载文件</a>'.replace('aaaa', bookURL) +
                '<a class="removeFile" href="javascript:void(0)" style="margin-left:1rem;">移除</a>' +
                '</span>');
            infoEle.find(".removeFile").click(function () {
                $("#ebookurl").val('');
                infoEle.html("");
//                $("#picker").css("display", "");
            });
        }
        </c:if>
    });
    $("#reset").click(function () {
        ue.setContent("");
        catalogEditor.setContent("");
        authorIntroEditor.setContent("");
        sampleChaptersEditor.setContent("");
        reviewEditor.setContent("");
        //extentionEditor.setContent("");
    });

    //多级级联菜单
    function changetype(ele, callback) {
        ele = $(ele);
        var ele_id = ele.attr('id');
        var level = parseInt(ele_id.substr(ele_id.length - 1, 1));
        var val = $(ele).val();
        if(level%2){
            if (val && val != '0') {//不是选择的请选择
                $.get('<c:url value="/book/typeof.do"/>?parent=' + val, function (result) {
                    if (result && result != '[]') {
                        var newid = "type" + (level + 1);
                        setOption($("#" + newid));
                        var ele_new_select = $('<select class="type-select" id="nameid" onchange="changetype(this)"></select>'
                            .replace("nameid", newid))[0];
                        if($('.add_ele')!=null){
                            $('.add_ele').remove();
                        }
                        var addnewid = "add_ele" +level;
                        var add_img = $('<img id="add_ele" class="add_ele" onclick="addEle(this)" src="${pageContext.request.contextPath}/images/main/addinfoblack.jpg" alt=""> '
                            .replace("add_ele",addnewid))[0];
                        $(ele).parent().append(ele_new_select);
                        $(ele).parent().append(add_img);
                        setOption($("#" + newid), JSON.parse(result));
                    } else {
                        setOption($("#type" + (level + 1)))
                    }
                    callFun(callback)
                })
        }else {//选中的是请选择
                setOption($("#type" + (level + 1)))
            }
        }
    }

    //设置select的选项
    function setOption(ele, opts) {
        ele = $(ele);
        if (ele.length == 0) return;
        if (opts) {
            ele.html('<option value="0">&nbsp;&nbsp;请选择</option>');
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
        var formdata = new FormData(form);
        var ele_sel_last = $(".type-select:last-of-type");
        var typevulue = "";
        var le = 0;
        ele_sel_last.each(function () {
            /*if ($(this).val() == "0") {
                //alert("请选择图书类型！");
                return false;
            }*/
            if ($(this).val() != "0"){
                typevulue = typevulue + $(this).val() + ",";
            }
        });
        typevulue = typevulue.substr(0,typevulue.length-1);

        if($(".type-select:last-of-type").length==1){
            if(typevulue==0){
                alert("请选择图书类型！");
                return false;
            }
        }

        formdata.append("type", typevulue);
        $.ajax({
            url: '<c:url value="/book/upsert.do"/>',
            type: 'POST',
            cache: false,
            data: formdata,
            processData: false,
            contentType: false,
            success: function (data) {
                if ("SUCCESS" == data) {
                    if (!history) {
                        alert("上传成功");
                        form.reset();
                        $(".type-select").each(function (idx, ele) {
                            if (ele.id != 'type1') $(ele).remove();
                        })
                    } else {
                        self.location = document.referrer//后退刷新
                    }
                } else {
                    alert(data)
                }
            }
        });
        return false;
    }

    function callFun(func, param) {
        if (func) func(param);
    }

    function checkImage(imgFile,str) {
        var filextension=imgFile.value.substring(imgFile.value.lastIndexOf("."),imgFile.value.length);
        filextension=filextension.toLowerCase();
        if ((filextension!='.jpg')&&(filextension!='.gif')&&(filextension!='.jpeg')&&(filextension!='.png')&&(filextension!='.bmp'))
        {
            alert("对不起，系统仅支持标准格式的照片，请您调整格式后重新上传，谢谢 !");
            imgFile.focus();
        }
        else
        {
            var path;
            if(document.all)//IE
            {
                imgFile.select();
                path = document.selection.createRange().text;
                $("#imgPreview").show();
                document.getElementById("imgPreview"+str).innerHTML="";
                document.getElementById("imgPreview"+str).style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(enabled='true',sizingMethod='scale',src=\"" + path + "\")";//使用滤镜效果
            }
            else//FF
            {
                path=window.URL.createObjectURL(imgFile.files[0]);// FF 7.0以上
                //path = imgFile.files[0].getAsDataURL();// FF 3.0
                $("#"+"imgPreview"+str).show();

                document.getElementById("imgPreview"+str).innerHTML = "<img id='img1'+"+str+" width='120px' height='100px' src='"+path+"'/>";
                $("#img1"+str).click(function(){
                    var _this = $(this);//将当前的pimg元素作为_this传入函数
                    imgShow("#outerdiv"+str, "#innerdiv"+str, "#bigimg"+str, _this);
                });
            }
        }
    }



    function checkPDF(pdfFile,str) {
        var filextension=imgFile.value.substring(imgFile.value.lastIndexOf("."),imgFile.value.length);
        filextension=filextension.toLowerCase();
        if ((filextension!='.pdf'))
        {
            alert("对不起，系统仅支持标准格式的照片，请您调整格式后重新上传，谢谢 !");
            pdfFile.focus();
        }
    }


    function addEle(e) {
        var e1 = $(e);
        var ele_id = e1.attr('id');
        var level = parseInt(ele_id.substr(ele_id.length - 1, 1));
        var add_tr = $(' <tr>\n' +
                      '<td align="right" valign="middle" class="borderright borderbottom bggray"></td></tr>');
        var add_td = $('<td align="left" valign="middle" class="borderright borderbottom main-for"></td>');
        var add_ele_select = $('<select class="type-select" id="type'+(level+2)+'"  onchange="changetype(this)"></select>');
        var add_ele_option = $(' <option value="0">&nbsp;&nbsp;请选择</option>\n' +
                            '<c:forEach var="booktype" items="${types}">\n' +
                            '<option value="${booktype.id}">&nbsp;&nbsp;${booktype.typeName}</option>\n' +
                            '</c:forEach>');
        add_ele_select.append(add_ele_option);
        add_td.append(add_ele_select);
        add_tr.append(add_td);
        $(e).parent().parent().after(add_tr);
        $(e).hide();
    }

    function imgShow(outerdiv, innerdiv, bigimg, _this){
        var src = _this.attr("src");//获取当前点击的pimg元素中的src属性
        $(bigimg).attr("src", src);//设置#bigimg元素的src属性

        /*获取当前点击图片的真实大小，并显示弹出层及大图*/
        $("<img/>").attr("src", src).load(function(){
            var windowW = $(window).width();//获取当前窗口宽度
            var windowH = $(window).height();//获取当前窗口高度
            var realWidth = this.width;//获取图片真实宽度
            var realHeight = this.height;//获取图片真实高度
            var imgWidth, imgHeight;
            var scale = 0.8;//缩放尺寸，当图片真实宽度和高度大于窗口宽度和高度时进行缩放

            if(realHeight>windowH*scale) {//判断图片高度
                imgHeight = windowH*scale;//如大于窗口高度，图片高度进行缩放
                imgWidth = imgHeight/realHeight*realWidth;//等比例缩放宽度
                if(imgWidth>windowW*scale) {//如宽度扔大于窗口宽度
                    imgWidth = windowW*scale;//再对宽度进行缩放
                }
            } else if(realWidth>windowW*scale) {//如图片高度合适，判断图片宽度
                imgWidth = windowW*scale;//如大于窗口宽度，图片宽度进行缩放
                imgHeight = imgWidth/realWidth*realHeight;//等比例缩放高度
            } else {//如果图片真实高度和宽度都符合要求，高宽不变
                imgWidth = realWidth;
                imgHeight = realHeight;
            }
            $(bigimg).css("width",imgWidth);//以最终的宽度对图片缩放

            var w = (windowW-imgWidth)/2;//计算图片与窗口左边距
            var h = (windowH-imgHeight)/2;//计算图片与窗口上边距
            $(innerdiv).css({"top":h, "left":w});//设置#innerdiv的top和left属性
            $(outerdiv).fadeIn("fast");//淡入显示#outerdiv及.pimg
        });

        $(outerdiv).click(function(){//再次点击淡出消失弹出层
            $(this).fadeOut("fast");
        });
    }
    function auditingBook(bookid,state) {
        $.get("<c:url value="/book/auditingBook.do"/>?bookId=" + bookid+"&state="+state, function(result){
            debugger;
            window.history.back(-1);
        });
        //debugger;
        //this.location.href = "<c:url value="/book/auditingBook.do"/>?bookId=" + bookid+"&state="+state;
        //return false;
    }
    function isContains(str, substr) {
        return str.indexOf(substr) >= 0;
    }
</script>
</body>

</html>
