<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ include file="/WEB-INF/views/include/head.jsp"%>
<html>
<head>
	<title>菜单管理</title>
	<meta name="decorator" content="default"/>
	<link rel="stylesheet" href="${ctxStatic}/sbShop/css/admin-member-msg.css">
	<script type="text/javascript">
		$(document).ready(function() {
		var f="${f}";
		if(f==1){
		}else{
	    	var frame = window.parent.document.getElementById("left"); 
		    var path = frame.getAttribute("src"); 
		          frame.setAttribute("src", path); 
		}
		 jQuery.validator.addMethod("love", function(value, element) {
			 return love();
			 }, "名称重复，请重新输入");
			$("#inputForm").validate({
				rules: {
					productTypeName:{
						required:true,
						love:true,
						},
				},
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				messages: {
					productTypeName: {remote: "名称重复，请重新输入"},
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
			var f=false;
			$.ajax({
				type: "POST",
				 async: false,
				url: "${ctxweb}/PmProductType/checkName?id=${sbProductType.id}&parentId="+$("#menuId").val()+"&productTypeName="+$("#productTypeName").val()+"",
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
		function del(id){
			return confirmx('确认要删除吗？', "${ctxweb}/shop/PmProductType/delete?id="+ id+"");
		}
		
	</script>
	<style type="text/css">
	.controls > .input-append > #menuButton{
	 display: none;
	}
	</style>
</head>
<body style="height: 100%">
	 <ul class="nav nav-tabs">
		<li <c:if test="${not empty sbProductType.id }"> class="active"</c:if> ><a href="${ctxweb}/shop/PmProductType/form?id=${sbProductType.id}&shopId=${pmShopInfo.id}&ys=lk&parentId=${sbProductType.parentId}">分类<c:if test="${not empty sbProductType and not empty sbProductType.shopId}">修改</c:if><c:if test="${not empty sbProductType and empty sbProductType.shopId}">查看</c:if></a></li>
		<li <c:if test="${empty sbProductType.id}"> class="active"</c:if> ><a href="${ctxweb}/shop/PmProductType/form?shopId=${pmShopInfo.id}&parentId=${empty sbProductType.id?sbProductType.parentId:sbProductType.id}&ys=ad">分类添加</li>
	</ul><br/> 
	<form:form id="inputForm" modelAttribute="sbProductType" action="${ctxweb}/shop/PmProductType/savetype" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<tags:message content="${message}"/>
		<div class="control-group">
			<label class="control-label">上级菜单:</label>
			<div class="controls">
                <tags:treeselect id="menu" name="parentId" value="${sbProductType.parentId}" labelName="productTypeStr" labelValue="${sbProductType.productTypeStr}"
					title="菜单" url="${ctxsys}/PmProductType/treeData" extId="${menu.id}" cssClass="required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="name">名称:</label>
			<div class="controls">
				<form:input path="productTypeName" htmlEscape="false" maxlength="50" class="required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="name">商品分类图片:</label>
			<div class="controls">
			<form:hidden path="productTypeLogo" htmlEscape="false" maxlength="100"  class="input-xlarge"/>
				<span class="help-inline" id="productTypeLogo"  style="color: blue;"></span>
				<tags:ckfinder input="productTypeLogo" type="images" uploadPath="/merchandise/category"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="href">关键词:</label>
			<div class="controls">
				<form:input path="typeKeyword" htmlEscape="false" maxlength="200"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="isShow">排序:</label>
			<div class="controls">
				<form:input path="orderNo" htmlEscape="false" maxlength="50" class="required digits"/>
				</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="isShow">是否前端展示:</label>
			<div class="controls">
			   <form:radiobutton path="isShowFront" value="0" checked="true"/>不开放
               <form:radiobutton path="isShowFront" value="1"/>开放
			</div>
		</div>
		<input name="isfshow" id="isfshow" type="hidden" value="${sbProductType.isShowFront}"/>
		<div class="control-group" style="display:none;">
			<label class="control-label" for="isShow">是否开放商家:</label>
			<div class="controls">
				  <form:radiobutton path="isShowShop" value="0" />不开放
                  <form:radiobutton path="isShowShop" value="1" checked="true"/>开放
			</div>
		</div>
		<%-- <div class="control-group">
			<label class="control-label" for="isShow">费率:</label>
			<div class="controls">
				<form:input path="rate" htmlEscape="false" maxlength="50" class="required digits"/>
			</div>
		</div> --%>
		<div class="control-group">
			<label class="control-label" for="isShow">备注:</label>
			<div class="controls">
				<form:textarea path="describeInfo" htmlEscape="false" maxlength="50" />
			</div>
		</div>
		<div class="form-actions">
		        <c:if test="${not empty sbProductType and not empty sbProductType.shopId}">
				<input id="btnSubmit" class="btn btn-primary" type="submit"  value="保 存"/>&nbsp;
				<input id="btnCancel" class="btn" type="button" value="删除" onclick="overlay()"/>
				</c:if>
			    <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
	
	<div id="modal-overlay" style="position:fixed;top:0;left:0;bottom:0;background: rgba(0,0,0,0.4)">
	<div style="width:240px;height:180px;margin:10% auto;background: #fff;">
        <div class="msg-btn">
            <label>是否删除分类？</label>
        </div>
        <div class="msg-btn" style="padding:10px 0;">
            <a onclick="del()" style="background-color:#4778C7;">确定</a>
            <a onclick="overlay()" style="background-color:#999">取消</a>
        </div>

</div>
</div>
<script type="text/javascript">

        // 修改密码弹框
        function overlay() {
            var e1 = document.getElementById('modal-overlay');
            e1.style.visibility = (e1.style.visibility == "visible") ? "hidden" : "visible";
        }

        //提交修改密码
        function del() {
            var id=$("#id").val();
            window.location="${ctxweb}/shop/PmProductType/delete?id="+id;
        }
</script>

<style>
    /* 定义模态对话框外面的覆盖层样式 */
    #modal-overlay {
        visibility: hidden;
        position: absolute; /* 使用绝对定位或固定定位  */
        left: 0px;
        top: 0px;
        width: 100%;
        height: 100%;
        text-align: center;
        z-index: 1000;
        background-color: #3333;
    }

    /* 模态框样式 */
    .modal-data {
        width: 300px;
        margin: 100px auto;
        background-color: #fff;
        border: 1px solid #000;
        border-color: #ffff;
        padding: 15px;
        text-align: center;
    }
</style>
</body>
</html>