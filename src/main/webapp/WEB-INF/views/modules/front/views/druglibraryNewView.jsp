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
				<a href="${ctx}/drugNewInfo?drugId=${d.drugid}" >药品详情</a>
			    </div>
        </div>
   
			<div class="jblb">
				<div class="block_name mtt"> 
							
						
							<p class="">${d.businessdrugname }</p>
							<div class="brd"></div>
				</div>
				<div class="yaopxq">
						<p class="pic">
						<c:choose>
							<c:when test="${d.drugurl != null || d.drugurl != '' }">
								<img style="width: 350px; height: 350px;" src="${d.drugurl}"/>
							</c:when>
							<c:otherwise></c:otherwise>
						</c:choose>
						</p>
						<div class="center">
							<p><b style="color:red;">(请在医生指导下使用)</b></p>
							<div class="l">
								<p>商品名: </p>
								<p>药品名: </p>
								<p>英文名:</p>
								<p>规格:</p>
								<p>生产厂家:</p>
								<p>用法用量:</p>
								<p>药物剂型:</p>
								<!-- <p>药理毒理:</p>
								<p>药代动力学:</p> -->
								<p>适应症:</p> 
								<p>禁忌:</p>
								<p>注意事项:</p>
								<p>不良反应:</p>
								<p>药物相互作用:</p>
								<p>适宜人群:</p>
								<p>不适宜人群:</p>
								<p>生产日期:</p>
								<p>保质期:</p>
								<p>用途/功效:</p>
								<p>用药过量:</p>
								<p>贮藏:</p>
								<p>主要成分:</p>
								<p>作用类别:</p>
								<p>包装规格:</p>
								<p>其它内容:</p>
								<p>性状:</p>
								<p>特殊人群用药:</p>
								<p>批准文号:</p>
								<p>批准日期:</p>
								<p>妊娠及哺乳期妇女用药:</p>
								<p>儿童用药:</p>
								<p>老年患者用药:</p>
						
							</div>
							<div class="r">
								<p><span>${d.businessdrugname }</span></p>
								<p><span>${d.drugname }</span></p>
								<p><span>${d.drugenglishname }</span></p>
								<p><span>${d.drugstandard }</span></p>
								<p><span>${d.drugfactory }</span></p>
								<p><span>${d.drugdosage }</span></p>
								<p><span>${d.pharmacy }</span></p>
								<!-- <p><span>${d.drugcruel }</span></p>
								<p><span>${d.drugpower }</span></p> -->
								<p><span>${d.adaptsymptom }</span></p> 
								<p><span>${d.contraindication }</span></p>
								<p><span>${d.drugprecautions }</span></p>
								<p><span>${d.adversereactions }</span></p>
								<p><span>${d.drugmutual }</span></p>
								<p><span>${d.suitpeople }</span></p>
								<p><span>${d.notsuitpeople }</span></p>
								<p><span>${d.productdate }</span></p>
								<p><span>${d.guaranteedatedate }</span></p>
								<p><span>${d.effect }</span></p>
								<p><span>${d.excessive }</span></p>
								<p><span>${d.preserveinfo }</span></p>
								<p><span>${d.drugingredient }</span></p>
								<p><span>${d.regardtype }</span></p>
								<p><span>${d.packaging }</span></p>
								<p><span>${d.othercontents }</span></p>
								<p><span>${d.characterss }</span></p>
								<p><span>${d.specialpeople }</span></p>
								<p><span>${d.approvenumber }</span></p>
								<p><span>${d.approvedate }</span></p>
								<p><span>${d.gestation }</span></p>
								<p><span>${d.childrenuseddrug }</span></p>
								<p><span>${d.oldpatientusedrug }</span></p>

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
