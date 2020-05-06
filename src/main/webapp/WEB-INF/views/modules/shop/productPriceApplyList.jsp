<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>价格申请列表</title>
    <meta name="decorator" content="default"/>
    <link rel="stylesheet" href="${ctxStatic}/h5/css/timePicker.css">
    <script src="${ctxStatic}/jquery/jquery-1.9.1.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="${ctxStatic}/h5/js/jquery-timepicker.js"></script>
    <link href="${ctxStatic}/supplyshop/layui/css/modules/layer/default/layer.css?v=1" type="text/css" rel="stylesheet" />
    <script src="${ctxStatic}/supplyshop/layui/lay/modules/layer.js?v=1" type="text/javascript"></script>

    <script type="text/javascript">
        function page(n,s){
            $("#pageNo").val(n);
            $("#pageSize").val(s);
            $("#searchForm").attr("action","${ctxweb}/shop/ebProductPriceApply/applyList");
            $("#searchForm").submit();
            // if($("#sellPrice").val() != "" && !/^(-?\d+)(\.\d+)?$/.test($("#sellPrice").val())){
            //     alert("价格的格式不正确！");
            //     return false;
            //     return false;
            // }
            // $("#searchForm").submit();
            // return false;
        }

        <%--//商品状态改变--%>
        <%--var chargingStatus;--%>
        <%--var chargingId;--%>
        <%--function editStatus(){--%>
        <%--// alert(productChargingId)--%>
        <%--$.ajax({--%>
        <%--type: "POST",--%>
        <%--url: "${ctxweb}/shop/ebShopCharging/updateStatus",--%>
        <%--data: {'chargingStatus':chargingStatus,'chargingId':chargingId},--%>
        <%--success: function(data){--%>

        <%--page( $("#pageNo").val(),$("#pageSize").val());--%>
        <%--}--%>
        <%--});--%>
        <%--}--%>
    </script>



    <style>
        .list-ul{
            width: 42%;
            float: left;
            list-style: none;
            padding: 0;
            border: 1px solid #69AC72;
            box-sizing: border-box;
            margin:30px;
        }
                #searchForm,#inputForm{background:#fff;}
                .form-search label{margin-left:0;margin-right:10px;}
                .form-search .ul-form li{margin-left:10px;}
                ul-form{margin-top:10px;}
                tr{height:35px;padding:0 10px;}
    .nav-tabs>.active>a{border-top:3px solid #009688;color:#009688;}
      .nav-tabs>li>a{color:#000;}
      .pagination{padding-bottom:25px;}
      .ibox-content{margin:0 30px;}
      body{background:#f5f5f5;}
      .ibox-content{background:#fff;}
      .nav{margin-bottom:0;}
      .form-horizontal{margin:0;}
       .breadcrumb{background:#fff;padding:0;}
        .list-ul li:nth-child(1){padding-left: 20px}
        .list-ul li:nth-child(2){padding-left: 20px}
        .list-ul li:nth-child(3) img{width: 100%}
        .form-search .ul-form li label{width:auto;}
      .form-search .ul-form{margin-top:10px;}
      .nav-tabs>.active>a{text-align:center;width:100px;}
    </style>

    <link rel="stylesheet" href="${ctxStatic}/layui/css/layui.css"  media="all">
    <script src="${ctxStatic}/layui/layui.js" charset="utf-8"></script>

    <script>
        layui.use('laydate', function(){
            var laydate = layui.laydate;

            //日期时间选择器
            laydate.render({
                elem: '#startTime'
                ,type: 'datetime'
            });

            //日期时间选择器
            laydate.render({
                elem: '#endTime'
                ,type: 'datetime'
            });
        });
    </script>
</head>
<body>
<div style="color:#999;padding:19px 0 17px 30px;background:#f5f5f5;">
		<span>当前位置：</span><span>商品管理 - </span><span style="color:#009688;">商品价格申请</span>
</div>
<div style="background:#fff;margin:0 30px;">
<ul class="nav nav-tabs">
    <li class="active"><a href="${ctxweb}/shop/ebProductPriceApply/applyList">申请列表</a></li>
    <%--<li >--%>
    <%--<shiro:hasPermission name="merchandise:EbProductCharging:edit">--%>
    <%--<a href="${ctxsys}/EbProductCharging/form?flag=add&productTypeId=${ebProductCharging.productTypeId}">增加加料</a>--%>
    <%--</shiro:hasPermission>--%>
    <%--</li>--%>

</ul>
<form:form id="searchForm" modelAttribute="apply" action="${ctxweb}/shop/ebProductPriceApply/applyList" method="post" class="breadcrumb form-search ">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
    <tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
    <ul class="ul-form">
        <li><label>商品名称:</label><form:input path="productName" htmlEscape="false" maxlength="80" class="input-medium"  placeholder="请输入商品名称"/></li>
        <li><label>创建时间:</label>
            <input type="text" readonly value="${startTime}" id="startTime" name="startTime" placeholder="yyyy-MM-dd HH:mm:ss"/> ~
            <input type="text" readonly value="${endTime}" id="endTime"  name="endTime"  placeholder="yyyy-MM-dd HH:mm:ss"/></li>
        <li>
            <label>审核状态:</label>
            <form:select path="applyStatus">
                <form:option value="">全部</form:option>
                <form:option value="0">未审核</form:option>
                <form:option value="1">审核通过</form:option>
                <form:option value="2">审核不通过</form:option>
                <form:option value="4">已取消</form:option>
            </form:select>
        </li>
        <li><label></label><input id="btnSubmit" class="btn btn-primary" type="submit" style="background: #393D49;" value="查询" onclick="return page();"/></li>
    </ul>
</form:form>
<tags:message content="${message}"/>

<table id="treeTable" class="table table-striped table-condensed table-bordered" >
    <tr>
        <%--<th class="center123">门店名称</th>--%>
        <th class="center123">商品名称</th>
        <%--<th class="center123">修改类型</th>--%>
        <th class="center123 ">申请理由</th>
        <th class="center123 ">申请时间</th>
        <th class="center123 ">审核状态</th>
        <th class="center123">操作</th>
    </tr>
    <c:forEach items="${page.list}" var="priceApply" varStatus="status">
        <tr>
                <%--<td class="center123">${priceApply.shopName}</td>--%>
            <td class="center123">${priceApply.productName}</td>
                <%--<td class="center123">￥${productCharging.sellPrice}</td>--%>
                <%--<td class="center123">￥${productCharging.sellPrice}</td>--%>
            <td class="center123">
                <%--<c:if test="${priceApply.applyType == 1}">规格</c:if>--%>
                <%--<c:if test="${priceApply.applyType == 2}">加料</c:if>--%>
            </td>
            <td class="center123">
                    ${priceApply.applyRemark.length()>25?priceApply.applyRemark.substring(0,25):priceApply.applyRemark}
                    ${priceApply.applyRemark.length()>25?"...":""}
            </td>
            <td class="center123"><fmt:formatDate value="${priceApply.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/> </td>
            <td class="center123 apply-status-td">

                <c:if test="${priceApply.applyStatus==0}">
                    <span style="color:#0465AA">未审核</span>
                </c:if>

                <c:if test="${priceApply.applyStatus==1}">
                    <span style="color:#00aa00">审核通过</span>
                </c:if>
                <c:if test="${priceApply.applyStatus==2}">
                    <span style="color:#dd0000">审核不通过</span>
                </c:if>

                <c:if test="${priceApply.applyStatus==4}">
                    <span style="color:#8F93AA">已取消</span>
                </c:if>
            </td>
            <td class="center123 control-td">
                <c:if test="${priceApply.isApply == 0}">
                    <c:if test="${priceApply.applyStatus == 4}">
                        <a href="${ctxweb}/shop/ebProductPriceApply/toPriceApplyUpdate?id=${priceApply.id}&isChange=0" class="update-btn">查看详情</a>
                    </c:if>
                    <c:if test="${priceApply.applyStatus == 0}">
                        <a href="${ctxweb}/shop/ebProductPriceApply/toPriceApplyUpdate?id=${priceApply.id}&isChange=1" class="update-btn">修改</a>
                        <a href="javascript:;" onclick="cancelApply('${priceApply.id}',this)">取消</a>
                    </c:if>

                </c:if>

                <c:if test="${priceApply.isApply == 1}">
                    <a href="${ctxweb}/shop/ebProductPriceApply/toPriceApplyUpdate?id=${priceApply.id}&isChange=0" class="update-btn">查看详情</a>
                </c:if>
            </td>
        </tr>
    </c:forEach>
</table>

<div id="outerdiv" style="position:fixed;top:0;left:0;background:rgba(0,0,0,0.7);z-index:2;width:100%;height:100%;display:none;">
    <div id="innerdiv" style="position:absolute;">
        <img id="bigimg" style="border:5px solid #fff;" src="" />
    </div>
</div>

<div class="pagination">${page}</div>
</div>

<script type="text/javascript">
    function cancelApply(id,element){
        layer.confirm("确定取消该申请？",function(){
            $.ajax({
                url:"${ctxweb}/shop/ebProductPriceApply/cancelApply",
                data:{
                    "id":id,
                },
                datatype: "json",
                success:function(data){
                    if(data.code=="1") {
                        layer.msg("取消申请成功")
                        page();
                    }else{
                        layer.msg("取消申请失败")
                        page();
                    }

                },error: function(){
                    layer.msg("取消申请失败！");
                }
            });
        })

    }
</script>
</body>

</html>