<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/front/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<meta name="decorator" content="frontindex"/>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title></title>
	<meta name="keywords" content="" />
	<meta name="description" content="" />
</head>
<body >	
<style>
.center {
    margin: -4px auto;
    width: 1140px;
}
#top .nav {
    width: 100%;
    overflow: hidden;
    z-index: 9999;
    transition: all 0.3s ease 0s;
    left: 0px;
    border-bottom: 1px solid transparent;
    height: 75px;
    padding-top: 0px;
}
	
	h1{
		font: bold 80%/120% Arial, Helvetica, sans-serif;
		text-transform: uppercase;
		margin: 0 0 10px;
		color: #999;
	}
	h2{
		font-size: 22px;
		margin: 0 0 8px;
	}
	h3{
		font-size: 1.6em;
		margin: 10px 0 5px;
	}
	a{
		color: #333;
		text-decoration: none;
	}
	
	p{
		margin-bottom:15px;
	}
	#back-to-top{
		position:fixed;
		bottom:50px;
		right:20px;
	}
	#back-to-top a{
		text-align:center;
		text-decoration:none;
		color:#d1d1d1;
		display:block;
		width:80px;
		/*使用CSS3中的transition属性给跳转链接中的文字添加渐变效果*/
		-moz-transition:color 1s; 
		-webkit-transition:color 1s;
		-o-transition:color 1s;
	}
	#back-to-top a:hover{
		color:#979797;
	}
	#back-to-top a span{
		background:#d1d1d1;
		border-radius:6px;
		display:block;
		height:80px;
		width:80px;
		background:#d1d1d1 url(${ctxStaticFront}/images/arrow-up.png) no-repeat center center;
		margin-bottom:5px;
		-moz-transition:background 1s;
		-webkit-transition:background 1s;
		-o-transition:background 1s;
	}
	#back-to-top a:hover span{
		background:#979797 url(${ctxStaticFront}/images/arrow-up.png) no-repeat center center;
	}
	p {
    margin-bottom: 7px;
}
.i5 li .userpic p{position: absolute;background: rgba(254,130,76,1);width: inherit;height: inherit;
border-radius: 50%;opacity: 0;-webkit-transition: all 0.4s ease-in-out;-moz-transition: all 0.4s ease-in-out;
-o-transition: all 0.4s ease-in-out;-ms-transition: all 0.4s ease-in-out;transition: all 0.4s ease-in-out;
-webkit-transform: scale(0);-moz-transform: scale(0);-o-transform: scale(0);-ms-transform: scale(0);transform: scale(0);
-webkit-backface-visibility: hidden;behavior: url(./static/front/js/PIE.htc);}

  </style>
  <div class="clear"></div>
