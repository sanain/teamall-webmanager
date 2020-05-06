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
		<div class="newsnav"> 
								<div class="center">
										<a href="${ctx}/">首页   ></a><a href="${ctx}/womenandchildreninfo">全省号源  </a>

								</div>
								


						</div> 
			<div class="block_name mtt suc"> 
							<span class=""> PROVINCE NUMBER</span>
							<p class="">全省号源</p>
							<div class="brd"></div>
				</div>
				<div class="Statistics">
					<div class="center">
						<form action="${ctx}/statistics" method="pos" id="searchForm">
							<input id="pageNo"   name="pageNo" type="hidden" value="${page.pageNo}"/>
							<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
							<input type="hidden" name="cityId" value="" id="cityId"/>
							<input type="hidden" name="areaId" value="" id="areaId"/>
							<input type="hidden" name="depId" value="" id="depId"/>
						<div class="Province">
							<p><em></em>四川省</p>	
							<span>找到<b>${page.count}</b>家医院</span>
							  <div class="StatisticsSearch">
								<input type="text"  name="searchKey" value="${searchKey}" placeholder="输入医院名搜索">
								<input type="submit" value="">
							 </div>
						</div>
						</form>
						<div class="Commune">
							<p>地级市（州）：</p>
							<div class="StatBox opacity">
								<div class="Boxbg">
									<div class="chengshi" >
													<c:if test="${cityId == '0'}">
															<a  id="0"  class="opacity on">全部<em class="opacity on" ></em></a>
													</c:if>
													<c:if test="${cityId != '0'}">
															<a  id="0" class="opacity">全部<em class="opacity" ></em></a>
													</c:if>
												<c:forEach items="${city}" var="cis">
												<c:if test="${cis.cityid == cityId}">
														<a  class="opacity on" id="${cis.cityid}">${cis.city}<em class="opacity on"></em></a>
												</c:if>
									</c:forEach>
									<c:forEach items="${city}" var="cis">
												<c:if test="${cis.cityid != cityId}">
														<a class="opacity" id="${cis.cityid}">${cis.city}<em class="opacity"></em></a>
												</c:if>
									</c:forEach>
									</div>
								</div>
							</div>
							
						</div>
						<div class="Commune">
							<p>区  /  县：</p>
							<div class="StatBox opacity">
								<div class="Boxbg">
									<div class="ares">
											<c:if test="${areaId == '0'}">
															<a id="0" class="opacity on">全部<em class="opacity on" ></em></a>
													</c:if>
													<c:if test="${areaId != '0'}">
															<a id="0" class="opacity">全部<em class="opacity" ></em></a>
													</c:if>
														<c:forEach items="${area}" var="area">
															<c:if test="${area.areaid == areaId}">
																	<a class="opacity on" id="${area.areaid}">${area.area}<em class="opacity on"></em></a>
															</c:if>
															
														
														</c:forEach>
														<c:forEach items="${area}" var="area">
														
															<c:if test="${area.areaid != areaId}">
																	<a class="opacity" id="${area.areaid}">${area.area}<em class="opacity"></em></a>
															</c:if>
														</c:forEach>
										
									</div>
								</div>
							</div>
							
						</div> 
						
						
						<div class="Commune">
							<p>科室：</p>
							<div class="StatBox opacity">
								<div class="Boxbg">
								        <div class="depatment">
								        		<c:if test="${depId == '0'}">
															<a  id="0"  class="opacity on">全部<em class="opacity on" ></em></a>
													</c:if>
													<c:if test="${depId != '0'}">
															<a  id="0" class="opacity">全部<em class="opacity" ></em></a>
													</c:if>
											<c:forEach items="${depList}" var="cis">
												<c:if test="${cis.id == depId}">
														<a  class="opacity on" id="${cis.id}">${cis.depName}<em class="opacity on"></em></a>
													</c:if>
											</c:forEach>
											<c:forEach items="${depList}" var="cis">
													<c:if test="${cis.id != depId}">
															<a class="opacity" id="${cis.id}" style="color:#8B6914;">${cis.depName}<em class="opacity"></em></a>
													</c:if>
											</c:forEach>
								        
								        
								        
								        
								        
								        <%--  <c:if test="${deptementKey == '0'}">
										    <a id="0" class="opacity on">全部<em class="opacity on" ></em></a>
										</c:if>
										<c:if test="${deptementKey != '0'}">
										     <a id="0" class="opacity ">全部<em class="opacity " ></em></a>
										</c:if>
										   <a class="opacity ${deptementKey=='儿科'?'on':''}" id="儿科">儿科<em class="opacity ${deptementKey=='儿科'?'on':''}"></em></a>
										   <a class="opacity ${deptementKey == '妇科'?'on':'' }" id="妇科">妇科<em class="opacity ${deptementKey == '妇科'?'on':'' }"></em></a>
										   <a class="opacity ${deptementKey == '产科'?'on':'' }" id="产科">产科<em class="opacity ${deptementKey == '产科'?'on':'' }"></em></a>
									  --%>
										</div>
								</div>
							</div>
							
						</div>	
						
						
						
						
						
						
						
							
					</div>


				</div>
				<div class="StatisticsText">
					<div class="center">
						<h1><p class="title">当前地区共<b>${page.count}</b>家医院,共余<b>${counts}</b>号<%-- ,共<b>${bedcounts}</b>床位</p> --%></p> <p class="right"><!-- <a href="" class="on">列表</a><a href="">图表</a> --></p></h1>
						<ul id="warp">
						 <c:forEach items="${page.list}" var="hos">
						 <li class="">
								<a href="${ctx}/hospital/${hos.hospitalId}.html?indexs=statiscs&depId=${depId}">
								    <c:if test="${not empty hos.stophosname}">
								    <p class="title">${hos.stophosname}</p>
								    </c:if>	
								     <c:if test="${empty hos.stophosname}">
									<p class="title">${hos.name}</p>
									 </c:if>
									    <c:if test="${empty hos.stophosname && hos.hisInterfaceType != 0}">	
									 <%--   <p class="spare"><span style="position:relative;top:-15px;font-size:15px;">余<b>${hos.allnum}</b>号源</p></span>
									     <p class="spare"><span style="position:relative;top:-12px;font-size:15px;">余<b>${hos.leavebeds}</b>床位</p></span> --%>
								     <p class="spare">余<b>${hos.allnum}</b>号源</p>
									    </c:if>
									    <c:if test="${empty hos.stophosname && hos.hisInterfaceType == 0}">	
								    		 <p class="spare"><b>${hos.allnum}</b>号源(测试中)</p>
									    </c:if>
									    <c:if test="${not empty hos.stophosname}">	
									   <p class="spare"><b>系统升级中</b></p>
									    </c:if>
									<p class="small opacity">${hos.address}</p>
									<div class="show opacity">
									    <c:if test="${ empty hos.stophosname}">
										<span style="font-size:13px;">${hos.name}</span>
										</c:if>
										 <c:if test="${ not empty hos.stophosname}">
										<span style="font-size:13px;">${hos.stophosname}</span>
										</c:if>
										
									</div>
									</a>
								</li> 
						 
						 
							
								<%-- <li class="">
								<a href="${ctx}/hospital/${hos.hospitalId}.html?indexs=statiscs">	
									<p class="title">${hos.name }</p>
									<p class="spare">余<b>${hos.allnum}</b>号</p>
									<p class="small opacity">${hos.address}</p>
									<div class="show opacity">
										<span style="font-size:13px;">${hos.name }</span>
									</div>
									</a>
								</li>  --%>
							 </c:forEach>


						</ul>
					</div>
					<div class="page pgb">${page}</div>
				</div>
			

		</div>
