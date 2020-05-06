<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0,minimal-ui">
    <title>${'add'.equals(flag) ? '增加代理商':'修改代理商'}</title>
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/admin-store-msg.css">
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/bootstrap.min.css">
    <link type="text/css" rel="stylesheet" href="${ctxStatic}/common/jqsite.min.css">
    <link rel="stylesheet" href="${ctxStatic}/tii/tii.css">
    <link rel="stylesheet" href="${ctxStatic}/h5/css/timePicker.css">
    <link href="${ctxStatic}/supplyshop/layui/css/modules/layer/default/layer.css?v=1" type="text/css" rel="stylesheet"/>


    <script src="${ctxStatic}/sbShop/js/jquery.min.js"></script>
    <script src="${ctxStatic}/sbShop/js/jquery.validate.min.js"></script>
    <script src="${ctxStatic}/jquery-validation/1.11.1/jquery.validate.method.js"></script>
    <script src="${ctxStatic}/bootstrap/2.3.1/docs/assets/js/bootstrap-modal.js"></script>
    <script type="text/javascript" src="${ctxStatic}/h5/js/jquery-timepicker.js"></script>
    <script type="text/javascript" src="${ctxStatic}/common/mustache.min.js"></script>
    <script type="text/javascript" src="${ctxStatic}/common/jqsite.min.js"></script>
    <script type="text/javascript" src="${ctxStatic}/ckeditor/ckeditor.js"></script>
    <script type="text/javascript" src="${ctxStatic}/ckfinder/ckfinder.js"></script>

    <script src="${ctxStatic}/supplyshop/layui/lay/modules/layer.js?v=1" type="text/javascript"></script>
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

        .fit-right .img-btn a{
            margin-left: 20px;
        }

        .shop-control-btn{
            display: inline-block;
            margin-top: 5px;
            background: #69AC72;
            color: #ffffff;
            height: 30px;
            line-height: 30px;
            padding: 0 15px;
            border-radius: 4px;
        }

        .shop-control-btn:hover,.shop-control-btn:active{
            display: inline-block;
            margin-top: 5px;
            background: #69AC72;
            color: #ffffff;
            height: 30px;
            line-height: 30px;
            padding: 0 15px;
            border-radius: 4px;
        }

        .shop-control-div textarea{
            border-radius: 10px;
        }

        .fit-btn .save{
            display: inline-block;
            height: 30px;
            line-height: 30px;
            background: #69AC72;
            color: #ffffff;
            border-radius: 5px;
            width: 90px;
        }

        .info-error{
            padding-left: 20px;
            color: red;
        }
    </style>

    <script type="text/javascript">
        $().ready(function() {
            // 在键盘按下并释放及提交后验证提交表单
            $("#agent-info-form").validate({
                messages: {
                    agentCode: {
                        required:"请输入名称",
                        maxlength:"账号长度不能超过16"
                    },
                    password:{
                        required:"请输入密码",
                        minlength:"密码不能少于6位",
                        maxlength:"密码不能多于24位"
                    },
                    agentName:{
                        required:"请输入代理商名称",
                        maxlength:"代理商名称不能多于50"
                    },
                    mobilePhone:{
                        required:"请输入联系电话",
                        phone:"请输入正确的联系方式"
                    },
                    remark:"简介不能超过450个字"

                },
                errorClass:"info-error"
            })
        });
    </script>
