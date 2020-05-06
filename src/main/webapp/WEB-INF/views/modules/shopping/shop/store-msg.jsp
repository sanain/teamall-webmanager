<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0,minimal-ui">
    <title>${'add'.equals(flag) ? '增加门店':'门店信息'}</title>
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/admin-store-msg.css">
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/bootstrap.min.css">
    <link type="text/css" rel="stylesheet" href="${ctxStatic}/common/jqsite.min.css">
    <link rel="stylesheet" href="${ctxStatic}/tii/tii.css">
    <link rel="stylesheet" href="${ctxStatic}/h5/css/timePicker.css">

    <%--<link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">--%>
    <%--<script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>--%>
    <%--<script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>--%>

    <script src="${ctxStatic}/sbShop/js/jquery.min.js"></script>
    <script src="${ctxStatic}/sbShop/js/jquery.validate.min.js"></script>
    <script src="${ctxStatic}/bootstrap/2.3.1/docs/assets/js/bootstrap-modal.js"></script>
    <script type="text/javascript" src="${ctxStatic}/h5/js/jquery-timepicker.js"></script>
    <script type="text/javascript" src="${ctxStatic}/common/mustache.min.js"></script>
	<script type="text/javascript" src="${ctxStatic}/common/jqsite.min.js"></script>
   	<script type="text/javascript" src="${ctxStatic}/ckeditor/ckeditor.js"></script>
	<script type="text/javascript" src="${ctxStatic}/ckfinder/ckfinder.js"></script>
    <script src="${ctxStatic}/sbShop/js/admin-store-msg.js"></script>
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
            }else {
                $("#map-div").css("display", "none");
                $("#map-control").val("坐标选位")

                //地区名称
                $("#district-name-ul").css("display", "inline-block");
                //详细地址
                $("#contact-address-ul").css("display", "inline-block");
            }

        }
    </script>

    <script>
        $().ready(function(e) {
            $("#timePicker").hunterTimePicker();
            $(".time-picker").hunterTimePicker();
        });

        // $.validator.setDefaults({
        //     submitHandler: function() {
        //         alert("提交事件!");
        //     }
        // });
    </script>
    <script type="text/javascript">
        function addShopInfo() {
            debugger;

            var chec=$('.lei-bie ul li input:checked');
            var arrc='';
            for (i=0;i<chec.length;i++){
                arrc+=$(chec[i]).val()+',';
            }
            arrc=arrc.substring(0,arrc.length-1);;
            $("#cooperTypesid").val(arrc);

            var shopName=$("#shopName").val();
            var returnRatio=$("#returnRatio").val();
            var password=$("#password").val();
            var confirmPassword=$("#confirm-password").val();
            $(this).parents('form').find('input[type=text],textarea[type=text]').css("border", "1px solid #a9a9a9");
            $('.lei-bie ul').css("border", "none");

            if(!(/^1[3456789]\d{9}$/.test($("#mobile").val()))){
                $("#mobile").css("border", "1px solid red");
                alert("账号不正确！");
                return;
            }else if(shopName==""){
                $("#shopName").css("border", "1px solid red");
                alert("请填写门店名称！");
                return false;
            }else if($("#flag").val() == "add" && $("#set-password-input").val() == ""){
                $("#set-password-input").css("border", "1px solid red");
                alert("密码不能为空！");
                return;
            }else if($("#flag").val() == "add" && $("#set-password-input").val().trim().length < 6){
                $("#set-password-input").css("border", "1px solid red");
                alert("密码不能少于六位！");
                return;
            }else if($("#contactAddress").val() == undefined || $("#contactAddress").val() == "" ){
                $("#contactAddress").css("border", "1px solid red");
                alert("地址不能为空！");
                return;
            }else if($("#openingTime").val() == ""){
                $("#openingTime").css("border", "1px solid red");
                alert("开始营业时间不能为空！");
                return;
            }else if( $("#closingTime").val() == ""){
                $("#closingTime").css("border", "1px solid red");
                alert("结束营业时间不能为空！");
                return;
            }

            var url="";
            var flag="${flag}";
            if(flag=="add"){
                url= "${ctxsys}/PmShopInfo/addShopInfo";
            }else{
                url= "${ctxsys}/PmShopInfo/shopinfoEdit";
            }

            $.ajax({
                type: "POST",
                url: url,
                data: $("#form2").serialize(),
                success: function(data){
                    alert(data.msg);
                    if(data.code=='00'&&flag=="add"){
                        window.location.href="${ctxsys}/PmShopInfo/list";
                    }
                }
            });
        }
    </script>

    <style>
    	.fixed-img{dispaly:none;position:fixed;width:600px;left:50%;margin-left:-300px;}
    	.fixed-img img{width:100%;max-width:auto}
    	.fit-right ul li ol li:first-child{}
        .nav-ul{
            margin-right: 10px;
            margin-left: 10px;
        }
        .go-back{
            display: inline-block;
            height: 30px;
            line-height: 30px;
            border-radius: 5px;
            width: 90px;
            border: #1b6d85 1px solid;
        }

        /*#map-container*/
        /*{*/
            /*position: absolute;*/
            /*width: 150px;*/
            /*height: 150px;*/
            /*border: 1px solid #000;*/
            /*background: #999;*/
        /*}*/
        #map-div{
            position:relative;
        }
        #search-div
        {
            margin-top:20px;
            position:absolute;right:0;top:0;
            height: 30px;
            background-color:rgb(211, 211, 211);
            z-index: 1;

        }

        #search-div input, #search-div button
        {
            height: 30px;
            float: left;

        }

        .search-btn{
            height: 30px;
            padding: 3px 12px;
            margin: 0px;
        }
        /*#search-p*/
        /*{*/
        /*position: relative;*/
        /*width: 100px;*/
        /*height: 100px;*/
        /*border: 1px solid #F00;*/
        /*background: #FFF;*/
        /*z-index: 1;*/
        /*}*/

        .fit-right .img-btn a{
            margin-left: 20px;
        }

        .fit-left ul li:nth-child(1){
            width: 130px;
        }
    </style>

