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
				<div class="menav">
					<div class="center">
						<ul>
								<li><a href="${ctx}/userinfo/baseinfo" ><img src=""><p>个人信息</p></a></li>
								<li><a href="${ctx}/userinfo/attentioninfo" ><img src=""><p>我的关注</p></a></li>
								<li><a href="${ctx}/userinfo/userregisterinfo"><img src=""><p>我的预约</p></a></li>
								<li><a href="${ctx}/userinfo/userconsultinfo"><img src=""><p>我的咨询</p></a></li>
								<li><a href="${ctx}/userinfo/reportinfo"><img src=""><p>我的报告</p></a></li>
								<li><a href="${ctx}/userinfo/useroutpatientinfo"><img src=""><p>我的门诊</p></a></li>
								<li><a href="${ctx}/userinfo/palyinfo"><img src=""><p>我的缴费</p></a></li>
								<li><a href="${ctx}/userinfo/orderinfo"><img src=""><p>我的订单</p></a></li>
								<li><a href="${ctx}/userinfo/newscollectinfo"><img src=""><p>我的收藏</p></a></li>
								<!-- 	<li><a href=""><img src=""><p>健康记录评估</p></a></li> -->
								<li><a href="${ctx}/userinfo/healthFile"   class="on"><img src=""><p>我的健康档案</p></a></li>
								<li><a href="${ctx}/xnh/init""><img src=""><p>新农合</p></a></li>
						</ul>
					</div>



				</div>
				<div class="jkd">
					<div class="center">
						<ul>
							<li><a href="${ctx}/userinfo/HealthRecordsController/healthrecords">健康记录</a></li>
							<li><a href="${ctx}/userinfo/shiYanShiJianCha/shiYanShiJianChaInfo">检查记录</a></li>
							<li><a href="${ctx}/userinfo/chronicillness/SugarDiabetesAskInfo">慢病记录</a></li>
							<li><a href="${ctx}/userinfo/JiuZhenXinXiController/jiuzhenInfo">门诊记录</a></li>
							<li><a href="${ctx}/userinfo/aduitMedical/aduitMedicalInfo">体检记录</a></li>
							<li><a href="${ctx}/userinfo/inhospitaldruginfo/InHospitalInfo">住院记录</a></li>
						</ul>
					</div>






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

var i = 0;
$(".jkd li a").each(function(){ 
		
		$(this).css("background-image","url(${ctxStaticFront}/images/da"+i+".png)")
		i++;

})




</script>



</body>
</html>
