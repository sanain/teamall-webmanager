<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<meta name="decorator" content="default"/>
	<meta name="Description" content="${fns:getProjectName()},线上充值列表"/>
	<meta name="Keywords" content="${fns:getProjectName()},线上充值列表"/>
	<title>线下充值列表</title>
	<link rel="stylesheet" href="${ctxStatic}/sbShop/css/build.css">
	<link rel="stylesheet" href="${ctxStatic}/sbShop/css/lineRecharge.css">
	<link rel="stylesheet" href="${ctxStatic}/sbShop/css/swiper-3.4.0.min.css">
	<script type="text/javascript" src="${ctxStatic}/sbShop/js/lineRecharge.js"></script>
	<script type="text/javascript" src="${ctxStatic}/sbShop/js/swiper-3.4.0.min.js"></script>
	<script type="text/javascript">
	function page(n,s){
		$("#pageNo").val(n);
		$("#pageSize").val(s);
		$("#searchForm").attr("action","${ctxsys}/UserAmtLog/lineRechargeList");
		$("#searchForm").submit();
	    return false;
	}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctxsys}/UserAmtLog/lineRechargeList">线下充值列表</a></li>
	</ul>
	 <form id="searchForm" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
		<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form">
		    <li>
		    	<input class="wi" value="${mobile}" id="mobile" name="mobile" type="text" maxlength="11" placeholder="会员账号" onkeyup="value=value.replace(/[^\d]/g,'')" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))"/>
		    </li>
		    <li>
		    	<input class="wid" value="${accountName}" id="accountName" name="accountName" type="text" maxlength="15" placeholder="转账姓名"/>
		    </li>
		    <li>
		    	<input class="widd" value="${applyCode}" id="applyCode" name="applyCode" type="text" maxlength="18" placeholder="申请编号" onkeyup="value=value.replace(/[^\d]/g,'')" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))" />
		    </li>
		    <li>
				<select id="status" name="status" class="input-medium">
					<option value="">状态</option>
					<option ${status=='1'?'selected':''} value="1">审核中</option>
					<option ${status=='2'?'selected':''} value="2">审核不通过</option>
					<option ${status=='3'?'selected':''} value="3">充值中</option>
					<option ${status=='5'?'selected':''} value="5">退款中</option>
					<option ${status=='4'?'selected':''} value="4">充值成功</option>
					<option ${status=='6'?'selected':''} value="6">退款成功</option>
				<select>
			</li>
		    <li>
               <input value="${startTime}" id="startTime" name="startTime" type="date" style="width:130px">
               <span>-</span>
               <input value="${endTime}" id="startTime" name="endTime" type="date" style="width:130px">
            </li>
		    <li><input id="btnSubmit" class="btn btn-primary" type="submit" value="搜索" onclick="return page();"/></li>
			<li><input id="btnExport" class="btn btn-primary getExsel" type="button" value="导出"/></li>
		</ul>
    </form>
    <input type="hidden" id="ctxsys" name="ctxsys" value="${ctxsys}"/>
    <input type="hidden" id="ctxStatic" name="ctxStatic" value="${ctxStatic}"/>
	<tags:message content="${message}"/>
	<table id="treeTable" class="table table-striped table-condensed table-bordered">
		<tr>
		 <th>序号</th>
		 <th>会员账号</th>
		 <th>申请编号 </th>
		 <th>转账金额</th>
		 <th>补贴金额</th>
		 <th>转账姓名</th>
		 <th>银行账号</th>
		 <th>开户银行</th>
		 <th>状态</th>
		 <th>申请时间</th>
		 <th>最后操作人</th>
		 <th>最后操作时间</th>
		 <th>操作</th>
		</tr>
		<c:forEach items="${page.list}" var="pmUserOfflineRechargeLog" varStatus="ss">
			<tr>
			    <td>${ss.index+1}</td>
			    <td>${pmUserOfflineRechargeLog.mobile}</td>
			    <td>${pmUserOfflineRechargeLog.applyCode}</td>
			    <td class="transferAmount">${pmUserOfflineRechargeLog.transferAmount}</td>
			    <td class="subsidyAmount">${pmUserOfflineRechargeLog.subsidyAmount}</td>
			    <td>${pmUserOfflineRechargeLog.accountName}</td>
			    <td>${pmUserOfflineRechargeLog.account}</td>
			    <td>${pmUserOfflineRechargeLog.bankName}</td>
			    <td>
			    	<c:if test="${pmUserOfflineRechargeLog.status==1}">审核中</c:if>
			    	<c:if test="${pmUserOfflineRechargeLog.status==2}">审核不通过</c:if>
			    	<c:if test="${pmUserOfflineRechargeLog.status==3}">充值中</c:if>
			    	<c:if test="${pmUserOfflineRechargeLog.status==4}">充值成功</c:if>
			    	<c:if test="${pmUserOfflineRechargeLog.status==5}">退款中</c:if>
			    	<c:if test="${pmUserOfflineRechargeLog.status==6}">退款成功</c:if>
			    </td>
			    <td><fmt:formatDate value="${pmUserOfflineRechargeLog.createTime}" type="both"/></td>
			    <td>${pmUserOfflineRechargeLog.createUser}</td>
			    <td><fmt:formatDate value="${pmUserOfflineRechargeLog.modifyTime}" type="both"/></td>
			    <shiro:hasPermission name="	merchandise:UserAmtLog:edit">
			    <td>
			    	<a class="lookimg" id="${pmUserOfflineRechargeLog.id}" href="javascript:;">查看凭证</a>
			    	<c:if test="${pmUserOfflineRechargeLog.status==1}">
				    	<a class="yes" id="${pmUserOfflineRechargeLog.id}" status="${pmUserOfflineRechargeLog.status}" href="javascript:;">同意</a>
					    <a class="no" id="${pmUserOfflineRechargeLog.id}" status="${pmUserOfflineRechargeLog.status}" href="javascript:;">拒绝</a>
				    </c:if>
				    <c:if test="${pmUserOfflineRechargeLog.status==3}">
				    	<a class="yes" id="${pmUserOfflineRechargeLog.id}" status="${pmUserOfflineRechargeLog.status}" href="javascript:;">同意充值</a>
					</c:if>
				    <c:if test="${pmUserOfflineRechargeLog.status==5}">
				    	<a class="yes" id="${pmUserOfflineRechargeLog.id}" status="${pmUserOfflineRechargeLog.status}" href="javascript:;">退款完成</a>
					    <a class="no" id="${pmUserOfflineRechargeLog.id}" status="${pmUserOfflineRechargeLog.status}" href="javascript:;">拒绝退款</a>
				    </c:if>
			    </td>
			    </shiro:hasPermission>
			</tr>
		</c:forEach>
		<c:if test="${!empty page.list}">
			<tr>
				<td id="no"></td><td/>
				<td>合计：</td>
				<td id="transferAmountcount"></td>
				<td id="subsidyAmountcount"></td>
				<td/><td/><td/><td/><td/><td/><td/><td/><td/>
			</tr>
		</c:if>
	</table>
	<div class="pagination">${page}</div>
	<div class="lishi-img">
		<div class="lishi-img-box">
			<p>查看凭证<img class="lishi-del-img" src="${ctxStatic}/hAdmin/img/xxx-rzt.png" alt=""></p>
			<div class="lishi-img-div">
				<div class="lishi-img-body" id="banner">
					<div class="swiper-wrapper"></div>
					<div class="swiper-pagination"></div>
				</div>
			</div>
		</div>
	</div>
	<div class="lishi-yes">
		<div class="lishi-yes-box">
			<p class="tip"></p>
			<div class="lishi-yes-div">
				<div class="lishi-yes-body">
					<p class="tip-y"></p>
					<div class="post-y"></div>
				</div>
			</div>
		</div>
	</div>
	<div class="lishi-no">
		<div class="lishi-no-box">
			<p>数据审核<img class="lishi-del-no" src="${ctxStatic}/hAdmin/img/xxx-rzt.png" alt=""></p>
			<div class="lishi-no-div">
				<div class="lishi-no-body">
					<div>拒绝原因：</div>
					<form id="postForm" method="post">
						<input type="hidden" id="id" name="id"/>
						<input type="hidden" id="status-n" name="status"/>
						<div><textarea id="reason" name="reason"></textarea></div>
					</form>
					<div style="text-align:center;margin-top:12px;">
						<a class="btn btn-primary post-n" href="javascript:;">保存</a>
						<a class="btn btn-primary lishi-del-no" href="javascript:;">关闭</a>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>