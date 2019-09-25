/**
 * $.txtCur();
 * @charset utf-8
 * @extends jquery.1.8.3
 * @example
 * $('.info').txtCur({n:50});
 * $('.info').txtCur({n:50,z:'...',isTitle:1});
 */
(function($){   
    $.fn.extend({     
         txtCur: function(options) {   
		    //默认参数
            var defaults = {
			     /**截取长度 */
                 n:60, 
				 /*结尾添加字符*/
                 z:'...' ,
				 /*是否在标签上 添加 title 属性*/
				 isTitle :  true
               			 
            }        
            var options = $.extend(defaults, options);   
            return this.each(function(){
			    var o = options;   
                var $this = $(this);				
               	var s = $this.text(),
				l = $this.text().length,
				n = o.n; //设置字符长度为18个 
				if (l > n) {
					//文本所有内容用a标签的title属性提示文本全部内容
					if(o.isTitle) {$(this).attr("title", s);}
					s = $this.text(s.substring(0, n) + o.z);
				}
				/**/
 
            });
        },
        
    });
})(jQuery);
//监控输入框，改变其背景
$(function(){

	$('input').blur(function(){
		var inputval = $(this).val();
		if(inputval != ''){
			$(this).addClass('focus');
		}else{
			$(this).removeClass('focus');
		}
	})
});
//阻止冒泡
function getEvent() {
    if (document.all) {
        return window.event; //如果是ie
    }
    func = getEvent.caller;
    while (func != null) {
        var arg0 = func.arguments[0];
        if (arg0) {
            if ((arg0.constructor == Event || arg0.constructor == MouseEvent) || (typeof(arg0) == "object" && arg0.preventDefault && arg0.stopPropagation)) {
                return arg0;
            }
        }
        func = func.caller;
    }
    return null;
}
function stopevt() {
    var event = event || window.event;
    if(event && event.stopPropagation){
        event.stopPropagation();
    }else{
        event.cancelBubble = true;
    }
    // var ev = getEvent();
    // if (ev.stopPropagation) {
    //     ev.stopPropagation();
    // } else if (window.ev) {
    //     window.ev.cancelBubble = true;
    // }
}
//弹窗点击空白地带关闭
function shadehide(){
	$('.shade-middle').click(function(){
		$(this).parent('.shade-box').remove();
		$('body').removeClass('noscroll');
	});
	$('.shade-main').click(function(){
		stopevt();
	});
	$('.close').click(function(){
		$(this).parents('.shade-box').remove();
		$('body').removeClass('noscroll');
	});
}
//注册部分tab切换
function signtab(){
	$('.sign-tab-hd li').click(function(){
		var liindex = $(this).index();
		$(this).addClass('on').siblings('li').removeClass('on');
		$('.sign-tab-bd').eq(liindex).addClass('show').siblings('.sign-tab-bd').removeClass('show');
		if($('.piccode').length != 0){
			$('#verifyCanvas').remove();
			verifyCode = new GVerify("code_0"+liindex);
		}
		
	});
    $('.sign-tab-hd li:first').addClass('on');
    $('.sign-tab-bd:first').addClass('show');
}
//弹窗tab切换
//function tab(){
//	$('.sign-tab-hd li').click(function(){
//		var liindex = $(this).index();
//		$(this).addClass('on').siblings('li').removeClass('on');
//		$('.sign-tab-bd').eq(liindex).addClass('show').siblings('.sign-tab-bd').removeClass('show');
//	});
//	$('.sign-tab-hd li:first').trigger('click');
//}
//弹窗
var shade = {
    loginshade:function(){//登录弹窗
        var that = $('body');
        var loginhtml = '<div class="shade-box loginbox">';//登录弹窗的结构
        loginhtml += '<div class="shade-middle">';
        loginhtml += '<div class="shade-inner">';
        loginhtml += '<div class="shade-main login animated"><span class="close"></span>';
        loginhtml += '<div class="shade-logo"><img id ="login_img" src="/new_style/img/public/shade_logo.png"/></div>';
        loginhtml += '<input class="input" id="_loginUsername" type="text" placeholder="请输入用户名/手机号/邮箱" onblur="_checkInput(this,[\'required\']);"/>';
        loginhtml += '<input class="input" id="_loginPassword" type="password" placeholder="请输入密码" onblur="_checkInput(this,[\'required\']);"/>';
        loginhtml += '<div class="login-opera clearfix">';
        loginhtml += '<input type="checkbox" class="checkbox" id="checkbox_01" />';
        loginhtml += '<label for="checkbox_01">记住密码</label>';
        loginhtml += '<a  class="login-opera-link regist" onclick="toRegister()">账号注册</a>';
        loginhtml += '</div>';
        loginhtml += '<span class="btn" onclick="_loginAjax()">登录</span>';
        loginhtml += '</div>';
        loginhtml += '</div>';
        loginhtml += '</div>';
        loginhtml += '</div>';
        //判断调用期望效果，显示弹窗还是隐藏弹窗
        if(that.find('.loginbox').length == 0){
            that.append(loginhtml);
            $('.loginbox').addClass('show');
            $('.login').addClass('show zoomIn');
            shadehide();
        }else{
            $('.loginbox').remove();
        }
    },

    signshade:function(){//注册弹窗
        var that = $('body');
        var signhtml = '<div class="shade-box signbox">';
        signhtml += '<div class="shade-middle">';
        signhtml +=	'<div class="shade-inner">';
        signhtml +=	'<div class="shade-main sign animated"><span class="close"></span>';
        signhtml +=	'<div class="sign-tab">';
        signhtml +=	'<ul class="sign-tab-hd clearfix">';
        signhtml +=	'<li>手机注册</li>';
        signhtml +=	'<li>邮箱注册</li>';
        signhtml +=	'</ul>';
        signhtml +=	'<div class="sign-tab-bd">';
        signhtml +=	'<input class="input" id="_regPhoneUsername" type="text" placeholder="请输入用户名" onblur="checkName(this)" required/>';
        signhtml +=	'<input class="input" id="_regPhonePhone" type="text" placeholder="请输入手机号" onblur="_checkInput(this,[\'required\',\'phone\',\'repeat\']);"/>';
        signhtml +=	'<input class="input" id="_regPhonePassword" type="password" placeholder="请输入密码" onblur="_checkInput(this,[\'required\']);"/>';
        signhtml +=	'<input class="input" id="_regPhoneConfirmPassword" type="password" placeholder="请再次输入密码" onblur="_confirmPassword(this,1);"/>';
        signhtml +=	'<div class="piccode-box clearfix">';
        signhtml +=	'<span class="piccode-input"><input class="input" id="_regPhoneCode" type="text" placeholder="请输入验证码" onblur="_checkInput(this,[\'required\']);"/></span>';
        signhtml +=	'<span class="piccode" id="code_00"></span>';
        signhtml +=	'</div>';
        signhtml +=	'<div class="login-opera clearfix small">';
        signhtml +=	'<input type="checkbox" class="checkbox" id="checkbox_01"/>';
        signhtml +=	'<label for="checkbox_01">阅读并接受</label>';
        signhtml +=	'<a class="link-article" href="#">《上海大学出版社用户注册协议》</a>';
        signhtml +=	'</div>';
        signhtml +=	'<span class="btn" onclick="_regAjax(1)" >确认注册</span>';
        signhtml +=	'</div>';
        signhtml +=	'<div class="sign-tab-bd">';
        signhtml +=	'<input class="input" id="_regEmailUsername" type="text" placeholder="请输入用户名" onblur="checkName(this);" required/>';
        signhtml +=	'<input class="input" id="_regEmailEmail" type="text" placeholder="请输入邮箱" onblur="_checkInput(this,[\'required\',\'email\',\'repeat\']);"/>';
        signhtml +=	'<input class="input" id="_regEmailPassword" type="password" placeholder="请输入密码" onblur="_checkInput(this,[\'required\']);"/>';
        signhtml +=	'<input class="input" id="_regEmailConfirmPassword" type="password" placeholder="请再次输入密码" onblur="_confirmPassword(this,2);"/>';
        signhtml +=	'<div class="piccode-box clearfix">';
        signhtml +=	'<span class="piccode-input"><input class="input" id="_regEmailCode" type="text" placeholder="请输入验证码" onblur="_checkInput(this,[\'required\']);"/></span>';
        signhtml +=	'<span class="piccode" id="code_01"></span>';
        signhtml +=	'</div>';
        signhtml +=	'<div class="login-opera clearfix small">';
        signhtml +=	'<input type="checkbox" class="checkbox" id="checkbox_02" />';
        signhtml +=	'<label for="checkbox_02">阅读并接受</label>';
        signhtml +=	'<a class="link-article" href="#">《上海大学出版社用户注册协议》</a>';
        signhtml +=	'</div>';
        signhtml +=	'<span class="btn" onclick="_regAjax(2)">确认注册</span>';
        signhtml +=	'</div>';
        signhtml +=	'</div>';
        signhtml +=	'</div>';
        signhtml +=	'</div>';
        signhtml += '</div>';
        signhtml += '</div>';
        //判断调用期望效果，显示弹窗还是隐藏弹窗
        if(that.find('.signbox').length == 0){
            that.append(signhtml);
            $('.signbox').addClass('show');
            $('.sign').addClass('show zoomIn');
            shadehide();
            signtab();

        }else{
            $('.signbox').remove();
        }
    },
    userInfoShade:function(imgurl){//编辑个人资料弹窗
        var that = $('body');
        var userInfohtml = '<div class="shade-box userinfobox">';
        userInfohtml += '<div class="shade-middle">';
        userInfohtml += '<div class="shade-inner">';
        userInfohtml += '<div class="shade-main userinfo animated"><span class="close"></span>';
        userInfohtml += '<div class="sign-tab">';
        userInfohtml += '<ul class="sign-tab-hd clearfix">';
        userInfohtml += '<li class="on">基本信息</li>';
        userInfohtml += '<li>头像编辑</li>';
        userInfohtml += '</ul>';
        userInfohtml += '<div class="sign-tab-bd show">';
        userInfohtml += '<input class="input" id="_upUsername" type="text" placeholder="请输入用户名" onchange="checkName(this)" required/>';
        userInfohtml += '<input class="input" id="_upEmail" type="text" placeholder="请输入邮箱" onblur="_checkInput(this,[\'required\',\'email\',\'repeat\']);" />';
        userInfohtml += '<input class="input" id="_upPhone" type="text" placeholder="请输入手机号" onblur="_checkInput(this,[\'required\',\'phone\',\'repeat\']);"/>';
        userInfohtml += '<span class="btn" onclick="return _updateUser(1)">保存</span>';
        userInfohtml += '</div>';
        userInfohtml += '<div class="sign-tab-bd">';
        userInfohtml += '<div class="header-change-box">';
        userInfohtml += '<img id="finalImg" src=';
        userInfohtml += imgurl;
        userInfohtml += ' />';
        userInfohtml += '</div>';
        userInfohtml += '<span class="btn" onclick="return _updateUser(2)">保存</span>';
        userInfohtml += '</div></div></div></div></div></div>';

        if(that.find('.userinfobox').length == 0){
            that.append(userInfohtml);
            $('.userinfobox').addClass('show');
            $('.userinfo').addClass('show zoomIn');
            shadehide();
            signtab();
            $('#finalImg').click(function(){
                $('#finalImg').imgCrop();
            });
        }else{
            $('.userinfobox').remove();
        }
    },
    addAddressShade:function(){
        var that = $('body');
        var addAddresshtml ='<div class="shade-box newAddressbox show">';
        addAddresshtml += '<div class="shade-middle">';
        addAddresshtml += '<div class="shade-inner">';
        addAddresshtml += '<div class="shade-main newAddress animated show"><span class="close"></span>';
        addAddresshtml += '<div class="shade-title">新增收货地址</div>';
        addAddresshtml += '<div class="address-edit">';
        addAddresshtml += '<ul>';
        addAddresshtml += '<input style="display: none" id="address_id_not_show" name="id"/>'
        addAddresshtml += '<li class="clearfix">';
        addAddresshtml += '<span class="address-label must">选择地区</span>';
        addAddresshtml += '<div class="address-input-box clearfix" id="area_box">';
        addAddresshtml += '<select class="address-select" id="province" name="province">';
        addAddresshtml += '</select>';
        addAddresshtml += '<select class="address-select" id="city" name="city">';
        addAddresshtml += '</select>';
        addAddresshtml += '<select class="address-select" id="area" name="area">';
        addAddresshtml += '</select>';
        addAddresshtml += '</div>';
        addAddresshtml += '</li>';
        addAddresshtml += '<li class="clearfix">';
        addAddresshtml += '<span class="address-label must">详细地址</span>';
        addAddresshtml += '<textarea class="address-text" id="add_new_address_address" placeholder="建议您如实填写详细收货地址，例如街道名称， 门牌号码，楼号和房间号等信息"></textarea>';
        addAddresshtml += '</li>';
        addAddresshtml += '<li class="clearfix">';
        addAddresshtml += '<span class="address-label">邮政编码</span>';
        addAddresshtml += '<input type="text" class="address-input" id="add_new_address_code" placeholder="如您不清楚邮递区号，请填写000000" />';
        addAddresshtml += '</li>';
        addAddresshtml += '<li class="clearfix">';
        addAddresshtml += '<span class="address-label must">收件人</span>';
        addAddresshtml += '<input type="text" class="address-input" id="add_new_address_receiver" placeholder="请输入收件人姓名" />';
        addAddresshtml += '</li>';
        addAddresshtml += '<li class="clearfix">';
        addAddresshtml += '<span class="address-label must">手机号</span>';
        addAddresshtml += '<input type="text" class="address-input" id="add_new_address_phone" placeholder="请输入收件人手机号" onblur="_checkInput(this,[\'required\',\'phone\']);"/>';
        addAddresshtml += '</li>';
        addAddresshtml += '</ul></div>';
        addAddresshtml += '<span class="btn" onclick="return address_submit()">保存</span>';
        addAddresshtml += '</div></div></div></div>';

        if(that.find('.newAddressbox').length == 0){
            that.append(addAddresshtml);
            $('.newAddressbox').addClass('show');
            $('.newAddress').addClass('show zoomIn');
            shadehide();
        }else{
            $('.newAddressbox').remove();
        }
    },
	warnShade:function(txt){
		var that = $('body');
		var warnHtml ='<div class="shade-box warnbox">';
			warnHtml += '<div class="shade-middle">';
			warnHtml += '<div class="shade-inner">';
			warnHtml += '<div class="shade-main warn animated"><span class="close"></span>';
			warnHtml += '<span class="close"></span>';
			warnHtml += '<p><img src="img/common/icon_warn.png"/></p>';
			warnHtml += '<p class="warn-word">';
			warnHtml += txt;
			warnHtml += '</p></div></div></div></div>';
			
			if(that.find('.warnbox').length == 0){
		    	that.append(warnHtml);
		    	that.addClass('noscroll');
		  		$('.warnbox').addClass('show');
		  		$('.warn').addClass('show zoomIn');
		  		shadehide();
		    }else{
		    	$('.warnbox').remove();
		    }
			
			
	},
	bookIntro:function(title,intro){
		var that = $('body');
		var introHtml ='<div class="shade-box bookDetailbox">';
			introHtml += '<div class="shade-middle">';
			introHtml += '<div class="shade-inner">';
			introHtml += '<div class="shade-main bookintroduce animated"><span class="close"></span><div class="book-intro-box">';
			introHtml += '<span class="close"></span>';
			introHtml += '<p class="book-intro-title">';
			introHtml += title;
			introHtml += '</p>';
			introHtml += '<div class="book-introduce">';
			introHtml += intro;
			introHtml += '</div></div></div></div></div></div>';
			if(that.find('.bookDetailbox').length == 0){
		    	that.append(introHtml);
		    	that.addClass('noscroll');
		  		$('.bookDetailbox').addClass('show');
		  		$('.bookintroduce').addClass('show zoomIn');
		  		shadehide();
		    }else{
		    	$('.bookDetailbox').remove();
		    }
	},
    pdfshade:function(pdf,src){

        var that = $('body');
        var pdfHtml ='<div class="shade-box pdfDetailbox">';
        pdfHtml += '<div class="shade-middle">';
        pdfHtml += '<div class="shade-inner">';
        pdfHtml += '<div class="shade-main pdfintroduce animated"><span class="close"></span>';
        pdfHtml += '<div class="pdfbox" id="pdfbox">';
        pdfHtml += '</div></div></div></div></div></div>';
        if(that.find('.bookDetailbox').length == 0){
            that.append(pdfHtml);
            that.addClass('noscroll');
            $('.pdfDetailbox').addClass('show');
            $('.pdfintroduce').addClass('show zoomIn');
            var options = {
//					forcePDFJS:true,
                PDFJS_URL: src
            };
            setTimeout(function(){
                PDFObject.embed(pdf,'#pdfbox',options);
            },400);


            shadehide();
        }else{
            $('.pdfDetailbox').remove();
        }
    }

}

if(navigator.appName == 'Microsoft Internet Explorer'){
    $('.book-right-list li:nth-child(3n)').css('margin-right','0px');
    $('.code:last-child').css('margin-right','0px');
    $('.new-list li:nth-child(2n)').css('margin-right','0px');
    $('.opera-list li:last-child').css('margin-right','0px');
    $('.contact-list li:last-child').css('margin-right','0px');
    $('.news-list li:nth-child(2n)').css('margin-right','0px');
    $('.link-list-box .link-list:last-child').css('margin-right','0px');
}