<hidden  id="parentIframe" name="parentIframe"    onkeyup="hrefs(this);"/>
<p id="back-to-top"><a href="#top"><span></span>回到顶部</a></p>
<div class="clear"></div>
		<div id="content" class="index">
				
						<div class="fullSlide">
							<div class="bd">
							    <ul>
							      <li _src="url(${ctxStaticFront}/images/banner.jpg)" style="background:#fff center 0 no-repeat;">
							      	<div class="center">
							      		<div class="SlideFonts SlideBar opacity">
							      			<img src="${ctxStaticFront}/images/fonts.png">
			
							      		</div>
							      		<div class="SlideButton SlideBar opacity">
							      			<a  href="${ctx}/userinfo/healthFile">
							      			<img src="${ctxStaticFront}/images/button.png" class=""></a>
			
							      		</div>
			
							      	</div>
			
			
							      </li>
							      <li _src="url(${ctxStaticFront}/images/banner.jpg)" style="background:#fff center 0 no-repeat;">
							      	<div class="center">
							      		<div class="SlideFonts SlideBar ">
							      			<img src="${ctxStaticFront}/images/fonts.png">
			
							      		</div>
							      	
								      		<div class="SlideButton SlideBar ">
								      			<a href="${ctx}/userinfo/healthFile">
								      				<img src="${ctxStaticFront}/images/button.png">
								      			</a>
								      		</div>
										
							      	</div>
			
			
							      </li>
							    
							    </ul>
							</div>
						
						</div>
							<div class="i1 navbar" >
								<div class="center">
										<ul class="">
												<li style="background:url(${ctxStaticFront}/images/bbg1.jpg) center no-repeat" class="animate-element top_to_bottom">
													<a href="${ctx}/statistics">
														<h2 class="left_to_right">全省号源</h2>
														<p class="animate-element right_to_left">点击我,您可以了解全省医院的号源情况</p>
														<span class="">请点击进入</span>
													</a>
				
												</li>
												<li style="background:url(${ctxStaticFront}/images/bbg.jpg) center no-repeat" class="animate-element top_to_bottom">
													<a href="${ctx}/medical/medicalinfo">
														<h2 class="left_to_right">查找医院</h2>
														<p class="animate-element right_to_left">点击我,您可以了解全省医院的信息</p>
														<span class="">请点击进入</span>
													</a>
												</li>	
												<li style="background:url(${ctxStaticFront}/images/bbg2.jpg) center no-repeat;margin-right:0" class="animate-element top_to_bottom">
													<a class="guahaof"  href="${ctx}/womenandchildreninfo">
														<h2 class="left_to_right">妇幼专区</h2>
														<p class="animate-element right_to_left">点击我，您可以了解全省妇幼医院的号源与床位信息</p>
														<span class="">请点击进入</span>
													</a>
												</li>
										</ul>
								</div>
				
							</div>
							<div class="i2 navbar"  id="yl"> 
								<div class="center">
									<div class="block_name index"> 
										<div class="index">
											<span class="animate-element left_to_right">CLINIC SERVICE</span>
											<p class="animate-element right_to_left">就诊服务</p>
											<div class="brd"></div>
										</div>	
									</div>
									<ul class="butn">
											<li class="guahao">	
												<a href="">
												<div class="i2_sk animate-element scale" > 
												<img src="" class="">
												</div>
												<p class="animate-element left_to_right"><span>预约挂号</span></p>
												</a>
											</li>
											<li>	
												<a href="${ctx}/userinfo/reportinfo">
												<div class="i2_sk animate-element scale" > 
												<img src="" class="">
												</div>
												<p class="animate-element left_to_right"><span>报告查询</span></p>
												</a>
											</li>
											<li>	
												<a href="${ctx}/userinfo/palyinfo">
												<div class="i2_sk animate-element scale" > 
												<img src="" class="">
												</div>
												<p class="animate-element left_to_right"><span>缴费记录</span></p>
												</a>
											</li>
											<li>	
												<a href="${ctx}/userinfo/useroutpatientinfo">
												<div class="i2_sk animate-element scale" > 
												<img src="" class="">
												</div>
												<p class="animate-element left_to_right"><span>门诊记录</span></p>
												</a>
											</li>
											<li>	
												<a href="${ctx}/userinfo/healthFile">
												<div class="i2_sk animate-element scale" > 
												<img src="" class="">
												</div>
													<p class="animate-element left_to_right"><span>健康档案</span></p>
												</a>
											</li>
										
											
											
									</ul>
										<div class="fmt">
											<div class="l animate-element left_to_right">
												<ul> 
													<c:forEach  items="${doctort}" var="hd"  varStatus="dcsa">	
														<li class="${dcsa.count==1?'on':'' }">
															<c:if test="${not empty hd.photourl }">
																	<a href="" ><img src="${hd.photourl}"></a>
															</c:if>
															<c:if test="${empty hd.photourl  }">
																	<a href="" ><img src="${ctxStaticFront}/images/indexdefaul.png"></a>
															</c:if>
														</li>
												</c:forEach>	
												</ul>
											</div>
											<div class="r animate-element right_to_left">
											<ul>
												<c:forEach  items="${doctort}" var="doctor" varStatus="status">	
																<li class="${status.count==1?'on':'' }">
																  <a href="./doctor/${doctor.doctorId}${urlSuffix}">
																	<div class="fonts">
																	<p class="p1">推荐专家</p>
																	<div class="name">	 
																		<p class="p2">${doctor.name}</p>
																		<p class="p3">${doctor.job}<br/><span></span></p>
																	</div>
																	<div class="small">
																		${doctor.hospitalname }</br>
																		${doctor.specialty }</br>
																	  <c:set var="docdesc" value="${fns:abbr(doctor.ddesc,100)}"/>
																		简介: ${docdesc}
																	</div>
																	</div>
																	<div class="zpic">
																		    <c:if test="${doctor.sex == '1'}">
																		    <img src="${ctxStaticFront}/images/indexnan.png">
																			</c:if>
																			<c:if test="${doctor.sex == '2'}">
																			    <img src="${ctxStaticFront}/images/indennv.png">
																		    </c:if>
																	</div>
																</li>
												</c:forEach>
				
											</ul>
								
				
											</div>
				
				
				
										</div>
										
										<div class="clear"></div>
										<a href="${ctx}/medical/medicalinfo" class="org animate-element scale">
										查看所有医院
										</a>
									</div>	
										
								</div>
			
						<div class="i3 navbar"  id="yc"> 
								<div class="center">
								<div class="block_name index"> 
									<div class="index">
										<span class="animate-element left_to_right">NETWORK MEDICAL</span>
										<p class="animate-element right_to_left">网络医疗</p>
										<div class="brd"></div>
									</div>	
								</div>
								<ul> 
										<li class="animate-element top_to_bottom"><a href="${ctx}/medical/remote"><img src="${ctxStaticFront}/images/news.png"></a></li>
										<li class="animate-element top_to_bottom"><a href="${ctx}/medical/remote"><img src="${ctxStaticFront}/images/say.png"></a></li>
										<li class="animate-element top_to_bottom"><a href="${ctx}/medical/remote"><img src="${ctxStaticFront}/images/sp.png"></a></li>
			
								</ul>
								<div class="clear"></div>
								<a class="org animate-element scale" href="${ctx}/medical/remote">
									查看所有内容
								</a>
								</div>	
			
			
			
			
			
						</div>
						<div class="i4 navbar"  id='dt'> 
								<div class="center">
										<div class="block_name index"> 
											<div class="index">
											<span class="animate-element left_to_right">INTELLIGENT GUIDE</span>
											<p class="animate-element right_to_left">智能导诊</p>
											<b style="color:red;font-size:15px;">点击人体图片上对应部位，查看可能疾病和相关科室，该提示仅供参考，如有疑问请咨询医务人员。</b>
										<!-- 	<div class="brd"></div> -->
											</div>
										</div>
			
								<%-- 		<div class="l"> 
											<h2>按部位导诊</h2>
											<div id="box" class="box viewport-flip">
												<a  class="list flip  "><img src="${ctxStaticFront}/images/flip_1.png" alt="正面" /></a>
												<a  class="list flip out"><img src="${ctxStaticFront}/images/flip_2.png" alt="背面" /></a>
												
												<div class="sc">
													<img src="${ctxStaticFront}/images/zs.jpg">
												</div>
											</div>
											<div class="zm">
													<a  id="buwei1"  href=""><img src="${ctxStaticFront}/images/zm_4.png" style="left:40px;top:80px"></a>
													<a  id="buwei2"  href=""><img src="${ctxStaticFront}/images/zm_3.png" style="right:50px;top:75px"></a>
													<a  id="buwei3"  href=""><img src="${ctxStaticFront}/images/zm_7.png" style="left:0px;top:250px"></a>
													<a id="buwei4"  href=""><img src="${ctxStaticFront}/images/zm_1.png" style="right:90px;top:190px;z-index:66"></a>
													<a id="buwei5"  href=""><img src="${ctxStaticFront}/images/zm_5.png" style="right:20px;top:260px"></a>
													<a id="buwei6"  href=""><img src="${ctxStaticFront}/images/zm_2.png" style="left:60px;top:325px"></a>
													<a id="buwei7"  href=""><img src="${ctxStaticFront}/images/zm_6.png" style="right:100px;top:400px"></a>
											</div>
											<div class="bm">
															<a id="buwei8"  href=""><img src="${ctxStaticFront}/images/bm_1.png" style="left:50px;top:200px"></a>
															<a id="buwei9"  href=""><img src="${ctxStaticFront}/images/bm_3.png" style="left:70px;top:340px"></a>
															<a id="buwei10"  href=""><img src="${ctxStaticFront}/images/bm_2.png" style="right:70px;top:320px"></a>
			
											</div>
											
										</div> --%>
										
										
										<div class="l"> 
								<h2>按常见病导医</h2>
								
								<div id="box" class="box viewport-flip">
									<div class="BoxS">
										<a href="" class="on" zmrel="${ctxStaticFront}/images/flip_1.png" bmrel="${ctxStaticFront}/images/flip_2.png">男</a>
										<a href="" class="" zmrel="${ctxStaticFront}/images/wuman.png" bmrel="${ctxStaticFront}/images/wumanbm.png">女</a>
									</div>
									<a  class="list flip  "><img src="${ctxStaticFront}/images/flip_1.png" alt="正面" /></a>
									<a  class="list flip out"><img src="${ctxStaticFront}/images/flip_2.png" alt="背面" /></a>
									<div class="sc">
										<img src="${ctxStaticFront}/images/zs.jpg">
								</div>
									
								</div>
								
								<div class="zm">
												<a  id="buwei1"  href=""><img src="${ctxStaticFront}/images/zm_4.png" style="left:40px;top:80px"></a>
													<a  id="buwei2"  href=""><img src="${ctxStaticFront}/images/zm_3.png" style="right:103px;top:75px"></a>
													<a  id="buwei3"  href=""><img src="${ctxStaticFront}/images/zm_7.png" style="left:0px;top:250px"></a>
													<a id="buwei4"  href=""><img src="${ctxStaticFront}/images/zm_1.png" style="right:90px;top:190px;z-index:66"></a>
													<a id="buwei5"  href=""><img src="${ctxStaticFront}/images/zm_5.png" style="right:20px;top:260px"></a>
													<a id="buwei6"  href=""><img src="${ctxStaticFront}/images/zm_2.png" style="left:60px;top:325px"></a>
													<a id="buwei7"  href=""><img src="${ctxStaticFront}/images/zm_6.png" style="right:100px;top:400px"></a>
											
								</div>
								<div class="bm">
														<a id="buwei8"  href=""><img src="${ctxStaticFront}/images/bm_1.png" style="left:50px;top:200px"></a>
															<a id="buwei9"  href=""><img src="${ctxStaticFront}/images/bm_3.png" style="left:70px;top:340px"></a>
															<a id="buwei10"  href=""><img src="${ctxStaticFront}/images/bm_2.png" style="right:70px;top:320px"></a>
			


								</div>
							</div>
										
										<div class="r"> 
												<h2>按常见病导诊</h2>
										<ul id="masonry">
												
											<c:forEach items="${illnessList}" var="illness">
												<li><a style="display:block;overflow:hidden;word-break:keep-all;white-space:nowrap;text-overflow:ellipsis;" href="${ctx}/IllnessInfo/diseaseInfo?id=${illness.id}" title="${illness.illName}">${illness.illName}</a></li>
											</c:forEach>	
										</ul>
			
			
			
										</div>
			
								</div>
								<div class="clear"></div>
								<a class="org animate-element scale" href="${ctx}/IllnessInfo/reqIllness?qeuryName=&partName=&childName=">
									查看所有内容
								</a>
			
			
			
			
			
						</div>
							<div class="i5 navbar"  id='yz'> 
							</br>
										<div class="block_name index"> 
											<div class="index">
												<span class="animate-element left_to_right">FREE CONSULTATION</span>
												<p class="animate-element right_to_left">义诊咨询</p>
												<div class="brd"></div>
											</div>	
										</div>
										<div class="center">
												<h2>今日义诊医生</h2>
												<ul>
												  <c:forEach items="${yizhenDoctorList}" var="yizhenDoctor">
												  <c:set var="doctorType" value="${fnf:getDoctorTypeByid(yizhenDoctor.doctortype)}"/>
												  <c:set var="hospital" value="${fnf:getHospitalByintId(yizhenDoctor.hospitalId)}"/>
														<li class="">
																	 <c:set var="url" value="${yizhenDoctor.photourl}" />  
																
															<div class="userpic animate-element scale" style="background:url(${fnf:imageScaleUrl(url,'180','180','doctorpc')}) center no-repeat;"> 
																<a href="./doctor/${yizhenDoctor.doctorId}${urlSuffix}">
																<p class="opacity"><span>
																	擅长:${yizhenDoctor.specialty}
																</span></p>
																</a>
															</div>
				
															<div class="fonts animate-element bottom_to_top">
																<p class="p1" align="center">${yizhenDoctor.name} <span>${doctorType.doctorTypeName}</span></p>
																<p class="p2" align="center">${hospital.name}</p>
															</div>
														</li>
												</c:forEach>
												</ul>
												</br>
												<h2>免费咨询</h2>
												<div class="zx"> 
														<a href=""><img src="${ctxStaticFront}/images/mfzx.jpg"></a>
				
				
				
												</div>	
				
												<a href="./doctor/moreDoctor" class="org animate-element scale" style="margin:100px auto ">查看所有义诊医生</a>
				
				
										</div>	
				
				
				
				
				
							</div>
							<div class="i6 navbar"  id='yd'>
								<div class="center">
								</br>
										<div class="block_name index"> 
											<div class="index">
												<span class="animate-element left_to_right"> HEALTH INFORMATION</span>
												<p class="animate-element right_to_left">健康资讯</p>
												<div class="brd"></div>
											</div>	
										</div>
										<ul> 
										<c:forEach items="${newDetailHotList}" var="newsdetail">
										<li class="animate-element left_to_right">
				                         <a href="./news/${newsdetail.newsdetailid}${urlSuffix}">
										<div class="l"> 
											<c:if test="${not empty newsdetail.newsdetailspicture }">
												<img height="160"  widht="190px" src="${newsdetail.newsdetailspicture}">
											</c:if>	
											<c:if test="${empty newsdetail.newsdetailspicture }">
												<img height="160"  widht="190px" src="${ctxStaticFront}/images/zixunimg.jpg">
											</c:if>	
										</div>
										<div class="r"> 
										<p>${newsdetail.newsdetailtitle}</p>
										<span>${newsdetail.newsdetailabstract}</span>
										</div>
										 </a>
										</li>
										</c:forEach>
										</ul>
										<div class="clear"></div>
										<a href="${ctx}/news/index.html" class="org animate-element scale">查看所有内容</a>
								</div>
							</div>
		
						<div class="i8 navbar" id='fx'> 
						<div class="center">
								<div class="block_name "> 
									<span class="animate-element left_to_right">DRUG INQUIRY</span>
									<p class="animate-element right_to_left">药品查询</p>
							
									<div class="brd"></div>
								</div>
								<form class="cxform" action="${ctx}/indexsearch">
										<p>
										  <select name="selectstyle">
										    <option value="1">药品查询</option>
										<!--     <option value="2">新农合查询</option> -->
										  </select>
										<input type="text" name="searchcontent" placeholder="请输入查询关键字" class="cx">
										
										
										<input type="submit" value="查询" class="tj">
										</p>
										<span>温馨提示：您可以进行药品查询！<b style="color:red;">(请在医生指导下使用)</b></span>


	

								</form>



							</div>
							</div>
					</div>
		
