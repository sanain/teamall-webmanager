<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<meta name="decorator" content="default"/>
	<meta name="Description" content="${fns:getProjectName()},退款申请介入"/>
	<meta name="Keywords" content="${fns:getProjectName()},退款申请介入"/>
	<title>退款申请介入</title>
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
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").attr("action","${ctxsys}/ReturnGoodIntervene");
			$("#searchForm").submit();
	    	return false;
	    }
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
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctxsys}/ReturnGoodIntervene">退款申请介入列表</a></li>
	</ul>
	 <form:form id="searchForm" modelAttribute="pmReturnGoodIntervene" action="${ctxsys}/ReturnGoodIntervene" method="post" class="breadcrumb form-search ">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
		<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form">
		     <li>
		      <label>退款编号</label>
		      <form:input path="aftersale.saleNo" htmlEscape="false" maxlength="20" class="input-medium" />
		     </li>
		     <li>
		      <label>介入状态</label>
		      <form:select path="interveneStatus" class="input-medium">
		        <form:option value="">全部状态</form:option>
		        <form:option value="1">买家申请介入</form:option>
		        <form:option value="2">卖家申请介入</form:option>
		        <form:option value="3">平台客服处理中</form:option>
		        <form:option value="4">平台客服已完成处理</form:option>
		      </form:select>
		     </li>
			<li><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/></li>
			<li><input id="btnExport" class="btn btn-primary check-a1" type="button" value="导出"/></li>
		</ul>
		<div class="check1">
    <div class="check-box">
        <p>导出选项<img class="check-del1" src="${ctxStatic}/sbShop/images/xxx-rzt.png" alt=""></p>
          <ul class="mn1">
	          <li class="checkbox"><input type="checkbox" class="kl" value="" id="all"><label><i></i>全选</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="1"><label><i></i>退款申请编号</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="2"><label><i></i>介入状态</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="3"><label><i></i>用户账号</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="4"><label><i></i>用户问题描述</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="5"><label><i></i>提交时间</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="6"><label><i></i>商家</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="7"><label><i></i>商家问题描述</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="8"><label><i></i>提交时间</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="9"><label><i></i>创建时间</label></li>
          </ul>
        <div class="check-btn">
            <a href="javascript:;" id="fromNewActionSbM" >确定</a>
            <a class="check-del1" href="javascript:;">取消</a>
        </div>
      </div>
    </div>
	</form:form> 
	<tags:message content="${message}"/>
	<table id="treeTable" class="table table-striped table-condensed table-bordered" >
		<tr>
		<th>编号</th>
		<th>退款申请编号</th>
		<th>介入状态</th>
		<th>用户账号</th>
		<th>用户问题描述</th>
		<th class="sort-column userSubmitTime">提交时间</th>
		<th>商家</th>
		<th>商家问题描述</th>
		<th class="sort-column shopSubmitTime">提交时间</th>
		<th class="sort-column createTime">创建时间</th>
		<th>操作</th>
		</tr>
		<c:forEach items="${page.list}" var="ReturnGoodIntervene" varStatus="status">
			<tr>
			  <td>${status.index+1}</td>
			    <td>${ReturnGoodIntervene.aftersale.saleNo}</td>
			    <td >
					<c:if test="${ReturnGoodIntervene.interveneStatus==1}">买家申请介入</c:if>
				    <c:if test="${ReturnGoodIntervene.interveneStatus==2}">卖家申请介入</c:if>
					<c:if test="${ReturnGoodIntervene.interveneStatus==3}">平台客服处理中</c:if>
					<c:if test="${ReturnGoodIntervene.interveneStatus==4}">平台客服已完成处理</c:if>
				</td>
			    <td>${fns:getUser(ReturnGoodIntervene.user.userId).mobile}</td>
			    <td title="${ReturnGoodIntervene.userProblemDesc}">${fns:abbr(ReturnGoodIntervene.userProblemDesc,25)}</td>
			    <td><fmt:formatDate value="${ReturnGoodIntervene.userSubmitTime}" type="both"/></td>
				<td>${ReturnGoodIntervene.shopInfo.shopName}</td>
				<td title="${ReturnGoodIntervene.shopProblemDesc}">${fns:abbr(ReturnGoodIntervene.shopProblemDesc,25)}</td>
			    <td><fmt:formatDate value="${ReturnGoodIntervene.shopSubmitTime}" type="both"/></td>
			    <td><fmt:formatDate value="${ReturnGoodIntervene.createTime}" type="both"/></td>
				<td>
					<c:choose>
						<c:when test="${ReturnGoodIntervene.interveneStatus==3}">
							<a href="${ctxsys}/ReturnGoodIntervene/form?id=${ReturnGoodIntervene.id}">已查看</a>
						</c:when>
						<c:when test="${ReturnGoodIntervene.interveneStatus==4}">
							<a href="${ctxsys}/ReturnGoodIntervene/form?id=${ReturnGoodIntervene.id}">已处理</a>
						</c:when>
						<c:otherwise>
							<a href="${ctxsys}/ReturnGoodIntervene/form?id=${ReturnGoodIntervene.id}">未查看</a>
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
		</c:forEach>
	</table>
	<div class="pagination">${page}</div>
	<script type="text/javascript">
	  $('#all').click(function(){
        if($(this).is(':checked')){
            $('.kl').prop('checked',true).attr('checked',true);
            $('#all').prop('checked',true).attr('checked',true);
        }else {
            $('.kl').removeAttr('checked');
            $('#all').removeAttr('checked');
        }
    });
	$('body').on('click','.kl',function(){
        if ($('.kl').length==$('.kl[type=checkbox]:checked').length){
            $('#all').prop('checked',true).attr('checked',true);
        }else {
            $('#all').removeAttr('checked');
        }
    })
     $('#fromNewActionSbM').click(function(){
	     $.ajax({
			    type : "POST",
			    data:$('#searchForm').serialize(),
			    url : "${ctxsys}/ReturnGoodIntervene/exsel",   
			    success : function (data) {
			         window.location.href=data; 
			    }
	         });
     });
	</script>
</body>
</html>