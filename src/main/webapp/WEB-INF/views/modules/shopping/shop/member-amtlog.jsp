<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0,minimal-ui">
    <meta name="Description" content="${fns:getProjectName()},余额明细"/>
	<meta name="Keywords" content="${fns:getProjectName()},余额明细"/>
    <title>余额明细</title>
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/admin-member-account.css">
    <%--<link rel="stylesheet" href="${ctxStatic}/sbShop/css/bootstrap.min.css">--%>
    <link rel="stylesheet" href="${ctxStatic}/bootstrap/2.3.1/css_cerulean/bootstrap.min.css">
    <script src="${ctxStatic}/sbShop/js/jquery.min.js"></script>
    <script src="${ctxStatic}/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
	<script type="text/javascript">
	function page(n,s){
		$("#pageNo").val(n);
		$("#pageSize").val(s);
		$("#searchForm").attr("action","${ctxsys}/PmShopInfo/useramtlog?id=${pmShopInfo.id}");
		$("#searchForm").submit();
	    return false;
	}
	</script>
    <style type="text/css">
        .nav-ul li a.active {
            color: #69AC72;

            border-bottom: 2px solid #69AC72;
        }
        .nav-ul li a {
            display: inline-block;
            color: #666666;
            line-height: 40px;
            height: 40px;
        }
        .nav-ul li {
            float: left;
            padding-right: 4%;
        }
        .nav-ul {
            overflow: hidden;
            height: 42px;
            line-height: 40px;
            background: #ffffff;
            padding-left: 33px;
            margin-bottom: 20px;
        }
        .c-context {
            padding: 10px;
            background: #E3E4E6;
        }

    </style>
</head>
<body>
    <div class="c-context">
      <ul class="nav-ul">
          <li><a href="${ctxsys}/PmShopInfo/shopinfo?id=${pmShopInfo.id}">门店信息</a></li>
          <li><a  href="${ctxsys}/PmShopInfo/employees?id=${pmShopInfo.id}">门店员工</a></li>
          <li><a href="${ctxsys}/PmShopInfo/device?id=${pmShopInfo.id}">登录设备信息</a></li>
          <li><a  href="${ctxsys}/PmShopInfo/amtlogIndex?id=${pmShopInfo.id}">门店结算</a></li>
          <li><a class="active"  href="${ctxsys}/PmShopInfo/useramtlog?id=${pmShopInfo.id}">收支明细</a></li>
      </ul>
      <form id="searchForm" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
		<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
        <div class="balance">
            <div class="select-div">
                <span>类型：</span>
                <select id="amtType" name="amtType">
                    <option value="" selected="selected">-请选择-</option>
                    <option ${amtType=='1'?'selected':''} value="1">消费</option>
                    <option ${amtType=='2'?'selected':''} value="2">充值</option>
                    <%--<option ${amtType=='3'?'selected':''} value="3">返现</option>--%>
                    <option ${amtType=='4'?'selected':''} value="4">提现</option>
                    <%--<option ${amtType=='5'?'selected':''} value="5">积分兑现</option>--%>
                    <%--<option ${amtType=='6'?'selected':''} value="6">领取积分</option>--%>
                    <%--<option ${amtType=='7'?'selected':''} value="7">积分奖励</option>--%>
                    <%--<option ${amtType=='8'?'selected':''} value="8">线下店铺消费</option>--%>
                    <option ${amtType=='9'?'selected':''} value="9">后台充值</option>
                    <option ${amtType=='10'?'selected':''} value="10">线上货款</option>
                    <%--<option ${amtType=='11'?'selected':''} value="11">爱心奖励</option>--%>
