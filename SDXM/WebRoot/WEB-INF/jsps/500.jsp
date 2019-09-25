<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <link rel="shortcut icon"
        href="${pageContext.request.contextPath}/favicon.ico" type="image/x-icon" />
<title>500 - 对不起，服务器内部错误！</title>
<link href="${pageContext.request.contextPath}/css/css.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="${pageContext.request.contextPath}/js/sdmenu.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js" ></script>
<script src="${pageContext.request.contextPath}/ckeditor/ckeditor.js"></script>
<link rel="shortcut icon" href="${pageContext.request.contextPath}/images/favicon.ico" />
<link href="${pageContext.request.contextPath}/css/css.css" type="text/css" rel="stylesheet" />
<style>
html, body, div, span, applet, object, iframe, h1, h2, h3, h4, h5, h6, p, blockquote, pre, a, abbr, acronym, address, big, cite, code, del, dfn, em, img, ins, kbd, q, s, samp, small, strike, strong, sub, sup, tt, var, b, u, i, center, dl, dt, dd, ol, ul, li, fieldset, form, label, legend, table, caption, tbody, tfoot, thead, tr, th, td, article, aside, canvas, details, embed, figure, figcaption, footer, header, hgroup, menu, nav, output, ruby, section, summary, time, mark, audio, video {
  margin: 0;
  padding: 0;
  border: 0;
  font-size: 100%;
  font: inherit;
  vertical-align: baseline;
  outline: none;
}
html { height: 100%; } /* always display scrollbars */
body { height: 100%; font-size: 62.5%; line-height: 1; font-family: Arial, Tahoma, Verdana, sans-serif; }

article, aside, details, figcaption, figure, footer, header, hgroup, menu, nav, section { display: block; }
ol, ul { list-style: none; }

