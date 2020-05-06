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

<h1>预防疫苗接种报告详情</h1>
<table cellspacing="0" cellpadding="0">
	<tr>
		<td width="30%" align="center">建卡日期</td>
		<td width="70%" class="indent">${am.buildCardDate}</td>
	</tr>
	<tr>
		<td width="30%" align="center">建卡医院名称</td>
		<td width="70%" class="indent">${am.buildCardOrgName}</td>
	</tr>
	<tr>
		<td width="30%" align="center">接种日期</td>
		<td width="70%" class="indent">${am.inoculationDate}</td>
	</tr>
	<tr>
		<td width="30%" align="center">接种剂次</td>
		<td width="70%" class="indent">${am.inoculationDose}</td>
	</tr>
	<tr>
		<td width="30%" align="center">接种部位</td>
		<td width="70%" class="indent">${am.inoculationPosition}</td>
	</tr>
	<tr>
		<td width="30%" align="center">接种医生名称</td>
		<td width="70%" class="indent">${am.inoculationDoctorName}</td>
	</tr>
	<tr>
		<td width="30%" align="center">疑似预防接种异常反应史描述</td>
		<td width="70%" class="indent">${am.inoculationAbnormalDescription}</td>
	</tr>
	<tr>
		<td width="30%" align="center">接种禁忌描述</td>
		<td width="70%" class="indent">${am.vaccinationTabooDescription}</td>
	</tr>
	<tr>
		<td width="30%" align="center">疫苗名称</td>
		<td width="70%" class="indent">${am.vaccineName}</td>
	</tr>
	<tr>
		<td width="30%" align="center">疑似预防接种异常反应的可疑疫苗名称</td>
		<td width="70%" class="indent">${am.inoculationAbnormalName}</td>
	</tr>
	<tr>
		<td width="30%" align="center">疑似预防接种异常反应发生日期</td>
		<td width="70%" class="indent">${am.inoculationAbnormalDate}</td>
	</tr>
	<tr>
		<td width="30%" align="center">疑似预防接种异常反应处理结果</td>
		<td width="70%" class="indent">${am.inoculationAbnormalResult}</td>
	</tr>
</body>
</html>

