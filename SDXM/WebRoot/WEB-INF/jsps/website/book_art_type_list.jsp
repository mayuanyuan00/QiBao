<!DOCTYPE html>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  <link rel="icon"
        href="${pageContext.request.contextPath}/favicon.ico" type="image/x-icon" />
  <link rel="shortcut icon" href="${pageContext.request.contextPath}/favicon.ico" type="image/x-icon" />
  <title>图书专区二级</title>
  <!-- CSS -->
  <link href="${pageContext.request.contextPath}/new_style/css/reset.css" rel="stylesheet" type="text/css">
  <link href="${pageContext.request.contextPath}/new_style/css/main.css" rel="stylesheet" type="text/css">
  <link href="${pageContext.request.contextPath}/new_style/css/book-section.css" rel="stylesheet" type="text/css">
  <link href="${pageContext.request.contextPath}/new_style/css/swiper.min.css" rel="stylesheet" type="text/css">
  <style type="text/css">
    .ellipsis {
      overflow: hidden;
      text-overflow: ellipsis;
      white-space: nowrap;
    }
  </style>

  <%
    /// 这儿设置的是booktype的class名字，若第一级的booktype有更改，需要改此处
    Map<Integer, String> booktypeCls = new HashMap<Integer, String>();
    booktypeCls.put(12, "book_section_sub_nav_title_teach_material");//教材专著
    booktypeCls.put(13, "book_section_sub_nav_title_humanity");//人文社科
    booktypeCls.put(14, "book_section_sub_nav_title_art");//艺术类
    booktypeCls.put(15, "book_section_sub_nav_title_culture");//海派文化
    booktypeCls.put(18, "book_section_sub_nav_title_tool");//工具书
    booktypeCls.put(16, "book_section_sub_nav_title_school");//基础教育
    booktypeCls.put(17, "book_section_sub_nav_title_ancient");//古籍文献
    booktypeCls.put(19, "book_section_sub_nav_title_others");//其他
    request.setAttribute("booktypeCls", booktypeCls);
  %>
</head>

<body>
<%--<div class="container">--%>
  <%--<jsp:include page="header.jsp"/>--%>
  <%--<div class="mianbody">--%>
    <%--<div class="main_banner clearfix">--%>
      <%--<div class="main_banner_bg"></div>--%>
      <%--<div class="main_banner_inner clearfix w1200">--%>
        <%--<jsp:include page="nav.jsp"/>--%>
        <%--<div class="main_container">--%>
          <%--<c:choose>--%>
            <%--<c:when test="${empty errormsg}">--%>
              <%--<div class="main_container_content">--%>
                <%--<a href="javascript:void(0)" style="cursor: auto;">图书专区</a>--%>
                <%--<c:forEach items="${booktypes}" var="booktype">--%>
                  <%--<img src="${pageContext.request.contextPath}/websit_style/img/arrow_right2.jpg"--%>
                       <%--alt=""/>--%>
                  <%--<a href="#">${booktype.typeName}</a>--%>
                <%--</c:forEach>--%>
              <%--</div>--%>
              <%--<!--网页小目录-->--%>
              <%--<ul class="book_cover_list clearfix">--%>
                <%--<c:forEach items="${books.results}" var="book">--%>
                  <%--<li>--%>
                    <%--<div class="book_cover_BG"><a--%>
                        <%--href="${pageContext.request.contextPath}/home/bookDetail.do?id=${book.id}"><img--%>
                        <%--src="${pageContext.request.contextPath}${book.imageurl}"/></a>--%>
                    <%--</div>--%>
                    <%--<div class="book_cover_BG_right">--%>
                      <%--<h3>--%>
                        <%--<a href="${pageContext.request.contextPath}/home/bookDetail.do?id=${book.id}"--%>
                         <%--class="ellipsis" title="${book.bookName}">${book.bookName}</a>--%>
                      <%--</h3>--%>
                      <%--<p>作者：${book.author}</p>--%>
                      <%--<p>开本：${book.folio}</p>--%>
                      <%--<span>￥&nbsp<b>${book.price}</b></span>--%>
                    <%--</div>--%>
                    <%--<a href="${pageContext.request.contextPath}/home/bookDetail.do?id=${book.id}"--%>
                       <%--class="learn_more_btn">了解更多 +</a>--%>
                  <%--</li>--%>
                <%--</c:forEach>--%>
              <%--</ul>--%>
            <%--</c:when>--%>
            <%--<c:otherwise>--%>
              <%--<div>${errormsg}</div>--%>
            <%--</c:otherwise>--%>
          <%--</c:choose>--%>
          <%--<div class="back_btn">--%>
            <%--<a href="javascript:void(0)" onclick="goback()">返回</a>--%>
          <%--</div><!--返回按钮-->--%>
        <%--</div>--%>
      <%--</div><!--main_banner_inner-->--%>

    <%--</div>--%>

  <%--</div>--%>
  <%--<jsp:include page="footer.jsp"/>--%>
