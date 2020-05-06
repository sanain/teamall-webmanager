<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/front/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<meta name="decorator" content="frontdefault"/>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>用户中心-我的门诊</title>
	<meta name="keywords" content="" />
	<meta name="description" content="" />
	<script type="text/javascript" src="${ctxStaticFront}/js/laydate/laydate.js"></script>
		<style type="text/css">
        	.cascading-dropdown-loading {
        		cursor: wait;
        		background: url('${ctxStaticFront}/images/ajax-loader.gif') 85% center no-repeat transparent;
        	}
        </style>
	<script type="text/javascript" src="${ctxStaticFront}/js/jquery.cascadingdropdown.js"></script>
</head>

<body>
<div id="content"> 
<div class="mefixd">
				<div class="menav">
					<div class="center">
						<ul>
								<li><a href="${ctx}/userinfo/baseinfo" ><img src=""><p>个人信息</p></a></li>
								<li><a href="${ctx}/userinfo/attentioninfo"><img src=""><p>我的关注</p></a></li>
								<li><a href="${ctx}/userinfo/userregisterinfo"><img src=""><p>我的预约</p></a></li>
								<li><a href="${ctx}/userinfo/userconsultinfo" ><img src=""><p>我的咨询</p></a></li>
								<li><a href="${ctx}/userinfo/reportinfo"><img src=""><p>我的报告</p></a></li>
								<li><a href="${ctx}/userinfo/useroutpatientinfo" class="on"><img src=""><p>我的门诊</p></a></li>
								<li><a href="${ctx}/userinfo/palyinfo" ><img src=""><p>我的缴费</p></a></li>
								<li><a href="${ctx}/userinfo/orderinfo"  ><img src=""><p>我的订单</p></a></li>
								<li><a href="${ctx}/userinfo/newscollectinfo"><img src=""><p>我的收藏</p></a></li>
								<!-- 	<li><a href=""><img src=""><p>健康记录评估</p></a></li> -->
								<li><a href="${ctx}/userinfo/healthFile""><img src=""><p>我的健康档案</p></a></li>
								<li><a href="${ctx}/xnh/init""><img src=""><p>新农合</p></a></li>
						</ul>
					</div>
				</div>
				</div>
				<div class="bar">
					<ul>
					</ul>
			    </div>
		<div class="secbg sle">
			<div class="center">
				<form id="searchForm"  action="${ctx}/userinfo/useroutpatientinfo" name="searchForm" class="form-inline">
					<input id="pageNo" name="pageNo" type="hidden" value="${pageinfo.pageNo}" /> 
					<input id="pageSize" name="pageSize" 	type="hidden" value="${pageinfo.pageSize}" />
					<ul>
					<li id="SelectTime"><input type="text" id="startdate" class="Stime" name="startdate" value="${startdate}" placeholder="开始时间"/>
					<span>—</span>
					<input type="text" class="Stime" id="enddate" name="enddate" value="${enddate}" placeholder="结束时间"/></li>
						<li><p>区域</p> <select id="cityId" name="cityId" class="step2" onchange="changeLac(this.value)" style="">
									 <c:if test="${empty cityId or cityId == 0}">
							        	<option value="0" selected="selected">---请选择---</option>
							         </c:if>
										<c:forEach var="cityitem" items="${citys}">
												 <c:if test="${cityitem.cityid == cityId}"> 
														<option value="${cityitem.cityid}">
															${cityitem.city}			
												 </c:if>	
										</c:forEach>
										<c:forEach var="cityitems" items="${citys}">
													 <c:if test="${cityitems.cityid != cityId}"> 
														<option value="${cityitems.cityid}">
															${cityitems.city}			
												 </c:if>	
										</c:forEach>
										<c:if test="${!empty cityId}">
											<option value="0">---请选择---</option>
										</c:if>
									</select>
												</li>
						<li><p>医院</p> <select id="step3" name="hospId" onchange="changeLacp(this.value)" style="">
							<c:if test="${empty hospId or hospId == 0}">
							<option value="0" selected="selected">---请选择---</option>
							</c:if>
							<c:forEach var="ho" items="${hospitas}">
							 <c:if test="${ho.hospitalId == hospId}"> 
								<option value="${ho.hospitalId}">
									${ho.name}			
								</option>
							</c:if>
							</c:forEach>
							<c:forEach var="ho" items="${hospitas }">
							 <c:if test="${ho.hospitalId != hospId}"> 
								<option value="${ho.hospitalId}">
									${ho.name}			
								</option>
							 </c:if>
							</c:forEach>
						</select>
						</li>

						<li><p>就诊卡</p> 
						<select id="patientNO" name="patientNO" class="step4">
								
									 <c:if test="${empty patientNO or patientNO == '0'}">
								        	<option value="0" selected="selected">---请选择---</option>
								     </c:if>
								<c:forEach var="ho" items="${userhospitallist}">
										 <c:if test="${ho.patientidcardno == patientNO}"> 
											<option value="${ho.patientidcardno}">
											${ho.patientname}(${ho.patientidcardno}) 				
											</option>
										</c:if>
								</c:forEach>
								
								<c:forEach var="ho" items="${userhospitallist}">
										 <c:if test="${ho.patientidcardno != patientNO}"> 
											<option value="${ho.patientidcardno}">
											${ho.patientname}(${ho.patientidcardno}) 				
											</option>
										</c:if>
								</c:forEach>
									<c:if test="${!empty patientNO}">
										<option value="0">---请选择---</option>
									</c:if>
						</select>
						</li>
						<li style="margin-right:0;"><input type="submit" onclick="return datecheck()" value="搜索">
						</li>
					</ul>
				</form>
			</div>
		</div>
				<div class="met mtn">
						<div class="center">
								<table cellspacing="0" ceelpadding='0' style="width:725px;margin:20px auto">
									<tr class="tr1"><td width="200px" class="num">医院</td>
										<td width="155px">就诊科室</td>
										<td width="140px">就诊人</td>
										<td width="180px">门诊时间</td>
										<td width="">操作</td>
									</tr>
									 <c:if test="${!empty pageinfo.list}">
									<c:forEach items="${pageinfo.list}" var="userDoctor">
									 <c:set var="hospital" value="${fnf:getHospitalByDocId(userDoctor.doctorId)}" />
									<tr>
										<td class="num">${hospital.name}</td>
										<td>${userDoctor.departmentname}</td>
										<td>${userDoctor.patientname}</td>
										<td><fmt:formatDate value="${userDoctor.sourcedate}" pattern="yyyy-MM-dd"/></td>
										<td><a href="${ctx}/userinfo/useroutpatientinfo?userDoctorId=${userDoctor.docuid}">查看</a></td>
									</tr>
									</c:forEach>
									</c:if>
								</table>
								<div class="page pgb">${pageinfo}</div>
						</div>
						
				</div>
				
		</div>
