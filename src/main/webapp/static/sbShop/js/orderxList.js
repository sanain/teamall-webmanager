$(function(){
	$('body').on('click','.lishi-del-img',function(){
		$('.lishi-img').hide();
	})
	$('body').on('click','.lookimg',function(){
		var id=$(this).attr("id");
		$.ajax({
		    type:'post',
		    contentType:"application/x-www-form-urlencoded;charset=UTF-8",
		    url:$("#ctxsys").val()+"/Order/listximgs",
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
});