<%--</div>--%>
<div class="container">
  <jsp:include page="header.jsp"/>
  <div class="mainbody">
    <div class="book_section_banner">
    </div>
    <div class="book_section">
      <div class="active-box no-border">
        <a href="${pageContext.request.contextPath}/home/enter.do">首页</a>
        <a href="${pageContext.request.contextPath}/home/bookTypeList.do">图书专区</a>
        <c:forEach items="${parentTypes}" var="item">
          <c:if test="${item.id==ptype}">
            <a href="${pageContext.request.contextPath}/home/bookArtList.do?type=${item.id}">${item.typeName}</a>
          </c:if>
        </c:forEach>
      </div>
      <ul class="book_section_nav clearfix" id="bookNav">
        <li ><a href="${pageContext.request.contextPath}/home/bookTypeList.do">所有图书</a></li>
        <c:forEach items="${parentTypes}" var="item">
          <li id="${item.id}" class="<c:if test='${item.id==ptype}'>active</c:if>">
          <a href="${pageContext.request.contextPath}/home/bookArtList.do?ptype=${item.id}">${item.typeName}</a>
          </li>
        </c:forEach>
      </ul>

      <%--<jsp:include page="book_navigation.jsp"/>--%>



      <div class="book_section_content clearfix">
        <div class="book_section_left">
          <div class="${booktypeCls.get(ptype)}">
          <c:forEach  items="${parentTypes}" var="item" >
            <c:if test='${item.id==ptype}'>
              ${item.typeName}
            </c:if>
          </c:forEach>
          </div>
          <div class="book_section_sub_nav">
            <ul class="clearfix">
              <li title="${ptype}" class="swiper-slide    <c:if test='${jumpType==-1}'>active</c:if> ">所有</li>
              <c:forEach items="${showTypes}" var="item">
                <li title="${item.id}" class="swiper-slide  <c:if test='${jumpType!=-1 and jumpType==item.id}'>active</c:if>">${item.typeName}</li>
              </c:forEach>
              <%--<li class="swiper-slide active">艺术理论</li>--%>
              <%--<li class="swiper-slide">前沿艺术</li>--%>
              <%--<li class="swiper-slide">美术教材</li>--%>
              <%--<li class="swiper-slide">书法字帖</li>--%>
              <%--<li class="swiper-slide">书法教材</li>--%>
              <%--<li class="swiper-slide">纂刻艺术</li>--%>
              <%--<li class="swiper-slide">艺术设计</li>--%>
              <%--<li class="swiper-slide">建筑设计</li>--%>
              <%--<li class="swiper-slide">收藏鉴赏</li>--%>
              <%--<li class="swiper-slide">综合艺术</li>--%>
              <%--<li class="swiper-slide">音乐艺术</li>--%>
              <%--<li class="swiper-slide">画册</li>--%>
              <%--<li class="swiper-slide">其他</li>--%>
            </ul>
          </div>
        </div>
        <div class="book_section_right">
          <div class="book_section_sub_list">
            <div class="swiper-wrapper">
              <div class="swiper-slide">
                <ul class="clearfix">

                </ul>
              </div>
            </div>
          </div>
          <div class="page-box page-box-special">
            <ul>
              <li><a>上一页</a></li>
              <li><a>1</a></li>
              <li><a>2</a></li>
              <li><a>3</a></li>
              <li><a>下一页</a></li>
            </ul>
          </div>
        </div>
      </div>
    </div>
  </div><!--mainbody-->
  <jsp:include page="footer.jsp"/></div>

<script type="text/javascript" src="${pageContext.request.contextPath}/new_style/js/gverify.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/new_style/js/login.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/new_style/js/jquery-1.8.0.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/new_style/js/jquery.SuperSlide.2.1.1.source.logintab.js" ></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/new_style/js/swiper.js" ></script>
<script type="text/javascript">
//    $('.book_section_sub_list em').txtCur({n:18});

