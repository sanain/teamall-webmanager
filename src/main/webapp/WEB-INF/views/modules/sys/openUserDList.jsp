<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>合伙人选择页面</title>
	 <meta name="decorator" content="default"/>
	<script type="text/javascript">
		function page(n,s){
			if(n) $("#pageNo").val(n);
			if(s) $("#pageSize").val(s);
			$("#searchForm").attr("action","${ctxsys}/sys/user/openDaililist");
			$("#searchForm").submit();
	    	return false;
	    }
		    function loke(id,sysname,syslname,xagentId){
		       window.opener.document.getElementById('sysId').value=id;
		       window.opener.document.getElementById('sysloginName').innerHTML=sysname;
		       window.opener.document.getElementById('sysname').innerHTML=syslname;
		       window.opener.document.getElementById('xagentId').value=xagentId;
		       window.opener.document.getElementById('btu').innerHTML="<span id='bent' onclick='bent()'   class='btn btn-primary'>保存</span>";
		       window.open("about:blank","_self").close();
		     }
    </script>
</head>
     <body>
        <div class="ibox-content">
				<ul class="nav nav-tabs">
					<li class="active"><a href="">银牌用户列表</a></li>
				</ul>
					<form:form id="searchForm"  modelAttribute="user" action="${ctxsys}/sys/user/list1" method="post" class="breadcrumb form-search ">
						<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
						<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
						<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
					<div class="p-xs">
						<ul class="ul-form">
							<li><label>合伙人编码：</label><form:input path="agentCode" htmlEscape="false" maxlength="50" class="input-medium"/></li>
							<li><label>合伙人名称：</label><form:input path="agentName" htmlEscape="false" maxlength="50" class="input-medium"/></li>
							<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/>
							</li>
						</ul>
					</div>
					</form:form>
	                 <tags:message content="${message}"/>
                        <table class="table table-striped table-bordered table-hover dataTables-example" >
                           	<thead><tr><th>合伙人编码</th><th>合伙人名称</th><th class="sort-column loginName">合伙人级别</th><th class="sort-column name">绑定用户手机号</th><th>绑定用户名称</th><shiro:hasPermission name="sys:user:edit"><th>操作</th></shiro:hasPermission></tr></thead>
                            <tbody>
                            <c:forEach items="${page.list}" var="user">
								<tr class="gradeX">
									<td>${user.agentCode}</td>
									<td>${user.agentName}</td>
									<td><c:if test="${user.agentType}==1">钻石合伙人</c:if>
									<c:if test="${user.agentType}==2">金牌合伙人</c:if>
									<c:if test="${user.agentType}==3">银牌合伙人</c:if>
									
									</td>
									<td>${user.user.mobile}</td>
									<td>${user.user.username}</td>
									<td><a onclick="loke('${user.agentId}','${user.agentName}','${user.user.mobile}','${user.agentId}')">选择</a></td>
								</tr>
							</c:forEach>
                            </tbody>
                        </table>
                        <div class="pagination">${page}</div>
                        </div>
</body>
</html>