<!DOCTYPE html>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <link rel="icon"
          href="${pageContext.request.contextPath}/favicon.ico" type="image/x-icon" />
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/favicon.ico" type="image/x-icon" />
    <title>个人信息</title>
    <!-- CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/new_style/css/reset.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/new_style/css/main.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/new_style/css/cropper.min.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/new_style/css/ImgCropping.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/new_style/css/user.css"/>
   <style>
       .column {
           width: 100px;
           text-align: center;
       }
   </style>
</head>

<body>
<div class="container">
    <jsp:include page="header.jsp"/>
    <div class="mainbody">
        <div class="active-box">
            <a>个人中心</a>
            <a>个人信息</a>
        </div>
        <div class="user-info clearfix">
            <div class="user-info-l clearfix">
                <span class="user-header"><img
                        src="${pageContext.request.contextPath}${sessionScope.user.imageUrl}"/></span>
                <span class="user-name">${user.userName}</span>
                <span class="user-contact"><em class="icon-email">${sessionScope.user.email}</em><em
                        class="icon-phone">${sessionScope.user.phone}</em></span>
            </div>
            <div class="user-info-r">
                <span class="icon-edit"><a href="javascript:void(0)" style="color: black">编辑资料</a></span>
                <span class="icon-collect"><a href="<c:url value="/collection/myCollection.do" />" style="color: black">我的收藏</a></span>
            </div>
        </div>

        <div class="user-section">
            <div class="user-section-title clearfix">
                <span class="icon-order">订单状态</span>
                <a href="${pageContext.request.contextPath}/order/myorderlist.do">查看更多订单</a>
            </div>
            <div class="user-section-content clearfix">
                <ul class="user-section-order">
                    <li><a class="icon-pay"
                           href="${pageContext.request.contextPath}/order/myorderlist.do?status=1">待付款<em>${sessionScope.count1}</em></a>
                    </li>
                    <li><a class="icon-send" href="${pageContext.request.contextPath}/order/myorderlist.do?status=4">待发货<em>${sessionScope.count2}</em></a>
                    </li>
                    <li><a class="icon-get"
                           href="${pageContext.request.contextPath}/order/myorderlist.do?status=5">待收货<em>${sessionScope.count3}</em></a>
                    </li>
                </ul>
            </div>
        </div>
        <div class="user-section">
            <div class="user-section-title clearfix">
                <span class="icon-message">消息提醒</span>
                <%--<a>查看更多消息</a>--%>
            </div>
            <div class="user-section-content">
                <c:if test="${not empty sessionScope.orders}">
                    <ul>
                        <c:forEach items="${sessionScope.orders}" var="order" varStatus="status">
                            <li>
                                <div class="msg-box-l clearfix">
                                    <%--<span class="msg-book"><img src="${pageContext.request.contextPath}/new_style/img/book_02.png"/></span>--%>
                                    <span class="msg-book-info logistics">您的订单${order.orderno}已被签收，签收人：他人代签    感谢您的支持，欢迎再次购买!</span>
                                    <span class="msg-book-info time"><em>${order.create_date}</em><a>查看物流详情</a></span>
                                </div>
                                 <span class="check-btn"><a href="${pageContext.request.contextPath}/order/finishOrder.do?id=${order.id}" style="color: black">确认收货</a></span>
                            </li>
                        </c:forEach>
                    </ul>
                </c:if>
            </div>
        </div>
        <div class="user-section">
            <div class="user-section-title clearfix">
                <span class="icon-address">地址管理</span>
                <a class="address-add">新增收货地址</a>
            </div>
            <c:if test="${not empty sessionScope.address}">
                <div class="user-section-content">
                    <ul class="address_management_list">
                        <li class="address_management_list_title clearfix">
                            <div class="receiver column">收货人</div>
                            <div class="receiver_location column">所在地区</div>
                            <div class="receiver_address column">详细地址</div>
                            <div class="receiver_code column">邮编</div>
                            <div class="receiver_phone column">电话/手机</div>
                            <div class="receiver_action column">操作</div>
                        </li>
                        <c:forEach items="${sessionScope.address}" var="address">
                            <li class="clearfix">
                                <div class="receiver_id" style="display: none">${address.id}</div>
                                <div class="receiver column">${address.consignee}</div>
                                <div class="receiver_location" style="display: none">${address.province}-${address.city}-${address.area}</div>
                                <div class="receiver_location column">${address.province}${address.city}${address.area}</div>
                                <div class="receiver_address column">${address.addressDetail}</div>
                                <div class="receiver_code column"><c:if test="${address.code eq ''}">&nbsp;</c:if>${address.code}</div>
                                <div class="receiver_tel column">${address.tel}</div>
                                <%--<div class="receiver_phone" style="display: none">${address.phone}</div>--%>
                                <div class="receiver_action column">
                                    <a href="javascript:void(0);" class="edit_address">修改</a>
                                    <a href="javascript:void(0);" class="delete_address">删除</a>
                                </div>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </c:if>


        </div>

    </div>
    <jsp:include page="footer.jsp" />

