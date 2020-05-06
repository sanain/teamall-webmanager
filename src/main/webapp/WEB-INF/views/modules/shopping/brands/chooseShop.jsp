<%@ page contentType="text/html;charset=UTF-8"%>
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
            $("#searchForm").attr("action", "${ctxsys}/Product/chooseShop");
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
        <form:form id="searchForm" modelAttribute="pmShopInfo"
                   action="${ctxsys}/Product/chooseShop" method="post"
                   class="breadcrumb form-search ">
            <input id="pageNo" name="pageNo" type="hidden"
                   value="${page.pageNo}" />
            <input id="pageSize" name="pageSize" type="hidden"
                   value="${page.pageSize}" />
            <input id="chooseIds" name="shopIds" type="hidden"
                   value="${shopIds}" />
            <input id="shopNames" name="shopNames" type="hidden"
                   value="${shopNames}" />
            <tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}"
                            callback="page();" />
            <ul class="ul-form">
                <li><label>门店名称:</label> <form:input path="shopName"
                                                     htmlEscape="false" maxlength="50" class="input-medium"
                                                     placeholder="请输入门店名称" /></li>
                <li><input style="margin-left:10px;background: #2e8ded"
                           id="btnSubmit" class="btn btn-primary " type="submit" value="查询"
                           onclick="return page();" /></li>
            </ul>
        </form:form>
        <tags:message content="${message}" />
        <!-- 	<div style="width: 100%;">
    <input class="btn btn-primary"
        style="margin:0px 0px 5px 5px;padding-top:2px;border-radius:0px;background: #2e8ded;font-size:12px;height: 25px;width: 50px"
        id="choose-all-btn" status="0" type="button" value="全选"
        onclick="return chooseAll();" />
</div> -->
        <table class="table table-striped table-condensed table-bordered">
            <tr>
                <th class="center123"><input type="checkbox" class="kty"
                                             value="" id="all"></th>
                <th class="center123" style="width:150px">门店名称</th>
                <th class="center123">门店账号</th>
                <th class="center123">门店地址</th>

            </tr>
            <c:forEach items="${page.list}" var="shop" varStatus="status">
                <tr>
                    <td class="center123"><input type="checkbox" name="subcheck"
                                                 class="kty choose-item" value="${shop.id}"
                                                 shopName="${shop.shopName}"></td>
                    <td class="center123">${fns:abbr(shop.shopName,30)}</td>
                    <td class="center123">${fns:abbr(shop.shopCode,14)}</td>
                    <td class="center123">${fns:abbr(shop.contactAddress,60)}</td>
                </tr>
            </c:forEach>
        </table>
        <div class="pagination">${page}</div>
    </div>
</div>
<%--<input type="hidden" id="chooseIds" value=""/>--%>



<script type="text/javascript">
    var idArr;
    var nameArr;
    var size = '${page.count}'; //商品总数

    //初始化数据
    function init() {
        var chooseIds = $("#chooseIds").val();
        var shopNames = $("#shopNames").val();

        if (chooseIds == undefined || chooseIds == "") {
            idArr = new Array();
        } else {
            idArr = chooseIds.split(",");
        }

        if (shopNames == undefined || shopNames == "") {
            nameArr = new Array();
        } else {
            nameArr = shopNames.split(",");
        }
        var itemArr = $(".choose-item");
        for (var i = 0; i < itemArr.length; i++) {
            if (idArr.indexOf($(itemArr[i]).attr("value")) >= 0) {
                $(itemArr[i]).attr("checked", true);
            } else {
                $(itemArr[i]).attr("checked", false);
            }
        }
        adTable(nameArr, idArr);

        multipleBtnStatus();
    }

    function adTable(nameArr, idArr) {
        var str = "";
        for (var i = 0; i < nameArr.length; i++) {
            str += "<tr>\
							<td>" + nameArr[i] + "</td>\
							 <td>" + idArr[i] + "</td>\
							 <td  onclick='removethis(\"" + idArr[i] + "\",\"" + nameArr[i] + "\")'>移除</td>\
							</tr>"
        }
        $(".tbody").html(str);
    }

    function removethis(id, name) {
        if (idArr.indexOf(id) >= 0) {
            idArr.splice(idArr.indexOf(id), 1);
            nameArr.splice(nameArr.indexOf(name), 1);
        }

        $("#chooseIds").val(idArr.toString());
        $("#shopNames").val(nameArr.toString());
        init();
    }

    $(function() {
        init();

        //单个元素点击的情况
        $(".choose-item").click(function() {

            if ($(this).is(':checked')) {
                idArr.push($(this).attr("value"))
                nameArr.push($(this).attr("shopName"))
            } else {
                if (idArr.indexOf($(this).attr("value")) >= 0) {
                    idArr.splice(idArr.indexOf($(this).attr("value")), 1);
                    nameArr.splice(nameArr.indexOf($(this).attr("shopName")), 1);
                }
            }
            $("#chooseIds").val(idArr.toString());
            $("#shopNames").val(nameArr.toString());
            //检查全选按钮是否应该勾选
            multipleBtnStatus();

            init();
        })
        // 子选
        /*    $("body").on("click", "input[name='subcheck']", function () {
               var $subcheck = $("input[name='subcheck']");

           })	 */

        //点击全选多多选框
        $("#all").click(function() {
            var itemArr = $(".choose-item");

            //选中的情况
            if ($(this).attr("checked") == "checked") {
                for (var i = 0; i < itemArr.length; i++) {
                    if (idArr.indexOf($(itemArr[i]).attr("value")) < 0) {
                        idArr.push($(itemArr[i]).attr("value"))
                        nameArr.push($(itemArr[i]).attr("shopName"))
                    }
                }

            } else {
                for (var i = 0; i < itemArr.length; i++) {
                    var index = idArr.indexOf($(itemArr[i]).attr("value"));
                    if (index >= 0) {
                        idArr.splice(index, 1);
                        nameArr.splice(index, 1);
                    }
                }
            }

            $("#chooseIds").val(idArr.toString());
            $("#shopNames").val(nameArr.toString());

            multipleBtnStatus();
            init();
        })
    })

    /**
     * 一键所有
     */
    function chooseAll() {
        var status = $("#choose-all-btn").attr("status"); // 0 当前未选中，1 当前已经选中

        if (status == 1) {
            $("#chooseIds").val("");
            $("#productNames").val("");

            $("#all").attr("checked", false);
            init();
            $("#choose-all-btn").attr("status", "0");

            return;
        }


        $.ajax({
            url : "${ctxweb}/shop/product/getAllProduct",
            type : "POST",
            data : $("#searchForm").serialize(),
            datatype : "json",
            success : function(data) {
                $("#chooseIds").val(data.productIds);
                $("#productNames").val(data.productNames);

                $("#all").attr("checked", false);
                init();
                $("#choose-all-btn").attr("status", "1");
            }
        })

    }


    /**
     * 控制俩种全选按钮的状态
     */
    function multipleBtnStatus() {
        if ($(".choose-item[type=checkbox]:checked").length == $(".choose-item").length) {
            $("#all").attr("checked", true);
        } else {
            $("#all").attr("checked", false);
        }

        if (idArr.length == size) {
            $("#choose-all-btn").attr("status", 1);
        } else {
            $("#choose-all-btn").attr("status", 0);
        }
    }
</script>
</body>
</html>