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
			<div class="mefixd">
				<div class="menav">
					<div class="center">
						<ul>
								<li><a href="${ctx}/userinfo/baseinfo" ><img src=""><p>个人信息</p></a></li>
								<li><a href="${ctx}/userinfo/attentioninfo"><img src=""><p>我的关注</p></a></li>
								<li><a href="${ctx}/userinfo/userregisterinfo"><img src=""><p>我的预约</p></a></li>
								<li><a href="${ctx}/userinfo/userconsultinfo"><img src=""><p>我的咨询</p></a></li>
								<li><a href="${ctx}/userinfo/reportinfo" class="on"><img src=""><p>我的报告</p></a></li>
								<li><a href="${ctx}/userinfo/useroutpatientinfo"><img src=""><p>我的门诊</p></a></li>
								<li><a href="${ctx}/userinfo/palyinfo" ><img src=""><p>我的缴费</p></a></li>
								<li><a href="${ctx}/userinfo/orderinfo"  ><img src=""><p>我的订单</p></a></li>
								<li><a href="${ctx}/userinfo/newscollectinfo"><img src=""><p>我的收藏</p></a></li>
								<!-- 	<li><a href=""><img src=""><p>健康记录评估</p></a></li> -->
								<li><a href="${ctx}/userinfo/healthFile""><img src=""><p>我的健康档案</p></a></li>
								<li><a href="${ctx}/xnh/init""><img src=""><p>新农合</p></a></li>

						</ul>
					</div>
					</div>
				</div>
						<div class="gywm">
							<div class="center">
									<div class="l">
										<div class="Gnavbar" style="">
											<ul style="">
												<li><a href="" class="opacity on">报告详情</a></li>
												<li><a href="" class="opacity">报告图片</a></li>
											
											</ul>

										</div>
									</div>
									<div class="r">
											<div class="block_name mtt"> 
							
														
														<p class="">我的报告</p>
														<div class="brd"></div>
											</div>
											<div class="Gselect on">
												<table  cellspacing="0" cellpadding="0" >
												   <c:forEach items="${userreport}" var="report">
												   <c:set var="reportItemList" value="${fnf:getreportItemById(report.reportid)}"/>
															<tr>
																<td width="25%" align="center">报告名称</td>
																<td width="75%" align="center">${report.checkname}</td>
															</tr>
															<c:forEach items="${reportItemList}" var="reportItem">
															<tr class="Rnone"><td><p></p></td><td></td></tr>
															<tr>
																<td width="25%" align="center">检查名称</td>
																<td width="75%" align="center">${reportItem.reportItemName}</td>
															</tr>
															<tr>
																<td width="25%" align="center">参考值</td>
																<td width="75%" align="center">${reportItem.reportItemReferenceValue}</td>
															</tr>
															<tr>
																<td width="25%" align="center">结果值</td>
																<td width="75%" align="center">${reportItem.reportItemValue}</td>
															</tr>
															<tr>
																<td width="25%" align="center">单位</td>
																<td width="75%" align="center">${reportItem.reportItemUnit}</td>
															</tr>
															<tr>
																<td width="25%" align="center">检查部位</td>
																<td width="75%" align="center">${reportItem.reportSite}</td>
															</tr>
															<tr>
																<td width="25%" align="center">描述信息</td>
																<td width="75%" align="center">${reportItem.reportInfo}</td>
															</tr>
															</c:forEach>
															
												</table>

											</div>
											<div class="Gselect">
													<div class="Board">
														<img alt="报告图片" src="${ctxStaticFront}/${report.contentpicsrc}">
														
													</div>
											</div>
											</c:forEach>
											
									</div>
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
$(".Gselect.on").fadeIn()

function muo(o){ 

		if($(".Gselect.on").height() > $(".Gnavbar").height()){ 
		 o = $(".Gselect.on").height() + 143
		}else{ 
		 o = $(".Gnavbar").height() + 143
		}
		return o ;
}

$(".gywm").height(muo())
$(".Gnavbar li").each(function(){ 


	
		var i = $(this).index()
		var a = $(".Gselect:eq("+i+")")
		$(this).click(function(){ 
			if(!$(this).find("a").hasClass("on")){ 
			$(".Gselect.on").fadeOut().removeClass("on")
			$(".Gnavbar li a.on").removeClass("on")
			a.fadeIn().addClass("on")
			$(this).find("a").addClass("on")
			var ma  = muo();
			$(".gywm").animate({ 
					"height":ma
			})
			}
		})
	
})

</script>

</body>
</html>