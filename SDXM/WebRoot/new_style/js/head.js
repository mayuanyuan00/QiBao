$('.loginbtn').click(function(){
    shade.loginshade();
});
$('.signbtn').click(function(){
    shade.signshade();
});
function toRegister() {
    $('.loginbox').remove();
    shade.signshade();
}
function checkNull() {
    var t = $("#key");
    if ($.trim(t.val()) == ""){
        alert("请输入搜索关键字!");
        return false;
    }else{
        this.location.href = '<c:url value="${pageContext.request.contextPath}/search/search.do"/>?keyword=' + encodeURI($.trim(t.val())).replace(/%/g,".");
    }
}
$(function () {
    var pageUrl = window.location.href;
    var aArray= $('.nav-list ul li a');
    for (var i = 0; i < aArray.length; i++) {
        var a=aArray[i].href;
        if (pageUrl.search(a)!=-1) {
            $(aArray[i]).css({'background':'#816a52','color':'#fff'});
        }
    }
});

$('.nav_box ul li a').click(function () {
    $('.nav_box ul li a').not($(this)).css({'background':'#fff','color':'#333'});
    $(this).css({'background':'#816a52','color':'#fff'});
});

function loginOut() {
    var url = "<c:url value='/user/logout.do'/>";
    $.ajax({
        type: "GET",
        url: url,
        success: function ()
        {
            alert("注销成功");
            window.location.reload();
//            $("#header").load("/home/header.do",null,function(){});
        },
        error:function () {
            alert("注销失败，请重试！");
        }
    });
}

$(window).unload( function(){
    var url = "<c:url value='/user/logout.do'/>";
    window.location.reload();
} );

function checkLogin() {
<c:if test="${empty sessionScope.user}">
        alert("请先登陆");
    return false;
</c:if>
    <c:if test="${not empty sessionScope.user}">
        return true;
</c:if>

}



//Ajax登录
function _loginAjax(){
    var _username = $("#_loginUsername").val();
    var _password = $("#_loginPassword").val();
    // check
    if(_username.length < 1 || _password.length < 1){
        alert("用户名或密码不正确");
        return ;
    }
    // ajax
    $.post("${pageContext.request.contextPath}/user/login.do",
        {
            username:_username,
            password:_password
        },function(result){
            if(result=="error"){
                alert("用户名或密码错误");
            }
            else {
                location.reload(true);
                /*$(document).ready(function () {
                    fresh();
                });
                function fresh() {
                    $("#header").load("/home/header.do",null,function(){alert("登录成功")});
                }*/
            }

        });
}

//Ajax注册
function _regAjax(type){
    var _pre = "#_regPhone";
    if(type == 2){
        _pre = "#_regEmail";
    }
    var data = {};
    data.username = $(_pre+"Username").val();
    data.password = $(_pre+"Password").val();
    if (type == 2) {
        data.email = $(_pre+"Email").val();
        if (!_isblank(data.email)) {
            alert("请填写必填字段");
            return;
        }
    }else{
        data.phone = $(_pre+"Phone").val();
        if (!_isblank(data.phone)) {
            alert("请填写必填字段");
            return;
        }
    }
    if(!verifyCode.validate($(_pre+"Code").val())){
        alert("验证码错误");
        verifyCode.refresh();
        return;
    }
//        判断是否阅读注意事项
    var flag1 = $('#checkbox_01').is(":checked");
    var flag2 = $('#checkbox_02').is(":checked");
    if(!flag1&&!flag2){
        alert("请阅读并接受《上海大学出版社用户注册协议》");
        return;
    }

    // ajax
    $.post("${pageContext.request.contextPath}/user/register.do",
        data,function(result){
            if(result == "success"){
                alert("注册成功");
                location.reload();
            }else {
                alert("注册失败");
            }
        });
}


function _isblank(content){
    if (content==null || _trim(content) == "") {
        return false;
    }
    return true;
}

function _trim(text){
    return text.replace(/^\s+|\s+$/gm,'');
}

function _checkInput(tt,args){
    for(var index in args){
        var method = "_"+args[index]+"_";
        var m = window[method](tt);
        if(!m){
            break;
        }
    }
}

