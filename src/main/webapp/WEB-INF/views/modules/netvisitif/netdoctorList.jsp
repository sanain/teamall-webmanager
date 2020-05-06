<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<html>
<head>
	<title>开通网络医院医生</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		
		function page(n,s){
			if(n) $("#pageNo").val(n);
			if(s) $("#pageSize").val(s);
			$("#searchForm").attr("action","${ctxsys}/netvisitif/netvisitifdata/doctorlist");
			$("#searchForm").submit();
	    	return false;
	    }
		var hospitalId = '${doctor.hospitalId}';
		function hospitalTreeselectCallBack() {
			if(hospitalId != $("#hospitalId").val()) {
				hospitalId = $("#hospitalId").val();
				//修改departmenturl值
				var departmenturl = $("#departmenturl").val();
				$("#departmenturl").val(departmenturl.substring(0,departmenturl.lastIndexOf('=')+1) + hospitalId);
				//清空department值
				$("#departmentId").val('');
				$("#departmentName").val('');
			}
		}
	</script>
</head>
<body>
	
	<form:form id="searchForm" modelAttribute="doctor" action="${ctxsys}/netvisitif/netvisitifdata/doctorlist" method="post" class="breadcrumb form-search ">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<input id="hospitalId" name="hospitalId" type="hidden" value="${doctor.hospitalId}"/>
	</form:form>
	<tags:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead><tr><th >医院</th><th >科室</th><th>医生</th><th >医生职称</th><th >已开通病种</th><th >电话</th><th >照片</th></tr></thead>
		<tbody>
		<c:forEach items="${page.list}" var="doctor">
			<tr>
				<td>${doctor.hospitalname}</td>
				<td>${doctor.departmentname}</td>
				<td>${doctor.name}</td>
				<td>${doctor.job }</td>
				<td>${doctor.doctorDiseaseIds }</td>
				<td>${doctor.doctorphone }</td>
				<td><c:if test="${!empty doctor.photourl}"><img width="100px" height="60px" src="${doctor.photourl}"/></c:if></td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>