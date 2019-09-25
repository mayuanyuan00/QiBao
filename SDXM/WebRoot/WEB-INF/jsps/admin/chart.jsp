<%@ page language="java" import="java.util.*" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>主要内容区main</title>
    <script  src="${pageContext.request.contextPath}/js/jquery.min.js"></script>

    <script src="https://img.hcharts.cn/highcharts/highcharts.js"></script>
    <!--[if lt IE 9]>
        <script src="https://img.hcharts.cn/highcharts/modules/oldie.js"></script>
    <![endif]-->

    <script src="${pageContext.request.contextPath}/ckeditor/ckeditor.js"></script>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/images/favicon.ico"/>
    <link href="${pageContext.request.contextPath}/css/css.css" type="text/css" rel="stylesheet"/>
    <style>
        div{
            margin: 10px auto;

        }
    </style>
</head>
<body>
<!-- 为ECharts准备一个具备大小（宽高）的Dom -->
<script language="javascript" type="text/javascript">
    window.onload=function(){
//设置年份的选择
        var myDate= new Date();
        var endYear = myDate.getFullYear();
        var startYear=myDate.getFullYear()-20;//起始年份
        var obj=document.getElementById('myYear')
        for (var i=endYear ;i>startYear;i--)
        {
            obj.options.add(new Option(i,i));
        }
//        obj.options[obj.options.length-51].selected=1;
    }
