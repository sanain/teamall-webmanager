<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<jsp:useBean id="ebCertificate" class="com.jq.support.model.certificate.EbCertificate" scope="request"/>
<html>
<head>
    <title>优惠券添加</title>
    <meta name="decorator" content="default"/>
    <link href="${ctxStatic}/jquery-jbox/2.3/Skins/Default/jbox.css?v=1" type="text/css" rel="stylesheet"/>
    <script src="${ctxStatic}/jquery-jbox/2.3/jquery.jBox-2.3.js?v=1" type="text/javascript"></script>
    <link href="${ctxStatic}/supplyshop/layui/css/modules/layer/default/layer.css?v=1" type="text/css"
          rel="stylesheet"/>
    <script src="${ctxStatic}/supplyshop/layui/lay/modules/layer.js?v=1" type="text/javascript"></script>
    <script type="text/javascript">
        $(function () {
            $("#btnSubmit").click(function () {
                debugger;
                if ($("#certificateName").val() == "") {
                    $.jBox.error("请输入优惠券名称");
                    return false;
                }
                if ($("#type").val() == "") {
                    $.jBox.error("请选择类型");
                    return false;
                }
                if ($("#type").val() != "3") {
                    if ($("#provinceOutFullFreight").val() == "") {
                        $.jBox.error("请输入满减金额");
                        return false;
                    }
                }
                if ($("#amount").val() == "") {
                    $.jBox.error("请输入金额/折扣");
                    return false;
                }


                if ($("#productType").val() == "") {
                    $.jBox.error("请选择产品类型适用范围");
                    return false;
                }
                if ($("#certificateStartDate").val() == "") {
                    $.jBox.error("请输入有效开始日期");
                    return false;
                }
                if ($("#certificateEndDate").val() == "") {
                    $.jBox.error("请输入有效结束日期");
                    return false;
                }

                if ($("#sendtime").val() == "") {
                    $.jBox.error("请输入发起时间");
                    return false;
                }
                if ($('input[name=enabledSys]:checked').val() == "1") {
                    if ($("#enabledSysRemark").val().trim().length == 0) {
                        $.jBox.error("禁用原因不能为空");
                        return false;
                    }

                }
                var cid = $("#menuId").val();
                if (cid != "") {
                    cid = cid.substring(0, cid.length - 1);
                    $("#productTypeId").val(cid);
                }

                $("#searchForm").submit();

            });


        });

        function enablesyss() {
            var enabled = $('input[name=enabledSys]:checked').val();
            if (enabled == "0") {
                $("#enabledSysRemark").val("");
                $("#enabledReason").css("display", "none");
            }
            if (enabled == "1") {
                $("#enabledReason").css("display", "block");
            }
        }

        function shopcheckScope() {
            if ($("#productType").val() == "1") {
                layer.open({
                    type: 2,
                    title: '商品列表',
                    shadeClose: true,
                    shade: false,
                    maxmin: true, //开启最大化最小化按钮
                    area: ['880px', '450px'],
                    content: '${ctxweb}/shop/product/shopchooseProducts?chooseIds='+$("#productTypeId").val(),
                    btn: ['确定', '关闭'],
                    yes: function (index, layero) { //或者使用btn1
                        content = layero.find("iframe")[0].contentWindow.$('#chooseIds').val();
                        if (content == "") {
                            layer.msg("请先选中一行");
                            $("#productTypeId").val(content);
                        } else {
                            $("#productTypeId").val(content);
                            layer.close(index);
                        }

                    }
                });
                $("#cids").css("display", "none");
            }
            if ($("#productType").val() == "2") {
                $("#cids").css("display", "block");
                $("#productTypeId").val("");
                $("#porcId").css("display", "none");
            } else {
                $("#cids").css("display", "none");
                $("#productTypeId").val("");
            }


        }
    </script>
    <script type="text/javascript">
        $(function(){
            $('#productTypeId').click(function(){
                shopcheckScope();
            });
        })
    </script>
    <script type="text/javascript">
        $(function(){
            var flag = '${flag}';
            if(flag == "edit"){
                //把input设置成不可用
                var inputArr = $("input");
                for(var i = 0 ; i < inputArr.length ; i++){
                    if($(inputArr[i]).attr("name") == "enabledSys"){
                        continue;
                    }

                    if($(inputArr[i]).attr("name") == "certificateStartDate" || $(inputArr[i]).attr("name") == "certificateEndDate" ||
                        $(inputArr[i]).attr("name") == "sendTime" ){

                        $(inputArr[i]).attr("disabled","disabled")
                    }

                    $(inputArr[i]).attr("readonly","readonly")
                }

                //select设置成不可用
                var selectArr = $("select");
                for(var i = 0 ; i < inputArr.length ; i++){
                    //设置成可点击，但是不会变化
                    $(selectArr[i]).attr({"onfocus":"this.defaultIndex=this.selectedIndex","onchange":"this.selectedIndex=this.defaultIndex"})
                    $(selectArr[i]).attr({"readonly":"readonly"})
                }

                //textarea设置成不可用
                var textareaArr = $("textarea");
                for(var i = 0 ; i < inputArr.length ; i++){
                    if($(textareaArr[i]).attr("name")=="remark") {
                        $(textareaArr[i]).attr("readonly", "readonly")
                    }
                }
            }


        })
    </script>
    <style type="text/css">
    .form-horizontal{margin:0;}
        a{
            color:#009688;
        }
        a:hover{
            color:#009688;
        }

        #btnSubmit{
            background: #393D49;
        }
           body{background:#f5f5f5;}
    #searchForm{background:#fff;}
    .nav-tabs>.active>a{border-top:3px solid #009688;color:#009688;}
      .nav-tabs>li>a{color:#000;}
      .pagination{padding-bottom:25px;}
    </style>
</head>
<body style="height: 100%">
<c:if test="${not empty msg }">
    <script type="text/javascript">
        $(function () {
            $.jBox.success("${msg}", "信息提示");
            if ("${type}" == "edit") {
                setTimeout(function () {
                    location.href = "${ctxweb}/shop/product/shopCertificatelist";
                }, 500);
            }
        })
    </script>
</c:if>
<input type="hidden" id="flag" value="${flag}"/>

	<div style="color:#999;padding:19px 0 17px 30px;background:#f5f5f5;">
		<span>当前位置：</span><span>门店管理 - </span><span style="color:#009688;">优惠券添加</span>
	</div>
		<div style="margin:0 30px;background:#fff;">
	<ul class="nav nav-tabs">
    <li><a href="${ctxweb}/shop/product/shopCertificatelist">优惠券信息</a></li>
      <li class="active"><a href="javascript:;">优惠券${flag=='edit'?'修改':'添加'}</a></li>
</ul>
<br/>
<form:form id="searchForm" modelAttribute="ebCertificate" action="${ctxweb}/shop/product/addcertificateJson" method="post"
           class="form-horizontal">
    <div class="control-group" >
        <label class="control-label">优惠券名称:</label>
        <div class="controls" >
            <form:input path="certificateName" htmlEscape="false"  maxlength="50" class="input-medium"
                        placeholder="请输入优惠券名称"  style="width:217px;"/>
        </div>
    </div>
    <form:hidden path="certificateId" value="${ebCertificate.certificateId}"/>
    <div class="control-group">
        <label class="control-label">类型:</label>
        <div class="controls">
            <form:select path="type" class="input-medium"  style="width:230px;">
                <form:option value="">请选择</form:option>
                <form:option value="1">满减券</form:option>
                <form:option value="2">现金券</form:option>
                <form:option value="3">折扣券</form:option>
            </form:select>
        </div>
    </div>
    <div class="control-group" id="manjian">
        <label class="control-label">满减金额:</label>
        <div class="controls">
            <form:input path="provinceOutFullFreight" htmlEscape="false" maxlength="50" class="input-medium"
                      style="width:217px;"   placeholder="请输入满减金额" onkeyup="value=value.replace(/[^\d{1,}\.\d{1,}|\d{1,}]/g,'')"/>
        </div>
    </div>

    <div class="control-group">
        <label class="control-label">金额/折扣:</label>
        <div class="controls">
            <form:input path="amount" htmlEscape="false" maxlength="50" class="input-medium" placeholder="请输入金额/折扣"
                      style="width:217px;"   onkeyup="value=value.replace(/[^\d{1,}\.\d{1,}|\d{1,}]/g,'')"/>
            <b>(当类型为满减卷或现金卷时、输入可以抵扣的金额，当类型为折扣卷时按十分之几算)</b>
        </div>
    </div>
    <div class="control-group" style="display:none;">
        <label class="control-label">产品类型适用范围:</label>
        <div class="controls">
            <form:select path="productType" class="input-medium" onchange="shopcheckScope()"  style="width:230px;">
                <form:option value="3">所有商品</form:option>
                <form:option value="">请选择</form:option>
                <form:option value="1">指定商品</form:option>
                <%--     <form:option value="2">指定类别</form:option> --%>

            </form:select>
        </div>
    </div>

    <div class="control-group" id="cids" style="display:none;">
        <label class="control-label">选择类别:</label>
        <div class="controls">
            <tags:treeselect id="menu" name="cid" value="${sbProductType.id}" labelName="productTypeStr"
                             labelValue="${sbProductType.productTypeStr}" title="菜单"
                             url="${ctxweb}/shop/product/category/treeData" extId="${sbProductType.id}"
                             cssClass="required input-medium" allowClear="true"/>
        </div>
    </div>


    <div class="control-group" id="porcId"  style="display: none">
        <label class="control-label">商品ID:</label>
        <div class="controls">
            <form:input path="productTypeId" htmlEscape="false" maxlength="50" class="input-medium"
                        placeholder="请输入商品/类别ID" readonly="readonly"  style="width:217px;"/>
            <b>(当产品类型适用范围是指定商品/指定类别时，输入的id以,隔开)</b>
        </div>
    </div>

    <div class="control-group">
        <label class="control-label">商家范围:</label>
        <div class="controls">
            <form:select path="shopType" class="input-medium"  style="width:230px;">
                <form:option value="1">${pmShopInfo.shopName}</form:option>
                <%--    <form:option value="2">所有商家</form:option> --%>
            </form:select>
            <form:hidden path="shopTypeId" value="1"/>

        </div>
    </div>
    <%-- <div class="control-group">
        <label class="control-label">商家ID:</label>
        <div class="controls">
     <form:input path="shopTypeId" htmlEscape="false" maxlength="50" class="input-medium"   placeholder="请输入商家ID"/>
        </div>
    </div> --%>
    <div class="control-group">
        <label class="control-label">有效开始日期:</label>
        <div class="controls">
            <form:input path="certificateStartDate" htmlEscape="false" maxlength="50" class="input-medium"
                        placeholder="请输入有效开始日期" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"
                        value="${ebCertificate.certificateStartDate}"  style="width:217px;"/>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">有效结束日期:</label>
        <div class="controls">
            <form:input path="certificateEndDate" htmlEscape="false" maxlength="50" class="input-medium"
                        placeholder="请输入有效结束日期"
                        onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"
                        value="${ebCertificate.certificateEndDate}"  style="width:217px;"/>

        </div>
    </div>
    <div class="control-group">
        <label class="control-label">发起时间:</label>
        <div class="controls">
            <form:input path="sendTime" htmlEscape="false" maxlength="50" class="input-medium" placeholder="请输入发起时间"
                        onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" value="${ebCertificate.sendTime}"  style="width:217px;"/>
        </div>
    </div>

    <div class="control-group">
        <label class="control-label">优惠券备注:</label>
        <div class="controls">
            <form:textarea path="remark" htmlEscape="false" maxlength="500" class="input-medium" placeholder="请输入备注"  style="width:217px;"/>
        </div>
    </div>
    <c:if test="${flag=='edit'}">
        <div class="control-group">
            <label class="control-label">是否禁用优惠券:</label>
            <div class="controls">
                <form:radiobutton path="enabledSys" value="0" onclick="enablesyss()"/>否
                <form:radiobutton path="enabledSys" value="1" onclick="enablesyss()"/>是
            </div>
        </div>

        <div class="control-group" id="enabledReason" style="display:${ebCertificate.enabledSys==1?'block':'none'}">
            <label class="control-label">禁用原因:</label>
            <div class="controls">
                <textarea id="enabledSysRemark" name="enabledSysRemark" maxlength="500"  style="width:217px;"
                          placeholder="请输入禁用原因">${remarksys}</textarea>
            </div>
        </div>
    </c:if>
    <%-- 	<c:if test="${not empty ebCertificateLocations}">
                <div class="control-group">
            <label class="control-label">投放位置:</label>
            <div class="controls">
             <form:select path="locationId" class="input-medium">
             <form:option value="">请选择</form:option>
             <c:forEach var="locations" items="${ebCertificateLocations}">
             <form:option value="${locations.id}">${locations.certificateLocationName }</form:option>
             </c:forEach>
            </form:select>
            </div>
        </div>
        </c:if>
 --%>


    <div class="form-actions">
        <input style="display: inline-block;width:90px;color: #ffffff;" id="btnSubmit" class="btn btn-primary"
               type="button" value="保 存"/>
        <span></span>
        <input id="btnCancel" style="width:90px;" class="btn" type="button" value="返 回" onclick="javascript:history.go(-1);"/>
    </div>
</form:form>
    </div>

</body>

</html>