<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<meta name="decorator" content="default"/>
	<link href="${ctxStatic}/jquery-ztree/3.5.12/css/zTreeStyle/zTreeStyle1.min.css" rel="stylesheet" type="text/css"/>
	<script src="${ctxStatic}/jquery-ztree/3.5.12/js/jquery.ztree.core-3.5.min.js" type="text/javascript"></script>
	<script src="${ctxStatic}/jquery-ztree/3.5.12/js/jquery.ztree.excheck-3.5.min.js" type="text/javascript"></script>
	<script src="${ctxStatic}/jquery-ztree/3.5.12/js/jquery.ztree.exhide-3.5.min.js" type="text/javascript"></script>
	<link href="${ctxStatic}/jquery-jbox/2.3/Skins/Default/jbox.css" type="text/css" rel="stylesheet" />
	 <script src="${ctxStatic}/jquery-jbox/2.3/jquery.jBox-2.3.js" type="text/javascript"></script>
	<link rel="stylesheet" href="${ctxStatic}/sbShop/css/build.css">
	<script type="text/javascript">
	function page(n,s){
		if(n) $("#pageNo").val(n);
		if(s) $("#pageSize").val(s);
		$("#searchForm").attr("action","${ctxsys}/warehouse/list");
		$("#searchForm").submit();
		return false;
	}
	
	
	function hideWarehouse(id,status,obj){
		$.ajax({
			type:"get",
			url:"${ctxsys}/warehouse/hideWarehouse",
			data:{id:id,status:status},
			success:function(data){
				if(data.code=="00"){
					 $.jBox.tip('操作成功。', 'success'); 
					if(status==1){ /** 1表示隐藏 0或null表示显示**/
    					$(obj).attr("onclick","hideWarehouse("+data.warehouse.id+",0,this)");
    					$(obj).text("显示");  
    					$(obj).prev("span").html("隐藏 | ");
	      	        	  
    				}
    				if(status==0){
    					$(obj).attr("onclick","hideWarehouse("+data.warehouse.id+",1,this)");
    					$(obj).text("隐藏");
    					$(obj).prev("span").html("显示 | ");
    				}
				}
			},error:function(data){
				alert("操作失败");
			}
		});
		
	}
	
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctxsys}/warehouse/list">仓库列表</a></li>
		<li><a href="${ctxsys}/warehouse/form">仓库添加</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="warehouse" action="${ctxsys}/warehouse/list" method="post" class="breadcrumb form-search ">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form">
			  <li><label>仓库编码：</label><form:input path="wareNo" htmlEscape="false" maxlength="50" class="input-medium"/></li> 
			  <li><label>仓库名称：</label><form:input path="wareName" htmlEscape="false" maxlength="50" class="input-medium"/></li> 
			<li class="btns">
			 <input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/>
			<!--   <input id="btnDel" class="btn btn-primary" type="button" onclick="deleteIds()" value="删除" />-->
			</li>
			
		</ul>
	</form:form>
	<tags:message content="${message}"/>
	<table  class="table table-striped table-condensed table-bordered" >
	    <th>编号</th>
		<th>仓库编码</th>
		<th>仓库名称</th>
		<th>对应部门编码</th>
		<th>对应部门名称</th>
		 <shiro:hasPermission name="merchandise:Warehouse:edit">
		<th>状态</th>
		 </shiro:hasPermission>
		<th>备注</th>
		<shiro:hasPermission name="merchandise:Warehouse:edit">
		<th>操作</th></shiro:hasPermission>
	
		</tr>
		<c:forEach items="${page.list}" var="warehouse" varStatus="status">
			<tr>
			    <td>${status.index+1}</td>
				<td>${warehouse.wareNo}</td>
				<td>${warehouse.wareName}</td>
				<td>${warehouse.organizationNo}</td>
				<td>${warehouse.organizationName}</td>
			 <shiro:hasPermission name="merchandise:Warehouse:edit">
				<td>
				<c:choose>
				<c:when test="${empty warehouse.status || warehouse.status==0}">
				<span>显示 | </span><a href="javascript:;" onclick="hideWarehouse(${warehouse.id},1,this)">隐藏</a>
				</c:when>
				<c:otherwise>
				<span>隐藏 | </span><a href="javascript:;" onclick="hideWarehouse(${warehouse.id},0,this)">显示</a>
				</c:otherwise>
				</c:choose>
				</td>
				 </shiro:hasPermission>
				<td>${warehouse.remarks}</td>
			   <shiro:hasPermission name="merchandise:Warehouse:edit"><td>
					<a href="${ctxsys}/warehouse/form?id=${warehouse.id}">修改</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>