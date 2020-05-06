<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>用户导入</title>
	<%@include file="/WEB-INF/views/include/dialog.jsp" %>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
	
		$(document).ready(function() {
			$("#btnImport").click(function(){
				$.jBox($("#importBox").html(), {title:"导入数据", buttons:{"关闭":true},  
				   bottomText:"导入文件不能超过5M，仅允许导入“xls”或“xlsx”格式文件！"});
						
			});
		});
		function page(n,s){
			if(n) $("#pageNo").val(n);
			if(s) $("#pageSize").val(s);
			$("#searchForm").attr("action","${ctxsys}/user/userImport/list");
			$("#searchForm").submit();
	    	return false;
	    }
	    
	    /** type:  导入区分（1: 新农合用户导入  2：患者病历导入  3：患者姓名导入） */
	    function doImport(type) {
	    	$("#importType").val(type);
	    	var btntxt = "导入文件不能超过5M，仅允许导入“xls”或“xlsx”格式文件！";
	    	if (1 == type) {
	    	    btntxt =  btntxt + "</br>新农合用户导入: 手机号码 和 身份证号码 必须输入！";
	    	} else if (2 == type) {
	    	    btntxt =  btntxt + "</br>患者病历用户导入: 手机号码 和 身份证号码 必须输入！";
	    	} else if (3 == type) {
	    	    btntxt =  btntxt + "</br>患者姓名用户导入: 真实姓名 和 用户名 必须输入！";
	    	}
	    	$.jBox($("#importBox").html(), {title:"导入数据", buttons:{"关闭":true},  
				   bottomText: btntxt});
	    }
	</script>
</head>
<body>
	<div id="importBox" class="hide">
		<form id="importForm" action="${ctxsys}/user/userImport/import" method="post" enctype="multipart/form-data"
			class="form-search" style="padding-left:20px;text-align:center;" onsubmit="loading('正在导入，请稍等...');"><br/>
			<input id="importType" name="importType" type="hidden" />
			<input id="uploadFile" name="file" type="file" style="width:330px"/><br/><br/>　　
			<input id="btnImportSubmit" class="btn btn-primary" type="submit" value="   导    入   "/>
			<a href="${ctxwebsys}/user/import/template.xlsx" target="_blank">下载模板</a>
		</form>
	</div>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctxsys}/user/userImport/list">用户导入列表</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="userimporthis" action="${ctxsys}/user/userImport/list" method="post" class="breadcrumb form-search ">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		
	<%-- 	<c:set var="sysuser" value="${fns:getSysUser()}"/> --%>
		<ul class="ul-form">
		    <li><label>分类：</label><form:select id="importtype" path="importtype" class="input-small"><form:option value=""  label=""/><form:options items="${fns:getDictList('user_import_type')}"  itemLabel="label" itemValue="value" htmlEscape="false" /></form:select></li>
		    <li><label>处理结果：</label><form:select id="successflg" path="successflg" class="input-small"><form:option value=""  label=""/><form:options items="${fns:getDictList('userImportRsFlg')}"  itemLabel="label" itemValue="value" htmlEscape="false" /></form:select></li>
		    <li><label>导入时间：</label><form:input path="accessdate" htmlEscape="false" maxlength="10" class="Wdate input-small" onclick="WdatePicker({isShowClear:true,readOnly:true,dateFmt:'yyyy-MM-dd',skin:'whyGreen'})"/></li>
		    <li class="clearfix"></li>
		    <li><label>手机号：</label><form:input path="mphone" htmlEscape="false" maxlength="20" class="input-medium"/></li>
		    <li><label>身份证：</label><form:input path="pubid" htmlEscape="false" maxlength="50" class="input-medium"/></li>
		    
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/></li>
			<li class="clearfix"></li>
			<li class="btns">
				<input id="btnImport1" class="btn btn-primary" type="button" value="新农合用户导入" onclick="doImport(1);"/>
				<input id="btnImport2" class="btn btn-primary" type="button" value="患者病历用户导入" onclick="doImport(2);"/>
				<input id="btnImport3" class="btn btn-primary" type="button" value="患者姓名用户导入" onclick="doImport(3);"/>
			</li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<tags:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead><tr><th>分类</th><th>导入时间</th><th>手机号</th><th>身份证号</th><th>姓名</th><th>农合号</th><th>预设密码</th><th>预设用户名</th><th>导入结果</th><th>异常信息</th><shiro:hasPermission name="user:userImport:edit"><th>操作</th></shiro:hasPermission></tr></thead>
		<tbody>
		<c:forEach items="${page.list}" var="userimporthis">
			<tr>
				<td>${fns:getDictLabel(userimporthis.importtype, 'user_import_type', '')}</td>
				<td>${userimporthis.accessdate}</td>
				<td>${userimporthis.mphone}</td>
				<td>${userimporthis.pubid}</td>
				<td>${userimporthis.truename}</td>
				<td>${userimporthis.nhno}</td>
				<td>${userimporthis.pwd}</td>
				<td>${userimporthis.webname}</td>
				<td>${fns:getDictLabel(userimporthis.successflg, 'userImportRsFlg', '')}</td>
				<td>${userimporthis.errormsg}</td>
				<shiro:hasPermission name="user:userImport:edit"><td>
    				<a href="${ctxsys}/user/userImport/delete?id=${userimporthis.id}">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>