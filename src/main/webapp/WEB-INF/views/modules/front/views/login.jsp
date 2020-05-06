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
<script type="text/javascript">
	$(document).ready(function(){  
	
		/* $("#userForm").validate({
			    
				submitHandler: function(form){
					alert("ddd");
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
				    alert("dddd");
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			}); */
        $("#button_submit").click(function(){  
            var name = $("#usephone").val();  
            var pass = $("#userpwd").val();  
            if(name==""){
                $("#msgbox").show();
                $("#msgcontent").text("用户名不能为空");
            	
            	return false;
            }
            if(pass==""){
            	 $("#msgbox").show();
                $("#msgcontent").text("密码不能为空");
            	return false;
            }

            
            //var user = {userName:name,password:pass};//拼装成json格式 
            /* var params = $("#userForm").serializeArray(); 
           
            $.ajax({  
                type:"post",  
                url:"${ctx}/userlogin.json",
                cache:false,
                data:params,
                timeout : 1000, //超时时间设置
                async:false,
                success:function(data){ 
                	//var dataJson = JSON.parse(data);
                    
                    if(data.errorcode=="00"){
                        alert("${ctx}/userinfo");
                        window.location.href="${ctx}/userinfo"; 
                    }else{
                    	 alert(data.msg);
                    } 
                },  
                error:function(e) {  
                    alert("出错："+e);  
                },
                complete: function(XMLHttpRequest, textStatus) {
                        this; // 调用本次AJAX请求时传递的options参数
                   }  
            });  */
           
            
            
        }); 
        
        $("#doctor_submit").click(function(){  
            var name = $("#doctoracc").val();  
            var pass = $("#doctorpwd").val();  
            if(name==""){
                $("#msgboxdoctor").show();
                $("#msgcontentdoctor").text("用户名不能为空");
            	
            	return false;
            }
            if(pass==""){
            	 $("#msgbox").show();
                $("#msgcontentdoctor").text("密码不能为空");
            	return false;
            }
        }); 
        
        
    });  
</script>
			
		
		<div id="content"> 
				<div class="loginbar">
					
						<div class="center">
							
								<div class="login">
											<div class="logs">
													<ul>
													<li class="doc <c:if test="${docmsg != null}"> on </c:if>"><a href="" class="opacity">医生登录</a></li>
													<li class="user <c:if test="${docmsg == null}"> on </c:if>"><a href="" class="opacity">用户登录</a></li>
													</ul>
											</div>
											   <form id="userForm" action="${ctx}/userlogin">
													<ul id="sdoc"  <c:if test="${docmsg == null}"> class="on" </c:if>>
													    <input id="url" name="url" type="hidden" value="${returl}">
														<li class="sr"><p>手机号码</p><input id="usephone" name="userphone" type="text"  value="${userPhone}"/></li>
														<li class="sr"><p>密码</p><input id="userpwd" name="userpwd"  type="password" value="${passWord}"/></li>
														<li>
														 <c:if test="${not empty rememberState}">
														 <div class="jykey"><input type="checkbox" name="rememberstate" value="1" checked="checked">记住密码</div>
														 </c:if>
														 <c:if test="${empty rememberState}">
														 <div class="jykey"><input type="checkbox" name="rememberstate" value="1" >记住密码</div>
														 </c:if>
															<a href="${ctx}/userforgotpassword" class="forget">忘记密码?</a>
														</li>
														
														<li id="msgbox" class="msg"  <c:if test="${msg == null}"> style="display:none" </c:if>>
																<div class="msg_err">
																	<div class="msg_ct">
																	  <span><i class="icono-exclamation"></i></span>
																	  <p id="msgcontent">${msg}</p>
																	</div>

																</div>
														</li>
														<li class="dl"><input type="submit" id="button_submit" value="登录" class=""/> <a href="${ctx}/reg" class="zhuc ">注册</a>	</li>
													</ul>
													</form>
													<form id="doctorForm" action="${ctx}/doctorlogin">
													<ul id="suser" <c:if test="${docmsg != null}"> class="on" </c:if>>
														<li class="sr"><p>医生帐号</p><input id="doctoracc" name="doctoracc" type="text"  value=""/></li>
														<li class="sr"><p>密码</p><input id="doctorpwd" name="doctorpwd"  type="password" value=""/></li>
														<li><div class="jykey"><input type="checkbox"/>记住密码</div>
															<!-- <a href="" class="forget">忘记密码?</a> -->
														</li>
														<li id="msgboxdoctor" class="msg" <c:if test="${docmsg == null}"> style="display:none" </c:if>>
															<div class="msg_err">
																	<div class="msg_ct">
																	  <span><i class="icono-exclamation"></i></span>
																	  <p id="msgcontentdoctor">${docmsg}</p>
																	</div>

																</div>
														</li>
														<li class="dl"><input type="submit" id="doctor_submit" value="登录" class=""/> 	</li>
													</ul>
													</form>

											

								</div>


						</div>	






				</div>		

		</div>

		
		
		
		
<script type="text/javascript">

var oldc = $(".logs li.on"),oldcl=$(".logs li:eq("+$(".logs li.on").index()+")");

$(".logs li").hover(function(){ 

		if(oldc){ 
			oldc.removeClass("on")
			oldc=$(this)
		}else{
			oldc=$(this)
		}
		$(this).addClass("on")

		},function(){ 
			oldc.removeClass("on")
			oldcl.addClass("on")
			oldc=oldcl
})
$(".logs li").click(function(){ 

		if(oldc){ 
			oldc.removeClass("on")
			oldc=$(this)
		}else{
			oldc=$(this)
		}
		oldcl=$(this)
		oldc.removeClass("on")
		oldcl.addClass("on")
	
		if($(this).hasClass("doc")){ 
				$("#sdoc").removeClass("on")
				$("#suser").addClass("on")
				$("#sdoc").find("input[type='text']").val("")
		}else{ 
sdoc
				$("#sdoc").addClass("on")
				$("#suser").removeClass("on")
				$("#suser").find("input[type='text']").val("")
		}

})



</script>
		
</body>
</html>