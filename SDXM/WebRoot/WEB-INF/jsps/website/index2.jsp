<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="cn.com.common.Counter" %>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <title>首页</title>
        <!-- CSS -->   
        <link  href="${pageContext.request.contextPath}/new_style/css/reset.css" rel="stylesheet" type="text/css">
        <link  href="${pageContext.request.contextPath}/new_style/css/main.css" rel="stylesheet" type="text/css">
        <link  href="${pageContext.request.contextPath}/new_style/css/book_detail2.css" rel="stylesheet" type="text/css">
		<style>
			.slide_picture {
				display: block;
				width: 200px;
				height: 300px;
				float: left;
			}
			.slide_picture img {
				width: 193px;
				height: 131px;
			}
		</style>
    </head>
<% 
	//if(session.isNew())
	//{
		//Counter.incTodayCounter();
	//}
%>

   <body>
  <%--  今日访问量：<%=Counter.getTodayNum() %><br/>
      总的访问量: <%=Counter.getTotalNum() %> --%>
		<div class="container">
			<jsp:include page="header.jsp"></jsp:include>
			<div class="mianbody">
				<div class="main_banner clearfix">
					<div class="main_banner_bg"></div>
					<div class="main_banner_inner clearfix w1200" >
						<jsp:include page="nav.jsp"/><!--main_banner_nav-->
						<div class="main_banner_pic">
							<img src="${pageContext.request.contextPath}/images/home/useByHome2.jpg" />
							<img src="${pageContext.request.contextPath}/images/home/useByHome1.jpg" />
							<img src="${pageContext.request.contextPath}/images/home/useByHome4.jpg" />
							<img src="${pageContext.request.contextPath}/images/home/useByHome3.jpg" />
						</div>
					</div><!--main_banner_inner-->
				</div><!--main_banner-->
				<c:if test="${not empty hotBook}">
				<div class="main_outer bg_white pt150">
					<div class="main_inner">
						<div class="book_title hot_title">
							<p>热 门 推 荐</p>
							<span>RECOMMEND</span>
						</div>
						<div class="hotbook_list">
							<div class="hd">
								<%--<a class="next"></a>--%>
								<ul></ul>
								<%--<a class="prev"></a>--%>
								<span class="pageState"></span>
							</div>
							<div class="bd">
								<ul class="picList clearfix">
									<c:forEach items="${hotBook}" begin="0" end="3" step="1" var="t">
										<li>
											<a href="${pageContext.request.contextPath}/home/bookDetail.do?id=${t.id}"></a>
											<div class="pic"><img src="${pageContext.request.contextPath}${t.imageurl}"/></div>
											<div class="title">${t.bookName}</div>
										</li>
									</c:forEach>
								</ul>
								<c:if test="${hotBook.size() >4}">
								<ul class="picList clearfix">
									<c:forEach items="${hotBook}" begin="4" end="7" step="1" var="t">
										<li>
											<a href="${pageContext.request.contextPath}/home/bookDetail.do?id=${t.id}"></a>
											<div class="pic"><img src="${pageContext.request.contextPath}${t.imageurl}" alt=""/></div>
											<div class="title">${t.bookName}</div>
										</li>
									</c:forEach>
								</ul>
								</c:if>
							</div>
						</div><!--hotbook_list-->
						<c:if test="${hotBook.size()>=8}">

						</c:if>
					</div><!--main_inner-->
				</div><!--main_outer-->
				</c:if>
				<c:if test="${not empty newBook}">
				<div class="main_outer bg_gray border_bottom">
					<div class="main_inner">
						<div class="book_title newbook_title">
							<p>新 书 上 架</p>
							<span>NEW  BOOK  RECOMMENDATION</span>
						</div>
						<div class="newbook_list">
							<ul>
								<c:forEach items="${newBook}" var="book"  begin="0" step="1" end="8">
									<li><a href="${pageContext.request.contextPath}/home/bookDetail.do?id=${book.id}"><img src="${pageContext.request.contextPath}${book.imageurl}"/></a></li>
								</c:forEach>
							</ul>
						</div>
						<div class="newbook_slide">
							<div class="hd">
								<a class="next"></a>
								<ul></ul>
								<a class="prev"></a>
								<span class="pageState"></span>
							</div>
							<div class="bd">
								<div class="ulWrap">
									<c:forEach items="${newBook}" begin="0" step="12" varStatus="statue">
										<ul>
											<c:forEach items="${newBook}" var="book"  begin="${statue.index}" step="1" end="${statue.index+11}">
												<li>
												<a href="${pageContext.request.contextPath}/home/bookDetail.do?id=${book.id}"></a>
												<div class="pic">
													<img src="${pageContext.request.contextPath}${book.imageurl}"/>
													<span>￥<i>${book.price}</i></span>
												</div>
												</li>
											</c:forEach>
										</ul>
									</c:forEach>
								</div><!-- ulWrap End -->
							</div><!-- bd End -->
						</div><!--newbook_slide-->
						
					</div><!--main_inner-->
				</div><!--main_outer  bg_gray-->
				</c:if>
				<div class="main_outer bg_gray pd100">
					<div class="main_inner">
						<ul class="buy_list clearfix">
							<li><img src="${pageContext.request.contextPath}/websit_style/img/bug_pic.png"/></li>
							<li>
								<a href="#"></a>
								<p>当当网</p>
								<span>shupress.taobao.com</span>
							</li>
							<li>
								<a href="#"></a>
								<p>天猫</p>
								<span>shupress.taobao.com</span>
							</li>
							<li>
								<a href="#"></a>
								<p>京东</p>
								<span>shupress.taobao.com</span>
							</li>
						</ul>
					</div><!--main_inner-->
				</div><!--main_outer bg_gray pd100-->
				<div class="main_outer bg_orange pd0 clearfix">
					<div class="new_nav">
						<ul>
							<li class="on"><a>社 内 公 告</a></li>
							<li><a>重 要 活 动</a></li>
							<li><a>我 社 风 采</a></li>
						</ul>
					</div><!--new_nav-->
					<div class="news_list_box">
						<div class="new_list show">
							<ul>
								<c:if test="${not empty news1}">
									<c:forEach items="${news1}" var="t">
										<li>
											<a href="${pageContext.request.contextPath}/news/detail.do?id=${t.id}&type=${t.type}&page=-1">	</a>
											<p class="news_time">${t.createTime}</p>
											<p class="news_title">${t.title}</p>
										</li>
									</c:forEach>
								</c:if>
								<c:if test="${empty news1}">
									<li>
										<p class="news_detail">填充文字未提供就为了好看</p>
									</li>
									<li>
										<p class="news_detail">填充文字未提供就为了好看</p>
									</li>
									<li>
										<p class="news_detail">填充文字未提供就为了好看</p>
									</li>
									<li>
										<p class="news_detail">填充文字未提供就为了好看</p>
									</li>
									<li>
										<p class="news_detail">填充文字未提供就为了好看</p>
									</li>

								</c:if>
							</ul>
						</div>
						<div class="new_list">
							<ul>
								<c:if test="${not empty news2}">
									<c:forEach items="${news2}" var="t">
										<li>
											<a href="${pageContext.request.contextPath}/news/detail.do?id=${t.id}&type=${t.type}&page=-1">	</a>
												<p class="news_time">${t.createTime}</p>
												<p class="news_title">${t.title}</p>

										</li>
									</c:forEach>
								</c:if>
								<c:if test="${empty news2}">
									<li>
										<p class="news_detail">填充文字未提供就为了好看</p>
									</li>
									<li>
										<p class="news_detail">填充文字未提供就为了好看</p>
									</li>
									<li>
										<p class="news_detail">填充文字未提供就为了好看</p>
									</li>
									<li>
										<p class="news_detail">填充文字未提供就为了好看</p>
									</li>
									<li>
										<p class="news_detail">填充文字未提供就为了好看</p>
									</li>
								</c:if>
							</ul>
						</div>
						<div class="new_list">
							<ul>
								<c:if test="${not empty news3}">
									<c:forEach items="${news3}" var="t">
										<li>
											<a href="${pageContext.request.contextPath}/news/detail.do?id=${t.id}&type=${t.type}&page=-1">	</a>
											<p class="news_time">${t.createTime}</p>
											<p class="news_title">${t.title}</p>
										</li>
									</c:forEach>
								</c:if>
								<c:if test="${empty news3}">
									<li>
										<p class="news_detail">填充文字未提供就为了好看</p>
									</li>
									<li>
										<p class="news_detail">填充文字未提供就为了好看</p>
									</li>
									<li>
										<p class="news_detail">填充文字未提供就为了好看</p>
									</li>
									<li>
										<p class="news_detail">填充文字未提供就为了好看</p>
									</li>
									<li>
										<p class="news_detail">填充文字未提供就为了好看</p>
									</li>
								</c:if>
							</ul>
						</div>
						
					</div><!--news_list_box-->
					<div class="new_tab">
						<div class="new_tab_box">
							<div class="hd">
								<ul><li>01</li><li>02</li><li>03</li></ul>
							</div>
							<div class="bd">
								<ul>
									<c:if test="${not empty news4}">
										<c:forEach items="${news4}" var="t">
											<li>

												<a class="slide_picture" href="${pageContext.request.contextPath}/news/detail.do?id=${t.id}&type=${t.type}&page=-1">
												<%--<c:if test="${t.content.length()>200}">${t.content.substring(0,200)}......</c:if>--%>
													<img src="${pageContext.request.contextPath}${t.pics}" alt="" />
												<%--<c:if test="${t.content.length()<=200}">${t.content}</c:if>--%>${t.summary}......
												</a>
											</li>
										</c:forEach>
									</c:if>
								</ul>
							</div>
							<!-- 下面是前/后按钮代码，如果不需要删除即可 -->
							<a class="prev" href="javascript:void(0)"></a>
							<a class="next" href="javascript:void(0)"></a>
						</div>
					</div>
				</div><!--main_outer bg_orange pd0 clearfix-->
				<div class="main_outer bg_pic">
					<div class="contact_box clearfix">
						<div class="contact_leftbox">
							<div class="map_box" id="allmap"></div>
							<div class="contact_inner">
								<div class="contact_title">联系我们</div>
								<p>地址：上海市宝山区上大路99号</p>
								<p>邮编：200444</p>
								<p>电话：66135122 66136211</p>
								<ul class="code_list clearfix">
									<li>
										<img src="${pageContext.request.contextPath}/websit_style/img/code.png" />
										<span>微博</span>
									</li>
									<li>
										<img src="${pageContext.request.contextPath}/websit_style/img/code.png" />
										<span>微信</span>
									</li>
								</ul>
							</div>
							
						</div><!--contact_leftbox-->
						<div class="contact_rightbox">
							<div class="contact_right_title"><img src="${pageContext.request.contextPath}/websit_style/img/contact_pic.png"/></div>
							<div class="contact_detail clearfix">
								<input type="text" class="contact_input w250" placeholder="您的姓名"/>
								<input type="text" class="contact_input w250 ml50"  placeholder="您的电话"/>
								<input id="message" type="text" class="contact_input w550" placeholder="您想说的..."/>
							</div>
							<span class="contact_btn" style="cursor: hand;">提 交</span>
						</div>
					</div><!--contact_box-->
				</div><!--main_outer bg_pic-->
			</div>
				<jsp:include page="footer.jsp"></jsp:include>
		</div>
		<jsp:include page="login.jsp"></jsp:include>
		<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=wil0NU4tz8qZrAiKdYPMgeh6fKhSBuFo"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/websit_style/js/jquery.SuperSlide.2.1.1.source.js" ></script>

		<script>
			jQuery(".hotbook_list").slide({titCell:".hd ul",mainCell:".bd ul",autoPage:true,effect:"left",scroll:4,vis:4});
			jQuery(".newbook_slide").slide({titCell:".hd ul",mainCell:".bd .ulWrap",autoPage:true,effect:"leftLoop",vis:1,autoPlay:true});
			jQuery(".new_tab_box").slide({mainCell:".bd ul",autoPlay:true,trigger:"click"});
			//列表切换
			$('.new_nav li').click(function(){
                $(this).addClass('on').siblings().removeClass('on');
                var liindex = $(this).index();
                $('.new_list:eq('+liindex+')').addClass('show').siblings().removeClass('show');
            });
			//地图
			// 百度地图API功能
			var map = new BMap.Map("allmap");
			var point = new BMap.Point(116.331398,39.897445);
			map.centerAndZoom(point,12);
			// 创建地址解析器实例
			var myGeo = new BMap.Geocoder();
			// 将地址解析结果显示在地图上,并调整地图视野
			myGeo.getPoint("上海市宝山区上大路99号", function(point){
				if (point) {
					map.centerAndZoom(point, 16);
					map.addOverlay(new BMap.Marker(point));
				}else{
					alert("您选择地址没有解析到结果!");
				}
			}, "北京市");


            $(".contact_input.w250.ml50").keyup(
			    function () {
			        var pattern=/^\d{7,11}$/g;
			        if(pattern.test($(this).val())){
                        $(this).css("color","#333");
					}else {
			            $(this).css("color","red");
					}
                }
			);

            $(".contact_btn").click(function () {
                if ($("#message").val() == "") {
                    alert("请输入留言内容");
                }else{
                    var str = "?type=1";
                    $(".contact_input").each(function (i) {
                        str += "&" + "list" + i + "=" +  encodeURI(encodeURI(this.value));
                    });
                    var pattern = /^\d{7,11}$/g;
                    if (pattern.test($(".contact_input.w250.ml50").val())) {
                        $.ajax({
                                url:"${pageContext.request.contextPath}/message/save.do"+str,
                                type:"GET",
                                success:function (data) {
                                    alert(data);
                                    window.location.reload();
                                }
                            }
                        )
                    }else {
                        alert("您的电话有误");
                    }
                }
            });
		</script>
	</body>

</html>