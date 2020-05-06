<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>菜单管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
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
	<script>
	$(function(){
			$('body').on('click','.elect-show',function(){
                window.open('${ctxsys}/Product/list?stule=99','newwindow','height=500,width=800,top=100,left=300,toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no') ;
            });
	})
	    
	 </script>
</head>
<body style="height: 100%">
	 <ul class="nav nav-tabs">
	 <li ><a href="${ctxsys}/ebArticle/list?articleTypeId=${ebArticle.articleTypeId}">文章列表</a></li>
	 <li class="active"><a >文章<shiro:hasPermission name="merchandise:PmProductTypeSpertAttr:view">${not empty ebArticle.articleId?'修改':'添加'}
	 </shiro:hasPermission></a></li>
	</ul><br/> 
	<input id="price" type="hidden">
	<form:form id="inputForm" modelAttribute="ebArticle" action="${ctxsys}/ebArticle/save" method="post" class="form-horizontal">
		<form:hidden path="articleId"/>
		<tags:message content="${message}"/>
		<%--<div class="control-group">
			<label class="control-label" for="name">类别名称:</label>
			<form:hidden path="articleTypeId"/>
			<div class="controls">
				<input  readonly="true" class="required" value="${fns:getEbArticleTypeName(ebArticle.articleTypeId).articleTypeName}"  class="input-xlarge"/>
			</div>
		</div>
		--%><div class="control-group">
			<label class="control-label">类别名称:</label>
			<div class="controls">
                <tags:treeselect id="menu" name="articleTypeId" value="${ebArticle.articleTypeId}" labelName="" labelValue="${fns:getEbArticleTypeName(ebArticle.articleTypeId).articleTypeName}"
					title="菜单" url="${ctxsys}/ebArticleType/treeData" extId="" cssClass="required"/>
			</div>
		</div>
		
		
		<div class="control-group">
			<label class="control-label" for="isShow">标题:</label>
			  <div class="controls">
				 <form:input path="articleTitle" htmlEscape="false" maxlength="50" class="required "/>
			  </div>
		 </div>
		 
		<div class="control-group">
			<label class="control-label" for="isShow">作者姓名:</label>
			  <div class="controls">
				 <form:input path="articleAuthor" htmlEscape="false" maxlength="50" class="required "/>
			  </div>
		 </div>
		<%--<div class="control-group">
			<label class="control-label" for="isShow">浏览数:</label>
			  <div class="controls">
				 <form:input path="articleMediumint" htmlEscape="false" maxlength="50" class="required digits"/>
			  </div>
		 </div>
		
		--%>
		<c:if test="${ebArticleType.articleTypeCode=='syzdydhl'}">
		<div class="control-group">
			<label class="control-label" for="isShow">超链接 :</label>
			  <div class="controls">
				 <form:input path="articleUrl" htmlEscape="false" maxlength="150" class="required"/>
			  </div>
		 </div>
		</c:if>
		<c:if test="${ebArticleType.articleTypeCode!='syzdydhl'}">
		<div class="control-group">
			<label class="control-label" for="isShow">是否是导购文章:</label>
			  <div class="controls">
				<form:radiobutton path="articleIsguide" value="0" required="required" />是<form:radiobutton path="articleIsguide" value="1"/>否
			  </div>
		 </div>
		
		<div class="control-group">
			<label class="control-label" for="articleContent">文章内容:</label>
			<div class="controls">
				<form:textarea id="articleContent" htmlEscape="false" path="articleContent" rows="6"  class="input-xxlarge"/>
				<tags:ckeditor replace="articleContent" uploadPath="/merchandise/article/adImg" />
			</div>
		</div>
		
		<div class="control-group">
			<label class="control-label" for="isShow">关键词 :</label>
			  <div class="controls">
				 <form:textarea  path="articleKeyword" htmlEscape="false" maxlength="300" class="required" />
			  </div>
		 </div></c:if>
		<%--<div class="control-group">
			<label class="control-label" for="isShow">栏目 :</label>
			  <div class="controls">
				 <form:input path="articleColumn" htmlEscape="false" maxlength="50" class="required"/>
			  </div>
		 </div>
		 
		 --%><div class="control-group">
			<label class="control-label" for="isShow">状态:</label>
			  <div class="controls">
				<form:radiobutton path="articleStatus" value="0" required="required" />显示<form:radiobutton path="articleStatus" value="1"/>隐藏<form:radiobutton path="articleStatus" value="2"/>删除
			  </div>
		 </div>
		 <c:if test="${ebArticleType.articleTypeCode!='syzdydhl'}">
		 <div class="control-group">
			<label class="control-label" for="name">宣传图:</label>
			<div class="controls">
			<form:hidden path="adImg" htmlEscape="false" maxlength="100"  class="input-xlarge"/>
				<span class="help-inline" id="adImg"  style="color: blue;"></span>
				<tags:ckfinder input="adImg" type="images" uploadPath="/merchandise/article/adImg"/>
			</div>
		</div>
		 </c:if>
		<div class="control-group">
			<label class="control-label">发布时间:</label>
			<div class="controls">
			<input class="small" type="text" class="input-medium" name="releasetime" id="releasetime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:00'})" value="${ebArticle.releasetime}" placeholder="请选择时间"/>
			</div>
		</div> 
		 
		 
		 
		<div class="form-actions">
		        <shiro:hasPermission name="merchandise:ebArticle:edit">
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;
				</shiro:hasPermission>
			    <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>