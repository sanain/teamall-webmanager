<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>商品列表</title>
    <meta name="decorator" content="default"/>
    <link rel="stylesheet" href="${ctxStatic}/layui/css/layui.css?v=1">
    <script type="text/javascript">
        function page(n, s) {
            if (n) $("#pageNo").val(n);
            if (s) $("#pageSize").val(s);
            $("#searchForm").attr("action", "${ctxweb}/shop/ebproductshop/index");
            $("#searchForm").submit();
            return false;
        }

        function changeType(typeId){
            $("#typeId").val(typeId);
            page();
        }

        function showAndHidden(element){
            if($(element).attr("status") == 0){    //收起状态
                $(element).text("收起▲")
                $(element).attr("status",1)
            }else{
                $(element).text("展开🔻")
                $(element).attr("status",0)
            }
            $(".possible-hidden").toggleClass("hidden-li");
            $("#isShow").val($(element).attr("status"));
        }

        $(function(){
            var liArr = $(".house-nav li");
            if(liArr.length <= 14){
                $("#show-and-hiden-div").css("display","none")
            }else{

                var liArr = $(".house-nav li");
                for (var i = 0; i < liArr.length; i++) {
                    if (i > 14) {
                        $(liArr[i]).addClass("possible-hidden")
                        if('${isShow}'==0) {
                            $(liArr[i]).addClass("hidden-li")
                        }
                    }
                }

            }
        })

    </script>

    <style type="text/css">
        .form-search .ul-form li label{width:auto;}
        .form-search label{margin-left:0;}
        #searchForm{background:#fff;}
        body{background:#f5f5f5;}
        #btnSubmit{
            background:  #393D49;
            margin-left:20px;
        }
        #btnSubmit:hover{
            color: rgb(120,120,120);
        }
        a{
            color:#009688;
        }
        .sort-column {
            color: #009688;
            cursor: pointer;
        }
        .pagination{padding:0 15px 20px 0px;}
        .breadcrumb{margin-bottom:0px;padding:0;}
        .layui-tab-title{height:43px;}

        .house-nav li.active a {
            position: relative;
            border-bottom: 3px solid #009688;
        }
        .house-nav li {
            float: left;
            line-height: 53px;
            width: 12%;
            cursor: pointer;
            text-align: center;
        }
        li {
            list-style: none;
        }

        .house-nav li.active a {
            display: inline-block;
            width: 100%;
            color: #333;
            height: 50px;
        }
        .house-nav li a {
            color: #666;
        }
        /*.house-nav{*/
        /*height: 106px;*/
        /*overflow: hidden;*/
        /*}*/
        .hidden-li{
            display: none;
        }
    </style>
</head>
<body style="background:#f5f5f5;">
<div style="color:#999;margin:19px 0 17px 30px;">
    <span>当前位置：</span><span>商品管理 - </span><span style="color:#009688;">商品列表</span>
</div>

