<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="robots" content="noarchive">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0,minimal-ui">
    <title>商品管理</title>
    <link rel="stylesheet" href="${ctxStatic}/supplyshop/css/warehouse-comm.css">
    <link rel="stylesheet" href="${ctxStatic}/supplyshop/css/bootstrap.min.css">
    <link rel="stylesheet" href="${ctxStatic}/supplyshop/css/build.css">
    <script src="${ctxStatic}/supplyshop/js/jquery.min.js"></script>
    <script src="${ctxStatic}/supplyshop/js/base_form.js"></script>
    <script src="${ctxStatic}/supplyshop/js/warehouse-comm.js"></script>
    <script src="${ctxStatic}/supplyshop/js/kkk.js"></script>
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
    		 location.href="${ctxweb}/supplyshop/supplyShopproduct/list3";
    		$('.xcq').hide();
    	   });
    	 });
		$(document).ready(function() {
		 $.ajax({
				type: "POST",
				url: "${ctxweb}/supplyshop/supplyShopproduct/classOne",
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
			$("#searchForm").attr("action","${ctxweb}/supplyshop/supplyShopproduct/list3?prdouctStatus=1");
			}else{
			$("#searchForm").attr("action","${ctxweb}/supplyshop/supplyShopproduct/list3");
			}
			
			$("#searchForm").submit();
	    	return false;
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
            <li class="active putaway"><a href="${ctxweb}/supplyshop/supplyShopproduct/list3?prdouctStatus=0">商品管理</a></li>
            </c:if>
            <c:if test="${stule==99}">
            <li class="active putaway" style="display:none"><a>选择商品</a></li>
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
                <li>批发价格：</li>
                <li>
                    <input class="num" type="text" name="statrPrice" value="${statrPrice}">
                    <span>到</span>
                    <input class="num" type="text" name="stopPrice" value="${stopPrice}">
                </li>
				 <li style="margin-left:10px"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/></li>
            </ul>
        </div>
        
        </form>
        <div class="house-list">
            <ul class="house-list-top">
                <li style="width:10%">商品图片</li>
                <li style="width:20%">商品名称</li>
                <li>批发价格</li>
                <li style="width:6%;">库存</li>
                <li>条形码</li>
                <li><a href="javascript:;">创建时间</a></li>
				<li style="width:25%">审核状态/原因</li>
                <li style="width:6%">操作</li>
            </ul>
            
            <div class="house-list-body">
            <c:forEach items="${page.list}" var="list">
                <ul>
                    <li style="width:10%;text-align: center;line-height: 60px;">
                        <div>
                            <img src="${fn:split(list.prdouctImg,'|')[0]}" alt="">
                        </div>
                        
                    </li>
					<li style="width:20%;text-align: center;line-height: 60px;">
					${list.productName}
					</li>
                    <li>¥<b><fmt:formatNumber type="number" value="${list.wholesalePrice}" pattern="0.00" maxFractionDigits="2"/></b></li>
                    <li style="width:6%">${list.wholesaleStoreNums}</li>
                    <li>${list.barCode}</li>
                    <li>
                        ${list.createTime}
                    </li>
					<li style="width:25%;text-align: center;line-height: 60px;padding-top:0px;">
					<c:if test="${list.auditState==1}"><font color="green" style="text-align: center;line-height: 60px;">${list.auditTime} 审核通过
					<c:if test="${not empty list.auditRemark}">
					: ${list.auditRemark}
					</c:if>
					
					</font>
					</c:if>
                    <c:if test="${list.auditState==0}"><font color="red">${list.auditTime} 审核不通过
										<c:if test="${not empty list.auditRemark}">
					: ${list.auditRemark}
					</c:if>
					</font></c:if>
					<c:if test="${empty list.auditState}"><font color="gray" style="text-align: center;">审核中</font></c:if>
                    </li>
                    <li style="width:6%;text-align: center;line-height: 60px;">
					
					 <a href="${ctxweb}/supplyshop/supplyShopproduct/from?productId=${list.productId}"  style="color:blue;background: white;"> <c:if test="${productlist.auditState==0}">重新编辑</c:if>
					 <c:if test="${empty list.auditState}">编辑商品</c:if>
					 <c:if test="${list.auditState==1}">查看商品</c:if>
					 </a>
					 
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
