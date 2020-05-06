<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="robots" content="noarchive">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0,minimal-ui">
    <title>商品列表</title>
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/warehouse-comm.css">
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/bootstrap.min.css">
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/build.css">
    <script src="${ctxStatic}/sbShop/js/jquery.min.js"></script>
    <script src="${ctxStatic}/sbShop/js/base_form.js"></script>
    <script src="${ctxStatic}/sbShop/js/warehouse-comm.js"></script>
    <script src="${ctxStatic}/sbShop/js/kkk.js"></script>
     <style type="text/css">
    	.xcq{display:none;position:fixed;z-index:10000;background:rgba(0,0,0,0.4);top:0;left:0;right:0;bottom:0;}
    	.xcq-b{position:absolute;width:300px;height:200px;text-align:center;background:#fff;top:50%;left:50%;margin-left:-150px;margin-top:-100px;border-radius: 5px;overflow:hidden;}
    	.xcq p{height:35px;line-height:35px;text-align:center;background:#f0f0f0;}
    	.xcq span{display:inline-block;margin:15px 0 20px 0;}
    	.xcq div{text-align:center;}
    	.xcq a{display:inline-block;width:80px;height:30px;line-height:30px;text-align:center;color:#fff;background:#4778C7;border-radius: 5px;}
    </style>
    <script>
    $(window.parent.document).find('.list-ul').find('ul').slideUp();
    $(window.parent.document).find('.list-ul').find('a').removeClass('active');
    </script>
    <script type="text/javascript">
    $(window.parent.document).find('.list-ul').find('a').removeClass('hove');
    $(window.parent.document).find('.comm').siblings('ul').find('li:nth-child(3)').children('a').addClass('hove');
    $(function(){
    		$('.xcq a').click(function(){
    		 location.href="${ctxweb}/shop/product/list2?storeNums=0";
    		$('.xcq').hide();
    	   });
    	 });
		$(document).ready(function() {
		 $.ajax({
				type: "POST",
				url: "${ctxweb}/shop/product/classOne",
				data: {},
				success: function(data){
				  var html="<option value=''>全部类别</option>";
				  var s="${ebProduct.productTypeParentId}";
				  for(var i=0;i<data.length;i++){
					  if(data[i].id==s){
					  html+="<option value='"+data[i].id+"' selected='selected'>"+data[i].productTypeName+"</option>";
					  }else{
					  html+="<option value='"+data[i].id+"' >"+data[i].productTypeName+"</option>";
					  }
				    }
				    $("#select").html(html);
				  }
				});
		});
		  function page(n,s){
			if(n) $("#pageNo").val(n);
			if(s) $("#pageSize").val(s);
			$("#searchForm").attr("action","${ctxweb}/shop/product/list2?prdouctStatus=1");
			$("#searchForm").submit();
	    	return false;
	    }
	     function tyep(type){
	        var id_array=new Array();  
			$('input[name="ids"]:checked').each(function(){  
			    id_array.push($(this).val());//向数组中添加元素  
			});  
			var idstr=id_array.join(',');
	        $.ajax({
				type: "POST",
				url: "${ctxweb}/shop/product/saveIds",
				data: {ids:idstr,type:type},
				success: function(data){
				 if(type=='1'){
				 	$('.xcq').show();
				   $(".message").html("您的商品经过我们平台审核，约30分钟可以和大家见面");
				  }else if(type=='2'){
				  	$('.xcq').show();
				    $(".message").html("删除成功");
				  }
			   }
			});
			
	    }
	      function save(id,hh){
	        var text=$(hh).siblings('textarea').val();
	    	$.ajax({
				type: "POST",
				url: "${ctxweb}/shop/product/saveName",
				data: {id:id,name:$(hh).prev().val()},
				success: function(data){
				  }
				});
	    }
	</script>
</head>
<body>
    <div class="house">
        <ul class="house-nav">
            <li class=" putaway"><a href="${ctxweb}/shop/product/list?prdouctStatus=0">等待上架的商品</a></li>
            <li class="active sell-out"><a href="${ctxweb}/shop/product/list2?storeNums=0">全部卖完的商品</a></li>
        </ul>
        <form action="" id="searchForm" method="post" >
            <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
			<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
			<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
        <div class="house-div">
            <ul>
                <li>商品名称：</li>
                <li><input name="productName" type="text" value="${ebProduct.productName}"></li>
            </ul>
            <ul>
                <li>商家编码：</li>
                <li><input type="text" name="barCode"  value="${ebProduct.barCode}"></li>
            </ul>
            <ul>
                <li>一级类目：</li>
                <li>
                   <select id="select" name="productTypeParentId" value="${ebProduct.productTypeParentId}">
                   </select>
                </li>
            </ul>
            <ul class="two-inp">
                <li>价格：</li>
                <li>
                    <input class="num" type="text" name="statrPrice" value="${statrPrice}">
                    <span>到</span>
                    <input class="num" type="text" name="stopPrice" value="${stopPrice}">
                </li>
            </ul>
            <ul class="two-inp">
                <li>总销量：</li>
                <li>
                    <input class="num" type="text"  name="starpmun" value="${starpmun}">
                    <span>到</span>
                    <input class="num" type="text"  name="stopmun" value="${stopmun}">
                </li>
            </ul>
            <!-- <ul class="div-fenlei">
                <li>门店中的分类：</li>
                <li>
                    <input readonly class="readonly" type="text">
                    <div class="fenlei">
                        <p>全部分类</p>
                        <ul class="fenlei-ul">
                            <li>
                                <b></b>
                                <span>水果</span>
                                <ul>
                                    <li><span>苹果</span></li>
                                    <li><span>干货</span></li>
                                </ul>
                            </li>
                            <li>
                                <b></b>
                                <span>蔬菜</span>
                                <ul>
                                    <li><span>白菜</span></li>
                                    <li><span>香菜</span></li>
                                </ul>
                            </li>
                        </ul>
                    </div>
                </li>
            </ul> -->
            <!-- <ul>
                <li></li>
                <li class="checkbox">
                    <input id="yunf" type="checkbox">
                    <label for="yunf"><i></i>免运费</label>
                </li>
            </ul> -->
        </div>
        
        <div class="two-btn">
           <input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/>
           
        </div>
        </form>
        <div class="house-list">
            <ul class="house-list-top">
                <li></li>
                <li>商品名称</li>
                <li>价格</li>
                <li>库存</li>
                <li><a href="javascript:;">总销量</a></li>
                <li><a href="javascript:;">创建时间</a></li>
             <!--    <li><a href="javascript:;">结束时间</a></li> -->
                <li>操作</li>
            </ul>
            <p>
                <span class="checkbox1">
                    <input class="quanxuan" type="checkbox">
                    全选
                </span>
                <a class="del-ul" onclick="tyep(2)" >删除</a>
                <a href="javascript:;" onclick="tyep(1)">上架</a>
            </p>
            <div class="house-list-body">
            <c:forEach items="${page.list}" var="list">
                <ul>
                    <li>
                        <span class="checkbox1" style="position:relative;display: block;">
                            <input type="checkbox" name="ids" value="${list.productId}">
                            <label></label>
                        </span>
                    </li>
                    <li>
                        <div class="img-kuang">
                            <img src="${fn:split(list.prdouctImg,'|')[0]}"  alt="">
                        </div>
                        <u>${list.productName}</u>
                        <span class="area">
                            <textarea maxlength="40"></textarea>
                            <a class="area-a" href="javascript:;" onclick="save(${list.productId},this)">保存</a>
                        </span>
                        <img class="bianji" src="${ctxStatic}/sbShop/images/icon_bianji_h.png" alt="">
                    </li>
                    <li>¥<b><fmt:formatNumber type="number" value="${list.sellPrice}" pattern="0.00" maxFractionDigits="2"/></b></li>
                    <li>${list.storeNums}</li>
                    <li>${list.sale}</li>
                    <li>
                        <p>${list.createTime}</p>
                        <span></span>
                    </li>
                    <%-- <li>
                        <p>${list.createTime}</p>
                        <span></span>
                    </li> --%>
                    <li>
                        <a href="${ctxweb}/shop/product/from?productId=${list.productId}">编辑商品</a>
                        <br>
                         <a href="${ctxweb}/ProductDetailsHtml/${list.productId}.html">查看商品</a>
                    </li>
                </ul>
                </c:forEach>
            </div>
           <!--  <p>
                <span class="checkbox">
                    <input class="quanxuan" type="checkbox">
                    <label><i></i>全选</label>
                </span>
                <a class="del-ul" onclick="tyep(2)" >删除</a>
                <a href="javascript:;" onclick="tyep(1)">上架</a>
            </p> -->
        </div>
        <!--分页-->
       <div class="pagination">
         ${page}
        </div>
        <!--备注-->
        <div class="beizhu">
            <b>备注：</b>
            <span>您可以将希望上架出售的商品打勾，然后按 <u>"上架"</u>的确认键，您的商品经过我们平台审核，约30分钟可以和大家见面。</span>
        </div>
    </div>
      <div class="xcq">
    	<div class="xcq-b">
	    <p>提示</p>
		<span class="message" data-tid="${messager}" style="padding: 13px;">${messager}</span>
		<div>
			<a href="javascript:;">确认</a>
		</div>
   </div>
    </div>
</body>
</html>
