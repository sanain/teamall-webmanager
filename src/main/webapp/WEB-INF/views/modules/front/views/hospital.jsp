<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/front/include/taglib.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
	<meta name="decorator" content="fronthospital"/>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title></title>
	<meta name="keywords" content="" />
	<meta name="description" content="" />
	<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=32szE2ZbYkoX6g1kvtTCqfkz"></script>
	<script type="text/javascript" src="${ctxStaticFront}/js/jquery.slider.js"></script>
	<style type="text/css">
		#bedinfos li{width: 100%;min-height: 100px;margin-bottom: 30px;}
		#bedinfos li h2{float: left;background: #fe824c;color: #fff;font-size: 32px;font-family: "Arial";font-weight: normal;padding:0 5px; }
		#bedinfos li .title{width: 100%;overflow: hidden;}
		#bedinfos li a{margin-top: 20px;display: inline-block;margin-right: 30px;padding: 5px 20px;background: #ebf1fc;color: #404d5e;font-size: 18px;border: 1px solid #bbc6dd}
	</style>
</head>
<body >	
<style>

.me_qh {
    border: 1px solid #BBC6DD;
    width: 640px;
    height: 0px;
    background: #FFF none repeat scroll -1% 3%;
    margin: 0px auto;
}

</style>

		<div id="content"> 
			<div class="jieshao">
			<!-- 
					<div class="notice">
						<div class="center">
							<div class="l">
								<img src="images/laba.png">
							</div>
							<div class="r">
								<p>站内公告站内公告站内公告站内公告站内公告站内公告站内公告站内公告站内公告</p>
							</div>
						</div>
-->
			</div>
			<div class="smalt">
				<div class="center">
					<div class="l">
					   <c:set var="url" value="${hospital.photourl}" />  
