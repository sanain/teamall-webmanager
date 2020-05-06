<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/modules/front/include/taglib.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
<head>
	<meta name="decorator" content="fronthospital"/>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title></title>
	<meta name="keywords" content="" />
	<meta name="description" content="" />
	<style>
	.ks4 table td img {
	    max-width: 40%;
	    border: 1px solid #e3e3e3;
	    border-radius: 50%;
	}
	.ys3 table.ftable{border-top:none }
			.Ulswitch{border-top: none;}
	</style>
	<script type="text/javascript" src="${ctxStaticFront}/js/power-slider1.js"></script>
	<link rel="stylesheet" type="text/css" href="${ctxStaticFront}/de/style.css" media="all" />
	
</head>

<body>

		<div id="content"> 
				<div class="ks1">
					<div class="center">
						<div class="block_name mtt"> 
							
							<p class="">${depName}</p>
							<div class="brd"></div>
						</div>
							

					</div>
					
				</div>
			<c:if test="${not empty dep.ddesc}">
				<div class="ks2">
						<div class="Fontsbar">
						<p>科室简介</p>
						<span>Department profile</span>
						</div>
						<div class="center">
							<p>${dep.ddesc}</p>


						</div>

				</div>
			</c:if>		
				<!-- <div class="ks3">
					<div class="center">
						<div class="Zxgh">
								<div class="Ghbox">
										<div class="l"><img src="images/ghico1.png"></div>
										<div class="r"><p>已咨询人数 <span>20000</span>人</p></div>
								</div>
						</div>
						<div class="Zxgh">
								<div class="Ghbox">
										<div class="l"><img src="images/ghico2.png"></div>
										<div class="r"><p>已咨询人数 <span>20000</span>人</p></div>
								</div>

						</div>
					</div>
				</div> -->
					
				<div class="ys3 ks4">
						<div class="Fontsbar">
						<p>30天排班列表</p>
						<span>This month schedule list</span>
						</div>
						<div class="center">
							<c:forEach var="docs" items="${doctNumber}">
								<div class="tableBox">
											<table cellpadding="0" cellspacing="0" class="ftable">
									<tr class="tr1">
										<td width="150" align="center">医生</td>
										<td >时段</td>
									</tr>
									<tr>
										<td class="last"><a href="${ctx}/doctor/${docs.doctorId}.html">${docs.name}</a></td>
										<td class="bno">
											<table cellpadding="0" cellspacing="0">
												<tr>
													<td width="95" align="center">上午</td>
												</tr>
												<tr>
													<td width="95" align="center">下午</td>
												</tr>
												<tr>
													<td width="95" align="center">晚上</td>
												</tr>
												<tr>
													<td width="95" align="center">&nbsp;</td>
												</tr>
											</table>
										</td>
									</tr>
									


							</table>
							<div class="slider1" id="slider">
								<div class="prev"></div>
								<div class="next"></div>
								<div class="lider">
								<div class="sliderbox">
									<ul>
										<li class="sid"><ul class="Ulswitch">
										<c:forEach items="${daStrings}" var="dsdds"  begin="0" end="6" varStatus="s">
											<li>
												<div class="title">
												<span><fmt:parseDate value="${dsdds}" var="date"
														pattern="yyyy-MM-dd" /><fmt:formatDate value="${date}" pattern="yyyy-MM-dd" /></span><p>${fns:getWeekChina(date)}</p>
												</div>
												<ul>
													<li>
														<c:if test="${empty docs.numSourceList[s.index].morningleavenum}">
															&nbsp;
														</c:if>
														<c:if test="${docs.numSourceList[s.index].morningleavenum==0}">
															<span>&nbsp;</span>
														</c:if>
														<c:if test="${docs.numSourceList[s.index].morningleavenum>0}">
															<span><a onclick="javascript:yuyue('${docs.numSourceList[s.index].sourceid}','1')" href="#">余 <span>${docs.numSourceList[s.index].morningleavenum}</span></a></span>
														</c:if>
													</li>
													<li>
														<c:if test="${empty docs.numSourceList[s.index].afternoonleavenum}">
															&nbsp;
														</c:if>
														<c:if test="${docs.numSourceList[s.index].afternoonleavenum==0}">
															<span>&nbsp;</span>
														</c:if>
														<c:if test="${docs.numSourceList[s.index].afternoonleavenum>0}">
															<span><a onclick="javascript:yuyue('${docs.numSourceList[s.index].sourceid}','2')">余 <span>${docs.numSourceList[s.index].afternoonleavenum}</span></a></span>
														</c:if>
													</li>
													<li>
														<c:if test="${empty docs.numSourceList[s.index].eveningleavenum}">
															&nbsp;
														</c:if>
														<c:if test="${docs.numSourceList[s.index].eveningleavenum==0}">
															<span>&nbsp;</span>
														</c:if>
														<c:if test="${docs.numSourceList[s.index].eveningleavenum>0}">
															<span><a onclick="javascript:yuyue('${docs.numSourceList[s.index].sourceid}','3')">余 <span>${docs.numSourceList[s.index].eveningleavenum}</span></a></span>
														</c:if>
													</li>
													<li>&nbsp;</li>
												</ul>
											</li>
										</c:forEach>
									</ul></li>
									
									<li class="sid"><ul class="Ulswitch">
										<c:forEach items="${daStrings}" var="dsdds"  begin="7" end="13" varStatus="s">
											<li>
												<div class="title">
												<span><fmt:parseDate value="${dsdds}" var="date"
														pattern="yyyy-MM-dd" /><fmt:formatDate value="${date}" pattern="yyyy-MM-dd" /></span><p>${fns:getWeekChina(date)}</p>
												</div>
												<ul>
													<li>
														<c:if test="${empty docs.numSourceList[s.index].morningleavenum}">
															&nbsp;
														</c:if>
														<c:if test="${docs.numSourceList[s.index].morningleavenum==0}">
															<span>&nbsp;</span>
														</c:if>
														<c:if test="${docs.numSourceList[s.index].morningleavenum>0}">
															<span><a onclick="javascript:yuyue('${docs.numSourceList[s.index].sourceid}','1')">余 <span>${docs.numSourceList[s.index].morningleavenum}</span></a></span>
														</c:if>
													</li>
													<li>
														<c:if test="${empty docs.numSourceList[s.index].afternoonleavenum}">
															&nbsp;
														</c:if>
														<c:if test="${docs.numSourceList[s.index].afternoonleavenum==0}">
															<span>&nbsp;</span>
														</c:if>
														<c:if test="${docs.numSourceList[s.index].afternoonleavenum>0}">
															<span><a onclick="javascript:yuyue('${docs.numSourceList[s.index].sourceid}','2')">余 <span>${docs.numSourceList[s.index].afternoonleavenum}</span></a></span>
														</c:if>
													</li>
													<li>
														<c:if test="${empty docs.numSourceList[s.index].eveningleavenum}">
															&nbsp;
														</c:if>
														<c:if test="${docs.numSourceList[s.index].eveningleavenum==0}">
															<span>&nbsp;</span>
														</c:if>
														<c:if test="${docs.numSourceList[s.index].eveningleavenum>0}">
															<span><a onclick="javascript:yuyue('${docs.numSourceList[s.index].sourceid}','3')">余 <span>${docs.numSourceList[s.index].eveningleavenum}</span></a></span>
														</c:if>
													</li>
													<li>&nbsp;</li>
												</ul>
											</li>
										</c:forEach>
									</ul></li>
									
									<li class="sid"><ul class="Ulswitch">
										<c:forEach items="${daStrings}" var="dsdds"  begin="14" end="20" varStatus="s">
											<li>
												<div class="title">
												<span><fmt:parseDate value="${dsdds}" var="date"
														pattern="yyyy-MM-dd" /><fmt:formatDate value="${date}" pattern="yyyy-MM-dd" /></span><p>${fns:getWeekChina(date)}</p>
												</div>
												<ul>
													<li>
														<c:if test="${empty docs.numSourceList[s.index].morningleavenum}">
															&nbsp;
														</c:if>
														<c:if test="${docs.numSourceList[s.index].morningleavenum==0}">
															<span>&nbsp;</span>
														</c:if>
														<c:if test="${docs.numSourceList[s.index].morningleavenum>0}">
															<span><a onclick="javascript:yuyue('${docs.numSourceList[s.index].sourceid}','1')">余 <span>${docs.numSourceList[s.index].morningleavenum}</span></a></span>
														</c:if>
													</li>
													<li>
														<c:if test="${empty docs.numSourceList[s.index].afternoonleavenum}">
															&nbsp;
														</c:if>
														<c:if test="${docs.numSourceList[s.index].afternoonleavenum==0}">
															<span>&nbsp;</span>
														</c:if>
														<c:if test="${docs.numSourceList[s.index].afternoonleavenum>0}">
															<span><a onclick="javascript:yuyue('${docs.numSourceList[s.index].sourceid}','2')">余 <span>${docs.numSourceList[s.index].afternoonleavenum}</span></a></span>
														</c:if>
													</li>
													<li>
														<c:if test="${empty docs.numSourceList[s.index].eveningleavenum}">
															&nbsp;
														</c:if>
														<c:if test="${docs.numSourceList[s.index].eveningleavenum==0}">
															<span>&nbsp;</span>
														</c:if>
														<c:if test="${docs.numSourceList[s.index].eveningleavenum>0}">
															<span><a onclick="javascript:yuyue('${docs.numSourceList[s.index].sourceid}','3')">余 <span>${docs.numSourceList[s.index].eveningleavenum}</span></a></span>
														</c:if>
													</li>
													<li>&nbsp;</li>
												</ul>
											</li>
										</c:forEach>
									</ul></li>
									
									<li class="sid"><ul class="Ulswitch">
										<c:forEach items="${daStrings}" var="dsdds"  begin="21" end="27" varStatus="s">
											<li>
												<div class="title">
												<span><fmt:parseDate value="${dsdds}" var="date"
														pattern="yyyy-MM-dd" /><fmt:formatDate value="${date}" pattern="yyyy-MM-dd" /></span><p>${fns:getWeekChina(date)}</p>
												</div>
												<ul>
													<li>
														<c:if test="${empty docs.numSourceList[s.index].morningleavenum}">
															&nbsp;
														</c:if>
														<c:if test="${docs.numSourceList[s.index].morningleavenum==0}">
															<span>&nbsp;</span>
														</c:if>
														<c:if test="${docs.numSourceList[s.index].morningleavenum>0}">
															<span><a onclick="javascript:yuyue('${docs.numSourceList[s.index].sourceid}','1')">余 <span>${docs.numSourceList[s.index].morningleavenum}</span></a></span>
														</c:if>
													</li>
													<li>
														<c:if test="${empty docs.numSourceList[s.index].afternoonleavenum}">
															&nbsp;
														</c:if>
														<c:if test="${docs.numSourceList[s.index].afternoonleavenum==0}">
															<span>&nbsp;</span>
														</c:if>
														<c:if test="${docs.numSourceList[s.index].afternoonleavenum>0}">
															<span><a onclick="javascript:yuyue('${docs.numSourceList[s.index].sourceid}','2')">余 <span>${docs.numSourceList[s.index].afternoonleavenum}</span></a></span>
														</c:if>
													</li>
													<li>
														<c:if test="${empty docs.numSourceList[s.index].eveningleavenum}">
															&nbsp;
														</c:if>
														<c:if test="${docs.numSourceList[s.index].eveningleavenum==0}">
															<span>&nbsp;</span>
														</c:if>
														<c:if test="${docs.numSourceList[s.index].eveningleavenum>0}">
															<span><a onclick="javascript:yuyue('${docs.numSourceList[s.index].sourceid}','3')">余 <span>${docs.numSourceList[s.index].eveningleavenum}</span></a></span>
														</c:if>
													</li>
													<li>&nbsp;</li>
												</ul>
											</li>
										</c:forEach>
									</ul></li>
									
									
											
											
										</ul>
										
										</div>
										</div>
									</div>
									
								</div>
							</c:forEach>
						</div>

				</div>




		</div>

		<input type="hidden" id="userinfos"  name="userinfos"  value="${userinfo.userId}" />

