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

<body>
<style>

.i5.sel5 .State a {
    margin-top: 10px;
}
.State a.off {
    background-color: #999;
}
.State a {
    line-height: 16px;
    font-size: 10px;
    color: #FFF;
    display: inline-block;
    padding: 0px 7px;
    height: 20px;
    background-color: #FE824C;
    text-align: center;
    float: left;
    background-position: center center;
    background-repeat: no-repeat;
    margin-right: 5px;
    border-radius: 8px;
    margin-top: 23px;
    behavior: url(./static/front/js/PIE.htc);
}
.StatBox {
    float: left;
    overflow: hidden;
    width: 932px;
    height: 67px;
}
.StatBox{
    z-index:9999;
}
.opacity  on {
    background: #FFF none repeat scroll 0% 0%;
    color: #404D5E;
    border-radius: 6px;
    padding: 2px 8px 2px 5px;
     z-index:5555;
}
.StatBoxClose {
    float: right;
    color: #red;
    display: block;
    margin-right: 20px;
}

.i5.sel5 .fonts {
    width: 240px;
}
</style>

		<div id="content">
		<div class="slct">
							<div class="block_name mt"> 
							<span class="">NETWORK MEDICAL</span>
							<p class="">网络医疗</p>
							<div class="brd"></div>
							</div>
							<img src="${ctxStaticFront}/images/liucheng.png">
		 </div>
		<div class="shm shmm">
		<form action="${ctx}/medical/remote"  id="subs" method="get">
			<div class="secbg sle">
				<div class="center">
				
						<div class="shm">
							<div class="secbg sle">
								<div class="center">
									<ul>
										<li><p>区域</p> <select id="cityId" name="cityId"
											class="step1" onchange="changeLac(this.value)"  style="" >
												<c:if test="${empty cityId or cityId == '0'}">
													<option value="0" selected="selected"  >---所有---</option>
												</c:if>
												
													<c:forEach var="cityitem" items="${citys }">
															<c:if test="${cityitem.cityid == cityId}">
																<option value="${cityitem.cityid}">${cityitem.city}</option>
															</c:if>
												</c:forEach>
												<c:forEach var="cityitems" items="${citys}">
															<c:if test="${cityitems.cityid != cityId}">
																<option value="${cityitems.cityid}">${cityitems.city}</option>
															</c:if>
												</c:forEach>
											<%-- 	
												<c:if test="${!empty cityId}">
													<option value="0" >---所有---</option>
												</c:if> --%>
										</select></li>
										<li><p>级别</p> <select id="levelId" name="levelId"
											class="step2" onchange="changeLac(this.value)">

												<c:if test="${empty levelId or levelId == '0'}">
													<option value="0" selected="selected">---所有---</option>
												</c:if>
												
												
												
												<c:forEach var="map" items="${level }">
															<c:if test="${map.id == levelId}">
																<option value="${map.id}">${map.hospitalLevelName}</option>
															</c:if>
												</c:forEach>
												
												<c:forEach var="maps" items="${level }">
															<c:if test="${maps.id != levelId}">
																<option value="${maps.id}">${maps.hospitalLevelName}</option>
																</c:if>
												</c:forEach>
											<%-- 	<c:if test="${levelId !='0'}">
															<option value="0">--所有--</option>
												</c:if> --%>
												
												
												
												
										</select></li>
										<li><p>类别</p> <select id="departmentId"
											name="departmentId" class="step3"
											onchange="changeLac(this.value)">
												<c:if test="${empty departmentId or departmentId eq '0'}">
													<option value="0" selected="selected">---所有---</option>
												</c:if>
												<c:forEach var="types" items="${type }">
															<c:if test="${types.id eq departmentId}">
																<option value="${types.id}">${types.hospitalTypeName}</option>
															</c:if>
												</c:forEach>
												
												<c:forEach var="typess" items="${type }">
													<c:if test="${typess.id != departmentId}">
																<option value="${typess.id}">${typess.hospitalTypeName}</option>
															</c:if>
												</c:forEach>
											<%-- 	<c:if test="${departmentId !='0'}">
															<option value="0">--所有--</option>
												</c:if> --%>
															
															
															
															
										</select></li>


	
										<li><p>医院</p> <select id="step4" name="hospId">
													
												<c:if test="${empty hospId or hospId == 0}">
													<option value="0" selected="selected">---所有---</option>
												</c:if>
												<c:forEach var="ho" items="${hospitas }">
													<c:if test="${not empty hospId }">
															<c:if test="${ho.hospitalId == hospId}">
																<option value="${ho.hospitalId}">${ho.name}</option>
															</c:if>
													</c:if>
												</c:forEach>
												<c:forEach var="hos" items="${hospitas }">
												<c:if test="${hos.hospitalId != hospId}">
																<option value="${hos.hospitalId}">${hos.name}</option>
																</c:if>
												</c:forEach>
											<%-- 	<c:if test="${hospId !='0'}">
															<option value="0">--所有--</option>
												</c:if> --%>
										</select></li>

										<li style="margin-right:0;"><input type="text"
											name="doctorNmae" value="${doctorNmae}" placeholder="医生姓名"><input type="submit" value="搜索">
										</li>
										</br></br>
										<li>
								<div class="Commune" sytle="margin-bottom: 50px;position:relative;">
								<div style="width: 58px;height: 35px;line-height: 35px;color: #404D5E; position:relative;top:29px;left:10px;z-index:5555;font-size:17px;">病   种：</div>
								<div class="StatBox opacity">
									<div class="Boxbg" style="position:relative;left:70px;top:0px; z-index:9999;font-size:15px;">
										<c:forEach items="${dis}" var="d"></c:forEach>
											
													
													<c:if test="${diseases == '0'}">
														<a  id="0"  class="opacity on" ><div style="color: #8B6914;letter-spacing:3px;">全  部</div></a>
													</c:if>
													<c:if test="${diseases != '0'}">
																<a  id="0"  class="opacity" ><div style="color: #8B6914;letter-spacing:3px;">全  部</div></a>
													</c:if>
													
													<c:forEach items="${dis}" var="d">
														<c:if test="${d.diseaseId == diseases}">
																<a class="opacity on" id="${d.diseaseId}"><div style="color: #8B6914;letter-spacing:3px;">${d.name}</div></a>
														</c:if>
													</c:forEach>
													
													<c:forEach items="${dis}" var="d">
														<c:if test="${d.diseaseId != diseases}">
																<a class="opacity" id="${d.diseaseId}"><div style="color: #8B6914;letter-spacing:3px;">${d.name}</div></a>
														</c:if>
													</c:forEach>
										
									</div>
								</div>
							
						</div>
										
										</li>
									</ul>


								</div>
								
			
							</div>

						</div>
				</div>
			</div>
				<input type="hidden" name="diseasesNames" id="ddiseasesst" value="${diseases}"/>
			
	</form>
		</div>
		<div class="i5 sel5">
						<div class="center">
							<ul>
							     
					             <c:forEach items="${page.list}" var="blockDoctor">
										<li class="">
										
										  <c:set var="url" value="${blockDoctor.photourl}" />  
										
											<div class="userpic animate-element scale" style="background:url(${fnf:imageScaleUrl(url,'180','180','doctorpc')}) center no-repeat"> 
											<a href="${ctx}/doctor/${blockDoctor.doctorId}.html">
												<p class="opacity"><span>
													${blockDoctor.specialty}
												</span></p></a>
											</div>
                                            
											<div  align="center" class="fonts animate-element bottom_to_top" >
												<p class="p1">${blockDoctor.name} <span>${blockDoctor.jobsString} </span></p>
												<p class="p2"><span style="font-size:9px;">${blockDoctor.getDepartment().getHospital().getName()}</span></p>
												<div class="State">
										         <c:if test="${blockDoctor.isReg=='1'}">
										          <a  style="background-image:url()">挂号</a>
										         </c:if>
										    
										        <c:if test="${blockDoctor.isReg !='1'}">
										          <a  style="background-image:url()" class="off">挂号</a>
										       </c:if>
										    
										       <c:if test="${blockDoctor.chartartconsult=='1'}">
											     <a style="background-image:url()">图文</a>
											   </c:if>
										       <c:if test="${blockDoctor.chartartconsult !='1'}">
											    <a class="off" style="background-image:url()">图文</a>
											   </c:if>
											
											   <c:if test="${blockDoctor.telconsult=='1'}">
											   <a style="background-image:url()">电话</a>
											   </c:if>
											   <c:if test="${blockDoctor.telconsult !='1'}">
											    <a class="off" style="background-image:url()">电话</a>
											   </c:if>
											
									           <c:if test="${blockDoctor.videoconsult=='1'}">
										    	<a style="background-image:url()">视频</a>
											  </c:if>
											  <c:if test="${blockDoctor.videoconsult !='1'}">
											    <a class="off" style="background-image:url()">视频</a>
											  </c:if>
											
											<%--   <c:if test="${blockDoctor.freeconsult=='1'}">
											   <a  style="background-image:url()">咨询</a>
											 </c:if>
											  <c:if test="${blockDoctor.freeconsult !='1'}">
											  <a class="off" style="background-image:url()">咨询</a>
											 </c:if> --%>
											 
							 	
												<c:if test="${blockDoctor.isonline ==1}">
													 <a  style="background-image:url()">在线</a>
												</c:if>
												<c:if test="${blockDoctor.isonline !=1}">
													<a class="off" style="background-image:url()">在线</a>
												</c:if>
											 

										</div>
									</div>
										</li>
								</c:forEach>
								</ul>
						</div>

	
					</div>
					<form id="searchForm" action="${ctx}/medical/remote" name="searchForm" class="form-inline">
					<input type="hidden" name="diseasesNames"  id="diseasesNum" value="${disease}"/>
        			<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
					<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
					<input  name="cityId" type="hidden" value="${cityId}"/>
					<input name="levelId" type="hidden" value="${levelId}"/>
					<input name="departmentId" type="hidden" value="${departmentId}"/>
					<input name="doctorNmae" type="hidden" value="${doctorNmae}"/>
					<input name="hospId" type="hidden" value="${hospId}"/>
					
					
		 		</form>
					
				<div class="page pgb">${page}</div>
		</div>
		
