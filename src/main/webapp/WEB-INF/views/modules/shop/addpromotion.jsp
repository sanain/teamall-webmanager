<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/addpromotion.css?v=18">
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/bootstrap.min.css">
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/build.css">
    <link rel="stylesheet" href="${ctxStatic}/sbShop/layui/css/layui.css">
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/colpick.css">
    <link type="text/css" rel="stylesheet" href="${ctxStatic}/common/jqsite.min.css">
    <link rel="stylesheet" href="${ctxStatic}/tii/tii.css">
    <%--<link rel="stylesheet" href="${ctxStatic}/sbShop/css/bootstrap.min.css">--%>
    <%--<script src="${ctxStatic}/sbShop/js/jquery.min.js"></script>--%>
    <script src="${ctxStatic}/sbShop/js/jquery.min.js"></script>
    <script src="${ctxStatic}/bootstrap/2.3.1/js/bootstrap.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="${ctxStatic}/common/mustache.min.js"></script>
    <script type="text/javascript" src="${ctxStatic}/common/jqsite.min.js"></script>
    <script type="text/javascript" src="${ctxStatic}/ckeditor/ckeditor.js"></script>
    <script type="text/javascript" src="${ctxStatic}/ckfinder/ckfinder.js"></script>
    <script src="${ctxStatic}/tii/tii.js"></script>
    <link href="${ctxStatic}/jquery-jbox/2.3/Skins/Default/jbox.css?v=1" type="text/css" rel="stylesheet"/>
    <script src="${ctxStatic}/jquery-jbox/2.3/jquery.jBox-2.3.js?v=1" type="text/javascript"></script>
    <link href="${ctxStatic}/supplyshop/layui/css/modules/layer/default/layer.css?v=1" type="text/css"
          rel="stylesheet"/>

    <script src="${ctxStatic}/supplyshop/layui/lay/modules/layer.js?v=1" type="text/javascript"></script>
    <%--<script src="${ctxStatic}/sbShop/js/jquery.min.js"></script>--%>
    <script src="${ctxStatic}/My97DatePicker/WdatePicker.js" type="text/javascript"></script>


    <title></title>
