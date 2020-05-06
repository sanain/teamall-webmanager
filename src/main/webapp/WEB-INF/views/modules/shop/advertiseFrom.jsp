<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>
        <c:if test="${'0'.equals(isChange)}">
            查看申请详情
        </c:if>
        <c:if test="${!'0'.equals(isChange) && 'add'.equals(flag)}">
            增加广告申请
        </c:if>
        <c:if test="${!'0'.equals(isChange) && !'add'.equals(flag)}">
            修改广告申请
        </c:if>
    </title>
    <meta name="decorator" content="default"/>
    <script type="text/javascript" src="${ctxStatic}/jquery-validation/1.11.0/lib/jquery-1.9.0.js"></script>
    <script type="text/javascript" src="${ctxStatic}/jquery-validation/1.11.0/jquery.validate.js"></script>

    <link rel="stylesheet" href="${ctxStatic}/layui/css/layui.css"  media="all">
    <script src="${ctxStatic}/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript">

        <%--function toProductApplyList(){--%>
        <%--window.location.href='${ctxsys}/ebProductApply'--%>
        <%--}--%>

        $(function(){
            //查看详情情况下不能修改
            if('${isChange}'== '0'){
                $("input").attr("readonly","readonly");
                $("textarea").attr("readonly","readonly");
            }

            if('${flag}' ==  'add'){
                $("#inputForm").attr("action","${ctxweb}/shop/ebShopAdvertise/insert")
            }

            if('${flag}' !=  'add'){
                $("#inputForm").attr("action","${ctxweb}/shop/ebShopAdvertise/update")
            }
        })

    </script>

    <style type="text/css">
        .control-group .control-label{
            padding-right: 10px;
        }
        .form-check-inline{
            float: left;
            padding-left: 10px;
        }
    </style>
</head>
<body>

<ul class="nav nav-tabs">
    <ul class="nav nav-tabs">
        <li  class="active"><a  href="${ctxweb}/shop/ebShopAdvertise/advertiseFrom?id=${ebShopAdvertise.id}">
            广告详情
        </a></li>
    </ul>
</ul><br/>
<p id="price" style="display:none;"></p>
<form id="inputForm" style="position:relative"  method="post" class="form-horizontal">

    <div class="control-group">
        <label class="control-label" for="asName">广告名称:</label>
        <div class="controls">
            ${ebShopAdvertise.name}
        </div>
    </div>

    <div class="control-group">
        <label class="control-label" for="name">有效时间:</label>
        <div class="controls">
            <fmt:formatDate value="${ebShopAdvertise.entryTime}" pattern="yyyy-MM-dd HH:mm"/>
        </div>
    </div>

    <div class="control-group">
        <label class="control-label" for="name">创建时间:</label>
        <div class="controls">
            <fmt:formatDate value="${ebShopAdvertise.createTime}" pattern="yyyy-MM-dd HH:mm"/>
        </div>
    </div>

    <div class="control-group">
        <label class="control-label" for="name">审核状态:</label>
        <div class="controls">
            <c:if test="${ebShopAdvertise.applyStatus==0}">
                <span style="color:#0465AA">未审核</span>
            </c:if>

            <c:if test="${ebShopAdvertise.applyStatus==1}">
                <span style="color:#00aa00">审核通过</span>
            </c:if>
            <c:if test="${ebShopAdvertise.applyStatus==2}">
                <span style="color:#dd0000">审核不通过</span>
            </c:if>

            <c:if test="${ebShopAdvertise.applyStatus==4}">
                <span style="color:#8F93AA">取消申请</span>
            </c:if>
        </div>
    </div>
    <c:if test="${ebShopAdvertise.applyTime != null}">
        <div class="control-group">
            <label class="control-label" for="name">创建时间:</label>
            <div class="controls">
                <fmt:formatDate value="${ebShopAdvertise.createTime}" pattern="yyyy-MM-dd HH:mm"/>
            </div>
        </div>
    </c:if>

    <div class="control-group">
        <label class="control-label" for="name">广告位置:</label>
        <div class="controls">
            ${ebShopAdvertise.site == 1 ? "弹窗广告":"banner广告"}
        </div>
    </div>
    <div class="control-group">
        <label class="control-label" for="name">广告位置:</label>
        <div class="controls">
            ${ebShopAdvertise.type == 1 ? "图片广告":"优惠券广告"}
        </div>
    </div>

    <c:if test="${ebShopAdvertise.type == 1 }">
        <div class="control-group" id="update-img">
            <label class="control-label" for="name">广告图片:</label>
            <c:forEach var="pic" items="${ebShopAdvertise.pic}">
                <img class="layui-upload-img"  src="${pic}" style="height: 100px;
                <c:if test="${ebShopAdvertise.pic == null || ''.equals(ebShopAdvertise.pic)}">display: none</c:if>" id="demo1">
            </c:forEach>

        </div>
    </c:if>
    <c:if test="${ebShopAdvertise.type == 2 }">

        <div class="control-group" id="certificate-div">
            <label class="control-label" for="name">优惠券:</label>
            <div class="controls">
                    ${ebShopAdvertise.certificateName}
            </div>
        </div>
    </c:if>

    <div class="control-group">
        <label class="control-label">申请理由</label>
        <div class="controls">
            <textarea class="form-control" name="remark" readonly id="exampleFormControlTextarea1" rows="5">${ebShopAdvertise.remark} </textarea>
        </div>
    </div>



    <c:forEach var="remark" items="${remarkList}" varStatus="vs">
        <div class="control-group">
            <label class="control-label" for="name">回复${vs.index+1}:</label>
            <div class="controls">
                <textarea style="width: 200px; height: 100px;" readonly cols="100" rows="5">${remark.applyRemark}</textarea>
            </div>
        </div>
    </c:forEach>

    <div class="control-group">
        <label class="control-label"></label>
        <div class="controls">
            <input id="btnCancel" type="button" value="返回"  class="btn" onclick="javascript:history.go(-1)">
        </div>
    </div>
</form>
</body>

</html>