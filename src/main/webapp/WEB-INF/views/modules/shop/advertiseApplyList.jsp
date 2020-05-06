<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>广告申请列表</title>
    <meta name="decorator" content="default"/>
    <link rel="stylesheet" href="${ctxStatic}/layui/css/layui.css"  media="all">
    <script src="${ctxStatic}/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript">
        function page(n, s) {
            if (n) $("#pageNo").val(n);
            if (s) $("#pageSize").val(s);
            $("#searchForm").attr("action", "${ctxweb}/shop/ebShopAdvertise/applyList");
            $("#searchForm").submit();
            return false;
        }
    </script>
    <script type="text/javascript">
        $(function(){
            if('${prompt}' != ""){
               alert('${prompt}')
            }
            })
    </script>
    <style type="text/css">

        #download-file:hover,.btns input:hover{
            color: rgb(120,120,120);
        }
  #searchForm{background:#fff;}
    .nav-tabs>.active>a{border-top:3px solid #009688;color:#009688;}
      .nav-tabs>li>a{color:#000;}
      .pagination{padding-bottom:25px;}
      .ibox-content{margin:0 30px;}
      body{background:#f5f5f5;}
      .ibox-content{background:#fff;}
      .nav{margin-bottom:0;}
    </style>
</head>
<body>
	<div style="color:#999;padding:19px 0 17px 30px;background:#f5f5f5;">
		<span>当前位置：</span><span>门店管理 - </span><span style="color:#009688;">小程序广告</span>
	</div>
<div class="ibox-content">

    <ul class="nav nav-tabs">
        <li><a href="${ctxweb}/shop/ebShopAdvertise/advertiseList">广告列表</a></li>
        <li><a  href="${ctxweb}/shop/ebShopAdvertise/applyFrom?flag=add">增加申请</a></li>
        <li class="active"><a href="${ctxweb}/shop/ebShopAdvertise/applyList">申请列表</a></li>
    </ul>

    <form:form id="searchForm" modelAttribute="ebShopAdvertise" action="${ctxweb}/shop/ebShopAdvertise/applyList" method="post"
               class="breadcrumb form-search ">
        <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
        <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
        <tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
        <div class="p-xs">
            <ul class="ul-form">

                <li>
                    <label>广告名称：</label>
                    <form:input path="name" style="width:217px;" htmlEscape="false" maxlength="50" class="input-medium"  placeholder="请输入广告名称"/>
                </li>

                <li>
                    <label>审核状态：</label>
                    <form:select path="applyStatus" style="width:230px;" >
                        <form:option value="">全部</form:option>
                        <form:option value="0">未审核</form:option>
                        <form:option value="1">审核通过</form:option>
                        <form:option value="2">审核不通过</form:option>
                        <form:option value="4">取消申请</form:option>
                        <form:option value="5">已删除</form:option>
                    </form:select>
                </li>
                <li>
                    <label>广告位置：</label>
                    <form:select path="site" style="width:230px;" >
                        <form:option value="">全部</form:option>
                        <form:option value="1">弹框广告</form:option>
                        <form:option value="2">banner广告</form:option>
                    </form:select>
                </li>
                <li>
                    <label>广告类型：</label>
                    <form:select path="type" style="width:230px;" >
                        <form:option value="">全部</form:option>
                        <form:option value="1">图片广告</form:option>
                        <form:option value="2">优惠券广告</form:option>
                    </form:select>
                </li>
                <li class="btns"><input style="background: #393D49;width:80px;" id="btnSubmit" class="btn btn-primary" type="submit" value="查询"
                                        onclick="return page();"/>
                </li>
            </ul>
        </div>
    </form:form>


    <table class="table table-striped table-bordered table-hover dataTables-example">
        <thead>
        <tr>
            <th>广告名称</th>
            <th>门店名称</th>
            <th>广告位置</th>
            <th>广告类型</th>
            <th>申请理由</th>
            <%--<th>广告图片</th>--%>
            <%--<th>优惠券</th>--%>
            <th>申请时间</th>
            <th>审核时间</th>
            <th>审核状态</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${page.list}" var="advertise">
            <tr>
                <th>
                        ${advertise.name.length() > 15 ? advertise.name.substring(0,15) : advertise.name}${advertise.name.length() > 15 ? "...":""}
                </th>
                <th>
                        ${advertise.shopName}
                </th>
                <th>
                        ${advertise.site == 1 ? "弹窗广告":"banner广告"}
                </th>

                <th>
                        ${advertise.type == 1 ? "图片广告":"优惠券广告"}
                </th>
                <th>
                        ${advertise.remark.length() > 10 ? advertise.remark.substring(0,10) : advertise.remark}${advertise.remark.length() > 10 ? "...":""}
                </th>

                <%--<th >--%>
                    <%--<c:if test="${advertise.pic != null && !''.equals(advertise.pic)}">--%>
                        <%--<img src="${ctxweb}${advertise.pic}" style="width: 50px;">--%>
                    <%--</c:if>--%>
                <%--</th>--%>


                <%--<th >--%>
                   <%--${advertise.certificateName}--%>
                <%--</th>--%>
                <th>
                    <fmt:formatDate value="${advertise.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
                </th>

                <th>
                    <fmt:formatDate value="${advertise.applyTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
                </th>


                <c:if test="${advertise.applyStatus==0}">
                    <th style="color:#0465AA">未审核</th>
                </c:if>

                <c:if test="${advertise.applyStatus==1}">
                    <th style="color:#00aa00">审核通过</th>
                </c:if>
                <c:if test="${advertise.applyStatus==2}">
                    <th style="color:#dd0000">审核不通过</th>
                </c:if>

                <c:if test="${advertise.applyStatus==4}">
                    <th style="color:#8F93AA">取消申请</th>
                </c:if>
                <c:if test="${advertise.applyStatus==5}">
                    <th style="color:#8F93AA">已删除</th>
                </c:if>
                <th>

                    <c:if test="${advertise.isApply==1}">
                        <a style="color: #009688;" href="${ctxweb}/shop/ebShopAdvertise/applyFrom?id=${advertise.id}&isChange=0" >查看详情</a>
                    </c:if>

                    <c:if test="${advertise.isApply==0}">
                        <c:if test="${advertise.applyStatus==0}">
                            <a style="color: #009688;" href="${ctxweb}/shop/ebShopAdvertise/applyFrom?id=${advertise.id}&isUpdate=1" >修改</a> |
                        </c:if>
                        <%--<a style="color: #009688;" href="${ctxweb}/shop/ebShopAdvertise/cancelApply?id=${advertise.id}" >取消申请</a> |--%>
                    <c:if test="${advertise.applyStatus!=4}">
                        <a data-method="confirmTrans" class="cancel-btn" href="javascript:;" onclick="cancelApply('${advertise.id}',this)" >取消申请</a>
                    </c:if>
                    </c:if>

                </th>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <div class="pagination">${page}</div>
    <script>
        $(function(){
            if('${prompt}' != ""){
                layer.msg('${prompt}')
            }
        })
        function cancelApply(id , element){
            layui.use('layer', function() { //独立版的layer无需执行这一句
                var $ = layui.jquery, layer = layui.layer; //独立版的layer无需执行这一句
                layer.confirm('确定取消该申请么?', function (index) {

                 window.location.href='${ctxweb}/shop/ebShopAdvertise/cancelApply?id='+id;
                    layer.close(index);
                });
            })

        }
    </script>

    <%--<script>--%>

            <%--//触发事件--%>
            <%--var active = {--%>
                <%--confirmTrans: function(){--%>
                    <%--//配置一个透明的询问框--%>
                    <%--layer.msg('确定取消该申请?', {--%>
                        <%--time: 20000, //20s后自动关闭--%>
                        <%--btn: ['确定', '取消']--%>
                        <%--,yes: function(index, layero){--%>
                            <%--cancelApply()--%>
                        <%--}--%>
                    <%--});--%>
                <%--}--%>
            <%--};--%>


            <%--$('.cancel-btn').on('click', function(){--%>
                <%--var othis = $(this), method = othis.data('method');--%>
                <%--active[method] ? active[method].call(this, othis) : '';--%>
            <%--});--%>


    <%--</script>--%>

</div>
</body>
</html>