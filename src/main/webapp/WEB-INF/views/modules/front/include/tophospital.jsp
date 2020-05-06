<%@ page contentType="text/html;charset=UTF-8" %><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
#top_ys {
    width: 100%;
    padding-top: 11px;
    height: 68px;
}
#top_ys .t2 .State {
    float: right;
    width: auto;
    position:absolute; 
    top:35px; 
    right:93px;

}
.State a{    behavior: url(../static/front/js/PIE.htc);line-height: 18px;font-size: 12px;color: #fff;text-align: center;display:inline-block;padding: 0 7px;height: 20px;background-color: #fe824c;text-align: center;float: left;background-position:center;background-repeat: no-repeat;margin-right: 5px;border-radius: 8px;margin-top: 23px; }
</style>	
	
		<div class="center">
					<div class="t1">
							<div class="logo_fs">
									<p><a style="color: blue;" href="${ctx}/"><img src="${ctxStaticFront}/images/logo_zoom.png"><span>${fns:getProjectName()}</span></a></p>
									<p class="p2">
									
									  <c:if test="${empty hospital.hospitallogurl}">
								<img  height="15" width="14" src="${ctxStaticFront}/images/logo_keshis.png">
								</c:if>
							 <c:if test="${not empty hospital.hospitallogurl}">
								<img  height="15" width="14" src="${ctxStaticFront}/images/logo_keshis.png">
							</c:if>
									<a style="color: blue;" href="${ctx}/hospital/${hospital.hospitalId}.html"> <span>${hospital.name}</span></a></p>

							</div>
							
							<div class="r"> 
							
										<ul>
												<li><a href="${ctx}/search/search${urlSuffix}" style="" class="search ">搜索</a></li>
												<li><a href="${ctx}/appload" style="" class="user ">客户端</a></li>
												<c:set var="userinfo" value="${fnf:getUserInfo()}"/>																		
												<c:choose>
												   <c:when test="${userinfo eq null}">
												   		<li><a href="${ctx}/login" style="" class="loging ">登陆/注册</a></li>
												   </c:when>   
												   <c:otherwise> 
												        <li><a href="${ctx}/userinfo/baseinfo" style="" class="landed ">${userinfo.mobileNo}</a>，<a href="${ctx}/loginout" class="del">注销</a></li>
												   		
												   </c:otherwise>  
												</c:choose>
										</ul>	
							</div>
					</div>
					<div class="t2">
						<div class="logo_kes">
						<%-- <ul>
							     <c:if test="${empty hospital.hospitallogurl}">
									<img  height="35" width="35" src="${ctxStaticFront}/images/logo_keshis.png">
									</c:if>
								 <c:if test="${not empty hospital.hospitallogurl}">
									<img  height="35" width="35" src="${hospital.hospitallogurl}">
								</c:if>
									<div style="position:absolute; top:47px; left:150px;"><b>${hospital.name}</b></div>
							</ul> --%>
						</div>	
						<div class="State">
						                    <c:if test="${hospital.hasRegConfirm=='1'}">
											  <a  class=""  style="">挂号</a>
											</c:if>
											 <c:if test="${hospital.hasRegConfirm !='1'}">
											  <a  class="off" style="">挂号</a>
											</c:if>
											  
											<c:if test="${hospital.isinterrogation !='1'}">
											  <a class="off" style="">远程</a>
											</c:if>
											<c:if test="${hospital.isinterrogation=='1'}">
											  <a class="" style="">远程</a>
											</c:if>
											
											<c:if test="${hospital.waitstat != 1}">
											  <a class="off" style="">排队</a>
											</c:if>
											<c:if test="${hospital.waitstat== 1}">
											  <a class="" style="">排队</a>
											</c:if>
											
											<c:if test="${hospital.reportstat != 1}">
											  <a class="off" style="">报告</a>
											</c:if>
											<c:if test="${hospital.reportstat == 1}">
											  <a class="" style="">报告</a>
											</c:if>
											
											<c:if test="${hospital.payonlinestat != 1}">
											<a class="off" style="">门诊</a>
											</c:if>
											<c:if test="${hospital.payonlinestat == 1}">
											<a class="" style="">门诊</a>
											</c:if>
											
											<c:if test="${hospital.payonlinestat != 1}">
											 <a class="off" style="">缴费</a>
											</c:if>
											<c:if test="${hospital.payonlinestat == 1}">
											 <a class="" style="">缴费</a>
											</c:if>

						</div>



					</div>



				</div>
