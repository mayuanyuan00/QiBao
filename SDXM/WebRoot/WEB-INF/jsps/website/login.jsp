<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

		<script type="text/javascript" src="${pageContext.request.contextPath}/websit_style/js/jquery.SuperSlide.2.1.1.source.logintab.js" ></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/websit_style/js/gverify.js" ></script>

		<div class="login" style="display:none;">
				<div class="login_BG"></div>
				<div class="login_content">
					<h4>用户登录</h4>
					<ul class="login_list">
						<li class="login_list_acount">
							<p>用户名</p>
							<input id="_loginUsername" type="text" placeholder="请输入用户名/手机号/邮箱" onblur="_checkInput(this,['required']);"/>
						</li>
						<li class="login_list_password">
							<p>密码</p>
							<input id="_loginPassword" type="password" placeholder="请输入密码" onblur="_checkInput(this,['required']);"/>
						</li>
					</ul>
					<div class="login_remember_password">
						<div class="login_remember_password_checkbox">
							<input id="_loginRemember" type="checkbox" />
						</div>
						记住密码
					</div>
					<div class="login_forget_password">忘记密码</div>
					<input type="button" value="登录" class="login_btn_big" onclick="_loginAjax()"/>
				</div>
			</div><!--登录框-->
			<div class="logon" style="display:none;">
				<div class="logon_BG"></div>
				<div class="logon_content">
					<div class="logon_tab">
						<div class="logon_tab_title">
							<ul class="clearfix"><li>手机注册</li><li>邮箱注册</li></ul>
						</div>
						<div class="logon_tab_content">
							<ul>
								<li>
									<ul class="logon_phone_list clearfix">
										<li class="logon_phone_list_acount">
											<div><i>用户名</i><span></span></div>
											<input id="_regPhoneUsername" type="text" placeholder="请输入用户名" onblur="_checkInput(this,['required','repeat']);"/>
										</li>
										<li class="logon_phone_list_phone">
											<div><i>手机号</i><span></span></div>
											<input id="_regPhonePhone" type="text" placeholder="请输入手机号" onblur="_checkInput(this,['required','phone','repeat']);"/>
										</li>
										<li class="logon_phone_list_password">
											<div><i>密码</i><span></span></div>
											<input id="_regPhonePassword" type="password" placeholder="请输入密码" onblur="_checkInput(this,['required']);"/>
										</li>
										<li class="logon_phone_list_password_again">
											<div><i>确认密码</i><span></span></div>
											<input id="_regPhoneConfirmPassword" type="password" placeholder="请再次输入密码" onblur="_confirmPassword(this,1);"/>
										</li>
										<li class="logon_phone_list_verification_code">
											<div><i>验证码</i><span></span></div>
											<input id="_regPhoneCode" type="text" placeholder="请输入验证码" onblur="_checkInput(this,['required']);"/>
											<img id = "verifycode1" onclick="changeImg()" src="${pageContext.request.contextPath}/user/verifycode.do">
										</li>
									</ul>
									<div class="logon_protocol">
										<div class="logon_protocol_checkbox_container">
											<input type="checkbox" />
										</div>
										<p>阅读并接受<a href="###">《上海大学出版社用户注册协议》</a></p>
										<input type="button" value="确认注册" class="logon_btn_phone" onclick="_regAjax(1)"/>
									</div>
								</li>
							</ul>
							<ul>
								<li>
									<ul class="logon_phone_list clearfix">
										<li class="logon_phone_list_acount">
											<div><i>用户名</i><span></span></div>
											<input id="_regEmailUsername" type="text" placeholder="请输入用户名" onblur="_checkInput(this,['required']);"/>
										</li>
										<li class="logon_phone_list_phone">
											<div><i>邮箱号</i><span></span></div>
											<input id="_regEmailEmail" type="text" placeholder="请输入邮箱" onblur="_checkInput(this,['required','email','repeat']);"/>
										</li>
										<li class="logon_phone_list_password">
											<div><i>密码</i><span></span></div>
											<input id="_regEmailPassword" type="password" placeholder="请输入密码" onblur="_checkInput(this,['required']);"/>
										</li>
										<li class="logon_phone_list_password_again">
											<div><i>确认密码</i><span></span></div>
											<input id="_regEmailConfirmPassword" type="password" placeholder="请再次输入密码" onblur="_confirmPassword(this,2);"/>
										</li>
										<li class="logon_phone_list_verification_code">
											<div><i>验证码</i><span></span></div>
											<input id="_regEmailCode" type="text" placeholder="请输入验证码" onblur="_checkInput(this,['required']);"/>
											<img id = "verifycode2" onclick="changeImg()" src="${pageContext.request.contextPath}/user/verifycode.do">
										</li>
									</ul>
									<div class="logon_protocol">
										<div class="logon_protocol_checkbox_container">
											<input type="checkbox" />
										</div>
										<p>阅读并接受<a href="###">《上海大学出版社用户注册协议》</a></p>
										<input type="button" value="确认注册" class="logon_btn_email" onclick="_regAjax(2)"/>
									</div>
								</li>
							</ul>
						</div>
					</div>
				</div>
			</div><!--注册框-->
			

			<script>
			
			function changeImg(){
				var img1 = document.getElementById("verifycode1"); 
		        var img2 = document.getElementById("verifycode2"); 
		        img1.src = "${pageContext.request.contextPath}/user/verifycode.do?date=" + Date.parse(new Date());
		        img2.src = "${pageContext.request.contextPath}/user/verifycode.do?date=" + Date.parse(new Date());
		    }
         
			$('.nav_list_first li').click(function(){
				$(this).addClass('on').siblings().removeClass('on');
				var liindex = $(this).index();
				$('.nav_second_list:eq('+liindex+')').slideDown().siblings('.nav_second_list').hide();
			});
			
			//登录按钮
			$('.login').hide();
			$('.login_btn').click(function(){
				$('.login').show();
			});
			
			$('.login_btn_big').click(function(){
				$('.login').hide();
			});
			
			//注册按钮
			$('.logon').hide();
			$('.logon_btn').click(function(){
				$('.logon').show();
			});
			$('.logon_btn_phone,.logon_btn_email').click(function(){
				$('.logon').hide();
			});
			
			//点击黑暗处关闭弹窗
			$('.login_BG').click(function(){
				$('.login').hide();
			});
			$('.logon_BG').click(function(){
				$('.logon').hide();
			});
			
			//注册方式切换
			jQuery(".logon_tab").slide({trigger:"click"});
			
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
				data.verifycode = $(_pre+"Code").val();
				if (!_isblank(data.username) 
						|| !_isblank(data.password) 
						|| !_isblank(data.verifycode)) {
					alert("请填写必填字段");
					return;
				}
				
				// ajax
				$.post("${pageContext.request.contextPath}/user/register.do",
						data,function(result){
							if(result == "success"){
								alert("注册成功");
							}else if (result == "verifycode") {
								$(_pre+"Code").css("border-color","#DC143C");
								alert("验证码错误");
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
				debugger;
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
							 return false;
						}
					}
				});
			}

			
		</script>