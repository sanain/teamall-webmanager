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

<h1>检查检验报告详情</h1>
<table cellspacing="0" cellpadding="0">
	<tr>
		<td width="25%" align="center">ABO血型</td>
		<td width="75%" class="indent">${am.aboType}</td>
	</tr>
	<tr>
		<td width="25%" align="center">Rh血型</td>
		<td width="75%" class="indent">${am.rhType}</td>
	</tr>
	<tr>
		<td width="25%" align="center">检查检验类别</td>
		<td width="75%" class="indent">${am.checkCategorie}</td>
	</tr>
	<tr>
		<td width="25%" align="center">项目名称</td>
		<td width="75%" class="indent">${am.checkItemName}</td>
	</tr>
	<tr>
		<td width="25%" align="center">项目描述</td>
		<td width="75%" class="indent">${am.checkItemDescription}</td>
	</tr>
	<tr>
		<td width="25%" align="center">项目代码</td>
		<td width="75%" class="indent">${am.checkProjectCode}</td>
	</tr>
	<tr>
		<td width="25%" align="center">结果代码</td>
		<td width="75%" class="indent">${am.checkResultCode	}</td>
	</tr>
</body>
</html>

