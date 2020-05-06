<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="robots" content="noarchive">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0,minimal-ui">
    <title>${fns:getProjectName()}仓库中心</title>
    <link rel="stylesheet" href="${ctxStatic}/supplyshop/css/index.css">
    <link rel="stylesheet" href="${ctxStatic}/supplyshop/css/bootstrap.min.css">
    <script src="${ctxStatic}/supplyshop/js/jquery.min.js"></script>
    <script src="${ctxStatic}/supplyshop/js/issue-classification.js"></script>
</head>
<body style="background: #E3E4E5;">
    <!--头部固定-->
    <div class="head">
    	<ul class="list-ul" style="padding-left: 10px">
                <li style="width: 300px;">
                  <span style="margin-left: 20px; font-size: 20px; color: #ffffff;">${fns:getProjectName()}-${ebWarehouseUser.wareName}</span>
                </li>
                
            </ul>
    
        <ul>
            <li>您好！<span>${ebWarehouseUser.account}</span>，欢迎来到${fns:getProjectName()}-仓库派送管理中心</li>
            <li>
                <a class="quit-a" href="${ctxweb}/ebWarehouseItem/outLogin">退出登录</a>
            </li>
        </ul>
    </div>
		
 		<iframe name="tager" src="${ctxweb}/ebWarehouseItem/ebWarehouseorderlist" frameborder="0" style="width: 100%;padding: 80px 20px 0 20px;background: #E3E4E5;"></iframe>
 </body>
</html>