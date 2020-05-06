<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<meta name="decorator" content="default"/>
	<meta name="Description" content="${fns:getProjectName()},退款申请介入"/>
	<meta name="Keywords" content="${fns:getProjectName()},退款申请介入"/>
	<title>退款申请介入</title>
	<style>
        .mar-right{
            float:left;width: 50%
        }
    </style>
    <script type="text/javascript">
    $(document).ready(function() {
		$("#name").focus();
		$("#inputForm").validate({
			submitHandler: function(form){
				loading('正在提交，请稍等...');
				form.submit();
			}
		});
	});
    </script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctxsys}/ReturnGoodIntervene">退款申请介入列表</a></li>
		<li class="active"><a href="${ctxsys}/ReturnGoodIntervene/form?id=${pmReturnGoodIntervene.id}">退款申请介入</a></li>
	</ul><br/>
	 <form id="inputForm" modelAttribute="pmReturnGoodIntervene" action="${ctxsys}/ReturnGoodIntervene/edit" method="post" class="form-horizontal">
		<input id="id" name="id" type="hidden" value="${pmReturnGoodIntervene.id}"/>
		<tags:message content="${message}"/>
		<div class="control-group">
	        <div class="mar-right">
	            <label class="control-label">退款编号:</label>
	            <div class="controls">${pmReturnGoodIntervene.aftersale.saleNo}</div>
	        </div>
	        <div class="mar-right">
	            <label class="control-label">介入状态:</label>
	            <div class="controls">
	            	<c:if test="${pmReturnGoodIntervene.interveneStatus==1}">买家申请介入</c:if>
	            	<c:if test="${pmReturnGoodIntervene.interveneStatus==2}">卖家申请介入</c:if>
	            	<c:if test="${pmReturnGoodIntervene.interveneStatus==3}">平台客服处理中</c:if>
	            	<c:if test="${pmReturnGoodIntervene.interveneStatus==4}">平台客服已完成处理</c:if>
				</div>
	        </div>
	    </div>
	    <div class="control-group">
	        <div class="mar-right">
	            <label class="control-label">用&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;户:</label>
	            <div class="controls">${pmReturnGoodIntervene.user.username}</div>
	        </div>
	        <div class="mar-right">
	            <label class="control-label">商&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;家:</label>
	            <div class="controls">${pmReturnGoodIntervene.shopInfo.shopName}</div>
	        </div>
	    </div>
	    <div class="control-group">
	        <div class="mar-right">
	            <label class="control-label">用户问题描述:</label>
	            <div class="controls"><textarea disabled="disabled">${pmReturnGoodIntervene.userProblemDesc}</textarea></div>
	        </div>
	        <div class="mar-right">
	            <label class="control-label">商家问题描述:</label>
	            <div class="controls"><textarea disabled="disabled">${pmReturnGoodIntervene.shopProblemDesc}</textarea></div>
	        </div>
	    </div>
	    <div class="control-group">
	        <div class="mar-right">
	            <label class="control-label">用户凭证图片:</label>
	            <div class="controls">
	               <c:forEach items="${pmReturnGoodIntervene.userEvidencePicUrlList}" var="e">
								<img src="http://pmsc.5g88.com/${e}" width="200px" height="200px">
                   </c:forEach>  
                </div>
	        </div>
	        <div class="mar-right">
	            <label class="control-label">商家凭证图片:</label>
	            <div class="controls">
	              <c:forEach items="${pmReturnGoodIntervene.shopEvidencePicUrlList}" var="a">
								<img src="http://pmsc.5g88.com/${a}" width="200px" height="200px">
                   </c:forEach>  
	            </div>
	        </div>
	    </div>
	    <div class="control-group">
	        <div class="mar-right">
	            <label class="control-label">用户提交时间:</label>
	            <div class="controls"><fmt:formatDate value="${pmReturnGoodIntervene.userSubmitTime}" type="both"/></div>
	        </div>
	        <div class="mar-right">
	            <label class="control-label">商家提交时间:</label>
	            <div class="controls"><fmt:formatDate value="${pmReturnGoodIntervene.shopSubmitTime}" type="both"/></div>
	        </div>
	    </div>
	    <div class="control-group">
	        <div class="mar-right">
	            <label class="control-label">处理结果:</label>
	            <div class="controls">
	            	<textarea id="treatmentResults" name="treatmentResults">${pmReturnGoodIntervene.treatmentResults}</textarea>
	            </div>
	        </div>
	        <div class="mar-right">
	            <label class="control-label">判决理由:</label>
	            <div class="controls">
	            	<textarea id="judgmentReason" name="judgmentReason">${pmReturnGoodIntervene.judgmentReason}</textarea>
	            </div>
	        </div>
	    </div>
	    <div class="control-group">
	        <div class="mar-right">
	            <label class="control-label">创建时间:</label>
	            <div class="controls"><fmt:formatDate value="${pmReturnGoodIntervene.createTime}" type="both"/></div>
	        </div>
	        <div class="mar-right">
	            <label class="control-label">跟新时间:</label>
	            <div class="controls"><fmt:formatDate value="${pmReturnGoodIntervene.updateTime}" type="both"/></div>
	        </div>
	    </div>
	    <div class="form-actions">
	   	 <c:if test="${pmReturnGoodIntervene.interveneStatus<4}">
	        <input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;
	     </c:if>
	        <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
	    </div>
	</form> 
</body>
</html>