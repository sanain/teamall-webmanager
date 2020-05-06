<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/front/include/taglib.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title></title>
	<meta name="keywords" content="" />
	<meta name="description" content="" />
</head>

<body>
<style type="text/css"> 
	
	*{padding: 0;margin: 0;font-family:"5FAE8F6F96C59ED1", "Microsoft Yahei";list-style-type: none;}

	body{padding: 15px;}
	table{width: 730px;margin: 0 auto;border-left: 1px solid #bbc6dd;border-top: 1px solid #bbc6dd}
	table td{border-right: 1px solid #bbc6dd;border-bottom: 1px solid #bbc6dd;height: 35px;line-height: 35px;color: #888d95;font-size: 14px;}
	table td.indent{text-indent: 20px}
	h1{font-size: 30px;padding-bottom: 10px;color: #404d5e;font-weight: normal;text-align: center;}
	.bard{width: 60px;height: 1px ;background: #0186d5;margin: 0 auto 30px auto}
	</style>

<h1>慢病随访-高血压</h1>
<table cellspacing="0" cellpadding="0">
							<tr>
								<td width="25%" align="center">创建时间</td>
								<td width="75%" class="indent">${gaoxueyasuifanginfo.followDate}</td>
							</tr>
							<tr>
								<td width="25%" align="center">随访时间</td>
								<td width="75%" class="indent">${gaoxueyasuifanginfo.followDate}</td>
							</tr>
							<tr>
								<td width="25%" align="center">随访医生姓名</td>
								<td width="75%" class="indent">${gaoxueyasuifanginfo.followDoctorName}</td>
							</tr>
							<tr>
								<td width="25%" align="center">医院名称</td>
								<td width="75%" class="indent">${gaoxueyasuifanginfo.followOrgName}</td>
							</tr>
							<tr>
								<td width="25%" align="center">随访方式</td>
								<td width="75%" class="indent">${gaoxueyasuifanginfo.followWay}</td>
							</tr>
							<tr>
								<td width="25%" align="center">症状名称</td>
								<td width="75%" class="indent">${gaoxueyasuifanginfo.symptomName}</td>
							</tr><tr>
								<td width="25%" align="center">症状名称描述</td>
								<td width="75%" class="indent">${gaoxueyasuifanginfo.symptomNameDescription}</td>
							</tr><tr>
								<td width="25%" align="center">收缩压</td>
								<td width="75%" class="indent">${gaoxueyasuifanginfo.systolicPressurel}</td>
							</tr>
							<tr>
								<td width="25%" align="center">舒张压</td>
								<td width="75%" class="indent">${gaoxueyasuifanginfo.diastolicPressure}</td>
							</tr>
							
								<tr>
								<td width="25%" align="center">体重</td>
								<td width="75%" class="indent">${gaoxueyasuifanginfo.weight}</td>
							</tr>
								<tr>
								<td width="25%" align="center">体质指数</td>
								<td width="75%" class="indent">${gaoxueyasuifanginfo.constitutionalIndex}</td>
							</tr>
							<tr>
								<td width="25%" align="center">其他阳体特征</td>
								<td width="75%" class="indent">${gaoxueyasuifanginfo.other}</td>
							</tr>
								<tr>
								<td width="25%" align="center">其他阳体特征描述</td>
								<td width="75%" class="indent">${gaoxueyasuifanginfo.otherDescription}</td>
							</tr>
								<tr>
								<td width="25%" align="center">日吸烟量</td>
								<td width="75%" class="indent">${gaoxueyasuifanginfo.smoking}</td>
							</tr>
								<tr>
								<td width="25%" align="center">日饮酒量</td>
								<td width="75%" class="indent">${gaoxueyasuifanginfo.alcohol}</td>
							</tr>
							<tr>
								<td width="25%" align="center">锻炼频率</td>
								<td width="75%" class="indent">${gaoxueyasuifanginfo.exerciseFrequency}</td>
							</tr>
								<tr>
								<td width="25%" align="center">每次锻炼时间</td>
								<td width="75%" class="indent">${gaoxueyasuifanginfo.exerciseTime}</td>
							</tr>
								<tr>
								<td width="25%" align="center">摄盐情况</td>
								<td width="75%" class="indent">${gaoxueyasuifanginfo.saltIntake}</td>
							</tr>
								<tr>
								<td width="25%" align="center">心理调整状态</td>
								<td width="75%" class="indent">${gaoxueyasuifanginfo.mentality}</td>
							</tr>
								<tr>
								<td width="25%" align="center">目标体重</td>
								<td width="75%" class="indent">${gaoxueyasuifanginfo.targetWeight}</td>
							</tr>
								<tr>
								<td width="25%" align="center">目标体质指标</td>
								<td width="75%" class="indent">${gaoxueyasuifanginfo.targetConstitutionalIndex}</td>
							</tr>
								<tr>
								<td width="25%" align="center">目标日吸烟量</td>
								<td width="75%" class="indent">${gaoxueyasuifanginfo.targetSmoking}</td>
							</tr>
								<tr>
								<td width="25%" align="center">目标日饮酒量</td>
								<td width="75%" class="indent">${gaoxueyasuifanginfo.targetAlcohol}</td>
							</tr>
								<tr>
								<td width="25%" align="center">目标锻炼频率</td>
								<td width="75%" class="indent">${gaoxueyasuifanginfo.targetExerciseFrequency}</td>
							</tr>
								<tr>
								<td width="25%" align="center">目标动力时长</td>
								<td width="75%" class="indent">${gaoxueyasuifanginfo.targetPower}</td>
							</tr>
								<tr>
								<td width="25%" align="center">目标摄盐情况</td>
								<td width="75%" class="indent">${gaoxueyasuifanginfo.targetSaltIntake}</td>
							</tr>
								<tr>
								<td width="25%" align="center">辅助检查项目</td>
								<td width="75%" class="indent">${gaoxueyasuifanginfo.inspectionItem}</td>
							</tr>
								<tr>
								<td width="25%" align="center">辅助检查项目描述</td>
								<td width="75%" class="indent">${gaoxueyasuifanginfo.inspectionItemDescription}</td>
							</tr>
								<tr>
								<td width="25%" align="center">辅助检查结果</td>
								<td width="75%" class="indent">${gaoxueyasuifanginfo.inspectionResult}</td>
							</tr>
								<tr>
								<td width="25%" align="center">辅助检查结果描述</td>
								<td width="75%" class="indent">${gaoxueyasuifanginfo.inspectionResultDescription}</td>
							</tr>
								<tr>
								<td width="25%" align="center">随访评价结果</td>
								<td width="75%" class="indent">${gaoxueyasuifanginfo.followResultEvaluation}</td>
							</tr>
							<tr>
								<td width="25%" align="center">转诊原因</td>
								<td width="75%" class="indent">${gaoxueyasuifanginfo.referralReasons}</td>
							</tr>
							
							<tr>
								<td width="25%" align="center">目标转诊科室</td>
								<td width="75%" class="indent">${gaoxueyasuifanginfo.targetReferralDep}</td>
							</tr>
							<tr>
								<td width="25%" align="center">目标转诊医院</td>
								<td width="75%" class="indent">${gaoxueyasuifanginfo.targetReferralOrg}</td>
							</tr>
							<tr>
								<td width="25%" align="center">下次随访日期</td>
								<td width="75%" class="indent">${gaoxueyasuifanginfo.nextFollowDate}</td>
							</tr>
							

						</table>
</html>

