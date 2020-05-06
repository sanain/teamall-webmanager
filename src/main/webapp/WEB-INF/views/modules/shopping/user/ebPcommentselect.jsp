<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>商品添加</title>
	<link href="http://cdn.bootcss.com/bootstrap/3.1.0/css/bootstrap.css" rel="stylesheet">
	<meta name="decorator" content="default"/>
  <script type="text/javascript">
		$(document).ready(function() {
			$("#treeTable").treeTable({expandLevel : 5});
			$(document).ready(function() {
			$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});
		});
					});
	 	</script>
</head>
<body style="font-size: 13px;">
 
     <ul class="nav nav-tabs">
	    <li class="active"><a>评论查看</a></li>
	</ul>
	<form:form  modelAttribute="ebProductcomment"  action="${ctxsys}/ebPcommentContorller/save" method="post" class="form-horizontal">
		<div class="container" style="width: 100%;">
	<div class="row clearfix">
		<div class="col-md-12 column">
			<div class="panel panel-info">
				<div class="panel-heading">
					<h3 class="panel-title">
						评论详情
					</h3>
				</div>
				<div class="panel-body">
					             评论时间:${ebProductcomment.commentTime}
				</div>
				<div class="panel-footer">
					             评论分数:${ebProductcomment.point}
				</div>
				<div class="panel-body">
					               规格:${ebProductcomment.productname}
				</div>
				<div class="panel-footer">
					               用户:${ebProductcomment.username}
				</div>
				<div class="panel-body">
					     <c:forEach items="${ebProductimages}" var="ebProductimages">
					         <img alt="" src="${ebProductimages.name}" style=" width:100; height:100px;" />
					      </c:forEach>
					             
				</div>
			</div>
		</div>
	</div>
</div>
	</form:form>

</body>
</html>