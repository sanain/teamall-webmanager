<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>提现记录</title>
    <meta name="decorator" content="default"/>

    <script type="text/javascript">
        function page(n, s) {
            if (n) $("#pageNo").val(n);
            if (s) $("#pageSize").val(s);
            $("#searchForm").attr("action", "${ctxweb}/shop/shopPmAmtLog/applyToCashlist");
            $("#searchForm").submit();
            return false;
        }
    </script>
    <style type="text/css">

        #download-file:hover,.btns input:hover{
            color: rgb(120,120,120);
        }
		 		    #searchForm,#inputForm{background:#fff;}
    .nav-tabs>.active>a{border-top:3px solid #009688;color:#009688;}
      .nav-tabs>li>a{color:#000;}
      .pagination{padding-bottom:25px;}
      .ibox-content{margin:0 30px;}
      body{background:#f5f5f5;}
      .ibox-content{background:#fff;}
      .nav{margin-bottom:0;}
      .form-horizontal{margin:0;}
       .breadcrumb{background:#fff;padding:0;}
        /*.nav-tabs a{*/
            /*color: rgb(120,120,120);*/
        /*}*/
    </style>
</head>
<body>
	<div style="color:#999;padding:19px 0 17px 30px;background:#f5f5f5;">
		<span>当前位置：</span><span>门店管理 - </span><span style="color:#009688;">资金提现</span>
	</div>
<div class="ibox-content">

    <ul class="nav nav-tabs">
        <li><a href="${ctxweb}/shop/shopPmAmtLog/index">门店结算</a></li>
        <li><a href="${ctxweb}/shop/shopPmAmtLog/list">收支明细</a></li>
        <li class="active"><a  style="color: #009688;" href="">提现记录</a></li>
    </ul>

    <form id="searchForm" modelAttribute="pmUserBank" action="${ctxweb}/shop/shopPmAmtLog/applyToCashlist" method="post"
               class="breadcrumb form-search ">
        <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
        <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
        <tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>

    </form>


    <table class="table table-striped table-bordered table-hover dataTables-example">
        <thead>
            <tr>

                <th>操作类型</th>
                <th>申请时间</th>
                <th>提现金额</th>
                <th>交易状态</th>
                <th>备注</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${page.list}" var="useramtlog">
                    <tr>

                        <th>
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
                                <c:if test="${useramtlog.amtType==12}">商家付款</c:if>
                                <%--<c:if test="${useramtlog.amtType==13}">线下货款</c:if>--%>
                                <%--<c:if test="${useramtlog.amtType==14}">退款</c:if>--%>
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
                        </th>
                        <th >
                            <fmt:formatDate value="${useramtlog.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
                        </th>
                        <th >
                            <c:if test="${useramtlog.amt>0}">+ ${useramtlog.amt}</c:if>
                            <c:if test="${useramtlog.amt<=0}">${useramtlog.amt}</c:if>
                        </th>
                        <th >
                            <c:if test="${useramtlog.status==0}">收入</c:if>
                            <c:if test="${useramtlog.status==1}">交易完成</c:if>
                            <c:if test="${useramtlog.status==2}">交易取消</c:if>
                        </th>
                        <th >
                            <li class="allAmtSum">${useramtlog.remark}
                        </th>

                    </tr>
            </c:forEach>
        </tbody>
    </table>
    <div class="pagination">${page}</div>

</div>

</body>
</html>