</div>
<script type="text/javascript" src="${pageContext.request.contextPath}/new_style/js/jquery-1.8.0.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/new_style/js/main.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/new_style/js/cropper.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/new_style/js/imgCrop.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/new_style/js/main.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/new_style/js/distpicker.data.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/new_style/js/distpicker.js"></script>
<script>
    //显示或隐藏
    $('.sign-tab-hd li').click(function () {
        let liindex = $(this).index();
        $(this).addClass('on').siblings('li').removeClass('on');
        $('.sign-tab-bd').eq(liindex).addClass('show').siblings('.sign-tab-bd').removeClass('show');
    });

    //编辑个人资料弹窗。需传入头像地址
    $('.icon-edit').click(function () {
        shade.userInfoShade('${pageContext.request.contextPath}${sessionScope.user.imageUrl}');
        $('#_upUsername').val('${sessionScope.user.userName}');
        $('#_upEmail').val('${sessionScope.user.email}');
        $('#_upPhone').val('${sessionScope.user.phone}');
    });



    $('.address-add').click(function () {
        shade.addAddressShade();
        $('#area_box').distpicker();
    });

    //修改用户信息
    function _updateUser(tp) {
        var uid = "${pageContext.request.contextPath}${sessionScope.user.id}";
        var _username = $('#_upUsername').val();
        var _upEmail = $('#_upEmail').val();
        var _upPhone = $('#_upPhone').val();
        var formData = new FormData();
        formData.append("uid", uid);
        if (tp == 1) {
            if (!_isblank(_username) || !_isblank(_upEmail) || !_isblank(_upPhone)) {
                alert("请填写完整");
                return;
            }
            formData.append("name", _username);
            formData.append("email", _upEmail);
            formData.append("phone", _upPhone);
        }
        if (tp == 2) {
            var fileImg = $("#finalImg").attr("src");
            formData.append("avatar_file_after", convertBase64UrlToBlob(fileImg));
        }
        $.ajax({
            url: "<c:url value='/user/userUpdate.do'/>",
            type: 'POST',
            data: formData,
            timeout: 100003, //超时时间设置，单位毫秒
            async: true,
            cache: false,
            contentType: false,
            processData: false,
            success: function (result) {
                if (result == "msg") {
                    alert("文件上传大小不能超过1M");
                }
                window.location.reload();
            },
            error: function (e) {
                alert("操作失败");
            }
        });
    }

    function convertBase64UrlToBlob(urlData) {

        var bytes = window.atob(urlData.split(',')[1]);        //去掉url的头，并转换为byte

        //处理异常,将ascii码小于0的转换为大于0
        var ab = new ArrayBuffer(bytes.length);
        var ia = new Uint8Array(ab);
        for (var i = 0; i < bytes.length; i++) {
            ia[i] = bytes.charCodeAt(i);
        }

        return new Blob([ab], {type: 'image/jpeg'});
    }

    //修改某地址
    $(".edit_address").click(function () {
        shade.addAddressShade();
        var address_id =  $(this).parent().parent().find("div.receiver_id").html();
        var place = $(this).parent().parent().find("div.receiver_location").first().html();
        place = place.split("-");
        var province = place[0];
        var city = place[1];
        var area = place[2];
        var consignee = $(this).parent().parent().find("div.receiver").html();
        var addressDetail = $(this).parent().parent().find("div.receiver_address").html();
        var tel = $(this).parent().parent().find("div.receiver_tel").html();
        var code = $(this).parent().parent().find("div.receiver_code").html();
        if(code == "&nbsp;"){
            code = "";
        }
        $('#area_box').distpicker({
            province: province,
            city: city,
            district: area
        });
        $("#address_id_not_show").val(address_id);
        $("#add_new_address_address").val(addressDetail);
        $("#add_new_address_code").val(code);
        $("#add_new_address_receiver").val(consignee);
        $("#add_new_address_phone").val(tel);
    });
    //删除某地址
    $('.delete_address').click(function(){
        var flag = window.confirm("确定要删除？");
        if(flag){
        var addressId=$(this).parent().parent().find("div.receiver_id").html();
        var forThis=this;
        $.ajax({
                url:"${pageContext.request.contextPath}/home/address/delete.do?id="+addressId,
                type:"GET",
                success:function (data) {
                    alert(data);
                    if(data=="删除成功"){
                        $(forThis).parent().parent().remove();
                    }
                }
            }
        );
        }
    });
</script>
</body>

</html>

