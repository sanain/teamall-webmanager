<%@ page contentType="text/html;charset=UTF-8" %><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
		<div class="center">
					<div class="t1">
							<div class="logo_fs">
									<p><a style="color: blue;" href="${ctx}/"><img src="${ctxStaticFront}/images/logo_zoom.png"><span>健康四川</span></a></p>
									<p class="p2"><a href="${ctx}/hospital/${doCmsg.hospitalId}.html">
									<c:if test="${empty doCmsg.getDepartment().getHospital().hospitallogurl}">
						              <img  height="15" width="14" src="${ctxStaticFront}/images/logo_keshis.png">
							     	</c:if>
							        <c:if test="${not empty doCmsg.getDepartment().getHospital().hospitallogurl}">
								      <img  height="15" width="14" src="${doCmsg.getDepartment().getHospital().hospitallogurl}">
							        </c:if>
									
									<%-- <img src="${ctxStaticFront}/images/logo_zoom.jpg"> --%>
									<span style="color: blue;">${doCmsg.getDepartment().getHospital().getName()}</span></a></p>

							</div>
							<div class="l">
								<div class="tell"> 
								<p>客服电话： 400 - 1681120 </p>

								</div>


							</div>
							<div class="r"> 
							
										<ul>
												<li><a href="${ctx}/search/search${urlSuffix}" style="" class="search ">搜索</a></li>
												<li><a href="${ctx}/appload" style="" class="user ">客户端</a></li>
												
												<c:set var="userinfo" value="${fnf:getUserInfo()}"/>
												
																																	
												<c:choose>
												   <c:when test="${userinfo eq null}">
												   		<li><a href="${ctx}/login?url=/doctor/${doCmsg.doctorId}.html"  style="" class="loging ">登陆/注册</a></li>
												   </c:when>   
												   <c:otherwise> 
												        <li><a href="${ctx}/userinfo/baseinfo" style="" class="landed ">${userinfo.mobileNo}</a>，<a href="${ctx}/loginout" class="del">注销</a></li>
												   		
												   </c:otherwise>  
												</c:choose>
										</ul>	
							</div>
					</div>




				</div>
