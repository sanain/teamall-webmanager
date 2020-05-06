<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>过滤列表</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		function page(n,s){
			if(n)$("#pageNo").val(n);
			if(s)$("#pageSize").val(s);
			$("#searchForm").attr("action","${ctxsys}/PmSensitiveWordsFilter");
			$("#searchForm").submit();
	    	return false;
	    }
	 var fileId;
	 function eStatus(){
	    $.ajax({
			type: "POST",
			url: "${ctxsys}/PmSensitiveWordsFilter/guolv",
			data: {id:fileId},
			success: function(data){
			 alertx('操作成功');
			 page();
		    }
	      });
	  }
	  function editfStatus(fid){
		  fileId=fid;
		    var msg="是否手动过滤改数据";
			confirmx(msg,eStatus);
		}
	 
	 
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctxsys}/PmSensitiveWordsFilter">过滤列表</a></li>
	</ul>
	 <form:form id="searchForm" modelAttribute="pmSensitiveWordsFilter" action="${ctxsys}/PmSensitiveWordsFilter" method="post" class="breadcrumb form-search ">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
		<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
			<ul class="ul-form">
		    <li><label>创建人:</label>
		       <form:input path="createUser" htmlEscape="false" maxlength="80" class="input-medium"  placeholder="请输入创建人"/></li>
		    <li><label>状态:</label>
		        <form:select path="filterStatus"><form:option value="">全部</form:option><form:option value="1">待过滤</form:option><form:option value="2">已过滤</form:option><form:option value="3">过滤失败</form:option></form:select></li>
		    <li style="margin-left:10px"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/></li>
		</ul>
	</form:form> 
	<tags:message content="${message}"/>
	<table id="treeTable" class="table table-striped table-condensed table-bordered" >
		<tr>
		 <th class="center123">编号</th>
		 <th class="center123">类型</th>
		 <th class="center123">文章评论/商品评论、商品名称</th>
		 <th class="center123">状态</th>
		 <th class="center123">创建人</th>
		 <th class="center123 sort-column createTime">创建时间</th>
		 <th class="center123">最后修改人</th>
		 <th class="sort-column modifyTime center123">最后修改时间</th>
		 <shiro:hasPermission name="merchandise:PmSensitiveWordsFilter:edit">
		 <th class="center123">操作</th>
		 </shiro:hasPermission></tr>
		  <c:forEach items="${page.list}" var="PmSensitiveWordsFilterList" varStatus="status">
			<tr>
			    <td class="center123">${status.index+1}</td>
				<td class="center123">
				<c:if test="${PmSensitiveWordsFilterList.filterObjType==1}">
				商品
				</c:if>
				<c:if test="${PmSensitiveWordsFilterList.filterObjType==2}">
				商品评论
				</c:if>
				<c:if test="${PmSensitiveWordsFilterList.filterObjType==3}">
				文章评论
				</c:if>
				</td>
			    <td class="center123">
				<c:if test="${PmSensitiveWordsFilterList.filterObjType==1}">
				${PmSensitiveWordsFilterList.ebProduct.productName}
				</c:if>
				<c:if test="${PmSensitiveWordsFilterList.filterObjType==2}">
				${PmSensitiveWordsFilterList.ebProductcomment.productname}
				</c:if>
				<c:if test="${PmSensitiveWordsFilterList.filterObjType==3}">
				${PmSensitiveWordsFilterList.ebDiscuss.userName}
				</c:if>
				</td>
				
				<td class="center123">
				<c:if test="${PmSensitiveWordsFilterList.filterStatus==1}">待过滤</c:if>
				<c:if test="${PmSensitiveWordsFilterList.filterStatus==2}">已过滤</c:if>
				<c:if test="${PmSensitiveWordsFilterList.filterStatus==3}">过滤失败</c:if>
				</td>
				<td class="center123">${PmSensitiveWordsFilterList.createUser}</td>
				<td class="center123">${PmSensitiveWordsFilterList.createTime}</td>
				<td class="center123">${PmSensitiveWordsFilterList.modifyUser}</td>
				<td class="center123">${PmSensitiveWordsFilterList.modifyTime}</td>
			   <shiro:hasPermission name="merchandise:PmSensitiveWordsFilter:edit">
			    <td class="center123">
			    <c:if test="${PmSensitiveWordsFilterList.filterStatus==1}">
			    <a  onclick="editfStatus('${PmSensitiveWordsFilterList.id}')">过滤</a>
			     </c:if>
				</td>
				</shiro:hasPermission>
			</tr>
		</c:forEach>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>