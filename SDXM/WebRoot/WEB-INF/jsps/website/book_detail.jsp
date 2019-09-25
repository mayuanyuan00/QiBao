<!DOCTYPE html>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <link rel="icon"
          href="${pageContext.request.contextPath}/favicon.ico" type="image/x-icon" />
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/favicon.ico" type="image/x-icon" />
    <title>上大出版社-图书详情</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/new_style/css/reset.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/new_style/css/main.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/new_style/css/book-section.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/new_style/css/swiper.min.css" />
</head>

<body>
<div class="container">
    <jsp:include page="header.jsp"/>
    <div class="mainbody">

        <div class="book_section">
            <div class="active-box no-border">
                <a href="${pageContext.request.contextPath}/home/enter.do">首页</a>
                <a href="${pageContext.request.contextPath}/home/bookTypeList.do">图书专区</a>
                <a href="${pageContext.request.contextPath}/home/bookArtTypeList.do?type=${type.id}">${type.typeName}</a>
            </div>
            <div class="book_section_detail clearfix">
                <div class="book_section_detail_left">
                    <div class="book_section_detail_picBig">
                        <img src="${pageContext.request.contextPath}${book.imageurl}" alt="" />
                    </div>
                </div>
                <div class="book_section_detail_right">
                    <h3>${book.bookName}</h3>
                    <p>作&emsp;&emsp;者： ${book.author}</p>
                    <p>书&emsp;&emsp;号： ${book.isbn}</p>
                    <p>出版日期： ${book.publicationDate}</p>
                    <p>价&emsp;&emsp;格： <strong>${book.price}</strong>元</p>
                    <div class="book_section_detail_num">数&emsp;&emsp;量
                        <input id="book_section_num_input" type="text" value="1" />
                        <div class="book_section_detail_num_btn">
                            <em class="add_btn"></em>
                            <em class="min_btn"></em>
                        </div>
                        本
                    </div>

                    <div class="book_section_detail_btn clearfix">
                        <div class="book_section_detail_btnBuy">
                            <span onclick="addToShopping(${book.id})">立即购买</span>
                        </div>
                        <div class="book_section_detail_btnAdd">
                            <span style="color: white" onclick="addToCart(${book.id})">加入购物车</span>
                        </div>
                    </div>

                    <div class="book_section_detail_content">
                        <ul class="clearfix">
                            <li class="swiper-slide active">内容简介</li>
                            <li class="swiper-slide">图书目录</li>
                            <li class="swiper-slide">编辑推荐</li>
                            <li class="swiper-slide">精彩书评</li>
                            <li class="swiper-slide">延伸阅读</li>
                        </ul>
                    </div>
                    <div class="book_section_detail_content_list">
                        <div class="swiper-wrapper">
                            <div class="swiper-slide">
                                <div class="swiper-slide-inner">
                                    <div style=" height: 90%;overflow: hidden;text-align: justify;">
                                        <p>${book.contentvalidity}</p>
                                    </div>
                                    <span class="showTextDetailClass">阅读更多</span>
                                </div>
                            </div>
                            <div class="swiper-slide">
                                <div class="swiper-slide-inner">
                                    <div style=" height: 90%;overflow: hidden;text-align: justify;">
                                    <p>${book.catalog}</p>
                                    </div>
                                    <span class="showTextDetailClass">阅读更多</span>
                                </div>
                            </div>
                            <div class="swiper-slide">
                                <div class="swiper-slide-inner">
                                    <div style=" height: 90%;overflow: hidden;text-align: justify;">
                                    <p>${book.editorial}</p>
                                    </div>
                                    <span class="showTextDetailClass">阅读更多</span>
                                </div>
                            </div>
                            <div class="swiper-slide">
                                <div class="swiper-slide-inner">
                                    <div style=" height: 90%;overflow: hidden;text-align: justify;">
                                    <p>${book.review}</p>
                                    </div>
                                    <span class="showTextDetailClass">阅读更多</span>
                                </div>
                            </div>
                            <div class="swiper-slide">
                                <div class="swiper-slide-inner">
                                    <div style=" height: 85%;overflow: hidden;text-align: justify;">
                                    <p>${book.extention}</p>
                                    </div>
                                    <span class="showTextDetailClass">阅读更多</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="book_section_recommend">
                <div class="book_section_recommend_title clearfix">
                    <p>相关推荐</p>
                    <a href="${pageContext.request.contextPath}/home/bookArtList.do?ptype=${type.id}">更多 >></a>
                </div>
                <ul class="book_section_rel_recommend_list clearfix">
                    <c:forEach items="${books.results}" var="book" begin="0" end="3">
                        <li>
                            <a href="${pageContext.request.contextPath}/home/bookDetail.do?id=${book.id}"></a>
                            <div>
                                <img src="${pageContext.request.contextPath}${book.imageurl}" alt="" />
                            </div>
                            <em>${book.bookName}</em>
                            <span>作者：${book.author}</span>
                            <span>定价：${book.price}元</span>
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </div>
    </div><!--mainbody-->
    <jsp:include page="footer.jsp"/>
