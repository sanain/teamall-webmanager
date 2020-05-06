<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title></title>
    <meta name="decorator" content="default"/>
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/build.css">
    <link rel="stylesheet" href="${ctxStatic}/layui/css/layui.css"  media="all">
    <script type="text/javascript" src="${ctxStatic}/layui/layui.js"></script>
    <script src="${ctxStatic}/supplyshop/layui/lay/modules/layer.js?v=1" type="text/javascript"></script>
    <link href="${ctxStatic}/supplyshop/layui/css/modules/layer/default/layer.css?v=1" type="text/css" rel="stylesheet" />

    <script type="text/javascript">

        function page(n,s){
            if(n) $("#pageNo").val(n);
            if(s) $("#pageSize").val(s);
            $("#searchForm").attr("action","${ctxsys}/statement/payTotalViewList");
            $("#searchForm").submit();
            return false;
        }
    </script>

    <style type="text/css">
        .title-tr span{
            padding: 0px;
            margin: 0px;
            float: none;
            text-align: center;
            cursor: pointer;
        }

        .sore-th:hover{
            color: #69AC72;
        }
        #contentTable td , #contentTable td{
            text-align: left;
        }

        #contentTable td,#contentTable th{
            text-align: center;
        }
    </style>

    <script type="text/javascript">
        layui.use('laydate', function() {
            var laydate = layui.laydate;
            //日期范围
            laydate.render({
                elem: '#test6'
                ,type: 'datetime'
                , range: true
            });


            //年月范围
            laydate.render({
                elem: '#test8'
                , type: 'month'
                , range: true
            });
        })

        // function clearTimeRange(){
        //     $(".timeRange").val("");
        // }

        function clearQuickRange(){
            $("#emptyOption").attr("selected","selected")
        }
    </script>
    <link rel="stylesheet" type="text/css" href="${ctxStatic}/sbShop/css/export.css">
</head>
<body>
<ul class="nav nav-tabs">
    <li class="active"><a>支付统计</a></li>
</ul>
<form:form id="searchForm" modelAttribute="pmBusinessStatistics" action="${ctxsys}/statement/payTotalList" method="post" class="breadcrumb form-search ">
    <input path="userId" type="hidden"/>
    <input id="type" name="type" type="hidden"/>
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
    <tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
    <div style="font-size: 13px;padding-left: 32px;padding-right: 10px;">
        指标说明：支付净额表示核减退款后您实际发生的交易总额；结算金额表示通过平台付款且扣除手续费后的商户可提现金额；非结算金额表示未通过平台付款的交易金额</br></br>
    </div>
    <ul class="ul-form">
        <li><label>时间范围:</label>  <input type="text" onclick="clearQuickRange()" class="timeRange" readonly name="timeRange" value="${timeRange}" id="test6" placeholder=" - " style=" width: 250px;"></li>
        <li><label>快捷选择:</label>
            <select name="quickTime">
                <option id="emptyOption" value="">---请选择---</option>
                <option value="-1" <c:if test="${quickTime == -1}">selected</c:if>>昨天</option>
                <option value="-7" <c:if test="${quickTime == -7}">selected</c:if>>近七天</option>
                <option value="-30" <c:if test="${quickTime == -30}">selected</c:if>>近三十天</option>
            </select>
        </li>

        <li style="margin-left: 30px"> &nbsp;&nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/></li>
            <%--<li><input id="btnExport" class="btn btn-primary check-a1" type="button" value="导出"/></li>--%>
        <li style="margin-left:10px; "><input id="btnExport" class="btn btn-primary check-a1" type="button" value="导出"/></li>

        <div class="check1">
            <div class="check-box">
                <p>导出选项<img class="check-del1" src="${ctxStatic}/sbShop/images/xxx-rzt.png" alt=""></p>
                <ul class="mn1">
                    <li class="checkbox"><input type="checkbox" class="kl" value="" id="all"><label><i></i>全选</label></li>
                    <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="统计日期,totalTime"><label><i></i>营业总额</label></li>
                    <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="营业总额,allAmount"><label><i></i>营业总额</label></li>
                    <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="营业退款,allRefundAmount"><label><i></i>营业总额</label></li>
                    <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="营业净额,allRealAmount"><label><i></i>营业总额</label></li>
                    <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="支付金额,payAmount"><label><i></i>支付金额</label></li>
                    <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="退款金额,extractRefundAmount"><label><i></i>支付金额</label></li>
                    <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="支付净额,realAmount"><label><i></i>支付净额</label></li>
                    <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="手续费,poundage"><label><i></i>手续费</label></li>
                    <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="可提现金额,extractAmout"><label><i></i>可提现金额</label></li>
                    <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="非结算金额,noExtractAmout"><label><i></i>非结算金额</label></li>
                    <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="非结算退款,noExtractRefundAmount"><label><i></i>非结算金额</label></li>
                    <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="非结算净额,noExtractRealAmount"><label><i></i>非结算金额</label></li>
                </ul>
                <div class="check-btn">
                    <a href="javascript:;" id="fromNewActionSbM" >确定</a>
                    <a class="check-del1" href="javascript:;">取消</a>
                </div>
            </div>
        </div>
    </ul>