<script type="text/javascript">
var parname="";

$(".butn li").each(function(i){ 

	if($(".butn").hasClass("add1")){ 
		var a=i+2;
		var s=i;
	}else{ 
		var a=i+1;
		
	}
	var urlpa="${ctxStaticFront}";
	var that=$(".butn li:eq("+i+") ");
	that.find("img").attr("src",urlpa+"/images/i2_l"+a+".png")

	that.hover(function(){ 
		that.find("img").attr("src",urlpa+"/images/i2_l"+a+"h.png")


	},function(){ 
		that.find("img").attr("src",urlpa+"/images/i2_l"+a+".png")
	})

})



$(function(){

//首先将#back-to-top隐藏
	$("#back-to-top").hide();
	//当滚动条的位置处于距顶部100像素以下时，跳转链接出现，否则消失
	$(function () {
		$(window).scroll(function(){
		if ($(window).scrollTop()>100){
		$("#back-to-top").fadeIn(1500);
		}
		else
		{
		$("#back-to-top").fadeOut(1500);
		}
		});
		//当点击跳转链接后，回到页面顶部位置
		$("#back-to-top").click(function(){
		$('body,html').animate({scrollTop:0},1000);
		return false;
		});
		});



var json='<%=request.getAttribute("part")%>';
	$.each(eval("("+json+")"), function (i, n) {
	       if(n.name == "胸部"){
	       	$("#buwei1").attr("href","${ctx}/IllnessInfo/reqIllness?partName="+n.id);
	       }
	       if(n.name == "头部"){
	       	$("#buwei2").attr("href","${ctx}/IllnessInfo/reqIllness?partName="+n.id);
	       }
	       if(n.name == "上肢"){
	       	$("#buwei4").attr("href","${ctx}/IllnessInfo/reqIllness?partName="+n.id);
	       }
	       if(n.name == "腰部"){
	       	$("#buwei3").attr("href","${ctx}/IllnessInfo/reqIllness?partName="+n.id);
	       }
	       if(n.name == "生殖"){
	       	$("#buwei6").attr("href","${ctx}/IllnessInfo/reqIllness?sex=1&partName="+n.id);
	       	parname=n.id;
	       }
	       if(n.name == "腹部"){
	       	$("#buwei5").attr("href","${ctx}/IllnessInfo/reqIllness?partName="+n.id);
	       }
	       if(n.name == "下肢"){
	       	$("#buwei7").attr("href","${ctx}/IllnessInfo/reqIllness?partName="+n.id);
	       }
	       if(n.name == "背部"){
	       	$("#buwei8").attr("href","${ctx}/IllnessInfo/reqIllness?partName="+n.id);
	       }
	       if(n.name == "排泄部"){
	       	$("#buwei10").attr("href","${ctx}/IllnessInfo/reqIllness?partName="+n.id);
	       }
	       if(n.name == "四部"){
	       	$("#buwei9").attr("href","${ctx}/IllnessInfo/reqIllness?partName="+n.id);
	       }
	       
	       
	});
	
$(".fullSlide .bd li:first .SlideBar").addClass("oldli");//初始化
$(".fullSlide .bd li .SlideBar").addClass("off");
jQuery(".fullSlide").slide({
    interTime:5000,
    titCell: ".hd ul",
    mainCell: ".bd ul",
    effect: "fold",
    autoPlay: true,
    autoPage: true,
    trigger: "click",
    mouseOverStop:false,
    delayTime:1000,
    startFun: function(i) {
    	 
    	
    	 	var curLi = jQuery(".fullSlide .bd li").eq(i);
		        if ( !! curLi.attr("_src")) {
		            curLi.css("background-image", curLi.attr("_src")).removeAttr("_src");
		        }
		       
    			

		 		$(".oldli").addClass("off").removeClass("oldli")
		    	
		   		setTimeout(function(){ 
		   			
		   				curLi.find(".SlideBar").removeClass("off").addClass("star");
		   			
		   			setTimeout(function(){ 
		   				curLi.find(".SlideBar").removeClass("star").addClass("oldli");
		  			},200)

		   		},600)
		   		
	
    		   

    	
       
      
    }

    
});
	
	
	
}); 


