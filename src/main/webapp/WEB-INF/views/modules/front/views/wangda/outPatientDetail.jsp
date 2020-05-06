<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/front/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<meta name="decorator" content="frontdefault"/>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>wd-我的门诊</title>
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
<script type="text/javascript" src="${ctxStaticFront}/js/jquery.cascadingdropdown.js"></script>
<body >	
<div id="content" class="Mee"> 
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
						<div class="gywm" id="menjl">
							<div class="center">
									<div class="l">
										<div class="Gnavbar" style="">
											<ul style="">
												<li ><a href="" class="opacity on" id="yaowu">健康评估</a></li>
												<li><a href="" class="opacity">门诊摘要</a></li>
												<li><a href="" class="opacity">就诊信息</a></li>
												<li><a href="" class="opacity">医学初值</a></li>
												<li><a href="" class="opacity">手术史操作</a></li>
												<li><a href="" class="opacity">诊断记录</a></li>
												<li><a href="" class="opacity">门诊处方-治疗计划</a></li>
												<li><a href="" class="opacity">门诊处方-用药</a></li>
												<li><a href="" class="opacity">门诊病历-症状</a></li>
												<li><a href="#menjl" class="opacity">门诊病历-转诊过程</a></li>
												<li><a href="#menjl" class="opacity">门诊病历-转诊建议</a></li>
												<li><a href="#menjl" class="opacity">门诊病历-主要健康问题</a></li>
											</ul>

										</div>
									</div>
									<div class="r">
											<div class="block_name mtt"> 
							
														
														<p class="">门诊记录</p>
														<div class="brd"></div>
											</div>
											<div class="Gselect on">
												<table  cellspacing="0" cellpadding="0">
												 <c:forEach items="${pingguList}" var="pinggu">
													  <tr>
																<td width="25%" align="center">健康问题评估</td>
																<td width="75%" class="indent">${pinggu.healthAssessment}</td>
												      </tr>
												      <tr>
																<td width="25%" align="center">结果描述</td>
																<td width="75%" class="indent">${pinggu.resultDescription}</td>
													   </tr>
											      </c:forEach>
											      <c:if test="${empty pingguList}">
											       <tr>
																<td width="25%" align="center">健康问题评估</td>
																<td width="75%" class="indent"></td>
												      </tr>
												      <tr>
																<td width="25%" align="center">结果描述</td>
																<td width="75%" class="indent"></td>
													   </tr>
											      
											      </c:if>
												</table>

											</div>
											<div class="Gselect">
												<table  cellspacing="0" cellpadding="0">
												    <c:forEach items="${jkzdList}" var="jkzd">
													       <tr>
																<td width="25%" align="center">康复指导措施</td>
																<td width="75%" class="indent">${jkzd.rehabilitationInstruction}</td>
															</tr>
												    </c:forEach>
												    <c:if test="${empty jkzdList}">
												     <tr>
																<td width="25%" align="center">康复指导措施</td>
																<td width="75%" class="indent"></td>
															</tr>
												    
												    </c:if>
												</table>

											</div>
											<div class="Gselect">
												<table  cellspacing="0" cellpadding="0">
												   <c:forEach items="${jiuzhenInfoList}" var="jiuzhenInfo">
													       <tr>
																<td width="25%" align="center">就诊医生</td>
																<td width="75%" class="indent">${jiuzhenInfo.doctorName}</td>
															</tr>
															<tr>
																<td width="25%" align="center">就诊人联系电话</td>
																<td width="75%" class="indent">${jiuzhenInfo.phone}</td>
															</tr>
															<tr>
																<td width="25%" align="center">就诊机构</td>
																<td width="75%" class="indent">${jiuzhenInfo.visitOrgName}</td>
															</tr>
															<tr>
																<td width="25%" align="center">就诊科室</td>
																<td width="75%" class="indent">${jiuzhenInfo.visitDepName}</td>
															</tr>
												    </c:forEach>
												    <c:if test="${empty jiuzhenInfoList}">
												          <tr>
																<td width="25%" align="center">就诊医生</td>
																<td width="75%" class="indent"></td>
															</tr>
															<tr>
																<td width="25%" align="center">就诊人联系电话</td>
																<td width="75%" class="indent"></td>
															</tr>
															<tr>
																<td width="25%" align="center">就诊机构</td>
																<td width="75%" class="indent"></td>
															</tr>
															<tr>
																<td width="25%" align="center">就诊科室</td>
																<td width="75%" class="indent"></td>
															</tr>
												    
												    </c:if>
												</table>

											</div>
											<div class="Gselect">
												<table  cellspacing="0" cellpadding="0">
												     <c:forEach items="${qitachuzhiList}" var="qitachuzhi">
													        <tr>
																<td width="25%" align="center">其他医学处置</td>
																<td width="75%" class="indent">${qitachuzhi.otherMedical}</td>
															</tr>
															<tr>
																<td width="25%" align="center">其他医学处置描述</td>
																<td width="75%" class="indent">${qitachuzhi.otherMedicalTreatment}</td>
															</tr>
													   </c:forEach>
													  <c:if test="${empty qitachuzhiList}">
													        <tr>
																<td width="25%" align="center">其他医学处置</td>
																<td width="75%" class="indent"></td>
															</tr>
															<tr>
																<td width="25%" align="center">其他医学处置描述</td>
																<td width="75%" class="indent"></td>
															</tr>
													  </c:if> 
												</table>

											</div>
											<div class="Gselect">
												<table  cellspacing="0" cellpadding="0">
												    <c:forEach items="${shoushucaozuoList}" var="shoushucaozuo">
													       <tr>
																<td width="25%" align="center">手术名称</td>
																<td width="75%" class="indent">${shoushucaozuo.surgeryName}</td>
															</tr>
															<tr>
																<td width="25%" align="center">操作名称</td>
																<td width="75%" class="indent">${shoushucaozuo.operationName}</td>
															</tr>
													</c:forEach>
													<c:if test="${empty shoushucaozuoList}">
													      <tr>
																<td width="25%" align="center">手术名称</td>
																<td width="75%" class="indent"></td>
															</tr>
															<tr>
																<td width="25%" align="center">操作名称</td>
																<td width="75%" class="indent"></td>
															</tr>
													
													
													</c:if>
												</table>

											</div>
											<div class="Gselect">
												<table  cellspacing="0" cellpadding="0">
												     <c:forEach items="${zdjlList}" var="zhenduanjilu">
													        <tr>
																<td width="25%" align="center">诊断名称</td>
																<td width="75%" class="indent">${zhenduanjilu.diagnosticName}</td>
															</tr>
															<tr>
																<td width="25%" align="center">诊断日期</td>
																<td width="75%" class="indent">${zhenduanjilu.diagnosticDate}</td>
															</tr>
														     <tr>
																<td width="25%" align="center">诊断结果</td>
																<td width="75%" class="indent">${zhenduanjilu.diagnosticResult}</td>
															</tr>
													  </c:forEach>
													  <c:if test="${empty zdjlList}">
													         <tr>
																<td width="25%" align="center">诊断名称</td>
																<td width="75%" class="indent"></td>
															</tr>
															<tr>
																<td width="25%" align="center">诊断日期</td>
																<td width="75%" class="indent"></td>
															</tr>
														     <tr>
																<td width="25%" align="center">诊断结果</td>
																<td width="75%" class="indent"></td>
															</tr>
													  
													  
													  </c:if>
												</table>
											</div>
											<div class="Gselect">
												<table  cellspacing="0" cellpadding="0">
												   <c:forEach items="${zljhList}" var="zhiliaojihua">
													        <tr>
																<td width="25%" align="center">处置计划</td>
																<td width="75%" class="indent">${zhiliaojihua.disposalPlan}</td>
															</tr>
															<tr>
																<td width="25%" align="center">处置计划描述</td>
																<td width="75%" class="indent">${zhiliaojihua.disposalPlanDescription}</td>
															</tr>
															<tr>
																<td width="25%" align="center">治疗方案</td>
																<td width="75%" class="indent">${zhiliaojihua.treatmentPlan}</td>
															</tr>
															<tr>
																<td width="25%" align="center">治疗方案描述</td>
																<td width="75%" class="indent">${zhiliaojihua.treatmentPlanDescription}</td>
															</tr>
													</c:forEach>
													<c:if test="${empty zljhList}">
													      <tr>
																<td width="25%" align="center">处置计划</td>
																<td width="75%" class="indent"></td>
															</tr>
															<tr>
																<td width="25%" align="center">处置计划描述</td>
																<td width="75%" class="indent"></td>
															</tr>
															<tr>
																<td width="25%" align="center">治疗方案</td>
																<td width="75%" class="indent"></td>
															</tr>
															<tr>
																<td width="25%" align="center">治疗方案描述</td>
																<td width="75%" class="indent"></td>
															</tr>
													
													</c:if>
												</table>
											</div>
											<div class="Gselect">
												<table  cellspacing="0" cellpadding="0">
												    <c:forEach items="${yongyaoList}" var="yongyao">
													        <tr>
																<td width="25%" align="center">用药剂量-单次</td>
																<td width="75%" class="indent">${yongyao.pharmacyDose}</td>
															</tr>
															<tr>
																<td width="25%" align="center">用药频率</td>
																<td width="75%" class="indent">${yongyao.pharmacyFrequency}</td>
															</tr>
															<tr>
																<td width="25%" align="center">药物剂型</td>
																<td width="75%" class="indent">${yongyao.pharmacyDosageForm}</td>
															</tr>
															<tr>
																<td width="25%" align="center">药物名称</td>
																<td width="75%" class="indent">${yongyao.pharmacyName}</td>
															</tr>
															<tr>
																<td width="25%" align="center">用药天数</td>
																<td width="75%" class="indent">${yongyao.pharmacyDays}</td>
															</tr>
															<tr>
																<td width="25%" align="center">药物使用总剂量</td>
																<td width="75%" class="indent">${yongyao.pharmacyTotalDose}</td>
															</tr>
															<tr>
																<td width="25%" align="center">用药停止日期</td>
																<td width="75%" class="indent">${yongyao.pharmacyStopDate}</td>
															</tr>
													  </c:forEach>
													  <c:if test="${empty yongyaoList}">
													          <tr>
																<td width="25%" align="center">用药剂量-单次</td>
																<td width="75%" class="indent"></td>
															</tr>
															<tr>
																<td width="25%" align="center">用药频率</td>
																<td width="75%" class="indent"></td>
															</tr>
															<tr>
																<td width="25%" align="center">药物剂型</td>
																<td width="75%" class="indent"></td>
															</tr>
															<tr>
																<td width="25%" align="center">药物名称</td>
																<td width="75%" class="indent"></td>
															</tr>
															<tr>
																<td width="25%" align="center">用药天数</td>
																<td width="75%" class="indent"></td>
															</tr>
															<tr>
																<td width="25%" align="center">药物使用总剂量</td>
																<td width="75%" class="indent"></td>
															</tr>
															<tr>
																<td width="25%" align="center">用药停止日期</td>
																<td width="75%" class="indent"></td>
															</tr>
													  </c:if>
												</table>
											</div>
											<div class="Gselect">
												<table  cellspacing="0" cellpadding="0">
												     <c:forEach items="${zzList}" var="zhengzhuang">
													        <tr>
																<td width="25%" align="center">症状持续时间</td>
																<td width="75%" class="indent">${zhengzhuang.duration}</td>
															</tr>
															<tr>
																<td width="25%" align="center">症状名称</td>
																<td width="75%" class="indent">${zhengzhuang.zzName}</td>
															</tr>
															<tr>
																<td width="25%" align="center">症状详细描述</td>
																<td width="75%" class="indent">${zhengzhuang.valueName}</td>
															</tr>
													   </c:forEach>
													   <c:if test="${empty zzList}">
													   <tr>
																<td width="25%" align="center">症状持续时间</td>
																<td width="75%" class="indent"></td>
															</tr>
															<tr>
																<td width="25%" align="center">症状名称</td>
																<td width="75%" class="indent"></td>
															</tr>
															<tr>
																<td width="25%" align="center">症状详细描述</td>
																<td width="75%" class="indent"></td>
															</tr>
													   
													   </c:if>
												</table>
											</div>
											<div class="Gselect">
												<table  cellspacing="0" cellpadding="0">
												    <c:forEach items="${zhuanzhenList}" var="zhuanzhen">
													        <tr>
																<td width="25%" align="center">健康问题评估</td>
																<td width="75%" class="indent">${zhuanzhen.healthAssessment}</td>
															</tr>
															<tr>
																<td width="25%" align="center">结果描述</td>
																<td width="75%" class="indent">${zhuanzhen.resultDescription}</td>
															</tr>
													</c:forEach>
													<c:if test="${empty zhuanzhenList}">
													       <tr>
																<td width="25%" align="center">健康问题评估</td>
																<td width="75%" class="indent"></td>
															</tr>
															<tr>
																<td width="25%" align="center">结果描述</td>
																<td width="75%" class="indent"></td>
															</tr>
													
													</c:if>
												</table>
											</div>
											<div class="Gselect">
												<table  cellspacing="0" cellpadding="0">
												   <c:forEach items="${zzjyList}" var="zzjianyi">
													        <tr>
																<td width="25%" align="center">就诊原因</td>
																<td width="75%" class="indent">${zzjianyi.visitReason}</td>
															</tr>
															<tr>
																<td width="25%" align="center">就诊原因描述</td>
																<td width="75%" class="indent">${zzjianyi.visitReasonDescription}</td>
															</tr>
															<tr>
																<td width="25%" align="center">就诊科室</td>
																<td width="75%" class="indent">${zzjianyi.visitDep}</td>
															</tr>
															<tr>
																<td width="25%" align="center">就诊机构名称</td>
																<td width="75%" class="indent">${zzjianyi.visitOrgName}</td>
															</tr>
												    </c:forEach>
												    <c:if test="${empty zzjyList}">
												           <tr>
																<td width="25%" align="center">就诊原因</td>
																<td width="75%" class="indent"></td>
															</tr>
															<tr>
																<td width="25%" align="center">就诊原因描述</td>
																<td width="75%" class="indent"></td>
															</tr>
															<tr>
																<td width="25%" align="center">就诊科室</td>
																<td width="75%" class="indent"></td>
															</tr>
															<tr>
																<td width="25%" align="center">就诊机构名称</td>
																<td width="75%" class="indent"></td>
															</tr>
												    </c:if>
												</table>
											</div>
											<div class="Gselect">
												<table  cellspacing="0" cellpadding="0">
												   <c:forEach items="${healthProbleList}" var="healthProble">
													        <tr>
																<td width="25%" align="center">咨询问题</td>
																<td width="75%" class="indent">${healthProble.consultingProblem}</td>
															</tr>
															<tr>
																<td width="25%" align="center">详细描述</td>
																<td width="75%" class="indent">${healthProble.problemDescription}</td>
															</tr>
															<tr>
																<td width="25%" align="center">卫生服务要求</td>
																<td width="75%" class="indent">${healthProble.healthRequirements}</td>
															</tr>
															<tr>
																<td width="25%" align="center">详细描述</td>
																<td width="75%" class="indent">${healthProble.requirementsDescription}</td>
															</tr>
													</c:forEach>
													<c:if test="${empty healthProbleList}">
													       <tr>
																<td width="25%" align="center">咨询问题</td>
																<td width="75%" class="indent"></td>
															</tr>
															<tr>
																<td width="25%" align="center">详细描述</td>
																<td width="75%" class="indent"></td>
															</tr>
															<tr>
																<td width="25%" align="center">卫生服务要求</td>
																<td width="75%" class="indent"></td>
															</tr>
															<tr>
																<td width="25%" align="center">详细描述</td>
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