blockquote, q { quotes: none; }
blockquote:before, blockquote:after, q:before, q:after { content: ''; content: none; }
strong { font-weight: bold }
input { outline: none }
table {
    border-collapse: collapse;
    border-spacing: 0;
}
img {
    border: 0;
    max-width: 100%;
}
a { text-decoration: none }
a:hover { text-decoration: underline }
.clear { clear: both }
.clear:before,
.container:after {
    content: "";
    display: table;
}
.clear:after { clear: both }
/* IE 6/7 */
.clear { zoom: 1 }
body {
    background: #dfdfdf url(${pageContext.request.contextPath}/img/bg_noise.jpg) repeat;
    font-family: Helvetica, Arial, sans-serif;
    -webkit-font-smoothing: antialiased;
    overflow: hidden;
}
@font-face {
    font-family: 'TeXGyreScholaRegular';
    src: url('texgyreschola-regular-webfont.eot');
    src: url('texgyreschola-regular-webfont.eot?#iefix') format('embedded-opentype'),
    url('texgyreschola-regular-webfont.woff') format('woff'),
    url('texgyreschola-regular-webfont.ttf') format('truetype'),
    url('texgyreschola-regular-webfont.svg#TeXGyreScholaRegular') format('svg');
    font-weight: normal;
    font-style: normal;

}
@font-face {
    font-family: 'TeXGyreScholaBold';
    src: url('texgyreschola-bold-webfont.eot');
    src: url('texgyreschola-bold-webfont.eot?#iefix') format('embedded-opentype'),
    url('texgyreschola-bold-webfont.woff') format('woff'),
    url('texgyreschola-bold-webfont.ttf') format('truetype'),
    url('texgyreschola-bold-webfont.svg#TeXGyreScholaBold') format('svg');
    font-weight: normal;
    font-style: normal;

}
@-webkit-keyframes main { 
	0% {
	    -webkit-transform: scale3d(0.1, 0.1, 1);
	    opacity: 0;
	}
	45% {
	    -webkit-transform: scale3d(1.07, 1.07, 1);
	    opacity: 1;
	}
	70% { -webkit-transform: scale3d(0.95, 0.95, 1) }
	100% { -webkit-transform: scale3d(1, 1, 1) }
}
@-moz-keyframes main { 
	0% {
	    -moz-transform: scale(0.1, 0.1);
	    opacity: 0;
	}
	45% {
	    -moz-transform: scale(1.07, 1.07);
	    opacity: 1;
	}
	70% { -moz-transform: scale(0.95, 0.95) }
	100% { -moz-transform: scale(1, 1) }
}
@-webkit-keyframes logo { 
	0% { opacity: 0 }
	100% { opacity: 1 }
}
@-webkit-keyframes footer { 
	0% { top: 50px }
	100% { top: 0 }
}
.clear { clear: both }
.clear:before,
.container:after {
    content: "";
    display: table;
}
.clear:after { clear: both }
.clear { zoom: 1 }
.left { float: left }
.right { float: right }
#wrapper {
    height: 100%;
    background-image: linear-gradient(bottom, rgba(0,0,0,.0) 0%, rgba(0,0,0,.20) 100%);
    background-image: -o-linear-gradient(bottom, rgba(0,0,0,.0) 0%, rgba(0,0,0,.20) 100%);
    background-image: -moz-linear-gradient(bottom, rgba(0,0,0,.0) 0%, rgba(0,0,0,.20) 100%);
    background-image: -webkit-radial-gradient(rgba(0,0,0,.0) 0%, rgba(0,0,0,.20) 100%);
    background-image: -ms-linear-gradient(bottom, rgba(0,0,0,.0) 0%, rgba(0,0,0,.20) 100%);
}
.logo {
    position: absolute;
    background: url(logo.png);
    width: 200px;
    height: 80px;
    top: 1%;
    left: 1%;
    z-index: 1;
    animation: logo 1.5s 1;
    -webkit-animation: logo 1.5s 1;
    -moz-animation: logo 1.5s 1;
    -o-animation: logo 1.5s 1;
    -ms-animation: logo 1.5s 1;
    transition: all 0.3s ease-in-out;
    -webkit-transition: all 0.3s ease-in-out;
    -moz-transition: all 0.3s ease-in-out;
    -o-transition: all 0.3s ease-in-out;
    -ms-transition: all 0.3s ease-in-out;
}
.logo:hover { opacity: .75 !important }
#main {
    position: relative;
    width: 600px;
    margin: 0 auto;
    padding-top: 8%;
    animation: main .8s 1;
    animation-fill-mode: forwards;
    -webkit-animation: main .8s 1;
    -webkit-animation-fill-mode: forwards;
    -moz-animation: main .8s 1;
    -moz-animation-fill-mode: forwards;
    -o-animation: main .8s 1;
    -o-animation-fill-mode: forwards;
    -ms-animation: main .8s 1;
    -ms-animation-fill-mode: forwards;
}
#main #header h1 {
    position: relative;
    display: block;
    font: 72px 'TeXGyreScholaBold', Arial, sans-serif;
    color: #0061a5;
    text-shadow: 2px 2px #f7f7f7;
    text-align: center;
}
#main #header h1 span.sub {
    position: relative;
    font-size: 21px;
    top: -20px;
    padding: 0 10px;
    font-style: italic;
}
#main #header h1 span.icon {
    position: relative;
    display: inline-block;
    top: -6px;
    margin: 0 10px 5px 0;
    background: #0061a5;
    width: 50px;
    height: 50px;
    -moz-box-shadow: 1px 2px white;
    -webkit-box-shadow: 1px 2px white;
    box-shadow: 1px 2px white;
    -webkit-border-radius: 50px;
    -moz-border-radius: 50px;
    border-radius: 50px;
    color: #dfdfdf;
    font-size: 46px;
    line-height: 48px;
    font-weight: bold;
    text-align: center;
    text-shadow: 0 0;
}
#main #content {
    position: relative;
    width: 600px;
    background: white;
    -moz-box-shadow: 0 0 0 3px #ededed inset, 0 0 0 1px #a2a2a2, 0 0 20px rgba(0,0,0,.15);
    -webkit-box-shadow: 0 0 0 3px #ededed inset, 0 0 0 1px #a2a2a2, 0 0 20px rgba(0,0,0,.15);
    box-shadow: 0 0 0 3px #ededed inset, 0 0 0 1px #a2a2a2, 0 0 20px rgba(0,0,0,.15);
    -webkit-border-radius: 5px;
    -moz-border-radius: 5px;
    border-radius: 5px;
    z-index: 5;
}
#main #content h2 {
    background: url(404_s-divider.jpg) no-repeat;
    background-position: bottom;
    padding: 12px 0 22px 0;
    font: 20px 'TeXGyreScholaRegular', Arial, sans-serif;
    color: #8e8e8e;
    text-align: center;
}
#main #content p {
    position: relative;
    padding: 20px;
    font-size: 13px;
    line-height: 25px;
    color: #b5b5b5;
}
#main #content .utilities { padding: 20px }
#main #content .utilities form .input-container {
    position: relative;
    width: 290px;
}
#main #content .utilities form .input-container input[type=text] {
    width: 280px;
    height: 34px;
    padding: 0 8px;
    background: white;
    border: solid 1px #cdcdcd;
    outline: none;
    -moz-box-shadow: 0 3px 3px rgba(0,0,0,.05) inset;
    -webkit-box-shadow: 0 3px 3px rgba(0,0,0,.05) inset;
    box-shadow: 0 3px 3px rgba(0,0,0,.05) inset;
    -webkit-border-radius: 3px;
    -moz-border-radius: 3px;
    border-radius: 3px;
    font-size: 14px;
    color: #696969;
    -webkit-font-smoothing: antialiased;
    transition: all 0.3s ease-in-out;
    -webkit-transition: all 0.3s ease-in-out;
    -moz-transition: all 0.3s ease-in-out;
    -o-transition: all 0.3s ease-in-out;
    -ms-transition: all 0.3s ease-in-out;
}
#main #content .utilities .input-container input[type=text]:focus { border: solid 1px #9f9f9f }
#main #content .utilities form  .input-container button#search {
    position: absolute;
    display: block;
    top: 9px;
    right: 0;
    background: white url(404_search.png) no-repeat;
    width: 18px;
    height: 18px;
    border: none;
    cursor: pointer;
    opacity: .3;
    transition: all 0.3s ease-in-out;
    -webkit-transition: all 0.3s ease-in-out;
    -moz-transition: all 0.3s ease-in-out;
    -o-transition: all 0.3s ease-in-out;
    -ms-transition: all 0.3s ease-in-out;
}
#main #content .utilities form  .input-container button#search:hover { opacity: .6 }
#main #content .utilities .button {
    display: inline-block;
    height: 34px;
    margin: 0 0 0 6px;
    padding: 0 18px;
    background: #006db0;
    background-image: linear-gradient(bottom, #0062a6 0%, #0079bb 100%);
    background-image: -o-linear-gradient(bottom, #0062a6 0%, #0079bb 100%);
    background-image: -moz-linear-gradient(bottom, #0062a6 0%, #0079bb 100%);
    background-image: -webkit-linear-gradient(bottom, #0062a6 0%, #0079bb 100%);
    background-image: -ms-linear-gradient(bottom, #0062a6 0%, #0079bb 100%);
    -moz-box-shadow: 0 0 0 1px #003255, 0 1px 3px rgba(0, 50, 85, 0.5), 0 1px #00acd8 inset;
    -webkit-box-shadow: 0 0 0 1px #003255, 0 1px 3px rgba(0, 50, 85, 0.5), 0 1px #00acd8 inset;
    box-shadow: 0 0 0 1px #003255, 0 1px 3px rgba(0, 50, 85, 0.5), 0 1px #00acd8 inset;
    -webkit-border-radius: 3px;
    -moz-border-radius: 3px;
    border-radius: 3px;
    font-size: 14px;
    line-height: 34px;
    color: white;
    font-weight: bold;
    text-shadow: 0 -1px #00385a;
    text-decoration: none;
}
#main #content .utilities .button:hover {
    background: #0081c6;
    background-image: linear-gradient(bottom, #006fbb 0%, #008dce 100%);
    background-image: -o-linear-gradient(bottom, #006fbb 0%, #008dce 100%);
    background-image: -moz-linear-gradient(bottom, #006fbb 0%, #008dce 100%);
    background-image: -webkit-linear-gradient(bottom, #006fbb 0%, #008dce 100%);
    background-image: -ms-linear-gradient(bottom, #006fbb 0%, #008dce 100%);
    -moz-box-shadow: 0 0 0 1px #003255, 0 1px 3px rgba(0, 50, 85, 0.5), 0 1px #00c1e4 inset;
    -webkit-box-shadow: 0 0 0 1px #003255, 0 1px 3px rgba(0, 50, 85, 0.5), 0 1px #00c1e4 inset;
    box-shadow: 0 0 0 1px #003255, 0 1px 3px rgba(0, 50, 85, 0.5), 0 1px #00c1e4 inset;
}
#main #content .utilities .button:active {
    background: #0081c6;
    background-image: linear-gradient(bottom, #008dce 0%, #006fbb 100%);
    background-image: -o-linear-gradient(bottom, #008dce 0%, #006fbb 100%);
    background-image: -moz-linear-gradient(bottom, #008dce 0%, #006fbb 100%);
    background-image: -webkit-linear-gradient(bottom, #008dce 0%, #006fbb 100%);
    background-image: -ms-linear-gradient(bottom, #008dce 0%, #006fbb 100%);
    -moz-box-shadow: 0 0 0 1px #003255, 0 1px 3px rgba(0, 50, 85, 0.5), 0 1px #00c1e4 inset;
    -webkit-box-shadow: 0 0 0 1px #003255, 0 1px 3px rgba(0, 50, 85, 0.5), 0 1px #00c1e4 inset;
    box-shadow: 0 0 0 1px #003255, 0 1px 3px rgba(0, 50, 85, 0.5), 0 1px #00c1e4 inset;
}
#main #content .utilities .button-container .button:focus { color: black }
#main #footer {
    position: relative;
    top: 30px;
    padding: 5px 0;
    text-align: center;
    z-index: 1;
    animation: footer .4s .8s 1;
    animation-fill-mode: forwards;
    -webkit-animation: footer .4s .8s 1;
    -webkit-animation-fill-mode: forwards;
    -moz-animation: footer .4s .8s 1;
    -moz-animation-fill-mode: forwards;
    -o-animation: footer .4s .8s 1;
    -o-animation-fill-mode: forwards;
    -ms-animation: footer .4s .8s 1;
    -ms-animation-fill-mode: forwards;
}
#main #footer ul {
    font: 13px 'TeXGyreScholaRegular', Arial, sans-serif;
    text-shadow: 0 1px white;
}
#main #footer ul li {
    display: inline;
    margin: 0 12px;
}
#main #footer ul li a {
    font: 13px 'TeXGyreScholaRegular', Arial, sans-serif;
    color: #696969;
    text-shadow: 0 1px white;
    text-decoration: none;
}
#main #footer ul li a:hover {
    color: #0061a5;
    text-decoration: underline;
}
</style>
</head>
<body>
<div id="wrapper"><a class="logo" href="/"></a>
  <div id="main">
    <div id="header">
      <h1><span class="icon">!</span>500<span class="sub">Internal Server Error</span></h1>
    </div>
    <div id="content">
      <h2>服务器内部错误！</h2>
      <p>当您看到这个页面,表示服务器内部错误,此网站可能遇到技术问题,无法执行您的请求,请稍后重试或联系站长进行处理,感谢您的支持!</p>
      <div class="utilities">
          <div class="input-container" style="font: 13px 'TeXGyreScholaRegular', Arial, sans-serif;color: #696969; text-shadow: 0 1px white;text-decoration: none;">
            <span id="totalSecond" style="color:red">5</span>秒后自动跳转…
          </div>
        <a class="button right" href="#" onClick="history.go(-1);return true;">返回...</a><a class="button right" href="<c:url value='/user/main.do'/>">联系站长</a>
        <div class="clear"></div>
      </div>
    </div>
   
</div>


 <!--定义js变量及方法-->
	<script language="javascript" type="text/javascript">
var second = document.getElementById('totalSecond').textContent;


if (navigator.appName.indexOf("Explorer") > -1)
{
second = document.getElementById('totalSecond').innerText; 
} else
{
second = document.getElementById('totalSecond').textContent; 
}




setInterval("redirect()", 1000); 
function redirect()
{
if (second < 0)
{


 <!--定义倒计时后跳转页面-->
location.href = '${pageContext.request.contextPath}/home/enter.do'; 
} else
{
if (navigator.appName.indexOf("Explorer") > -1)
{
document.getElementById('totalSecond').innerText = second--; 
} else
{
document.getElementById('totalSecond').textContent = second--; 
}
}
}
//判断当前窗口是否有顶级窗口，如果有就让当前的窗口的地址栏发生变化，
function loadTopWindow(){
    if (window.top!=null && window.top.document.URL!=document.URL){
        window.top.location= document.URL; //这样就可以让登陆窗口显示在整个窗口了
    }
}
</script>
</html>
