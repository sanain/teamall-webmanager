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
	 <style>
   .gywm .r .block_name {
    margin: 20px 0px;
     margin-right: 300px;
        margin-bottom: 29px;
        margin-left: 0px;
   }
 </style>
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
								<li><a href="${ctx}/userinfo/reportinfo"><img src=""><p>我的报告</p></a></li>
								<li><a href="${ctx}/userinfo/useroutpatientinfo"><img src=""><p>我的门诊</p></a></li>
								<li><a href="${ctx}/userinfo/palyinfo"><img src=""><p>我的缴费</p></a></li>
								<li><a href="${ctx}/userinfo/orderinfo"><img src=""><p>我的订单</p></a></li>
								<li><a href="${ctx}/userinfo/newscollectinfo"><img src=""><p>我的收藏</p></a></li>
								<!-- 	<li><a href=""><img src=""><p>健康记录评估</p></a></li> -->
								<li><a href="${ctx}/userinfo/healthFile" class="on"><img src=""><p>我的健康档案</p></a></li>
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
											<li ><a href="" class="opacity on">个人信息</a></li>
												<li ><a href="" class="opacity" id="yaowu">药物过敏史</a></li>
												<li><a href="" class="opacity">遗传病史</a></li>
												<li><a href="" class="opacity">家族疾病史</a></li>
												<li><a href="" class="opacity">个人残疾史</a></li>
												<li><a href="" class="opacity">个人输血史</a></li>
												<li><a href="" class="opacity">个人患病史</a></li>
												<li><a href="" class="opacity">个人外伤史</a></li>
												<li><a href="" class="opacity">个人手术史</a></li>
											</ul>

										</div>
									</div>
									<div class="r">
											<div class="block_name mtt"> 
							
														
														<p class="">健康记录</p>
														<div class="brd"></div>
											</div>
											<div class="Gselect on">
												<table  cellspacing="0" cellpadding="0">
													             <tr>
													             <td width="25%" align="center">患者姓名</td>
																 <td width="75%" class="indent">${hisUser.name}</td>
																 </tr>
																  <tr>
																<td width="25%" align="center">个人身份证</td>
																<td width="75%" class="indent">${hisUser.idCard}</td>
															      </tr>
																 <tr>
																<td width="25%" align="center">联系电话</td>
																<td width="75%" class="indent">${hisUser.phone}</td>
																 </tr>
																 <tr>
																<td width="25%" align="center">患者性别</td>
																 <c:if test="${hisUser.sex=='' || hisUser.sex == null}">
																	<td width="75%" class="indent">未知</td>
																 </c:if>
																 <c:if test="${hisUser.sex=='1'}">
																	<td width="75%" class="indent">男</td>
																 </c:if>
																 <c:if test="${hisUser.sex=='2'}">
																	<td width="75%" class="indent">女</td>
																 </c:if>
																 <c:if test="${hisUser.sex=='3'}">
																	<td width="75%" class="indent">其它</td>
																 </c:if>
															 </tr>
															  <tr>
																<td width="25%" align="center">出生日期</td>
																<td width="75%" class="indent">${hisUser.birthTime}</td>
																</tr>
																 <tr>
																<td width="25%" align="center">工作单位</td>
																<td width="75%" class="indent">${hisUser.company}</td>
																</tr>
																 <tr>
																<td width="25%" align="center">文化程度</td>
																<td width="75%" class="indent">${hisUser.educationLevel}</td>
												                 </tr>
												</table>

											</div>
											<div class="Gselect">
												<table  cellspacing="0" cellpadding="0">
												 <c:forEach items="${guominshiList}" var="guominshi">
													  <tr>
																<td width="25%" align="center">过敏源名称</td>
																<td width="75%" class="indent">${guominshi.anaphylactogenName}</td>
												      </tr>
												  </c:forEach>
												                <c:if test="${empty guominshiList}">
												                <tr>
												                  <td width="25%" align="center">过敏源名称</td>
												                  <td width="75%" class="indent"></td>
												                </tr>
												                </c:if>
												</table>

											</div>
											<div class="Gselect">
												<table  cellspacing="0" cellpadding="0">
												  <c:forEach items="${yichuanbing}" var="yichuanb">
													       <tr>
																<td width="25%" align="center">遗传病史名称</td>
																<td width="75%" class="indent">${yichuanb.geneticDiseaseName}</td>
															</tr>
															<tr>
																<td width="25%" align="center">遗传病描述</td>
																<td width="75%" class="indent">${yichuanb.geneticDiseaseDescription}</td>
															</tr>
												  </c:forEach>
												  <c:if test="${empty yichuanbing}">
												      <tr>
																<td width="25%" align="center">遗传病史名称</td>
																<td width="75%" class="indent"></td>
															</tr>
															<tr>
																<td width="25%" align="center">遗传病描述</td>
																<td width="75%" class="indent"></td>
															</tr>
												  </c:if>
												</table>

											</div>
											<div class="Gselect">
												<table  cellspacing="0" cellpadding="0">
													       <c:forEach items="${jiazushiList}" var="jiazushi">
													       <tr>
																<td width="25%" align="center">配偶性别</td>
																<td width="75%" class="indent">${jiazushi.spouseSex}</td>
															</tr>
															<tr>
																<td width="25%" align="center">家族性疾病名</td>
																<td width="75%" class="indent">${jiazushi.familialDiseaseName}</td>
															</tr>
															</c:forEach>
															<c:if test="${empty jiazushiList}">
															    <tr>
																<td width="25%" align="center">配偶性别</td>
																<td width="75%" class="indent"></td>
															</tr>
															<tr>
																<td width="25%" align="center">家族性疾病名</td>
																<td width="75%" class="indent"></td>
															</tr>
															</c:if>
												</table>

											</div>
											<div class="Gselect">
												<table  cellspacing="0" cellpadding="0">
												     <c:forEach items="${canjishiList}" var="canjishi">
													        <tr>
																<td width="25%" align="center">残疾情况名称</td>
																<td width="75%" class="indent">${canjishi.disabilityName}</td>
															</tr>
												     </c:forEach>
												     <c:if test="${empty canjishiList}">
												          <tr>
																<td width="25%" align="center">残疾情况名称</td>
																<td width="75%" class="indent"></td>
															</tr>
												     </c:if>	
												</table>

											</div>
											<div class="Gselect">
												<table  cellspacing="0" cellpadding="0">
												       <c:forEach items="${shuxueshiList}" var="shuxueshi">
													       <tr>
																<td width="25%" align="center">输血时间</td>
																<td width="75%" class="indent">${shuxueshi.transfusionDate}</td>
															</tr>
															<tr>
																<td width="25%" align="center">输血原因</td>
																<td width="75%" class="indent">${shuxueshi.transfusionReason}</td>
															</tr>
															<tr>
																<td width="25%" align="center">输血原因描述</td>
																<td width="75%" class="indent">${shuxueshi.transfusionReasonDescription}</td>
															</tr>
                                                      </c:forEach>
                                                      <c:if test="${empty shuxueshiList}">
                                                               <tr>
																<td width="25%" align="center">输血时间</td>
																<td width="75%" class="indent"></td>
															</tr>
															<tr>
																<td width="25%" align="center">输血原因</td>
																<td width="75%" class="indent"></td>
															</tr>
															<tr>
																<td width="25%" align="center">输血原因描述</td>
																<td width="75%" class="indent"></td>
															</tr>
                                                             
                                                      
                                                      </c:if>
												</table>

											</div>
											<div class="Gselect">
												<table  cellspacing="0" cellpadding="0">
												    <c:forEach items="${huobingList}" var="huobing">
													        <tr>
																<td width="25%" align="center">既往患病时间</td>
																<td width="75%" class="indent">${huobing.pastHistoryDate}</td>
															</tr>
															<tr>
																<td width="25%" align="center">既往患病名称</td>
																<td width="75%" class="indent">${huobing.pastHistoryName}</td>
															</tr>
												      </c:forEach>
												      <c:if test="${empty huobingList}">
												            <tr>
																<td width="25%" align="center">既往患病时间</td>
																<td width="75%" class="indent"></td>
															</tr>
															<tr>
																<td width="25%" align="center">既往患病名称</td>
																<td width="75%" class="indent"></td>
															</tr>
												      
												      </c:if>
												</table>
											</div>
											<div class="Gselect">
												<table  cellspacing="0" cellpadding="0">
												    <c:forEach items="${waishangList}" var="waishang">
													        <tr>
																<td width="25%" align="center">外伤史</td>
																<td width="75%" class="indent">${waishang.traumaHistory}</td>
															</tr>
															<tr>
																<td width="25%" align="center">外伤史时间</td>
																<td width="75%" class="indent">${waishang.traumaHistoryDate}</td>
															</tr>
															<tr>
																<td width="25%" align="center">外伤史具体描述</td>
																<td width="75%" class="indent">${waishang.traumaHistoryDescription}</td>
															</tr>
												      </c:forEach>
												      <c:if test="${empty waishangList}">
												      <tr>
																<td width="25%" align="center">外伤史</td>
																<td width="75%" class="indent"></td>
															</tr>
															<tr>
																<td width="25%" align="center">外伤史时间</td>
																<td width="75%" class="indent"></td>
															</tr>
															<tr>
																<td width="25%" align="center">外伤史具体描述</td>
																<td width="75%" class="indent"></td>
															</tr>
												      
												      </c:if>
												</table>
											</div>
											<div class="Gselect">
												<table  cellspacing="0" cellpadding="0">
												    <c:forEach items="${shoushushiList}" var="shoushushi">
													        <tr>
																<td width="25%" align="center">手术史</td>
																<td width="75%" class="indent">${shoushushi.operationHistory}</td>
															</tr>
															<tr>
																<td width="25%" align="center">手术史时间</td>
																<td width="75%" class="indent">${shoushushi.operationHistoryDate}</td>
															</tr>
												      </c:forEach>
												      <c:if test="${empty shoushushiList}">
												           <tr>
																<td width="25%" align="center">手术史</td>
																<td width="75%" class="indent"></td>
															</tr>
															<tr>
																<td width="25%" align="center">手术史时间</td>
																<td width="75%" class="indent"></td>
															</tr>
												      
												      </c:if>
												</table>
											</div>

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
