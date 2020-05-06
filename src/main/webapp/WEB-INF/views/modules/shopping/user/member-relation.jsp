<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0,minimal-ui">
    <meta name="Description" content="${fns:getProjectName()},会员关系"/>
	<meta name="Keywords" content="${fns:getProjectName()},会员关系"/>
    <title>会员关系</title>
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/admin-member-relation.css">
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/bootstrap.min.css">
    <link href="${ctxStatic}/jquery-ztree/3.5.12/css/zTreeStyle/zTreeStyle1.min.css" rel="stylesheet" type="text/css"/>
    <script src="${ctxStatic}/sbShop/js/jquery.min.js"></script>
	<script src="${ctxStatic}/jquery-ztree/3.5.12/js/jquery.ztree.core-3.5.min.js" type="text/javascript"></script>
	<script src="${ctxStatic}/jquery-ztree/3.5.12/js/jquery.ztree.excheck-3.5.min.js" type="text/javascript"></script>
	<script src="${ctxStatic}/jquery-ztree/3.5.12/js/jquery.ztree.exhide-3.5.min.js" type="text/javascript"></script>
    <script type="text/javascript">
		$.ajax({
	    	type: "POST",
	        url: "${ctxsys}/User/userNextList",
	        data: {userId:${userId}},
	        success: function(data){
	        var setting = {
				check:{enable:false,nocheckInherit:true},
				view:{selectedMulti:false},
				data:{
					simpleData:{enable:true}
				},
			};
			var zNodes=[data];
			var tree = $.fn.zTree.init($("#menuTree"), setting, data);
			// 默认选择节点
	 	   /*  var ids = "8";
			for(var i=0; i<ids.length; i++) { */
				var node = tree.getNodeByParam("id", "1");
				try{tree.checkNode(node, true, false);}catch(e){
				
				}
			//} 
			// 默认展开全部节点
			tree.expandAll(true);
	        },error: function(XMLHttpRequest, textStatus, errorThrown) {}
		});
    </script>
</head>
<body>
    <div class="c-context">
        <ul class="nav-ul">
            <li><a href="${ctxsys}/User/form?userId=${userId}">会员信息</a></li>
            <li><a href="${ctxsys}/User/userAccount?userId=${userId}">会员账户</a></li>
            <li><a class="active" href="${ctxsys}/User/userrelation?userId=${userId}">会员关系</a></li>
        </ul>
        <div class="context-box-a">
		  <!-- <div class="modal-dialog"> -->
		    <!-- <div class="modal-content"> -->
			  <div class="modal-body">
				<div id="menuTree" class="ztree" style="margin-top:3px;float:left;"></div>
			  </div>
		    <!-- </div> -->
		  <!-- </div> -->
        </div>
    </div>
</body>
</html>