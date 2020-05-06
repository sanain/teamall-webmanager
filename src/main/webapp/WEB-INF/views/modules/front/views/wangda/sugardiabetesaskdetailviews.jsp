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

<h1>慢病随访-糖尿病</h1>
<table cellspacing="0" cellpadding="0">
							<tr>
								<td width="25%" align="center">登记日期</td>
								<td width="75%" class="indent">${tangniaobingsuifanginfo.followDate}</td>
							</tr>
							<tr>
								<td width="25%" align="center">随访日期</td>
								<td width="75%" class="indent">${tangniaobingsuifanginfo.followTime}</td>
							</tr>
							<tr>
								<td width="25%" align="center">随访医生</td>
								<td width="75%" class="indent">${tangniaobingsuifanginfo.followDoctorName}</td>
							</tr>
							<tr>
								<td width="25%" align="center">随访方式</td>
								<td width="75%" class="indent">${tangniaobingsuifanginfo.followWay}</td>
							</tr>
							<tr>
								<td width="25%" align="center">症状名称</td>
								<td width="75%" class="indent">${tangniaobingsuifanginfo.symptomName}</td>
							</tr>
							<tr>
								<td width="25%" align="center">症状名称描述</td>
								<td width="75%" class="indent">${tangniaobingsuifanginfo.symptomNameDescription}</td>
							</tr>
							<tr>
								<td width="25%" align="center">收缩压</td>
								<td width="75%" class="indent">${tangniaobingsuifanginfo.systolicPressurel}</td>
							</tr><tr>
								<td width="25%" align="center">舒张压</td>
								<td width="75%" class="indent">${tangniaobingsuifanginfo.diastolicPressure}</td>
							</tr><tr>
								<td width="25%" align="center">体重</td>
								<td width="75%" class="indent">${tangniaobingsuifanginfo.weight}</td>
							</tr>
							<tr>
								<td width="25%" align="center">体质指数</td>
								<td width="75%" class="indent">${tangniaobingsuifanginfo.constitutionalIndex}</td>
							</tr>
							
								<tr>
								<td width="25%" align="center">足背脉搏动标志</td>
								<td width="75%" class="indent">${tangniaobingsuifanginfo.dorsalArterialPulseSign}</td>
							</tr>
								<tr>
								<td width="25%" align="center">其他阳性体征</td>
								<td width="75%" class="indent">${tangniaobingsuifanginfo.other}</td>
							</tr>
							<tr>
								<td width="25%" align="center">其他阳体特征描述</td>
								<td width="75%" class="indent">${tangniaobingsuifanginfo.otherDescription}</td>
							</tr>
								<tr>
								<td width="25%" align="center">日吸烟量</td>
								<td width="75%" class="indent">${tangniaobingsuifanginfo.smoking}</td>
							</tr>
								<tr>
								<td width="25%" align="center">日饮酒量</td>
								<td width="75%" class="indent">${tangniaobingsuifanginfo.alcohol}</td>
							</tr>
								<tr>
								<td width="25%" align="center">锻炼频率</td>
								<td width="75%" class="indent">${tangniaobingsuifanginfo.exerciseFrequency}</td>
							</tr>
							<tr>
								<td width="25%" align="center"> 每次锻炼时间</td>
								<td width="75%" class="indent">${tangniaobingsuifanginfo.exerciseTime}</td>
							</tr>
								<tr>
								<td width="25%" align="center">日主食量</td>
								<td width="75%" class="indent">${tangniaobingsuifanginfo.stapleFood}</td>
							</tr>
								<tr>
								<td width="25%" align="center">心理调整状态</td>
								<td width="75%" class="indent">${tangniaobingsuifanginfo.mentality}</td>
							</tr>
								<tr>
								<td width="25%" align="center">目标体重</td>
								<td width="75%" class="indent">${tangniaobingsuifanginfo.targetWeight}</td>
							</tr>
								<tr>
								<td width="25%" align="center">目标体质指数</td>
								<td width="75%" class="indent">${tangniaobingsuifanginfo.targetConstitutionalIndex}</td>
							</tr>
								<tr>
								<td width="25%" align="center">目标日吸烟量</td>
								<td width="75%" class="indent">${tangniaobingsuifanginfo.targetSmoking}</td>
							</tr>
								<tr>
								<td width="25%" align="center">目标日饮酒量</td>
								<td width="75%" class="indent">${tangniaobingsuifanginfo.targetAlcohol}</td>
							</tr>
								<tr>
								<td width="25%" align="center">目标锻炼频率</td>
								<td width="75%" class="indent">${tangniaobingsuifanginfo.targetExerciseFrequency}</td>
							</tr>
								<tr>
								<td width="25%" align="center">目标动力时长</td>
								<td width="75%" class="indent">${tangniaobingsuifanginfo.targetPower}</td>
							</tr>
								<tr>
								<td width="25%" align="center">目标日主食量</td>
								<td width="75%" class="indent">${tangniaobingsuifanginfo.targeMentality}</td>
							</tr>
								<tr>
								<td width="25%" align="center">空腹血糖值</td>
								<td width="75%" class="indent">${tangniaobingsuifanginfo.kfxt}</td>
							</tr>
								<tr>
								<td width="25%" align="center">糖化血红蛋白值</td>
								<td width="75%" class="indent">${tangniaobingsuifanginfo.thxhdb}</td>
							</tr>
								<tr>
								<td width="25%" align="center">辅助检查项目</td>
								<td width="75%" class="indent">${tangniaobingsuifanginfo.inspectionItem}</td>
							</tr>
								<tr>
								<td width="25%" align="center">辅助检查项目描述</td>
								<td width="75%" class="indent">${tangniaobingsuifanginfo.inspectionItemDescription}</td>
							</tr>
								<tr>
								<td width="25%" align="center">辅助日期</td>
								<td width="75%" class="indent">${tangniaobingsuifanginfo.inspectionTime}</td>
							</tr>
								<tr>
								<td width="25%" align="center">下次随访日期</td>
								<td width="75%" class="indent"><fmt:formatDate value="${tangniaobingsuifanginfo.nextFollowDate}" pattern="yyyy-MM-dd "/></td>
							</tr>

						</table>
</html>

