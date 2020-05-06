<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<jsp:useBean id="ebCertificate" class="com.jq.support.model.certificate.EbCertificate" scope="request"/>
<html>
<head>
    <title>优惠券列表</title>
    <meta name="decorator" content="default"/>
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/build.css">
    <link href="${ctxStatic}/jquery-jbox/2.3/Skins/Default/jbox.css" type="text/css" rel="stylesheet"/>
    <script src="${ctxStatic}/jquery-jbox/2.3/jquery.jBox-2.3.js" type="text/javascript"></script>
    <style type="text/css">
    body{background:#f5f5f5;}
    #searchForm{background:#fff;}
    .nav-tabs>.active>a{border-top:3px solid #009688;color:#009688;}
      .nav-tabs>li>a{color:#000;}
      .pagination{padding-bottom:25px;}
        .form-search .cerrtifcate li label {
            width: 120px;
            text-align: right;
        }
.form-search label{margin-right:10px;margin-left:0;}
.form-search .ul-form li{margin-bottom:5px;}
        a{
            color:#009688;
        }
        a:hover{
            color:#009688;
        }


    </style>
    <script type="text/javascript">
        function page(n, s) {
            if (n) $("#pageNo").val(n);
            if (s) $("#pageSize").val(s);
            $("#searchForm").attr("action", "${ctxweb}/shop/product/shopCertificatelist");
            $("#searchForm").submit();
            return false;
        }

        // 确定删除弹框
        function overlay(id) {
            debugger;
            var e1 = document.getElementById('modal-overlays');
            var ids = document.getElementById('yhid');
            ids.value = id;
            e1.style.visibility = (e1.style.visibility == "visible") ? "hidden" : "visible";
        }

        //确定
        function update() {
            updatePassword();
            overlay(id);
        }


        function updatePassword() {
            var id = $("#yhid").val();
            var params = {
                id: $.trim($("#yhid").val()),
            }
            $.ajax({
                type: "post",
                url: "${ctxweb}/shop/product/deletecertificate",
                data: params,
                beforeSend: function () {

                },
                success: function (data) {
                    window.location.reload();
                }
                , error: function (res) {
                    alert("获取数据失败");
                }
            })

            <%--var id = $.trim($("#yhid").val());--%>
            <%--window.location.href = "${ctxweb}/shop/product/deletecertificate?id=" + id;--%>
        }
    </script>
</head>
<body>
	<div style="color:#999;padding:19px 0 17px 30px;background:#f5f5f5;">
		<span>当前位置：</span><span>门店管理 - </span><span style="color:#009688;">优惠券信息</span>
	</div>
	<div style="margin:0 30px;background:#fff;">
<ul class="nav nav-tabs">
    <li class="active"><a href="${ctxweb}/shop/product/shopCertificatelist">优惠券信息</a></li>
    <li><a href="${ctxweb}/shop/product/addcertificate">优惠券添加</a></li>
</ul>
<c:if test="${not empty msg}">
    <script type="text/javascript">
        $(function () {
            $.jBox.success("${msg}", "信息提示");
        })
    </script>
</c:if>
<form:form id="searchForm" modelAttribute="ebCertificate" action="${ctxweb}/shop/product/shopCertificatelist"
           method="post" class="form-search breadcrumb">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
    <ul class="ul-form cerrtifcate">
        <li><label>类型:</label>
            <form:select path="type" class="input-medium" style="width:230px;">
                <form:option value="">请选择</form:option>
                <form:option value="1">满减券</form:option>
                <form:option value="2">现金券</form:option>
                <form:option value="3">折扣券</form:option>
            </form:select>
        </li>
        <li style="display: none"><label>产品类型适用范围:</label>
            <form:select path="productType" class="input-medium" style="width:230px;">
                <form:option value="">请选择</form:option>
                <form:option value="1">指定商品</form:option>
                <!--<form:option value="2">指定类别</form:option>-->
                <form:option value="3">所有商品</form:option>
            </form:select>
        </li>
        <li style="display: none"><label>商品/类别ID:</label><form:input path="productTypeId" htmlEscape="false" maxlength="50"
                                               class="input-medium" placeholder="请输入商品/类别ID"/></li>
        <li><label>有效开始日期:</label>
            <input type="text" id="startDate" name="startDate" htmlEscape="false" maxlength="50" style="width:217px;"
                   onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" placeholder="请输入有效开始日期" class="input-medium">
        <li><label>有效结束日期:</label>
            <input type="text" id="endDate" name="endDate" htmlEscape="false" maxlength="50" style="width:217px;"
                   onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" placeholder="请输入有效开始日期" class="input-medium">
        <li><label>优惠券名称:</label><form:input path="certificateName" htmlEscape="false" maxlength="50" style="width:217px;"
                                             class="input-medium" placeholder="请输入优惠券名称"/></li>
        <li style="margin-left:10px">
            <button type="submit" class="btn btn-primary"
                    style="display: inline-block;background: #393D49;color: #ffffff;height: 30px;line-height: 30px;padding: 0 15px;border-radius: 4px;">
                查询
            </button>
        </li>
    </ul>
</form:form>
<table class="table table-striped table-condensed table-bordered">
    <tr>
        <th class="center123" width="150px">优惠券名称</th>
        <th class="center123" width="60px">类型</th>
        <th class="center123" width="60px">满减金额</th>
        <th class="center123" width="50px">金额/折扣</th>
        <th class="center123" width="60px"  style="display: none">产品类型适用范围</th>
        <th class="center123"  style="display: none">商品名称</th>
        <th class="center123" width="100px" style="display: none">商家范围</th>
        <!-- <th class="center123">商家id</th> -->
        <th class="center123" width="140px">有效开始日期</th>
        <th class="center123" width="140px">有效结束日期</th>
        <th class="center123" width="140px">发起时间</th>
        <th class="center123" width="140px">创建时间</th>
        <th class="center123">优惠券备注</th>
        <th class="center123" width="80px">操作</th>
    </tr>
    <c:forEach items="${page.list}" var="ebCertificate" varStatus="status">
        <tr>
            <td class="center123">${ebCertificate.certificateName}</td>
            <td class="center123">
                <c:choose>
                    <c:when test="${ebCertificate.type==1 }">满减券</c:when>
                    <c:when test="${ebCertificate.type==2 }">现金券</c:when>
                    <c:otherwise>折扣券</c:otherwise>
                </c:choose>
            </td>
            <td class="center123">${ebCertificate.provinceOutFullFreight}</td>
            <td class="center123">${ebCertificate.amount}</td>
            <td class="center123"  style="display: none">
                <c:choose>
                    <c:when test="${ebCertificate.productType==1 }">指定商品</c:when>
                    <c:when test="${ebCertificate.productType==2 }">指定类别</c:when>
                    <c:otherwise>所有商品</c:otherwise>
                </c:choose>
            </td>
            <td class="center123"  style="display: none">${ebCertificate.productType=='1'?ebCertificate.productInfos:'所有商品'}</td>
            <td class="center123" style="display: none">${ebCertificate.shopType=='1'?'指定商家':'所有商家'}</td>
            <td class="center123"> ${ebCertificate.certificateStartDate} </td>
            <td class="center123">
                    ${ebCertificate.certificateEndDate}
            </td>
            <td class="center123">
                    ${ebCertificate.sendTime}
            </td>
            <td class="center123">${ebCertificate.createTime}</td>
            <td class="center123">${ebCertificate.remark}</td>
            <td class="center123">

                <a style="color:#009688; "
                   href="${ctxweb}/shop/product/addcertificate?id=${ebCertificate.certificateId}&flag=edit">修改</a>
                <%--&nbsp;|&nbsp;--%>
                <%--<a style="color:#009688; "--%>
                   <%--onclick="overlay(${ebCertificate.certificateId})">删除</a>--%>
            </td>
        </tr>
    </c:forEach>
</table>
<div class="pagination">${page}</div>

<div id="modal-overlays">
    <div class="modal-data">
        <div class="msg-btn">
            <label style="margin-top:10px;">确定删除么?</label><input style="display: none" id="yhid">
        </div>
        <div class="msg-btn">
            <a onclick="update()" style="background-color:#4778C7;width:50px;height:30px;line-height:30px;color:#fff;margin-top:20px;display: inline-block;">确定</a>
            <a onclick="overlay()" style="background-color:#999;width:50px;height:30px;line-height:30px;color:#fff;margin-top:20px;display: inline-block;">取消</a>
        </div>
    </div>
</div>
</div>
<style>
    /* 定义模态对话框外面的覆盖层样式 */
    #modal-overlays {
        visibility: hidden;
        position: absolute; /* 使用绝对定位或固定定位  */
        left: 0px;
        top: 0px;
        width: 100%;
        height: 100%;
        text-align: center;
        z-index: 1000;
        background-color: #3333;
    }

    /* 模态框样式 */
    .modal-data {
        width: 200px;
        height:80px;
        margin: 100px auto;
        background-color: #fff;
        border: 1px solid #000;
        border-color: #ffff;
        padding: 15px;
        text-align: center;
    }
</style>
</body>
</html>