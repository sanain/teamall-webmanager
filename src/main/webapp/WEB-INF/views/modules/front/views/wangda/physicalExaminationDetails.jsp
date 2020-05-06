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

<h1>体检报告详情</h1>
<table cellspacing="0" cellpadding="0">
	<tr>
		<td width="25%" align="center">建卡日期</td>
		<td width="75%" class="indent">${am.buildCardDate}</td>
	</tr>
	<tr>
		<td width="25%" align="center">建卡姓名</td>
		<td width="75%" class="indent">${am.buildCardName}</td>
	</tr>
	<tr>
		<td width="25%" align="center">建卡就医名称</td>
		<td width="75%" class="indent">${am.buildCardOrgName}</td>
	</tr>
	<tr>
		<td width="25%" align="center">建卡就医地址</td>
		<td width="75%" class="indent">${am.buildCardOrgAddr}</td>
	</tr>
	<tr>
		<td width="25%" align="center">体检时间</td>
		<td width="75%" class="indent">${am.testTime}</td>
	</tr>
	<tr>
		<td width="25%" align="center">责任医生姓名</td>
		<td width="75%" class="indent">${am.responsibleDoctorName}</td>
	</tr>
	<tr>
		<td width="25%" align="center">症状名称</td>
		<td width="75%" class="indent">${am.symptomName}</td>
	</tr>
	<tr>
		<td width="25%" align="center">症状名称描述</td>
		<td width="75%" class="indent">${am.symptomNameDescription}</td>
	</tr>
	<tr>
		<td width="25%" align="center">体温</td>
		<td width="75%" class="indent">${am.temperature}</td>
	</tr>
	<tr>
		<td width="25%" align="center">脉搏</td>
		<td width="75%" class="indent">${am.pluseRate}</td>
	</tr>
	<tr>
		<td width="25%" align="center">呼吸频次</td>
		<td width="75%" class="indent">${am.respiratoryFrequency}</td>
	</tr>
	<tr>
		<td width="25%" align="center">左侧收缩压</td>
		<td width="75%" class="indent">${am.leftSystolicPressure}</td>
	</tr>
	<tr>
		<td width="25%" align="center">左侧舒张压</td>
		<td width="75%" class="indent">${am.leftDiastolicPressure}</td>
	</tr>
	<tr>
		<td width="25%" align="center">右侧收缩压</td>
		<td width="75%" class="indent">${am.rightSystolicPressure}</td>
	</tr>
	<tr>
		<td width="25%" align="center">右侧舒张压</td>
		<td width="75%" class="indent">${am.rightDiastolicPressure}</td>
	</tr>
	<tr>
		<td width="25%" align="center">身高</td>
		<td width="75%" class="indent">${am.height}</td>
	</tr>
	<tr>
		<td width="25%" align="center">体重</td>
		<td width="75%" class="indent">${am.weight}</td>
	</tr>
	<tr>
		<td width="25%" align="center">腰围</td>
		<td width="75%" class="indent">${am.waist}</td>
	</tr>
	<tr>
		<td width="25%" align="center">体质指数</td>
		<td width="75%" class="indent">${am.constitutionalIndex}</td>
	</tr>
	<tr>
		<td width="25%" align="center">心率</td>
		<td width="75%" class="indent">${am.heartRate}</td>
	</tr>
	<tr>
		<td width="25%" align="center">口唇外观</td>
		<td width="75%" class="indent">${am.appearanceLips}</td>
	</tr>
	<tr>
		<td width="25%" align="center">齿列</td>
		<td width="75%" class="indent">${am.dentition}</td>
	</tr>
	<tr>
		<td width="25%" align="center">齿列描述</td>
		<td width="75%" class="indent">${am.dentitionDescription}</td>
	</tr>
	<tr>
		<td width="25%" align="center">咽部检查结果</td>
		<td width="75%" class="indent">${am.pharyngealCheckResult}</td>
	</tr>
	<tr>
		<td width="25%" align="center">左眼裸眼远视力值</td>
		<td width="75%" class="indent">${am.leftUncasedHole}</td>
	</tr>
	<tr>
		<td width="25%" align="center">左眼矫正远视力值</td>
		<td width="75%" class="indent">${am.leftCorrect}</td>
	</tr>

	
	
	<tr>
		<td width="25%" align="center">右眼裸眼远视力值</td>
		<td width="75%" class="indent">${am.rightCorrect}</td>
	</tr>
		<!--
	<tr>
		<td width="25%" align="center">左眼矫正远视力值</td>
		<td width="75%" class="indent">${am.leftCorrect}</td>
	</tr>	
	<tr>
		<td width="25%" align="center">左眼矫正远视力值</td>
		<td width="75%" class="indent">${am.leftCorrect}</td>
	</tr>