</form:form>
<tags:message content="${message}"/>
<table id="contentTable" class="table table-striped table-bordered table-condensed" >
    <tr class="title-tr" style="text-align: center">
        <th>序号</th>
        <th>日期</th>
        <th>营业总额</th>
        <th>营业退款</th>
        <th>营业净额</th>
        <th>支付金额</th>
        <th>退款金额</th>
        <th>支付净额</th>
        <th>手续费</th>
        <th>结算金额</th>
        <th>非结算金额</th>
        <th>非结算退款</th>
        <th>非结算净额</th>
        <th>操作</th>

    </tr>

    <c:if test="${page.list == null || page.list.size() == 0}">
        <tr class="data-tr">
            <td colspan="15" style="text-align: center">暂无数据</td>
        </tr>
    </c:if>
    <c:if test="${page.list != null && page.list.size() != 0}">
        <c:forEach items="${page.list}" var="pay" varStatus="status">
            <tr  class="data-tr" style="text-align: center">
                <td> ${status.index+1}</td>
                <td class="total-time-class"> <fmt:formatDate value="${pay.totalTime}" pattern="yyyy-MM-dd"/> </td>
                <td> ${pay.allAmount}</td>
                <td> ${pay.allRefundAmount}</td>
                <td> ${pay.allRealAmount}</td>
                <td> ${pay.payAmount}</td>
                <td> ${pay.extractRefundAmount}</td>
                <td> ${pay.realAmount}</td>
                <td> ${pay.poundage}</td>
                <td> ${pay.extractAmout}</td>
                <td> ${pay.noExtractAmout}</td>
                <td> ${pay.noExtractRefundAmount}</td>
                <td> ${pay.noExtractRealAmount}</td>
                <td>
                     <a href="javascript:;" onclick="goPayTotal()">明细</a>
                </td>
            </tr>
        </c:forEach>
    </c:if>
</table>

<div class="pagination">${page}</div>


<script type="text/javascript">
    /**
     * 跳转支付统计
     */
    function goPayTotal() {
        $("#type").val("1");
        $("#pageNo").val("");
        $("#pageSize").val("");

        $("#searchForm").attr("action","${ctxsys}/statement/payTotalList");
        $("#searchForm").submit();
    }

    $('#fromNewActionSbM').click(function(){
        $.ajax({
            type : "post",
            data:$('#searchForm').serialize(),
            url : "${ctxsys}/statement/excelPayTotalView",
            success : function (data) {
                window.location.href=data;
                console.log(data)
                $('.check1').hide();
            }
        });
    });

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


</body>
</html>