<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>加料列表</title>
    <meta name="decorator" content="default"/>
    <link rel="stylesheet" href="${ctxStatic}/h5/css/timePicker.css">
    <script src="${ctxStatic}/jquery/jquery-1.9.1.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="${ctxStatic}/h5/js/jquery-timepicker.js"></script>
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/bootstrap.min.css">
    <script src="${ctxStatic}/sbShop/js/jquery.min.js"></script>
    <script src="${ctxStatic}/bootstrap/2.3.1/js/bootstrap.min.js"></script>
    <link href="${ctxStatic}/supplyshop/layui/css/modules/layer/default/layer.css?v=1" type="text/css" rel="stylesheet" />
    <script src="${ctxStatic}/supplyshop/layui/lay/modules/layer.js?v=1" type="text/javascript"></script>
    <script type="text/javascript">
        function page(n,s){
            $("#pageNo").val(n);
            $("#pageSize").val(s);
            $("#searchForm").attr("action","${ctxweb}/shop/ebShopCharging?productTypeId=${ebProductCharging.productTypeId}");

            $("#searchForm").submit();
            return false;
        }


    </script>



    <style>
        .list-ul{
            width: 42%;
            float: left;
            list-style: none;
            padding: 0;
            border: 1px solid #69AC72;
            box-sizing: border-box;
            margin:30px;
        }
        .list-ul li:nth-child(1){padding-left: 20px}
        .list-ul li:nth-child(2){padding-left: 20px}
        .list-ul li:nth-child(3) img{width: 100%}
    </style>

    <link rel="stylesheet" href="${ctxStatic}/layui/css/layui.css"  media="all">
    <script src="${ctxStatic}/layui/layui.js" charset="utf-8"></script>

    <script>
        layui.use('laydate', function(){
            var laydate = layui.laydate;

            //日期时间选择器
            laydate.render({
                elem: '#startTime'
                ,type: 'datetime'
            });

            //日期时间选择器
            laydate.render({
                elem: '#endTime'
                ,type: 'datetime'
            });
        });
    </script>
