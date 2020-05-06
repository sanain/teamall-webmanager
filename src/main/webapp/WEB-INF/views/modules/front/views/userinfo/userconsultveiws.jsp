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
	<script type="text/javascript" src="${ctxStaticFront}/js/laydate/laydate.js"></script>
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
								<li><a href="${ctx}/userinfo/userconsultinfo" class="on"><img src=""><p>我的咨询</p></a></li>
								<li><a href="${ctx}/userinfo/reportinfo" ><img src=""><p>我的报告</p></a></li>
								<li><a href="${ctx}/userinfo/useroutpatientinfo"><img src=""><p>我的门诊</p></a></li>
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
					</ul>
			    </div>
		   <div class="secbg sle">
			<div class="center">
				<form id="searchForm"  action="${ctx}/userinfo/userconsultinfo" name="searchForm" class="form-inline">
					<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}" /> 
					<input id="pageSize" name="pageSize" 	type="hidden" value="${page.pageSize}" />
					<ul>
					<li id="SelectTime">
					<input type="text" id="startdate" class="Stime" name="checkstarttime" value="${checkStartTime}" placeholder="开始时间"/><span>—</span>
					<input type="text" class="Stime" id="enddate" name="checkendtime" value="${checkEndTime}" placeholder="结束时间"/></li>
						<li><p>咨询类型</p> <select  name="constyle" class="constyle"  >
									 <c:if test="${empty conStyle or conStyle == '0'}">
							        	<option value="0" selected="selected">-----所有-----</option>
							            <option value="1" >图文咨询</option>
							        	<option value="2" >电话咨询</option>
							        	<option value="3" >视频咨询</option>
							        	<option value="10" >免费咨询</option>
							         </c:if>
							         
									 <c:if test="${conStyle == '1'}"> 
										<option value="1" selected="selected">图文咨询</option>
										<option value="0" >所有类型</option>
							        	<option value="2" >电话咨询</option>
							        	<option value="3" >视频咨询</option>
							        	<option value="10" >免费咨询</option>
									 </c:if>	
									
									<c:if test="${conStyle == '2'}"> 
									    <option value="2" selected="selected">电话咨询</option>
									    <option value="0" >所有类型</option>
										<option value="1" >图文咨询</option>
							        	<option value="3" >视频咨询</option>
							        	<option value="10" >免费咨询</option>
									</c:if>	
									
									<c:if test="${conStyle == '3'}"> 
									    <option value="3" selected="selected">视频咨询</option>
									    <option value="0" >所有类型</option>
										<option value="1" >图文咨询</option>
							        	<option value="2" >电话咨询</option>
							        	<option value="10" >免费咨询</option>
									</c:if>	
									
									<c:if test="${conStyle == '10'}"> 
									    <option value="10" selected="selected">免费咨询</option>
									    <option value="0" >所有类型</option>
										<option value="1" >图文咨询</option>
							        	<option value="2" >电话咨询</option>
							        	<option value="3" >视频咨询</option>
									</c:if>	
								  </select>
								</li>

						   <li style="margin-right:0;"><input type="submit" id="submitid"  onclick="return datecheck()" value="搜索"></li>
						
					</ul>
				</form>
			</div>
		</div>
				<div class="met mtn bgxq">
						<div class="center"> 
									<table cellspacing="0" ceelpadding='0' style="width:1000px;margin:20px auto">
									
					 <tr class="tr1">
					        <td width="130px" class="num">序号</td>
							<td width="180px">咨询时间</td>
							<td width="190px">咨询对象</td>
							<td width="180px">咨询状态</td>
							<td width="180px">咨询类型</td>
							<td >操作</td>
					 </tr>
					 
				     	<c:forEach items="${page.list}" var="order" varStatus="i">
									<tr>
									    <td class="num">${i.index+1}</td>
										<td> <fmt:formatDate value="${order.starttime}" pattern="yyyy-MM-dd HH:mm"/></td>
										<td>${order.doctor.name}</td>
										
							             <c:if test="${order.state=='0'}">
										 <td>未开始</td>
										 </c:if>
							             <c:if test="${order.state=='1'}">
										 <td>进行中</td>
										 </c:if>
							             <c:if test="${order.state=='9'}">
										 <td>结束</td>
										 </c:if>
										 
										<c:if test="${order.interrogationtype=='1'}">
										  <td>图文咨询</td>
										  <td><a href="${ctx}/userinfo/userconsultinfo?interid=${order.userinterrogationid}&intertype=${order.interrogationtype}">记录查看</a></td>
										</c:if>
										<c:if test="${order.interrogationtype=='2'}">
										  <td>电话咨询</td>
										  <td><a href="${ctx}/userinfo/userconsultinfo?interid=${order.userinterrogationid}&intertype=${order.interrogationtype}">记录查看</a></td>
										</c:if>
										<c:if test="${order.interrogationtype=='3'}">
										  <td>视频咨询</td>
										  <td><a href="${ctx}/userinfo/userconsultinfo?interid=${order.userinterrogationid}&intertype=${order.interrogationtype}">记录查看</a></td>
										</c:if>
										<c:if test="${order.interrogationtype=='10'}">
										  <td>免费咨询</td>
										  <td><a href="" class="chakan" id="${order.userinterrogationid}">记录查看</a></td>
										  <input type="hidden" id="ids${order.userinterrogationid}" value="${order.interrogationtype}" />
										 
										</c:if>
										<c:if test="${ order.interrogationtype!='10' and order.interrogationtype!='1' and order.interrogationtype!='2'and order.interrogationtype!='3' }">
										  <td>无</td>
										  <td><a href="" class="" id="232">无</a></td>
										</c:if>
										
									</tr>
							</c:forEach>
							
					  </table>
								<div class="page pgb">${page}</div>
						</div>	
				</div>
		</div>

