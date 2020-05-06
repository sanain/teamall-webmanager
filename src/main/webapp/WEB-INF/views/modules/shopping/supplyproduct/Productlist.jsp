<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>批发商品审核列表</title>
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
	  </script>
	  <script type="text/javascript">
	  function editProstatus(productId,status){
		  product=productId;
		    var msg="";
			if(status==1){
			  msg="是否把该商品下架";
			}else{
			  msg="是否把该商品上架";
			}
			confirmx(msg,editStatus);
		}
</script>
    <script type="text/javascript">
	$(function(){
    	$(".run-ball-box").hide();
	})
    	function sbmit(){
    	$("#fromsb").submit();
    	
    	}
    	function page(n,s){
		if(n) $("#pageNo").val(n);
	    if(s) $("#pageSize").val(s);
	          $("#searchForm").attr("action","${ctxsys}/Product/supplylist");
	          $("#searchForm").submit();
	    	return false;
	    }
		
    </script>
</head>
<body>
    <div class="run-ball-box">
        <div class="run-ball"><span class="sk-inner-circle"></span></div>
        <div class="sh-ju">数据加载中...</div>
    </div>
	<ul class="nav nav-tabs">
		<shiro:hasPermission name="merchandise:pro:view"><li class="active"><a href="${ctxsys}/Product/supplylist">批发商品审核</a></li></shiro:hasPermission>
	</ul>
	 <form:form id="searchForm" modelAttribute="ebProduct" action="${ctxsys}/Product/supplylist" method="post" class="breadcrumb form-search ">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
		<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form">
		     <input type="hidden" name="shopId" value="${shopId}">
		     <li><label>商品名字:</label><form:input path="productName" htmlEscape="false" maxlength="50" class="input-medium"  placeholder="请输入商品名字"/></li>
			 <li><label>供应商名称:</label><form:input path="wholesaleShopName" htmlEscape="false" maxlength="50" class="input-medium"  placeholder="请输入供应商名称"/></li>
			 <li><label>分&nbsp;&nbsp;类:</label><tags:treeselect id="menu" name="productTypeId" value="${sbProductType.id}" labelName="productTypeStr" labelValue="${sbProductType.productTypeStr}" title="菜单" url="${ctxsys}/PmProductType/treeData" extId="${sbProductType.id}" cssClass="required input-medium"/></li>
			
			 
		</ul>
		<ul class="ul-form">
		 <li><label>审核状态:</label>
			    <form:select path="auditState" class="input-medium">
			      <form:option value="">全部</form:option>
			      <form:option value="0">审核不通过</form:option>
			      <form:option value="1">审核通过</form:option>
			    </form:select>
			 </li>
		     <li><input id="btnSubmit" class="btn btn-primary" style="margin-left:10px" type="submit" value="查询" onclick="return page();"/></li>
	      
		</ul>
	</form:form> 
	<tags:message content="${message}"/>
	<table  class="table table-striped table-condensed table-bordered" >
		<tr>
		<th class="center123">商品名称</th>
		<th class="center123">商品图片</th>
		<th class="center123">所属分类</th>
		<th class="center123 sort-column wholesalePrice">批发价格</th>
		<th class="center123 sort-column createTime">上传时间</th>
		<th class="center123">品牌</th>
		<th class="center123">门店名称</th>
		<shiro:hasPermission name="merchandise:pro:edit">
		<th class="center123">上下架</th>
		</shiro:hasPermission>
		<th class="center123">审核备注</th>
		<th class="center123">审核时间</th>
		<th>审核状态</th>
		</tr>
		<c:forEach items="${page.list}" var="productlist" varStatus="status">
			<tr>
			   <td class="center123">
				   <a href="${ctxweb}/ProductDetailsHtml/${productlist.productId}.html">${fns:abbr(productlist.productName,13)}</a>
				</td>
				<td class="center123"><img class="fu" src="${fn:split(productlist.prdouctImg,'|')[0]}"style="width:30px;height:30px"/><img class="kla" style="display:none;position:fixed;top:30%;left:40%" alt="" src="${fn:split(productlist.prdouctImg,'|')[0]}"></td>
				<td class="center123">${fns:getsbProductTypeName(productlist.productTypeId).productTypeStr}</td>
				<td class="center123"> ${productlist.wholesalePrice}</td>
				<td class="center123">${productlist.createTime}</td>
				<td class="center123">${productlist.brandName}</td>
				<td class="center123">${productlist.wholesaleShopName}</td>
				<shiro:hasPermission name="merchandise:pro:edit">
				<td class="center123">
				<c:if test="${productlist.auditState==1}">
				   <c:if test="${productlist.prdouctStatus==3|| empty productlist.prdouctStatus}"> 已删除 </c:if>     <c:if test="${productlist.prdouctStatus!=3 && not empty productlist.prdouctStatus}"><c:if test="${productlist.prdouctStatus==0}">下架</c:if><c:if test="${productlist.prdouctStatus==1}">上架</c:if>|<c:if test="${productlist.prdouctStatus==0|| empty productlist.prdouctStatus}"><a onclick="editProstatus('${productlist.productId}','${productlist.prdouctStatus}')">上架</a></c:if><c:if test="${productlist.prdouctStatus==1}"><a onclick="editProstatus('${productlist.productId}','${productlist.prdouctStatus}')" >下架</a></c:if></c:if>
				</c:if>
				 <c:if test="${productlist.auditState==0}"><font color="red">审核不通过</font></c:if>
				<c:if test="${empty productlist.auditState}"><font color="gray">未审核</font></c:if>
				</td>
				</shiro:hasPermission>
				<td class="center123">${productlist.auditRemark}</td>
				<td class="center123">${productlist.auditTime}</td>
			    <td>
				 <a href="${ctxsys}/Product/supplyform?productId=${productlist.productId}"> 
				 <c:if test="${productlist.auditState==0}">审核不通过</c:if>
				    <c:if test="${empty productlist.auditState}">未审核</c:if>
					<c:if test="${productlist.auditState==1}">审核通过</c:if></a>
				</td>
			</tr>
		</c:forEach>
	</table>
	<div class="pagination">${page}</div>
  
</body>

</html>