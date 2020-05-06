<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>平台广告列表</title>
    <meta name="decorator" content="default"/>

    <script type="text/javascript">
        function page(n, s) {
            if (n) $("#pageNo").val(n);
            if (s) $("#pageSize").val(s);
            $("#searchForm").attr("action", "${ctxsys}/ebShopAdvertise/advertiseList");
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

    <link href="${ctxStatic}/supplyshop/layui/css/modules/layer/default/layer.css?v=1" type="text/css" rel="stylesheet" />
    <script src="${ctxStatic}/supplyshop/layui/lay/modules/layer.js?v=1" type="text/javascript"></script>
    <script src="${ctxStatic}/sbShop/layui/layui.js"></script>
    <link href="${ctxStatic}/supplyshop/layui/css/modules/layer/default/layer.css?v=1" type="text/css" rel="stylesheet" />
    <script src="${ctxStatic}/supplyshop/layui/lay/modules/layer.js?v=1" type="text/javascript"></script>
    <link rel="stylesheet" href="${ctxStatic}/layui/css/layui.css"  media="all">
    <script src="${ctxStatic}/layui/layui.js" charset="utf-8"></script>
</head>
<body>
<div class="ibox-content">

    <ul class="nav nav-tabs">
        <li  class="active"><a href="${ctxsys}/ebShopAdvertise/advertiseList">平台广告列表</a></li>
        <shiro:hasPermission name="merchandise:ebShopAdvertise:edit">
            <li><a style="color: #009688;" href="${ctxsys}/ebShopAdvertise/advertiseFrom?flag=add">新增广告</a></li>
        </shiro:hasPermission>

    </ul>

    <form:form id="searchForm" modelAttribute="ebShopAdvertise" action="${ctxsys}/ebShopAdvertise/advertiseList" method="post"
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
            <th>广告位置</th>
            <th>广告类型</th>
            <th>广告内容</th>
            <%--<th>申请理由</th>--%>
            <th>创建时间</th>
            <th>生效时间</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${page.list}" var="advertise">
            <tr>
                <th>
                        ${advertise.name.length() > 15 ? advertise.name.substring(0,15) : advertise.name}${advertise.name.length() > 15 ? "...":""}
                </th>
                <%--<th>--%>
                        <%--${advertise.shopName}--%>
                <%--</th>--%>
                <th>
                        ${advertise.site == 1 ? "弹窗广告":"banner广告"}
                </th>

                <th>
                        ${advertise.type == 1 ? "图片广告":"优惠券广告"}
                </th>


                <th >
                    <c:if test="${advertise.pic != null && !''.equals(advertise.pic)}">
                        <c:forEach var="pic" items="${advertise.pic.split(',')}" varStatus="status">
                            <c:if test="${status.index < 2}">
                            <img src="${pic}" style="width: 50px;margin-left: 10px">
                            </c:if>
                        </c:forEach>

                    </c:if>

                    <c:if test="${advertise.pic == null || ''.equals(advertise.pic)}">
                        ${advertise.certificateName.length() > 10 ? advertise.certificateName.substring(0,10) : advertise.certificateName}${advertise.certificateName.length() > 10 ? "...":""}
                    </c:if>
                </th>
                    <%--<th>--%>
                    <%--${advertise.remark.length() > 15 ? advertise.remark.substring(0,15) : advertise.remark}${advertise.remark.length() > 15 ? "...":""}--%>
                    <%--</th>--%>


                <th>
                    <fmt:formatDate value="${advertise.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
                </th>
                <th>
                    <fmt:formatDate value="${advertise.entryTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
                </th>

                <shiro:hasPermission name="merchandise:ebShopAdvertise:edit">
                <th>
                    <a style="color: rgb(105,172,114);" href="${ctxsys}/ebShopAdvertise/advertiseFrom?id=${advertise.id}" >修改</a>
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

        function updateIsStatus(advertiseId , isStatus){
            var prompt = isStatus==0?"确定禁用该广告？":"确定启用该广告？";
            layer.confirm(prompt,{title:"确定"},function(){
                $.ajax({
                    //提交数据的类型 POST GET
                    type:"POST",
                    //提交的网址
                    url:"${ctxsys}/ebShopAdvertise/updateIsStatus",
                    //提交的数据
                    data:{
                        "advertiseId":advertiseId,
                        "isStatus":isStatus,
                    },
                    datatype: "json",//"xml", "html", "script", "json", "jsonp", "text".
                    success:function(data){
                        if(data.code=="1"){
                           layer.msg("操作成功")
                            // if(isStatus == 0){
                            //     var str=" <a href='javascript:;'>不可用</a>|";
                            //     str+=" <a href='javascript:;' style='color: rgb(105,172,114);' onclick='updateIsStatus("+advertiseId+",1)'>可用</a>";
                            //     $(".update-status-th").html(str);
                            // }else{
                            //     var str=" <a href='javascript:;'>可用</a>|";
                            //     str+=" <a href='javascript:;' style='color: rgb(105,172,114);' onclick='updateIsStatus("+advertiseId+",0)'>不可用</a>";
                            //     $(".update-status-th").html(str);
                            // }

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

</div>
</body>
</html>