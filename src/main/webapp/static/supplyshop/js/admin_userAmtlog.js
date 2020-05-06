$(function(){
	var ctxsys=$("#ctxsys").val();
	$('body').on('click','.no',function(){
		var id=$(this).attr("amtLogid");
		$('#id-n').val(id);
		$.ajax({
            type: "POST",
            url: ctxsys+"/UserAmtLog/userListest",
            data: {},
            success: function(data){
              $('#remark').val(data);
             }
	      });
		
		$('.lishi-no').show();
	})
	$('body').on('click','.lishi-del-no',function(){
		$('.lishi-no').hide();
	})
	$('body').one('click','.post-n',function(){
		 $.ajax({
			    type : "POST",
			    data:{id:$('#id-n').val(),Vstatus:2,remark:$("#remark").val()},
			    url : ctxsys+"/UserAmtLog/edit",
			    beforeSend: function(){
				     loading('请等待。。');
				    },
			    success : function (data) {
			       alertx('操作成功');
			        page();
			    }
	         });
		//$("#noForm").attr("action",ctxsys+"/UserAmtLog/edit?Vstatus=2");
		//$("#noForm").submit();
	})
	
	$('body').on('click','.yes',function(){
		var id=$(this).attr("amtLogid");
		$('#id-y').val(id);
		$('.lishi-yes').show();
	})
	$('body').on('click','.lishi-del-yes',function(){
		$(this).closest('.lishi-yes').hide();
		$(this).closest('.pi-yes').hide();
	})
	
	$('.check-a2').click(function(){
		var id_array=new Array();  
		$('.kl-to[type=checkbox]:checked').each(function(){  
		    id_array.push($(this).val());//向数组中添加元素  
		});
		if(id_array!=null&&id_array.length>0){
			$('.pi-yes').show();
		}else{
			alert("至少选择一条");
		}
		
	});
})