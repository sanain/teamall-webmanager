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

<body >

<div id="content" class="Mee"> 
				<div class="mefixd">
				<div class="menav">
					<div class="center">
						<ul>
								<li><a href="${ctx}/userinfo/baseinfo" ><img src=""><p>个人信息</p></a></li>
								<li><a href="${ctx}/userinfo/attentioninfo"><img src=""><p>我的关注</p></a></li>
								<li><a href="${ctx}/userinfo/userregisterinfo" class="on"><img src=""><p>我的预约</p></a></li>
								<li><a href="${ctx}/userinfo/userconsultinfo" ><img src=""><p>我的咨询</p></a></li>
								<li><a href="${ctx}/userinfo/reportinfo" ><img src=""><p>我的报告</p></a></li>
								<li><a href="${ctx}/userinfo/useroutpatientinfo" ><img src=""><p>我的门诊</p></a></li>
								<li><a href="${ctx}/userinfo/palyinfo" ><img src=""><p>我的缴费</p></a></li>
								<li><a href="${ctx}/userinfo/orderinfo"  ><img src=""><p>我的订单</p></a></li>
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
				<li><a href="${ctx}/userinfo/userregisterinfo?id=0" class="opacity on">我的预约</a>
				</li>
				<li><a href="${ctx}/userinfo/userregisterinfo?id=1" class="opacity">我为他人预约</a>
				</li>

			</ul>
		</div>
		<div class="met">

			<div class="center">
				<table cellspacing="0" ceelpadding='0'>
					<tr class="tr1">
						<td width="130px" class="num">序号</td>
						<td width="230px">医院名称</td>
						<td width="160px">科室</td>
						<td width="80px">医生</td>
						<td width="160px">预约就诊时间</td>
						<td width="140px">预约时间</td>
						<td width="90px">预约情况</td>
						<td width="90px">取号情况</td>
						<td>操作</td>
					</tr>
					<c:if test="${empty page.list}">
					
					
					
					
					</c:if>
					
					<c:forEach var="rgistermsg" items="${page.list}" varStatus="varStatus">
					 <c:set var="hosp" value="${fnf:getHospitalById(rgistermsg.hospitalId)}"/> 
					<tr>
						<td class="num">${varStatus.index+1}</td>  
						<td>${hosp.name}</td>
						<td>${rgistermsg.departmentname}</td>
						<td>${rgistermsg.doctorname}</td>
						 <c:if test="${rgistermsg.sourcetimetype=='1'}">
						   <td>
						   <fmt:formatDate value="${rgistermsg.sourcedate}" pattern="yyyy-MM-dd"/>(上午)
						   </td>
						</c:if>
					    <c:if test="${rgistermsg.sourcetimetype=='2'}">
						  <td>
						  <fmt:formatDate value="${rgistermsg.sourcedate}" pattern="yyyy-MM-dd"/>(下午)
						  </td>
						</c:if>
						  <c:if test="${rgistermsg.sourcetimetype=='3'}">
						  <td>
						  <fmt:formatDate value="${rgistermsg.sourcedate}" pattern="yyyy-MM-dd"/>(晚上)
						  </td>
						</c:if>
						 <c:if test="${empty rgistermsg.sourcetimetype}">
						 <td>
						 <fmt:formatDate value="${rgistermsg.sourcedate}" pattern="yyyy-MM-dd"/>
						 </td>
						</c:if>
						<td><fmt:formatDate value="${rgistermsg.createtime}" pattern="yyyy-MM-dd HH:mm"/></td>
						
						 <c:if test="${ rgistermsg.state != 10}">
						      <c:choose>
						           <c:when test="${rgistermsg.postate=='0'}"><td><span>未付款</span></td></c:when>
						           <c:when test="${rgistermsg.postate=='1'}"><td><span>已付款</span></td></c:when>
					               <c:when test="${rgistermsg.postate=='2'}"><td><span>现场支付</span></td></c:when>
					               <c:when test="${rgistermsg.postate=='8'}"> <td><span>已过期</span></td></c:when>
						           <c:when test="${rgistermsg.postate=='9'}"> <td><span>已退号</span></td></c:when>
						          <c:otherwise> 
						          <td><span>状态异常</span></td>
						          </c:otherwise>
						      </c:choose>
						     
						</c:if>
						
						 <c:if test="${ rgistermsg.state == 10}">
						        <td><span>预约失败</span></td>
						     
						</c:if>
						 <input type="hidden" id="rids" value="${rgistermsg.registerrecordid}" />
						 <c:if test="${not empty rgistermsg.doctorstatus}">
						    <c:if test="${rgistermsg.doctorstatus=='1'}"><td><span>停诊</span></td></c:if>
						    <c:if test="${rgistermsg.doctorstatus=='2'}"><td><span>替诊</span></td></c:if>
						</c:if>
					<td>
					    <c:if test="${rgistermsg.state=='1' && rgistermsg.isused=='0'}"><span>未取号</span></c:if>
					    <c:if test="${rgistermsg.state=='1' && rgistermsg.isused=='1'}"><span>已取号</span></c:if>
						</td>
						<td><a href="${ctx}/userinfo/userregisterinfo?id=2&rid=${rgistermsg.registerrecordid}">查看</a>
					    <c:if test="${rgistermsg.state==1}"><a  href="" onclick="backrgister('${rgistermsg.registerrecordid}')">退号</a> </c:if> 
						 </td>
					</tr> 
					</c:forEach>
					
				</table>
			</div>
			<div class="page pgb">${page}</div>
		  </div>
		 <form id="searchForm" action="${ctx}/userinfo/userregisterinfo"  name="searchForm" class="form-inline">
        	<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
			<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
			<input id="" name="id" type="hidden" value="0"/>
		 </form>
		   <input id="pidcard" name="" type="hidden" value="${userinfo.cardid}"/>
		</div>

<script type="text/javascript">
$(document).ready(function(){//页面加载验证是否有身份证号
	  var idcard=$("#pidcard").val();
	  if(idcard.length<8){
	    layer.confirm('请实名认证后再查询预约记录！', {
	    btn: ['去实名认证','不需要实名认证'] //按钮
	      }, function(){
	      window.location.href="${ctx}/userinfo/authinfo"
	       }, function(){
	    });
	   }
  })
</script>
<script type="text/javascript" >
function page(n, s) {
		if (n)
			$("#pageNo").val(n);
		if (s)
			$("#pageSize").val(s);
		$("#searchForm").submit();
		return false; }
</script>

<script type="text/javascript">
	function backrgister(ridsid){
	//var ridsid = $("#rids").val(); //获取registerrecordid值
	layer.confirm('您确定需要取消预约吗？', {
    btn: ['确定','取消'] //按钮
      }, function(){
      
    	$.ajax({
	 	type: "POST",
			url: "${ctx}/userinfo/backregister?rid="+ridsid, //这是跳转目标地址
			cache:false,
			async: false, //表示异步传输
			success: function(jsonJson){// jsonJson表示返回的数据
				if(jsonJson.success){
				    layer.msg(jsonJson.msg);
					window.location.reload(); //刷新当前页面
				}else{
				   layer.msg(jsonJson.msg);
					}
			}
		});     
      
       }, function(){
   });
		
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
