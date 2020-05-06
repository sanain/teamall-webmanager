<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>加料列表</title>
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
            $("#searchForm").attr("action", "${ctxsys}/EbProductCharging/chooseProductCharging");
            $("#searchForm").submit();
            return false;
        }
	</script>
<body>
<div style="overflow:hidden;height:350px;">
	<div style="float:left;width:25%;overflow:scroll;height:100%;">
		<table
				class="table table-striped table-condensed table-bordered table1">
			<thead>
			<tr>
				<td>加料名</td>
				<td></td>
			</tr>
			</thead>

			<tbody class="tbody">

			</tbody>


		</table>

	</div>

	<div style="float:left;width:75%;overflow:scroll;height:100%;">
		<form:form id="searchForm" modelAttribute="ebProductCharging" action="${ctxsys}/EbProductCharging/chooseProductCharging" method="post" class="breadcrumb form-search ">
			<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
			<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
			<input id="productTypeId" name="productTypeId" type="hidden" value="${ebProductCharging.productTypeId}" />
			<input id="is-all" name="isAll" type="hidden" value="${isAll}" />
			<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
			<input type="hidden" id="chooseIds" name="chooseIds" value="${chooseIds}"/>
			<ul class="ul-form">
				<li><label>加料名字:</label><form:input path="cName" htmlEscape="false" maxlength="80" class="input-medium"  placeholder=""/></li>
				<li><label>标签名字:</label><form:input path="lable" htmlEscape="false" maxlength="80" class="input-medium"  placeholder=""/></li>
				<li><label>价格:</label><form:input id="sellPrice" path="sellPrice" htmlEscape="false" maxlength="80" class="input-medium"  placeholder="" required="required"/></li>
				<li><label></label><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/></li>
			</ul>
		</form:form>
		<tags:message content="${message}"/>
		<input type="hidden" id="cNames"  value="${cNames}"/>
		<input type="hidden" id="lables"  value="${lables}"/>
		<input type="hidden" id="sellPrices" value="${sellPrices}"/>
		<div style="width: 100%">
			<input class="btn btn-primary" style="margin:0px 0px 5px 5px;width: 37px;font-size: 11px;padding: 1px 0px 0px 1px;height: 25px;" id="choose-all-btn" status="0" type="button" value="全选" onclick="return chooseAll();"/>
		</div>
		<table id="treeTable" class="table table-striped table-condensed table-bordered" >
			<tr>
				<th class="center123"> <input type="checkbox"  class="kty" value="" id="all"></th>
				<th class="center123">编号</th>
				<th class="center123">加料名字</th>
				<th class="center123">标签名字</th>
				<th class="center123">价格</th>
				<th class="center123">创建时间</th>
				<th class="center123 ">状态</th>
			</tr>


			<c:forEach items="${page.list}" var="productCharging" varStatus="status">
				<tr class="charging-tr">
					<td class="center123"><input type="checkbox" name="ktvs" class="kty chooseItem"  value="${productCharging.id}"></td>
					<td class="center123">${status.index+1}</td>
					<td class="center123 cName" style="">${productCharging.cName}</td>
					<td class="center123 lable">${productCharging.lable}</td>
					<td class="center123 sellPrice">￥${productCharging.sellPrice}</td>
					<td class="center123"><fmt:formatDate value="${productCharging.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/> </td>

					<td class="center123">
						<c:if test="${productCharging.status == 0}">不可用</c:if>
						<c:if test="${productCharging.status == 1}">可用</c:if>
					</td>

				</tr>
			</c:forEach>
		</table>
		<div class="pagination">${page}</div>

	</div>
</div>


