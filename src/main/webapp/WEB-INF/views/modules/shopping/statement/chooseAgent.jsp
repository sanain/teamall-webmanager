<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>代理商列表</title>
    <meta name="decorator" content="default" />
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/build.css?v=1">
    <link rel="stylesheet"
          href="${ctxStatic}/sbShop/css/quick-choose-product.css">

    <style>
        .table1 tr {
            height: 35px;
        }

        .breadcrumb {
            background: #fff;
        }
    </style>
    <script>
        function page(n, s) {
            if (n) $("#pageNo").val(n);
            if (s) $("#pageSize").val(s);
            $("#searchForm").attr("action", "${ctxsys}/agentStatement/chooseAgent");
            $("#searchForm").submit();
            return false;
        }
    </script>
</head>
<body>
<div style="overflow:hidden;height:350px;">
    <div style="float:left;width:25%;overflow:scroll;height:100%;">
        <table
                class="table table-striped table-condensed table-bordered table1">
            <thead>
            <tr>
                <td>代理商名称</td>
            </tr>
            </thead>

            <tbody class="tbody">

            </tbody>


        </table>

    </div>

    <div style="float:left;width:75%;overflow:scroll;height:100%;">

        <form:form id="searchForm" modelAttribute="pmAgent" action="${ctxsys}/agentStatement/chooseAgent" method="post" class="breadcrumb form-search ">
            <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
            <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
            <input id="chooseId" name="agentId" type="hidden" value="${agentId}" />
            <input id="chooseName" name="chooseName" type="hidden" value="${agentName}" />
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
                <th class="center123"></th>
                <th class="center123">编号</th>
                <th class="center123">代理商名称</th>
                <th class="center123">创建时间</th>
                <th class="center123" style="display: none">状态</th>
            </tr>
            <c:forEach items="${page.list}" var="agent" varStatus="status">
                <tr>
                    <td class="center123"><input type="checkbox" name="ktvs" class="kty chooseItem"  value="${agent.id}"></td>
                    <td class="center123">${agent.agentCode}</td>
                    <td class="center123 agent-name" value="${agent.agentName}">${fns:abbr(agent.agentName,20)}</td>
                    <td class="center123"><fmt:formatDate value="${agent.createTime}" pattern="yyyy-MM-dd"/></td>
                    <td class="center123" style="display: none">
                        <c:if test="${agent.onlineStatus == 0}">
                            不在线
                        </c:if>

                        <c:if test="${agent.onlineStatus == 1}">
                            在线
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </div>
    <div class="pagination">${page}</div>
</div>
<script type="text/javascript">
    var agentId = $("#chooseId").val();
    var agentName = $("#chooseName").val();
    var lastNode; //上次选中的节点

    $(function(){

        //初始化原来已经选好的代理商
        initAlreadyChecked();

        /**
         * 控制选择和取消
         * */
        $(".chooseItem").click(function(){
            if($(this).attr("checked") == "checked"){
                agentId = $(this).attr("value");
                agentName = $(this).parents("tr").find(".agent-name").attr("value");
                if(lastNode != null && lastNode != undefined){
                    lastNode.attr("checked",false);
                }
                lastNode = $(this);
            }else{
                agentId = '';
                agentName = '';
                lastNode =  null;
            }

            $("#chooseId").val(agentId);
            $("#chooseName").val(agentName);
            adTable();
        })
    })

    /**
     * 初始化原来已经选好的代理商
     * */
    function initAlreadyChecked(){
        var arr = $(".chooseItem");
        for(var i = 0 ; i < arr.length ; i++){
            if(agentId == $(arr[i]).attr("value")){
                $(arr[i]).attr("checked",true);
                lastNode = $(arr[i]);
            }
        }
        adTable();
    }

    function adTable() {
        debugger;
        var str = "";
        if(agentId != "" && agentName != ""){
            str += "<tr>\
							<td>" + agentName+ "</td>\
							 <td>" + agentId + "</td>\
							 <td  onclick='removethis()'>移除</td>\
							</tr>"
        }
        $(".tbody").html(str);
    }

    function removethis() {
        $(".tbody").html("");
        $(lastNode).click();
    }
</script>
</body>
</html>