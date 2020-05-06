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
			
	 $("#upload").click(function(){
		 var a;
		var formData = new FormData();
		formData.append('file', $('#file')[0].files[0]);
		$.ajax({
		    url: '${ctxsys}/Product/pohotupload',
		    type: 'POST',
		    cache: false,
		    data: formData,
		     success: function (data){//上传成功
		     a=data;
		     if(a!=""){
		     $("#ju").remove();
		     $("#poth").append("<span id='ju'><input type='hidden' name='pothname' value='"+a+"'/><img  width='70px;' height='50px;' alt='' src='"+a+"'></span>");
             }else{
             alert("请选择上传的图片");
             }
              },
		    processData: false,
		    contentType: false
		}).done(function(res) {

		}).fail(function(res) {
	
		});
            });
			
		});
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li ><a href="${ctxsys}/EbProperty/list?productId=${productId}">商品属性列表</a></li>
		<shiro:hasPermission name="merchandise:pro:edit"><li class="active"><a href="${ctxsys}/EbProperty/form">商品属性添加</a></li></shiro:hasPermission>
	</ul></ul><br/>
	<form:form id="inputForm" modelAttribute="ebProperty" action="${ctxsys}/EbProperty/saveCategory" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<input type="hidden" name="productId" value="${productId}"/>
		<tags:message content="${message}"/>
		<div class="control-group">
			<label class="control-label">上级菜单:</label>
			<div class="controls">
                <tags:treeselect id="menu" name="parent.id" value="${ebProperty.parent.id}" labelName="parent.propertyName" labelValue="${ebProperty.parent.propertyName}"
					title="菜单" url="${ctxsys}/EbProperty/treeData" extId="${menu.id}" productId="${productId}" cssClass="required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="name">名称:</label>
			<div class="controls">
				<form:input path="propertyName" htmlEscape="false" maxlength="50" class="required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="name">属性图片:</label>
			<div class="controls">
			<form:hidden path="propertyImages" htmlEscape="false" maxlength="100"  class="input-xlarge"/>
				<span class="help-inline" id="propertyImages"  style="color: blue;"></span>
				<tags:ckfinder input="propertyImages" type="images" uploadPath="/merchandise/EbProperty"/>
				
				<%-- 	<input id="file" type="file" name="filename" value="${EbProCategory.categoryImages}"/><button id="upload" type="button">上传</button>
					<span id="poth"><span id='ju'><img  width="70px;" height="50px;"  src="${EbProCategory.categoryImages}"></span></span> --%>
			</div>
			<div class="control-group">
			<label class="control-label" for="name">价格:</label>
			<div class="controls">
				<form:input path="propertyPrice" htmlEscape="false" maxlength="50" required="required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="name">下级标题:</label>
			<div class="controls">
				<form:input path="nextTitle" htmlEscape="false" maxlength="50" required="required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="name">菜单:</label>
			<div class="controls">
				<form:select path="propertyTow" required="required">
				<form:option value="0">一级</form:option>
				<form:option value="1">二级</form:option>
				<form:option value="2">三级</form:option>
				</form:select>
				<span>*一级，规格  二级是颜色，三级是尺寸，必须对应</span>
			</div>
		</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="merchandise:pro:edit">
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;
			</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>