<tr>
		<td width="25%" align="center">左眼矫正远视力值</td>
		<td width="75%" class="indent">${am.leftCorrect}</td>
	</tr>
</table><tr>
		<td width="25%" align="center">左眼矫正远视力值</td>
		<td width="75%" class="indent">${am.leftCorrect}</td>
	</tr><tr>
		<td width="25%" align="center">左眼矫正远视力值</td>
		<td width="75%" class="indent">${am.leftCorrect}</td>
	</tr><tr>
		<td width="25%" align="center">左眼矫正远视力值</td>
		<td width="75%" class="indent">${am.leftCorrect}</td>
	</tr><tr>
		<td width="25%" align="center">左眼矫正远视力值</td>
		<td width="75%" class="indent">${am.leftCorrect}</td>
	</tr><tr>
		<td width="25%" align="center">左眼矫正远视力值</td>
		<td width="75%" class="indent">${am.leftCorrect}</td>
	</tr><tr>
		<td width="25%" align="center">左眼矫正远视力值</td>
		<td width="75%" class="indent">${am.leftCorrect}</td>
	</tr><tr>
		<td width="25%" align="center">左眼矫正远视力值</td>
		<td width="75%" class="indent">${am.leftCorrect}</td>
	</tr><tr>
		<td width="25%" align="center">左眼矫正远视力值</td>
		<td width="75%" class="indent">${am.leftCorrect}</td>
	</tr><tr>
		<td width="25%" align="center">左眼矫正远视力值</td>
		<td width="75%" class="indent">${am.leftCorrect}</td>
	</tr><tr>
		<td width="25%" align="center">左眼矫正远视力值</td>h
		<td width="75%" class="indent">${am.leftCorrect}</td>
	</tr><tr>
		<td width="25%" align="center">左眼矫正远视力值</td>
		<td width="75%" class="indent">${am.leftCorrect}</td>
	</tr><tr>
		<td width="25%" align="center">左眼矫正远视力值</td>
		<td width="75%" class="indent">${am.leftCorrect}</td>
	</tr><tr>
		<td width="25%" align="center">左眼矫正远视力值</td>
		<td width="75%" class="indent">${am.leftCorrect}</td>
	</tr><tr>
		<td width="25%" align="center">左眼矫正远视力值</td>
		<td width="75%" class="indent">${am.leftCorrect}</td>
	</tr><tr>
		<td width="25%" align="center">左眼矫正远视力值</td>
		<td width="75%" class="indent">${am.leftCorrect}</td>
	</tr><tr>
		<td width="25%" align="center">左眼矫正远视力值</td>
		<td width="75%" class="indent">${am.leftCorrect}</td>
	</tr><tr>
		<td width="25%" align="center">左眼矫正远视力值</td>
		<td width="75%" class="indent">${am.leftCorrect}</td>
	</tr><tr>
		<td width="25%" align="center">左眼矫正远视力值</td>
		<td width="75%" class="indent">${am.leftCorrect}</td>
	</tr><tr>
		<td width="25%" align="center">左眼矫正远视力值</td>
		<td width="75%" class="indent">${am.leftCorrect}</td>
	</tr><tr>
		<td width="25%" align="center">左眼矫正远视力值</td>
		<td width="75%" class="indent">${am.leftCorrect}</td>
	</tr><tr>
		<td width="25%" align="center">左眼矫正远视力值</td>
		<td width="75%" class="indent">${am.leftCorrect}</td>
	</tr><tr>
		<td width="25%" align="center">左眼矫正远视力值</td>
		<td width="75%" class="indent">${am.leftCorrect}</td>
	</tr>
	  -->
</body>
</html>

