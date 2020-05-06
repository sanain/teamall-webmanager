<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>门店管理</title>
	<meta name="decorator" content="default"/>
	<link href="${ctxStatic}/jquery-ztree/3.5.12/css/zTreeStyle/zTreeStyle1.min.css" rel="stylesheet" type="text/css"/>
	<script src="${ctxStatic}/jquery-ztree/3.5.12/js/jquery.ztree.core-3.5.min.js" type="text/javascript"></script>
	<script src="${ctxStatic}/jquery-ztree/3.5.12/js/jquery.ztree.excheck-3.5.min.js" type="text/javascript"></script>
	<script src="${ctxStatic}/jquery-ztree/3.5.12/js/jquery.ztree.exhide-3.5.min.js" type="text/javascript"></script>
	<link rel="stylesheet" href="${ctxStatic}/sbShop/css/build.css">
	<style>
        .check{position: fixed;top:0;left: 0;right: 0;bottom: 0;background: rgba(0,0,0,0.3);z-index: 10000}
        .check-box{width: 750px;background: #ffffff;position: absolute;top: 50%;left: 50%;margin-left: -375px;margin-top: -200px;}
        .check-box>p{height: 35px;line-height: 35px;background: #f0f0f0;position: relative;text-align: center}
        .check-box>p img{position: absolute;top:12px;right: 15px;cursor: pointer}
        .check-box ul{overflow: hidden;padding: 10px;outline:none;list-style:none}
        .check-box ul li.checkbox{float: left;width: 30%;line-height: 30px;margin-top: 0;}
        .check-box ul li.checkbox input{position:relative;left:8px}
        .check-btn{text-align: center;padding-bottom: 20px}
        .check-btn a{display: inline-block;width: 80px;height: 30px;line-height: 30px;border-radius: 5px;border: 1px solid #dcdcdc}
        .check-btn a:nth-child(1){background: #68C250;border: 1px solid #68C250;color: #ffffff;margin-right: 5px}
        .check-btn a:nth-child(2){color: #666666;margin-left: 5px}
        .check-box .checkbox input[type="checkbox"]:checked + label::before {
            background: #68C250;
            top:0 px;
            border: 1px solid #68C250;
        }
        .check-box .checkbox label::before{
            top: 0px;
        }
        .check-box .checkbox i{
            position: absolute;
            width: 12px;
            height: 8px;
            background: url(../images/icon_pick.png) no-repeat;
            top: 4px;
            left: -18px;
            cursor: pointer;
        }
        .check-box .checkbox input{top: 10px;position:relative}
    </style>
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
		/* $(document).ready(function() {
			$("#btnExport").click(function(){
				top.$.jBox.confirm("确认要导出用户数据吗？","系统提示",function(v,h,f){
					if(v=="ok"){
						$("#searchForm").attr("action","${ctxsys}/User/export");
						$("#searchForm").submit();
					}
				},{buttonsFocus:1});
				top.$('.jbox-body .jbox-icon').css('top','55px');
			});
			$("#btnImport").click(function(){
				$.jBox($("#importBox").html(), {title:"导入数据", buttons:{"关闭":true}, 
					bottomText:"导入文件不能超过5M，仅允许导入“xls”或“xlsx”格式文件！"});
			});
		}); */
		function page(n,s){
			if(n) $("#pageNo").val(n);
			if(s) $("#pageSize").val(s);
			$("#searchForm").attr("action","${ctxsys}/psstore/storeList");
			$("#searchForm").submit();
	    	return false;
	    }
/* 	     var usercId;
       function byStatus(userId,status){
	    var msg="";
	     usercId=userId;
		if(status==1){
		  msg="是否把该用户禁用";
		}else{
		  msg="是否把该用户启用";
		}
	    confirmx(msg,byUstatus);
	   } */
/* 	    function byUstatus(){
	      $.ajax({
			    type : "POST",
			    data:{userId:usercId},
			    url:"${ctxsys}/User/byStatus",   
			    success : function (data) {
			     alertx("操作成功");
			     page();
			    }
	         });
	    } */
	    
	    function hideStore(storeId,status,obj){
	   	$.ajax({
	    		type:"get",
	    		data:{storeId:storeId,status:status},
	    		url:"${ctxsys}/psstore/storeStatus",
	    		success:function(data){
	    			if(data.code=="00"){
	    				alertx("操作成功");
	    				if(status==1){
	    					$(obj).text("显示");  
	    					$(obj).attr("onclick","hideStore("+data.store.storeId+",0,this)");
							$(obj).prev("span").html("隐藏 | ");
	    				}
	    				if(status==0){
	    					$(obj).text("隐藏");
	    					$(obj).attr("onclick","hideStore("+data.store.storeId+",1,this)");
							$(obj).prev("span").html("显示 | ");
	    				}
	    			}else{
	    				alertx("操作失败");
	    			}
	    		}
	    	});  
	    	
	    }
	    
	    
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctxsys}/psstore/storeList">门店列表</a></li>
		<shiro:hasPermission name="merchandise:store:edit"><li><a href="${ctxsys}/psstore/storeEdit">门店添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="ebStore" action="${ctxsys}/User" method="post" class="breadcrumb form-search ">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
	<%-- 	<c:set var="sysuser" value="${fns:getSysUser()}"/> --%>
		<ul class="ul-form">
			<li><label>门店名字：</label><form:input path="storeName" htmlEscape="false" maxlength="50" class="input-medium"/></li>
			<li><label>门店地址：</label><form:input path="storeAddr" htmlEscape="false" maxlength="50" class="input-medium"/>
			</li>
			<li><label></label><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/>
			</li>
		</ul>
	</form:form>
	<tags:message content="${message}"/>
	<div style="margin:0 auto;overflow-x:auto">
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead><tr>
		<th class="center123">门店编号</th>
		<th class="center123">门店名字</th>
		<th class="center123">门店图片</th>
		<th class="center123">门店地址</th>
		
		<th class="center123">门店经度</th>
		<th class="center123">门店纬度</th>
		<th class="center123">门店营业时间</th>
		
		<th class="center123">门店电话</th>
	<shiro:hasPermission name="merchandise:store:edit">
			<th class="center123">状态</th> 
		</shiro:hasPermission>
		
		<shiro:hasPermission name="merchandise:store:edit">
		<th class="center123">操作</th>
		</shiro:hasPermission>
		</tr></thead>
		<tbody>
		<c:forEach items="${page.list}" var="storeList" varStatus="status">
			<tr>
			    <td class="center123">${status.index+1}</td>
				<td class="center123">${storeList.storeName}</a></td>
				<td class="center123"><img src="${storeList.storeBanner}" width="150" height="150"/></td>
					
				<td class="center123">${storeList.storeAddr}</td>
				
			
				<td class="center123">${storeList.storeLongitude}</td>
				<td class="center123">${storeList.storeLatitude}</td>
				<td class="center123">${storeList.storeBusinessTime }</td>
				<td class="center123">${storeList.storePhone }</td>
				<shiro:hasPermission name="merchandise:store:edit">
					<td class="center123">
					<c:choose>
					<c:when test="${empty storeList.status || storeList.status==0}"><span>隐藏 | </span><a href="javascript:;" onclick="hideStore(${storeList.storeId},1,this)">显示</a> </c:when>
					<c:otherwise>
					 <span>显示 | </span><a href="javascript:;" onclick="hideStore(${storeList.storeId},0,this)">隐藏</a>
					</c:otherwise>
					</c:choose>
					</td>
				</shiro:hasPermission>
				<shiro:hasPermission name="merchandise:store:edit">
				<td class="center123">
    				<a href="${ctxsys}/psstore/storeEdit?storeId=${storeList.storeId}">修改</a> 
    				&nbsp;|&nbsp;
    				<a href="${ctxsys}/psstore/storeDelete?storeId=${storeList.storeId}" onclick="return confirmx('确定要删除该门店吗？', this.href)">删除</a>
				</td>
				</shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	</div>
	
		
	<div class="pagination">${page}</div>
	
	
	</script>
</body>
</html>