<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="robots" content="noarchive">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0,minimal-ui">
    <title>出售的商品</title>
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
    $(function(){
    		$('.xcq a').click(function(){
    		 location.href="${ctxweb}/shop/product/list3";
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
		 
		  $("#reset").click(function(){
			  $("#select").val("");
			  $(".house-div").find("input").each(function(){ 
	        		$(this).attr("value","");
				})	
			 });
		});
		function page(n,s){
			if(n) $("#pageNo").val(n);
			if(s) $("#pageSize").val(s);
			if("${stule}"!=99){
			$("#searchForm").attr("action","${ctxweb}/shop/product/list3?prdouctStatus=1");
			}else{
			$("#searchForm").attr("action","${ctxweb}/shop/product/list4");
			}
			
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
				if(data=='01'){
				 alert("推荐数已满");
				 }else if(data=='03'){
				   $(".message").html("请选择至少一个");
				   	$('.xcq').show();
				 }else if(data=='00'){
				  if(type=='0'){
				   $(".message").html("您的商品下架成功");
				   	$('.xcq').show();
				  }else if(type=='4'){
				    $(".message").html("推荐成功");
				    $('.xcq').show();
				  }else if(type=='5'){
				    $(".message").html("取消推荐成功");
				    $('.xcq').show();
				  }
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
	    function loke(vals,id,price,img){
	       window.opener.document.getElementById('advertiseTypeObjId').value=id;
	       window.opener.document.getElementById('imgsval').src=img;
	       window.opener.document.getElementById('pname').title=vals;
	       window.opener.document.getElementById('pname').innerHTML=vals;
	       window.open("about:blank","_self").close();
       }
	</script>
</head>
<body>
    <div class="house">
        <ul class="house-nav">
           <c:if test="${stule!=99}">
            <li class="active putaway"><a href="${ctxweb}/shop/product/list3?prdouctStatus=0">出售的商品</a></li>
            </c:if>
            <c:if test="${stule==99}">
            <li class="active putaway"><a>选择商品</a></li>
            </c:if>
        </ul>
        <form action="" id="searchForm" method="post" >
            <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
			<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
			<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
			<input name="stule" type="hidden" value="${stule}">
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
           <!--  <ul class="div-fenlei">
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
            </ul>
            <ul>
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
               <!--  <li><a href="javascript:;">结束时间</a></li> -->
                <li>操作</li>
            </ul>
            <c:if test="${stule!=99}">
            <p>
                <span class="checkbox1">
                    <input class="quanxuan" type="checkbox">
                    全选
                </span>
                <a class="del-ul" href="javascript:;" onclick="tyep(0)">下架</a>
                <a class="del-ul" href="javascript:;" onclick="tyep(4)">推荐</a>
                <a class="del-ul" href="javascript:;" onclick="tyep(5)">取消推荐</a>
            </p>
            </c:if>
            <div class="house-list-body">
            <c:forEach items="${page.list}" var="list">
                <ul>
                    <li>
                        <span class="checkbox1"  style="position:relative;display: block;">
                            <input type="checkbox" name="ids" value="${list.productId}">
                            <label></label>
                            <c:if test="${list.isShopRecommend==0|| empty list.isShopRecommend }">
                            <b style="position: absolute;top: 4px;right: 8px;"><img src="${ctxStatic}/sbShop/images/yi.png"/></b>
                        	</c:if>
                        	<c:if test="${list.isShopRecommend==1}">
                            <b style="position: absolute;top: 4px;right: 8px;"><img src="${ctxStatic}/sbShop/images/wei.png"/></b>
                        	</c:if>
                        </span>
                       
                    </li>
                    <li>
                        <div class="img-kuang">
                            <img src="${fn:split(list.prdouctImg,'|')[0]}" alt="">
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
                   <%--  <li>
                        <p>${list.createTime}</p>
                        <span></span>
                    </li> --%>
                    <li>
                      <c:if test="${stule!=99}">
                        <a href="${ctxweb}/shop/product/from?productId=${list.productId}">编辑商品</a>
                        <br>
                        <a href="${ctxweb}/ProductDetailsHtml/${list.productId}.html">查看商品</a>
                        </c:if>
                         <c:if test="${stule==99 }">
                           <a onclick="loke('${list.productName}','${list.productId}','${list.marketPrice}','${fn:split(list.prdouctImg,'|')[0]}')">选择</a>
                         </c:if>
                    </li>
                </ul>
                </c:forEach>
            </div>
          
        </div>
        <!--分页-->
       <div class="pagination">
         ${page}
        </div>
        <!--备注-->
         <c:if test="${stule!=99}">
        <%--<div class="beizhu">
            <b>备注：</b>
            <span>您可以将希望下架的商品打勾，然后按 <u>"下架"</u>的确认键，立即下架。</span>
        </div>
        --%></c:if>
    </div>
    <div class="xcq">
    	<div class="xcq-b">
	    <p>提示</p>
		<span class="message" data-tid="${messager}">${messager}</span>
		<div>
			<a href="javascript:;">确认</a>
		</div>
   </div>
    </div>
</body>
</html>