<!--                 <form id="searchForm" action="${ctx}/userinfo/queryOutPatient" name="searchForm" class="form-inline"> -->
<!--         			<input id="pageNo" name="pageNo" type="hidden" value="${pageinfo.pageNo}"/> -->
<!-- 					<input id="pageSize" name="pageSize" type="hidden" value="${pageinfo.pageSize}"/> -->
<!-- 					<input  name="cityId" type="hidden" value="${cityId}"/> -->
<!-- 					<input name="hospId" type="hidden" value="${hospId}"/> -->
<!-- 					<input name="upid" type="hidden" value="${upid}"/> -->
<!-- 		 	     </form> -->
<script type="text/javascript">
    function datecheck(){
        var sts= $("#startdate").val();
	 if($("#startdate").val() != "" &&$("#enddate").val() !=""){
	   if($("#startdate").val()>$("#enddate").val()){
	      	layer.alert("开始时间不能大于结束时间！"); 
	 	    return false;
	      }
    	}
	}
</script>
<script>
laydate.skin('molv');
var start = {
    elem: '#startdate',
    format: 'YYYY-MM-DD',
    max: laydate.now(), //最大日期
    istime: true,
    istoday: false,
    choose: function(datas){
         end.min = datas; //开始日选好后，重置结束日的最小日期
         end.start = datas //将结束日的初始值设定为开始日
    }
};
var end = {
    elem: '#enddate',
    format: 'YYYY-MM-DD',
    max: laydate.now(), //最大日期
    istime: true,
    istoday: false,
    choose: function(datas){
         end.min = datas; //开始日选好后，重置结束日的最小日期
         end.start = datas //将结束日的初始值设定为开始日
    }
};
laydate(start);
laydate(end);
</script>
<script type="text/javascript">


$(".menav li").each(function(a){ 

		var me = $(".menav li:eq("+a+")"),i=a+1;
		if(me.find("a").hasClass("on")){ 
				me.find("img").attr("src","${ctxStaticFront}/images/me_"+i+"h.png")
		}else{ 
			me.find("img").attr("src","${ctxStaticFront}/images/me_"+i+".png")
		}
		
		me.hover(function(){ 
			
			me.find("img").attr("src","${ctxStaticFront}/images/me_"+i+"h.png")
		},function(){ 
			if(!me.find("a").hasClass("on")){ 
				me.find("img").attr("src","${ctxStaticFront}/images/me_"+i+".png")
			}
			

		})
})


