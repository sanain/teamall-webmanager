<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>用户管理</title>
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
			$("#searchForm").attr("action","${ctxsys}/User");
			$("#searchForm").submit();
	    	return false;
	    }
	  var usercId;
       function byStatus(userId,status){
	    var msg="";
	     usercId=userId;
		if(status==1){
		  msg="是否把该用户禁用";
		}else{
		  msg="是否把该用户启用";
		}
	    confirmx(msg,byUstatus);
	   }
	    function byUstatus(){
	      $.ajax({
			    type : "POST",
			    data:{userId:usercId},
			    url:"${ctxsys}/User/byStatus",   
			    success : function (data) {
			     alertx("操作成功");
			     page();
			    }
	         });
	    }

	</script>
	<script>
		var usercIdTest;
		function byTest(userId,test){
			var msg="";
			usercIdTest=userId;
			if(test==1){
				msg="是否设置该用户为正常用户";
			}else{
				msg="是否设置该用户为测试用户";
			}
			confirmx(msg,byUTest);
		}
		function byUTest(){
			$.ajax({
				type : "POST",
				data:{userId:usercIdTest},
				url:"${ctxsys}/User/byTest",
				success : function (data) {
					alertx("操作成功");
					page();
				}
			});
		}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctxsys}/User/list">用户列表</a></li>
		<%-- <shiro:hasPermission name="merchandise:user:edit"><li><a href="${ctxsys}/User/form">用户添加</a></li></shiro:hasPermission> --%>
	</ul>
	<form:form id="searchForm" modelAttribute="ebUser" action="${ctxsys}/User" method="post" class="breadcrumb form-search ">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
	<%-- 	<c:set var="sysuser" value="${fns:getSysUser()}"/> --%>
		<ul class="ul-form">
			<li><label>昵称：</label><form:input path="username" htmlEscape="false" maxlength="50" class="input-medium"/></li>
			<li><label>用户手机：</label><form:input path="mobile" htmlEscape="false" maxlength="50" class="input-medium"/></li>
			<li><label>用户状态：</label>
			<form:select path="status">
			  <form:option value="">全部</form:option>
			  <form:option value="1">正常</form:option>
			  <form:option value="2">禁用</form:option>
			</form:select>
			</li>
			<li style="margin-left:10px;margin-right:10px"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/>
			</li>
			<shiro:hasPermission name="merchandise:user:editInfo">
			  <li class="clearfix" style="margin-left:10px"><input id="btnExport" class="btn btn-primary check-a1" type="button" value="导出"/></li>
			</shiro:hasPermission>
		</ul>
	<div class="check1">
    <div class="check-box">
        <p>导出选项<img class="check-del1" src="${ctxStatic}/sbShop/images/xxx-rzt.png" alt=""></p>
          <ul class="mn1">
	          <li class="checkbox"><input type="checkbox" class="kl" value="" id="all"><label><i></i>全选</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="1"><label><i></i>账号</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="2"><label><i></i>昵称</label></li>
	          <%--<li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="3"><label><i></i>邀请码</label></li>--%>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="4"><label><i></i>当前余额</label></li>
	          <%--<li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="5"><label><i></i>当前积分</label></li>--%>
	          <%--<li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="6"><label><i></i>当前积分</label></li>--%>
	          <%--<li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="7"><label><i></i>普通合伙人</label></li>--%>
	          <%--<li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="8"><label><i></i>精英合伙人</label></li>--%>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="9"><label><i></i>注册时间</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="10"><label><i></i>会员状态</label></li>
	          <%--<li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="11"><label><i></i>每天最大支付额度</label></li>--%>
          </ul>
        <div class="check-btn">
            <a href="javascript:;" id="fromNewActionSbM" >确定</a>
            <a class="check-del1" href="javascript:;">取消</a>
        </div>
      </div>
    </div>
	</form:form>
	<tags:message content="${message}"/>
	<div style="margin:0 auto;overflow-x:auto">
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead><tr>
		<th class="center123">编号</th>
		<th class="center123">人脉</th>
		<th class="center123">账号</th>
		<th class="center123">昵称</th>
		<%--<th class="center123">邀请码</th>--%>
		<th class="center123">当前余额</th>
		<%--<th class="center123">线下大额充值余额</th>--%>
		<%--<th class="center123">冻结余额</th>--%>
		<th class="center123">当前积分</th>
		<%--<th class="center123">普通合伙人</th>--%>
		<%--<th class="center123">精英合伙人</th>--%>
		<th class="center123 sort-column createTime">注册时间</th>
		<shiro:hasPermission name="merchandise:user:edit">
		<th class="center123">会员状态</th>
		<th class="center123">测试用户</th>
		</shiro:hasPermission>
		<%--<th class="center123" style="display:none">每天最大支付额度</th>--%>
		<shiro:hasPermission name="merchandise:user:edit">
		<th class="center123">操作</th>
		</shiro:hasPermission>
		</tr></thead>
		<tbody>
		<c:forEach items="${page.list}" var="userList" varStatus="status">
			<tr>
			    <td class="center123">${status.index+1}</td>
				<td class="center123"><a onclick="getuser(${userList.userId})" data-toggle="modal" data-target="#myModal_y">查看人脉</a></td>
				<td class="center123">
					<c:if test="${userList.shopShoppingId != null}">
						${fns:replaceMobile(userList.mobile)}
					</c:if>

					<c:if test="${userList.shopShoppingId == null}">
						${userList.mobile}
					</c:if>
				</td>
				<td class="center123">
					<a>
							${userList.username}
					</a>
				</td>
				<%--<td class="center123">${userList.cartNum}</td>--%>
				<td class="center123">
					<fmt:formatNumber type="number" value="${userList.currentAmt}" pattern="0.00" maxFractionDigits="2"/><shiro:hasPermission name="merchandise:user:editInfo">
					<c:if test="${userList.shopShoppingId == null}">
						|<a onclick="wrodct(${userList.userId})"  data-toggle="modal" data-target="#myModal">充值</a>
					</c:if>
				</shiro:hasPermission></td>
				<%--<td class="center123"><fmt:formatNumber type="number" value="${userList.currentAmtOffline}" pattern="0.00" maxFractionDigits="2"/></td>--%>
				<%--<td class="center123"><fmt:formatNumber type="number" value="${userList.frozenAmt}" pattern="0.0000" maxFractionDigits="4"/></td>--%>
				<td class="center123"><fmt:formatNumber type="number" value="${userList.currentLove}" pattern="0.0000" maxFractionDigits="4"/></td>
				<%--<td class="center123"><c:if test="${userList.isMessenger==0}">否</c:if><c:if test="${userList.isMessenger==1}">是</c:if> </td> --%>
				<td class="center123">${userList.createtime}</td>