</head>
<body>
    <ul class="nav nav-tabs">
        <li class="active"><a style="color: #009688; "href="${ctxweb}/shop/ebShopCharging?productTypeId=${pmProductType.id}">${pmProductType.productTypeName}加料列表</a></li>
        <c:if test="${available}">
            <li><a style="color: #009688;" href="${ctxweb}/shop/ebShopCharging/form?typeId=${ebProductCharging.productTypeId}">增加加料</a></li>
        </c:if>
    </ul>
    <form:form id="searchForm" modelAttribute="ebProductCharging" action="${ctxsys}/EbProductCharging" method="post" class="breadcrumb form-search ">
        <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
        <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
        <input id="chargingIds" name="chargingIds" type="hidden" value="${chargingIds}" />
        <input id="productTypeId" name="productTypeId" type="hidden" value="${ebProductCharging.productTypeId}" />
        <tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
        <ul class="ul-form">
            <li><label>加料名字:</label><form:input path="cName" cssStyle="height: 30px" htmlEscape="false" maxlength="80" class="input-medium"  placeholder="请输入加料名称"/></li>

            <li><label></label><input id="btnSubmit" class="btn btn-primary" type="submit" style="background: #393D49;margin-left: -50px" value="查询" onclick="return page();"/></li>
            <li style="float: right;"><label></label><input id="clear-apply" class="btn btn-primary" type="button" style="background: #393D49;margin-right: 50px;" value="清空" onclick="clearApply();"/></li>
            <li style="float: right;margin-right: -60px"><label></label><input id="opend-apply" class="btn btn-primary" type="button" style="background: #393D49;" value="申请单" onclick="openApplyChargingList()"/></li>

        </ul>
    </form:form>
    <tags:message content="${message}"/>

    <table id="treeTable" class="table table-striped table-condensed table-bordered" >
        <tr>
            <th class="center123">加料名字</th>
            <th class="center123">所属分类</th>
            <th class="center123">销售价</th>
            <th class="center123">来源</th>
            <th class="center123">使用状态</th>
            <th class="center123 ">状态</th>
            <th class="center123 ">创建时间</th>
            <th class="center123 ">成本</th>
            <th class="center123">操作</th>
        </tr>
        <c:forEach items="${ebProductChargingList}" var="productCharging" varStatus="status">
            <tr>
                <td class="center123" style="color:#18AEA1;cursor: pointer">${productCharging.cName}</td>
                <td class="center123">${productCharging.productTypeStr}</td>
                <td class="center123">￥${ebShopChargingList[status.index].sellPrice}</td>
                <td class="center123">
                        ${productCharging.shopName != null && !''.equals(productCharging.shopName) ? productCharging.shopName : '平台'}
                </td>
                <td class="center123">
                    <c:if test="${productCharging.isPublic == 0 || productCharging.isPublic == null}">
                        平台使用
                    </c:if>
                    <c:if test="${productCharging.isPublic == 1}">
                        商家使用
                    </c:if>
                    <c:if test="${productCharging.isPublic == 2}">
                        平台和商家共用
                    </c:if>
                </td>
                <td class="center123">
                    <c:if test="${productCharging.status == 0}">不可用</c:if>
                    <c:if test="${productCharging.status == 1}">可用</c:if>
                </td>
                <td class="center123"><fmt:formatDate value="${productCharging.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/> </td>
                <td class="center123">
                    <span class="cost-span">${ebShopChargingList[status.index].cost}</span>
                    <input type="number"  style="margin:0px;display: none;width: 50px" class="cost-input" value="${ebShopChargingList[status.index].cost}">
                    <input type="hidden" style="display: none" class="shop-charging-id" value="${ebShopChargingList[status.index].id}">
                </td>
                <td class="center123">
                    <a href="javascript:;" class="add-to-apply" value="${productCharging.id}" onclick="addToApply('${productCharging.id}',this)">加入申请单</a>
                    <a href="javascript:;" class="remove-from-apply"  value="${productCharging.id}" onclick="removeFromApply('${productCharging.id}',this)">移出申请单</a>
                    <a href="javascript:;" class="update-btn" onclick="startUpdateCost(this)">修改成本</a>
                    <a href="javascript:;" style="display: none" class="submit-btn"  onclick="submitUpdateCost(this)">确定</a>
                    <c:if test="${productCharging.shopId == shopId}">
                        <a href="${ctxweb}/shop/ebShopCharging/form?typeId=${ebProductCharging.productTypeId}&id=${productCharging.id}">修改</a>
                    </c:if>

                </td>
            </tr>
        </c:forEach>
    </table>


    <div id="outerdiv" style="position:fixed;top:0;left:0;background:rgba(0,0,0,0.7);z-index:2;width:100%;height:100%;display:none;">
        <div id="innerdiv" style="position:absolute;">
            <img id="bigimg" style="border:5px solid #fff;" src="" />
        </div>
    </div>

    <div class="pagination">${page}</div>
    <script type="text/javascript">
        var chargingIdArr = new Array();
        $(function(){
            if($("#chargingIds").val().trim().length > 0){
                chargingIdArr = $("#chargingIds").val().trim().split(",");
            }

            var addToApplyArr =  $(".add-to-apply");
            var removeFromApplyArr =  $(".remove-from-apply");

            for(var i = 0 ; i < addToApplyArr.length ; i++){
                //已经选中
                if(chargingIdArr.indexOf($(addToApplyArr[i]).attr("value")) < 0){
                    $(removeFromApplyArr[i]).css("display","none");
                }else{
                    $(addToApplyArr[i]).css("display","none");
                }
            }
        })

        //添加到申请单
        function addToApply(chargingId,element){
            chargingIdArr.push(chargingId);
            $(element).parents("td").find(".add-to-apply").css("display","none");
            $(element).parents("td").find(".remove-from-apply").css("display","inline-block");
            $("#chargingIds").val(chargingIdArr.toString())
        }

        //从申请单移除
        function removeFromApply(chargingId,element){
            if(chargingIdArr.indexOf(chargingId) >= 0){
                $(element).parents("td").find(".remove-from-apply").css("display","none");
                $(element).parents("td").find(".add-to-apply").css("display","inline-block");
                chargingIdArr.splice(chargingIdArr.indexOf(chargingId),1)
                $("#chargingIds").val(chargingIdArr.toString())
            }
        }

        /**
         * 打开申请单
         */
        function openApplyChargingList(){
            layer.open({
                type: 2,
                title: '加料申请',
                shadeClose: true,
                shade: false,
                maxmin: true, //开启最大化最小化按钮
                area: ['1000px', '450px'],
                content: '${ctxweb}/shop/ebProductChargingApply/openApplyChargingList?chargingIds='+$("#chargingIds").val().trim(),
                btn: ['确定', '关闭'],
                yes: function(index, layero){ //或者使用btn1
                    var chargingIdLiArr = layero.find("iframe")[0].contentWindow.$('.charging-id-li');
                    var newPriceInputArr = layero.find("iframe")[0].contentWindow.$('.new-price-input');
                    var applyName = layero.find("iframe")[0].contentWindow.$('#apply-name').val().trim();
                    var applyRemark = layero.find("iframe")[0].contentWindow.$('#apply-remark').val().trim();

                    var chargingIdArr = new Array();
                    var newPriceArr = new Array();

                    if(chargingIdLiArr.length == 0){
                        layer.msg("你未选中任意的加料");
                        return ;
                    }

                    if(applyName.toString().length == 0){
                        layer.msg("申请名称不能为空");
                    }


                    for(var i = 0 ; i < chargingIdLiArr.length ; i++){
                        chargingIdArr.push($(chargingIdLiArr[i]).text().trim())
                        newPriceArr.push($(newPriceInputArr[i]).val().trim())
                    }

                    layer.confirm("确定提交订单？",function(){
                        layer.close(index);
                        $.ajax({
                            url:"${ctxweb}/shop/ebProductChargingApply/insertApply",
                            data:{
                                "chargingIdArr":chargingIdArr,
                                "newPriceArr":newPriceArr,
                                "applyName":applyName,
                                "applyRemark":applyRemark
                            },
                            type:"POST",
                            datatype:"json",
                            traditional:true,
                            success:function(data){
                                layer.msg(data.prompt);
                                clearApply();
                            },
                            error:function(){
                                layer.msg(data.prompt);
                            }

                        })
                    })

                }
            });
        }


        /**
         * 清空申请单
         */
        function clearApply(){
            $("#chargingIds").val("");
            $(".remove-from-apply").css("display","none");
            $(".add-to-apply").css("display","inline-block");
        }
    </script>
    <script type="text/javascript">
        function startUpdateCost(element){
            var parent = $(element).parents("tr");
            var costInput = parent.find(".cost-input");
            var costSpan = parent.find(".cost-span");
            var updateBtn = parent.find(".update-btn");
            var submitBtn = parent.find(".submit-btn");


            costInput.val(costSpan.text().trim());
            submitBtn.css("display","inline-block")
            costInput.css("display","inline-block")
            costSpan.css("display","none")
            updateBtn.css("display","none")


        }


        function submitUpdateCost(element){
            var parent = $(element).parents("tr");
            var costInput = parent.find(".cost-input");
            var costSpan = parent.find(".cost-span");
            var updateBtn = parent.find(".update-btn");
            var submitBtn = parent.find(".submit-btn");
            var shopChargingId = parent.find(".shop-charging-id");

            $.ajax({
                url:"${ctxweb}/shop/ebShopCharging/updateCost",
                data:{
                    "cost":costInput.val(),
                    "id":shopChargingId.val(),
                },
                datatype: "json",
                success:function(data){
                    if(data.code=="1"){
                        costSpan.text(costInput.val().trim());
                        updateBtn.css("display","inline-block")
                        costSpan.css("display","inline-block")
                        costInput.css("display","none")
                        submitBtn.css("display","none")
                    }else{
                        alert("修改失败")
                    }
                },error: function(){
                    alert("修改失败！");
                }
            });
        }
    </script>
</body>

</html>