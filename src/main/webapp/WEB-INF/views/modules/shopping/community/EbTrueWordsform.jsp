<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>真心话管理</title>
	<meta name="decorator" content="default"/>
	<%-- <%@include file="/WEB-INF/views/include/treetable.jsp" %> --%>
	<script type="text/javascript">
	function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").attr("action","${ctxsys}/TrueWords/form");
			$("#searchForm").submit();
	    	return false;
	    }
	    $("#treeTable").treeTable({expandLevel : 5});
		$(document).ready(function() {
			$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});
		});
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctxsys}/TrueWords/list">真心话列表</a></li>
		<shiro:hasPermission name="merchandise:truewords:edit"><li class="active"><a href="${ctxsys}/TrueWords/form?id=${ebTruewords.id}">真心话添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="inputForm" modelAttribute="ebTruewords" action="${ctxsys}/TrueWords/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<tags:message content="${message}"/>
		<table id="treeTable" class="table table-striped " style=" width:46%; margin-right:30px; float: left;">
			<tr >
			    <td colspan="2" style="text-align: center;"><h5>真心话详情</h5></td>
			</tr>
			<tr>
			    <td>发帖人:</td>
			</tr>
			<tr>
			    <td>帖子内容</td>
				<td><form:textarea path="sincereContent" id="sincereContent" style=" width:53%;resize: none;height: 100px;"/></td>
			</tr>
		   <tr>
			    <td>类别</td>
				<td> <tags:treeselect id="menu2" name="sincereCategoryid" value="${ebTruewords.sincereCategoryid}" labelName="sincereCategoryname" labelValue="${ebTruewords.sincereCategoryname}"
					title="菜单" url="${ctxsys}/EbProCategory/treeData" extId="" /></td>
			</tr>
			  <tr>
			    <td>发帖时间</td>
				<td><input class="small"  name="time" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" value="<fmt:formatDate value='${ebTruewords.time}' type='date' pattern='yyyy-MM-dd HH:mm:ss'/>" >  
			</td>
			</tr>
			<tr>
			    <td>悬赏金额</td>
				<td><form:input path="rewards"/></td>
			</tr>
			<tr>
			    <td>提问状态</td>
				<td><form:select path="state"><form:option value="1">完成</form:option><form:option value="2">未完成</form:option><form:option value="3">(app隐藏)</form:option></form:select></td>
			</tr>
			<tr>
			    <td>置顶</td>
				<td><form:radiobutton path="isStickied" value="0"/>否<form:radiobutton path="isStickied" value="1"/>是</td>
			</tr>
			<%-- <tr>
			    <td>图片:</td>
				<td><c:forEach items="${ebProductimage}" var="ebProductimageList"><img width="70px;" height="50px;" src="${ebProductimageList.name}"/></c:forEach></td>
			</tr> --%>
			<tr>
			    <td></td>
				<td><shiro:hasPermission name="merchandise:truewords:edit">
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;
			</shiro:hasPermission><input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/></td>
			</tr>
	</table>
	</form:form>
	 <form:form id="searchForm" modelAttribute="ebTruewords"  action="${ctxsys}/TrueWords/form" method="post" class="">
		<form:hidden path="id"/>
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
		<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
	
	<table id="treeTable" class="table table-striped" style="width:46%; float: left;">
		     <tr>
			    <td colspan="5" style="text-align: center;"><h5>回复列表</h5></td>
			</tr>
		<tr><th></span><span>编号</span></th><th>用户</th><th>回帖内容</th><th>是否最佳</th><shiro:hasPermission name="merchandise:truewords:edit"><th>操作</th></shiro:hasPermission></tr>
			<c:forEach var="ebRestorelist" items="${page.list}">
			<tr>
			    <td>${ebRestorelist.id}</td>
				<td>${ebRestorelist.ebUser.username}</td>
				<td><audio src="${ebRestorelist.content}" controls="controls" style=" width:20px; height: 20px; padding-top:10px;"></audio></td>
				<td><c:if test="${ebRestorelist.stick==0}">否</c:if><c:if test="${ebRestorelist.stick==1}">是</c:if></td>
				<td><a href="${ctxsys}/EbRestore/form?id=${ebRestorelist.id}">查看</a> <a href="${ctxsys}/EbRestore/delete?id=${ebRestorelist.id}">删除</a></td>
			</tr>
			</c:forEach>
			<tr><td colspan="4"><div class="pagination">${page}</div></td></tr>	
	</table>

	</form:form>
</body>
</html>