<%--				<td class="center123"><c:if test="${userList.isAmbassador==0}">否</c:if><c:if test="${userList.isAmbassador==1}">是</c:if> </td>--%>

				<shiro:hasPermission name="merchandise:user:edit">
				<td class="center123">
					<c:if test="${userList.status==1}">正常</c:if>
					<c:if test="${userList.status==2}">禁用</c:if>
					<c:if test="${userList.shopShoppingId == null}">
						|
						<c:if test="${userList.status==2}">
							<a onclick="byStatus('${userList.userId}','${userList.status}')" >正常</a>
						</c:if>
						<c:if test="${userList.status==1}">
							<a onclick="byStatus('${userList.userId}','${userList.status}')" >禁用</a>
						</c:if>
					</c:if>
				</td>
				</shiro:hasPermission>
				<shiro:hasPermission name="merchandise:user:edit">
					<td class="center123">
						<c:if test="${userList.test==1}">测试</c:if>
						<c:if test="${empty userList.test||userList.test==0}">正常</c:if>
						<c:if test="${userList.shopShoppingId == null}">
							|
							<c:if test="${empty userList.test||userList.test==0}">
								<a onclick="byTest('${userList.userId}','${userList.test}')" >测试</a>
							</c:if>
							<c:if test="${userList.test==1}">
								<a onclick="byTest('${userList.userId}','${userList.test}')" >正常</a>
							</c:if>
						</c:if>
					</td>
				</shiro:hasPermission>
				<%--<td class="center123"  style="display:none">${userList.maxPay}<shiro:hasPermission name="merchandise:user:editInfo">|<a onclick="wrodct(${userList.userId},${userList.maxPay})"  data-toggle="modal" data-target="#myModal_d">设置</a></shiro:hasPermission></td>--%>
				<shiro:hasPermission name="merchandise:user:edit">
				<td class="center123">
    				<a href="${ctxsys}/User/form?userId=${userList.userId}">修改</a>
				</td>
				</shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	</div>
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title">会员充值</h4>
	        </div>
		        <div class="modal-body">
			        <form id="form2">
			           <p><span>请输入金额:</span><input type="number" step="0.1" min="0" id="currentAmt" name="currentAmt" value="0" required /></p>
			        </form>
		        </div>
	        <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	        <button id="saveInfo" type="button" class="btn btn-primary" onclick="saveInfo()">保存</button>
	        </div>
		    </div><!-- /.modal-content -->
		  </div><!-- /.modal-dialog -->
		</div><!-- /.modal -->
		
		
		<div class="modal fade" id="myModal_d" tabindex="-1" role="dialog">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		        <h4 class="modal-title">金额设置</h4>
		        </div>
			        <div class="modal-body">
				        <form id="form3">
				           <p><span>每日支付最大额度:</span><input id="maxPay" name="maxPay" type="number" step="0.1" min="0" value="0"/></p>
				        </form>
			        </div>
		        <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	        <button id="saveInfo2" type="button" class="btn btn-primary" >保存</button>
	        </div>
		    </div><!-- /.modal-content -->
		  </div><!-- /.modal-dialog -->
		</div><!-- /.modal -->
		
		<div class="modal fade" id="myModal_y" tabindex="-1" role="dialog">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		        <h4 class="modal-title">查看人脉</h4>
		        </div>
			        <div class="modal-body">
				        <div id="menuTree" class="ztree" style="margin-top:3px;float:left;"></div>
			        </div>
		        <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	        <!-- <button type="button" class="btn btn-primary" onclick="saveInfo2()">保存</button> -->
	        </div>
		    </div><!-- /.modal-content -->
		  </div><!-- /.modal-dialog -->
		</div><!-- /.modal -->
		
	<div class="pagination">${page}</div>
	
	<script type="text/javascript">
	var o;
	function wrodct(a,maxPay){
	  o=a;
	  $("#maxPay").val(maxPay);
	}
	$('body').one('click','#saveInfo2',function(){
      if($("#maxPay").val()!=null&&$("#maxPay").val()!=''){
 	     $.ajax({
             type: "POST",
             url: "${ctxsys}/User/setCurrentAmt",
             data: {userId:o, maxPay:$("#maxPay").val()},
             success: function(data){
            	 page();
             },error: function(XMLHttpRequest, textStatus, errorThrown) {
             }
            });
		}else{
		 alert("金额不能为空!");
		return false;
	   }
	})
	function getuser(userId){
	      $.ajax({
	             type: "POST",
	             url: "${ctxsys}/User/userNextList",
	             data: {userId:userId},
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
				    
	               },error: function(XMLHttpRequest, textStatus, errorThrown) {
	             }
	           });
	}
	$('body').one('click','#saveInfo',function(){
		if($('input[name="currentAmt"]').val()!=null&&$('input[name="currentAmt"]').val()!=''){
	 	     $.ajax({
	             type: "POST",
	             url: "${ctxsys}/User/currentAmt",
	             data: {userId:o, currentAmt:$('input[name="currentAmt"]').val()},
	             success: function(data){
	                page();
	               },error: function(XMLHttpRequest, textStatus, errorThrown) {
	             }
	           });
			}else{
			 alert("金额不能为空!");
			return false;
		  }
	})
	</script>
	<script type="text/javascript">
        $('#all').click(function(){
            if($(this).is(':checked')){
                $('.kl').prop('checked',true).attr('checked',true);
                $('#all').prop('checked',true).attr('checked',true);
            }else {
                $('.kl').removeattr('checked');
                $('#all').removeattr('checked');
            }
        });
        $('body').on('click','.kl',function(){
            if ($('.kl').length==$('.kl[type=checkbox]:checked').length){
                $('#all').prop('checked',true).attr('checked',true);
            }else {
                $('#all').removeattr('checked');
            }
        })
        $('#fromnewactionsbm').click(function(){
            $.ajax({
                type : "post",
                data:$('#searchform').serialize(),
                url : "${ctxsys}/user/exsel",
                success : function (data) {
                    window.location.href=data;
                }
            });
        });
	</script>
</body>
</html>