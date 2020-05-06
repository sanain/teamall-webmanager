<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="robots" content="noarchive">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0,minimal-ui">
    <title>${fns:getProjectName()}商家中心</title>
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/batch-manage.css">
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/bootstrap.min.css">
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/build.css">
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/layui/css/layui.css">
    <script src="${ctxStatic}/sbShop/js/jquery.min.js"></script>
    <script src="${ctxStatic}/sbShop/js/kkk.js"></script>
    <script src="${ctxStatic}/sbShop/layui/layui.js"></script>
     <script src="${ctxStatic}/sbShop/js/base_form.js"></script>
    <script src="${ctxStatic}/sbShop/js/batch-manage.js"></script>
    <style>
    	.batch-body .batch-body-right .pagination li{width:auto}
    	.batch-body .batch-body-right .body-ul{margin-bottom:30px;}
    	
    	.batch-body-left ul li a.act{background: #f0f0f0;}
    </style>
     <style>
        .run-ball-box{
            position: fixed;
            top: 0;
            right: 0;
            left: 0;
            bottom: 0;
            z-index: 111111;
            background: rgba(0,0,0,0.3);
        }
        .loadEffect {
            width: 100px;
            height: 100px;
            top: 50%;
            left: 50%;
            margin-top:-50px;
            margin-left: -50px;
            position: absolute;
        }
        .loadEffect div{
            width: 100%;
            height: 100%;
            position: absolute;
            -webkit-animation: load 2.08s linear infinite;
        }
        .loadEffect div span{
            display: inline-block;
            width: 20px;
            height: 20px;
            border-radius: 50%;
            background: #5988D8;
            position: absolute;
            left: 50%;
            margin-top: -10px;
            margin-left: -10px;
        }
        @-webkit-keyframes load{
            0%{
                -webkit-transform: rotate(0deg);
            }
            10%{
                -webkit-transform: rotate(45deg);
            }
            50%{
                opacity: 1;
                -webkit-transform: rotate(160deg);
            }
            62%{
                opacity: 0;
            }
            65%{
                opacity: 0;
                -webkit-transform: rotate(200deg);
            }
            90%{
                -webkit-transform: rotate(340deg);
            }
            100%{
                -webkit-transform: rotate(360deg);
            }

        }
        .loadEffect div:nth-child(1){
            -webkit-animation-delay:0.2s;
        }
        .loadEffect div:nth-child(2){
            -webkit-animation-delay:0.4s;
        }
        .loadEffect div:nth-child(3){
            -webkit-animation-delay:0.6s;
        }
        .loadEffect div:nth-child(4){
            -webkit-animation-delay:0.8s;
        }
    </style>
    <script type="text/javascript">
    $(window.parent.document).find('.list-ul').find('ul').slideUp();
    $(window.parent.document).find('.list-ul').find('a').removeClass('active');
    function page(n,s){
			if(n) $("#pageNo").val(n);
			if(s) $("#pageSize").val(s);
			$("#searchForm").attr("action","${ctxweb}/shop/product/eateSbscType");
			$("#searchForm").submit();
	    	return false;
	    }
	     function tyep(type){
	     	$('.sf').hide();
	        var id_array=new Array();  
			$('input[name="ids"]:checked').each(function(){  
			    id_array.push($(this).val());//向数组中添加元素  
			});  
			var idstr=id_array.join(',');
			if(idstr==null||idstr==''){
			  alert("请选择!");
			}else{
	          $.ajax({
				type: "POST",
				url: "${ctxweb}/shop/product/saveIds",
				data: {ids:idstr,type:type},
				beforeSend:function(){
				$(".run-ball-box").show();
				},success: function(data){
				$(".run-ball-box").hide();
				$(".message").html("设置成功");
				$('.xcq').show();
				 }
			  });
			 }
	    }
	   function setType1(){
	   var typeIds = $('input[name="type1"]:checked').val();
	     var id_array=new Array();  
			$('input[name="ids"]:checked').each(function(){  
			    id_array.push($(this).val());//向数组中添加元素  
			});  
			 var idstr=id_array.join(',');
			if(idstr==null||idstr==''){
			  alert("请选择!");
			}else{
			 
	          $.ajax({
				type: "POST",
				url: "${ctxweb}/shop/product/Tyepshop",
				data: {ids:idstr,typeId:typeIds},
				beforeSend:function(){
				$(".run-ball-box").show();
				},success: function(data){
				$(".run-ball-box").hide();
				$(".message").html("设置成功");
				 $('.xcq').show();
				 }
			  });
			}
	   }
	  function munsMuns(){
	    var id_array=new Array();  
			$('input[name="ids"]:checked').each(function(){  
			    id_array.push($(this).val());//向数组中添加元素  
			});  
			var idstr=id_array.join(',');
			var typeIds=$("#tuok").val();
			var munSize=$("#munSize").val();
			if(idstr==null||idstr==''){
			  alert("请选择!");
			}else{
			  $.ajax({
				type: "POST",
				url: "${ctxweb}/shop/product/munsEate",
				data: {ids:idstr,typeId:typeIds,munSize:munSize},
				beforeSend:function(){
				$(".run-ball-box").show();
				},success: function(data){
				$(".run-ball-box").hide();
				$(".message").html("设置成功");
				$('.xcq').show();
				}
			   });
			 }	
	  }
	  function setType(id){
        var typeIds = $('input[name="type"]:checked').val();
        $.ajax({
			type: "POST",
			url: "${ctxweb}/shop/product/Tyepshop",
			data: {ids:id,typeId:typeIds},
			beforeSend:function(){
			$(".run-ball-box").show();
			},success: function(data){
			$(".run-ball-box").hide();
			$(".message").html("设置成功");
			 $('.xcq').show();
			 
			}
		 });
	  }
	  $(function(){
	  $('.piliang-s').click(function(){
	  		$('.sf span').html("是否批量上架？")
	  		$('.sf').show();
	  		$('.sf div').append("<a href='javascript:;' onclick='tyep(1)'>ok</a> ")
	  });
	  $('.piliang-x').click(function(){
	  		$('.sf span').html("是否批量下架？")
	  		$('.sf').show();
	  		$('.sf div').append("<a href='javascript:;' onclick='tyep(0)'>ok</a> ")
	  });
	  $('.piliang-del').click(function(){
	  		$('.sf span').html("是否批量删除？")
	  		$('.sf').show();
	  		$('.sf div').append("<a href='javascript:;' onclick='tyep(3)'>ok</a> ")
	  });
	  
	  
	  
	  $(".run-ball-box").hide();
	  	$('.numb').cbNumm();
	  })
	  function messheg(){
	   location.href="${ctxweb}/shop/product/eateSbscType";
	  }
	   $(function(){
	   		$('body').on('click','.box-a',function(){
	   			$(this).closest('body').find('.a-box').hide();
	   			$(this).closest('ul').find('.a-box').show();
	   			var hval=$(this).closest('ul').find('.h-fen').val();
	   			var int=$(this).closest('ul').find('.a-box').find('input[type=radio]');
	   			
	   			for(i=0;i<int.length;i++){
	   				
	   				if($(int[i]).val()==hval){
	   				
	   					$(int[i]).attr('checked','checked');
	   				}
	   			}
	   		});
	   
             $('.elect-show').click(function(){
              var id_array=new Array();  
			$('input[name="ids"]:checked').each(function(){  
			    id_array.push($(this).val());//向数组中添加元素  
			});  
			var idstr=id_array.join(',');
			if(idstr==null||idstr==''){
			  alert("请选择!");
			}else{
			  window.open('${ctxweb}/shop/pmShopFreightTem/pmShopFreightTemList?stule='+idstr+'','newwindow','height=500,width=700') ;
			}
            });
        });
    </script>
     <style type="text/css">
     .sf{display:none;position:fixed;width:200px;border:1px solid #dcdcdc;height:150px;text-align:center;z-index:10000;background:#fff;top:50%;left:50%;margin-left:-100px;margin-top:-75px;border-radius: 5px;overflow:hidden;}
    	.sf p{height:35px;line-height:35px;text-align:center;background:#f0f0f0;}
    	.sf span{display:inline-block;margin:15px 0 20px 0;}
    	.sf div{text-align:center;}
    	.sf a{display:inline-block;width:80px;height:30px;line-height:30px;text-align:center;color:#fff;background:#4778C7;border-radius: 5px;}
    	.xcq{display:none;position:fixed;width:200px;border:1px solid #dcdcdc;height:150px;text-align:center;z-index:10000;background:#fff;top:50%;left:50%;margin-left:-100px;margin-top:-75px;border-radius: 5px;overflow:hidden;}
    	.xcq p{height:35px;line-height:35px;text-align:center;background:#f0f0f0;}
    	.xcq span{display:inline-block;margin:15px 0 20px 0;}
    	.xcq div{text-align:center;}
    	.xcq a{display:inline-block;width:80px;height:30px;line-height:30px;text-align:center;color:#fff;background:#4778C7;border-radius: 5px;}
    </style>
</head>
<body>
<div class="xcq">
    <p>提示</p>
	<span class="message" data-tid="${messager}">${messager}</span>
	<div>
		<a href="javascript:;" onclick=" messheg()">ok</a> 
	</div>
   </div>
   
   <div class="sf">
    <p>提示</p>
	<span class="message"></span>
	<div>
		
	</div>
   </div>
<div class="run-ball-box">
        <div class="loadE">
            <div class="loadEffect">
                <div><span></span></div>
                <div><span></span></div>
                <div><span></span></div>
                <div><span></span></div>
            </div>
        </div>
    </div>
<form action="" id="searchForm" method="post" >
            <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
			<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
			<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
    <div class="batch">
        

        <div class="batch-body">
            <div class="batch-body-left">
                <p>商品分类</p>
                <ul>
                    <li><a href="${ctxweb}/shop/product/eateSbscType?shopTypeId=wxfl&turn=0" <c:if test="${turn==0}"> class='act' </c:if> >未分类商品</a></li>
                    <li><a href="javascript:;">所有分类</a></li>
                </ul>
               
                <ul>
                 <c:forEach items="${pmShopProductTypes}" var="pmShopProductTypes">
                    <li>
                        <a href="${ctxweb}/shop/product/eateSbscType?shopTypeId=${pmShopProductTypes.id}">${pmShopProductTypes.productTypeName}</a>
                        <ul>
                           <c:forEach items="${pmShopProductTypes.pmShopProductTypes}" var="pmShopProductTypevs">
                            <li><a href="${ctxweb}/shop/product/eateSbscType?shopTypeId=${pmShopProductTypevs.id}&turn=${pmShopProductTypevs.id}" <c:if test="${turn==pmShopProductTypevs.id}"> class='act'</c:if>>${pmShopProductTypevs.productTypeName}</a></li>
                            </c:forEach>
                        </ul>
                    </li>
                    </c:forEach>
                </ul>
                
            </div>
            <div class="batch-body-right">
            <p class="batch-top">
            <span>商品名称：</span>
            <input type="text" name="productName" value="${ebProduct.productName}">
            <input name="turn" type="hidden" value="${turn}">
            <!--日期-->
          <!--   <span>创建日期：</span>
            <input id="LAY_demorange_s" class="date" type="text">
            <b>-</b>
            <input id="LAY_demorange_e" class="date" type="text"> -->
            <!--价格-->
            <span>价格：</span>
            <input  type="text" name="statrPrice" value="${statrPrice}">
            <b>-</b>
            <input type="text" name="stopPrice" value="${stopPrice}">
            <!--状态-->
            <span>状态：</span>
            <select name="prdouctStatus">
                <option value="" <c:if test="${ empty  prdouctStatus}">selected="selected"</c:if>>全部</option>
                <option value="0" <c:if test="${prdouctStatus=='0'}">selected="selected"</c:if>> 未上架</option>
                <option value="1" <c:if test="${prdouctStatus=='1'}">selected="selected"</c:if>>出售中</option>
            </select>
              <input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/>
        </p>
                <div class="first-div">
                    <span class="checkbox1">
                        <input class="all-input" type="checkbox">
                        全选
                    </span>
                    <div>
                        <a class="ku-a" href="javascript:;">批量更新库存</a>
                        <div class="ku-box">
                            <p>
                                批量更新库存：
                                <select id="tuok" name="munsType">
                                    <option value="0">不使用公式</option>
                                    <option value="1">加</option>
                                    <option value="2">减</option>
                                    <option value="3">乘</option>
                                    <option value="4">除</option>
                                </select>
                            </p>
                            <input class="numb" type="text" value="0" id="munSize" name="munSize">
                            <div>
                                <a href="javascript:;" onclick="munsMuns()">应用</a>
                                <a class="del-ku" href="javascript:;">取消</a>
                            </div>
                        </div>
                    </div>
                    <a href="javascript:;" class="elect-show">设置运费</a>
                    <div>
                        <a class="first-fen" href="javascript:;">批量更新分类</a>
                        <div class="a-box">
                            <img src="${ctxStatic}/sbShop/images/xxx-rzt.png" alt="">
                            <div>
                                <ul>
                                <c:forEach items="${pmShopProductTypes}" var="pmShopProductTypes">
                                    <li>
                                      			${pmShopProductTypes.productTypeName}
                                        <ul>
                                         <c:forEach items="${pmShopProductTypes.pmShopProductTypes}" var="pmShopProductTypevs">
                                            <li class="radio1">
                                                <input type="radio" name="type1" value="${pmShopProductTypevs.id}">
                                                <label><i></i>${pmShopProductTypevs.productTypeName}</label>
                                            </li>
                                            </c:forEach>
                                        </ul>
                                    </li>
                                    </c:forEach>
                                </ul>
                            </div>
                            <a href="javascript:;" onclick="setType1()">应用</a>
                        </div>
                    </div>

                    <a class="piliang-x" href="javascript:;">批量下架</a>
                    <a class="piliang-s" href="javascript:;" >批量上架</a>
                    <a class="piliang-del" href="javascript:;">批量删除</a>
                </div>
                <ul class="head-ul">
                    <li></li>
                    <li>商品名称</li>
                    <li>价格</li>
                    <li>库存数量</li>
                    <li>所属分类</li>
                    <li>创建时间</li>
                    <li>状态</li>
                    <li>操作</li>
                </ul>
                <div class="body-ul" style="width: 100%;">
                <c:forEach items="${page.list}" var="productList">
                    <ul>
                        <li>
                        <span class="checkbox1">
                            <input type="checkbox" name="ids" value="${productList.productId}">
                            
                        </span>
                        </li>
                        <li>
                            <div>
                                <img src="${fn:split(productList.prdouctImg,'|')[0]}" alt="">
                            </div>
                            <span>${productList.productName}</span>
                        </li>
                        <li>
                            ¥<u><fmt:formatNumber type="number" value="${list.marketPrice}" pattern="0.00" maxFractionDigits="2"/></u>
                        </li>
                        <li>
                        ${productList.storeNums}
                        </li>
                        <li>
                          ${productList.shopProductType.productTypeNameStr}
                        </li>
                        <li>
                            <p> ${productList.createTime}</p>
                        </li>
                        <li>
                        	<input class="h-fen" type="hidden" value="${fn:split(productList.shopProTypeIdStr,',')[1]}">
                        		<c:if test="${productList.prdouctStatus==0}"> 未上架</c:if>   <c:if test="${productList.prdouctStatus==1}">出售中</c:if>   <c:if test="${productList.prdouctStatus==3}">已删除</c:if>   
                        </li>
                        <li>
                            <a href="${ctxweb}/shop/product/from?productId=${productList.productId}">编辑商品</a>
                            <br>
                            <a class="box-a" href="javascript:;">编辑分类</a>
                            <div class="a-box">
                               <img src="${ctxStatic}/sbShop/images/xxx-rzt.png" alt="">
                                <div>
                                    <ul>
                                    <c:forEach items="${pmShopProductTypes}" var="pmShopProductTypes">
                                    <li>
                                      			${pmShopProductTypes.productTypeName}
                                        <ul>
                                         <c:forEach items="${pmShopProductTypes.pmShopProductTypes}" var="pmShopProductTypevs">
                                            <li class="radio1">
                                                <input type="radio" name="type" value="${pmShopProductTypevs.id}">
                                                <label>${pmShopProductTypevs.productTypeName}</label>
                                            </li>
                                            </c:forEach>
                                        </ul>
                                    </li>
                                    </c:forEach>
                                    </ul>
                                </div>
                                <a class="s" href="javascript:;" onclick="setType(${productList.productId})">应用</a>
                            </div>
                        </li>
                    </ul>
                    </c:forEach>
                 
                </div>
                <!--分页-->
                <div class="pagination">
		         ${page}
		        </div>
            </div>
        </div>
    </div>
</body>
</html>