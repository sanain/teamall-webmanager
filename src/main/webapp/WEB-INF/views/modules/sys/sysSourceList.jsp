<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <meta name="decorator" content="default"/>
    <title>系统资源列表</title>
    <script type="text/javascript">
        function page(n,s){
            if(n) $("#pageNo").val(n);
            if(s) $("#pageSize").val(s);
            $("#searchForm").attr("action","${ctxsys}/sysSource");
            $("#searchForm").submit();
            return false;
        }

    </script>
</head>
<body>
<ul class="nav nav-tabs">
    <li class="active"><a href="${ctxsys}/sysSource/list">资源列表</a></li>
    <shiro:hasPermission name="merchandise:sysSource:edit"><li>
        <a href="${ctxsys}/sysSource/form">资源增加</a></li>
    </shiro:hasPermission>
</ul>
<form:form id="searchForm" modelAttribute="sysSource" action="${ctxsys}/sysSource/list" method="post" class="breadcrumb form-search ">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
    <tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
    <ul class="ul-form">
        <li><label>描述:</label><form:input path="description" htmlEscape="false" maxlength="50" class="input-medium"   placeholder=""/></li>
        <li>
            <label>内容类型:</label>
            <form:select path="contentType">
                <form:option value="">请选择</form:option>
                <form:option value="1">文字</form:option>
                <form:option value="2">图片</form:option>
            </form:select>
        </li>
        <li><label></label><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/></li>
    </ul>
</form:form>
<tags:message content="${message}"/>
<table  class="table table-striped table-condensed table-bordered" >
    <th>编号</th>
    <th>内容</th>
    <th>分类</th>
    <th>描述</th>
    <th>创建时间</th>
    <shiro:hasPermission name="merchandise:sysSource:edit">
        <th>操作</th>
    </shiro:hasPermission>
    </tr>
    <c:forEach items="${page.list}" var="source" varStatus="status">
        <tr>
            <td>${status.index+1}</td>
            <td>
                <c:if test="${source.contentType == 2}">
                    <a href="${ctxsys}/sysSource/form?id=${source.id}">
                        <img src="${source.value}" style="width: 200px"/>
                    </a>
                </c:if>

                <c:if test="${source.contentType == 1}">
                    <a href="${ctxsys}/sysSource/form?id=${source.id}">${source.value}</a>
                </c:if>
            </td>
            <td>
                    ${source.typeStr}
            </td>
            <td>
                    ${fns:abbr(source.description,50)}
            </td>
            <td><fmt:formatDate value="${source.createTime}" pattern="yyyy-MM-dd hh:mm:ss" /></td>
            <shiro:hasPermission name="merchandise:sysSource:edit"><td>
                <a href="${ctxsys}/sysSource/form?id=${source.id}">修改</a>
                <a href="${ctxsys}/sysSource/delete?id=${source.id}" onclick="return confirmx('确定删除该资源？', this.href)">删除</a>
            </td></shiro:hasPermission>
        </tr>
    </c:forEach>
</table>
<div class="pagination">${page}</div>
</body>
</html>