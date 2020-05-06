	<%@page import = "cn.org.bjca.client.security.SecurityEngineDeal"%>
<%@ include file="/WEB-INF/views/modules/front/include/taglib.jsp"%>
	<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="java.util.*,java.io.FileInputStream"%>


<%
	long start = System.currentTimeMillis();
	request.setCharacterEncoding("GBK");
	Properties properties = new Properties();
	
	//设置DSVS客户端配置文件路径，配置文件默认位于当前用户下BJCAROOT下，不建议设置
	SecurityEngineDeal.setProfilePath("/root/BJCAROOT");

	properties.load(new FileInputStream(application.getRealPath("/webappName.properties")));
	
	// 从配置文件读取DSVS应用名称，并初始化一个服务对象
/* 	System.out.println(properties.getProperty("DSVSAppName")); */
	long end1 = System.currentTimeMillis();
	long use1 = end1 - start ;
  	SecurityEngineDeal sed = SecurityEngineDeal.getInstance(properties.getProperty("DSVSAppName"));

	// 从配置文件读取TSS（时间戳）应用名称，并初始化一个服务对象
	SecurityEngineDeal sedTss = null;
  	sedTss = SecurityEngineDeal.getInstance(properties.getProperty("TSSAppName"));
  
    long end4 = System.currentTimeMillis();
	long use4 = end4 - start ;
	String strServerCert = null;
	String strRandom = null;
	String strSignedData = null;
	// 获取DSVS服务器证书
	strServerCert = sed.getServerCertificate();//最长时间
	long end2 = System.currentTimeMillis();
	long use2 = end2 - end4 ;
	// 服务器端产生随机数
	strRandom = sed.genRandom(24);
	// 利用DSVS服务器证书对随机数签名
	long end3 = System.currentTimeMillis();
	long use3 = end3 - end2 ;
	strSignedData = sed.signData(strRandom);
	session.setAttribute("Random", strRandom);
	long end = System.currentTimeMillis();
	long use = end - end3 ;
%>  
 



<!DOCTYPE html>
<html>
<head>
	<meta name="decorator" content="frontdefault"/>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title></title>
	<meta name="keywords" content="" />
	<meta name="description" content="" />
</head>
<style>

.loginbar .login .logs li {
    width: 33%;
    height: 100%;
    text-align: center;
}

