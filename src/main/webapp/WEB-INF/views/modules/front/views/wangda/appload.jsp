<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/front/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>健康四川</title>

<meta name="keywords" content="" />
<meta name="description" content="" />

	<link rel="stylesheet" type="text/css" href="${ctxStaticFront}/css/style.css" media="all" />
	<link rel="stylesheet" type="text/css" href="${ctxStaticFront}/css/animat.css" media="all" />
	<link rel="stylesheet" type="text/css" href="${ctxStaticFront}/css/filp.css" media="all" />
	<link rel="stylesheet" type="text/css" href="${ctxStaticFront}/css/chinaz.css" media="all" />
	
	<script type="text/javascript" src="${ctxStaticFront}/js/jquery.min.js"></script>
	<script type="text/javascript" src="${ctxStaticFront}/js/dome.js"></script>




</head>
<body style="background:url(${ctxStaticFront}/images/apploadbg.jpg) center top no-repeat">	

		<div id="top_ys" class="animate-element top_to_bottom "> 
			<%@include file="/WEB-INF/views/modules/front/include/topother.jsp" %>
				
		</div>
		<div id="content">
		    <div class="newsnav"> 
				<div class="center">
				<a href="${ctx}/">首页    >  </a>
			    <a href="${ctx}/appload">APP下载</a>
			    </div>
       </div>
		    
		
		 
			<div class="appload headline-bg index-headline-bg wavesWapper">
						<div class="block_name mtt"> 
							
							<span class="animate-element left_to_right">Download APP</span>
							<p class="animate-element right_to_left">APP下载</p>
							<div class="brd"></div>
						</div>
						
						<canvas id="waves" class="waves" style="height: 999px"></canvas>
						<div class="center">
								<div class="l">
									<div class="phone ">
									    
									    <img src="${ctxStaticFront}/images/sj1.png" class="img1 animate-element apptop">
										<img src="${ctxStaticFront}/images/sj2.png" class="img2 animate-element apptop1">
									</div>
									
										
									

								</div>
								<div class="r">
									<div class="bg animate-element scale">
										<ul>
											<%-- <li><a href="${ctx}/${appios.versionsrc}" style="background:url(${ctxStaticFront}/images/ios.png) 10px center  no-repeat">点击下载</a>
											<div class="ewm">
												<img src="${ctxStaticFront}/images/ewmios.jpg">
												<p>Ios版APP扫描下载</p>
											</div>
											</li> --%>
											<li><a href="${ctx}/${android.versionsrc}" style="background:url(${ctxStaticFront}/images/adr.png) 10px center  no-repeat">点击下载</a>
											<div class="ewm">
												<img src="${ctxStaticFront}/images/ewm.jpg">
												<p>安卓版APP扫描下载</p>
											</div>
											</li>
											<li style="margin-right:0"><a href="" style="background:url(${ctxStaticFront}/images/wxmsg.png) 10px center  no-repeat">扫描关注</a>
											<div class="ewm">
												<img src="${ctxStaticFront}/images/ewmweixin.jpg">
												<p>健康四川微信关注</p>
											</div>
											</li>

										</ul>


									</div>

								</div>

						</div>
			</div>
				
<script src="${ctxStaticFront}/js/49f8daee.vendors.js"></script>
<script src="${ctxStaticFront}/js/26f2fc0d.index.js"></script>

					
				
		</div>
		<%@include file="/WEB-INF/views/modules/front/include/bottom.jsp" %>
	
<script type="text/javascript"> 
			var oldc=$($(".sel ul li.on"));

			$(".sel ul li").click(function(){ 
						if(!$(this).hasClass("add")){ 
									oldc.removeClass("on")
									$(this).addClass("on")
									oldc=$(this)
						}
						
			})



</script>

</body>
</html>
