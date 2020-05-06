<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0,minimal-ui">
    <meta name="Description" content="${fns:getProjectName()},积分明细"/>
	<meta name="Keywords" content="${fns:getProjectName()},积分明细"/>
    <title>更换代理关系</title>
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/bootstrap.min.css">
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/admin-member-account.css">
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/bootstrap.min.css">
    <script src="${ctxStatic}/bootstrap/2.3.1/js/bootstrap.min.js" type="text/javascript"></script>
    <script src="${ctxStatic}/sbShop/js/jquery.min.js"></script>
    <script src="${ctxStatic}/common/jqsite.js" type="text/javascript"></script>
    <style>
    	.listy{background:#fff;padding:20px;}
    	.listy li{line-height:30px;border:1px solid #dcdcdc;border-bottom:none;float:left;width:50%}
    	.listy li:last-child{border-bottom:1px solid #dcdcdc;}
    	.listy li span{display:inline-block;width:100px;text-align:right;margin-right:10px}
    	.listy li input{line-height:normal}
    	body .btn{padding: 3px 12px;border-color:#69AC72}
    </style>
</head>
<body>
    <div class="c-context">
        <ul class="nav-ul">
            <li><a href="${ctxsys}/User/form?userId=${userId}">会员信息</a></li>
            <li><a href="${ctxsys}/User/userAccount?userId=${userId}">会员账户</a></li>
            <li><a href="${ctxsys}/User/userrelation?userId=${userId}">会员关系</a></li>
        	<li><a class="active" href="${ctxsys}/User/sysShow?userId=${userId}">更换用户代理</a>
        	    <a href="${ctxsys}/User/userAccount?userId=${userId}"><img class="balance-img" src="${ctxStatic}/sbShop/images/xxx-rzt.png" alt=""></a>
        	</li>
        </ul>
        <from id="fromId" >
	        <div class="control-group">	
	        	<ul class="listy">
	        		<li><span>用 户 名 称:</span> ${ebUser.username}</li>
	        		<li><span>用户手机号: </span>${ebUser.mobile}</li>
	        		<li><span>所 属 代 理: </span>${sysOffice.name}</li>
	        		<!-- 选择的用户id -->
	        		<input id="sysId" name="sysId" value="" readonly="readonly" type="hidden"/>
	        		<!-- 选择的用户名称 -->
	        		<li><span>请选择代理:</span><input id="sysname" type="text" name="sysname" value="" class="input-medium" readonly="readonly" onclick="windowOpen('${ctxsys}/sys/user/openDaililist?office.isAgent=1&company.isAgent=1&office.grade=3','代理用户选择','700','400')" /></li>
	        		<li><span></span></li>
	        		<li><span></span><a class="btn btn-primary" id="sub" style="background:#69AC72" >确定</a></li>
	        	</ul>
	        </div>
	      </from>
	      
	      <script type="text/javascript">
	       function sub(){
	          if(){
	          
	          }
	       }
	      </script>
    </div>
</body>
</html>