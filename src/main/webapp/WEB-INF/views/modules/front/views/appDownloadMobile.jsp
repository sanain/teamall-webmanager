<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/front/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>

<meta name="keywords" content="" />
<meta name="description" content="" />

	<link rel="stylesheet" type="text/css" href="${ctxStaticFront}/css/style.css" media="all" />
	<link rel="stylesheet" type="text/css" href="${ctxStaticFront}/css/animat.css" media="all" />
	<link rel="stylesheet" type="text/css" href="${ctxStaticFront}/css/filp.css" media="all" />
	<link rel="stylesheet" type="text/css" href="${ctxStaticFront}/css/chinaz.css" media="all" />
	<script type="text/javascript" src="${ctxStaticFront}/js/jquery.min.js"></script>
	<script type="text/javascript" src="${ctxStaticFront}/js/dome.js"></script>


 	<style type="text/css">
 *{padding: 0;margin: 0;list-style-type: none;text-decoration: none;font-family:"5FAE8F6F96C59ED1", "Microsoft Yahei";}
 body{background: #f4f4f4}
.l{float: left}
.r{float: right;}
.mobile{width: 640px;margin: 0 auto;}
.mobile h1{width: 100%;text-align: center;font-size: 36px;color: #4c4c4c;padding: 25px 0;font-weight: normal;background: #fff}
.mobile .mobile_bg{background:url(${ctxStaticFront}/images/mobile_bg.jpg) center top no-repeat;width: 100%;overflow: hidden;padding: 60px 0;}
.mobile .l{width: 320px;overflow: hidden;}
.mobile .l .fonts{height: 185px;width: 100%;text-align: center;font-size: 30px;color: #fff}
.mobile_top{overflow: hidden;width: 100%;margin-top: 20px;}
.mobile .l .fonts p{line-height: 45px}
.mobile .l .fonts .Ycenter{margin-top: 120px}
.mobile .l .download{width: 100%;text-align: center;}
.mobile .l .download a{width: 230px;padding: 20px 0;font-size: 30px;line-height: 32px;color: #65c4e8;background: rgba(255,255,255,0.8);display: block;text-align: center;border-radius: 10px;border: 1px solid #3ab8e8}
.mobile .l .download a span{display: inline-block;padding-left: 50px}
.mobile .l .download li{display: inline-block;float: none;margin-bottom: 50px;}
.mobile .r{width: 320px;overflow: hidden;}

.ewm{width: 100%;text-align: center;margin-top: 100px;}
.ewm li{display: inline-block;margin: 0 35px}

.ewm li p{font-size: 24px;color: #333333}

 	</style>



</head>
<body style="">	
		<div class="mobile" >
			<h1>${fns:getProjectName()}客户端下载</h1>
			<div class="mobile_bg">
				<div class="mobile_top">
					<div class="l">
						<div class="fonts">
							<div class="Ycenter">
								<p>${fns:getProjectName()}</p>
								<p>成就健康人生</p>
							</div>
						</div>
						<div class="download">
							<ul>
								<li><a href="${ctx}/${android.versionsrc}"><span style="background:url(${ctxStaticFront}/images/mobile_android.png) center left no-repeat">安卓下载</span></a></li>
								<li><a href="${ctx}/${appios.versionsrc}"><span style="background:url(${ctxStaticFront}/images/mobile_ios.png) center left no-repeat">IOS下载</span> </a></li>
							</ul>
							
						</div>
				</div>
				<div class="r">
					
					<img src="${ctxStaticFront}/images/mobile_phone.png">
				</div>

				</div>
				<ul class="ewm">
						<li><img src="${ctxStaticFront}/images/ewmweixinbig.jpg"><p>关注${fns:getProjectName()}茶微信号</p></li>
						<li><img src="${ctxStaticFront}/images/appdownload.jpg"><p>扫描下载${fns:getProjectName()}</p></li>
				</ul>



			</div>





		</div>
	

			
		
	
<script type="text/javascript"> 
		
</script>

</body>
</html>
