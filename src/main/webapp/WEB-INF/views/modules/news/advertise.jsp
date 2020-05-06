<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>广告</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#advertisename").focus();
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
					$("#inputForm").submit();
			});

			dotTypeChg();
		});
		
		var typeJsonStr = '${fns:toJson(adtypeList)}';
		var typeArray = eval(typeJsonStr);  
		
		function dotTypeChg(){
			var typeid = $("#typeSel").val();
			if ("" == typeid) {
				$("#adtypename").val("");
				$("#adtypeonlynum").val("");
				$("#memo").html("");
				$("#imgmemo").html("");
			} else {
				for(var i=0;i<typeArray.length;i++){  
				   if (typeArray[i].adtypeid == typeid) {
					   $("#adtypename").val(typeArray[i].adtypename);
					   $("#adtypeonlynum").val(typeArray[i].adtypeonlynum);
					   $("#memo").html(typeArray[i].memo);
					   $("#imgmemo").html(typeArray[i].imgmemo);
				   }
				}  
			}
			
	//		alert($("#xxx").find("option:selected").text());
		}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctxsys}/news/advertise/list">广告列表</a></li>
		<li class="active"><a href="#">广告${not empty advertise.advertiseid?'修改':'添加'}</a></li>
	</ul><br/>
	
	<form:form id="inputForm" modelAttribute="advertise" action="${ctxsys}/news/advertise/save" method="post" class="form-horizontal">
		<form:hidden path="advertiseid"/>
		<form:hidden path="adtypename"/>
		<tags:message content="${message}"/>
		<div class="control-group">
			<label class="control-label" for="advertisename">广告名称:</label>
			<div class="controls">
				<form:input path="advertisename" htmlEscape="false" maxlength="255"  class="required input-xxlarge"  />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="adtypeid.adtypeid">广告类型:</label>
			<div class="controls">
				<form:select path="adtypeid.adtypeid" class="input" onchange="dotTypeChg();" id="typeSel">
					<form:option value="" label=""/>
					<form:options items="${adtypeList}" itemLabel="adtypename" itemValue="adtypeid" htmlEscape="false" />
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="adtypeonlynum">唯一码:</label>
			<div class="controls">
				<form:input path="adtypeonlynum" htmlEscape="false"   class="input-small"  readonly="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="targetsys">广告发布位置:</label>
			<div class="controls">
				<form:select path="targetsys" class="input">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('advertise_targetsys')}" itemLabel="label" itemValue="value" htmlEscape="false" />
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="advertisecontent">广告内容:</label>
			<div class="controls">
				<form:textarea id="advertisecontent" htmlEscape="true" path="advertisecontent" rows="6"  maxlength="3000"   class="input-xxlarge"/>
				<tags:ckeditor replace="advertisecontent" uploadPath="/news/advertise" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="adabstract">摘要:</label>
			<div class="controls">
				<form:textarea id="adabstract" htmlEscape="true" path="adabstract" rows="6"  maxlength="3000"  class="input-xxlarge"/>
				<tags:ckeditor replace="adabstract" uploadPath="/news/advertise" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" >广告类型说明:</label>
			<div class="controls">
				<span class="help-inline"  id="memo" style="color: blue;"></span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="advertisesrc">图片:</label>
			<div class="controls">
				<form:hidden path="advertisesrc" htmlEscape="false" maxlength="100"  class="input-xlarge"/>
				<span class="help-inline" id="imgmemo"  style="color: blue;"></span>
				<tags:ckfinder input="advertisesrc" type="images" uploadPath="/news/advertise"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="advertisesort">排序:</label>
			<div class="controls">
				<form:input path="advertisesort" htmlEscape="false" maxlength="6"   class="digits"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="addefault">是否默认:</label>
			<div class="controls">
				<form:radiobutton path="addefault" htmlEscape="false" class="required"  value="0"  checked="checked" />否
				<form:radiobutton path="addefault" htmlEscape="false" class="required"   value="1" />是
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="adenter">是否禁用:</label>
			<div class="controls">
				<form:radiobutton path="adenter" htmlEscape="false" class="required"  value="0"  checked="checked" />否
				<form:radiobutton path="adenter" htmlEscape="false" class="required"   value="1" />是
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="adclass">广告分类:</label>
			<div class="controls">
				<form:select path="adclass" class="input">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('adclass')}" itemLabel="label" itemValue="value" htmlEscape="false" />
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="adurl">地址:</label>
			<div class="controls">
				<form:input path="adurl" htmlEscape="false" maxlength="100"  class="input-xxlarge"  />
			</div>
		</div>
		
		<div class="control-group">
			<label class="control-label"  for="adcreatetime">创建时间:</label>
			<div class="controls">
				<input id="adcreatetime" name="adcreatetime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${advertise.adcreatetime}" pattern="yyyy-MM-dd HH:mm:ss"/>"  />
			</div>
		</div>
		
		<div class="form-actions">
			<shiro:hasPermission name="news:advertise:edit">
				<input id="btnSubmit" class="btn btn-primary" type="button" value="保 存" />&nbsp;
			</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>