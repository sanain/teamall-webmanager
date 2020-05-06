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

					<div id="content"> 
						<div class="newsnav"> 
								<div class="center">
										<a href="${ctx}/">首页</a>>   确认订单

								</div>
						</div>
						<div class="queren">
								<div class="block_name mtt"> 
							
								<span class="">Confirm the payment</span>
								<p class="">确认信息</p>
								<div class="brd"></div>
								</div>

								<div class="qrnews">
									<div class="center">
										<p class="on">确认信息</p>
										<p>选择付款</p>
									</div>
								</div>
								<div class="qrdoc">

									<div class="Fontsbar">
									<p>医生信息</p>
									<span>Doctor information</span>
									</div>
									<div class="center">
										<div class="l">
											<div class="ct">
											<p class="p1"><span>${numSource.doctorname}</span>&nbsp;&nbsp;&nbsp;&nbsp; ${numSource.doctor.job}</p>
											<p>${numSource.hospitalname}-${numSource.departmentname}</p>
											<p></p>
											</div>
										</div>
										 
										<div class="c">
											<p style="position:absolute; top:480px; left:580px;">预约挂号-<fmt:formatDate value="${numSource.sourcedate}" pattern="yyyy-MM-dd"/><c:if test="${timestypeNoName != '0' }"></p><p style="position:absolute; top:510px; left:595px;">${timestypeNoName}</p></c:if>	
			<c:if test="${timestypeNoName == '0' }">
			<p style="position:absolute; top:510px; left:605px;">
											<c:if test="${numSourceTime=='1'}">
                                                     上午
                                             </c:if>
                                             <c:if test="${numSourceTime=='2'}">
                                                     下午
                                             </c:if>
                                              <c:if test="${numSourceTime=='3'}">
                                                     下午
                                             </c:if>
             </c:if>                                
											</p>
										</div>
										<div class="r">
											<c:if test="${numSource.consultationfee>0}">
												<p>¥${numSource.consultationfee}元</p>
											</c:if>
											<div class="tishi">现场支付,以医院费用为准</div>
										</div>
										
									</div>
								</div>	
								<div class="sel">
											<div class="Fontsbar">
											<p>就诊人信息</p>
											<span>Patient information</span>
											</div>
											<div class="center">
											<ul>
											
											  <c:forEach var="userHospital" items="${userHospitalList}" varStatus="status">
												<li id="${userHospital.upid}" <c:if test="${status.index==0}"> class="on" </c:if>>
													<p>${userHospital.patientname} <!--  <span>（默认就诊人）</span> --> </p>
													<p>身份证: <span>${userHospital.patientidcardno}</span></p>
													<p>手机号: <span>${userHospital.patienttelephone}</span></p>
													<p>就诊卡: <span>${userHospital.medicareno}</span></p>
													<div class="hidden">
														<img src="${ctxStaticFront}/images/selorg.png">
													</div>
												</li>
												</c:forEach>
												
												
												<li class="add">
														<a href="${ctx}/userinfo/peoplecardinfo?opid=0&hospitid=${numSource.hospitalId}&rtid=${rtID}"; >
														<p>当前所选择医院没有就诊人信息，添加就诊人</p>
														</a>
												</li>

											</ul>
											<div class="qrtj">
											 <form action="${ctx}/userinfo/createorder">
											    <input id="poType" name="poType" type="hidden" value="3">
											    <input id="hpCount" name="hpCount" type="hidden" value="1">
											    <input id="poAllPrice" name="poAllPrice" type="hidden" value="${numSource.consultationfee}">
											    <input id="numSourceTime" name="numSourceTime" type="hidden" value="${numSourceTime}">
											    <input id="objectId" name="objectId" type="hidden" value="${numSource.sourceid}">
												<input id="upId" name="upId" type="hidden" value="${userHospitalList[0].upid}">
												<input id="timestypeNoName" name="timestypeNoName" type="hidden" value="${timestypeNoName}">
													<input id="timestypeNo" name="timestypeNo" type="hidden" value="${timestypeNo}">
												<input type="submit" id="order_submit" value="提交">
											</form>
											</div>
											</div>

								</div>	
						</div>


					</div>
				
		
		
<script type="text/javascript">

	$(document).ready(function(){
		var oldc=$($(".sel ul li.on"));

		$(".sel ul li").click(function(){
		if(!$(this).hasClass("add")){
			oldc.removeClass("on");
			$(this).addClass("on");
			oldc=$(this);
			$("#upId").val(oldc.attr("id"));
			//alert($("#upId").val());
		}
		})


	$("#order_submit").click(function(){
		var upId = $("#upId").val();
		
		if(upId==""){
			layer.alert('请选择就诊人！', {
				icon: 2,
				skin: 'layer-ext-moon'
			})

			return false;
		}else{

		}
		layer.load();
		document.myform("order_submit").disabled='true'; //防止重复提交 */
	});

	});



</script>

</body>
</html>
