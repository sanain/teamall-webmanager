<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>用户管理</title>
	<meta name="decorator" content="default"/>
	<style>
	  #searchForm,#inputForm{background:#fff;}
    .nav-tabs>.active>a{border-top:3px solid #009688;color:#009688;}
      .nav-tabs>li>a{color:#000;}
      .pagination{padding-bottom:25px;}
      .ibox-content{margin:0 30px;}
      body{background:#f5f5f5;}
      .ibox-content{background:#fff;}
      .nav{margin-bottom:0;}
      .form-horizontal{margin:0;}
       .breadcrumb{background:#fff;padding:0;}
                 .control-group{overflow:hidden;height:35px;margin-top:10px;padding:0;padding-bottom:13px;}
       .control-label{float:left;margin-right:15px;}
       .controls{float:left;}
         .controls input{height:34px;border:1px solid #eee;padding:0;width:230px;}
           .controls select{height:34px;border:1px solid #eee;padding:0;width:230px;}
	</style>
	<style>
      input[type="radio"], input[type="checkbox"] {
       margin: -2px 5px;
       line-height: normal;
       box-sizing: border-box;
       padding: 0;
       width:15px;
       height:15px;
      }
 
 	</style>
	<script src="${ctxStatic}/sbShop/js/jquery.min.js"></script>
	<script src="${ctxStatic}/sbShop/js/jquery.validate.min.js"></script>
	<script src="${ctxStatic}/jquery-validation/1.11.1/jquery.validate.method.js"></script>
	<script type="text/javascript">
        $().ready(function() {
            // 在键盘按下并释放及提交后验证提交表单
            $("#searchForm").validate({
                rules: {
                    username: {
                        required:true,
                        maxlength:16
                    },

                    jobNumber:{
                        required:true,
                        maxlength:50
                    },
                    phoneNumber:{
                        required:true,
                        phone:true
                    }
                },
                messages: {
                    username: {
                        required:"请输入人员名称",
                        maxlength:"人员名称长度不能超过16"
                    },
                    password:{
                        required:"请输入密码",
                        minlength:"密码不能少于6位",
                        maxlength:"密码不能多于24位"
                    },
                    jobNumber:{
                        required:"请输入登录名称",
                        maxlength:"登录名称不能多于50"
                    },
                    phoneNumber:{
                        required:"请输入联系电话",
                        phone:"请输入正确的联系方式"
                    }

                },

            })
        });
	</script>
</head>
<body>
<div style="color:#999;padding:19px 0 17px 30px;background:#f5f5f5;">
		<span>当前位置：</span><span>人员设置 - </span><span style="color:#009688;">门店人员管理</span>
	</div>
<div class="ibox-content">
	<ul class="nav nav-tabs">
		<li><a href="${ctxweb}/shop/shop/user/list">人员列表</a></li>
		<li class="active"><c:if test="${type==0}"><a>添加人员</a></c:if><c:if test="${type==1}"><a>修改人员</a></c:if></li>
	</ul><br/>
	<form:form id="searchForm" modelAttribute="user" action="${ctxweb}/shop/shop/user/update" method="post" class="breadcrumb form-search ">
		<form:hidden path="shopUserId" htmlEscape="false" maxlength="100" class="model"/>
		<form:hidden path="createTime" htmlEscape="false" maxlength="100" class="model"/>
		<form:hidden path="del" htmlEscape="false" maxlength="100" class="model"/>
		<form:hidden path="shopId" htmlEscape="false" maxlength="100" class="model"/>
		<form:hidden path="status" htmlEscape="false" maxlength="100" class="model"/>
		<div class="control-group">
			<label class="control-label">人员名称:</label>
			<div class="controls">
				<form:input path="username" htmlEscape="false" maxlength="100" class="model"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">登录名称:</label>
			<div class="controls">
				<form:input path="jobNumber" htmlEscape="false" maxlength="100" class="model"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">登录密码:</label>
			<div class="controls">
				<input type="password" id="password" name="password"
					   <c:if test="${empty user.password}">
					   required minlength="6" maxlength="24"
						</c:if>
					   htmlEscape="false"  class="model"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">出生日期:</label>
			<div class="controls">
				<form:input path="birthday" htmlEscape="false" maxlength="100" class="model"/>
					<%--<label class="lbl"><fmt:formatDate value="${user.}" type="both" dateStyle="full"/></label>--%>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">人员类型:</label>
			<div class="controls">
				<form:select path="type">
					<form:option value="1">收银人员</form:option>
					<form:option value="2">配送人员</form:option>
				</form:select>
				<%--<form:input path="type" htmlEscape="false" maxlength="100" class="model"/>--%>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">手机号码:</label>
			<div class="controls">
				<form:input path="phoneNumber" htmlEscape="false" maxlength="100" class="model"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">在线打印:</label>
			<div class="controls">
			    <form:radiobutton path="isPrinting"  value="1" />是
				<form:radiobutton path="isPrinting"  value="0" />否
			</div>
		</div>
		<div class="control-group" style="display:none;">
			<label class="control-label">提成比例:</label>
			<div class="controls">
				<form:input path="userRatio" htmlEscape="false" maxlength="100" class="model" onkeyup="this.value=this.value.replace(/[^\d\.\d{0,2}]/g,'')" />
			</div>
			 <label style="float: left;line-height: 34px;">%</label></div>
		</div>
		<div class="form-actions">
			<input id="btnSubmit" class="btn btn-primary" type="submit" style="background-color:#23262E;background-image: -webkit-gradient(linear,0 0,0 100%,from(#23262E),to(#23262E));width:85px;height:35px;padding:0;margin-left:80px;" value="保 存"/>
			<input id="btnCancel" class="btn" type="button" value="返 回" style="width:85px;height:35px;" onclick="history.go(-1)"/>
		</div>
	</form:form>
</div>
</body>
</html>