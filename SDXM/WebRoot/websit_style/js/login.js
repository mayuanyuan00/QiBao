	
			var verifyCode = new GVerify("piccodebox_01");
			
			$('.logon_tab_title li').click(function(){
				$('#verifyCanvas').remove();
				var liindex = parseInt($(this).index())+1;
				var verifyCode = new GVerify("piccodebox_0"+liindex); 
			});

			/*$('.nav_list_first li').click(function(){
				$(this).addClass('on').siblings().removeClass('on');
				var liindex = $(this).index();
				$('.nav_second_list:eq('+liindex+')').slideDown().siblings('.nav_second_list').hide();
			});*/
			
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
			//jQuery(".logon_tab").slide({trigger:"click"});