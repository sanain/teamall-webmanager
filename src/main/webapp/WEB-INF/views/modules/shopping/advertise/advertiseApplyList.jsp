<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>广告申请列表</title>
    <meta name="decorator" content="default"/>

    <script type="text/javascript">
        function page(n, s) {
            if (n) $("#pageNo").val(n);
            if (s) $("#pageSize").val(s);
            $("#searchForm").attr("action", "${ctxsys}/ebShopAdvertise/shopApplyList");
            $("#searchForm").submit();
            return false;
        }
    </script>

    <style type="text/css">

        #download-file:hover,.btns input:hover{
            color: rgb(120,120,120);
        }

    </style>

    <script type="text/javascript" src="${ctxStatic}/jquery-validation/1.11.0/lib/jquery-1.9.0.js"></script>
    <script type="text/javascript" src="${ctxStatic}/jquery-validation/1.11.0/jquery.validate.js"></script>

    <link rel="stylesheet" href="${ctxStatic}/layui/css/layui.css"  media="all">
    <script src="${ctxStatic}/layui/layui.js" charset="utf-8"></script>

    <script>
        layui.use('laydate', function(){
            var laydate = layui.laydate;

            //日期时间选择器
            laydate.render({
                elem: '#test5'
                ,type: 'datetime'
            });
        });
    </script>
</head>
<body>
<div class="ibox-content">

    <ul class="nav nav-tabs">
        <li  class="active"><a href="">广告申请列表</a></li>
        <%--<li><a style="color: #009688;" href="${ctxweb}/shop/ebShopAdvertise/applyList">申请列表</a></li>--%>
    </ul>

    <form:form id="searchForm" modelAttribute="ebShopAdvertise" action="${ctxsys}/ebShopAdvertise/shopApplyList" method="post"
               class="breadcrumb form-search ">
        <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
        <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
        <tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
        <div class="p-xs">
            <ul class="ul-form">

                <li>
                    <label>广告名称：</label>
                    <form:input path="name" htmlEscape="false" maxlength="50" class="input-medium"  placeholder="请输入广告名称"/>
                </li>

                <li>
                    <label>生效时间：</label>
                    <input type="text" name="startTime" readonly="readonly"  value="${startTime}" id="test5" placeholder="选择生效时间">
                </li>


                <li>
                    <label>审核状态：</label>
                    <form:select path="applyStatus">
                        <form:option value="">全部</form:option>
                        <form:option value="0">未审核</form:option>
                        <form:option value="1">审核通过</form:option>
                        <form:option value="2">审核不通过</form:option>

                        <%--<form:option value="4">取消申请</form:option>--%>
                    </form:select>
                </li>


                <li>
                    <label>广告位置：</label>
                    <form:select path="site">
                        <form:option value="">全部</form:option>
                        <form:option value="1">弹框广告</form:option>
                        <form:option value="2">banner广告</form:option>
                    </form:select>
                </li>
                <li>
                    <label>广告类型：</label>
                    <form:select path="type">
                        <form:option value="">全部</form:option>
                        <form:option value="1">图片广告</form:option>
                        <form:option value="2">优惠券广告</form:option>
                    </form:select>
                </li>
                <li class="btns"><input  id="btnSubmit" class="btn btn-primary" type="submit" value="查询"
                                        onclick="return page();"/>
                </li>
            </ul>
        </div>
    </form:form>


    <table class="table table-striped table-bordered table-hover dataTables-example">
        <thead>
            <th>广告名称</th>
            <th>门店名称</th>
            <th>广告位置</th>
            <th>广告类型</th>
            <th>广告内容</th>
            <th>申请理由</th>
            <th>申请时间</th>
            <th>生效时间</th>
            <th>审核状态</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${page.list}" var="advertise">
            <tr>
                <th>
                        ${fns:abbr(advertise.name,16)}
                </th>
                <th>
                        ${fns:abbr(advertise.shopName,20)}
                </th>
                <th>
                        ${advertise.site == 1 ? "弹窗广告":"banner广告"}
                </th>

                <th>
                        ${advertise.type == 1 ? "图片广告":"优惠券广告"}
                </th>


                <th >
                    <c:if test="${advertise.pic != null && !''.equals(advertise.pic)}">
                        <c:if test="${advertise.pic != null && !''.equals(advertise.pic)}">
                            <c:forEach var="pic" items="${advertise.pic.split(',')}" varStatus="status">
                                <c:if test="${status.index < 2}">
                                    <img src="${pic}" style="width: 50px;margin-left: 10px;">
                                </c:if>
                            </c:forEach>

                        </c:if>
                    </c:if>

                    <c:if test="${advertise.pic == null || ''.equals(advertise.pic)}">
                        ${advertise.certificateName.length() > 10 ? advertise.certificateName.substring(0,10) : advertise.certificateName}${advertise.certificateName.length() > 10 ? "...":""}
                    </c:if>
                </th>
                    <th>
                            ${fns:abbr(advertise.remark,16)}
                    <%--${advertise.remark.length() > 6 ? advertise.remark.substring(0,6) : advertise.remark}${advertise.remark.length() > 6 ? "..":""}--%>
                    </th>




                <th>
                    <fmt:formatDate value="${advertise.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
                </th>
                <th>
                    <fmt:formatDate value="${advertise.entryTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
                </th>


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

                <shiro:hasPermission name="merchandise:ebShopAdvertise:edit">
                <th>
                     <a style="color: rgb(105,172,114);" href="${ctxsys}/ebShopAdvertise/applyCheckFrom?id=${advertise.id}" >查看</a>
                    <c:if test="${advertise.applyStatus==1}">
                             <c:if test="${advertise.isStatus==1}">
                              <a style="color: rgb(105,172,114);" href="${ctxsys}/ebShopAdvertise/isStatus?id=${advertise.id}&pageNo=${page.pageNo}&pageSize=${page.pageSize}" onclick="return confirmx('确定设置该广告为不可用？', this.href)">
                               可用 </a>
                            </c:if>
                            <c:if test="${advertise.isStatus==0}">
                             <a style="color: rgb(105,172,114);" href="${ctxsys}/ebShopAdvertise/isStatus?id=${advertise.id}&pageNo=${page.pageNo}&pageSize=${page.pageSize}" onclick="return confirmx('确定设置该广告为可用？', this.href)">
                              不可用 </a>
                            </c:if>

                    </c:if>

                </th>
                </shiro:hasPermission>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <div class="pagination">${page}</div>

    <script>
        layui.use('laydate', function(){
            var laydate = layui.laydate;

            //日期时间选择器
            laydate.render({
                elem: '#test5'
                ,type: 'datetime'
            });
        });
    </script>

</div>
</body>
</html>