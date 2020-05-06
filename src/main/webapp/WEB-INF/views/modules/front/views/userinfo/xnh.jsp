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
	<style type="text/css">
	#p_bakzybc  a:HOVER {text-decoration: underline;} 
	</style>
</head>

<body>

<div id="content"> 
	<div class="newsnav"> 
		<div class="center">
			<a href="/">首页</a>   >   新农合查询
		</div>
	</div>

	<div class="myx">
		<div class="block_name mtt"> 
			<span class="">New farming or query</span>
			<p class="">新农合查询</p>
			<div class="brd"></div>
		</div>
		<div class="ziliao">
			<div class="Fontsbar">
			<p>个人信息</p>
			<span>Personal Information</span>
			</div>
			<div class="center">
				<input type="hidden" id="personcode" value="" />
				<input type="hidden" id="personid" value="" />
				<input type="hidden" id="errmsg" value="${errmsg}" />
				<span id="sp_personcode">参合号：</span>
				<span id="sp_personname">姓名： </span>
				<span id="sp_sex">性别： </span>
				<span id="sp_obd">出生日期：</span>
				<span id="sp_certid">身份证号：</span>
			</div>
		</div>
	</div>
	<div class="secbg sle enone">
		<div class="center"> 
			<ul> 
			<li><p>年份</p>
				<select name="year" id="nhselYear"  style="width: 150px;">
					<option value="">--请选择参合年份--</option>
					<option value="2015">2016</option>
					<option value="2015">2015</option>
					<option value="2014">2014</option>
					<option value="2013">2013</option>
					<option value="2012">2012</option>
					<option value="2011">2011</option>
					<option value="2010">2010</option>
					<option value="2009">2009</option>
				</select>
			
			</li>
			</ul>
		</div>
	</div>
	
	<div class="me_jz">
		<div class="swch xys">
			<a id="a_grchxx" href="" class="on">个人参合信息 </a>
			<a id="a_mzbc"  href="">门诊补偿 </a>
			<a id="a_zyjtsbc"  href="">住院及特殊补偿</a>
			<a id="a_debc"  href="">定额补偿</a>
			<a id="a_ecbc"  href="">二次补偿</a>
			<a id="a_mztc"  href="">门诊统筹</a>
			<a id="a_mbtc"  href="">慢病统筹</a>
		</div>
		<div class="me_qh nhsel">
			<div class="center">
				<div class="xqh on">
					<div class="chxx">
						<div class="title">
							<p class="p1">参合个人信息</p>	
							<p class="p2">家庭信息</p>
						</div>
						<ul class="on">
							<li><p class="p1"><b>个人参合号</b> <span  id="p1_personid"></span></p>	<p class="p2"><b>家庭参合号</b> <span id="f1_familycode"></span></p></li>
							<li><p class="p1"><b>姓      名</b><span id="p1_personname"></span></p>	<p class="p2"><b>家庭属性</b><span id="f1_attr"></span></p></li>
							<li><p class="p1"><b>身份证号</b><span id="p1_certid"></span></p>	<p class="p2"><b>家庭余额</b><span id="f1_familyaccount"></span></p></li>
							<li><p class="p1"><b>个人属性</b><span  id="p1_attr"></span></p>	<p class="p2"><b>状      态</b><span id="f1_status"></span></p></li>
							<li><p class="p1"><b>家庭关系</b><span id="p1_relation"></span></p>	<p class="p2"><b>参合人数</b><span id="f1_chcount"></span></p></li>
						</ul>
					</div>
				</div>
				
				<div class="xqh" id="div_mzbc">
					<div class="met mtn enone">
						<table cellspacing="0" ceelpadding='0' id="tb_mzbc">
							<tr class="tr1"><td width="200px" class="num">就诊时间</td>
							<td width="300px">就诊医院</td>
							<td width="225px">诊断疾病 </td>
							<td width="150px">经诊医生</td>
							<td width="140px">医疗总费用</td>
							<td width="140px">补偿费用</td>
							<td width="150px">补偿时间</td>
							</tr>
						</table>
					</div>
				</div>
				<div class="xqh" id="div_zybc">
					<div class="met mtn enone" id="div_zybc_sub">
						<table cellspacing="0" ceelpadding='0'   id="tb_zybc" >
							<tr class="tr1"><td width="55px" align="center">查看</td>
								<td width="100px">入院时间</td>
								<td width="90px">出院时间 </td>
								<td width="95px">补偿时间</td>
								<td width="100px">诊断疾病</td>
								<td width="98px">经治医生</td>
								<td width="70px">总费用</td>
								<td width="100px">非自费费用</td>
								<td width="85px">补偿费用</td>
								<td width="80px">审核费用</td>
								<td width="80px">就诊医院</td>
								<td width="80px">出院科室</td>
								<td width="100px">是否当地住院</td>
							</tr>
						</table>
					</div>
					
					<div class="met mtn enone"  id ="div_dayitem" style="padding-top: 0px; display: none;">
						<div class="block_name mtt"> 
									<p style="font-size: 24px; padding-bottom: 5px;" id="p_bakzybc" ><font style="border-bottom: 2px solid #0186d5;">每日清单</font>   <a href='javascript:;' onclick='bakZybc();' style="padding-left: 30px;color: #384DCA; font-size: 20px;">返回住院补偿</a> </p> 
						</div>
						<table cellspacing="0" ceelpadding='0'   id="tb_dayitem" >
							<tr class="tr1">
							  <td width='100px' class='num'>分类	</td>
								<td width='100px'>时间</td>
								<td width='100px'>收费类别 </td>
								<td width='150px'>名称</td>
								<td width='100px'>数量</td>
								<td width='105px'>总费用</td>
								<td width='105px'>非自费费用</td>
								<td width='150px'>处方医生</td>
								<td width='315px'>价格变动原因</td>
							</tr>
						</table>
					</div>
				</div>
				
				<div class="xqh" id="div_debc">
					<div class="met mtn enone">
						<table cellspacing="0" ceelpadding='0' id="tb_debc">
							<tr class="tr1"><td width="180px" class="num">补偿费用	</td>
							<td width="230px">医疗总费用</td>
							<td width="200px">就诊时间 </td>
							<td width="200px">补偿时间</td>
							<td width="170px">定额项目名称</td>
							<td>就诊医院</td>
							</tr>
						</table>
					</div>
				</div>
				
				<div class="xqh" id="div_ecbc">
					<div class="met mtn enone">
						<table cellspacing="0" ceelpadding='0' id="tb_ecbc">
							<tr class="tr1"><td width="165px" class="num">补偿费用	</td>
								<td width="235px">补偿时间</td>
								<td width="255px">经办人员 </td>
								<td width="285px">正常住院补偿</td>
								<td width="200px">补偿备注</td>
							</tr>
							
						</table>
					</div>
				</div>
				
				<div class="xqh" id="div_mztc">
					<div class="met mtn enone">
						<table cellspacing="0" ceelpadding='0' id="tb_mztc">
							<tr class="tr1">
								<td width="160px" class="num">诊疗项目名称 </td>
								<td width="120px">医疗总费用</td>
								<td width="120px">非自费费用 </td>
								<td width="105px">补偿费用</td>
								<td width="110px">补偿时间</td>
								<td width="130px">补偿机构</td>
								<td width="110px">经办人员</td>
								<td width="160px">审核人员</td>
								<td width="120px">审核备注</td>
							</tr>
						</table>
					</div>
				</div>
				
				<div class="xqh" id="div_mbtc">
					<div class="met mtn enone">
						<table cellspacing="0" ceelpadding='0' id="tb_mbtc">
							<tr class="tr1">
								<td width="165px" class="num">疾病名称	</td>
								<td width="120px">医疗总费用</td>
								<td width="120px">非自费费用 </td>
								<td width="135px">补偿费用</td>
								<td width="125px">补偿时间</td>
								<td width="110px">补偿机构 </td>
								<td width="105px">经办人员</td>
								<td width="140px">审核费用</td>
								<td width="115px">审核备注</td>
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