<script>
 if( !('placeholder' in document.createElement('input')) ){  
   
    $('input[placeholder],textarea[placeholder]').each(function(){   
      var that = $(this),   
      text= that.attr('placeholder');   
      if(that.val()===""){   
        that.val(text).addClass('placeholder');   
      }   
      that.focus(function(){   
        if(that.val()===text){   
          that.val("").removeClass('placeholder');   
        }   
      })   
      .blur(function(){   
        if(that.val()===""){   
          that.val(text).addClass('placeholder');   
        }   
      })   
      .closest('form').submit(function(){   
        if(that.val() === text){   
          that.val('');   
        }   
      });   
    });   
  } 
</script>


<script type="text/javascript">

function page(n, s) {

	var citys="";
	var areas=""; 
	var hospitallevelids="";
	var deptementID="";

		if (n)
			$("#pageNo").val(n);
		if (s)
			$("#pageSize").val(s);
		
       $(".ares a").each(function(index, element) {
       if(!($(this).attr("class")=="opacity")){
			 areas = $(this).attr("id");
		}	
		  });
		 $(".chengshi a").each(function(index, element) {
							       if(!($(this).attr("class")=="opacity")){
										 citys = $(this).attr("id");
									}	
						    });	
						    
		 $(".depatment a").each(function(index, element) {
							       if(!($(this).attr("class")=="opacity")){
										 deptementID = $(this).attr("id");
									}	
						    });					    
						    
		$("#cityId").val(citys);
		$("#areaId").val(areas);
		
		$("#depId").val(deptementID);
		
		$("#searchForm").submit();
		
		
		return false;
}








	$(".StatBox").each(function(){ 
			var q1 = $(this).find("a").outerHeight(true)
			var q2 = $(this).outerHeight(true)
			if(q2>q1){ 
					var that=$(this)
					$(this).height(q1)
					$(this).parent().append("<a href='' class='StatBoxClose  ' ><em class='opacity'></em></a>")
					$(this).parent().find(".StatBoxClose").click(function(){
							if($(this).hasClass("on")){
									$(this).removeClass("on")
									that.height(q1)
							}else{
									$(this).addClass("on")
									that.height(that.find(".Boxbg").height())
							}	
					})
			}
		

	})
	
	
	
	
	
	
	

	$(".StatBox em").click(function(){ 
	var citys="";
	var types="";
	var levels="";
	var areas="";
	var deptementID="";
	
	        $(this).removeClass("on");
			$(this).parent().removeClass("on");
			event.stopPropagation();
	
			 $(".chengshi a").each(function(index, element) {
						if(!($(this).attr("class")=="opacity")){
							 citys += $(this).attr("id");
						}		       
			    });
			    
			
		/* 	$(this).removeClass("on");
			$(this).parent().removeClass("on");
			event.stopPropagation(); */
			
			    
			    
			    
			     $(".ares a").each(function(index, element) {
				       if(!($(this).attr("class")=="opacity")){
							 areas += $(this).attr("id");
						}	
			    });
			    
			       $(".depatment a").each(function(index, element) {
				       if(($(this).attr("class")=="opacity on")){
				       /* 	alert($(this).attr("id")); */
							 deptementID = $(this).attr("id")+"";
						}	
			    });
			    
			    
			    		
			 	    $("#cityId").val(citys);
			    	$("#areaId").val(areas);
	            	$("#depId").val(deptementID);
			    	
				    $("#searchForm").submit();		
			    
			 	/*     $("#cityId").val(citys);
			    	$("#areaId").val(areas);
			    	$("#pageNo").val(1);
			    	if($(this).parent().parent().attr("class") == "chengshi"){
						$("#cityId").val(0);
				}
				$("#searchForm").submit();	 */		
	})	
	$(".StatBox a").click(function(){
	$("#pageNo").val(1);
		var citys="";
	var types="";
	var levels="";
	var areas=""; 
	var deptementID="";	
						
						if($(this).parent().attr("class") == "chengshi"){
								 $(".chengshi a").each(function(index, element) {
								     $(this).removeClass("on");
									$(this).find("em").removeClass("on");
							    });
								citys=$(this).attr("id");
						
						}else{
										
							 $(".chengshi a").each(function(index, element) {
							       if(!($(this).attr("class")=="opacity")){
										 citys = $(this).attr("id");
									}	
						    });
						
						
						}
							
					if($(this).parent().attr("class") == "ares"){
								 $(".ares a").each(function(index, element) {
								     $(this).removeClass("on");
									$(this).find("em").removeClass("on");
							    });
								areas=$(this).attr("id");
						
						}else{
										
							 $(".ares a").each(function(index, element) {
							       if(!($(this).attr("class")=="opacity")){
										 areas = $(this).attr("id");
									}	
						    });
						
						}
						
						
					  if($(this).parent().attr("class") == "depatment"){
								 $(".depatment a").each(function(index, element) {
								     $(this).removeClass("on");
									$(this).find("em").removeClass("on");
							});
								deptementID=$(this).attr("id");
						
						}else{
										
							 $(".depatment a").each(function(index, element) {
							
							       if(!($(this).attr("class")=="opacity")){
										 deptementID = $(this).attr("id");
									}	
						    });
						
						
						}
						
						
						
						
						
						
						 $(this).addClass("on");
							var that=$(this)
							setTimeout(function(){ 
								that.find("em").addClass("on")
						},300)
						
					
						
			    
			    	/* $("#cityId").val(citys);
			    	$("#areaId").val(areas); */
			    	$("#cityId").val(citys);
			    	$("#areaId").val(areas);
	            	$("#depId").val(deptementID);
			    	
					/* $("#pageNo").val(1); */	
			 	$("#searchForm").submit();
			
	})
	$('.StatisticsText li').hover(function(){ 
			$(this).addClass("on")
	},function(){ 
			$(this).removeClass("on")

	})
	$('.StatisticsText li p.small').hover(function(){ 
			$(this).addClass("on")
	},function(){ 
			$(this).removeClass("on")

	})
	
