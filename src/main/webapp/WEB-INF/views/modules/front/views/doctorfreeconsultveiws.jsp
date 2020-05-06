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
	<script type="text/javascript" src="${ctxStaticFront}/js/jquery.min.js"></script>
	<script type="text/javascript" src="${ctxStaticFront}/js/dome.js"></script>
	<script type="text/javascript" src="${ctxStaticFront}/js/superslide.2.1.js"></script>
	<script type="text/javascript" src="${ctxStaticFront}/layer/layer.js"></script>
	<script type="text/javascript" src="${ctxStaticFront}/js/jquery.mousewheel.js"></script>
	<script type="text/javascript" src="${ctxStatic}/front/js/jquery.form.js" charset="utf-8"></script>
	<script type="text/javascript" src="${ctxStatic}/front/js/base.js" charset="utf-8"></script>
	<script type="text/javascript" src="${ctxStatic}/front/js/Jcrop-master/js/jquery.Jcrop.min.js" charset="utf-8"></script>
	<script type="text/javascript" src="${ctxStatic}/front/js/layer/layer.js"></script>
	<script type="text/javascript" src="${ctxStatic}/front/js/useramodifyIcon.js" charset="utf-8"></script>
   <link rel="stylesheet" href="${ctxStatic}/front/js/layer/skin/layer.css" id="layui_layer_skinlayercss">
	
	
</head>
<body>
 <div id="content"> 
				<div class="yizhen">
					<div class="zixun">
						<div class="Fontsbar">
								<p>免费咨询</p>
								<span>Free consultation</span>
						</div>
						<div class="center">
							<textarea  id="textareaid" placeholder="请在此输入您想咨询的问题，例如：" style="width:75%;height:150px;margin-left:160px;"></textarea>

							<input type="submit" class="org" value="提&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;交" onclick="javascript:freeconsultupdate();"  >
						</div>	

					</div>
				</div>
                <input type="hidden" id="doctorids"  name="doctorids"  value="${doctorid}" />
</body>
 <script type="text/javascript">
    var ctx="${ctx}";
</script>
<script type="text/javascript"> 
     /* 免费咨询提交数据 */	
	function freeconsultupdate(){
	var doctorId = $("#doctorids").val();
	var  content= $("#textareaid").val();
	$.ajax({
	 	type: "POST",
			url: "${ctx}/doctor/doctorfreeconsultinfo?doctorid="+doctorId+"&contents="+content,
			cache:false,
			async: false, 
			success: function(jsonJson)
			{
				if(jsonJson.success){
				   layer.confirm('您的咨询已提交！系统审核通过后，将会有医生给您回复。您可以在个人中心-我的咨询-中查看。', {
                        btn: ['返回医生主页','查看咨询记录'] //按钮
                    }, function(){
                      var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
                   	  parent.window.location.href = ctx+"/doctor/"+doctorId+".html";//跳转到医生主页
                   	  parent.layer.close(index);//关闭弹出窗口
                    }, function(){
                      var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
                   	  parent.window.location.href = ctx+"/userinfo/userconsultinfo";//跳转到用户中心-我的咨询
                   	  parent.layer.close(index);//关闭弹出窗口
                    });
				}else{
				alert(jsonJson.msg);
				}
			}
		});
   }
</script>

</html>
