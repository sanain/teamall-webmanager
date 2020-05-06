<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>菜单管理</title>
	<meta name="decorator" content="default"/>
	<%@include file="/WEB-INF/views/include/treetable.jsp" %>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#btnSubmit").click(function(){
				$("#inputForm").submit();
			});
		var f="${refresh}";
		if(f==1){
	    	var frame = window.parent.document.getElementById("left"); 
		    var path = frame.getAttribute("src"); 
		        frame.setAttribute("src", path); 
		}
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
	function del(id){
		return confirmx('确认要删除吗？', "${ctxsys}/ebArticleType/delete?id="+ id+"");
	}	
	</script>
</head>
<body style="height: 100%">
	 <ul class="nav nav-tabs">
		<li class="active"><a><shiro:hasPermission name="merchandise:ebArticleType:edit">${not empty ebArticleType.parentId?'修改当前':'添加下一级'}</shiro:hasPermission>分类</a></li>
	</ul><br/> 
	<form:form id="inputForm" modelAttribute="ebArticleType" action="${ctxsys}/ebArticleType/save" method="post" class="form-horizontal">
		<form:hidden path="articleTypeId"/>
		<tags:message content="${message}"/>
		<div class="control-group">
			<label class="control-label">上级菜单:</label>
			<div class="controls">
                <tags:treeselect id="menu" name="parentId" value="${ebArticleType.parentId}" labelName="" labelValue="${ebArticleType.parentArticleTypeName}"
					title="菜单" url="${ctxsys}/ebArticleType/treeData" extId="" cssClass="required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="name">文章标题 :</label>
			<div class="controls">
				<form:input path="articleTypeName" htmlEscape="false" maxlength="50" class="required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="name">类别图片:</label>
			<div class="controls">
			<form:hidden path="imageUrl" htmlEscape="false" maxlength="100"  class="input-xlarge"/>
				<span class="help-inline" id="imageUrl"  style="color: blue;"></span>
				<tags:ckfinder input="imageUrl" type="images" uploadPath="/merchandise/article"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="typeIntroduction">类别简介:</label>
			<div class="controls">
				<form:textarea path="typeIntroduction" htmlEscape="false" maxlength="250" />
			</div>
		</div>
		 <c:if test="${ebArticleType.articleTypeCode=='gxjlpt'}">
		<div class="control-group">
			<label class="control-label" for="isShow">所属地区:</label>
			  <div class="controls">
				<form:radiobutton path="area" value="1" required="required" />珠三角地区<form:radiobutton path="area" value="2"/>粤东地区<form:radiobutton path="area" value="3"/>粤西地区<form:radiobutton path="area" value="4"/>粤北地区
			  </div>
		 </div>
		 </c:if>
		  <c:if test="${ebArticleType.articleTypeCode=='syzdydhl'}">
		<div class="control-group">
			<label class="control-label" for="isShow">超链接:</label>
			  <div class="controls">
				<form:input path="articleUrl" htmlEscape="false" maxlength="200" class="required"/>
			  </div>
		 </div>
		 </c:if>
		<div class="control-group">
			<label class="control-label" for="isShow">备注:</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" maxlength="250" />
			</div>
		</div>
		<div class="form-actions">
		        <shiro:hasPermission name="merchandise:ebArticleType:edit">
					<input id="btnSubmit" class="btn btn-primary" type="submit"  value="保 存"/>&nbsp;
				</shiro:hasPermission>
			    <c:if test="${not empty ebArticleType.parentId}">
			    	<input id="btnCancel" class="btn" type="button" value="删除" onclick="del(${ebArticleType.articleTypeId})"/>
			    </c:if>
			    <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>