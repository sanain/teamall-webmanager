<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <style>
        .div-box{margin: 20px;color: #666666;border: 1px solid #DCDCDC}
        .div-box ul{overflow: hidden;list-style: none;margin: 0;padding: 0}
        .div-box ul li{float: left;text-align: center;height: auto;line-height: 30px;}
        .div-box ul li:nth-child(1){width: 10%}
        .div-box ul li:nth-child(2){width: 15%}
        .div-box ul li:nth-child(3){width: 20%}
        .div-box ul li:nth-child(4){width: 30%}
        .div-box ul li:nth-child(5){width: 25%}
        .ul-top{background: #f5f5f5}
        .ul-top li{color: #333333}
        .list-box ul:nth-child(even){background: #f0f0f0}
    </style>
</head>
<body>
    <div class="div-box">
        <ul class="ul-top">
            <li></li>
            <li>金额</li>
            <li>收款方</li>
            <li>备注</li>
            <li>创建时间</li>
        </ul>
        <div class="list-box">
        <c:if test="${pmAmtLog!=null && fn:length(pmAmtLog) > 0}">
         <c:forEach items="${pmAmtLog}" var="pmAmtLog" varStatus="status1">
            <ul>
                <li>${status1.index}</li>
                <li><fmt:formatNumber type="number" value="${pmAmtLog.amt}" pattern="0.00" maxFractionDigits="4"/> </li>
                <li>${fns:replaceUserIdShopShoppingFlagName(pmAmtLog.userId)}</li>
                <li>${pmAmtLog.remark}</li>
                <li>${pmAmtLog.createTime}</li>
            </ul>
            </c:forEach>
          </c:if>
          <c:forEach items="${pmOrderLoveLogs}" var="pmOrderLoveLogs" varStatus="status">
            <ul>
                <li>${status.index+1}</li>
                <li><c:if test="${pmOrderLoveLogs[4]=='1'}"><c:if test="${pmOrderLoveLogs[5]==1}"></c:if><c:if test="${pmOrderLoveLogs[5]==2}">-</c:if><fmt:formatNumber type="number" value="${pmOrderLoveLogs[0]}" pattern="0.0000" maxFractionDigits="4"/> </c:if>
                    <c:if test="${pmOrderLoveLogs[4]=='2'}"><c:if test="${pmOrderLoveLogs[5]==1}"></c:if><c:if test="${pmOrderLoveLogs[5]==2}">-</c:if><fmt:formatNumber type="number" value="${pmOrderLoveLogs[0]}" pattern="0.00" maxFractionDigits="2"/> </c:if>
                </li>
                <li>${fns:replaceMobile(pmOrderLoveLogs[3])}</li>
                <li>${pmOrderLoveLogs[1]}</li>
                <li>${pmOrderLoveLogs[2]}</li>
            </ul>
            </c:forEach>
        </div>
    </div>
</body>
</html>
