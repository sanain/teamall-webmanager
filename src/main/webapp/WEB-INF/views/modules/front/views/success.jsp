<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/modules/front/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta name="decorator" content="frontdefault" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>用户注册</title>
<meta name="keywords" content="" />
<meta name="description" content="" />
</head>
<body >	
		<div id="content"> 
				<div class="block_name mt"> 
							
							<span class=""> registration</span>
							<p class="">用户注册</p>
							<div class="brd"></div>
				</div>
				<br/>
				<div class="success">
						<h1><img src="${ctxStaticFront}/images/suc.png"><span>恭喜您注册成功!</span></h1>
						<p>系统将会在<b>10</b>秒后跳转至用户中心</p>
						<ul>
							<li style="padding-right:15px;margin-right:15px;border-right:1px solid #a1a7ae"><a href="${ctx }/list">返回本站首页</a></li>
							<li><a href="${ctx }/login">进入登录</a></li>
						</ul>
						
						<span class="sp1">温馨提示：在个人中心完成实名认证后，才可使用本站医疗服务</span>
						
				</div>

		</div>
			

<script type="text/javascript">


		function js(){ 
				setTimeout(function(){ 
			var len = $(".success p b").text()
				if(len>1){ 
					len--;
					$(".success p b").text(len)
					js()
				}else{ 

					window.location.href="${ctx}/login";
				}

		},1000)

		} 

		js()

</script>



</body>
</html>