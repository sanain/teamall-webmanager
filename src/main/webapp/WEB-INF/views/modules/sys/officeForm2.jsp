<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>机构管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
		   var type=$("#type").val();
		   typeTo(type);
		    var newModels=$("#newModels").val();
			if(newModels=='1'){
			 $("#nameModel").hide();
			 $("#nameModel").val("");
			  $("#password").hide();
			  $("#password").val("");
			}else{
			  $("#nameModel").show();
			  $("#password").show();
			}
			$("#no").focus();
			$("#inputForm").validate({
				rules: {
					nameModel: {remote: "${ctxsys}/sys/user/checkLoginName?oldLoginName=" + encodeURIComponent('${user.loginName}')}
				},
				messages: {
					nameModel: {remote: "用户登录名已存在"},
					confirmNewPassword: {equalTo: "输入与上面相同的密码"}
				},
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
			var type=$("#type").val();
			
		function typeTo(type){
		if(type=='1'){
				$('#newModels option:nth-child(2)').attr('selected','selectes');
				$('#newModels').attr('disabled','disabled');
				 $("#nameModel").show();
			     $("#password").show();
			   var html="";
			   var grade="${office.grade}";
			   if(grade=='3'){
			   	 html+=" <option value='1'>省代</option><option value='2'>市代</option>";
			   	 $("#fatype").html(html);
			    }else if(grade=='2'){
			     html+=" <option value='1'>省代</option>";
			     $("#fatype").html(html);
			    }
			   /*   var html2=" <option value='2'>新账号</option>";
			   	 $("#newModel").html(html2); */
			   	 $("#yfsid").hide();
			   	 $("#types").show();
			}else{
			$("#newModels").removeAttr("disabled"); 
			 $("#types").hide();
			 $("#yfsid").show();
				$.ajax({
		             type: "POST",
		             url: "${ctxsys}/sys/office/treeData2",
		             data: {isAgent:1,type:1,grade:"${office.grade}"},
		             success: function(data){
		                 console.log(data);
		                var html="";
		                for(var i=0;i<data.length;i++){
			                html+="<option value="+data[i].id+"  > "+data[i].name+"</option>";
						 }
						 $("#yfid").html(html);
		                }
		            });
			}
		}
		function newModelTo(s){
		  if(s=='1'){
			 $("#nameModel").hide();
			  $("#nameModel").val("");
			  $("#password").hide();
			  $("#password").val("");
			}else{
			 $("#nameModel").show();
			  $("#password").show();
			}
		}
		
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a >升级移树</a></li>
	</ul><br/>
	<form id="inputForm" modelAttribute="office" action="${ctxsys}/sys/office/save2" method="post" class="form-horizontal">		
		<tags:message content="${message}"/>
		<input name="id" value="${office.id}" type="hidden">
		<div class="control-group">
			<label class="control-label" for="name">机构名称:</label>
			<div class="controls">
			<input name="name" value="${office.name}" type="text"  class="valid" readonly="readonly">
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="name">选择操作:</label>
			<div class="controls">
				<select id="type" name="type" onchange="typeTo(this.value)">
				   <option value="1">升级</option>
				   <option value="2">移树</option>
				</select>
			</div>
		</div>
		<div class="control-group" id="types">
			<label class="control-label" for="name">选择方向:</label>
			<div class="controls">
				<select id="fatype" name="fatype">
				  <option value="2">市代</option>
				  <option value="1">省代</option>
				</select>
			</div>
		</div>
		<div class="control-group" id="yfsid">
			<label class="control-label" for="name">请选择移树:</label>
			<div class="controls">
				<select id="yfid" name="yfid">
				</select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="name">选择操作:</label>
			<div class="controls">
				<select id="newModels" name="newModel" onchange="newModelTo(this.value)">
				  <option value="1" >原账号</option>
				  <option value="2" selected="selected">新账号</option>
				</select>
			</div>
		</div>
		<div class="control-group" id="nameModel">
			<label class="control-label" for="name">用户名:</label>
			<div class="controls">
				<input  name="nameModel" type="text" class="required">
			</div>
		</div>
		<div class="control-group" id="password">
			<label class="control-label" for="name">密码:</label>
			<div class="controls">
				<input type="password"  name="password" required="required">
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="name">是否带关系:</label>
			<div class="controls">
				<select name="inToNu">
				  <option value="1">是</option>
				  <option value="0">否</option>
				</select>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="sys:office:edit">
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;
			</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form>
</body>
</html>