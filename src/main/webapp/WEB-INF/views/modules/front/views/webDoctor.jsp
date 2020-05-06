<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/front/include/taglib.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta name="decorator" content="frontdoctor"/>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title></title>
	<meta name="keywords" content="" />
	<meta name="description" content="" />
</head>

<body>
	<script type="text/javascript" src="${ctxStaticFront}/js/power-slider1.js"></script>

<style>
.ysgh p.p1 {
    margin-top: 15px;
    margin-right: 120px;
}
.ysgh p {
    font-size: 14px;
    color: #404D5E;
}
.ysgh p {
    font-size: 16px;
    color: #404D5E;
    margin-bottom: 5px;
    float: left;
}
* {
    padding: 0px;
    margin: 0px;
    list-style-type: none;
    text-decoration: none;
    font-family: "5FAE8F6F96C59ED1","Microsoft Yahei";
}
* {
    padding: 0px;
    margin: 0px;
    list-style-type: none;
    text-decoration: none;
    font-family: "5FAE8F6F96C59ED1","Microsoft Yahei";
}

</style>

	<div class="newsnav"> 
								<div class="center">
										<a href="${ctx}/">首页    >  </a> <a href="" onclick="javascript :history.back(-1);">上一页</a>
								</div>
								

						</div>
<div id="content"> 
				<div class="ys1">
					<div class="center">
						<div class="c1">
							<div class="yssmall"> 
									<div class="l"> 
									     <c:set var="url" value="${doCmsg.photourl}" />  
                                         <img  src="${fnf:imageScaleUrl(url,'200','200','doctorpc')}">
									     <c:if test="${ not empty userattentionmsg}">
										 <a href="javascript:;" onclick="delattention()">取消关注</a>
										</c:if>
										<c:if test="${ empty userattentionmsg}">
										 <a href="javascript:;" onclick="addattention()">添加关注</a>
										</c:if>
										
									</div>
									<div class="r">
										<h1>${doCmsg.name} <span>${doCmsg.doctortypeobj.doctorTypeName}</span></h1>
										<p>科室：${doCmsg.department.name}</p>
										<p>医院：${doCmsg.department.hospital.name}</p>
										<p>擅长：${specialtyInfo} </p>
										<div class="State">
										 
										    <c:if test="${doCmsg.isReg=='1'}">
										    <a  style="background-image:url()">挂号</a>
										    </c:if>
										    
										    <c:if test="${doCmsg.isReg=='0'}">
										    <a  style="background-image:url()" class="off">挂号</a>
										    </c:if>
										    
										    
										    <c:if test="${doCmsg.isReg!='0' and doCmsg.isReg!='1'}">
										    <a  style="background-image:url()" class="off">挂号</a>
										    </c:if>
										    
										     <c:if test="${doCmsg.chartartconsult=='1'}">
											<a style="background-image:url()">图文</a>
											</c:if>
										    <c:if test="${doCmsg.chartartconsult=='2'}">
											<a class="off" style="background-image:url()">图文</a>
											</c:if>
											 <c:if test="${doCmsg.chartartconsult!='2'and doCmsg.chartartconsult!='1'}">
											<a class="off" style="background-image:url()">图文</a>
											</c:if>
											
											<c:if test="${doCmsg.telconsult=='1'}">
											<a style="background-image:url()">电话</a>
											</c:if>
											<c:if test="${doCmsg.telconsult=='2'}">
											<a class="off" style="background-image:url()">电话</a>
											</c:if>
											<c:if test="${doCmsg.telconsult!='2' and doCmsg.telconsult!='1'}">
											<a class="off" style="background-image:url()">电话</a>
											</c:if>
											
									        <c:if test="${doCmsg.videoconsult=='1'}">
											<a style="background-image:url()">视频</a>
											</c:if>
											 <c:if test="${doCmsg.videoconsult=='2'}">
											<a class="off" style="background-image:url()">视频</a>
											</c:if>
											 <c:if test="${doCmsg.videoconsult!='2' and doCmsg.videoconsult!='1'}">
											<a class="off" style="background-image:url()">视频</a>
											</c:if>
											
											<c:if test="${doCmsg.freeconsult=='1'}">
											<a  style="background-image:url()">咨询</a>
											</c:if>
											<c:if test="${doCmsg.freeconsult=='2'}">
											<a class="off" style="background-image:url()">咨询</a>
											</c:if>
											<c:if test="${doCmsg.freeconsult!='2' and doCmsg.freeconsult!='1'}">
											<a class="off" style="background-image:url()">咨询</a>
											</c:if>

										</div>
										
									</div>
							</div>

							<div class="yspj"> 
								<ul>
									<li>就诊疗效 
										<div class="Muxin">
										    ${fnf:getBigStar(doCmsg.doctorSolve,ctxStaticFront)}
										</div>
									</li>
									<li>专业技术 
										<div class="Muxin">
										    ${fnf:getBigStar(doCmsg.doctorExpertise,ctxStaticFront)}
										</div>
									</li>
									<li>医生态度 
										<div class="Muxin">
											${fnf:getBigStar(doCmsg.doctorAttitude,ctxStaticFront)}
										</div>
									</li>


								</ul>
								<div class="ysgh">
											
												<img src="${ctxStaticFront}/images/ghico1.png">

												<p class="p1">已挂号人数</p>
												<p class="p2"><span style="margin-top: -39px; margin-left: 150px;" align="center">${doCmsg.registerCount}</span><b style="margin-top: -33px; margin-left: 240px;" >人</b></p>
											
										</div>
										<div class="ysgh">
											
												<img src="${ctxStaticFront}/images/ghico2.png">

												<p class="p1">已咨询人数</p>
												<p class="p2"><span style="margin-top: -39px; margin-left: 150px;" align="center">${doCmsg.consultCount}</span><b style="margin-top: -33px; margin-left: 240px;" >人</b></p>
											
										</div>
							</div>
						</div>
						<div class="ysbutn">
							<ul>
								<li>
									<p class="gold">${doCmsg.chartarprice}</p>
									<div class="lidc">
									 <c:if test="${doCmsg.chartartconsult=='1'}">
										<img src="${ctxStaticFront}/images/ycico1.png" >
									</c:if>
									<c:if test="${doCmsg.chartartconsult=='2'}">
										<img src="${ctxStaticFront}/images/ycico1.png" class="off">
									</c:if>
										<c:if test="${doCmsg.chartartconsult!='2'and doCmsg.chartartconsult!='1' }">
										<img src="${ctxStaticFront}/images/ycico1.png" class="off">
									</c:if>
										<p class="font">图文咨询</p>
									</div>
									<div class="hidden">
											<div class="htjt"></div>
											<p>请在下方直接下单或者下载健康四川app完成下单流程！</p>
											<img src="${ctxStaticFront}/images/appdownload.jpg">
									</div>
								</li>
								<li>
									<p class="gold">${doCmsg.telprice}</p>
									<div class="lidc">
									 <c:if test="${doCmsg.telconsult=='1'}">
										<img src="${ctxStaticFront}/images/ycico2.png">
									   </c:if>
									   
									    <c:if test="${doCmsg.telconsult=='2'}">
										<img src="${ctxStaticFront}/images/ycico2.png" class="off">
									   </c:if>
									      
									    <c:if test="${doCmsg.telconsult!='2'and doCmsg.telconsult!='1' }">
										<img src="${ctxStaticFront}/images/ycico2.png" class="off">
									   </c:if>
										<p class="font">电话咨询</p>
									</div>
									<div class="hidden">
											<div class="htjt"></div>
											<p>请在下方直接下单或者下载健康四川app完成下单流程！</p>
											<img src="${ctxStaticFront}/images/appdownload.jpg">
									</div>
								</li>
								<li>
									<p class="gold">${doCmsg.videoprice}</p>
									<div class="lidc">
									  <c:if test="${doCmsg.videoconsult=='1'}">
										<img src="${ctxStaticFront}/images/ycico3.png">
										</c:if>
										
									   <c:if test="${doCmsg.videoconsult=='2'}">
										<img src="${ctxStaticFront}/images/ycico3.png" class="off">
										</c:if>
										  <c:if test="${doCmsg.videoconsult!='2'and doCmsg.videoconsult!='1'}">
										<img src="${ctxStaticFront}/images/ycico3.png" class="off">
										</c:if>
										<p class="font">视频咨询</p>
									</div>
									<div class="hidden">
											<div class="htjt"></div>
											<p>请在下方直接下单或者下载健康四川app完成下单流程！</p>
											<img src="${ctxStaticFront}/images/appdownload.jpg">
									</div>
								</li>
								<!-- 
								<li>
									   <div class="lidc">
									   <c:if test="${doCmsg.freeconsult=='1'}">
										<img id ="chatfree" src="${ctxStaticFront}/images/ycico4.png">
										</c:if>
									
									    <c:if test="${doCmsg.freeconsult=='2'}">
										<img src="${ctxStaticFront}/images/ycico4.png" class="off">
										</c:if>
										
										<c:if test="${doCmsg.freeconsult!='2' and doCmsg.freeconsult!='1' }">
										<img  src="${ctxStaticFront}/images/ycico4.png" class="off">
										</c:if>
										<p class="font">免费咨询</p>
										
									</div>
									<div class="hidden">
											<div class="htjt"></div>
											<p>下载健康四川app，即可使用网络医疗！</p>
											<img src="${ctxStaticFront}/images/ewm.jpg">
									</div>
									
								</li>
								 -->
							</ul>


						</div>

					</div>
				</div>
		
				<div class="bar">
								<ul>
									<c:if test="${doCmsg.isReg=='1'}">
										<li><a href="${ctx}/doctor/${doCmsg.doctorId}.html"
											class="opacity">预约挂号排班表</a>
										</li>
									</c:if>
									<c:if test="${doCmsg.telconsult=='1'}">
										<li><a href="${ctx}/doctor/webdoctor/${doCmsg.doctorId}.html"
											class="opacity on">网络问诊排班表</a>
										</li>
									</c:if>

							
								</ul>
							</div> 
					
				<%-- <c:if test="${doCmsg.telconsult=='1'}"> --%>
				<div class="ys3">
						<div class="Fontsbar">
						<p>本周网络问诊排班列表</p>
						<span>Weekly Schedule</span>
						</div>
						<div class="center">
							<table cellpadding="0" cellspacing="0" class="ftable">
									<tr class="tr1">
										<td width="150" align="center">科室</td>
										<td class="bno">
										
											<table cellpadding="0" cellspacing="0">
												<tr class="tr1">
												<td  width="103px;" align="center">咨询类型</td>
													<c:forEach var="dsdds" items="${daStrings}">
													<td width="130" align="center"><p>
													<fmt:parseDate value="${dsdds}" var="date"
														pattern="yyyy/MM/dd" />
														${dsdds}
													</p><span>${fns:getWeekChina(date)}</span></td>
													</c:forEach>
												</tr>
																						
												
															
											</table>
											
										</td>
									
									</tr>
									<tr></tr>
									<tr>
										<td class="last">${doCmsg.department.name}</td>
										<td class="bno">
											<table cellpadding="0" cellspacing="0">
												
												<tr>
													<td width="100px;"><span style="color:rgb(59, 120, 222);">图文咨询</span></td>
													<c:forEach var="num" items="${numSourcelist}">
                                                     <td width="131" align="center">
                                                      	<c:if test="${num.numCount > 0}">
                                              	        	余<a style="color: #3b78de;margin-left: 5px;font-size: 14px;" href="javascript:ShowTime('${num.starttimemin}','${doCmsg.doctorId}','1')">${num.numCount}</a>
                                                      	</c:if>
                                                      	<c:if test="${num.numCount == 0}">&nbsp;</c:if>
                                                      </td>
													</c:forEach>
												</tr>
											    	<tr>
												    	<td width="100px;"><span style="color:rgb(59, 120, 222);">电话咨询</span></td>
													<c:forEach var="num" items="${numSourcelist}">
                                                     <td width="131" align="center">
                                                      	<c:if test="${num.numCount > 0}">
                                              	        	余<a style="color: #3b78de;margin-left: 5px;font-size: 14px;" href="javascript:ShowTime('${num.starttimemin}','${doCmsg.doctorId}','2')">${num.numCount}</a>
                                                      	</c:if>
                                                      	<c:if test="${num.numCount == 0}">&nbsp;</c:if>
                                                      </td>
													</c:forEach>
												</tr>
													<tr>
													<td ><span style="color:rgb(59, 120, 222);">视频咨询</span></td>
													<c:forEach var="num" items="${numSourcelist}">
                                                     <td width="131" align="center">
                                                      	<c:if test="${num.numCount > 0}">
                                              	        	余<a style="color: #3b78de;margin-left: 5px;font-size: 14px;" href="javascript:ShowTime('${num.starttimemin}','${doCmsg.doctorId}','3')">${num.numCount}</a>
                                                      	</c:if>
                                                      	<c:if test="${num.numCount == 0}">&nbsp;</c:if>
                                                      </td>
													</c:forEach>
												</tr>
											</table>
										</td>
									</tr>
						</table>
						</div>

				</div>  
			<%-- 	</c:if> --%>
				
				
				
				
				<div class="ys4">
					<div class="center">
						<div class="Fontsbar">
						<p>医生简介</p>
						<span>Doctor Introduction</span>
						</div>
						<p>${doCmsg.ddesc}</p>
					</div>
					
				</div>

		<div class="ys5">
			<div class="Fontsbar">
				<p>评论</p>
				<span>Comment</span>
			</div>
			<div class="center">
				<ul>
				   <c:forEach var="revmsg" items="${Revmsglist}">
					<li>
						<div class="l">
						
							 <c:set var="url" value="${revmsg.userurl}" />  
						     <img src="${fnf:imageScaleUrl(url,'200','200','userpc')}">
							
							<p>${revmsg.username}</p>
						</div>
						<div class="r">
							<p><fmt:formatDate value="${revmsg.reviewtime}" pattern="yyyy/MM/dd"/></p>
							<span>${revmsg.reviewcontent}</span>
						</div></li>
					 </c:forEach>
				</ul>
			</div>
		</div>
		<F>
        <input type="hidden" id="doctorids"  name="doctorids"  value="${doCmsg.doctorId}" />
         <input type="hidden" id="userinfos"  name="userinfos"  value="${userinfo.userId}" />
		</div>

 <script type="text/javascript">
	$("#chatfree").on("click", function() {
	    var userInfo = $("#userinfos").val();
		var dId = $("#doctorids").val(); 
		if(userInfo != null && userInfo !=""){
		$("body").css("overflow", "hidden")
		layer.open({
			type : 2,
			title : '免费咨询',
			shadeClose : true,
			maxmin : true, //开启最大化最小化按钮
			area : ['1160px', '460px'],
			content : '${ctx}/doctor/freeconsultinfo?docid='+dId,
			end : function() {
				$("body").css("overflow", "auto")
			}
		  })
		}
		else{
		window.location.href  ="${ctx}/login?url=/doctor/"+$("#doctorids").val()+".html";
		}
	})
	
		var olde = null;
		$(document).on("click", function(e) {
			if (olde != null) {
				$(".ysbutn li:eq(" + olde + ") .hidden").css("display", "none")
			}
			if ($(e.target).parent().attr("class") == "lidc") {
				$(e.target).parent().next().css("display", "block")
				olde = $(e.target).parent().parent().index()
			}
		})
		$(".ysbutn li .gold").each(function() {
			if ($(this).text() == "0.0") {
				$(this).text("义诊")
			}
		})

		$('.lidc img').each(function() {
			if ($(this).hasClass("off")) {
				var str = $(this).attr("src").split(".")
				$(this).attr("src", str[0] + "h" + ".png")
			}

		})
		
	 /* 增加关注 */	
	function addattention(){
	var userInfo = $("#userinfos").val();
	var doctorId = $("#doctorids").val();
	
	 if(userInfo != null && userInfo !=""){
	$.ajax({
	 	type: "POST",
			url: "${ctx}/doctor/addattention?doctorid="+doctorId,
			cache:false,
			async: false, 
			success: function(jsonJson){
				if(jsonJson.success){
					layer.msg(jsonJson.msg);
					window.location.reload();
				}else{
					layer.msg(jsonJson.msg);
				}
			}
		});
	  }
	 else{
		window.location.href  ="${ctx}/login?url=/doctor/"+$("#doctorids").val()+".html";
		}
		
		
   }
   /* 取消关注 */
   	function delattention(){
   	var userInfo = $("#userinfos").val();
	var doctorId = $("#doctorids").val(); 
	 if(userInfo != null && userInfo !=""){
	$.ajax({
	 	type: "POST",
			url: "${ctx}/doctor/delattention?doctorid="+doctorId,
			cache:false,
			async: false, 
			success: function(jsonJson){
				if(jsonJson.success){
				    layer.msg(jsonJson.msg);
					/* //alert(jsonJson.msg); */
				   window.location.reload(); 
				}else{
				   layer.msg(jsonJson.msg);
					/* alert(jsonJson.msg); */
				}
			}
		});
	  }
	 else{
	  window.location.href  ="${ctx}/login?url=/doctor/"+$("#doctorids").val()+".html";
		}
		
   }
   
   
	function ShowTime(sourcedate,doctorid,type) {
	var userinfos = $("#userinfos").val();
	if(userinfos != null && userinfos !=""){
			var index = layer.load(0, {
				    shade: [0.1,'#fff'] //0.1透明度的白色背景
				});
			
		        layer.close(index); 
								 layer.open({
							       			type: 2,
								            title: '选择时间段',
								            shadeClose: true,
								            maxmin: true, //开启最大化最小化按钮
								            area: ['600px', '320px'],
								            content: '${ctx}/userinfo/webTimeQuantum?doctorid='+doctorid+'&sourcetime='+sourcedate+'&types='+type,
								            success: function(layero, index){
							    			}
									 	});
		            }else{
		            window.location.href  ="${ctx}/login?url=/doctor/webdoctor/"+$("#doctorids").val()+".html";
		            }  
	}
   var olde = null;
$(document).on("click",function(e){ 
					if(olde != null){ 
						$(".ysbutn li:eq("+olde+") .hidden").css("display","none")
					}
					if($(e.target).parent().attr("class") == "lidc"){
								$(e.target).parent().next().css("display","block")
								olde=$(e.target).parent().parent().index()
					}
})
$("#slider").powerSlider({handle:"left"});
 </script>

</body>
</html>
