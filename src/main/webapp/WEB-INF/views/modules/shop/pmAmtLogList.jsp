<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>收支明细</title>
    <meta name="decorator" content="default"/>

    <script type="text/javascript">
        function page(n, s) {
            if (n) $("#pageNo").val(n);
            if (s) $("#pageSize").val(s);
            $("#searchForm").attr("action", "${ctxweb}/shop/shopPmAmtLog/list");
            $("#searchForm").submit();
            return false;
        }
    </script>
    <style type="text/css">

        #download-file:hover,.btns input:hover{
            color: rgb(120,120,120);
        }

        /*.nav-tabs a{*/
            /*color: rgb(120,120,120);*/
        /*}*/
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
    </style>
</head>
<body>
	<div style="color:#999;padding:19px 0 17px 30px;background:#f5f5f5;">
		<span>当前位置：</span><span>门店管理 - </span><span style="color:#009688;">资金提现</span>
	</div>
<div class="ibox-content">

    <ul class="nav nav-tabs">
        <li><a  href="${ctxweb}/shop/shopPmAmtLog/index">门店结算</a></li>
        <li class="active"><a href="">收支明细</a></li>
        <li><a  href="${ctxweb}/shop/shopPmAmtLog/applyToCashlist">提现记录</a></li>
    </ul>

    <form id="searchForm" modelAttribute="pmUserBank" action="${ctxweb}/shop/shopPmAmtLog/list" method="post"
               class="breadcrumb form-search ">
        <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
        <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
        <tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
        <div class="p-xs" style="padding:10px 0;">
            <ul class="ul-form">

                <li>
                    <label style="width: 45px;">类型：</label>
                    <select id="amtType" name="amtType">
                    <option value="" selected="selected">-请选择-</option>
<%--                    <option ${amtType=='1'?'selected':''} value="1">消费</option>--%>
<%--                    <option ${amtType=='2'?'selected':''} value="2">充值</option>--%>
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
                </li>
                <li>
                    <label style="width: 45px;">收支：</label>
                    <select id="amt" name="amt">
                        <option value="" selected="selected">-请选择-</option>
                        <option ${amt=='1'?'selected':''} value="1">收入</option>
                        <option ${amt=='2'?'selected':''} value="2">支出</option>
                    </select>
                </li>
                <li>
                    <label style="width: 45px;">时间：</label>
                    <input id="startTime" name="startTime" type="txt" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"style="width:155px" value="${startTime}">
                    <b>—</b>
                    <input id="endTime" name="endTime" type="txt" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width:155px" value="${endTime}">
                </li>
                <li class="btns"><input style="background: #393D49; " id="btnSubmit" class="btn btn-primary" type="submit" value="查询"
                                        onclick="return page();"/>
                </li>

            </ul>
        </div>
    </form>


    <table class="table table-striped table-bordered table-hover dataTables-example">
        <thead>
            <tr>
                <th>时间</th>
                <th>类型</th>
                <th>收入/支出</th>
                <th>金额</th>
                <th>备注</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${page.list}" var="useramtlog">
                    <tr>
                        <th >
                            <fmt:formatDate value="${useramtlog.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
                        </th>
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
                        </th>
                        <th >
                            <c:if test="${useramtlog.amtType==4}">(支出)提现</c:if>
                            <c:if test="${useramtlog.amtType!=4}">
                            <c:if test="${useramtlog.amt>0}">收入</c:if>
                            <c:if test="${useramtlog.amt<0}">支出</c:if>
                            <c:if test="${useramtlog.amt==0}"></c:if>
                            </c:if>
                        </th>
                        <th >
                            <c:if test="${useramtlog.amt>0}">+ ${useramtlog.amt}</c:if>
                            <c:if test="${useramtlog.amt<=0}">${useramtlog.amt}</c:if>
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