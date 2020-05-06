<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>发布商品</title>
<link rel="stylesheet"
	href="${ctxStatic}/commodity/css/commodity-details.css?v=1">
<link rel="stylesheet" href="${ctxStatic}/sbShop/css/bootstrap.min.css">
<link rel="stylesheet" href="${ctxStatic}/sbShop/css/build.css">
<script src="${ctxStatic}/sbShop/js/jquery.min.js?v=3"
	type="text/javascript"></script>
<script src="${ctxStatic}/sbShop/js/base_form.js?v=13"
	type="text/javascript"></script>
<link
	href="${ctxStatic}/supplyshop/layui/css/modules/layer/default/layer.css?v=1"
	type="text/css" rel="stylesheet" />
<script src="${ctxStatic}/supplyshop/layui/lay/modules/layer.js?v=1"
	type="text/javascript"></script>
<script src="${ctxStatic}/sbShop/layui/layui.js" type="text/javascript"></script>

<script src="${ctxStatic}/commodity/js/release-comm-step.js?v=721"
	type="text/javascript"></script>
<script src="${ctxStatic}/jquery/jquery-migrate-1.1.1.min.js"
	type="text/javascript"></script>
<script type="text/javascript" src="${ctxStatic}/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="${ctxStatic}/ckfinder/ckfinder.js"></script>
<script src="${ctxStatic}/bootstrap/2.3.1/js/bootstrap.min.js"
	type="text/javascript"></script>
<script src="${ctxStatic}/My97DatePicker/WdatePicker.js"
	type="text/javascript"></script>
<script src="${ctxStatic}/common/mustache.min.js" type="text/javascript"></script>
<link href="${ctxStatic}/common/jqsite.min.css" type="text/css"
	rel="stylesheet" />
<script src="${ctxStatic}/common/jqsite.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/ueditor/ueditor.config.js"
	type="text/javascript"></script>
<script src="${ctxStatic}/ueditor/ueditor.all.js" type="text/javascript"></script>
<style type="text/css">
body .btn {
	background: #69AC72;
	color: #fff;
	padding: 3px 12px;
	margin-right: 10px;
}

.logistics-li>.radio>input {
	top: 4px;
	left: 5px
}

.shop-news select {
	margin-bottom: 10px;
}

.shop-pic {
	margin-bottom: 25px;
}

.shop-pic ol {
	overflow: hidden;
}

.shop-pic ol li {
	float: left
}

.maijia-ul input[type=radio] {
	top: 4px
}

.maijia-ul li {
	margin-bottom: 10px
}

.shop-pic .btn {
	margin-bottom: 20px;
}

body .shop-news ul {
	padding-bottom: 0
}

.shop-news select:nth-child(4) {
	margin-left: 68px;
}

.radio-div {
	display: inline-block
}
</style>
<style type="text/css">
/*运动的球效果*/
.run-ball-box {
	text-align: center;
	position: fixed;
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	background: rgba(0, 0, 0, 0.3);
	color: #ffffff;
	z-index: 100000000;
}

.run-ball {
	background-color: #69AC72;
	width: 60px;
	height: 60px;
	border-radius: 100%;
	-webkit-animation: sk-innerCircle 1s linear infinite;
	-moz-animation: sk-innerCircle 1s linear infinite;
	-o-animation: sk-innerCircle 1s linear infinite;
	animation: sk-innerCircle 1s linear infinite;
	position: absolute;
	top: 50%;
	left: 50%;
	margin-top: -30px;
	margin-left: -30px;
}

.sh-ju {
	position: absolute;
	top: 50%;
	left: 50%;
	margin-top: 50px;
	margin-left: -36px;
}

.run-ball .sk-inner-circle {
	display: block;
	background-color: #fff;
	width: 25%;
	height: 25%;
	position: absolute;
	border-radius: 100%;
	top: 5px;
	left: 5px;
}

@
-webkit-keyframes sk-innerCircle { 0% {
	-webkit-transform: rotate(0deg);
}

100%
{
-webkit-transform




:


 


rotate




(360
deg


);
}
}
@
-moz-keyframes sk-innerCircle { 0% {
	-moz-transform: rotate(0deg);
}

100%
{
-moz-transform




:


 


rotate




(360
deg


);
}
}
@
-o-keyframes sk-innerCircle { 0% {
	-o-transform: rotate(0deg);
}

100%
{
-o-transform




:


 


rotate




(360
deg


);
}
}
@
keyframes sk-innerCircle { 0% {
	transform: rotate(0deg);
}

100%
{
transform




:


 


rotate




(360
deg


);
}
}
.sb-xian {
	padding-bottom: 20px;
	background: #ffffff;
	clear: both;
	margin-bottom: 20px
}

.sb-xian>p {
	height: 35px;
	line-height: 35px;
	background: #F0F0F0;
	color: #4B4B4B;
	padding-left: 25px
}

.sb-xian .checkbox {
	display: inline-block
}

.sb-xian>ul {
	display: none
}

.sb-xian ul li {
	margin-bottom: 15px;
}

.sb-xian .checkbox i {
	top: 4px;
	left: -19px
}

.sb-xian ul li:nth-child(1)>span {
	position: relative;
	top: -9px
}

.sb-xian ul li>span {
	display: inline-block;
	width: 100px;
	text-align: right;
	margin-right: 10px;
	height: 30px;
	line-height: 30px
}

.sb-xian input[type=text] {
	outline: none;
	border: 1px solid #DCDCDC;
	padding: 0 10px;
	height: 30px;
}

.sb-xian ul li:nth-child(2) input {
	width: 150px;
}

.sb-xian ul li:nth-child(3) input {
	width: 60px;
	text-align: center;
	margin-right: 15px;
}

.sb-xian ul li:nth-child(4) input {
	width: 60px;
	text-align: center;
	margin-right: 15px;
}

.sb-xian-b b {
	display: inline-block;
	width: 100px;
	font-weight: normal;
	text-align: right;
	margin-right: 10px;
}

.sb-xian-b {
	padding-bottom: 15px;
	margin-bottom: 20px;
	border-bottom: 1px solid #CCCCCC
}

.sb-xian b {
	font-weight: normal
}

.norm {
	display: inline-block;
	position: relative
}

.norm>span {
	display: block;
	cursor: pointer;
	width: 200px;
	height: 30px;
	line-height: 30px;
	border: 1px solid #DCDCDC;
	padding-left: 10px;
	padding-right: 30px;
	background: url("../images/zhankai1.png") no-repeat 179px 11px;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
	word-wrap: break-word
}

.norm-box {
	position: absolute;
	width: 350px;
	display: none
}

.norm-box ul {
	width: 100%;
	border: 1px solid #DCDCDC;
	overflow: hidden
}

.norm-box ul:nth-child(1) {
	background: #f0f0f0;
	text-align: center;
	height: 30px;
}

.norm-box ul li:nth-child(1) {
	width: 60%;
	text-align: center
}

.norm-box ul li:nth-child(2) {
	width: 20%;
	text-align: center
}

.norm-box ul li:nth-child(3) {
	width: 20%;
	text-align: center
}

.norm-box ul li {
	margin-bottom: 0;
	float: left;
	line-height: 30px;
}

.norm-box ul {
	background: #ffffff;
	margin-bottom: 0;
}

.norm-box ul li {
	text-align: center;
	height: 30px;
	border-right: 1px solid #DCDCDC;
	color: #666666;
	cursor: pointer
}

.pic-list {
	padding-left: 25px;
}

#productChargingIds {
	outline: none;
	border: 1px solid #DCDCDC;
	padding: 0 10px;
	height: 30px;
	border-radius: 4px;
	width: 65%;
	margin-top: 10px;
}

.product-charging-table {
	margin-top: 20px;
	margin-bottom: 10px;
	width: 80%;
	font-weight: normal;
}

/*.product-charging-table tbody , .product-charging-table tr{*/
/*display: inline-block;*/
/*width: 100%;*/
/*}*/
.product-charging-table td, .product-charging-table th {
	padding: 2px 20px;
	text-align: center;
}

.guige-div ul li {
	float: left;
	width: 266px;
	margin-right: 10px;
}

.guige-div {
	margin-top: 70px;
	margin-left: 25px;
}

.guige-div h5 {
	line-height: 35px;
}

.choose-price ul li {
	float: left;
	margin-right: 30px;
}

#setting {
	width: 60px;
	height: 30px;
	background: #000;
	color: #fff;
	border: 0;
	border-radius: 3px;
	outline: none;
	padding: 0;
}

#price1, #price2, #price3 {
	width: 170px;
	height: 30px;
	border-radius: 2px;
	border: 1px solid #e5e5e5;
	text-indent: 10px;
}

.choose-price ul {
	margin-left: 25px;
}

.guige-div ul li label, .choose-price ul li label {
	width: 70px;
	text-align: right;
	margin-right: 10px;
}

.select {
	width: 160px;
	height: 30px;
}
</style>



