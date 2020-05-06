<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<meta name="decorator" content="default"/>
	<title>银行卡列表</title>
	<style type="text/css">
	p{margin: 0;}
        .lishi{display:none;position: fixed;top: 0;left: 0;right: 0;bottom: 0;background: rgba(0,0,0,0.3);}
        .lishi-box{border:3px solid #69AC72;position: absolute;width: 450px;height: 300px;background: #ffffff;border-radius: 5px;top: 50%;left: 50%;margin-left: -225px;margin-top: -150px}
        .lishi-box>p{background:#69AC72;line-height: 39px;height: 39px;color: #fff;padding: 0 20px;border-bottom: 1px solid #e5e5e5;font-size: 16px;margin: 0;}
        .lishi-box>p img{float: right;margin-top: 14px;cursor: pointer}
        .lishi-div{height: 300px;overflow-y:auto; color: #000}
        .lishi-body{padding: 20px;}
        .lishi-body>p{height: 30px;line-height: 30px;margin-bottom: 15px}
        .lishi-body>p i{width: 30px;height: 30px;text-align: center;line-height: 30px;border-radius: 50%;border: 1px solid #e5e5e5;float: left}
        .lishi-body>p i img{border-radius: 50%;width:100%}
        .lishi-body>p b{font-weight: normal; color: #529E5C;margin-left: 10px}
        .lishi-body>p span{float: left;color: #000}
        .lishi-body u{display: inline-block;width: 160px;height: 160px;line-height: 160px;text-align: center;overflow: hidden;margin-right: 1px}
        .lishi-body>div{margin-bottom: 10px;font-size: 14px;}
        .lishi-body>div>span:nth-child(1){width:30%;text-align:right;display:inline-block;}
    </style>
	<script type="text/javascript">
	function page(n,s){
		var phoneNum=$("#phoneNum").val();
		//if(phoneNum!=""&&!/^[1][345678][0-9]{9}$/.test(phoneNum)){
		//	alert("电话号码格式错误!");
		//	return false;
		//}
		$("#pageNo").val(n);
		$("#pageSize").val(s);
		$("#searchForm").attr("action","${ctxsys}/pmAgentBank");
		$("#searchForm").submit();
	    return false;
	}
	function timeStamp2String (time){
		var datetime = new Date();
	    datetime.setTime(time);
	    var year = datetime.getFullYear();
	    var month = datetime.getMonth() + 1;
	    var date = datetime.getDate();
	    var hour = datetime.getHours();
	    var minute = datetime.getMinutes();
	    var second = datetime.getSeconds();
	    var mseconds = datetime.getMilliseconds();
	    return year + "-" + month + "-" + date+"&nbsp;&nbsp;"+hour+":"+minute+":"+second;
	};
	$(function(){
		$('body').on('click','.lishi-del',function(){
			$('.lishi').hide();
		})
	})
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctxsys}/pmAgentBank">银行卡列表</a></li>
		<li><a href="${ctxsys}/pmAgentBank/form">银行卡添加</a></li>
	</ul>
	 <form id="searchForm" modelAttribute="pmAgentBank" method="post" class="breadcrumb form-search ">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
		<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form">
			<li><label>手机号:</label><form:input path="pmAgentBank.phoneNum" type="number" htmlEscape="false" maxlength="50" class="input-medium"  placeholder="手机号"/></li>
			<li><label>银行账号:</label><form:input path="pmAgentBank.account" type="number" htmlEscape="false" maxlength="50" class="input-medium"  placeholder="银行账号"/></li>
		    <li><label></label><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/></li>
		</ul>
	</form> 
	<tags:message content="${message}"/>
	<table id="treeTable" class="table table-striped table-condensed table-bordered">
		<tr>
		 <th>开户名</th>
		 <th>交易银行账号</th>
		 <th>银行名称</th>
		 <th>开户地址</th>
		 <th>银行类型</th>
		 <th>开户国家</th>
		 <th>银行预留手机号</th>
		 <th>所属支行 </th>
		 <th>创建时间 </th>
		 <th>操作 </th>
		</tr>
		<c:forEach items="${page.list}" var="pb">
			<tr>
				<td>${pb.accountName}</td>
			    <td>${pb.account}</td>
			    <td>${pb.bankName}</td>
			    <td>${pb.districtName}</td>
			    <td>	
					<c:if test="${pb.bankType==0}">银行卡</c:if>
					<c:if test="${pb.bankType==1}">支付宝</c:if>
				</td>
			    <td>${pb.countryName}</td>
			    <td>${pb.phoneNum}</td>
			    <td>${pb.subbranchName}</td>
			    <td><fmt:formatDate value="${pb.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
			    <td><a href="${ctxsys}/pmAgentBank/form?id=${pb.id}">修改</a>&nbsp;&nbsp;
			    <a onclick="return confirmx('是否删除','${ctxsys}/pmAgentBank/delete?id=${pb.id}')">删除</a></td>
			</tr>
		</c:forEach>
	</table>
	<div class="pagination">${page}</div>
	<div class="lishi"></div>
</body>
</html>