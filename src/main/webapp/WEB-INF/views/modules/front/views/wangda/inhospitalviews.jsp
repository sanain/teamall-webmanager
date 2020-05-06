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
	<%-- <script type="text/javascript" src="${ctxStaticFront}/js/jquery.cascadingdropdown.js"></script>
	 --%>
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
								<li><a href="${ctx}/userinfo/orderinfo"><img src=""><p>我的订单</p></a></li>
								<li><a href="${ctx}/userinfo/newscollectinfo"><img src=""><p>我的收藏</p></a></li>
									<!-- 	<li><a href=""><img src=""><p>健康记录评估</p></a></li> -->
							<li><a href="${ctx}/userinfo/healthFile" class="on"><img src=""><p>我的健康档案</p></a></li>
								<li><a href="${ctx}/xnh/init""><img src=""><p>新农合</p></a></li>
						</ul>
					</div>

					</div>

				</div>
				
				<div class="block_name mtt" style="margin:20px 0;">
				  <p class="">住院记录</p>
			      <div class="brd"></div>
			    </div>
			    <div class="met mtn enone">
				<div class="center">
				
				 <form id="searchForm" action="${ctx}/medical/medicalinfo/InHospitalInfo" name="searchForm" class="form-inline">
        			<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
					<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		 		</form>
					<table cellspacing="0" ceelpadding='0'
						style="width:730px;margin:0 auto">
						<tr class="tr1">
							<td width="140px" class="num">序号</td>
							<td width="135px">入院时间</td>
							<td width="210px">医院</td>
							<td width="160px">疾病</td>
							<td>操作</td>
						</tr>
						<c:forEach items="${page.list}" var="order" varStatus="i">
							<tr>
								    <td class="num">${i.index+1}</td>
									<td>${order.inTime}</td>
							        <td>${order.hispital}</td>
						         	<td>${order.illness}</td>
							        <td><a href="${ctx}/userinfo/inhospitaldruginfo/InHospitalBaseInfo?idextension=${order.idExtension}&idnote=${order.idNote}" class="chakan">查看</a></td>
							</tr>
						</c:forEach>
					 </table>
				 </div>
			</div>
			     <div><ul></br></ul><div>
			    <div class="page pgb">${page}</div>
				
		</div>

<script type="text/javascript">


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

function page(n, s) {
		if (n)
			$("#pageNo").val(n);
		if (s)
			$("#pageSize").val(s);
		$("#searchForm").submit();
		return false;
}

</script>


</body>
</html>
