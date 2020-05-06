<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>真心话列表</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").attr("action","${ctxsys}/TrueWords/list");
			$("#searchForm").submit();
	    	return false;
	    }
		 function  radios(id,val){
		 $.ajax({
		    url: '${ctxsys}/TrueWords/ralue',
		    type: 'POST',
		    cache: false,
		    data: {"id":id,"val":val},
		     success: function (data){//上传成功
			     if(data=="00"){
			     if(val=="1"){
			     $("#"+id+"_0").removeAttr('checked');
			     }
			     if(val=="0"){
			     $("#"+id+"_1").removeAttr('checked');
			     }
			     }
                }
             });
		 }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctxsys}/TrueWords/list">真心话列表</a></li>
		<%-- <shiro:hasPermission name="merchandise:truewords:edit"><li><a href="${ctxsys}/TrueWords/form">真心话添加</a></li></shiro:hasPermission> --%>
	</ul>
	<form:form id="searchForm" modelAttribute="ebTruewords" action="${ctxsys}/TrueWords/list" method="post" class="breadcrumb form-search ">
		
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form">
		<li><form:input path="sincereContent" placeholder="请输入内容" htmlEscape="false" maxlength="100"/></li>
		<li><form:select path="state">
		     <form:option value="">请选择</form:option>
		      <form:option value="1">完成</form:option>
		      <form:option value="2">未完成</form:option>
		       <form:option value="3">(app隐藏)</form:option>
		</form:select></li>
		<li><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/></li>
		</ul>
	</form:form>
	<tags:message content="${message}"/>
	<table id="treeTable" class="table table-striped table-condensed">
		<tr><th></span><span>编号</span></th><th>真心话内容</th><th class="sort-column time">时间</th><th>悬赏金额</th><th>状态</th><th>是否首页显示</th><shiro:hasPermission name="merchandise:truewords:edit"><th>操作</th></shiro:hasPermission></tr>
		<c:forEach items="${page.list}" var="EbTruewordsList" varStatus="status">
			<tr>
			    <td> ${status.index+1}</td>
				<td>
				<c:choose>
			    <c:when test="${fn:length(EbTruewordsList.sincereContent) >= 10}">
			       ${fn:substring(EbTruewordsList.sincereContent,0,10)}……
			     </c:when>
			     <c:otherwise> 
			       ${EbTruewordsList.sincereContent}
			     </c:otherwise>
			 </c:choose>
				</td>
				<td>${EbTruewordsList.time}</td>
				<td>${EbTruewordsList.rewards}</td>
				<td><c:if test="${EbTruewordsList.state==1}">完成</c:if><c:if test="${EbTruewordsList.state==2}">未完成</c:if><c:if test="${EbTruewordsList.state==3}">(app隐藏)</c:if></td>
			   <%-- --%>
			    <td><input type="radio" value="0" id="${EbTruewordsList.id}_0" onclick="radios(${EbTruewordsList.id},0)" <c:if test="${EbTruewordsList.isStickied==0}">checked="checked"</c:if>/>否  <input type="radio" id="${EbTruewordsList.id}_1" value="1" onclick="radios(${EbTruewordsList.id},1)" <c:if test="${EbTruewordsList.isStickied==1}">checked="checked"</c:if>/>是 </td>
			   <shiro:hasPermission name="merchandise:truewords:edit"><td>
					<a href="${ctxsys}/TrueWords/form?id=${EbTruewordsList.id}">修改</a>
					<a href="${ctxsys}/TrueWords/delete?id=${EbTruewordsList.id}" onclick="return confirmx('要删除该区域及所有子区域项吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>