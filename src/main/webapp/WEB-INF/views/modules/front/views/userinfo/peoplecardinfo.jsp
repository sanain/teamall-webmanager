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
	<script type="text/javascript" src="${ctxStaticFront}/js/laydate/laydate.js"></script>
	<script type="text/javascript" src="${ctxStaticFront}/js/jquery.cascadingdropdown.js"></script>
</head>

<body>
  
<div id="content" class="Mee"> 
				<div class="mefixd">
				<div class="menav">
					<div class="center">
						<ul>
							<li><a href="${ctx}/userinfo/baseinfo" class="on"><img src=""><p>个人信息</p></a></li>
								<li><a href="${ctx}/userinfo/attentioninfo"><img src=""><p>我的关注</p></a></li>
								<li><a href="${ctx}/userinfo/userregisterinfo"><img src=""><p>我的预约</p></a></li>
								<li><a href="${ctx}/userinfo/userconsultinfo"><img src=""><p>我的咨询</p></a></li>
								<li><a href="${ctx}/userinfo/reportinfo"><img src=""><p>我的报告</p></a></li>
								<li><a href="${ctx}/userinfo/useroutpatientinfo"><img src=""><p>我的门诊</p></a></li>
								<li><a href="${ctx}/userinfo/palyinfo" ><img src=""><p>我的缴费</p></a></li>
								<li><a href="${ctx}/userinfo/orderinfo" ><img src=""><p>我的订单</p></a></li>
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
							<li><a href="${ctx}/userinfo/baseinfo" class="opacity">个人资料</a></li>
							<li><a href="${ctx}/userinfo/authinfo" class="opacity ">实名认证</a></li>
							<li><a href="${ctx}/userinfo/passwordinfo" class="opacity ">密码修改</a></li>
							<li><a href="${ctx}/userinfo/peoplecardinfo" class="opacity on">就诊卡管理</a></li>
					</ul>
				</div>
				<div class="bar">
					<ul>
					</ul>
			    </div>
				<div class="secbg sle">
						<div class="center">
							<form id="searchForm"  action="${ctx}/userinfo/peoplecardinfo" name="searchForm" method="post" class="form-inline">
								<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}" /> 
								<input id="pageSize" name="pageSize" 	type="hidden" value="${page.pageSize}" />
								<ul>
								<%-- <li id="SelectTime"><input type="text" id="startdate" class="Stime" name="startdate" value="${startdate}" placeholder="开始时间"/>
								<span>—</span>
								<input type="text" class="Stime" id="enddate" name="enddate" value="${enddate}" placeholder="结束时间"/></li> --%>
									<li><p>区域</p> <select id="cityId" name="cityId" class="step2" onchange="changeLac(this.value)" style="">
														 <c:if test="${empty cityId or cityId == 0}">
												        	<option value="0" selected="selected">---请选择---</option>
												         </c:if>
												         <c:if test="${not empty cityId and cityId!=0}">
												         	<option value="0" >---请选择---</option>
												         </c:if>
														<c:forEach var="cityitem" items="${citys}">
															<option value="${cityitem.cityid}" ${cityId==cityitem.cityid?'selected':''}>${cityitem.city}</option>
														</c:forEach>
														
												</select>
									</li>
									<li><p>医院</p> <select id="step3" name="hospId" onchange="changeLacp(this.value)" style="">
										<c:if test="${empty hospId or hospId == 0}">
										<option value="" selected="selected">---请选择---</option>
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
			
									<li style="margin-right:0;"><input type="submit" onclick="return datecheck()" value="搜索">
									</li>
								</ul>
							</form>
						</div>
					</div>
			       
			       <div class="met mtn enone">
						<div class="center" >
								<table cellspacing="0" ceelpadding='0' style="width:730px;margin:0 auto">
									<tr class="tr1">
									    <td width="258px">&nbsp;&nbsp;&nbsp;&nbsp;医院</td>
										<td width="135px">姓名</td>
										<td width="220px">卡号 </td>
										<td >操作</td>
									</tr>
									
									<c:forEach  items="${page.list}" var="userHosIfno">
				                    <c:set var="hosp" value="${fnf:getHospitalByintId(userHosIfno.hospitalId)}"/>  
									   <tr>
											<td > 
											   <c:if test="${not empty hosp.name}">&nbsp;&nbsp;&nbsp;&nbsp;${hosp.name}<!--${userHosIfno.hospitalId}--></c:if>
											   <c:if test="${ empty hosp.name}"> &nbsp;&nbsp; </c:if>
											</td>
											
											<td>${userHosIfno.patientname}</td>
											<td> 
											 <c:if test="${not empty userHosIfno.medicareno}"> ${userHosIfno.medicareno}</c:if>
											 <c:if test="${ empty userHosIfno.medicareno}">   &nbsp;&nbsp; </c:if>
											</td>  
					  
											<td>
											 <a  class="dell"  href="" adel="${userHosIfno.upid}">删除</a>
					                         <a href="${ctx}/userinfo/peoplecardinfo?opid=2&upno=${userHosIfno.upid}">编辑</a>
					                        </td>
									  </tr>
									</c:forEach>
									
									
									
								</table>
								<div class="me_add" style="margin-bottom:10px;">
									<a href="${ctx}/userinfo/peoplecardinfo?opid=0" class="add"><img src="${ctxStaticFront}/images/addjzs.png">
									</a>
								</div>
						</div>
						
				</div>
				<div class="page pgb" style="margin-top:10px;">${page}</div>
			       



		</div>

<script type="text/javascript">


      $("a.dell").on("click",function(){ 
      		var i = $(this).attr("adel")
      			        layer.alert("确认删除？",{ 
						btn:['确定','取消'],
						yes:function(){ 
							window.location.href="${ctx}/userinfo/peoplecardinfo?opid=1&upno="+i+""
						},
						cancel:function(){ 
						}
						});
				 return false;
      	
      })
      
    
</script>

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










</body>
</html>
