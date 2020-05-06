<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0,minimal-ui">
    <meta name="Description" content="${fns:getProjectName()},门店装修"/>
    <meta name="Keywords" content="${fns:getProjectName()},门店装修"/>

    <title>
        <c:if test='${"add".equals(flag)}'>绑定设备</c:if>
        <c:if test='${!"add".equals(flag)}'>修改设备信息</c:if>
    </title>

    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/admin-fitment.css">
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/bootstrap.min.css">
    <link rel="stylesheet" href="${ctxStatic}/tii/tii.css">
    <%--<script src="https://cdn.staticfile.org/twitter-bootstrap/4.1.0/js/bootstrap.min.js"></script>--%>

<%--<link rel="stylesheet" href="${ctxStatic}/sbShop/css/build.css">--%>
    <style>
        .ul-form li{
            float:left;
        }
        body .form-search .ul-form li label{
            width:90px;
            text-align: right;
            padding-right:8px ;
            font-weight: normal;
        }

        body .form-search .ul-form li input,select,option{
            height: 35px;
            border-radius: 5px;


        }
        #form-search{
            padding-top: 20px;
        }

        .nav-tabs-dv,#searchForm{
            background-color: white;
            padding-top: 1px;
        }

        .input-label{
            padding-right: 10px;
            height: 34px;
            line-height: 34px;
            font-size:16px;
            font-weight: normal;
            text-align: right;
        }

        .fitment{
            padding-bottom: 10px;
        }
    </style>

    <script src="${ctxStatic}/sbShop/js/jquery.min.js"></script>
    <%--<script src="${ctxStatic}/tii/tii.js"></script>--%>
    <%--<script src="${ctxStatic}/sbShop/js/admin-fitment.js"></script>--%>
    <%--<script>--%>
        <%--function page(n,s){--%>
            <%--if(n) $("#pageNo").val(n);--%>
            <%--if(s) $("#pageSize").val(s);--%>
            <%--$("#searchForm").attr("action","${ctxsys}/PmShopInfo/device");--%>
            <%--$("#searchForm").submit();--%>
            <%--return false;--%>
        <%--}--%>
    <%--</script>--%>


