<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/front/include/taglib.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
	<meta name="decorator" content="frontdefault"/>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>${fns:getProjectName()}_${newsDetail.newsdetailtitle}</title>
	<meta name="keywords" content="" />
	<meta name="description" content="" />
</head>
<body >	
		<div id="content"> 
			<div class="yil">
							<div class="xq">
								<div class="center">
										<div class="title" style="width:1000px;">
											
										<a href="" onclick="javascript :history.back(-1);" ><img  width="55px" height="55px"  src="${ctxStaticFront}/images/timg.jpg">	</a>					<h1 id="newsDate" >${newsDetail.newsdetailtitle}</h1>
										
												<p><fmt:formatDate value="${newsDetail.pubtime}" pattern="yyyy/MM/dd HH:mm:ss"/> 　作者：${newsDetail.newsdetailauthor} 　来源：${newsDetail.newsdetailsfrom}</p>
												
												<div style="margin:0px auto;width:500px;">
													<div class="sc">
														<c:if test="${empty newscollectmsg}">
															<a href="" onclick="collection(${newsDetail.newsdetailid})">
															<span id="teColecction">收藏</span>
															<img src="${ctxStaticFront}/images/sc.png">
															</a>
														</c:if>
														<c:if test="${not empty newscollectmsg}">
															<a href="" onclick="collection(${newsDetail.newsdetailid})">
															<span id="teColecctions">已收藏</span>
															<img src="${ctxStaticFront}/images/sc.png">
															</a>
														</c:if>
													</div>
													<div class="bdsharebuttonbox" data-tag="share_1">
														<a href="#" onclick="shareNum(${newsDetail.newsdetailid})" class="bds_sqq" data-cmd="sqq" style="background:url(${ctxStaticFront}/images/qq.png) center no-repeat;width:36px;height:36px;padding-left:0"></a>
														<a href="#" onclick="shareNum(${newsDetail.newsdetailid})" class="bds_qzone" data-cmd="qzone" href="#" style="background:url(${ctxStaticFront}/images/qqkj.png) center no-repeat;width:36px;height:36px;padding-left:0"></a>
														<a href="#" onclick="shareNum(${newsDetail.newsdetailid})" class="bds_tsina" data-cmd="tsina" href="#" style="background:url(${ctxStaticFront}/images/newweibo.png) center no-repeat;width:36px;height:36px;padding-left:0"></a>
														<a href="#" onclick="shareNum(${newsDetail.newsdetailid})" class="bds_weixin" data-cmd="weixin" style="background:url(${ctxStaticFront}/images/newweixin.png) center no-repeat;width:36px;height:36px;padding-left:0"></a>
	                                               </div>
                                               </div>
                                               
                                               </div>
                                        <div class="newstext">
											<p class="pic">
										
											<c:if test="${not empty newsDetail.newsdetailspicture}">
<!-- 												<img src="${newsDetail.newsdetailspicture}"> -->
												</c:if>
											</p>
											<p id="newsContent">${newsDetail.newsdetailcontent}</p>
										</div>
										</div>
										
										
								</div>
							</div>
			       	</div>
				      <input type="hidden" id="userinfos"  name="userinfos"  value="${userinfo.userId}"/>
<script type="text/javascript">


	function collection(v){//收藏
	 var userInfo = $("#userinfos").val();
	 
	 if(userInfo != null && userInfo !=""){
	 $.ajax({
	 	type: "POST",
			url: "${ctx}/news/addNewsCollect?newsid="+v,
			cache:false,
			async: false, 
			success: function(jsonJson){
			  if(jsonJson.success){
			     layer.msg(jsonJson.msg);
			    jQuery('#teColecction').html("");
			    $("#teColecction").text("已收藏");
			    $("#teColecctions").text("已收藏");
			  }
			  else{
				   layer.msg(jsonJson.msg);
				   $("#teColecction").text("收藏");
				   $("#teColecctions").text("收藏");
					}
			  }
		});
	}
	else{
	 window.location.href  ="${ctx}/login?url=/news/"+v+".html";
	}
   }
	
	
	
	
	function shareNum(newsDetailid){//分享次数
	 $.ajax({
	 	type: "POST",
			url: "${ctx}/news/shareNum?newsid="+newsDetailid,
			cache:false,
			async: false, 
			success: function(jsonJson){
			 
			}
		});
	
	}

</script>
<script>
	with(document)0[(getElementsByTagName('head')[0]||body).appendChild(createElement('script')).src='http://bdimg.share.baidu.com/static/api/js/share.js?cdnversion='+~(-new Date()/36e5)];
	
</script>

</body>
</html>