</script>
<span>请选择年份：</span><select id="myYear"></select>
<div id="bar" style="width: 800px;height:400px;"></div>
<div id="line" style="width: 800px;height: 400px;"></div>
<div id="pie" style="width: 800px;height: 400px;"></div>
<script type="text/javascript">
    if ( !Array.prototype.forEach ) {
        Array.prototype.forEach = function forEach( callback, thisArg ) {
            var T, k;
            if ( this == null ) {
                throw new TypeError( "this is null or not defined" );
            }
            var O = Object(this);
            var len = O.length >>> 0;
            if ( typeof callback !== "function" ) {
                throw new TypeError( callback + " is not a function" );
            }
            if ( arguments.length > 1 ) {
                T = thisArg;
            }
            k = 0;
            while( k < len ) {
                var kValue;
                if ( k in O ) {
                    kValue = O[ k ];
                    callback.call( T, kValue, k, O );
                }
                k++;
            }
        };
    }
    var oChart = null;

    //定义oChart的布局环境
    //布局环境组成：X轴、Y轴、数据显示、图标标题
    var oOptions = {

        //设置图表关联显示块和图形样式
        chart: {
            renderTo: 'bar',  //设置显示的页面块
            //type:'line'                //设置显示的方式
            type: 'column'
        },

        //图标标题
        title: {
            text: '每月销量柱形图',
            left: '50%',
            top: '10%',
            textAlign: 'center'
        },

        xAxis: {
            categories: [
                '一月','二月','三月','四月','五月','六月','七月','八月','九月','十月','十一月','十二月'
            ]
            //crosshair: true
        },
        yAxis: {
            //min: 0,
            title: {
                text: '单位（元）'
            }
        },
        //数据列
        series: [{
            //data:[120,360,560,60,360,160,40,360,60,230,230,300]
            data: []
        }]
    };

    $(document).ready(function(){

        oChart = new Highcharts.Chart(oOptions);

        LoadSerie_Ajax();
        //异步动态加载数据列
        $("#myYear").change(function () {
            LoadSerie_Ajax($(this).val());
        });
        //LoadSerie_Ajax(year);
    });

    //异步读取数据并加载到图表
    function LoadSerie_Ajax(year) {
        oChart.showLoading();

        var     months1 = [
            {name: "1", value: "0"},
            {name: "2", value: "0"},
            {name: "3", value: "0"},
            {name: "4", value: "0"},
            {name: "5", value: "0"},
            {name: "6", value: "0"},
            {name: "7", value: "0"},
            {name: "8", value: "0"},
            {name: "9", value: "0"},
            {name: "10", value: "0"},
            {name: "11", value: "0"},
            {name: "12", value: "0"}
        ];
        var months2 = [
            {name: "1", value: "0"},
            {name: "2", value: "0"},
            {name: "3", value: "0"},
            {name: "4", value: "0"},
            {name: "5", value: "0"},
            {name: "6", value: "0"},
            {name: "7", value: "0"},
            {name: "8", value: "0"},
            {name: "9", value: "0"},
            {name: "10", value: "0"},
            {name: "11", value: "0"},
            {name: "12", value: "0"}
        ];
        var months3 = [
            {name: "1", value: "0"},
            {name: "2", value: "0"},
            {name: "3", value: "0"},
            {name: "4", value: "0"},
            {name: "5", value: "0"},
            {name: "6", value: "0"},
            {name: "7", value: "0"},
            {name: "8", value: "0"},
            {name: "9", value: "0"},
            {name: "10", value: "0"},
            {name: "11", value: "0"},
            {name: "12", value: "0"}
        ];
        var months4 = [
            {name: "1", value: "0"},
            {name: "2", value: "0"},
            {name: "3", value: "0"},
            {name: "4", value: "0"},
            {name: "5", value: "0"},
            {name: "6", value: "0"},
            {name: "7", value: "0"},
            {name: "8", value: "0"},
            {name: "9", value: "0"},
            {name: "10", value: "0"},
            {name: "11", value: "0"},
            {name: "12", value: "0"}
        ];
        var months5 = [
            {name: "1", value: "0"},
            {name: "2", value: "0"},
            {name: "3", value: "0"},
            {name: "4", value: "0"},
            {name: "5", value: "0"},
            {name: "6", value: "0"},
            {name: "7", value: "0"},
            {name: "8", value: "0"},
            {name: "9", value: "0"},
            {name: "10", value: "0"},
            {name: "11", value: "0"},
            {name: "12", value: "0"}
        ];
        var months6 = [
            {name: "1", value: "0"},
            {name: "2", value: "0"},
            {name: "3", value: "0"},
            {name: "4", value: "0"},
            {name: "5", value: "0"},
            {name: "6", value: "0"},
            {name: "7", value: "0"},
            {name: "8", value: "0"},
            {name: "9", value: "0"},
            {name: "10", value: "0"},
            {name: "11", value: "0"},
            {name: "12", value: "0"}
        ];
        var months7 = [
            {name: "1", value: "0"},
            {name: "2", value: "0"},
            {name: "3", value: "0"},
            {name: "4", value: "0"},
            {name: "5", value: "0"},
            {name: "6", value: "0"},
            {name: "7", value: "0"},
            {name: "8", value: "0"},
            {name: "9", value: "0"},
            {name: "10", value: "0"},
            {name: "11", value: "0"},
            {name: "12", value: "0"}
        ];
        var months8 = [
            {name: "1", value: "0"},
            {name: "2", value: "0"},
            {name: "3", value: "0"},
            {name: "4", value: "0"},
            {name: "5", value: "0"},
            {name: "6", value: "0"},
            {name: "7", value: "0"},
            {name: "8", value: "0"},
            {name: "9", value: "0"},
            {name: "10", value: "0"},
            {name: "11", value: "0"},
            {name: "12", value: "0"}
        ];

        $.ajax({
            type: "post",
            async: true,            //异步请求（同步请求将会锁住浏览器，用户其他操作必须等待请求完成才可以执行）
            url: "${pageContext.request.contextPath}/user/userCharts.do?year="+year,     //请求发送到TestServlet处
            dataType: "json",        //返回数据形式为json
            success: function (result) {

                //请求成功时执行该函数内容，result即为服务器返回的json对象
                result = eval("(" + result + ")");
                for (var i = 0; i < result.length; i++) {

                    if (result[i].bookType == "其他") {
                        for (var j = 0; j < 12; j++) {
                            if (result[i].month == months1[j].name) {
                                months1[j].value = result[i].count;

                            }
                        }
                    }
                    if (result[i].bookType == "教材专著") {
                        for (var j = 0; j < 12; j++) {
                            if (result[i].month == months2[j].name) {
                                months2[j].value = result[i].count;
                            }
                        }
                    }
                    if (result[i].bookType == "人文社科") {
                        for (var j = 0; j < 12; j++) {
                            if (result[i].month == months3[j].name) {
                                months3[j].value = result[i].count;
                            }
                        }
                    }
                    if (result[i].bookType == "艺术类") {
                        for (var j = 0; j < 12; j++) {
                            if (result[i].month == months4[j].name) {
                                months4[j].value = result[i].count;
                            }
                        }
                    }
                    if (result[i].bookType == "海派文化") {
                        for (var j = 0; j < 12; j++) {
                            if (result[i].month == months5[j].name) {
                                months5[j].value = result[i].count;
                            }
                        }
                    }
                    if (result[i].bookType == "工具书") {
                        for (var j = 0; j < 12; j++) {
                            if (result[i].month == months6[j].name) {
                                months6[j].value = result[i].count;
                            }
                        }
                    }
                    if (result[i].bookType == "中小学教辅") {
                        for (var j = 0; j < 12; j++) {
                            if (result[i].month == months7[j].name) {
                                months7[j].value = result[i].count;
                            }
                        }
                    }
                    if (result[i].bookType == "古籍文献") {
                        for (var j = 0; j < 12; j++) {
                            if (result[i].month == months8[j].name) {
                                months8[j].value = result[i].count;
                            }
                        }
                    }

                }
                var str1="",str2= "",str3="",str4="",str5="",str6="",str7="",str8="";

                //取得其他图书销售量
                for(var i=0;i<12;i++){
                    str1 = str1+months1[i].value+",";
                    str2 = str2+months2[i].value+",";
                    str3 = str3+months3[i].value+",";
                    str4 = str4+months4[i].value+",";
                    str5 = str5+months5[i].value+",";
                    str6 = str6+months6[i].value+",";
                    str7 = str7+months7[i].value+",";
                    str8 = str8+months8[i].value+",";
                }

                str1=JSON.parse("[" + str1.substr(0,str1.lastIndexOf(",")) + "]");
                str2=JSON.parse("[" + str2.substr(0,str2.lastIndexOf(",")) + "]");
                str3=JSON.parse("[" + str3.substr(0,str3.lastIndexOf(",")) + "]");
                str4=JSON.parse("[" + str4.substr(0,str4.lastIndexOf(",")) + "]");
                str5=JSON.parse("[" + str5.substr(0,str5.lastIndexOf(",")) + "]");
                str6=JSON.parse("[" + str6.substr(0,str6.lastIndexOf(",")) + "]");
                str7=JSON.parse("[" + str7.substr(0,str7.lastIndexOf(",")) + "]");
                str8=JSON.parse("[" + str8.substr(0,str8.lastIndexOf(",")) + "]");

                oChart = Highcharts.chart('bar',{
                    chart: {
                        type: 'column'
                    },
                    title: {
                        text: '每月销量柱形图',
                        left: '50%',
                        top: '10%',
                        textAlign: 'center'
                    },
                    /*grid: {
                        left: '10%', //表显示的位置
                        right: '14%',
                        top: '30%',
                        containLabel: true,
                        animation:false,
                        backgroundColor: "rgba(256,256,256,0.5)"
                    },*/
                    /*tooltip: {
                        // head + 每个 point + footer 拼接成完整的 table
                        headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
                        pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                        '<td style="padding:0"><b>{point.y:.1f} mm</b></td></tr>',
                        footerFormat: '</table>',
                        shared: true,
                        useHTML: true
                    },*/

                    //加载数据图表
                    xAxis: {
                        categories: [
                            '一月','二月','三月','四月','五月','六月','七月','八月','九月','十月','十一月','十二月'
                        ]
                        //crosshair: true
                    },
                    yAxis: {
                        min: 0,
                        title: {
                            text: '单位（元）'
                        }
                    },

                    plotOptions: {
                        column: {
                            borderWidth: 0
                        }
                    },
                    series: [{
                        // 根据名字对应到相应的系列
                        name: "其他",
                        // type: "bar",
                        data: str1
                    }, {
                        name: '教材专著',
                        //type: 'bar',
                        data: str2
                    }, {
                        name: '人文社科',
                        //type: 'bar',
                        data: str3
                    }, {
                        name: '艺术类',
                        //type: 'bar',
                        data: str4
                    }, {
                        name: '海派文化',
                        //type: 'bar',
                        data: str5
                    }, {
                        name: '工具书',
                        //type: 'bar',
                        data: str6
                    }, {
                        name: '中小学教辅',
                        //type: 'bar',
                        data: str7
                    }, {
                        name: '古籍文献',
                        //type: 'bar',
                        data: str8
                    }]
                });
            }
        });
        oChart.hideLoading();
    }


</script>

</body>
</html>
