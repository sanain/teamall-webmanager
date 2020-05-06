<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>商品添加</title>
	<meta name="decorator" content="default"/>
	<%@include file="/WEB-INF/views/include/treetable.jsp" %>
		<link rel="stylesheet" type="text/css" href="${ctxStatic}/bounced/css/xcConfirm.css"/>
		<script src="${ctxStatic}/bounced/js/xcConfirm.js" type="text/javascript" charset="utf-8"></script> 
  <script type="text/javascript">
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
		});
	 	function btin(){
			var model= $("#model").val();
			var productNo= $("#productNo").val();
			  $.ajax({
			     url: '${ctxsys}/User/ralue',
			     type: 'POST',
			     cache: false,
			     data: {"model":model},
			     success: function (data){
			         if(data=='00'){
			          $.ajax({
					     url: '${ctxsys}/Product/ralue',
					     type: 'POST',
					     cache: false,
					     data: {"productNo":productNo},
					     success: function (data){
					         if(data=='00'){
						          $("#inputForm").submit();
						          return true;  
			         	 	  }else{
				            	var txt="未找商品编号为  <span style='color:red'>"+productNo+"</span>商品！";
						       window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
						       return false;  
					            }
					        }
					     });
			              }else{
			              	var txt="未找手机号为  <span style='color:red'>"+model+"</span>该用户！";
						       window.wxc.xcConfirm(txt, window.wxc.xcConfirm.typeEnum.info);
						       return false;  
			            }
			        }
			     });
			 } 
	function deleteimg(img){
	    var a=$(img).prev().val();
	   if(a!=""&&a!=null){
	   $.ajax({
		    url:"${ctxsys}/Product/deleteimg",
		    type: 'POST',
		    cache: false,
		    data: {img:a},
		     success: function (data){//上
		     }
	   });
	    }
	   $(img).parent().parent().remove();
	   }
					
	 	</script>
</head>
<body>
 
     <ul class="nav nav-tabs">
		<shiro:hasPermission name="merchandise:pcomment:view"><li><a href="${ctxsys}/ebPcommentContorller">评论列表</a></li></shiro:hasPermission>
	    <li class="active"><a href="${ctxsys}/ebPcommentContorller/form?id=${ebProductcomment.commentId}">评论<shiro:hasPermission name="merchandise:pcomment:edit">${not empty ebProductcomment.commentId?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="merchandise:pcomment:view">查看</shiro:lacksPermission></a></li>
	</ul>
	<form:form  id="inputForm" modelAttribute="ebProductcomment"  action="${ctxsys}/ebPcommentContorller/save" method="post" class="form-horizontal">
	 <form:hidden path="commentId"/>
	<tags:message content="${message}"/>
	
	<div class="control-group">
			<label class="control-label">评论用户的手机号:</label>
			<div class="controls">
		    <input type="text" name="userName" id="model" onblur="modelr()">
			</div>
			</div>
	<div class="control-group">
			<label class="control-label">评论商品编号:</label>
			<div class="controls">
			<input type="text" name="productNo"  id="productNo" onblur="modelr()">
			</div>
			</div>
	<div class="control-group">
			<label class="control-label">图片上传:</label>
					<div class="controls">
					<div id="uploadForm">
		          			<input id="file" type="file"/><button id="upload" type="button">上传</button>
		          			</div>
					</div>
			</div>
	<div class="control-group">
	       <label class="control-label">评论图片:</label>
			   <div class="controls" id="poth" style="padding-bottom: 10px;">
					    <c:forEach items="${ebProductimages}" var="ebimg">
											<dl style=" float: left; width: 100px; height: 100px;" >
											<dt style="margin: 10px;"><img width="70px;" height="50px;" alt="" src="${ebimg.name}"></dt>
											<dd style="text-align: center; margin: 9px;"><input type="hidden" name="${ebimg.id}" value="${ebimg.id}"/><a href="#" onclick="deleteimg(this)">删除</a></dd>
											</dl>
						</c:forEach>
					</div>
			</div>
		<div class="control-group">
			<label class="control-label">用户评论内容:</label>
			<div class="controls">
			<textarea name="contents" id="contents" style="width:20%"></textarea>
			<%-- ${ebProductcomment.contents} --%>
			</div>
			</div>
	<%-- 	<div class="control-group">
			<label class="control-label">回复评论内容:</label>
			<div class="controls">
			<form:textarea path="recontents" htmlEscape="false" maxlength="50" class="required"/>
			</div>
			</div> --%>
		<div class="control-group">
			<label class="control-label">评论时间:</label>
			<div class="controls">
			<input class="small" type="text" name="commentTime" id="create_time_start" onfocus="WdatePicker()" value="${ebProductcomment.commentTime}" />
			</div>
			</div>
		<div class="control-group">
			<label class="control-label">评论的分数:</label>
			<div class="controls">
			<input type="text" name="point">
			<%-- <form:input path="point" htmlEscape="false" maxlength="50" class="required"/> --%>
			</div>	
			</div>
			<div class="control-group">
			<label class="control-label">是否匿名:</label>
			<div class="controls">
			<input type="radio" name="isni" checked="checked" value="0">否<input type="radio" name="isni" value="1">是
			<%-- <form:input path="point" htmlEscape="false" maxlength="50" class="required"/> --%>
			</div>	
			</div>
    <div class="control-group">
			<label class="control-label"></label>
			<div class="controls">
			<shiro:hasPermission name="merchandise:pcomment:edit">
			<input id="bt" onclick="btin()" class="btn btn-primary" type="button" value="保 存"/>&nbsp;
			</shiro:hasPermission>
			<input id="btnCancel" class="btn  btn-primary" type="button" value="返 回" onclick="history.go(-1)"/>
			</div>
			</div>	
	</form:form>
<script type="text/javascript">
		$(document).ready(function() {
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
		     $("#poth").append("<dl style=' float: left; width: 100px; height: 100px;'><dt style='margin: 10px;'><input type='hidden' name='pothname' value='"+a+"'/><img width='70px;' height='50px;' alt='' src='"+a+"'></dt><dd style='text-align: center; margin: 9px;'><a href='#' onclick='deleteimg(this)'>删除</a></dd></dl>");
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
</body>
	
</html>