</script>

<script type="text/javascript">
//根据医院id查询就诊卡
	if($("#patientNO option").size() < 2){
		$('#patientNO').attr("disabled","desabled");
	}
	
  function changeLacp(v) {  
    jQuery('#patientNO').html(""); //把ci内容设为空  
    var ciValue = jQuery('#patientNO');  
    ciValue.append('<option value="0">---请选择---</option>');  
   	   $("#patientNO").css({"background":"#fff url(${ctxStaticFront}/images/selectLoad.gif) no-repeat 84% 50%"});    
    //异步请求查询ci列表的方法并返回json数组  
    jQuery.ajax({  
        url : '${ctx}/userinfo/findpatientbyhoiduserid',  
        type : 'post',  
        data : { hospId : $("#step3").val() },  
        dataType : 'json',  
        success : function (opts) {
            if (opts && opts.length > 0) {  
                    var html = [];  
                    for (var i = 0; i < opts.length; i++) {  
                        html.push('<option value="'+opts[i].patientidcardno+'">'+opts[i].patientname+'('+opts[i].medicareno+')</option>');  
                    }  
                    ciValue.append(html.join(''));  
                    $("#patientNO").removeAttr("disabled");  
                    $("#patientNO").css({"background":"#fff"});  
                }else{
                	  $("#patientNO").css({"background":"#D6D6D6"});  
                	  $('#patientNO').attr("disabled","desabled");
                }  
            }  
        });  

}  




//根据城市id查询医院	
	if($("#step3 option").size() < 2){
		$('#step3').attr("disabled","desabled");
	}
  function changeLac(v) {  
    jQuery('#step3').html(""); //把ci内容设为空  
    var ciValue = jQuery('#step3');  
    ciValue.append('<option value="0">---请选择---</option>');  
   	   $("#step3").css({"background":"#fff url(${ctxStaticFront}/images/selectLoad.gif) no-repeat 84% 50%"}); 
       jQuery('#patientNO').html("");
        $("#patientNO").css({"background":"#D6D6D6"});  
        $('#patientNO').attr("disabled","desabled");
        var ciValueno = jQuery('#patientNO');  
         ciValueno .append('<option value="0">---请选择---</option>');   
    //异步请求查询ci列表的方法并返回json数组
    jQuery.ajax({  
        url : '${ctx}/userinfo/searchhospatilbycityidofuesed',  
        type : 'post',  
        data : { cityId : $("#cityId").val() },  
        dataType : 'json',  
        success : function (opts) {
            if (opts && opts.length > 0) {  
                    var html = [];  
                    for (var i = 0; i < opts.length; i++) {  
                        html.push('<option value="'+opts[i].hospitalId+'">'+opts[i].name+'</option>');  
                    }  
                    ciValue.append(html.join(''));  
                    $("#step3").removeAttr("disabled");  
                    $("#step3").css({"background":"#fff"});  
                }else{
                	  $("#step3").css({"background":"#D6D6D6"});  
                	  $('#step3').attr("disabled","desabled");
                }  
            }  
        });  

}  
 function page(n, s) {
		if (n)
			$("#pageNo").val(n);
		if (s)
			$("#pageSize").val(s);
		//$("#searchForm").attr("action", "${ctx}/doctorinfo/myrepatient");
		$("#searchForm").submit();
		return false;
}
function querySubmit(){

	if(sumns()){
		 $("#action").val("more"); 
		 $("#searchForm").submit();
	}

}


function sumns(){
	if($("#startdate").val() == ""){
	 	layer.alert("请填写开始时间！"); 
	 	return false;
	}
	if($("#enddate").val() == ""){
		 layer.alert("请填写结束时间！");
		 return false; 
	}
	if($("#cityId").val() == 0 || $("#cityId").val() == ""){
		 layer.alert("请选择对应的城市！"); 
		 return false;
	}
	if($("#step3").val() == 0 || $("#step3").val() == ""){
		 layer.alert("请选择对应的医院！"); 
		 return false;
 	}
	if($("#patientNO").val() == 0 || $("#patientNO").val() == ""){
		 layer.alert("请选择需要查看的就诊卡！"); 
		 return false;
	 }
	 return true;
}
</script>




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







<!-- 	<script>
laydate.skin('molv')
laydate({
    elem: '#SelectTime input', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
    event: 'focus' //响应事件。如果没有传入event，则按照默认的click
});

