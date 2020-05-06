<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/front/include/taglib.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta name="decorator" content="frontdefault"/>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<script type="text/javascript" src="${ctxStaticFront}/js/power-slider.js"></script>
	<script type="text/javascript" src="${ctxStaticFront}/js/dome.js"></script>
	<script type="text/javascript" src="${ctxStaticFront}/js/layer/layer.js"></script>
	<script type="text/javascript" src="${ctxStaticFront}/js/jquery.cascadingdropdown.js"></script>
	<title>义诊医生</title>
	
</head>
<body >	
		<div id="content"> 
		   <div class="newsnav"> 
				<div class="center">
				<a href="${ctx}/">首页    >  </a>
			    <a href="${ctx}/doctor/moreDoctor">义诊咨询</a>
			    </div>
          </div>
		   
				<div class="yizhen">
					<div class="block_name mtt"> 
								
								<span class="">Clinic consultation</span>
								<p class="">义诊咨询</p>
								<div class="brd"></div>
					</div>
					<div class="zixun">
						<div class="Fontsbar">
								<p>免费咨询</p>
								<span>Free consultation</span>
						</div>
						<div class="center">
						<%-- <form class="Smsg" id="content" name="content" action="${ctx}/doctor/chatToDoctor"> --%>
						<form  id="content" name="content"  method="post" >
							<textarea placeholder="请在此输入您想咨询的问题，例如：请问怎样预防感冒？" name="UserContent" id="textareaid" style="width:75%;height:150px;margin-left:160px;"></textarea>
							<input type="submit" class="org"  value="提&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;交" onclick="return contentsend()">
						</form>
						</div>	

					</div>
				
				</div>
				<div class="yizhensl">
						<div class="Fontsbar">
										<p>今日义诊</p>
										<span>FREE CLINIC TODAY</span>
							</div>
						<div class="i5 sel5">
							<div class="center">
							<div class="slider" id="slider">
							<ul class="sliderbox" style="">
								   <c:forEach items="${page.list}" var="doctor">
								   <c:set var="doctorType" value="${fnf:getDoctorTypeByid(doctor.doctortype)}"/>
								   <c:set var="hospital" value="${fnf:getHospitalByintId(doctor.hospitalId)}"/>
										<li class="" style="">
										 <c:set var="url" value="${doctor.photourl}" />  
											<div class="userpic" style="background:url(${fnf:imageScaleUrl(url,'200','200','doctorpc')}) center no-repeat"> 
												<a href="../doctor/${doctor.doctorId}${urlSuffix}">
												<p class="opacity"><span>
													${doctor.specialty}
												</span></p>
												</a>
											</div>

											<div class="fonts ">
												<p class="p1">${doctor.name} <span>${doctorType.doctorTypeName}</span></p>
												<p class="p2">${hospital.name}</p>
												<div class="State">
                                                   <c:if test="${doctor.chartartconsult==1}">
													<a class="on" style="">图文</a>
												   </c:if>
												   <c:if test="${doctor.chartartconsult!=1}">
													<a class="off" style="">图文</a>
												   </c:if>
												
												   <c:if test="${doctor.videoconsult==1}">
													<a class="on" style="">视频</a>
													</c:if>
												   <c:if test="${doctor.videoconsult!=1}">
													<a class="off" style="">视频</a>
													</c:if>
													<c:if test="${doctor.telconsult==1}">
													<a class="on" style="">电话</a>
													</c:if>
												   <c:if test="${doctor.telconsult!=1}">
													<a class="off" style="">电话</a>
													</c:if>
													<c:if test="${doctor.isReg=='1'}">
													<a class="on" style="">挂号</a>
													</c:if>
												    <c:if test="${doctor.isReg!='1'}">
													<a class="off" style="">挂号</a>
													</c:if>
													<c:if test="${doctor.isWebDoctor==1}">
													<a class="on" style="">咨询</a>
													</c:if>
													<c:if test="${doctor.isWebDoctor!='1'}">
													<a class="off" style="">咨询</a>
													</c:if>
												
												</div>
											</div>
										</li>
									</c:forEach>
								</ul>

							<!-- 	<ul clernav">
									
								</ul> -->
							<!-- 	<div class="prev btn"></div>
								<div class="next btn"></div> -->
							</div>
						</div>
				</div>
				<form id="searchForm" action="${ctx}/doctor/moreDoctor" name="searchForm" class="form-inline">
        			<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
					<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		 		</form>
				
			<div class="page pgb">${page}</div>	
		</div>
		
		
		
