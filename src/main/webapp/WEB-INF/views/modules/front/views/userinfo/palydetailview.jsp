<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/modules/front/include/taglib.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<link rel="stylesheet" type="text/css" href="${ctxStatic}/front/css/style.css" media="all" />
<link rel="stylesheet" type="text/css" href="${ctxStatic}/front/css/animat.css" media="all" />
<link rel="stylesheet" type="text/css" href="${ctxStatic}/static/front/css/filp.css" media="all" />
<script type="text/javascript" src="${ctxStaticFront}/js/jquery.min.js"></script>
<script type="text/javascript" src="${ctxStaticFront}/js/dome.js"></script>
<script type="text/javascript" src="${ctxStaticFront}/js/superslide.2.1.js"></script>
<script type="text/javascript" src="${ctxStaticFront}/js/imagesloaded.pkgd.min.js"></script>
<script type="text/javascript" src="${ctxStaticFront}/js/jquery.masonry.min.js"></script>
<script type="text/javascript" src="${ctxStaticFront}/js/layer/layer.js"></script>
<script type="text/javascript">
   var ctxStaticFront="/jqyy-mainweb/static/front";
</script>

<style type="text/css">
        	.cascading-dropdown-loading {
        		cursor: wait;
        		background: url('${ctxStaticFront}/images/ajax-loader.gif') 85% center no-repeat transparent;
        	}
        </style>
	<script type="text/javascript" src="${ctxStaticFront}/js/jquery.cascadingdropdown.js"></script>

<!DOCTYPE html>
<html>
<head>
	<title>缴费明细</title>
	
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<style type="text/css"> 
	
	*{padding: 0;margin: 0;font-family:"5FAE8F6F96C59ED1", "Microsoft Yahei";list-style-type: none;}
	li{width: 100%;}
	li p{font-size: 14px;color: #404d5e;line-height: 30px}
	li p span{margin-right: 20px;}
	.r{margin-right: 0;float: right;}
	body{padding: 15px;}
	</style>
</head>
<body>
	
			
				<c:if test="${order.status=='0'}">
					<a  id="gh_submit" style="color:blue;"  href="javascript:onter();" >点击缴费</a></br>
				</c:if>
			 </br>
			 
	<!-- 									
-->
		<input type="hidden"  id="patientIdcarduserId" name="patientIdcarduserId" value="32334" />
		<input type="hidden" id="poType"  name="poType" value="5" />
		<input type="hidden" id="hospitalId"  name="hospitalId" value="${order.hospitalId}" />
		<input type="hidden" id="objectId"  name="objectId" value="${order.feeid}" />
		<input type="hidden" id="poAllPrice"  name="poAllPrice" value="${order.settleamount}" />
		<input type="hidden" id="doctorId"  name="doctorId" value="${order.doctorId}" />
 		

<ul>
     <c:if test="${!empty freelist}">
     <c:forEach var="dlist" items="${freelist}">
	<li>
	<p>名称:${dlist.feeitemname}</p>
	<p><span>规格:${dlist.feeitemstandard}</span><span>数量:${dlist.feeitemnum}</span><span>单位:${dlist.feeitemunit}</span><span>单价:${dlist.feeitemamount}元 </span><span class="r">小计:￥${dlist.feeitemallamount}</span></p>
	</li>
	</c:forEach>
	</c:if>
	<c:if test="${!empty newcollect}">
	<c:forEach items="${newcollect}" var="news">   
	<li>
	   <p>${news.newsdetail.newsdetailtitle}</p>
	   <p>${news.newsdetail.newsdetailauthor}</p>
	   <p>
	     <span>${news.newsdetail.newsdetailcontent}</span>
	   </p>
	</li>
	</c:forEach>
	</c:if>
</ul>

<script type="text/javascript">

	function onter(){
 		var patientIdcarduserId = $("#patientIdcarduserId").val();
 		var poType = $("#poType").val();
 		var hospitalId = $("#hospitalId").val();
 		var objectId = $("#objectId").val();
 		var poAllPrice = $("#poAllPrice").val();
 		var doctorId = $("#doctorId").val();
 	  	var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
   		window.open("${ctx}/userinfo/paymentOrdery?patientIdcarduserId="+patientIdcarduserId+"&poType="+poType+"&hospitalId="+hospitalId+"&objectId="+objectId+"&poAllPrice="+poAllPrice+"&doctorId="+doctorId);
	}



</script>
</body>


</html>