</head>
<body>
<div class="fitment">
    <ul class="nav-ul">
        <c:if test="${!'add'.equals(flag)}">
            <li><a class="active"  href="${ctxsys}/pmAgent/form?agentId=${pmAgent.id}">修改代理商</a></li>
        </c:if>
        <c:if test="${'add'.equals(flag)}">
            <li><a class="active"  href="${ctxsys}/pmAgent/form?agentId=${pmAgent.id}&flag=add">增加代理商</a></li>
        </c:if>
    </ul>


    <form class="form-horizontal" id="agent-info-form"

          <c:if test="${'add'.equals(flag)}">action="${ctxsys}/pmAgent/insert"</c:if>
          <c:if test="${!'add'.equals(flag)}">action="${ctxsys}/pmAgent/update"</c:if> method="post" name="form2">

        <c:if test="${!'add'.equals(flag)}">
            <input type="hidden" id="id" name="id" value="${pmAgent.id}"/>
        </c:if>

        <div class="fit-box">
            <input type="hidden" id="flag" value="${flag}">
            <div class="fit-left">
                <ul>
                    <li><b>*</b>账号：</li>
                    <li><input id="agent-code" required maxlength="16" <c:if test="${!'add'.equals(flag)}">readonly</c:if> name="agentCode" value="${pmAgent.agentCode}" type="text"></li>
                </ul>
                <c:if test="${!'add'.equals(flag)}">
                    <ul>
                        <li>修改密码：</li>
                        <li>
                            <input type="button" style="background-color:rgb(106,172,114);padding:0px;width: 60px;height: 30px;margin-left: 0px;font-size:14px;line-height: 30px" value="修改密码" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#setPassword"/>
                        </li>
                        <li>
                            <input type="text" style="width: 1px;height: 0px;border: 0px solid #fff;background: rgba(250,250,250,0.2)" id="set-password-input" name="password"  value="" minlength="6" maxlength="24"/>
                        </li>
                    </ul>
                </c:if>

                <c:if test="${'add'.equals(flag)}">
                    <ul>
                        <li>设置密码：</li>
                        <li>
                            <input type="button" style="background-color:rgb(106,172,114);padding:0px;width: 60px;height: 30px;margin-left: 0px;font-size:14px;line-height: 30px" value="设置密码" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#setPassword"/>
                        </li>
                        <li>
                            <input type="text" style="width: 1px;height: 0px;border: 0px solid #fff;background: rgba(250,250,250,0.2)" id="set-password-input" name="password" required minlength="6" maxlength="24"/>
                        </li>
                    </ul>
                </c:if>

                <%--<input type="password" style="width: 1px;height: 0px;border: 0px solid #fff;background: rgba(250,250,250,0.2)" id="set-password-input" name="password" required minlength="6" maxlength="24"/>--%>
                <ul>
                    <li>名称：</li>
                    <li><input id="shopName" required maxlength="50" name="agentName" value="${pmAgent.agentName}" type="text"></li>
                </ul>

                <ul>
                    <li>简介：</li>
                    <li>
                        <textarea id="remarkDesc" maxlength="450" placeholder="最多输入450个字" onchange="this.value=this.value.substring(0, 450)" onkeydown="this.value=this.value.substring(0, 450)" onkeyup="this.value=this.value.substring(0, 450)"
                                  cols="18" rows="27" name="remark" style="padding-left: 5px;padding-right: 5px">${pmAgent.remark}</textarea>
                    </li>
                </ul>

                <ul style="display: none">
                    <li>在线状态：</li>
                    <li>
                        <div class="radio-div">
                            <c:choose>
                                <c:when test="${pmAgent.onlineStatus==0}">
                                    <input id="xian1" name="onlineStatus" type="radio" value="1">
                                    <label for="xian1">在线</label>
                                    <input id="yin1" name="onlineStatus" type="radio" value="0" checked>
                                    <label for="yin1">不在线</label>

                                </c:when>
                                <c:otherwise>
                                    <input id="xian1" name="onlineStatus" type="radio" value="1" checked>
                                    <label for="xian1">在线</label>
                                    <input id="yin1" name="onlineStatus" type="radio" value="0">
                                    <label for="yin1">不在线</label>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </li>
                </ul>

                <ul>
                    <li>联系电话：</li>
                    <li>
                        <input id="customerPhone" required class="phone" name="mobilePhone" value="${pmAgent.mobilePhone}" type="text" maxlength="11" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))">
                    </li>
                </ul>
                <ul>
                    <li>地区名称：</li>
                    <li>
                        <span id="district">${pmAgent.districtName}</span>
                        <input id="districtName" name="districtName" class="hidden" value="${pmAgent.districtName}"></li>
                </ul>
                <ul>
                    <li>详细地址：</li>
                    <li>
                        <input  id="contactAddress" name="contactAddress" value="${pmAgent.contactAddress}" type="text" style="width: 408px;"></li>
                </ul>
                <ul>
                    <li>门店坐标：</li>
                    经度：<input id="longitude" name="longitude" value="${pmAgent.longitude}" type="text" style="width: 132px;" >

                    纬度：<input id="latitude"   name="latitude" value="${pmAgent.latitude}" type="text" style="width: 132px;" >
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
                        <%--<iframe id="iframe_map" width="100%" height="300" frameborder="0" scrolling="no" style="display: none;"></iframe>--%>
                    </div>
                    <%--<iframe id="iframe_map" width="100%" height="300" frameborder="0" scrolling="no" style="display: none;"></iframe>--%>
                </ul>

            </div>
            <div class="fit-right">
                <ul>
                    <li>管理门店：</li>
                    <li>
                        <div class="shop-div">
                            <input type="hidden" value="${pmAgent.shopIds}" name="shopIds" id="shop-ids"/>
                            <textarea id="shop-names"  readonly cols="45" rows="5" name="shopNames" style="padding-left: 5px;padding-right: 5px">${pmAgent.shopNames}</textarea>
                            <div class="shop-control-div">
                                <a class="btn btn-primary shop-control-btn" onclick="insertShop()" href="javascript:;">添加</a>
                                <a class="btn btn-primary shop-control-btn" onclick="clearShop()" href="javascript:;">清空</a>
                            </div>
                        </div>
                    </li>
                </ul>
            </div>
            <div class="fit-btn">
                <shiro:hasPermission name="merchandise:PmShopInfo:edit">
                    <input type="submit" value="保存" class="save"/>
                    <%--<input type="submit" value="保存" class="save">--%>
                </shiro:hasPermission>

                <div style="display: inline-block">
                    <c:if test="${'add'.equals(flag)}">
                        <a class="go-back" href="javascript:;" onclick="history.go(-1)" style=" background-color: white;
            color: #0C0C0C;">返回</a>
                    </c:if>
                </div>
            </div>

        </div>
    </form>


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

