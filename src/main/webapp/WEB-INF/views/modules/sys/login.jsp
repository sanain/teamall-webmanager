<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.apache.shiro.web.filter.authc.FormAuthenticationFilter"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>${fns:getConfig('productName')} 登录</title>
	<link href="${ctxStatic}/hAdmin/css/bootstrap.min.css" rel="stylesheet">
	<link href="${ctxStatic}/hAdmin/css/font-awesome.css?v=4.4.0" rel="stylesheet">
    <link href="${ctxStatic}/hAdmin/css/animate.css" rel="stylesheet">
    <link href="${ctxStatic}/hAdmin/css/style.css" rel="stylesheet">
    <link href="${ctxStatic}/hAdmin/css/login.css" rel="stylesheet">
	<script src="${ctxStatic}/jquery/jquery-1.9.1.min.js" type="text/javascript"></script>
    <script src="${ctxStatic}/jquery/jquery-migrate-1.1.1.min.js" type="text/javascript"></script>
    <link href="${ctxStatic}/jquery-validation/1.11.1/jquery.validate.min.css" type="text/css" rel="stylesheet" />
    <script src="${ctxStatic}/jquery-validation/1.11.1/jquery.validate.min.js" type="text/javascript"></script>
    <script src="${ctxStatic}/jquery-validation/1.11.1/jquery.validate.method.min.js" type="text/javascript"></script>
    
       <script>
    		$(document).ready(function() {
    		$("#captchaImg").click(function(){
				$("#captchaImg").attr("src","${ctxweb}/randomCode");
			});
			/* $("#loginForm").validate({
				rules: {
					username:{
						required:true
					},
					password:{
						required:true
					},
					validateCode: {
					required:true,
					remote: {
						url:"${ctxweb}/validateCode",
						data: {validateCode:$('#validateCode').val()},
						type:"post"
					   }
					}
				},
				messages: {
					validateCode: {remote: "验证码不正确.", required: "请填写验证码."}
					username: {required: "请填写用户名."},
					password: {required: "请填写密码."},
				},
				errorLabelContainer: "#messageBox",
				errorPlacement: function(error, element) {
					error.appendTo($("#loginError").parent());
				} 
			}); */
			
		});
		
   </script>
   <script type="text/javascript">   
			if(self.frameElement && self.frameElement.tagName == "IFRAME" || $('#left').length > 0 || $('.jbox').length > 0){
				alert('未登录或登录超时。请重新登录，谢谢！');
				top.location = "${ctx}";
			}
	</script>  
</head>
<body>
    <div class="login">
	<form id="loginForm" class="form-signin" action="${ctxsys}/login" method="post">
        <img src="${ctxStatic}/hAdmin/img/login-bg.png" alt="">
        <div class="login-body">
            <%--<img src="${ctxStatic}/hAdmin/img/title.png?v=1" alt="">--%>
            <img src="${fns:getSysSource(12)}" alt="">
            <ul>
                <li>
                    <input id="username" name="username" value="${username}" placeholder="账号" type="text">
                </li>
                <li>
                    <input id="password" name="password" placeholder="密码" type="password">
                </li>
                <li>
                    <input id="validateCode" style="width: 227px;" name="validateCode" placeholder="验证码" type="txt">
                    <img id="captchaImg" width="75px" height="33px" src="${ctxweb}/randomCode" alt="">
                </li>
                <li><span>${messager}</span><button type="submit">登录</button></li>
            </ul>
        </div>
	</form>
        <div class="login-bottom">
            <p>©版权所有：${fns:getCompanyName()} CopyRight@2017 YUKE. All Rights Reserved</p>
            <p>联系地址：  邮编：510000</p>
        </div>
		<div style="display: none" class="signup-footer">
            <div class="pull-left">
                &copy; hAdmin
            </div>
        </div>
    </div>
</body>

</html>