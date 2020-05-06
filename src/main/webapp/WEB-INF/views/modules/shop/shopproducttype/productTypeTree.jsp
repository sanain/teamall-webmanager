<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title></title>
	<meta name="decorator" content="default"/>
	<%@include file="/WEB-INF/views/include/treeview.jsp" %>
	<script type="text/javascript">
		$(document).ready(function(){
	
		    $("#inputForm").validate({
				submitHandler: function(form){
					var ids = [], nodes = tree.getCheckedNodes(true);
					for(var i=0; i<nodes.length; i++) {
						ids.push(nodes[i].id);
					}
					$("#menuIds").val(ids);
					loading('正在提交，请稍等...');
					form.submit();
				}
			});
			function zTreeOnClick(event, treeId, treeNode) {
             };
			var setting = {
				check:{enable:false,nocheckInherit:true},
				view:{selectedMulti:false},
				edit:{enable: true,editNameSelectAll:true,removeTitle:"删除",renameTitle:"重命名"
					},
				data:{
				keep:{parent:true,leaf:true},
				simpleData:{enable:true}
				},
				callback:{
					beforeRemove:beforeRemove,//点击删除时触发，用来提示用户是否确定删除
	                //beforeEditName: beforeEditName,//点击编辑时触发，用来判断该节点是否能编辑
					onClick:zTreeOnClick,
				}
			};
			function beforeRemove(e,treeId,treeNode){
				return confirm("你确定要删除吗？");
				}
			// 菜单
			var zNodes=[
				<c:forEach items="${productTypes}" var="menu">
					{id:"${menu.id}", pId:"${menu.parentId}", name:"${menu.productTypeName}",url:"${url}${menu.id}",target:"right"},
	            </c:forEach>];
			var tree = $.fn.zTree.init($("#menuTree"), setting, zNodes);
			// 默认选择节点
	 	    var ids = "";
			for(var i=0; i<ids.length; i++) {
				var node = tree.getNodeByParam("id", ids[i]);
				try{tree.checkNode(node, true, false);}catch(e){}
			} 
			// 默认展开全部节点
			tree.expandAll(false);
		});
		
	</script>
	<style>
	
	</style>
	
      </head>
               <body style="width: 100%; height: 100%">
  				 <div id="menuTree" class="ztree" style="margin-top:3px;float:left;"></div>
              </body>
        </html>