</script>

<script type="text/javascript">

var oldt = $(".xqh:first") // 初始化
$(".me_qh .center").css("height",oldt.height()+20) // 初始化
$(".swch a").each(function(a){ 
		var i = a+1;
		var that = $(".swch a:eq("+a+")")
		var thats = $(".xqh:eq("+a+")")
	
		that.click(function(){ 
			if (!searchXnh(i)) {
				return;
			}
			if(oldt != thats){ 
					$(".swch a.on").removeClass("on")
					that.addClass("on")
					
					oldt.fadeOut()
					thats.fadeIn()
					$(".me_qh .center").animate({ 
						"height":thats.height()+20
					})
					
					oldt=thats

			}
				
		})

});//切换,特效
    
$(document).ready(function(){  
	var errmsg = $("#errmsg").val();
	if ("" != errmsg) {
		// layer.msg(errmsg);
		// window.location.href= "/userinfo/authinfo";
		layer.alert('<p class="pmsg">' + errmsg + '</p><p class="pmsg">马上去&nbsp;&nbsp;&nbsp;&nbsp;<a href="${ctx}/userinfo/authinfo">实名认证</a></p>',{ 
			title:"消息提示",
		 	area: ['600px', '300px'],
		 	closeBtn: 0,
		 	shadeClose:true
		 	
		 	});
	} else {
		jQuery.ajax({  
			url : '${ctx}/xnh/personalInfo',  
			type : 'post',  
			data : { },  
			dataType : 'json',  
			success : function (opts) {  
				
				    if (opts.success) {  
		            var personalInfo = opts.msg;
			        $("#sp_personcode").html("参合号：" + personalInfo.personcode);
					$("#sp_personname").html("姓名：" + personalInfo.personname);
					$("#sp_sex").html("性别：" + personalInfo.sex);
					$("#sp_obd").html("出生日期：" + personalInfo.obd);
					$("#sp_certid").html("身份证号：" + personalInfo.certid);
					$("#personcode").val(personalInfo.personcode);
					$("#personid").val(personalInfo.personid);
		        } else {
						 layer.msg(opts.msg);
			    } 
			}  
		});
	}
	  
	
	$("#nhselYear").change(function(){
		var year = $("#nhselYear").val();
		if (year) {
			// searchXnh(1);
			$(".swch a:eq(0)").click();
		}
	});  
});

