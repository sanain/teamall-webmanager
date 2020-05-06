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
<body >	

		<div id="content"> 
					<div class="slct">
							<div class="block_name mt"> 
							
							<span class="">Internet medical treatment</span>
							<p class="">网络医疗</p>
							<div class="brd"></div>
							</div>

							<img src="${ctxStaticFront}/images/select.png">

					</div>
						<div class="shm">
								<form action="${ctx}/medical/queryDoctor" >
						
								
											<div class="secbg sle">
												<div class="center"> 
													<ul >
															<li><p>区域</p>
										 <select id="cityId" name="cityId" class="step1" onchange="changeLac(this.value)">
														 <c:if test="${empty cityId or cityId == 0}">
												        	<option value="0" selected="selected">---所有---</option>
												         </c:if>
												<c:forEach var="cityitem" items="${citys}">
														<c:choose> 
														 <c:when test="${cityitem.cityid == cityId}"> 
															<option value="${cityitem.cityid}">
																	${cityitem.city}			
															</option>
														 </c:when> 	
														 <c:otherwise>	
															<option value="${cityitem.cityid}">
																	${cityitem.city}			
															</option>
														 </c:otherwise>
													</c:choose> 
												</c:forEach>
													<c:if test="${!empty cityId}">
														<option value="0">---所有---</option>
													</c:if>
													
												
											</select>	
											
											</li>
											
											
										<li><p>级别</p>
										<select id="levelId" name="levelId" class="step2" onchange="changeLac(this.value)">
												
												 <c:if test="${empty levelId or levelId == 0}">
												        	<option value="0" selected="selected">---所有---</option>
												         </c:if>
											<c:forEach var="map" items="${level }">
														<c:choose> 
														 <c:when test="${map.id == levelId}"> 
															<option value="${map.id}">
																	${map.hospitalLevelName}			
															</option>
														 </c:when> 	
														 <c:otherwise>	
															<option value="${map.id}">
																	${map.hospitalLevelName}			
															</option>
														 </c:otherwise>
													</c:choose> 
												</c:forEach>
													<c:if test="${!empty levelId}">
														<option value="0">---所有---</option>
													</c:if>
												
										
										</select>
															</li>
															
														
													<li><p>类别</p>
													<select  id="departmentId" name="departmentId" class="step3" onchange="changeLac(this.value)">
													 <c:if test="${empty departmentId or departmentId eq '0'}">
												        	<option value="0" selected="selected">---所有---</option>
												         </c:if>
												<c:forEach var="types" items="${type }">
														<c:choose> 
														 <c:when test="${types.id eq departmentId}"> 
															<option value="${types.id}">
																	${types.hospitalTypeName}			
															</option>
														 </c:when> 	
														 <c:otherwise>	
															<option value="${types.id}">
																	${types.hospitalTypeName}			
															</option>
														 </c:otherwise>
													</c:choose> 
												</c:forEach>
													<c:if test="${!empty departmentId}">
														<option value="0">---所有---</option>
													</c:if>
													
													</select>
													
													
														</li>
																	
															
															
													<li><p>医院</p>
														<select id="step4" name="hospId" >
															
													 <c:if test="${empty hospId or hospId == 0}">
												        	<option value="0" selected="selected">---所有---</option>
												         </c:if>
												<c:forEach var="ho" items="${hospitas }">
												
													<c:if test="${not empty hospId }">
														<c:choose> 
														 <c:when test="${ho.hospitalId == hospId}"> 
															<option value="${ho.hospitalId}">
																	${ho.name}			
															</option>
														 </c:when> 	
														 <c:otherwise>	
															<option value="${ho.hospitalId}">
																	${ho.name}			
															</option>
														 </c:otherwise>
													</c:choose> 
													
													</c:if>
												</c:forEach>
													<c:if test="${!empty hospId}">
														<option value="0">---所有---</option>
													</c:if>
															
														</select>	
														
														</li>		
															
															<li style="margin-right:0;"><input type="text"  name="hosNmae"  value="${hosNmae}" placeholder="医院名"><input type="submit" value=""></li>
													</ul>
												
												

												</div>
											</div>

							</div>
							
							</form>
					
					
					<div class="i5 sel5">
						<div class="center">
							<ul>
										<li class="">
											<div class="userpic animate-element scale" style="background:url(${ctxStaticFront}images/pic.png) center no-repeat"> 
												<a href="">
												<p class="opacity"><span>
													擅长： 过敏性鼻结膜炎、过敏性哮喘、荨麻疹/血管性水肿、食物过敏、药物过敏、变应性肺真菌病。
												</span></p>
												</a>
											</div>

											<div class="fonts animate-element bottom_to_top">
												<p class="p1">小之前 <span>博士/主任医师</span></p>
												<p class="p2">成都军区总医院</p>
												<div class="State">
													<a class="off" style="">排号</a>
													<a class="off" style="">排号</a>
													<a class="off" style="">排号</a>
													<a class="off" style="">排号</a>
													<a class="off" style="">排号</a>
												</div>
											</div>
										</li>
										<li class="">
											<div class="userpic animate-element scale" style="background:url(${ctxStaticFront}/images/pic.png) center no-repeat"> 
												<a href="">
												<p class="opacity"><span>
													擅长： 过敏性鼻结膜炎、过敏性哮喘、荨麻疹/血管性水肿、食物过敏、药物过敏、变应性肺真菌病。
												</span></p>
												</a>
											</div>

											<div class="fonts animate-element bottom_to_top">
												<p class="p1">小之前 <span>博士/主任医师</span></p>
												<p class="p2">成都军区总医院</p>
												<div class="State">
													<a class="off" style="background-image:url(${ctxStaticFront}/images/seico1.png)"></a>
													<a class="off" style="background-image:url(${ctxStaticFront}/images/seico2.png)"></a>
													<a class="off" style="background-image:url(${ctxStaticFront}/images/seico3.png)"></a>
												
												</div>
											</div>
										</li>
										<li class="">
											<div class="userpic animate-element scale" style="background:url(${ctxStaticFront}/images/pic.png) center no-repeat"> 
												<a href="">
												<p class="opacity"><span>
													擅长： 过敏性鼻结膜炎、过敏性哮喘、荨麻疹/血管性水肿、食物过敏、药物过敏、变应性肺真菌病。
												</span></p>
												</a>
											</div>

											<div class="fonts animate-element bottom_to_top">
												<p class="p1">小之前 <span>博士/主任医师</span></p>
												<p class="p2">成都军区总医院</p>
												<div class="State">
													<a class="off" style="background-image:url(${ctxStaticFront}/images/seico1.png)"></a>
													<a class="off" style="background-image:url(${ctxStaticFront}/images/seico2.png)"></a>
													<a class="off" style="background-image:url(${ctxStaticFront}/images/seico3.png)"></a>
												
												</div>
											</div>
										</li>
										<li class="">
											<div class="userpic animate-element scale" style="background:url(${ctxStaticFront}/images/pic.png) center no-repeat"> 
												<a href="">
												<p class="opacity"><span>
													擅长： 过敏性鼻结膜炎、过敏性哮喘、荨麻疹/血管性水肿、食物过敏、药物过敏、变应性肺真菌病。
												</span></p>
												</a>
											</div>

											<div class="fonts animate-element bottom_to_top">
												<p class="p1">小之前 <span>博士/主任医师</span></p>
												<p class="p2">成都军区总医院</p>
												<div class="State">
													<a class="off" style="background-image:url(${ctxStaticFront}/images/seico1.png)"></a>
													<a class="off" style="background-image:url(${ctxStaticFront}/images/seico2.png)"></a>
													<a class="off" style="background-image:url(${ctxStaticFront}/images/seico3.png)"></a>
												
												</div>
											</div>
										</li>
										<li class="">
											<div class="userpic animate-element scale" style="background:url(${ctxStaticFront}/images/pic.png) center no-repeat"> 
												<a href="">
												<p class="opacity"><span>
													擅长： 过敏性鼻结膜炎、过敏性哮喘、荨麻疹/血管性水肿、食物过敏、药物过敏、变应性肺真菌病。
												</span></p>
												</a>
											</div>

											<div class="fonts animate-element bottom_to_top">
												<p class="p1">小之前 <span>博士/主任医师</span></p>
												<p class="p2">成都军区总医院</p>
												<div class="State">
													<a class="off" style="background-image:url(${ctxStaticFront}/images/seico1.png)"></a>
													<a class="off" style="background-image:url(${ctxStaticFront}/images/seico2.png)"></a>
													<a class="off" style="background-image:url(${ctxStaticFront}/images/seico3.png)"></a>
												
												</div>
											</div>
										</li>
										<li class="">
											<div class="userpic animate-element scale" style="background:url(${ctxStaticFront}/images/pic.png) center no-repeat"> 
												<a href="">
												<p class="opacity"><span>
													擅长： 过敏性鼻结膜炎、过敏性哮喘、荨麻疹/血管性水肿、食物过敏、药物过敏、变应性肺真菌病。
												</span></p>
												</a>
											</div>

											<div class="fonts animate-element bottom_to_top">
												<p class="p1">小之前 <span>博士/主任医师</span></p>
												<p class="p2">成都军区总医院</p>
												<div class="State">
													<a class="off" style="background-image:url(${ctxStaticFront}/images/seico1.png)"></a>
													<a class="off" style="background-image:url(${ctxStaticFront}/images/seico2.png)"></a>
													<a class="off" style="background-image:url(${ctxStaticFront}/images/seico3.png)"></a>
												
												</div>
											</div>
										</li>
										<li class="">
											<div class="userpic animate-element scale" style="background:url(${ctxStaticFront}/images/pic.png) center no-repeat"> 
												<a href="">
												<p class="opacity"><span>
													擅长： 过敏性鼻结膜炎、过敏性哮喘、荨麻疹/血管性水肿、食物过敏、药物过敏、变应性肺真菌病。
												</span></p>
												</a>
											</div>

											<div class="fonts animate-element bottom_to_top">
												<p class="p1">小之前 <span>博士/主任医师</span></p>
												<p class="p2">成都军区总医院</p>
												<div class="State">
													<a class="off" style="background-image:url(${ctxStaticFront}/images/seico1.png)"></a>
													<a class="off" style="background-image:url(${ctxStaticFront}/images/seico2.png)"></a>
													<a class="off" style="background-image:url(${ctxStaticFront}/images/seico3.png)"></a>
												
												</div>
											</div>
										</li>
										<li class="">
											<div class="userpic animate-element scale" style="background:url(${ctxStaticFront}/images/pic.png) center no-repeat"> 
												<a href="">
												<p class="opacity"><span>
													擅长： 过敏性鼻结膜炎、过敏性哮喘、荨麻疹/血管性水肿、食物过敏、药物过敏、变应性肺真菌病。
												</span></p>
												</a>
											</div>

											<div class="fonts animate-element bottom_to_top">
												<p class="p1">小之前 <span>博士/主任医师</span></p>
												<p class="p2">成都军区总医院</p>
												<div class="State">
													<a class="off" style="background-image:url(${ctxStaticFront}/images/seico1.png)"></a>
													<a class="off" style="background-image:url(${ctxStaticFront}/images/seico2.png)"></a>
													<a class="off" style="background-image:url(${ctxStaticFront}/images/seico3.png)"></a>
												
												</div>
											</div>
										</li>
										<li class="">
											<div class="userpic animate-element scale" style="background:url(${ctxStaticFront}/images/pic.png) center no-repeat"> 
												<a href="">
												<p class="opacity"><span>
													擅长： 过敏性鼻结膜炎、过敏性哮喘、荨麻疹/血管性水肿、食物过敏、药物过敏、变应性肺真菌病。
												</span></p>
												</a>
											</div>

											<div class="fonts animate-element bottom_to_top">
												<p class="p1">小之前 <span>博士/主任医师</span></p>
												<p class="p2">成都军区总医院</p>
												<div class="State">
													<a class="off" style="background-image:url(${ctxStaticFront}/images/seico1.png)"></a>
													<a class="off" style="background-image:url(${ctxStaticFront}/images/seico2.png)"></a>
													<a class="off" style="background-image:url(${ctxStaticFront}/images/seico3.png)"></a>
												
												</div>
											</div>
										</li>
										<li class="">
											<div class="userpic animate-element scale" style="background:url(${ctxStaticFront}/images/pic.png) center no-repeat"> 
												<a href="">
												<p class="opacity"><span>
													擅长： 过敏性鼻结膜炎、过敏性哮喘、荨麻疹/血管性水肿、食物过敏、药物过敏、变应性肺真菌病。
												</span></p>
												</a>
											</div>

											<div class="fonts animate-element bottom_to_top">
												<p class="p1">小之前 <span>博士/主任医师</span></p>
												<p class="p2">成都军区总医院</p>
												<div class="State">
													<a class="off" style="background-image:url(${ctxStaticFront}/images/seico1.png)"></a>
													<a class="off" style="background-image:url(${ctxStaticFront}/images/seico2.png)"></a>
													<a class="off" style="background-image:url(${ctxStaticFront}/images/seico3.png)"></a>
												
												</div>
											</div>
										</li>
										<li class="">
											<div class="userpic animate-element scale" style="background:url(images/pic.png) center no-repeat"> 
												<a href="">
												<p class="opacity"><span>
													擅长： 过敏性鼻结膜炎、过敏性哮喘、荨麻疹/血管性水肿、食物过敏、药物过敏、变应性肺真菌病。
												</span></p>
												</a>
											</div>

											<div class="fonts animate-element bottom_to_top">
												<p class="p1">小之前 <span>博士/主任医师</span></p>
												<p class="p2">成都军区总医院</p>
												<div class="State">
													<a class="off" style="background-image:url(images/seico1.png)"></a>
													<a class="off" style="background-image:url(images/seico2.png)"></a>
													<a class="off" style="background-image:url(images/seico3.png)"></a>
												
												</div>
											</div>
										</li>
										<li class="">
											<div class="userpic animate-element scale" style="background:url(images/pic.png) center no-repeat"> 
												<a href="">
												<p class="opacity"><span>
													擅长： 过敏性鼻结膜炎、过敏性哮喘、荨麻疹/血管性水肿、食物过敏、药物过敏、变应性肺真菌病。
												</span></p>
												</a>
											</div>

											<div class="fonts animate-element bottom_to_top">
												<p class="p1">小之前 <span>博士/主任医师</span></p>
												<p class="p2">成都军区总医院</p>
												<div class="State">
													<a class="off" style="background-image:url(images/seico1.png)"></a>
													<a class="off" style="background-image:url(images/seico2.png)"></a>
													<a class="off" style="background-image:url(images/seico3.png)"></a>
												
												</div>
											</div>
										</li>
										





								</ul>
						</div>


					</div>
					<div class="page pgb">
											<a href="">首页</a>
											<a href="">上一页</a>
											<a href="">1</a>
											<a href="">2</a>
											<a href="">下一页</a>
											<a href="">尾页</a>

					</div>
		</div>


<script type="text/javascript">



  function changeLac(v) {  
    jQuery('#step4').html(""); //把ci内容设为空  
    var ciValue = jQuery('#step4');  
    ciValue.append('<option value="0">---请选择---</option>');  
      
    //异步请求查询ci列表的方法并返回json数组  
    jQuery.ajax({  
        url : '${ctx}/medical/hospitalbycityAndlevel',  
        type : 'post',  
        data : { cityId : $("#cityId").val(),levelId: $("#levelId").val(),departmentId: $("#departmentId").val() },  
        dataType : 'json',  
        success : function (opts) {  
            if (opts && opts.length > 0) {  
                    var html = [];  
                    for (var i = 0; i < opts.length; i++) {  
                        html.push('<option value="'+opts[i].hospitalId+'">'+opts[i].name+'</option>');  
                    }  
                    ciValue.append(html.join(''));  
                }  
            }  
        });  

}  


function page(n, s) {
		if (n)
			$("#pageNo").val(n);
		if (s)
			$("#pageSize").val(s);
		$("#searchForm").submit();
		return false;
}





</script>
</body>

</html>
