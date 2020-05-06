<%@ page trimDirectiveWhitespaces="true" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>  
<meta charset="utf-8">
<meta name="Keywords" content="大宗贸易" />
<meta name="Description" content="大宗贸易" />
<title>大宗贸易_${fns:getProjectName()}网上商城－放心粮油|广州大米批发|网上买米|网上买油|粮油专卖</title>
<script type="text/javascript" src="${ctxStatic}/blocktrading/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="${ctxStatic}/blocktrading/superslide.js"></script>
<link rel="stylesheet" type="text/css" href="${ctxStatic}/blocktrading/common.css"/>
<style>
html,body,div,p,ul,ol,dl,dt,dd,form,h1,h2,h3,h4,h5,h6,input,fieldset,legend,optgroup{margin:0;padding:0;}
.mscroll { width:807px; font-size: 13px;}
.mscroll .thscroll { width:807px; color: #FF0000;}
.mscroll .tr-scroll { width:807px; height:500px; position:relative; overflow:hidden;}
.mscroll .tr-scroll .content{position:absolute;overflow:hidden;}/*必须要的元素*/
.mscroll .tr-scroll .thscroll{ width:807px; color: #FF0000;  }
.mscroll .tr-scroll .tdscroll{ width:807px; color: #FF0000;  }
.mscroll .thscroll th,.mscroll .thscroll td,.mscroll .tdscroll th,.mscroll .tdscroll td{
overflow:hidden;text-align:center; border-bottom:solid 1px #FF0000; border-right:solid 1px #FF0000; line-height:30px; background-color:#000000; height:30px;}
.mscroll .tdscroll td{
overflow:hidden;text-align:center; border-bottom:solid 1px #FF0000; 
border-right:solid 1px #FF0000;  line-height:30px; background-color:#000000; height:30px; color:#FFFF00;

 

}
</style>
</head>
<body bgcolor="#000000">
<div class="mscroll" id="NKS_TSCROLL">
<table class="thscroll" cellspacing="0" cellpadding="0" border="0">
<tr>
	<th width="20%">商品名称</th>
	<th width="8%">交易类型</th>
	<th width="9%">数量</th>
	<th width="8%">价格</th>
    <th width="8%">计量单位</th>
	<th width="10%">品牌厂家</th>
	<th width="9%">标准/规格</th>
	<th width="10%">交货地点</th>
	<th width="9%">产地</th>
	<th width="10%">有效期</th>
</tr>
</table>
<div class="tr-scroll">
<div class="content">
<table class="tdscroll" cellspacing="0" cellpadding="0" border="0">
<c:forEach items="${list}" var="ebBlockTrading">
    <tr>
    <td width="20%">${ebBlockTrading.productName }</td>
    <td width="8%"><c:if test="${ebBlockTrading.tradeType eq 0 }">买</c:if><c:if test="${ebBlockTrading.tradeType eq 1 }">卖</c:if></td>
    <td width="9%">${ebBlockTrading.num }</td>
    <td width="8%">${ebBlockTrading.sellprice }</td>
    <td width="8%">${ebBlockTrading.units }</td>
    <td width="10%">${ebBlockTrading.business }</td>
    <td width="9%">${ebBlockTrading.property }</td>
    <td width="10%">${ebBlockTrading.deliveryPoint }</td>
    <td width="9%">${ebBlockTrading.production }</td>
    <td width="10%">${ebBlockTrading.expiryDate }</td>
  </tr>
  </c:forEach> 
 
  </table>
</div>
</div>
<script type="text/javascript">jQuery(".tr-scroll").slide( { mainCell:".content",effect:"topMarquee",vis:1,interTime:70,autoPlay:true} );</script>

</div><!--mscroll end-->

</body>
<script src="public/common/js/ajax.nk.js" type="text/javascript"></script>
<script type="text/javascript">
<!--
var defaultUrl = "http://www.51trly.com/";


onload = function()
{
  window.setInterval(scroll_load, 1000*60*30);
}

function scroll_load()
{
	window.location.href = defaultUrl+'scroll';
}

//-->
</script>
</html> 

   