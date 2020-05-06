<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>各市州网络医院统计</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			
		});

		function clickCity(cityid){
			
		}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="#">网络医院统计</a></li>
	</ul>
	<div style="margin-bottom: 5px;">
		<label style="font-weight: bold; padding-left: 5px;">已开通医院合计：</label><span style="font-weight: bold;">${hossum}</span>
	</div>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead><tr><th>区域</th><th>已开通网络医院数量</th></tr></thead>
		<tbody>
		<c:forEach items="${datalist}" var="city">
			<tr>
				<td>${city.city}</td>
				<td align="center">
    				<a href="${ctxsys}/netvisitif/netvisitifdata/cityhoslist?cityid=${city.cityid}"  target="hosListFrame" >${city.nethoscnt}</a>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
</body>
</html>