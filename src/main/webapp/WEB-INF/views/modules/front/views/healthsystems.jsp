<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/modules/front/include/taglib.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta name="decorator" content="frontdefault" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<meta name="keywords" content="" />
<meta name="description" content="" />

</head>
<body >	
			<div class="block_name mtt suc"> 
							<span class="">Friendship link</span>
							<p class="">
								<c:choose>
									<c:when test="${code == 'wsj' }">卫生系统</c:when>
									<c:otherwise>
										<c:choose>
											<c:when test="${code == 'yjj' }">药监</c:when>
											<c:otherwise>
												<c:choose>
													<c:when test="${code == 'rkjs' }">人口计生</c:when>
													<c:otherwise>
														<c:choose>
															<c:when test="${code == 'ybj' }">医保局</c:when>
															<c:otherwise>
																<c:choose>
																	<c:when test="${code == 'hszh' }">红十字会</c:when>
																	<c:otherwise></c:otherwise>
																</c:choose>
															</c:otherwise>
														</c:choose>
													</c:otherwise>
												</c:choose>
											</c:otherwise>
										</c:choose>
									</c:otherwise>
								</c:choose>
							</p>
							<div class="brd"></div>
				</div>
				<!-- 
				<div class="Statistics">
					<div class="center">
						
						<div class="Commune">
							<p>地区：</p>
							<div class="StatBox opacity">
								<div class="Boxbg">
									<a class="opacity">成都市<em class="opacity"></em></a>
									<a class="opacity">成都市<em class="opacity"></em></a>
									<a class="opacity">成都市<em class="opacity"></em></a>
								</div>
							</div>
							
						</div>

					</div>


				</div>
				 -->
				<div class="HealthText">
					<div class="center">
						<ul>
							<li>
								<p>国家级:</p>
								<div class="link">
									<c:forEach items="${areaName_国家级 }" var="lk" begin="0">
										<a target="_blank" href="${lk[11] }" class="opacity">${lk[10] }</a>
									</c:forEach>
								</div>
							</li>
							<li>
								<p>成都市:</p>
								<div class="link">
									<c:forEach items="${areaName_成都市 }" var="lk">
										<a target="_blank" href="${lk[11] }" class="opacity">${lk[10] }</a>
									</c:forEach>
								</div>
							</li>
							<li>
								<p>自贡市:</p>
								<div class="link">
									<c:forEach items="${areaName_自贡市 }" var="lk">
										<a target="_blank" href="${lk[11] }" class="opacity">${lk[10] }</a>
									</c:forEach>
								</div>
							</li>
							<li>
								<p>乐山市:</p>
								<div class="link">
									<c:forEach items="${areaName_乐山市 }" var="lk">
										<a target="_blank" href="${lk[11] }" class="opacity">${lk[10] }</a>
									</c:forEach>
								</div>
							</li>
							<li>
								<p>眉山市:</p>
								<div class="link">
									<c:forEach items="${areaName_眉山市 }" var="lk">
										<a target="_blank" href="${lk[11] }" class="opacity">${lk[10] }</a>
									</c:forEach>
								</div>
							</li>
							<li>
								<p>广元市:</p>
								<div class="link">
									<c:forEach items="${areaName_广元市 }" var="lk">
										<a target="_blank" href="${lk[11] }" class="opacity">${lk[10] }</a>
									</c:forEach>
								</div>
							</li>
							<li>
								<p>达州市:</p>
								<div class="link">
									<c:forEach items="${areaName_达州市 }" var="lk">
										<a target="_blank" href="${lk[11] }" class="opacity">${lk[10] }</a>
									</c:forEach>
								</div>
							</li>
							<li>
								<p>攀枝花市:</p>
								<div class="link">
									<c:forEach items="${areaName_攀枝花市 }" var="lk">
										<a target="_blank" href="${lk[11] }" class="opacity">${lk[10] }</a>
									</c:forEach>
								</div>
							</li>
							<li>
								<p>南充市:</p>
								<div class="link">
									<c:forEach items="${areaName_南充市 }" var="lk">
										<a target="_blank" href="${lk[11] }" class="opacity">${lk[10] }</a>
									</c:forEach>
								</div>
							</li>
							<li>
								<p>阿坝州:</p>
								<div class="link">
									<c:forEach items="${areaName_阿坝州 }" var="lk">
										<a target="_blank" href="${lk[11] }" class="opacity">${lk[10] }</a>
									</c:forEach>
								</div>
							</li>
							<li>
								<p>泸州市:</p>
								<div class="link">
									<c:forEach items="${areaName_泸州市 }" var="lk">
										<a target="_blank" href="${lk[11] }" class="opacity">${lk[10] }</a>
									</c:forEach>
								</div>
							</li>
							<li>
								<p>绵阳市:</p>
								<div class="link">
									<c:forEach items="${areaName_绵阳市 }" var="lk">
										<a target="_blank" href="${lk[11] }" class="opacity">${lk[10] }</a>
									</c:forEach>
								</div>
							</li>
							<li>
								<p>内江市:</p>
								<div class="link">
									<c:forEach items="${areaName_内江市 }" var="lk">
										<a target="_blank" href="${lk[11] }" class="opacity">${lk[10] }</a>
									</c:forEach>
								</div>
							</li>
							<li>
								<p>宜宾市:</p>
								<div class="link">
									<c:forEach items="${areaName_宜宾市 }" var="lk">
										<a target="_blank" href="${lk[11] }" class="opacity">${lk[10] }</a>
									</c:forEach>
								</div>
							</li>
							<li>
								<p>遂宁市:</p>
								<div class="link">
									<c:forEach items="${areaName_遂宁市 }" var="lk">
										<a target="_blank" href="${lk[11] }" class="opacity">${lk[10] }</a>
									</c:forEach>
								</div>
							</li>
							<li>
								<p>巴中市:</p>
								<div class="link">
									<c:forEach items="${areaName_巴中市 }" var="lk">
										<a target="_blank" href="${lk[11] }" class="opacity">${lk[10] }</a>
									</c:forEach>
								</div>
							</li>
							<li>
								<p>德阳市:</p>
								<div class="link">
									<c:forEach items="${areaName_德阳市 }" var="lk">
										<a target="_blank" href="${lk[11] }" class="opacity">${lk[10] }</a>
									</c:forEach>
								</div>
							</li>
							<li>
								<p>广安市:</p>
								<div class="link">
									<c:forEach items="${areaName_广安市 }" var="lk">
										<a target="_blank" href="${lk[11] }" class="opacity">${lk[10] }</a>
									</c:forEach>
								</div>
							</li>
							<li>
								<p>资阳市:</p>
								<div class="link">
									<c:forEach items="${areaName_资阳市 }" var="lk">
										<a target="_blank" href="${lk[11] }" class="opacity">${lk[10] }</a>
									</c:forEach>
								</div>
							</li>
							<li>
								<p>甘孜州:</p>
								<div class="link">
									<c:forEach items="${areaName_甘孜州 }" var="lk">
										<a target="_blank" href="${lk[11] }" class="opacity">${lk[10] }</a>
									</c:forEach>
								</div>
							</li>
							<li>
								<p>雅安市:</p>
								<div class="link">
									<c:forEach items="${areaName_雅安市 }" var="lk">
										<a target="_blank" href="${lk[11] }" class="opacity">${lk[10] }</a>
									</c:forEach>
								</div>
							</li>
							<li>
								<p>凉山州:</p>
								<div class="link">
									<c:forEach items="${areaName_凉山州 }" var="lk">
										<a target="_blank" href="${lk[11] }" class="opacity">${lk[10] }</a>
									</c:forEach>
								</div>
							</li>
						</ul>
					</div>
				</div>


		</div>
			

</body>
</html>
