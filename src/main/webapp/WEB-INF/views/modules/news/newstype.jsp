<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>栏目</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#newstypename").focus();
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
					var newstypetype = $('input[name="newstypetype"]:checked').val();
					if ("1" == newstypetype) {
						var newstypeurl = $.trim($("#newstypeurl").val());
						if (null == newstypeurl || "" == newstypeurl) {
							top.$.jBox("URL类型必须输入URL地址!",  {title:"错误", buttons:{"关闭":true}, 
							bottomText:""});
							return false;
						}
					}
					$("#inputForm").submit();
			});
		});
		
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctxsys}/news/newstype/">栏目列表</a></li>
		<li class="active"><a href="#">栏目${not empty newstype.newstypeid?'修改':'添加'}</a></li>
	</ul><br/>
	
	<form:form id="inputForm" modelAttribute="newstype" action="${ctxsys}/news/newstype/save" method="post" class="form-horizontal">
		<form:hidden path="newstypeid"/>
		<tags:message content="${message}"/>
		<div class="control-group">
			<label class="control-label">上级类型:</label>
			<div class="controls">
                <tags:treeselect id="newstype" name="parent.newstypeid" value="${newstype.parent.newstypeid}" labelName="parent.newstypename" labelValue="${newstype.parent.newstypename}"
					title="栏目" url="${ctxsys}/news/newstype/treeData" extId="${newstype.newstypeid}" cssClass="required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="newstypename">类型名称:</label>
			<div class="controls">
				<form:input path="newstypename" htmlEscape="false" maxlength="50"  class="required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="newstypeordername">短名:</label>
			<div class="controls">
				<form:input path="newstypeordername" htmlEscape="false" maxlength="10"  />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="englishname">英文名称:</label>
			<div class="controls">
				<form:input path="englishname" htmlEscape="false" maxlength="50"  />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="describe">类型摘要:</label>
			<div class="controls">
				<form:textarea path="describe" htmlEscape="false" rows="3" maxlength="200" class="input-xxlarge" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="memo">备注:</label>
			<div class="controls">
				<form:textarea path="memo" htmlEscape="false" rows="3" maxlength="1000" class="input-xxlarge" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="newstypetag">标识:</label>
			<div class="controls">
				<form:select path="newstypetag" class="input">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('newstypetag')}" itemLabel="label" itemValue="value" htmlEscape="false" />
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="effect">效果:</label>
			<div class="controls">
				<form:select path="effect" class="input">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('newsdetail_category')}" itemLabel="label" itemValue="value" htmlEscape="false" />
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="newstypesort">排序:</label>
			<div class="controls">
				<form:input path="newstypesort" htmlEscape="false" maxlength="6"   class="required digits"/>
			</div>
		</div>
		
		<div class="control-group">
			<label class="control-label" for="newstypeiconbig">类别大图:</label>
			<div class="controls">
				<form:hidden path="newstypeiconbig" htmlEscape="false" maxlength="100"  class="input-xlarge"/>
				<tags:ckfinder input="newstypeiconbig" type="images" uploadPath="/news/newstype"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="newstypeiconsmall">类别小图:</label>
			<div class="controls">
				<form:hidden path="newstypeiconsmall" htmlEscape="false" maxlength="100"  class="input-xlarge"/>
				<tags:ckfinder input="newstypeiconsmall" type="images" uploadPath="/news/newstype"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="newstypeenable">是否可用:</label>
			<div class="controls">
				<form:radiobutton path="newstypeenable" htmlEscape="false" class="required"  value="1"  checked="checked" />可用
				<form:radiobutton path="newstypeenable" htmlEscape="false" class="required"   value="0" />不可用
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="newstypetype">类别区分:</label>
			<div class="controls">
				<form:radiobutton path="newstypetype" htmlEscape="false" class="required"  value="0"  checked="checked" />正常
				<form:radiobutton path="newstypetype" htmlEscape="false" class="required"   value="1" />URL
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="newstypeurl">URL地址:</label>
			<div class="controls">
				<form:input path="newstypeurl" htmlEscape="false" maxlength="100"  class="input-xxlarge"/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="news:newstype:edit">
				<input id="btnSubmit" class="btn btn-primary" type="button" value="保 存" />&nbsp;
			</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>