<!DOCTYPE html>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="cn.com.common.Counter" %>
<%@ page import="java.io.File" %>

<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
	<link rel="icon"
		  href="${pageContext.request.contextPath}/favicon.ico" type="image/x-icon" />
	<link rel="shortcut icon" href="${pageContext.request.contextPath}/favicon.ico" type="image/x-icon" />
	<title>上大出版社-首页</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/new_style/css/reset.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/new_style/css/main.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/new_style/css/swiper.min.css" />
</head>
<body>
<div class="container">
	<jsp:include page="header.jsp"></jsp:include>
	<div class="mainbody">
		<%--<div class="swiper-container">
			<div class="swiper-wrapper">
				<a class="swiper-slide" style="background: url(${pageContext.request.contextPath}/images/home/useByHome1.png) no-repeat center center;background-size:auto 100%;"></a>
				<a class="swiper-slide" style="background: url(${pageContext.request.contextPath}/images/home/useByHome2.png) no-repeat center center;background-size:auto 100%;"></a>
				<a class="swiper-slide" style="background: url(${pageContext.request.contextPath}/images/home/useByHome3.png) no-repeat center center;background-size:auto 100%;"></a>
				<a class="swiper-slide" style="background: url(${pageContext.request.contextPath}/images/home/useByHome4.png) no-repeat center center;background-size:auto 100%;"></a>
			</div>
			<div class="swiper-pagination"></div>
		</div>--%>
			<div id="slideBox" class="slideBox">
				<div class="hd">
					<ul><li></li><li></li><li></li><li></li></ul>
				</div>
				<div class="bd">
					<ul>
						<li style="background: url(${pageContext.request.contextPath}/images/home/useByHome1.png) no-repeat center center;background-size:auto 100%;"><a></a></li>
						<li style="background: url(${pageContext.request.contextPath}/images/home/useByHome2.png) no-repeat center center;background-size:auto 100%;"><a></a></li>
						<li style="background: url(${pageContext.request.contextPath}/images/home/useByHome3.png) no-repeat center center;background-size:auto 100%;"><a></a></li>
						<li style="background: url(${pageContext.request.contextPath}/images/home/useByHome4.png) no-repeat center center;background-size:auto 100%;"><a></a></li>
					</ul>
				</div>
			</div>
			<!--swiper-container-->

		<div class="section">
			<div class="section-title">
				<p>重点推荐</p>
				<span>KEY RECOMMENDATION</span>
			</div>
			<jsp:include page="nav2.jsp"/>
		</div>

			<div class="opera-list  bg-brown clearfix">
				<ul>
					<li>
						<a href="${pageContext.request.contextPath}/waiter.jsp"></a>
						<div class="opera-item icon-download">
							<p>数字出版</p>
							<span>DIGITAL PUBLISHING</span>
						</div>
					</li>
					<li>
						<a href="${pageContext.request.contextPath}${download.resourceUrl}" download="${download.resourceName}${fn:substringAfter(file.name,'.')}"></a>
						<div class="opera-item icon-publish">
								<p>下载目录</p>
								<span>DOWNLOAD DIRECTORY</span>
							</div>
					</li>
					<li>
						<a href="${pageContext.request.contextPath}/home/contact.do"></a>
						<div class="opera-item icon-submit">
							<p>欢迎来稿</p>
							<span>WELCOME TO CONTRIBUTE</span>
						</div>
					</li>
				</ul>
			</div>




		<div class="section">
			<div class="section-title">
				<p>新书上架</p>
				<span>NEW BOOK SHELVES</span>
			</div>

			<div class="book-imageflow-box clearfix">
				<div class="book-imageflow">
					<div id="LoopDiv">
						<input id="S_Num" type="hidden" value="${newBook.size()}" />
						<div id="starsIF" class="imageflow">
							<c:forEach items="${newBook}" var="book" varStatus="a">
							<img src="${pageContext.request.contextPath}${book.imageurl}" class="tt" showId="${a.index}" width="274" height="403" alt="Picture" />
							</c:forEach>
						</div>
					</div>
				</div>
				<div class="book-detail-box">
					<ul>
						<c:forEach items="${newBook}" var="book">
							<li>
								<span class="book-name">${book.bookName}</span>
								<p class="book-info-list">作 者：${book.author}</p>
								<p class="book-info-list">定 价：${book.price}</p>
								<p class="book-info-list">书 号：${book.isbn}</p>
								<p class="book-info-list">出版日期：${book.publicationDate}</p>
								<p class="book-info-list book-info">
										${book.editorial}
								</p>
								<p></p>

								<a class="book-more" href="${pageContext.request.contextPath}/home/bookDetail.do?id=${book.id}">查看更多</a>
							</li>
						</c:forEach>
					</ul>
				</div>
			</div>
		</div>

		<div class="bg-gray-02">
			<div class="section">
				<div class="section-title">
					<p>新闻中心</p>
					<span>NEW CENTER</span>
				</div>
				<div class="section-more clearfix"><a href="${pageContext.request.contextPath}/home/newsList.do">更多</a></div>

				<div class="video-box">
					<%
						String storeDirectoryAbs = request.getSession().getServletContext().getRealPath("/images/home/");
						File mp4 = new File(storeDirectoryAbs,"homenewsMedia"+".mp4");
						if (!mp4.exists()){
					%>
						<img class="videopic" src="${pageContext.request.contextPath}/images/home/homenewsMedia.t" />
					<% }else{ %>
					<video id="video" class="video" width='1200' height='322' controls="controls" >
						<source src="${pageContext.request.contextPath}/images/home/homenewsMedia.mp4"></source>
						<%--<source src="${pageContext.request.contextPath}/new_style/img/mov_bbb.ogg"></source>--%>
						Your browser does not support HTML5 video.
					</video >
					<% }%>
				</div>

				<div class="new-list clearfix">
					<ul>
						<c:forEach items="${latestNews}" begin="0" var="news" end="3">
							<li class="clearfix">
								<a href="${pageContext.request.contextPath}/home/systemdetail.do?id=${news.id}&homeType=home">
									<div class="clearfix">
									<div class="new-list-left">
									<p class="day">${news.createTime.toString().substring(8,10)}</p>
									<p class="date">${news.createTime.toString().substring(0,7)}</p>
								</div>
								<div class="new-list-right">
										<p class="new-title">${news.title}</p>
									<p class="new-info">${news.summary}</p>
								</div>
									</div>
								</a>
							</li>
						</c:forEach>
					</ul>
				</div>
			</div>
		</div>

		<div class="section clearfix">
			<div class="section-left">
				<div class="section-title pdr-70">
					<p>精彩书评</p>
					<span>BOOK REVIEW</span>
				</div>
				<div class="section-more pdr-70 clearfix"></div>
				<div class="review-list">
					<ul>
						<c:forEach items="${recommend}" var="command">
							<c:if test="${command.auditing!='improt_book_abcdefgh'}">
							<li>
								<p>${command.auditing}</p>
								<i>${command.bookName}</i>
							</li>
							</c:if>
						</c:forEach>
					</ul>
				</div>
			</div>
			<div class="section-right">
				<div class="section-title">
					<p>图书作家</p>
					<span>THE BOOK WRITER</span>
				</div>
				<div class="section-more clearfix"><a></a></div>
				<div class="writer-info">
					<img style="height: 255px" src="${pageContext.request.contextPath}/images/home/useByHome5.png" />
					<div class="writer-name clearfix">
						<span>${author.authorName}</span>
						<%--<i>${recommend.get(0).publicationDate}</i>--%>
					</div>
					<div class="writer-intro">${author.comment}</div>
				</div>

			</div>
		</div>
	</div><!--mainbody-->
	<jsp:include page="footer.jsp" />
