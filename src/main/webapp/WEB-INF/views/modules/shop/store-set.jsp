<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="robots" content="noarchive">
    <meta name="Description" content="${fns:getProjectName()},门店基本设置"/>
    <meta name="Keywords" content="${fns:getProjectName()},门店基本设置"/>
    <title>门店基本设置</title>
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/admin-member-msg.css">
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/store-set.css">
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/bootstrap.min.css">
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/build.css">
    <link rel="stylesheet" href="${ctxStatic}/sbShop/layui/css/layui.css">
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/colpick.css">
    <link type="text/css" rel="stylesheet" href="${ctxStatic}/common/jqsite.min.css">
    <link rel="stylesheet" href="${ctxStatic}/tii/tii.css">
    <script src="${ctxStatic}/sbShop/js/jquery.min.js"></script>
    <script type="text/javascript" src="${ctxStatic}/common/mustache.min.js"></script>
    <script type="text/javascript" src="${ctxStatic}/common/jqsite.min.js"></script>
    <script type="text/javascript" src="${ctxStatic}/ckeditor/ckeditor.js"></script>
    <script type="text/javascript" src="${ctxStatic}/ckfinder/ckfinder.js"></script>
    <script src="${ctxStatic}/tii/tii.js"></script>
    <script src="${ctxStatic}/sbShop/js/colpick.js"></script>
    <script src="${ctxStatic}/sbShop/js/store-set.js"></script>
    <script>
        $(window.parent.document).find('.list-ul').find('ul').slideUp();
        $(window.parent.document).find('.list-ul').find('a').removeClass('active');
    </script>
    <script>
        $(function () {
            if ($('#shopBannerPreview').children('li:nth-child(1)').text() == '无') {
                $('#shopBannerPreview').children('li:nth-child(1)').text('')
            }
            if ($('#shopwapBannerPreview').children('li:nth-child(1)').text() == '无') {
                $('#shopwapBannerPreview').children('li:nth-child(1)').text('')
            }
            if ($('#shopLogoPreview').children('li:nth-child(1)').text() == '无') {
                $('#shopLogoPreview').children('li:nth-child(1)').text('')
            }
        })

        function ratio() {
            var val = parseInt($('#returnRatio').val());
            if (val >= ${minRatioOnLine} && val <=${maxRatioOnLine}) {

            } else {
                if (val >${maxRatioOnLine}) {
                    $('#returnRatio').val(${maxRatioOnLine})
                }
                if (val <${minRatioOnLine}) {
                    $('#returnRatio').val(${minRatioOnLine})
                }
                alert("请输入正确的折扣比")
            }


        }

        function coordinatesChange(lng, lat) {
            $("#longitude").val(lng);
            $("#latitude").val(lat);
        }


        <%--function openMap(obj) {--%>
            <%--if (obj.value === "坐标选位") {--%>
                <%--var lng = $("#longitude").val();--%>
                <%--var lat = $("#latitude").val();--%>
                <%--var url = "${ctxweb}/mapBaidu";--%>
                <%--if (lng && lat)--%>
                    <%--url += "?point=" + lng + "," + lat;--%>
                <%--document.getElementById("iframe_map").src = url;--%>
                <%--$("#iframe_map").toggle();--%>
                <%--obj.value = "确定";--%>
                <%--//windowOpen(url,"文件管理",1000,700);--%>
            <%--} else {--%>
                <%--obj.value = "坐标选位";--%>
                <%--$("#iframe_map").toggle();--%>
                <%--document.getElementById("iframe_map").src = "";--%>
            <%--}--%>
        <%--}--%>

        //百度地图WebAPI 坐标转地址
        // function showPosition(r) {
        //     // ak = appkey 访问次数流量有限制
        //     var url = 'http://api.map.baidu.com/geocoder/v2/?ak=7b788c5ea45cc4b3ac6331a4b0643d5b&callback=?&location=' + r.lat + ',' + r.lng + '&output=json&pois=1';
        //     $.getJSON(url, function (res) {
        //         console.log(res.result)
        //         var result = res.result;
        //         var addr = res.result.addressComponent;
        //         var detailaddr = addr.country + "," + addr.province + "," + addr.city + "," + addr.district + "," + addr.street + addr.street_number;
        //         detailaddr = detailaddr.replace("省", "");
        //         $("#district").html(detailaddr);
        //         $("#districtName").val(detailaddr);
        //         document.getElementById("contactAddress").value = result.formatted_address + result.sematic_description;
        //     });
        // }

        // 修改密码弹框
        function overlay() {
            var e1 = document.getElementById('modal-overlay');
            e1.style.visibility = (e1.style.visibility == "visible") ? "hidden" : "visible";
        }

        //提交修改密码
        function updateUser() {
            overlay();
            var reg = new RegExp(/[A-Za-z].*[0-9]|[0-9].*[A-Za-z]/)
            // 密码为空
            if ($("#passwd").val() == "") {
                alert("请输入新密码");
            } else if ($("#passwd").val().length < 6) {
                alert("新密码不能小于6个字符");
            } else {
                updatePassword();
            }
        }


        function updatePassword() {
            var index = "";
            var passwd = $("#passwd").val();
            var params = {
                passwd: $.trim($("#passwd").val()),
            }
            $.ajax({
                type: "post",
                url: "${ctxweb}/shop/shopInfo/modifyPasswd",
                data: params,
                beforeSend: function () {

                },
                success: function (data) {
                    window.location.reload();
                }
                , error: function (res) {
                    alert("获取数据失败");
                }
            })
        }

    </script>

    <script type="text/javascript" src="https://map.qq.com/api/js?v=2.exp&key=4QYBZ-DDUWU-34XV2-2GNUC-GG43Q-JKBTJ&libraries=drawing,place,convertor"></script>

    <script type="text/javascript">
        var map ;
        var searchService;
        var geocoder;	//地址解析
        var marker;

        /**
         * 初始化地图
         * lat 纬度    log  经度
         * */
        function init(lng , lat){
            if(lng == undefined || lng == ""){
                lng =116.4016485214;
            }

            if(lat == undefined || lat == ""){
                lat=39.9077281779;
            }

            map = new qq.maps.Map(document.getElementById("map-container"),{
                center:  new qq.maps.LatLng(lat,lng),
                zoom: 13
            });

            //初始化一个标记
            var latLng = new qq.maps.LatLng(lat, lng);
            marker = new qq.maps.Marker({
                map:map,
                position: latLng
            });


            //添加dom监听事件
            qq.maps.event.addDomListener(map, 'click', function(event) {
                addMarker(event.latLng);
            });

            initPlace("广州")
            initGeocoder();
        }

        /**
         * 初始化关键字搜索
         * @param localtionCity
         */
        function initPlace(localtionCity){
            //实例化自动完成
            var ap = new qq.maps.place.Autocomplete(document.getElementById('place'), {
                offset: new qq.maps.Size(0, 5),
                location: localtionCity
            });
            var keyword = "";
            //调用Poi检索类。用于进行本地检索、周边检索等服务。
            searchService = new qq.maps.SearchService({
                complete : function(results){
                    if(results.type === "CITY_LIST") {
                        searchService.setLocation(results.detail.cities[0].cityName);
                        searchService.search(keyword);
                        return;
                    }

                    var pois = results.detail.pois;

                    //获取搜索列表的第一个元素
                    var poi = pois[0];

                    //调用经纬度解析
                    geocoder.getAddress(poi.latLng);
                }
            });

            //添加监听事件
            qq.maps.event.addListener(ap, "confirm", function(res){
                keyword = res.value;
                searchService.search(keyword);
            });

        }

        /**
         * 初始化地址解析
         */
        function initGeocoder(){
            geocoder = new qq.maps.Geocoder({
                complete : function(result){
                    //移除旧标记
                    if(marker != null){
                        marker.setMap(null);
                    }

                    map.setCenter(result.detail.location);

                    marker = new qq.maps.Marker({
                        map:map,
                        position: result.detail.location
                    });

                    updateAddress(result.detail);
                }
            });
        }

        /**
         * 通过关键字搜索
         * */
        function searchKeyWord(){
            var keyword = document.getElementById("place").value;
            searchService.search(keyword);
        }

        /**
         * 通过经纬度搜索
         * */
        function searchByLatLng(){
            //获取经纬度数值   按照,分割字符串 取出前两位 解析成浮点数

            var lat = parseFloat($("#latitude").val());
            var lng = parseFloat($("#longitude").val());
            var latLng = new qq.maps.LatLng(lat, lng);
            //调用获取位置方法
            geocoder.getAddress(latLng);

        }


        //添加标记
        function addMarker(location) {
            //移除旧标记
            if(marker != null){
                marker.setMap(null);
            }

            marker = new qq.maps.Marker({
                position: location,
                map: map
            });

            geocoder.getAddress(location);
        }

        //修改地址信息
        function updateAddress(geoInfo){
            var ac = geoInfo.addressComponents;
            var districtName = ac.province+","+ac.city+","+ac.district;
            if(ac.street != undefined && ac.street != ""){
                districtName = districtName+","+ac.street
            }
            if(ac.streetnumber != undefined && ac.streetnumber != ""){
                districtName = districtName +","+ ac.streetnumber
            }

            //地区名称
            $("#districtName").val(districtName);
            $("#district").text(districtName);

            //详细地址
            $("#contactAddress").val(geoInfo.address);

            //更新坐标
            $("#latitude").val(geoInfo.location.getLat())
            $("#longitude").val(geoInfo.location.getLng())

        }
    </script>

    <script type="text/javascript">

        //打开关闭地图
        function openMap(){
            var lng = $("#longitude").val();
            var lat = $("#latitude").val();

            if($("#map-div").css("display") == "none"){
                $("#map-div").css("display","block")
                $("#map-control").val("确定")
                init(lng , lat);
            }else{
                $("#map-div").css("display","none");
                $("#map-control").val("坐标选位")
            }

        }
    </script>


    <style type="text/css">
        #map-div{
            position:relative;
        }
        #search-div
        {
            margin-top:20px;
            position:absolute;right:0;top:0;
            height: 30px;
            padding: 0px;
            background-color:rgb(211, 211, 211);
            z-index: 1;

        }

        .search-btn{
            height: 30px;
            padding: 3px 12px;
            margin: 0px;
        }

        #search-div input, #search-div button
        {
            float: left;
            height: 30px;

        }

        .store>ul>li:nth-child(2) {
            width: 80%;
            border-left: 1px solid #dcdcdc;
            padding-left: 5px;
        }

        .btn{
            background: #393D49;
            border: #393D49;
        }

        .btn:hover{
            color:rgb(120,120,120);
            background: #393D49;
        }

        .file-div a{
            background: #393D49;
        }
    </style>