function _confirmPassword(tt,type){
    var _pre = "#_regPhone";
    if(type == 2){
        _pre = "#_regEmail";
    }
    var _password = $(_pre+"Password").val();
    var _confirmpassword = $(_pre+"ConfirmPassword").val();
    if(_password != _confirmpassword){
        $(tt).css("border-color","#DC143C");
        alert("密码不一致");
    }else{
        $(tt).css("border-color","");
    }
}

function _required_(tt){
    var a = $(tt).val();
    if(a.length < 1){
        $(tt).css("border-color","#DC143C");
        return false;
    }else{
        $(tt).css("border-color","");
        return true
    }
}

function _email_(tt){
    var a = $(tt).val();
    var pattern=/^(\w)+(\.\w+)*@(\w)+((\.\w+)+)$/;
    if(!pattern.test(a)){
        $(tt).css("border-color","#dc143c");
        alert("邮箱有误");
        return false;
    }else{
        $(tt).css("border-color","");
        return true;
    }
}

function _phone_(tt){
    var a = $(tt).val();
    var pattern=/^\d{7,11}$/g;
    if(!pattern.test(a)){
        $(tt).css("border-color","#DC143C");
        alert("电话有误");
        $(tt).val("");
        return false;
    }else{
        $(tt).css("border-color","");
        return true;
    }
}

function _repeat_(tt){
    var a = $(tt).val();
    $.ajax({
        url : '${pageContext.request.contextPath}/user/checkrepeat.do',
        type : 'post',
        async: false,//使用同步的方式,true为异步方式
        data : {'content':a},//这里使用json对象
        success : function(data){
            if(data=="success"){
                $(tt).css("border-color","");
                return true;
            }else{
                $(tt).css("border-color","#DC143C");
                alert("已经被注册了");
                $(tt).val("");
                return false;
            }
        }
    });
}
//保存收货地址
function address_submit() {
    var form = new FormData();
    var addressId = $("#address_id_not_show").val();
    var province = $("#province").val();
    var city = $("#city").val();
    var area = $("#area").val();
    var addressDetail = $("#add_new_address_address").val();
    var code = $("#add_new_address_code").val();
    var receiver = $("#add_new_address_receiver").val();
    var tel = $("#add_new_address_phone").val();
    if (addressDetail == "") {
        alert("请填写详细地址");
        return;
    }
    if (receiver == "") {
        alert("请填写收货人");
        return;
    }
    if (tel == "") {
        alert("请填写手机号");
        return;
    }
    if (addressId != "") {
        form.append("id", addressId);
    }
    form.append("province", province);
    form.append("city", city);
    form.append("area", area);
    form.append("addressDetail", addressDetail);
    form.append("code", code);
    form.append("consignee", receiver);
    form.append("tel", tel);
    $.ajax({
            url: "${pageContext.request.contextPath}/home/address/upset.do",
            type: "POST",
            data: form,
            contentType: false,
            processData: false,
            success: function (data) {
            <%--$(".address_management").load("${pageContext.request.contextPath}/home/personalInformation.do");--%>
                alert(data);
                window.location.reload();
            },
            error: function () {
                alert("保存失败");
                closeAdd();
            }

        }
    );
    shade.addAddressShade()
};

function closeAdd() {
    $("#address_id_not_show").val("");
    $("#province").val("");
    $("#city").val("");
    $("#area").val("");
    $("#add_new_address_address").val("");
    $("#add_new_address_code").val("");
    $("#add_new_address_receiver").val("");
    $("#add_new_address_phone").val("");
}
function checkName(that) {
    $.ajax({
        type: "POST",
        url: "${pageContext.request.contextPath}/adminUser/userCheck.do",
        data: {name:$(that).val(),groupCode:"3"},
        dataType: "text",
        success: function (data) {
            if (data != "success") {
                alert("该用户名已被占用!");
                $(that).val("");
            }
        },
        error: function (data) {
            alert("请联系网站管理员");
        }
    });
}

//栏目高亮
$(function () {
    var pageUrl = window.location.href;
    $('.nav-list>ul>li>a').each(function () {
        if (pageUrl.indexOf($(this).attr('href'))!=-1) {
            $(this).css({'background':'#fff','color':'#7C5028'});
        }
    })
})