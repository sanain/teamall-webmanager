<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>网络医疗科室统计</title>
	<meta name="decorator" content="default"/>
	<%@include file="/WEB-INF/views/include/dialog.jsp" %>
	<script type="text/javascript" src="${ctxStatic}/front/js/layer/layer.js"></script> 
	<script type="text/javascript">
		$(document).ready(function() {
			
		});

		function clickHos2(hospitalId, hosname){
			top.$.jBox.open("iframe:${ctxsys}/netvisitif/netvisitifdata/doctorlist?hospitalId=" + hospitalId, hosname + " 网络医生详细信息",$(top.document).width()-220,$(top.document).height()-100,{
				buttons:{"确定":true}, loaded:function(h){
					$(".jbox-content", top.document).css("overflow-y","hidden");
				}
			});
		}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="#">${cityname} 网络医院统计</a></li>
	</ul>
	<div style="margin-bottom: 5px;">
		<label style="padding-left: 5px; font-weight: bold;">已开通医院合计：</label><span style="font-weight: bold;">${hossum}</span>
		<label style="padding-left: 25px; font-weight: bold;">已开通科室合计：</label><span style="font-weight: bold;">${depsum}</span>
		<label style="padding-left: 25px; font-weight: bold;">已开通医生合计：</label><span style="font-weight: bold;">${docsum}</span>
	</div>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead><tr><th>医院名称</th><th>已开通科室数量</th><th>已开通医生数量</th></tr></thead>
		<tbody>
		<c:forEach items="${datalist}" var="hos">
			<tr>
				<td>${hos.name}</td>
				<td align="center">${hos.allnum}</td>
				<td align="center"><a href="javascripte:;"  onclick="clickHos2(${hos.hospitalId}, '${hos.name}');"  >${hos.leavebeds}</a></td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
</body>
</html>