<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>门店列表</title>
    <meta name="decorator" content="default" />
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/build.css?v=1">
    <link rel="stylesheet"
          href="${ctxStatic}/sbShop/css/quick-choose-product.css">

    <style>
        .table1 tr {
            height: 35px;
        }

        .breadcrumb {
            background: #fff;
        }
    </style>
    <script>
        function page(n, s) {
            if (n) $("#pageNo").val(n);
            if (s) $("#pageSize").val(s);
            $("#searchForm").attr("action", "${ctxsys}/Product/chooseShops");
            $("#searchForm").submit();
            return false;
        }
    </script>
</head>
<body>
<div style="overflow:hidden;height:350px;">
    <div style="float:left;width:25%;overflow:scroll;height:100%;">
        <table
                class="table table-striped table-condensed table-bordered table1">
            <thead>
            <tr>
                <td>门店名称</td>
                <td></td>
            </tr>
            </thead>

            <tbody class="tbody">

            </tbody>


        </table>

    </div>

    <div style="float:left;width:75%;overflow:scroll;height:100%;">
        <form:form id="searchForm" modelAttribute="pmShopInfo" action="${ctxsys}/agentStatement/chooseShopByAgent" method="post" class="breadcrumb form-search ">
            <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
            <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
            <input type="hidden" id="chooseIds" name="chooseIds" value="${chooseIds}"/>
            <input type="hidden" id="agentId" name="agentId" value="${agentId}"/>
            <input type="hidden" id="chooseNames" value="${shopNames}"/>
            <tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
            <ul class="ul-form">
                <li><label>门店名称:</label><form:input path="shopName" value="${pmShopInfo.shopName}" htmlEscape="false" maxlength="50" class="input-medium"  placeholder="请输入店名"/><input style="margin-left:10px" id="btnSubmit" class="btn btn-primary " type="submit" value="查询" onclick="return page();"/></li>
            </ul>
        </form:form>
        <tags:message content="${message}"/>

        <table  class="table table-striped table-condensed table-bordered" >
            <tr>
                <th class="center123"></th>
                <th class="center123">编号</th>
                <th class="center123">门店名称</th>
                <th class="center123">门店地址</th>
                <th class="center123">营业时间</th>
            </tr>
            <c:forEach items="${pmShopList}" var="shop" varStatus="status">
                <tr>
                    <td class="center123"><input type="checkbox" name="ktvs" class="kty chooseItem"  value="${shop.id}"></td>
                    <td class="center123">${status.index+1}</td>
                    <td class="center123 shop-name">${shop.shopName}</td>
                    <td class="center123">${shop.contactAddress}</td>
                    <td class="center123">${shop.openingTime} ~ ${shop.closingTime}</td>
                </tr>
            </c:forEach>
        </table>
        <div class="pagination">${page}</div>
    </div>
    <input type="hidden" />



</div>
<script type="text/javascript">

</script>


<script type="text/javascript">
    var id="";
    var shopName="";
    var lastNode;
    $(function(){
        id = $("#chooseIds").val();
        shopName = $("#chooseNames").val();

        //初始化原来已经选好的门店
        initAlreadyChecked();

        /**
         * 控制选择和取消
         * */
        $(".chooseItem").click(function(){
            if($(this).attr("checked") == "checked"){

                id = $(this).attr("value");
                shopName = $(this).parents("tr").find(".shop-name").text();

                if(lastNode != null && lastNode != undefined){
                    lastNode.attr("checked",false);
                }
                lastNode = $(this);
            }else{
                id = '';
                shopName = '';
                lastNode = null;
            }

            $("#chooseIds").val(id);
            $("#chooseNames").val(shopName);

            adTable()
        })
    })

    /**
     * 初始化原来已经选好的门店
     * */
    function initAlreadyChecked(){
        var arr = $(".chooseItem");
        for(var i = 0 ; i < arr.length ; i++){
            if(id == $(arr[i]).attr("value")){
                $(arr[i]).attr("checked",true);
                lastNode = $(arr[i]);
            }
        }

        adTable();
    }


    function adTable() {
        var str = "";
        debugger
        if(shopName != "" && id != "") {
            str += "<tr>\
							<td>" + shopName + "</td>\
							 <td>" + id + "</td>\
							 <td  onclick='removethis()'>移除</td>\
							</tr>"
        }
        $(".tbody").html(str);
    }

    function removethis(id, name) {
        $(".tbody").html("");
        $(lastNode).click();
    }
</script>
</body>
</html>