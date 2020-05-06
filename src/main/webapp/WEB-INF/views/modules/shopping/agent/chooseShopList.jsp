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
            $("#searchForm").attr("action", "${ctxsys}/pmAgent/chooseShops");
            $("#searchForm").submit();
            return false;
        }
	</script>
</head>
<body>
<<div style="overflow:hidden;height:350px;">
	<div style="float:left;width:25%;overflow:scroll;height:100%;">
		<table
				class="table table-striped table-condensed table-bordered table1">
			<thead>
			<tr>
				<td>门店名称</td>
			</tr>
			</thead>

			<tbody class="tbody">
			</tbody>
		</table>
	</div>

	<div style="float:left;width:75%;overflow:scroll;height:100%;">
		<form:form id="searchForm" modelAttribute="pmShopInfo" action="${ctxsys}/pmAgent/chooseShops" method="post" class="breadcrumb form-search ">
			<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
			<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
			<input type="hidden" id="chooseIds" name="chooseIds" value="${chooseIds}"/>
			<input type="hidden" id="agentId" name="agentId" value="${agentId}"/>
			<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
			<ul class="ul-form">
				<li><label>门店名称:</label><form:input path="shopName" value="${pmShopInfo.shopName}" htmlEscape="false" maxlength="50" class="input-medium"  placeholder="请输入店名"/><input style="margin-left:10px" id="btnSubmit" class="btn btn-primary " type="submit" value="查询" onclick="return page();"/></li>
			</ul>
		</form:form>
		<tags:message content="${message}"/>

		<input type="hidden" id="chooseNames" value="${shopNames}"/>
		<table  class="table table-striped table-condensed table-bordered" >
			<tr>
				<th class="center123"><input type="checkbox" class="kty"
											 value="" id="all"></th>
				<th class="center123">编号</th>
				<th class="center123">门店名称</th>
				<th class="center123">门店地址</th>
				<th class="center123">营业时间</th>
			</tr>
			<c:forEach items="${page.list}" var="shop" varStatus="status">
				<tr>
					<td class="center123"><input type="checkbox" name="ktvs" class="kty chooseItem"  value="${shop.id}" shopName="${shop.shopName}"></td>
					<td class="center123">${status.index+1}</td>
					<td class="center123 shop-name">${shop.shopName}</td>
					<td class="center123">${shop.contactAddress}</td>
					<td class="center123">${shop.openingTime} ~ ${shop.closingTime}</td>
				</tr>
			</c:forEach>
		</table>
		<div class="pagination">${page}</div>
		<input type="hidden" />

	</div>
</div>

<script type="text/javascript">
    var ids;
    var shopNameArr;

    $(function(){
        if($("#chooseIds").val() == undefined || $("#chooseIds").val() == ""){
            ids = new Array();
        }else{
            ids = $("#chooseIds").val().split(",");
        }

        if($("#chooseNames").val() == undefined || $("#chooseNames").val() == ""){
            shopNameArr = new Array();
        }else{
            shopNameArr = $("#chooseNames").val().split(",");
        }

        adTable();

        /**
         * 控制选择和取消
         * */
        $(".chooseItem").click(function(){
            if($(this).attr("checked") == "checked"){
                if(ids.indexOf($(this).attr("value")) == -1){
                    ids.push($(this).attr("value"));
                    //获得门店名
                    shopNameArr.push($(this).attr("shopName"));
                }
            }else{
                var index = ids.indexOf($(this).attr("value"));
                if(index != -1){
                    ids.splice(index , 1);
                    shopNameArr.splice(index , 1);
                }
            }

            $("#chooseIds").val(ids.toString());
            $("#chooseNames").val(shopNameArr.toString());
            adTable()
        })

        //点击全选多选框
        $("#all").click(function() {
            var itemArr = $(".chooseItem");

            //选中的情况
            if ($(this).attr("checked") == "checked") {
                for (var i = 0; i < itemArr.length; i++) {
                    if (ids.indexOf($(itemArr[i]).attr("value")) < 0) {
                        ids.push($(itemArr[i]).attr("value"))
                        shopNameArr.push($(itemArr[i]).attr("shopName"))
                    }
                }

            } else {
                for (var i = 0; i < itemArr.length; i++) {
                    var index = ids.indexOf($(itemArr[i]).attr("value"));
                    if (index >= 0) {
                        ids.splice(index, 1);
                        shopNameArr.splice(index, 1);
                    }
                }
            }

            $("#chooseIds").val(ids.toString());
            $("#chooseNames").val(shopNameArr.toString());

            adTable();
        })
    })

    /**
     * 初始化原来已经选好的门店
     * */
    function initAlreadyChecked(){
        var arr = $(".chooseItem");
        for(var i = 0 ; i < arr.length ; i++){
            if(ids.indexOf($(arr[i]).attr("value")) >= 0){
                $(arr[i]).attr("checked",true);
                // var shopName = $(arr[i]).parents("tr").find(".shop-name");
            }
        }
    }

    function adTable() {
        var str = "";
        for (var i = 0; i < shopNameArr.length; i++) {
            str += "<tr>\
							<td>" + shopNameArr[i] + "</td>\
							 <td>" + ids[i] + "</td>\
							 <td  onclick='removethis(\"" + ids[i] + "\",\"" + shopNameArr[i] + "\")'>移除</td>\
							</tr>"
        }
        $(".tbody").html(str);
        initAlreadyChecked();
    }

    function removethis(id, name) {
        debugger
        if (ids.indexOf(id) >= 0) {
            ids.splice(ids.indexOf(id), 1);
            shopNameArr.splice(shopNameArr.indexOf(name), 1);
        }

        $("#chooseIds").val(ids.toString());
        $("#chooseNames").val(shopNameArr.toString());

        adTable();
    }
</script>
</body>
</html>