function bakZybc() {
	$("#div_dayitem").hide();
	$("#tb_dayitem tr").remove();
	$("#div_zybc_sub").show();
}

function zybcDetail(zyid) {
	var personcode = $("#personcode").val();
	if (null == personcode || "" == personcode) {
		return;
	}
	jQuery.ajax({  
		url : '${ctx}/xnh/searchDayItems',  
		type : 'post',  
		data : {"personcode":personcode, "zyid":zyid},  
		dataType : 'json',  
		success : function (opts) {  
		    if (opts.success) {  
	            var jsData = opts.msg;
	            
							 $("#tb_dayitem tr").remove();
							 var titleTr = "<tr class='tr1'><td width='100px' class='num'>分类	</td><td width='100px'>时间</td><td width='100px'>收费类别 </td><td width='150px'>名称</td><td width='100px'>数量</td><td width='105px'>总费用</td><td width='105px'>非自费费用</td><td width='150px'>处方医生</td><td width='315px'>价格变动原因</td></tr>";
							 $("#tb_dayitem").append(titleTr);
							 var listdata = jsData.list;
							 for (var i = 0; i < listdata.length; i++) {
									var dataTr = "<tr><td class='num'>";
									dataTr += listdata[i].lbmc;
									dataTr += "</td><td>";
									dataTr += listdata[i].logindate;
									dataTr += "</td><td>";
									dataTr += listdata[i].listname;
									dataTr += "</td><td>";
									dataTr += listdata[i].usualname;
									dataTr += "</td><td>";
									dataTr += listdata[i].allnumber;
									dataTr += "</td><td>";
									dataTr += listdata[i].allmoney;
									dataTr += "</td><td>";
									dataTr += listdata[i].bcmoney;
									dataTr += "</td><td>";
									dataTr += listdata[i].doctorname;
									dataTr += "</td><td>";
									dataTr += listdata[i].reason;
									dataTr += "</td></tr>";
									$("#tb_dayitem").append(dataTr);
							 }
							 $(".me_qh .center").animate({ 
									"height": $("#div_dayitem").height() + 20    
								})
								
							$("#div_dayitem").show();
							// $("#div_dayitem").addClass("on");
							$("#div_zybc_sub").hide();
			} else {
				layer.msg(opts.msg);
	    } 
		}  
	});  
	
}

