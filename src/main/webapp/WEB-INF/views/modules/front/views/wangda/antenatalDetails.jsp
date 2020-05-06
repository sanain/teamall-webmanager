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

<h1>产检报告详情</h1>
<table cellspacing="0" cellpadding="0">
	<tr>
		<td width="25%" align="center">随访日期</td>
		<td width="75%" class="indent">${am.doctorTime}</td>
	</tr>
	<tr>
		<td width="25%" align="center">医生</td>
		<td width="75%" class="indent">${am.doctor}</td>
	</tr>
	<tr>
		<td width="25%" align="center">医院</td>
		<td width="75%" class="indent">${am.doctorAdrress}</td>
	</tr>
	<tr>
		<td width="25%" align="center">体重</td>
		<td width="75%" class="indent">${am.weight}</td>
	</tr>
	<tr>
		<td width="25%" align="center">收缩压/mmHg</td>
		<td width="75%" class="indent">${am.systolicPressurel}</td>
	</tr>
	<tr>
		<td width="25%" align="center">舒张压/mmHg</td>
		<td width="75%" class="indent">${am.diastolicPressure}</td>
	</tr>
	<tr>
		<td width="25%" align="center">怀孕周数</td>
		<td width="75%" class="indent">${am.pregnancyTime}</td>
	</tr>
	<tr>
		<td width="25%" align="center">宫底高度</td>
		<td width="75%" class="indent">${am.fundusHeight}</td>
	</tr>
	<tr>
		<td width="25%" align="center">腹围</td>
		<td width="75%" class="indent">${am.abdominal}</td>
	</tr>
	<tr>
		<td width="25%" align="center">胎方位代</td>
		<td width="75%" class="indent">${am.position}</td>
	</tr>
	<tr>
		<td width="25%" align="center">胎心</td>
		<td width="75%" class="indent">${am.fetal}</td>
	</tr>
	<tr>
		<td width="25%" align="center">B超结果描述</td>
		<td width="75%" class="indent">${am.bComplainOf}</td>
	</tr>
	<tr>
		<td width="25%" align="center">健康评估</td>
		<td width="75%" class="indent">${am.assessment}</td>
	</tr>
</body>
</html>

