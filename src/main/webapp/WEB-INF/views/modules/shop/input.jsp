<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="robots" content="noarchive">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0,minimal-ui">
    <title>分类</title>
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/input.css">
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/bootstrap.min.css">
    <script src="${ctxStatic}/sbShop/js/jquery.min.js"></script>
     <script src="${ctxStatic}/sbShop/js/base_form.js"></script>
    <script src="${ctxStatic}/sbShop/js/aaa.js"></script>
    <script>
    $(window.parent.document).find('.list-ul').find('ul').slideUp();
    $(window.parent.document).find('.list-ul').find('a').removeClass('active');
    </script>
</head>
<body>
  <form action="">
  	<div class="add-bottom">
        <a class="add-fu btn btn-primary" href="javascript:;">添加新的分类</a>
        <a href="Javascript:;" class="step3 btn btn-primary">保存</a>
    </div>
  	
  	<div class="add-box">
        <ul class="ul-top">
        	<li>添加子分类</li>
            <li>分类名称</li>
            <li>上移</li>
            <li>下移</li>
            <li>删除</li>
        </ul>
         <c:forEach items="${pmShopProductTypes }" var="pmShopProductTypes">
        <div class="new-div">
            <ul class="new-ul">
            	<li>
                    <a class="add-child btn btn-primary" href="javascript:;">添加子分类</a>
                </li>
                <li class="ul-one">
                    <input type="text" value="${pmShopProductTypes.productTypeName}">
                </li>
                <li><a class="sy-div" href="javascript:;"><img src="${ctxStatic}/sbShop/images/zhankai2.png" alt=""></a></li>
                <li><a class="xy-div" href="javascript:;"><img src="${ctxStatic}/sbShop/images/zhankai1.png" alt=""></a></li>
                <li><a class="new-ul-del" href="javascript:;"><img src="${ctxStatic}/sbShop/images/xxx-rzt.png" alt=""></a></li>
            </ul>
            <c:forEach items="${pmShopProductTypes.pmShopProductTypes}" var="pmShopProductTypesLi">
            <ul class="ul-list">
            	<li></li>
                <li><input type="text" value="${pmShopProductTypesLi.productTypeName}"></li>
                <li><a class="sy-ul" href="javascript:;"><img src="${ctxStatic}/sbShop/images/zhankai2.png" alt=""></a></li>
                <li><a class="xy-ul" href="javascript:;"><img src="${ctxStatic}/sbShop/images/zhankai1.png" alt=""></a></li>
                <li><a class="ul-list-del" href="javascript:;"><img src="${ctxStatic}/sbShop/images/xxx-rzt.png" alt=""></a></li>
            </ul>
            </c:forEach>
        </div>
         </c:forEach>
    </div>
   
    
  </form>
    
    <script type="text/javascript">
        $('.step3').click(function(){
        	if($(this).cbInput('step3')==1){
            
        }else{
          var select=new Array();
	        $('.new-div .ul-one input').each(function(i){
	           var select2=new Array();
	           $(this).parent().parent().siblings('ul').find('input').each(function(i){
	            select2.push($(this).val());
	           })
	           var ll={aa:$(this).val(),cc:select2};
	            select.push(ll);
	        })
        //请求品牌
         $.ajax({
	      type: "POST",
	      url: "${ctxweb}/shop/product/shopProductTypeAdd",
	      data: {select:JSON.stringify(select)},
	      success: function(data){
	        window.location.href="${ctxweb}/shop/product/shopProductType";
	       }
	        })
        }
        })
        
    
    </script>
</body>
</html>