</script>



			
<!-- <script type="text/javascript">

function page(n, s) {

			var citys="";
	var areas=""; 

		if (n)
			$("#pageNo").val(n);
		if (s)
			$("#pageSize").val(s);
		
 $(".ares a").each(function(index, element) {
       if(!($(this).attr("class")=="opacity")){
			 areas = $(this).attr("id");
		}	
						    });
		 $(".chengshi a").each(function(index, element) {
							       if(!($(this).attr("class")=="opacity")){
										 citys = $(this).attr("id");
									}	
						    });	
		$("#cityId").val(citys);
			    	$("#areaId").val(areas);
		$("#searchForm").submit();
		
		
		return false;
}
	$(".StatBox").each(function(){ 
			var q1 = $(this).find("a").outerHeight(true)
			var q2 = $(this).outerHeight(true)
			if(q2>q1){ 
					var that=$(this)
					$(this).height(q1)
					$(this).parent().append("<a href='' class='StatBoxClose  ' ><em class='opacity'></em></a>")
					$(this).parent().find(".StatBoxClose").click(function(){
							if($(this).hasClass("on")){
									$(this).removeClass("on")
									that.height(q1)
							}else{
									$(this).addClass("on")
									that.height(that.find(".Boxbg").height())
							}	
					})
			}
		

	})
	

	$(".StatBox em").click(function(){ 
				
	var citys="";
	var types="";
	var levels="";
	var areas="";
	
			 $(".chengshi a").each(function(index, element) {
						if(!($(this).attr("class")=="opacity")){
							 citys += $(this).attr("id");
						}		       
			    });
			    
			
			$(this).removeClass("on");
			$(this).parent().removeClass("on");
			event.stopPropagation();
			
			    
			    
			    
			     $(".ares a").each(function(index, element) {
				       if(!($(this).attr("class")=="opacity")){
							 areas += $(this).attr("id");
						}	
			    });
			 	    $("#cityId").val(citys);
			    	$("#areaId").val(areas);
			    	$("#pageNo").val(1);
			    	if($(this).parent().parent().attr("class") == "chengshi"){
						$("#cityId").val(0);
				}
				$("#searchForm").submit();			
	})	
	$(".StatBox a").click(function(){
	
		var citys="";
	var types="";
	var levels="";
	var areas=""; 
						
						if($(this).parent().attr("class") == "chengshi"){
								 $(".chengshi a").each(function(index, element) {
								     $(this).removeClass("on");
									$(this).find("em").removeClass("on");
							    });
								citys=$(this).attr("id");
						
						}else{
										
							 $(".chengshi a").each(function(index, element) {
							       if(!($(this).attr("class")=="opacity")){
										 citys = $(this).attr("id");
									}	
						    });
						
						
						}
							
					if($(this).parent().attr("class") == "ares"){
								 $(".ares a").each(function(index, element) {
								     $(this).removeClass("on");
									$(this).find("em").removeClass("on");
							    });
								areas=$(this).attr("id");
						
						}else{
										
							 $(".ares a").each(function(index, element) {
							       if(!($(this).attr("class")=="opacity")){
										 areas = $(this).attr("id");
									}	
						    });
						
						}
						
						 $(this).addClass("on");
							var that=$(this)
							setTimeout(function(){ 
								that.find("em").addClass("on")
						},300)
						
					
						
			    
			    	$("#cityId").val(citys);
			    	$("#areaId").val(areas);
					$("#pageNo").val(1);	
			 	$("#searchForm").submit();
			
	})
	$('.StatisticsText li').hover(function(){ 
			$(this).addClass("on")
	},function(){ 
			$(this).removeClass("on")

	})
	$('.StatisticsText li p.small').hover(function(){ 
			$(this).addClass("on")
	},function(){ 
			$(this).removeClass("on")

	})
	
</script>
 -->



</body>
</html>
