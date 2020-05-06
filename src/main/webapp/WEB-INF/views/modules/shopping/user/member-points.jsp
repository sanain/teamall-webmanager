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
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/bootstrap.min.css">
    <script src="${ctxStatic}/sbShop/js/jquery.min.js"></script>
    <script src="${ctxStatic}/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
	<script type="text/javascript">
	function page(n,s){
		$("#pageNo").val(n);
		$("#pageSize").val(s);
		$("#searchForm").attr("action","${ctxsys}/User/consumptionPoints?userId=${userId}");
		$("#searchForm").submit();
	    return false;
	}
	</script>
</head>
<body>
    <div class="c-context">
      <ul class="nav-ul">
          <li><a href="${ctxsys}/User/form?userId=${userId}">会员信息</a></li>
          <li><a href="${ctxsys}/User/userAccount?userId=${userId}">会员账户</a></li>
          <li><a href="${ctxsys}/User/userrelation?userId=${userId}">会员关系</a></li>
          <li><a class="active" href="${ctxsys}/User/consumptionPoints?userId=${userId}">消费金明细</a><a href="${ctxsys}/User/userAccount?userId=${userId}"><img class="balance-img" src="${ctxStatic}/sbShop/images/xxx-rzt.png" alt=""></a></li>
      </ul>
      <form id="searchForm" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
		<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
        <div class="balance">
            <div class="select-div">
                <span>类型：</span>
                <select id="amtType" name="amtType">
                    <option value="" selected="selected">--请选择--</option>
                    <%--<option ${amtType=='1'?'selected':''} value="1">积分激励获得</option>--%>
                    <%--<option ${amtType=='2'?'selected':''} value="2">购物消费</option>--%>
                    <option ${amtType=='2'?'selected':''} value="2">购买</option>
                    <%--<option ${amtType=='3'?'selected':''} value="3">退还购物消费</option>--%>
                    <%--<option ${amtType=='4'?'selected':''} value="4">商家获得</option>--%>
                </select>
                <span>收支：</span>
                <select id="amt" name="amt">
                	<option value="" selected="selected">--请选择--</option>
                    <option ${amt=='0'?'selected':''} value="0">收入</option>
                    <option ${amt=='1'?'selected':''} value="1">支出</option>
                </select>
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
					    	<%--<c:if test="${useramtlog.amtType==1}">积分激励获得</c:if>--%>
		                    <c:if test="${useramtlog.amtType==2}">购买</c:if>
		                    <%--<c:if test="${useramtlog.amtType==3}">退还购物消费</c:if>--%>
		                    <%--<c:if test="${useramtlog.amtType==4}">商家获得</c:if>--%>
                        </li>
                        <li>
                        	<c:if test="${useramtlog.amt>0}">收入</c:if>
		                    <c:if test="${useramtlog.amt<0}">支出</c:if>
		                    <c:if test="${useramtlog.amt==0}"></c:if>
                        </li>
                        <li class="allAmtSum order-amount">
                            <c:if test="${useramtlog.amt>0}">+ ${useramtlog.amt}</c:if>
                            <c:if test="${useramtlog.amt<=0}">${useramtlog.amt}</c:if>
                        </li>
                        <li>${useramtlog.remark}</li>
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
<%--<script type="text/javascript">--%>
	<%--var allAmtSum=0;--%>
	<%--for (var i= 0; i < $('.allAmtSum').length; i++) {--%>
		<%--allAmtSum+=parseFloat($($('.allAmtSum')[i]).text());--%>
	<%--}--%>
	<%--$('#allAmtSum').text(allAmtSum);--%>
<%--</script>--%>

<script type="text/javascript">
    var allAmtSum=0;
    for (var i= 0; i < $('.order-amount').length; i++) {
        var allAmitSumStr = $($('.order-amount')[i]);


        if(allAmitSumStr == undefined || allAmitSumStr.text() == undefined || allAmitSumStr.text() == ""){
            continue;
        }

        if(allAmitSumStr.text().trim().charAt(0) == "-"){
            allAmtSum-=parseFloat(allAmitSumStr.text().trim().substr(1));
        }else{
            allAmtSum+=parseFloat(allAmitSumStr.text().trim().substr(1));
        }

    }

    if(allAmtSum > 0){
        $('#allAmtSum').text("+"+ allAmtSum);
    }else{
        $('#allAmtSum').text(allAmtSum);
    }

</script>

</html>