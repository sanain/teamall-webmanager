<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<meta name="decorator" content="default"/>
  <script type="text/javascript">
	    $(document).ready(function() {
	    
		});
	 	</script>
</head>
<body>
     <ul class="nav nav-tabs">
        <li ><a href="${ctxsys}/EbLabel/list">标签列表</a></li>
		<shiro:hasPermission name="merchandise:EbLabel:view">
		<li class="active"><a href="${ctxsys}/EbLabel/form">标签添加</a></li>
		</shiro:hasPermission>
	 </ul>
	 
	<tags:message content="${message}"/>
	<form:form id="inputForm"  modelAttribute="ebLabel" action="${ctxsys}/EbLabel/save"  method="post" class="form-horizontal">
			<form:hidden path="id"/>
				<div class="control-group">
					<label class="control-label">标签名称：</label>
					<div class="controls">
		            <form:input path="name" htmlEscape="false" maxlength="50" required="required"/>
		            <a>不能出现逗号</a>
					</div>
				</div>
			    <div class="control-group">
				  <label class="control-label">类型：</label>
					<div class="controls">
		             <form:select path="labelType">
		                <form:option value="1">商品</form:option>
		                <form:option value="2">文章</form:option>
		             </form:select>
					</div>
				</div>
		<div class="form-actions">
			<shiro:hasPermission name="merchandise:EbLabel:edit">
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="提交"/>&nbsp;
			</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>