</head>
<body>
    <div class="fitment">
      <ul class="nav-ul">
          <c:if test="${!'add'.equals(flag)}">
            <li><a class="active"  href="${ctxsys}/PmShopInfo/shopinfo?id=${pmShopInfo.id}">门店信息</a></li>
          </c:if>
          <c:if test="${'add'.equals(flag)}">
            <li><a class="active" href="${ctxsys}/PmShopInfo/shopinfo?id=${pmShopInfo.id}&flag=add">增加门店</a></li>
          </c:if>
          <c:if test="${!'add'.equals(flag)}">
            <li><a  href="${ctxsys}/PmShopInfo/employees?id=${pmShopInfo.id}">门店员工</a></li>
            <li><a  href="${ctxsys}/PmShopInfo/device?id=${pmShopInfo.id}">登录设备信息</a></li>
              <li><a  href="${ctxsys}/PmShopInfo/amtlogIndex?id=${pmShopInfo.id}">门店结算</a></li>
            <li><a  href="${ctxsys}/PmShopInfo/useramtlog?id=${pmShopInfo.id}">收支明细</a></li>
          </c:if>
      </ul>


      <form class="form-horizontal"
            <c:if test="${'add'.equals(flag)}">action="${ctxsys}/PmShopInfo/addShopInfo"</c:if>
            <c:if test="${!'add'.equals(flag)}">action="${ctxsys}/PmShopInfo/shopinfoEdit"</c:if> method="post" id="form2" name="form2">
          <c:if test="${!'add'.equals(flag)}">
        <input type="hidden" id="id" name="id" value="${pmShopInfo.id}"/>
          </c:if>

          <c:if test="${'add'.equals(flag)}">
              <input type="hidden" id="id" name="oldShopId" value="${pmShopInfo.id}"/>
          </c:if>
        <input type="hidden"  name="mobile" value="${mobile}"/>
        <input type="hidden" id="area" name="area" value=""/>

         <input type="hidden" id="cooperTypesid" name="cooperTypesId" value="${cooperTypesid}"/>
        <input type="hidden" id="messager" name="messager" value="0"/>
        <div class="fit-box">
            <input type="hidden" id="flag" value="${flag}">
            <div class="fit-left">
                <ul>
                    <li><b>*</b>账号：</li>
                    <li><input id="mobile" <c:if test="${!'add'.equals(flag)}">readonly</c:if> name="mobilePhone" value="${mobile}" type="text"></li>
                </ul>
                <c:if test="${!'add'.equals(flag)}">
                <ul>
                    <li>修改密码：</li>
                    <li>
                        <input type="button" style="background-color:rgb(106,172,114);padding:0px;width: 60px;height: 30px;margin-left: 0px;font-size:14px;line-height: 30px" value="修改密码" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#myModal"/>
                    </li>
                </ul>
                    <ul>
                        <li>抽点修改：</li>
                        <li class="iRatio">
                            小程序<font color="blue">${pmShopInfo.miniReturnRatio}%</font>    线下门店<font color="blue">${pmShopInfo.shopReturnRatio}% </font>   美团等平台<font color="blue">${pmShopInfo.otherReturnRatio}%</font></li>
                        <li style="margin-left: 10px">
                            <input type="button" style="background-color:rgb(106,172,114);padding:0px;width: 60px;height: 30px;margin-left: 0px;font-size:14px;line-height: 30px" value="抽点修改" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#setRand1"/>
                        </li>
                    </ul>
                </c:if>

                <c:if test="${'add'.equals(flag)}">
                    <ul>
                        <li>设置密码：</li>
                        <li>

                            <input type="button" style="background-color:rgb(106,172,114);padding:0px;width: 60px;height: 30px;margin-left: 0px;font-size:14px;line-height: 30px" value="设置密码" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#setPassword"/>
                        </li>
                    </ul>
                    <ul>
                        <li>抽点设置：</li>
                        <li class="iRatio">
                            小程序<font color="blue">0%</font>    线下门店<font color="blue">0%</font>    美团等平台<font color="blue">0%</font></li>
                        <li style="margin-left: 10px">
                            <input type="button" style="background-color:rgb(106,172,114);padding:0px;width: 60px;height: 30px;margin-left: 0px;font-size:14px;line-height: 30px" value="抽点设置" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#setRand"/>
                        </li>
                    </ul>
                </c:if>

                <input type="hidden" id="set-password-input" name="shopPassword">
                <input type="hidden" id="set-miniReturnRatio-input" name="setMiniReturnRatio" value="${pmShopInfo.miniReturnRatio}">
                <input type="hidden" id="set-shopReturnRatio-input" name="setShopReturnRatio" value="${pmShopInfo.shopReturnRatio}">
                <input type="hidden" id="set-otherReturnRatio-input" name="setOtherReturnRatio" value="${pmShopInfo.otherReturnRatio}">
                <ul>
                    <li>门店名称：</li>
                    <li><input id="shopName" required name="shopName" value="${pmShopInfo.shopName}" type="text"></li>
                </ul>

                <ul>
                    <li>门店简介：</li>
                    <li>
                        <textarea id="remarkDesc" placeholder="最多输入450个字" cols="18" rows="27" name="remarkDesc" style="padding-left: 5px;padding-right: 5px">${pmShopInfo.remarkDesc}</textarea>
                    </li>
                </ul>
                <script type="text/javascript">
                    $(function(){
                        $('#remarkDesc').on("keyup",function(){
                            if($('#remarkDesc').val().length > 500){
                                $('#remarkDesc').val($('#remarkDesc').val().substring(0,450));//长度大于100时截取钱100个字符
                            }
                        })
                    })

                </script>
                <ul>
                    <li>营业时间：</li>
                    <li>
                        <input type="text" class="time-picker" date="true" id="openingTime" name="openingTime" value="${pmShopInfo.openingTime}" readonly style="width: 100px"> ~
                        <input type="text" class="time-picker" data="true" id="closingTime" name="closingTime" value="${pmShopInfo.closingTime}" readonly style="width: 100px">
                    </li>
                </ul>

                <ul>
                    <li>在线状态：</li>
                    <li>
                        <div class="radio-div">
                        	<c:choose>
		        				<c:when test="${pmShopInfo.onlineStatus==1}">
			                    	<input id="xian1" name="onlineStatus" type="radio" value="1" checked>
			                        <label for="xian">在线</label>
			                        <input id="yin1" name="onlineStatus" type="radio" value="0">
		                            <label for="yin">不在线</label>
		                    	</c:when>
		                    	<c:otherwise>
		                    		<input id="xian1" name="onlineStatus" type="radio" value="1">
			                        <label for="xian">在线</label>
			                        <input id="yin1" name="onlineStatus" type="radio" value="0" checked>
		                            <label for="yin">不在线</label>
		                    	</c:otherwise>
		                	</c:choose>
                        </div>
                    </li>
                </ul>
                <ul>
                    <li>商品分类编辑：</li>
                    <li>
                        <div class="radio-div">
                                    <input id="isProductType1" name="isProductType" type="radio" value="1"
                                           <c:if test="${not empty pmShopInfo.isProductType&&pmShopInfo.isProductType==1}">checked</c:if>/>
                                    <label>支持</label>
                                    <input id="isProductType2" name="isProductType" type="radio" value="0"
                                           <c:if test="${empty pmShopInfo.isProductType||pmShopInfo.isProductType==0}">checked</c:if>
                                    />
                                    <label>不支持</label>
                        </div>
                    </li>
                </ul>
                <ul>
                    <li>测试门店：</li>
                    <li>
                        <div class="radio-div">
                            <input id="test1" name="test" type="radio" value="1"
                                   <c:if test="${not empty pmShopInfo.test&&pmShopInfo.test==1}">checked</c:if>/>
                            <label>是</label>
                            <input id="test2" name="test" type="radio" value="0"
                                   <c:if test="${empty pmShopInfo.test||pmShopInfo.test==0}">checked</c:if>
                            />
                            <label>否</label>
                        </div>
                    </li>
                </ul>
                <ul>
                    <li>商品编辑：</li>
                    <li>
                        <div class="radio-div">
                            <input id="isProduct1" name="isProduct" type="radio" value="1"
                                   <c:if test="${not empty pmShopInfo.isProduct&&pmShopInfo.isProduct==1}">checked</c:if>/>
                            <label>支持</label>
                            <input id="isProduct2" name="isProduct" type="radio" value="0"
                                   <c:if test="${empty pmShopInfo.isProduct||pmShopInfo.isProduct==0}">checked</c:if>
                            />
                            <label>不支持</label>
                        </div>
                    </li>
                </ul>
                <ul>
                    <li>订单申请退款：</li>
                    <li>
                        <div class="radio-div">
                            <input id="OrderReturns1" name="storeOrderReturns" type="radio" value="1"
                                   <c:if test="${not empty pmShopInfo.storeOrderReturns&&pmShopInfo.storeOrderReturns==1}">checked</c:if>/>
                            <label>支持</label>
                            <input id="OrderReturns2" name="storeOrderReturns" type="radio" value="0"
                                   <c:if test="${empty pmShopInfo.storeOrderReturns||pmShopInfo.storeOrderReturns==0}">checked</c:if>
                            />
                            <label>不支持</label>
                        </div>
                    </li>
                </ul>
                <ul>
                    <li>四舍五入（小程序）：</li>
                    <li>
                        <div class="radio-div">
                            <input id="is-round-applet1" name="isRoundApplet" onclick="changeAppletRound(1)" type="radio" value="1"
                                   <c:if test="${not empty pmShopInfo.isRoundApplet&&pmShopInfo.isRoundApplet==1}">checked</c:if>/>
                            <label>支持</label>
                            <input id="is-round-applet2" name="isRoundApplet" onclick="changeAppletRound(0)"  type="radio" value="0"
                                   <c:if test="${empty pmShopInfo.isRoundApplet||pmShopInfo.isRoundApplet==0}">checked</c:if>
                            />
                            <label>不支持</label>
                        </div>
                    </li>
                </ul>

                <ul id="accuracy-applet-ul"
                        <c:if test="${empty pmShopInfo.isRoundApplet || pmShopInfo.isRoundApplet == 0}">style="display: none" </c:if>
                >
                    <li>精确度（小程序）：</li>
                    <li>
                        <div class="radio-div">
                           <select name="accuracyApplet">
                               <option value="1"  <c:if test="${not empty pmShopInfo.accuracyApplet && pmShopInfo.accuracyApplet==1}">selected</c:if>>元</option>
                               <option value="2"  <c:if test="${empty pmShopInfo.accuracyApplet||pmShopInfo.accuracyApplet==2}">selected</c:if>>角</option>
                               <option value="3"  <c:if test="${not empty pmShopInfo.accuracyApplet && pmShopInfo.accuracyApplet==3}">selected</c:if>>分</option>
                           </select>
                        </div>
                    </li>
                </ul>

                <ul>
                    <li>四舍五入（收银端）：</li>
                    <li>
                        <div class="radio-div">
                            <input id="is-round-cash1" name="isRoundCash" type="radio" value="1" onclick="changeCashRound(1)"
                                   <c:if test="${not empty pmShopInfo.isRoundCash&&pmShopInfo.isRoundCash==1}">checked</c:if>/>
                            <label>支持</label>
                            <input id="is-round-cash2" name="isRoundCash" type="radio" value="0" onclick="changeCashRound(0)"
                                   <c:if test="${empty pmShopInfo.isRoundCash||pmShopInfo.isRoundCash==0}">checked</c:if>
                            />
                            <label>不支持</label>
                        </div>
                    </li>
                </ul>

                <ul id="accuracy-cash-ul"
                    <c:if test="${empty pmShopInfo.isRoundCash || pmShopInfo.isRoundCash == 0}">style="display: none" </c:if>
                >
                    <li>精确度（收银端）：</li>
                    <li>
                        <div class="radio-div">
                            <select name="accuracyCash">
                                <option value="1"  <c:if test="${not empty pmShopInfo.accuracyCash && pmShopInfo.accuracyCash==1}">selected</c:if>>元</option>
                                <option value="2"  <c:if test="${empty pmShopInfo.accuracyCash||pmShopInfo.accuracyCash==2}">selected</c:if>>角</option>
                                <option value="3"  <c:if test="${not empty pmShopInfo.accuracyCash && pmShopInfo.accuracyCash==3}">selected</c:if>>分</option>
                            </select>
                        </div>
                    </li>
                </ul>

                <ul>
                    <li>联系电话：</li>
                    <li>
                        <input id="customerPhone" required name="customerPhone" value="${pmShopInfo.customerPhone}" type="text" maxlength="11" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))">
                    </li>
                </ul>
                <ul>
                    <li>起始取餐号：</li>
                    <li>
                        <input id="startNumber" required name="startNumber" value="${pmShopInfo.startNumber}" type="text" maxlength="11" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))">
                    </li>
                </ul>
                <ul>
                    <li>门店取餐提醒：</li>
                    <li>
                        <div class="radio-div">
                            <input id="isTakeMeals1" name="isTakeMeals" type="radio" value="1"
                                   <c:if test="${not empty pmShopInfo.isTakeMeals&&pmShopInfo.isTakeMeals==1}">checked</c:if>/>
                            <label>是</label>
                            <input id="isTakeMeals2" name="isTakeMeals" type="radio" value="0"
                                   <c:if test="${empty pmShopInfo.isTakeMeals||pmShopInfo.isTakeMeals==0}">checked</c:if>
                            />
                            <label>否</label>
                        </div>
                    </li>
                </ul>
                <ul>
                    <li>小程序点餐开关：</li>
                    <li>
                        <div class="radio-div">
                            <input id="isMiniOrder1" name="isMiniOrder" type="radio" value="1"
                                   <c:if test="${not empty pmShopInfo.isMiniOrder&&pmShopInfo.isMiniOrder==1}">checked</c:if>/>
                            <label>关</label>
                            <input id="isMiniOrder2" name="isMiniOrder" type="radio" value="0"
                                   <c:if test="${empty pmShopInfo.isMiniOrder||pmShopInfo.isMiniOrder==0}">checked</c:if>
                            />
                            <label>开</label>
                        </div>
                    </li>
                </ul>
                <ul>
                    <li>门店坐标：</li>
                        <input id="longitude" name="longitude" value="${pmShopInfo.shopLongitude}" type="hidden" style="width: 132px;" >

                    <input id="latitude"   name="latitude" <c:if test="${!'add'.equals(flag)}">value="${pmShopInfo.shopLatitude}"</c:if> type="hidden" style="width: 132px;" >
                        <input type="button" id="map-control" value="坐标选位" onclick="openMap()" style="display: inline-block;margin-top: 5px;background: #69AC72;color: #ffffff;height: 30px;line-height: 30px;padding: 0 15px;border-radius: 4px;"/>
                    <%--地图盒子--%>
                    <div id="map-div" style="display: none;margin-left: 40px">
                        <div style="margin:5px" id="search-div">
                            <input style="width:200px;padding:3px 4px;" type="text" id="place" />
                            <button type="button" class="btn search-btn" onclick="searchKeyWord()">搜索</button>
                            <br><br>
                        </div>

                        <!--   定义地图显示容器   -->
                        <div id="map-container" style="width:100%;height:300px"></div>
                        <input style="width:200px;padding:3px 4px;" type="hidden" style="display: none" />
                    </div>
                </ul>

                <ul id="district-name-ul"
                        <c:if test="${pmShopInfo.districtName == null || ''.equals(mShopInfo.districtName)}">
                            style="display: none"
                        </c:if>
                >
                    <li>地区名称：</li>
                    <li>
                        <span id="district">${pmShopInfo.districtName},${pmShopInfo.shopLlAddress}</span>
                        <input id="districtName" name="districtName" class="hidden" value="${pmShopInfo.districtName}"></li>
                </ul>
                <ul id="contact-address-ul"
                        <c:if test="${pmShopInfo.contactAddress == null || ''.equals(mShopInfo.contactAddress)}">
                            style="display: none"
                        </c:if>
                >
                    <li>详细地址：</li>
                    <li>
                        <input required id="contactAddress" name="contactAddress" value="${pmShopInfo.contactAddress}" type="text" style="width: 400px;"></li>
                </ul>
            </div>

            <div class="fit-right">
                <ul>
                    <li>门店LOGO：</li>
                    <li>
                        <div class="img-btn">
                            <input type="hidden" name="shopLogo" id="shopLogo" value="${pmShopInfo.shopLogo}"  htmlEscape="false" maxlength="100" class="input-xlarge"/>
							<span class="help-inline" id="shopLogo"  style="color: blue;"></span>
							<tags:ckfinder input="shopLogo" type="images" uploadPath="/merchandise/ShopImg"/>
                        </div>
                    </li>
                </ul>
                <ul>
                    <li>门店背景图：</li>
                    <li>
                        <div class="img-btn">
		        			<input type="hidden" name="shopBanner" id="shopBanner" value="${pmShopInfo.shopBanner}"  htmlEscape="false" maxlength="100" class="input-xlarge"/>
							<span class="help-inline" id="shopBanner"  style="color: blue;"></span>
							<tags:ckfinder input="shopBanner" type="images" uploadPath="/merchandise/ShopImg"/>
		                </div>
                    </li>
                </ul>
                <ul>
                    <li>营业执照图：</li>
                    <li style="height: 211px;">
                        <div class="img-btn">
		        			<input type="hidden" name="businessCodeLogo" id="businessCodeLogo" value="${pmShopInfo.businessCodeLogo}"  htmlEscape="false" maxlength="100" class="input-xlarge"/>
							<span class="help-inline" id="businessCodeLogo"  style="color: blue;"></span>
							<tags:ckfinder input="businessCodeLogo" type="images" uploadPath="/merchandise/ShopImg"/>
		                </div>
                    </li>
                </ul>

                <input type="hidden" id="prompt" value="${prompt}"/>
                <ul class="lei-bie" >
                    <li>经营类别：</li>
                    <li>
                        <ul style="overflow-y: auto;height: 215px">
                        	<c:forEach items="${productTypes}" var="productType" varStatus="i">
	                            <li>
	                                <input value="${productType.id}" type="checkbox">
	                                <span>${productType.productTypeName}</span>
	                            </li>
                            </c:forEach>
                        </ul>
                    </li>
                </ul>
            </div>
            <div class="fit-btn">
	            <shiro:hasPermission name="merchandise:PmShopInfo:edit">
	            	<input type="button" style="    display: inline-block;
    margin-top: 5px;
    background: #69AC72;
    color: #ffffff;
    height: 30px;
    line-height: 30px;
    padding: 0 15px;
    border-radius: 5px;
    width: 90px;" onclick="addShopInfo()" value="保存"/>
                    <%--<input type="submit" value="保存" class="save">--%>
	            </shiro:hasPermission>

                <div style="display: inline-block">
                <c:if test="${'add'.equals(flag)}">
                    <a class="go-back" href="${ctxsys}/PmShopInfo" style=" background-color: white;
            color: #0C0C0C;">返回</a>
                </c:if>
                </div>
            </div>

            <!-- 模态框（Modal） -->
            <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                                &times;
                            </button>
                            <h4 class="modal-title" id="myModalLabel">
                                修改密码
                            </h4>
                        </div>
                        <div class="modal-body">
                            <form role="form" id="password-from" method="post" action="">
                                <div class="password">
                                    <label for="password">密码：</label>
                                    <input type="password" class="form-control" id="password" name="password" placeholder="请输入密码">
                                </div>
                                <div class="password">
                                    <label for="password">确认密码：</label>
                                    <input type="password" class="form-control" id="confirm-password" name="confirm-password" placeholder="请输入确认密码">
                                </div>
                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" id="submit-button" class="btn btn-primary">
                                确定
                            </button>
                            <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                            </button>
                            <script type="text/javascript">
                                $(function(){
                                    $("#submit-button").click(function(){

                                        if($("#password").val().trim() != $("#confirm-password").val().trim()){
                                            alert("确认密码和密码不一致！");
                                            return false;
                                        }


                                        $.ajax({
                                            url:"${ctxsys}/User/updatePassword",
                                            data:{"password":$("#password").val(),"shopId":$("#id").val()},
                                            dataType:"json",
                                            success:function(result){
                                                if(result == "1"){
                                                    alert("修改密码成功！");
                                                    $("#myModal").modal('hide');
                                                }else{
                                                    alert("修改密码失败！");
                                                    $("#myModal").modal('hide');
                                                }
                                            },
                                            error:function(){
                                                alert("修改密码失败！");
                                                $("#myModal").modal('hide');
                                            }
                                        });
                                    })

                                    $("#confirm-password").val("");
                                    $("#password").val("");
                                })

                            </script>
                        </div>
                    </div><!-- /.modal-content -->
                </div><!-- /.modal -->
            </div>

            <!-- 设置密码（Modal） -->
            <div class="modal fade" id="setPassword" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                                &times;
                            </button>
                            <h4 class="modal-title">
                                设置密码
                            </h4>
                        </div>
                        <div class="modal-body">
                            <form role="form"  method="post" action="">
                                <div class="password">
                                    <label for="password">密码：</label>
                                    <input type="password" class="form-control" id="password2" name="password" placeholder="请输入密码">
                                </div>
                                <div class="password">
                                    <label for="password">确认密码：</label>
                                    <input type="password" class="form-control" id="confirm-password2" name="confirm-password" placeholder="请输入确认密码">
                                </div>
                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                            </button>
                            <button type="button"  onclick="enterPassword()" class="btn btn-primary">
                                提交
                            </button>

                            <script type="text/javascript">
                                //把模态框的密码设置到页面的input
                                function enterPassword(){
                                    var password = $("#password2").val();
                                    var confirm = $("#confirm-password2").val();

                                    $("#setPassword").modal("hide");


                                    if(password == undefined || password == ""){
                                        alert("密码不能为空！");
                                        return false;
                                    }

                                    if(confirm == undefined || confirm == ""){
                                        alert("确认密码不能为空！");
                                        return false;
                                    }

                                    if(password != confirm){
                                        alert("确认密码和密码不一致！");
                                        return false;
                                    }


                                    $("#set-password-input").val(password);
                                }

                            </script>
                        </div>
                    </div><!-- /.modal-content -->
                </div><!-- /.modal -->
            </div>
            <!-- 抽点设置（Modal） -->
            <div class="modal fade" id="setRand" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                                &times;
                            </button>
                            <h4 class="modal-title">
                                抽点设置
                            </h4>
                        </div>
                        <div class="modal-body">
                            <form role="form"  method="post" action="">
                                <div  style="overflow: hidden;margin-top: 5px">
                                    <label style="float: left;line-height: 34px;">小程序订单（门店自取和外卖）：</label>
                                    <input style="float: left;line-height: 34px;width: 70px;" type="text" class="form-control" id="miniReturnRatio" name="miniReturnRatio"  value="0"/>
                                    <label style="float: left;line-height: 34px;">%</label></div>
                                <div  style="overflow: hidden;margin-top: 5px">
                                <label style="float: left;line-height: 34px;">线下门店支付订单：</label>
                                <input style="float: left;line-height: 34px;width: 70px;" type="text" class="form-control" id="shopReturnRatio" name="shopReturnRatio"  value="0"/>
                                    <label style="float: left;line-height: 34px;">%</label></div>
                                <div  style="overflow: hidden;margin-top: 5px">
                                <label style="float: left;line-height: 34px;">美团等平台订单：</label>
                                <input style="float: left;line-height: 34px;width: 70px;" type="text" class="form-control" id="otherReturnRatio" name="otherReturnRatio" value="0"/>
                                    <label style="float: left;line-height: 34px;">%</label></div>
                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                            </button>
                            <button type="button"  onclick="enterRand()" class="btn btn-primary">
                                提交
                            </button>

                            <script type="text/javascript">
                                //把模态框的密码设置到页面的input
                                function enterRand(){
                                    var miniReturnRatio = $("#miniReturnRatio").val();
                                    var shopReturnRatio = $("#shopReturnRatio").val();
                                    var otherReturnRatio = $("#otherReturnRatio").val();
                                    if(miniReturnRatio == undefined || miniReturnRatio == ""
                                    ||(miniReturnRatio<0||miniReturnRatio>100)){
                                        alert("小程序订单（门店自取和外卖）抽点不能为空，并且0<=抽点<=100！");
                                        return false;
                                    }

                                    if(shopReturnRatio == undefined || shopReturnRatio == ""
                                        ||(shopReturnRatio<0||shopReturnRatio>100)){
                                        alert("线下门店支付订单抽点不能为空，并且0<=抽点<=100！");
                                        return false;
                                    }

                                    if(otherReturnRatio == undefined || otherReturnRatio == ""
                                        ||(otherReturnRatio<0||otherReturnRatio>100)){
                                        alert("美团等平台订单抽点不能为空，并且0<=抽点<=100！");
                                        return false;
                                    }
                                    $("#set-miniReturnRatio-input").val(miniReturnRatio);
                                    $("#set-shopReturnRatio-input").val(shopReturnRatio);
                                    $("#set-otherReturnRatio-input").val(otherReturnRatio);
                                    $(".iRatio").html( "小程序<font color='blue'>"+miniReturnRatio+"%</font>    线下门店<font color='blue'>"+shopReturnRatio+"%</font>    美团等平台<font color='blue'>"+otherReturnRatio+"%</font>");
                                    $("#setRand").modal("hide");
                                }

                            </script>
                        </div>
                    </div><!-- /.modal-content -->
                </div><!-- /.modal -->
            </div>
            <!-- 抽点修改（Modal） -->
            <div class="modal fade" id="setRand1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                                &times;
                            </button>
                            <h4 class="modal-title">
                                抽点修改
                            </h4>
                        </div>
                        <div class="modal-body">
                            <form role="form" method="post" action="">
                                <div style="overflow: hidden;margin-top: 5px">
                                    <label style="float: left;line-height: 34px;">小程序订单（门店自取和外卖）：</label>
                                    <input type="text"  style="float: left; width: 70px;" class="form-control" id="miniReturnRatio1" name="miniReturnRatio1" value="${pmShopInfo.miniReturnRatio}"/>
                                    <label style="float: left;line-height: 34px;">%</label> </div>
                                <div style="overflow: hidden;margin-top: 5px">
                                    <label style="float: left;line-height: 34px;">线下门店支付订单：</label>
                                    <input  style="float: left; width: 70px;" type="text" class="form-control" id="shopReturnRatio1" name="shopReturnRatio1" value="${pmShopInfo.shopReturnRatio}"/>
                                    <label style="float: left;line-height: 34px;">%</label></div>
                                <div style="overflow: hidden;margin-top: 5px">
                                    <label style="float: left;line-height: 34px;">美团等平台订单：</label>
                                    <input style="float: left; width: 70px;" type="text" class="form-control" id="otherReturnRatio1" name="otherReturnRatio1"value="${pmShopInfo.otherReturnRatio}"/>
                                    <label style="float: left;line-height: 34px;">%</label>
                                </div>
                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" id="setRand1-button" class="btn btn-primary">
                                确定
                            </button>
                            <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                            </button>
                            <script type="text/javascript">
                                $(function(){
                                    $("#setRand1-button").click(function(){

                                        var miniReturnRatio = $("#miniReturnRatio1").val();
                                        var shopReturnRatio = $("#shopReturnRatio1").val();
                                        var otherReturnRatio = $("#otherReturnRatio1").val();
                                        if(miniReturnRatio == undefined || miniReturnRatio == ""
                                            ||(miniReturnRatio<0||miniReturnRatio>100)){
                                            alert("小程序订单（门店自取和外卖）抽点不能为空，并且0<=抽点<=100！");
                                            return false;
                                        }

                                        if(shopReturnRatio == undefined || shopReturnRatio == ""
                                            ||(shopReturnRatio<0||shopReturnRatio>100)){
                                            alert("线下门店支付订单抽点不能为空，并且0<=抽点<=100！");
                                            return false;
                                        }

                                        if(otherReturnRatio == undefined || otherReturnRatio == ""
                                            ||(otherReturnRatio<0||otherReturnRatio>100)){
                                            alert("美团等平台订单抽点不能为空，并且0<=抽点<=100！");
                                            return false;
                                        }


                                        $.ajax({
                                            url:"${ctxsys}/PmShopInfo/updateReturnRatio",
                                            data:{miniReturnRatio:miniReturnRatio,
                                                shopReturnRatio:shopReturnRatio,
                                                otherReturnRatio:otherReturnRatio,
                                                shopId:$("#id").val()},
                                            dataType:"json",
                                            success:function(result){
                                                if(result.code==00){
                                                    alert("修改抽点成功！");
                                                    $("#setRand1").modal('hide');
                                                    $(".iRatio").html( "小程序<font color='blue'>"+miniReturnRatio+"%</font>    线下门店<font color='blue'>"+shopReturnRatio+"%</font>    美团等平台<font color='blue'>"+otherReturnRatio+"%</font>");
                                                }else{
                                                    alert("修改抽点失败！");
                                                }
                                            },
                                            error:function(){
                                                alert("修改抽点失败！");
                                            }
                                        });
                                    })

                                })

                            </script>
                        </div>
                    </div><!-- /.modal-content -->
                </div><!-- /.modal -->
            </div>

        </div>
      </form>
    </div>
<div class="tii">
	<span class="tii-img"></span>
	<span class="message" data-tid="${message}">${message}</span>
</div>

<div class="fixed-img">
</div>




</body>
<%--<link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">--%>
<%--<script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>--%>
<%--<script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>--%>
<script type="text/javascript">

    $(function () {
        var arr = [ "增加门店成功"," 账号已存在"];
        if('${prompt}' != "" ){
            var index = parseInt('${prompt}');
            alert(arr[index])
        }

        if("add" == '${flag}'){
            $("#latitude").attr("value","39.910925");
            $("#longitude").attr("value","116.413384");
        }

    })

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
</html>