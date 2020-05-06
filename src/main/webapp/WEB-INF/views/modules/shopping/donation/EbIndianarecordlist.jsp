<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>商品列表</title>
	<meta name="decorator" content="default"/>
	<%@include file="/WEB-INF/views/include/treetable.jsp" %>
		<link rel="stylesheet" type="text/css" href="${ctxStatic}/bounced/css/xcConfirm.css"/>
		<script src="${ctxStatic}/bounced/js/jquery-1.9.1.js" type="text/javascript" charset="utf-8"></script>
		<script src="${ctxStatic}/bounced/js/xcConfirm.js" type="text/javascript" charset="utf-8"></script>
	<style type="text/css">
	 .ul-form li{margin: 5px;}
	 .operating { margin: 5px; margin-left: 20px;}
	</style>
	
	<script type="text/javascript">
	    	function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").attr("action","${ctxsys}/EbIndianarecord/list");
			$("#searchForm").submit();
	    	return false;
	         }
	         function examine(id){
	    	 $.ajax({
		    url: '${ctxsys}/EbIndianarecord/ralue',
		    type: 'POST',
		    cache: false,
		    data: {"id":id},
		     success: function (data){//上传成功
		      console.log(data);
		             var txt="";
		             var mun=0;
	                  for(var i in data.lotterynumbers){
	                       mun++;
		 					var list=data.lotterynumbers[i];
		 					console.log(list.lucky);
		 					if(list.lucky==1){
		 					txt+="<span  style='color:#3299CC'>"+list.numbersId+"</span>   ";
		 					}else{
		 					txt+="<span>"+list.numbersId+"</span>   ";
		 					}
		 					 console.log(list.numbersId);
		 	             }
		 	            var option = {
						title: "抽奖码"+mun+"次数 ",
						btn: parseInt("0014",5),
						onOk: function(){
							console.log("确认啦");
						}
					}
					window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.success, option);
                }
             });
			
	        }
		   $(document).ready(function() { 
		
			});
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctxsys}/EbIndianarecord/list?objectId=${objectId}">夺宝记录列表</a></li>
		<li ><a href="${ctxsys}/EbIndianarecord/form?objectId=${objectId}">添加夺宝记录</a></li>
	</ul>
	 <form:form id="searchForm" modelAttribute="ebIndianarecord" action="${ctxsys}/EbIndianarecord/list" method="post" class="breadcrumb form-search ">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
		<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form">
		   <li><form:input path="objectId" type="hidden" value="${objectId}"/></li>
		    <li><form:input path="ebUser.username"  placeholder="请输入用户名"/></li>
			<li><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/></li>
		</ul>
	</form:form> 
	<tags:message content="${message}"/>
	<table id="treeTable" class="table table-striped table-condensed">
		<tr><th><span>编号</span></th><th>用户名</th><th>投入金额</th><th>支付状态</th><th>是否真实</th><th>支付类型</th><shiro:hasPermission name="merchandise:sales:edit"><th>操作</th></shiro:hasPermission></tr>
		<c:forEach items="${page.list}" var="EbIndianarecordlist" varStatus="status">
			<tr>
			    <td>${status.index+1}</td>
				<td><a href="${ctxsys}/User/check?userId=${EbIndianarecordlist.ebUser.userId}">${EbIndianarecordlist.ebUser.username}<c:if test="${EbIndianarecordlist.lucky==1}">--中奖</c:if></a></td>
				<td>${EbIndianarecordlist.money}</td>
				<td><c:if test="${EbIndianarecordlist.payStatus==0}">未支付</c:if><c:if test="${EbIndianarecordlist.payStatus==1}">已支付</c:if></td>
				<td><span><c:if test="${EbIndianarecordlist.trueFlse==1}">真</c:if><c:if test="${EbIndianarecordlist.trueFlse!=1}">假</c:if></span></td>
				<td><c:if test="${EbIndianarecordlist.payType==3}">微信</c:if><c:if test="${EbIndianarecordlist.payType==2}">支付宝</c:if><c:if test="${EbIndianarecordlist.payType==1}">银联</c:if></td>
			    <td><shiro:hasPermission name="merchandise:sales:edit">
			  		<span onclick="examine('${EbIndianarecordlist.id}')">查看抽奖码</span>
					<%-- <a href="${ctxsys}/EbIndianarecord/form?id=${EbIndianarecordlist.id}">修改</a>
					<a href="${ctxsys}/EbIndianarecord/delete?id=${EbIndianarecordlist.id}" onclick="return confirmx('要删除该区域及所有子区域项吗？', this.href)">删除</a> --%>
				  </shiro:hasPermission>
				</td>
			</tr>
		</c:forEach>
	</table>
	<div class="pagination">${page}</div>
</body>
<script type="text/javascript">
 
</script>
</html>