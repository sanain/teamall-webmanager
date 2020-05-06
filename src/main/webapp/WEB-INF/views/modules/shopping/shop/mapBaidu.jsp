<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title></title>
	<style type="text/css">
			html, body {
				margin: 0;
				padding: 0;
				width: 100%;
				height: 100%;
			}
			#map {
				width: 100%;
				height: 100%;
			}
			.control {
				color: #A0522D;
				font: 14px arial, sans-serif;
			}
			.cursor-pointer {
				cursor: pointer;
			}
		</style>
	<script type="text/javascript" src="https://api.map.baidu.com/api?v=2.0&ak=32szE2ZbYkoX6g1kvtTCqfkz"></script>
</head>
<body onload="load()">	
<div >
	<div id="map">
		<!-- 地图显示区域 -->
	</div>
	<div id="SearchControl" class="control">
		<label>地址:</label><input type="text" id="address" /><input type="button" value="搜索" class="cursor-pointer" onclick="search()" />
	</div>
</div>

<script type="text/javascript">
/**
		 * 搜索控件
		 */
		function SearchControl() {
			this.defaultAnchor = BMAP_ANCHOR_TOP_RIGHT;
			this.defaultOffset = new BMap.Size(10, 10);
		}
		SearchControl.prototype = new BMap.Control();
		SearchControl.prototype.initialize = function(map) {
			var control = document.getElementById("SearchControl");
			map.getContainer().appendChild(control);
			return control;
		};
		
		function position(point){
			if(point)
				parent.showPosition(point);
				parent.coordinatesChange(point.lng,point.lat);
		}
		function search(){
			var address = document.getElementById("address").value;
			if(address) {
				map_js.searchAddress(address);
				document.getElementById("address").value = "";
			}
		}
		/**
		 * 地图通用参数
		 */
		var map_parameter = {
			center : "广东省",
			zoom : 10,
			minZoom : 7,
			maxZoom : 19,
			point : null,
			address : null
		};
		/**
		 * 页面装载时调用
		 */
		function load() {
			var center = getParameter("center");
			if(center)
				map_parameter.center = center;
			var zoom = getParameter("zoom");
			if(zoom)
				map_parameter.zoom = zoom;
			var minZoom = getParameter("minZoom");
			if(minZoom)
				map_parameter.minZoom = minZoom;
			var maxZoom = getParameter("maxZoom");
			if(maxZoom)
				map_parameter.maxZoom = maxZoom;
			map_parameter.point = getParameter("point");
			map_parameter.address = getParameter("address");
			map_js.createMap("map");
		}
		/**
		 * 页面卸载时调用
		 */
		function unload() {
		}
		/**
		 * 地图操作相关JS命名空间
		 */
		var map_js = {
			/**
			 * 创建地图
			 * @param {Object} container 地图容器
			 */
			createMap : function(container) {
				window.map = new BMap.Map(container);
				map.centerAndZoom(map_parameter.center, map_parameter.zoom);
				map.addEventListener("load", map_js.mapLoad);
			},
			mapLoad : function(e) {
				/*基础参数设置*/
				map.setMinZoom(map_parameter.minZoom);
				map.setMaxZoom(map_parameter.maxZoom);
				/*地图事件设置*/
				map.enableScrollWheelZoom();
				map.enableContinuousZoom();
				map.enableInertialDragging();
				map.enableKeyboard();
				/*地图控件设置*/
				var ctrl_nav = new BMap.NavigationControl({
					anchor : BMAP_ANCHOR_TOP_LEFT,
					type : BMAP_NAVIGATION_CONTROL_LARGE
				});
				map.addControl(ctrl_nav);
				var searchControl = new SearchControl();
				map.addControl(searchControl);
				/*地图菜单设置*/
				var menu = new BMap.ContextMenu();
				menu.addItem(new BMap.MenuItem("在这儿...",function(e){
					map.clearOverlays();
					var point = new BMap.Point(e.lng, e.lat);
					map_js.addMarker(point);
				},{width:50}));
				map.addContextMenu(menu);
				// 清除覆盖物
				map.clearOverlays();
				map_js.initMarker();
			},
			searchAddress : function(address) {
				map.clearOverlays();
				new BMap.Geocoder().getPoint(address, function(point) {
					if (point)
						map_js.addMarker(point);
				}, map_parameter.center);
			},
			initMarker : function() {
				if(map_parameter.point) {
					var point = new BMap.Point(map_parameter.point.split(",")[0], map_parameter.point.split(",")[1]);
					map_js.addMarker(point);
				} else if(map_parameter.address) {
					map_js.searchAddress(map_parameter.address);
				}else{
				}
			},
			addMarker : function(point) {
				var iconImg = map_js.tools.createIcon(us_mk_icon_js.elements.cone.red);
				var marker = new BMap.Marker(point, {
					icon : iconImg,
					enableDragging : true
				});
				var label = new BMap.Label("拖动改变位置",{"offset":new BMap.Size(us_mk_icon_js.elements.cone.red.lb-us_mk_icon_js.elements.cone.red.x+17,2)});
				label.setStyle({
					borderColor:"#808080",
					color:"#333"
        		});
				marker.setLabel(label);
				map.addOverlay(marker);
				// 调整到相应的视野
				map.setViewport([point]);
				(function(marker) {
					marker.addEventListener("dragend", function() {
						position(marker.getPosition());
					});
				})(marker);
				position(point);
			},
			/**
			 * 工具
			 */
			tools : {
				/**
				 * 创建图标对象
				 * @param {Object} json 图标信息描述
				 */
				createIcon : function(json) {
					var icon = new BMap.Icon(us_mk_icon_js.url, new BMap.Size(json.w, json.h), {
						imageOffset : new BMap.Size(-json.l, -json.t),
						infoWindowOffset : new BMap.Size(json.lb + 5, 1),
						offset : new BMap.Size(json.x, json.h)
					});
					return icon;
				}
			}
		};
		
		var us_mk_icon_js = {
			url : "http://app.baidu.com/map/images/us_mk_icon.png",
			elements : {
				cone : {
					red : {
						w : 23,
						h : 25,
						l : 46,
						t : 21,
						x : 9,
						lb : 12
					}
				}
			}
		};
		function getParameter(key){
			var reg = new RegExp("(^|&)" + key + "=([^&]*)(&|$)");
			var value = window.location.search.substr(1).match(reg);
			if (value != null)
				return unescape(value[2]);
			return null;
		}

</script>
</body>
</html>
