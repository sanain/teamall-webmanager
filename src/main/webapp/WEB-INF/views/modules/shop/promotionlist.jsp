<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<jsp:useBean id="ebCertificate" class="com.jq.support.model.certificate.EbCertificate" scope="request"/>
<html>
<head>
    <title>促销活动</title>
    <meta name="decorator" content="default"/>

    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/build.css">
    <link href="${ctxStatic}/jquery-jbox/2.3/Skins/Default/jbox.css" type="text/css" rel="stylesheet"/>
    <script src="${ctxStatic}/jquery-jbox/2.3/jquery.jBox-2.3.js" type="text/javascript"></script>
    <script src="${ctxStatic}/sbShop/js/jquery.min.js"></script>
    <%--<link rel="stylesheet" href="${ctxStatic}/sbShop/css/bootstrap.min.css">--%>
    <script src="${ctxStatic}/bootstrap/2.3.1/js/bootstrap.min.js" type="text/javascript"></script>
    <link href="${ctxStatic}/supplyshop/layui/css/modules/layer/default/layer.css?v=1" type="text/css"
          rel="stylesheet"/>
    <script src="${ctxStatic}/supplyshop/layui/lay/modules/layer.js?v=1" type="text/javascript"></script>

    <style type="text/css">
        .table>tbody>tr>th{text-align:left;}
        .table-striped tbody tr td{font-size:13px;}
        .table-striped tbody>tr td:nth-child(1){width:10%;}
        .table-striped tbody>tr td:nth-child(2){width:7%;}
        .table-striped tbody>tr td:nth-child(12){width:5%;}
        .table-striped tbody>tr:nth-child(even)>td,.table-striped tbody>tr:nth-child(odd)>td{text-align:left;}
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
        .navleft ul li input{padding:0;text-indent:10px;}
        #certificateEndDate,#certificateStartDate{text-indent:10px;}
        .navleft ul{height:95%;}

    </style>
    <script>
        function updateEnabledSys(id,enableSys){

            var prompt = "确定把该活动设置成不可用？"
            if(enableSys == 0){
                prompt = "确定把该活动设置成可用？"
            }
            layer.confirm(prompt,{title:"设置提示"},function(){
                $.ajax({
                    url:'${ctxweb}/shop/product/updateEnabledSys',
                    type:"post",
                    data:{
                        id:id,
                        enableSys:enableSys,
                    },
                    success:function(date){
                        layer.msg(date.msg)
                        page();
                    },
                    error:function(){
                        layer.msg(date.msg)
                    }
                })
            })
        }

        function addPromotion(){
            $.ajax({
                type: "POST",
                url: "${ctxweb}/shop/product/addPromotion",
                data:{
                    certificateId:$("#certificateId").val(),
                    promotionType:$("#promotionType").val(),
                    type:$("#type").val(),
                    certificateName:$("#certificateName").val(),
                    provinceOutFullFreight:$("#provinceOutFullFreight").val(),
                    amount:$("#amount").val(),
                    banner:$("#banner").val(),
                    groupCertificateNum:$("#groupCertificateNum").val(),
                    groupNum:$("#groupNum").val(),
                    certificateStartDate:$("#certificateStartDate").val(),
                    remark:$("#remark").val(),
                    certificateEndDate:$("#certificateEndDate").val(),
                    productIds:$("#product-ids").val()
                },
                success: function(data){
                    alert(data.msg);
                    if(data.code=='00'){
                        window.location.href="${ctxweb}/shop/product/promotionlist";
                    }

                }
            });
        }

    </script>
    <script type="text/javascript">
        function page(n, s) {
            if (n) $("#pageNo").val(n);
            if (s) $("#pageSize").val(s);
            $("#searchForm").attr("action", "${ctxweb}/shop/product/promotionlist");
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
    <span>当前位置：</span><span>门店管理 - </span><span style="color:#009688;">促销活动信息</span>
</div>
<div style="margin:0 30px;background:#fff;">
    <ul class="nav nav-tabs">
        <li class="active"><a href="${ctxweb}/shop/product/promotionlist">促销活动信息</a></li>
        <li><a href="${ctxweb}/shop/product/addpromotion">促销活动添加</a></li>
    </ul>
    <c:if test="${not empty msg}">
        <script type="text/javascript">
            $(function () {
                $.jBox.success("${msg}", "信息提示");
            })
        </script>
    </c:if>
    <form id="searchForm" modelAttribute="ebCertificate" action="${ctxweb}/shop/product/promotionlist"
          method="post" class="form-search breadcrumb">
        <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
        <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
        <ul class="ul-form cerrtifcate">
            <li><label>促销活动名称:</label><input id="searchCertificateName" name="searchCertificateName" value="${searchCertificateName}" htmlEscape="false" maxlength="50" style="    width: 231px;
    border-width: 1px;
    border-style: solid;
    border-color: rgb(229, 229, 229);
    border-image: initial;
    border-radius: 2px;
    height: 30px;"
                                             class="input-medium" placeholder="请输入促销活动名称"/></li>
            <li><label>促销类型：</label>
                <select id="searchType" name="searchType" class="input-medium" style="    width: 231px;
    border-width: 1px;
    border-style: solid;
    border-color: rgb(229, 229, 229);
    border-image: initial;
    border-radius: 2px;
    height: 30px;">
                    <option value="">请选择</option>
                    <option value="3" <c:if test="${searchType==3}">selected</c:if>>折扣促销</option>
                    <option value="1" <c:if test="${searchType==1}">selected</c:if>>满减促销</option>
                    <option value="5" <c:if test="${searchType==5}">selected</c:if>>第二件打折</option>
                    <option value="5" <c:if test="${searchType==6}">selected</c:if>>团购促销</option>
                </select>
            </li>
            <li><label>审核状态：</label>
                <select id="applyStatus" name="searchApplyStatus" class="input-medium" style="    width: 231px;
    border-width: 1px;
    border-style: solid;
    border-color: rgb(229, 229, 229);
    border-image: initial;
    border-radius: 2px;
    height: 30px;">
                    <option value="">全部</option>
                    <option value="0" <c:if test="${not empty searchApplyStatus && searchApplyStatus==0}">selected</c:if>>未审核</option>
                    <option value="1" <c:if test="${not empty searchApplyStatus && searchApplyStatus==1}">selected</c:if>>审核通过</option>
                    <option value="2" <c:if test="${not empty searchApplyStatus &&searchApplyStatus==2}">selected</c:if>>审核不通过</option>
                    <option value="2" <c:if test="${not empty searchApplyStatus &&searchApplyStatus==3}">selected</c:if>>取消</option>
                </select>
            </li>
            <li><label>有效开始日期:</label>
                <input type="text" id="searchStartDate" name="searchStartDate" value="${searchStartDate}" htmlEscape="false" maxlength="50" style="width:217px;height: 30px;"
                       onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" placeholder="请输入有效开始日期" class="input-medium">
            <li><label>有效结束日期:</label>
                <input type="text" id="searchEndDate" name="searchEndDate" value="${searchEndDate}" htmlEscape="false" maxlength="50" style="width:217px;height: 30px;"
                       onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" placeholder="请输入有效开始日期" class="input-medium">

            <li style="margin-left:10px">
                <button type="submit" class="btn btn-primary"
                        style="display: inline-block;background: #393D49;color: #ffffff;height: 30px;line-height: 30px;padding: 0 15px;border-radius: 4px;">
                    查询
                </button>
            </li>
        </ul>
    </form>
    <table class="table table-striped table-condensed table-bordered">
        <tr>
            <th class="center123" width="170px">促销名称</th>
            <th class="center123" width="60px">促销类型</th>
            <th class="center123" width="60px">满减金额</th>
            <th class="center123" width="50px">金额/折扣</th>
            <th class="center123" width="60px"  style="display: none">产品类型适用范围</th>
            <th class="center123"  style="display: none">商品名称</th>
            <th class="center123" width="100px" style="display: none">商家范围</th>
            <!-- <th class="center123">商家id</th> -->
            <th class="center123" width="80px">开始日期</th>
            <th class="center123" width="80px">结束日期</th>
            <th class="center123" width="80px"  style="display: none">发起时间</th>
            <th class="center123" width="80px">申请时间</th>
            <th class="center123" width="80px">当前状态</th>
            <th class="center123" width="80px">状态</th>
            <th class="center123" width="80px">审核时间</th>
            <th class="center123" width="80px">审核状态</th>
            <th class="center123" style="display: none">促销活动备注</th>
            <th class="center123" width="80px">操作</th>
        </tr>
        <c:forEach items="${page.list}" var="ebCertificate" varStatus="status">
            <tr>
                <td class="center123">${ebCertificate.certificateName}</td>
                <td class="center123">
                    <c:choose>
                        <c:when test="${ebCertificate.type==1 }">满减促销</c:when>
                        <c:when test="${ebCertificate.type==3 }">折扣促销</c:when>
                        <c:when test="${ebCertificate.type==5 }">第二件打折</c:when>
                        <c:when test="${ebCertificate.type==6 }">团购活动</c:when>
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
                <td class="center123"  style="display: none"
                    ${ebCertificate.sendTime}
                </td>
                <td class="center123">${ebCertificate.createTime}</td>

                <td class="center123">
                        ${ebCertificate.available ? "有效":"无效"}
                </td>

                <td class="center123">
                        ${ebCertificate.enabledSys == 0  ? "可用":"不可用"}
                    <c:if test="${ebCertificate.shopId != null && ''.equals(ebCertificate.shopId)}">
                        <c:if test="${ebCertificate.isapply==1 && ebCertificate.applyStatus==1}">
                            <c:if test="${ebCertificate.enabledSys == 0}">
                                |<a href="javascript:;" style="color: #18AEA1" onclick="updateEnabledSys('${ebCertificate.certificateId}',1)">不可用</a>
                            </c:if>
                            <c:if test="${ebCertificate.enabledSys != 0}">
                                |<a href="javascript:;" style="color: #18AEA1" onclick="updateEnabledSys('${ebCertificate.certificateId}',0)">可用</a>
                            </c:if>
                        </c:if>
                    </c:if>
                </td>
                <td class="center123">${ebCertificate.applyTime}</td>
                <td>
                    <c:if test="${ebCertificate.isapply==1}">
                        <c:if test="${ebCertificate.applyStatus==1}">
                            <label style="color:#00aa00">审核通过</label>
                        </c:if>
                        <c:if test="${ebCertificate.applyStatus==2}">
                            <label style="color:#dd0000">审核不通过</label>
                        </c:if>
                    </c:if>
                    <c:if test="${ebCertificate.isapply==2 && ebCertificate.applyStatus==0}">
                        <label style="color:#0b2c89">等待审核</label>
                    </c:if>
                    <c:if test="${ebCertificate.applyStatus==3}">
                        <label style="color:#8B91A0">取消申请</label>
                    </c:if>
                </td>

                <td class="center123" style="display: none">${ebCertificate.remark}</td>
                <td class="center123">
                    <c:if test="${ebCertificate.isapply==2 && ebCertificate.applyStatus==0}">
                        <a style="color: #009688;" href="${ctxweb}/shop/product/update?certificateId=${ebCertificate.certificateId}&pageNo=${page.pageNo}&pageSize=${page.pageSize}" >取消申请</a> |
                    </c:if>
                        <%--<c:if test="${ebCertificate.applyStatus==2}">--%>
                        <%--<a data-toggle="modal" style="color: #009688;" data-target="#myModal" onclick="magss(${ebCertificate.certificateId})">审核信息</a> |--%>
                        <%--</c:if>--%>
                    <c:if test="${ebCertificate.applyStatus!=3}">
                        <label  style="color: #009688;" href="" class="navbtna"
                                certificateId="${ebCertificate.certificateId}"
                                type="${ebCertificate.type}"
                                promotionType="${ebCertificate.promotionType}"
                                certificateName="${ebCertificate.certificateName}"
                                provinceOutFullFreight="${ebCertificate.provinceOutFullFreight}"
                                amount="${ebCertificate.amount}"
                                banner="${ebCertificate.banner}"
                                certificateStartDate="${ebCertificate.certificateStartDate}"
                                certificateEndDate="${ebCertificate.certificateEndDate}"
                                isApply="${ebCertificate.isapply}"
                                productTypeId="${ebCertificate.productTypeId}"
                                productInfos="${ebCertificate.productInfos}"
                                shopInfos="${ebCertificate.shopInfos}"
                                shopTypeId="${ebCertificate.shopTypeId}"
                                groupCertificateNum="${ebCertificate.groupCertificateNum}"
                                groupNum="${ebCertificate.groupNum}"
                        >${!(ebCertificate.applyStatus==1 || ebCertificate.applyStatus==3) ? "修改":"查看"}</label>
                    </c:if>
                    <c:if test="${ebCertificate.isapply==1}">
                        <a href="javascript:;" onclick="getRemarkById('${ebCertificate.certificateId}')">回复</a>
                    </c:if>
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
<link rel="stylesheet" href="${ctxStatic}/sbShop/css/addpromotion.css?v=21">
<div class="navbar-right">
    <input type="hidden" id="certificateId"/>
    <div class="navleft">
        <ul style="background: #ffffff;">
            <li class="clearfix">
                <span class="left">促销类型：</span>
                <select class="right" name="promotionType" id="promotionType">
                    <option value="1" selected="selected">打折/满减</option>
                    <option value="2">第二件打折</option>
                    <option value="3">团购活动</option>
                </select>
            </li>
            <li class="clearfix promotionType-1">
                <span class="left">促销方式：</span>
                <select class="right" name="type" id="type">
                    <option value="3" selected="selected">折扣促销</option>
                    <option value="1">满减促销</option>
                </select>
            </li>
            <li class="clearfix">
                <span class="left">促销名称:</span>
                <input class="right" type="text" id="certificateName" style="height: 34px;"/>
            </li>
            <li class="clearfix">
                <span class="left">满减金额:</span>
                <input class="right" type="text" id="provinceOutFullFreight"  style="height: 34px;"/>
            </li>
            <li class="clearfix groupNum-1">
                <span class="left groupNum-span" style="margin-left: 0px;">满足团购商品数:</span>
                <input class="right" type="text" id="groupNum" oninput = "value=value.replace(/[^\d]/g,'')" style="height: 34px;"/>
            </li>
            <li class="clearfix groupCertificateNum-1">
                <span class="left groupCertificateNum-span" style="margin-left: 0px;">优惠商品数:</span>
                <input class="right" type="text" id="groupCertificateNum" oninput = "value=value.replace(/[^\d]/g,'')" style="height: 34px;"/>
            </li>
            <li class="clearfix">
                <span class="left amount-span">折扣:</span>
                <input class="right" type="text" id="amount" style="height: 34px;"/>
            </li>
            <%--<li class="clearfix">--%>
            <%--<span class="left">活动图片：</span>--%>
            <%--<span>建议文件格式GIF、JPG、JPEG、PNG文件大小1M以内，240x240</span>--%>
            <%--</li>--%>

            <%--<li class="clearfix">--%>
            <%--<span class="left"></span>--%>
            <%--<div class="file-div">--%>
            <%--<input type="hidden" name="banner" id="banner" value=""--%>
            <%--htmlEscape="false" maxlength="100" class="input-xlarge"/>--%>
            <%--<span class="help-inline" id="banner" style="color: blue;" maxHeight="20"></span>--%>
            <%--<tags:ckfinder input="banner" type="images" uploadPath="/shopImg"/>--%>
            <%--</div>--%>
            <%--</li>--%>
            <li class="clearfix">
                <span class="left">开始日期:</span>
                <input id="certificateStartDate" name="certificateStartDate" htmlEscape="false" maxlength="50" class="input-medium right"
                       placeholder="" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"
                       value=""  autocomplete="new-password" style="height: 34px;"/>
            </li>
            <li class="clearfix">
                <span class="left">结束日期:</span>
                <input id="certificateEndDate" name="certificateEndDate" htmlEscape="false" maxlength="50" class="input-medium right"
                       placeholder="" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"
                       value=""  autocomplete="new-password" style="height: 34px;"/>
            </li>

            <li class="clearfix" id="choose-product-li">
                <span class="left">选择商品:</span>
                <div style="width: 336px" class="right">
                    <input  type="button" style="float:left;background-color: #09c;width: 30%;color: white;text-indent:0;" value="选择" id="choose-product" onclick="chooseProduct()"/>
                </div>
            </li>

            <li class="clearfix" id="manage-product-li">
                <span class="left">已选择商品:</span>
                <div style="width: 336px" class="right">
                    <input class="right"  type="text" style="width: 80%;float: left" id="product-names" readonly onclick="openProductList()"/>
                    <input class="right" type="hidden" id="product-ids" />
                    <input class="right" style="float:right;background-color: #09c;width: 15%;color: white" id="clear-btn" type="button" value="清空" onclick="clearProduct()"/>
                </div>
            </li>

            <%--<li class="clearfix" style="" id="remark-li">--%>
            <%--<span class="left">回复:</span>--%>
            <%--&lt;%&ndash;<input class="right" type="text" id="remark" />&ndash;%&gt;--%>
            <%--<textarea cols="10" rows="5" id="remark" style="margin-left: 55px"></textarea>--%>
            <%--</li>--%>
        </ul>

        <div class="clearfix save-box">
            <button class="save" onclick="addPromotion()">修改申请</button>
            <button class="canel" style="margin-right:60px;">取消</button>
        </div>
    </div>
</div>

<!-- 已选择商品模态框（Modal） -->
<div class="modal fade" id="product-name-modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title" id="myModalLabel">
                    已选择商品
                </h4>
            </div>
            <div class="modal-body" id="choose-product-name-div" style="height:300px;overflow: auto">

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                </button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>


<!-- 审核回复信息模态框（Modal） -->
<div class="modal fade" id="remark-modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel2" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title" id="myModalLabel2">
                    审核回复信息
                </h4>
            </div>
            <div class="modal-body" id="remark-div" style="height:300px;overflow: auto">

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                </button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>

<script type="text/javascript">
    $(function() {
        $(".navbtna").click(function() {
            amountMethod();
            $("body").addClass("navbar-right-show");
            var certificateId=$(this).attr('certificateId');
            var type=$(this).attr('type');
            var promotionType=$(this).attr('promotionType');
            var certificateName=$(this).attr('certificateName');
            var provinceOutFullFreight=$(this).attr('provinceOutFullFreight');
            var amount=$(this).attr('amount');
            var banner=$(this).attr('banner');
            var certificateStartDate=$(this).attr('certificateStartDate');
            var certificateEndDate=$(this).attr('certificateEndDate');
            var productInfos=$(this).attr('productInfos');
            var productTypeId=$(this).attr('productTypeId');
            var applyStatus=$(this).attr('applyStatus');
            var groupNum=$(this).attr('groupNum');
            var groupCertificateNum=$(this).attr('groupCertificateNum');

            if(banner!=''){
                $("#bannerPreview").html("");
                $("#bannerPreview").html(
                    "<li><img src='"+banner+"' url='"+banner+"' style='max-width:200px;max-height:200px;_height:200px;border:0;padding:3px;'>&nbsp;&nbsp;<a href='javascript:' onclick='bannerDel(this);'>×</a></li>"
                );
            }else{
                $("#bannerPreview").html("<li style='list-style:none;padding-top:5px;'>无</li>");
            }

            $("#certificateId").val(certificateId);
            $("#type").val(type);
            $("#promotionType").val(promotionType);
            $("#certificateName").val(certificateName);
            $("#provinceOutFullFreight").val(provinceOutFullFreight);
            $("#amount").val(amount);
            $("#banner").val(banner);
            $("#groupNum").val(groupNum);
            $("#groupCertificateNum").val(groupCertificateNum);
            $("#certificateStartDate").val(certificateStartDate);
            $("#certificateEndDate").val(certificateEndDate);

            $("#product-names").val(productInfos);
            $("#product-ids").val(productTypeId);


            if(promotionType == 2){
                $(".promotionType-1").css("display","none")
                $(".groupCertificateNum-1").css("display","none");
                $(".groupNum-1").css("display","none");
                $(".amount-span").html("折扣:");
            }else if(promotionType == 1){
                $(".promotionType-1").css("display","block")
                $(".groupCertificateNum-1").css("display","none");
                $(".groupNum-1").css("display","none");
                if(type=='3'){
                    $(".amount-span").html("折扣:");
                }else if(type=='1'){
                    $(".amount-span").html("金额:");

                }
            }else if(promotionType == 3){
                $(".promotionType-1").css("display","none");
                $(".groupCertificateNum-1").css("display","block");
                $(".groupNum-1").css("display","none");
                $(".amount-span").html("促销价:");
            }


            if(applyStatus==1 || applyStatus==3){
                $(".navbar-right input").attr("readonly",true)
                $(".save").css("display","none");

                $("#choose-product-li").css("display","none")
                $(".navbar-right select").attr("disabled",true)
                $("#clear-btn").css("display")
            }else{
                $("#remark-li").css("display","none");
                $(".navbar-right input").attr("readonly",false)
                $(".save").css("display","inline-block");
                $("#choose-product-li").css("display","block")
                $(".navbar-right select").attr("disabled",false)
                $("#clear-btn").css("display")
            }

            $("#product-names").attr("readonly","readonly");
        })
        $(".canel").click(function() {
            $("body").removeClass("navbar-right-show");
        })
    })
    document.body.addEventListener('touchmove', function(e) {
        e.preventDefault();
    })
    $("body").on('change', "#promotionType", function(){
        amountMethod();
    })
    $("body").on('change', "#type", function(){
        amountMethod();

    })
    function amountMethod() {
        var promotionType=$("#promotionType").val();
        var type=$("#type").val();
        if(promotionType=='1'){
            $(".promotionType-1").css("display","block");
            if(type=='3'){
                $(".amount-span").html("折扣:");
            }else if(type=='1'){
                $(".amount-span").html("金额:");

            }
        }else if(promotionType=='2'){
            $(".promotionType-1").css("display","none");
            $(".amount-span").html("折扣:");

        }
    }

    function chooseProduct(){
        layer.open({
            type: 2,
            title: '商品列表',
            shadeClose: true,
            shade: false,
            scrollbar: false,
            maxmin: true, //开启最大化最小化按钮
            area: ['880px', '450px'],
            content: '${ctxweb}/shop/product/chooseProduct?productIds='+$("#product-ids").val(),
            btn: [ '确定','关闭'],
            yes: function(index, layero){ //或者使用btn1
                var chooseIds = layero.find("iframe")[0].contentWindow.$('#chooseIds').val();
                var productNames = layero.find("iframe")[0].contentWindow.$('#productNames').val();

                $("#product-ids").val(chooseIds)
                $("#product-names").val(productNames)
                layer.close(index);

            }
        })
    }

    function clearProduct(){
        $("#product-ids").val("")
        $("#product-names").val("")
    }

    function openProductList(){
        var index = 1;
        $("#product-name-modal").modal("show");
        if($("#product-names").val() != ""){

            var names = $("#product-names").val().split(",");
            $("#choose-product-name-div").empty();

            var table = "<table class='table table-striped'id='product-name-table'>"+
                "<tr>"+
                "<th >序号</th>"+
                "<th >商品名</th>"+
                "</tr>"

            for(var i = 0 ; i < names.length ; i++){
                var tr = "<tr>";
                tr += "<td>"+(index++)+"</td>"
                tr += "<td>"+names[i]+"</td>"
                tr += "</tr>"
                table += tr;
            }

            table+"</table>"

            $("#choose-product-name-div").html(table)
        }
    }


    function getRemarkById(id){
        $.ajax({
            url:"${ctxweb}/shop/product/getPromotionRemarkById",
            data:{
                applyId:id
            },
            success:function (result) {
                debugger;
                var index =1;
                $("#remark-modal").modal("show");
                $("#remark-div").empty();

                var table = "<table class='table table-striped' id='remark-table'>"+
                    "<tr>"+
                    "<th >序号</th>"+
                    "<th >回复信息</th>"+
                    "<th >时间</th>"+
                    "</tr>"

                if(result.code == '01') {

                    for (var i = 0; i < result.data.length; i++) {
                        var tr = "<tr>";
                        tr += "<td>" + (index++) + "</td>"
                        tr += "<td>" + result.data[i].applyRemark + "</td>"
                        tr += "<td>" + result.data[i].createTime + "</td>"
                        tr += "</tr>"
                        table += tr;
                    }
                }else{
                    table += "<tr><td colspan='3' style='text-align: center'>暂无数据</td></tr>";
                }
                table+"</table>"

                $("#remark-div").html(table)
            },error:function(){
                layer.msg("查询回复错误")
            }
        })
        // $("#remark-modal").modal("show");
        // if($("#product-names").val() != ""){
        //
        //     var names = $("#product-names").val().split(",");
        //
        // }
    }
</script>
</body>

</html>