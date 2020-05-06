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

			<div class="jblb">
				<div class="block_name mtt"> 
							
							<p class="">${illnes.illName}</p>
							<div class="brd"></div>
				</div>
				<div class="center">
					<div class="smallt">
						${illneInfo}			
					</div>
					<div class="yaop">
						<div class="l">
							<div class="Fontsbar">
								<p>就诊科室</p>
								<span>Medical department</span>
							</div>
							<ul>
							<c:forEach items="${deps}" var="dep">
								<li><%-- <a href="${ctx}/hospital/department/${dep.hospitalId}.html?hosId=${dep.hospitalId}&depName=${dep.name}"> --%>
								${dep.depName}</a></li>
							</c:forEach>	
							</ul>
						</div>
						<div class="r">
							<div class="Fontsbar">
								<p>相关药品</p>
								<span>Related drugs</span>
							</div>
							<ul>
								<c:forEach items="${druglibrary}" var="drus">
								<li><a href="${ctx}/IllnessInfo/druglibraryInfo?drugId=${drus.drugid}">${drus.drugname}</a></li>
								</c:forEach>
							</ul>

						</div>


					</div>
					<div class="jbxiangqing">
							<div class="Fontsbar">
								<p>疾病详情</p>
								<span>Disease details</span>
							</div>
							<div class="fonts">
								<p>一.发病原因</p>
								<p>${fns:abbr(illnes.illPathogenyTxt,10000)}</p>
								<p>二.并发疾病</p>
								<p>${fns:abbr(illnes.illConcurrentTxt,30000)}</p>
								<p>三.病状体征</p>
								<p>${fns:abbr(illnes.illSymptomsTxt,80000)}</p>
								<p>四.病理病因</p>
								<p>${fns:abbr(illnes.illPathogenyTxt,30000)} </p>
								<p>五.饮食保健</p>
								<p>${fns:abbr(illnes.illFoodTxt,30000)}  </p>
							</div>


					</div>
							<div class="Fontsbar">
								<p>就诊医生</p>
								<span>Medical doctor</span>
							</div>
							<div class="i5 sel5"> 
								<ul>
								<c:forEach items="${doctor}" var="docs"> 
									<li class="">
												  <c:set var="url" value="${docs.photourl}" />  
											<div class="userpic animate-element scale" style="background:url(${fnf:imageScaleUrl(url,'500','500','doctorpc')}) center no-repeat"> 
												<a href="${ctx}/doctor/${docs.doctorId}.html">
												<p class="opacity"><span>
													  <c:set var="docspecial" value="${fns:abbr(docs.specialty,40)}"/>
                                                                                                                                       擅长：${docspecial}
												</span></p>
												</a>
											</div>

											<div class="fonts animate-element bottom_to_top">
												<p class="p1"> ${docs.name} <span>${docs.job} </span></p>
												<p class="p2">${docs.department.name}</p>
												<div class="State">
												
													<c:if test="${docs.isReg=='1'}">
												    <a  style="background-image:url()">挂号</a>
												    </c:if>
												    
												    <c:if test="${docs.isReg=='0'}">
												    <a  style="background-image:url()" class="off">挂号</a>
												    </c:if>
												    
												    
												    <c:if test="${docs.isReg!='0' and docs.isReg!='1'}">
												    <a  style="background-image:url()" class="off">挂号</a>
												    </c:if>
												    
												     <c:if test="${docs.chartartconsult=='1'}">
													<a style="background-image:url()">图文</a>
													</c:if>
												    <c:if test="${docs.chartartconsult=='2'}">
													<a class="off" style="background-image:url()">图文</a>
													</c:if>
													 <c:if test="${docs.chartartconsult!='2'and docs.chartartconsult!='1'}">
													<a class="off" style="background-image:url()">图文</a>
													</c:if>
													
													<c:if test="${docs.telconsult=='1'}">
													<a style="background-image:url()">电话</a>
													</c:if>
													<c:if test="${docs.telconsult=='2'}">
													<a class="off" style="background-image:url()">电话</a>
													</c:if>
													<c:if test="${docs.telconsult!='2' and docs.telconsult!='1'}">
													<a class="off" style="background-image:url()">电话</a>
													</c:if>
													
											        <c:if test="${docs.videoconsult=='1'}">
													<a style="background-image:url()">视频</a>
													</c:if>
													 <c:if test="${docs.videoconsult=='2'}">
													<a class="off" style="background-image:url()">视频</a>
													</c:if>
													 <c:if test="${docs.videoconsult!='2' and docs.videoconsult!='1'}">
													<a class="off" style="background-image:url()">视频</a>
													</c:if>
													
													<c:if test="${docs.freeconsult=='1'}">
													<a  style="background-image:url()">咨询</a>
													</c:if>
													<c:if test="${docs.freeconsult=='2'}">
													<a class="off" style="background-image:url()">咨询</a>
													</c:if>
													<c:if test="${docs.freeconsult!='2' and docs.freeconsult!='1'}">
													<a class="off" style="background-image:url()">咨询</a>
													</c:if>
													<!-- <a class="off" style="">服务</a>
													<a class="off" style="">服务</a>
													<a class="off" style="">服务</a> -->
												</div>
											</div>
									</li>
							</c:forEach>

								</ul>



							</div>
							<div class="Fontsbar">
								<p>就诊医院</p>
								<span>Medical hospital</span>
							</div>
							<div class="yiy">
								<div class="center">
									<ul>
									
									<c:forEach items="${hospitalList}" var="hospital">
												<li>
													<a href="../hospital/${hospital.hospitalId}${urlSuffix}">
														<div class="l">
															<img height="70" width="70" src="${hospital.photourl}">
														</div>
														<div class="r">
																<p>
																<b>&nbsp;${hospital.name}</b><br/><br/>
