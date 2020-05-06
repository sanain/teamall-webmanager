<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>商品列表</title>
	<meta name="decorator" content="default"/>
	<link rel="stylesheet" href="${ctxStatic}/sbShop/css/build.css?v=1">
  
    <script type="text/javascript">
    	  
    	function page(n,s){
		if(n) $("#pageNo").val(n);
	    if(s) $("#pageSize").val(s);
	          $("#searchForm").attr("action","${ctxsys}/trace/tracelist");
	          $("#searchForm").submit();
	    	return false;
	    }
	    
 
		  
    </script>
 
</head>
<body>
     
	<ul class="nav nav-tabs">
		
		<li class="active"><a href="${ctxsys}/trace/tracelist">溯源码列表</a></li>
		<li><a href="${ctxsys}/trace/list">录入溯源码</a></li> 
	</ul>
	 <form:form id="searchForm" modelAttribute="ebProduct" action="${ctxsys}/trace/tracelist" method="post" class="breadcrumb form-search ">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
		<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form">
		     <li><label>溯源码:</label><form:input path="tracingSourceCode" htmlEscape="false" maxlength="50" class="input-medium"  placeholder="请输入溯源码"/></li>
			 <li><input id="btnSubmit" class="btn btn-primary " type="submit" value="查询" onclick="return page();"/></li>
		
		</ul>
		 
	</form:form> 
	<tags:message content="${message}"/>
	<table  class="table table-striped table-condensed table-bordered" >
		<tr>
		<th class="center123">溯源码</th>
		<th class="center123" style="width:150px">商品名称</th>
		<th class="center123">商品图片</th>
		<th class="center123">所属分类</th>
		<th class="center123 sort-column sellPrice">销售价</th>
		<c:if test="${stule!='99'}">
		<th class="center123 sort-column costPrice">结算价</th>
		<th class="center123 sort-column marketPrice">市场价</th>
		<th class="center123">品牌</th>
		<th class="center123 sort-column upTime">上架时间</th>
		</c:if>
		<th class="center123">门店名称</th>
		
		<th class="center123">操作</th>
	 
		 
		 
	 
		</tr>
		<c:forEach items="${page.list}" var="productlist" varStatus="status">
			<tr>
				<td class="center123">${productlist.tracingSourceCode}</td>
				<td class="center123 productName">
				  ${fns:abbr(productlist.productName,20)} 
				</td>
				<td class="center123"><img class="fu" src="${fn:split(productlist.prdouctImg,'|')[0]}"style="width:30px;height:30px"/><img class="kla" style="display:none;position:fixed;top:30%;left:40%" alt="" src="${fn:split(productlist.prdouctImg,'|')[0]}"></td>
				<td class="center123">${fns:getsbProductTypeName(productlist.productTypeId).productTypeStr}</td>
				<td class="center123"> ${productlist.sellPrice}</td>
				<c:if test="${stule!='99'}">
				<td class="center123">${productlist.costPrice}</td>
				<td class="center123">${productlist.marketPrice}</td>
				<td class="center123">${productlist.brandName}</td>
				<td class="center123">${productlist.upTime}</td>
				</c:if>
				<td class="center123">${productlist.shopName}</td>
			
				<td class="center123" ><a href="${ctxsys}/trace/certinfo?code=${productlist.tracingSourceCode}">查看证书</a></td>
				 
				 
			 
			    
			</tr>
		</c:forEach>
	</table>
	<div class="pagination">${page}</div>
    <input type="hidden" id="chooseIds" value=""/>
    <input type="hidden" id="chooseProductName" value=""/>
    <input type="hidden" id="traceSourceCode" value=""/>
  
  
 
  
 <script type="text/javascript">

   
      
       $('body').on('click','.chooseItem',function(){
    	   var id=$('.chooseItem[type=radio]:checked').val();
    	   var code=$('.chooseItem[type=radio]:checked').attr("code");
    	   var prodctName=$(this).parents("tr").find(".productName a").text().trim();
    		   $("#chooseIds").val(id);
    		   $("#traceSourceCode").val(code);
    		   $("#chooseProductName").val(prodctName);
    	   
    		
    });
    
    
     
   
    
  </script>
</body>
</html>