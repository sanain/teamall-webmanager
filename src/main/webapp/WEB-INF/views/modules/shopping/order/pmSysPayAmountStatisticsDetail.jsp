<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ include file="/WEB-INF/views/include/head.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>系统当天实时支付金额统计</title>
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/platform-configuration.css">
     <style>
        .fix-in{position: fixed;top: 0;right: 0;left: 0;bottom: 0;background: rgba(0,0,0,0.3);display:none;}
        .fix-box{position: absolute;width: 400px;height: 200px;background: #ffffff;top: 50%;left: 50%;margin-top: -100px;margin-left: -200px}
        .fix-box>p{height: 35px;line-height: 35px;text-align: center;color: #333333;margin-bottom: 0;background: #f0f0f0;position: relative}
        .fix-box>p img{position: absolute;top: 12px;right: 15px;;cursor: pointer}
        .fix-box ul{list-style: none;padding: 0;color: #666666;margin-bottom: 0;margin-top: 15px}
        .fix-box ul li{line-height: 30px;margin-bottom: 5px}
        .fix-box ul span{width: 150px;text-align: right;display: inline-block}
        .fix-txt{text-align: center;margin-top:30px;}
        .fix-box ul b{font-weight: normal}
        .fix-box ul input{height: 30px;border: 1px solid #dcdcdc;border-radius: 3px;}
        .fix-btn{text-align: center;margin-top: 30px}
        .fix-btn a{display: inline-block;height: 30px;line-height: 30px;padding: 0 15px;background: #69AC72;color: #ffffff;border-radius: 5px;text-decoration: none}
        .fix-btn a:nth-child(1){margin-right: 10px}
        .fix-btn a:nth-child(2){background: #ffffff;border: 1px solid #dcdcdc;color: #666666;margin-left: 10px}
    </style>
    <script>
    $(document).ready(function() {
    		$('.fix-del').click(function(){
    			$('.fix-in').hide();
    		});
    		
    	});
    	
		function btn(){
			window.location='${ctxsys}/pmSysPayAmountStatistics/list';
		}
    </script>
</head>
<body>
<div class="form-horizontal">
    <div class="platform">
        <p>系统当天实时支付金额统计    (${startTime}--${endTime})</p>
        <div class="platform-list">
            <ul style="width: 20%;">
                <li>预计总收入：</li>
                <li><fmt:formatNumber type="number" value="${pmSysPayAmountStatistics.estimatedRevenue}" pattern="0.00" maxFractionDigits="2"/></li>
            </ul>
            <ul style="width: 20%;">
                <li>预计让利款：</li>
                <li><fmt:formatNumber type="number" value="${pmSysPayAmountStatistics.expectedAssignment}" pattern="0.00" maxFractionDigits="2"/></li>
            </ul>
            
            <ul style="width: 20%;">
                <li>实际总收入：</li>
                <li><fmt:formatNumber type="number" value="${pmSysPayAmountStatistics.realityRevenue}" pattern="0.00" maxFractionDigits="2"/></li>
            </ul>
            <ul style="width: 20%;">
                <li>实际让利款：</li>
                <li><fmt:formatNumber type="number" value="${pmSysPayAmountStatistics.realityAssignment}" pattern="0.00" maxFractionDigits="2"/></li>
            </ul>
            
         </div>
        </div>
      </div>    
<div class="form-horizontal">
    <div class="platform">
        <p>各支付通道金额统计</p>
        <div class="platform-list">
        <c:forEach items="${map}" var="pc" varStatus="i">
			<ul style="width: 20%;">
                <li> ${pc.value }</li>
            </ul>
	    </c:forEach>
        </div>
         <a class="pla-btn" href="javascript:;" onclick="btn();" style="position: relative;left: 22%;background: rgb(105, 172, 114);">查看更多</a>
    </div>
</div>
</body>
</html>