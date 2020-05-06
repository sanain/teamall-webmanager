<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0,minimal-ui">
    <meta name="Description" content="${fns:getProjectName()},银行卡详情"/>
	<meta name="Keywords" content="${fns:getProjectName()},银行卡详情"/>
    <title>银行卡详情</title>
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/admin-member-account.css">
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/bootstrap.min.css">
    <link rel="stylesheet" href="${ctxStatic}/tii/tii.css">
    <link href="${ctxStatic}/common/jqsite.min.css" type="text/css" rel="stylesheet" />
    <script src="${ctxStatic}/common/jqsite.min.js" type="text/javascript"></script>
    <script src="${ctxStatic}/sbShop/js/jquery.min.js"></script>
    <script src="${ctxStatic}/tii/tii.js"></script>
</head>
<body>
    <div class="c-context">
      <ul class="nav-ul">
          <li><a href="${ctxsys}/User/form?userId=${userId}">会员信息</a></li>
          <li><a href="${ctxsys}/User/userAccount?userId=${userId}">会员账户</a></li>
          <li><a href="${ctxsys}/User/userrelation?userId=${userId}">会员关系</a></li>
          <li><a class="active" href="${ctxsys}/User/userbanks?userId=${userId}">银行卡详情</a><a href="${ctxsys}/User/userAccount?userId=${userId}"><img class="balance-img" src="${ctxStatic}/sbShop/images/xxx-rzt.png" alt=""></a></li>
      </ul>
      <form id="" method="post" class="breadcrumb form-search">
       <div class="bank">
            <div class="bank-list">
                <ul>
                    <li>添加时间</li>
                    <li>开户行</li>
                    <li>所属支行</li>
                    <li>卡号</li>
                    <li>手机号</li>
                    <li>操作</li>
                </ul>
                <div class="list-body">
                  <c:forEach items="${userBanks}" var="userBank">
                    <ul>
                        <li><fmt:formatDate value="${userBank.createTime}" type="both"/></li>
                        <li>${userBank.bankName}</li>
                        <li>${userBank.subbranchName}</li>
                        <li>${userBank.account}</li>
                        <li>${userBank.phoneNum}</li>
                        <li>
                        <c:if test="${userBank.isDefault==1}">
                            <a style="color: #ccc">默认</a>
                        </c:if>
                        <c:if test="${userBank.isDefault==0}">
                            <a onclick="return confirmx('是否设为默认','${ctxsys}/User/bankdefault?userId=${userId}&id=${userBank.id}')">设为默认</a>
                        </c:if>
                        <a onclick="return confirmx('是否删除','${ctxsys}/User/bankdelete?userId=${userId}&id=${userBank.id}')">删除</a>
                        </li>
                    </ul>
                 </c:forEach>
                </div>
            </div>
        </div>
     </form>
    </div>
<div class="tii">
	<span class="tii-img"></span>
	<span class="message" data-tid="${message}">${message}</span>
</div>
</body>
</html>