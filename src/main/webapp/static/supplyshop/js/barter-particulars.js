$(function(){
    var listright=$('.shop-list');
    for (i=0;i<listright.length;i++){
        var he=parseInt($(listright[i]).children('li:first-child').height());
        for (j=1;j<$(listright[i]).children('li').length;j++){
            $(listright[i]).children('li:nth-child('+(j+1)+')').css('line-height',he+20+'px')
        }
    }
    $('.refuse-a').click(function(){
        $('.refuse').show();
    });
    $('.refuse-del').click(function(){
    	$("#recordContent").css("border", "1px solid #a9a9a9");
        $('.refuse').hide();
    });
    $('.consent-a').click(function(){
        $('.consent').show();
    });
    $('.consent-del').click(function(){
        $('.consent').hide();
    });
    $('body').on('click','.store-as',function(){
    	var aftersaleid=$("#aftersaleid").val();
    	var recordContent=$("#recordContent").val();
    	var path=$("#path").val();
    	if(aftersaleid==""){
    		alert("页面错误,请刷新！");
    	}else if(path==""){
    		alert("页面错误,请刷新！");
    	}else if(recordContent==""){
    		$("#recordContent").css("border", "1px solid red");
    		alert("请填拒绝理由！");
    	}else{
	    	$.ajax({
		    	type:'post',
		      	contentType:"application/x-www-form-urlencoded;charset=UTF-8",
		    	url:path+"/shop/ReturnManagement/ReturnManagementEdit",
		       	datatype:"json",
		       	data:{
		       		aftersaleid:aftersaleid,
		       		recordContent:recordContent
		       	},
		       	success:function(data){}
	    	});
    	}
    });
    $('body').on('click','.store-bc',function(){
    	var aftersaleid=$("#aftersaleid").val();
    	var path=$("#path").val();
    	if(aftersaleid==""){
    		alert("页面错误,请刷新！");
    	}else if(path==""){
    		alert("页面错误,请刷新！");
    	}else{
	    	$.ajax({
		    	type:'post',
		      	contentType:"application/x-www-form-urlencoded;charset=UTF-8",
		    	url:path+"/shop/ReturnManagement/returnManagementAffirm",
		       	datatype:"json",
		       	data:{
		       		aftersaleid:aftersaleid,
		       	},
		       	success:function(data){}
	    	});
    	}
    });
})