<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>
    <c:if test="${type == 1}">
        营业指标日报列表
    </c:if>
    <c:if test="${type == 2}">
        营业指标月报列表
    </c:if>
</title>
<meta name="decorator" content="default"/>
<link rel="stylesheet" href="${ctxStatic}/sbShop/css/build.css">
<link rel="stylesheet" href="${ctxStatic}/layui/css/layui.css"  media="all">
<script type="text/javascript" src="${ctxStatic}/layui/layui.js"></script>
<script type="text/javascript">

	function page(n,s){
		if(n) $("#pageNo").val(n);
		if(s) $("#pageSize").val(s);
		$("#searchForm").attr("action","${ctxsys}/statement/indicatorList");
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

        #contentTable td , #contentTable th{
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

        $(function(){
            $("#searchForm").submit(function(){
                if($(".timeRange").val() == undefined || $(".timeRange").val() == "") {
                    if ($("#quickTime").val() == 0) {
                        alert("请选择时间范围")
                    }
                }
            })
        })
    </script>
    <link rel="stylesheet" type="text/css" href="${ctxStatic}/sbShop/css/export.css">
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a>
            <c:if test="${type == 1}">
                营业指标日报列表
            </c:if>
            <c:if test="${type == 2}">
                营业指标月报列表
            </c:if>
        </a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="pmBusinessStatistics" action="${ctxsys}/statement/indicatorList" method="post" class="breadcrumb form-search ">
		<input path="userId" type="hidden"/>
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<input id="type" name="type" type="hidden" value="${type}"/>
		<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form">
		  <li><label>时间范围:</label>  <input type="text" onclick="clearQuickRange()" class="timeRange" readonly name="timeRange" value="${timeRange}" id="test${type==1 ? 6 : 8}" placeholder=" - " style=" width: 200px;"></li>
		  <li><label>快捷选择:</label>
              <select id="quickTime" name="quickTime" onchange="clearTimeRange()">
                  <option id="emptyOption" value="0">---请选择---</option>
                  <option value="1" <c:if test="${quickTime == 1}">selected</c:if>> ${type==1?"今天":"近三月"}</option>
                  <option value="2" <c:if test="${quickTime == 2}">selected</c:if>>${type==1?"近七天":"近六月"}</option>
                    <option value="3" <c:if test="${quickTime == 3}">selected</c:if>>${type==1?"近三十天":"近十二月"}</option>
              </select>
          </li>

            <li><label>订单类型:</label>
                <select name="orderType" >
                    <option value="0" <c:if test="${orderType == 0}">selected</c:if>>全部</option>
                    <option value="1" <c:if test="${orderType == 1}">selected</c:if>>门店订单</option>
                    <option value="2" <c:if test="${orderType == 2}">selected</c:if>>自提订单（小程序）</option>
                    <option value="3" <c:if test="${orderType == 3}">selected</c:if>>外卖订单（小程序）</option>
                </select>
            </li>
            <li><label>显示方式:</label>
                <input class="form-check-input" type="radio" style="padding: 10px 0px" name="isAll" value="1" <c:if test="${isAll == 1}"> checked="checked"</c:if>>汇总
                <input class="form-check-input" type="radio" style="padding: 10px 0px" name="isAll" value="0" <c:if test="${isAll == 0}"> checked="checked"</c:if>>门店
            </li>
            <li style="margin-left: 30px"> &nbsp;&nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/></li>
            <li style="margin-left:10px; "><input id="btnExport" class="btn btn-primary check-a1" type="button" value="导出"/></li>
            <div class="check1">
                <div class="check-box">
                    <p>导出选项<img class="check-del1" src="${ctxStatic}/sbShop/images/xxx-rzt.png" alt=""></p>
                    <ul class="mn1">
                        <li class="checkbox"><input type="checkbox" class="kl" value="" id="all"><label><i></i>全选</label></li>
                        <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="名称,shopName"><label><i></i>名称</label></li>
                        <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="销售总金额,payableAmount"><label><i></i>销售金额(合计)</label></li>
                        <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="优惠金额,certificateAmount"><label><i></i>优惠金额(合计)</label></li>
                        <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="退款金额,refundAmount"><label><i></i>退款金额(合计)</label></li>
                        <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="实收金额,realAmount"><label><i></i>实收金额(合计)</label></li>
                        <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="订单总数,orderCount"><label><i></i>订单总数(合计)</label></li>
                        <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="单均消费,averaging"><label><i></i>单均消费(合计)</label></li>
                        <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="员工人数,employees"><label><i></i>员工人数(门店)</label></li>
                        <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="可提现金额,amtAmount"><label><i></i>可提现金额</label></li>
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

        <tr class="title-tr">
            <td>序号</td>
            <td>名称</td>
            <td>销售总金额</td>
            <td>优惠金额</td>
            <td>退款金额</td>
            <td>实收金额</td>
            <td>订单总数</td>
            <td>单均消费</td>
            <td>员工人数</td>
            <td>可提现金额</td>
            <td>日期</td>
        </tr>
        <c:if test="${page.list == null || page.list.size() == 0}">
            <tr id="${pack.id}" class="data-tr">
                <td colspan="15" style="text-align: center">暂无数据</td>
            </tr>
        </c:if>
        <c:if test="${page.list != null && page.list.size() != 0}">
            <c:forEach items="${page.list}" var="indicator" varStatus="status">
            <tr id="${pack.id}" class="data-tr">
                <td> ${status.index+1}</td>


                <td> ${isAll == 1 ? "汇总":indicator.shopName}</td>
                <td> ${indicator.payableAmount}</td>
                <td> ${indicator.certificateAmount}</td>
                <td> ${indicator.refundAmount}</td>
                <td> ${indicator.realAmount}</td>
                <td> ${indicator.orderCount}</td>
                <td> ${indicator.averaging}</td>
                <td> ${indicator.employees}</td>
                <td> ${indicator.amtAmount}</td>
                <c:if test="${type == 1}">
                    <td> <fmt:formatDate value='${indicator.totalTime}' pattern='yyyy-MM-dd'/></td>
                </c:if>
                <c:if test="${type == 2}">
                    <td> <fmt:formatDate value='${indicator.totalTime}' pattern='yyyy-MM'/></td>
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
                url : "${ctxsys}/statement/indicatorExcel",
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