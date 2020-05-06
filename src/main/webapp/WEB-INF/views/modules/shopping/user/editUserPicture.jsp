<%@ page trimDirectiveWhitespaces="true" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/modules/front/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
  <meta name="description" content="">
  <meta name="author" content="">
  <link rel="shortcut icon" href="images/favicon.png" type="image/png">
<style>
	.grayBorderB{
	border-bottom: 1px solid #f2f2f2;
}
.fright{float: right;}
.fleft{float: left;}

a.fullBtnBlue:hover{
	background-color:#2b8cc5;
	color:#fff;
}
a.fullBtnBlue{
	display: inline-block;
	height: 50px;
	width: 342px;
	font-size: 20px;
	line-height: 50px;
	text-align: center;
	margin-bottom: 20px;
	*margin-bottom: 10px;
	outline: none;
	cursor:pointer;
	background-color: #32a5e7;
	color: #fff;
}
a.fullBtnGray{
	display: inline-block;
	width: 156px;
	height: 50px;
	line-height: 50px;
	font-size: 20px;
	text-align: center;
	outline: none;
	cursor:pointer;
	background-color: #d9d9d9;
	color: #fff;
}
a.fullBtnGray:hover{
	background-color:#c3c3c3;
	color:#fff;
}
.i_icon{
	display: inline-block;
	width: 100%;
	height: 100%;
	overflow: hidden;
}
	</style>
  <title>个人信息</title>

  <link href="${ctxStatic}/doctor/css/style.default.css" rel="stylesheet">
  <link href="${ctxStatic}/doctor/css/modifyIcon.css" type="text/css" rel="Stylesheet"/>
  <link href="${ctxStatic}/doctor/css/jquery-confirm.min.css" type="text/css" rel="Stylesheet"/>
  <link href="${ctxStatic}/front/js/Jcrop-master/css/jquery.Jcrop.min.css" type="text/css" rel="stylesheet"/>
     <script type="text/javascript">
        var ctx="${ctx}";
     </script>
  <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
  <!--[if lt IE 9]>
  <script src="${ctxStatic}/doctor/js/html5shiv.js"></script>
  <script src="${ctxStatic}/doctor/js/respond.min.js"></script>
  <![endif]-->
</head>

<body>



<!-- Preloader -->
<div id="preloader">
    <div id="status"><i class="fa fa-spinner fa-spin"></i></div>
</div>


<section>
  <div class="contentpanel">
   <input type='hidden' id="mz_csrf_tks" value=""/>
		<div>
			<div id="mainWrap" class='mainWrap'>
				<div class="grayBorderB">
					<div class="titleWrap">
						<div class="leftWrap-bottom" style="line-height: 33px;margin-right: 20px">
							<span class="fright">支持jpg、jpeg、png、bmp格式，文件小于5M</span>
						</div>
						<div class="clear"></div>
					</div>
			    </div>
				<div id="upload">
					<form id="uploadForm" name="uploadForm" enctype="multipart/form-data">
						<div class='lineWrap grayTip divFloat' id="bg4chooseImg">
							<a id="chooseImg" class="normalInput">
								<em><i class="i_icon"></i>选择照片</em>
							</a>
						</div>
						<input type="file" id="file" name="file" class="file" size="28" accept="image/*"/>
						<!--[if lte IE 8]><span style="position:absolute; left:140px; top:5px">双击选择照片</span><![endif]-->
					</form>
					<div class="contain">
							<div class="frame marginOrgFrame originalImg">
								<img id="origImg"  class="originalMaxWH" data-src="${ctx}/${userinfo.photo}">
							</div>
							<div class="instrunction">
								您上传的头像会自动生成三种尺寸，请注意中小尺寸是否清晰
							</div>
							<div class="marginBigFrame bigImgTop" id="preview200" style="top:  130.678px; left: 375px;">
								<div class="frame marginBigFrame bigImg">
									<img id="bigImg" src="${ctx}/${userinfo.photo}">
								</div>
								<span class="imgTip big">200*200px</span>
							</div>
							<div class="commonFrame middleImgTop" id="preview100"  style="top:  130.678px; left: 605px;">
								<div class="frame commonFrame middleImg">
									<img id="middleImg" src="${ctx}/${userinfo.photo}">
								</div>
								<span class="imgTip common">100*100px</span>
							</div>
							<div class="commonFrame smallImgTop" id="preview50" style="top:  130.678px; left: 735px;">
								<div class="frame commonFrame smallImg">
									<img id="smallImg" src="${ctx}/${userinfo.photo}">
								</div>
								<span class="imgTip small">50*50px</span>
							</div>
						</div>
					<div class='lineWrap ftop' style="">
						<a class="fullBtnBlue fleft" id='save'>保存</a>
						<!-- <a class="fullBtnGray black iconCancel fleft" id='cancel' href="javascript:history.go(0)">取消</a> -->
						<a class="fullBtnGray black iconCancel fleft" id='cancel' >取消</a>
					</div>
				</div>
					<form id="scropForm" name="scropForm" enctype="application/x-www-form-urlencoded">
						<input type="hidden"  id="origIconUrl" name="origIconUrl" value="${usermsg.photo}"/>
						<input type="hidden"  id="x" name="x" />
						<input type="hidden"  id="y" name="y" />
						<input type="hidden"  id="w" name="w" />
						<input type="hidden"  id="h" name="h" /> 
						<input type="hidden"  id="objectId" name="objectId" value="${usermsg.userId }"/> 
						<input type="hidden"  name="action" value="user"/> 
					</form>
			</div>
		</div>
	</div>
    </div><!-- contentpanel -->
  </div><!-- mainpanel -->
  
 
  
</section>


<script src="${ctxStatic}/doctor/js/jquery-1.11.1.min.js"></script>
<script src="${ctxStatic}/doctor/js/jquery-migrate-1.2.1.min.js"></script>
<script src="${ctxStatic}/doctor/js/bootstrap.min.js"></script>
<script src="${ctxStatic}/doctor/js/modernizr.min.js"></script>
<script src="${ctxStatic}/doctor/js/jquery.sparkline.min.js"></script>
<script src="${ctxStatic}/doctor/js/toggles.min.js"></script>
<script src="${ctxStatic}/doctor/js/retina.min.js"></script>
<script src="${ctxStatic}/doctor/js/jquery.cookies.js"></script>
<script src="${ctxStatic}/doctor/js/jquery-confirm.min.js"></script>
<script src="${ctxStatic}/doctor/js/jquery.prettyPhoto.js"></script>
<script src="${ctxStatic}/doctor/js/holder.js"></script>
<script src="${ctxStatic}/doctor/js/myalert.js"></script>

<script src="${ctxStatic}/doctor/js/custom.js"></script>
<script type="text/javascript" src="${ctxStatic}/front/js/jquery.form.js" charset="utf-8"></script>
	<script type="text/javascript" src="${ctxStatic}/front/js/base.js" charset="utf-8"></script>
	<script type="text/javascript" src="${ctxStatic}/front/js/Jcrop-master/js/jquery.Jcrop.min.js" charset="utf-8"></script>
	<script type="text/javascript" src="${ctxStatic}/front/js/layer/layer.js"></script>
	<script type="text/javascript" src="${ctxStatic}/front/js/useramodifyIcon.js" charset="utf-8"></script>
<link rel="stylesheet" href="${ctxStatic}/front/js/layer/skin/layer.css" id="layui_layer_skinlayercss">
<script>
  $("#cancel").click(function () {
          var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
          parent.layer.close(index);
        }
        );
   
</script>

</body>
</html>