<script type="text/javascript">
	
	function yuyue(sourceid,numSourceTime){
		var hosName="${hospital.name}";
		if(hosName.indexOf("系统升级", 0)!="-1"){
			layer.alert("系统维护中，请升级完成后挂号！");
			return false;
		}else{
			var url="${ctx}/userinfo/recordconfirm?sourceid="+sourceid+"&numSourceTime="+numSourceTime;
			window.location.href=url;
		}
		
	}
</script>

 <script type="text/javascript">
   
	function ShowTime(sourceid,numSourceTime) {
	var userinfos = $("#userinfos").val();
	
	if(userinfos != null && userinfos !=""){
			var index = layer.load(0, {
				    shade: [0.1,'#fff'] //0.1透明度的白色背景
				});
				 jQuery.ajax({  
		        url : '${ctx}/userinfo/timeQuantum',  
		        type : 'post',  
		        data : { sourceid:sourceid,numSourceTime:numSourceTime},  
		        dataType : 'json',  
		        success : function (result) {
		        layer.close(index); 
		       			 if(result.results	== 'yes'){
								 layer.open({
							       			type: 2,
								            title: '选择时间段',
								            shadeClose: true,
								            maxmin: true, //开启最大化最小化按钮
								            area: ['600px', '320px'],
								            content: '${ctx}/userinfo/timeQuantumInfo?sourceid='+sourceid+'&numSourceTime='+numSourceTime,
								            success: function(layero, index){
							    			}
									 	});
					 	}else{
					 //	alert("${ctx}/userinfo/recordconfirm?sourceid="+sourceid+"&numSourceTime="+numSourceTime+"&timestypeNoName=0");
					 	//	location.href ="userinfo/recordconfirm?sourceid="+sourceid+"&numSourceTime="+numSourceTime+"&timestypeNoName=0";
					 	
					 		
			 				window.location.href  ="${ctx}/userinfo/recordconfirm?sourceid="+sourceid+"&numSourceTime="+numSourceTime+"&timestypeNoName=0";
					 	}
		        
		            }  
		        });  
			 
	}else{
		window.location.href  ="${ctx}/login?url=/hospital/${hosId}.html?hosId=${hosId}&depName=${depName}";
					
	}
  }
   
 </script>
 		<script>$(".slider1").powerSlider({handle:"left",delayTime:600000000});
				$(".tableBox:first").find('table.ftable').css("border-top",'1px solid #bbc6dd')
				$(".tableBox:first").find('.Ulswitch').css("border-top",'1px solid #bbc6dd')
		
		</script>
</body>


</html>
