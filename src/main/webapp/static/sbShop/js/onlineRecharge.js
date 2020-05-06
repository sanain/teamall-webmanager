$(function(){
	var ctxsys=$("#ctxsys").val();
	var alll=0;
	for (var i= 0; i < $('.amt').length; i++) {
		alll+=parseFloat($($('.amt')[i]).text())
	}
	$('#no').text($('.amt').length+1)
	$('#count').text(alll.toFixed(2))
	
	$('body').on('click','.add-show',function(){
		$('.lishi-add').show();
	})
	$('body').on('click','.lishi-del-add',function(){
		$('.lishi-add').hide();
	})
	
	$('body').on('click','.userinfo',function(){
		$('.userlist').show();
	})
	$('body').on('click','.del-userlist',function(){
		$('.userlist').hide();
	})
	
	$('body').on('click','.postmoblie',function(){
		$('#addmobile').val($(this).closest('tr').children('td:nth-child(2)').text());
		$('#addmobiles').val($(this).closest('tr').children('td:nth-child(6)').text());
		$('.userlist').hide();
	})
	
	$('body').on('dblclick','.postmoblie-tr',function(){
		$('#addmobile').val($(this).children('td:nth-child(2)').text());
		$('.userlist').hide();
	})
	
	$('body').one('click','.add',function(){
		$("#addForm").attr("action",ctxsys+"/UserAmtLog/onlineRechargeAdd");
		$("#addForm").submit();
	})
	
	
	$('body').on('click','.adds-show',function(){
		$('.lishi-adds').show();
	})
	$('body').on('click','.lishi-del-adds',function(){
		$('.lishi-adds').hide();
	})
	$('body').one('click','.adds',function(){
		var contents=$("#contents").val();
		$.ajax({
		    type:'post',
		    contentType:"application/x-www-form-urlencoded;charset=UTF-8",
		    url:ctxsys+"/UserAmtLog/onlineRechargeadds",
		    datatype:"json",
		    data:{
		    	contents:contents
		    },
		    success:function(data){
		    	var obj = eval('(' + data + ')');
		    	if(obj.flag==true){
		    		alert(obj.msg)
		    		window.location.href=obj.url;
		    	}else{
		    		alert(obj.msg)
		    		window.location.href=obj.url;
		    	}
		    }
		});
	})
});
function timeStamp2String (time){
	var datetime = new Date();
    datetime.setTime(time);
    var year = datetime.getFullYear();
    var month = datetime.getMonth() + 1;
    var date = datetime.getDate();
    var hour = datetime.getHours();
    var minute = datetime.getMinutes();
    var second = datetime.getSeconds();
    var mseconds = datetime.getMilliseconds();
    return year + "-" + month + "-" + date+"&nbsp;&nbsp;"+hour+":"+minute+":"+second;
};

function userPage(no){
	userPage();
}

