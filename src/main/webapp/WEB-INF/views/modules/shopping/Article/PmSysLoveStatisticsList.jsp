<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>${fns:getProjectName()}数据汇总</title>
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
  $(function(){
	 	$('.check1').hide();
	   	$('body').on('click','.check-a1',function(){
	   		$('.check1').show();
	   	});
	   	
	   	$('body').on('click','.check-del1',function(){
	   		$('.check1').hide();
	   	});
    });
function checkAll() {
	if ($(".checkAll").is(":checked")) {
        $("input[class=checkRow]:checkbox").prop("checked", true);
    } else {
	    $("input[class=checkRow]:checkbox").prop("checked", false);
    }
}

function checkRow(obj) {
	if ($("#"+obj).is(":checked")) {
		$("input[id="+obj+"]:checkbox").prop("checked", false);
    } else {
    	$("input[id="+obj+"]:checkbox").prop("checked", true);
    }
}

function deleteIds(){
	obj = document.getElementsByName("checkRow");
	check_val = [];
	for(k in obj){
		if(obj[k].checked)
			check_val.push(obj[k].value);
	}
	if(check_val.length==0){
		alert("请选择要删除的");
	}else{
		return confirmx('确认要删除吗？', "${ctxsys}/productcomment/deleteService?ids="+ check_val+"");
}
}


function page(n,s){
	if(n) $("#pageNo").val(n);
	if(s) $("#pageSize").val(s);
	$("#searchForm").attr("action","${ctxsys}/PmSysLoveStatistics/list");
	$("#searchForm").submit();
	return false;
}
</script>     

</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a>${fns:getProjectName()}数据汇总</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="pmSysLoveStatistics" action="${ctxsys}/PmSysLoveStatistics/list" method="post" class="breadcrumb form-search ">
		<input path="userId" type="hidden"/>
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form">
		  <li><label>开始时间:</label> <input class="small" type="text" style=" width: 100px;" name="statrDate" id="create_time_start" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" value="${statrDate}" placeholder="请输入开始时间"/></li>
		  <li><label>结束时间:</label><input class="small" type="text" name="stopDate" id="stoptime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd '})" style=" width: 100px;" value="${stopDate}" placeholder="请输入结束时间"/></li>
		  <li> &nbsp;&nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/></li>
		  <li><input id="btnExport" class="btn btn-primary check-a1" type="button" value="导出"/></li>
		  <div class="check1">
    	<div class="check-box">
	        <p>导出选项<img class="check-del1" src="${ctxStatic}/sbShop/images/xxx-rzt.png" alt=""></p>
	          <ul class="mn1">
		          <li class="checkbox"><input type="checkbox" class="kl" value="" id="all"><label><i></i>全选</label></li>
		          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="1"><label><i></i>统计日期</label></li>
		          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="2"><label><i></i>期初存总积分数</label></li>
		          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="3"><label><i></i>当日增加积分数</label></li>
		          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="4"><label><i></i>当日减少积分数</label></li>
		          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="5"><label><i></i>期末结存总积分数</label></li>
              </ul>
            <div class="check-btn">
	            <a href="javascript:;" id="fromNewActionSbM" >确定</a>
	            <a class="check-del1" href="javascript:;">取消</a>
	        </div>
	      </div>
	    </div>
		</ul>
	</form:form>
	<tags:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed" >
		<tr>
			<th><input type="checkbox" class="checkAll" name="checkAll" onclick="checkAll();"/></th>
			  <th class="sort-column createTime">统计日期</th>
              <th>期初存总积分数</th>
              <th>当日增加积分数</th>
              <th>当日减少积分数</th>
              <th>期末结存总积分数</th>
		</tr>
		<c:forEach items="${page.list}" var="pack" varStatus="i">
			<tr id="${pack.id}">
				<td><input type="checkbox" value="${pack.id}" class="checkRow" name="checkRow"/></td> 
				<td> <fmt:formatDate value="${pack.createTime}" /></td>
				 <c:set var="beginLove" value="${pack.beginLove+beginLove}"></c:set>
				<td><fmt:formatNumber type="number" value="${pack.beginLove}" pattern="0.0000" maxFractionDigits="4"/></td>
				 <c:set var="todayAddLove" value="${pack.todayAddLove+todayAddLove}"></c:set>
                <td><fmt:formatNumber type="number" value="${pack.todayAddLove}" pattern="0.0000" maxFractionDigits="4"/></td>
                 <c:set var="todayReduceLove" value="${pack.todayReduceLove+todayReduceLove}"></c:set>
                <td><fmt:formatNumber type="number" value="${pack.todayReduceLove}" pattern="0.0000" maxFractionDigits="4"/></td>
                 <c:set var="endLove" value="${pack.endLove+endLove}"></c:set>
                <td><fmt:formatNumber type="number" value="${pack.endLove}" pattern="0.0000" maxFractionDigits="4"/></td>
			</tr>
		</c:forEach>
		<tr>
			  <th>合计:</th>
			  <th></th>
              <th><fmt:formatNumber type="number" value="${beginLove}" pattern="0.0000" maxFractionDigits="4"/></th>
              <th><fmt:formatNumber type="number" value="${todayAddLove }" pattern="0.0000" maxFractionDigits="4"/></th>
              <th><fmt:formatNumber type="number" value="${todayReduceLove}" pattern="0.0000" maxFractionDigits="4"/></th>
              <th><fmt:formatNumber type="number" value="${endLove}" pattern="0.0000" maxFractionDigits="4"/></th>
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
			    url : "${ctxsys}/PmSysLoveStatistics/exsel",   
			    success : function (data) {
			         window.location.href=data; 
			    }
	         });
     });
	</script>
</body>
</html>