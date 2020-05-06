<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").attr("action","${ctxsys}/PmShopCooperType");
			$("#searchForm").submit();
	    	return false;
	    }
	 
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctxsys}/PmShopCooperType">商户合作分类</a></li>
	</ul>
	 <form:form id="searchForm" modelAttribute="pmShopCooperType" action="${ctxsys}/PmShopCooperType" method="post" class="breadcrumb form-search ">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
		<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		  <input name="shopId" type="hidden" value="${shopId}"/>
		<ul class="ul-form">
		    <li><label>分类名字:</label><input name="name" htmlEscape="false" value="${name}" maxlength="80" class="input-medium"  placeholder=""/></li>
		    <li><label></label><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/></li>
		    <li><label></label><input  class="btn btn-primary" type="button" value="新增" data-toggle="modal" data-target="#myModal" /></li>
		</ul>
	</form:form> 
	<tags:message content="${message}"/>
	<table id="treeTable" class="table table-striped table-condensed">
		<tr>
		 <th class="center123">编号</th>
		 <th class="center123">分类名称</th>
		 <th class="center123">开始时间</th>
		 <th class="center123">结束时间</th>
		 <shiro:hasPermission name="merchandise:pmShopInfo:edit">
		 <th class="center123">操作</th>
		 </shiro:hasPermission></tr>
		<c:forEach items="${page.list}" var="ShopCooperTypeList" varStatus="status">
			<tr>
			    <td class="center123">${status.index+1}</td>
				<td class="center123">${ShopCooperTypeList[1].productTypeName}</td>
				<td class="center123">${ShopCooperTypeList[0].startDate}</td>
			    <td class="center123">${ShopCooperTypeList[0].endDate}</td>
			    <shiro:hasPermission name="merchandise:pmShopInfo:edit">
			    <td class="center123">
					<a href="${ctxsys}/PmShopCooperType/delete?id=${ShopCooperTypeList[0].id}"  onclick="return confirmx('要删除该区域及所有子区域项吗？', this.href)">删除</a>
				</td>
				</shiro:hasPermission>
			</tr>
		</c:forEach>
	</table>
	<div class="pagination">${page}</div>
	
	
	
	
<div class="modal fade" id="myModal" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">数据审核</h4>
      </div>
      <div class="modal-body">
        <form id="form2" action="${ctxsys}/PmShopCooperType/save" method="post" >
         <p><span>分类:</span>
         <span>
         <input name="shopId" id="shopId" type="hidden" value="${shopId}"/>
         <select name="productTypeId" id="productTypeId">
         </select></span>
         </p>
         <p><span>开始时间:</span><span> <input class="small" type="text" style=" width: 100px;" name="startDate" id="create_time_start" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" value="" placeholder="请输入开始时间"/>
				  </span></p>
         <p><span>结束时间:</span><span><input class="small" type="text" name="endDate" id="stoptime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" style=" width: 100px;" value="" placeholder="请输入结束时间"/></span></p>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        <button type="button" class="btn btn-primary" onclick="saveInfo()">保存</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<script type="text/javascript">
    $(document).ready(function(){
      var s="${message}";
        if(s!=null&&s!=''){
          alert(s);
        }
    
         $.ajax({
             type: "POST",
             url: "${ctxsys}/PmProductType/getTo",
             data: $("#form2").serialize(),
             success: function(data){
             var html;
            for(var i=0;i<data.length;i++){
              html+="<option value='"+data[i].id+"'>"+data[i].productTypeName+"</option>";
             }
             $("#productTypeId").html(html);
             },error: function(XMLHttpRequest, textStatus, errorThrown) {
             }
         });
    
     })
 	function saveInfo(){
 	    if($("#create_time_start").val()==null||$("#create_time_start").val()==''){
 	      alert("开始合作时间不能为空");
 	    }else if($("#stoptime").val()==null||$("#stoptime").val()==''){
 	     alert("开始合作时间不能为空");
 	    }else if($("#shopId").val()==null||$("#shopId").val()==''){
 	     alert("商户id不能为空");
 	     }else{
 	     $("#form2").submit();
 	     }
		}
</script>
</body>
</html>