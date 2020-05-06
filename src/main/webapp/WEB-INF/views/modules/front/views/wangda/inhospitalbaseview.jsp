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
								<li><a href="${ctx}/userinfo/userconsultinfo"><img src=""><p>我的咨询</p></a></li>
								<li><a href="${ctx}/userinfo/reportinfo"><img src=""><p>我的报告</p></a></li>
								<li><a href="${ctx}/userinfo/useroutpatientinfo"><img src=""><p>我的门诊</p></a></li>
								<li><a href="${ctx}/userinfo/palyinfo"><img src=""><p>我的缴费</p></a></li>
								<li><a href="${ctx}/userinfo/orderinfo"><img src=""><p>我的订单</p></a></li>
								<li><a href="${ctx}/userinfo/newscollectinfo"><img src=""><p>我的收藏</p></a></li>
								<!-- 	<li><a href=""><img src=""><p>健康记录评估</p></a></li> -->
							<li><a href="${ctx}/userinfo/healthFile" class="on"><img src=""><p>我的健康档案</p></a></li>
								<li><a href="${ctx}/xnh/init""><img src=""><p>新农合</p></a></li>
						</ul>
					</div>

					</div>

				</div>


		<div class="gywm">
			<div class="center">
				<div class="l">
					<div class="Gnavbar" style="">
						<ul style="">
							<li><a href="${ctx}/userinfo/inhospitaldruginfo/InHospitalBaseInfo?idnote=${inHospitalnfo.idNote}&idextension=${inHospitalnfo.idExtension}" class="opacity on ">住院信息</a>
							</li>
							<li><a href="${ctx}/userinfo/inhospitaldruginfo/InHospitalSymptomInfo?idnote=${inHospitalnfo.idNote}&idextension=${inHospitalnfo.idExtension}" class="opacity ">症状</a>
							</li>
							<li><a href="${ctx}/userinfo/inhospitaldruginfo/InHospitalReportInfo?idnote=${inHospitalnfo.idNote}&idextension=${inHospitalnfo.idExtension}" class="opacity">检查检验报告</a>
							</li>
							<li><a href="${ctx}/userinfo/inhospitaldruginfo/InHospitalDiagnoseInfo?idnote=${inHospitalnfo.idNote}&idextension=${inHospitalnfo.idExtension}" class="opacity">诊断记录</a>
							</li>
							<li><a href="${ctx}/userinfo/inhospitaldruginfo/InHospitalHelpPlanInfo?idnote=${inHospitalnfo.idNote}&idextension=${inHospitalnfo.idExtension}" class="opacity">治疗计划</a>
							</li>
							<li><a href="${ctx}/userinfo/inhospitaldruginfo/InHospitalDrugInfo?idnote=${inHospitalnfo.idNote}&idextension=${inHospitalnfo.idExtension}" class="opacity">用药</a>
							</li>
						</ul>

					</div>
				</div>
				<div class="r">
					<div class="block_name mtt">
						<p class="">住院记录</p>
						<div class="brd"></div>
					</div>
					<div class="Gselect on">
						<table cellspacing="0" cellpadding="0">
							<tr>
								<td width="25%" align="center">会诊记录标识</td>
								<td width="75%" class="indent">${inHospitalnfo.idNotes}</td>
							</tr>
							<tr>
								<td width="25%" align="center">病案号标</td>
								<td width="75%" class="indent">${inHospitalnfo.idRecord}</td>
							</tr>
							<tr>
								<td width="25%" align="center">创建时间</td>
								<td width="75%" class="indent">${inHospitalnfo.doctorTime}</td>
							</tr>
							<tr>
								<td width="25%" align="center">入院时间</td>
								<td width="75%" class="indent">${inHospitalnfo.inTime}</td>
							</tr>
							<tr>
								<td width="25%" align="center">出院时间</td>
								<td width="75%" class="indent">${inHospitalnfo.outHispital}</td>
							</tr>
							<tr>
								<td width="25%" align="center">医生</td>
								<td width="75%" class="indent">${inHospitalnfo.doctor}</td>
							</tr><tr>
								<td width="25%" align="center">科室</td>
								<td width="75%" class="indent">${inHospitalnfo.office}</td>
							</tr><tr>
								<td width="25%" align="center">医院名称</td>
								<td width="75%" class="indent">${inHospitalnfo.hispital}</td>
							</tr><tr>
								<td width="25%" align="center">疾病</td>
								<td width="75%" class="indent">${inHospitalnfo.illness}</td>
							</tr>

						</table>
					</div>

					</div>

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

$(".Gselect.on").fadeIn()

function muo(o){ 

		if($(".Gselect.on").height() > $(".Gnavbar").height()){ 
		 o = $(".Gselect.on").height() + 143
		}else{ 
		 o = $(".Gnavbar").height() + 143
		}
		return o ;
}

$(".gywm").height(muo())
$(".Gnavbar li").each(function(){ 


	
		var i = $(this).index()
		var a = $(".Gselect:eq("+i+")")
		$(this).click(function(){ 
			if(!$(this).find("a").hasClass("on")){ 
			$(".Gselect.on").fadeOut().removeClass("on")
			$(".Gnavbar li a.on").removeClass("on")
			a.fadeIn().addClass("on")
			$(this).find("a").addClass("on")
			var ma  = muo();
			$(".gywm").animate({ 
					"height":ma
			})
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
