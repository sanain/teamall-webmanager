<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/front/include/taglib.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
		<meta name="decorator" content="frontdefault"/>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title></title>
	<meta name="keywords" content="" />
	<meta name="description" content="" />
	<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=32szE2ZbYkoX6g1kvtTCqfkz"></script>
</head>
<body >	
			<div id="content"> 
			
				<div class="newsnav"> 
								<div class="center">
										<a href="${ctx}/">首页    >  </a> <a href="${ctx}/medical/medicalinfo">查找医院</a>
								</div>
								

						</div>
					
				
							<div class="block_name mt"> 
								
								<span class="">SELECT HOSPITAL</span>
								<p class="">查找医院</p>
								<div class="brd"></div>
							</div>

							<div class="bar">
								<ul>
										<li><a href="" class="opacity on">地图筛选</a></li>
										<li><a href="${ctx }/medical/medicalinfo" class="opacity">条件筛选</a></li>
										

							
								</ul>
							</div>

							<div class="yiy">
									<div class="center">
										<div id="Map" style="width:100%;height:800px;margin-top:60px"></div>
									</div>



							</div>



				




		</div>
	

<script type="text/javascript">
var data_info;
var map = null;
var cityName= null;
var pointsABC = new Array();
var poininfo = new Array();
var zuobiao=0;
var data_info=null;
$(function(){

	map = new BMap.Map("Map");
	var point = new BMap.Point(116.331398,39.897445);
	map.centerAndZoom(point,14);
	map.enableScrollWheelZoom(); 
	var geolocation = new BMap.Geolocation();
	geolocation.getCurrentPosition(function(r){
		if(this.getStatus() == BMAP_STATUS_SUCCESS){
			var mk = new BMap.Marker(r.point);
			map.addOverlay(mk);
			map.panTo(r.point);
		}
		else {
			alert('failed'+this.getStatus());
		}        
	},{enableHighAccuracy: true})
	
	function myFun(result){
		 cityName = result.name;
	     map.setCenter(cityName);
	//	alert("当前定位城市:"+cityName);
		$.post("${ctx}/medical/queryHospitalCoordinates",{cityName:cityName},function(result){
					var opts = {
							width : 250,     // 信息窗口宽度
							height: 100,     // 信息窗口高度
							enableMessage:true//设置允许信息窗发送短息
						   };
							// 百度地图API功能	
					 data_info =result;
					var points = new Array();
					for(var i=0;i<data_info.length;i++){
					  		  	// 百度地图API功能
							var point = new BMap.Point(data_info[i][1],data_info[i][2]);
							var marker = new BMap.Marker(point);  //创建标注
							map.addOverlay(marker);              //将标注添加到地图中
							var label = new BMap.Label(data_info[i][4],{offset:new BMap.Size(20,-10)});
							marker.setLabel(label);
							var content ="<a href='${ctx}/hospital/"+data_info[i][0]+".html'><sapn style='color:blue'>点击查看医院详情</span> </a><br/>"+data_info[i][4]+"<br/>地址："+data_info[i][3];
							addClickHandler(content,marker);
						}
						function addClickHandler(content,marker){
							marker.addEventListener("click",function(e){
								openInfo(content,e)}
							);
						}
						function openInfo(content,e){
							var p = e.target;
							var point = new BMap.Point(p.getPosition().lng, p.getPosition().lat);
							var infoWindow = new BMap.InfoWindow(content,opts);  // 创建信息窗口对象 
							map.openInfoWindow(infoWindow,point); //开启信息窗口
						}
    					
    					
    
			 		 });										 
	}
	
	var myCity = new BMap.LocalCity();
	myCity.get(myFun);

	map.addEventListener("dragend",function(e){
				if(zuobiao == 0){
				 layer.alert("开启获取当前位置1000米范围内的医院"); 
					zuobiao=1;
				}
				map.clearOverlays();  
				var optsts = {
							width : 250,     // 信息窗口宽度
							height: 100,     // 信息窗口高度
							enableMessage:true//设置允许信息窗发送短息
						   };
			   var eventPoint = new BMap.Point(e.point.lng,e.point.lat);//获取当前鼠标点击位置
			   var marker = new BMap.Marker(eventPoint);  // 标注当前鼠标点击的位置
			   var labels = new BMap.Label("我的位置",{offset:new BMap.Size(20,-10)});
			   marker.setLabel(labels);
			   map.addOverlay(marker);               // 将标注添加到地图中
			   var circle = new BMap.Circle(eventPoint,1000,{strokeColor:"blue", strokeWeight:2, strokeOpacity:0.5}); //创建圆
			   map.addOverlay(circle);            //增加圆
			   marker.setAnimation(BMAP_ANIMATION_BOUNCE); //跳动的动画
			 for(var i=0;i<data_info.length;i++){
					  		  	// 百度地图API功能
							var point = new BMap.Point(data_info[i][1],data_info[i][2]);
							
							if(map.getDistance(eventPoint,point).toFixed(2) < 1000 )//判断当前所有医院满足条件的显示
							{	
								var marker = new BMap.Marker(point);  //创建标注
								map.addOverlay(marker);              //将标注添加到地图中
								var label = new BMap.Label(data_info[i][4],{offset:new BMap.Size(20,-10)});
								marker.setLabel(label);
								var content ="<a href='${ctx}/hospital/"+data_info[i][0]+".html'><sapn style='color:blue'>点击查看医院详情</span> </a><br/>"+data_info[i][4]+"<br/>地址："+data_info[i][3];
								addClickHandlers(content,marker);
							}	
						}
						function addClickHandlers(content,marker){
							marker.addEventListener("click",function(e){
							
								openInfo(content,e)
								}
							);
						}
						function openInfo(content,e){
							var p = e.target;
							var point = new BMap.Point(p.getPosition().lng, p.getPosition().lat);
							var infoWindow = new BMap.InfoWindow(content,optsts);  // 创建信息窗口对象 
							map.openInfoWindow(infoWindow,point); //开启信息窗口
						}
}); 
		
		
		


var size = new BMap.Size(10, 20);
map.addControl(new BMap.CityListControl({
    anchor: BMAP_ANCHOR_TOP_LEFT,
    offset: size,
    // 切换城市之间事件
    // onChangeBefore: function(){
    //    alert('before');
    // },
    // 切换城市之后事件
   onChangeAfter:function(){
		   $.post("${ctx}/medical/queryHospitalCoordinates",{cityName:cityName},function(result){
							var opts = {
									width : 250,     // 信息窗口宽度
									height: 100,     // 信息窗口高度
									enableMessage:true//设置允许信息窗发送短息
								   };
									// 百度地图API功能	
							 data_info =result;
							var points = new Array();
							for(var i=0;i<data_info.length;i++){
							  		  	// 百度地图API功能
									var point = new BMap.Point(data_info[i][1],data_info[i][2]);
									var marker = new BMap.Marker(point);  //创建标注
									map.addOverlay(marker);              //将标注添加到地图中
									var label = new BMap.Label(data_info[i][4],{offset:new BMap.Size(20,-10)});
									marker.setLabel(label);
									var content ="<a href='${ctx}/hospital/"+data_info[i][0]+".html'><sapn style='color:blue'>点击查看医院详情</span> </a><br/>"+data_info[i][4]+"<br/>地址："+data_info[i][3];
									addClickHandler(content,marker);
								}
								function addClickHandler(content,marker){
									marker.addEventListener("click",function(e){
										openInfo(content,e)}
									);
								}
								function openInfo(content,e){
									var p = e.target;
									var point = new BMap.Point(p.getPosition().lng, p.getPosition().lat);
									var infoWindow = new BMap.InfoWindow(content,opts);  // 创建信息窗口对象 
									map.openInfoWindow(infoWindow,point); //开启信息窗口
								}
		    					
		    					
		    
					 		 });		
   }
}));
		
		
		
	});	
	
			


$(".menav li").each(function(a){ 
		var me = $(".menav li:eq("+a+")"),i=a+1;
		me.find("img").attr("src","images/me_"+i+".png")
		me.hover(function(){ 
			me.find("img").attr("src","images/me_"+i+"h.png")
		},function(){ 
			me.find("img").attr("src","images/me_"+i+".png")

		})
})

// 百度地图API功能

</script>
</body>
</html>
