(function($){   
    $.fn.extend({     
         imgCrop: function() {   
		    let cropHtml = '<div class="tailoring-container">';
				cropHtml +='<div class="tailoring-middle">';
				cropHtml +='<div class="tailoring-content">';
				cropHtml +='<div class="tailoring-content-one">';
				cropHtml +='<label title="上传图片" for="chooseImg" class="l-btn choose-btn">';
				cropHtml +='<input type="file" accept="image/jpg,image/jpeg,image/png" name="file" id="chooseImg" class="hidden">';
				cropHtml +='选择图片';
				cropHtml +='</label>';
				cropHtml +='<div class="close-tailoring">×</div>';
				cropHtml +='</div>';
				cropHtml +='<div class="tailoring-content-two">';
				cropHtml +='<div class="tailoring-box-parcel">';
				cropHtml +='<img id="tailoringImg">';
				cropHtml +='</div>';
				cropHtml +='<div class="preview-box-parcel">';
				cropHtml +='<p>图片预览：</p>';
				cropHtml +='<div class="square previewImg"></div>';
				cropHtml +='<div class="circular previewImg"></div>';
				cropHtml +='</div>';
				cropHtml +='</div>';
				cropHtml +='<div class="tailoring-content-three">';
				cropHtml +='<button class="l-btn sureCut" id="sureCut">确定</button>';
				cropHtml +='</div>';
				cropHtml +='</div>';
				cropHtml +='</div>';
				cropHtml +='</div>';
				
			$('body').append(cropHtml);
			
			$('#chooseImg').change(function(e){
				selectImg(this)
			});
			function selectImg(file){
				if (!file.files || !file.files[0]){
					console.log(1)
		            return;
		        }
		        var reader = new FileReader();
		        reader.onload = function (evt) {
		            var replaceSrc = evt.target.result;
		            //更换cropper的图片
		            $('#tailoringImg').cropper('replace', replaceSrc,false);//默认false，适应高度，不失真
		        }
		        reader.readAsDataURL(file.files[0]);
			}
			$('#tailoringImg').cropper({
		        aspectRatio: 1/1,//默认比例
		        preview: '.previewImg',//预览视图
		        guides: false,  //裁剪框的虚线(九宫格)
		        autoCropArea: 0.5,  //0-1之间的数值，定义自动剪裁区域的大小，默认0.8
		        movable: false, //是否允许移动图片
		        dragCrop: true,  //是否允许移除当前的剪裁框，并通过拖动来新建一个剪裁框区域
		        movable: true,  //是否允许移动剪裁框
		        resizable: true,  //是否允许改变裁剪框的大小
		        zoomable: false,  //是否允许缩放图片大小
		        mouseWheelZoom: false,  //是否允许通过鼠标滚轮来缩放图片
		        touchDragZoom: true,  //是否允许通过触摸移动来缩放图片
		        rotatable: true,  //是否允许旋转图片
		        crop: function(e) {
		            // 输出结果数据裁剪图像。
		        }
		    });
		    $("#sureCut").on("click",function () {
		        if ($("#tailoringImg").attr("src") == null ){
		            return false;
		        }else{
		            var cas = $('#tailoringImg').cropper('getCroppedCanvas');//获取被裁剪后的canvas
		            var base64url = cas.toDataURL('image/png'); //转换为base64地址形式
		            $("#finalImg").prop("src",base64url);//显示为图片的形式
		
		            //关闭裁剪框
		            $(".tailoring-container").remove();
		        }
		    });
		    $('.close-tailoring').click(function(){
		    	  $(".tailoring-container").remove();
		    });
        },
        
    });   
       
})(jQuery);
