<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>菜单管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#name").focus();
			 jQuery.validator.addMethod("love", function(value, element) {
				 return love();
				 }, "属性/规格名称重复，请重新输入");
			$("#inputForm").validate({
				rules: {
					spertAttrName:{
						required:true,
						love:true,
						},
				},
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
		function love(){
			var ck="";
			if($('#spertAttrType1').attr('checked')){
				ck=$('#spertAttrType1').val();
			}
			if($('#spertAttrType2').attr('checked')){
				ck=$('#spertAttrType2').val();
			}
			var f=false;
			$.ajax({
				type: "POST",
				 async: false,
				url: "${ctxweb}/shop/PmProductTypeSpertAttr/checkName?productTypeId="+${sbProductType.id}+"&spertAttrType="+ck+"&spertAttrName="+$('#spertAttrName').val()+"",
				success: function(data){
					if(data==false){
						f= false;
					}else{
						f= true;
					}
				  }
				});
			return f;
		}
		  function handle(str){
	    		if(typeof(str)=="undefined"){
	    			return "";
	    		}
	    		return str;
	    	} 
	</script>
</head>
<body style="height: 100%">
	 <ul class="nav nav-tabs">
	 <li ><a href="${ctxweb}/shop/PmProductTypeSpertAttr/list?productTypeId=${productTypeId}">规格属性列表</a></li>
	 <li class="active"><a href="">规格属性
		 <c:if test="${not empty sbProductTypeSpertAttr.id&&not empty sbProductType.shopId&&sbProductType.shopId==shopId}">
			 修改
		 </c:if>
		 <c:if test="${empty sbProductTypeSpertAttr.id}">
			 添加
		 </c:if>
		 <c:if test="${not empty sbProductTypeSpertAttr.id&&(empty sbProductType.shopId||sbProductType.shopId!=shopId)}">
			 查看
		 </c:if>
	 </a></li>
	</ul><br/> 
	
	<form:form id="inputForm" modelAttribute="sbProductTypeSpertAttr" action="${ctxweb}/shop/PmProductTypeSpertAttr/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<tags:message content="${message}"/>
		<div class="control-group">
			<label class="control-label">类别名称:</label>
			<form:hidden path="productTypeId"/>
			<div class="controls">
				<input  readonly="true" class="required" value="${sbProductType.productTypeName}"  class="input-xlarge"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">类型:</label>
			<div class="controls">
				<form:radiobutton path="spertAttrType" value="1" required="required" />规格<form:radiobutton path="spertAttrType" value="2" />属性
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">排序:</label>
			  <div class="controls">
				 <form:input path="orderNo" htmlEscape="false" maxlength="50" class="required digits"/>
			  </div>
		 </div>
		 <div class="control-group">
			<label class="control-label">属性/规格名称:</label>
			  <div class="controls">
				 <form:input path="spertAttrName" htmlEscape="false" maxlength="50" required="required"/>
			  </div>
		 </div>
		 <div class="control-group" style="display: none">
			<label class="control-label">显示方式:</label>
			  <div class="controls">
				<form:radiobutton path="showType" value="1" required="required"  checked="true" />平铺<form:radiobutton path="showType" value="2"/>下拉
			  </div>
		 </div>
		  <div class="control-group" style="display: none">
			<label class="control-label">前台显示方式:</label>
			  <div class="controls">
				<form:radiobutton path="frontShowType" value="1" required="required"  checked="true"/>文字<form:radiobutton path="frontShowType" value="2"/>图片
			  </div>
		 </div>
		 <div class="control-group" style="display: none">
			<label class="control-label"> 录入类型:</label>
			  <div class="controls">
			 <!--  1为手工录入，2为从列表选择。当为规格时：必须从列表选择。当为属性时：手工录入为文本框，从列表选择为下拉框 -->
				<form:radiobutton path="entryType" value="1" required="required"  checked="true"/>手工录入<form:radiobutton path="entryType" value="2"/>为从列表选择
			  </div>
		 </div>
		  <div class="control-group">
			<label class="control-label">前台搜索显示:</label>
			  <div class="controls">
			 <!--  1为手工录入，2为从列表选择。当为规格时：必须从列表选择。当为属性时：手工录入为文本框，从列表选择为下拉框 -->
				<form:radiobutton path="isFrontShow" value="1" required="required" />显示<form:radiobutton path="isFrontShow" value="0"/>不显示
			  </div>
		 </div>
		   <div class="control-group">
			<label class="control-label">是否后台显示:</label>
			  <div class="controls">
			 <!--  1为手工录入，2为从列表选择。当为规格时：必须从列表选择。当为属性时：手工录入为文本框，从列表选择为下拉框 -->
				<form:radiobutton path="isBackShow" value="1" required="required" />显示<form:radiobutton path="isBackShow" value="0"/>不显示
			  </div>
		 </div>
		<div class="control-group">
			<label class="control-label">来源:</label>
			<div class="controls">
				<c:if test="${empty sbProductType.shopId}">平台</c:if>
				<c:if test="${not empty sbProductType.shopId}">${sbProductType.shopName}</c:if>
			</div>
		</div>
		<div class="form-actions">
				<c:if test="${(empty sbProductTypeSpertAttr.id||not empty sbProductTypeSpertAttr.id&&not empty sbProductType.shopId&&sbProductType.shopId==shopId)}">
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;
				</c:if>
			    <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>