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
										<a href="${ctx}/">首页</a>   <a href="${ctx}/hospital/${numSource.hospitalId}.html">>   医院主页</a>   <a href="${ctx}/doctor/${numSource.doctorId}.html">>   医生主页</a>   >   确认订单

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

									<div class="center">
										<div class="l">
											<div class="ct">
											<p class="p1"><span>${numSource.doctorname}</span>&nbsp;&nbsp;&nbsp;&nbsp; ${numSource.doctor.job}</p>
											<p>${numSource.hospitalname}-${numSource.departmentname}</p>
											<p></p>
											</div>
										</div>
										 
										<div class="c">
											<p style="position:absolute; top:418px; left:670px;">网络问诊</p>
											<p style="position:absolute; top:450px; left:625px;">
											
											<c:if test="${numSource.sourcetime == 1 }">上午 ${numSource.starttime}-${numSource.endtime }</c:if>
											<c:if test="${numSource.sourcetime == 2 }">下午 ${numSource.starttime}-${numSource.endtime }</c:if>
											<c:if test="${numSource.sourcetime == 3 }">晚上 ${numSource.starttime}-${numSource.endtime }</c:if>
											</p>
										</div>
										<div class="r">
											<p>¥${poAllPrice}元</p>
										</div>
										
									</div>
								</div>	
								<div class="sel">
												<%--<div class="Fontsbar">
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
														<a href="${ctx}/userinfo/peoplecardinfo?opid=0&rtid=${rtID}"; >
														<p>当前所选择医院没有就诊人信息，添加就诊人</p>
														</a>
												</li>

											</ul> --%>
											<div class="qrtj">
											 <form action="${ctx}/userinfo/createWebOrder">
											 	<input id="interrogationType" name="interrogationType" type="hidden" value="${types}">
											    <input id="objectId" name="sourceid" type="hidden" value="${numSource.sourceid}">
												<input id="upId" name="upId" type="hidden" value="${userHospitalList[0].upid}">
												<input type="submit" id="order_submit" value="提交">
											</form>
											</div>
											</div>

								</div>	
						</div>


					</div>
				
		
		
<script type="text/javascript">

	/* $(document).ready(function(){
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

 */
	/* $("#order_submit").click(function(){
		$(this).attr("disabled","disabled");//防止重复提交
	}); */




</script>

</body>
</html>
