<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <meta name="decorator" content="default"/>
    <title>门店列表</title>
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/build.css">
    <link rel="stylesheet" href="${ctxStatic}/h5/css/timePicker.css">
    <%--<link rel="stylesheet" href="${ctxStatic}/layui/css/modules/laydate/default/laydate.css?v=5.0.9" media="all">--%>
    <%--<link  rel="stylesheet" href="${ctxStatic}/layui/css/modules/layer/default/layer.css?v=3.1.1" media="all">--%>

    <script type="text/javascript" src="${ctxStatic}/My97DatePicker/WdatePicker.js"></script>
    <script type="text/javascript" src="${ctxStatic}/h5/js/jquery-timepicker.js"></script>
    <script src="${ctxStatic}/layui/layui.js"></script>
    <%--<script src="${ctxStatic}/supplyshop/layui/lay/modules/layer.js?v=1" type="text/javascript"></script>--%>
    <link href="${ctxStatic}/supplyshop/layui/css/modules/layer/default/layer.css?v=1" type="text/css" rel="stylesheet" />
    <script src="${ctxStatic}/supplyshop/layui/lay/modules/layer.js?v=1" type="text/javascript"></script>
    <script type="text/javascript" src="${ctxStatic}/h5/js/jquery-timepicker.js"></script>
    <style>
        .check{position: fixed;top:0;left: 0;right: 0;bottom: 0;background: rgba(0,0,0,0.3);z-index: 10000}
        .check-box{width: 750px;background: #ffffff;position: absolute;top: 50%;left: 50%;margin-left: -375px;margin-top: -200px;}
        .check-box>p{height: 35px;line-height: 35px;background: #f0f0f0;position: relative;text-align: center}
        .check-box>p img{position: absolute;top:12px;right: 15px;cursor: pointer}
        .check-box ul{overflow: hidden;padding: 10px;outline:none;list-style:none}
        .check-box ul li.checkbox{float: left;width: 30%;line-height: 30px;margin-top: 0;}
        .check-box ul li.checkbox input{position:relative;left:8px}
        .check-btn{text-align: center;padding-bottom: 20px}
        .check-btn a{display: inline-block;width: 80px;height: 30px;line-height: 30px;border-radius: 5px;border: 1px solid #dcdcdc}
        .check-btn a:nth-child(1){background: #68C250;border: 1px solid #68C250;color: #ffffff;margin-right: 5px}
        .check-btn a:nth-child(2){color: #666666;margin-left: 5px}
        .check-box .checkbox input[type="checkbox"]:checked + label::before {
            background: #68C250;
            top:0 px;
            border: 1px solid #68C250;
        }
        .check-box .checkbox label::before{
            top: 0px;
        }
        .check-box .checkbox i{
            position: absolute;
            width: 12px;
            height: 8px;
            background: url(../images/icon_pick.png) no-repeat;
            top: 4px;
            left: -18px;
            cursor: pointer;
        }
        .check-box .checkbox input{top: 10px;position:relative}
        body .form-search .ul-form li label{width:100px;
            text-align: right;
            padding-right: 8px;
        }
    </style>

    <script type="text/javascript">

        function page(n,s){
            if(n) $("#pageNo").val(n);
            if(s) $("#pageSize").val(s);
            $("#searchForm").attr("action","${ctxsys}/pmAgent/shopList");
            $("#searchForm").submit();
            return false;
        }
    </script>

    <script>
        $().ready(function(e) {

            $("#timePicker").hunterTimePicker();
            $(".time-picker").hunterTimePicker();
        });
    </script>

</head>
<body>
<ul class="nav nav-tabs">
    <shiro:hasPermission name="merchandise:pmAgent:view">
        <li class="active"><a href="${ctxsys}/pmAgent/shopList">门店列表</a></li>
    </shiro:hasPermission>
</ul>
<form:form id="searchForm" modelAttribute="pmShopInfo" action="${ctxsys}/pmAgent/shopList" method="post" class="breadcrumb form-search ">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
    <tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
    <ul class="ul-form">
        <li><label>店名:</label><form:input path="shopName" htmlEscape="false" maxlength="80" class="input-medium"  placeholder=""/></li>
        <li><label>地址:</label><form:input path="contactAddress" htmlEscape="false" maxlength="80" class="input-medium"  placeholder=""/></li>
        <li><label>开始营业时间:</label><input name="openingTime" readonly="readonly" id="openingTime" type="text"  htmlEscape="false" value="${openingTime}" maxlength="80" class="input-medium time-picker"  placeholder=""/>
        ~<input name="closingTime" id="closingTime" readonly="readonly" type="text" htmlEscape="false" value="${closingTime}" maxlength="80" class="input-medium time-picker"  placeholder=""/></li>

        <%--<li><label>营业时间:</label>--%>
            <%--<input type="text" name="opening" readonly="readonly" value="" id="test5" placeholder="yyyy-MM-dd HH:mm:ss" lay-key="1">~--%>
            <%--<input type="text" name="closingTime" readonly="readonly" value="" id="test6" placeholder="yyyy-MM-dd HH:mm:ss" lay-key="1">--%>
        <%--</li>--%>

        <c:if test="${!isAgent}">
            <li id="chooseAgentLi" style="display: inline-block;"><label>选择门店:</label>
                <select name="isAllAgent" id="isAllAgent" class="input-medium" onchange="chooseAgent()">
                    <option value="1">全部代理商</option>
                    <option value="0">指定代理商</option>
                </select>
            </li>
        </c:if>

        <input type="hidden" id="chooseAgentId" name="agentIds" htmlEscape="false" maxlength="80" class="input-medium"  placeholder=""/>

        <li style="margin-left:10px">&nbsp;&nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/></li>

    </ul>
</form:form>
<tags:message content="${message}"/>

<table id="treeTable" class="table table-striped table-condensed table-bordered" >
    <tr>
        <th class="center123">所属代理商</th>
        <th class="center123">店名</th>
        <th class="center123">地址</th>
        <th class="center123">创建时间</th>
            <th class="center123">操作</th>
    </tr>
    <c:forEach items="${pmShopList}" var="pmShop" varStatus="status">
        <tr>
            <td class="center123">${pmAgentShopList[status.index].agentName}</td>
            <td class="center123">${pmShop.shopName}</td>
            <td class="center123">${fns:abbr(pmShop.contactAddress,40)}</td>
            <td class="center123">
                    ${pmShop.openingTime} ~ ${pmShop.closingTime}
            </td>
            <td class="center123">
                <a href="${ctxsys}/PmShopInfo/shopinfo?id=${pmShop.id}">查看详情</a>
            </td>
        </tr>
    </c:forEach>
</table>
<div class="pagination">${page}</div>

<script type="text/javascript">

    //选择指定门店或者全部门店
    function chooseAgent(){
        if($("#isAllAgent").val() == 1){
            $("#chooseAgentId").val("");
        }else{
            layer.open({
                type: 2,
                title: '代理商列表',
                shadeClose: true,
                shade: false,
                maxmin: true, //开启最大化最小化按钮
                area: ['880px', '450px'],
                content: '${ctxsys}/pmAgent/chooseAgent?agentIds='+ $("#chooseAgentId").val(),
                btn: ['确定', '关闭'],
                yes: function(co){ //或者使用btn1
                    content = layero.find("iframe")[0].contentWindow.$('#chooseIds').val();
                    if(content==""){
                        layer.msg("请先选中一行");
                    }else{
                        $("#chooseAgentId").val(content);
                        layer.close(index);
                    }

                }
            })
        }

    }
</script>

<script>
    layui.use('laydate', function(){
        var laydate = layui.laydate;

        //日期时间选择器
        laydate.render({
            elem: '#test5'
            ,type: 'datetime'
        });

        //日期时间选择器
        laydate.render({
            elem: '#test6'
            ,type: 'datetime'
        });
    });
</script>
</body>
</html>