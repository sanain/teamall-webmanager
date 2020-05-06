<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="decorator" content="default" />
<title>商家消息</title>
<link rel="stylesheet" href="${ctxStatic}/sbShop/css/in-email.css">
<link rel="stylesheet" href="${ctxStatic}/sbShop/layui/css/layui.css">
<link rel="stylesheet" href="${ctxStatic}/sbShop/css/build.css">
<script src="${ctxStatic}/sbShop/js/jquery.min.js"></script>
<script src="${ctxStatic}/sbShop/layui/layui.js"></script>
<script src="${ctxStatic}/sbShop/js/base_form.js"></script>
<link rel="stylesheet" href="${ctxStatic}/sbShop/css/bootstrap.min.css">
<script>
	$(window.parent.document).find('.list-ul').find('ul').slideUp();
	$(window.parent.document).find('.list-ul').find('a').removeClass('active');
</script>

<style>
.left {
	float: left;
}

.right {
	float: right;
}

.clearfix:before, .clearfix:after {
	display: table;
	content: " ";
}

.clearfix:after {
	clear: both;
}

.clearfix {
	*zoom: 1;
}
.nav-tabs{border-bottom:1px solid #e5e5e5;height:40px;}
.nav-tabs>.active>a {
	border-top: 3px solid #009688;
	color: #009688;
}  

.nav-tabs ul li a {
	color: #000;
}
.nav-tabs ul{margin-bottom:0;}
.nav-tabs ul li{float:left;height:40px;line-height:40px;width:120px;text-align:center;}
.nav-tabs ul .active a{color:#009688;}
.nav-tabs ul .active{border-top:3px solid #009688;height:40px;background:#fff;border-left:1px solid #e5e5e5;border-right:1px solid #e5e5e5;border-radius:2px;}
a {
	color: #009688;
}

a:hover {
	color: #009688;
}

.list-box>a {
	color: #009688;
}

body {
	background: #f5f5f5;
}

#searchForm {
	border: 3px solid #fff;
}
</style>
</head>
<script type="text/javascript">
$(function(){ 
	$('.in-top ul li').click(function(){
	       $(this).addClass('active').siblings().removeClass('active')
	       $(".email-list").empty();
	   })

	    var del;
	    $('body').on('click','.delete-a',function(){
	        $('.delete').show();
	        del=$(this)
	    });
	    $('.delete-yes').click(function(){
	    	var ids=$(del).attr("ids");
	    	delByIds(ids);
	        del.closest('.list-box').remove();
	        $('.delete').hide();
	    });
	    $('.delete-del').click(function(){
	        $('.delete').hide();
	    });
});

var type=${messageType};
function page(n,s){
			if(n) $("#pageNo").val(n);
			if(s) $("#pageSize").val(s);
			$("#searchForm").attr("action","${ctxweb}/shop/message/messageList?messageType="+type+"");
			$("#searchForm").submit();
	    	return false;
	    }

function selectType(mtype){
	type=mtype;
	page();
}

function delByIds(ids){
	$.post("${ctxweb}/shop/message/deleteService",{ids:ids},function(result){
	    return true;
	  });
	
}

function clearall(){
	$.post("${ctxweb}/shop/message/deleteService",{type:type},function(result){
		$('.email-list').remove();
		page();
	  });
}
	
function showDetail(messageType,messageObjId){
	//  1、物流消息；2、退款消息；3、角色消息；4、人脉消息；5、系统消息；6、发货提醒；7、 结算提醒；8、退货/售后提醒；9、系统公告；
	var url="";
	if(messageType=="1"||messageType=="6"||messageType=="8"){
		if(messageObjId!=""){
			url="${ctxweb}/shop/PmShopOrders/orderDetail?orderId="+messageObjId+"";
			window.location.href=url;
		}else{
			alert("订单号不存在！");
		}
	}else if(messageType=="7"){
		//url="${ctxweb}/shop/message/myAccount";
		//window.location.href=url;
	}
	
}
</script>

<body style="background:#f5f5f5;">
	<div style="color:#999;margin:19px 0 17px 30px;">
		<span>当前位置：</span><span style="color:#009688;">消息通知</span>
	</div>
	<div class="in-email">
		<form action="" id="searchForm" method="post">
			<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}" />
			<input id="pageSize" name="pageSize" type="hidden"
				value="${page.pageSize}" />
			<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}"
				callback="page();" />
			<div class="nav-tabs">
				<ul class="clearfix">
					<li class="${mTypeClass1}"><a href="javascript:;"onclick="selectType('1')">会员消息</a></li>
					<li class="${mTypeClass2}"><a href="javascript:;"onclick="selectType('2')">收益消息</a></li>
					<li class="${mTypeClass3}"><a href="javascript:;"onclick="selectType('3')">系统公告</a></li>
				</ul>
				<a class="del-email" href="javascript:;" onclick="clearall();">清空消息</a>
			</div>
		</form>




		<!--消息列表-->
		<div class="email-list">
			<c:forEach items="${page.list}" var="pc">
				<div class="list-box">
					<div class="clearfix"
						style="border-bottom:1px solid #e5e5e5;padding-bottom:13px;">
						<span class="left"><b
							style="margin-right:5px;position:relative;top:-1px;"><img
								src="${ctxStatic}/sbShop/images/notice-img1.png"
								style="width:17px;" /></b>${pc.messageInfo.messageTitle}</span> <span
							class="clearfix right"> <span class="left"
							style="font-size:13px;color:#666;margin-right:25px;line-height:22px;"><fmt:formatDate
									value="${pc.createTime}" pattern="yyyy-MM-dd HH:mm:ss" /></span> <img
							ids="${pc.id}" class="delete-a"
							src="${ctxStatic}/sbShop/images/xxx-rzt.png" alt="">
						</span>
					</div>
					<div>
						<p>${pc.messageInfo.messageContent}</p>
					</div>
					<c:if
						test="${pc.messageInfo.messageType==1||pc.messageInfo.messageType==2||pc.messageInfo.messageType==6||pc.messageInfo.messageType==8}">
						<a href="javascript:;"
							onclick="showDetail('${pc.messageInfo.messageType}','${pc.messageInfo.messageObjId}');">查看详情
						</a>
					</c:if>
				</div>
			</c:forEach>
		</div>


		<!--分页-->

	</div>
	<div class="pagination">${page}</div>

	<!--是否删除-->
	<div class="delete">
		<div class="delete-box">
			<p>
				提示 <img class="delete-del"
					src="${ctxStatic}/sbShop/images/xxx-rzt.png" alt="">
			</p>
			<div>
				<p>确定要删除该消息吗？</p>
				<a class="delete-yes" href="javascript:;">确定</a> <a
					class="delete-del" href="javascript:;">取消</a>
			</div>
		</div>
	</div>
</body>
</html>