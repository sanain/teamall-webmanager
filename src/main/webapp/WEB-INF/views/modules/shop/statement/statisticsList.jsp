<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>营业汇总列表</title>
    <meta name="decorator" content="default"/>
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/build.css">
    <link rel="stylesheet" href="${ctxStatic}/layui/css/layui.css"  media="all">
    <script type="text/javascript" src="${ctxStatic}/layui/layui.js"></script>
    <link href="${ctxStatic}/sbShop/css/statistics.css" type="text/css" rel="stylesheet">
    <script type="text/javascript">

        function page(n,s){
            if(n) $("#pageNo").val(n);
            if(s) $("#pageSize").val(s);
            $("#searchForm").attr("action","${ctxweb}/shop/statement/statisticsList");
            $("#searchForm").submit();
            return false;
        }
    </script>

    <style type="text/css">
    #contentTable th{font-weight:normal;}
    .pagination{padding:10px 0 20px 0;}
        .title-tr span{
            padding: 0px;
            margin: 0px;
            float: none;
            text-align: center;
            cursor: pointer;
        }
tr{height:40px;}
        .sore-th:hover{
            color: #69AC72;
        }
        #contentTable td , #contentTable td{
            text-align: left;
        }

        #contentTable td,#contentTable th{
            text-align: center;
        }
        .btn-primary{
            background-color: black;
        }

        .btn-primary:link{
            background-color: black;
        }
        body{background:#f5f5f5;}
        #contentTable,#searchForm{background:#fff;}
        .commontitle ul li:last-child{border:1px solid #e5e5e5;margin-right:30px;background:#fff;color:#000;}
        .commontitle ul li:first-child{background:#3E9388;color:#fff;}
    </style>

    <script type="text/javascript">
        layui.use('laydate', function() {
            var laydate = layui.laydate;
            //日期范围
            laydate.render({
                elem: '#test6'
                , range: true
                ,trigger:'click'
            });


            //年月范围
            laydate.render({
                elem: '#test8'
                , type: 'month'
                , range: true
                ,trigger:'click'
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
<div style="color:#999;padding:19px 0 17px 30px;background:#f5f5f5;">
		<span>当前位置：</span><span>报表管理 - </span><span style="color:#009688;">营业汇总日报</span>
</div>

		<div class="backcolor commontitle" style="margin-left:30px;margin-right:30px;">
			<ul class="clearfix overp">
				<li class="select1"><b class="active"></b>营收明细</li>		
				<c:if test="${type==1}">
				  <li class="select2"><a href="${ctxweb}/shop/statement/statisticsDaily"><b></b>营收趋势</a></li>
				</c:if>
				<c:if test="${type==2}">
				  <li class="select2"><a href="${ctxweb}/shop/statement/statisticsMonth"><b></b>营收趋势</a></li>
				</c:if>
			</ul>
		</div>

<div style="margin:0 30px;background:#fff;">
<form:form id="searchForm" modelAttribute="pmBusinessStatistics" action="${ctxweb}/shop/statement/statisticsList" method="post" class="breadcrumb form-search ">
    <input path="userId" type="hidden"/>
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
    <input id="type" name="type" type="hidden" value="${type}"/>
    <input id="shopId" name="shopId" type="hidden" value="${shopId}"/>
    <input id="isAll" name="isAll" type="hidden" value="${isAll}"/>
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
        <li style="margin-left: 30px"> &nbsp;&nbsp;<input id="btnSubmit" style="background: #393D49" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/></li>
        <li style="margin-left: 10px"><input id="btnExport" style="background: #393D49 "  class="btn btn-primary check-a1" type="button" value="导出"/></li>
            <%--<li><input class="btn btn-primary check-a1" type="reset" value="重置"/></li>--%>
        <div class="check1">
            <div class="check-box">
                <p>导出选项<img class="check-del1" src="${ctxStatic}/sbShop/images/xxx-rzt.png" alt=""></p>
                <ul class="mn1">
                    <li class="checkbox"><input type="checkbox" class="kl" value="" id="all"><label><i></i>全选</label></li>
                    <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="店名,shopName"><label><i></i>店名</label></li>

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
                    <a href="javascript:;" id="fromNewActionSbM" style="background: #393D49">确定</a>
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
        <th>门店名称</th>
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
</div>

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
            url : "${ctxweb}/shop/statement/statisticsExcel",
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