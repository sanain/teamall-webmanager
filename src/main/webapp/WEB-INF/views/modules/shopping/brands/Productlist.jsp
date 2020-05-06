<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%
	String path = request.getContextPath();

	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
%>
<html>
<head>
	<title>商品列表</title>
	<meta name="decorator" content="default"/>
	<link href="${ctxStatic}/jquery-jbox/2.3/Skins/Default/jbox.css?v=1" type="text/css" rel="stylesheet" />
	<link rel="stylesheet" href="${ctxStatic}/sbShop/css/build.css">
	<link href="${ctxStatic}/supplyshop/layui/css/modules/layer/default/layer.css?v=1" type="text/css" rel="stylesheet" />
	<script src="${ctxStatic}/supplyshop/layui/lay/modules/layer.js?v=1" type="text/javascript"></script>
	<script src="${ctxStatic}/sbShop/layui/layui.js"></script>
	<link href="${ctxStatic}/supplyshop/layui/css/modules/layer/default/layer.css?v=1" type="text/css" rel="stylesheet" />
	<script src="${ctxStatic}/supplyshop/layui/lay/modules/layer.js?v=1" type="text/javascript"></script>

	<script src="${ctxStatic}/jquery-jbox/2.3/jquery.jBox-2.3.js?v=1" type="text/javascript"></script>
	<style>
		/*运动的球效果*/
		.run-ball-box{
			text-align: center;
			position: fixed;
			top: 0;
			left: 0;
			right: 0;
			bottom: 0;
			background: rgba(0,0,0,0.3);
			color: #ffffff;
			z-index:100000000;
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
			margin-left: -30px;;
		}
		.sh-ju{
			position: absolute;top: 50%;left: 50%;margin-top: 50px;margin-left: -36px;
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

		@-webkit-keyframes sk-innerCircle {
			0% {
				-webkit-transform: rotate(0deg);
			}
			100% {
				-webkit-transform: rotate(360deg);
			}
		}
		@-moz-keyframes sk-innerCircle {
			0% {
				-moz-transform: rotate(0deg);
			}
			100% {
				-moz-transform: rotate(360deg);
			}
		}
		@-o-keyframes sk-innerCircle {
			0% {
				-o-transform: rotate(0deg);
			}
			100% {
				-o-transform: rotate(360deg);
			}
		}
		@keyframes sk-innerCircle {
			0% {
				transform: rotate(0deg);
			}
			100% {
				transform: rotate(360deg);
			}
		}
		.sb-xian{padding-bottom: 20px;background: #ffffff;clear:both;margin-bottom:20px}
		.sb-xian>p{height: 35px;line-height: 35px;background: #F0F0F0;color: #4B4B4B;padding-left: 25px}
		.sb-xian .checkbox{display: inline-block}
		.sb-xian>ul{display:none}
		.sb-xian ul li{margin-bottom: 15px;}
		.sb-xian .checkbox i{top:4px;left:-19px}
		.sb-xian ul li:nth-child(1)>span{position:relative;top:-9px}
		.sb-xian ul li>span{display: inline-block;width: 100px;text-align: right;margin-right: 10px;height:30px;line-height:30px}
		.sb-xian input[type=text]{outline: none;border: 1px solid #DCDCDC;padding: 0 10px;height: 30px;}
		.sb-xian ul li:nth-child(2) input{width: 150px;}
		.sb-xian ul li:nth-child(3) input{width: 60px;text-align: center;margin-right: 15px;}
		.sb-xian ul li:nth-child(4) input{width: 60px;text-align: center;margin-right: 15px;}
		.sb-xian-b b{display: inline-block;width: 100px;font-weight: normal;text-align: right;margin-right: 10px;}
		.sb-xian-b{padding-bottom: 15px;margin-bottom: 20px;border-bottom: 1px solid #CCCCCC}
		.sb-xian b{font-weight: normal}
		.norm{display: inline-block;position: relative}
		.norm>span{display: block;cursor: pointer;width: 200px;height: 30px;line-height: 30px;border: 1px solid #DCDCDC;padding-left: 10px;padding-right: 30px;background: url("../images/zhankai1.png") no-repeat 179px 11px;overflow: hidden; text-overflow: ellipsis; white-space: nowrap; word-wrap: break-word}
		.norm-box{position: absolute;width: 350px;display: none}
		.norm-box ul{width: 100%;border: 1px solid #DCDCDC;overflow:hidden}
		.norm-box ul:nth-child(1){background: #f0f0f0;text-align: center;height: 30px;}
		.norm-box ul li:nth-child(1){width: 60%;text-align: center}
		.norm-box ul li:nth-child(2){width: 20%;text-align: center}
		.norm-box ul li:nth-child(3){width: 20%;text-align: center}
		.norm-box ul li{margin-bottom: 0;float:left;line-height:30px;}
		.norm-box ul{background: #ffffff;margin-bottom: 0;}
		.norm-box ul li{text-align: center;height: 30px;border-right: 1px solid #DCDCDC;color: #666666;cursor: pointer}
		.pic-list{padding-left:25px;}
	</style>
	<style>
		.check{position: fixed;top:0;left: 0;right: 0;bottom: 0;background: rgba(0,0,0,0.3);z-index: 10000}
		.check-box{width: 750px;background: #ffffff;position: absolute;top: 50%;left: 50%;margin-left: -375px;margin-top: -200px;}
		.check-box>p{height: 35px;line-height: 35px;background: #f0f0f0;position: relative;text-align: center}
		.check-box>p img{position: absolute;top:12px;right: 15px;cursor: pointer}
		.check-box>p a{color:#68C250;position:absolute;left:15px;top:0px}
		.check-box ul{overflow: hidden;padding: 10px;outline:none;list-style:none}
		.check-box ul li.checkbox{float: left;width: 30%;line-height: 30px;margin-top: 0;}
		.check-box ul li.checkbox input{position:relative;left:8px}
		.check-btn{text-align: center;padding-bottom: 20px}
		.check-btn a{display: inline-block;width: 80px;height: 30px;line-height: 30px;border-radius: 5px;border: 1px solid #dcdcdc}
		.check-btn a:nth-child(1){background: #68C250;border: 1px solid #68C250;color: #ffffff;margin-right: 5px}
		.check-btn a:nth-child(2){color: #666666;margin-left: 5px}
		.check-box .checkbox input[type="checkbox"]:checked + label::before {
			background: #68C250;
			top:0 px;
			border: 1px solid #68C250;
		}
		.check-box .checkbox label::before{
			top: 0px;
		}
		.check-box .checkbox i{
			position: absolute;
			width: 12px;
			height: 8px;
			background: url(../images/icon_pick.png) no-repeat;
			top: 4px;
			left: -18px;
			cursor: pointer;
		}
		.check-box .checkbox input{top: 10px;position:relative}
	</style>

	<script type="text/javascript">
        $(function(){
            $('#all').click(function(){
                if($(this).is(':checked')){
                    console.log('1')
                    $('.kl').attr('checked','checked');
                    $('#all').attr('checked','checked');
                }else {
                    console.log('2')
                    $('.kl').removeAttr('checked');
                    $('#all').removeAttr('checked');
                }
            });
            $('body').on('click','.kl',function(){
                if ($('.kl').length==$('.kl[type=checkbox]:checked').length){
                    $('#all').attr('checked','checked');
                }else {
                    $('#all').removeAttr('checked');
                }
            })
            $('#fromNewActionSbM').click(function(){
                $.ajax({
                    type : "POST",
                    data:$('#searchForm').serialize(),
                    url : "${ctxsys}/Product/exsel",
                    beforeSend:function(){
                        $(".run-ball-box").show();
                    },success : function (data) {
                        $(".run-ball-box").hide();
                        window.location.href=data;
                    }
                });
            });
        })

	</script>

	<script type="text/javascript">
        $(function(){
            eblabelLs();//加载标签
            $(".run-ball-box").hide();
            $("#priceType").val("${priceType}");
            $('body').on('mouseover','.fu',function(){$(this).siblings('.kla').show()});
            $('body').on('mouseout','.fu',function(){$(this).siblings('.kla').hide()});
            $('.check').hide();
            $('body').on('click','.check-a',function(){
                $('.check').show();
            });

            $('body').on('click','.check-del',function(){
                $('.check').hide();
            });

            $('.check1').hide();
            $('body').on('click','.check-a1',function(){
                $('.check1').show();
            });

            $('body').on('click','.check-del1',function(){
                $('.check1').hide();
            });
        })
        function writable(a,va){
            $("#ids").val(a);
            var html="";
            $.ajax({
                type: "POST",
                url: "${ctxsys}/Product/classOne",
                data: {"type":"1"},
                success: function(data){
                    for(var i=0;i<data.length;i++){
                        if(va!=null){
                            var strs= new Array();
                            strs= va.split(",");
                            if(strs!=null){
                                html+="<li class='checkbox'><input type='checkbox' name='tag' value='"+data[i].id+"'";
                                for(var j=0;j<strs.length;j++){
                                    if(strs[j]==data[i].id){
                                        html+="  checked='checked'  ";
                                    }
                                }
                                html+="><label><i></i>"+data[i].name+"</label></li>";
                            }
                        }
                    }
                    $(".mn").html(html);
                }
            });
            $('.check').show();
        }
        function sbmit(){
            $("#fromsb").submit();

        }
        function page(n,s){
            if(n) $("#pageNo").val(n);
            if(s) $("#pageSize").val(s);
            $("#searchForm").attr("action","${ctxsys}/Product/list?shopType=${shopType}");
            $("#searchForm").submit();
            return false;
        }
        function eblabelLs(){
            $.ajax({
                type: "POST",
                url: "${ctxsys}/EbLabel/eblabelLs",
                data: {},
                success: function(data){
                    var html='<option value="">全部</option>';
                    var productTagname="${productTags}";
                    for(var i=0;i<data.length;i++){
                        if(productTagname==data[i].name){
                            html+="<option value="+data[i].name+" selected='selected'>"+data[i].name+"</option>";
                        }else{
                            html+="<option value="+data[i].name+">"+data[i].name+"</option>";
                        }
                    }
                    $("#productTags").html(html);
                }
            });
        }


        //商品状态改变
        var product;
        function editStatus(){
            $.ajax({
                type: "POST",
                url: "${ctxsys}/Product/editProstatus",
                data: {productId:product},
                success: function(data){
                    page();
                }
            });
        }
        function editProstatus(productId,status){
            product=productId;
            var msg="";

            if('${findType}' == '1'){
                if(status==1){
                    msg="是否把该商品下架";
                }else{
                    msg="是否把该商品上架";
                }
            }else{
                if(status==1){
                    msg="是否把所有门店的该商品下架";
                }else{
                    msg="是否把所有门店的该商品上架";
                }
            }

            confirmx(msg,editStatus);
        }
        function IsRecommend(){
            $.ajax({
                type: "POST",
                url: "${ctxsys}/Product/eaitIsRecommend",
                data: {productId:product},
                success: function(data){
                    page();
                }
            });
        }
        //商品推荐状态
        function eaitIsRecommend(productId,status){
            var msg="";
            product=productId;
            if(status==1){
                msg="是否把该商品推荐移除";
            }else{
                msg="是否把该商品推荐至首页";
            }
            confirmx(msg,IsRecommend);
        }
        //开启消费金
        function eaitIsisConsumptionPointsPay(productId,isConsumptionPointsPay){
            var msg="";
            product=productId;
            if(isConsumptionPointsPay==0){
                msg="开启消费金支付";
            }else{
                msg="关闭消费金支付";
            }
            confirmx(msg,IsisConsumptionPointsPay);
        }
        function IsisConsumptionPointsPay(){
            $.ajax({
                type: "POST",
                url: "${ctxsys}/Product/eaitIsisConsumptionPointsPay",
                data: {productId:product},
                success: function(data){
                    if(data.code=='00'){
                        alertx(data.msg);
                        page();
                    }else{
                        alertx(data.msg);
                    }
                }
            });
        }

        //是否进入激活专区
        function eaitIsisActivateProduct(productId,isActivateProduct){
            var msg="";
            product=productId;
            if(isConsumptionPointsPay==0){
                msg="该商品是否进入激活专区";
            }else{
                msg="是否关闭该商品进入激活专区";
            }
            confirmx(msg,IsisActivateProduct);
        }
        function IsisActivateProduct(){
            $.ajax({
                type: "POST",
                url: "${ctxsys}/Product/eaitIsisActivateProduct",
                data: {productId:product},
                success: function(data){
                    if(data.code=='00'){
                        alertx(data.msg);
                        page();
                    }else{
                        alertx(data.msg);
                    }
                }
            });
        }

        var status;
        function isProductStatus(sTatus){
            var msg="";
            status=sTatus;
            if(status==1){
                msg="是否商品批量上架";
            }else if(status==0){
                msg="是否商品批量下架";
            }else{
                msg="是否批量删除商品";
            }
            confirmx(msg,editProductStatus);
        }
        function editProductStatus(){
            var id_array=new Array();
            $('input[name="ktvs"]:checked').each(function(){
                id_array.push($(this).val());//向数组中添加元素
            });
            var idstr=id_array.join(',');
            $.ajax({
                type: "POST",
                url: "${ctxsys}/Product/puStatusUpdw",
                data: {ktvs:idstr,status:status},
                beforeSend: function(){
                    loading('请等待。。');
                },
                success: function(data){

                    if(data.code=="00"){
                        showTip(data.msg);
                        page();
                    }else if(data.code=="01"){
                        alertx(data.msg);
                        page();
                    }
                }
            });
        }

	</script>
	<script type="text/javascript">
        function loke(vals,id,price,img,redweb,marketPrice,sale,poorTotal,middleTotal,goodTotal){
            window.opener.document.getElementById('advertiseTypeObjIds').value=id;
            if(window.opener.document.getElementById('price')!=null||window.opener.document.getElementById('price')!=undefined){
                window.opener.document.getElementById('price').innerHTML=price;
            }
            if(window.opener.document.getElementById('prices')!=null||window.opener.document.getElementById('prices')!=undefined){
                window.opener.document.getElementById('prices').innerHTML=price;
            }
            var poor = poorTotal == null ? 0 :poorTotal;
            var middle = middleTotal== null ? 0 : middleTotal;
            var good = goodTotal == null ? 0 : goodTotal;
            var all = poor + middle + good;
            var ty = 0;
            if (all != 0) {
                ty = Double.valueOf(good) / Double.valueOf(all);
            }
            if(window.opener.document.getElementById('saleValue')!=null||window.opener.document.getElementById('saleValue')!=undefined){
                window.opener.document.getElementById('saleValue').innerHTML=ty;
            }
            if(window.opener.document.getElementById('marketPrice')!=null||window.opener.document.getElementById('marketPrice')!=undefined){
                window.opener.document.getElementById('marketPrice').innerHTML=marketPrice;
            }
            if(window.opener.document.getElementById('sale')!=null||window.opener.document.getElementById('sale')!=undefined){
                window.opener.document.getElementById('sale').innerHTML=sale;
            }
            if(window.opener.document.getElementById('pname')!=null||window.opener.document.getElementById('pname')!=undefined){
                window.opener.document.getElementById('pname').innerHTML=vals;
            }
            if(window.opener.document.getElementById('imgsval')!=null||window.opener.document.getElementById('imgsval')!=undefined){
                window.opener.document.getElementById('imgsval').src=""+img.split("|")[0];
            }
            if(window.opener.document.getElementById('pname')!=null||window.opener.document.getElementById('pname')!=undefined){
                window.opener.document.getElementById('pname').innerHTML=vals;
                window.opener.document.getElementById('pname').title=vals;
            }
            if(window.opener.document.getElementById('redweb')!=null||window.opener.document.getElementById('redweb')!=undefined){
                window.opener.document.getElementById('redweb').innerHTML=redweb;
            }

            window.open("about:blank","_self").close();
        }
	</script>
</head>
<body>
<div class="run-ball-box">
	<div class="run-ball"><span class="sk-inner-circle"></span></div>
	<div class="sh-ju">数据加载中...</div>
</div>
<ul class="nav nav-tabs">
	<shiro:hasPermission name="merchandise:pro:view"><li class="active"><a href="${ctxsys}/Product/list">商品列表</a></li></shiro:hasPermission>
	<shiro:hasPermission name="merchandise:pro:edit"><li><a href="${ctxsys}/Product/form" >商品添加</a></li></shiro:hasPermission>
</ul>
<form:form id="searchForm" modelAttribute="ebProduct" action="${ctxsys}/Product/list" method="post" class="breadcrumb form-search ">
	<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
	<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
	<ul class="ul-form">
		<input type="hidden" name="shopId" value="${shopId}">
		<input type="hidden" name="stule" value="${stule}">
		<li><label style="width: 90px;margin-right: 4px">商品名字:</label><form:input path="productName" htmlEscape="false" maxlength="50" class="input-medium"  placeholder="请输入商品名字"/></li>
		<c:if test="${stule!='99'}">
			<%--<li><label>门店名称:</label><form:input path="shopName" htmlEscape="false" maxlength="50" class="input-medium"  placeholder="请输入门店名称"/></li>--%>
			<li><label>分&nbsp;&nbsp;类:</label>
				<tags:treeselect id="menu" name="productTypeId" value="${sbProductType.id}" labelName="productTypeStr" labelValue="${sbProductType.productTypeStr}" title="菜单" url="${ctxsys}/PmProductType/treeData" extId="${sbProductType.id}" cssClass="required input-medium"/></li>
		</c:if>
		<li><label>商品状态:</label>
			<form:select path="prdouctStatus" class="input-medium">
				<form:option value="">全部</form:option>
				<form:option value="0">下架</form:option>
				<form:option value="1">上架</form:option>
			</form:select>
		</li>
		<li class="clearfix"></li>
		<li><label style="width:90px;"><select name="podateType" value="${podateType}" style="width:90px;"><!-- <option value="1">发布时间</option> --><option value="2">上架时间</option></select></label>
			<input class="small" type="text" style=" width: 100px;" name="statrDate" id="create_time_start" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" value="${statrDate}" placeholder="请输入开始时间"/>
			--<input class="small" type="text" name="stopDate" id="stoptime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" style=" width: 100px;" value="${stopDate}" placeholder="请输入结束时间"/>
		<li><label>
			<select name="priceType" value="${priceType}" id="priceType" style="width:80px;">
				<option value="1">销售价</option>
				<option value="2">结算价</option>
					<%--<option value="3">市场价</option>--%>
			</select>
		</label>:
			<input class="small" type="text" style=" width: 100px;" name="statrPrice"   value="${statrPrice}" placeholder="请输入最小价格"/>
			--<input class="small" type="text" name="stopPrice"   style=" width: 100px;" value="${stopPrice}" placeholder="请输入最大价格"/></li>
		<li><label>商品标签:</label>
			<select name="productTags" id="productTags" class="input-medium" >
			</select>
		</li>

		<li><label>显示方式:</label>
			<input class="form-check-input" onclick="changeFindType(1)" type="radio" style="padding: 10px 0px" name="findType" value="1" <c:if test="${findType == 1}">checked</c:if>/>根据商品展示
			<input class="form-check-input" onclick="changeFindType(0)"  type="radio" style="padding: 10px 0px" name="findType" value="0" <c:if test="${findType != 1}">checked</c:if>/>根据门店展示
		</li>

		<li id="chooseShopLi" style="display: none"><label>选择门店:</label>
			<select name="isAllShop" id="isAllShop" class="input-medium" onchange="chooseShopType()">
				<option value="1" ${isAllShop == 1 ? 'selected':''}>全部门店</option>
				<option value="0"  ${isAllShop == 0 ? 'selected':''}>指定门店</option>
			</select>
		</li>
		<input type="hidden" id="chooseShopId" value="${chooseShopId}" name="chooseShopId"/>
			<%--<li><label style="width: 110px;">是否积分支付:</label>--%>
			<%--<form:select path="isLovePay" class="input-medium">--%>
			<%--<form:option value="">全部</form:option>--%>
			<%--<form:option value="0">否</form:option>--%>
			<%--<form:option value="1">是</form:option>--%>
			<%--</form:select>--%>
			<%--</li>--%>
			<%--<li><label style="width: 110px;">是否消费金支付:</label>--%>
			<%--<form:select path="isConsumptionPointsPay" class="input-medium">--%>
			<%--<form:option value="">全部</form:option>--%>
			<%--<form:option value="0">否</form:option>--%>
			<%--<form:option value="1">是</form:option>--%>
			<%--</form:select>--%>
			<%--</li>--%>
			<%--<li><label style="width: 120px;">是否激活专区商品:</label>--%>
			<%--<form:select path="isActivateProduct" class="input-medium">--%>
			<%--<form:option value="">全部</form:option>--%>
			<%--<form:option value="0">否</form:option>--%>
			<%--<form:option value="1">是</form:option>--%>
			<%--</form:select>--%>
			<%--</li>--%>
	</ul>
	<ul class="ul-form">
		<li style="margin-left: 10px"><input id="btnSubmit" class="btn btn-primary " type="submit" value="查询" onclick="return page();"/></li>
		<li style="margin-left: 10px"><shiro:hasPermission name="merchandise:pro:edit"><button type="button" class="btn btn-primary check-a1" >导出</button> </shiro:hasPermission>
		</li>
		<li style="margin-left: 10px"><button type="button" class="btn btn-primary " onclick="isProductStatus('1')" >上架</button></li>
		<li style="margin-left: 10px"><button type="button" class="btn btn-primary " onclick="isProductStatus('0')" >下架</button></li>
		<li style="margin-left: 10px"><button type="button" class="btn btn-primary " onclick="isProductStatus('3')" >删除</button></li>
	</ul>
	<div class="check1">
		<div class="check-box">
			<p>导出选项<img class="check-del1" src="${ctxStatic}/sbShop/images/xxx-rzt.png" alt=""></p>
			<form id="fromNewAction">
				<ul class="mn1">
					<li class="checkbox"><input type="checkbox" class="kl" value="" id="all"><label><i></i>全选</label></li>
					<c:if test="${findType!=1}">
						<li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="门店名称,shopName"><label><i></i>门店名称</label></li>
					</c:if>
					<li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="商品名称,productName"><label><i></i>商品名称</label></li>
					<li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="商品图片,prdouctImg"><label><i></i>商品图片</label></li>
					<li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="所属分类,productTypeName"><label><i></i>所属分类</label></li>
					<li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="销售价,sellPrice"><label><i></i>销售价</label></li>
					<li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="会员价,memberPrice"><label><i></i>会员价</label></li>
					<li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="商品状态,prdouctStatus"><label><i></i>商品状态</label></li>
					<li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="创建时间,createTime"><label><i></i>创建时间</label></li>
					<li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="上架时间,upTime"><label><i></i>上架时间</label></li>
						<%--<li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="月销量"><label><i></i>月销量</label></li>--%>
				</ul>
			</form>
			<div class="check-btn">
				<a href="javascript:;" id="fromNewActionSbM" >确定</a>
				<a class="check-del1" href="javascript:;">取消</a>
			</div>
		</div>
	</div>
</form:form>
<tags:message content="${message}"/>
<table  class="table table-striped table-condensed table-bordered" >
	<tr>
		<th class="center123"><input type="checkbox"  class="kty" value="" id="allu"></th>
		<th class="center123" style="width:150px">商品名称</th>
		<c:if test="${findType == 0}">
			<th class="center123" style="width:150px">门店名称</th>
		</c:if>
		<th class="center123">商品图片</th>
		<th class="center123">所属分类</th>
		<th class="center123">销售价</th>
		<c:if test="${fns:isShowWeight()}">
			<th class="center123">计量类型</th>
		</c:if>
		<th class="center123">库存</th>
		<c:if test="${stule!='99'}">
			<%--<th class="center123">是否积分支付</th>--%>
			<%--<th class="center123">积分</th>--%>
			<th class="center123">会员价</th>
			<%--<th class="center123 sort-column marketPrice">市场价</th>--%>
			<%--<th class="center123 sort-column returnRatio">折扣比</th>--%>
			<%--<th class="center123">品牌</th>--%>
			<th class="center123">上架时间</th>
			<%--<th class="center123 sort-column favorite">收藏量</th>--%>
			<th class="center123">月销量</th>
		</c:if>
		<%--<th class="center123">门店名称</th>--%>
		<%--<th class="center123">是否消费金支付</th>--%>
		<%--<th class="center123">是否激活专区商品</th>--%>
		<%--<th class="center123 sort-column isRecommend">推荐</th>--%>
		<shiro:hasPermission name="merchandise:pro:edit">
			<th class="center123">状态</th>
		</shiro:hasPermission>
		<th class="center123" >创建时间</th>
		<th>操作</th>
	</tr>
	<c:forEach items="${ebProductList}" var="productlist" varStatus="status">
		<tr>
			<td class="center123"><input type="checkbox" name="ktvs" class="kty"  value="${productlist.productId}"></td>
			<td class="center123">
				<a href="${ctxweb}/ProductDetailsHtml/${productlist.productId}.html" style="width:150px" title="${productlist.productName}" >${fns:abbr(productlist.productName,20)}</a>
			</td>
			<c:if test="${findType == 0}">
				<td class="center123">
					<a href="${ctxsys}/PmShopInfo/shopinfo?id=${pmShopInfoList[status.index].id}" style="width:150px" title="${pmShopInfoList[status.index].shopName}" >${pmShopInfoList[status.index].shopName}</a>
				</td>
			</c:if>
			<td class="center123"><img class="fu product-img" src="${fn:split(productlist.prdouctImg,'|')[0]}"style="width:30px;height:30px"/><img class="kla" style="display:none;position:fixed;top:30%;left:40%" alt="" src="${fn:split(productlist.prdouctImg,'|')[0]}"></td>
			<td class="center123">${fns:getsbProductTypeName(productlist.productTypeId).productTypeStr}</td>
			<td class="center123">
				<c:if test="${findType == 1}">
					${productlist.sellPrice}
				</c:if>
				<c:if test="${findType == 0}">
					${ebShopProductList[status.index].sellPrice  == null ? ebShopProductList[status.index].sellPriceRange : ebShopProductList[status.index].sellPrice}
				</c:if>
			</td>

			<c:if test="${fns:isShowWeight()}">
				<td class="center123">
					<c:if test="${findType == 0}">
						<font >
								${ ebShopProductList[status.index].measuringType == null || ebShopProductList[status.index].measuringType==1  ? "件":"重量"}
						</font>
					</c:if>
					<c:if test="${findType == 1}">
						<font >
								${productlist.measuringType == null || productlist.measuringType==1  ? "件":"重量"}
						</font>
					</c:if>
				</td>
			</c:if>
			<td class="center123">
				<font <c:if test="${ebShopProductList[status.index].storeNums<=10}">color="red"</c:if>>
					<c:if test="${findType == 0}">
						${fns:replaceStoreNum(ebShopProductList[status.index].measuringType,ebShopProductList[status.index].measuringUnit,ebShopProductList[status.index].storeNums)}
						<%--${ ebShopProductList[status.index].storeNums}--%>
						<c:if test="${fns:isShowWeight()}">
							<c:if test="${ebShopProductList[status.index].measuringType == 2 &&  ebShopProductList[status.index].measuringUnit==1 }">
								公斤
							</c:if>
							<c:if test="${ebShopProductList[status.index].measuringType == 2 &&  ebShopProductList[status.index].measuringUnit==2 }">
								克
							</c:if>
							<c:if test="${ebShopProductList[status.index].measuringType == 2 &&  ebShopProductList[status.index].measuringUnit==3 }">
								斤
							</c:if>
						</c:if>
					</c:if>
					<c:if test="${findType == 1}">
						${fns:replaceStoreNum(productlist.measuringType,productlist.measuringUnit,productlist.storeNums)}
						<c:if test="${fns:isShowWeight()}">
							<c:if test="${productlist.measuringType == 2 &&  productlist.measuringUnit==1 }">
								公斤
							</c:if>
							<c:if test="${productlist.measuringType == 2 &&  productlist.measuringUnit==2 }">
								克
							</c:if>
							<c:if test="${productlist.measuringType == 2 &&  productlist.measuringUnit==3 }">
								斤
							</c:if>
						</c:if>
					</c:if>




				</font>
			</td>
			<c:if test="${stule!='99'}">
				<%--<td class="center123"> <c:if test="${empty productlist.isLovePay||productlist.isLovePay==0}">否</c:if><c:if test="${productlist.isLovePay==1}">是</c:if> </td>--%>
				<%--<td class="center123">${productlist.rewardDeeds}</td>--%>
				<td class="center123">
					<c:if test="${findType == 1}">
						${productlist.memberPrice}
					</c:if>
					<c:if test="${findType == 0}">
						${ebShopProductList[status.index].memberPrice == null ? ebShopProductList[status.index].memberPriceRange : ebShopProductList[status.index].memberPrice}
					</c:if>

				</td>
				<%--<td class="center123">${productlist.marketPrice}</td>--%>
				<%--<td class="center123">${productlist.returnRatio}</td>--%>
				<%--<td class="center123">${productlist.brandName}</td>--%>
				<td class="center123">${productlist.upTime}</td>
				<%--<td class="center123">${productlist.favorite}</td>--%>
				<td class="center123">${productlist.monthSalesAmount}</td>
			</c:if>
				<%--<td class="center123">${productlist.shopName}</td>--%>
				<%--<td class="center123">--%>
				<%--<c:if test="${productlist.isConsumptionPointsPay==0|| empty productlist.isConsumptionPointsPay}">否</c:if><c:if test="${productlist.isConsumptionPointsPay==1}">是</c:if>|<c:if test="${productlist.isConsumptionPointsPay==0|| empty productlist.isConsumptionPointsPay}"><a onclick="eaitIsisConsumptionPointsPay('${productlist.productId}','${productlist.isConsumptionPointsPay}')" >是</a></c:if><c:if test="${productlist.isConsumptionPointsPay==1}"><a onclick="eaitIsisConsumptionPointsPay('${productlist.productId}','${productlist.isConsumptionPointsPay}')" >否</a></c:if>--%>
				<%--</td>--%>
				<%--<td class="center123">--%>
				<%--<c:if test="${productlist.isActivateProduct==0|| empty productlist.isActivateProduct}">否</c:if><c:if test="${productlist.isActivateProduct==1}">是</c:if>|<c:if test="${productlist.isActivateProduct==0|| empty productlist.isActivateProduct}"><a onclick="eaitIsisActivateProduct('${productlist.productId}','${productlist.isActivateProduct}')" >是</a></c:if><c:if test="${productlist.isActivateProduct==1}"><a onclick="eaitIsisActivateProduct('${productlist.productId}','${productlist.isActivateProduct}')" >否</a></c:if>--%>
				<%--</td>--%>
				<%--<td class="center123">--%>
				<%--<c:if test="${productlist.isRecommend==0|| empty productlist.isRecommend}">否</c:if><c:if test="${productlist.isRecommend==1}">是</c:if>|<c:if test="${productlist.isRecommend==0|| empty productlist.isRecommend}"><a onclick="eaitIsRecommend('${productlist.productId}','${productlist.isRecommend}')" >是</a></c:if><c:if test="${productlist.isRecommend==1}"><a onclick="eaitIsRecommend('${productlist.productId}','${productlist.isRecommend}')" >否</a></c:if>--%>
				<%--</td>--%>
			<shiro:hasPermission name="merchandise:pro:edit">

				<td class="center123">
				<c:if test="${productlist.prdouctStatus==3|| empty productlist.prdouctStatus}">
					已删除
				</c:if>
				<c:if test="${productlist.prdouctStatus!=3 && not empty productlist.prdouctStatus}">
					<c:if test="${productlist.prdouctStatus==0}">
						下架
					</c:if>
					<c:if test="${productlist.prdouctStatus==1}">
						上架
					</c:if>|
					<c:if test="${productlist.prdouctStatus==0|| empty productlist.prdouctStatus}">
						<a onclick="editProstatus('${productlist.productId}','${productlist.prdouctStatus}')">上架</a>
					</c:if>
					<c:if test="${productlist.prdouctStatus==1}">
						<a onclick="editProstatus('${productlist.productId}','${productlist.prdouctStatus}')" >下架</a>
					</c:if>

					</td>
				</c:if >
			</shiro:hasPermission>
			<td class="center123">
				<c:if test="${findType == 1}">
					${productlist.createTime}
				</c:if>
				<c:if test="${findType == 0}">
					${ebShopProductList[status.index].createTime}
				</c:if>
			</td>
			<td>
				<c:if test="${stule!='99'}">
					<c:if test="${findType == 0}">
						<a href="${ctxsys}/Product/show?productId=${productlist.productId}&findType=${findType}&espShopId=${ebShopProductList[status.index].shopId}">查看</a>
					</c:if>

					<c:if test="${findType == 1}">
						<a href="${ctxsys}/Product/show?productId=${productlist.productId}&findType=${findType}">查看</a>
					</c:if>

					<c:if test="${findType == 1}">
						<a href="javascript:;" onclick="opendShopByProduct('${productlist.productId}')">查看门店</a>
					</c:if>
					<shiro:hasPermission name="merchandise:pro:edit">
						<a onclick="writable(${productlist.productId},'${productlist.productTags}')">设置标签</a>
					</shiro:hasPermission>
				</c:if>
				<c:if test="${stule=='99'}">
					<shiro:hasPermission name="merchandise:pro:edit">
						<a onclick="loke('${productlist.productName}','${productlist.productId}','${productlist.sellPrice}','${productlist.prdouctImg}','${productlist.rewardDeeds}','${productlist.marketPrice}','${productlist.sale}','${productlist.poorTotal}','${productlist.middleTotal}','${productlist.goodTotal}')" >选择</a>
					</shiro:hasPermission>
				</c:if>
			</td>
		</tr>
	</c:forEach>
</table>
<div class="pagination">${page}</div>

<div id="outerdiv" style="position:fixed;top:0;left:0;background:rgba(0,0,0,0.7);z-index:2;width:100%;height:100%;display:none;">
	<div id="innerdiv" style="position:absolute;">
		<img id="bigimg" style="border:5px solid #fff;" src="" />
	</div>
</div>
<%--<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="exampleModalLabel">导出选项</h4>
      </div>
      <div class="modal-body">
         <form id="fromNewAction">
         <ul class="ul-form" style="list-style:none">
             <li><input type="checkbox" value="" id="all">全选</li>
             <li><input type="checkbox" class="kl" name="syllable" value="1">商品名称</li>
             <li><input type="checkbox" class="kl" name="syllable" value="2">商品图片</li>
             <li><input type="checkbox" class="kl" name="syllable" value="3">所属分类</li>
             <li><input type="checkbox" class="kl" name="syllable" value="4">市场价</li>
             <li><input type="checkbox" class="kl" name="syllable" value="5">销售价</li>
             <li><input type="checkbox" class="kl" name="syllable" value="6">成本价</li>
             <li><input type="checkbox" class="kl" name="syllable" value="7">门店名称</li>
             <li><input type="checkbox" class="kl" name="syllable" value="8">商品状态</li>
             <li><input type="checkbox" class="kl" name="syllable" value="9">创建时间</li>
             <li><input type="checkbox" class="kl" name="syllable" value="10">上架时间</li>
         </ul>

         </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        <button type="button" class="btn btn-primary" id="fromNewActionSbM">确定</button>
      </div>
    </div>
  </div>
</div> --%>


<form action="${ctxsys}/Product/saveTags" id="fromsb">
	<div class="check">
		<div class="check-box">
			<p><a href="${ctxsys}/EbLabel">添加新标签》》</a> 设置商品标签<img class="check-del" src="${ctxStatic}/sbShop/images/xxx-rzt.png" alt=""></p>
			<input type="hidden" value="" name="id" id="ids">
			<ul class="mn">
			</ul>
			<div class="check-btn">
				<a href="javascript:;" onclick="sbmit()">确定</a>
				<a class="check-del" href="javascript:;">取消</a>
			</div>
		</div>
	</div>
</form>

<script type="text/javascript">
    $('body').on('click','.kty',function(){
        if ($('.kty').length==$('.kty[type=checkbox]:checked').length){
            $('#allu').prop('checked',true).attr('checked',true);
        }else {
            $('#allu').removeAttr('checked');
        }
    })
    $('#allu').click(function(){
        if($(this).is(':checked')){
            $('.kty').prop('checked',true).attr('checked',true);
            $('#allu').prop('checked',true).attr('checked',true);
        }else {
            $('.kty').removeAttr('checked');
            $('#allu').removeAttr('checked');
        }
        alert($('#allu').val());
    });
</script>

<%--点击图片放大--%>
<script>
    $(function(){
        $(".product-img").click(function(){
            var _this = $(this);//将当前的pimg元素作为_this传入函数
            imgShow("#outerdiv", "#innerdiv", "#bigimg", _this);
        });
    });

    function imgShow(outerdiv, innerdiv, bigimg, _this){
        var src = _this.attr("src");//获取当前点击的pimg元素中的src属性
        $(bigimg).attr("src", src);//设置#bigimg元素的src属性

        /*获取当前点击图片的真实大小，并显示弹出层及大图*/
        $("<img/>").attr("src", src).load(function(){
            var windowW = $(window).width();//获取当前窗口宽度
            var windowH = $(window).height();//获取当前窗口高度
            var realWidth = this.width;//获取图片真实宽度
            var realHeight = this.height;//获取图片真实高度
            var imgWidth, imgHeight;
            var scale = 0.8;//缩放尺寸，当图片真实宽度和高度大于窗口宽度和高度时进行缩放

            if(realHeight>windowH*scale) {//判断图片高度
                imgHeight = windowH*scale;//如大于窗口高度，图片高度进行缩放
                imgWidth = imgHeight/realHeight*realWidth;//等比例缩放宽度
                if(imgWidth>windowW*scale) {//如宽度扔大于窗口宽度
                    imgWidth = windowW*scale;//再对宽度进行缩放
                }
            } else if(realWidth>windowW*scale) {//如图片高度合适，判断图片宽度
                imgWidth = windowW*scale;//如大于窗口宽度，图片宽度进行缩放
                imgHeight = imgWidth/realWidth*realHeight;//等比例缩放高度
            } else {//如果图片真实高度和宽度都符合要求，高宽不变
                imgWidth = realWidth;
                imgHeight = realHeight;
            }
            $(bigimg).css("width",imgWidth);//以最终的宽度对图片缩放

            var w = (windowW-imgWidth)/2;//计算图片与窗口左边距
            var h = (windowH-imgHeight)/2;//计算图片与窗口上边距
            $(innerdiv).css({"top":h, "left":w});//设置#innerdiv的top和left属性
            $(outerdiv).fadeIn("fast");//淡入显示#outerdiv及.pimg
        });

        $(outerdiv).click(function(){//再次点击淡出消失弹出层
            $(this).fadeOut("fast");
        });
    }
</script>



<script type="text/javascript">
    function opendShopByProduct(productId){
        layer.open({
            type: 2,
            title: '门店列表',
            shadeClose: true,
            shade: false,
            maxmin: true, //开启最大化最小化按钮
            area: ['880px', '450px'],
            content: '${ctxsys}/Product/findShopsByProduct?productId='+productId,
            btn: [ '关闭'],
            yes: function(index, layero){ //或者使用btn1
                // content = layero.find("iframe")[0].contentWindow.$('#chooseIds').val();
                // if(content==""){
                //     layer.msg("请先选中一行");
                //     $("#shopIds").val(content);
                // }else{
                //     $("#shopIds").val(content);
                layer.close(index);
                // }

            }
        })

    }
</script>


<script type="text/javascript">
    $(function(){
        if('${findType}' == 0){
            $("#chooseShopLi").css("display","inline-block")
        }else{
            $("#chooseShopLi").css("display","none")
        }
    })
    <%--控制是否显示选中门店的控件--%>
    function changeFindType(type){
        if(type == 0){
            $("#chooseShopLi").css("display","inline-block")
        }else{
            $("#chooseShopLi").css("display","none")
        }
    }

    //选择指定门店或者全部门店
    function chooseShopType(){
        if($("#isAllShop").val() == 1){
            $("#chooseShopId").val("");
        }else{
            layer.open({
                type: 2,
                title: '门店列表',
                shadeClose: true,
                shade: false,
                maxmin: true, //开启最大化最小化按钮
                area: ['880px', '450px'],
                content: '${ctxsys}/Product/chooseNoSelfShops?chooseIds='+ $("#chooseShopId").val(),
                btn: ['确定', '关闭'],
                yes: function(index, layero){ //或者使用btn1
                    content = layero.find("iframe")[0].contentWindow.$('#chooseIds').val();
                    if(content==""){
                        layer.msg("请先选中一行");
                        $("#chooseShopId").val(content);
                    }else{
                        $("#chooseShopId").val(content);
                        layer.close(index);
                    }

                }
            })
        }

    }
</script>
</body>
</html>