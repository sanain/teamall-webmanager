$(function(){
	if($('#advertuseImgPreview').children('li:nth-child(1)').text()=='无'){
		$('#advertuseImgPreview').children('li:nth-child(1)').text('')
	}
    $('.fit-btn-a').click(function(){
    	var lamoduleTitle=$("#lamoduleTitle").val();
    	var orderNo=$("#orderNo").val();
    	var advertiseType=$("#advertiseType").val();
    	var advertuseImg=$("#advertuseImg").val();
    	var advertiseTitle=$("#advertiseTitle").val();
    	var sellPrice=$("#sellPrice").val();
    	var charitySize=$("#charitySize").val();
    	
    	$(this).parents('form').find('input[type=text]').css("border", "1px solid #a9a9a9");
    	if(lamoduleTitle==""){
			$("#lamoduleTitle").css("border", "1px solid red");
			alert("请填写模块名称！");
			return false;
		}else if(orderNo==""){
			$("#orderNo").css("border", "1px solid red");
			alert("请填排序！");
			return false;
		}else if(advertiseType==""){
			alert("请填选择广告类型！");
			return false;
		}/*else if(advertiseType!=""){
			if(advertiseType=="3"){
				if(advertuseImg==""){
					alert("请填选择图片！");
					return false;
				}
			}
		}*/else if(advertiseTitle==""){
			$("#advertiseTitle").css("border", "1px solid red");
			alert("请填写标题！");
			return false;
		}else if(sellPrice==""){
			$("#sellPrice").css("border", "1px solid red");
			alert("请填写价格！");
			return false;
		}else if(charitySize==""){
			$("#charitySize").css("border", "1px solid red");
			alert("请填写红包数量！");
			return false;
		}else{
			var frm =document.forms[0];
			frm.submit();
		}
    });
})