<%--                    <option ${amtType=='12'?'selected':''} value="12">商家付款</option>--%>
                    <%--<option ${amtType=='13'?'selected':''} value="13">线下货款</option>--%>
                    <option ${amtType=='14'?'selected':''} value="14">退款</option>
                    <%--<option ${amtType=='15'?'selected':''} value="15">购买精英合伙人</option>--%>
                    <%--<option ${amtType=='16'?'selected':''} value="16">线下充值</option>--%>

                    <%--<option value="" selected="selected">-请选择-</option>--%>
                    <%--<option ${amtType=='1'?'selected':''} value="1">购物</option>--%>
                    <%--<option ${amtType=='2'?'selected':''} value="2">充值</option>--%>
                    <%--<option ${amtType=='3'?'selected':''} value="3">返现</option>--%>
                    <%--<option ${amtType=='4'?'selected':''} value="4">提现</option>--%>
                    <%--<option ${amtType=='5'?'selected':''} value="5">积分兑现</option>--%>
                    <%--<option ${amtType=='6'?'selected':''} value="6">领取积分</option>--%>
                    <%--<option ${amtType=='7'?'selected':''} value="7">积分奖励</option>--%>
                    <%--<option ${amtType=='8'?'selected':''} value="8">线下店铺消费</option>--%>
                    <%--<option ${amtType=='9'?'selected':''} value="9">后台充值,转账</option>--%>
                    <%--<option ${amtType=='10'?'selected':''} value="10">线上货款</option>--%>
                    <%--<option ${amtType=='11'?'selected':''} value="11">爱心奖励</option>--%>
                    <%--<option ${amtType=='12'?'selected':''} value="12">商家付款</option>--%>
                    <%--<option ${amtType=='13'?'selected':''} value="13">线下货款</option>--%>
                    <%--<option ${amtType=='14'?'selected':''} value="14">退款</option>--%>
                    <%--<option ${amtType=='15'?'selected':''} value="15">购买精英合伙人</option>--%>
                    <%--<option ${amtType=='16'?'selected':''} value="16">线下充值</option>--%>
                </select>
                <span>收支：</span>
                <select id="amt" name="amt">
                	<option value="" selected="selected">-请选择-</option>
                    <option ${amt=='1'?'selected':''} value="1">收入</option>
                    <option ${amt=='2'?'selected':''} value="2">支出</option>
                </select>
                <span>时间：</span>
                <input id="startTime" name="startTime" type="txt" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"style="width:155px" value="${startTime}">
              	<b>—</b>
               	<input id="endTime" name="endTime" type="txt" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width:155px" value="${endTime}">
                <a class="btn" href="javascript:;" onclick="return page();">查询</a>
            </div>
            <div class="balance-list">
                <ul class="list-top">
                    <li>时间</li>
                    <li>类型</li>
                    <li>收入/支出</li>
                    <li>金额</li>
                    <li>备注</li>
                </ul>
                <div class="list-body">
                <c:forEach items="${page.list}" var="useramtlog">
                    <ul>
                        <li><fmt:formatDate value="${useramtlog.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></li>
                        <li>
                            <c:if test="${useramtlog.amtType==1}">消费</c:if>
                            <c:if test="${useramtlog.amtType==2}">充值</c:if>
                            <%--<c:if test="${useramtlog.amtType==3}">返现</c:if>--%>
                            <c:if test="${useramtlog.amtType==4}">提现</c:if>
                            <%--<c:if test="${useramtlog.amtType==5}">积分兑现</c:if>--%>
                            <%--<c:if test="${useramtlog.amtType==6}">领取积分</c:if>--%>
                            <%--<c:if test="${useramtlog.amtType==7}">积分奖励</c:if>--%>
                            <%--<c:if test="${useramtlog.amtType==8}">线下店铺消费</c:if>--%>
                            <c:if test="${useramtlog.amtType==9}">后台充值</c:if>
                            <c:if test="${useramtlog.amtType==10}">线上货款</c:if>
                            <%--<c:if test="${useramtlog.amtType==11}">爱心奖励</c:if>--%>
