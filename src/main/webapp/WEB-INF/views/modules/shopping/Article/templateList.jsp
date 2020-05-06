<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>商品列表</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").attr("action","${ctxsys}/template");
			$("#searchForm").submit();
	    	return false;
	    }
	 
	</script>
	<style>
        .list-ul{
            width: 42%;
            float: left;
            list-style: none;
            padding: 0;
            border: 1px solid #69AC72;
            box-sizing: border-box;
            margin:30px;
        }
        .list-ul li:nth-child(1){padding-left: 20px}
        .list-ul li:nth-child(2){padding-left: 20px}
        .list-ul li:nth-child(3) img{width: 100%}
    </style>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctxsys}/template">广告模板列表</a></li>
		 <li ><a href="${ctxsys}/template/form">广告模板<shiro:hasPermission name="merchandise:template:edit">${not empty ebProductimage.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="merchandise:template:edit">查看</shiro:lacksPermission></a></li>
 	</ul>
	 <form:form id="searchForm" modelAttribute="ebLayouttype" action="${ctxsys}/template" method="post" class="breadcrumb form-search ">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
		<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form">
		    <li><label>关键词:</label><form:input path="moduleTitle" htmlEscape="false" maxlength="80" class="input-medium"  placeholder=""/></li>
		    <li><label>对应业务:</label>
			     <form:select path="objAdModule">  
		            <form:option value="" label="全部"/>  
		            <form:options items="${fns:getDictList('layouttype')}" itemValue="value" itemLabel="label"/>  
	            </form:select>  
		    </li>
		    <li><label>状态:</label>
		       <form:select path="status"  class="input-medium">
		          <form:option value="">全部</form:option>
				  <form:option value="1">开启</form:option>
				  <form:option value="2">关闭</form:option>
				</form:select>
		    </li>
		    <li><label>类型:</label>
		      <form:select path="type"  class="input-medium">
		      <form:option value="">全部</form:option>
				  <form:option value="1">app</form:option>
				  <form:option value="2">h5</form:option>
				  <form:option value="3">pc</form:option>
				</form:select>
		    </li>
		    <li><label>模板类型:</label>
			    <form:select path="moduleType">  
		            <form:option value="" label="全部"/>  
		            <form:options items="${fns:getDictList('caType')}" itemValue="value" itemLabel="label"/>  
	            </form:select>  
		    </li>
		    <li><label></label><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/></li>
		</ul>
	</form:form> 
	<tags:message content="${message}"/>
	
	<table id="treeTable" class="table table-striped table-condensed table-bordered" >
		<tr>
		 <th class="center123">编号</th>
		 <th class="center123">模板标题</th>
		 <th class="center123">模板类型</th>
		 <th class="center123">类型</th>
		 <th class="center123">模板样例图</th>
		 <th class="center123">对应业务</th>
		 <th class="center123 sort-column objectId">排序</th>
		 <th class="center123 ">状态</th>
		  <shiro:hasPermission name="merchandise:template:edit">
		 <th class="center123">操作</th>
		  </shiro:hasPermission></tr>
		<c:forEach items="${page.list}" var="ebLayouttypeList" varStatus="status">
			<tr>
			    <td class="center123">${status.index+1}</td>
				<td class="center123"><a href="${ctxsys}/template/form?id=${ebLayouttypeList.id}">${ebLayouttypeList.moduleTitle}</a></td>
				<td class="center123">${fns:getDictLabel(ebLayouttypeList.moduleType,'caType','')}</td>
				<td class="center123"><c:if test="${ebLayouttypeList.type==1}">APP广告</c:if><c:if test="${ebLayouttypeList.type==2}">h5</c:if><c:if test="${ebLayouttypeList.type==3}">pc</c:if></td>
				<td class="center123"><img src="${ebLayouttypeList.moduleDemoUrl}" style="width: 50px;height:40px;" alt=""></td>
			    <td class="center123">${fns:getDictLabel(ebLayouttypeList.objAdModule,'layouttype','')}</td>
			    <td class="center123">${ebLayouttypeList.objectId}</td>
			    <td class="center123">
			     <c:if test="${ebLayouttypeList.status==1}">开启</c:if><c:if test="${ebLayouttypeList.status==2}">关闭</c:if>
			     </td>
			    <shiro:hasPermission name="merchandise:template:edit">
			    <td class="center123">
					<a href="${ctxsys}/template/form?id=${ebLayouttypeList.id}">修改</a>
					<a href="${ctxsys}/template/delete?id=${ebLayouttypeList.id}" onclick="return confirmx('要删除该区域及所有子区域项吗？', this.href)">删除</a>
					<a href="${ctxsys}/EbAdvertise/list?layouttypeId=${ebLayouttypeList.id}" >管理该模板</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
	</table>
	
	
	
	  <%-- <div style="overflow: hidden;width: 106%">
	  <c:forEach items="${page.list}" var="ebLayouttypeList" varStatus="status">
	        <ul class="list-ul">
	            <li><a style="color: #69AC72;">${status.index+1}丶${ebLayouttypeList.moduleTitle} 模板类型:<c:if test="${ebLayouttypeList.type==0}">APP广告</c:if><c:if test="${ebLayouttypeList.type==1}">h5</c:if></a></li>
	            <li><a style="color: #69AC72;">状态:<c:if test="${ebLayouttypeList.status==1}">开启</c:if><c:if test="${ebLayouttypeList.status==2}">关闭</c:if> 对应业务广告模板:<c:if test="${ebLayouttypeList.objAdModule==1}">线上商城（天猫）</c:if><c:if test="${ebLayouttypeList.objAdModule==2}">线下门店（美团/附近）</c:if><c:if test="${ebLayouttypeList.objAdModule==3}">善于发现（什么值得买）</c:if><c:if test="${ebLayouttypeList.objAdModule==4}">御可贡茶商学院</c:if></a></li>
	            <li><img src="${ebLayouttypeList.moduleDemoUrl}" alt=""></li>
	        </ul>
	  </c:forEach>
	  </div> --%>
	<div class="pagination">${page}</div>
</body>
</html>