function userPage(no){
	var ctxsys=$("#ctxsys").val();
	var usermobile=$("#usermobile").val();
	var userstatus=$("#userstatus").val();
//	var pageCount=$("#pageCount").val();
	var userpageSize=$("#userpageSize").val();
	$.ajax({
		type:'post',
		contentType:"application/x-www-form-urlencoded;charset=UTF-8",
		url:ctxsys+"/UserAmtLog/userPage",
		datatype:"json",
		data:{
			usermobile:usermobile,
			userstatus:userstatus,
			userpageNo:no,
//			pageCount:pageCount,
			userpageSize:userpageSize
		},
		success:function(data){
			var obj = eval('(' + data + ')');
			if(obj.flag==true){
				var userpageNo=Number(obj.userpageNo);
				html='';
				html+='<form class="breadcrumb form-search" style="margin-bottom: 1px">';
				html+='<ul class="ul-form">';
				html+='<li><input value="'+obj.usermobile+'" id="usermobile" name="usermobile" type="text" maxlength="11" placeholder="会员账号"/></li>';
				html+='<li><select id="userstatus" name="userstatus" class="input-medium">';
				if(obj.userstatus==""){
					html+='<option selected="selected" value="">会员状态</option>';
					html+='<option value="1">使用会员</option>';
					html+='<option value="2">禁用会员</option>';
				}
				if(obj.userstatus=="1"){
					html+='<option value="">会员状态</option>';
					html+='<option selected="selected" value="1">使用会员</option>';
					html+='<option value="2">禁用会员</option>';
				}
				if(obj.userstatus=="2"){
					html+='<option value="">会员状态</option>';
					html+='<option value="1">使用会员</option>';
					html+='<option selected="selected" value="2">禁用会员</option>';
				}
				html+='<select></li>';
				html+='<li><input class="btn btn-primary" style="width: 58px" value="查询" onclick="userPage();"/></li></ul>';
				html+='</form>';
				html+='<div class="table-div">';
				html+='<div class="table-div-a">';
				html+='<table id="treeTable" class="table table-striped table-condensed">';
				html+='<tr><th></th><th>会员账号</th><th>昵称</th><th>联系电话</th><th>邀请码</th><th>冻结积分</th><th>性别</th><th>注册时间</th><th>操作</th></tr>';
				for(var i in obj.userlist){
					var ebUser=obj.userlist[i];
					html+='<tr class="postmoblie-tr">';
					html+='<td>'+(Number(i)+1)+'</td>';
					html+='<td>'+ebUser.mobile+'</td>';
					html+='<td>'+ebUser.username+'</td>';
					html+='<td>'+ebUser.mobile+'</td>';
					html+='<td>'+ebUser.cartNum+'</td>';
					html+='<td>'+ebUser.frozenLove+'</td>';
					html+='<td>';
					if(ebUser.sex==0){
						html+='保密';
					}
					if(ebUser.sex==1){
						html+='男';
					}
					if(ebUser.sex==2){
						html+='女';
					}
					html+='</td>';
					var strdate2 = timeStamp2String(ebUser.createtime.time);
					html+='<td>'+strdate2+'</td>';
					html+='<td><a class="postmoblie" href="javascript:;">选择</a></td>';
					html+='</tr>';
				}
				html+='</table></div>';
				html+='<div class="pagination">';
				html+='<input id=pageCount name="pageCount" type="hidden" value="'+obj.pageCount+'"/>';
				html+='<ul>';
				if(obj.userpageNo==1){
					html+='<li class="disabled"><a href="javascript:;">« 上一页</a></li>';
				}
				if(obj.userpageNo>1){
					html+='<li><a href="javascript:;" onclick="userPage('+(userpageNo-1)+');">« 上一页</a></li>';
				}
				if(userpageNo-2>0){
					html+='<li><a href="javascript:;" onclick="userPage('+(userpageNo-2)+');">'+(obj.userpageNo-2)+'</a></li>';
				}
				if(userpageNo-1>0){
					html+='<li><a href="javascript:;" onclick="userPage('+(userpageNo-1)+');">'+(userpageNo-1)+'</a></li>';
				}
				html+='<li class="active"><a href="javascript:;">'+obj.userpageNo+'</a></li>';
				if(userpageNo+1<=obj.pageCount){
					html+='<li><a href="javascript:;" onclick="userPage('+(userpageNo+1)+');">'+(userpageNo+1)+'</a></li>';
				}
				if(userpageNo+2<=obj.pageCount){
					html+='<li><a href="javascript:;" onclick="userPage('+(userpageNo+2)+');">'+(userpageNo+2)+'</a></li>';
				}
				if(obj.pageCount==obj.userpageNo){
					html+='<li class="disabled"><a href="javascript:;">下一页 »</a></li>';
				}
				if(obj.pageCount>obj.userpageNo){
					html+='<li><a href="javascript:;" onclick="userPage('+(userpageNo+1)+');">下一页 »</a></li>';
				}
				html+='<li class="disabled controls">';
				html+='<a href="javascript:;">当前 <input type="number" value="'+obj.userpageNo+'" style="width: 40px">/<input id="userpageSize" type="number" value="'+obj.userpageSize+'" style="width: 40px">条，共 '+obj.userCount+'条</a>';
				html+='</li><li></li>';
				html+='</ul>';
				html+='<div style="clear:both;"></div></div></div>';
				$(".userlist-body").html(html).show();
			}else{
				html='';
				html+='<form class="breadcrumb form-search" style="margin-bottom: 1px">';
				html+='<ul class="ul-form">';
				html+='<li><input value="'+obj.usermobile+'" id="usermobile" name="usermobile" type="text" maxlength="11" placeholder="会员账号"/></li>';
				html+='<li><select id="userstatus" name="userstatus" class="input-medium">';
				if(obj.userstatus==""||obj.userstatus==undefined){
					html+='<option selected="selected" value="">会员状态</option>';
					html+='<option value="1">使用会员</option>';
					html+='<option value="2">禁用会员</option>';
				}
				if(obj.userstatus=="1"){
					html+='<option value="">会员状态</option>';
					html+='<option selected="selected" value="1">使用会员</option>';
					html+='<option value="2">禁用会员</option>';
				}
				if(obj.userstatus=="2"){
					html+='<option value="">会员状态</option>';
					html+='<option value="1">使用会员</option>';
					html+='<option selected="selected" value="2">禁用会员</option>';
				}
				html+='<select></li>';
				html+='<li><input class="btn btn-primary" style="width: 58px" value="查询" onclick="return userPage();"/></li></ul>';
				html+='</form>';
				html+='<div class="table-div">';
				html+='<div class="table-div-a">';
				html+='<table id="treeTable" class="table table-striped table-condensed">';
				html+='<tr><th></th><th>会员账号</th><th>昵称</th><th>联系电话</th><th>邀请码</th><th>性别</th><th>注册时间</th><th>操作</th></tr>';
				html+='</table></div>';
				html+='<div class="pagination">';
				html+='<input id=pageCount name="pageCount" type="hidden" value="'+obj.pageCount+'"/>';
				html+='<ul>';
				if(obj.userpageNo==1){
					html+='<li class="disabled"><a href="javascript:;">« 上一页</a></li>';
				}
				if(obj.userpageNo>1){
					html+='<li><a href="javascript:;">« 上一页</a></li>';
				}
				if(obj.userpageNo-2>0){
					html+='<li><a href="javascript:;" onclick="userPage();">'+(obj.userpageNo-2)+'</a></li>';
				}
				if(obj.userpageNo-1>0){
					html+='<li><a href="javascript:;" onclick="userPage();">'+(userpageNo-1)+'</a></li>';
				}
				html+='<li class="active"><a href="javascript:;" onclick="userPage();">'+obj.userpageNo+'</a></li>';
				if(userpageNo+1<=obj.pageCount){
				html+='<li><a href="javascript:;" onclick="userPage();">'+(userpageNo+1)+'</a></li>';
				}
				if(userpageNo+2<=obj.pageCount){
					html+='<li><a href="javascript:;" onclick="userPage();">'+(userpageNo+2)+'</a></li>';
				}
				if(obj.pageCount==obj.userpageNo){
					html+='<li class="disabled"><a href="javascript:;">下一页 »</a></li>';
				}
				if(obj.pageCount>obj.userpageNo){
					html+='<li><a href="javascript:;" onclick="userPage('+(userpageNo+1)+');">下一页 »</a></li>';
				}
				html+='<li class="disabled controls">';
				html+='<a href="javascript:;">当前 <input type="number" value="'+obj.userpageNo+'" style="width: 40px">/<input id="userpageSize" type="number" value="'+obj.userpageSize+'" style="width: 40px">条，共 '+obj.userCount+'条</a>';
				html+='</li><li></li>';
				html+='</ul>';
				html+='<div style="clear:both;"></div></div></div>';
				$(".userlist-body").html(html).show();
			}
		}
	});
}