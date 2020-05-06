<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<meta name="decorator" content="default"/>
	<title>记录列表</title>
	<script type="text/javascript">
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").attr("action","${ctxsys}/pmSysLoveLevelLog");
			$("#searchForm").submit();
	    	return false;
	    }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctxsys}/pmSysLoveLevelLog">每日积分级别数日志列表</a></li>
	</ul>
	 <form:form id="searchForm" modelAttribute="pmSysLoveLevelLog" action="${ctxsys}/pmSysLoveLevelLog" method="post" class="breadcrumb form-search ">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
		<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form"><%--
		 <li><label>用户名称:</label><form:input path="userNames" htmlEscape="false" maxlength="60" class="input-medium"  placeholder="请输入用户名称"/></li>
		 <li><label>用户手机:</label><form:input path="mobiles" htmlEscape="false" maxlength="60" class="input-medium"  placeholder="请输入用户手机"/></li>
		  
		    <li><label>暂缓类型:</label>
		       <form:select path="frozenType" class="input-medium">
		         <form:option value="">全部</form:option>
		         <form:option value="1">所有当前积分数</form:option>
		         <form:option value="2">指定积分数</form:option>
		         <form:option value="3">指定时间积分数</form:option>
		         <form:option value="4">指定当前积分比例</form:option>
		       </form:select>
		    </li>
		    <li><label>积分角色:</label>
		       <form:select path="gainLoveRole" class="input-medium">
		         <form:option value="">全部</form:option>
		         <form:option value="1">买家</form:option>
		         <form:option value="2">商家</form:option>
		       </form:select>
		    </li>  
		    <li><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/></li>--%>
		</ul>
	</form:form> 
	<tags:message content="${message}"/>
	<div style="margin:0 auto;overflow-x:auto">
	<table id="treeTable" class="table table-striped table-condensed">
		<tr>
		 <th>创建时间</th>
		 <th>零级积分数</th>
		 <th>零级是否可激励</th>
		 <th>零级时间范围</th>
		 <th>一级积分数</th>
		 <th>一级是否可激励</th>
		 <th>一级时间范围</th>
		 <th>二级积分数</th>
		 <th>二级是否可激励</th>
		 <th>二级时间范围</th>
		 <th>三级积分数</th>
		 <th>三级是否可激励</th>
		 <th>三级时间范围</th>
		 <th>四级积分数</th>
		 <th>四级是否可激励</th>
		 <th>四级时间范围</th>
		 <th>五级积分数</th>
		 <th>五级是否可激励</th>
		 <th>五级时间范围</th>
		 <th>六级积分数</th>
		 <th>六级是否可激励</th>
		 <th>六级时间范围</th>
		 <th>七级积分数</th>
		 <th>七级是否可激励</th>
		 <th>七级时间范围</th>
		 <th>八级积分数</th>
		 <th>八级是否可激励</th>
		 <th>八级时间范围</th>
		 <th>九级积分数</th>
		 <th>九级是否可激励</th>
		 <th>九级时间范围</th>
		 <th>十级积分数</th>
		 <th>十级是否可激励</th>
		 <th>十级时间范围</th>
		 <th>十一级积分数</th>
		 <th>十一级是否可激励</th>
		 <th>十一级时间范围</th>
		 <th>十二级积分数</th>
		 <th>十二级是否可激励</th>
		 <th>十二级时间范围</th>
		 <th>十三级积分数</th>
		 <th>十三级是否可激励</th>
		 <th>十三级时间范围</th>
		 <th>十四级积分数</th>
		 <th>十四级是否可激励</th>
		 <th>十四级时间范围</th>
		 <th>十五级积分数</th>
		 <th>十五级是否可激励</th>
		 <th>十五级时间范围</th>
		 <th>十六级积分数</th>
		 <th>十六级是否可激励</th>
		 <th>十六级时间范围</th>
		 <th>十七级积分数</th>
		 <th>十七级是否可激励</th>
		 <th>十七级时间范围</th>
		 <th>十八级积分数</th>
		 <th>十八级是否可激励</th>
		 <th>十八级时间范围</th>
		 <th>十九级积分数</th>
		 <th>十九级是否可激励</th>
		 <th>十九级时间范围</th>
		</tr>
		<c:forEach items="${page.list}" var="log">
			<tr>
				<td><fmt:formatDate value="${log.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				<td><fmt:formatNumber type="number" value="${log.level0Love}" pattern="0.0000" maxFractionDigits="4"/></td>
			    <td>
			    	<c:if test="${log.level0LoveIsStimulate==0}">否</c:if>
			    	<c:if test="${log.level0LoveIsStimulate==1}">是</c:if>
 				</td>
			    <td>${log.level0Dates}</td>
			    
				<td><fmt:formatNumber type="number" value="${log.level1Love}" pattern="0.0000" maxFractionDigits="4"/></td>
			    <td>
			    	<c:if test="${log.level1LoveIsStimulate==0}">否</c:if>
			    	<c:if test="${log.level1LoveIsStimulate==1}">是</c:if>
 				</td>
			    <td>${log.level1Dates}</td>
			    
				<td><fmt:formatNumber type="number" value="${log.level2Love}" pattern="0.0000" maxFractionDigits="4"/></td>
			    <td>
			    	<c:if test="${log.level2LoveIsStimulate==0}">否</c:if>
			    	<c:if test="${log.level2LoveIsStimulate==1}">是</c:if>
 				</td>
			    <td>${log.level2Dates}</td>
			    
				<td><fmt:formatNumber type="number" value="${log.level3Love}" pattern="0.0000" maxFractionDigits="4"/></td>
			    <td>
			    	<c:if test="${log.level3LoveIsStimulate==0}">否</c:if>
			    	<c:if test="${log.level3LoveIsStimulate==1}">是</c:if>
 				</td>
			    <td>${log.level3Dates}</td>
			    
				<td><fmt:formatNumber type="number" value="${log.level4Love}" pattern="0.0000" maxFractionDigits="4"/></td>
			    <td>
			    	<c:if test="${log.level4LoveIsStimulate==0}">否</c:if>
			    	<c:if test="${log.level4LoveIsStimulate==1}">是</c:if>
 				</td>
			    <td>${log.level4Dates}</td>
			    
				<td><fmt:formatNumber type="number" value="${log.level5Love}" pattern="0.0000" maxFractionDigits="4"/></td>
			    <td>
			    	<c:if test="${log.level5LoveIsStimulate==0}">否</c:if>
			    	<c:if test="${log.level5LoveIsStimulate==1}">是</c:if>
 				</td>
			    <td>${log.level5Dates}</td>
			    
				<td><fmt:formatNumber type="number" value="${log.level6Love}" pattern="0.0000" maxFractionDigits="4"/></td>
			    <td>
			    	<c:if test="${log.level6LoveIsStimulate==0}">否</c:if>
			    	<c:if test="${log.level6LoveIsStimulate==1}">是</c:if>
 				</td>
			    <td>${log.level6Dates}</td>
			    
				<td><fmt:formatNumber type="number" value="${log.level7Love}" pattern="0.0000" maxFractionDigits="4"/></td>
			    <td>
			    	<c:if test="${log.level7LoveIsStimulate==0}">否</c:if>
			    	<c:if test="${log.level7LoveIsStimulate==1}">是</c:if>
 				</td>
			    <td>${log.level7Dates}</td>
			    
				<td><fmt:formatNumber type="number" value="${log.level8Love}" pattern="0.0000" maxFractionDigits="4"/></td>
			    <td>
			    	<c:if test="${log.level8LoveIsStimulate==0}">否</c:if>
			    	<c:if test="${log.level8LoveIsStimulate==1}">是</c:if>
 				</td>
			    <td>${log.level8Dates}</td>
			    
				<td><fmt:formatNumber type="number" value="${log.level9Love}" pattern="0.0000" maxFractionDigits="4"/></td>
			    <td>
			    	<c:if test="${log.level9LoveIsStimulate==0}">否</c:if>
			    	<c:if test="${log.level9LoveIsStimulate==1}">是</c:if>
 				</td>
			    <td>${log.level9Dates}</td>
			    
				<td><fmt:formatNumber type="number" value="${log.level10Love}" pattern="0.0000" maxFractionDigits="4"/></td>
			    <td>
			    	<c:if test="${log.level10LoveIsStimulate==0}">否</c:if>
			    	<c:if test="${log.level10LoveIsStimulate==1}">是</c:if>
 				</td>
			    <td>${log.level10Dates}</td>
			    
				<td><fmt:formatNumber type="number" value="${log.level11Love}" pattern="0.0000" maxFractionDigits="4"/></td>
			    <td>
			    	<c:if test="${log.level11LoveIsStimulate==0}">否</c:if>
			    	<c:if test="${log.level11LoveIsStimulate==1}">是</c:if>
 				</td>
			    <td>${log.level11Dates}</td>
			    
				<td><fmt:formatNumber type="number" value="${log.level12Love}" pattern="0.0000" maxFractionDigits="4"/></td>
			    <td>
			    	<c:if test="${log.level12LoveIsStimulate==0}">否</c:if>
			    	<c:if test="${log.level12LoveIsStimulate==1}">是</c:if>
 				</td>
			    <td>${log.level12Dates}</td>
			    
				<td><fmt:formatNumber type="number" value="${log.level13Love}" pattern="0.0000" maxFractionDigits="4"/></td>
			    <td>
			    	<c:if test="${log.level13LoveIsStimulate==0}">否</c:if>
			    	<c:if test="${log.level13LoveIsStimulate==1}">是</c:if>
 				</td>
			    <td>${log.level13Dates}</td>
			    
				<td><fmt:formatNumber type="number" value="${log.level14Love}" pattern="0.0000" maxFractionDigits="4"/></td>
			    <td>
			    	<c:if test="${log.level14LoveIsStimulate==0}">否</c:if>
			    	<c:if test="${log.level14LoveIsStimulate==1}">是</c:if>
 				</td>
			    <td>${log.level14Dates}</td>
			    
				<td><fmt:formatNumber type="number" value="${log.level15Love}" pattern="0.0000" maxFractionDigits="4"/></td>
			    <td>
			    	<c:if test="${log.level15LoveIsStimulate==0}">否</c:if>
			    	<c:if test="${log.level15LoveIsStimulate==1}">是</c:if>
 				</td>
			    <td>${log.level15Dates}</td>
			    
				<td><fmt:formatNumber type="number" value="${log.level16Love}" pattern="0.0000" maxFractionDigits="4"/></td>
			    <td>
			    	<c:if test="${log.level16LoveIsStimulate==0}">否</c:if>
			    	<c:if test="${log.level16LoveIsStimulate==1}">是</c:if>
 				</td>
			    <td>${log.level16Dates}</td>
			    
				<td><fmt:formatNumber type="number" value="${log.level17Love}" pattern="0.0000" maxFractionDigits="4"/></td>
			    <td>
			    	<c:if test="${log.level17LoveIsStimulate==0}">否</c:if>
			    	<c:if test="${log.level17LoveIsStimulate==1}">是</c:if>
 				</td>
			    <td>${log.level17Dates}</td>
			    
				<td><fmt:formatNumber type="number" value="${log.level18Love}" pattern="0.0000" maxFractionDigits="4"/></td>
			    <td>
			    	<c:if test="${log.level18LoveIsStimulate==0}">否</c:if>
			    	<c:if test="${log.level18LoveIsStimulate==1}">是</c:if>
 				</td>
			    <td>${log.level18Dates}</td>
			    
				<td><fmt:formatNumber type="number" value="${log.level19Love}" pattern="0.0000" maxFractionDigits="4"/></td>
			    <td>
			    	<c:if test="${log.level19LoveIsStimulate==0}">否</c:if>
			    	<c:if test="${log.level19LoveIsStimulate==1}">是</c:if>
 				</td>
			    <td>${log.level19Dates}</td>
			    
			</tr>
		</c:forEach>
	</table>
	</div>
	
	<div class="pagination">${page}</div>
</body>
</html>