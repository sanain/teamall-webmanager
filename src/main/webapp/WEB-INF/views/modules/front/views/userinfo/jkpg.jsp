<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/front/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<meta name="decorator" content="frontdefault"/>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title></title>
	<meta name="keywords" content="" />
	<meta name="description" content="" />
</head>
<body>
<div id="content" class="Mee"> 
	<div class="mefixd">
		<div class="menav">
			<div class="center">
				<ul>
					<li><a href="${ctx}/userinfo/baseinfo" class="on"><img src=""><p>个人信息</p></a></li>
					<li><a href="${ctx}/userinfo/attentioninfo"><img src=""><p>我的关注</p></a></li>
					<li><a href="${ctx}/userinfo/userregisterinfo"><img src=""><p>我的预约</p></a></li>
					<li><a href="${ctx}/userinfo/userconsultinfo"><img src=""><p>我的咨询</p></a></li>
					<li><a href="${ctx}/userinfo/reportinfo"><img src=""><p>我的报告</p></a></li>
					<li><a href="${ctx}/userinfo/useroutpatientinfo"><img src=""><p>我的门诊</p></a></li>
					<li><a href="${ctx}/userinfo/palyinfo"><img src=""><p>我的缴费</p></a></li>
					<li><a href="${ctx}/userinfo/orderinfo"><img src=""><p>我的订单</p></a></li>
					<li><a href="${ctx}/userinfo/newscollectinfo"><img src=""><p>我的收藏</p></a></li>
					<!-- 	<li><a href=""><img src=""><p>健康记录评估</p></a></li> -->
					<li><a href="${ctx}/userinfo/healthFile""><img src=""><p>我的健康档案</p></a></li>
					<li><a href="${ctx}/xnh/init""><img src=""><p>新农合</p></a></li>
					<%--<li><a href="${ctx}/jkpg/init""><img src=""><p>健康评估</p></a></li>--%>
				</ul>
			</div>
		</div>
	</div>
	<div class="met" >
		<iframe src="http://jkpg.jkscw.com.cn" width="100%" height="100%">不支持</iframe>
	</div>
</div>

<script type="text/javascript">
$(".menav li").each(function(a){ 
	var me = $(".menav li:eq("+a+")"),i=a+1;
	if(me.find("a").hasClass("on")){ 
		me.find("img").attr("src","${ctxStaticFront}/images/me_"+i+"h.png")
	}else{ 
		me.find("img").attr("src","${ctxStaticFront}/images/me_"+i+".png")
	}
	me.hover(function(){ 
		me.find("img").attr("src","${ctxStaticFront}/images/me_"+i+"h.png")
	},function(){ 
		if(!me.find("a").hasClass("on")){ 
			me.find("img").attr("src","${ctxStaticFront}/images/me_"+i+".png")
		}
	})
})

</script>
</body>
</html>
