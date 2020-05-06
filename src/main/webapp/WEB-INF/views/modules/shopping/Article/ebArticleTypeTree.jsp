<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title></title>
	<meta name="decorator" content="default"/>
	<%@include file="/WEB-INF/views/include/treeview.jsp" %>
	<script src="${ctxStatic}/jquery-ztree/3.5.12/js/jquery.ztree.exedit-3.5.min.js" type="text/javascript"></script>
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
				var url="${url}"+treeNode.id+"&f=1";
				var frame = window.parent.document.getElementById("right"); 
				frame.setAttribute("src", url); 
             };
			var setting = {
				check:{enable:false,nocheckInherit:true},
				view:{selectedMulti:false},
				edit:{enable: false,showRenameBtn:false,editNameSelectAll:true,removeTitle:"删除",renameTitle:"重命名"
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
				return confirmx('确认要删除吗？', "${ctxsys}/ebArticleType/delete?id="+ treeId.id+"");
				}
			// 菜单
			var zNodes=[
				<c:forEach items="${ebArticleTypes}" var="menu">
					{id:"${menu.articleTypeId}", pId:"${menu.parentId}", name:"${menu.articleTypeName}",url:"${url}${menu.articleTypeId}",target:"right"},
	            </c:forEach>];
			var tree = $.fn.zTree.init($("#menuTree"), setting, zNodes);
			// 默认选择节点
	 	    var ids = "";
			for(var i=0; i<ids.length; i++) {
				var node = tree.getNodeByParam("id", ids[i]);
				try{tree.checkNode(node, true, false);}catch(e){}
			} 
			// 默认展开全部节点
			tree.expandAll(true);
		});
		
	</script>
	<style>
	</style>
      </head>
               <body style="width: 100%; height: 100%">
  				 <div id="menuTree" class="ztree" style="margin-top:3px;float:left;"></div>
              </body>
        </html>