<script type="text/javascript">




	
	if($("#step4 option").size() < 2){
		$('#step4').attr("disabled","desabled");
	}
  function changeLac(v) {  
    jQuery('#step4').html(""); //把ci内容设为空  
    var ciValue = jQuery('#step4');  
    ciValue.append('<option value="0">---请选择---</option>');  
   	   $("#step4").css({"background":"#fff url(${ctxStaticFront}/images/selectLoad.gif) no-repeat 84% 50%"});    
    //异步请求查询ci列表的方法并返回json数组  
    jQuery.ajax({  
        url : '${ctx}/medical/webhospital',  
        type : 'post',  
        data : { cityId : $("#cityId").val(),levelId: $("#levelId").val(),departmentId: $("#departmentId").val() },  
        dataType : 'json',  
        success : function (opts) {
        
            if (opts && opts.length > 0) {  
                    var html = [];  
                    for (var i = 0; i < opts.length; i++) {  
                        html.push('<option value="'+opts[i].hospitalId+'">'+opts[i].name+'</option>');  
                    }
                    html.push('<option value="0">---所有---</option>');    
                    ciValue.append(html.join(''));  
                    $("#step4").removeAttr("disabled");  
                    $("#step4").css({"background":"#fff"});  
                }else{
                	  $("#step4").css({"background":"#D6D6D6"});  
                	  $('#step4').attr("disabled","desabled");
                }  
            }  
        });  

}  