<script type="text/javascript">
    var ctx="${ctx}";
</script>

<script type="text/javascript">
function setContent(str) {
	str = str.replace(/<\/?[^>]*>/g,'');          //去除HTML tag
	str.value = str.replace(/[ | ]*\n/g,'\n');    //去除行尾空白
	return str;
}


function contentsend(){
		var  contents= $("#textareaid").val();
	    var  content= setContent(contents);
		if(content==""||content==null){
			layer.alert('咨询内容不能为空');
			return false;
		 }
		if(content.length>300){
			layer.alert('咨询内容不能超过300字');
			return false;
		}else{
			 $.ajax({
			 	type: "POST",
					url: "${ctx}/doctor/freeconsultindex",
					 data : { contents :content},
					cache:false,
					async: false, 
					success: function(jsonJson)
					{     
						if(jsonJson.success){
						      layer.confirm('您的咨询已提交！系统审核通过后，将会有医生给您回复。您可以在个人中心-我的咨询-中查看。', {
		                        btn: ['返回义诊首页','查看咨询记录'] //按钮
		                    }, function(){
		                       parent.window.location.href = ctx+"/doctor/moreDoctor";//今日义诊主页
		                    }, function(){
		                      parent.window.location.href = ctx+"/userinfo/userconsultinfo";//跳转到用户中心-我的咨询
		                    });
		                   return false; 
						}
					 if(jsonJson.errorCode==02){
						layer.confirm(jsonJson.msg, {
		                btn: ['登录咨询','返回义诊首页'] //按钮
		                 }, function(){
		                      parent.window.location.href = ctx+"/login?url=/doctor/moreDoctor";//跳转到用户中心-我的咨询
		                    }, function(){
		                      parent.window.location.href = ctx+"/doctor/moreDoctor";//今日义诊主页
		                    });
		                    return false;
		             }else{
					    layer.alert(jsonJson.msg);
					    return false;
					 }
					 
					}
				});
				return false;
			}
}
</script>

		
<script type="text/javascript"> 
		function page(n, s) {
			if (n)
				$("#pageNo").val(n);
			if (s)
				$("#pageSize").val(s);
			$("#searchForm").submit();
			return false; 
		}


function Mualt () {
	layer.alert('<p class="pmsg">您的咨询已提交！系统审核通过后，将会有医生给您回复。</p><p class="pmsg">您可以在个人中心-我的咨询-<a href="">免费咨询</a>中查看。</p>',{ 
	title:"",
 	area: ['600px', '300px'],
 	closeBtn: 0,
 	shadeClose:true
 	
 	})
}




</script>
<script type="text/javascript"> 
// function clis(){
// 	        var idss = $("#ids").val();
// 	        var fonts = $("#sgfonts").val();
// 			alert(fonts);
// 			$.post("${ctx}/userinfo/userconsultinfo",{intertype:100,interid:idss,contents:fonts},function(result){
  					
//   				windows.location.href=result;
  				
  				
  				
//  		 });
// 	}



//$("#slider").powerSlider({handle:"left",sliderNum:2});
var lil = $("#slider li").length

if( lil > 8){

$("#slider").css("height","750px")

}





$("#slider li").css("width",$("#slider").width() * .25)




</script>
</body>
</html>