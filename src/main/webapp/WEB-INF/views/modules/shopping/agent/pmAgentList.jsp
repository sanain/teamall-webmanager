<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <meta name="decorator" content="default"/>
    <title>代理商列表</title>
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/build.css">
    <link rel="stylesheet" href="${ctxStatic}/h5/css/timePicker.css">
    <script type="text/javascript" src="${ctxStatic}/My97DatePicker/WdatePicker.js"></script>
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
        <%--$(function(){--%>
            <%--$('.check1').hide();--%>
            <%--$('body').on('click','.check-a1',function(){--%>
                <%--$('.check1').show();--%>
            <%--});--%>

            <%--$('body').on('click','.check-del1',function(){--%>
                <%--$('.check1').hide();--%>
            <%--});--%>

            <%--//提交之前验证时间格式--%>
            <%--$("#searchForm").submit(function(){--%>
                <%--var reg = /([0-1][0-9]|2[0-3]):([0-5][0-9])/--%>
                <%--var openingTime = $("#openingTime").val().trim();--%>
                <%--var closingTime = $("#closingTime").val().trim();--%>

                <%--if(openingTime!=undefined && openingTime != "" && !reg.test(openingTime)){--%>
                    <%--alert("开始营业时间不符合格式");--%>
                    <%--return false;--%>
                <%--}--%>

                <%--if(closingTime!=undefined && closingTime != "" &&  !reg.test(closingTime)){--%>
                    <%--alert("结束营业时间不符合格式");--%>
                    <%--return false;--%>
                <%--}--%>

                <%--return true;--%>
            <%--})--%>
        <%--});--%>
        function page(n,s){
            if(n) $("#pageNo").val(n);
            if(s) $("#pageSize").val(s);
            $("#searchForm").attr("action","${ctxsys}/pmAgent");
            $("#searchForm").submit();
            return false;
        }
        <%--$('#all').click(function(){--%>
            <%--if($(this).is(':checked')){--%>
                <%--$('.kl').prop('checked',true).attr('checked',true);--%>
                <%--$('#all').prop('checked',true).attr('checked',true);--%>
            <%--}else {--%>
                <%--$('.kl').removeAttr('checked');--%>
                <%--$('#all').removeAttr('checked');--%>
            <%--}--%>
        <%--});--%>
        <%--$('body').on('click','.kl',function(){--%>
            <%--if ($('.kl').length==$('.kl[type=checkbox]:checked').length){--%>
                <%--$('#all').prop('checked',true).attr('checked',true);--%>
            <%--}else {--%>
                <%--$('#all').removeAttr('checked');--%>
            <%--}--%>
        <%--})--%>
        <%--$('#fromNewActionSbM').click(function(){--%>
            <%--$.ajax({--%>
                <%--type : "POST",--%>
                <%--data:$('#searchForm').serialize(),--%>
                <%--url : "${ctxsys}/PmShopInfo/exsel",--%>
                <%--success : function (data) {--%>
                    <%--window.location.href=data;--%>
                <%--}--%>
            <%--});--%>
        <%--});--%>
    <%--</script>--%>
    <%--<script type="text/javascript">--%>
        <%--function loke(vals,id,img){--%>
            <%--window.opener.document.getElementById('advertiseTypeObjIds').value=id;--%>
            <%--window.opener.document.getElementById('imgsvals').src=""+img;--%>
            <%--window.opener.document.getElementById('pnames').innerHTML=vals;--%>
            <%--window.opener.document.getElementById('pnames').title=vals;--%>
            <%--window.parent.opener.fkent();--%>
            <%--window.open("about:blank","_self").close();--%>
        <%--}--%>
    </script>

    <%--<script>--%>
        <%--$().ready(function(e) {--%>

            <%--$("#timePicker").hunterTimePicker();--%>
            <%--$(".time-picker").hunterTimePicker();--%>
        <%--});--%>
    <%--</script>--%>


</head>
<body>
<ul class="nav nav-tabs">
    <shiro:hasPermission name="merchandise:pmAgent:view">
        <li class="active"><a href="${ctxsys}/pmAgent">代理商列表</a></li>
        <li><a href="${ctxsys}/pmAgent/form?flag=add">增加代理商</a></li>
    </shiro:hasPermission>
</ul>
<form:form id="searchForm" modelAttribute="pmAgent" action="${ctxsys}/pmAgent" method="post" class="breadcrumb form-search ">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
    <tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
    <ul class="ul-form">

        <li><label>代理商账号:</label><form:input path="agentCode" htmlEscape="false" maxlength="80" class="input-medium"  placeholder=""/></li>
        <li><label>代理商名称:</label><form:input path="agentName" htmlEscape="false" maxlength="80" class="input-medium"  placeholder=""/></li>
        <li style="margin-left:10px">&nbsp;&nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/></li>

    </ul>
</form:form>
<tags:message content="${message}"/>

<table id="treeTable" class="table table-striped table-condensed table-bordered" >
    <tr>
        <th class="center123">编号</th>
        <th class="center123">代理商名称</th>
        <th class="center123">地址</th>
        <th class="center123">创建时间</th>
        <%--<th class="center123">状态</th>--%>
        <shiro:hasPermission name="merchandise:pmAgent:edit">
            <th class="center123">操作</th>
        </shiro:hasPermission>
    </tr>
    <c:forEach items="${page.list}" var="agent" varStatus="status">
        <tr>
            <td class="center123">${agent.agentCode}</td>
            <td class="center123">${fns:abbr(agent.agentName,20)}</td>
            <td class="center123">${fns:abbr(agent.agentName,30)}</td>
            <td class="center123"><fmt:formatDate value="${agent.createTime}" pattern="yyyy-MM-dd"/></td>
            <%--<td class="center123">--%>
                <%--<c:if test="${agent.onlineStatus == 0}">--%>
                    <%--不在线--%>
                <%--</c:if>--%>
<%----%>
                <%--<c:if test="${agent.onlineStatus == 1}">--%>
                    <%--在线--%>
                <%--</c:if>--%>
            </td>
            <td class="center123">
                    <shiro:hasPermission name="merchandise:pmAgent:edit">
                        <a href="${ctxsys}/pmAgent/form?agentId=${agent.id}">修改</a>
                        <%--<a href="javascript:;" onclick="deletePmAgent('${agent.id}')">删除</a>--%>
                        <a href="${ctxsys}/pmAgent/delete?agentId=${agent.id}" onclick="return confirmx('确认要删除该用户吗？', this.href)">删除</a>
                    </shiro:hasPermission>
            </td>
        </tr>
    </c:forEach>
</table>
<div class="pagination">${page}</div>

<script type="text/javascript">
    function deletePmAgent(agentId){
        layer.confirm("确定删除该代理商？",function(){
            $.ajax({
                type:"POST",
                url:"${ctxsys}/pmAgent/delete",
                data:{
                    "agentId":agentId
                },
                datatype: "json",
                success:function(data){
                    if(data.code == "1"){
                        layer.msg("删除成功");
                    }
                },error: function(){
                }
            });
        })
    }
</script>
</body>
</html>