function page(n, s) {
var diseaseName="";
		if (n)
			$("#pageNo").val(n);
		if (s)
			$("#pageSize").val(s);
			
			 $(".Boxbg a").each(function(index, element) {
       if(($(this).attr("class")=="opacity on")){
				 diseaseName = $(this).attr("id");
			}	
    });	
			    	
    	$("#diseasesNum").val(diseaseName);
		$("#searchForm").submit();
		return false;
}


/**
$('#ghselect').cascadingDropdown({
    selectBoxes: [
        {
            selector: '.step1'
        },
        {
            selector: '.step2'
        },
        {
      	    selector: '.step3',
        },
        {
            selector: '.step4',
            requires: ['.step1','.step2'],
            requireAll: true,
            source: function(request, response) {
                if(request.levelId=="0" || request.cityId=="0" || request.departmentId=="0"){
                	response();
                }else{
                	$.getJSON('${ctx}/medical/hospitalbycityAndlevel', request, function(data) {
	                    response($.map(data, function(item, index) {
	                        return {
	                            label: item.name,
	                            value: item.hospitalId,
	                            //selected: index == 0 // set to true to mark it as the selected item
	                        };
	                    }));
                	});	
                }
                
            }
        },
        {
            selector: '.step5',
            requires: ['.step10'],
            source: function(request, response) {
                if(request.hospId=="0"){
                	response();
                }else{
                	$.getJSON('${ctx}/medical/hospitalBydepartment', request, function(data) {
	                    response($.map(data, function(item, index) {
	                        return {
	                            label: item.name,
	                            value: item.departmentId,
	                            //selected: index == 0 // set to true to mark it as the selected item
	                        };
	                    }));
                	});	
                }
                
            }
        }
    ],
    onChange: function(event, value, requiredValues, requirementsMet){
    	
        // do stuff
        // dropdownData is an object with values from all the dropdowns in this group
    },
    onReady: function(event, dropdownData) {
    	//alert("onReady");
        // do stuff
    }
});
**/

 $("#gh_submit").click(function(){  
 	  var doctorId = $("#doctorId").val();
 	  if(doctorId=="0"){
 	  	alert("您还未选择医生，请选择医生！");
 	  }
 	  else{
 	  	window.location.href="${ctx}/doctor/"+doctorId+".html"; 
 	  }
 	  
 });