</head>
<body>
	<div style="color:#999;padding:19px 0 17px 30px;background:#f5f5f5;">
		<span>当前位置：</span><span>门店管理 - </span><span style="color:#009688;">基本设置</span>
	</div>
<form class="form-horizontal" action="${ctxweb}/shop/shopInfo/storeSetFormEdit" method="post" name="form2">
    <div class="store">
        <p class="store-top" >	<b style="float:left;width:5px;height:16px;border-right:3px solid #358FE6;margin-right:10px;margin-top:14px;"></b>门店设置</p>

        <ul class="store-name">
            <li><b>*</b>门店名称：</li>
            <li>
                <input id="shopName" name="shopName" value="${shopInfo.shopName}" class="input" type="text">
            </li>
        </ul>
        <%--<ul class="store-offline">
            <li><b>*</b>线下门店：</li>
            <li class="checkbox1">
            	<c:choose>
        			<c:when test="${shopInfo.isLineShop==0}">
        				<input id="isLineShop" name="isLineShop" type="checkbox">
                		是否开通
        			</c:when>
        			<c:when test="${shopInfo.isLineShop==1}">
        				<input id="isLineShop" name="isLineShop" checked type="checkbox">
                		是否开通
        			</c:when>
        			<c:otherwise>
        				<input id="isLineShop" name="isLineShop" type="checkbox">
                		是否开通
        			</c:otherwise>
        		</c:choose>
            </li>
        </ul>--%>
        <ul class="store-offline">
            <li>地区名称：</li>
            <li>
                <span id="district">${shopInfo.districtName},${shopInfo.shopLlAddress}</span>
                <input id="districtName" name="districtName" class="hidden"
                       value="${shopInfo.districtName},${shopInfo.shopLlAddress}">
            </li>
        </ul>
        <ul class="store-offline">
            <li>详细地址：</li>
            <li>
                <input id="contactAddress" class="store-name input" name="contactAddress"
                       value="${shopInfo.contactAddress}" type="text"
                       style="height: 30px;border: 1px solid #eee;padding: 0 10px;width: 430px">
            </li>
        </ul>
        <ul class="store-offline">
            <li><b></b>门店坐标：</li>
            <li>
                经度：<input id="longitude" name="longitude" class="store-name input" value="${shopInfo.shopLongitude}"
                          type="text" style="height: 30px;border: 1px solid #eee;padding: 0 10px;width: 130px">
                纬度：<input id="latitude" name="latitude" class="store-name input" value="${shopInfo.shopLatitude}"
                          type="text" style="height: 30px;border: 1px solid #eee;padding: 0 10px;width: 130px">
                <input type="button" class="btn" id="map-control"
                       style="background: #393D49;color: #fff;padding: 3px 12px;margin-right: 10px;" value="坐标选位"
                       onclick="openMap(this)"/>

                <%--地图盒子--%>
                <div id="map-div" style="display: none;margin-left: 40px">
                    <div style="margin:5px" id="search-div">
                        <input style="width:200px;padding:0px 4px;" type="text" id="place" />
                        <button type="button" class="btn search-btn" style="color: #ffffff;" onclick="searchKeyWord()">搜索</button>
                        <br><br>
                    </div>

                    <!--   定义地图显示容器   -->
                    <div id="map-container" style="width:100%;height:300px"></div>
                    <input style="width:200px;padding:3px 4px;" type="hidden" style="display: none" />
                    <%--<iframe id="iframe_map" width="100%" height="300" frameborder="0" scrolling="no" style="display: none;"></iframe>--%>
                </div>

                <%--<iframe id="iframe_map" width="100%" height="300" frameborder="0" scrolling="no"--%>
                        <%--style="display: none;"></iframe>--%>
            </li>
        </ul>
        <ul class="store-offline">
            <li><b></b>修改门店密码：</li>
            <li>
                <input type="button" class="btn"
                       style="background: #393D49;color: #fff;padding: 3px 12px;margin-right: 10px;" value="修改"
                       onclick="overlay()"/>
            </li>
        </ul>

        <ul class="store-offline">
            <li>四舍五入（小程序）：</li>
            <li>
                <div class="radio-div">
                    <input id="is-round-applet1" name="isRoundApplet" onclick="changeAppletRound(1)" type="radio" value="1"
                           <c:if test="${not empty shopInfo.isRoundApplet && shopInfo.isRoundApplet==1}">checked</c:if>/>
                    支持
                    <input id="is-round-applet2" name="isRoundApplet" onclick="changeAppletRound(0)"  type="radio" value="0"
                           <c:if test="${empty shopInfo.isRoundApplet||shopInfo.isRoundApplet==0}">checked</c:if>
                    />
                    不支持
                </div>
            </li>
        </ul>

        <ul class="store-offline" id="accuracy-applet-ul"
            <c:if test="${empty shopInfo.isRoundApplet || shopInfo.isRoundApplet == 0}">style="display: none" </c:if>
        >
            <li>精确度（小程序）：</li>
            <li>
                <div class="radio-div">
                    <select name="accuracyApplet" style="height: 25px;width: 50px;">
                        <option value="1"  <c:if test="${not empty shopInfo.accuracyApplet && shopInfo.accuracyApplet==1}">selected</c:if>>元</option>
                        <option value="2"  <c:if test="${empty shopInfo.accuracyApplet||shopInfo.accuracyApplet==2}">selected</c:if>>角</option>
                        <option value="3"  <c:if test="${not empty shopInfo.accuracyApplet && shopInfo.accuracyApplet==3}">selected</c:if>>分</option>
                    </select>
                </div>
            </li>
        </ul>

        <ul class="store-offline">
            <li>四舍五入（收银端）：</li>
            <li>
                <div class="radio-div">
                    <input id="is-round-cash1" name="isRoundCash" type="radio" value="1" onclick="changeCashRound(1)"
                           <c:if test="${not empty shopInfo.isRoundCash && shopInfo.isRoundCash==1}">checked</c:if>/>
                    支持
                    <input id="is-round-cash2" name="isRoundCash" type="radio" value="0" onclick="changeCashRound(0)"
                           <c:if test="${empty shopInfo.isRoundCash||shopInfo.isRoundCash==0}">checked</c:if>
                    />
                    不支持
                </div>
            </li>
        </ul>

        <ul class="store-offline" id="accuracy-cash-ul"
            <c:if test="${empty shopInfo.isRoundCash || shopInfo.isRoundCash == 0}">style="display: none" </c:if>
        >
            <li>精确度（收银端）：</li>
            <li>
                <div class="radio-div">
                    <select name="accuracyCash" style="height: 25px;width: 50px;">
                        <option value="1"  <c:if test="${not empty shopInfo.accuracyCash && shopInfo.accuracyCash==1}">selected</c:if>>元</option>
                        <option value="2"  <c:if test="${empty shopInfo.accuracyCash||shopInfo.accuracyCash==2}">selected</c:if>>角</option>
                        <option value="3"  <c:if test="${not empty shopInfo.accuracyCash && shopInfo.accuracyCash==3}">selected</c:if>>分</option>
                    </select>
                </div>
            </li>
        </ul>


        <ul class="store-offline">
            <li><b></b>是否支持外卖：</li>
            <li>
                <input name="takeout" value="0" type="radio" ${shopInfo.takeout==0 or shopInfo.takeout == null?'checked':''}/>否
                <input name="takeout" value="1" type="radio" ${shopInfo.takeout==1?'checked':''}/>是
            </li>
        </ul>


        <ul class="store-offline">
            <li>外卖配送距离(米)：</li>
            <li>
                <input id="shopRange" class="store-name input" name="shopRange"
                       value="${shopInfo.shopRange}" type="number"
                       style="height: 30px;border: 1px solid #eee;padding: 0 10px;width: 130px">
            </li>
        </ul>

        <ul class="store-offline">
            <li>起送价格：</li>
            <li>
                <input id="startingPrice" class="store-name input" name="startingPrice"
                       value="${shopInfo.startingPrice}" type="number"
                       style="height: 30px;border: 1px solid #eee;padding: 0 10px;width: 130px">
            </li>
        </ul>
        <ul class="store-offline">
            <li>起始取餐号：</li>
            <li>
                <input id="startNumber" class="store-name input" name="startNumber"
                       value="${shopInfo.startNumber}" type="number"
                       style="height: 30px;border: 1px solid #eee;padding: 0 10px;width: 130px">
            </li>
        </ul>
        <ul class="store-offline">
            <li><b></b>门店取餐提醒：</li>
            <li>
                <input name="isTakeMeals" value="1" type="radio" ${shopInfo.isTakeMeals==1?'checked':''}/>是
                <input name="isTakeMeals" value="0" type="radio" ${shopInfo.isTakeMeals==0 or shopInfo.isTakeMeals == null?'checked':''}/>否
                <font color="red">(*每日0:00更新)</font>
            </li>
        </ul>
        <ul class="store-offline">
            <li><b></b>小程序点餐：</li>
            <li>
                <input name="isMiniOrder" value="0" type="radio" ${shopInfo.isMiniOrder==0 or shopInfo.isMiniOrder == null?'checked':''}/>开
                <input name="isMiniOrder" value="1" type="radio" ${shopInfo.isMiniOrder==1?'checked':''}/>关
            </li>
        </ul>
        <%--     <ul class="store-ratio">
                 <li><b>*</b>默认折扣比：</li>
                 <li><input id="returnRatio" type="number" name="returnRatio" onchange="ratio();"
                            value="${shopInfo.returnRatio}" class="num input" maxlength="3" type="text">%
                     <span>(注：比例只能在${minRatioOnLine}-${maxRatioOnLine}的整数)</span></li>
             </ul>--%>
        <ul class="store-bg">
            <li style="height:141px;">门店广告图：</li>
            <li style="height:141px;">
                <div class="file-div">
                    <input type="hidden" name="shopBanner" id="shopBanner" value="${shopInfo.shopBanner}"
                           htmlEscape="false" maxlength="100" class="input-xlarge"/>
                    <span class="help-inline" id="shopBanner" style="color: blue;" maxHeight="20"></span>
                    <tags:ckfinder input="shopBanner" type="images" uploadPath="/shopImg"/>
                </div>
                <span>建议文件格式GIF、JPG、JPEG、PNG文件大小1M以内，1920x140</span>
            </li>
        </ul>
        <%--
       <ul class="store-bg">
           <li>手机门店背景：</li>
           <li>
               <div class="file-div">
                   <input type="hidden" name="shopwapBanner" id="shopwapBanner" value="${shopInfo.shopwapBanner}"  htmlEscape="false" maxlength="100"  class="input-xlarge"/>
                   <span class="help-inline" id="shopwapBanner"  style="color: blue;"></span>
                   <tags:ckfinder input="shopwapBanner" type="images" uploadPath="/shopImg"/>
               </div>
               <span>建议文件格式GIF、JPG、JPEG、PNG文件大小1M以内，750x199</span>
           </li>
       </ul> --%>

        <ul class="store-bg">
            <li>门店Logo：</li>
            <li>
                <div class="file-div">
                    <input type="hidden" name="shopLogo" id="shopLogo" value="${shopInfo.shopLogo}" htmlEscape="false"
                           maxlength="100" class="input-xlarge"/>
                    <span class="help-inline" id="shopLogo" style="color: blue;"></span>
                    <tags:ckfinder input="shopLogo" type="images" uploadPath="/shopImg"/>
                </div>
                <span>建议文件格式GIF、JPG、JPEG、PNG文件大小1M以内，120x120</span>
            </li>
        </ul>
        <%-- <ul>
            <li>门店背景颜色：</li>
            <li>
                #<input id="picker" Name="shopBannerBg" value="${shopInfo.shopBannerBg}" type="text">
                <div class="clear"></div>
            </li>
        </ul> --%>
        <ul class="store-offline">
            <li><b></b>是否开启优惠券入口：</li>
            <li>
                <input name="isCertificate" value="0" type="radio" ${shopInfo.isCertificate==0 or shopInfo.isCertificate == null?'checked':''}/>否
                <input name="isCertificate" value="1" type="radio" ${shopInfo.isCertificate==1?'checked':''}/>是
            </li>
        </ul>
        <ul class="store-bg">
            <li>门店优惠券图：</li>
            <li>
                <div class="file-div">
                    <input type="hidden" name="certificatePic" id="certificatePic" value="${shopInfo.certificatePic}"
                           htmlEscape="false" maxlength="100" class="input-xlarge"/>
                    <span class="help-inline" id="certificatePic" style="color: blue;" maxHeight="20"></span>
                    <tags:ckfinder input="certificatePic" type="images" uploadPath="/shopImg"/>
                </div>
                <span>建议文件格式GIF、JPG、JPEG、PNG文件大小1M以内，1920x140</span>
            </li>
        </ul>
        <ul class="store-brief">
            <li>门店简介：</li>
            <li>
                <textarea name="remarkDesc" id="remarkDesc">${shopInfo.remarkDesc}</textarea>
                <p><span>门店简介会加入到门店索引中！</span></p>
            </li>
        </ul>
        <%-- <ul>
            <li>门店介绍：</li>
            <li>
                <textarea name="describeInfo" id="productHtml">${shopInfo.describeInfo}</textarea>
			  	<tags:ckeditor replace="productHtml" uploadPath="/shopImg"></tags:ckeditor>
            </li>
        </ul> --%>
        <ul class="ul-btn">
            <li></li>
            <li><a class="store-bc btn btn-primary" href="javascript:;">保存</a></li>
        </ul>
    </div>
