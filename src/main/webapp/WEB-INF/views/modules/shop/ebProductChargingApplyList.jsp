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
            $("#searchForm").attr("action","${ctxweb}/shop/ebProductChargingApply/applyList");
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
        #applyName,#applyStatus{margin-left:15px;height:35px;width:240px;line-height:35px;padding:0;}
        table{margin:0 20px;}
        #treeTable tr{height:35px;line-height:35px;}
        .form-search .ul-form{height:40px;}
    </style>
    <style type="text/css">
        .control-group .control-label{
            padding-right: 10px;
        }
        .form-check-inline{
            float: left;
            padding-left: 10px;
        }
        #inputForm{margin:0 30px;}
          #searchForm,#inputForm{background:#fff;}
    .nav-tabs>.active>a{border-top:3px solid #009688;color:#009688;}
      .nav-tabs>li>a{color:#000;text-align:center;}
      .pagination{padding-bottom:25px;padding-left:20px;margin-top:20px;}
      .ibox-content{margin:0 30px;}
      body{background:#f5f5f5;}
      .ibox-content{background:#fff;}
      .nav{margin-bottom:0;}
      .form-horizontal{margin:0;}
    </style>
    <link rel="stylesheet" href="${ctxStatic}/layui/css/layui.css"  media="all">
    <script src="${ctxStatic}/layui/layui.js" charset="utf-8"></script>


</head>
<body style="background:#f5f5f5;">
	<div style="color:#999;margin:19px 0 17px 30px;">
		<span>当前位置：</span><span>商品管理 - </span><span style="color:#009688;">加料管理</span>
	</div>

<div id="inputForm">
<ul class="nav nav-tabs">
    <li style="width:145px;"><a  href="${ctxweb}/shop/shopPmProductType/list">加料类别</a></li>
    <li style="width:145px;" class="active"><a  href="${ctxweb}/shop/ebProductChargingApply/applyList">申请列表</a></li>

</ul>
<form:form id="searchForm" modelAttribute="apply" action="${ctxsys}/ebProductPriceApply/applyList" method="post" class="breadcrumb form-search ">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
    <tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
    <ul class="ul-form">
        <li><label>申请名称:</label><form:input path="applyName" htmlEscape="false" maxlength="80" class="input-medium"  placeholder="请输入商品名称"/></li>
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
        <li><label></label><input id="btnSubmit" class="btn btn-primary"  type="submit" style="background: #393D49;margin-left: -50px" value="查询" onclick="return page();"/></li>
    </ul>
</form:form>
<tags:message content="${message}"/>

<table id="treeTable" class="table table-striped table-condensed table-bordered" >
    <tr>
        <th class="center123">申请名称</th>
        <th class="center123 ">申请理由</th>
        <th class="center123 ">申请时间</th>
        <th class="center123 ">审核状态</th>
        <th class="center123">操作</th>
    </tr>
    <c:forEach items="${page.list}" var="chargingApply" varStatus="status">
        <tr>
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
                <c:if test="${chargingApply.isApply == 0}">
                    <c:if test="${chargingApply.applyStatus == 4}">
                        <a href="${ctxweb}/shop/ebProductChargingApply/applyForm?applyId=${chargingApply.id}" class="update-btn">查看详情</a>
                    </c:if>
                    <c:if test="${chargingApply.applyStatus == 0}">
                        <a href="${ctxweb}/shop/ebProductChargingApply/applyForm?applyId=${chargingApply.id}" class="update-btn">修改</a>
                        <a href="javascript:;" onclick="cancelApply('${chargingApply.id}',this)">取消</a>
                    </c:if>

                </c:if>

                <c:if test="${chargingApply.isApply == 1}">
                    <a href="${ctxweb}/shop/ebProductChargingApply/applyForm?applyId=${chargingApply.id}" class="update-btn">查看详情</a>
                </c:if>
            </td>
        </tr>
    </c:forEach>
</table>
<div class="pagination">${page}</div></div>

<div id="outerdiv" style="position:fixed;top:0;left:0;background:rgba(0,0,0,0.7);z-index:2;width:100%;height:100%;display:none;">
    <div id="innerdiv" style="position:absolute;">
        <img id="bigimg" style="border:5px solid #fff;" src="" />
    </div>
</div>

<script type="text/javascript">
    function cancelApply(id,element){
        layer.confirm("确定取消该申请？",function(){
            $.ajax({
                url:"${ctxweb}/shop/ebProductChargingApply/cancelApply",
                data:{
                    "applyId":id,
                },
                datatype: "json",
                success:function(data){
                    if(data.code=="1"){
                        layer.msg("取消申请成功")
                    }else{
                        layer.msg("取消申请失败")
                    }
                    page();
                },error: function(){
                    layer.msg("取消申请失败！");
                }
            });
        })

    }
</script>
</body>

</html>