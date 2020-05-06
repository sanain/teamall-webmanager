<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/front/include/taglib.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta name="decorator" content="frontdefault"/>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title></title>
	<meta name="keywords" content="" />
	<meta name="description" content="" />
	
</head>

<body>
<style type="text/css">
        	.cascading-dropdown-loading {
        		cursor: wait;
        		background: url('${ctxStaticFront}/images/ajax-loader.gif') 85% center no-repeat transparent;
        	}
        </style>
<script type="text/javascript" src="${ctxStaticFront}/js/jquery.cascadingdropdown.js"></script>
<div id="content">
       <div class="newsnav"> 
				<div class="center">
				<a href="${ctx}/">首页    >  </a>
				<a href="${ctx}/indexsearch?selectstyle=1"> 药品查询  ></a>
				<a href="${ctx}/drugInfo?drugId=${d.drugid}" >药品详情</a>
			    </div>
        </div>
   
			<div class="jblb">
				<div class="block_name mtt"> 
							
						
							<p class="">${d.drugname }</p>
							<div class="brd"></div>
				</div>
				<div class="yaopxq">
						<p class="pic">
						<c:if test=" ${not empty d.drugurl}">
						<img src="${d.drugurl}">
						</c:if>
						</p>
						<div class="center">
						<p><b style="color:red;">(请在医生指导下使用)</b></p>
							<div class="l">
								<p>药品名: </p>
								<p>规格:</p>
								<p>单位:</p>
								<p>参考价(元):</p>
								<p>剂型:</p>
								<p>生产厂家:</p>
								<p>准字号:</p>
								<p>是否医保:</p>
								<p>是否非处方药:</p>
								<p>是否国家基础药物:</p>
								<p>主要成分:</p>
								<p>药品类型:</p>
								<p>功能主治:</p>
								<p>用法用量:</p>
								<p>不良反应:</p>
								<p>注意事项:</p>
						
							</div>
							<div class="r">
								<p><span>${d.drugname }</span></p>
								<p><span>${d.drugstandard }</span></p>
								<p><span>${d.drugunit }</span></p>
								<p><span>${d.referenceprice }</span></p>
								<p><span>${d.pharmacy }</span></p>
								<p><span>${d.drugfactory }</span></p>
								<p><span>${d.quasifamous }</span></p>
								<p><span> ${d.state=='0'?'否':'是' } </span></p>
								<p><span>${d.drugstatus=='0'?'否':'是' }</span></p>
								<p><span>${d.isbasicdrugs=='0'?'否':'是' }</span></p>
								<p><span>${d.drugingredient }</span></p>
								<p><span>${d.drugtype }</span></p>
								<p><span>${d.drugfeatures }</span></p>
								<p><span> ${d.drugdosage }</span></p>
								<p><span> ${d.adversereactions }</span></p>
								<p><span>${d.drugprecautions }</span></p>
							


							</div>
						</div>




				</div>



			</div>
			
		</div>
<script type="text/javascript">


$(".menav li").each(function(a){ 
		var me = $(".menav li:eq("+a+")"),i=a+1;
		me.find("img").attr("src","images/me_"+i+".png")
		me.hover(function(){ 
			me.find("img").attr("src","images/me_"+i+"h.png")
		},function(){ 
			me.find("img").attr("src","images/me_"+i+".png")

		})
})

$(".yaopxq .l p").each(function(){ 
		var len = $(this).index();
		var rp = $(".yaopxq .r p:eq("+len+")")
		if($(this).height() < rp.height()){ 
				$(this).height(rp.height())
		}else{ 
			rp.height($(this).height())

		}


})



</script>



</body>
</html>
