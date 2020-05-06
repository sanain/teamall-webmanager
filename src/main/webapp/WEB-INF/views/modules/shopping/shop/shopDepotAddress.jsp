<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<meta name="decorator" content="default"/>
	<link rel="stylesheet" href="${ctxStatic}/sbShop/css/build.css">
	<script type="text/javascript">
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").attr("action","${ctxsys}/PmShopInfo/shopDepotAddress?shopid="+${shopid}+"");
			$("#searchForm").submit();
	    	return false;
	    }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctxsys}/PmShopInfo">商户信息</a></li>
		<li class="active"><a href="${ctxsys}/PmShopInfo/shopDepotAddress?shopid=${shopid}">商户仓库地址</a></li>
		<%-- <li class="active"><a href="javascript:;">商户仓库地址</a></li> --%>
	</ul>
	<form id="searchForm" modelAttribute="" action="" method="post" class="breadcrumb form-search ">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
		<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		 <ul class="ul-form">
			 <li><label>默认状态:</label>
		       <select id="isDefault" name="isDefault" class="input-medium">
		         <option value="">全部</option>
		         <option ${isDefault=='1'?'selected':''} value="1">默认</option>
		         <option ${isDefault=='0'?'selected':''} value="0">不默认</option>
		       </select>
		    </li>
		    <li>
		    	<input value="${contactName}" id="contactName" name="contactName" type="text" maxlength="20" placeholder="请输入收货人"/>
		    </li>
		    <li>
		    	<input value="${phoneNumber}" id="phoneNumber" name="phoneNumber" type="text" maxlength="11" placeholder="请输入手机号" onkeyup="value=value.replace(/[^\d]/g,'')" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))" />
		    </li>
		    <%-- <li><label>审核状态:</label>
		       <select id="verifyStatus" name="verifyStatus" class="input-medium">
		         <option value="">全部</option>
		         <option ${verifyStatus=='0'?'selected':''} value="0">未审核</option>
		         <option ${verifyStatus=='1'?'selected':''} value="1">审核通过</option>
		         <option ${verifyStatus=='2'?'selected':''} value="2">审核不通过</option>
		       </select>
		    </li> --%>
		    <li><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/></li>
		</ul>
	</form>
	<tags:message content="${message}"/>
	<table id="treeTable" class="table table-striped table-condensed">
		<tr>
		 <th class="center123">编号</th>
		 <th class="center123">默认状态</th>
		 <th class="center123">收货人</th>
		 <th class="center123">手机号</th>
		 <th class="center123">座机号</th>
		 <th class="center123">国家</th>
		 <th class="center123">省</th>
		 <th class="center123">市 </th>
		 <th class="center123">区</th>
		 <th class="center123">街道地址 </th>
		 <%-- <shiro:hasPermission name="merchandise:PmShopInfo:edit">
		 <th class="center123">审核状态</th>
		 </shiro:hasPermission> --%>
		 <th class="center123">创建人</th>
		 <th class="center123">创建时间</th>
		 <shiro:hasPermission name="merchandise:PmShopInfo:edit">
		 <th class="center123">详情</th>
		 </shiro:hasPermission></tr>
		<c:forEach items="${page.list}" var="shopDepotAddress" varStatus="status">
			<tr>
			    <td class="center123">${status.index+1}</td>
				<%-- <td class="center123"><a href="${ctxsys}/PmShopCooperType?shopId=${PmShopInfoList.id}">查看合作分类</a></td> --%>
			    <td class="center123">
				    <c:if test="${shopDepotAddress.isDefault==0}">不默认</c:if>
				    <c:if test="${shopDepotAddress.isDefault==1}">默认</c:if>
			    </td>
				<td class="center123">${shopDepotAddress.contactName}</td>
			    <td class="center123">${shopDepotAddress.phoneNumber}</td>
			    <td class="center123">${shopDepotAddress.telephoneNumber}</td>
			    <td class="center123">${shopDepotAddress.countryName}</td>
			    <td class="center123">${shopDepotAddress.provinceName}</td>
			    <td class="center123">${shopDepotAddress.cityName}</td>
			    <td class="center123">${shopDepotAddress.areaName}</td>
			    <td class="center123">${shopDepotAddress.detailAddress}</td>
				<%-- <shiro:hasPermission name="merchandise:PmShopInfo:edit">
			    <td class="center123">
				    <c:if test="${shopDepotAddress.verifyStatus==0}">未审核
					    <a href="${ctxsys}/PmShopInfo/verifyStatus?verifyStatus=2&shopid=${shopid}&id=${shopDepotAddress.id}">审核通过</a>
					    <a href="${ctxsys}/PmShopInfo/verifyStatus?verifyStatus=3&shopid=${shopid}&id=${shopDepotAddress.id}">审核不通过</a>
				    </c:if>
				    <c:if test="${shopDepotAddress.verifyStatus==1}">提交审核</c:if>
				    <c:if test="${shopDepotAddress.verifyStatus==2}">审核通过</c:if>
				    <c:if test="${shopDepotAddress.verifyStatus==3}">审核不通过</c:if>
			    </td>
				</shiro:hasPermission> --%>
			    <td class="center123">${shopDepotAddress.createUser}</td>
			    <td class="center123"><fmt:formatDate value="${shopDepotAddress.createTime}" type="both"/></td>
			    <shiro:hasPermission name="merchandise:PmShopInfo:edit">
			    <td class="center123">
					<a href="${ctxsys}/PmShopInfo/shopDepotAddressfrom?shopid=${shopid}&id=${shopDepotAddress.id}">详情</a>
				</td>
				</shiro:hasPermission>
			</tr>
		</c:forEach>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>