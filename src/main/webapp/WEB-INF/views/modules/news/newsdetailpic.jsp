<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>文章内容(图片)</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#newsdetailpicindex").focus();
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
			$("#btnSubmit").click(function(){
					/* var newstypetype = $('input[name="newstypetype"]:checked').val();
					if ("1" == newstypetype) {
						var newstypeurl = $.trim($("#newstypeurl").val());
						if (null == newstypeurl || "" == newstypeurl) {
							top.$.jBox("URL类型必须输入URL地址!",  {title:"错误", buttons:{"关闭":true}, 
							bottomText:""});
							return false;
						}
					} */
					$("#inputForm").submit();
			});
		});
		
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="#">文章图片${not empty newsdetailpic.newsdetailpicid?'修改':'添加'}</a></li>
	</ul><br/>
	
	<form:form id="inputForm" modelAttribute="newsdetailpic" action="${ctxsys}/news/newsdetail/savepic?fromType=${fromType}" method="post" class="form-horizontal">
		<input type="hidden"  id="fromType" value="${fromType}"/>
		<form:hidden path="newsdetailpicid"/>
		<form:hidden path="newsdetailid.newsdetailid"/>
		<tags:message content="${message}"/>
		<div class="control-group">
			<label class="control-label" for="newsdetailid.newsdetailtitle">文章标题:</label>
			<div class="controls">
				<form:input path="newsdetailid.newsdetailtitle" htmlEscape="false" maxlength="200"  class=" input-xxlarge"   readonly="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="newsdetailpicindex">排序:</label>
			<div class="controls">
				<form:input path="newsdetailpicindex" htmlEscape="false" maxlength="6"   class="required digits"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="newsdetaildescribe">描述:</label>
			<div class="controls">
				<form:textarea path="newsdetaildescribe" htmlEscape="false" rows="2" maxlength="100" class="input-xxlarge" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="newsdetailpicsrc">图片:</label>
			<div class="controls">
				<form:hidden path="newsdetailpicsrc" htmlEscape="false" maxlength="150"  class="input-xlarge"/>
				<tags:ckfinder input="newsdetailpicsrc" type="images" uploadPath="/news/newsdetail"/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="news:newsdetail:edit">
				<input id="btnSubmit" class="btn btn-primary" type="button" value="保 存" />&nbsp;
			</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>