</div>
<script type="text/javascript">
    if("${message}" != ""){
        layer.confirm("${message}",{title:"提示"})
    }
</script>
<script type="text/javascript">

    function insertShop(){
        var content;
        var shopName;
        layer.open({
            type: 2,
            title: '门店列表',
            shadeClose: true,
            shade: false,
            maxmin: true, //开启最大化最小化按钮
            area: ['880px', '450px'],
            content: '${ctxsys}/pmAgent/chooseShops?chooseIds='+$("#shop-ids").val()+"&agentId=${pmAgent.id}",
            btn: ['确定', '关闭'],
            yes: function(index, layero){ //或者使用btn1
                content = layero.find("iframe")[0].contentWindow.$('#chooseIds').val();
                shopName = layero.find("iframe")[0].contentWindow.$('#chooseNames').val();

                $("#shop-ids").val(content);
                $("#shop-names").val(shopName);
                layer.close(index);
            }
        });
    }

    function clearShop(){
        $("shop-ids").val("")
        $("shop-names").val("")
    }
</script>
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
        <%--var arr = [ "增加门店成功"," 增加门店失败",  " 用户不存在 " , "增加门店失败 " , " 账号为空"];--%>
        <%--if('${prompt}' != "" ){--%>
        <%--var index = parseInt('${prompt}');--%>
        <%--alert(arr[index])--%>
        <%--}--%>

        if("add" == '${flag}'){
            $("#latitude").attr("value","39.910925");
            $("#longitude").attr("value","116.413384");
        }

        // $("#latitude").val("");
        // $("#longitude").val("");;
        // $("#example").modal({show:false});
    })

</script>
</html>