function searchXnh(menuIdx) {
	var personcode = $("#personcode").val();
	var personid = $("#personid").val();
	if (null == personcode || "" == personcode || null == personid || "" == personid) {
		return false;
	}
	
	var year = $("#nhselYear").val();
	if(!year){
		alert("请选择参合年份");
		return false;
	}
	$("#tb_dayitem tr").remove();
	
	jQuery.ajax({  
		url : '${ctx}/xnh/searchXnh',  
		type : 'post',  
		data : {"personcode":personcode, "personid":personid, "daType":menuIdx, "year":year },  
		dataType : 'json',  
		success : function (opts) {  
		    if (opts.success) {  
	            var jsData = opts.msg;
	            // 个人参合和家庭参合信息
	            if (1 == menuIdx) {
	            	// 个人参合
	            	var personCH = jsData.personCH;
	            	$("#p1_personid").html(personCH.personid);
	            	$("#p1_personname").html(personCH.personname);
	            	$("#p1_certid").html(personCH.certid);
	            	$("#p1_attr").html(personCH.attr);
	            	$("#p1_relation").html(personCH.relation);
	            	// 家庭参合
	            	var familyCH = jsData.familyCH;
	            	$("#f1_familycode").html(familyCH.familycode);
	            	$("#f1_attr").html(familyCH.attr);
	            	$("#f1_familyaccount").html(familyCH.familyaccount);
	            	$("#f1_status").html(familyCH.status);
	            	$("#f1_chcount").html(familyCH.chcount);
	            // 门诊补偿
				} else if (2 == menuIdx) {
					 $("#tb_mzbc tr").remove();
					 var titleTr = "<tr class='tr1'><td width='200px' class='num'>就诊时间</td><td width='300px'>就诊医院</td><td width='225px'>诊断疾病 </td><td width='150px'>经诊医生</td><td width='140px'>医疗总费用</td><td width='140px'>补偿费用</td><td width='150px'>补偿时间</td></tr>";
					 $("#tb_mzbc").append(titleTr);
					 var listdata = jsData.list;
					 for (var i = 0; i < listdata.length; i++) {
							var dataTr = "<tr><td class='num'>";
							dataTr += listdata[i].jzdate;
							dataTr += "</td><td>";
							dataTr += listdata[i].hospitalname;
							dataTr += "</td><td>";
							dataTr += listdata[i].jbmc;
							dataTr += "</td><td>";
							dataTr += listdata[i].doctorname;
							dataTr += "</td><td>";
							dataTr += listdata[i].allmzfy;
							dataTr += "</td><td>";
							dataTr += listdata[i].bcfy;
							dataTr += "</td><td>";
							dataTr += listdata[i].bcdate;
							dataTr += "</td></tr>";
							$("#tb_mzbc").append(dataTr);
					 }
					 $(".me_qh .center").animate({ 
							"height": $("#div_mzbc").height() + 20    
						})
				// 住院及特殊补偿
				} else if (3 == menuIdx) {
					bakZybc();
				 	 $("#tb_zybc tr").remove();
					 var titleTr = "<tr class='tr1'><td width='80px' align='center'>查看</td><td width='100px'>入院时间</td><td width='90px'>出院时间 </td><td width='95px'>补偿时间</td><td width='100px'>诊断疾病</td><td width='98px'>经治医生</td><td width='70px'>总费用</td><td width='100px'>非自费费用</td><td width='85px'>补偿费用</td><td width='80px'>审核费用</td><td width='80px'>就诊医院</td><td width='80px'>出院科室</td><td width='100px'>是否当地住院</td></tr>";
					 $("#tb_zybc").append(titleTr);
					 var listdata = jsData.list;
					 for (var i = 0; i < listdata.length; i++) {
							var dataTr = "<tr><td align='center'><a href='javascript:;' onclick='zybcDetail(";
							dataTr += listdata[i].id;
							dataTr += ");' style='margin-right:0;font-weight:normal;color:blue;'>每日清单</a></td><td>";
							dataTr += listdata[i].rydate;
							dataTr += "</td><td>";
							dataTr += listdata[i].cydate;
							dataTr += "</td><td>";
							dataTr += listdata[i].fhdate;
							dataTr += "</td><td>";
							dataTr += listdata[i].jbmc;
							dataTr += "</td><td>";
							dataTr += listdata[i].doctorname;
							dataTr += "</td><td>";
							dataTr += listdata[i].zytotalmoney;
							dataTr += "</td><td>";
							dataTr += listdata[i].zffy;
							dataTr += "</td><td>";
							dataTr += listdata[i].sqmoney;
							dataTr += "</td><td>";
							dataTr += listdata[i].bcmoney;
							dataTr += "</td><td>";
							dataTr += listdata[i].hospitalname;
							dataTr += "</td><td>";
							dataTr += listdata[i].ksname;
							dataTr += "</td><td>";
							dataTr += listdata[i].islocal;
							dataTr += "</td></tr>";
							$("#tb_zybc").append(dataTr);
					 }
					 $(".me_qh .center").animate({ 
							"height": $("#div_zybc").height() + 20    
						})
				
				// 定额补偿
				} else if (4 == menuIdx) {
					 $("#tb_debc tr").remove();
					 var titleTr = "<tr class='tr1'><td width='180px' class='num'>补偿费用	</td><td width='230px'>医疗总费用</td><td width='200px'>就诊时间 </td><td width='200px'>补偿时间</td><td width='170px'>定额项目名称</td><td>就诊医院</td></tr>";
					 $("#tb_debc").append(titleTr);
					 var listdata = jsData.list;
					 for (var i = 0; i < listdata.length; i++) {
							var dataTr = "<tr> <td class='num'>";
							dataTr += listdata[i].bcfy;
							dataTr += "</td><td>";
							dataTr += listdata[i].allfy;
							dataTr += "</td><td>";
							dataTr += listdata[i].dedate;
							dataTr += "</td><td>";
							dataTr += listdata[i].fhdate;
							dataTr += "</td><td>";
							dataTr += listdata[i].dename;
							dataTr += "</td><td>";
							dataTr += listdata[i].hospitalname;
							dataTr += "</td></tr>";
							$("#tb_debc").append(dataTr);
					 }
					 $(".me_qh .center").animate({ 
							"height": $("#div_debc").height() + 20    
						})
				// 二次补偿
				} else if (5 == menuIdx) {
					 $("#tb_ecbc tr").remove();
					 var titleTr = "<tr class='tr1'><td width='165px' class='num'>补偿费用	</td><td width='235px'>补偿时间</td><td width='255px'>经办人员 </td><td width='285px'>正常住院补偿</td><td width='200px'>补偿备注</td></tr>";
					 $("#tb_ecbc").append(titleTr);
					 var listdata = jsData.list;
					 for (var i = 0; i < listdata.length; i++) {
							var dataTr = "<tr> <td class='num'>";
							dataTr += listdata[i].bcmoney;
							dataTr += "</td><td>";
							dataTr += listdata[i].fhdate;
							dataTr += "</td><td>";
							dataTr += listdata[i].fhuserid;
							dataTr += "</td><td>";
							dataTr += listdata[i].zcbcmoney;
							dataTr += "</td><td>";
							dataTr += listdata[i].bcremark;
							dataTr += "</td></tr>";
							$("#tb_ecbc").append(dataTr);
					 }
					 $(".me_qh .center").animate({ 
							"height": $("#div_ecbc").height() + 20    
						})
				// 门诊统筹
				} else if (6 == menuIdx) {
				   $("#tb_mztc tr").remove();
					 var titleTr = "<tr class='tr1'><td width='160px' class='num'>诊疗项目名称 </td><td width='120px'>医疗总费用</td><td width='120px'>非自费费用 </td><td width='105px'>补偿费用</td><td width='110px'>补偿时间</td><td width='130px'>补偿机构</td><td width='110px'>经办人员</td><td width='160px'>审核人员</td><td width='120px'>审核备注</td></tr>";
					 $("#tb_mztc").append(titleTr);
					 var listdata = jsData.list;
					 for (var i = 0; i < listdata.length; i++) {
							var dataTr = "<tr> <td class='num'>";
							dataTr += listdata[i].xmmc;
							dataTr += "</td><td>";
							dataTr += listdata[i].moneytotal;
							dataTr += "</td><td>";
							dataTr += listdata[i].moneyfzf;
							dataTr += "</td><td>";
							dataTr += listdata[i].bcmoney;
							dataTr += "</td><td>";
							dataTr += listdata[i].bcdate;
							dataTr += "</td><td>";
							dataTr += listdata[i].hospitalname;
							dataTr += "</td><td>";
							dataTr += listdata[i].uname;
							dataTr += "</td><td>";
							dataTr += listdata[i].shmoney;
							dataTr += "</td><td>";
							dataTr += listdata[i].shremark;
							dataTr += "</td></tr>";
							$("#tb_mztc").append(dataTr);
					 }
					 $(".me_qh .center").animate({ 
							"height": $("#div_mztc").height() + 20    
						})
				// 慢病统筹
				} else if (7 == menuIdx) {
				   $("#tb_mbtc tr").remove();
					 var titleTr = "<tr class='tr1'><td width='165px' class='num'>疾病名称	</td><td width='120px'>医疗总费用</td><td width='120px'>非自费费用 </td><td width='135px'>补偿费用</td><td width='125px'>补偿时间</td><td width='110px'>补偿机构 </td><td width='105px'>经办人员</td><td width='140px'>审核费用</td><td width='115px'>审核备注</td></tr>";
					 $("#tb_mbtc").append(titleTr);
					 var listdata = jsData.list;
					 for (var i = 0; i < listdata.length; i++) {
							var dataTr = "<tr> <td class='num'>";
							dataTr += listdata[i].xmmc;
							dataTr += "</td><td>";
							dataTr += listdata[i].moneytotal;
							dataTr += "</td><td>";
							dataTr += listdata[i].moneyfzf;
							dataTr += "</td><td>";
							dataTr += listdata[i].bcmoney;
							dataTr += "</td><td>";
							dataTr += listdata[i].bcdate;
							dataTr += "</td><td>";
							dataTr += listdata[i].hospitalname;
							dataTr += "</td><td>";
							dataTr += listdata[i].uname;
							dataTr += "</td><td>";
							dataTr += listdata[i].shmoney;
							dataTr += "</td><td>";
							dataTr += listdata[i].shremark;
							dataTr += "</td></tr>";
							$("#tb_mbtc").append(dataTr);
					 }
					 $(".me_qh .center").animate({ 
							"height": $("#div_mbtc").height() + 20    
						})
				}
	        } else {
					layer.msg(opts.msg);
		    } 
		}  
	});  
	return true;
}
    
</script>


</body>
</html>
