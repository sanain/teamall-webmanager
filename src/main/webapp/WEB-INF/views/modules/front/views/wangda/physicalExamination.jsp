<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/front/include/taglib.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
								<li><a href="${ctx}/userinfo/baseinfo" ><img src=""><p>个人信息</p></a></li>
								<li><a href="${ctx}/userinfo/attentioninfo" class="on"><img src=""><p>我的关注</p></a></li>
								<li><a href="${ctx}/userinfo/userregisterinfo"><img src=""><p>我的预约</p></a></li>
								<li><a href="${ctx}/userinfo/userconsultinfo"><img src=""><p>我的咨询</p></a></li>
								<li><a href="${ctx}/userinfo/reportinfo"><img src=""><p>我的报告</p></a></li>
								<li><a href="${ctx}/userinfo/useroutpatientinfo"><img src=""><p>我的门诊</p></a></li>
								<li><a href="${ctx}/userinfo/palyinfo"><img src=""><p>我的缴费</p></a></li>
								<li><a href="${ctx}/userinfo/orderinfo"><img src=""><p>我的订单</p></a></li>
								<li><a href="${ctx}/userinfo/newscollectinfo"><img src=""><p>我的收藏</p></a></li>
								<!-- 	<li><a href=""><img src=""><p>健康记录评估</p></a></li> -->
								<li><a href="${ctx}/userinfo/healthFile""><img src=""><p>我的健康档案</p></a></li>
						</ul>
					</div>

					</div>

				</div>
				<div class="block_name mtt" style="margin:20px 0;"> 
							<p class="">体检记录</p>
							<div class="brd"></div>
				</div>
				<div class="met mtn enone">
						<div class="center" >
								<table cellspacing="0" ceelpadding='0' style="width:730px;margin:0 auto">
									<tr class="tr1"><td width="95px" class="num">序号</td>
										<td width="155px">体检时间</td>
										<td width="245px">体检医院</td>
										<td >操作</td>
									</tr>
									<c:forEach items="${page.list }" var="aduitMedical" varStatus="varStatus" >	
									<tr class="tr1">
											<td class="num">${varStatus.index+1}</td>
											<td>${aduitMedical.testTime }</td>
											<td>${aduitMedical.buildCardOrgName }</td>
											<td><a href="" id="${aduitMedical.id}" class="chakan">查看</a></td>
									</tr>
								</c:forEach>


								</table>




						</div>
					



				</div>
			


	<div class="page pgb">${page}</div>

		</div>
		<div class="clear"></div>
	
<script type="text/javascript">


$(".menav li").each(function(a){ 
		var me = $(".menav li:eq("+a+")"),i=a+1;
		me.find("img").attr("src","${ctxStaticFront}/images/me_"+i+".png")
		me.hover(function(){ 
			me.find("img").attr("src","${ctxStaticFront}/images/me_"+i+"h.png")
		},function(){ 
			me.find("img").attr("src","${ctxStaticFront}/images/me_"+i+".png")

		})
})



$("a.chakan").on("click",function(){ 
	layer.open({ 
			  type: 2,
			    title: '体检报告详情',
			    shadeClose: true,
			    shade: 0.8,
			    area : [ '900px', '600px' ],
			    content : '${ctx}/userinfo/aduitMedical/physicalExaminationDetails?id='+$(this).attr("id")

	})





})
</script>



</body>
</html>