</div>




<script type="text/javascript" src="${pageContext.request.contextPath}/new_style/js/jquery-1.8.0.min.js" ></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/new_style/js/jquery.SuperSlide.2.1.1.js" ></script>
<%--<script type="text/javascript" src="${pageContext.request.contextPath}/new_style/js/swiper.js" ></script>--%>

<script type="text/javascript" src="${pageContext.request.contextPath}/new_style/js/imageflow.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/new_style/js/main.js" ></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/new_style/js/gverify.js" ></script>

<script>


    //文字缩减
	$(".new-title").txtCur({n:20});
    $('.book-intro').txtCur({n:20});
    $('.new-info').txtCur({n:70});
    $('.writer-intro').txtCur({n:200});
    $('.book-info').txtCur({n:120});
    $('.book-title').txtCur({n:9});
    //视频播放
    $('.audio-icon').click(function(){
        $('.audio-icon').parent().addClass('play');
        $('#video')[0].play();
    });

    //轮播图
    jQuery(".slideBox").slide({mainCell:".bd ul",autoPlay:true,delayTime:700});

    /*$(function(){
        if(navigator.appName == 'Microsoft Internet Explorer'){
            $('.book-right-list li:nth-child(3n)').css('margin-right','0px');
            $('.code:last-child').css('margin-right','0px');
            $('.new-list li:nth-child(2n)').css('margin-right','0px');
            $('.opera-list li:last-child').css('margin-right','0px');
        }
    })*/

</script>
</body>
</html>