</head>
<script>
    function addPromotion(){
        $.ajax({
            type: "POST",
            url: "${ctxweb}/shop/product/addPromotion",
            data:{
                promotionType:$("#promotionType").val(),
                type:$("#type").val(),
                certificateName:$("#certificateName").val(),
                provinceOutFullFreight:$("#provinceOutFullFreight").val(),
                amount:$("#amount").val(),
                groupCertificateNum:$("#groupCertificateNum").val(),
                groupNum:$("#groupNum").val(),
                banner:$("#banner").val(),
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
<body class="bodycolor" style="background: #ffffff;
    height: 100%;">
<div class="mod-box clearfix" style="padding: 15px;">
    <div class="mod">
        <dl>
            <dt>打折/满减</dt>
            <dd>为单次消费的某些商品 指定折扣或优惠金额</dd>
            <dd class="navbtn" value="1">应用</dd>
        </dl>
    </div>
    <div class="mod">
        <dl>
            <dt>第二件打折</dt>
            <dd>为单次消费指定商品中的第二件商品打折扣</dd>
            <dd class="navbtn" value="2">应用</dd>
        </dl>
    </div>
    <div class="mod">
        <dl>
            <dt>团购活动</dt>
            <dd>为单次消费指定商品中的商品团购活动价</dd>
            <dd class="navbtn" value="3">应用</dd>
        </dl>
    </div>
</div>


<div class="navbar-right">
    <div class="navleft">
        <ul>
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
                <input class="right" type="text" id="certificateName" />
            </li>
            <li class="clearfix">
                <span class="left">满减金额:</span>
                <input class="right" type="text" id="provinceOutFullFreight" />
            </li>
            <li class="clearfix groupNum-1">
                <span class="left groupNum-span">满足团购商品数:</span>
                <input class="right" type="text" id="groupNum" oninput = "value=value.replace(/[^\d]/g,'')"/>
            </li>
            <li class="clearfix groupCertificateNum-1">
                <span class="left groupCertificateNum-span">优惠商品数:</span>
                <input class="right" type="text" id="groupCertificateNum" oninput = "value=value.replace(/[^\d]/g,'')" />
            </li>
            <li class="clearfix">
                <span class="left amount-span">折扣:</span>
                <input class="right" type="text" id="amount" />
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
                       value=""  autocomplete="new-password"/>
            </li>
            <li class="clearfix">
                <span class="left">结束日期:</span>
                <input id="certificateEndDate" name="certificateEndDate" htmlEscape="false" maxlength="50" class="input-medium right"
                       placeholder="" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"
                       value=""  autocomplete="new-password"/>
            </li>


            <li class="clearfix" id="choose-product-li">
                <span class="left">选择商品:</span>
                <div style="width: 336px" class="right">
                    <input  type="button" style="float:left;background-color: #09c;width: 30%;color: white" value="选择" id="choose-product" onclick="chooseProduct()"/>
                </div>
            </li>

            <li class="clearfix" id="manage-product-li">
                <span class="left">已选择商品:</span>
                <div style="width: 336px" class="right">
                    <input class="right"  type="text" style="width: 80%;float: left" id="product-names" readonly onclick="openProductList()"/>
                    <input class="right" type="hidden" id="product-ids" />
                    <input class="right" style="float:right;background-color: #09c;width: 15%;color: white" type="button" value="清空" onclick="clearProduct()"/>
                </div>
            </li>


            <li class="clearfix" style="display: none">
                <span class="left">促销备注:</span>
                <input class="right" type="text" id="remark" />
            </li>


        </ul>

        <div class="clearfix save-box">
            <button class="save" onclick="addPromotion()">提交申请</button>
            <button class="canel">取消</button>
        </div>
    </div>
</div>
<!-- 模态框（Modal） -->
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


<%--<script src="${ctxStatic}/sbShop/js/jquery.min.js"></script>--%>
<script type="text/javascript">
    $(function() {
        $(".navbtn").click(function() {
            var promotionType=$(this).attr('value');
            $("#promotionType").val(promotionType);
            amount();
            $("body").addClass("navbar-right-show");
        })
        $(".canel").click(function() {
            $("body").removeClass("navbar-right-show");
        })
    })
    document.body.addEventListener('touchmove', function(e) {
        e.preventDefault();
    })
    $("body").on('change', "#promotionType", function(){
        amount();
    })
    $("body").on('change', "#type", function(){
        amount();

    })
    function amount() {
        var promotionType=$("#promotionType").val();
        var type=$("#type").val();
        if(promotionType=='1'){
            $(".promotionType-1").css("display","block");
            $(".groupCertificateNum-1").css("display","none");
            $(".groupNum-1").css("display","none");
            // $("#choose-product-li").css("display","block")
            // $("#manage-product-li").css("display","block")
            if(type=='3'){
                $(".amount-span").html("折扣:");
            }else if(type=='1'){
                $(".amount-span").html("金额:");

            }
        }else if(promotionType=='2'){
            $(".promotionType-1").css("display","none");
            $(".amount-span").html("折扣:");
            $(".groupCertificateNum-1").css("display","none");
            $(".groupNum-1").css("display","none");
            // $("#choose-product-li").css("display","none")
            // $("#manage-product-li").css("display","none")
        }else if(promotionType=='3'){
            $(".promotionType-1").css("display","none");
            $(".groupCertificateNum-1").css("display","block");
            $(".groupNum-1").css("display","none");
            $(".amount-span").html("促销价:");
        }
    }

    function chooseProduct(){
        layer.open({
            type: 2,
            title: '商品列表',
            shadeClose: true,
            shade: false,
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

</script>
</body>

</html>
