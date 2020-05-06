<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>医生管理</title>
	<meta name="decorator" content="default"/>
	<%@include file="/WEB-INF/views/include/treeview.jsp" %>
	<script type="text/javascript">
		$(document).ready(function(){
			$("#inputForm").validate({
				rules: {
					realname: "required",
					name: {required:true,maxlength:100,remote: "${ctxsys}/user/otherUser/checkName?oldName=" + encodeURIComponent("${otherUser.name}")},
					newPwd: {maxlength:"20",minlength:"3"},
					pwd: {equalTo:"#newPwd",maxlength:"20",minlength:"3"}
				},
				messages: {
					name: {remote: "用户名已存在，请修改"}
				},
				submitHandler: function(form){
					var treeObj = $.fn.zTree.getZTreeObj("hosTree");
					var ids = [], nodes = tree.getCheckedNodes(true);
					for(var i=0; i<nodes.length; i++) {
						if(nodes[i].id != 0){
							ids.push(nodes[i].id);
						}
					}
					$("#hospitalIds").val(ids);
					
					loading('正在提交，请稍等...');
					form.submit();
				}
			});
			var otherid = '${otherUser.otherid }';
			if(otherid==null || otherid=='') {
				$("#newPwd").addClass("required");
			}
			
			var setting = {
				check:{enable:true,nocheckInherit:true},
				view:{selectedMulti:false},
				data:{
					simpleData:{enable:true}
				},
				callback:{
					beforeClick:function(id, node){
						tree.checkNode(node, !node.checked, true, true);
						return false;
					}
				}
			};
			
			// 用户-菜单
			var zNodes=[
				<c:forEach items="${cityList}" var="city">
					{id:'0', name:'${city.city}'
						,children:[   
							<c:forEach items="${hospitalList}" var="hos">
								<c:if test="${city.cityid == hos.city}">
									{id:'${hos.hospitalId}', name:'${hos.name}'},
								</c:if>
					        </c:forEach> 
				      	]
				      },
	            </c:forEach>];
			// 初始化树结构
			var tree = $.fn.zTree.init($("#hosTree"), setting, zNodes);
			// 默认选择节点
			var ids = "${otherUser.hospitalIds}".split(",");
			for(var i=0; i<ids.length; i++) {
				var node = tree.getNodeByParam("id", ids[i]);
				try{tree.checkNode(node, true, false);}catch(e){}
			}
			// 默认展开全部节点
			tree.expandAll(false);
			
		});
		
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctxsys}/user/otherUser/list">第三方用户列表</a></li>
		<li class="active"><a href="${ctxsys}/user/otherUser/form?id=${otherUser.otherid}"><shiro:hasPermission name="sys:doctor:edit">${not empty otherUser.otherid?'修改':'添加'}</shiro:hasPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="otherUser" action="${ctxsys}/user/otherUser/saveOtherUser" method="post" class="form-horizontal">
		<form:hidden path="otherid" />
		<tags:message content="${message}"/>
		
		<div class="control-group">
			<label class="control-label">第三方名称:</label>
			<div class="controls">
				<form:input path="realname" htmlEscape="false"/><span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">用户名:</label>
			<div class="controls">
				<input type="hidden" name="oldName" value="${otherUser.name }" />
				<form:input path="name" htmlEscape="false"/><span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">密码:</label>
			<div class="controls">
				<input type="hidden" name="oldPwd" value="${otherUser.pwd }" />
				<input id="newPwd" name="newPwd" type="password" /><c:if test="${empty otherUser.otherid }"><span class="help-inline"><font color="red">*</font></c:if>
				<c:if test="${not empty otherUser.pwd}"><span class="help-inline">若不修改密码，请留空。</span></c:if>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">确认密码:</label>
			<div class="controls">
				<input id="pwd" name="pwd" type="password"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">账户是否存在异常:</label>
			<div class="controls">
				<input type="radio" name="state" value="0" <c:if test="${otherUser.state=='0' || empty otherUser.state }">checked="checked"</c:if>>正常</input>
				<input type="radio" name="state" value="1" <c:if test="${otherUser.state=='1' }">checked="checked"</c:if>>异常</input>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">是否开放:</label>
			<div class="controls">
				<input type="radio" name="isopen" value="0" <c:if test="${otherUser.isopen=='0' || empty otherUser.isopen }">checked="checked"</c:if>>开放</input>
				<input type="radio" name="isopen" value="1" <c:if test="${otherUser.isopen=='1' }">checked="checked"</c:if>>未开放</input>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">开通功能:</label>
			<div class="controls">
				<form:checkboxes path="functionList" items="${fns:getDictList('functionId')}" itemLabel="label" itemValue="value" htmlEscape="false" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">开通医院:</label>
			<div class="controls">
				<div id="hosTree" class="ztree" style="margin-top:3px;float:left;"></div>
				<form:hidden path="hospitalIds"/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="sys:doctor:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>