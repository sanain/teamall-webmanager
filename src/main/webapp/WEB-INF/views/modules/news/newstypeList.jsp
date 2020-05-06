<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>栏目管理</title>
	<meta name="decorator" content="default"/>
	<%@include file="/WEB-INF/views/include/treetable.jsp" %>
	<style type="text/css">.table td i{margin:0 2px;}</style>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#treeTable").treeTable({expandLevel : 3});
		});
    	function updateSort() {
			loading('正在提交，请稍等...');
	    	$("#listForm").attr("action", "${ctxsys}/news/newstype/updateSort");
	    	$("#listForm").submit();
    	}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctxsys}/news/newstype/list">栏目列表</a></li>
		<shiro:hasPermission name="news:newstype:edit"><li><a href="${ctxsys}/news/newstype/form">栏目添加</a></li></shiro:hasPermission>
	</ul>
	<tags:message content="${message}"/>
	<form id="listForm" method="post">
		<table id="treeTable" class="table table-striped table-bordered table-condensed">
			<tr><th>名称</th><th>短名</th><th>英文名</th><th>标识</th><th>排序</th><th>是否可用</th><th>类别大图</th><th>类别小图</th><th>类别区分</th><th>操作</th></tr>
			<c:forEach items="${list}" var="newstype">
				<tr id="${newstype.newstypeid}"  pId="${newstype.parent.newstypeid ne '1' ? newstype.parent.newstypeid : '0'}">
					<td>${newstype.newstypename}</td>
					<td>${newstype.newstypeordername}</td>
					<td>${newstype.englishname}</td>
					<td>${fns:getDictLabel(newstype.newstypetag, 'newstypetag', '')}</td>
					<td>${newstype.newstypesort}</td>
					<td>${fns:getDictLabel(newstype.newstypeenable, 'newstypeenable', '')}</td>
					<td><c:if test="${!empty newstype.newstypeiconbig}"><img width="100px" height="60px" src="${newstype.newstypeiconbig}"/></c:if></td>
					<td><c:if test="${!empty newstype.newstypeiconsmall}"><img width="100px" height="60px" src="${newstype.newstypeiconsmall}"/></c:if></td>
					<td>${fns:getDictLabel(newstype.newstypetype, 'newstypetype', '')}</td>
					<td>
						<shiro:hasPermission name="news:newstype:edit">
							<a href="${ctxsys}/news/newstype/form?newstypeid=${newstype.newstypeid}">修改</a>
							<a href="${ctxsys}/news/newstype/delete?id=${newstype.newstypeid}" onclick="return confirmx('确定要删除该栏目吗？', this.href)">删除</a>
							<a href="${ctxsys}/news/newstype/form?parent.newstypeid=${newstype.newstypeid}">添加下级栏目</a>
						</shiro:hasPermission>
					</td>
				</tr>
			</c:forEach>
		</table>
	</form>
</body>
</html>