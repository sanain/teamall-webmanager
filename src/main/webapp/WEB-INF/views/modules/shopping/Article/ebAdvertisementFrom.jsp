<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>
		<c:if test="${'add'.equals(flag)}">增加门店广告</c:if>
		<c:if test="${!'add'.equals(flag)}">修改门店广告</c:if>
	</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript" src="${ctxStatic}/jquery-validation/1.11.0/lib/jquery-1.9.0.js"></script>
	<script type="text/javascript" src="${ctxStatic}/jquery-validation/1.11.0/jquery.validate.js"></script>

	<script type="text/javascript">
        $(function(){
            if("add" ==  '${flag}'){
                //设置是否禁用
                var options = $("#status").find("option");
                for(var i = 0 ; i < options.length ; i++){
                    if($(options[i]).val() == '${ebAdvertisement.status}'){
                        $(options[i]).attr("selected","selected");
                        break;
                    }
                }

                //设置表单路径
                $("#inputForm").attr("action","${ctxsys}/EbAdvertisement/save");
            }
        })
	</script>
	<script type="text/javascript">
        function toAdvertisementList(){
            window.location.href='${ctxsys}/EbAdvertisement'
        }


        if('${prompt}' != ""){
            alert('${prompt}');
		}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctxsys}/EbAdvertisement/list">广告列表</a></li>
		<li class="active">
			<c:if test="${'add'.equals(flag)}">
				<a href="${ctxsys}/EbAdvertisement/form?flag=add">
					增加门店广告
				</a>
			</c:if>
			<c:if test="${!'add'.equals(flag)}">
				<a href="${ctxsys}/EbAdvertisement/form?id=${ebAdvertisement.id}">
					修改门店广告
				</a>
			</c:if>
		</li>
	</ul><br/>
	<p id="price" style="display:none;"></p>
	<form:form id="inputForm" style="position:relative" modelAttribute="ebAdvertisement" action="${ctxsys}/EbAdvertisement/update" method="post" class="form-horizontal">
		<form:hidden path="id" value="${ebAdvertisement.id}"/>
		<form:hidden path="createTime" value="${createTime}'"/>
		<form:hidden path="del" value="${ebAdvertisement.del}"/>
		<tags:message content="${message}"/>
		<div class="control-group">
			<label class="control-label" for="name">广告名称:</label>
			<div class="controls">
				<form:input path="asName" value="${ebAdvertisement.asName}" htmlEscape="false" maxlength="50" required="required"/>
			</div>
		</div>

		<div class="control-group">
			<label class="control-label" for="name">广告图片:</label>
			<div class="controls">
			<form:hidden path="asPic" htmlEscape="false" maxlength="100"  class="input-xlarge"/>
				<span class="help-inline" id="advertuseImg"  style="color: blue;"></span>
				<tags:ckfinder input="asPic" type="images"  selectMultiple="true" uploadPath="/merchandise/ebAdvertisement"/>
			</div>
		</div>
		<div class="control-group" id="adcertuseDetailsd">
			<label class="control-label" for="sort">广告内容:</label>
			<div class="controls">
			 <form:textarea path="asContent" id="asContent" htmlEscape="false"/>
				<tags:ckeditor replace="asContent" uploadPath="merchandise/ebAdvertisement"></tags:ckeditor>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="icon">状态</label>
			<div class="controls">
			<form:select path="status" id="status" style="width: 100px;" class="input-medium">
		           	<form:option value="1">启用</form:option>
					<form:option value="2">禁用</form:option>
               </form:select>  
			</div>
		</div>

		<div class="form-actions">
			<input id="btnSubmit" class="btn btn-primary" type="submit" value="${'add'.equals(flag)?'增加':'修改'}"/>&nbsp;
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="toAdvertisementList()"/>
		</div>
	</form:form>

</body>

</html>