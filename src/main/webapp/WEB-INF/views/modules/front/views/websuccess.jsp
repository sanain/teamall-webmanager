<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/modules/front/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta name="decorator" content="frontdefault" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>状态提示</title>
<meta name="keywords" content="" />
<meta name="description" content="" />
</head>
<body >	
		<div id="content"> 
						<div class="newsnav"> 
								<div class="center">
										<a href="${ctx}/">首页   >   状态提示</a>

								</div>
	

						</div>
						<div class="queren">
								<div class="block_name mtt"> 
								<span class="">State Info</span>
								<p class="">状态信息</p>
								<div class="brd"></div>
								</div> 

								<div class="center">
									<div class="poin">
										<div class="l">
												
												<img src="${ctxStaticFront}/images/pion.png">
										</div>
										<div class="r">
												
												<div class="href">
													<p>${msg}
													<span>系统将会在<b>10</b>秒后跳转至网站首页</span>
												</p>
													
												</div>	
												<span>点击进入-<a href="${ctx}/userinfo/baseinfo">用户中心</a>查看信息</span> 

										</div>


									</div>
																
							</div>
						</div>

				
		</div>
			

<script type="text/javascript">


		function js(){ 
			 setTimeout(function(){ 
				var len = $(".href b").text();
				if(len>1){ 
					len--;
					$(".href b").text(len)
					js()	
				}else{ 
					window.location.href="${ctx}/userinfo/userregisterinfo";
				}	
	
			},1000)

		}  

		js()

</script>



</body>
</html>