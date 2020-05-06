<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/front/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<meta name="decorator" content="frontdefault"/>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title></title>
	<meta name="keywords" content="" />
	<meta name="description" content="" />
	<link rel="stylesheet" type="text/css" href="css/style.css" media="all" />
	<link rel="stylesheet" type="text/css" href="css/animat.css" media="all" />
	<link rel="stylesheet" type="text/css" href="css/filp.css" media="all" />
	<script type="text/javascript" src="js/jquery.min.js"></script>
	<script type="text/javascript" src="js/dome.js"></script>
	<script type="text/javascript" src="js/superslide.2.1.js"></script>
</head>

<body>

<div id="content" class="Mee"> 
				<div class="mefixd">
				<div class="menav">
					<div class="center">
						<ul>
								<li><a href="${ctx}/userinfo/baseinfo" ><img src=""><p>个人信息</p></a></li>
								<li><a href="${ctx}/userinfo/attentioninfo"><img src=""><p>我的关注</p></a></li>
								<li><a href="${ctx}/userinfo/userregisterinfo"><img src=""><p>我的预约</p></a></li>
								<li><a href="${ctx}/userinfo/userconsultinfo"><img src=""><p>我的咨询</p></a></li>
								<li><a href="${ctx}/userinfo/reportinfo"><img src=""><p>我的报告</p></a></li>
								<li><a href="${ctx}/userinfo/useroutpatientinfo"><img src=""><p>我的门诊</p></a></li>
								<li><a href="${ctx}/userinfo/palyinfo"><img src=""><p>我的缴费</p></a></li>
								<li><a href="${ctx}/userinfo/orderinfo" class="on"><img src=""><p>我的订单</p></a></li>
								<li><a href="${ctx}/userinfo/newscollectinfo"><img src=""><p>我的收藏</p></a></li>
							<!-- 	<li><a href=""><img src=""><p>健康记录评估</p></a></li> -->
								<li><a href="${ctx}/userinfo/healthFile""><img src=""><p>我的健康档案</p></a></li>
							<li><a href="${ctx}/xnh/init""><img src=""><p>新农合</p></a></li>
						</ul>
					</div>

					</div>

				</div>
				
			<div class="bar">
					<ul>
							<li><a href="${ctx}/userinfo/orderinfo?id=0" class="opacity ">未付款</a></li>
							<li><a href="${ctx}/userinfo/orderinfo?id=1" class="opacity ">已付款</a></li>
							<li><a href="${ctx}/userinfo/orderinfo?id=2" class="opacity ">退订或过期</a></li>
							<li><a href="${ctx}/userinfo/orderinfo?id=3" class="opacity on">已完成</a></li>
							
					</ul>
			</div>
			<div class="met">
						<form id="searchForm" action="${ctx}/userinfo/orderinfo" name="searchForm" class="form-inline">
        			    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
					    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
					    <input id="" name="id" type="hidden" value="3"/>
		 		        </form>		
						<div class="center"> 
									<table cellspacing="0" ceelpadding='0'>
										<tr class="tr1"><td width="130px" class="num">序号</td>
										<td width="260px">订单号</td>
									<!-- 	<td width="260px">医院名称</td>
										<td width="100px">患者姓名</td> -->
										<td width="160px">创建时间</td>
										<td width="120px">总价</td>
										<td width="160px">订单状态</td>
									    <td width="160px">订单类型</td> 
										<td >操作</td>
									    </tr>
									
										<c:forEach items="${page.list}" var="order" varStatus="i">
											<tr>
											<td class="num">${i.index+1}</td>
											<td>${order.pono}</td>
											<%--  <c:set var="hosk" value="${fnf:getHospitalById(order.hospitalId)}"/> 
										    <td>${hosk.name}</td>
										    <td>${order.patientname}</td> --%>
											<td><fmt:formatDate value="${order.pocreatetime}" pattern="yyyy-MM-dd"/></td>
											<td>${order.poallprice}</td>
											 <c:if test="${not empty order.pono}">
											    	<td>已完成</td>
											 </c:if>
											  <c:if test="${empty order.pono}">
											    	<td>异常</td>
											  </c:if>	
											  
											  <c:if test="${order.potype=='1'}">
											        <td>医院产品定单 </td>
											  </c:if>
											  
											  <c:if test="${order.potype=='2'}">
											        <td>协医产品定单</td>
											  </c:if>
											  
											  <c:if test="${order.potype=='3'}">
											        <td>挂号定单</td>
											  </c:if>
											  
											  <c:if test="${order.potype=='4'}">
											        <td>问诊定单</td>
											  </c:if>
											  
											  <c:if test="${order.potype=='5'}">
											        <td>缴费订单 </td>
											  </c:if>
											  
											<td>
							    				<a href="${ctx}/userinfo/orderinfo?lookorder=${order.poid}">查看</a>
											</td>
											</tr>
										</c:forEach> 

								</table>
								<div class="page pgb">${page}</div>
						</div>	
				</div>
				</table>
			</div>
		</div>


		</div>

<script type="text/javascript">

function page(n, s) {
		if (n)
			$("#pageNo").val(n);
		if (s)
			$("#pageSize").val(s);
		$("#searchForm").submit();
		return false;
}



$(".menav li").each(function(a){ 

		var me = $(".menav li:eq("+a+")"),i=a+1;
		if(me.find("a").hasClass("on")){ 
				me.find("img").attr("src","${ctxStaticFront}/images/me_"+i+"h.png")
		}else{ 
			me.find("img").attr("src","${ctxStaticFront}/images/me_"+i+".png")
		}
		
		me.hover(function(){ 
			
			me.find("img").attr("src","${ctxStaticFront}/images/me_"+i+"h.png")
		},function(){ 
			if(!me.find("a").hasClass("on")){ 
				me.find("img").attr("src","${ctxStaticFront}/images/me_"+i+".png")
			}
			

		})
})
</script>



</body>
</html>
