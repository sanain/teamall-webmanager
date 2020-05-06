<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>积分商品列表</title>
	<meta name="decorator" content="default"/>
	<link rel="stylesheet" href="${ctxStatic}/sbShop/css/build.css">
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
		.radio-box{display:none;width: 500px;background: #ffffff;position: absolute;top: 50%;left: 50%;margin-left: -200px;margin-top: -200px;}
		.radio-btn{text-align: center;padding-bottom: 20px}
        .radio-btn a{display: inline-block;width: 80px;height: 30px;line-height: 30px;border-radius: 5px;border: 1px solid #dcdcdc}
        .radio-btn a:nth-child(1){background: #68C250;border: 1px solid #68C250;color: #ffffff;margin-right: 5px}
        .radio-btn a:nth-child(2){color: #666666;margin-left: 5px}
        .radio-box>p{height: 35px;line-height: 35px;background: #f0f0f0;position: relative;text-align: center}
        .radio-box>p img{position: absolute;top:12px;right: 15px;cursor: pointer}
        .radio-box>p a{color:#68C250;position:absolute;left:15px;top:0px}
        .radio-box ul{overflow: hidden;padding: 10px;outline:none;list-style:none}
        .radio-box ul li{float: left;width: 30%;line-height: 30px;margin-top: 0;}
        .check-box ul li.checkbox input{position:relative;left:8px}
        .check{position: fixed;top:0;left: 0;right: 0;bottom: 0;background: rgba(0,0,0,0.3);z-index: 10000}
        .check-box{width: 750px;background: #ffffff;position: absolute;top: 50%;left: 50%;margin-left: -375px;margin-top: -200px;}
        .check-box>p{height: 35px;line-height: 35px;background: #f0f0f0;position: relative;text-align: center}
        .check-box>p img{position: absolute;top:12px;right: 15px;cursor: pointer}
        .check-box>p a{color:#68C250;position:absolute;left:15px;top:0px}
        .check-box ul{overflow: hidden;padding: 10px;outline:none;list-style:none}
        .check-box ul li.checkbox{float: left;width: 30%;line-height: 30px;margin-top: 0;}
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
        .radio4{display:none;position:fixed;top:0;left:0;bottom:0;right:0;}
        .radio4 .radio4-box{position:absolute;width:250px;height:150px;top:50%;left:50%;margin-top:-75px;margin-left:-125px;background:#fff;border:1px solid #dcdcdc}
        .radio4-box>p{height: 35px;line-height: 35px;background: #f0f0f0;position: relative;text-align: center}
        .radio4-box>p img{position: absolute;top:12px;right: 15px;cursor: pointer}
        .radio4-box ul{overflow: hidden;padding: 10px;outline:none;list-style:none}
        .radio4-box ul li{float: left;width: 50%;line-height: 30px;margin-top: 0;}
    </style>
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
    	
    	$('.check-a2').click(function(){
    		$('.radio-box').show();
    	});
    	$('body').on('click','.check-del1',function(){
    		$('.check1').hide();
    		$('.radio-box').hide();
    	});
    	
    	$('.radio4-del').click(function(){
    		$('.radio4').hide()
    	});
    	$('.check-a4').click(function(){
    		$('.radio4').show()
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
	          $("#searchForm").attr("action","${ctxsys}/Product/Orderlist");
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
		  var product;
	 function editGStatus(){
	    $.ajax({
			type: "POST",
			url: "${ctxsys}/Product/getzijin",
			data: {productId:product},
			success: function(data){
			 page();
		    }
	      });
	  }
	  function editGProstatus(productId){
		  product=productId;
		    var msg="";
			  msg="是改变该商品的流向";
			confirmx(msg,editGStatus);
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
    </script>
    <script type="text/javascript">
    function loke(vals,id,price,img,redweb){
       window.opener.document.getElementById('advertiseTypeObjIds').value=id;
       if(window.opener.document.getElementById('price')!=null||window.opener.document.getElementById('price')!=undefined){
       window.opener.document.getElementById('price').innerHTML=price;
       }
       if(window.opener.document.getElementById('prices')!=null||window.opener.document.getElementById('prices')!=undefined){
       window.opener.document.getElementById('prices').innerHTML=price;
       }
       window.opener.document.getElementById('imgsval').src=""+img.split("|")[0];
       window.opener.document.getElementById('pname').innerHTML=vals;
       window.opener.document.getElementById('pname').title=vals;
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
		<shiro:hasPermission name="merchandise:pro:view"><li class="active"><a href="${ctxsys}/Product/Orderlist">商品列表</a></li></shiro:hasPermission>
		<shiro:hasPermission name="merchandise:pro:edit"><li><a href="${ctxsys}/Product/form" >商品添加</a></li></shiro:hasPermission> 
	</ul>
	 <form:form id="searchForm" modelAttribute="ebProduct" action="${ctxsys}/Product/Orderlist" method="post" class="breadcrumb form-search ">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
		<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form">
		      <form:hidden path="isLovePay" value="1"/>
		      <input type="hidden" name="shopId" value="${shopId}">
			 <input type="hidden" name="stule" value="${stule}">
		     <li><label>商品名字:</label><form:input path="productName" htmlEscape="false" maxlength="50" class="input-medium"  placeholder="请输入商品名字"/></li>
			 <c:if test="${stule!='99'}">
			 <li><label>门店名称:</label><form:input path="shopName" htmlEscape="false" maxlength="50" class="input-medium"  placeholder="请输入门店名称"/></li>
			 <li><label>分&nbsp;&nbsp;类:</label><tags:treeselect id="menu" name="productTypeId" value="${sbProductType.id}" labelName="productTypeStr" labelValue="${sbProductType.productTypeStr}" title="菜单" url="${ctxsys}/PmProductType/treeData" extId="${sbProductType.id}" cssClass="required input-medium"/></li>
			</c:if>
			 <li><label>商品状态:</label>
			    <form:select path="prdouctStatus" class="input-medium">
			      <form:option value="">全部</form:option>
			      <form:option value="0">下架</form:option>
			      <form:option value="1">上架</form:option>
			    </form:select>
			 </li>
			 <li><label>商品模式:</label>
			    <form:select path="productViewMall" class="input-medium">
			      <form:option value="">全部</form:option>
			      <form:option value="2">积分商城</form:option>
			      <form:option value="3">普通+积分商城</form:option>
			    </form:select>
			 </li>
			  <li><label>流向:</label>
			    <form:select path="lovePayGain" class="input-medium">
			      <form:option value="">全部</form:option>
			      <form:option value="1">固定账号</form:option>
			      <form:option value="2">商家</form:option>
			    </form:select>
			 </li>
			  <li><label>商品标签:</label>
			    <select name="productTags" id="productTags" class="input-medium" >
			    </select>
			 </li>
			 <li><label style="width: 110px;">是否消费金支付:</label>
			    <form:select path="isConsumptionPointsPay" class="input-medium">
			      <form:option value="">全部</form:option>
			      <form:option value="0">否</form:option>
			      <form:option value="1">是</form:option>
			    </form:select>
			 </li>
		      <li><label style="width:90px;"><select name="podateType" value="${podateType}" style="width:90px;"><!-- <option value="1">发布时间</option> --><option value="2">上架时间</option></select></label>
		         <input class="small" type="text" style=" width: 100px;" name="statrDate" id="create_time_start" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" value="${statrDate}" placeholder="请输入开始时间"/>
		       --<input class="small" type="text" name="stopDate" id="stoptime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" style=" width: 100px;" value="${stopDate}" placeholder="请输入结束时间"/>
			  <li><label></label><label><select name="priceType" value="${priceType}" id="priceType" style="width:80px;"><option value="1">销售价</option><option value="2">结算价</option><option value="3">市场价</option></select></label>:
			    <input class="small" type="text" style=" width: 100px;" name="statrPrice"   value="${statrPrice}" placeholder="请输入最小价格"/>
			  --<input class="small" type="text" name="stopPrice"   style=" width: 100px;" value="${stopPrice}" placeholder="请输入最大价格"/></li>
		     <li><label style="width:90px;">比例区间</label><input  type="text" style=" width: 100px;" name="lovePayMinRatio" value="${lovePayMinRatio}" placeholder="请输入下限"/>%
			  --<input  type="text" name="lovePayMaxRatio"   style=" width: 100px;"   value="${lovePayMaxRatio}"  placeholder="请输入上限"/>%</li>
		</ul>
		<ul class="ul-form"> 
		     <li><input id="btnSubmit" class="btn btn-primary " type="submit" value="查询" onclick="return page();"/></li>
		     <shiro:hasPermission name="merchandise:pro:edit">
	         <li><button type="button" class="btn btn-primary check-a1" >导出</button></li>
	         </shiro:hasPermission>
	         <li><button type="button" class="btn btn-primary check-a2" >上架</button></li>
	         <li><button type="button" class="btn btn-primary check-a3" >下架</button></li>
	         <li><button type="button" class="btn btn-primary check-a4" >流向</button></li>
		</ul>
		<div class="radio4">
			<div class="radio4-box">
		        <p>流向<img class="radio4-del" src="${ctxStatic}/sbShop/images/xxx-rzt.png" alt=""></p>
		          <ul class="mn1">
		          <li><input type="radio" class="" checked="checked" name="lovePayGains" value="2"><label><i></i>商家</label></li>
		          <li><input type="radio" class="" name="lovePayGains" value="1"><label><i></i>固定账号</label></li>
		          </ul>
		        <div class="check-btn">
		            <a href="javascript:;" class="radio4-ckel" >确定</a>
		            <a class="radio4-del" href="javascript:;">取消</a>
		        </div>
	        </div>
		</div>
		
		<div class="check1">
    <div class="check-box">
        <p>导出选项<img class="check-del1" src="${ctxStatic}/sbShop/images/xxx-rzt.png" alt=""></p>
          <ul class="mn1">
          <li class="checkbox"><input type="checkbox" class="kl" value="" id="all"><label><i></i>全选</label></li>
          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="1"><label><i></i>商品名称</label></li>
          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="2"><label><i></i>商品图片</label></li>
          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="3"><label><i></i>所属分类</label></li>
          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="4"><label><i></i>市场价</label></li>
          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="5"><label><i></i>销售价</label></li>
          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="6"><label><i></i>结算价</label></li>
          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="7"><label><i></i>门店名称</label></li>
          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="8"><label><i></i>商品状态</label></li>
          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="9"><label><i></i>创建时间</label></li>
          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="10"><label><i></i>上架时间</label></li>
          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="11"><label><i></i>让利比</label></li>
          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="12"><label><i></i>收藏量</label></li>
          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="13"><label><i></i>月销量</label></li>
          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="14"><label><i></i>品牌</label></li>
          </ul>
        <div class="check-btn">
            <a href="javascript:;" id="fromNewActionSbM" >确定</a>
            <a class="check-del1" href="javascript:;">取消</a>
        </div>
      </div>
    </div>
    <div class="radio-box">
        <p>上架选项<img class="check-del1" src="${ctxStatic}/sbShop/images/xxx-rzt.png" alt=""></p>
          <ul class="mn1">
          <li><input type="radio" class="kl" name="productViewMallt"  value="1"><label><i></i>普通商城</label></li>
          <li><input type="radio" class="kl" name="productViewMallt" checked="checked" value="2"><label><i></i>积分商城</label></li>
          <li><input type="radio" class="kl" name="productViewMallt" value="3"><label><i></i>普通+积分商城</label></li>
          </ul>
        <div class="radio-btn">
            <a href="javascript:;" id="fromNewActionSbMs" >确定</a>
            <a class="check-del1" href="javascript:;">取消</a>
        </div>
      </div>
    </div>
	<tags:message content="${message}"/>
	<table  class="table table-striped table-condensed table-bordered" >
		<tr>
		<th class="center123"><input type="checkbox"  class="kty" value="" id="allu"></th>
		<th class="center123">商品名称</th>
		<th class="center123">商品图片</th>
		<th class="center123">所属分类</th>
		<th class="center123 sort-column sellPrice">销售价</th>
		<c:if test="${stule!='99'}">
		<th class="center123 sort-column costPrice">结算价</th>
		<th class="center123 sort-column marketPrice">市场价</th>
		<th class="center123 sort-column returnRatio">让利比</th>
		<th class="center123">品牌</th>
		<th class="center123 sort-column upTime">上架时间</th>
		<th class="center123 sort-column favorite">收藏量</th>
		<th class="center123 sort-column monthSalesAmount">月销量</th>
		</c:if>
		<th class="center123">门店名称</th>
		<th class="center123 sort-column isRecommend">推荐</th>
		<th class="center123  sort-column lovePayGain">流向(固定账号/商家)</th>
		<th class="center123">比例区间</th>
		<th class="center123">是否消费金支付</th>
		<shiro:hasPermission name="merchandise:pro:edit">
		<th class="center123">状态</th>
		</shiro:hasPermission>
		<th class="center123 sort-column createTime" >创建时间</th>
		<th>操作</th>
		</tr>
		<c:forEach items="${page.list}" var="productlist" varStatus="status">
			<tr>
			    <td class="center123"><input type="checkbox" name="ktvs" class="kty"  value="${productlist.productId}"></td>
				<td class="center123">
				   <a href="${ctxweb}/ProductDetailsHtml/${productlist.productId}.html">${fns:abbr(productlist.productName,13)}</a>
				</td>
				<td class="center123"><img class="fu" src="${fn:split(productlist.prdouctImg,'|')[0]}"style="width:30px;height:30px"/><img class="kla" style="display:none;position:fixed;top:30%;left:40%" alt="" src="${fn:split(productlist.prdouctImg,'|')[0]}"></td>
				<td class="center123">${fns:getsbProductTypeName(productlist.productTypeId).productTypeStr}</td>
				<td class="center123"> ${productlist.sellPrice}</td>
				<c:if test="${stule!='99'}">
				<td class="center123">${productlist.costPrice}</td>
				<td class="center123">${productlist.marketPrice}</td>
				<td class="center123">${productlist.returnRatio}</td>
				<td class="center123">${productlist.brandName}</td>
				<td class="center123">${productlist.upTime}</td>
				<td class="center123">${productlist.favorite}</td>
				<td class="center123">${productlist.monthSalesAmount}</td>
				</c:if>
				<td class="center123">${productlist.shopName}</td>
				<td class="center123">
				    <c:if test="${productlist.isRecommend==0|| empty productlist.isRecommend}">否</c:if><c:if test="${productlist.isRecommend==1}">是</c:if>|<c:if test="${productlist.isRecommend==0|| empty productlist.isRecommend}"><a onclick="eaitIsRecommend('${productlist.productId}','${productlist.isRecommend}')" >是</a></c:if><c:if test="${productlist.isRecommend==1}"><a onclick="eaitIsRecommend('${productlist.productId}','${productlist.isRecommend}')" >否</a></c:if>
				</td>
				<td class="center123">
				     <c:if test="${productlist.lovePayGain==1}">固定账号</c:if><c:if test="${productlist.lovePayGain==2}">商家</c:if>|<c:if test="${productlist.lovePayGain==2}">
				     <a onclick="editGProstatus(${productlist.productId})" >固定账号</a></c:if>
				     <c:if test="${productlist.lovePayGain==1}">
				     <a onclick="editGProstatus(${productlist.productId})" >商家</a></c:if>
				</td>
				<td class="center123">${productlist.lovePayMinRatio}%~${productlist.lovePayMaxRatio}%</td>
				<td class="center123">
				    <c:if test="${productlist.isConsumptionPointsPay==0|| empty productlist.isConsumptionPointsPay}">否</c:if><c:if test="${productlist.isConsumptionPointsPay==1}">是</c:if>|<c:if test="${productlist.isConsumptionPointsPay==0|| empty productlist.isConsumptionPointsPay}"><a onclick="eaitIsisConsumptionPointsPay('${productlist.productId}','${productlist.isConsumptionPointsPay}')" >是</a></c:if><c:if test="${productlist.isConsumptionPointsPay==1}"><a onclick="eaitIsisConsumptionPointsPay('${productlist.productId}','${productlist.isConsumptionPointsPay}')" >否</a></c:if>
				</td>
				<shiro:hasPermission name="merchandise:pro:edit">
				<td class="center123">
				   <c:if test="${productlist.prdouctStatus==3|| empty productlist.prdouctStatus}"> 已删除 </c:if>
				   <c:if test="${productlist.prdouctStatus!=3 && not empty productlist.prdouctStatus}">
				   <c:if test="${productlist.prdouctStatus==0}">下架</c:if>
				   <c:if test="${productlist.prdouctStatus==1}">上架<c:if test="${productlist.productViewMall==1}">(普通商城)</c:if><c:if test="${productlist.productViewMall==2}">(积分商城)</c:if><c:if test="${productlist.productViewMall==3}">(普通商城+积分商城)</c:if></c:if>
				  </c:if>
				</td>
				</shiro:hasPermission>
				<td class="center123">${productlist.createTime}</td>
			    <td>
				    <c:if test="${stule!='99'}">
				      <a href="${ctxsys}/Product/show?productId=${productlist.productId}">查看</a>
				       <shiro:hasPermission name="merchandise:pro:edit">
				        <a onclick="writable(${productlist.productId},'${productlist.productTags}')">设置标签</a>
				      </shiro:hasPermission>
				    </c:if>
			        <c:if test="${stule=='99'}">
			         <shiro:hasPermission name="merchandise:pro:edit">
			            <a onclick="loke('${productlist.productName}','${productlist.productId}','${productlist.reasonablePrice}','${productlist.prdouctImg}','${productlist.rewardDeeds}')" >选择</a>
			          </shiro:hasPermission>
			        </c:if>
				</td>
			</tr>
		</c:forEach>
	</table>
	<div class="pagination">${page}</div>
  </form:form> 
  <form action="${ctxsys}/Product/saveTags" id="fromsb">
    <div class="check">
    <div class="check-box">
        <p><a href="${ctxsys}/EbLabel">去添加</a> 导出选项<img class="check-del" src="${ctxStatic}/sbShop/images/xxx-rzt.png" alt=""></p>
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
	  $('#all').click(function(){
        if($(this).is(':checked')){
            $('.kl').prop('checked',true).attr('checked',true);
            $('#all').prop('checked',true).attr('checked',true);
        }else {
            $('.kl').removeAttr('checked');
            $('#all').removeAttr('checked');
        }
    });
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
    });
	$('body').on('click','.kl',function(){
        if ($('.kl').length==$('.kl[type=checkbox]:checked').length){
            $('#all').prop('checked',true).attr('checked',true);
        }else {
            $('#all').removeAttr('checked');
        }
    })
    $('.radio4-ckel').click(function(){
        $.ajax({
		    type : "POST",
		    data:$('#searchForm').serialize(),
		    url : "${ctxsys}/Product/getliu",
		    beforeSend:function(){
			$(".run-ball-box").show();
			},success : function (data) {
		     $(".run-ball-box").hide();
		     if(data.code=="00"){
		      showTip(data.msg);
		      page();
		     }else if(data.code=="01"){
		     alertx(data.msg);
		     }
		    }
         });
    })
     $('.check-a3').click(function(){
      $.ajax({
		    type : "POST",
		    data:$('#searchForm').serialize(),
		    url : "${ctxsys}/Product/getzijinUp",
		    beforeSend:function(){
			$(".run-ball-box").show();
			},success : function (data) {
		     $(".run-ball-box").hide();
		     if(data.code=="00"){
		      showTip(data.msg);
		      page();
		     }else if(data.code=="01"){
		     alertx(data.msg);
		     }
		    }
         });
  	  });
     $('#fromNewActionSbMs').click(function(){
        $.ajax({
		    type : "POST",
		    data:$('#searchForm').serialize(),
		    url : "${ctxsys}/Product/getzijinSave",
		    beforeSend:function(){
			$(".run-ball-box").show();
			},success : function (data) {
		     $(".run-ball-box").hide();
		     if(data.code=="00"){
		      showTip(data.msg);
		      page();
		     }else if(data.code=="01"){
		       alertx(data.msg);
		     }
		    }
         });
     });
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
	</script>
</body>
</html>