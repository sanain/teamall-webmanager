<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>评价列表</title>
<meta name="decorator" content="default"/>
<meta name="robots" content="noarchive">
<script>
    $(window.parent.document).find('.list-ul').find('ul').slideUp();
    $(window.parent.document).find('.list-ul').find('a').removeClass('active');
    </script>
	<script type="text/javascript">
	    $(function(){
		 	$('.check1').hide();
	    	$('body').on('click','.check-a1',function(){
	    		$('.check1').show();
	    	});
	    	
	    	$('body').on('click','.check-del1',function(){
	    		$('.check1').hide();
	    	});
	     });
	</script>
	<script type="text/javascript">
	function myModal_d(commentId,recontents){
	$('#commentId').val(commentId);
	$('#recontents').val(recontents);
	}
    $(function(){
     
     $('body').one('click','#saveInfo2',function(){
       
		 if($("#recontents").val()!=null&&$("#recontents").val()!=''){
		  
		    	var commentId=$('#commentId').val();
		    	var recontents=$('#recontents').val();
		 	     $.ajax({
		             type: "POST",
		             url: "${ctxsys}/productcomment/resave",
		             data: {commentId:commentId, recontents:recontents},
		             success: function(data){
						 if(data.code==00){
							alert(data.msg);
							page();
						 }else{
							alert(data.msg);
						 }
		             },error: function(XMLHttpRequest, textStatus, errorThrown) {
		             }
		          });
				}else{
				 alert("回复内容不能为空!");
				return false;
	 }});
	});
	</script>
<script type="text/javascript"> 
$(document).ready(function() {
	selectStar();
});

function checkAll() {
	if ($(".checkAll").is(":checked")) {
        $("input[class=checkRow]:checkbox").prop("checked", true);
    } else {
	    $("input[class=checkRow]:checkbox").prop("checked", false);
    }
}

function checkRow(obj) {
	if ($("#"+obj).is(":checked")) {
		$("input[id="+obj+"]:checkbox").prop("checked", false);
    } else {
    	$("input[id="+obj+"]:checkbox").prop("checked", true);
    }
}

function deleteIds(){
	obj = document.getElementsByName("checkRow");
	check_val = [];
	for(k in obj){
		if(obj[k].checked)
			check_val.push(obj[k].value);
	}
	if(check_val.length==0){
		alert("请选择要删除的");
	}else{
		return confirmx('确认要删除吗？', "${ctxsys}/productcomment/deleteService?ids="+ check_val+"");
}
}


function page(n,s){
	if(n) $("#pageNo").val(n);
	if(s) $("#pageSize").val(s);
	$("#searchForm").attr("action","${ctxsys}/productcomment/list");
	$("#searchForm").submit();
	return false;
}
function selectStar(){
	$("#star").val(${star});
}
</script>     

</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a>评价列表</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="ebProductcomment" action="${ctxsys}/message/list" method="post" class="breadcrumb form-search ">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form">
			  <li><label>门店名称：</label><form:input path="shopName" htmlEscape="false" maxlength="50" class="input-medium"/></li>
			  <li><label>评价人：</label><form:input path="username" htmlEscape="false" maxlength="50" class="input-medium"/></li> 
			  <li><label>评分类型：</label>
                    <select id="star" name="star" class="input-medium">
                        <option value="0">全部评分</option>
                        <option value="5">好评</option>
                        <option value="2">中评</option>
                        <option value="1">差评</option>
                    </select>
                </li>
			  <li class="btns">
			 <input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/>
			 <input id="btnDel" class="btn btn-primary" type="button" onclick="deleteIds()" value="删除" />
			</li>
		</ul>
	</form:form>
	<tags:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<tr>
			<th style="width:3%"><input type="checkbox" class="checkAll" name="checkAll" onclick="checkAll();"/></th>
			  <th style="width:10%">门店名称 </th>
			  <th style="width:12%">商品信息</th>
              <th style="width:5%">评价人</th>
              <th style="width:10%">评价时间</th>
			  <th style="width:3%">评分</th>
              <th style="width:20%">评价内容</th>
              <th style="width:10%">回复时间</th>
              <th style="width:20%">回复内容</th>
			<%-- <shiro:hasPermission name="bsky:product:edit"> --%><th>操作</th><%-- </shiro:hasPermission> --%>
		</tr>
		<c:forEach items="${page.list}" var="pack" varStatus="i">
			<tr id="${pack.commentId}">
				<td><input type="checkbox" value="${pack.commentId}" class="checkRow" name="checkRow"/></td> 
				<td>${pack.shopName}</td>
				<td>${pack.productname}${pack.standName}</td>
               
                <td><c:if test="${pack.userId==0}"><font color="green">${pack.username}</font></c:if><c:if test="${pack.userId!=0}">${pack.username}</c:if></td>
				<td><fmt:formatDate value="${pack.commentTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				 <td>
                	<c:if test="${pack.overallMerit==1}">差评</c:if>
                	<c:if test="${pack.overallMerit==5}">好评</c:if>
                	<c:if test="${pack.overallMerit>=2&&pack.overallMerit<=4}">中评</c:if>
               	</td>
                <td>${pack.contents}</td>
				<td><fmt:formatDate value="${pack.recommentTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				<td>${pack.recontents}</td>
				<td><a onclick="return confirmx('确认要删除吗？', '${ctxsys}/productcomment/delete?id=${pack.commentId}')">删除</a>&nbsp;&nbsp;
				<a href="javascript:;" data-toggle="modal" data-target="#myModal_d" onclick="myModal_d('${pack.commentId}','${pack.recontents}');"><c:if test="${pack.status==1}">修改回复</c:if><c:if test="${empty pack.status||pack.status==0}">回复</c:if></a>
				</td>
			</tr>
		</c:forEach>
	</table>
	<div class="pagination">${page}</div>
<div class="modal fade" id="myModal_d" tabindex="-1" role="dialog">
		  <div class="modal-dialog" role="document">
		  <input type="hidden" id="commentId"/>
		    <div class="modal-content">
		      <div class="modal-header">
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		        <h4 class="modal-title">评论回复</h4>
		        </div>
			        <div class="modal-body">
				        <form id="form3">
				           <p><span></span><textarea id="recontents" name="recontents" style="width:92%;"></textarea></p>
				        </form>
			        </div>
		        <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	        <button type="button" class="btn btn-primary" id="saveInfo2" >回复</button>
	        </div>
		    </div>
		  </div>
		</div>
</body>
</html>