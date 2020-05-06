$(function(){
	var ctxsys=$("#ctxsys").val();
	var ctxStatic=$("#ctxStatic").val();
	var alltransferAmount=0;
	var allsubsidyAmount=0;
	for (var i= 0; i < $('.transferAmount').length; i++) {
		alltransferAmount+=parseFloat($($('.transferAmount')[i]).text())
	}
	for (var i= 0; i < $('.subsidyAmount').length; i++) {
		allsubsidyAmount+=parseFloat($($('.subsidyAmount')[i]).text())
	}
	
	$('#no').text($('.transferAmount').length+1)
	$('#transferAmountcount').text(alltransferAmount.toFixed(2))
	$('#subsidyAmountcount').text(allsubsidyAmount.toFixed(2))
	
	$('.getExsel').click(function(){
		var ctxweb=$("#ctxweb").val();
	    $.ajax({
	    		type : "POST",
			    data:{},
			    url : ctxsys+"/UserAmtLog/userOfflineRechargeLogExsel",   
			    success : function (data) {
			    	window.location.href=data;
			    }
	    });
    });
	
	$('body').on('click','.lookimg',function(){
		var id=$(this).attr("id");
		$.ajax({
		    type:'post',
		    contentType:"application/x-www-form-urlencoded;charset=UTF-8",
		    url:ctxsys+"/UserAmtLog/lineRechargeimg",
		    datatype:"json",
		    data:{
		       	id:id
		    },
		    success:function(data){
		    	var obj = eval('(' + data + ')');
		    	if(obj.flag=false){
		    	}else{
		    		var html="";
		    		arr=obj.imgs.split(',');
		    		for(var i=0;i<arr.length;i++){
		    			if(arr[i]==""){
		    				html+='<div class="swiper-slide"></div>';
		    			}else{
		    				html+='<div class="swiper-slide"><img src="'+arr[i]+'"></div>';
		    			}
		    		}
		    		$('.swiper-wrapper').html(html);
		    		$('.lishi-img').show();
		    		var mySwiper = new Swiper('#banner', {
		    			pagination : '.swiper-pagination',
		    			autoHeight:true,
		    			autoplay: 3000,
		    		})
		    	}
		    }
		});
	})
	$('body').on('click','.lishi-del-img',function(){
		$('.lishi-img').hide();
	})
	
	$('body').on('click','.yes',function(){
		var id=$(this).attr("id");
		var status=$(this).attr("status");
		if(status==1){
			$('.tip').html('确认审核<img class="lishi-del-yes" src="'+ctxStatic+'/hAdmin/img/xxx-rzt.png" alt="">');
			$('.tip-y').text('确定同意该申请？');
			$('.post-y').html('<a class="btn btn-primary" href="'+ctxsys+'/UserAmtLog/lineRechargeEdit?re=0&status=1&id='+id+'">同意</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a class="btn btn-primary lishi-del-yes" href="javascript:;">取消</a>');
		}
		if(status==3){
			$('.tip').html('确认完成<img class="lishi-del-yes" src="'+ctxStatic+'/hAdmin/img/xxx-rzt.png" alt="">');
			$('.tip-y').text('确定已充值完成？');
			$('.post-y').html('<a class="btn btn-primary" href="'+ctxsys+'/UserAmtLog/lineRechargeEdit?re=0&status=3&id='+id+'">同意充值</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a class="btn btn-primary lishi-del-yes" href="javascript:;">取消</a>');
		}
		if(status==5){
			$('.tip').html('确认退款<img class="lishi-del-yes" src="'+ctxStatic+'/hAdmin/img/xxx-rzt.png" alt="">');
			$('.tip-y').text('确定已退款完成？');
			$('.post-y').html('<a class="btn btn-primary" href="'+ctxsys+'/UserAmtLog/lineRechargeEdit?re=0&status=5&id='+id+'">退款完成</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a class="btn btn-primary lishi-del-yes" href="javascript:;">取消</a>');
		}
		$('.lishi-yes').show();
	})
	$('body').on('click','.lishi-del-yes',function(){
		$('.lishi-yes').hide();
	})
	
	$('body').on('click','.no',function(){
		var id=$(this).attr("id");
		var status=$(this).attr("status");
		$('#id').val(id);
		$('#status-n').val(status);
		$('.lishi-no').show();
	})
	$('body').on('click','.lishi-del-no',function(){
		$('.lishi-no').hide();
	})
	
	$('body').on('click','.post-n',function(){
		$("#postForm").attr("action",ctxsys+"/UserAmtLog/lineRechargeEdit?re=1");
		$("#postForm").submit();
	})
});