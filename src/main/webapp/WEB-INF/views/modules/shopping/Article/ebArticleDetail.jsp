<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
  <head>
    <title>文章详情</title>
    <meta name="decorator" content="default"/>
  </head>
  <body>
    <div style="width:1000px; margin:15px 15px;">
        <h1 style="text-align: center;">${ebArticle.articleTitle}</h1><br>
         <ul class="nav nav-tabs">
		   <li><h4 style="color:gray;">作者 ：${ebArticle.articleAuthor}</h4></li>
		   <li style="padding-left: 65%;"> <h5>发布时间 :<fmt:formatDate value="${ebArticle.releasetime}" pattern="yyyy-MM-dd HH:mm:ss"/></h5></li>
	     </ul>
        <p>${ebArticle.articleContent}</p>
        <div class="form-actions">
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)" readonly="readonly">
		</div>
    </div>
  </body>
</html>   