<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0,minimal-ui">
    <meta name="Description" content="${fns:getProjectName()},积分明细"/>
	<meta name="Keywords" content="${fns:getProjectName()},积分明细"/>
    <title>积分明细</title>
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/admin-member-account.css">
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/bootstrap.min.css">
    <script src="${ctxStatic}/sbShop/js/jquery.min.js"></script>
	<script type="text/javascript">
	function page(n,s){
		$("#pageNo").val(n);
		$("#pageSize").val(s);
		$("#searchForm").attr("action","${ctxsys}/User/fzuserlovelog?userId=${userId}");
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
        	<li><a class="active" href="${ctxsys}/User/fzuserlovelog?userId=${userId}">暂缓积分明细</a>
        	    <a href="${ctxsys}/User/userAccount?userId=${userId}"><img class="balance-img" src="${ctxStatic}/sbShop/images/xxx-rzt.png" alt=""></a>
        	</li>
        </ul>
        <form id="searchForm" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
		<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
        <div class="sb">
            <div class="select-div">
                <span>类型：</span>
                <select id="loveType" name="loveType">
                    <option value="" selected="selected">-请选择-</option>
                    <option ${loveType=='1'?'selected':''} value="1">暂缓积分</option>
                    <option ${loveType=='2'?'selected':''} value="2">激活积分</option>
                    <option ${loveType=='3'?'selected':''} value="3">暂缓积分兑换支付</option>
                    <option ${loveType=='4'?'selected':''} value="4">退还暂缓积分兑换支付</option>
                    <option ${loveType=='5'?'selected':''} value="5">转移暂缓积分</option>
                    <option ${loveType=='6'?'selected':''} value="6">获得转移暂缓积分</option>
                    <option ${loveType=='7'?'selected':''} value="7">系统封存暂缓积分</option>
                </select>
                <span>收支：</span>
                <select id="loveStatus" name="loveStatus">
                	<option value="" selected="selected">-请选择-</option>
                    <option ${loveStatus=='1'?'selected':''} value="1">增加</option>
                    <option ${loveStatus=='2'?'selected':''} value="2">减少</option>
                </select>
                <span>时间：</span>
                <input id="startTime" name="startTime" type="date" style="width:155px" value="${startTime}">
              	<b>—</b>
               	<input id="startTime" name="endTime" type="date" style="width:155px" value="${endTime}">
                <a class="btn" href="javascript:;" onclick="return page();">查询</a>
            </div>
            <div class="balance-list">
                <ul class="list-top">
                    <li>时间</li>
                    <li>类型</li>
                    <li>备注</li>
                    <li>收入/支出</li>
                    <li>积分数</li>
                </ul>
                <div class="list-body">
                <c:forEach items="${page.list}" var="userlovelog">
                    <ul>
                        <li><fmt:formatDate value="${userlovelog.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></li>
                        <li>
                        	<c:if test="${userlovelog.loveType==1}">暂缓积分</c:if>
		                    <c:if test="${userlovelog.loveType==2}">激活积分</c:if>
		                    <c:if test="${userlovelog.loveType==3}">暂缓积分兑换支付</c:if>
		                    <c:if test="${userlovelog.loveType==4}">退还暂积分兑换支付</c:if>
		                    <c:if test="${userlovelog.loveType==5}">转移暂缓积分</c:if>
		                    <c:if test="${userlovelog.loveType==6}">获得转移暂缓积分</c:if>
		                    <c:if test="${userlovelog.loveType==7}">系统封存暂缓积分</c:if>
						</li>
						<li>${userlovelog.remark}</li>
                        <li>
							<c:if test="${userlovelog.loveStatus==1}">收入</c:if>
		                    <c:if test="${userlovelog.loveStatus==2}">支出</c:if>
                        </li>
                        <li class="allLoveSum"><fmt:formatNumber value="${userlovelog.love}" pattern="0.0000"/></li>
                    </ul>
                </c:forEach>
                </div>
                <ul class="list-bottom">
                    <li>合计：</li>
                    <li></li>
                    <li></li>
                    <li></li>
                    <li id="allLoveSum"></li>
                </ul>
            </div>
          <div class="pagination" style="margin-top: -15px;margin-left: 20px;">${page}</div>
        </div>
      </form>
    </div>
</body>
<script type="text/javascript">
	function decimal(num,v){
		var vv = Math.pow(10,v);
		return Math.round(num*vv)/vv;
	}
	var allLoveSum=0;
	for (var i= 0; i < $('.allLoveSum').length; i++) {
		allLoveSum+=parseFloat($($('.allLoveSum')[i]).text());
	}
	$('#allLoveSum').text(decimal(allLoveSum,4));
</script>
</html>