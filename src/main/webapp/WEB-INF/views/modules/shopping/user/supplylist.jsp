<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>供应商管理</title>
	<meta name="decorator" content="default"/>
	<link href="${ctxStatic}/jquery-ztree/3.5.12/css/zTreeStyle/zTreeStyle1.min.css" rel="stylesheet" type="text/css"/>
	<script src="${ctxStatic}/jquery-ztree/3.5.12/js/jquery.ztree.core-3.5.min.js" type="text/javascript"></script>
	<script src="${ctxStatic}/jquery-ztree/3.5.12/js/jquery.ztree.excheck-3.5.min.js" type="text/javascript"></script>
	<script src="${ctxStatic}/jquery-ztree/3.5.12/js/jquery.ztree.exhide-3.5.min.js" type="text/javascript"></script>
	<link rel="stylesheet" href="${ctxStatic}/sbShop/css/build.css">
	<style>
        .check{position: fixed;top:0;left: 0;right: 0;bottom: 0;background: rgba(0,0,0,0.3);z-index: 10000}
        .check-box{width: 750px;background: #ffffff;position: absolute;top: 50%;left: 50%;margin-left: -375px;margin-top: -200px;}
        .check-box>p{height: 35px;line-height: 35px;background: #f0f0f0;position: relative;text-align: center}
        .check-box>p img{position: absolute;top:12px;right: 15px;cursor: pointer}
        .check-box ul{overflow: hidden;padding: 10px;outline:none;list-style:none}
        .check-box ul li.checkbox{float: left;width: 30%;line-height: 30px;margin-top: 0;}
        .check-box ul li.checkbox input{position:relative;left:8px}
        .check-btn{text-align: center;padding-bottom: 20px}
        .check-btn a{display: inline-block;width: 80px;height: 30px;line-height: 30px;border-radius: 5px;border: 1px solid #dcdcdc}
        .check-btn a:nth-child(1){background: #68C250;border: 1px solid #68C250;color: #ffffff;margin-right: 5px}
        .check-btn a:nth-child(2){color: #666666;margin-left: 5px}
        .check-box .checkbox input[type="checkbox"]:checked + label::before {
            background: #68C250;
            top:0 px;
            border: 1px solid #68C250;
        }
        .check-box .checkbox label::before{
            top: 0px;
        }
        .check-box .checkbox i{
            position: absolute;
            width: 12px;
            height: 8px;
            background: url(../images/icon_pick.png) no-repeat;
            top: 4px;
            left: -18px;
            cursor: pointer;
        }
        .check-box .checkbox input{top: 10px;position:relative}
    </style>
	<script type="text/javascript">
	 $(function(){
		 	$('.check1').hide();
	    	$('body').on('click','.check-a1',function(){
	    		$('.check1').show();
	    	});
	    	
	    	$('body').on('click','.check-del1',function(){
	    		$('.check1').hide();
	    	});
	     });
		/* $(document).ready(function() {
			$("#btnExport").click(function(){
				top.$.jBox.confirm("确认要导出用户数据吗？","系统提示",function(v,h,f){
					if(v=="ok"){
						$("#searchForm").attr("action","${ctxsys}/User/export");
						$("#searchForm").submit();
					}
				},{buttonsFocus:1});
				top.$('.jbox-body .jbox-icon').css('top','55px');
			});
			$("#btnImport").click(function(){
				$.jBox($("#importBox").html(), {title:"导入数据", buttons:{"关闭":true}, 
					bottomText:"导入文件不能超过5M，仅允许导入“xls”或“xlsx”格式文件！"});
			});
		}); */
		function page(n,s){
			if(n) $("#pageNo").val(n);
			if(s) $("#pageSize").val(s);
			$("#searchForm").attr("action","${ctxsys}/User/supplyList");
			$("#searchForm").submit();
	    	return false;
	    }
	     var usercId;
       function byStatus(userId,status){
	    var msg="";
	     usercId=userId;
		if(status==1){
		  msg="是否把该用户禁用";
		}else{
		  msg="是否把该用户启用";
		}
	    confirmx(msg,byUstatus);
	   }
	    function byUstatus(){
	      $.ajax({
			    type : "POST",
			    data:{userId:usercId},
			    url:"${ctxsys}/User/byStatus",   
			    success : function (data) {
			     alertx("操作成功");
			     page();
			    }
	         });
	    }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctxsys}/User/supplyList">供应商列表</a></li>
		<shiro:hasPermission name="merchandise:user:edit"><li><a href="${ctxsys}/User/supplyuseredit">供应商添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="ebUser" action="${ctxsys}/User" method="post" class="breadcrumb form-search ">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
	<%-- 	<c:set var="sysuser" value="${fns:getSysUser()}"/> --%>
		<ul class="ul-form">
			<li><label>关键字：</label><form:input path="username" htmlEscape="false" maxlength="50" class="input-medium"/></li>
			<li><label>用户手机：</label><form:input path="mobile" htmlEscape="false" maxlength="50" class="input-medium"/></li>
			<li><label>用户状态：</label>
			<form:select path="status">
			  <form:option value="">全部</form:option> 
			  <form:option value="1">正常</form:option>
			  <form:option value="2">禁用</form:option>
			</form:select>
			</li>
			<li><label></label><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/>
			</li>
		</ul>
	</form:form>
	<tags:message content="${message}"/>
	<div style="margin:0 auto;overflow-x:auto">
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead><tr>
		<th class="center123">编号</th>
		<th class="center123">账号</th>
		<th class="center123">供应商公司名称</th>
		<th class="center123">供应商门店名称</th>
		<th class="center123">联系人</th>
		<th class="center123">联系电话/手机</th>
		<th class="center123 sort-column isOptimization">是否优选供应商</th>
		<th class="center123 sort-column supplyName">添加人</th>
		<th class="center123 sort-column supplyDate">添加时间</th>
		<th class="center123">添加备注</th>
		<shiro:hasPermission name="merchandise:user:edit">
		<th class="center123">供应商状态</th>
		</shiro:hasPermission>
		<shiro:hasPermission name="merchandise:user:edit">
		<th class="center123">操作</th>
		</shiro:hasPermission>
		</tr></thead>
		<tbody>
		<c:forEach items="${page.list}" var="userList" varStatus="status">
			<tr>
			    <td class="center123">${status.index+1}</td>
				<td class="center123">${userList.mobile}</td>
				<td class="center123">${userList.pmShopInfoShopIdSmallB.companyName}</a></td>
				<td class="center123">${userList.pmShopInfoShopIdSmallB.shopName}</td>
				<td class="center123">${userList.pmShopInfoShopIdSmallB.contactName}</td>
				<td class="center123">${userList.pmShopInfoShopIdSmallB.mobilePhone}</td>
				<td class="center123"><c:if test="${userList.pmShopInfoShopIdSmallB.isOptimization==0}">否</c:if><c:if test="${userList.pmShopInfoShopIdSmallB.isOptimization==1}"><font color="green">是</font></c:if></td>
				<td class="center123">${userList.pmShopInfoShopIdSmallB.createUser}</td>
				<td class="center123"><fmt:formatDate value="${userList.pmShopInfoShopIdSmallB.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				<td class="center123">${userList.pmShopInfoShopIdSmallB.onlineStatus}</td>
				<shiro:hasPermission name="merchandise:user:edit">
				<td class="center123"><c:if test="${userList.status==1}">正常</c:if><c:if test="${userList.status==2}">禁用</c:if>|<c:if test="${userList.status==2}">
				<a onclick="byStatus('${userList.userId}','${userList.status}')" >正常</a></c:if><c:if test="${userList.status==1}"><a onclick="byStatus('${userList.userId}','${userList.status}')" >禁用</a></c:if></td> 
				</shiro:hasPermission>
				<shiro:hasPermission name="merchandise:user:edit">
				<td class="center123">
    				<a href="${ctxsys}/User/supplyuseredit?userId=${userList.userId}">修改</a>
				</td>
				</shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	</div>
	
		
	<div class="pagination">${page}</div>
	
	
	</script>
</body>
</html>