</script> -->
<!-- <script type="text/javascript">
if($("#step3 option").size() < 2){
		$('#step4').attr("disabled","desabled");
	}
  function changeLac(v) {  
    jQuery('.step2').html(""); //把ci内容设为空  
    debugger;
    var ciValue = jQuery('.step2');  
    debugger;
    ciValue.append('<option value="0">---请选择---</option>');  
   	   $(".step2").css({"background":"#fff url(${ctxStaticFront}/images/selectLoad.gif) no-repeat 84% 50%"});    
    //异步请求查询ci列表的方法并返回json数组 
     debugger; 
    jQuery.ajax({  
        url : '${ctx}/userinfo/patientByCid',  
        type : 'post',  
        data : {cityId : $("#cityId").val()},  
        dataType : 'json',  
        success : function (opts) {
         debugger;
            if (opts && opts.length > 0) {  
                    var html = [];  
                    for (var i = 0; i < opts.length; i++) {  
                        html.push('<option value="'+opts[i].hospitalId+'">'+opts[i].name+'</option>');  
                    }  
                    ciValue.append(html.join(''));  
                    $(".step2").removeAttr("disabled");  
                    $(".step2").css({"background":"#fff"});  
                }else{
                	  $(".step2").css({"background":"#D6D6D6"});  
                	  $('.step2').attr("disabled","desabled");
                	   $(".step3").css({"background":"#D6D6D6"});  
                	  $('.step3').attr("disabled","desabled");
                }
                 debugger;
            }  
        });  

}
  function changeHos(v) {  
    jQuery('#step3').html(""); //把ci内容设为空  
    debugger;
    var ciValue = jQuery('#step3');  
    debugger;
    ciValue.append('<option value="0">---请选择---</option>');  
   	   $("#step3").css({"background":"#fff url(${ctxStaticFront}/images/selectLoad.gif) no-repeat 84% 50%"});    
    //异步请求查询ci列表的方法并返回json数组 
     debugger; 
    jQuery.ajax({  
        url : '${ctx}/userinfo/patientByHid',  
        type : 'post',  
        data : {hospId: $("#hospId").val()},  
        dataType : 'json',  
        success : function (opts) {
         debugger;
            if (opts && opts.length > 0) {  
                    var html = [];  
                    for (var i = 0; i < opts.length; i++) {  
                        html.push('<option value="'+opts[i].patientidcardno+'">'+opts[i].patientname+'('+opts[i].medicareno+')</option>');  
                    }  
                    ciValue.append(html.join(''));  
                    $("#step3").removeAttr("disabled");  
                    $("#step3").css({"background":"#fff"});  
                }else{
                	  $("#step3").css({"background":"#D6D6D6"});  
                	  $('#step3').attr("disabled","desabled");
                }
                 debugger;
            }  
        });  

}

$(".menav li").each(function(a){ 

		var me = $(".menav li:eq("+a+")"),i=a+1;
		if(me.find("a").hasClass("on")){ 
				me.find("img").attr("src","${ctxStaticFront}/images/me_"+i+"h.png")
		}else{ 
			me.find("img").attr("src","${ctxStaticFront}/images/me_"+i+".png")
		}
		
		me.hover(function(){ 
			
			me.find("img").attr("src","${ctxStaticFront}/images/me_"+i+"h.png")
		},function(){ 
			if(!me.find("a").hasClass("on")){ 
				me.find("img").attr("src","${ctxStaticFront}/images/me_"+i+".png")
			}
			

		})
})
       function page(n, s) {
		if (n)
			$("#pageNo").val(n);
		if (s)
			$("#pageSize").val(s);
		//$("#searchForm").attr("action", "${ctx}/doctorinfo/myrepatient");
		$("#searchForm").submit();
		return false;
}


</script>

<script type="text/javascript">
	$(document).ready(function(){  
        $("#button_submit").click(function(){  
            var uname = $("#uname").val();  
            var nname = $("#nickname").val(); 
            var umail = $("#mail").val();
             
            if(uname==""){
                $("#msgbox").show();
                $("#msgcontent").text("用户名不能为空");
            	
            	return false;
            }
            if(nname==""){
            	 $("#msgbox").show();
                $("#msgcontent").text("昵称不能为空");
            	return false;
            }
             if(umail==""){
            	 $("#msgbox").show();
                $("#msgcontent").text("邮箱不能为空");
            	return false;
            }
        }); 
 
        
    });  
</script> -->


</body>
</html>
