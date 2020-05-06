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
<script type="text/javascript" src="${ctxStaticFront}/js/jquery.cascadingdropdown.js"></script>
		<div id="content"> 
						<div class="newsnav"> 
							<div class="center">
								<a href="${ctx}/">首页  > </a>  <a href="${ctx}/indexsearch?selectstyle=1"> 药品查询  </a>
							</div>
						</div>
			<div class="jblb">
				<div class="block_name mtt"> 
							
							<span class="">Drug inquiry</span>
							<p class="">药品查询</p>
							<div class="brd"></div>
				</div>

				<div class="cxbg">
					<%-- <form class="cxform">
						<p>
						<b>药品查询</b>
						<input type="text" placeholder="请输入查询关键字" class="cx" value="${drugname}">
						<input type="submit" value="查询" class="tj">
						</p>
											
					</form> --%>
					<form id="searchForm" action="${ctx}/indexsearch?selectstyle=1" name="searchForm" class="cxform">
                     <p>
						<b>药品查询</b>
						<input name="selectstyle"  type="hidden" value="1"/>
						<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
					    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
						<input type="text" name="searchcontent" placeholder="请输入查询关键字" class="cx" value="${searchname}">
						<input type="submit" value="查询" class="tj">
					 </p>
		 		   </form>
					
				</div>
					<div class="met mtn enone">
								
						<div class="center"> 
									<table cellspacing="0" ceelpadding='0' >
										<tr class="tr1">
											<td width="400px" class="num">商品名</td>
											<td width="240px">药品名</td>
											<td width="240px">准字号</td>
											<td width="260px">规格 </td>
											<td width="360px">适应症</td>
											<td width="90px">操作</td>
										</tr>
									<c:forEach items="${page.list}" var="drug" varStatus="i">
										
										<tr> 
											<td class="num">
												<c:set var="drugbusinessname" value="${fns:abbr(drug.businessdrugname,24)}"/>
                                                ${drugbusinessname}
											</td>
											<td>
												<c:set var="yaopinming" value="${fns:abbr(drug.drugname,24)}"/>
                                                ${yaopinming}
											</td>
											<td>${drug.approvenumber}</td>
											<td>${drug.drugstandard}</td>
											<td>
												<p>
												<c:set var="features" value="${fns:abbr(drug.adaptsymptom,100)}"/>
                                                ${features}
												</p>
											</td>
											<td>
											  <a href="${ctx}/drugNewInfo?drugId=${drug.drugid}">详情</a>
											</td>
										</tr>
								   </c:forEach>
								</table>
						 </div>	
			    	</div>

					<div class="page pgb">${page}</div>
				<!-- 	<div class="page pgb"><ul>
					<li class="disabled"><a href="javascript:">&#171; 上一页</a></li>
					<li class="active"><a href="javascript:">1</a></li>
					<li class="disabled"><a href="javascript:">下一页 &#187;</a></li>
					<li class="disabled controls"><a href="javascript:">当前 <input type="text" value="1" onkeypress="var e=window.event||this;var c=e.keyCode||e.which;if(c==13)page(this.value,10);" onclick="this.select();"/> / <input type="text" value="10" onkeypress="var e=window.event||this;var c=e.keyCode||e.which;if(c==13)page(1,this.value);" onclick="this.select();"/> 条，共 1 条</a><li>
					</ul>
					</div> -->
			</div>
		</div>
		
		
		
		
		
<!-- <script type="text/javascript">


$(".menav li").each(function(a){ 
		var me = $(".menav li:eq("+a+")"),i=a+1;
		me.find("img").attr("src","images/me_"+i+".png")
		me.hover(function(){ 
			me.find("img").attr("src","images/me_"+i+"h.png")
		},function(){ 
			me.find("img").attr("src","images/me_"+i+".png")

		})
})

</script> -->
<script type="text/javascript" >
function page(n, s) {
		if (n)
			$("#pageNo").val(n);
		if (s)
			$("#pageSize").val(s);
		$("#searchForm").submit();
		return false; }
</script>




</body>
</html>
