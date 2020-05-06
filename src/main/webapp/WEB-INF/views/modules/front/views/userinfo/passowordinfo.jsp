<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/front/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<meta name="decorator" content="frontdefault"/>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title></title>
	<meta name="keywords" content="" />
	<meta name="description" content="" />
</head>

<body>

<div id="content" class="Mee"> 
				<div class="mefixd">
				<div class="menav">
					<div class="center">
						<ul>
							 	<li><a href="${ctx}/userinfo/baseinfo" class="on"><img src=""><p>个人信息</p></a></li>
								<li><a href="${ctx}/userinfo/attentioninfo"><img src=""><p>我的关注</p></a></li>
								<li><a href="${ctx}/userinfo/userregisterinfo"><img src=""><p>我的预约</p></a></li>
								<li><a href="${ctx}/userinfo/userconsultinfo"><img src=""><p>我的咨询</p></a></li>
								<li><a href="${ctx}/userinfo/reportinfo"><img src=""><p>我的报告</p></a></li>
								<li><a href="${ctx}/userinfo/useroutpatientinfo"><img src=""><p>我的门诊</p></a></li>
								<li><a href="${ctx}/userinfo/palyinfo"><img src=""><p>我的缴费</p></a></li>
								<li><a href="${ctx}/userinfo/orderinfo" ><img src=""><p>我的订单</p></a></li>
								<li><a href="${ctx}/userinfo/newscollectinfo"><img src=""><p>我的收藏</p></a></li>
								<!-- 	<li><a href=""><img src=""><p>健康记录评估</p></a></li> -->
								<li><a href="${ctx}/userinfo/healthFile""><img src=""><p>我的健康档案</p></a></li>
								<li><a href="${ctx}/xnh/init""><img src=""><p>新农合</p></a></li>


						</ul>
					</div>

					</div>

				</div>
				
				<div class="bar">
					<ul>
							<li><a href="${ctx}/userinfo/baseinfo" class="opacity">个人资料</a></li>
							<li><a href="${ctx}/userinfo/authinfo" class="opacity ">实名认证</a></li>
							<li><a href="${ctx}/userinfo/passwordinfo" class="opacity  on">密码修改</a></li>
							<li><a href="${ctx}/userinfo/peoplecardinfo" class="opacity">就诊卡管理</a></li>
					</ul>
				</div>
				<div class="met" >
								
						<form class="zl" id="passupdatefrom" method = 'post'  action ='${ctx}/userinfo/passinfoupdate'>
							<input id="usermobile" name="usermobile"  type="hidden" value="${userinfo.mobileNo}">
								<ul> 
                                  <li><p class="l">手机号</p> <input type="text"  disabled="value"  value="${userinfo.mobileNo}"></li>
								<!-- <li class="key"><p class="l">验证码</p><input id="numberUUID"  name="numberUUID" type="text">
								<a href="javascript:void(0)" onclick="checkMsg()" id="telKey">获取</a></li> -->
								 <li class="key"><p class="l">验证码</p>
								 <input id="numberUUID"  name="numberUUID" type="text">
								 <a href="javascript:void(0)" onclick="settime(this)" value="免费获取验证码" id="telKey">免费获取验证码</a></li>
								<!--  <input type="button" id="btn" value="免费获取验证码" onclick="settime(this)" />  -->
								 </li>
								<li><p class="l">原密码</p><input id="oldpass"  name="oldpass" type="password"></li>
								<li><p class="l">新密码</p><input   id="newpass"  name="newpass" type="password"></li>
								<li><p class="l">确认密码</p><input   id="surpass"  name="surpass" type="password"></li>
								 <li id="msgbox" class="msg"  <c:if test="${msg == null}"> style="display:none" </c:if>>
									<div class="msg_err">
									<div class="msg_ct">
									<span><i class="icono-exclamation"></i></span>
									<p id="msgcontent">${msg}</p>
									</div>
									</div>
								</li>
							    <li class="sb"><input id="button_submit"  type="submit" value="提交" ></li>

								</ul>
						</form>
				</div>
		</div>
<script src="http://libs.baidu.com/jquery/1.10.2/jquery.min.js"></script>
<script type="text/javascript"> 
var countdown=100; 
function settime(obj) {
        
    if(countdown==100){
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


$(".menav li").each(function(a){ 

		var me = $(".menav li:eq("+a+")"),i=a+1;
		if(me.find("a").hasClass("on")){ 
				me.find("img").attr("src","${ctxStaticFront}/images/me_"+i+"h.png")
		}else{ 
			me.find("img").attr("src","${ctxStaticFront}/images/me_"+i+".png")
		}
		
		me.hover(function(){ 
			
			me.find("img").attr("src","${ctxStaticFront}/images/me_"+i+"h.png")
		},function(){ 
			if(!me.find("a").hasClass("on")){ 
				me.find("img").attr("src","${ctxStaticFront}/images/me_"+i+".png")
			}
			

		})
})


</script>

<script type="text/javascript">
        function namesss() {//验证输入信息
            var usermobiles = $("#usermobile").val();  
            var codes = $("#numberUUID").val(); 
            var oldpasses = $("#oldpass").val();
            var newpasses = $("#newpass").val();
            var surpasses = $("#surpass").val();
            if(codes==""){
                $("#msgbox").show();
                $("#msgcontent").text("验证码不能为空");
            	return false;
            }
            if(oldpasses==""){
            	 $("#msgbox").show();
                $("#msgcontent").text("原密码不能为空");
            	return false;
            	
            }
             if(newpasses==""){
            	 $("#msgbox").show();
                $("#msgcontent").text("新密码不能为空");
            	return false;
            }
             if(surpass==""){
            	 $("#msgbox").show();
                $("#msgcontent").text("确认密码不能为空");
            	return false;
            }
             if(surpasses!=newpasses){
            	 $("#msgbox").show();
                $("#msgcontent").text("新密码与确认密码不一致");
            	return false;
            }
            else {return true;}
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
			
			
			//--------------提交表单------------------------------------
			
				$("#button_submit").click(function(){
			       if(namesss()){/* 前端输入内容验证 */
					$("#cover").show();
					$.ajax({
					 	type: "POST",
  						url: "${pageContext.request.contextPath}/userinfo/passifoupdate",
  						cache:false,
  						async: false, 
   						data: $("#passupdatefrom").serialize(),
  						success: function(data){
     						if(data.success){
     							layer.confirm(data.msg, {
								    btn: ['确定'] //按钮
								}, function(){
								   window.location.href="${pageContext.request.contextPath}/loginout";
								}, function(){
								   
							    	});
     							
								
     						}else if(data.errorCode==01){
     						    	
	     						layer.confirm(data.msg, {
								    btn: ['确定'] //按钮
								}, function(){
								   window.location.href=window.location.href;
								}, function(){
								   
							    	});
     							
     						}else{
     						       
     						       layer.confirm(data.msg, {
								    btn: ['确定'] //按钮
								}, function(){
								   window.location.href=window.location.href;
								}, function(){
							    	});
     							$("#cover").hide();
     						}
   						}
 					});
 					} 
				 return false;
				});
              
   } );

//--------------获取验证码------------------------------------
   function checkMsg(){
	var phonenum = $("#usermobile").val(); 
	
	$.ajax({
	 	type: "POST",
			url: "${pageContext.request.contextPath}/usercheck?phone="+phonenum,
			cache:false,
			async: false, 
			success: function(jsonJson){
				if(jsonJson.success){
				layer.msg(jsonJson.msg);
				}else{
					layer.msg(jsonJson.msg);
					
				}
			}
		});
   }

</script>

</body>
</html>