</div>
<script type="text/javascript" src="${pageContext.request.contextPath}/new_style/js/jquery-1.8.0.min.js" ></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/new_style/js/pdfobject.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/new_style/js/main.js" ></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/new_style/js/swiper.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/websit_style/js/jquery.SuperSlide.2.1.1.source.js"></script>
    <script>
 //       $('.showTextDetailClass').click(function(){
 //           shade.pdfshade('${pageContext.request.contextPath}${book.extention}','${pageContext.request.contextPath}/n_style/js/generic/web/viewer.html');
 //       });
//        var boomessage=[];
//        $(function () {
//
//        });

        //详情切换
        jQuery(".book_tab").slide({trigger: "click"});
        //购买数量加减
        $('.icon_add').click(function () {
            var nownum = $('.book_num_input').text();
            if (nownum <= 999) {
                nownum++;
                $('.book_num_input').text(nownum);
            } else {
                alert('已达最大购买数量');
            }
        });
        $('.icon_minus').click(function () {
            var nownum = $('.book_num_input').text();
            if (nownum > 1) {
                nownum--;
                $('.book_num_input').text(nownum);
            } else {
                alert('不能减少');
            }
        });

        function addToShopping(id){
        	
        	<c:if test="${empty sessionScope.user}">
	            alert("请先登陆");
	            return false;
            </c:if>
            <c:if test="${not empty sessionScope.user}">
	            var amount = $(".book_section_detail_num :input").val();
	         	amount = amount < 1 ? 1:amount;
            $.post("${pageContext.request.contextPath}/cart/add.do",
                {itemid:id,amount:amount},function(result){
                    if(result == "success"){
                        window.location.href = "${pageContext.request.contextPath}/cart/shoppingcart.do";
                    }
                });
            <%--window.location.href = "${pageContext.request.contextPath}/order/directcommit.do?itemid="+id+"&count="+amount;--%>
            </c:if>
        }
        
        function addToCart(id){
        	<c:if test="${empty sessionScope.user}">
	            alert("请先登陆");
	            return false;
            </c:if>
            <c:if test="${not empty sessionScope.user}">
	            var amount = $(".book_section_detail_num :input").val();
	         	amount = amount < 1 ? 1:amount;
	        	$.post("${pageContext.request.contextPath}/cart/add.do",
						{itemid:id,amount:amount},function(result){
							if(result == "success"){
								alert("购物车添加成功");
							}
				});
            </c:if>
         	
        }
            $('.book_section_rel_recommend_list em').txtCur({n:18});
        //图片切换
        $('.book_section_detail_left li').mouseover(function(){
            var src = $(this).children('img').attr('src');
            $('.book_section_detail_picBig img').attr('src', src);
        });

        //购买数量加减
        $('.add_btn').click(function(){
            var num = +$(this).parent().prev().val();
            if(num < 99){
                num++;
            }else{
                alert('不能再增加了');
            }
            $(this).parent().prev().val(num);
        });
        $('.min_btn').click(function(){
            var num = +$(this).parent().prev().val();
            if(num > 1){
                num--;
            }else{
                alert('不能再减少了');
            }
            $(this).parent().prev().val(num);
        });

        //tab切换
        /*$('.book_section_detail_content li').eq(0).addClass('active');
        tabs('.book_section_detail_content li','.book_section_detail_content_list','active');

        function tabs(obj,swiperObj,className) {
            var tabSwiper = new Swiper(swiperObj, {
                effect : 'slide',//切换效果
                speed : 0, //滑动速度，单位ms
                autoHeight: true, // 高度随内容变化
                allowTouchMove:false, //鼠标拖动无效
                onSlideChangeStart : function() {
                    $(obj+"."+className).removeClass(className); /!*有当前类名的删除类名,给下一个添加当前类名*!/
                    $(obj).eq(tabSwiper.activeIndex).addClass(className);/!*activeIndex是过渡后的slide索引*!/
                }
            });
            // 模拟点击事件，如果是移入事件，将mousedown 改为 mouseenter
            $(obj).on('touchstart mousedown', function(e) {
                e.preventDefault();/!*清除默认事件*!/
                $(obj+"."+className).removeClass(className);
                $(this).addClass(className); /!*点击当前导航 改变当前样式*!/
                tabSwiper.slideTo($(this).index());/!*滑动到对应的滑块*!/
            });
            $(obj).click(function(e) {
                e.preventDefault();/!*清除默认点击事件*!/
            });
        }*/
$('.book_section_detail_content li').click(function(){
    var liindex = $(this).index();
    if(liindex == 4){
        shade.pdfshade('${pageContext.request.contextPath}${book.extention}','${pageContext.request.contextPath}/new_style/js/generic/web/viewer.html');
        return;
    }
    $(this).addClass('active').siblings('li').removeClass('active');
    $('.book_section_detail_content_list .swiper-slide').eq(liindex).show().siblings('.swiper-slide').hide();
});


$(".showTextDetailClass").click(function () {
            var str=$(this).parent().prop("outerHTML");
           str=str.replace('<span class="showTextDetailClass">阅读更多</span>',"");
           var title=$(".book_section_detail_content ul").children(".active").html();
//           str=str.replace("<span","<p");
//            str=str.replace("</span>","</p>");
            shade.bookIntro(title,str);
        });

    </script>
</body>

</html>

