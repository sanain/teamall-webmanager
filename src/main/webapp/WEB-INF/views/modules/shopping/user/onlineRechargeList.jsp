<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<meta name="decorator" content="default"/>
	<meta name="Description" content="${fns:getProjectName()},线上充值列表"/>
	<meta name="Keywords" content="${fns:getProjectName()},线上充值列表"/>
	<title>线上充值列表</title>
	<link rel="stylesheet" href="${ctxStatic}/sbShop/css/build.css">
	<link rel="stylesheet" href="${ctxStatic}/sbShop/css/onlineRecharge.css">
	<script type="text/javascript" src="${ctxStatic}/sbShop/js/onlineRecharge.js"></script>
	<script type="text/javascript">
	function page(n,s){
		$("#pageNo").val(n);
		$("#pageSize").val(s);
		$("#searchForm").attr("action","${ctxsys}/UserAmtLog/onlineRechargeList");
		$("#searchForm").submit();
	    return false;
	}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctxsys}/UserAmtLog/onlineRechargeList">余额日志列表</a></li>
	</ul>
	 <form id="searchForm" action="UserAmtLog" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
		<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form">
		    <li>
		    	<input value="${mobile}" id="mobile" name="mobile" type="text" maxlength="11" placeholder="用户账号" onkeyup="value=value.replace(/[^\d]/g,'')" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))" />
		    </li>
		    <li>
               <input value="${startTime}" id="startTime" name="startTime" type="date" style="width:130px">
               <span>-</span>
               <input value="${endTime}" id="startTime" name="endTime" type="date" style="width:130px">
            </li>
		    <li><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/></li>
		    <li class="add-show"><input id="btnExport" class="btn btn-primary check-a1" type="button" value="会员充值（选中会员）"/></li>
		    <li class="adds-show"><input id="btnExport" class="btn btn-primary check-a1" type="button" value="批量会员充值"/></li>
		</ul>
    </form>
    <input type="hidden" id="ctxsys" name="ctxsys" value="${ctxsys}" />
	<tags:message content="${message}"/>
	<table id="treeTable" class="table table-striped table-condensed table-bordered">
		<tr>
		 <th>序号</th>
		 <th>会员账号</th>
		 <th>充值金额</th>
		 <th>说明</th>
		 <th>创建人</th>
		 <th>创建时间</th>
		</tr>
		<c:forEach items="${page.list}" var="pmAmtLog" varStatus="status">
			<tr>
			    <td>${status.index+1}</td>
			    <td>${pmAmtLog.ebUser.mobile}</td>
			    <td class="amt">${pmAmtLog.amt}</td>
			    <td>${pmAmtLog.remark}</td>
			    <td>${pmAmtLog.createUser}</td>
			    <td><fmt:formatDate value="${pmAmtLog.createTime}" type="both"/></td>
			</tr>
		</c:forEach>
		<c:if test="${!empty page.list}">
			<tr>
				<td id="no"></td>
				<td>合计：</td>
				<td id="count"></td>
				<td/><td/><td/>
			</tr>
		</c:if>
	</table>
	<div class="pagination">${page}</div>
	<div class="lishi-add">
		<div class="lishi-add-box">
			<p>会员充值<img class="lishi-del-add" src="${ctxStatic}/hAdmin/img/xxx-rzt.png" alt=""></p>
			<div class="lishi-add-div">
				<div class="lishi-add-body">
					<form id="addForm" method="post">
						<div class="userinfo"> 会 员 账 号：<input id="addmobile" name="addmobile" type="text" readonly="readonly"/></div>
					 	<br>
					 	<div> 充 值 金 额：<input id="addamt" name="addamt" type="number" onkeyup='value=value.replace(/\.{2,}/g,".")'/></div>
					</form>
					<div style="text-align:center;margin-top:8px;">
						<a class="btn btn-primary add" href="javascript:;">保存</a>
						<a class="btn btn-primary lishi-del-add" href="javascript:;">取消</a>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="userlist">
		<div class="userlist-box">
			<p>会员选择——双击快速选择<img class="del-userlist" src="${ctxStatic}/hAdmin/img/xxx-rzt.png" alt=""></p>
			<div class="userlist-div">
				<div class="userlist-body">
					<form class="breadcrumb form-search" style="margin-bottom: 1px">
						<ul class="ul-form">
						    <li>
						    	<input value="${usermobile}" id="usermobile" name="usermobile" type="text" maxlength="11" placeholder="会员账号" onkeyup="value=value.replace(/[^\d]/g,'')" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))" />
						    </li>
						    <li>
						       <select id="userstatus" name="userstatus" class="input-medium">
						         <option value="">会员状态</option>
						         <option ${userstatus=='1'?'selected':''} value="1">使用会员</option>
						         <option ${userstatus=='2'?'selected':''} value="2">禁用会员</option>
						       <select>
						    </li>
						    <li><input class="btn btn-primary" style="width: 58px" value="查询" onclick="userPage();"/></li>
						</ul>
				    </form>
					<div class="table-div">
					 <div class="table-div-a">
					  <table id="treeTable" class="table table-striped table-condensed">
					  	<tr>
						 <th></th>
						 <th>会员账号</th>
						 <th>昵称</th>
						 <th>联系电话</th>
						 <th>邀请码</th>
						 <th>性别</th>
						 <th>注册时间</th>
						 <th>操作</th>
						</tr>
						<c:forEach items="${userlist}" var="ebUser" varStatus="status">
							<tr class="postmoblie-tr">
							    <td>${status.index+1}</td>
							    <td>${ebUser.mobile}</td>
							    <td>${ebUser.username}</td>
							    <td>${ebUser.mobile}</td>
							    <td>${ebUser.cartNum}</td>
							    <td>
								    <c:if test="${ebUser.sex==0}">保密</c:if>
								    <c:if test="${ebUser.sex==1}">男</c:if>
								    <c:if test="${ebUser.sex==2}">女</c:if>
							    </td>
							    <td><fmt:formatDate value="${ebUser.createtime}" type="both"/></td>
							    <td><a class="postmoblie" href="javascript:;">选择</a></td>
							</tr>
						</c:forEach>
					  </table>
					 </div>
					<div class="pagination">
						<%-- <input id=pageCount name="pageCount" type="hidden" value="${pageCount}"/> --%>
						<ul>
							<c:if test="${userpageNo==1}">
								<li class="disabled"><a href="javascript:;">« 上一页</a></li>
							</c:if>
							<c:if test="${userpageNo>1}">
								<li><a href="javascript:;">« 上一页</a></li>
							</c:if>
							<c:if test="${userpageNo-2>0}">
								<li><a href="javascript:;" onclick="userPage(${userpageNo-2});">${userpageNo-2}</a></li>
							</c:if>
							<c:if test="${userpageNo-1>0}">
								<li><a href="javascript:;" onclick="userPage(${userpageNo-1});">${userpageNo-1}</a></li>
							</c:if>
							<li class="active"><a href="javascript:;">${userpageNo}</a></li>
							<c:if test="${userpageNo+1<=pageCount}">
								<li><a href="javascript:;" onclick="userPage(${userpageNo+1});">${userpageNo+1}</a></li>
							</c:if>
							<c:if test="${userpageNo+2<=pageCount}">
								<li><a href="javascript:;" onclick="userPage(${userpageNo+2});">${userpageNo+2}</a></li>
							</c:if>
							<c:if test="${pageCount==userpageNo}">
								<li class="disabled"><a href="javascript:;">下一页 »</a></li>
							</c:if>
							<c:if test="${pageCount>userpageNo}">
								<li><a href="javascript:;" onclick="userPage(${userpageNo+1});">下一页 »</a></li>
							</c:if>
							<li class="disabled controls">
								<a href="javascript:;">当前 <input type="number" value="${userpageNo}" style="width: 40px">/<input id="userpageSize" type="number" value="${userpageSize}" style="width: 40px">条，共 ${userCount}条</a>
							</li><li></li>
						</ul>
						<div style="clear:both;"></div>
					</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="lishi-adds">
		<div class="lishi-adds-box">
			<p>批量会员充值<img class="lishi-del-adds" src="${ctxStatic}/hAdmin/img/xxx-rzt.png" alt=""></p>
			<div class="lishi-adds-div">
				<div class="lishi-adds-body">
					<div>批量会员账号及对应金额：<br>示例格式(帐户,金额 15903088888,48 15903032111,28)</div>
					<div><textarea id="contents" name="contents"></textarea></div>
					<div style="text-align:center;margin-top:8px;">
						<a class="btn btn-primary adds" href="javascript:;">保存</a>
						<a class="btn btn-primary lishi-del-adds" href="javascript:;">取消</a>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>