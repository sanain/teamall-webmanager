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
								<li><a href=""><img src=""><p>健康记录评估</p></a></li>
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
						    <li><a href="${ctx}/userinfo/inhospitaldruginfo/InHospitalBaseInfo?idnote=${yongyaoinfo.idNote}&idextension=${yongyaoinfo.idExtension}" class="opacity ">住院信息</a>
							</li>
							<li><a href="${ctx}/userinfo/inhospitaldruginfo/InHospitalSymptomInfo?idnote=${yongyaoinfo.idNote}&idextension=${yongyaoinfo.idExtension}" class="opacity ">症状</a>
							</li>
							<li><a href="${ctx}/userinfo/inhospitaldruginfo/InHospitalReportInfo?idnote=${yongyaoinfo.idNote}&idextension=${yongyaoinfo.idExtension}" class="opacity">检查检验报告</a>
							</li>
							<li><a href="${ctx}/userinfo/inhospitaldruginfo/InHospitalDiagnoseInfo?idnote=${yongyaoinfo.idNote}&idextension=${yongyaoinfo.idExtension}" class="opacity">诊断记录</a>
							</li>
							<li><a href="${ctx}/userinfo/inhospitaldruginfo/InHospitalHelpPlanInfo?idnote=${yongyaoinfo.idNote}&idextension=${yongyaoinfo.idExtension}" class="opacity">治疗计划</a>
							</li>
							<li><a href="${ctx}/userinfo/inhospitaldruginfo/InHospitalDrugInfo?idnote=${yongyaoinfo.idNote}&idextension=${yongyaoinfo.idExtension}" class="opacity on">用药</a>
							</li>
						</ul>

					</div>
				</div>
				<div class="r">
					<div class="block_name mtt">
						<p class="">用药</p>
						<div class="brd"></div>
					</div>
					<div class="Gselect on">
						<table cellspacing="0" cellpadding="0">
							<tr>
								<td width="25%" align="center">用药计量-单次</td>
								<td width="75%" class="indent">${yongyaoinfo.pharmacyDose}</td>
							</tr>
							<tr>
								<td width="25%" align="center">用药频率</td>
								<td width="75%" class="indent">${yongyaoinfo.pharmacyFrequency}</td>
							</tr>
							<tr>
								<td width="25%" align="center">药物计型</td>
								<td width="75%" class="indent">${yongyaoinfo.pharmacyDosageForm}</td>
							</tr>
							<%-- <tr>
								<td width="25%" align="center">药物计型代码表</td>
								<td width="75%" class="indent">${yongyaoinfo.inTime}</td>
							</tr> --%>
							<tr>
								<td width="25%" align="center">药物名称</td>
								<td width="75%" class="indent">${yongyaoinfo.pharmacyName}</td>
							</tr>
							<tr>
								<td width="25%" align="center">用药天数</td>
								<td width="75%" class="indent">${yongyaoinfo.pharmacyDays}</td>
							</tr><tr>
								<td width="25%" align="center">药物使用总剂量</td>
								<td width="75%" class="indent">${yongyaoinfo.pharmacyTotalDose}</td>
							</tr><tr>
								<td width="25%" align="center">用药停止日期</td>
								<td width="75%" class="indent">${yongyaoinfo.pharmacyStopDate}</td>
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
