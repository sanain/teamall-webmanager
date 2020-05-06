<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<meta name="decorator" content="default"/>
	<meta name="Description" content="${fns:getProjectName()},分场信息"/>
	<meta name="Keywords" content="${fns:getProjectName()},分场信息"/>
	<title>分场信息</title>
	<script type="text/javascript">
	/* $(document).ready(function() {
		$("#name").focus();
		$("#inputForm").validate({
			submitHandler: function(form){
				loading('正在提交，请稍等...');
				form.submit();
			}
		});
	}); */
	function post(id){
		$.ajax({
	    	type:'post',
	      	contentType:"application/x-www-form-urlencoded;charset=UTF-8",
	    	url:"${ctxsys}/UserAmtLog/form",
	       	datatype:"json",
	       	data:{
	       		saleId:saleId
	       	},
	       	success:function(data){
	       		if(data!=""){
		       		var html="";
		      		html+='<div class="lishi-box">';
		      		html+='<p>协商历史 <img class="lishi-del" src="${ctxStatic}/hAdmin/img/xxx-rzt.png" alt=""></p>';
		      		html+='<div class="lishi-div">';
		      	    for(var i in data){
		      	        var list=data[i];
		      			html+='<div class="lishi-body">';
		      			html+='<p>';
		      			if(list.recordObjType==3){
		      				html+='<i><img class="lishi-del" src="${ctxStatic}/sbShop/images/logo.png" alt=""></i><b>${fns:getProjectName()}平台</b>';
		      			}else{
		      				html+='<i><img class="lishi-del" src="'+list.recordObjImg+'" alt=""></i><b>'+list.recordObjName+'</b>';
		      			}
		      			var newTime = new Date(list.recordDate);
		      			var strdate2 = timeStamp2String(list.recordDate);
		      			html+='<span>'+strdate2+'</span></p>';
		      			html+='<div>'+list.recordName+'</div>';
		      			html+='<div>'+list.recordContent+'</div>';
		      			if(list.recordEvidencePicUrl!=""){
				      	html+='<div>';
		      			for(var i in list.imgList){
		      				var img=list.imgList[i];
				      		html+='<u><img src="'+img+'" alt=""></u>';
		      			}
				      	html+='</div>';
		      			}
		      			html+='</div>';
		      	    }
		      		html+='</div>';
		      		html+='</div>';
		      	  $(".lishi").html(html).show();
		      	  
	       		}
	       	}
		});
	}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctxsys}/UserAmtLog">分场列表</a></li>
		<li class="active"><shiro:hasPermission name="	merchandise:UserAmtLog:view"><a href="${ctxsys}/UserAmtLog/form?id=${pmAmtLog.id}">分场信息</a></shiro:hasPermission></li>
	</ul>
	<form:form id="inputForm" modelAttribute="pmAmtLog" enctype="multipart/form-data" action="" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<form:hidden path="agentId"/>
		<form:hidden path="agentShopType"/>
		<tags:message content="${message}"/>
		<c:if test="${pmAgentShopInfo.agentShopType==2}">
			<div class="control-group">
			<label class="control-label" for="href">代&nbsp;&nbsp;理&nbsp;&nbsp;机&nbsp;&nbsp;构:</label>
			<div class="controls">
				<label class="lbl">${pmAgentShopInfo.sysOffice.name}</label>
			</div>
		</div> 
		</c:if>
		<div class="control-group">
	        <label class="control-label">分场主图:</label>
	        <div class="controls">
	            <form:hidden path="agentMainPicUrl" htmlEscape="false" maxlength="100"  class="input-xlarge"/>
	            <span class="help-inline" id="agentMainPicUrl"  style="color: blue;"></span>
	            <tags:ckfinder input="agentMainPicUrl" type="images" uploadPath="/merchandise/AgentShopInfo"/>
	        </div>
   		</div>
		<div class="control-group">
			<label class="control-label" for="href">分场名称:</label>
			<div class="controls">
			 <form:input path="agentShopName" required="required"/>
			</div>
		</div>
		 <div class="control-group">
			<label class="control-label" for="href">分场简介:</label>
			<div class="controls">
			 <form:textarea path="agentShopIntroduce" required="required"/>
			</div>
		</div>
		 <div class="control-group">
			<label class="control-label" for="href">分场描述:</label>
			<div class="controls">
			 <form:textarea path="agentShopDescribe" required="required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="href">更新时间:</label>
			<div class="controls">
				<label class="lbl"><fmt:formatDate value="${pmAgentShopInfo.modifyTime}" type="both" dateStyle="full"/></label>
			</div>
		</div> 
		<div class="form-actions">
			<!-- <input id="btnSubmit" class="btn btn-primary" type="submit" value="保存"/> -->&nbsp;
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>