$('.nav a').click(function(){
    $('html, body').animate({
        scrollTop: $( $.attr(this, 'href') ).offset().top
    }, 500);
    return false;
});


$(".guahao").on("click",function(){ 
		 layer.open({
       			type: 2,
	            title: '预约挂号',
	            shadeClose: true,
	            maxmin: true, //开启最大化最小化按钮
	            area: ['650px', '600px'],
	            content: '${ctx}/Reservation/reservation',
	            success: function(layero, index){
    		}
    		
 	});
})
var oldi;
var prevTop = 0,
    currTop = 0;
$(window).bind("scroll",function(){ 
		$(".navbar").each(function(a){ 
			var that=$(".navbar:eq("+a+")")
			var top = $(".navbar:eq("+a+")").offset().top; 
			if(top < $(window).height()+$(window).scrollTop() && top+$(this).outerHeight() > $(window).scrollTop()){
					if(oldi){ 
					
							var Th= $(window).height()+$(window).scrollTop()-top
							var Oh=$(window).height()+$(window).scrollTop()-oldi.offset().top
							currTop = $(window).scrollTop();
							    
							    if (currTop < prevTop) { //判断小于则为向上滚动

							       	if(Oh<= 90){ 
									$(".nav a[href*=#"+oldi.attr("id")+"]").removeClass("on")
									$(".nav a[href*=#"+that.attr("id")+"]").addClass("on")
									oldi=that;
									}
							    } else {
							      if(Th > $(window).height() * 0.7){ 
										$(".nav a[href*=#"+oldi.attr("id")+"]").removeClass("on")
										$(".nav a[href*=#"+that.attr("id")+"]").addClass("on")
										oldi=that;
									}
							    }
							    prevTop = currTop
					}else{ 
						$(".nav a[href*=#"+that.attr("id")+"]").addClass("on")
						oldi=that;
					}
			}
		})
})
var is=1;
var Fanm = function(a){ 
		$(".BoxS a").removeClass("on")
		a.addClass("on")
		var zm = a.attr("zmrel")
		var bm = a.attr("bmrel")
		$("#box img[alt='正面']").attr("src",zm)
		$("#box img[alt='背面']").attr("src",bm)
}
$(".BoxS a").on("click",function(){ 
			if(is==1){
				is=2;
			}else{
				is=1;
			}
			$("#buwei6").attr("href","${ctx}/IllnessInfo/reqIllness?partName="+parname+"&sex="+is);
			Fanm($(this));	
		



})

</script>
<script>
 /* 调试placeholder属性兼容性 */
 if( !('placeholder' in document.createElement('input')) ){  
   
    $('input[placeholder],textarea[placeholder]').each(function(){   
      var that = $(this),   
      text= that.attr('placeholder');   
      if(that.val()===""){   
        that.val(text).addClass('placeholder');   
      }   
      that.focus(function(){   
        if(that.val()===text){   
          that.val("").removeClass('placeholder');   
        }   
      })   
      .blur(function(){   
        if(that.val()===""){   
          that.val(text).addClass('placeholder');   
        }   
      })   
      .closest('form').submit(function(){   
        if(that.val() === text){   
          that.val('');   
        }   
      });   
    });   
  } 
</script>

</body>
</html>
