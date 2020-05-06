<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>商品列表</title>
	<meta name="decorator" content="default"/>
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
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").attr("action","${ctxsys}/PmUserIdentityLog");
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
		<li class="active"><a href="${ctxsys}/PmUserIdentityLog">身份列表</a></li>
	</ul>
	 <form:form id="searchForm" modelAttribute="pmUserIdentityLog" action="${ctxsys}/PmUserIdentityLog" method="post" class="breadcrumb form-search ">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
		<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
			<ul class="ul-form">
		    <li><label>名称:</label><form:input path="acount" htmlEscape="false" maxlength="80" class="input-medium"  placeholder="请输入"/></li>
		    <li><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/></li>
		    <li><input id="btnExport" class="btn btn-primary check-a1" type="button" value="导出"/></li>
		</ul>
		 <div class="check1">
    <div class="check-box">
        <p>导出选项<img class="check-del1" src="${ctxStatic}/sbShop/images/xxx-rzt.png" alt=""></p>
          <ul class="mn1">
	          <li class="checkbox"><input type="checkbox" class="kl" value="" id="all"><label><i></i>全选</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="1"><label><i></i>用户名</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="2"><label><i></i>状态</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="3"><label><i></i>金额</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="4"><label><i></i>开始时间</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="5"><label><i></i>结束时间</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="6"><label><i></i>最后修改人</label></li>
          </ul>
        <div class="check-btn">
            <a href="javascript:;" id="fromNewActionSbM" >确定</a>
            <a class="check-del1" href="javascript:;">取消</a>
        </div>
      </div>
    </div>
    </form:form> 
	<tags:message content="${message}"/>
	<table  class="table table-striped table-condensed table-bordered " >
		<tr>
		 <th class="center123">编号</th>
		 <th class="center123">账号</th>
		 <th class="center123">状态</th>
		 <th class="center123">支付金额</th>
		 <th class="center123">开始时间</th>
		 <th class="center123">结束时间</th>
		 <th class="center123">最后修改人</th>
		 <th class="center123">最后修改时间</th>
		</tr>
		<c:forEach items="${page.list}" var="PmUserIdentityLogList" varStatus="status">
			<tr>
			    <td class="center123">${status.index+1}</td>
				<td class="center123">${PmUserIdentityLogList[1].mobile}</td>
				<td class="center123"><c:if test="${PmUserIdentityLogList[0].status==0}">未支付</c:if><c:if test="${PmUserIdentityLogList[0].status==1}">使用中</c:if><c:if test="${PmUserIdentityLogList[0].status==2}">过期 </c:if></td>
				<td class="center123">${PmUserIdentityLogList[0].amt}</td>
				<c:set var="amt" value="${PmUserIdentityLogList[0].amt+amt}"></c:set>  
				<td class="center123">${PmUserIdentityLogList[0].startTime}</td>
				<td class="center123">${PmUserIdentityLogList[0].endTime}</td>
				<td class="center123">${PmUserIdentityLogList[0].modifyUser}</td>
				<td class="center123">${PmUserIdentityLogList[0].modifyTime}</td>
			</tr>
		</c:forEach>
		<tr>
			    <th class="center123">合计:</th>
				<th class="center123"></th>
				<th class="center123"></th>
				<th class="center123">${amt }</th>
				<th class="center123"></th>
				<th class="center123"></th>
				<th class="center123"></th>
				<th class="center123"></th>
			</tr>
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
			    url : "${ctxsys}/PmUserIdentityLog/exsel",   
			    success : function (data) {
			         window.location.href=data; 
			    }
	         });
     });
	</script>
</body>
</html>