<!-- 																<img src="${ctxStaticFront}/images/ico1.png"> -->



                                                            <div class="lefsta">	
                                                               	<c:if test="${hospital.hasRegConfirm == '1'}">
																	<mico >
																</c:if>
																<c:if test="${hospital.hasRegConfirm != '1'}">
																	<mico  class="off" >
																</c:if>
																挂号
																</mico>
																
																
																<c:if test="${hospital.isinterrogation == '1'}">
																	<mico >
																</c:if>
																<c:if test="${hospital.isinterrogation != '1'}">
																	<mico class="off">
																</c:if>
																远程
																</mico>
																
																
																
															<c:if test="${hospital.waitstat =='1'}">
															<mico >
																</c:if>
																<c:if test="${hospital.waitstat !=1}">
																	<mico class="off" >
																</c:if>
																
																排队</mico>
																<c:if test="${hospital.reportstat ==1}">
																	<mico >
																</c:if>
																<c:if test="${hospital.reportstat !=1}">
																	<mico class="off" >
																</c:if>
																报告</mico> 
																<c:if test="${hospital.payonlinestat ==1}">
																	<mico >
																</c:if>
																<c:if test="${hospital.payonlinestat !=1}">
																	<mico class="off" >
																</c:if>
																门诊</mico> 
																<c:if test="${hospital.payonlinestat ==1}">
																	<mico >
																</c:if>
																<c:if test="${hospital.payonlinestat !=1}">
																	<mico class="off" >
																</c:if>
																缴费</mico> 
                                                              </div>	
                                                              </br>
															</p>
															<span>
														<%-- 	<c:set var="hosdesc" value="${fns:abbr(hospital.brief,130)}"/> ${hosdesc} --%>
															</span>
														</div>
													</a>
												</li>
										</c:forEach>
									
									</ul>

								</div>


							</div>

				</div>

			</div>
		</div>

			
		</div>
	

<script type="text/javascript">

var lhg = $(".yaop .l").height(), rhg = $(".yaop .r").height();
if(lhg>rhg && lhg != 0 && rhg != 0){ 
	$(".yaop .r").css("height",lhg)
}else{
	$(".yaop .l").css("height",rhg)
}








</script>

</body>
</html>