<script>
 if( !('placeholder' in document.createElement('input')) ){  
   
    $('input[placeholder],textarea[placeholder]').each(function(){   
      var that = $(this),   
      text= that.attr('placeholder');   
      if(that.val()===""){   
        that.val(text).addClass('placeholder');   
      }   
      that.focus(function(){   
        if(that.val()===text){   
          that.val("").removeClass('placeholder');   
        }   
      })   
      .blur(function(){   
        if(that.val()===""){   
          that.val(text).addClass('placeholder');   
        }   
      })   
      .closest('form').submit(function(){   
        if(that.val() === text){   
          that.val('');   
        }   
      });   
    });   
  } 
</script>

<script>
laydate.skin('molv');
var start = {
    elem: '#startdate',
    format: 'YYYY-MM-DD',
    max: laydate.now(), //最大日期
    istime: true,
    istoday: false,
    choose: function(datas){
         end.min = datas; //开始日选好后，重置结束日的最小日期
         end.start = datas //将结束日的初始值设定为开始日
    }
};
var end = {
    elem: '#enddate',
    format: 'YYYY-MM-DD',
    max: laydate.now(), //最大日期
    istime: true,
    istoday: false,
    choose: function(datas){
         end.min = datas; //开始日选好后，重置结束日的最小日期
         end.start = datas //将结束日的初始值设定为开始日
    }
};
laydate(start);
laydate(end);
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


</script>

<script type="text/javascript">

  
 function page(n, s) {
		if (n)
			$("#pageNo").val(n);
		if (s)
			$("#pageSize").val(s);
		//$("#searchForm").attr("action", "${ctx}/doctorinfo/myrepatient");
		$("#searchForm").submit();
		return false;
}


function sumns(){
	if($("#startdate").val() == ""){
	 	layer.alert("请填写开始时间！"); 
	 	return false;
	}
	if($("#enddate").val() == ""){
		 layer.alert("请填写结束时间！");
		 return false; 
	}
	 return true;
}
</script>
<script type="text/javascript">
    function datecheck(){
        var sts= $("#startdate").val();
	  if($("#startdate").val() != "" &&$("#enddate").val() !=""){
	   if($("#startdate").val()>$("#enddate").val()){
	      	layer.alert("开始时间不能大于结束时间！"); 
	 	    return false;
	      }
    	}
	}
	
	$(".chakan").on("click", function() {
		var idsvlaue = $(this).attr("id");
		var idss = $("#ids"+idsvlaue).val();
		$("body").css("overflow", "hidden")
		layer.open({
			type : 2,
			title : '免费咨询详情',
			shadeClose : true,
			maxmin : true, //开启最大化最小化按钮
			area : ['1160px', '650px'],
			content : '${ctx}/userinfo/userconsultinfo?interid='+idsvlaue+'&intertype='+idss,
			end : function() {

				$("body").css("overflow", "auto")
			}

		})

	})
</script>
</body>
</html>
