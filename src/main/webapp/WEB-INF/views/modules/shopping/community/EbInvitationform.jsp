<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>菜单管理</title>
	<meta name="decorator" content="default"/>
	<%@include file="/WEB-INF/views/include/treetable.jsp" %>
	<script type="text/javascript">
	function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").attr("action","${ctxsys}/EbInvitation/form");
			$("#searchForm").submit();
	    	return false;
	    }
	    $("#treeTable").treeTable({expandLevel : 5});
		$(document).ready(function() {
			$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});
		   var state=$("#state").val();
		   stateFun(state);
		});
		function stateFun(state){
			  if(state=='4'){
			   $("#errLog").show();
			    }else{
			    $("#errLog").hide();
			  }
		
		}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li ><a href="${ctxsys}/EbInvitation/list?CirclesId=${ebInvitation.circlesId}">帖子列表</a></li>
		<shiro:hasPermission name="merchandise:community:edit"><li class="active"><a href="${ctxsys}/EbInvitation/form?CirclesId=${ebInvitation.circlesId}">帖子添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="inputForm" modelAttribute="ebInvitation" action="${ctxsys}/EbInvitation/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<tags:message content="${message}"/>
		<table id="treeTable" class="table table-striped " style=" width:46%; margin-right:30px; float: left;">
			<tr >
			    <td colspan="2" style="text-align: center;"><h5>帖子详情</h5></td>
			</tr>
			<tr>
			    <td>帖子标题</td>
				<td><form:input path="invitationTitle" size="100"/></td>
			</tr>
			<tr>
			    <td>帖子内容</td>
				<td>${ebInvitation.invitationContent}</td>
			</tr>
			  <tr>
			    <td>发帖时间</td>
				<td><input class="small"  name="time" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" value="<fmt:formatDate value='${ebInvitation.time}' type='date' pattern='yyyy-MM-dd HH:mm:ss'/>" >  
			</td>
			</tr>
			<tr>
			    <td>品论数:</td>
				<td><form:input path="commentNum" size="100"/></td>
			</tr>
			<tr>
			    <td>点赞数:</td>
				<td><form:input path="praiseNum" size="100"/></td>
			</tr>
			<tr>
			    <td>打赏数:</td>
				<td><form:input path="tipNum" size="100"/></td>
			</tr>
			<tr >
			    <td>地理位置:</td>
				<td><form:input path="LocationDescribe" size="100"/></td>
			</tr>
			<tr >
			    <td>圈子状态</td>
				<td><form:select id="state" path="state" onchange="stateFun(this.value)"><form:option value="1">审核通过</form:option><form:option value="2">待审核</form:option><form:option value="3">app隐藏</form:option><form:option value="4">不通过</form:option></form:select></td>
			</tr>
			<tr id="errLog">
			    <td>不通过原因</td>
				<td><form:textarea path="errLog" id="errLog" style=" width:53%;resize: none;height: 100px;"/></td>
			</tr>
			<tr>
			    <td>图片:</td>
				<td>
								 <c:forEach items="${ebProductimage}" var="ebProductimageList" varStatus="stauts">
	                 	          <a id="example${stauts.index+1}" href="http://manager.cs-qw.com${ebProductimageList.name}"><img width="70px;" height="50px;" src="http://manager.cs-qw.com${ebProductimageList.name}" /></a>
	                  <%-- <a id="example${stauts.index+1}" href="http://manager.cs-qw.com${ebProductimageList.name}"><img width="70px;" height="50px;" src="http://manager.cs-qw.com${ebProductimageList.name}" /></a>
	                              --%></c:forEach>
				</td>
			</tr>
			<tr>
			    <td></td>
				<td><shiro:hasPermission name="merchandise:community:edit">
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;
			</shiro:hasPermission><input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/></td>
			</tr>
	</table>
	</form:form>
	
	<table id="treeTable" class="table table-striped" style="width:46%; float: left;">
		      <tr>
			    <td colspan="4" style="text-align: center;"><h5>回复列表</h5></td>
			</tr>
		      <tr>
			    <td colspan="4" style="text-align: center;">
			     <form:form id="searchForm" modelAttribute="ebInvitation"  action="${ctxsys}/EbInvitation/form" method="post" class=" breadcrumb form-search ">
					<form:hidden path="id"/>
					<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
				    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
					<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
				     <ul class="ul-form">
					    <li><input name="replypepoleName" value="${replypepoleName}"   placeholder="请输入姓名" style="height: 23px;"/> </li>
				        <li><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/></li>
		     		</ul>	
		     		 </form:form>
		        </td>
			</tr>
		    
		<tr><th><span>用户头像</span></th><th>回帖人</th><th>内容</th><shiro:hasPermission name="merchandise:community:edit"><th>操作</th></shiro:hasPermission></tr>
			<c:forEach var="ebReplylist" items="${page.list}">
			<tr>
				<td><img src="${ebReplylist.ebUser.avataraddress}" style=" width: 40px;" alt="..." class="img-circle"></td>
				<td>${ebReplylist.ebUser.username}</td>
				<td>
				<c:choose>
			    <c:when test="${fn:length(ebReplylist.replyContent) >= 10}">
			       ${fn:substring(ebReplylist.replyContent,0,10)}……
			     </c:when>
			     <c:otherwise> 
			     ${ebReplylist.replyContent}
			     </c:otherwise>
			   </c:choose>
				</td>
				<td><a href="${ctxsys}/EbReply/form?id=${ebReplylist.id}">查看</a><a href="${ctxsys}/EbReply/delete?id=${ebReplylist.id}">删除</a></td>
			</tr>
			</c:forEach>
			<tr><td colspan="4"><div class="pagination">${page}</div></td></tr>	
	</table>
</body>
</html>