<div class="ibox-content"  style="background:#fff;margin:0 30px 20px 30px;">
    <div class="layui-tab">
        <ul class="layui-tab-title">
            <li class="layui-this"
                style="width:145px;border-top:2px solid  #009688;background:#fff;"><a
                    class="active" href="${ctxweb}/shop/shopinfofeight/feightEdit"
                    style=" color: #009688;height:43px;background:#fff;">商品列表</a></li>
        </ul>
    </div>
    <form:form id="searchForm" modelAttribute="ebProduct" action="${ctxweb}/shop/ebproductshop/index" method="post" class="breadcrumb form-search ">
        <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
        <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
        <tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
        <ul class="ul-form" style="padding:0 30px;">
            <form:hidden path="isLovePay" value="1"/>
            <input type="hidden" name="shopId" value="${shopId}">
            <input type="hidden" id="typeId" name="typeId" value="${typeId}">
            <input type="hidden" name="stule" value="${stule}">
            <input type="hidden" id="isShow" name="isShow" value="${isShow}">
            <li><label style="margin-right:20px;">商品名字:</label><form:input path="productName" htmlEscape="false" maxlength="50" class="input-medium"  style="width:228px;" placeholder="请输入商品名字"/></li>
            <li style="margin-left:80px;"><label style="margin-right:20px;">商品状态:</label>
                <form:select path="prdouctStatus" class="input-medium"  style="width:240px;">
                    <form:option value="">全部</form:option>
                    <form:option value="2">下架</form:option>
                    <form:option value="1">上架</form:option>
                </form:select>
            </li>
        </ul>
        <ul style="overflow:hidden;margin-top:10px;margin-bottom:25px;padding:0 30px;">
            <li   style="float:left;"><label  style="margin-right:16px;">上架时间:</label>
                <input class="small" type="text" style=" width: 100px;" name="statrDate" id="create_time_start" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" value="${statrDate}" placeholder="请输入开始时间"/>
                --<input class="small" type="text" name="stopDate" id="stoptime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" style=" width: 100px;" value="${stopDate}" placeholder="请输入结束时间"/>
            </li>
            <li  style="float:left;margin-left:90px;"><label style="margin-right:20px;">销售价:</label>
                <input class="small" type="text" style=" width: 100px;" name="statrPrice"   value="${statrPrice}" placeholder="请输入最小价格"/>
                --<input class="small" type="text" name="stopPrice"   style=" width: 100px;" value="${stopPrice}" placeholder="请输入最大价格"/></li>
            <li    style="float:left;"><input id="btnSubmit" class="btn btn-primary"  type="submit" value="查询" onclick="return page();" style="width:95px;"/></li>
        </ul>
        <tags:message content="${message}"/>
        <ul class="house-nav">
            <li
                    <c:if test="${typeId==null}">class="active"</c:if>
            ><a href="javascript:;" onclick="changeType()">全部</a></li>

            <c:forEach items="${typeList}" var="type" varStatus="vs">
                <li
                        <c:if test="${typeId==type.id}">class="active"</c:if>


                ><a href="javascript:;" onclick="changeType('${type.id}')">${type.productTypeName}</a></li>

            </c:forEach>
        </ul>
        <div id="show-and-hiden-div" style="width: 100%;text-align: left;float: left;padding-left: 50px">
            <span onclick="showAndHidden(this)"
                  status="${isShow}"
                  style="padding-left: 10px;font-size: 16px;
                font-weight: bold;cursor: pointer;color:#009688;">
                <c:if test="${isShow==0}">展开🔻</c:if>
                <c:if test="${isShow==1}">收起▲</c:if>
            </span>
        </div>
        <div style="height: 30px;float: left;width: 100%"></div>
        <table  class="table table-striped table-condensed table-bordered" >
            <tr>
                <th class="center123">商品名称</th>
                <th class="center123">商品图片</th>
                <th class="center123">所属分类</th>
                <th class="center123 sort-column sellPrice">销售价</th>
                <c:if test="${fns:isShowWeight()}">
                    <th class="center123">计量类型</th>
                </c:if>
                <th class="center123 sort-column">库存</th>
                <th class="center123 sort-column">会员价</th>
                <th class="center123">状态</th>
                <th class="center123 sort-column createTime" >创建时间</th>
                <th>操作</th>
            </tr>
            <c:forEach items="${ebProductList}" var="productlist" varStatus="status">
                <tr>
                    <td class="center123">
                            ${fns:abbr(productlist.productName,13)}
                    </td>
                    <td class="center123"><img class="fu" src="${fn:split(productlist.prdouctImg,'|')[0]}"style="width:30px;height:30px"/><img class="kla" style="display:none;position:fixed;top:30%;left:40%" alt="" src="${fn:split(productlist.prdouctImg,'|')[0]}"></td>
                    <td class="center123">${fns:getsbProductTypeName(productlist.productTypeId).productTypeStr}</td>
                    <td class="center123">
                            ${ebShopProductList[status.index].sellPrice == null || "".equals(ebShopProductList[status.index].sellPrice) ?
                                    ebShopProductList[status.index].sellPriceRange :  ebShopProductList[status.index].sellPrice
                                    }
                    </td>
                    <c:if test="${fns:isShowWeight()}">
                        <td class="center123">${ebShopProductList[status.index].measuringType == null || ebShopProductList[status.index].measuringType == 1 ? "件":"重量"}</td>
                    </c:if>
                    <td class="center123">
                            ${fns:replaceStoreNum(ebShopProductList[status.index].measuringType,ebShopProductList[status.index].measuringUnit,ebShopProductList[status.index].storeNums)}
                        <c:if test="${fns:isShowWeight()}">
                            <c:if test="${ebShopProductList[status.index].measuringType == 2 &&  ebShopProductList[status.index].measuringUnit==1 }">
                                公斤
                            </c:if>
                            <c:if test="${ebShopProductList[status.index].measuringType == 2 &&  ebShopProductList[status.index].measuringUnit==2 }">
                                克
                            </c:if>
                            <c:if test="${ebShopProductList[status.index].measuringType == 2 &&  ebShopProductList[status.index].measuringUnit==3 }">
                                斤
                            </c:if>
                        </c:if>
                    </td>
                    <td class="center123">
                            ${ebShopProductList[status.index].memberPrice == null || "".equals(ebShopProductList[status.index].memberPrice) ?
                                    ebShopProductList[status.index].memberPriceRange :  ebShopProductList[status.index].memberPrice
                                    }
                    </td>

                    <td class="center123">
                        <c:if test="${productlist.prdouctStatus==0}">未上架</c:if><c:if test="${productlist.prdouctStatus==2}">下架</c:if><c:if test="${productlist.prdouctStatus==1}">上架</c:if>
                    </td>
                    <td class="center123">${ebShopProductList[status.index].createTime}</td>
                    <td>
                        <a href="${ctxweb}/shop/ebproductshop/show?productId=${productlist.productId}" style="color:#009688;">查看</a>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </form:form>
    <div class="pagination">${page}</div>

</div>
</body>
</html>
