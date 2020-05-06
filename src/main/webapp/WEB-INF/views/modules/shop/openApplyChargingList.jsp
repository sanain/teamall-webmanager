<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>申请单</title>
    <link rel="stylesheet" href="${ctxStatic}/commodity/css/commodity-overview.css">
    <link rel="stylesheet" href="${ctxStatic}/commodity/css/bootstrap.min.css">
    <link rel="stylesheet" href="${ctxStatic}/commodity/css/MxSlider.css">
    <script src="${ctxStatic}/commodity/js/jquery.min.js"></script>
    <script src="${ctxStatic}/bootstrap/2.3.1/js/bootstrap.js"></script>
    <script src="${ctxStatic}/commodity/js/MxSlider.js"></script>
    <script src="${ctxStatic}/commodity/js/base_form.js"></script>
    <script src="${ctxStatic}/commodity/js/commodity-overview.js"></script>
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
    <div class="context-box">
        <div class="overview-left" style="background: #fff;padding: 10px 20px">
            <div class="form-group" style="z-index: 1;">
                <label for="apply-name">申请名称</label>
                <input type="text" class="form-control" id="apply-name" onchange="this.value=this.value.substring(0, 50)" onkeydown="this.value=this.value.substring(0, 50)" onkeyup="this.value=this.value.substring(0, 50)">
            </div>


            <div class="form-group" style="z-index: 1;">
                <label for="apply-remark">申请理由</label>
                <textarea class="form-control" rows="5" id="apply-remark" onchange="this.value=this.value.substring(0, 200)" onkeydown="this.value=this.value.substring(0, 200)" onkeyup="this.value=this.value.substring(0, 200)"></textarea>
            </div>


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
                            <li>分类</li>
                            <li>销售价</li>
                            <li>新的销售价</li>
                        </ul>
                        <div class="list-body">
                            <c:forEach items="${chargingList}" var="charging" varStatus="status">
                                <ul class="detail-ul">
                                    <li class="charging-id-li" style="display: none">${charging.id}</li>
                                    <li>${charging.cName}</li>
                                    <li>${charging.productTypeStr}</li>
                                    <li>${shopChargingList[status.index].sellPrice}</li>
                                    <li>
                                        <input type="number" class="new-price-input" value="${shopChargingList[status.index].sellPrice}" style="width: 100%;border-radius: 5px;height: 35px;" >
                                    </li>
                                </ul>
                            </c:forEach>
                        </div>
                    </div>

            </div>
        </div>
    </div>
</div>


</body>
</html>