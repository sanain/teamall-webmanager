<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>营业汇总列表</title>
    <meta name="decorator" content="default"/>
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/build.css">
    <link rel="stylesheet" href="${ctxStatic}/layui/css/layui.css"  media="all">
    <script type="text/javascript" src="${ctxStatic}/layui/layui.js"></script>
    <script type="text/javascript">

        function page(n,s){
            if(n) $("#pageNo").val(n);
            if(s) $("#pageSize").val(s);
            $("#searchForm").attr("action","${ctxsys}/statement/statisticsList");
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
                , range: true
            });


            //年月范围
            laydate.render({
                elem: '#test8'
                , type: 'month'
                , range: true
            });
        })

        function clearTimeRange(){
            $(".timeRange").val("");
        }

        function clearQuickRange(){
            $("#emptyOption").attr("selected","selected")
        }
    </script>
    <link rel="stylesheet" type="text/css" href="${ctxStatic}/sbShop/css/export.css">
</head>
<body>
<ul class="nav nav-tabs">
    <li class="active"><a>营业汇总列表</a></li>
</ul>
<form:form id="searchForm" modelAttribute="pmBusinessStatistics" action="${ctxsys}/statement/handoverList" method="post" class="breadcrumb form-search ">
    <input path="userId" type="hidden"/>
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
    <input id="type" name="type" type="hidden" value="${type}"/>
    <tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
    <ul class="ul-form">
        <li><label>时间范围:</label>  <input type="text" onclick="clearQuickRange()" class="timeRange" readonly name="timeRange" value="${timeRange}" id="test${type==1 ? 6 : 8}" placeholder=" - " style=" width: 200px;"></li>
        <li><label>快捷选择:</label>
            <select name="quickTime" onchange="clearTimeRange()">
                <option id="emptyOption" value="">---请选择---</option>
                    <%--<c:if test="${type == 2}">--%>
                    <%--<option value="4" <c:if test="${quickTime == 4}">selected</c:if>>本月</option>--%>
                    <%--</c:if>--%>
                <option value="1" <c:if test="${quickTime == 1}">selected</c:if>> ${type==1?"今天":"近三月"}</option>
                <option value="2" <c:if test="${quickTime == 2}">selected</c:if>>${type==1?"近七天":"近六月"}</option>
                <option value="3" <c:if test="${quickTime == 3}">selected</c:if>>${type==1?"近三十天":"近十二月"}</option>
            </select>
        </li>
        <li><label>显示方式:</label>
            <input class="form-check-input" type="radio" style="padding: 10px 0px" name="isAll" value="1" <c:if test="${isAll == 1}">checked="checked"</c:if>>汇总
            <input class="form-check-input" type="radio" style="padding: 10px 0px" name="isAll" value="0" <c:if test="${isAll == 0}">checked="checked"</c:if>>门店
        </li>
        <li style="margin-left: 30px"> &nbsp;&nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/></li>
            <%--<li><input id="btnExport" class="btn btn-primary check-a1" type="button" value="导出"/></li>--%>
        <li style="margin-left:10px; "><input id="btnExport" class="btn btn-primary check-a1" type="button" value="导出"/></li>
        <div class="check1">
            <div class="check-box">
                <p>导出选项<img class="check-del1" src="${ctxStatic}/sbShop/images/xxx-rzt.png" alt=""></p>
                <ul class="mn1">
                    <li class="checkbox"><input type="checkbox" class="kl" value="" id="all"><label><i></i>全选</label></li>
                    <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="名称,shopName"><label><i></i>名称</label></li>

                    <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="销售总金额(合计),allPayableAmount"><label><i></i>销售总金额(合计)</label></li>
                    <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="实收金额(合计),allRealAmount"><label><i></i>实收金额(合计)</label></li>
                    <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="订单总数(合计),allOrderTotal"><label><i></i>订单总数(合计)</label></li>

                    <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="销售总金额(门店),storePayableAmount"><label><i></i>销售总金额(门店)</label></li>
                    <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="实收金额(门店),storeRealAmount"><label><i></i>实收金额(门店)</label></li>
                    <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="订单总数(门店),storeOrderTotal"><label><i></i>订单总数(门店)</label></li>

                    <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="销售总金额(自提),selfPayableAmount"><label><i></i>销售总金额(自提)</label></li>
                    <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="实收金额(自提),selfRealAmount"><label><i></i>实收金额(自提)</label></li>
                    <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="订单总数(自提),selfOrderTotal"><label><i></i>订单总数(自提)</label></li>

                    <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="销售总金额(外卖),onlinePayableAmount"><label><i></i>销售总金额(外卖)</label></li>
                    <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="实收金额(外卖),onlineRealAmount"><label><i></i>实收金额(外卖)</label></li>
                    <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="订单总数(外卖),onlineOrderTotal"><label><i></i>订单总数(外卖)</label></li>

                    <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="充值金额,memberTopup"><label><i></i>充值金额</label></li>
                    <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="统计日期,totalTime"><label><i></i>统计日期</label></li>
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
        <th>名称</th>
        <th colspan="3">营收合计（所有订单）</th>
        <th colspan="3">门店下单</th>
        <th colspan="3">门店自取（小程序）</th>
        <th colspan="3">线上外卖（小程序）</th>
        <th >会员充值</th>
        <th >统计信息</th>
    </tr>

    <tr class="title-tr" style="text-align: center">
        <td></td>
        <th></th>
        <td>销售总金额</td>
        <td>实收金额</td>
        <td>订单总数</td>

        <td>销售总金额</td>
        <td>实收金额</td>
        <td>订单总数</td>

        <td>销售总金额</td>
        <td>实收金额</td>
        <td>订单总数</td>

        <td>销售总金额</td>
        <td>实收金额</td>
        <td>订单总数</td>

        <td>充值金额</td>
        <td>统计日期</td>
    </tr>
    <c:if test="${page.list == null || page.list.size() == 0}">
        <tr id="${pack.id}" class="data-tr">
            <td colspan="15" style="text-align: center">暂无数据</td>
        </tr>
    </c:if>
    <c:if test="${page.list != null && page.list.size() != 0}">
        <c:forEach items="${page.list}" var="pbs" varStatus="status">
            <tr id="${pack.id}" class="data-tr" style="text-align: center">
                <td> ${status.index+1}</td>
                <td> ${isAll == 0 ? pbs.shopName : "汇总"}</td>
                <td> ${pbs.allPayableAmount}</td>
                <td> ${pbs.allRealAmount}</td>
                <td> ${pbs.allOrderTotal}</td>

                <td> ${pbs.storePayableAmount}</td>
                <td> ${pbs.storeRealAmount}</td>
                <td> ${pbs.storeOrderTotal}</td>

                <td> ${pbs.selfPayableAmount}</td>
                <td> ${pbs.selfRealAmount}</td>
                <td> ${pbs.selfOrderTotal}</td>

                <td> ${pbs.onlinePayableAmount}</td>
                <td> ${pbs.onlineRealAmount}</td>
                <td> ${pbs.onlineOrderTotal}</td>

                <td> ${pbs.memberTopup}</td>
                <c:if test="${type == 1}">
                    <td> <fmt:formatDate value='${pbs.totalTime}' pattern='yyyy-MM-dd'/></td>
                </c:if>
                <c:if test="${type == 2}">
                    <td> <fmt:formatDate value='${pbs.totalTime}' pattern='yyyy-MM'/></td>
                </c:if>
            </tr>
        </c:forEach>
    </c:if>
</table>

<div class="pagination">${page}</div>

<%--导出的脚本--%>
<script type="text/javascript">
    $(function(){
        $('.check1').hide();
        $('body').on('click','.check-a1',function(){
            $('.check1').show();
        });

        $('body').on('click','.check-del1',function(){
            $('.check1').hide();
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

    $('#fromNewActionSbM').click(function(){
        $.ajax({
            type : "post",
            data:$('#searchForm').serialize(),
            url : "${ctxsys}/statement/statisticsExcel",
            success : function (data) {
                window.location.href=data;
                console.log(data)
                $('.check1').hide();
            }
        });
    });
</script>
</body>
</html>