<!--                        <img   src="${fnf:imageScaleUrl(url,'789','343','hospitalpc')}"> -->
						 <img  width="789px;" height="343px;" src="${hospital.photourl}"> 
					   <%--  <c:if test="${empty hospital.photourl}">
						<img src="${ctxStaticFront}/images/hoshomes.jpg">
						</c:if>
					    <c:if test="${not empty hospital.photourl}">
						<img src="${hospital.photourl}">
						</c:if> --%>
						
					</div>
					<div class="r">
							<div class="l">
								<p>医院等级：</p>
								<p>医院类别：</p>
								<p>地区：</p>
								<p>详细地址：</p>
								<p>电话：</p>
								<p>医院官网：</p>
								<p>统计数据：</p>
							</div>
							<div class="r">
								<c:if test="${empty hospitalLevel.hospitalLevelName}">
									<p>暂无</p>
								</c:if>
								<c:if test="${not empty hospitalLevel.hospitalLevelName}">
									<p>${hospitalLevel.hospitalLevelName}</p>
								</c:if>
								<input type="hidden" id="typeall" value="${latitudeType}"/>
								
								
								<c:if test="${empty latitudeTypeOfcut}">
									<p>暂无</p>
								</c:if>
								<c:if test="${not empty latitudeTypeOfcut}">
									<p class="typecut">${latitudeTypeOfcut}&nbsp;</p>
								</c:if>
								
								<c:if test="${empty cityinfo.city}">
									<p>暂无</p>
								</c:if>
								<c:if test="${not empty cityinfo.city}">
									<p >${cityinfo.city}</p>
								</c:if>
								<input type="hidden" id="address" value="${hospital.address}"/>
								
								
								<c:if test="${empty hospitaladdress}">
									<p>暂无</p>
								</c:if>
								<c:if test="${not empty hospitaladdress}">
									<p class="addressa">${hospitaladdress}&nbsp;</p> 
								</c:if>
								
									<c:if test="${empty hospitalphone}">
									<p>暂无</p>
								</c:if>
								<c:if test="${not empty hospitalphone}">
									<p class="hospitalphone">${hospitalphone}</p>
								</c:if>	

								<input type="hidden" id="hospitalphonea" value="${hospital.phone}"/>
							
								<c:if test="${!empty hospital.officialurl}">
								 <p class="hospitalofficialurl"> 	<a target="_blank" href="${hospital.officialurl}"> ${hospital.officialurl} </a></p>
								
								  <input type="hidden" id="hospitalofficialurla" value="${hospital.officialurl}"/>
								</c:if>	
								<c:if test="${empty hospital.officialurl}">
								<p>&nbsp;</p></c:if>	
								<p class="gh">已挂号<span>${hospital.hosregnum}</span>人</p>
								<p class="zx">已咨询<span>${hospital.hosconsultnum}</span>人</p>
								<c:if test="${not empty indexs and indexs =='women'}">
								<%-- <p class="gh">共<span>${hospital.totalbeds}</span>床位，余<span>${hospital.leavebeds}</span>床位</p> --%>
								</c:if>

							</div>
					</div>
				</div>
			</div>
			<div class="tuijian">
					<div class="Fontsbar">
						<p>推荐医生</p>
						<span>Recommended Physician</span>
					</div>
					<div class="center">
							<div class="slider-box">
					    		<a href='javascript:;' class="slider-next slider-btn">向上</a>
					    	    <div class="slider-wrapper">
					    	    	    <ul class='slider-move'>
					    	    	    	  <c:forEach items="${doctorlist}" var="doc">
                  									      <li><a href="${ctx}/doctor/${doc.doctorId}.html" title="" class="">
                  									      
                  									      <c:if test="${empty doc.photourl}">
                  									            <div style="border-radius: 50%;background: #FE824C none repeat scroll 0% 0%;border: 1px solid #FE824C;text-align: center;width: 130px;height: 130px;position: relative;display: inline-block;behavior: url(../static/front/js/PIE.htc);">
                                                                <p  style="margin-top: 40px;font-size: 18px;color: #FFF;font-weight: bold;width: 100%;">${doc.name}</p>
                                                                <span style=" color: #FFF;font-size: 14px;}* {padding: 0px;margin: 0px;list-style-type: none;text-decoration: none;font-family: "5FAE8F6F96C5ED1","Microsoft Yahei";">
                                                                ${doc.department.name}</span></div></a></li>
                   									     <%--  <c:set var="url" value="${doc.photourl}" />  
                                                           <img  src="${fnf:imageScaleUrl(url,'200','200','doctorpc')}">
                  									      <div class="hidden opacity"><p>${doc.name}</p>
                  									      <span>${doc.department.name}</span></div></a> --%>
                  									      </c:if>
                  									      
                  									      <c:if test="${not empty doc.photourl}">
                   									      <c:set var="url" value="${doc.photourl}" />  
                                                           <img  src="${fnf:imageScaleUrl(url,'200','200','doctorpc')}">
                  									      <div class="hidden opacity"><p>${doc.name}</p>
                  									      <span>${doc.department.name}</span></div></a>
                  									      </c:if>
                  									      
                  									      
                  									      </li>
					    	    	         </c:forEach>
					    	    	    </ul>
					    	    </div>
					    		<a href='javascript:;' class="slider-prev slider-btn">向下</a>
					   		 </div>
					</div>
			</div>
		</div>
		<div class="yynav">
			<div class="center">
				<ul>
						<!-- <li class="on"><a href=""><img src=""><p>科室列表</p><span>Department</span></a></li>
						<li><a href=""><img src=""><p>医院简介</p><span>Introduction</span></a></li>
						<li><a href=""><img src=""><p>地理位置</p><span>Location</span></a></li>
						<li><a href=""><img src=""><p>就医指南</p><span>Guideline</span></a></li>
						<li><a href=""><img src=""><p>院内导航</p><span>Navigation</span></a></li>
						<li><a href=""><img src=""><p>床位信息</p><span>Bedinfo</span></a></li>  -->
						<li class="on"><a href=""><img src=""><p>科室列表</p><span>Department</span></a></li>
						<li><a href=""><img src=""><p>床位信息</p><span>Bedinfo</span></a></li> 
						<li><a href=""><img src=""><p>就医指南</p><span>Guideline</span></a></li>
						<li><a href=""><img src=""><p>地理位置</p><span>Location</span></a></li>
						<li><a href=""><img src=""><p>院内导航</p><span>Navigation</span></a></li>
						<li><a href=""><img src=""><p>医院简介</p><span>Introduction</span></a></li>
						
						<!-- <li><a href=""><img src=""><p>用户评价</p><span>Hospital profile</span></a></li> -->
				</ul>
			</div>
		</div>
		<div class="center" id="yys">
			<!-- 科室列表 -->
			<div class="yysel" style="display:block">
				<ul id="zndz"></ul>
			</div>
			
			<!-- 床位信息 -->
			<div class="yysel" style="display:none">
				<ul id="bedinfos"></ul>
			</div>
			
			<!-- 就医指南 -->
			<div class="yysel">
				<div class="yyzl">
					<div class="l">
						<a href="javascript:void()" class="on">预约规则</a>
						<a href="javascript:void()" >退号规则</a>
						<a href="javascript:void()" >医保指南</a>
						<a href="javascript:void()" >就诊指南</a>
					</div>
					<div class="r">
						<div class="yenri" align="left" style="padding-left: 8px;" escape="false" >
							<c:set var="bool" value="false" />
							<c:forEach items="${hospitalDynamic}" var="hd">
								<c:if test="${hd.dynamictype==4}">
									<div id="yuyue" class="subzhinan">
										<h2 class="ct" >${hd.dynamictitle}</h2>
										<p>${hd.dynamiccontent}</p>
										<p>${hd.dynamicdesc}</p>
									</div>
									<c:set var="bool" value="true" />
								</c:if>
								<c:if test="${hd.dynamictype==5}">
									<div id="tuihao" class="subzhinan" style="display:${bool?'none':'block' }">
										<h2 class="ct" >${hd.dynamictitle}</h2>
										<p>${hd.dynamiccontent}</p>
										<p>${hd.dynamicdesc}</p>
									</div>
									<c:set var="bool" value="true" />
								</c:if>
								<c:if test="${hd.dynamictype==6}">
									<div id="yibao" class="subzhinan" style="display:${bool?'none':'block' }">
										<h2 class="ct" >${hd.dynamictitle}</h2>
										<p>${hd.dynamiccontent}</p>
										<p>${hd.dynamicdesc}</p>
									</div>
									<c:set var="bool" value="true" />
								</c:if>
								<c:if test="${hd.dynamictype==7}">
									<div id="jiuzhen" class="subzhinan" style="display:${bool?'none':'block' }">
										<h2 class="ct" >${hd.dynamictitle}</h2>
										<p>${hd.dynamiccontent}</p>
										<p>${hd.dynamicdesc}</p>
									</div>
									<c:set var="bool" value="true" />
								</c:if>
							</c:forEach>
							<c:if test="${!bool }"><div class="subzhinan">暂无信息</div></c:if>
							<div style="display: none" class="subzhinan">暂无信息</div>
							<div style="display: none" class="subzhinan">暂无信息</div>
							<div style="display: none" class="subzhinan">暂无信息</div>
						</div>
					</div>
				</div>
			</div>
			
			<!-- 地理位置 -->
			<div class="yysel">
					 <div style="width:1138px;height:550px;border:#ccc solid 1px;font-size:12px" id="map"></div>
			</div>
			
			<!-- 院内导航 -->
			<div class="yysel">
				<div class="me_qh" style="height: auto;">
					<div class="title">
						<p class="p1">科室名称</p>	
						<p class="p2">科室位置</p>
					</div>
					<ul class="on" id="ondep">
						<c:forEach items="${department}" var="dep">
						    <li><p class="p1">${dep.name}</p>
						    <p class="p2">${dep.departaddr}</p></li>
						</c:forEach>
					</ul>
				</div>
			</div>
			
			<!-- 医院简介 -->
			<div class="yysel">
				<div class="fontsbar">
				<!--  
					<h2 class="tbar">医院沿革 <span>Hospital evolution</span></h2>
					$ {hospital.hdescribe}
					 -->
					<h2 class="tbar">医院简介 <span>Hospital Introduction</span></h2>
					<p>  <c:set var="hosdesc" value="${fns:abbr(hospital.brief,4000)}"/> ${hosdesc}</p>
                                                            
				</div>
			</div>
			
			
			
			
			
			
			
			
			
			<!-- 就诊疗效 -->
			<div class="yysel">
				<div class="yspj"> 
					<ul>
						<li> <span>就诊疗效</span> 
							<div class="Muxin">
								<img src="${ctxStaticFront}/images/Mqx.png">
								<img src="${ctxStaticFront}/images/Mqx.png">
								<img src="${ctxStaticFront}/images/Mqx.png">
								<img src="${ctxStaticFront}/images/Mbx.png">
								<img src="${ctxStaticFront}/images/Mmx.png">
							</div>
						</li>
						<li> <span>就诊疗效</span> 
							<div class="Muxin">
								<img src="${ctxStaticFront}/images/Mqx.png">
								<img src="${ctxStaticFront}/images/Mqx.png">
								<img src="${ctxStaticFront}/images/Mqx.png">
								<img src="${ctxStaticFront}/images/Mbx.png">
								<img src="${ctxStaticFront}/images/Mmx.png">
							</div>
						</li>
						<li> <span>就诊疗效</span> 
							<div class="Muxin">
								<img src="${ctxStaticFront}/images/Mqx.png">
								<img src="${ctxStaticFront}/images/Mqx.png">
								<img src="${ctxStaticFront}/images/Mqx.png">
								<img src="${ctxStaticFront}/images/Mbx.png">
								<img src="${ctxStaticFront}/images/Mmx.png">
							</div>
						</li>
					</ul>
			</div>
			<div class="ys5"> 
			<div class="center">
				<ul>
				<c:forEach items="${reviewList}" var="review">
					<li>
						<div class="l">
							<img src="${ctxStaticFront}/${review.userurl}">
							<p>${review.username}</p>
						</div>
						<div class="r">
							<p>${review.reviewtime}</p>
							<span>${review.reviewcontent}</span>
						</div>
					</li>
				</c:forEach>	
				</ul>
			</div>
			</div>	
		</div>
		<hidden id="dafs" value="${urls}" />
	</div>
