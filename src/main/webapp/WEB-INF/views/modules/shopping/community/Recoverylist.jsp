<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>商品列表</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
		getProvince();
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").attr("action","${ctxsys}/EbInvitation/Recoverylist");
			$("#searchForm").submit();
	    	return false;
	    }
	    function getProvince(){
	    	var url="${ctxsys}/EbCircles/getpList";
		    $.getJSON(url,function(data){callbackfunProvince(data)});
		}
		function callbackfunProvince(jsonObj){
			var ebCircles=jsonObj.ebCircles;
			var str="<option value=''>-选择圈子-</option>"; 
			var a=$("#circlesId").val();
			if(ebCircles!=undefined){
				$.each(ebCircles,function(i,pro){
					if(a==pro.id){
					   str+="<option  value='"+pro.id+"' selected='selected'>"+pro.circlesName+"</option>";
					}else{
					   str+="<option  value='"+pro.id+"'>"+pro.circlesName+"</option>";
					}
				});
			}
		  $("#circlesId").html(str);
		}
	    function  radios(id,val){
		 $.ajax({
		    url: '${ctxsys}/EbInvitation/ralue',
		    type: 'POST',
		    cache: false,
		    data: {"id":id,"val":val},
		     success: function (data){//上传成功
			     if(data=="00"){
				     if(val=="1"){
				        $("#"+id+"_0").removeAttr('checked');
				     }
				     if(val=="0"){
				        $("#"+id+"_1").removeAttr('checked');
				     }
			      }
                }
             });
		 }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctxsys}/EbInvitation/Recoverylist">帖子列表</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="ebInvitation" action="${ctxsys}/EbInvitation/Recoverylist" method="post" class="breadcrumb form-search ">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form">
		<li><form:select path="circlesId" id="circlesId" class="input-medium" value="${ebInvitation.circlesId}" htmlEscape="false" maxlength="100">
            <option value="${circlesId}"></option>
            </form:select>
        </li>
        <li><form:select class="input-medium" id="state" path="state">
        <option value="">请选择</form>
        <form:option value="1">审核通过</form:option>
        <form:option value="2">待审核</form:option>
        <form:option value="3">(app隐藏)</form:option>
        <form:option value="4">不通过</form:option></form:select></li>
        <li><form:input path="invitationTitle" class="input-medium" placeholder="请输入关键字" htmlEscape="false" maxlength="50"/></li>
        <li><input class="input-medium" type="text"  name="statetime" id="create_time_start" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" value="${statetime}" placeholder="请输入开始时间"/>--
		<input class="input-medium" type="text" name="stoptime" id="stoptime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"  value="${stoptime}" placeholder="请输入结束时间"/></li>
		<li><input class="input-medium" type="text" name="moble" placeholder="手机号" htmlEscape="false" maxlength="50" value="${moble}"/></li>
        <li><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/></li>
		</ul>
	</form:form>
	<tags:message content="${message}"/>
	<table id="treeTable" class="table table-striped table-condensed">
		<tr><th></span><span>编号</span></th><th>帖子标题</th><th>帖子内容</th><th>发帖人</th><th class="sort-column time">发帖时间</th><th>品论数</th><th>打赏数</th><th>圈子名称</th><th>状态</th><th>是否置顶</th><shiro:hasPermission name="merchandise:community:edit"><th>操作</th></shiro:hasPermission></tr>
		<c:forEach items="${page.list}" var="ebInvitationList" varStatus="status">
			<tr>
			    <td> ${status.index+1}</td>
				<td>
				<c:choose>
			    <c:when test="${fn:length(ebInvitationList.invitationTitle) >= 10}">
			       ${fn:substring(ebInvitationList.invitationTitle,0,10)}……
			     </c:when>
			     <c:otherwise> 
			      ${ebInvitationList.invitationTitle}
			     </c:otherwise>
			 </c:choose>
				</td>
				<td>
				<c:choose>
			    <c:when test="${fn:length(ebInvitationList.invitationContent) >= 10}">
			       ${fn:substring(ebInvitationList.invitationContent,0,10)}……
			     </c:when>
			     <c:otherwise> 
			       ${ebInvitationList.invitationContent}
			     </c:otherwise>
			 </c:choose>
				</td>
				<td>${ebInvitationList.ebUser.username}</td>
				<td>${ebInvitationList.time}</td>
				<td>${ebInvitationList.commentNum}</td>
				<td>${ebInvitationList.tipNum}</td>
				<td>${ebInvitationList.ebCircles.circlesName}</td>
				<td><c:if test="${ebInvitationList.state==1}">审核通过</c:if><c:if test="${ebInvitationList.state==2}">待审核</c:if><c:if test="${ebInvitationList.state==3}">(app隐藏)</c:if><c:if test="${ebInvitationList.state==4}">审核不通过</c:if></td>
			    <td><input type="radio" value="0" id="${ebInvitationList.id}_0" onclick="radios(${ebInvitationList.id},0)" <c:if test="${ebInvitationList.isStickied==0}">checked="checked"</c:if>/>否  <input type="radio" id="${ebInvitationList.id}_1" value="1" onclick="radios(${ebInvitationList.id},1)" <c:if test="${ebInvitationList.isStickied==1}">checked="checked"</c:if>/>是 </td>
			    <shiro:hasPermission name="merchandise:community:edit">
			     <td>
					<a href="${ctxsys}/EbInvitation/form?id=${ebInvitationList.id}">修改</a>
					<a href="${ctxsys}/EbInvitation/delete?id=${ebInvitationList.id}" onclick="return confirmx('要删除该区域及所有子区域项吗？', this.href)">删除</a>
				</td>
				</shiro:hasPermission>
			</tr>
		</c:forEach>
	</table>
	<div class="pagination" >${page}</div>
</body>
</html>