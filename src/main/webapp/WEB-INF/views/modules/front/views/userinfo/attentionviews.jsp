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
</head>

<body>

<div id="content" class="Mee"> 
				<div class="mefixd">
				<div class="menav">
					<div class="center">
						<ul>
								<li><a href="${ctx}/userinfo/baseinfo" ><img src=""><p>个人信息</p></a></li>
								<li><a href="${ctx}/userinfo/attentioninfo" class="on"><img src=""><p>我的关注</p></a></li>
								<li><a href="${ctx}/userinfo/userregisterinfo"><img src=""><p>我的预约</p></a></li>
								<li><a href="${ctx}/userinfo/userconsultinfo"><img src=""><p>我的咨询</p></a></li>
								<li><a href="${ctx}/userinfo/reportinfo"><img src=""><p>我的报告</p></a></li>
								<li><a href="${ctx}/userinfo/useroutpatientinfo"><img src=""><p>我的门诊</p></a></li>
								<li><a href="${ctx}/userinfo/palyinfo"><img src=""><p>我的缴费</p></a></li>
								<li><a href="${ctx}/userinfo/orderinfo"><img src=""><p>我的订单</p></a></li>
								<li><a href="${ctx}/userinfo/newscollectinfo"><img src=""><p>我的收藏</p></a></li>
							<!-- 	<li><a href=""><img src=""><p>健康记录评估</p></a></li> -->
								<li><a href="${ctx}/userinfo/healthFile""><img src=""><p>我的健康档案</p></a></li>
								<li><a href="${ctx}/xnh/init""><img src=""><p>新农合</p></a></li>
						</ul>
					</div>

					</div>

				</div>
				
				<div class="met" >
						<div class="center"> 
									<table cellspacing="0" ceelpadding='0'>
									<tr class="tr1"><td width="130px" class="num">序号</td>
										<td width="340px">医院名称</td>
										<td width="200px">科室</td>
										<td width="170px">医生</td>
										<td >操作</td>
										

									</tr>
									<c:forEach var="userAttentioninfo" items="${page.list}" varStatus="varStatus">
									<tr> 
										<td class="num">${varStatus.index+1}</td>
										<td>${userAttentioninfo.doctor.department.hospital.name}</td>
										<td>${userAttentioninfo.doctor.department.name}</td>
										<td> <a href="${ctx}/doctor/${userAttentioninfo.doctor.doctorId}.html">${userAttentioninfo.doctor.name}</a></td>
										  <td>
										    <input id="attentIdy" type="hidden" value="${userAttentioninfo.attentionid}"/>
										    <input id="docotorIdy" type="hidden" value="${userAttentioninfo.doctor.doctorId}"/>
										    <input id="uerIdy" type="hidden" value="${userAttentioninfo.userId}"/>
										    <a onclick="javascript:check('${userAttentioninfo.attentionid}','${userAttentioninfo.doctor.doctorId}','${userAttentioninfo.userId}')" style="cursor:pointer ;">取消关注</a> 
										  </td>

									</tr>
									</c:forEach>

								</table>
								<div class="page pgb">${page}</div>
								<form id="searchForm"  action="${ctx}/userinfo/attentioninfo" name="searchForm" method="post" class="form-inline">
									<input id="pageNo" name="pageNo" type="hidden" value="${pageinfo.pageNo}" /> 
									<input id="pageSize" name="pageSize" 	type="hidden" value="${pageinfo.pageSize}" />
								</form>
						</div>	
				</div>
				  
		</div>
<script>
function check(attentIdy,docotorIdy,uerIdy){
        layer.alert("确认取消关注？",{ 
			btn:['确定','取消'],
			yes:function(){ 
                   window.location.href="${ctx}/userinfo/removeAtten?attentId="+attentIdy+"&docotorId="+docotorIdy+"&uerId="+uerIdy+"&pageNo="+$("#pageNo").val()+"&pageSize="+$("#pageSize").val();
			},/*url跳转*/
			cancel:function(){/*点击取消*/
			}
			});
	       return false; /*整个js执行完后停止*/
};



</script>
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
		//$("#searchForm").attr("action", "${ctx}/doctorinfo/myrepatient");
		$("#searchForm").submit();
		return false;
}
</script>



</body>
</html>
