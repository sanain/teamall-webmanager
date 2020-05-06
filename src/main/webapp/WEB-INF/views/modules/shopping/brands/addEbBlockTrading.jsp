<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<jsp:useBean id="ebBlockTrading" class="com.jq.support.model.product.EbBlockTrading" scope="request"/>
<html>  
<head> 
	<title>商品管理</title>
	<meta name="decorator" content="default"/>
	<link href="${ctxStatic}/jquery-jbox/2.3/Skins/Default/jbox.css" type="text/css" rel="stylesheet" />
	<script src="${ctxStatic}/jquery-jbox/2.3/jquery.jBox-2.3.js" type="text/javascript"></script>
	 <script type="text/javascript">
	  $(function(){
		  $("#btnSubmit").click(function(){
			  if($("#productName").val()==""){
   			   $.jBox.error("商品名称不能为空", '信息提示');
   			   return;
   		   } 
			  if($("#tradeType").val()==""){
     			   $.jBox.error("请选择交易类型", '信息提示');
     			   return;
     		   } 
			  if($("#num").val()==""){
    			   $.jBox.error("数量不能为空", '信息提示');
    			   return;
    		   } if($("#price").val()==""){
    			   $.jBox.error("价格不能为空", '信息提示');
    			   return;
    		   } 
    		   if($("#price").val()==""){
    			   $.jBox.error("价格不能为空", '信息提示');
    			   return;
    		   } 
			  if($("#units").val()==""){
    			   $.jBox.error("计量单位不能为空", '信息提示');
    			   return;
    		   } 
			  if($("#business").val()==""){
    			   $.jBox.error("品牌厂家不能为空", '信息提示');
    			   return;
    		   } 
			  if($("#property").val()==""){
    			   $.jBox.error("标准/规格不能为空", '信息提示');
    			   return;
    		   } 
			  if($("#deliveryPoint").val()==""){
   			   $.jBox.error("交货地点不能为空", '信息提示');
   			   return;
   		     } 
			    if($("#production").val()==""){
    			   $.jBox.error("产地不能为空", '信息提示');
    			   return;
    		   } 
			  if($("#expiryDate").val()==""){
	   			   $.jBox.error("有效期不能为空", '信息提示');
	   			   return;
	   		   } 
			  else{
				  $("#searchForm").submit();
			  }
		  });
 
	  });
	 
	 </script>
</head>
<body style="height: 100%">
    <c:if test="${not empty msg }">
     <script type="text/javascript">
	   $(function(){
		   $.jBox.success("${msg}","信息提示");
		   if("${type}"=="update"){
			  setTimeout(function(){
				  location.href="${ctxsys}/Product/bigBlist";
			  },500);
		   }
	   })
	</script> 
    </c:if>
	 <ul class="nav nav-tabs">
	  <li class=""><a href="javascript:;">供求${flag=='edit'?'修改':'添加'}</a></li> 
 	</ul><br/> 
 	   <form:form id="searchForm" modelAttribute="ebBlockTrading" action="${ctxsys}/Product/suplyinfoJson" method="post" class="form-horizontal">
		<div class="control-group">
			<label class="control-label" for="href">商品名称:</label>
			<div class="controls">
         <form:input path="productName" htmlEscape="false" maxlength="50" class="input-medium"  placeholder="请输入商品名称"/>
         <form:hidden path="id" value="${ebBlockTrading.id}"/>
			</div>
		</div>     
		<div class="control-group">
			<label class="control-label" for="isShow">交易类型:</label>
			  <div class="controls">
			   <form:select path="tradeType" class="input-medium">
			      <form:option value="">请选择</form:option>
			      <form:option value="0">买</form:option>
			      <form:option value="1">卖</form:option>
			    </form:select>
			  </div>
		   </div>
		   <div class="control-group">
			<label class="control-label" for="href">数量:</label>
			<div class="controls">
			  <form:input path="num" htmlEscape="false" maxlength="50" class="input-medium"   placeholder="请输入数量"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="href">价格:</label>
			<div class="controls">
			<form:input path="sellprice" htmlEscape="false" maxlength="50" class="input-medium"  style="width:100px;" onkeyup="value=value.replace(/[^\d{1,}\.\d{1,}|\d{1,}]/g,'')"  placeholder="请输入价格"/>
			</div>
		</div>
		<div class="control-group">   
			<label class="control-label" for="href">计量单位:</label>
			<div class="controls">
			<form:input path="units" htmlEscape="false" maxlength="50" class="input-medium"   placeholder="请输入计量单位" value=""/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="href">品牌厂家:</label>
			<div class="controls">
			<form:input path="business" htmlEscape="false" maxlength="50" class="input-medium"   placeholder="请输入品牌厂家"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="href">标准/规格:</label>
			<div class="controls">
			<form:input path="property" htmlEscape="false" maxlength="50" class="input-medium"   placeholder="请输入标准/规格"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="href">交货地点:</label>
			<div class="controls">
    <form:input path="deliveryPoint" htmlEscape="false" maxlength="50" class="input-medium"   placeholder="请输入交货地点"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="href">产地:</label>
			<div class="controls">
       <form:input path="production" htmlEscape="false" maxlength="50" class="input-medium"   placeholder="请输入产地"/>
			</div>
		</div>
		
		<div class="control-group">
			<label class="control-label" for="href">有效期:</label>
			<div class="controls">
      <form:input path="expiryDate" htmlEscape="false" maxlength="50" class="input-medium"   placeholder="请输入有效期"/>
			</div>
		</div>
		<div class="form-actions">
				 <input id="btnSubmit" class="btn btn-primary" type="button" value="保 存"/> 
				 <span></span>
				 <input id="btnCancel" class="btn" type="button" value="返 回" onclick="window.location.href='${ctxsys}/Product/bigBlist'"/>
		</div>
 </form:form>
</body>
</html>