<%--                            <c:if test="${useramtlog.amtType==12}">商家付款</c:if>--%>
                            <%--<c:if test="${useramtlog.amtType==13}">线下货款</c:if>--%>
                            <c:if test="${useramtlog.amtType==14}">退款</c:if>
                            <%--<c:if test="${useramtlog.amtType==15}">购买精英合伙人</c:if>--%>
                            <%--<c:if test="${useramtlog.amtType==16}">线下充值</c:if>--%>

					    	<%--<c:if test="${useramtlog.amtType==1}">购物</c:if>--%>
		                    <%--<c:if test="${useramtlog.amtType==2}">充值</c:if>--%>
		                    <%--<c:if test="${useramtlog.amtType==3}">返现</c:if>--%>
		                    <%--<c:if test="${useramtlog.amtType==4}">提现</c:if>--%>
		                    <%--<c:if test="${useramtlog.amtType==5}">积分兑现</c:if>--%>
		                    <%--<c:if test="${useramtlog.amtType==6}">领取积分</c:if>--%>
		                    <%--<c:if test="${useramtlog.amtType==7}">积分奖励</c:if>--%>
		                    <%--<c:if test="${useramtlog.amtType==8}">线下店铺消费</c:if>--%>
		                    <%--<c:if test="${useramtlog.amtType==9}">后台充值,转账</c:if>--%>
		                    <%--<c:if test="${useramtlog.amtType==10}">线上货款</c:if>--%>
		                    <%--<c:if test="${useramtlog.amtType==11}">爱心奖励</c:if>--%>
		                    <%--<c:if test="${useramtlog.amtType==12}">商家付款</c:if>--%>
		                    <%--<c:if test="${useramtlog.amtType==13}">线下货款</c:if>--%>
		                    <%--<c:if test="${useramtlog.amtType==14}">退款</c:if>--%>
		                    <%--<c:if test="${useramtlog.amtType==15}">购买精英合伙人</c:if>--%>
		                    <%--<c:if test="${useramtlog.amtType==16}">线下充值</c:if>--%>
                        </li>
                        <li>
                            <c:if test="${useramtlog.amtType==4}">(支出)提现</c:if>
                            <c:if test="${useramtlog.amtType!=4}">
                        	<c:if test="${useramtlog.amt>0}">收入</c:if>
		                    <c:if test="${useramtlog.amt<0}">支出</c:if>
		                    <c:if test="${useramtlog.amt==0}"></c:if>
                            </c:if>
                        </li>
                        <li class="allAmtSum order-amount" >
                            <c:if test="${useramtlog.amt>0}">+ ${useramtlog.amt}</c:if>
                            <c:if test="${useramtlog.amt<=0}">${useramtlog.amt}</c:if>

                        </li>
                        <li class="allAmtSum">${useramtlog.remark}
                        </li>
                    </ul>
                </c:forEach>
                </div>
                <ul class="list-bottom">
                    <li>合计：</li>
                    <li></li>
                    <li></li>
                    <li id="allAmtSum"></li>
                </ul>
            </div>
	      <div class="pagination" style="margin-top: -15px;margin-left: 20px;">${page}</div>
        </div>
     </form>
    </div>
</body>
<script type="text/javascript">
	var allAmtSum=0;
	for (var i= 0; i < $('.order-amount').length; i++) {
	    var allAmitSumStr = $($('.order-amount')[i]);


	    if(allAmitSumStr == undefined || allAmitSumStr.text() == undefined || allAmitSumStr.text() == ""){
	        continue;
        }

        //把扩大100，避免js的浮点型相加，导致小数位不准确
        if(allAmitSumStr.text().trim().charAt(0) == "-"){
            allAmtSum-=parseFloat(allAmitSumStr.text().trim().substr(1))*100;
        }else{
            allAmtSum+=parseFloat(allAmitSumStr.text().trim().substr(1))*100;
        }

	}
	//还原
    allAmtSum = allAmtSum/100;

	if(allAmtSum > 0){
        $('#allAmtSum').text("+"+ allAmtSum);
    }else{
        $('#allAmtSum').text(allAmtSum);
    }

</script>
</html>