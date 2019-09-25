<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="cn.com.common.CServletListener" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <link rel="shortcut icon"
          href="${pageContext.request.contextPath}/favicon.ico" type="image/x-icon" />
<%response.setStatus(HttpServletResponse.SC_OK);%>  
<%  
/** *//**  
* 本页面是在客户查找的页面无法找到的情况下调用的  
*/  
response.setStatus(HttpServletResponse.SC_OK);  
%>  

<title>访问错误--页面跳转中...</title>
<link href="${pageContext.request.contextPath}/css/css.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="${pageContext.request.contextPath}/js/sdmenu.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js" ></script>
<script src="${pageContext.request.contextPath}/ckeditor/ckeditor.js"></script>
<link rel="shortcut icon" href="${pageContext.request.contextPath}/images/favicon.ico" />
<link href="${pageContext.request.contextPath}/css/css.css" type="text/css" rel="stylesheet" />
<style>
body{
	background:url('${pageContext.request.contextPath}/img/bg.png') no-repeat center center #1d1d1d;
	color:#eee;
	font-family:Corbel,Arial,Helvetica,sans-serif;
	font-size:13px;
}

#rocket{
	width:275px;
	height:375px;
	background:url('${pageContext.request.contextPath}/img/rocket.png') no-repeat;
	margin:60px auto 10px;
	position:relative;
}

/*	Two steam classes. */

.steam1,
.steam2{
	position:absolute;
	bottom:78px;
	left:50px;
	width:80px;
	height:80px;
	background:url('${pageContext.request.contextPath}/img/steam.png') no-repeat;
	opacity:0.8;
}

.steam2{

   /*	.steam2 shows the bottom part (dark version)
	*	of the background image.
	*/

	background-position:left bottom;
}

hgroup{

	/* Using the HTML4 hgroup element */

	display:block;
	margin:0 auto;
	width:850px;
	font-family:'Century Gothic',Calibri,'Myriad Pro',Arial,Helvetica,sans-serif;
	text-align:center;
}

h1{
	color:#76D7FB;
	font-size:40px;
	text-shadow:3px 3px 0 #3D606D;
	white-space:nowrap;
}

h2{
	color:#9FE3FC;
	font-size:18px;
	font-weight:normal;
	padding-bottom:15px;
}

/* Only Needed For The Demo Page */

p.createdBy{
	font-size:15px;
	font-weight:normal;
	margin:50px;
	text-align:center;
	text-shadow:none;
}

a, a:visited {
	text-decoration:none;
	outline:none;
	border-bottom:1px dotted #97cae6;
	color:#97cae6;
}

a:hover{
	border-bottom:1px dashed transparent;
}
</style>
</head>
<body style="text-align:center">

<div id="rocket"></div>

<hgroup>
    <h1>404错误</h1>
    <BR>
    <h2>我把页面弄丢了~~~~(>_<)~~~~ </h2>
</hgroup>
<p style="text-align:center;"><a href="<c:url value='/user/login.do?loginType=admin'/>" target="_blank">返回首页</a>　</p>

<p><p></p></p>
<p></p>
<%=CServletListener.count.get() %> 人访问
</body>
<!--定义js变量及方法-->
	<script language="javascript" type="text/javascript">
	$(window).load(function(){
	
		
		// We are listening for the window load event instead of the regular document ready.
		
		function animSteam(){
			
			// Create a new span with the steam1, or steam2 class:
			
			$('<span>',{
				className:'steam'+Math.floor(Math.random()*2 + 1),
				css:{
					// Apply a random offset from 10px to the left to 10px to the right
					marginLeft	: -10 + Math.floor(Math.random()*20)
				}
			}).appendTo('#rocket').animate({
				left:'-=58',
				bottom:'-=100'
			}, 120,function(){
				
				// When the animation completes, remove the span and
				// set the function to be run again in 10 milliseconds
				
				$(this).remove();
				setTimeout(animSteam,10);
			});
		}
		
		//判断当前窗口是否有顶级窗口，如果有就让当前的窗口的地址栏发生变化，
	    function loadTopWindow(){
	        if (window.top!=null && window.top.document.URL!=document.URL){
	            window.top.location= document.URL; //这样就可以让登陆窗口显示在整个窗口了
	        }
	    }
		
		function moveRocket(){
			$('#rocket').animate({'left':'+=100'},5000).delay(1000)
						.animate({'left':'-=100'},5000,function(){
					setTimeout(moveRocket,1000);
			});
		}

		// Run the functions when the document and all images have been loaded.
			
		moveRocket();
		animSteam();
	});
</script>
</html>