<script>
	/* 医院类别弹出框 */
$(".typecut").on("mouseenter", function () {
	var tyl =$("#typeall").attr("value");
	if(tyl.length>15){
		layer.tips(tyl, '.typecut', {
        tips: 3
      });
     }
    });
  /* 医院地址弹出框 */
  $(".addressa").on("mouseenter", function () {
	var tyas =$("#address").attr("value");
	if(tyas.length>15){
		layer.tips(tyas, '.addressa', {
        tips: 3
      });
     }
    });
    
    
      /*医院电话弹出框 */
    $(".hospitalphone").on("mouseenter", function () {
	var tye =$("#hospitalphonea").attr("value");
	if(tye.length>15){
		layer.tips(tye, '.hospitalphone', {
        tips: 3
      });
     }
    });	
    
	/*医院官网地址弹出框 */
	 $(".hospitalofficialurl").on("mouseenter", function () {
	var tyl =$("#hospitalofficialurla").attr("value");
	if(tyl.length>20){
		layer.tips(tyl, '.hospitalofficialurl', {
        tips: 3
      });
     }
    });	
	
	</script>
	<script>
		$(function(){
			$('.slider-box').mySlider({  //参数可选,以下为默认参数
					speed: 300,
					direction: 'left', //  运动方向 可选 left,top
					prevClass: 'slider-prev',
					nextClass: 'slider-next',
					prevClass: 'slider-prev',
					wrapperClass: 'slider-wrapper',
					moveClass: 'slider-move',
					
			});
		});
	</script>
	<script type="text/javascript">
	
	 var urlst = '<%=request.getAttribute("urlsstasd")%>';
	 var deptId = '<%=request.getAttribute("hospitalId")%>';
	 var dizhi = urlst+"/hospital/department/"+deptId+".html?hosId="+deptId+"&depId=";
	function pySegSort(arr,empty) {
		if(!String.prototype.localeCompare)
		return null;
		
		var letters ="*ABCDEFGHJKLMNOPQRSTWXYZ".split('');
		var zh ="啊把差大额发噶哈激卡啦吗那哦爬起然啥他哇西牙咋".split('');
		
		var segs = [];
		var curr;
		$.each(letters, function(i){
		curr = {letter: this, data:[]};
		$.each(arr, function() {
		if((!zh[i-1] || zh[i-1].localeCompare(this) <= 0) && this.localeCompare(zh[i]) == -1) {
		curr.data.push(this);
		}		
		});
		if(empty || curr.data.length) {
		segs.push(curr);
		curr.data.sort(function(a,b){
		return a.localeCompare(b);
		});
		}
		});
		return segs;
	}
       
        var depname=${departmentName};
		var jso =pySegSort(depname);
		var numSource = ${depNumSource};
		var q=jso.length; 
		var jsoNumberSource = numSource.length;
		for(var i=0;i<q;i++){ 
				var w = jso[i].data.length
				$("#zndz").append("<li class='Zn lt"+jso[i].letter+"'><div class='title'><h2>"+jso[i].letter+"</h2></div></li>")
			for(var e=0;e<w;e++){
				for(var t=0;t<numSource.length;t++){	
						if(jso[i].data[e] == numSource[t].name){
						$("#zndz .lt"+jso[i].letter+"").append("<a href="+dizhi+""+numSource[t].departmentId+" >"+jso[i].data[e]+"(号源余数<span style='color:red'>"+numSource[t].depNumSourceCount+"</span>)</a>");
					}
				}
			}
		}
		debugger;
  		var bedinfo = ${newbedinfoDepText};
  		var jsos =pySegSort(bedinfo); 
		var jsobedinfo = jsos.length; 
		var newsbedinfo = ${newAllBedinfo};
		for(var i=0;i<jsobedinfo;i++){ 
			var w = jsos[i].data.length;
			$("#bedinfos").append("<li class='Zn lt"+jsos[i].letter+"'><div class='title'><h2>"+jsos[i].letter+"</h2></div></li>")
			for(var e=0;e<w;e++){
				for(var t=0;t<newsbedinfo.length;t++){	
						if(jsos[i].data[e] == newsbedinfo[t].name){
							$("#bedinfos .lt"+jsos[i].letter+"").append("<a  onclick='return false;' >"+jsos[i].data[e]+"(总床位<span style='color:red'>"+newsbedinfo[t].totalbeds+"</span>,余数<span style='color:red'>"+newsbedinfo[t].leavebeds+"</span>)</a>");
						}
				}
			}
		} 
  
   		



