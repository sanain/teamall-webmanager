<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>加料申请详情</title>
    <link rel="stylesheet" href="${ctxStatic}/commodity/css/commodity-overview.css">
    <link rel="stylesheet" href="${ctxStatic}/commodity/css/bootstrap.min.css">
    <link rel="stylesheet" href="${ctxStatic}/commodity/css/MxSlider.css">
    <script src="${ctxStatic}/commodity/js/jquery.min.js"></script>
    <script src="${ctxStatic}/bootstrap/2.3.1/js/bootstrap.js"></script>
    <script src="${ctxStatic}/commodity/js/MxSlider.js"></script>
    <script src="${ctxStatic}/commodity/js/base_form.js"></script>
    <script src="${ctxStatic}/commodity/js/commodity-overview.js"></script>
    <link href="${ctxStatic}/supplyshop/layui/css/modules/layer/default/layer.css?v=1" type="text/css" rel="stylesheet" />
    <script src="${ctxStatic}/supplyshop/layui/lay/modules/layer.js?v=1" type="text/javascript"></script>

    <style type="text/css">
        .right-box2 ul li{
            width: 24%;
        }
        .form-group label{
            height: 32px;
            line-height: 32px;
            text-align: right;
        }


    </style>
    <style>
        .mySlider-bottom{clear:both;}
        .mySlider-bottom p{margin-bottom:0;}
    </style>
</head>
<body>

<div class="c-context">
    <ul class="nav-ul">
        <li><a class="active" href="${ctxsys}/ebProductChargingApply/toCheckApply?applyId=${apply.id}">申请详情</a></li>
    </ul>
    <div class="context-box">
        <div class="overview-left" style="background: #fff;padding: 10px 20px">
            <div class="form-group" style="z-index: 1;">
                <label for="apply-name">申请名称</label>
                <input type="text"  value="${apply.applyName}" class="form-control"
                <c:if test="${apply.isApply ==1}">
                       readonly="readonly"
                </c:if>
                       id="apply-name" onchange="this.value=this.value.substring(0, 50)" onkeydown="this.value=this.value.substring(0, 50)" onkeyup="this.value=this.value.substring(0, 50)">
            </div>

            <div class="form-group" style="z-index: 1;">
                <label for="apply-remark">申请理由</label>
                <textarea class="form-control"
                <c:if test="${apply.isApply ==1}">
                          readonly="readonly"
                </c:if>
                          rows="5" id="apply-remark" onchange="this.value=this.value.substring(0, 200)" onkeydown="this.value=this.value.substring(0, 200)" onkeyup="this.value=this.value.substring(0, 200)">${apply.applyRemark}</textarea>
            </div>


            <c:if test="${apply.isApply ==1}">
                <div class="form-group" style="z-index: 1;">
                    <label for="apply-remark">回复</label>
                    <textarea class="form-control" rows="5" id="remark" readonly="readonly" onchange="this.value=this.value.substring(0, 200)" onkeydown="this.value=this.value.substring(0, 200)" onkeyup="this.value=this.value.substring(0, 200)">${remarkList[0].remark}</textarea>
                </div>
            </c:if>
        </div>
        <div class="overview-right">
            <div class="overview-right-box">
                <ul class="right-box1">
                    <li>
                        <span>申请加料列表：</span>
                    </li>
                </ul>

                <div class="right-box2">
                    <ul class="list-top">
                        <li style="display: none"></li>
                        <li>加料名称</li>
                        <li>销售价</li>
                        <li>新的销售价</li>
                    </ul>
                    <div class="list-body">
                        <c:forEach items="${itemList}" var="item" varStatus="status">
                            <ul class="detail-ul">
                                <li class="item-id-li" style="display: none">${item.id}</li>
                                <li>${item.chargingName}</li>
                                <li>${item.oldPrice}</li>
                                <li>
                                    <input type="number"
                                    <c:if test="${apply.isApply ==1}">
                                           readonly="readonly"
                                    </c:if>
                                           class="new-price-input" value="${item.newPrice}" style="width: 100%;border-radius: 5px;height: 35px;" >
                                </li>
                            </ul>
                        </c:forEach>
                    </div>
                </div>

                <div class="right-box2" style="margin-top: 50px">

                    <c:if test="${apply.isApply ==0}">
                        <ul class="list-body control-btn-list">
                            <li><a href="javascript:;" style="background:#393D49;border:1px solid #69AC72" onclick="updateApply()" class="btn btn-primary">提交</a></li>
                        </ul>
                    </c:if>
                </div>
            </div>
        </div>
    </div>

    <script type="text/javascript">

    </script>
</div>
    <script type="text/javascript">
        function updateApply(){
            var itemIdArr = new Array();
            var newPriceArr = new Array();
            var itemIdLiArr = $(".item-id-li");
            var newPriceInput = $(".new-price-input");

            for(var i = 0 ; i < itemIdLiArr.length ; i++){
                itemIdArr.push($(itemIdLiArr[i]).text().trim());
                newPriceArr.push($(newPriceInput[i]).val().trim());
            }

            $.ajax({
                type:"POST",
                url:"${ctxweb}/shop/ebProductChargingApply/updateApply",
                data:{
                    "id":"${apply.id}",
                    "itemIdArr":itemIdArr,
                    "newPriceArr":newPriceArr,
                    "applyName":$("#apply-name").val().trim(),
                    "applyRemark":$("#apply-remark").val().trim()
                },
                datatype:"json",
                traditional:true,	//这里
                success:function(data){
                    layer.msg(data.prompt);
                },error:function(){
                    layer.msg(data.prompt);
                }
            })
        }
    </script>

</body>
</html>