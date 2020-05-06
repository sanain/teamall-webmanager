<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="robots" content="noarchive">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0,minimal-ui">
    <title>我的账单</title>
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/bootstrap.min.css">
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/pageloader.css">
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/my-account.css">
    <link rel="stylesheet" href="${ctxStatic}/sbShop/layui/css/layui.css">
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/build.css">
    <script src="${ctxStatic}/sbShop/js/jquery.min.js"></script>
    <script src="${ctxStatic}/sbShop/layui/layui.js"></script>
    <script src="${ctxStatic}/sbShop/js/base_form.js"></script>
         <script>
    $(window.parent.document).find('.list-ul').find('ul').slideUp();
    $(window.parent.document).find('.list-ul').find('a').removeClass('active');
    </script>
     
</head>
<script type="text/javascript">
$(function(){ 
	
}); 

function page(n,s){
			if(n) $("#pageNo").val(n);
			if(s) $("#pageSize").val(s);
			$("#searchForm").attr("action","${ctxweb}/shop/shopAccount/mybill");
			$("#searchForm").submit();
	    	return false;
	    }

function selectStar(){
	$("#star").val(${star});
}
		
</script>
<body>
    <!--我的账单-->
    <div class="my-bill">
     <p><a href="javascript:;">首页</a> > <a class="n-tab" href="javascript:;">我的账户</a> > <span>我的账单</span></p>
       <form action="" modelAttribute="pmAmtLog" id="searchForm" method="post" >
            <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
			<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
			<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
        <div class="select-div">
            <span>交易状态：</span>
             <form:select path="pmAmtLog.status" >
                <form:option value="" label="全部"/>
				<form:option value="0" label="交易中"/>
				<form:option value="1" label="交易完成"/>
				<form:option value="2" label="交易取消"/>
            </form:select>
            
            <span>消费类型：</span>
             <form:select path="pmAmtLog.amt" >
                <form:option value="" label="全部"/>
				<form:option value="1" label="收入"/>
				<form:option value="0" label="消费"/>
            </form:select>
            
            <span>金额类型：</span>
           <form:select path="pmAmtLog.amtType" >
				<form:option value="" label="全部"/>
				<form:options items="${fns:getDictList('amt_type')}" itemLabel="label" itemValue="value" htmlEscape="false" />
			</form:select>
        </div>
        <div class="two-btn">
            <input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/>
            <input class="btn btn-primary" type="reset" value="重置" />
        </div>
        </form>
        
		<div class="bill-list">
		
		            <ul class="list-top">
		                <li>实际金额</li>
		                <li>手续费</li>
		                <li>金额类型</li>
		                <li>状态</li>
		                <li>说明</li>
		                <li>创建时间</li>
		            </ul>
		           <c:forEach items="${page.list}" var="pc">
		            <ul class="list-body">
		                <li>¥${pc.amt}</li>
		                <li>¥${pc.fee}</li>
		                <li>${fns:getDictLabel(pc.amtType, 'amt_type', '')}</li>
		                <li>
			                <c:if test="${pc.status==0}">交易中</c:if>
							<c:if test="${pc.status==1}">交易完成</c:if>
							<c:if test="${pc.status==2}">交易取消</c:if>
		                </li>
		                <li>${pc.remark}</li>
		                <li><fmt:formatDate value="${pc.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></li>
		            </ul>
		            </c:forEach>
		        </div>

        <!--分页-->
       <div class="pagination">
         ${page}
        </div>
    </div>

</body>
</html>