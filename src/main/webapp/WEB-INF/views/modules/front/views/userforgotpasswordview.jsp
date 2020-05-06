c<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta name="decorator" content="frontdefault" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>用户重置密码</title>
<meta name="keywords" content="" />
<meta name="description" content="" />
<script src="http://libs.baidu.com/jquery/1.10.2/jquery.min.js"></script>
<script type="text/javascript"> 
var countdown=60; 
function settime(obj) {
        
    if(countdown==60){
        checkMsg();
        }  
    if (countdown == 0) { 
        obj.removeAttribute("disabled");    
        obj.value="免费获取验证码";
        $("#telKey").text("免费获取验证码");
        countdown = 60;
         $("#telKey").attr('onclick','settime(this)'); 
        return;
    } else {
        obj.setAttribute("disabled", true); 
        obj.value="重新发送(" + countdown + ")"; 
        $("#telKey").text("重新发送(" + countdown + ")");
        $("#telKey").attr('onclick',''); 
        countdown--; 
    } 
    setTimeout(function() { 
    settime(obj) }
    ,1000) 
}
   
</script>
<script type="text/javascript">
//-----------前端手机验证+后端手机号唯一原则-----------------------------------------------
$(document).ready(function(){
			function createAjax() {
				var ajax;
				if (window.XMLHttpRequest) {
						ajax = new XMLHttpRequest();
				} else {
						ajax = new ActiveXObject("Microsoft.XMLHTTP");
				}
				return ajax;
			}
			//当鼠标移开的时候，向后台发送数据验证手机号是否已经注册
			$("#telPhone").on("mouseout",function(){
			//.......后台验证手机号...........................
				var ajax=createAjax();
				ajax.open("POST","validatePhone",true);
				ajax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
				ajax.onreadystatechange = function(){
					if (ajax.readyState == 4 && ajax.status==200) {
					        var text=null;
						    text=ajax.responseText;
							//.......前端验证手机号码长度，只能为数字
							var telPhone=$("#telPhone").val();
							//电话号码的正则表达式:/^1[3|4|5|8]\d{9}$/,/(1[3-9]\d{9}$)/
							var phone=/^[-+]?\d+$/;
							if(telPhone.length==0){
								$("#validatePhone").html("<b style='color: red;'>【必填项！】</b>");
							}
							else if (null==text) {
								$("#validatePhone").html("<b style='color: red;'>【正在验证您的手机号码，请稍等！】</b>");
							}
							else if(!phone.test(telPhone)){
								$("#validatePhone").html("<b style='color: red;'>【电话号码只能为数字，请仔细检查！】</b>");
							}else if(telPhone.length<11){
								$("#validatePhone").html("<b style='color: red;'>【手机号码位数不正确，请仔细检查！】</b>");
							}else if(telPhone.length>11){
								$("#validatePhone").html("<b style='color: red;'>【手机号码位数不正确，请仔细检查！】</b>");
							}
							else if ("false"==text) {
								$("#validatePhone").html("<b style='color: red;'>【该手机号未注册，不能重置密码！】</b>");
							}
							else{
								$("#validatePhone").html("<b style='color: green;'>【手机号正确，请获取验证码】</b>");
							}
							
						}
				};
		        var name=document.getElementById("telPhone").value;
		        var date="mobileNo="+name;
// 		        console.debug(date);
		        ajax.send(date);

			});
		//-------------------------前端密码验证----------------------------------	
			//验证码
			$("#numberUUID").mouseout(function(){
				var number=$("#numberUUID").val();
			 	if(number.length==0){
			 		$("#msgUUID").html("<b style='color: red;'>【必填项！】</b>");
			 	}else{
			 		$("#msgUUID").html("请查收手机短信，并填写短信中的验证码");
			 	}
			});

			//密码的正则表达式
			$("#userPassWork").mouseout(function(){
				var one=$("#userPassWork").val();
				if(one.length==0){
					$("#userPassWorkId").html("<b style='color: red;'>【必填项！】</b>");
				}else if(one.length<6){
					$("#userPassWorkId").html("<b style='color: red;'>【你的密码长度不够！】</b>");
				}else if(one.length<8){
					$("#userPassWorkId").html("<b style='color: red;'>【密码级别低,请加强你的密码！】</b>");
				}else if(one.length>10&&one.length<17){
					$("#userPassWorkId").html("<b style='color: red;'>【密码级别高】</b>");
				}else if(one.length>16){
					$("#userPassWorkId").html("6~16个字符,区分大小写！");
				}
			});
			
			$("#userPassWorkTWO").mouseout(function(){
				var one=$("#userPassWork").val();
				var two=$("#userPassWorkTWO").val();
// 				console.debug(one,two);
				if(one.length==0){
					$("#userPassWorkId").html("<b style='color: red;'>【必填项！】</b>");
				}
				else if(one!=two){
					$("#userPassWorkTWOId").html("<b style='color: red;'>两次密码不一致，请检查你的密码！</b>");
				}else{
					$("#userPassWorkId").html("6~16个字符,区分大小写！");
					$("#userPassWorkTWOId").html("请再次填写密码");
				}

			});
			
			//--------------提交表单------------------------------------
			
				$("#submitBtn").click(function(){
					$("#cover").show();
					$.ajax({
					 	type: "POST",
  						url: "${pageContext.request.contextPath}/resetpassword",
  						cache:false,
  						async: true, 
   						data: $("#userInfoForm").serialize(),
  						success: function(data){
     						if(data.success){
     						 layer.confirm('密码重置成功，随后将为您转至登录页面！', {
							    btn: ['确定'] //按钮
							}, function(){
							     window.location.href="${pageContext.request.contextPath}/login";
							});
								
     						}else if(data.errorCode==01){
     							layer.confirm(data.msg, {
							    btn: ['确定'] //按钮
							}, function(){
							    $("#cover").hide();
     							window.location.href=window.location.href;
							});
     						}else{
     							layer.confirm(data.msg, {
							    btn: ['确定'] //按钮
							}, function(){
							    $("#cover").hide();
     							window.location.href=window.location.href;
							});
     						}
   						}
 					});
				 return false;
				});
});

