<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>申请列表</title>
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
            $("#searchForm").attr("action","${ctxsys}/ebProductChargingApply/checkApplyList");
            $("#searchForm").submit();
        }
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
        .list-ul li:nth-child(1){padding-left: 20px}
        .list-ul li:nth-child(2){padding-left: 20px}
        .list-ul li:nth-child(3) img{width: 100%}
    </style>

    <link rel="stylesheet" href="${ctxStatic}/layui/css/layui.css"  media="all">
    <script src="${ctxStatic}/layui/layui.js" charset="utf-8"></script>


</head>
<body>
<ul class="nav nav-tabs">
    <li class="active"><a href="${ctxsys}/productPriceChargingApply/applyList">申请列表</a></li>

</ul>
<form:form id="searchForm" modelAttribute="apply" action="${ctxsys}/ebProductPriceApply/applyList" method="post" class="breadcrumb form-search ">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
    <tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
    <ul class="ul-form">
        <li><label>申请名称:</label><form:input path="applyName" htmlEscape="false" maxlength="80" class="input-medium"  placeholder="请输入商品名称"/></li>
        <li><label>门店名称:</label><form:input path="shopName" htmlEscape="false" maxlength="80" class="input-medium"  placeholder="请输入门店名称"/></li>
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
        <li><label></label><input id="btnSubmit" class="btn btn-primary" style="background-color: #69AC72" type="submit" style="background: #393D49;margin-left: -50px" value="查询" onclick="return page();"/></li>
    </ul>
</form:form>
<tags:message content="${message}"/>

<table id="treeTable" class="table table-striped table-condensed table-bordered" >
    <tr>
        <th class="center123">门店名称</th>
        <th class="center123">申请名称</th>
        <th class="center123 ">申请理由</th>
        <th class="center123 ">申请时间</th>
        <th class="center123 ">审核状态</th>
        <th class="center123">操作</th>
    </tr>
    <c:forEach items="${page.list}" var="chargingApply" varStatus="status">
        <tr>
            <td class="center123">${chargingApply.shopName}</td>
            <td class="center123">${chargingApply.applyName}</td>
            <td class="center123">
                    ${fns:abbr(chargingApply.applyRemark,35)}
            </td>
            <td class="center123"><fmt:formatDate value="${chargingApply.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/> </td>
            <td class="center123 apply-status-td">

                <c:if test="${chargingApply.applyStatus==0}">
                    <span style="color:#0465AA">未审核</span>
                </c:if>

                <c:if test="${chargingApply.applyStatus==1}">
                    <span style="color:#00aa00">审核通过</span>
                </c:if>
                <c:if test="${chargingApply.applyStatus==2}">
                    <span style="color:#dd0000">审核不通过</span>
                </c:if>

                <c:if test="${chargingApply.applyStatus==4}">
                    <span style="color:#8F93AA">已取消</span>
                </c:if>
            </td>
            <td class="center123 control-td">
                <a href="${ctxsys}/ebProductChargingApply/toCheckApply?applyId=${chargingApply.id}" class="update-btn">查看</a>
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

</body>

</html>