$(".menav li").each(function(a){ 
		var me = $(".menav li:eq("+a+")"),i=a+1;
		me.find("img").attr("src","${ctxStaticFront}/images/me_"+i+".png")
		me.hover(function(){ 
			me.find("img").attr("src","${ctxStaticFront}/images/me_"+i+"h.png")
		},function(){ 
			me.find("img").attr("src","${ctxStaticFront}/images/me_"+i+".png")

		})
})


 $(".StatBox").each(function(){ 
			var q1 = $(this).find("a").outerHeight(true)
			var q2 = $(this).outerHeight(true)
			if(q2>q1){ 
					var that=$(this)
					$(this).height(q1)
					$(this).parent().append("<a href=''  class='StatBoxClose  ' ><em class='opacity'></em></a>")
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
	$(".Boxbg em").click(function(){ 
	var diseaseName="";
		
			$(this).removeClass("on");
			$(this).parent().removeClass("on");
			event.stopPropagation();
			    		$("#diseasesNum").val(0);
				$("#searchForm").submit();			
	})	
	$(".Boxbg a").click(function(){
		var diseaseName="";
				 $(".Boxbg a").each(function(index, element) {
								     $(this).removeClass("on");
									$(this).find("em").removeClass("on");
							    });
				 $(this).addClass("on");
					var that=$(this)
					setTimeout(function(){ 
						that.find("em").addClass("on")
				},300)
				
					 $(".Boxbg a").each(function(index, element) {
				       if(($(this).attr("class")=="opacity on")){
							 diseaseName = $(this).attr("id");
						}	
			    });	
			    $("#ddiseasesst").val(diseaseName);
		    	$("#diseasesNum").val(diseaseName);
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
<script>
 /* 调试placeholder属性兼容性 */
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
<!-- <script type="text/javascript">

function page(n, s) {
		if (n)
			$("#pageNo").val(n);
		if (s)
			$("#pageSize").val(s);
		$("#searchForm").submit();
		return false;
}

</script>
 -->
</body>
</html>