</form>
<div class="tii">
    <span class="tii-img"></span>
    <span class="message" data-tid="${message}">${message}</span>
</div>

<div id="modal-overlay" style="position:fixed;top:0;left:0;bottom:0;background: rgba(0,0,0,0.4)">
<div style="width:240px;height:180px;margin:10% auto;background: #fff;">
        <div class="msg-btn">

            <label>修改密码:</label>
            <input id="passwd" type="text" style="width:100px" onkeyup="value=value.replace(/[/W]/g,'') ">
            </br><label style="font-size: 2px;color: #4778C7;">（请勿输入特殊字符）</label>
        </div>
        <div class="msg-btn" style="padding:10px 0;">
            <a onclick="updateUser()" style="background-color:#4778C7;">确定</a>
            <a onclick="overlay()" style="background-color:#999">取消</a>
        </div>

</div>
</div>

<style>
    /* 定义模态对话框外面的覆盖层样式 */
    #modal-overlay {
        visibility: hidden;
        position: absolute; /* 使用绝对定位或固定定位  */
        left: 0px;
        top: 0px;
        width: 100%;
        height: 100%;
        text-align: center;
        z-index: 1000;
        background-color: #3333;
    }

    /* 模态框样式 */
    .modal-data {
        width: 300px;
        margin: 100px auto;
        background-color: #fff;
        border: 1px solid #000;
        border-color: #ffff;
        padding: 15px;
        text-align: center;
    }
</style>

<script>
    function changeCashRound(status){
        if(status == 1){
            $("#accuracy-cash-ul").css("display","inline-block");
        }else{
            $("#accuracy-cash-ul").css("display","none");
        }

    }

    function changeAppletRound(status){
        if(status == 1){
            $("#accuracy-applet-ul").css("display","inline-block");
        }else{
            $("#accuracy-applet-ul").css("display","none");
        }

    }
</script>
</body>
</html>