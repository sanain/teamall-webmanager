<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>商品列表</title>
	<meta name="decorator" content="default"/>
	<link rel="stylesheet" href="${ctxStatic}/sbShop/css/build.css">
	<style>
        .check{position: fixed;top:0;left: 0;right: 0;bottom: 0;background: rgba(0,0,0,0.3);z-index: 10000}
        .check-box{width: 750px;background: #ffffff;position: absolute;top: 50%;left: 50%;margin-left: -375px;margin-top: -200px;}
        .check-box>p{height: 35px;line-height: 35px;background: #f0f0f0;position: relative;text-align: center}
        .check-box>p img{position: absolute;top:12px;right: 15px;cursor: pointer}
        .check-box ul{overflow: hidden;padding: 10px;outline:none;list-style:none}
        .check-box ul li.checkbox{float: left;width: 30%;line-height: 30px;margin-top: 0;}
        .check-box ul li.checkbox input{position:relative;left:8px}
        .check-btn{text-align: center;padding-bottom: 20px}
        .check-btn a{display: inline-block;width: 80px;height: 30px;line-height: 30px;border-radius: 5px;border: 1px solid #dcdcdc}
        .check-btn a:nth-child(1){background: #68C250;border: 1px solid #68C250;color: #ffffff;margin-right: 5px}
        .check-btn a:nth-child(2){color: #666666;margin-left: 5px}
        .check-box .checkbox input[type="checkbox"]:checked + label::before {
            background: #68C250;
            top:0 px;
            border: 1px solid #68C250;
        }
        .check-box .checkbox label::before{
            top: 0px;
        }
        .check-box .checkbox i{
            position: absolute;
            width: 12px;
            height: 8px;
            background: url(../images/icon_pick.png) no-repeat;
            top: 4px;
            left: -18px;
            cursor: pointer;
        }
        .check-box .checkbox input{top: 10px;position:relative}
    </style>
	<script type="text/javascript">
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").attr("action","${ctxsys}/UserAmtStatistics/orderlist");
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
	 <form id="searchForm" action="${ctxsys}/UserAmtStatistics/orderlist" method="post" class="breadcrumb form-search ">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo }"/>
	    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize }" />
	    <input id="time" name="time" type="hidden" value="${time }" />
		<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form">
			<li>
		    	<label>订单编号</label>
		    	<input id="orderNo" name="orderNo" class="input-medium"  placeholder="请输入订单编号"/>
			</li>
			<li>
		        <label>用户账号</label>
		        <input id="mobile" name="mobile" class="input-medium" placeholder="请输入用户账号"/>
		       </li>
			<li>
		      <label>订单类型</label>
		     <select id="amtType" name="amtType" class="input-medium">
		         <option value="">金额类型</option>
		         <option value="1" <c:if test="${amtType==1}">selected="selected" </c:if>>购物</option>
		         <option value="2" <c:if test="${amtType==2}">selected="selected" </c:if>>充值</option>
		         <option value="3" <c:if test="${amtType==3}">selected="selected" </c:if>>返现</option>
		         <option value="4" <c:if test="${amtType==4}">selected="selected" </c:if>>提现</option>
		         <option value="5" <c:if test="${amtType==5}">selected="selected" </c:if>>积分兑现</option>
		         <option value="6" <c:if test="${amtType==6}">selected="selected" </c:if>>领取积分</option>
		         <option value="7" <c:if test="${amtType==7}">selected="selected" </c:if>>积分奖励</option>
		         <option value="8" <c:if test="${amtType==8}">selected="selected" </c:if>>线下门店消费</option>
		         <option value="9" <c:if test="${amtType==9}">selected="selected" </c:if>>后台充值,转账</option>
		         <option value="10" <c:if test="${amtType==10}">selected="selected" </c:if>>线上货款</option>
		         <option value="11" <c:if test="${amtType==11}">selected="selected" </c:if>>爱心奖励</option>
		         <option value="12" <c:if test="${amtType==12}">selected="selected" </c:if>>商家付款</option>
		         <option value="13" <c:if test="${amtType==13}">selected="selected" </c:if>>线下货款</option>
		         <option value="14" <c:if test="${amtType==14}">selected="selected" </c:if>>退款</option>
		         <option value="15" <c:if test="${amtType==15}">selected="selected" </c:if>>购买精英合伙人</option>
                 <option value="16" <c:if test="${amtType==16}">selected="selected" </c:if>>线下充值</option>
               </select>
		      </li>
		       <li><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/></li>
		       <shiro:hasPermission name="merchandise:order:edit">
			   <li><input id="btnExport" class="btn btn-primary check-a1" type="button" value="导出"/></li>
			   </shiro:hasPermission>
		</ul>
		 <div class="check1">
    <div class="check-box">
        <p>导出选项<img class="check-del1" src="${ctxStatic}/sbShop/images/xxx-rzt.png" alt=""></p>
          <ul class="mn1">
	          <li class="checkbox"><input type="checkbox" class="kl" value="" id="all"><label><i></i>全选</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="1"><label><i></i>交易时间</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="2"><label><i></i>用户账号</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="3"><label><i></i>订单类型</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="4"><label><i></i>订单编号</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="5"><label><i></i>交易金额</label></li>
          </ul>
        <div class="check-btn">
            <a href="javascript:;" id="fromNewActionSbM" >确定</a>
            <a class="check-del1" href="javascript:;">取消</a>
        </div>
      </div>
    </div>
    </form> 
	
	<tags:message content="${message}"/>
	<table id="treeTable" class="table table-striped table-condensed table-bordered" >
		<tr>
		<th>交易时间</th>
		<th>用户账号</th>
		<th>订单类型</th>
		<th>订单编号</th>
		<th>交易金额</th>
		</tr>
		<c:forEach items="${page.list}" var="pmAmtLog" varStatus="status">
			<tr>
			    <td>${pmAmtLog.createTime }</td>
			    <td>${pmAmtLog.ebUser.mobile }</td>
				<td>
				     <c:if test="${pmAmtLog.amtType==1 }">购物</c:if>
					 <c:if test="${pmAmtLog.amtType==2 }">充值</c:if>
					 <c:if test="${pmAmtLog.amtType==3 }">返现</c:if>
					 <c:if test="${pmAmtLog.amtType==4 }">提现</c:if>
					 <c:if test="${pmAmtLog.amtType==5 }">积分兑现</c:if>
					 <c:if test="${pmAmtLog.amtType==6 }">领取红包</c:if>
					 <c:if test="${pmAmtLog.amtType==7 }">${fns:getProjectName()}奖励</c:if>
					 <c:if test="${pmAmtLog.amtType==8 }">线下门店消费</c:if>
					 <c:if test="${pmAmtLog.amtType==9 }">后台充值,转账</c:if>
					 <c:if test="${pmAmtLog.amtType==10 }">线上贷款</c:if>
					 <c:if test="${pmAmtLog.amtType==11 }">爱心奖励</c:if>
					 <c:if test="${pmAmtLog.amtType==12 }">商家付款</c:if>
					 <c:if test="${pmAmtLog.amtType==13 }">线下贷款</c:if>
					 <c:if test="${pmAmtLog.amtType==14 }">退款</c:if>
					 <c:if test="${pmAmtLog.amtType==15 }">购买精英合伙人</c:if>
					 <c:if test="${pmAmtLog.amtType==16 }">线下充值</c:if>
			    </td>
				<td>${pmAmtLog.ebOrder.orderNo }</td>
				<td>${pmAmtLog.amt }</td>
			</tr>
		</c:forEach>
	</table>
	<div class="pagination">${page}</div>
	
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
			    url : "${ctxsys}/UserAmtStatistics/amtLogExsel",
			    success : function (data) {
			         window.location.href=data; 
			    }
	         });
     });
	</script>
</body>
</html>