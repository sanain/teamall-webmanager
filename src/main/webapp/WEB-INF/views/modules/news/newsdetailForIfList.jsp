<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>文章内容管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#allchkbtn").click(function(){
				
				if($(this).attr("checked")) {
					$("input:checkbox[name='chktypes']").attr("checked",'true');//全选
				} else {
					$("input:checkbox[name='chktypes']").removeAttr("checked");
				}
			});
		});
		function page(n,s){
			if(n) $("#pageNo").val(n);
			if(s) $("#pageSize").val(s);
			$("#searchForm").attr("action","${ctxsys}/news/newsdetail/listForIf");
			$("#searchForm").submit();
	    	return false;
	    }
	    
	    function statusApproval(st){
		   var ids="";
		   var msg = "";
		   var iserr = false;
			$("input:checkbox:checked[name='chktypes']").each(function(){
			 	var curval = $(this).val();
			 	var stval = $("#st" + curval).val();
			 	// 提交审核
			 	if (1 == st) {
			 		msg = "提交审核成功！";
			 		if (stval == "1" || stval == "2") {
			 			alert("错误：待审核  和  正式发布 的数据不能提交审核！");
			 			iserr = true;
			 			return;
			 		}
			 	} else if (2 == st) {
			 		msg = "审核通过成功！";
			 		if (stval != "1") {
			 			alert("错误：只有  待审核 的数据才能审核通过！");
			 			iserr = true;
			 			return;
			 		}
			 	}
			 	ids += curval + ",";
			});
			if (iserr) {
				return;
			}
			if ("" == ids) {
				alert("错误：请勾选需要提交的数据！");
			 	return;
			}
			// 提交保存
			$.ajax({
	 					url : "${ctxsys}/news/newsdetail/statusApproval",
	 					type : 'post',
	 					data : {
	 						ids : ids,
	 						status: st
	 					},
	 					cache : false,
	 					success : function(data) {
	 						// 保存成功
	 						if(data.success){
	 							top.$.jBox.tip(msg, 'info');
	 							// 保存完成后重新查询
	 							page();
	 						} else {
	 							top.$.jBox.tip(data.msg, 'info');
	 						}
	 					}
	 				});
	    }
	    
	    function docheck(){
	    	var allcheck = true;
	    	$("input:checkbox[name='chktypes']").each(function(){
				if($(this).attr("checked")) {
				} else {
					allcheck = false;
				}
			});
			if ($("#allchkbtn").attr("checked")) {
				if (!allcheck) {
					$("#allchkbtn").removeAttr("checked");
				}
			} else {
				if (allcheck) {
					$("#allchkbtn").attr("checked",'true');
				}
			}
	    }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctxsys}/news/newsdetail/listForIf">医院资讯内容列表</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="newsdetail" action="${ctxsys}/news/newsdetail/listForIf" method="post" class="breadcrumb form-search ">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<input id="newstypeid.newstypeid" name="newstypeid.newstypeid" type="hidden" value="${newstypeid}"/>
		<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form">
			<li><label>标题：</label><form:input path="newsdetailtitle" htmlEscape="false" maxlength="50" class="input-medium"/></li>
			<li><label>医院名称：</label><form:input path="hospitalid.name" htmlEscape="false" maxlength="50" class="input-medium"/></li>
			<li><label>状态：</label><form:select id="status" path="status" class="input-small"><form:option value="" label=""/><form:options items="${fns:getDictList('newsdetail_status')}" itemLabel="label" itemValue="value" htmlEscape="false" /></form:select></li>
			<li><label>分类：</label><form:select id="newsdetailclassify" path="newsdetailclassify" class="input-small"><form:option value="" label=""/><form:options items="${fns:getDictList('newsdetailclassify')}" itemLabel="label" itemValue="value" htmlEscape="false" /></form:select></li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/>
			</li>
			<li class="clearfix"></li>
			<li class="btns"><input id="statusAppbtn1" class="btn btn-primary" type="button" value="提交审核" onclick="statusApproval(1);"/></li>
			<shiro:hasPermission name="news:newsdetail:approval">
			<li class="btns"><input id="statusAppbtn2" class="btn btn-primary" type="button" value="审核通过" onclick="statusApproval(2);"/></li>
			</shiro:hasPermission>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<tags:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead><tr><th><input type="checkbox"  id="allchkbtn" /></th><th>栏目</th><th>医院名称</th><th>分类</th><th>状态</th><th>标题</th><th>作者</th><th>引用（来自）</th><th>是否热点</th><th>创建时间</th><th>发布时间</th><shiro:hasPermission name="news:newsdetail:edit"><th>操作</th></shiro:hasPermission></tr></thead>
		<tbody>
		<c:forEach items="${page.list}" var="newsdetail">
			<tr>
				<td><input type="checkbox" name="chktypes"  value="${newsdetail.newsdetailid }"  onclick="docheck();" /></td>
				<td>${newsdetail.newstypeid.newstypename}</td>
				<td>${newsdetail.hospitalid.name}</td>
				<td>${fns:getDictLabel(newsdetail.newsdetailclassify, 'newsdetailclassify', '')}</td>
				<td>${fns:getDictLabel(newsdetail.status, 'newsdetail_status', '')} <input id="st${newsdetail.newsdetailid }"  type="hidden" value="${newsdetail.status}"/></td>
				<td>${newsdetail.newsdetailtitle}</td>
				<td>${newsdetail.newsdetailauthor}</td>
				<td>${newsdetail.newsdetailsfrom}</td>
				<td>${fns:getDictLabel(newsdetail.newsdetailhot, 'newsdetailhot', '')}</td>
				<td><fmt:formatDate value="${newsdetail.newsdetailcreatetime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				<td><fmt:formatDate value="${newsdetail.pubtime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				<shiro:hasPermission name="news:newsdetail:edit"><td>
    				<a href="${ctxsys}/news/newsdetail/formForIf?newsdetailid=${newsdetail.newsdetailid}">修改</a>
    				<a href="${ctxsys}/news/newsdetail/delete?id=${newsdetail.newsdetailid}" onclick="return confirmx('确认要删除该文章吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>