</script>
<script type="text/javascript">

	function mudy(a){ 
		var i = a.index()+1;
		if(a.hasClass("on")){ 
			a.find("img").attr("src","${ctxStaticFront}/images/yyico"+i+"h.png");
		}else{ 
			a.find("img").attr("src","${ctxStaticFront}/images/yyico"+i+".png");
		}
	}// 封装,方便调用
	var oldt = $(".yysel:first"); // 初始化
	$("#yys").css("height",oldt.height()+50); // 初始化
	$(".yynav li").each(function(a){ 
		var i = a+1;
		var that = $(".yynav li:eq("+a+")");
		var thats = $(".yysel:eq("+a+")");
		mudy(that);
		that.hover(function(){ 
			that.find("img").attr("src","${ctxStaticFront}/images/yyico"+i+"h.png");
		},function(){ 
				if(!that.hasClass("on")){ 	
					that.find("img").attr("src","${ctxStaticFront}/images/yyico"+i+".png");
				}
		})
		that.click(function(){ 
			if(oldt != thats){ 
					mudy($(".yynav li.on").removeClass("on"));
					that.addClass("on");
					mudy(that);
					oldt.fadeOut();
					thats.fadeIn();
					$("#yys").animate({ 
						"height":thats.height()+50
					});
					if(a=1){ 
							Mumap();
					}
					oldt=thats;
			}
		});
	});//切换,特效

    //创建和初始化地图函数：
	var x = '<%=request.getAttribute("longitude")%>';//经度
    var y = '<%=request.getAttribute("latitude")%>';//纬度
    var names = '<%=request.getAttribute("hospitalName")%>';
	function Mumap(){ 
				  	// 百度地图API功能
				var map = new BMap.Map("map");
				var point = new BMap.Point(x,y);
				map.centerAndZoom(point, 20);
				var marker = new BMap.Marker(point);  // 创建标注
				map.addOverlay(marker);              // 将标注添加到地图中
				var label = new BMap.Label(names,{offset:new BMap.Size(20,-10)});
				marker.setLabel(label);
				map.enableScrollWheelZoom(true);
	}
</script>
<script type="text/javascript">
	var oldzhinanbutton = $(".yysel .yyzl .l a:eq(0)");
	var oldzhinan = $("#yuyue");
	$(function(){
		$(".yysel .yyzl .l a").click(function(){
			var targObjbutton = $(".yysel .yyzl .l a:eq("+$(this).index()+")");
			if(oldzhinanbutton != targObjbutton) {
				oldzhinanbutton.removeClass("on");
				targObjbutton.addClass("on");
				oldzhinanbutton = targObjbutton;
				
				$(".yenri .subzhinan").css("display","none");
				oldzhinan.fadeOut();
				var targObj = $(".yenri .subzhinan:eq("+$(this).index()+")");
				targObj.css("display","block");
				targObj.fadeIn();
				oldzhinan = targObj;
			}
		});
	});
</script>
<script type="text/javascript">
	$(function(){
		if(!"${hospital.photourl}"==""){
			$(".p2>img").attr("src","${hospital.photourl}");
		}
	});
</script>
</body>
</html>
