<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>加料类别</title>
    <meta name="decorator" content="default"/>
   <link rel="stylesheet" href="${ctxStatic}/layui/css/layui.css?v=1">
    <script type="text/javascript">
        function page(n, s) {
            if (n) $("#pageNo").val(n);
            if (s) $("#pageSize").val(s);
            $("#searchForm").attr("action", "${ctxweb}/shop/shopPmProductType/list");
            $("#searchForm").submit();
            return false;
        }
    </script>
    <style type="text/css">
    table thead tr{height:35px;line-height:35px;padding:0;}
    .table th, .table td{line-height:35px;}
    .pagination{padding-bottom:20px;}
body{background:#f5f5f5;}
.ibox-content,#searchForm{background:#fff;}
        #download-file:hover,.btns input:hover{
            color: rgb(120,120,120);
        }
.ibox-content{margin:0 30px;}
        /*.nav-tabs a{*/
            /*color: rgb(120,120,120);*/
        /*}*/
.form-search .ul-form li{height:40px;}
    .layui-tab-title{height:43px;}
.table th{padding:0 8px;}
    </style>
</head>
<body>
<body style="background:#f5f5f5;">
	<div style="color:#999;margin:19px 0 17px 30px;">
		<span>当前位置：</span><span>商品管理 - </span><span style="color:#009688;">加料管理</span>
	</div>
<div class="ibox-content">
    		<div class="layui-tab">
  <ul class="layui-tab-title">
    <li class="layui-this" style="width:145px;border-top:2px solid  #009688;background:#fff;">
        <a class="active" href="${ctxweb}/shop/shopPmProductType/list" style=" color: #009688;height:43px;background:#fff;">加料类别</a></li>

      <li><a style="color: #333;" href="${ctxweb}/shop/ebProductChargingApply">加料申请列表</a></li>
  </ul>
</div>

    <form id="searchForm" modelAttribute="pmProductType" action="${ctxweb}/shop/shopPmProductType/list" method="post"
               class="breadcrumb form-search ">
        <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
        <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
        <tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
        <div class="p-xs">
            <ul class="ul-form">
                <li>
                    <label style="width: 85px;">分类名称：</label>
                    <input id="productTypeName" style="width:230px;padding:0;height:35px;" name="productTypeName" type="text" style="width:155px" value="${pmProductType.productTypeName}">
                                   </li>
                <li class="btns"><input style="background: #393D49;height:35px;width:90px;" id="btnSubmit" class="btn btn-primary" type="submit" value="查询"
                                        onclick="return page();"/>
                </li>

            </ul>
        </div>
    </form>


    <table class="table table-striped table-bordered table-hover dataTables-example">
        <thead>
            <tr>
                <th>分类名称</th>
                <th>分类图片</th>
                <th>层次关系</th>
                <th>来源</th>
                <th>使用状态</th>
                <th>描述</th>
                <th>操作</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${page.list}" var="productType">
                    <tr>
                        <th >
                                ${productType.productTypeName}
                        </th>
                        <th>
                            <img src="${productType.productTypeLogo}" class="type-img" style="height: 34px; padding: 3px"/>
                        </th>
                        <th >
                            ${productType.productTypeStr}
                        </th>
                        <td>
                                ${productType.shopName != null && !''.equals(productType.shopName) ? productType.shopName : '平台'}
                        </td>
                        <td>
                            <c:if test="${productType.isPublic == 0 || productType.isPublic == null}">
                                平台使用
                            </c:if>
                            <c:if test="${productType.isPublic == 1}">
                                商家使用
                            </c:if>
                            <c:if test="${productType.isPublic == 2}">
                                平台和商家共用
                            </c:if>
                        </td>
                        <th >
                                ${productType.describeInfo}
                        </th>

                        <th >
                            <a href="${ctxweb}/shop/ebShopCharging?productTypeId=${productType.id}">查看加料</a>
                        </th>

                    </tr>
            </c:forEach>
        </tbody>
    </table>
    <div class="pagination">${page}</div>

</div>

</body>
</html>