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
</head>

<body>

<div id="content" class="Mee"> 
<div class="mefixd">
				<div class="menav">
					<div class="center">
						<ul>
								<li><a href="${ctx}/userinfo/baseinfo" ><img src=""><p>个人信息</p></a></li>
								<li><a href="${ctx}/userinfo/attentioninfo"><img src=""><p>我的关注</p></a></li>
								<li><a href="${ctx}/userinfo/userregisterinfo"><img src=""><p>我的预约</p></a></li>
								<li><a href="${ctx}/userinfo/userconsultinfo" ><img src=""><p>我的咨询</p></a></li>
								<li><a href="${ctx}/userinfo/reportinfo" ><img src=""><p>我的报告</p></a></li>
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
					<div class="block_name mtt" style="margin:20px 0;"> 
							
							
							<p class="">门诊详情</p>
							<div class="brd"></div>
				</div>
					<div class="qrdoc ordsg">

									
									<div class="center">
										<div class="Fontsbar">
										<p>就诊人信息</p>
										<span>Patient information</span>
										</div>
										<p class="med">
										<span>姓名：${userDoc.patientname}</span>
										<span>性别：<c:if test="${userDoc.patientsex==0}">女</c:if><c:if test="${userDoc.patientsex==1}">男</c:if>
										</span>
										<span>年龄：${userDoc.age}</span>
										<span>身份证号：${userDoc.patientidcardno}</span>
										<span>手机号码：${userDoc.patienttelephone}</span>
										</p>
										


									</div>

					</div>
					<div class="qrdoc ordsg">

									
									<div class="center menz">
										<div class="Fontsbar">
										<p>门诊信息</p>
										<span>Outpatient information</span>
										</div>
										<div class="ctr">
										<c:if test="${!empty userDoc.doctorId}">
										<c:set var="doctor" value="${fnf:getDoctorByintId(userDoc.doctorId)}" />
										</c:if>
											<p class="p1"><span>${doctor.name}</span>&nbsp;&nbsp;&nbsp;&nbsp; ${doctor.doctortype}</p>
											<p>${doctor.hospitalname}-${doctor.departmentname}</p>
											
										</div>
										<div class="zhend">
											<h2>医生诊断</h2>
											<p align="center">多喝牛骨汤</p>
										</div>
										<div class="zhend">
											<h2>医生建议</h2>
											<p align="center">没有特别的解决方法，需要特别修养</p>
										</div>


									</div>

					</div>	
		</div>

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
</script>


</body>
</html>
