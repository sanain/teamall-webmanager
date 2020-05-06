<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="robots" content="noarchive">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0,minimal-ui">
    <meta name="Description" content="${fns:getProjectName()},编辑模块"/>
	<meta name="Keywords" content="${fns:getProjectName()},编辑模块"/>
   <title>编辑模块</title>
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/fitment-edit.css">
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/bootstrap.min.css">
   
    <link type="text/css" rel="stylesheet" href="${ctxStatic}/common/jqsite.min.css">
    <script src="${ctxStatic}/sbShop/js/jquery.min.js"></script>
    <script type="text/javascript" src="${ctxStatic}/common/mustache.min.js"></script>
	<script type="text/javascript" src="${ctxStatic}/common/jqsite.min.js"></script>
    <script type="text/javascript" src="${ctxStatic}/ckeditor/ckeditor.js"></script>
	<script type="text/javascript" src="${ctxStatic}/ckfinder/ckfinder.js"></script>
    <script src="${ctxStatic}/sbShop/js/fitment-edit.js"></script>
    <script src="${ctxStatic}/sbShop/js/kkk.js"></script>
    <style type="text/css">
    	.iimg-box div img{width:100%}
    	.fit-left ul:last-child a.btn{line-height:17px;}
    </style>
    <script>
    $(window.parent.document).find('.list-ul').find('ul').slideUp();
    $(window.parent.document).find('.list-ul').find('a').removeClass('active');
    </script>
    <script type="text/javascript">
       $(function(){
          $('.elect-show').click(function(){
                window.open('${ctxweb}/shop/product/list4?stule=99','newwindow','height=500,width=900,top=100,left=300,toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no') ;
           });
          var advertiseType= $("#advertiseType").val();
          if(advertiseType=='2'){
           $("#adverImg").show();
           $("#productvl").show();
           $(".linkUrltitle").hide();
          }else if(advertiseType=='3'){
           $("#adverImg").show();
           $("#productvl").hide();
           $(".linkUrltitle").show();
          }
       });
        function onllk(advertiseType){
         if(advertiseType=='2'){
          $("#adverImg").show();
           $("#productvl").show();
           $(".linkUrltitle").hide();
          }else if(advertiseType=='3'){
           $("#adverImg").show();
           $("#productvl").hide();
           $(".linkUrltitle").show();
          }
        }
    </script>
</head>    
<body>
    <div class="fitment">
        <p>模块编辑</p>
        <form class="form-horizontal" action="${ctxweb}/shop/ShopAdvertise/add" method="post" id="searchForm" name="form2">
        <input id="advertiseid" name="advertiseid" type="hidden" value="${advertise.id}"/>
        <div class="fit-box">
        	 <div class="fit-right">
                <div class="add-list">
                    <p>${layouttype.moduleTitle}</p>
                    <div class="img-k">
                        <img src="${layouttype.moduleDemoUrl}" alt="">
                    </div>
                </div>
            </div>
            <div class="fit-left">
                <ul>
                    <li>模块名称：</li>
                    <li><input id="lamoduleTitle" name="lamoduleTitle" value="${layouttype.moduleTitle}" type="text"></li>
                </ul>
                <ul>
                    <li>排序：</li>
                    <li>
                        <input id="orderNo" name="orderNo" value="${advertise.orderNo}" onkeyup="value=value.replace(/[^\d]/g,'')" beforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))" type="text">
                        <p>在APP门店主页显示模块的顺序，必须是数字</p>
                    </li>
                </ul>
                <ul>
                    <li>状态：</li>
                    <li>
                    	<c:choose>
	                		<c:when test="${advertise.status==0||empty advertise.status}">
	                			<div class="radio">
		                            <input value="0" id="xian" name="mo" type="radio" checked>
		                            <label for="xian">显示</label>
		                        </div>
		                        <div class="radio">
		                            <input value="1" id="yin" name="mo" type="radio">
		                            <label for="yin">隐藏</label>
		                        </div>
							</c:when>
	                		<c:when test="${advertise.status==1}">
	                			<div class="radio">
		                            <input value="0" id="xian" name="mo" type="radio">
		                            <label for="xian">显示</label>
		                        </div>
	                			<div class="radio">
		                            <input value="1" id="yin" name="mo" type="radio" checked>
		                            <label for="yin">隐藏</label>
		                        </div>
							</c:when>
                		</c:choose>
                    </li>
                </ul>
                <ul>
                    <li>广告类型：</li>
                    <li>
                        <select name="advertiseType" id="advertiseType" onchange="onllk(this.value)" name="mo">
                        	<option selected="selected" disabled="disabled" value="">请选择类型</option>
                        	<option  <c:if test="${advertise.advertiseType=='3'}"> selected='selected'</c:if>  value="3">广告图片</option>
                			<option <c:if test="${advertise.advertiseType=='2'}"> selected='selected'</c:if> value="2">商品</option>
                        </select>
                    </li>
                </ul>
                <ul id="adverImg">
                    <li>图片：</li>
                    <li class="file">
                        <span>请按示例尺寸添加图片</span>
                        <input type="hidden" name="advertuseImg" id="advertuseImg" value="${advertise.advertuseImg}" htmlEscape="false" maxlength="100" class="input-xlarge"/>
						<span class="help-inline" id="advertuseImg" style="color: blue;"></span>
						<tags:ckfinder input="advertuseImg" type="images" maxWidth="100" maxHeight="100" uploadPath="/shopImg"/>
                        <!-- <div class="fit-img">
                            <img src="images/lishi.png" alt="">
                        </div> -->
                    </li>
                </ul>
                <ul>
                    <li>标题：</li>
                    <li><input id="advertiseTitle" name="advertiseTitle" value="${advertise.advertiseTitle}" type="text"></li>
                </ul>
                <ul class="linkUrltitle">
                    <li >链接：</li>
                    <li ><input id="linkUrl" name="linkUrl" value="${advertise.linkUrl}" type="text"><span style="font-size:5px; color: red;">(完整的地址如：https://www.baidu.com)</span></li>
                </ul>
               <%--  <ul>
                    <li>价格：</li>
                    <li><input id="sellPrice" name="sellPrice" value="${advertise.sellPrice}" type="text"></li>
                </ul>
                <ul>
                    <li>积分数量：</li>
                    <li><input id="charitySize" name="charitySize" value="${advertise.charitySize}" type="text"></li>
                </ul> --%>
                <ul id="productvl">
                    <li>商品：</li>
                    <li>
                    <input type="hidden" id="advertiseTypeObjId" name="advertiseTypeObjId" value="${advertise.advertiseTypeObjId}">
                    	<div class="iimg-box">
                    		<div style="width: 150px;height: 100px;overflow: hidden;">
                    			<img id="imgsval" src="${fn:split(advertise.ebProduct.prdouctImg,'|')[0]}">
                    		</div>
                    		<p id="pname">${advertise.ebProduct.productName}</p>
                    	</div>
                        <div>
                        	<a class="elect-show btn" href="javascript:;">选择</a>
							<!-- <a class="btn" href="javascript:;" onclick="remoenpm()">清除</a> -->
                        </div>
                     	
                    </li>
                </ul>
            </div>
            <input id="layouttypeId" name="layouttypeId" type="hidden" value="${layouttype.id}"/>
           
            <div class="fit-btn">
                <a class="fit-btn-a btn btn-primary" href="javascript:;">保存</a>
            </div>
       </div>
      </form>
    </div>
</body>
</html>