</head>
<body>
<input class="ctxsys" id="ctxsys" name="ctxsys" type="hidden" value="${ctxsys}"/>
<div class="fitment">
    <ul class="nav-ul">
        <li><a href="${ctxsys}/PmShopInfo/shopinfo?id=${pmShopDevice.shopId}">门店信息</a></li>
        <li><a href="${ctxsys}/PmShopInfo/shopinfo?id=${pmShopDevice.shopId}&flag=add">增加门店</a></li>
        <li><a  href="${ctxsys}/PmShopInfo/employees?id=${pmShopDevice.shopId}">门店员工</a></li>
        <li><a class="active"  href="${ctxsys}/PmShopInfo/device?id=${pmShopDevice.shopId}">登录设备信息</a></li>
        <li><a  href="${ctxsys}/PmShopInfo/amtlogIndex?id=${pmShopDevice.shopId}">门店结算</a></li>
        <li><a  href="${ctxsys}/PmShopInfo/useramtlog?id=${pmShopDevice.shopId}">收支明细</a></li>
    </ul>

    <div class="nav-tabs-dv">
        <ul class="nav nav-tabs">
            <shiro:hasPermission name="merchandise:PmShopInfo:view">
                <li >
                    <c:if test="${stule!='99'}">
                        <a href="${ctxsys}/PmShopInfo/device?id=${pmShopInfo.id}">设备列表</a>
                    </c:if><c:if test="${stule=='99'}">
                        <a>设备列表</a>
                     </c:if>
                </li>
            </shiro:hasPermission>

            <shiro:hasPermission name="merchandise:PmShopInfo:edit">
                <li class="active">
                    <c:if test="${stule!='99'}">
                        <c:if test='${"add".equals(flag)}'>
                            <a href="${ctxsys}/PmShopInfo/addDevice?id=${pmShopInfo.id}">
                                绑定设备
                            </a>
                        </c:if>
                         <c:if test='${!"add".equals(flag)}'>
                             <a href="${ctxsys}/PmShopInfo/updateDevice?id=${pmShopInfo.id}">
                                 修改设备信息
                             </a>
                         </c:if>
                        <%--<a href="${ctxsys}/PmShopInfo/addDevice?id=${pmShopDevice.shopId}">--%>
                            <%--增加设备--%>
                        <%--</a>--%>
                    </c:if>
                    <c:if test="${stule=='99'}">
                        <a>
                            <c:if test='${"add".equals(flag)}'>绑定设备</c:if>
                            <c:if test='${!"add".equals(flag)}'>修改设备信息</c:if>
                        </a>
                    </c:if>
                </li>
            </shiro:hasPermission>
        </ul>



        <form id="form-search" class="breadcrumb  "
                <c:if test='${"add".equals(flag)}'>
                    action="${ctxsys}/PmShopInfo/addDevice"
                </c:if>
                <c:if test='${!"add".equals(flag)}'>
                    action="${ctxsys}/PmShopInfo/updateDevice"
                </c:if>
              method="post">

            <%--<div class="row" >--%>
                <%--<h4 class="col-md-12" style="text-align: center">--%>
                    <%--<c:if test='${"add".equals(flag)}'>绑定设备</c:if>--%>
                    <%--<c:if test='${!"add".equals(flag)}'>修改设备信息</c:if>--%>
                <%--</h4>--%>
            <%--</div>--%>
            <%--设备id--%>
            <input type="hidden" value="${device.id}" name="deviceId">
            <%--门店id--%>
            <input type="hidden" value="${pmShopInfo.id}" name="id">
            <input type="hidden" value="${device.createTime}"  class="form-control" name="createTime" >

            <%--<div class="form-group">--%>
            <%--<label for="deviceCode" class="col-md-4 input-label">门店:</label>--%>
            <%--<input type="text" value="${device}" class="form-control col-md-8" name="deviceCode" readonly value="${device.shopName}">--%>
            <%--</div>--%>

            <div class="form-group row col-md-6 col-md-offset-3">
                <label for="deviceCode" class="col-md-3 input-label" style="display: inline-block">设备编码:</label>
                <div class="col-md-8">
                    <input type="text" value="${device.deviceCode}" style="display: inline-block" class="form-control col-md-8" name="deviceCode" id="deviceCode" placeholder="请输入设备编码">

                </div>
            </div>
            <div class="form-group  row col-md-6 col-md-offset-3">
                <label for="deviceName"  class="input-label col-md-3">设备名称:</label>
                <div class="col-md-8">
                    <input type="text" value="${device.deviceName}"  class="form-control" name="deviceName" id="deviceName" placeholder="请输入设备名称">

                </div>

            </div>
            <div class="row">
                <div class="col-md-2 col-md-offset-6">
                    <shiro:hasPermission name="merchandise:PmShopInfo:edit">
                    <button type="submit" class="btn btn-primary" style="background-color: #69AC72;color: white;float: left">
                        <c:if test='${"add".equals(flag)}'>
                           绑定
                        </c:if>
                        <c:if test='${!"add".equals(flag)}'>
                            修改
                        </c:if>
                    </button>
                    </shiro:hasPermission>
                    <%--<a type="reset" class="btn btn-primary" href="${ctxsys}/PmShopInfo/device?id=${pmShopInfo.id}" style="background-color: white;color: #0C0C0C;float: right"> 返回</a>--%>
                </div>
            </div>

        </form>
    </div>


</div>

<div class="tii">
    <span class="tii-img"></span>
    <span class="message" data-tid="${message}">${message}</span>
</div>
</body>
<script type="text/javascript">
    $(function(){
        // $(".form-control").css("display","inline-block")
        if('${prompt}' != ""){
            alert('${prompt}');
        }

        // $("form").submit(function(){
        //     console.log($("#form-search").attr("active"))
        //     $("#form-search").submit();
        //
        //     return false;
        // })
    })

</script>
</html>