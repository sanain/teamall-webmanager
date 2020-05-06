<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>广告列表</title>
    <meta name="decorator" content="default"/>
    <link rel="stylesheet" href="${ctxStatic}/layui/css/layui.css"  media="all">
    <script src="${ctxStatic}/layui/layui.js" charset="utf-8"></script>
    <link href="${ctxStatic}/supplyshop/layui/css/modules/layer/default/layer.css?v=1" type="text/css" rel="stylesheet" />
    <script src="${ctxStatic}/supplyshop/layui/lay/modules/layer.js?v=1" type="text/javascript"></script>
    <script src="${ctxStatic}/sbShop/layui/layui.js"></script>
    <script type="text/javascript">
        function page(n, s) {
            if (n) $("#pageNo").val(n);
            if (s) $("#pageSize").val(s);
            $("#searchForm").attr("action", "${ctxweb}/shop/ebShopAdvertise/advertiseList");
            $("#searchForm").submit();
            return false;
        }
    </script>

    <style type="text/css">

        #download-file:hover,.btns input:hover{
            color: rgb(120,120,120);
        }
   #searchForm{background:#fff;}
    .nav-tabs>.active>a{border-top:3px solid #009688;color:#009688;}
      .nav-tabs>li>a{color:#000;}
      .pagination{padding-bottom:25px;}
      .ibox-content{margin:0 30px;}
      body{background:#f5f5f5;}
      .ibox-content{background:#fff;}
      .nav{margin-bottom:0;}
      .form-search .ul-form li{margin-bottom:5px;}
    </style>
</head>
<body style="">
<input type="hidden" id="flag" value="${flag}"/>

	<div style="color:#999;padding:19px 0 17px 30px;background:#f5f5f5;">
		<span>当前位置：</span><span>门店管理 - </span><span style="color:#009688;">小程序广告</span>
	</div>
<div class="ibox-content">

    <ul class="nav nav-tabs">
        <li  class="active"><a href="${ctxweb}/shop/ebShopAdvertise/advertiseList">广告列表</a></li>
        <li><a  href="${ctxweb}/shop/ebShopAdvertise/applyFrom?flag=add">增加申请</a></li>
        <li><a  href="${ctxweb}/shop/ebShopAdvertise/applyList">申请列表</a></li>
    </ul>

    <form:form id="searchForm" modelAttribute="ebShopAdvertise" action="${ctxweb}/shop/ebShopAdvertise/advertiseList" method="post"
               class="breadcrumb form-search ">
        <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
        <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
        <tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
        <div class="p-xs">
            <ul class="ul-form">

                <li>
                    <label>广告名称：</label>
                    <form:input path="name" htmlEscape="false" maxlength="50" class="input-medium"  placeholder="请输入广告名称" style="width:217px;"/>
                </li>

                    <%--<li>--%>
                    <%--<label>审核状态：</label>--%>
                    <%--<form:select path="applyStatus">--%>
                    <%--<form:option value="">全部</form:option>--%>
                    <%--<form:option value="0">未审核</form:option>--%>
                    <%--<form:option value="1">审核通过</form:option>--%>
                    <%--<form:option value="2">审核不通过</form:option>--%>
                    <%--<form:option value="4">取消申请</form:option>--%>
                    <%--</form:select>--%>
                    <%--</li>--%>
                <li>
                    <label>广告位置：</label>
                    <form:select path="site"  style="width:230px;">
                        <form:option value="">全部</form:option>
                        <form:option value="1">弹框广告</form:option>
                        <form:option value="2">banner广告</form:option>
                    </form:select>
                </li>
                <li>
                    <label>广告类型：</label>
                    <form:select path="type"  style="width:230px;">
                        <form:option value="">全部</form:option>
                        <form:option value="1">图片广告</form:option>
                        <form:option value="2">优惠券广告</form:option>
                    </form:select>
                </li>

                <li>
                    <label>状态：</label>
                    <form:select path="isStatus"  style="width:230px;">
                        <form:option value="">全部</form:option>
                        <form:option value="0">不可用</form:option>
                        <form:option value="1">可用</form:option>
                    </form:select>
                </li>

                <li class="btns"><input style="background: #393D49;width:80px; " id="btnSubmit" class="btn btn-primary" type="submit" value="查询"
                                        onclick="return page();"/>
                </li>
            </ul>
        </div>
    </form:form>


    <table class="table table-striped table-bordered table-hover dataTables-example">
        <thead>
        <tr>
            <th>广告名称</th>
            <%--<th>门店名称</th>--%>
            <th>广告位置</th>
            <th>广告类型</th>
            <%--<th>申请理由</th>--%>
            <th>广告图片</th>
            <th>优惠券</th>
            <%--<th>申请时间</th>--%>
            <%--<th>审核时间</th>--%>
            <th>审核状态</th>
            <th>状态</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${page.list}" var="advertise">
            <tr>
                <th>
                        ${fns:abbr(advertise.name,20)}
                        <%--${advertise.name.length() > 15 ? advertise.name.substring(0,15) : advertise.name}${advertise.name.length() > 15 ? "...":""}--%>
                </th>
                <%--<th>--%>
                        <%--${fns:abbr(advertise.shopName,20)}--%>
                        <%--&lt;%&ndash;${advertise.shopName}&ndash;%&gt;--%>
                <%--</th>--%>
                <th>
                        ${advertise.site == 1 ? "弹窗广告":"banner广告"}
                </th>

                <th>
                        ${advertise.type == 1 ? "图片广告":"优惠券广告"}
                </th>
                    <%--<th>--%>
                    <%--${advertise.remark.length() > 15 ? advertise.remark.substring(0,15) : advertise.remark}${advertise.remark.length() > 15 ? "...":""}--%>
                    <%--</th>--%>

                <th >
                    <c:if test="${advertise.pic != null && !''.equals(advertise.pic)}">
                        <c:forEach var="pic" items="${advertise.pic.split(',')}" varStatus="status">
                            <c:if test="${status.index < 2}">
                                <img src="${pic}" style="width: 50px;margin-left: 10px">
                            </c:if>
                        </c:forEach>

                    </c:if>
                </th>


                <th >
                        <%--${advertise.certificateName.length() > 30 ? advertise.certificateName.substring(0,30) : advertise.certificateName}${advertise.certificateName.length() > 30 ? "...":""}--%>
                        ${fns:abbr(advertise.certificateName,25)}
                        <%--${advertise.certificateName}--%>
                </th>
                    <%--<th>--%>
                    <%--<fmt:formatDate value="${advertise.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/>--%>
                    <%--</th>--%>
                    <%----%>
                    <%--<th>--%>
                    <%--<fmt:formatDate value="${advertise.applyTime}" pattern="yyyy-MM-dd HH:mm:ss"/>--%>
                    <%--</th>--%>


                <c:if test="${advertise.applyStatus==0}">
                    <th style="color:#0465AA">未审核</th>
                </c:if>

                <c:if test="${advertise.applyStatus==1}">
                    <th style="color:#00aa00">审核通过</th>
                </c:if>
                <c:if test="${advertise.applyStatus==2}">
                    <th style="color:#dd0000">审核不通过</th>
                </c:if>

                <c:if test="${advertise.applyStatus==4}">
                    <th style="color:#8F93AA">取消申请</th>
                </c:if>

                <th class="update-status-th">
                    <c:if test="${advertise.applyStatus==1}">
                        <span>
                                ${advertise.isStatus == 0 ? "不可用":"可用"} |
                        </span>

                        <c:if test="${advertise.isStatus == 0}">
                            <a href="javascript:;" style="color: #009688;" onclick="updateIsStatus('${advertise.id}','1',this)">
                                可用
                            </a>
                        </c:if>

                        <c:if test="${advertise.isStatus != 0}">
                            <a href="javascript:;" style="color: #009688;" onclick="updateIsStatus('${advertise.id}','0',this)">
                                不可用
                            </a>
                        </c:if>
                    </c:if>

                    <c:if test="${advertise.applyStatus==2}">
                       不可用
                    </c:if>
                </th>

                <th>
                    <a style="color: #009688;" href="${ctxweb}/shop/ebShopAdvertise/advertiseFrom?id=${advertise.id}" >查看详情</a>

                    <a style="color: #009688;" href="${ctxweb}/shop/ebShopAdvertise/deleteAdvertise?id=${advertise.id}" >删除</a>
                </th>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <div class="pagination">${page}</div>
</div>

<script>
    function updateIsStatus(advertiseId , isStatus,element){
        var prompt = isStatus==0?"确定禁用该广告？":"确定启用该广告？";
        layer.confirm(prompt,{title:"确定"},function(){
            $.ajax({
                //提交数据的类型 POST GET
                type:"POST",
                //提交的网址
                url:"${ctxweb}/shop/ebShopAdvertise/updateIsStatus",
                //提交的数据
                data:{
                    "advertiseId":advertiseId,
                    "isStatus":isStatus,
                },
                datatype: "json",//"xml", "html", "script", "json", "jsonp", "text".
                success:function(data){
                    if(data.code=="1"){
                        layer.msg("操作成功")
                        page();


                    }else{
                        layer.msg("操作失败")
                    }
                },error: function(){
                    layer.msg("操作失败")
                }
            });
        })
    }
</script>
</body>
</html>