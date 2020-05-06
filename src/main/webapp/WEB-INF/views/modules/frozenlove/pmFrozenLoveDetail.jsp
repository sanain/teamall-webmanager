<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
  <head>
    <title>详情</title>
    <meta name="decorator" content="default"/>
  </head>
  <body>
    <div style="width:1000px; margin:15px 15px;">
        <h1 style="text-align: center;">操作结果 </h1><br>
         <ul class="nav nav-tabs">
		   <li><h4 style="color:gray;"></h4></li>
		   <li style="padding-left: 65%;"> <h5>创建时间 :<fmt:formatDate value="${pmFrozenLoveOperateLog.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></h5></li>
	     </ul>
        <p style="word-wrap: break-word;">${pmFrozenLoveOperateLog.operateReason}</p>
        <div class="form-actions">
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)" readonly="readonly">
		</div>
    </div>
  </body>
</html>   