<script type="text/javascript">
    var chooseIdArr ;	//加料id数组
    var cNameArr = new Array();	//加料名字数组
    var lableArr = new Array();	//标签名字数组
    var sellPriceArr = new Array();	//销售价数组
    var size = '${page.count}';//加料总数

    //初始化数据
    function init(){
        var chooseIds = $("#chooseIds").val();
        var cNames = $("#cNames").val();
        var lables = $("#lables").val();
        var sellPrices = $("#sellPrices").val();

        if(chooseIds == undefined || chooseIds == ""){
            chooseIdArr = new Array();
        }else{
            chooseIdArr = chooseIds.split(",");
        }

        if(cNames == undefined || cNames == ""){
            cNameArr = new Array();
        }else{
            cNameArr = cNames.split(",");
        }

        if(lables == undefined || lables == ""){
            lableArr = new Array();
        }else{
            lableArr = lables.split(",");
        }

        if(sellPrices == undefined || sellPrices == ""){
            sellPriceArr = new Array();
        }else{
            sellPriceArr = sellPrices.split(",");
        }

        var itemArr = $(".chooseItem");
        for(var i = 0 ; i < itemArr.length ; i++){
            if(chooseIds.indexOf($(itemArr[i]).val()) >= 0){
                $(itemArr[i]).attr("checked",true);
            }else{
                $(itemArr[i]).attr("checked",false);
            }
        }


    }

    $(function(){
        adTable();

        //单个元素点击的情况
        $(".chooseItem").click(function(){

            //选中的情况
            if($(this).attr("checked") == "checked"){
                //获得input父元素tr
                var parent = $(this).parents(".charging-tr");
                //初始化加料名、标签、销售价数组
                chooseIdArr.push($(this).val())
                cNameArr.push($(parent.find(".cName")).text());
                lableArr.push($(parent.find(".lable")).text());
                sellPriceArr.push($(parent.find(".sellPrice")).text().replace("￥",""));
            }else{

                var index = chooseIdArr.indexOf($(this).attr("value"));
                chooseIdArr.splice(index , 1);
                cNameArr.splice(index , 1);
                lableArr.splice(index , 1);
                sellPriceArr.splice(index , 1);
            }

            $("#cNames").val(cNameArr.toString())
            $("#lables").val(lableArr.toString())
            $("#sellPrices").val(sellPriceArr.toString())
            $("#chooseIds").val(chooseIdArr.toString());

            //检查全选按钮是否应该勾选
            adTable();
        })


        //点击全选多多选框
        $("#all").click(function(){

            //选中的情况
            if($(this).attr("checked") == "checked"){

                var trArr = $(".charging-tr");

                for(var i = 0 ; i < trArr.length ; i++){
                    if(chooseIdArr.indexOf($(trArr[i]).find(".chooseItem").attr("value")) < 0){
                        chooseIdArr.push($(trArr[i]).find(".chooseItem").attr("value"))
                        cNameArr.push($($(trArr[i]).find(".cName")).text());
                        lableArr.push($($(trArr[i]).find(".lable")).text());
                        sellPriceArr.push($(parent.find(".sellPrice")).text().replace("￥",""));
                    }
                }
            }else{
                var trArr = $(".charging-tr");

                for(var i = 0 ; i < trArr.length ; i++){
                    var index = chooseIdArr.indexOf($(trArr[i]).find(".chooseItem").attr("value"));
                    if(index >= 0){
                        chooseIdArr.splice(index,1);
                        cNameArr.splice(index,1);
                        lableArr.splice(index,1);
                        sellPriceArr.splice(index,1);
                    }
                }
            }

            $("#cNames").val(cNameArr.toString())
            $("#lables").val(lableArr.toString())
            $("#sellPrices").val(sellPriceArr.toString())
            $("#chooseIds").val(chooseIdArr.toString());

            adTable();
        })
    })

    /**
     * 一键所有
     */
    function chooseAll(){
        var status = $("#choose-all-btn").attr("status");  // 0 当前未选中，1 当前已经选中

        if(status == 1){
            $("#chooseIds").val("");
            $("#cNames").val("");
            $("#lables").val("");
            $("#sellPrices").val("");

            $("#all").attr("checked",false);
            adTable()
            $("#choose-all-btn").attr("status","0");

            return;
        }


        $.ajax({
            url:"${ctxsys}/EbProductCharging/chooseAll?productTypeId="+$("#productTypeId").val(),
            type:"POST",
            datatype:"json",
			data:$("#searchForm").serialize(),
            success:function (data) {
                $("#chooseIds").val(data.chooseIds);
                $("#cNames").val(data.cNames);
                $("#lables").val(data.lables);
                $("#sellPrices").val(data.sellPrices);

                $("#all").attr("checked",false);
                $("#choose-all-btn").attr("status","1");

                adTable();
            }
        })

    }


    /**
     * 控制俩种全选按钮的状态
     */
    function multipleBtnStatus(){
        if($(".chooseItem[type=checkbox]:checked").length == $(".chooseItem").length){
            $("#all").attr("checked",true);
        }else{
            $("#all").attr("checked",false);
        }

        if(chooseIdArr.length == size){
            $("#choose-all-btn").attr("status",1);
        }else{
            $("#choose-all-btn").attr("status",0);
        }
    }

    //把加料增加到左边
    function adTable() {
        init();

        var str = "";
        for (var i = 0; i < cNameArr.length; i++) {
            str += "<tr>\
							<td>" + cNameArr[i] + "</td>\
							 <td>￥" + sellPriceArr[i] + "</td>\
							 <td  onclick='removethis(\"" + chooseIdArr[i] + "\" )'>移除</td>\
							</tr>"
        }
        $(".tbody").html(str);


        multipleBtnStatus()
    }

    function removethis(id) {
        var index = chooseIdArr.indexOf(id);
        if (index >= 0) {
            chooseIdArr.splice(index,1);
            cNameArr.splice(index,1);
            lableArr.splice(index,1);
            sellPriceArr.splice(index,1);
        }

        $("#chooseIds").val(chooseIdArr.toString());
        $("#cNames").val(cNameArr.toString());
        $("#lables").val(lableArr.toString());
        $("#sellPrices").val(sellPriceArr.toString());

        adTable();
    }
</script>



</body>
</html>