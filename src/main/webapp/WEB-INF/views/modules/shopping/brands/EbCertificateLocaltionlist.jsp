<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<jsp:useBean id="ebCertificate" class="com.jq.support.model.certificate.EbCertificate" scope="request"/>
<html>
<head>
    <title>优惠券发放列表</title>
    <meta name="decorator" content="default"/>
    <script src="${ctxStatic}/hAdmin/js/jquery.min.js?v=2.1.4"></script>
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/build.css">
    <link href="${ctxStatic}/jquery-jbox/2.3/Skins/Default/jbox.css" type="text/css" rel="stylesheet"/>
    <link href="${ctxStatic}/supplyshop/layui/css/modules/layer/default/layer.css?v=1" type="text/css"
          rel="stylesheet"/>
    <script src="${ctxStatic}/supplyshop/layui/lay/modules/layer.js?v=1" type="text/javascript"></script>
    <script src="${ctxStatic}/jquery-jbox/2.3/jquery.jBox-2.3.js" type="text/javascript"></script>
    <style type="text/css">
        .form-search .cerrtifcate li label {
            width: 120px;
            text-align: right;
        }


    </style>
    <script type="text/javascript">
        function page(n, s) {
            if (n) $("#pageNo").val(n);
            if (s) $("#pageSize").val(s);
            $("#searchForm").attr("action", "${ctxsys}/Product/certificatelocaltionlist");
            $("#searchForm").submit();
            return false;
        }

    </script>
    <script type="text/javascript">
        function LocaltionStatus(id) {
            $.ajax({
                url: "${ctxsys}/Product/LocaltionStatus",
                type: 'POST',
                cache: false,
                data: {id: id},
                success: function (data) {
                    alert(data.msg);
                    page('', '');
                }
            });
        }

        function deletecertificatelocaltion(id) {
            layer.confirm('确定需要删除？', {
                btn: ['确定', '取消'] //按钮
            }, function () {

                $.ajax({
                    type: "POST",
                    url: "${ctxsys}/Product/deletecertificatelocaltion", //这是跳转目标地址
                    cache: false,
                    data: {id: id},
                    async: false, //表示异步传输
                    success: function (data) {// jsonJson表示返回的数据
                        layer.close();
                        alert(data.msg);
                        page('', '');
                    }
                });

            }, function () {
            });

        }
    </script>
</head>
<body>
<ul class="nav nav-tabs">
    <li class="active"><a>优惠券发放列表</a></li>
    <shiro:hasPermission name="eb:certificatelocaltion:edit">
        <li><a href="${ctxsys}/Product/addcertificatelocaltion">优惠券发放添加</a></li>
    </shiro:hasPermission>
</ul>
<c:if test="${not empty msg}">
    <script type="text/javascript">
        $(function () {
            $.jBox.success("${msg}", "信息提示");
        })
    </script>
</c:if>
<form:form id="searchForm" modelAttribute="ebCertificateLocation" action="${ctxsys}/Product/certificatelocaltionlist"
           method="post" class="form-search breadcrumb">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
    <ul class="ul-form cerrtifcate">
        <li><label style="width: 40px;">类型:</label>
            <form:select path="type" class="input-medium">
                <form:option value="">请选择</form:option>
                <form:option value="1">注册</form:option>
                <form:option value="2">被邀请注册</form:option>
                <form:option value="3">邀请人</form:option>
                <form:option value="4">小程序门店首页领取</form:option>
                <form:option value="5">一级邀请人</form:option>
                <form:option value="6">二级邀请人</form:option>
                <form:option value="7">三级邀请人</form:option>
            </form:select>
        </li>
        <li>&nbsp;&nbsp;<button type="submit" class="btn btn-primary">查询</button>
        </li>
    </ul>
</form:form>
<table class="table table-striped table-condensed table-bordered">
    <tr>
        <th>序号</th>
        <th class="center123">名称</th>
        <th class="center123">类型</th>
        <th class="center123">优惠券编码</th>
        <th class="center123">状态</th>
        <th class="center123">创建时间</th>
        <th class="center123">描述</th>
        <th class="center123">操作</th>
    </tr>
    <c:forEach items="${page.list}" var="ebCertificateLocaltion" varStatus="status">
        <tr>
            <td>${status.index+1}</td>
            <td class="center123">${ebCertificateLocaltion.certificateLocationName}</td>
            <td class="center123">
                <c:choose>
                    <c:when test="${ebCertificateLocaltion.type==1 }">注册</c:when>
                    <c:when test="${ebCertificateLocaltion.type==2 }">被邀请注册</c:when>
                    <c:when test="${ebCertificateLocaltion.type==3 }">邀请人</c:when>
                    <c:when test="${ebCertificateLocaltion.type==4 }">小程序门店首页领取</c:when>
                    <c:when test="${ebCertificateLocaltion.type==5 }">一级邀请人</c:when>
                    <c:when test="${ebCertificateLocaltion.type==6 }">二级邀请人</c:when>
                    <c:when test="${ebCertificateLocaltion.type==7 }">三级邀请人</c:when>
                </c:choose>
            </td>
            <td class="center123">${ebCertificateLocaltion.certificateIds}</td>
            <td class="center123">
                <c:if test="${ebCertificateLocaltion.status==1}">开启</c:if>
                <c:if test="${ebCertificateLocaltion.status==0}">关闭</c:if>|

                <a onclick="LocaltionStatus('${ebCertificateLocaltion.id}')">
                    <c:if test="${ebCertificateLocaltion.status==0}">
                        开启</c:if>
                    <c:if test="${ebCertificateLocaltion.status==1}">
                        关闭</c:if>
                </a>
            </td>

            <td class="center123">${ebCertificateLocaltion.createDate}</td>
            <td class="center123">${ebCertificateLocaltion.certificateLocationDesc}</td>

            <td class="center123">
                <shiro:hasPermission name="eb:certificatelocaltion:edit">
                    <a href="${ctxsys}/Product/addcertificatelocaltion?id=${ebCertificateLocaltion.id}">修改</a>
                    &nbsp;|&nbsp;
                    <a onclick="deletecertificatelocaltion('${ebCertificateLocaltion.id}')">删除</a>
                </shiro:hasPermission>
            </td>
        </tr>
    </c:forEach>
</table>
<div class="pagination">${page}</div>


</body>
</html>