</head>
<body style="background: #E3E4E5">
	<div class="run-ball-box">
		<div class="run-ball">
			<span class="sk-inner-circle"></span>
		</div>
		<div class="sh-ju">数据加载中...</div>
	</div>
	<div>
		<div class="head-nav">
			<ul class="nav-ul">
				<shiro:hasPermission name="merchandise:pro:view">
					<c:if test="${not empty  ebProduct.productId}">
						<li><a
							href="${ctxsys}/Product/show?productId=${ebProduct.productId}">商品概览</a></li>
					</c:if>
				</shiro:hasPermission>
				<shiro:hasPermission name="merchandise:pro:edit">
					<li><a class="active"
						href="${ctxsys}/Product/form?productId=${ebProduct.productId}">商品${not empty ebProduct.productId?'修改':'添加'}</a></li>
				</shiro:hasPermission>
			</ul>
		</div>
		<div class="content1"></div>
		<script type="text/javascript">
        var contextPath="${ctxweb}";
        var ctxsysctxsys="${ctxsys}";
        function FreightTemList(shopId){
            if(shopId==null||shopId==''){
                shopId="${ebProduct.shopId}";
            }
            var FreightTem="${ebProduct.freightTempId}";
            $.ajax({
                type: "POST",
                url: "${ctxsys}/Product/jsonPmShopFreightTemList",
                data: {shopId:shopId},
                success: function(data){
                    var html="<option value=''>请选择物流模板</option>";
                    for(var i=0;i<data.length;i++){
                        if(data[i].id==FreightTem){
                            html+="<option value="+data[i].id+"  selected = 'selected' > "+data[i].templateName+"</option>";
                        }else{
                            html+="<option value="+data[i].id+"  > "+data[i].templateName+"</option>";
                        }
                    }
                    $(".FreightTem").html(html);
                }
            });
        }
        function litext(){
            var min="${fns:getDictValue('minRatio','gyconfig','')}";
            var max="${fns:getDictValue('maxRatio','gyconfig','')}";
            var text=$('.right-ul1 li:nth-child(1)');
            var html="";
            for(i=0;i<text.length;i++){
                var s=$(text[i]).text();
                html+="<th>"+s+"</th>";
            }
            html+="<th style='display:none'>市场价格（元）</th><th>本店价格（元）</th><th  style='display: none'>折扣比例（"+min+"%~"+max+"%）</th><th style='display: none'>结算价格（元）</th><th>会员价格（元）</th><th>库存数量</th>";
            $('thead').html(html);
            console.log($('.right-ul1').length)
            $('tfoot').html("<tr><td colspan="+$('.right-ul1').length+">批量设置</td><td style='display: none'><input class='num1 t-shi' type='text' data-did='1'></td><td><input class='num1 tt-ben' type='text' data-did='2'></td><td style='display: none'><input class='num1 tt-ran'  type='text' data-did='3'></td><td style='display: none'><input readonly class='num1 t-jie' type='text' data-did='4'></td><td><input class='num1 t-huiy' type='text' data-did='5'></td><td><input class='num1' type='text' data-did='6'></td></tr>")
        }
        function qusb(aaa){
            var n = []; //一个新的临时数组
            for(var i = 0; i < aaa.length; i++){
                if (n.indexOf(aaa[i]) == -1) n.push(aaa[i]);
            }
            return n;
        }
        $(function(){
            if("${ebProduct.shopId}"!=null&&"${ebProduct.shopId}"!=''&&"${ebProduct.shopId}"!=undefined){
                fkent();
            }else{
                $("#shopTYpenamw").hide();
            }
            $("#type3").hide();
            $("#type2").hide();
            FreightTemList();
            if("${ebProduct.productTypeParentId}"!=null&&"${ebProduct.productTypeParentId}"!=''&&"${ebProduct.productTypeParentId}"!=undefined){
                fkeitType("${ebProduct.productTypeParentId}",'1',"${ebProduct.productTypeParent2Id}");
            }
            if("${ebProduct.productTypeParent2Id}"!=null&&"${ebProduct.productTypeParent2Id}"!=''&&"${ebProduct.productTypeParent2Id}"!=undefined){
                fkeitType("${ebProduct.productTypeParent2Id}",'2',"${ebProduct.productTypeId}");
            }
            var listtype="${pmProductTypes[0].id}";
            getTypeTow(listtype);
            var country="${ebProduct.country}";
            console.log(country);
            var provincesId="${ebProduct.provincesId}";
            var municipalId="${ebProduct.municipalId}";
            var area="${ebProduct.area}";
            if(country!=null&&country!=""){
                oneji(country);
                towji(country,1,provincesId);
                towji(provincesId,2,municipalId);
                towji(municipalId,3,area);
            }else{
                country=10000000;
                oneji(country);
            }
            $("#city").hide();
            $("#province").hide();
            $(".radio").change(function() {
                var $selectedvalue = $("input[name='li2']:checked").val();
                if ($selectedvalue == 1) {
                    $(".statendTo").show();
                    $("#shop-standard").hide();
                }else{
                    $("#shop-standard").show();
                    $(".statendTo").hide();
                }
            });



            //初始化单双规格
            var val_payPlatform =$("input[name='li2']:checked").val();
            if(val_payPlatform==1){
                $(".statendTo").show();
                $("#shop-standard").hide();
            }else{
                $("#shop-standard").show();
                $(".statendTo").hide();
            }


            //初始化计量类型
            // debugger;
            var measuringType =$("input[name='measuringType']:checked").val();
            if(measuringType==2){
                $(".measuring-unit-set").show();
                $(".detail-set").hide();
                $(".statendTo").show();
                $("#shop-standard").hide();
                //隐藏加料
                $(".product-charging-li").hide();
                $("#charging-tbody").empty();
            }else{
                $(".measuring-unit-set").hide();
                $(".detail-set").show();
            }

            //修改是进入
            var id="${ebProduct.productTypeId}";
            var shopId="${ebProduct.shopId}";
            // PingtaiType(shopId,id);
            getPingTow(id);
            if(id!=null&&id!=''){
                var idvs="${stands}";
                var idvsName="${standsName}";
                var idName=idvsName.split(";");
                var ids=idvs.split(";");
                var html="";
                var lesize="${lesize}";
                for(var i=0;i<lesize;i++){
                    if(ids[i]!=null&&ids[i]!=''){
                        var is= ids[i].split(":");
                        var isname= idName[i].split(":");
                        if(i==0){
                            var st1= qusb("${st1}".split(","));
                            html+="<ul class='right-ul1'>";
                            html+="<li>"+isname[0]+" <input type='hidden' value='"+is[0]+"'></li> <li>";
                            for(var j=0;j<st1.length;j++){
                                if(st1[j]!=null&&st1[j]!=""){
                                    var st1name=st1[j].split(":");
                                    html+="<span>"+st1name[1]+"<input type='hidden' name='attrId' value='"+st1name[0]+"'><b></b></span>";
                                }
                            }
                            html+="<a  href='javascript:;'><img src='${ctxStatic}/sbShop/images/add-a.png' alt=''></a></li></ul>";
                        }
                        if(i==1){
                            var st2= qusb("${st2}".split(","));
                            html+="<ul class='right-ul1'>";
                            html+="<li>"+isname[0]+" <input type='hidden' value='"+is[0]+"'></li> <li>";
                            for(var j=0;j<st2.length;j++){
                                if(st2[j]!=null&&st2[j]!=""){
                                    var st2name=st2[j].split(":");
                                    html+="<span>"+st2name[1]+"<input type='hidden' name='attrId' value='"+st2name[0]+"'><b></b></span>";
                                }
                            }
                            html+="<a  href='javascript:;'><img src='${ctxStatic}/sbShop/images/add-a.png' alt=''></a></li></ul>";
                        }
                        if(i==2){
                            var st3= qusb("${st3}".split(","));
                            html+="<ul class='right-ul1'>";
                            html+="<li>"+isname[0]+" <input type='hidden' value='"+is[0]+"'></li> <li>";
                            for(var j=0;j<st3.length;j++){
                                if(st3[j]!=null&&st3[j]!=""){
                                    var st3name=st3[j].split(":");
                                    html+="<span>"+st3name[1]+"<input type='hidden' name='attrId' value='"+st3name[0]+"'><b></b></span>";
                                }
                            }
                            html+="<a  href='javascript:;'><img src='${ctxStatic}/sbShop/images/add-a.png' alt=''></a></li></ul>";
                        }
                        if(i==3){
                            var st4= qusb("${st4}".split(","));
                            html+="<ul class='right-ul1'>";
                            html+="<li>"+isname[0]+" <input type='hidden' value='"+is[0]+"'></li> <li>";
                            for(var j=0;j<st4.length;j++){
                                if(st4[j]!=null&&st4[j]!=""){
                                    var st4name=st4[j].split(":");
                                    html+="<span>"+st4name[1]+"<input type='hidden' name='attrId' value='"+st4name[0]+"'><b></b></span>";
                                }
                            }
                            html+="<a  href='javascript:;'><img src='${ctxStatic}/sbShop/images/add-a.png' alt=''></a></li></ul>";
                        }
                    }
                }
                $("#ss").after(html);

                litext();
            }
        });
        function fkent(){
            $("#shopTYpenamw").show();
            $("#shopType1").hide();
            var advertiseTypeObjIds=$("#advertiseTypeObjIds").val();
            var type3=$("#type3").val();
            getPingTow(type3,advertiseTypeObjIds);
            FreightTemList(advertiseTypeObjIds);
            if(advertiseTypeObjIds==null||advertiseTypeObjIds==undefined){
                advertiseTypeObjIds="${ebProduct.shopId}";
            }
            var id="${ebProduct.productTypeParentId}";
            PingtaiType(advertiseTypeObjIds,id);
        }
        function PingtaiType(shopId,shopIdTyep){
            //加载分类范围
            var html="";
            html+="<option value=''> 请选择</option>";
            $.ajax({
                type: "POST",
                url: "${ctxsys}/Product/PmProductTypeId",
                data: {shopId:shopId},
                beforeSend:function(){
                    $(".run-ball-box").show();
                },success: function(data){
                    for(var i=0;i<data.length;i++){
                        if(data[i].id==shopIdTyep){
                            html+="<option value="+data[i].id+"  selected = 'selected' > "+data[i].productTypeName+"</option>";
                        }else{
                            html+="<option value="+data[i].id+"  > "+data[i].productTypeName+"</option>";
                        }

                    }
                    $("#type1").html(html);
                    $(".run-ball-box").hide();
                }
            });
        }
        function typeShop(shopId){
            var html="";
            $.ajax({
                type: "POST",
                url: "${ctxsys}/Product/shopType2",
                data: {shopTypeId:shopId},
                success: function(data){
                    if(data!=null&&data!=''&&data!=undefined){
                        $("#shopType1").show();
                        for(var i=0;i<data.length;i++){
                            html+="<option value="+data[i].id+"  > "+data[i].productTypeName+"</option>";
                        }
                        $("#shopType1").html(html);
                    }else{
                        $("#shopType1").hide();
                    }
                }
            });
        }
        function oneji(country){
            $.ajax({
                type: "POST",
                url: "${ctxsys}/Product/onejij",
                data: {},
                success: function(data){
                    if(country==10000000){
                        $("#province").hide();
                        $("#city").hide();
                        $("#area").hide();
                    }
                    var html="<option value=''>请选择国家</option>";
                    for(var i=0;i<data.length;i++){
                        if(data[i].id==country){
                            html+="<option value="+data[i].id+"  selected = 'selected' > "+data[i].districtName+"</option>";
                        }else{
                            html+="<option value="+data[i].id+"  > "+data[i].districtName+"</option>";
                        }
                    }
                    $("#nationality").html(html);
                }
            });
        }
        //加载平台类别
        function fkeitType(id,type,country){
            var html="";
            if(type=='1'){
                $("#type2").show();
                $("#type3").hide();
                html+="<option value=''>请选择二级类别</option>";
            }else{
                $("#type3").show();
                html+="<option value=''>请选择三级类别</option>";
            }
            $.ajax({
                type: "POST",
                url: "${ctxsys}/Product/tyeps",
                data: {id:id},
                success: function(data){
                    console.log(data);
                    for(var i=0;i<data.length;i++){
                        console.log(data[i].productTypeName);
                        if(data[i].id==country){
                            html+="<option value="+data[i].id+"  selected = 'selected' > "+data[i].productTypeName+"</option>";
                        }else{
                            html+="<option value="+data[i].id+" > "+data[i].productTypeName+"</option>";
                        }
                    }
                    if(type=='1'){
                        $("#type2").html(html);
                    }else{
                        $("#type3").html(html);
                    }
                }
            });
        }
        function towji(id,type,nextId){
            $.ajax({
                type: "POST",
                url: "${ctxsys}/Product/towjij",
                data: {id:id},
                success: function(data){
                    if(type=='1'){
                        var html="<option value=''>请选择省</option>";
                        if(data==undefined || data=="" || data==null){
                            $("#province").hide();
                        }else{
                            $("#province").show();
                        }
                    }else if(type=='2'){
                        var html="<option value=''>请选择市</option>";
                        if(data==undefined || data=="" || data==null){
                            $("#city").hide();
                        }else{
                            $("#city").show();
                        }
                    }else{
                        var html="<option value=''>请选择区</option>";
                        if(data==undefined || data=="" || data==null){
                            $("#area").hide();
                        }else{
                            $("#area").show();
                        }
                    }
                    for(var i=0;i<data.length;i++){
                        if(nextId==data[i].id){
                            html+="<option value="+data[i].id+" selected = 'selected'> "+data[i].districtName+"</option>";
                        }else{
                            html+="<option value="+data[i].id+"> "+data[i].districtName+"</option>";
                        }
                    }
                    if(type=='1'){
                        $("#province").html(html);
                    }else if(type=='2'){
                        $("#city").html(html);
                    }else{
                        $("#area").html(html);
                    }
                }
            });
        }
        //请求二三级类别
        function getTypeTow(typeId){
            $.ajax({
                type: "POST",
                url: "${ctxsys}/Product/productType",
                data: {id:typeId},
                success: function(data){
                    var html='';
                    for(var i=0;i<data.length;i++){
                        html+="<ul class='msg-ul'> <li>"+data[i].productTypeName+"</li><li><ul>";
                        for(var j=0;j<data[i].pmProductTypes.length;j++){
                            html+="<li><a href='javascript:;'' onclick='getPingTow("+data[i].pmProductTypes[j].id+")'>"+data[i].pmProductTypes[j].productTypeName+"</a></li>";
                        }
                        html+="</ul></li></ul>";
                    }
                    $("#msg-div").html(html);
                }
            });
        }
    function funp(id,name) {
		var index=$('#'+id).parent().index();
		console.log($(".right-ul1").length);
		for(var i=0;i<$(".right-ul1").length;i++){
		console.log($($('.right-ul1')[i]).find("li").eq(0).find("input").val());
		if($($('.right-ul1')[i]).find("li").eq(0).find("input").val()==name){
			var attrIds=$($('.right-ul1')[i]).find("input[name='attrId']");
			var op="<option value=''> 请选择</option>";
	    	for(j=0;j<attrIds.length;j++){
			   op+="<option value='"+$(attrIds[j]).val()+"'>"+$(attrIds[j]).parent().text()+"</option>";
		  }
		    $('#'+id).html(op);
		    break;
		 }
		}
	}

        function getPingTow(id,shopId){
            // $('.standard-right').html("<p id='ss'>编辑规格值：</p>");
            // $('.table-div').html("<p>编辑价格/库存</p><table border='1'><thead><tr><th></th><th style='display: none'>市场价格（元）</th><th>本店价格（元）</th><th style='display: none'>让利比例（%）</th><th style='display: none'>结算价格（元）</th><th>会员价格（元）</th><th>库存数量</th></tr></thead><tbody></tbody><tfoot class='tfoot'>" +
            //     "<tr>" +
            //     "<td colspan='1'>批量设置</td>" +
            //     "<td style='display: none'><input class='num1 t-shi' type='text' data-did='1'></td>" +
            //     "<td><input class='num1 tt-ben' type='text' data-did='2'></td>" +
            //     "<td style='display: none'><input class='num1 tt-ran' type='text' data-did='3'></td>" +
            //     "<td style='display: none'><input readonly='' class='num1 t-jie' type='text' data-did='4'></td>" +
            //     "<td><input class='num1 t-huiy' type='text' data-did='5'></td>" +
            //     "'<td><input class='num1' type='text' data-did='6'></td>" +
            //     "'</tr>" +
            //     "</tfoot>" +
            //     "</table>");
            $.ajax({
                type: "POST",
                url: "${ctxsys}/Product/productTypeId",
                data: {id:id},
                success: function(data){
                    $("#messyuyu").html(data.productTypeStr);
                }
            });
            $("#typeId").val(id);
            var options="";
            // var html="<ul><li></li><li>填错商品属性，可能会引起商品下架，影响您的正常销售，请认真准确填写</li></ul>";
            var html="<ul><li></li><li></li></ul>";
            //请求品牌
            $.ajax({
                type: "POST",
                url: "${ctxsys}/Product/productTypeBrand",
                data: {id:id},
                success: function(data){
                    html+="<ul><li>品牌：</li><li>";
                    html+="<select name='standarBraind_id'> <option value=''>请选择</option>";
                    var brandId="${ebProduct.brandId}";
                    for(var i=0;i<data.length;i++){
                        if(brandId==data[i].id){
                            html+=" <option value='"+data[i].id+"' selected = 'selected'>"+data[i].brandName+"</option>  ";
                        }else{
                            html+=" <option value='"+data[i].id+"'>"+data[i].brandName+"</option>  ";
                        }
                    }
                    html+="</select>";
                    html+="</li></ul>";
                    if(shopId==''||shopId==null){
                        shopId="${ebProduct.shopId}";
                    }
                    //按照分类请求规格
                    $.ajax({
                        type: "POST",
                        url: "${ctxsys}/Product/commerciale",
                        data: {id:id,shopId:shopId},
                        beforeSend:function(){
                            $(".run-ball-box").show();
                        },success: function(data){
                            var option='';
                            var spiltStr="${pmProductPropertyStandard.propertyStandardIdStr}";
                            if(spiltStr!=null&&spiltStr!=undefined){
                                var spil= spiltStr.split(';');
                            }
                            var a=0;
                            for(var i=0;i<data.length;i++){
                                if(data[i].spertAttrType=='2'){
                                    if(spil[a]!=null&&spil[a]!=undefined){
                                        var attr= spil[a].split(':');
                                        a++;
                                    }
                                    html+="<ul><li>"+data[i].spertAttrName+"：</li><input name='standard_id' type='hidden' value='"+data[i].id+"'/><li>";
                                    if(data[i].showType=='2'||data[i].showType=='3'){
                                        html+="<select name='standard_name'> <option value=''>请选择</option>";
                                        if(data[i].pmProductTypeSpertAttrValues!=null&&data[i].pmProductTypeSpertAttrValues.length>0){
                                            for(var j=0;j<data[i].pmProductTypeSpertAttrValues.length;j++){
                                                if(data[i].pmProductTypeSpertAttrValues!=null){
                                                    if(attr!=null){
                                                        if(attr[1]==data[i].pmProductTypeSpertAttrValues[j].id){
                                                            html+=" <option value='"+data[i].pmProductTypeSpertAttrValues[j].id+"' selected = 'selected'>"+data[i].pmProductTypeSpertAttrValues[j].spertAttrValue+"</option>  ";
                                                        }else{
                                                            html+=" <option value='"+data[i].pmProductTypeSpertAttrValues[j].id+"'>"+data[i].pmProductTypeSpertAttrValues[j].spertAttrValue+"</option>  ";
                                                        }
                                                    }else{
                                                        html+=" <option value='"+data[i].pmProductTypeSpertAttrValues[j].id+"'>"+data[i].pmProductTypeSpertAttrValues[j].spertAttrValue+"</option>  ";
                                                    }
                                                }
                                            }
                                        }
                                        html+="</select>";
                                    }
                                    if(data[i].showType=='1'){
                                        if(data[i].pmProductTypeSpertAttrValues!=null){
                                            html+="<input name='standard_name' type='hidden' value=''/>";
                                            for(var j=0;j<data[i].pmProductTypeSpertAttrValues.length;j++){
                                                if(attr!=null){
                                                    if(attr[1]==data[i].pmProductTypeSpertAttrValues[j].id){
                                                        html+=" <div class='radio-div'><input name='chu"+data[i].id+"' type='radio' checked='checked' value='"+data[i].pmProductTypeSpertAttrValues[j].id+"'><label>"+data[i].pmProductTypeSpertAttrValues[j].spertAttrValue+"</label></div>";
                                                    }else{
                                                        html+=" <div class='radio-div'><input name='chu"+data[i].id+"' type='radio' value='"+data[i].pmProductTypeSpertAttrValues[j].id+"'><label>"+data[i].pmProductTypeSpertAttrValues[j].spertAttrValue+"</label></div>";
                                                    }
                                                }else{
                                                    html+=" <div class='radio-div'><input name='chu"+data[i].id+"' type='radio' value='"+data[i].pmProductTypeSpertAttrValues[j].id+"'><label>"+data[i].pmProductTypeSpertAttrValues[j].spertAttrValue+"</label></div>";
                                                }
                                            }
                                        }
                                    }
                                    html+="</li></ul>";
                                    $("#product-property-div").html(html);

                                    <%--//添加增加门店标签--%>
                                    <%--var shopHtmlStr = "<ul>" +--%>
                                    <%--"<li>选择门店:</li>"+--%>
                                    <%--"<li>"+--%>
                                    <%--"<input type='radio' <c:if test='${isAllShop}'>checked</c:if> name='shopType' onclick='chooseShop(0)' class='shopType' value='0' >所有门店"+--%>
                                    <%--"<input type='radio' <c:if test='${!isAllShop}'>checked</c:if> name='shopType' onclick='chooseShop(1)' class='shopType' value='1' style='margin-left:10px;'>指定门店"+--%>
                                    <%--"</li>"+--%>
                                    <%--"</ul>";--%>
                                    <%--// $("#property-div").append(shopHtmlStr);--%>


                                    <%--//添加是否可外卖--%>
                                    <%--var takeOutHtmlStr = "<ul>" +--%>
                                    <%--"<li>是否可外卖:</li>"+--%>
                                    <%--"<li>"+--%>
                                    <%--"<input type='radio' name='isTakeOut' <c:if test='${ebProduct.isTakeOut != 0}'>checked</c:if> class='take-out' value='1'>支持"+--%>
                                    <%--"<input type='radio' name='isTakeOut' <c:if test='${ebProduct.isTakeOut == 0}'>checked</c:if> class='take-out' value='0' style='margin-left:10px;'>不支持"+--%>
                                    <%--"</li>"+--%>
                                    <%--"</ul>";--%>
                                    <%--// $("#property-div").append(takeOutHtmlStr);--%>

                                }else if(data[i].spertAttrType=='1'){
                                    var stru=0;
                                    var stand="${stands}";
                                    if(stand!=null){
                                        var stands= stand.split(';');
                                        for(var j=0;j<stands.length;j++){
                                            var standse= stands[j].split(':');
                                            if(standse[0]==data[i].id){
                                                stru++;
                                            }else{

                                            }
                                        }
                                    }

                                    if(stand==''||stand==null||stand==undefined){
                                        option+="<li class=''><input type='checkbox' value='"+data[i].id+"'><label>"+data[i].spertAttrName+"</label></li>";
                                    }else{
                                        if(stru>0){
                                            option+="<li class=''><input type='checkbox' checked='checked' value='"+data[i].id+"'><label>"+data[i].spertAttrName+"</label></li>";
                                        }else{
                                            option+="<li class=''><input type='checkbox' value='"+data[i].id+"'><label>"+data[i].spertAttrName+"</label></li>";
                                        }
                                    }
                                }

                            }
                            $(".run-ball-box").hide();
                            $("#add-stan").html(option);

/* debugger;
var addStanLi=$("#add-stan li"); */
for(var i=0;i<$("#add-stan li").length;i++){
	if($("#add-stan li").eq(i).find("input").is(':checked')){
		var index=$("#add-stan li").eq(i).index();
		var tteText = $("#add-stan li").eq(i).find("input").val();
		var text = $("#add-stan li").eq(i).find("label").text();
		var str = "";
		str ="<li style='margin-right: 10px'><input type='checkbox' value='" + tteText + "' id='guige-"+tteText+"' checked style='display:none;'>\
        	                 <label>" + text + ":</label>\
        	                 <select id='select"+tteText+"' at='"+$(".guige-div ul li").length+"' class='select'>\
        	                 <option value=''> 请选择</option>\
        	                 </select>\
        	            </li>";
		if ($(".guige-div ul li").length < 4) {
			$(".guige-div ul").append(str);	
	}
		funp('select'+tteText,tteText);
  }
}
                        }
                    });

                    //初始化加料
                    initCharging();
                    //初始化门店类型和是否外卖
                    initShopTypeAndTakeOut();
                }


            });

        }
        //买家付运费
        $('body').on('click','.logistics-li>div>input',function(){
            console.log($('.logistics-li:nth-child(2) ul')[0]);
            if ($('.maijia').attr('checked')&&$('.logistics-li:nth-child(2) ul')[0]==undefined){
                var shopId=$("#advertiseTypeObjIds").val();
                if(shopId==null||shopId==''){
                    shopId="${ebProduct.shopId}";
                }
                var s="";
                s+="<ul class='maijia-ul' style='display:none'><li><div class='radio-div'><input name='freightTempType' type='radio' value='1'><label>使用运费模板：</label>";
                s+="<select class='FreightTem' name='freightTempId'>";
                s+="</select>";
                s+="</div></li>  <li><div class='radio-div'> <input name='freightTempType' type='radio' value='2'>";
                s+="<label>快递</label><input type='text' name='freightTempMoney' value=''> <span>元</span> </div> </li></ul>  ";
                $('.logistics-li:nth-child(2)').append(s);
                FreightTemList(shopId);
            }else if(!$('.maijia').attr('checked')){
                $('.maijia-ul').remove();
            }
        });
        $(function(){
            var ReturnRatio=" ${ebProduct.returnRatio}";
            var minRatio="${fns:getDictValue('minRatio','gyconfig','')}";
            if($('.rang').is(':checked') ){
                $('.rang').siblings('label').html("折扣<input class='num ran' name='ReturnRatio' value='"+ReturnRatio+"' type='text'><span>%</span> <b>（折扣比范围<b class='ran1'>"+minRatio+"</b>%~<b class='ran2'>"+"${fns:getDictValue('maxRatio','gyconfig','')}"+"</b>%）</b>")
                $('.jiaspan').remove()
            }else {
                $('.rang').siblings('label').html("折扣 <span class='jiaspan'></span>  <span>%</span> <b>（折扣比范围<b class='ran1'>"+minRatio+"</b>%~<b class='ran2'>"+"${fns:getDictValue('maxRatio','gyconfig','')}"+"</b>%）</b>")
            }
            $('.rangli input[type=radio]').click(function(){
                var minRatio="${fns:getDictValue('minRatio','gyconfig','')}";
                if($('.rang').is(':checked') ){
                    $('.rang').siblings('label').html("折扣<input class='num ran' name='ReturnRatio' value='"+ReturnRatio+"'  type='text'><span>%</span> <b>（折扣比范围<b class='ran1'>"+minRatio+"</b>%~<b class='ran2'>"+"${fns:getDictValue('maxRatio','gyconfig','')}"+"</b>%）</b>")
                    $('.jiaspan').remove()
                }else {
                    $('.rang').siblings('label').html("折扣 <span class='jiaspan'></span>  <span>%</span> <b>（折扣比范围<b class='ran1'>"+minRatio+"</b>%~<b class='ran2'>"+"${fns:getDictValue('maxRatio','gyconfig','')}"+"</b>%）</b>")
                }
            });
        })
    </script>
		<form id="formId" action="${ctxsys}/Product/save" method="post">
			<div class="content2">

				<!--商品信息-->
				<div class="col-md-6 shop-news" style="height: 329px">
					<p>
						<font color="#69AC72">（1）</font>商品信息
					</p>
					<ul>
						<li><span>商品名称：</span> <input id="news1" class="input"
							name="productName" type="text" maxlength="40"
							value="${ebProduct.productName}"> <b>（不超过40字）</b></li>


						<li
							<c:if test="${!fns:isShowWeight()}">
                            style="display: none"
                    </c:if>>
							<%--<li style="display: none">--%> <span>计量类型：</span>
							<div class="radio-div">
								<input checked id="li2-1" name="measuringType"
									<c:if test="${empty ebProduct.measuringType || ebProduct.measuringType==1}">checked</c:if>
									type="radio" value="1"> <label for="li2-1">件</label>
							</div>
							<div class="radio-div">
								<input id="li2-2" name="measuringType"
									<c:if test="${not empty ebProduct.measuringType && ebProduct.measuringType==2}">checked</c:if>
									type="radio" value="2"> <label for="li2-2">重量</label>
							</div>
						</li>

						<li class="detail-set"><span>规格设置：</span>
							<div class="radio-div">
								<input checked id="li3-1" name="li2" type="radio"
									<c:if test="${empty  pmProductStandardDetails}"> checked="checked" </c:if>
									value="1"> <label for="li3-1">统一规格</label>
							</div>
							<div class="radio-div">
								<input id="li3-2" name="li2" type="radio"
									<c:if test="${not empty  pmProductStandardDetails}"> checked="checked" </c:if>
									value="2"> <label for="li3-2">多规格</label>
							</div></li>


						<li class="measuring-unit-set"
							<c:if test="${!fns:isShowWeight()}">
                        style="display:none"
                    </c:if>>
							<span>计量单位：</span>
							<div class="radio-div">
								<input id="li4-1" name="measuringUnit" type="radio"
									<c:if test="${empty ebProduct.measuringUnit || ebProduct.measuringUnit==1}">checked</c:if>
									value="1"> <label for="li4-1">公斤</label>
							</div>
							<div class="radio-div" style="display: none">
								<input id="li4-2" name="measuringUnit" type="radio"
									<c:if test="${not empty ebProduct.measuringUnit && ebProduct.measuringUnit==2}">checked</c:if>
									value="2"> <label for="li4-2">克</label>
							</div>

							<div class="radio-div" >
								<input id="li4-3" name="measuringUnit" type="radio"
									   <c:if test="${not empty ebProduct.measuringUnit && ebProduct.measuringUnit==3}">checked</c:if>
									   value="3"> <label for="li4-3">斤</label>
							</div>
						</li>


						<li style="display: none"><span>市场价格：</span> <input
							class="num1 input bshi" name="marketPrice" style="display: none"
							type="text" value="${ebProduct.marketPrice}"> <span>元</span>
							<b>（商品的成本卖价）</b></li>
						<li class="statendTo"><span>本店价格：</span> <input
							class="num1 input bend" name="sellPrice" type="text"
							value="${ebProduct.sellPrice}"> <span>元</span> <b>（商品在${fns:getProjectName()}平台上非会员的卖价）</b>
						</li>
						<li class="statendTo"><span>会员价格：</span> <input
							class="num1 input huiy" name="memberPrice" type="text"
							value="${ebProduct.memberPrice}"> <span>元</span> <b>（商品在${fns:getProjectName()}平台上非会员的卖价）</b>
						</li>
						<li class="rangli" style="display: none"><span>折扣比例：</span>
							<div class="radio-div">
								<input class="imo" checked name="li5" type="radio" value="1"
									<c:if test="${empty  ebProduct.returnRatio}"> checked="checked" </c:if>>
								<label>默认折扣比<span class="smo">0</span>%
								</label>
							</div>
							<div class="radio-div">
								<input class="rang" name="li5" type="radio" value="2"
									<c:if test="${not empty  ebProduct.returnRatio}"> checked="checked" </c:if>>
								<label> 折扣 <span class="jiaspan"></span> <%--  <input class="num1 ran" type="text" name="ReturnRatio" value="${ebProduct.returnRatio}"> --%>
									<span>%</span> <b>（折扣比范围<b class="ran1">${fns:getDictValue('minRatio','gyconfig','')}</b>%~<b
										class="ran2">${fns:getDictValue('maxRatio','gyconfig','')}</b>%）
								</b>
								</label>
							</div></li>
						<li style="display: none"><span>结算价格：</span> <input readonly
							class="num1 input jies" style="display: none" name="costPrice"
							type="text" value="${ebProduct.costPrice}"> <span>元</span>
							<b>（商品在${fns:getProjectName()}平台的结算价格）</b></li>
						<li class="statendTo"><span>库存数量：</span> <input
							class="num1 input" name="storeNums" type="text"
							value="${fns:replaceStoreNum(ebProduct.measuringType,ebProduct.measuringUnit,ebProduct.storeNums)}">
							<span>商家条形码：</span> <input class="num" type="text" name="barCode"
							value="${ebProduct.barCode}"></li>
						<li style="padding-bottom: 35px;"><span>商品简介：</span> <input
							class="input" name="productIntro" style="width: 65%;"
							maxlength="180" type="text" value="${ebProduct.productIntro}">
							<b>（不超过180字）</b></li>

						<li style="display: none"><span>所在地区：</span> <select
							id="nationality" name="country"
							onchange="towji(this.value,'1','')">
						</select> <select id="province" name="provincesId"
							onchange="towji(this.value,'2','')">
						</select> <select id="city" name="municipalId"
							onchange="towji(this.value,'3','')">
						</select> <select id="area" name="area">
						</select></li>
					</ul>
				</div>
				<input id="advertiseTypeObjIds" name="shopId" type="hidden"
					value="${ebProduct.shopId}" />
				<!--商品分类-->
				<div class="col-md-6 shop-classify" style="min-height: 329px">
					<p>
						<font color="#69AC72">（2）</font>商品分类
					</p>
					<div class="classify-div">
						<ul>
							<li><span>平台分类：</span></li>
							<li><select onchange="fkeitType(this.value,'1')" id="type1">
									<option value="" selected="selected">请选择</option>
									<%--   <c:forEach var="productTypes" items="${productTypes}">
                                  <option value="${productTypes.id}" <c:if test="${productTypes.id==ebProduct.productTypeParentId}"> selected="selected" </c:if>>${productTypes.productTypeName}</option>
                                  </c:forEach> --%>
							</select> <select id="type2" onchange="fkeitType(this.value,'2')">
									<option value="" selected="selected">请选择</option>
							</select> <select id="type3" name="type" onchange="getPingTow(this.value)">
									<option value="" selected="selected">请选择</option>
							</select></li>

							<li style="margin-top: 10px;">
								<%--<span>加料：</span>--%>
							</li>
							<li class="product-charging-li">
								<table class="product-charging-table" style="display: none">
									<tr>
										<th>加料名称</th>
										<th>标签名</th>
										<th>价格</th>
										<th>操作</th>
									</tr>
									<tbody id="charging-tbody">
										<c:forEach var="ebProductCharging"
											items="${ebProductChargingList}">
											<tr chargingId="${ebProductCharging.id}">
												<td style="display: none" class="old-charging-id">${ebProductCharging.id}</td>
												<td>${ebProductCharging.cName}</td>
												<td>${ebProductCharging.lable}</td>
												<td>${ebProductCharging.sellPrice}</td>
												<td style='cursor: pointer; color: #69AC72;'
													onclick="removeProductCharging(${ebProductCharging.id})">删除</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</li>
							<li class="product-charging-li" style="margin-top: 10px;"><a
								href="javascript:" onclick="addProductCharging()"
								class="btn product-charging-btn">添加</a> <a href="javascript:"
								onclick="clearProductCharging()"
								class="btn product-charging-btn">清空</a></li>

							<li><input type="hidden" class="input bend" readonly
								name="productChargingIds" id="productChargingIds" style=""></li>
						</ul>
						<ul style="display: none">
							<li><span>选择门店：</span></li>
							<li>
								<div class="xuan-img">
									<div style="width: 150px; height: 100px; overflow: hidden;">
										<img id="imgsvals" style="width: 100%"
											src="${ebProduct.pmShopInfo.shopwapBanner}" alt="" />
									</div>
									<p title="${ebProduct.shopName}" id="pnames"
										style="width: 150px; margin-top: 10px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; word-wrap: break-word;">${ebProduct.shopName }</p>
								</div> <a class="elecs-show btn" href="javascript:;">选择</a> <a
								class="btn" href="javascript:;" onclick="remoenpms()">清除</a>
							</li>
						</ul>
						<!--   <ul id="shopTYpenamw">
                          <li><span>门店分类：</span></li>
                          <li>
                              <select id="shopType" onchange="typeShop(this.value)">
                                  <option value="">请选择</option>

                              </select>
                              <select id="shopType1" name="pmshoprodic">
                                  <option value="">请选择</option>
                              </select>
                          </li>
                      </ul> -->
					</div>
				</div>
				<!--商品属性-->
				<div class="col-md-6 shop-property" style="margin-left: 0%;">
					<p>
						<font color="#69AC72">（3）</font>商品属性
					</p>
					<%--门店id--%>
					<input type="hidden" value="${shopIds}" name="shopIds" id="shopIds">
					<div class="property-div" id="property-div">
						<ul>
							<ul>
								<li>选择 门店:</li>
								<li><input type='radio' style="display: inline-block;"
									<c:if test='${isAllShop}'>checked</c:if> name='shopType'
									onclick='chooseShop(0)' class='shopType' value='0'><span
									style="display: inline-block; width: 60px">所有门店</span> <input
									type='radio' <c:if test='${!isAllShop}'>checked</c:if>
									name='shopType' onclick='chooseShop(1)' class='shopType'
									value='1' style='margin-left: 10px;'><span></span>指定门店<span></span></li>

							</ul>
							<ul id="shopNamesUl">
								<li>已选择门店:</li>
								<li style="width: auto"><input readonly
									class="form-control" style="height: 30px; border-radius: 5px;"
									type="text" id="shopNames" onclick="showShopName()"
									value="${shopNames}" /> <input class="btn"
									style="height: 30px; border-radius: 5px;" type="button"
									onclick="clearChooseShop()" value="清空" /></li>
							</ul>

							<!-- 模态框（Modal） -->
							<div class="modal fade" id="shop-name-modal" tabindex="-1"
								role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
								<div class="modal-dialog">
									<div class="modal-content">
										<div class="modal-header">
											<button type="button" class="close" data-dismiss="modal"
												aria-hidden="true">&times;</button>
											<h4 class="modal-title" id="myModalLabel">已选择的门店名</h4>
										</div>
										<div class="modal-body" id="choose-shop-name-div"
											style="height: 300px; overflow: auto">
											<%--<table class="table table-striped" id="shop-name-table">--%>

											<%--<tr>--%>
											<%--<th >序号</th>--%>
											<%--<th >门店名</th>--%>
											<%--</tr>--%>

											<%--</table>--%>
										</div>
										<div class="modal-footer">
											<button type="button" class="btn btn-default"
												data-dismiss="modal">关闭</button>
										</div>
									</div>
									<!-- /.modal-content -->
								</div>
								<!-- /.modal -->
							</div>

							<ul style="margin-top: 5px;">
								<li>是否可外卖:</li>
								<li><input type='radio' name='isTakeOut'
									<c:if test='${ebProduct.isTakeOut != 0}'>checked</c:if>
									class='take-out' value='1'><span
									style="display: inline-block; width: 60px">支持</span> <input
									type='radio' name='isTakeOut'
									<c:if test='${ebProduct.isTakeOut == 0}'>checked</c:if>
									class='take-out' value='0' style='margin-left: 10px;'><span>不支持</span>
								</li>
							</ul>
							<div id="product-property-div" style="width: 100%"></div>
							<!--  <ul>
                          <li>品牌：</li>
                          <li>
                              <select>
                                  <option value="">请选择品牌</option>
                                  <option value="">6666</option>
                              </select>
                          </li>
                      </ul>
                      <ul>
                          <li>原产地：</li>
                          <li>
                              <select>
                                  <option value="">请选择</option>
                                  <option value="">6666</option>
                              </select>
                          </li>
                      </ul>
                      <ul>
                          <li>使用季节：</li>
                          <li>
                              <div class="radio">
                                  <input name="chu" type="radio">
                                  <label>春季</label>
                              </div>
                              <div class="radio">
                                  <input name="chu" type="radio">
                                  <label>夏季</label>
                              </div>
                              <div class="radio">
                                  <input name="chu" type="radio">
                                  <label>秋季</label>
                              </div>
                              <div class="radio">
                                  <input name="chu" type="radio">
                                  <label>冬季</label>
                              </div>
                          </li>
                      </ul>
                      <ul>
                          <li>是否含糖：</li>
                          <li>
                              <select>
                                  <option value="">请选择</option>
                                  <option value="">6666</option>
                              </select>
                          </li>
                      </ul>
                      <ul>
                          <li>包装方式：</li>
                          <li>
                              <div class="radio">
                                  <input name="baoz" type="radio">
                                  <label>礼品盒</label>
                              </div>
                              <div class="radio">
                                  <input name="baoz" type="radio">
                                  <label>瓶装</label>
                              </div>
                              <div class="radio">
                                  <input name="baoz" type="radio">
                                  <label>袋装</label>
                              </div>
                              <div class="radio">
                                  <input name="baoz" type="radio">
                                  <label>盒装</label>
                              </div>
                              <div class="radio">
                                  <input name="baoz" type="radio">
                                  <label>罐装</label>
                              </div>
                              <div class="radio">
                                  <input name="baoz" type="radio">
                                  <label>其它</label>
                              </div>
                          </li>
                      </ul> -->
						</ul>
					</div>
				</div>
				<!--商品主图-->
				<div class="col-md-6 shop-pic" style="margin-left: 2%">
					<p>
						<font color="#69AC72">（4）</font>商品主图
					</p>
					<div class="pic-list">
						<input type="hidden" name="prdouctImg" id="prdouctImg"
							value="${ebProduct.prdouctImg}" htmlEscape="false"
							maxlength="100" class="input-xlarge" /> <span
							class="help-inline" id="prdouctImg" style="color: blue;"></span>
						<tags:ckfinder input="prdouctImg" type="images"
							selectMultiple="true" uploadPath="/merchandise/product/adImg" />
						<p style="font-size: 12px;">*图片比例为430:430</p>
					</div>
				</div>
			</div>




			<!--物流信息-->
			<!-- <div class="col-md-6 shop-logistics" style="display:none">
                <p>物流信息</p>
                <div>
                    <span>运费设置：</span>
                    <ul>
                        <li class="logistics-li">
                           <div class="">
                               <input checked name="money1" type="radio" value="1" <c:if test="${ebProduct.freightType==1}">checked="checked" </c:if>>
                               <label>卖家承担运费</label>
                           </div>
                        </li>
                        <li class="logistics-li">
                            <div class="">
                                <input class="maijia" name="money1" type="radio" value="2" <c:if test="${ebProduct.freightType==2}">checked="checked" </c:if>>
                                <label>买家承担运费</label>
                            </div>
							<div >
                            <c:if test="${ebProduct.freightType==2}">
                            <ul class="maijia-ul" style="display:none">
                                <li>
                                    <div class="radio-div">
                                        <input name="freightTempType" type="radio" value="1" <c:if test="${ebProduct.userFreightTemp==1}">checked="checked" </c:if>>
                                        <label>使用运费模板：</label>
                                        <select class='FreightTem' name="freightTempId">
                                            <option value="">国家</option>
                                            <option value="">中国</option>
                                            <<option value="">...</option>
                                        </select>
                                        <%-- <a href="${ctxweb}/shop/pmShopFreightTem/pmShopFreightTemList">查看运费模板</a> --%>
                                    </div>
                                </li>

                                <li>
                                    <div class="radio-div">
                                        <input name="freightTempType" type="radio" value="0" <c:if test="${ebProduct.userFreightTemp==0}">checked="checked" </c:if>>
                                        <label>快递</label>
                                        <input type="text" name="freightTempMoney" value="${ebProduct.courier}">
                                        <span>元</span>
                                    </div>
                                </li>
                            </ul>
                            </c:if>
                        </li>

                    </ul>
                </div>
            </div>
			-->



			<c:if test="${ not empty pmLovePayDeploys}">
				<div class="sb-xian" style="display: none">
					<p>其他商品设置</p>
					<div class="sb-xian-b">
						<b>积分支付</b> <span class=""> <input type="checkbox"
							name="isLovePay" value="1"> <label for=""><i></i>启用</label>
						</span>
					</div>
					<ul>
						<li><span>平台标准：</span>
							<div class="norm">
								<span>常规标准</span>
								<div class="norm-box">
									<ul>
										<li>生效日期</li>
										<li>下限</li>
										<li>上限</li>
									</ul>


									<c:forEach items="${pmLovePayDeploys}" var="pmLovePayDeploysv">
										<ul>
											<li><c:if
													test="${pmLovePayDeploysv.lovePayEffectType==1}">默认</c:if>
												<c:if test="${pmLovePayDeploysv.lovePayEffectType==2}">${pmLovePayDeploysv.lovePayStartDate}~${pmLovePayDeploysv.lovePayEndDate}</c:if></li>
											<li>${pmLovePayDeploysv.lovePayMinRatio}%</li>
											<li>${pmLovePayDeploysv.lovePayMaxRatio}%</li>
										</ul>
									</c:forEach>
								</div>
							</div></li>
						<li><span>生效日期：</span> <input class="date1"
							id="LAY_demorange_1" type="text" name="lovePayStartDate"
							value='<fmt:formatDate value="${ebProduct.lovePayStartDate}" type="date"/>'>
							~ <input class="date2" id="LAY_demorange_2" type="text"
							name="lovePayEndDate"
							value='<fmt:formatDate value="${ebProduct.lovePayEndDate}" type="date"/>'>
						</li>
						<li><span>下限：</span> <input class="x-in" type="text"
							name="lovePayMinRatio" value="${ebProduct.lovePayMinRatio}">
							<b class="zx"></b><b class="zd"></b></li>
						<li><span>上限：</span> <input class="s-in" type="text"
							name="lovePayMaxRatio" value="${ebProduct.lovePayMaxRatio}">
							<b class="zx"></b><b class="zd"></b></li>
					</ul>
				</div>
			</c:if>
			<!--商品规格-->
			<div class="col-md-12 shop-standard" id="shop-standard"
				style="background: #fff; margin: 0px 1%">
				<p style="display: inline-block; width: 100%">
					<font color="#69AC72" style="display: inline-block; width: 100%">（5）</font>商品规格
				</p>
				<div class="standard-tel">填错商品属性，可能会引起商品下架，影响您的正常销售。请认真准确填写</div>
				<div style="overflow: hidden;">
					<div class="standard-left">
						<p>选择规格：</p>
						<ul id="add-stan">
							<!--  <li class="checkbox">
                         <input type="checkbox">
                         <label><i></i>颜色</label>
                     </li>
                     <li class="checkbox">
                         <input type="checkbox">
                         <label><i></i>尺寸</label>
                     </li> -->
						</ul>
					</div>
					<div class="standard-right">
						<p id="ss">编辑规格值：</p>
						<!-- <ul class="right-ul1"><li> 颜色</li><li> <span>红色<b></b></span><a data-did="9" href="javascript:;"><img src="images/add-a.png" alt=""></a></li></ul>
                 -->
						<!-- <ul class="right-ul1">
                </ul>-->
					</div>
				</div>
				<!--编辑价格-->
				<div class="guige-div">
					<h3
						style="font-size: 20px; line-height: 33px; font-weight: bold; text-align: left;">价格变量:</h3>
					<h5>选择规格:</h5>
					<ul style="overflow: hidden;"></ul>
				</div>
				<div class="choose-price">
					<ul style="overflow: hidden;">
						<li><label>本店价格：</label> <input type='text' id='price1' /></li>
						<li><label>会员价格：</label> <input type='text' id='price2' /></li>
						<li><label>库存数量：</label> <input type='text' id='price3' /></li>
						<li>
							<button type="button" id="setting">设置</button>
						</li>
					</ul>
				</div>
				<div class="table-div">
					<p>编辑价格/库存</p>
					<table border="1">
						<thead>
							<th>颜色</th>
							<th style='display: none'>市场价格（元）</th>
							<th>本店价格（元）</th>
							<th style="display: none">折扣比例（${fns:getDictValue('minRatio','gyconfig','')}%~${fns:getDictValue('maxRatio','gyconfig','')}%）</th>
							<th style="display: none">结算价格（元）</th>
							<th>会员价格（元）</th>
							<th>库存数量</th>
						</thead>
						<tbody>
							<c:forEach items="${pmProductStandardDetails}"
								var="pmProductStandardDetail">
								<tr>
									<c:forEach items="${pmProductStandardDetail.strlust}"
										var="strlusts" varStatus="status">
										<td data-t="${strlusts.id}">${strlusts.name}<c:if
												test="${status.index==0}">
												<input name="standard_id_str" type="hidden"
													value="${pmProductStandardDetail.idStr}">
											</c:if>
										</td>
									</c:forEach>
									<td style='display: none'><input class="num t-shi"
										name="market_price" type="text"
										value="${pmProductStandardDetail.marketPrice}"></td>
									<td><input class="num t-ben" name="detail_prices"
										type="text" value="${pmProductStandardDetail.detailPrices}"></td>
									<td style="display: none"><input class="num t-ran"
										name="return_ratio" type="text"
										value="${pmProductStandardDetail.returnRatio}"
										style="display: none"></td>
									<td style="display: none"><input readonly
										class="num t-jie" name="supply_price" type="text"
										value="${pmProductStandardDetail.supplyPrice}"></td>
									<td><input class="num t-huiy" name="member_price"
										type="text" value="${pmProductStandardDetail.memberPrice}"></td>
									<td><input class="num" name="detailInventory" type="text"
										value="${pmProductStandardDetail.detailInventory}"></td>


								</tr>
							</c:forEach>
							<!--<tr>-->
							<!--<td>白色</td>-->
							<!--<td >S</td>-->
							<!--<td>20片装</td>-->
							<!--<td><input class="num" type="text"></td>-->
							<!--<td><input class="num" type="text"></td>-->
							<!--<td><input class="num" type="text"></td>-->
							<!--<td><input class="num" type="text"></td>-->
							<!--<td><input class="num" type="text"></td>-->
							<!--<td><a href="javascript:;">删除</a></td>-->
							<!--</tr>-->
							<!--<tr>-->
							<!--<td>白色</td>-->
							<!--<td>M</td>-->
							<!--<td>10片装</td>-->
							<!--<td><input class="num" type="text"></td>-->
							<!--<td><input class="num" type="text"></td>-->
							<!--<td><input class="num" type="text"></td>-->
							<!--<td><input class="num" type="text"></td>-->
							<!--<td><input class="num" type="text"></td>-->
							<!--<td><a href="javascript:;">删除</a></td>-->
							<!--</tr>-->
							<!--<tr>-->
							<!--<td>白色</td>-->
							<!--<td>M</td>-->
							<!--<td>20片装</td>-->
							<!--<td><input class="num" type="text"></td>-->
							<!--<td><input class="num" type="text"></td>-->
							<!--<td><input class="num" type="text"></td>-->
							<!--<td><input class="num" type="text"></td>-->
							<!--<td><input class="num" type="text"></td>-->
							<!--<td><a href="javascript:;">删除</a></td>-->
							<!--</tr>-->

							<!--<tr>-->
							<!--<td>红色</td>-->
							<!--<td>S</td>-->
							<!--<td>10片装</td>-->
							<!--<td><input class="num" type="text"></td>-->
							<!--<td><input class="num" type="text"></td>-->
							<!--<td><input class="num" type="text"></td>-->
							<!--<td><input class="num" type="text"></td>-->
							<!--<td><input class="num" type="text"></td>-->
							<!--<td><a href="javascript:;">删除</a></td>-->
							<!--</tr>-->
							<!--<tr>-->
							<!--<td>红色</td>-->
							<!--<td>S</td>-->
							<!--<td>20片装</td>-->
							<!--<td><input class="num" type="text"></td>-->
							<!--<td><input class="num" type="text"></td>-->
							<!--<td><input class="num" type="text"></td>-->
							<!--<td><input class="num" type="text"></td>-->
							<!--<td><input class="num" type="text"></td>-->
							<!--<td><a href="javascript:;">删除</a></td>-->
							<!--</tr>-->
							<!--<tr>-->
							<!--<td>红色</td>-->
							<!--<td>M</td>-->
							<!--<td>10片装</td>-->
							<!--<td><input class="num" type="text"></td>-->
							<!--<td><input class="num" type="text"></td>-->
							<!--<td><input class="num" type="text"></td>-->
							<!--<td><input class="num" type="text"></td>-->
							<!--<td><input class="num" type="text"></td>-->
							<!--<td><a href="javascript:;">删除</a></td> -->
							<!--</tr>-->
							<!--<tr>-->
							<!--<td>红色</td>-->
							<!--<td>M</td>-->
							<!--<td>20片装</td>-->
							<!--<td><input class="num" type="text"></td>-->
							<!--<td><input class="num" type="text"></td>-->
							<!--<td><input class="num" type="text"></td>-->
							<!--<td><input class="num" type="text"></td>-->
							<!--<td><input class="num" type="text"></td>-->
							<!--<td><a href="javascript:;">删除</a></td>-->
							<!--</tr>-->

						</tbody>
						<tfoot class="tfoot">
							<tr>
								<td colspan="1">批量设置</td>
								<td style='display: none'><input class="num1 t-shi"
									type="text" data-did="1"></td>
								<td><input class="num1 tt-ben" type="text" data-did="2"></td>
								<td style="display: none"><input class="num1 tt-ran"
									type="text" data-did="3"></td>
								<td style="display: none"><input readonly
									class="num1 t-jie" type="text" data-did="4"></td>
								<td><input class='num1 t-huiy' type='text' data-did='5'></td>
								<td><input class="num1" type="text" data-did="6"></td>

							</tr>
						</tfoot>
					</table>
				</div>
				<input id="kk" name="productId" type="hidden"
					value="${ebProduct.productId}" />
				<!--帮助说明-->
				<div class="assist-div">
					<p>帮助说明：</p>
					<ul>
						<li>1.本店价格为商品在${fns:getProjectName()}平台上的非会员卖价</li>
						<li>2.会员价格为商品在${fns:getProjectName()}平台上的会员卖价</li>
					</ul>
				</div>

			</div>
			<!--
         <div class="step-div">
             <a class="step2" href="javascript:;">上一步</a>
             <a class="step3" href="javascript:;">下一步</a>
         </div> -->
		</form>
	</div>
	<!--content2基本信息-->
	<%--<div class="content2" >--%>

	<%--<!--商品信息-->--%>
	<%--<div class="col-md-6 shop-news">--%>
	<%--<p><font color="#69AC72">（1）</font>商品信息</p>--%>
	<%--<ul>--%>
	<%--<li>--%>
	<%--<span>商品名称：</span>--%>
	<%--<input id="news1" class="input" name="productName"   type="text" maxlength="40" value="${ebProduct.productName}">--%>
	<%--<b>（不超过40字）</b>--%>
	<%--</li>--%>
	<%--<li>--%>
	<%--<span>规格设置：</span>--%>
	<%--<div class="radio-div">--%>
	<%--<input  checked id="li2-1" name="li2" type="radio" <c:if test="${empty  pmProductStandardDetails}"> checked="checked" </c:if> value="1">--%>
	<%--<label for="li2-1">统一规格</label>--%>
	<%--</div>--%>
	<%--<div class="radio-div">--%>
	<%--<input id="li2-2" name="li2" type="radio" <c:if test="${not empty  pmProductStandardDetails}"> checked="checked" </c:if> value="2">--%>
	<%--<label for="li2-2">多规格</label>--%>
	<%--</div>--%>
	<%--</li>--%>
	<%--<li style="display: none">--%>
	<%--<span>市场价格：</span>--%>
	<%--<input class="num1 input bshi" name="marketPrice"  style="display: none"   type="text" value="${ebProduct.marketPrice}">--%>
	<%--<span>元</span>--%>
	<%--<b>（商品的成本卖价）</b>--%>
	<%--</li>--%>
	<%--<li class="statendTo">--%>
	<%--<span>本店价格：</span>--%>
	<%--<input class="num1 input bend" name="sellPrice"   type="text" value="${ebProduct.sellPrice}">--%>
	<%--<span>元</span>--%>
	<%--<b>（商品在御可贡茶平台上非会员的卖价）</b>--%>
	<%--</li>--%>
	<%--<li class="statendTo">--%>
	<%--<span>会员价格：</span>--%>
	<%--<input class="num1 input huiy" name="memberPrice"   type="text" value="${ebProduct.memberPrice}">--%>
	<%--<span>元</span>--%>
	<%--<b>（商品在御可贡茶平台上非会员的卖价）</b>--%>
	<%--</li>--%>
	<%--<li class="rangli" style="display: none">--%>
	<%--<span>折扣比例：</span>--%>
	<%--<div class="radio-div">--%>
	<%--<input class="imo" checked name="li5" type="radio" value="1" <c:if test="${empty  ebProduct.returnRatio}"> checked="checked" </c:if>>--%>
	<%--<label>默认折扣比<span class="smo">0</span>%</label>--%>
	<%--</div>--%>
	<%--<div class="radio-div">--%>
	<%--<input class="rang" name="li5" type="radio" value="2" <c:if test="${not empty  ebProduct.returnRatio}"> checked="checked" </c:if>>--%>
	<%--<label>--%>
	<%--折扣--%>
	<%--<span class="jiaspan"></span>--%>
	<%--&lt;%&ndash;  <input class="num1 ran" type="text" name="ReturnRatio" value="${ebProduct.returnRatio}"> &ndash;%&gt;--%>
	<%--<span>%</span>--%>
	<%--<b>（折扣比范围<b class="ran1">${fns:getDictValue('minRatio','gyconfig','')}</b>%~<b class="ran2">${fns:getDictValue('maxRatio','gyconfig','')}</b>%）</b>--%>
	<%--</label>--%>
	<%--</div>--%>
	<%--</li>--%>
	<%--<li style="display: none">--%>
	<%--<span>结算价格：</span>--%>
	<%--<input readonly class="num1 input jies" style="display: none" name="costPrice"   type="text" value="${ebProduct.costPrice}">--%>
	<%--<span>元</span>--%>
	<%--<b>（商品在御可贡茶平台的结算价格）</b>--%>
	<%--</li>--%>
	<%--<li class="statendTo">--%>
	<%--<span>库存数量：</span>--%>
	<%--<input class="num1 input" name="storeNums"   type="text" value="${ebProduct.storeNums}">--%>
	<%--<span>商家条形码：</span>--%>
	<%--<input class="num"  type="text" name="barCode"  value="${ebProduct.barCode}">--%>
	<%--</li>--%>
	<%--<li  style="padding-bottom: 35px;">--%>
	<%--<span>商品简介：</span>--%>
	<%--<input class="input" name="productIntro" style="width: 65%;" maxlength="40" type="text" value="${ebProduct.productIntro}">--%>
	<%--<b>（不超过40字）</b>--%>
	<%--</li>--%>

	<%--<li style="display: none">--%>
	<%--<span>所在地区：</span>--%>
	<%--<select id="nationality" name="country"   onchange="towji(this.value,'1','')">--%>
	<%--</select>--%>
	<%--<select id="province" name="provincesId"   onchange="towji(this.value,'2','')">--%>
	<%--</select>--%>
	<%--<select id="city" name="municipalId"  onchange="towji(this.value,'3','')">--%>
	<%--</select>--%>
	<%--<select id="area" name="area" >--%>
	<%--</select>--%>
	<%--</li>--%>
	<%--</ul>--%>
	<%--</div>--%>
	<%--<input id="advertiseTypeObjIds" name="shopId" type="hidden" value="${ebProduct.shopId}"/>--%>
	<%--<!--商品分类-->--%>
	<%--<div class="col-md-6 shop-classify">--%>
	<%--<p><font color="#69AC72">（2）</font>商品分类</p>--%>
	<%--<div class="classify-div">--%>
	<%--<ul>--%>
	<%--<li><span>平台分类：</span></li>--%>
	<%--<li>--%>
	<%--<select onchange="fkeitType(this.value,'1')" id="type1">--%>
	<%--<option value="" selected="selected">请选择</option>--%>
	<%--&lt;%&ndash;   <c:forEach var="productTypes" items="${productTypes}">--%>
	<%--<option value="${productTypes.id}" <c:if test="${productTypes.id==ebProduct.productTypeParentId}"> selected="selected" </c:if>>${productTypes.productTypeName}</option>--%>
	<%--</c:forEach> &ndash;%&gt;--%>
	<%--</select>--%>
	<%--<select id="type2" onchange="fkeitType(this.value,'2')">--%>
	<%--<option value="" selected="selected">请选择</option>--%>
	<%--</select>--%>
	<%--<select id="type3" name="type" onchange="getPingTow(this.value)">--%>
	<%--<option value="" selected="selected">请选择</option>--%>
	<%--</select>--%>


	<%--</li>--%>

	<%--<li style=" margin-top: 10px;">--%>
	<%--&lt;%&ndash;<span>加料：</span>&ndash;%&gt;--%>
	<%--</li>--%>
	<%--<li>--%>
	<%--<table class="product-charging-table" style="display: none">--%>
	<%--<tr>--%>
	<%--<th>加料名称</th>--%>
	<%--<th>标签名</th>--%>
	<%--<th>价格</th>--%>
	<%--<th>操作</th>--%>
	<%--</tr>--%>
	<%--<c:forEach var="ebProductCharging" items="${ebProductChargingList}">--%>
	<%--<tr chargingId="${ebProductCharging.id}">--%>
	<%--<td style="display: none" class="old-charging-id">${ebProductCharging.id}</td>--%>
	<%--<td>${ebProductCharging.cName}</td>--%>
	<%--<td>${ebProductCharging.lable}</td>--%>
	<%--<td>${ebProductCharging.sellPrice}</td>--%>
	<%--<td style='cursor: pointer;color:#69AC72;'onclick=removeProductCharging(${ebProductCharging.id})>删除</td>--%>
	<%--</tr>--%>
	<%--</c:forEach>--%>
	<%--</table>--%>
	<%--</li>--%>
	<%--<li style=" margin-top: 10px;">--%>
	<%--<a href="javascript:" onclick="addProductCharging()" class="btn product-charging-btn">添加</a>--%>
	<%--<a href="javascript:" onclick="clearProductCharging()" class="btn product-charging-btn">清空</a>--%>
	<%--</li>--%>

	<%--<li><input type="hidden" class="input bend" readonly name="productChargingIds" id="productChargingIds" style=" "></li>--%>
	<%--</ul>--%>
	<%--<ul style="display:none">--%>
	<%--<li><span>选择门店：</span></li>--%>
	<%--<li>--%>
	<%--<div class="xuan-img" >--%>
	<%--<div style="width:150px;height:100px;overflow:hidden;"><img id="imgsvals" style="width:100%" src="${ebProduct.pmShopInfo.shopwapBanner}"/></div>--%>
	<%--<p title="${ebProduct.shopName}" id="pnames" style="width:150px;margin-top:10px;overflow: hidden;text-overflow: ellipsis;white-space: nowrap;word-wrap: break-word;">${ebProduct.shopName }</p>--%>
	<%--</div>--%>
	<%--<a class="elecs-show btn" href="javascript:;">选择</a>--%>
	<%--<a class="btn" href="javascript:;" onclick="remoenpms()">清除</a>--%>
	<%--</li>--%>
	<%--</ul>--%>
	<%--<!--   <ul id="shopTYpenamw">--%>
	<%--<li><span>门店分类：</span></li>--%>
	<%--<li>--%>
	<%--<select id="shopType" onchange="typeShop(this.value)">--%>
	<%--<option value="">请选择</option>--%>

	<%--</select>--%>
	<%--<select id="shopType1" name="pmshoprodic">--%>
	<%--<option value="">请选择</option>--%>
	<%--</select>--%>
	<%--</li>--%>
	<%--</ul> -->--%>
	<%--</div>--%>
	<%--</div>--%>

	<%--<!--物流信息-->--%>
	<%--<!-- <div class="col-md-6 shop-logistics" style="display:none">--%>
	<%--<p>物流信息</p>--%>
	<%--<div>--%>
	<%--<span>运费设置：</span>--%>
	<%--<ul>--%>
	<%--<li class="logistics-li">--%>
	<%--<div class="">--%>
	<%--<input checked name="money1" type="radio" value="1" <c:if test="${ebProduct.freightType==1}">checked="checked" </c:if>>--%>
	<%--<label>卖家承担运费</label>--%>
	<%--</div> --%>
	<%--</li>--%>
	<%--<li class="logistics-li">--%>
	<%--<div class="">--%>
	<%--<input class="maijia" name="money1" type="radio" value="2" <c:if test="${ebProduct.freightType==2}">checked="checked" </c:if>>--%>
	<%--<label>买家承担运费</label>--%>
	<%--</div>--%>
	<%--<div >--%>
	<%--<c:if test="${ebProduct.freightType==2}">--%>
	<%--<ul class="maijia-ul" style="display:none">--%>
	<%--<li>--%>
	<%--<div class="radio-div">--%>
	<%--<input name="freightTempType" type="radio" value="1" <c:if test="${ebProduct.userFreightTemp==1}">checked="checked" </c:if>>--%>
	<%--<label>使用运费模板：</label>--%>
	<%--<select class='FreightTem' name="freightTempId">--%>
	<%--<option value="">国家</option>--%>
	<%--<option value="">中国</option>--%>
	<%--<<option value="">...</option>--%>
	<%--</select>--%>
	<%--&lt;%&ndash; <a href="${ctxweb}/shop/pmShopFreightTem/pmShopFreightTemList">查看运费模板</a> &ndash;%&gt;--%>
	<%--</div>--%>
	<%--</li>--%>
	<%----%>
	<%--<li>--%>
	<%--<div class="radio-div">--%>
	<%--<input name="freightTempType" type="radio" value="0" <c:if test="${ebProduct.userFreightTemp==0}">checked="checked" </c:if>>--%>
	<%--<label>快递</label>--%>
	<%--<input type="text" name="freightTempMoney" value="${ebProduct.courier}">--%>
	<%--<span>元</span>--%>
	<%--</div>--%>
	<%--</li>--%>
	<%--</ul>--%>
	<%--</c:if>--%>
	<%--</li>--%>

	<%--</ul>--%>
	<%--</div>--%>
	<%--</div>--%>
	<%---->--%>
	<%--<!--商品主图-->--%>
	<%--<div class="col-md-6 shop-pic" style="width:48%;margin-left:2%">--%>
	<%--<p><font color="#69AC72">（4）</font>商品主图</p>--%>
	<%--<div class="pic-list">--%>
	<%--<input type="hidden" name="prdouctImg" id="prdouctImg" value="${ebProduct.prdouctImg}"   htmlEscape="false" maxlength="100"  class="input-xlarge"/>--%>
	<%--<span class="help-inline" id="prdouctImg"  style="color: blue;"></span>--%>
	<%--<tags:ckfinder input="prdouctImg" type="images" selectMultiple="true" uploadPath="/merchandise/product/adImg"/>--%>
	<%--<p style="font-size: 12px;" >*图片比例为430:430</p>--%>
	<%--</div>--%>
	<%--</div>--%>
	<%--<!--商品属性-->--%>
	<%--<div class="col-md-6 shop-property" style="width:50%;margin-left:0%;margin-top:-325px;">--%>
	<%--<p><font color="#69AC72">（3）</font>商品属性</p>--%>
	<%--&lt;%&ndash;门店id&ndash;%&gt;--%>
	<%--<input type="hidden" value="${shopIds}" name="shopIds" id="shopIds">--%>
	<%--<div class="property-div" id="property-div">--%>
	<%--<ul>--%>
	<%--<li>选择 门店:</li>--%>
	<%--<li>--%>
	<%--<input type='radio' <c:if test='${isAllShop}'>checked</c:if> name='shopType' onclick='chooseShop(0)' class='shopType' value='0' ><span style="display: inline-block;width: 60px">所有门店</span>--%>
	<%--<input type='radio' <c:if test='${!isAllShop}'>checked</c:if> name='shopType' onclick='chooseShop(1)' class='shopType' value='1' style='margin-left:10px;'></span>指定门店</span>--%>
	<%--</li>--%>

	<%--</ul>--%>
	<%--<ul id="shopNamesUl">--%>
	<%--<li>已选择门店:</li>--%>
	<%--<li >--%>
	<%--<input  readonly class="form-control" style="height: 30px;border-radius: 5px;" type="text" id="shopNames" onclick="showShopName()" value="${shopNames}"/>--%>
	<%--</li>--%>
	<%--</ul>--%>

	<%--<!-- 模态框（Modal） -->--%>
	<%--<div class="modal fade" id="shop-name-modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">--%>
	<%--<div class="modal-dialog">--%>
	<%--<div class="modal-content">--%>
	<%--<div class="modal-header">--%>
	<%--<button type="button" class="close" data-dismiss="modal" aria-hidden="true">--%>
	<%--&times;--%>
	<%--</button>--%>
	<%--<h4 class="modal-title" id="myModalLabel">--%>
	<%--已选择的门店名--%>
	<%--</h4>--%>
	<%--</div>--%>
	<%--<div class="modal-body" id="choose-shop-name-div">--%>

	<%--</div>--%>
	<%--<div class="modal-footer">--%>
	<%--<button type="button" class="btn btn-default" data-dismiss="modal">关闭--%>
	<%--</button>--%>
	<%--</div>--%>
	<%--</div><!-- /.modal-content -->--%>
	<%--</div><!-- /.modal -->--%>
	<%--</div>--%>

	<%--<ul>--%>
	<%--<li>是否可外卖:</li>--%>
	<%--<li>--%>
	<%--<input type='radio' name='isTakeOut' <c:if test='${ebProduct.isTakeOut != 0}'>checked</c:if> class='take-out' value='1'><span style="display: inline-block;width: 60px">支持</span>--%>
	<%--<input type='radio' name='isTakeOut' <c:if test='${ebProduct.isTakeOut == 0}'>checked</c:if> class='take-out' value='0' style='margin-left:10px;'><span>不支持</span>--%>
	<%--</li>--%>
	<%--</ul>--%>
	<%--<div id="product-property-div" style="width: 100%">--%>

	<%--</div>--%>
	<%--<!--  <ul>--%>
	<%--<li>品牌：</li>--%>
	<%--<li>--%>
	<%--<select>--%>
	<%--<option value="">请选择品牌</option>--%>
	<%--<option value="">6666</option>--%>
	<%--</select>--%>
	<%--</li>--%>
	<%--</ul>--%>
	<%--<ul>--%>
	<%--<li>原产地：</li>--%>
	<%--<li>--%>
	<%--<select>--%>
	<%--<option value="">请选择</option>--%>
	<%--<option value="">6666</option>--%>
	<%--</select>--%>
	<%--</li>--%>
	<%--</ul>--%>
	<%--<ul>--%>
	<%--<li>使用季节：</li>--%>
	<%--<li>--%>
	<%--<div class="radio">--%>
	<%--<input name="chu" type="radio">--%>
	<%--<label>春季</label>--%>
	<%--</div>--%>
	<%--<div class="radio">--%>
	<%--<input name="chu" type="radio">--%>
	<%--<label>夏季</label>--%>
	<%--</div>--%>
	<%--<div class="radio">--%>
	<%--<input name="chu" type="radio">--%>
	<%--<label>秋季</label>--%>
	<%--</div>--%>
	<%--<div class="radio">--%>
	<%--<input name="chu" type="radio">--%>
	<%--<label>冬季</label>--%>
	<%--</div>--%>
	<%--</li>--%>
	<%--</ul>--%>
	<%--<ul>--%>
	<%--<li>是否含糖：</li>--%>
	<%--<li>--%>
	<%--<select>--%>
	<%--<option value="">请选择</option>--%>
	<%--<option value="">6666</option>--%>
	<%--</select>--%>
	<%--</li>--%>
	<%--</ul>--%>
	<%--<ul>--%>
	<%--<li>包装方式：</li>--%>
	<%--<li>--%>
	<%--<div class="radio">--%>
	<%--<input name="baoz" type="radio">--%>
	<%--<label>礼品盒</label>--%>
	<%--</div>--%>
	<%--<div class="radio">--%>
	<%--<input name="baoz" type="radio">--%>
	<%--<label>瓶装</label>--%>
	<%--</div>--%>
	<%--<div class="radio">--%>
	<%--<input name="baoz" type="radio">--%>
	<%--<label>袋装</label>--%>
	<%--</div>--%>
	<%--<div class="radio">--%>
	<%--<input name="baoz" type="radio">--%>
	<%--<label>盒装</label>--%>
	<%--</div>--%>
	<%--<div class="radio">--%>
	<%--<input name="baoz" type="radio">--%>
	<%--<label>罐装</label>--%>
	<%--</div>--%>
	<%--<div class="radio">--%>
	<%--<input name="baoz" type="radio">--%>
	<%--<label>其它</label>--%>
	<%--</div>--%>
	<%--</li>--%>
	<%--</ul> -->--%>
	<%--</div>--%>
	<%--</div>--%>
	<%--<c:if test="${ not empty pmLovePayDeploys}">--%>
	<%--<div class="sb-xian" style="display:none">--%>
	<%--<p>其他商品设置</p>--%>
	<%--<div class="sb-xian-b">--%>
	<%--<b>积分支付</b>--%>
	<%--<span class="">--%>
	<%--<input type="checkbox"  name="isLovePay" value="1" >--%>
	<%--<label for=""><i></i>启用</label>--%>
	<%--</span>--%>
	<%--</div>--%>
	<%--<ul>--%>
	<%--<li>--%>
	<%--<span>平台标准：</span>--%>
	<%--<div class="norm">--%>
	<%--<span>常规标准</span>--%>
	<%--<div class="norm-box">--%>
	<%--<ul>--%>
	<%--<li>生效日期</li>--%>
	<%--<li>下限</li>--%>
	<%--<li>上限</li>--%>
	<%--</ul>--%>


	<%--<c:forEach items="${pmLovePayDeploys}" var="pmLovePayDeploysv">--%>
	<%--<ul>--%>
	<%--<li><c:if test="${pmLovePayDeploysv.lovePayEffectType==1}">默认</c:if><c:if test="${pmLovePayDeploysv.lovePayEffectType==2}">${pmLovePayDeploysv.lovePayStartDate}~${pmLovePayDeploysv.lovePayEndDate}</c:if></li>--%>
	<%--<li>${pmLovePayDeploysv.lovePayMinRatio}%</li>--%>
	<%--<li>${pmLovePayDeploysv.lovePayMaxRatio}%</li>--%>
	<%--</ul>--%>
	<%--</c:forEach>--%>
	<%--</div>--%>
	<%--</div>--%>
	<%--</li>--%>
	<%--<li> <span>生效日期：</span>--%>
	<%--<input class="date1" id="LAY_demorange_1" type="text" name="lovePayStartDate" value="<fmt:formatDate value="${ebProduct.lovePayStartDate}" type="date"/>">--%>
	<%--~--%>
	<%--<input class="date2" id="LAY_demorange_2" type="text" name="lovePayEndDate" value="<fmt:formatDate value="${ebProduct.lovePayEndDate}" type="date"/>">--%>
	<%--</li>--%>
	<%--<li>--%>
	<%--<span>下限：</span>--%>
	<%--<input class="x-in" type="text" name="lovePayMinRatio" value="${ebProduct.lovePayMinRatio}">--%>
	<%--<b class="zx"></b><b class="zd"></b>--%>
	<%--</li>--%>
	<%--<li>--%>
	<%--<span>上限：</span>--%>
	<%--<input class="s-in" type="text" name="lovePayMaxRatio" value="${ebProduct.lovePayMaxRatio}">--%>
	<%--<b class="zx"></b><b class="zd"></b>--%>
	<%--</li>--%>
	<%--</ul>--%>
	<%--</div>--%>
	<%--</c:if>--%>
	<%--<!--商品规格-->--%>
	<%--<div class="col-md-12 shop-standard" id="shop-standard">--%>
	<%--<p><font color="#69AC72">（5）</font>商品规格</p>--%>
	<%--<div class="standard-tel">填错商品属性，可能会引起商品下架，影响您的正常销售。请认真准确填写</div>--%>
	<%--<div class="standard-left">--%>
	<%--<p>选择规格：</p>--%>
	<%--<ul id="add-stan">--%>
	<%--<!--  <li class="checkbox">--%>
	<%--<input type="checkbox">--%>
	<%--<label><i></i>颜色</label>--%>
	<%--</li>--%>
	<%--<li class="checkbox">--%>
	<%--<input type="checkbox">--%>
	<%--<label><i></i>尺寸</label>--%>
	<%--</li> -->--%>
	<%--</ul>--%>
	<%--</div>--%>
	<%--<div class="standard-right">--%>
	<%--<p id="ss">编辑规格值：</p>--%>
	<%--<!-- <ul class="right-ul1"><li> 颜色</li><li> <span>红色<b></b></span><a data-did="9" href="javascript:;"><img src="images/add-a.png" alt=""></a></li></ul>--%>
	<%---->--%>
	<%--<!-- <ul class="right-ul1">--%>
	<%--</ul>-->--%>
	<%--</div>--%>
	<%--<!--编辑价格-->--%>
	<%--<div class="table-div">--%>
	<%--<p>编辑价格/库存</p>--%>
	<%--<table border="1">--%>
	<%--<thead>--%>
	<%--<th>颜色</th>--%>
	<%--<th   style='display: none'>市场价格（元）</th>--%>
	<%--<th>本店价格（元）</th>--%>
	<%--<th style="display: none">折扣比例（${fns:getDictValue('minRatio','gyconfig','')}%~${fns:getDictValue('maxRatio','gyconfig','')}%）</th>--%>
	<%--<th style="display: none">结算价格（元）</th>--%>
	<%--<th>会员价格（元）</th>--%>
	<%--<th>库存数量</th>--%>
	<%--</thead>--%>
	<%--<tbody>--%>
	<%--<c:forEach items="${pmProductStandardDetails}" var="pmProductStandardDetail">--%>
	<%--<tr>--%>
	<%--<c:forEach items="${pmProductStandardDetail.strlust}" var="strlusts" varStatus="status">--%>
	<%--<td data-t="${strlusts.id}">${strlusts.name}--%>
	<%--<c:if test="${status.index==0}">--%>
	<%--<input name="standard_id_str" type="hidden" value="${pmProductStandardDetail.idStr}">--%>
	<%--</c:if>--%>
	<%--</td>--%>
	<%--</c:forEach>--%>
	<%--<td   style='display: none'><input class="num t-shi" name="market_price" type="text"  value="${pmProductStandardDetail.marketPrice}"></td>--%>
	<%--<td><input class="num t-ben" name="detail_prices" type="text" value="${pmProductStandardDetail.detailPrices}"></td>--%>
	<%--<td  style="display: none"><input class="num t-ran" name="return_ratio" type="text" value="${pmProductStandardDetail.returnRatio}" style="display: none"></td>--%>
	<%--<td style="display: none"><input readonly class="num t-jie" name="supply_price" type="text" value="${pmProductStandardDetail.supplyPrice}"></td>--%>
	<%--<td><input class="num t-huiy" name="member_price" type="text" value="${pmProductStandardDetail.memberPrice}"></td>--%>
	<%--<td><input class="num" name="detailInventory" type="text" value="${pmProductStandardDetail.detailInventory}"></td>--%>


	<%--</tr>--%>
	<%--</c:forEach>--%>
	<%--<!--<tr>-->--%>
	<%--<!--<td>白色</td>-->--%>
	<%--<!--<td >S</td>-->--%>
	<%--<!--<td>20片装</td>-->--%>
	<%--<!--<td><input class="num" type="text"></td>-->--%>
	<%--<!--<td><input class="num" type="text"></td>-->--%>
	<%--<!--<td><input class="num" type="text"></td>-->--%>
	<%--<!--<td><input class="num" type="text"></td>-->--%>
	<%--<!--<td><input class="num" type="text"></td>-->--%>
	<%--<!--<td><a href="javascript:;">删除</a></td>-->--%>
	<%--<!--</tr>-->--%>
	<%--<!--<tr>-->--%>
	<%--<!--<td>白色</td>-->--%>
	<%--<!--<td>M</td>-->--%>
	<%--<!--<td>10片装</td>-->--%>
	<%--<!--<td><input class="num" type="text"></td>-->--%>
	<%--<!--<td><input class="num" type="text"></td>-->--%>
	<%--<!--<td><input class="num" type="text"></td>-->--%>
	<%--<!--<td><input class="num" type="text"></td>-->--%>
	<%--<!--<td><input class="num" type="text"></td>-->--%>
	<%--<!--<td><a href="javascript:;">删除</a></td>-->--%>
	<%--<!--</tr>-->--%>
	<%--<!--<tr>-->--%>
	<%--<!--<td>白色</td>-->--%>
	<%--<!--<td>M</td>-->--%>
	<%--<!--<td>20片装</td>-->--%>
	<%--<!--<td><input class="num" type="text"></td>-->--%>
	<%--<!--<td><input class="num" type="text"></td>-->--%>
	<%--<!--<td><input class="num" type="text"></td>-->--%>
	<%--<!--<td><input class="num" type="text"></td>-->--%>
	<%--<!--<td><input class="num" type="text"></td>-->--%>
	<%--<!--<td><a href="javascript:;">删除</a></td>-->--%>
	<%--<!--</tr>-->--%>

	<%--<!--<tr>-->--%>
	<%--<!--<td>红色</td>-->--%>
	<%--<!--<td>S</td>-->--%>
	<%--<!--<td>10片装</td>-->--%>
	<%--<!--<td><input class="num" type="text"></td>-->--%>
	<%--<!--<td><input class="num" type="text"></td>-->--%>
	<%--<!--<td><input class="num" type="text"></td>-->--%>
	<%--<!--<td><input class="num" type="text"></td>-->--%>
	<%--<!--<td><input class="num" type="text"></td>-->--%>
	<%--<!--<td><a href="javascript:;">删除</a></td>-->--%>
	<%--<!--</tr>-->--%>
	<%--<!--<tr>-->--%>
	<%--<!--<td>红色</td>-->--%>
	<%--<!--<td>S</td>-->--%>
	<%--<!--<td>20片装</td>-->--%>
	<%--<!--<td><input class="num" type="text"></td>-->--%>
	<%--<!--<td><input class="num" type="text"></td>-->--%>
	<%--<!--<td><input class="num" type="text"></td>-->--%>
	<%--<!--<td><input class="num" type="text"></td>-->--%>
	<%--<!--<td><input class="num" type="text"></td>-->--%>
	<%--<!--<td><a href="javascript:;">删除</a></td>-->--%>
	<%--<!--</tr>-->--%>
	<%--<!--<tr>-->--%>
	<%--<!--<td>红色</td>-->--%>
	<%--<!--<td>M</td>-->--%>
	<%--<!--<td>10片装</td>-->--%>
	<%--<!--<td><input class="num" type="text"></td>-->--%>
	<%--<!--<td><input class="num" type="text"></td>-->--%>
	<%--<!--<td><input class="num" type="text"></td>-->--%>
	<%--<!--<td><input class="num" type="text"></td>-->--%>
	<%--<!--<td><input class="num" type="text"></td>-->--%>
	<%--<!--<td><a href="javascript:;">删除</a></td> -->--%>
	<%--<!--</tr>-->--%>
	<%--<!--<tr>-->--%>
	<%--<!--<td>红色</td>-->--%>
	<%--<!--<td>M</td>-->--%>
	<%--<!--<td>20片装</td>-->--%>
	<%--<!--<td><input class="num" type="text"></td>-->--%>
	<%--<!--<td><input class="num" type="text"></td>-->--%>
	<%--<!--<td><input class="num" type="text"></td>-->--%>
	<%--<!--<td><input class="num" type="text"></td>-->--%>
	<%--<!--<td><input class="num" type="text"></td>-->--%>
	<%--<!--<td><a href="javascript:;">删除</a></td>-->--%>
	<%--<!--</tr>-->--%>

	<%--</tbody>--%>
	<%--<tfoot class="tfoot">--%>
	<%--<tr>--%>
	<%--<td colspan="1">批量设置</td>--%>
	<%--<td   style='display: none'><input class="num1 t-shi" type="text" data-did="1"></td>--%>
	<%--<td><input class="num1 tt-ben" type="text" data-did="2"></td>--%>
	<%--<td style="display: none"><input class="num1 tt-ran" type="text" data-did="3"></td>--%>
	<%--<td  style="display: none"><input readonly class="num1 t-jie" type="text" data-did="4"></td>--%>
	<%--<td><input class='num1 t-huiy' type='text' data-did='5'></td>--%>
	<%--<td><input class="num1" type="text" data-did="6"></td>--%>

	<%--</tr>--%>
	<%--</tfoot>--%>
	<%--</table>--%>
	<%--</div>--%>
	<%--<input id="kk" name="productId" type="hidden" value="${ebProduct.productId}"/>--%>
	<%--<!--帮助说明-->--%>
	<%--<div class="assist-div">--%>
	<%--<p>帮助说明：</p>--%>
	<%--<ul>--%>
	<%--<li>1.本店价格为商品在御可贡茶平台上的非会员卖价</li>--%>
	<%--<li>2.会员价格为商品在御可贡茶平台上的会员卖价</li>--%>
	<%--</ul>--%>
	<%--</div>--%>

	<%--</div>--%>
	<%--<!----%>
	<%--<div class="step-div">--%>
	<%--<a class="step2" href="javascript:;">上一步</a>--%>
	<%--<a class="step3" href="javascript:;">下一步</a>--%>
	<%--</div> -->--%>

	<%--</div>--%>


	<div class=""
		style="display: block; float: left; width: 100%; padding: 10px;">
		<div class="textare" style="margin-bottom: 10px; background: #fff;">
			<textarea name="productHtml" id="productHtml" cols="" rows="">${ebProduct.productHtml}</textarea>
			<tags:ckeditor replace="productHtml"
				uploadPath="/merchandise/product/adImg"></tags:ckeditor>
		</div>
	</div>
	<div style="float: left; width: 100%; padding-top: 20px;">
		<div class="content3-a">
			<!--  <a id="y" class="step4" href="javascript:;">上一步</a> -->
			<a id="s" class="step3" href="javascript:;"
				style="background: #69AC72">保存商品</a>
		</div>
	</div>
	<!--content3商品详情-->

	<form action=""></form>
	<script type="text/javascript">