//--------------获取验证码------------------------------------
function checkMsg(){
	var phonenum = $("#telPhone").val(); 
      
	$.ajax({
	 	type: "POST",
			url: "${pageContext.request.contextPath}/resetpasswordusercheck?phone="+phonenum,
			cache:false,
			async: false, 
			success: function(jsonJson){
				if(jsonJson.success){
				    layer.msg(jsonJson.msg);
				}
				else{
					layer.msg(jsonJson.msg);
					
				}
			}
		});
}

</script>
<style type="text/css">
		.cover {
					position:fixed; top: 0px; right:0px; bottom:0px; background-color: #777;
					filter: alpha(opacity=60); opacity:0.5; -moz-opacity:0.5;
					z-index: 1002; left: 0px; display:none;
				  
			}
</style>
</head>
<body>
	<div id="cover" class="cover"></div>
	<div id="content">
		<div class="block_name mt"> 
				<span class="">RESET PASSWORD</span>
				<p class="">用户重置密码</p>
				<div class="brd"></div>
		</div>
		<div class="met">
			<div class="center">
				<form id="userInfoForm" class="logz" >
					<ul>
						<li><p class="p1" >
								手机号码 <span>*</span>
							</p>
							<input id="telPhone" type="text" name="mobileNo"/>
							<p id="validatePhone" class="p2">请填写手机号码</p>
						</li>
						<li>
						<!-- <a href="javascript:void(0)" onclick="checkMsg()" id="telKey">免费获取验证码</a> -->
						     <a href="javascript:void(0)" onclick="settime(this)" value="免费获取验证码" id="telKey">免费获取验证码</a>
							<p class="p1">
								短信验证码 <span>*</span>
							</p> <input id="numberUUID" type="text" name="numberUUID"/>
							<p id='msgUUID' class="p2">请查收手机短信，并填写短信中的验证码</p>
						</li>
						<li><p class="p1">
								密码 <span>*</span>
							</p>
							<input id="userPassWork" type="password" name="password"/>
							<p id="userPassWorkId" class="p2">6~16个字符,区分大小写</p>
						</li>
					<li><p class="p1">
								确认密码 <span>*</span>
							</p>
							<input id="userPassWorkTWO" type="password" name="passwordTwo"/>
							<p id="userPassWorkTWOId" class="p2">请再次填写密码</p>
					</li>
						<li class="djtk">
							<div class="djtk1">
								<input type="checkbox" id="tytk"><span>同意</span> <a target="_blank" href="${pageContext.request.contextPath}/guanyu?num=5">"健康四川服务条款"</a>
							</div>
						</li>
						<li class="tj">
						    <input id="submitBtn" type="submit" disabled="true"> 
						</li>
						<!-- <input id="submitBtn" type="submit"  value="提交">  -->
					</ul>
				     </form>
							</div>
						</li>
						
			</div>
		</div>
	</div>

	<script type="text/javascript">
		var oldc = $(".logs li.on"), oldcl = $(".logs li:eq("
				+ $(".logs li.on").index() + ")");

		$(".logs li").hover(function() {

			if (oldc) {
				oldc.removeClass("on")
				oldc = $(this)
			} else {
				oldc = $(this)
			}
			$(this).addClass("on")

		}, function() {
			oldc.removeClass("on")
			oldcl.addClass("on")
			oldc = oldcl
		})
		$(".logs li").click(function() {

			if (oldc) {
				oldc.removeClass("on")
				oldc = $(this)
			} else {
				oldc = $(this)
			}
			oldcl = $(this)
			oldc.removeClass("on")
			oldcl.addClass("on")

		});

		$("#tytk").on("click", function() {

			if ($("#tytk").is(':checked')) {
				$("form.logz li.tj input").addClass("on")
				$("form.logz li.tj input").removeAttr("disabled")
			} else {
				$("form.logz li.tj input").removeClass("on")
				$("form.logz li.tj input").attr("disabled", 'true')

			}

		});
	</script>


</body>
</html>