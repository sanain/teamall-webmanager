<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>申请列表</title>
	<meta name="decorator" content="default"/>
	<link href="${ctxStatic}/jquery-ztree/3.5.12/css/zTreeStyle/zTreeStyle1.min.css" rel="stylesheet" type="text/css"/>
	<script src="${ctxStatic}/jquery-ztree/3.5.12/js/jquery.ztree.core-3.5.min.js" type="text/javascript"></script>
	<script src="${ctxStatic}/jquery-ztree/3.5.12/js/jquery.ztree.excheck-3.5.min.js" type="text/javascript"></script>
	<script src="${ctxStatic}/jquery-ztree/3.5.12/js/jquery.ztree.exhide-3.5.min.js" type="text/javascript"></script>
	<link rel="stylesheet" href="${ctxStatic}/sbShop/css/build.css">
	<link rel="stylesheet" href="${ctxStatic}/layui/css/layui.css"  media="all">
	<script src="${ctxStatic}/layui/layui.js" charset="utf-8"></script>
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

		function page(n,s){
			if(n) $("#pageNo").val(n);
			if(s) $("#pageSize").val(s);
			$("#searchForm").attr("action","${ctxsys}/ebProductApply");
			$("#searchForm").submit();
	    	return false;
	    }

	   var applyId;
	   var applyStatus;
       function byStatus(id,status){
			var msg="";
            applyId=id;
			if(status==1){
                applyStatus =2;
				msg="是否拒绝该申请";
			}else{
                applyStatus = 1;
				msg="是否通过该申请";
			}
			confirmx(msg,byApplystatus);
	   }
	    function byApplystatus(){
	      $.ajax({
			    type : "POST",
			    data:{"id":applyId,"applyStatus":applyStatus},
			    url:"${ctxsys}/ebProductApply/updateApplyStatus",
			    success : function (data) {
			        if(data == "success"){
                        alertx("操作成功");
					}else{
                        alertx("操作失败");
					}

			     	page($("#pageNo").val(),$("#pageSize").val());
			    }
	         });


	      $(function(){
	          if('${prompt}' != ""){
	              alert('${prompt}');
			  }
		  })
	    }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctxsys}/ebProductApply/list">申请列表</a></li>
		<%-- <shiro:hasPermission name="merchandise:user:edit"><li><a href="${ctxsys}/User/form">用户添加</a></li></shiro:hasPermission> --%>
	</ul>
	<form:form id="searchForm" modelAttribute="ebProductApply" action="${ctxsys}/User" method="post" class="breadcrumb form-search ">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
	<%-- 	<c:set var="sysuser" value="${fns:getSysUser()}"/> --%>
		<ul class="ul-form">
			<li><label>门店名称：</label><form:input path="shopName" htmlEscape="false" maxlength="50" class="input-medium"/></li>
			<li><label>商品名称：</label><form:input path="productName" htmlEscape="false" maxlength="50" class="input-medium"/></li>
			<%--<li><label>申请时间：</label><form:input path="createTime" htmlEscape="false" maxlength="50" class="input-medium"/></li>--%>
			<li><label>审核状态：</label>
			<form:select path="applyStatus">
			  <form:option value="">全部</form:option>
			  <form:option value="1">通过</form:option>
			  <form:option value="2">不通过</form:option>
			</form:select>
			</li>

			<li><label>状态：</label>
				<form:select path="isapply">
					<form:option value="">全部</form:option>
					<form:option value="1">已审核</form:option>
					<form:option value="2">未审核</form:option>
				</form:select>
			</li>
			<li style="margin-left:10px;margin-right:10px"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/>
			</li>
			<li style="margin-left:10px;margin-right:10px">
				<button type="button" class=" btn btn-primary" id="test3"><i class="layui-icon" onclick="return page();"></i>上传</button>
				<%--<input id="upload-new-file" class="btn btn-primary" type="submit" value="上传新的申请文件" onclick="return page();"/>--%>
			</li>
			<li style="margin-left:10px;margin-right:10px"><a href="javascript:;" onclick="downloadFile('model' , -111 , 'downloadApplyModelFile')"  class="btn btn-primary"  >下载</a>
			</li>
		</ul>
	</form:form>
	<tags:message content="${message}"/>
	<div style="margin:0 auto;overflow-x:auto">
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead><tr>
		<th class="center123">编号</th>
		<th class="center123">门店名称</th>
		<th class="center123">商品名称</th>
		<th class="center123">申请时间</th>
		<th class="center123">附件</th>
		<th class="center123">申请理由</th>
		<th class="center123">状态</th>
		<shiro:hasPermission name="merchandise:ebProductApply:edit">
		<th class="center123">审核状态</th>
		</shiro:hasPermission>
		<th class="center123">审核时间</th>
		<shiro:hasPermission name="merchandise:ebProductApply:edit">
		<th class="center123">操作</th>
		</shiro:hasPermission>
		</tr></thead>
		<tbody>
		<c:forEach items="${page.list}" var="ebProductApply" varStatus="status">
			<tr>
			    <td class="center123">${status.index+1}</td>
				<td class="center123"><a  href="${ctxsys}/PmShopInfo/shopinfo?id=${ebProductApply.shopId}">${ebProductApply.shopName}</a></td>
				<td class="center123">${ebProductApply.productName}</td>
				<td class="center123">${ebProductApply.createTime}</td>
				<%--<td class="center123"><span onclick='downloadFile("${ebProductApply.fileUrl}")'>下载</span></td>--%>
				<td class="center123" style="cursor: pointer;color: #18AEA1;" onclick="downloadFile('applyFile','${ebProductApply.id}','downloadApplyFile')">下载</td>
				<%--<td class="center123" ONCLICK="downloadFile('${ebProductApply.fileUrl}','downloadApplyFile)"><a href="${ctxsys}/ebProductApply/downloadApplyFile?id=${ebProductApply.id}" >下载</a></td>--%>
				<td class="center123">${ebProductApply.remark}</td>
				<shiro:hasPermission name="merchandise:user:edit">
				<td class="center123" style="cursor: pointer">
					<c:if test="${ebProductApply.applyStatus!=0}">
						<c:if test="${ebProductApply.applyStatus==1}">通过</c:if><c:if test="${ebProductApply.applyStatus==2}">不通过</c:if>|<c:if test="${ebProductApply.applyStatus==2}">
						<a onclick="byStatus('${ebProductApply.id}','${ebProductApply.applyStatus}')" >通过</a></c:if><c:if test="${ebProductApply.applyStatus==1}"><a onclick="byStatus('${ebProductApply.id}','${ebProductApply.applyStatus}')" >不通过</a></c:if></td>
					</c:if>

					<c:if test="${ebProductApply.applyStatus==0}">
						<a onclick="byStatus('${ebProductApply.id}',2)" >通过</a>|
						<a onclick="byStatus('${ebProductApply.id}',1)" >不通过</a>
					</c:if>
				</shiro:hasPermission>

				<td class="center123"><c:if test="${ebProductApply.isapply==1}">已审核</c:if><c:if test="${ebProductApply.isapply==2}">未审核</c:if> </td>
				<td class="center123">${ebProductApply.applyTime} </td>

			<%--<td class="center123"  style="display:none">${userList.maxPay}<shiro:hasPermission name="merchandise:user:editInfo">|<a onclick="wrodct(${userList.userId},${userList.maxPay})"  data-toggle="modal" data-target="#myModal_d">设置</a></shiro:hasPermission></td>--%>
				<shiro:hasPermission name="merchandise:ebProductApply:edit">
				<td class="center123">
    				<a href="javascript:;" onclick="addApplyId('${ebProductApply.id}')" data-toggle="modal" data-target="#myModal">回复</a>
    				<a href="${ctxsys}/ebProductApply/findApplyById?id=${ebProductApply.id}">查看详情</a>
				</td>
				</shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
		<%--用来提交下载文件请求--%>
		<form style="display: none" id="download-form">

		</form>
	</div>
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title">回复</h4>
	        </div>
		        <div class="modal-body">
			        <form id="form2" action="${ctxsys}/ebProductApply/saveRemark">
			           <input type="hidden" value="" id="applyId" name="applyId">
						<%--<p><span>请输入回复内容:</span></p>--%>
						<textarea style="width: 100%;height: 140px" name="applyRemark" id="applyRemark" rows="5" cols="100"></textarea>
			        </form>
		        </div>
	        <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	        <button id="saveInfo" type="button" class="btn btn-primary" onclick="saveRemark()">提交</button>
	        </div>
		    </div><!-- /.modal-content -->
		  </div><!-- /.modal-dialog -->
		</div><!-- /.modal -->
		
		

	<div class="pagination">${page}</div>

	<script type="text/javascript">
        function addApplyId(applyId){
		    $("#applyId").val(applyId)
		}
		/*提交回复信息*/
        function saveRemark(){
            if($("#applyRemark").val()!=undefined  && $("#applyRemark").val()!=''){
                // alert($("#applyRemark").text());
                $.ajax({
                    type: "POST",
                    url: "${ctxsys}/ebProductApply/saveRemark",
                    data: {"applyId":$("#applyId").val(), "applyRemark":$("#applyRemark").val()},
                    success: function(data){
                        if(data == "success"){
                            alert("回复成功！");
						}else{
                            alert("回复失败！");
						}
                        $("#myModal").modal('hide');
                        page($("#pageNo").val(n),$("#pageSize").val(s));
                        $("#applyRemark").val("")
                    },error: function(XMLHttpRequest, textStatus, errorThrown) {
                    }
                });
            }else{
                alert("回复内容不能为空!");
                return false;
            }
        }
	</script>

	<%--上传文件--%>
	<script>
        layui.use('upload', function(){
            var $ = layui.jquery
                ,upload = layui.upload;

            //指定允许上传的文件类型
            upload.render({
                elem: '#test3'
                ,url: '${ctxsys}/ebProductApply/updateApplyFile'
                ,accept: 'file' //普通文件
                ,size: 10240
                ,done: function(res){
                    if(res.flag == "success"){
                        alert("上传成功");
					}else{
                        alert("上传失败")
					}
                }
            });

        });
	</script>

	<script type="text/javascript">
        function downloadFile(fileType , id , downloadPath){
            if(fileType == undefined || fileType == ""){
                alert("文件不存在！");
				return false;
            }

			$.ajax({
				url:"${ctxsys}/ebProductApply/fileIsExists",
				data:{"id":id,"fileType":fileType},
                dataType: "json",
				 success: function (data){
					if(data.flag == "yes"){
					    if("model" == fileType){
                            window.location.href="${ctxsys}/ebProductApply/"+downloadPath;
						}else{
                            window.location.href="${ctxsys}/ebProductApply/"+downloadPath+"?id="+id;
						}
					}else{
					    alert("文件不存在");
					}
				 },
				error:function(){
				    alert("aaa");
				}
			})
		}
	</script>



	<script type="text/javascript">
		var o;
		function wrodct(a,maxPay){
		  o=a;
		  $("#maxPay").val(maxPay);
		}
	</script>

</body>
</html>