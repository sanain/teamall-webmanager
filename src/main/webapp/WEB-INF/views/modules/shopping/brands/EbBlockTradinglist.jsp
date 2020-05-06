<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<jsp:useBean id="ebBlockTrading" class="com.jq.support.model.product.EbBlockTrading" scope="request"/>
<html>
<head>
	<title>供求列表</title>
	<meta name="decorator" content="default"/>
	<link rel="stylesheet" href="${ctxStatic}/sbShop/css/build.css">
	<link href="${ctxStatic}/jquery-jbox/2.3/Skins/Default/jbox.css" type="text/css" rel="stylesheet" />
	<script src="${ctxStatic}/jquery-jbox/2.3/jquery.jBox-2.3.js" type="text/javascript"></script>
	 <script type="text/javascript">
    	function page(n,s){
    		if(n) $("#pageNo").val(n);
    	    if(s) $("#pageSize").val(s);
    	          $("#searchForm").attr("action","${ctxsys}/Product/bigBlist");
    	          $("#searchForm").submit();
    	    	return false;
    	    }
		
		</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<shiro:hasPermission name="merchandise:pro:view"><li class="active"><a href="${ctxsys}/Product/bigBlist">供求信息</a></li></shiro:hasPermission>
		 <shiro:hasPermission name="merchandise:pro:edit"><li><a href="${ctxsys}/Product/addsuplyinfo" >供求添加</a></li></shiro:hasPermission> 
	</ul>
 <c:if test="${not empty msg}">
 <script type="text/javascript">
	   $(function(){
		   $.jBox.success("${msg}","信息提示");
	   })
	</script> 
 </c:if>
  	   <form:form id="searchForm" modelAttribute="ebBlockTrading" action="${ctxsys}/Product/bigBlist" method="post" class="form-search breadcrumb">
  	     <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
     		<ul class="ul-form">
		     <li><label>商品名称:</label><form:input path="productName" htmlEscape="false" maxlength="50" class="input-medium"  placeholder="请输入商品名字"/></li>
			 <li><label>交货地点:</label><form:input path="deliveryPoint" htmlEscape="false" maxlength="50" class="input-medium"  placeholder="请输入交货地点"/></li>
			 <li><label>产地:</label><form:input path="production" htmlEscape="false" maxlength="50" class="input-medium"  placeholder="请输入产地"/></li>
			 </ul><br/>
			 <ul class="ul-form">
			 <li><label>品牌厂家:</label><form:input path="business" htmlEscape="false" maxlength="50" class="input-medium"  placeholder="请输入品牌厂家"/></li>
			 <li><label>有效期:</label><form:input path="expiryDate" htmlEscape="false" maxlength="50" class="input-medium"  placeholder="请输入有效期"/></li>
			 <li><label>交易类型:</label>
			    <form:select path="tradeType" class="input-medium">
			      <form:option value="">请选择</form:option>
			      <form:option value="0">买</form:option>
			      <form:option value="1">卖</form:option>
			    </form:select>
			 </li>
			   <li><button type="submit" class="btn btn-primary" style="margin-left:10px">查询</button></li>
		</ul>
	</form:form>
	<table  class="table table-striped table-condensed table-bordered" >
		<tr>
		<th class="center123" style="width:150px">商品名称</th>
		<th class="center123">交易类型</th>
		<th class="center123">数量</th>
		<th class="center123 sort-column sellPrice">价格</th>
		<th class="center123">计量单位</th>
		<th class="center123">品牌厂家</th>
		<th class="center123">标准/规格</th>
		<th class="center123">交货地点</th>
		<th class="center123">产地</th>
		<th class="center123">有效期</th>
 		<th class="center123">操作</th>  
		</tr>   
		<c:forEach items="${page.list}" var="ebBlockTrading" varStatus="status">
			<tr>
			   <td class="center123">${ebBlockTrading.productName}</td>
				<td class="center123"> 
				 ${ebBlockTrading.tradeType==0?'买':'卖'}
				</td>
				<td class="center123">${ebBlockTrading.num }</td>
				<td class="center123">${ebBlockTrading.sellprice }</td>
				<td class="center123"> ${ebBlockTrading.units}</td>
				 
				<td class="center123">${ebBlockTrading.business}</td>
				<td class="center123">
				${ebBlockTrading.property}
 				</td>
				<td class="center123">
				${ebBlockTrading.deliveryPoint}
				</td>
				<td class="center123">
				${ebBlockTrading.production}
				</td>
				<td class="center123">${ebBlockTrading.expiryDate}</td>
			     
			     <td class="center123">
    				<a href="${ctxsys}/Product/addsuplyinfo?id=${ebBlockTrading.id}&flag=edit">修改</a> 
    				&nbsp;|&nbsp;
    				<a href="${ctxsys}/Product/deleteInfo?id=${ebBlockTrading.id}" onclick="return confirmx('确定要删除信息吗？', this.href)">删除</a>
				</td>
			</tr>
		</c:forEach>
	</table>
	<div class="pagination">${page}</div>
 
  
 
</body>
</html>