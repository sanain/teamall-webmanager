<%@ page contentType="text/html;charset=UTF-8" %><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
		<div class="center">
					<div class="t1 tlogo">
							<div class="logo_fs nlogo">
									<a href="${ctx}/"><img src="${ctxStaticFront}/images/logos.png"></a>
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
												   		<li><a href="${ctx}/login" style="" class="loging ">登陆/注册</a></li>
												   </c:when>   
												   <c:otherwise> 
												        <li><a href="${ctx}/userinfo/baseinfo" style="" class="landed ">${userinfo.mobileNo}</a>，<a href="${ctx}/loginout" class="del">注销</a></li>
												   		
												   </c:otherwise>  
												</c:choose>
												
										</ul>	
							</div>
					</div>

				</div>
		
		
		