</script>
	<!--添加规格-->
	<div class="guige">
		<div class="guige-box">
			<span>请输入规格：</span> <input type="text"><br> <a
				class="guige-box-remove" href="javascript:;">取消</a> <a
				class="guige-box-add" href="javascript:;">确认</a>

		</div>
	</div>
	<!--验证不通过-->
	<div class="yanzhen">
		<div class="yanzhen-box">
			<p>提示</p>
			<div>
				<span>有选项没有填完，请继续填写！</span><br> <a href="javascript:;">继续填写</a>
			</div>
		</div>
	</div>
	<div></div>
	<script type="text/javascript">
		$(function() {
			$('.sb-xian>ul li input').attr('readonly', 'readonly');
			var isLovePay = "${ebProduct.isLovePay}";
			if (isLovePay == 1) {
				$('.sb-xian>ul').show();
				$('.sb-xian input[type=checkbox]').attr('checked', 'checked');
			}
			$('.norm>span').click(function() {
				$('.norm-box').show();
			});
			$('.sb-xian-b input').click(function() {
				if ($(this).is(':checked')) {
					$(this).closest('.sb-xian-b').siblings('ul').show();
				} else {
					$(this).closest('.sb-xian-b').siblings('ul').hide();
				}
			})
			$('body').on('click', '.sb-xian .norm-box ul:not(:nth-child(1))', function() {
				$('.sb-xian>ul input').removeAttr('readonly');
				var zd = parseFloat($(this).children('li:nth-child(3)').text());
				var zx = parseFloat($(this).children('li:nth-child(2)').text());
				var t1 = $(this).children('li:nth-child(1)').text();
				if (t1 == '默认') {
					$('.date1').removeClass('input').removeAttr('readonly').val('');
					$('.date2').removeClass('input').removeAttr('readonly').val('');
				} else {
					t1 = t1.split('~');
					$('.date1').val(t1[0]).attr('readonly', 'readonly');
					$('.date2').val(t1[1]).attr('readonly', 'readonly');
				}
				$('.zx').text(zx + '%~');
				$('.zd').text(zd + '%');
				$('.norm-box').hide()
			});
			//选择开始结束日期
			layui.use('laydate', function() {
				var laydate = layui.laydate;
	
				var start = {
					min : '1900-01-01 00:00:00',
					max : '2099-06-16 23:59:59',
					istoday : false,
					choose : function(datas) {
						end.min = datas; //开始日选好后，重置结束日的最小日期
						end.start = datas //将结束日的初始值设定为开始日
					}
				};
	
				var end = {
					min : laydate.now(),
					max : '2099-06-16 23:59:59',
					istoday : false,
					choose : function(datas) {
						start.max = datas; //结束日选好后，重置开始日的最大日期
					}
				};
	
				$(document.getElementById('LAY_demorange_1')).click(function() {
					if ($(this).attr('readonly')) {
	
					} else {
						start.elem = this;
						laydate(start);
					}
	
				})
				$(document.getElementById('LAY_demorange_2')).click(function() {
	
					if ($(this).attr('readonly')) {
	
					} else {
						end.elem = this
						laydate(end);
					}
				})
			})
	
	
	
	
			$('body').on('input propertychange', '.x-in', function() {
				this.value = this.value.match(/\d+(\.\d{0,2})?/) ? this.value.match(/\d+(\.\d{0,2})?/)[0] : '';
				if ($('.s-in').val() == "") {
					var zx = parseInt($($('.zx')[0]).text());
					var tzx = $($('.zx')[0]).text();
					var zd = parseInt($($('.zd')[0]).text());
					var tz = parseFloat($(this).val());
					var ttz = $(this).val();
					console.log(ttz.length)
					console.log(tzx)
					if (ttz.length >= tzx.length) {
						if (tz < zx || tz > zd) {
							$(this).val('')
						}
					}
				} else {
					var zx = parseInt($($('.zx')[0]).text());
					var tzx = $($('.zx')[0]).text();
					var dd = parseFloat($('.s-in').val());
					var tz = parseFloat($(this).val());
					var ttz = $(this).val();
					if (ttz.length >= tzx.length) {
						if (tz < zx || tz > dd) {
							$(this).val('')
						}
					}
				}
			});
			$('body').on('input propertychange', '.s-in', function() {
				this.value = this.value.match(/\d+(\.\d{0,2})?/) ? this.value.match(/\d+(\.\d{0,2})?/)[0] : '';
				if ($('.x-in').val() == "") {
					var tzx = $($('.zx')[0]).text();
					var ttz = $(this).val();
					var zx = parseInt($($('.zx')[0]).text());
					var zd = parseInt($($('.zd')[0]).text());
					var tz = parseFloat($(this).val());
					if (ttz.length >= tzx.length) {
						if (tz < zx || tz > zd) {
							$(this).val('')
						}
					}
				} else {
					var zx = parseInt($($('.zx')[0]).text());
					var tzx = $($('.zx')[0]).text();
					var zd = parseInt($($('.zd')[0]).text());
					var dd = parseFloat($('.x-in').val());
					var ttz = $(this).val();
					var tz = parseFloat($(this).val());
					if (ttz.length >= tzx.length) {
						if (tz < dd || tz > zd) {
							$(this).val('')
						}
					}
				}
			})
	
		});
	</script>
	<script type="text/javascript">
		$(function() {
			$('.elect-show').click(function() {
				window.open('${ctxsys}/Product/list?stule=99', 'newwindow', 'height=500,width=800,top=100,left=300,toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no') ;
			});
			$('.elecb-show').click(function() {
				window.open('${ctxsys}/ebArticle/list?stule=99', 'newwindow', 'height=500,width=800,top=100,left=300,toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no') ;
			});
			$('.elecs-show').click(function() {
				window.open('${ctxsys}/PmShopInfo/list?stule=99', 'newwindow', 'height=500,width=800,top=100,left=300,toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no') ;
			});
			$('#menuId').bind('input propertychange', function() {
				console.log('1136')
			});
		});
		function remoenpm() {
			document.getElementById('advertiseTypeObjIds').value = ''
			document.getElementById('imgsval').src = '';
			document.getElementById('pname').innerHTML = '';
		}
		function remoenpms() {
			document.getElementById('advertiseTypeObjIds').value = ''
			document.getElementById('imgsvals').src = '';
			document.getElementById('pnames').innerHTML = '';
		}
		function remoenpma() {
			document.getElementById('advertiseTypeObjIds').value = ''
			document.getElementById('imgsvala').src = '';
			document.getElementById('pnamea').innerHTML = '';
		}
	</script>


	<script type="text/javascript">
		$(function() {
	
	
			var oldIdArr = $(".old-charging-id");
			var oldIdStr = "";
			for (var i = 0; i < oldIdArr.length; i++) {
				if (i == oldIdArr.length - 1) {
					oldIdStr += $(oldIdArr[i]).text();
				} else if (i == 0) {
					oldIdStr += $(oldIdArr[i]).text() + ",";
				} else {
					oldIdStr += $(oldIdArr[i]).text() + ",";
				}
			}
			$("#productChargingIds").val(oldIdStr);
	
			//控制增加加料和清空加料的可用不可用
			$("#type3").change(function() {
	
				//清空表单
				var tdArr = $(".product-charging-table td");
				for (var i = 0; i < tdArr.length; i++) {
					$(tdArr[i]).parent().remove();
				}
	
				//清空加料id
				$("#productChargingIds").val("");
	
				//设置按钮可用或者不可用
				if ($("#type3").val() == "") {
					$(".product-charging-btn").attr("disabled", true);
					$(".product-charging-table").css("display", "none");
				} else {
					$(".product-charging-btn").attr("disabled", false);
					$(".product-charging-table").css("display", "block");
				}
			})
		})
	
		//初始化门店类型和是否支持外卖
		function initShopTypeAndTakeOut() {
			var shopTypeArr = $(".shopType");
			for (var i = 0; i < shopTypeArr.length; i++) {
				if ($(shopTypeArr[i]).val() == '${shopType}') {
					$(shopTypeArr[i]).attr("checked", "checked");
					break;
				}
			}
	
			var takeOutArr = $(".take-out");
			for (var i = 0; i < takeOutArr.length; i++) {
				if ($(takeOutArr[i]).val() == '${ebProduct.isTakeOut}') {
					$(takeOutArr[i]).attr("checked", "checked");
					break;
				}
			}
		}
		//初始化加料
		function initCharging() {
			if ($("#type3").val() != "") {
				$(".product-charging-btn").attr("disabled", false);
				$(".product-charging-table").css("display", "block");
			} else {
				$(".product-charging-btn").attr("disabled", true);
				$(".product-charging-table").css("display", "none");
			}
		}
		//点击增加加料
		function addProductCharging() {
			checkScope();
		}
	
		//点击清空加料
		function clearProductCharging() {
			//清空表单
			var tdArr = $(".product-charging-table td");
			for (var i = 0; i < tdArr.length; i++) {
				$(tdArr[i]).parent().remove();
			}
	
			//清空加料id
			$("#productChargingIds").val("");
		}
	
		//把选中的加料的信息加载到表格中
		//content 的格式为 id|加料名|标签名|价格,id|加料名|标签名|价格
		function addTableTr(chooseIds, cNames, sellPrices, lables) {
			if (chooseIds == undefined || chooseIds == "") {
				return false;
			}
			var chooseIdArr = chooseIds.split(",");
			var cNameArr = cNames.split(",");
			var sellPriceArr = sellPrices.split(",");
			var lableArr = lables.split(",");
	
			$("#productChargingIds").val(chooseIdArr.toString());
			$("#charging-tbody").empty();
			for (var i = 0; i < chooseIdArr.length; i++) {
	
				//拼凑tr标签
				//验证是否已经存在该id
				// var chargingIds = $("#productChargingIds").val()
				// if(chargingIds.indexOf(chooseIdArr[i]) >= 0){
				//     continue;
				// }
				var tdConentStr = "<tr chargingId='" + chooseIdArr[i] + "'>"
				tdConentStr += "<td>" + cNameArr[i] + "</td>"
				tdConentStr += "<td>" + lableArr[i] + "</td>"
				tdConentStr += "<td>" + sellPriceArr[i] + "</td>"
	
	
				tdConentStr += "<td style='cursor: pointer;color:#69AC72;'onclick=removeProductCharging(" + chooseIdArr[i] + ")>" + "删除" + "</td>"
				tdConentStr += "</tr>"
	
				$("#charging-tbody").append(tdConentStr);
	
			// if($("#productChargingIds").val()==""){
			//     $("#productChargingIds").val(chooseIdArr[i]);
			// }else{
			//     var oldVal = $("#productChargingIds").val();
			//     $("#productChargingIds").val(oldVal+","+chooseIdArr[i]);
			// }
			}
	
			$("#charging-tbody").css("display", "block");
		}
	
		//删除某一行
		function removeProductCharging(productChargingId) {
			var trArr = $(".product-charging-table tr");
	
			//删除表单指定一行
			for (var i = 0; i < trArr.length; i++) {
				if ($(trArr[i]).attr("chargingId") != undefined && $(trArr[i]).attr("chargingId") == productChargingId) {
					$(trArr[i]).remove();
				}
			}
			var ids = $("#productChargingIds").val();
			// ids.indexOf(","+productChargingId)
			// ids.indexOf(productChargingId)
			//清空非第一个id
			ids = ids.replace("," + productChargingId, "");
			//清空最后一个id
			ids = ids.replace(productChargingId + ",", "");
			//清空其他的
			ids = ids.replace(productChargingId, "");
	
			$("#productChargingIds").val(ids)
		}
	
		function checkScope() {
			if ($("#type3").val() != "") {
				layer.open({
					type : 2,
					title : '加料列表',
					shadeClose : true,
					shade : false,
					maxmin : true, //开启最大化最小化按钮
					area : [ '880px', '450px' ],
					content : '${ctxsys}/EbProductCharging/chooseProductCharging?productTypeId=' + $("#type3").val() + "&chooseIds=" + $("#productChargingIds").val(),
					btn : [ '确定', '关闭' ],
					yes : function(index, layero) { //或者使用btn1
						var chooseIds = layero.find("iframe")[0].contentWindow.$('#chooseIds').val();
						var cNames = layero.find("iframe")[0].contentWindow.$('#cNames').val();
						var sellPrices = layero.find("iframe")[0].contentWindow.$('#sellPrices').val();
						var lables = layero.find("iframe")[0].contentWindow.$('#lables').val();
	
						if (chooseIds != "") {
							addTableTr(chooseIds, cNames, sellPrices, lables);
							layer.close(index);
						}
					}
				});
			}
		// }
		// $("#cids").css("display","none");
		// } if($("#productType").val()=="2"){
		//     $("#cids").css("display","block");
		//     $("#productTypeId").val("");请输入规格
		//     $("#porcId").css("display","none");
		// } else{
		//     $("#cids").css("display","none");
		//     $("#productTypeId").val("");
		}
	
		// }
	</script>


	<script type="text/javascript">
		function showShopName() {
			$("#shop-name-modal").modal("show");
			var index = 1;
	
			if ($("#shopNames").val() != "") {
				index = 1;
				var shopNameArr = $("#shopNames").val().split(",");
				$("#choose-shop-name-div").empty();
				var table = "<table class='table table-striped'id='shop-name-table'>" +
					"<tr>" +
					"<th >序号</th>" +
					"<th >门店名</th>" +
					"</tr>"
	
	
				for (var i = 0; i < shopNameArr.length; i++) {
					var tr = "<tr>";
					tr += "<td>" + (index++) + "</td>"
					tr += "<td>" + shopNameArr[i] + "</td>"
					tr += "</tr>"
					table += tr;
				}
	
				table + "</table>"
	
				$("#choose-shop-name-div").html(table)
			}
		}
	
		function clearChooseShop() {
			$("#shopNames").val("");
			$("#shopIds").val("");
		}
	</script>
	<script type="text/javascript">
		function chooseShop(type) {
			if (type == 1) {
				layer.open({
					type : 2,
					title : '门店列表',
					shadeClose : true,
					shade : false,
					maxmin : true, //开启最大化最小化按钮
					area : [ '880px', '450px' ],
					content : '${ctxsys}/Product/chooseShops?shopIds=' + $("#shopIds").val(),
					btn : [ '确定', '关闭' ],
					yes : function(index, layero) { //或者使用btn1
						content = layero.find("iframe")[0].contentWindow.$('#chooseIds').val();
						var names = layero.find("iframe")[0].contentWindow.$('#shopNames').val();
						if (content == "") {
							layer.msg("请先选中一行");
							$("#shopIds").val(content);
						} else {
							$("#shopIds").val(content);
							$("#shopNames").val(names);
							layer.close(index);
						}
	
					}
				})
			}
	
		}
	</script>
</body>
</html>