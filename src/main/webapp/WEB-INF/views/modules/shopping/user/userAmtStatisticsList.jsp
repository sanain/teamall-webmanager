<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<meta name="decorator" content="default"/>
	<title>余额汇总列表</title>
	<link rel="stylesheet" href="${ctxStatic}/sbShop/css/build.css">
	<link rel="stylesheet" href="${ctxStatic}/sbShop/css/admin_userAmtlog.css">
	<script type="text/javascript" src="${ctxStatic}/sbShop/js/admin_userAmtlog.js"></script>
	<script type="text/javascript">
	
	function page(n,s){
		if(n)$("#pageNo").val(n);
		if(s)$("#pageSize").val(s);
		$("#searchForm").attr("action","${ctxsys}/UserAmtStatistics");
		$("#searchForm").submit();
	    return false;
	}
	
	 $(function(){
		 	$('.check1').hide();
	    	$('body').on('click','.check-a1',function(){
	    		$('.check1').show();
	    	});
	    	
	    	$('body').on('click','.check-del1',function(){
	    		$('.check1').hide();
	    	});
	     });

	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctxsys}/UserAmtStatistics">余额汇总列表</a></li>
	</ul>
	 <form id="searchForm" action="UserAmtStatistics" method="post" class="breadcrumb form-search ">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
		<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form">
		    <li>
			    <input class="small" type="text" style="width:130px" name="startTime" id="startTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" value="${startTime}" placeholder="请输入开始时间"/>
			    <span>-</span>
			    <input class="small" type="text" style="width:130px" name="endTime" id="endTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" style=" width: 100px;" value="${endTime}" placeholder="请输入结束时间"/>
	        </li>
	        <li><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/></li>
	        <li><input id="btnExport" class="btn btn-primary check-a1" type="button" value="导出"/></li>
		</ul>

	<div class="check1">
    <div class="check-box">
        <p>导出选项<img class="check-del1" src="${ctxStatic}/sbShop/images/xxx-rzt.png" alt=""></p>
          <ul class="mn1">
	          <li class="checkbox"><input type="checkbox" class="kl" value="" id="all"><label><i></i>全选</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="1"><label><i></i>日期</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="2"><label><i></i>平台总余额</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="3"><label><i></i>用户充值余额</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="4"><label><i></i>分红金额</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="5"><label><i></i>退款金额</label></li>
          </ul>
        <div class="check-btn">
            <a href="javascript:;" id="fromNewActionSbM" >确定</a>
            <a class="check-del1" href="javascript:;">取消</a>
        </div>
      </div>
    </div>
    </form> 
	<tags:message content="${message}"/>
	<table id="treeTable" class="table table-striped table-condensed table-bordered">
		<tr>
		 <th>日期</th>
		 <th>余额</th>
		 <th>充值余额</th>
		 <th>第三方渠道退款（非余额退款）</th>
		 <th>分红余额（用户+代理）</th>
		 <th>代理余额</th>
		 <th>余额交易金额（余额付款-余额退款）</th>
		 <th>操作</th>
		</tr>
		<c:forEach items="${page.list}" var="pmAmtStatistics">
			<tr>
			    <td>${pmAmtStatistics.time }</td>
			    <td>${pmAmtStatistics.userCurrentAmt+pmAmtStatistics.agentCurrentAmt }</td>
			    <c:set var="userCurrentAmt" value="${pmAmtStatistics.userCurrentAmt+pmAmtStatistics.agentCurrentAmt + userCurrentAmt }"></c:set> 
			    <td>${pmAmtStatistics.rechargeAmt }</td>
			    <c:set var="rechargeAmt" value="${pmAmtStatistics.rechargeAmt + rechargeAmt }"></c:set> 
			    <td>${pmAmtStatistics.refundPayAmt}</td>
			    <c:set var="refundPayAmt" value="${pmAmtStatistics.refundPayAmt + refundPayAmt }"></c:set> 
			    <td>${pmAmtStatistics.userTodayAmt+pmAmtStatistics.agentTodayAmt}</td>
			    <c:set var="todayAmt" value="${pmAmtStatistics.userTodayAmt+pmAmtStatistics.agentTodayAmt + todayAmt }"></c:set>
				 <td>${pmAmtStatistics.agentCurrentAmt}</td>
				  <c:set var="agentCurrentAmt" value="${pmAmtStatistics.agentCurrentAmt + agentCurrentAmt }"></c:set>
				 <td>${pmAmtStatistics.amtPayAmt-pmAmtStatistics.amtRefundAmt}</td>
				 <c:set var="amtPayRefundAmt" value="${pmAmtStatistics.amtPayAmt-pmAmtStatistics.amtRefundAmt + amtPayRefundAmt }"></c:set>
			    <td><a href="${ctxsys}/UserAmtStatistics/orderlist?time=${pmAmtStatistics.time}">查看明细</a></td>
			</tr>
		</c:forEach>
		<tr>
			<th>合计</th>
			<th>${fns:getAmt(userCurrentAmt)}</th>
			<th>${fns:getAmt(rechargeAmt )}</th>
			<td>${fns:getAmt(refundPayAmt)}</td>
			<th>${fns:getAmt(todayAmt)}</th>
			<th>${fns:getAmt(agentCurrentAmt)}</th>
			<th>${fns:getAmt(amtPayRefundAmt)}</th>
			<th></th>
		  </tr>
	</table>
	<div class="pagination">${page}</div>
	
	<div class="lishi"></div>
	<script type="text/javascript">
	  $('#all').click(function(){
	        if($(this).is(':checked')){
	            $('.kl').prop('checked',true).attr('checked',true);
	            $('#all').prop('checked',true).attr('checked',true);
	        }else {
	            $('.kl').removeAttr('checked');
	            $('#all').removeAttr('checked');
	        }
	    });
	  
		$('body').on('click','.kl',function(){
	        if ($('.kl').length==$('.kl[type=checkbox]:checked').length){
	            $('#all').prop('checked',true).attr('checked',true);
	        }else {
	            $('#all').removeAttr('checked');
	        }
	    })
	
     $('#fromNewActionSbM').click(function(){
	     $.ajax({
			    type : "POST",
			    data:$('#searchForm').serialize(),
			    url : "${ctxsys}/UserAmtStatistics/statisticsExsel",   
			    success : function (data) {
			        window.location.href=data; 
			    }
	         });
     });
    </script>
	<input type="hidden" id="ctxsys" name="ctxsys" value="${ctxsys}"/>

</body>
</html>