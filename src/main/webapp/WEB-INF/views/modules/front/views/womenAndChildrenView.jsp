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
		<!-- 	<div class="block_name mtt suc"> 
							
							<span class=""> Maternal and child zone</span>
							<p class="">妇幼专区</p>
							<div class="brd"></div>
				</div> -->
				<div class="newsnav"> 
								<div class="center">
										<a href="${ctx}/">首页   ></a><a href="${ctx}/womenandchildreninfo">妇幼专区  </a>

								</div>
								


						</div> 
				<div class="block_name bg "> 
							
							<span class=""> MATERNAL AND CHILD</span>
							<p class="">妇幼专区</p>
							<div class="brd"></div>
				</div>
				
				
				
				
				<div class="Statistics">
					<div class="center">
						<div class="Province">
						 <form action="${ctx}/womenandchildreninfo" method="pos" id="searchForm">
				          	<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
							 <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
							<input type="hidden" name="cityId" value="" id="cityId"/>
							<input type="hidden" name="areaId" value="" id="areaId"/>
							<input type="hidden" name="hospitallevelid" value="" id="hospitallevelid"/>
							<input type="hidden" name="deptementkey" value="" id="deptementkey"/>
					     
							<p><em></em>四川省</p>	
							<span>找到<b>${page.count}</b>家医院</span>
							  <div class="StatisticsSearch">
								<input type="text"  name="search" value="${searchKey}" placeholder="输入医院名搜索">
								<input type="submit" value="">
							 </div>
							 </form>
					     </div>
						
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
							<p>医院等级：</p>
							<div class="StatBox opacity">
								<div class="Boxbg">
								    <div class="hosptlevel">
								        <c:if test="${hospitalLevelId == '0'}">
										    <a id="0" class="opacity on">全部<em class="opacity on" ></em></a>
										</c:if>
										<c:if test="${hospitalLevelId != '0'}">
										     <a id="0" class="opacity">全部<em class="opacity" ></em></a>
										</c:if>
								    	<c:forEach items="${level}" var="levelmap">
											<c:if test="${levelmap.id == hospitalLevelId}">
												<a class="opacity on" id="${levelmap.id}">${levelmap.hospitalLevelName}<em class="opacity on"></em></a>
											</c:if>
											<c:if test="${levelmap.id != hospitalLevelId}">
												<a class="opacity" id="${levelmap.id}">${levelmap.hospitalLevelName}<em class="opacity"></em></a>
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
								         <c:if test="${deptementKey == '0'}">
										    <a id="0" class="opacity on">全部<em class="opacity on" ></em></a>
										</c:if>
										<c:if test="${deptementKey != '0'}">
										     <a id="0" class="opacity ">全部<em class="opacity " ></em></a>
										</c:if>
										   <a style="color:#8B6914;" class="opacity ${deptementKey=='儿科'?'on':''}" id="儿科">儿科<em class="opacity ${deptementKey=='儿科'?'on':''}"></em></a>
										   <a style="color:#8B6914;" class="opacity ${deptementKey == '妇科'?'on':'' }" id="妇科">妇科<em class="opacity ${deptementKey == '妇科'?'on':'' }"></em></a>
										   <a style="color:#8B6914;" class="opacity ${deptementKey == '产科'?'on':'' }" id="产科">产科<em class="opacity ${deptementKey == '产科'?'on':'' }"></em></a>
									
										</div>
								</div>
							</div>
							
						</div>	
							
					</div>


				</div>
				<div class="StatisticsText">
					<div class="center">
						<h1><p class="title">当前地区共<b>${page.count}</b>家医院,共余<b>
							<c:choose>
								<c:when test="${counts == null || counts == '' }">0</c:when>
								<c:otherwise>${counts }</c:otherwise>
							</c:choose>
						</b>号源,总共 <b>${allbedcounts}</b>床位,剩余<b>${bedcounts}</b>床位</p> <p class="right"><!-- <a href="" class="on">列表</a> --><!-- <a href="">图表</a> --></p></h1>
						<ul id="warp">
						 <c:forEach items="${page.list}" var="hos">
							
								<li class="">
								<a href="${ctx}/hospital/${hos.hospitalId}.html?indexs=women&depId=${depname}">
								    <c:if test="${not empty hos.stophosname}">
								    <p class="title">${hos.stophosname}</p>
								    </c:if>	
								     <c:if test="${ empty hos.stophosname}">
									<p class="title">${hos.name}</p>
									 </c:if>
									    <c:if test="${ empty hos.stophosname}">	
									  <p class="spare"><span style="position:relative;top:-15px;font-size:14px;">余<b>${hos.allnum}</b>号源<c:if test="${hos.hisInterfaceType==0}">(测试号源)</c:if></p></span>
									     <p class="spare"><span style="position:relative;top:-12px;font-size:15px;">共<b>${hos.totalbeds}</b>床位,余<b>${hos.leavebeds}</b>床位</p></span> 
									  <%--     <p class="spare">余<b>${hos.allnum}</b>号源</p> --%>
									    </c:if>
									    <c:if test="${ not empty hos.stophosname}">	
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
	var deptementkeys="";

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
		 $(".hosptlevel a").each(function(index, element) {
							       if(!($(this).attr("class")=="opacity")){
										 hospitallevelids = $(this).attr("id");
									}	
						    });	
						    
		 $(".depatment a").each(function(index, element) {
							       if(!($(this).attr("class")=="opacity ")){
							       	
										 deptementkeys = $(this).attr("id");
									}	
						    });					    
						    
		$("#cityId").val(citys);
		$("#areaId").val(areas);
		
		$("#hospitallevelid").val(hospitallevelids);
		$("#deptementkey").val(deptementkeys);
		
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
	var hospitallevelids="";
	var deptementkeys="";
			
			$(this).removeClass("on");
			$(this).parent().removeClass("on");
			event.stopPropagation();
			
			 $(".chengshi a").each(function(index, element) {
						if(!($(this).attr("class")=="opacity")){
							 citys += $(this).attr("id")+"";
						}		       
			    });
			    
			    
			     $(".ares a").each(function(index, element) {
				       if(!($(this).attr("class")=="opacity")){
							 areas += $(this).attr("id")+"";
						}	
			    });
			    
			       $(".hosptlevel a").each(function(index, element) {
				       if(!($(this).attr("class")=="opacity")){
							 hospitallevelids += $(this).attr("id")+"";
						}	
			    });
			    
			    
			       $(".depatment a").each(function(index, element) {
				       if(($(this).attr("class")=="opacity on")){
				       /* 	alert($(this).attr("id")); */
							 deptementkeys = $(this).attr("id")+"";
						}	
			    });
			    		
			    		
			 	    $("#cityId").val(citys);
			    	$("#areaId").val(areas);
			    	$("#hospitallevelid").val(hospitallevelids);
	            	$("#deptementkey").val(deptementkeys);
			    	
			    	
				$("#searchForm").submit();			
	})
	
	
	
	
		
	$(".StatBox a").click(function(){
		var citys="";
	var types="";
	var levels="";
	var areas=""; 
	var hospitallevelids="";
	var deptementkeys="";					
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
						
						
						if($(this).parent().attr("class") == "hosptlevel"){
								 $(".hosptlevel a").each(function(index, element) {
								     $(this).removeClass("on");
									$(this).find("em").removeClass("on");
							    });
								hospitallevelids=$(this).attr("id");
						
						}else{
										
							 $(".hosptlevel a").each(function(index, element) {
							       if(!($(this).attr("class")=="opacity")){
										 hospitallevelids = $(this).attr("id");
									}	
						    });
						
						
						}	
						
						
							if($(this).parent().attr("class") == "depatment"){
								 $(".depatment a").each(function(index, element) {
								     $(this).removeClass("on");
									$(this).find("em").removeClass("on");
							    });
								deptementkeys=$(this).attr("id");
						
						}else{
										
							 $(".depatment a").each(function(index, element) {
							
							       if(!($(this).attr("class")=="opacity ")){
										 deptementkeys = $(this).attr("id");
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
	                $("#hospitallevelid").val(hospitallevelids);
	            	$("#deptementkey").val(deptementkeys);
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




</body>
</html>
