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
			$("#searchForm").attr("action","${ctxsys}/EbCircles/form");
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
			$("#upload").click(function(){
		 var a;
		var formData = new FormData();
		formData.append('file', $('#file')[0].files[0]);
		$.ajax({
		    url: '${ctxsys}/Product/pohotupload',
		    type: 'POST',
		    cache: false,
		    data: formData,
		     success: function (data){//上传成功
		     a=data;
		     if(a!=""){
		     $("#poth").css({
		      "background-image":"url('"+a+"')",
              "background-size":"100% 100%",
              "background-repeat":"no-repeat",
		     });
		     $("#poth").append("<span id='ju'><input type='hidden' name='pothname' value='"+a+"'/></span>");
             }else{
             alert("请选择上传的图片");
             }
              },
		    processData: false,
		    contentType: false
		}).done(function(res) {

		}).fail(function(res) {
	
		});
            });
			
		});
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li ><a href="${ctxsys}/EbCircles/list">圈子列表</a></li>
		<shiro:hasPermission name="merchandise:community:edit"><li class="active"><a href="${ctxsys}/EbCircles/form">圈子添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="inputForm" modelAttribute="ebCircles" action="${ctxsys}/EbCircles/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<tags:message content="${message}"/>
		<table id="treeTable" class="table table-striped " style=" width:46%; margin-right:30px; float: left;">
			<tr >
			    <td colspan="2" style="text-align: center;"><h5>圈子详情</h5></td>
			</tr>
			<tr >
			    <td id="poth" colspan="2" style=" width:100%; height:200px; background-image: url('${ebCircles.circlesImg}'); background-size:100% 100%; background-repeat:no-repeat;"></td>
			</tr>
			<tr>
			    <td>上传图片</td>
				<td><input id="file" type="file" name="filename" value="${ebCircles.circlesImg}"/><button id="upload" type="button">上传</button></td>
			</tr>
			<tr>
			    <td>圈子名称:</td>
				<td><form:input path="circlesName" size="100"/></td>
			</tr>
			<tr>
			    <td>圈子介绍</td>
				<td><form:textarea path="circlesRecommend" id="circlesRecommend" style=" width:53%;resize: none;height: 122px;"/></td>
			</tr>
			<tr>
			    <td>圈子状态</td>
				<td><form:select path="state"><form:option value="0">显示</form:option><form:option value="1">隐藏</form:option></form:select></td>
			</tr>
			<tr  style=" height:70px;">
			    <td></td>
				<td ><shiro:hasPermission name="merchandise:community:edit">
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;
				<a href="${ctxsys}/EbInvitation/list?CirclesId=${ebCircles.id}" class="btn btn-primary" >查看圈子动态</a>&nbsp;
			</shiro:hasPermission><input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/></td>
			</tr>
	</table>
	</form:form>
	 <form:form id="searchForm" modelAttribute="ebCircles"  action="${ctxsys}/EbCircles/form" method="post" class="">
		<form:hidden path="id"/>
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
		<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
	
	<table id="treeTable" class="table table-striped" style="width:46%; float: left;">
		     <tr>
			    <td colspan="4" style="text-align: center;"><h5>圈子用户</h5></td>
			</tr>
		<tr><th></span><span>编号</span></th><th>用户头像</th><th>用户名</th><shiro:hasPermission name="merchandise:community:edit"><th>操作</th></shiro:hasPermission></tr>
			<c:forEach var="ebCircleslist" items="${page.list}">
			<tr>
			    <td>${ebCircleslist.id}</td>
				<td><img src="${ebCircleslist.userPortrait}" style=" width: 40px;" alt="..." class="img-circle"></td>
				<td>${ebCircleslist.userName}</td>
				<td><a href="${ctxsys}/User/form?id=${user.userId}">查看</a></td>
			</tr>
			</c:forEach>
			<tr><td colspan="4"><div class="pagination">${page}</div></td></tr>	
	</table>

	</form:form>
</body>
</html>