//    $('.book_section_sub_nav li').eq(0).addClass('active');
//    tabs('.book_section_sub_nav li','.book_section_sub_list','active');

    $(document).ready(function(){
        <c:if test="${jumpType==-1}">
        getbooks(${ptype},1,-1);
        </c:if>
        <c:if test="${jumpType!=-1}">
        getbooks(${jumpType},1,0);
        </c:if>
    });
    $(".book_section_sub_nav li").click(function () {
        $(this).addClass("active").siblings("li").removeClass("active");
        var type=$(this).attr("title");
        if($(this).html() == "所有") {
            getbooks(type,1,-1);
        }else {
            getbooks(type,1,0);
        }

    });

    function getbooks(type,page,jumpType) {
        $.ajax({
            url:"${pageContext.request.contextPath}/home/bookArtList/books.do?type="+type
                  +"&page="+page+"&jumpType="+jumpType,
            type:"get",
            success:function (data) {
                $(".book_section_sub_list").children().remove();
                $(".book_section_sub_list").prepend("<ul class='clearfix'></ul>");
                if(data.totalCount<1){
                    $(".book_section_sub_list ul").prepend('<span style="color: red">暂无数据</span>');
                }else {
                jQuery.each(data.results,function (i,book) {
                    $(".book_section_sub_list ul").append('<li>' +
                        '<a href="${pageContext.request.contextPath}/home/bookDetail.do?id='+book.id+'"></a>' +
                        '<div>' +
                        '<img src="'+book.imageurl+'" alt="" />' +
                        '</div>' +
                        '<em>'+book.bookName+'</em>' +
                        '<span>作者：'+book.author+'</span>' +
                        '<span>定价：'+toDecimal2(book.price)+'</span>' +
                        '</li>')
                });
                }

                var totolPage=Math.ceil(data.totalCount/data.pageSize);
                var str="<ul>";
                if(data.totalCount>0) {
                    if (totolPage < 6) {
                        if (page != 1) {
                            str += "<li><a style='cursor:pointer' onclick='getbooks(" + type + "," + (page - 1) + ","+jumpType+")'>上一页</a></li>";
                        }
                        for (var i = 1; i <= totolPage; i++) {
                            if (page == i) {
                                str += "<li class='on'><a style='cursor:pointer'  onclick='getbooks(" + type + "," + i + ","+jumpType+")'>" + i + "</a></li>";
                            } else {
                                str += "<li><a style='cursor:pointer' onclick='getbooks(" + type + "," + i + ","+jumpType+")'>" + i + "</a></li>";
                            }
                        }
                        if (page != totolPage) {
                            str += "<li><a style='cursor:pointer' onclick='getbooks(" + type + "," + (page + 1) + ","+jumpType+")'>下一页</a></li>";
                        }
                    } else {
                        if (page > 3) {
                            str += "<li><a style='cursor:pointer'  onclick='getbooks(" + type + "," + 1 + ","+jumpType+")'>首页</a></li>";
                        }
                        if (page != 1) {
                            str += "<li><a style='cursor:pointer'  onclick='getbooks(" + type + "," + (page - 1) + ","+jumpType+")'>上一页</a></li>";
                        }
                        if (page > 3) {
                            str += "<li><a >...</a></li>";
                        }
                        for (var j = page - 2; j <= page + 2; j++) {
                            if (page == j) {
                                str += "<li class='on'><a style='cursor:pointer'  onclick='getbooks(" + type + "," + j + +","+jumpType+")'>" + j + "</a></li>";
                            } else {
                                str += "<li><a style='cursor:pointer'  onclick='getbooks(" + type + "," + j + ","+jumpType+")'>" + j + "</a></li>";
                            }
                        }
                        if (page < totolPage - 3) {
                            str += "<li><a >...</a></li>";
                        }
                        if (page != totolPage) {
                            str += "<li><a style='cursor:pointer'  onclick='getbooks(" + type + "," + (page + 1) + ","+jumpType+")'>下一页</a></li>";
                        }
                        if (page < totolPage - 3) {
                            str += "<li><a style='cursor:pointer'  onclick='getbooks(" + type + "," + totolPage + ","+jumpType+")'>末页</a></li>";
                        }
                    }
                }
                str+="</ul>";

                $(".page-box-special").children().remove();
                $(".page-box-special").prepend(str);
            }
        })

    }

    function tabs(obj,swiperObj,className) {
            var tabSwiper = new Swiper(swiperObj, {
                effect : 'slide',//切换效果
                speed : 0, //滑动速度，单位ms
                autoHeight: true, // 高度随内容变化
                allowTouchMove:false, //鼠标拖动无效
                onSlideChangeStart : function() {
                    $(obj+"."+className).removeClass(className); /*有当前类名的删除类名,给下一个添加当前类名*/
                    $(obj).eq(tabSwiper.activeIndex).addClass(className);/*activeIndex是过渡后的slide索引*/
                }
            });
            // 模拟点击事件，如果是移入事件，将mousedown 改为 mouseenter
            $(obj).on('touchstart mousedown', function(e) {
                e.preventDefault();/*清除默认事件*/
                $(obj+"."+className).removeClass(className);
                $(this).addClass(className); /*点击当前导航 改变当前样式*/
                tabSwiper.slideTo($(this).index());/*滑动到对应的滑块*/
            });
            $(obj).click(function(e) {
                e.preventDefault();/*清除默认点击事件*/
            });
    }

//制保留2位小数，如：2，会在2后面补上00.即2.00
function toDecimal2(x) {
    var f = parseFloat(x);
    if (isNaN(f)) {
        return false;
    }
    var f = Math.round(x*100)/100;
    var s = f.toString();
    var rs = s.indexOf('.');
    if (rs < 0) {
        rs = s.length;
        s += '.';
    }
    while (s.length <= rs + 2) {
        s += '0';
    }
    return s;
}

</script>
</body>

</html>

