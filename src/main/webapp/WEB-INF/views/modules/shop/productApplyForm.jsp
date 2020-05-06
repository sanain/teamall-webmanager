<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>用户管理</title>
	<meta name="decorator" content="default"/>

	<style type="text/css">
		#btnSubmit{
			background: #393D49;
		}

		a{
			color: #009688;;
		}

		a:hover{
			color: #009688;;
		}
		
	    body{background:#f5f5f5;}
    .nav-tabs li{width:130px;text-align:center;color:#333;}
     .nav-tabs li a:hover{background:#fff;}
     .nav-tabs .active a{border-top:3px solid #3E9388;color:#3E9388;}
     #searchForm,.ibox-content,.form-actions{background:#fff;}	
     .ibox-content{margin:0 30px;}
	</style>
</head>
<body style="background:#f5f5f5;">
	<div style="color:#999;margin:19px 0 17px 30px;">
		<span>当前位置：</span><span>商品管理 - </span><span style="color:#009688;">商品申请</span>
	</div>
<div class="ibox-content">
	<ul class="nav nav-tabs">
		<li><a href="${ctxweb}/shop/ebProductApplyShop/list">申请列表</a></li>
		<li class="active"><a href="#">商品申请</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="user" action="${ctxweb}/shop/ebProductApplyShop/insert" method="post" enctype="multipart/form-data" class="breadcrumb form-search ">
		<form:hidden path="id" htmlEscape="false" maxlength="100" class="model"/>
		<form:hidden path="fileUrl" id="fileUrl" htmlEscape="false" maxlength="100" class="model"/>
        <div class="control-group"  style="overflow:hidden;border-bottom:0;">
            <label class="control-label" style="float:left;">商品名称:</label>
            <div class="controls" style="float:left;margin-left:30px;">
                <form:input path="productName" htmlEscape="false" maxlength="500" class="model" style="width:230px;height:35px;padding:0;"/>
            </div>
        </div>
        <div class="control-group"  style="overflow:hidden;margin-top:15px;border-bottom:0;">
			<label class="control-label"  style="float:left;">申请理由:</label>
			<div class="controls"  style="float:left;margin-left:30px;">
				<form:textarea path="remark" htmlEscape="false" maxlength="500" rows="3" class="model" style="width:230px;padding:0;"/>
			</div>
		</div>
		<div class="control-group"  style="overflow:hidden;margin-top:15px;border-bottom:0;">
			<label class="control-label"  style="float:left;">附件上传:</label>
			<div class="controls"  style="float:left;margin-left:30px;">
				<input type="file" id="files" name="multipartFile">
			</div>
		</div>
		<div class="control-group"  style="overflow:hidden;margin-top:15px;border-bottom:0;">
			<label class="control-label"  style="float:left;">注意事项:</label>
			<div class="controls"  style="float:left;margin-left:30px;">
				<font color="blue">* 提交附件压缩成大小10M以内RAR、ZIP文件提交!</font>
			</div>
		</div>
		<div class="form-actions" style="margin-top:10px;">
			<input id="btnSubmit" class="btn btn-primary" type="submit" onclick="return LimitAttach();" style="width:90px;height:35px;margin-left:80px;margin-right:13px;" value="保 存"/>
			<input id="btnCancel" class="btn" type="button" value="返 回" style="width:90px;height:35px;" onclick="history.go(-1)"/>
		</div>
	</form:form>
</div>
<script>
	function LimitAttach() {
		var ctxweb=$("#ctxweb").val();
		var file=document.getElementById("files").value;//文件
		var fileUrl=$("#fileUrl").val();
		if(file=='' && fileUrl==''){
			alert("请选择上传文件！");
			return false;
		}else{
			var size=document.getElementById("files").files[0].size;//文件大小
			var form1=document.getElementById("btnCancel");
			var ext = file.slice(file.lastIndexOf(".")+1).toLowerCase();
			if ("rar" != ext && "zip" != ext) {
				alert("提交附件压缩成大小10M以内RAR、ZIP文件提交!");
				return false;
			}else if(size>10000000){
				alert("提交附件压缩成大小10M以内RAR、ZIP文件提交!");
				return false;
			}
			else {
				form1.action=ctxweb+"/shop/ebProductApplyShop/insert";
				form1.submit();
			}
		}
	}
</script>
</body>
</html>