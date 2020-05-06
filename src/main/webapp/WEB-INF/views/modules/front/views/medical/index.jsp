<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/front/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<meta name="decorator" content="frontdefault"/>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title></title>
	<meta name="keywords" content="" />
	<meta name="description" content="" />
	<script type="text/javascript" src="${ctxStaticFront}/js/jquery.cascadingdropdown.js"></script>
</head>
<body>
	<style type="text/css">
        	.cascading-dropdown-loading {
        		cursor: wait;
        		background: url('${ctxStaticFront}/images/ajax-loader.gif') 85% center no-repeat transparent;
        	}
mico {
    padding: 0px 6px;
    height: 17px;
    float: left;
    display: block;
    background: #FE824C none repeat scroll 0% 0%;
    text-align: center;
    border-radius: 6px;
    margin-left: 5px;
    font-size: 10px;
    line-height: 16px;
    color: #FFF;
    font-weight: normal;
    behavior: url(../static/front/js/PIE.htc);
}
* {
    padding: 0px;
    margin: 0px;
    list-style-type: none;
    text-decoration: none;
    font-family: "5FAE8F6F96C59ED1","Microsoft Yahei";
}
.lefsta{
 position: relative;
  left: -6px;
  top: 8px;

}


        </style>
		<div id="content" > 
	     	
					<div class="newsnav"> 
								<div class="center">
										<a href="${ctx}/">首页    >  </a> <a href="${ctx}/medical/medicalinfo">查找医院</a>
								</div>
								

						</div>
					
					
					
							<div class="block_name mt"> 
								
								<span class="">SELECT HOSPITAL</span>
								<p class="">查找医院</p>
								<div class="brd"></div>
							</div>

							<div class="bar">
								<ul>
										<li><a href="${ctx}/medical/queryHospitalMap" class="opacity">地图筛选</a></li>
										<li><a href="#selecthosptail" class="opacity on">条件筛选</a></li>
										

							
								</ul>
							</div>
			      		<form action="${ctx}/medical/queryHospital" >
							<div class="shm">
								
											<div class="secbg sle">
												<div class="center"> 
													<ul >
															<li><p>区域</p>
										 <select id="cityId" name="cityId" class="step1" onchange="changeLac(this.value)">
														 <c:if test="${empty cityId or cityId == 0}">
												        	<option value="0" selected="selected">---所有---</option>
												         </c:if>
												<c:forEach var="cityitem" items="${citys}">
														 <c:if test="${cityitem.cityid == cityId}"> 
															<option value="${cityitem.cityid}">
																	${cityitem.city}			
															</option>
														</c:if>	
														
												</c:forEach>
													<c:if test="${!empty cityId && cityId != '0'}">
																<option value="0">---所有---</option>
															</c:if>
													<c:forEach var="cityitem" items="${citys}">
															 <c:if test="${cityitem.cityid != cityId}"> 
															<option value="${cityitem.cityid}">
																	${cityitem.city}			
															</option>
															</c:if>
																	
												</c:forEach>
													
												
											</select>	
											
											</li>
											
											
										<li><p>级别</p>
										<select id="levelId" name="levelId" class="step2" onchange="changeLac(this.value)">
												
												 <c:if test="${empty levelId or levelId == 0}">
												        	<option value="0" selected="selected">---所有---</option>
												         </c:if>
											<c:forEach var="map" items="${level }">
														 <c:if test="${map.id == levelId}"> 
															<option value="${map.id}">
																	${map.hospitalLevelName}			
															</option>
														</c:if>	
												</c:forEach>
											<c:if test="${!empty levelId && levelId != '0'}">
														<option value="0">---所有---</option>
													</c:if>	
										<c:forEach var="map" items="${level }">
										 <c:if test="${map.id != levelId}"> 
															<option value="${map.id}">
																	${map.hospitalLevelName}			
															</option>
															</c:if>
										</c:forEach>	
										</select>			
															</li>
															
														
													<li><p>类别</p>
													<select  id="departmentId" name="departmentId" class="step3" onchange="changeLac(this.value)">
													 <c:if test="${empty departmentId or departmentId eq '0'}">
												        	<option value="0" selected="selected">---所有---</option>
												         </c:if>
												<c:forEach var="types" items="${type }">
														 <c:if test="${types.id eq departmentId}"> 
															<option value="${types.id}">
																	${types.hospitalTypeName}			
															</option>
														</c:if>	
															
												</c:forEach>
												<c:if test="${!empty departmentId && departmentId != '0'}">
															<option value="0">---所有---</option>
														</c:if>
													<c:forEach var="types" items="${type }">
													 <c:if test="${types.id != departmentId}"> 
															<option value="${types.id}">
																	${types.hospitalTypeName}			
															</option>
														</c:if>	
												</c:forEach>
													
													</select>
													
													
														</li>
															
													<li><p>医院</p>
														<select id="step4" name="hospId" >
															
													 <c:if test="${empty hospId or hospId == 0}">
												        	<option value="0" selected="selected">---所有---</option>
												         </c:if>
												<c:forEach var="ho" items="${hospitas }">
												
													<c:if test="${not empty hospId }">
														 <c:if test="${ho.hospitalId == hospId}"> 
															<option value="${ho.hospitalId}">
																	${ho.name}			
															</option>
													
													 </c:if>
													</c:if>
												</c:forEach>
													<c:if test="${!empty hospId && hospId != '0'}">
																<option value="0">---所有---</option>
														 </c:if>
													<c:forEach var="ho" items="${hospitas }">
														<c:if test="${not empty hospId }">
															 <c:if test="${ho.hospitalId != hospId}"> 
																<option value="${ho.hospitalId}">
																		${ho.name}			
																</option>
														 </c:if>
														</c:if>
												</c:forEach>
															
														</select>	
														
														</li>		
															
															<li style="margin-right:0;"><input type="text"  name="hosNmae"  value="${hosNmae}" placeholder="医院名"><input type="submit" value="搜索"></li>
													</ul>
												
												

												</div>
											</div>

							</div>
							
							</form>
							<div class="yiy">
									<div class="center">
										<ul> 
										
											<c:forEach var="hosts" items="${page.list }">
												<li>
													<a href="${ctx}/hospital/${hosts.hospitalId}.html">
														<div class="l">
														 <c:if test="${empty hosts.hospitallogurl}">
															<img  height="70" width="70" src="${ctxStaticFront}/images/logo_keshi.png">
															</c:if>
														 <c:if test="${not empty hosts.hospitallogurl}">
															<img  height="70" width="70" src="${hosts.hospitallogurl}">
													    	</c:if>
															
														</div>
														<div class="r">
																<p>
																<b>${hosts.name }</b>
																</br>
														<div class="lefsta">		
																<c:if test="${hosts.hasRegConfirm == '1'}">
																	<mico >
																</c:if>
																<c:if test="${hosts.hasRegConfirm != '1'}">
																	<mico class="off" >
																</c:if>
																挂号
																</mico>
																
																
																<c:if test="${hosts.isinterrogation == '1'}">
																	<mico>
																</c:if>
																<c:if test="${hosts.isinterrogation != '1'}">
																	<mico class="off" >
																</c:if>
																远程
																</mico>
																
																
																
															<c:if test="${hosts.waitstat =='1'}">
															<mico >
																</c:if>
																<c:if test="${hosts.waitstat !=1}">
																	<mico class="off" >
																</c:if>
																
																排队</mico>
																<c:if test="${hosts.reportstat ==1}">
																	<mico>
																</c:if>
																<c:if test="${hosts.reportstat !=1}">
																	<mico class="off">
																</c:if>
																报告</mico> 
																<c:if test="${hosts.payonlinestat ==1}">
																	<mico >
																</c:if>
																<c:if test="${hosts.payonlinestat !=1}">
																	<mico class="off">
																</c:if>
																门诊</mico> 
																<c:if test="${hosts.payonlinestat ==1}">
																	<mico >
																</c:if>
																<c:if test="${hosts.payonlinestat !=1}">
																	<mico class="off" >
																</c:if>
																缴费</mico> 
															</div>	 
															</p>
															</br>
															<span>
															<c:set var="hosdesc" value="${fns:abbr(hospital.brief,100)}"/> ${hosdesc}
															</span>
														</div>
													</a>
												</li>
												</c:forEach>

										</ul>
										

									</div>



							</div>

	<div class="page pgb">${page}</div>

					</div>	




		</div>
		<form id="searchForm" action="${ctx}/medical/queryHospital" name="searchForm" class="form-inline">
        			<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
					<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
					<input  name="cityId" type="hidden" value="${cityId}"/>
					<input name="levelId" type="hidden" value="${levelId}"/>
					<input name="departmentId" type="hidden" value="${departmentId}"/>
					<input name="hosNmae" type="hidden" value="${hosNmae}"/>
					<input name="hospId" type="hidden" value="${hospId}"/>
					
					
		 		</form>
		
		
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
        url : '${ctx}/medical/hospitalbycityAndlevels',  
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
		if (n)
			$("#pageNo").val(n);
		if (s)
			$("#pageSize").val(s);
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


		
</body>
</html>