</style>
<script src="${ctxStatic}/front/js/ca/date.js" type="text/javascript"></script>
<script src="${ctxStatic}/front/js/ca/SecX_Common.js" type="text/javascript"></script>
	<!-- 页面加载时更新证书下拉列表内容 -->
		<SCRIPT LANGUAGE=JAVASCRIPT event=OnLoad for=window>
			GetList("firstForm.UserList");
		</SCRIPT>

		<!-- 页面监听证书插拔事件，并更新证书下拉列表内容 -->		
		<SCRIPT FOR=XTXAPP EVENT=OnUsbkeyChange LANGUAGE=javascript>
			ChangeUserList("firstForm.UserList");
		</SCRIPT>
		<SCRIPT ID=clientEventHandlersJS LANGUAGE=javascript >
	
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
													<li class="user <c:if test="${docmsg == null && camsg == null}"> on </c:if>"><a href="" class="opacity">用户登录</a></li>
													<li style="width: 34%;height: 100%;text-align: center;" class="ca <c:if test="${camsg != null}"> on </c:if>"><a href="" class="opacity">CA登录</a></li>
													</ul>
											</div>
											   <form id="userForm" action="${ctx}/userlogin">
													<ul id="sdoc"  <c:if test="${docmsg == null && camsg == null}"> class="on" </c:if>>
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
														
														<li id="msgbox" class="msg"  <c:if test="${empty msg  &&  camsg != ' '}"> style="display:none" </c:if>>
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
													<ul id="suser" <c:if test="${docmsg != null && camsg == null}"> class="on" </c:if>>
														<li class="sr"><p>医生帐号</p><input id="doctoracc" name="doctoracc" type="text"  value="${docAccount}"/></li>
														<li class="sr"><p>密码</p><input id="doctorpwd" name="doctorpwd"  type="password" value="${docPwds}"/></li>
														<li>
														     <c:if test="${not empty rememberStateDoctor}">
																 <div class="jykey"><input type="checkbox" name="rememberstatedoctor" value="1" checked="checked">记住密码</div>
															 </c:if>
															 <c:if test="${empty rememberStateDoctor}">
																 <div class="jykey"><input type="checkbox" name="rememberstatedoctor" value="1" >记住密码</div>
														      </c:if>
														<!-- <div class="jykey"><input type="checkbox"/>记住密码</div> -->
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
													
													
													<form  id="firstForm" name="firstForm"  action="${ctx}/caUserlogin" onsubmit="return checks()"method="post" >
													<ul id="ca" <c:if test="${camsg != null}"> class="on" </c:if>>
														<li class="sr"><p>CA帐号</p><select id="UserList" name="UserList" style="width: 243px;height:48px;font-size:20px;"></select> </li>
														<li class="sr"><p>密码</p><input id="UserPwds" name="UserPwds" type="password" maxlength="26"  oncopy="document.selection.empty()" onpaste="return false" oncut="document.selection.empty()"/></li>
														<!-- <li><div class="jykey"><input type="checkbox"/>记住密码</div>
														</li> -->
														<li id="msgboxdoctor" class="msg" <c:if test="${camsg == null}"> style="display:none" </c:if>>
															<div class="msg_err">
																	<div class="msg_ct">
																	  <span><i class="icono-exclamation"></i></span>
																	  <p id="msgcontentdoctor">${camsg}</p>
																	</div>

																</div>
														</li>
														<li class="dl"><input type="submit"   id="ca_submit" value="登录" class=""/> 	</li>
													</ul>
														<input type="hidden" ID="UserSignedData" name="UserSignedData">
														<input type="hidden" ID="UserCert" name="UserCert">
														<input type="hidden" ID="ContainerName" name="ContainerName">
														<input type="hidden" ID="CAUserID" value="" name="CAUserID">
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
				$("#ca").removeClass("on")
				$("#suser").addClass("on")
				$("#sdoc").find("input[type='text']").val("")
		}else if($(this).hasClass("user")){ 
				$("#sdoc").addClass("on")
				$("#suser").removeClass("on")
				$("#ca").removeClass("on")
				$("#suser").find("input[type='text']").val("")
		}else if($(this).hasClass("ca")){ 
				$("#ca").addClass("on")
				$("#suser").removeClass("on")
				$("#sdoc").removeClass("on")
				$("#suser").find("input[type='text']").val("")
		}

})

 var strServerSignedData = "<%=strSignedData%>";
			var strServerRan = "<%=strRandom%>";
			var strServerCert = "<%=strServerCert%>";  
				function checks(){		
							var ret;
							var strContainerName = firstForm.UserList.value;
							alert(strContainerName);
							var strPin = firstForm.UserPwds.value;
							//alert(strPin);
							// 调用证书登录
							ret = Login(firstForm,strContainerName,strPin);
							firstForm.UserPwds.value = "";
							if(ret){
								getUserCertID();
								var caidcard = document.getElementById("CAUserID").value;
							//	alert(caidcard);
								return true;
							}
					return false;	
				
			}

        	// 读取证书用户唯一标识	
			function getUserCertID(){
				// 获取下拉列表中选中证书的序列号
				var sid = document.getElementById("UserList").value;
				// 导出用户证书
				var userCert = GetSignCert(sid);
				// 注意："1.2.156.112562.2.1.1.1" 为固定写法，用于获取北京CA发放个人SM2数字证书中的用户唯一标志值
				var userid = GetExtCertInfoByOID(userCert,'1.2.156.112562.2.1.1.1');
				document.getElementById("CAUserID").value = userid;
			}	
        

</script>
		
</body>
</html>