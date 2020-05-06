<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>公益收益管理</title>
<meta name="decorator" content="default"/>
 <style>
        .fix-in{position: fixed;top: 0;right: 0;left: 0;bottom: 0;background: rgba(0,0,0,0.3);display:none;}
        .fix-box{position: absolute;width: 500px;height: 300px;background: #ffffff;top: 50%;left: 50%;margin-top: -150px;margin-left: -250px}
        .fix-box>p{height: 35px;line-height: 35px;text-align: center;color: #333333;margin-bottom: 0;background: #f0f0f0;position: relative}
        .fix-box>p img{position: absolute;top: 12px;right: 15px;;cursor: pointer}
        .fix-box ul{list-style: none;padding: 0;color: #666666;margin-bottom: 0;margin-top: 15px}
        .fix-box ul li{line-height: 30px;margin-bottom: 5px}
        .fix-box ul span{width: 150px;text-align: right;display: inline-block}
        .fix-box ul b{font-weight: normal}
        .fix-box ul input{height: 30px;border: 1px solid #dcdcdc;border-radius: 3px;}
        .fix-btn{text-align: center;margin-top: 30px}
        .fix-btn a{display: inline-block;height: 30px;line-height: 30px;padding: 0 15px;background: #328BC5;color: #ffffff;border-radius: 5px;text-decoration: none}
        .fix-btn a:nth-child(1){margin-right: 10px}
        .fix-btn a:nth-child(2){background: #ffffff;border: 1px solid #dcdcdc;color: #666666;margin-left: 10px}
    </style>
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
	    <script>
	function To_resynchronize(uid){
	var msg = "同步成功";
	debugger;
	$.ajax({
	 					url : "${ctxsys}/NcMessageTable/pmSysLoveAllot_reset",
	 					type : 'post',
	 					data : {
							uid:uid
	 					},
	 					cache : false,
	 					success : function(data) {
							console.log(data);
	 						// 保存成功
	 						if(data.code=='00'){
	 							top.$.jBox.tip(msg, 'info');
								  $("#searchForm").attr("action","${ctxsys}/PmSysLoveAllot/list");
								 $("#searchForm").submit();
	 						} else {
	 							top.$.jBox.tip(data.msg, 'info');
	 						}
	 					}
	 				});
	    }

	</script>
<script type="text/javascript"> 
$(document).ready(function() {
	$('body').on('click','.check-a',function(){
    		$('.fix-in').show();
    	});
    	
    	$('body').on('click','.check-del',function(){
    		$('.fix-in').hide();
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
	$("#searchForm").attr("action","${ctxsys}/PmSysLoveAllot/list");
	$("#searchForm").submit();
	return false;
}
function selectStar(){
	$("#star").val("${star}");
}
$(function(){
	var alltt;
	var allnu;
	var allran;
	var zhishu;
	$('body').on('click','.check-a',function(){
		$('#idinfo').val($(this).closest('tr').attr('id'));
		alltt=$(this).closest('tr').children('td:nth-child(2)').text();
		allnu=$(this).closest('tr').children('td:nth-child(4)').text();
		allran=$(this).closest('tr').children('td:nth-child(3)').text();
		var iii=parseFloat($(this).closest('tr').find('.ii').val());
		console.log(iii)
		$('.fix-box ul li:nth-child(1) b').html(alltt);
		$('.fix-box ul li:nth-child(2) b').html(allnu);
		$('.fix-box ul li:nth-child(3) b').html(allran);
		$('.fix-box ul li:nth-child(4) b').html(iii.toFixed(4));
		console.log(alltt)
		$('.fix-in').show();
	})
	$('.fix-del').click(function(){
		$('.fix-in').hide();
	});
	$('.fix-add').click(function(){
	 var idinfo=$("#idinfo").val();
	 var zhishu=0.0;
	 $.ajax({
		type: "POST",
		url: "${ctxsys}/PmSysLoveAllot/fenpei",
		data: {zhishu:zhishu,idinfo:idinfo},
		async:false,
		beforeSend:function(){
  		  loading('正在提交，请稍等...');
  	     },success: function(data){
		  location.href="${ctxsys}/PmSysLoveAllot/list";
		 }
		});
	});
})
</script>     

</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a>公益收益管理列表</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="pmSysLoveAllot" action="${ctxsys}/PmSysLoveAllot/list" method="post" class="breadcrumb form-search ">
		<input path="id" type="hidden"/>
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<input path="userId" type="hidden"/>
		<ul class="ul-form">
		    <li><label>开始时间:</label> <input class="small" type="text" style=" width: 100px;" name="statrDate" id="statrDate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" value="${statrDate}" placeholder="请输入开始时间"/></li>
			<li><label>结束时间:</label><input class="small" type="text" name="stopDate" id="stopDate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd '})" style=" width: 100px;" value="${stopDate}" placeholder="请输入结束时间"/></li>
		    <li> &nbsp;&nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/></li>
		    <li><input id="btnExport" class="btn btn-primary check-a1" type="button" value="导出"/></li>
		</ul>
		<div class="check1">
    <div class="check-box">
        <p>导出选项<img class="check-del1" src="${ctxStatic}/sbShop/images/xxx-rzt.png" alt=""></p>
          <ul class="mn1">
	          <li class="checkbox"><input type="checkbox" class="kl" value="" id="all"><label><i></i>全选</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="1"><label><i></i>统计时间</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="2"><label><i></i>平台总积分数</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="3"><label><i></i>分配红包总数</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="4"><label><i></i>商家昨日让利总额</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="5"><label><i></i>红包指数</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="6"><label><i></i>实际分配总额</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="7"><label><i></i>税费</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="8"><label><i></i>费率</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="9"><label><i></i>分配时间</label></li>
          </ul>
        <div class="check-btn">
            <a href="javascript:;" id="fromNewActionSbM" >确定</a>
            <a class="check-del1" href="javascript:;">取消</a>
        </div>
      </div>
    </div>
	</form:form>
	<tags:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
	  <input id="idinfo" type="hidden">
		<tr>
			<th><input type="checkbox" class="checkAll" name="checkAll" onclick="checkAll();"/></th>
			  <th>统计时间</th>
			  <th>平台总积分数</th>
              <th>分配积分总数</th>
              <th>商家昨日让利总额</th>
              <th>积分指数</th>
              <th>实际分配总额</th>
              <th>税费</th>
              <th>费率</th>
              <th>分配时间</th>
              <th>NC同步状态</th>
              <th>操作</th>
		</tr>
		<c:forEach items="${page.list}" var="pack" varStatus="i">
		      
			    <tr id="${pack.id}">
				<td>
				<input type="checkbox" value="${pack.id}" class="checkRow" name="checkRow"/>
				 <input class="ii" type="hidden" value="${pack.exponential}">
				</td> 
				<td>${pack.startTime}~${pack.endTime}</td>
                <td><fmt:formatNumber type="number" value="${pack.totalLove}" pattern="0.0000" maxFractionDigits="4"/></td>
                <c:set var="totalLove" value="${pack.totalLove+totalLove}"></c:set>  
                <td><fmt:formatNumber type="number" value="${pack.loveNum}" pattern="0.0000" maxFractionDigits="4"/></td>
                <c:set var="totalPrice" value="${pack.loveNum+totalPrice}"></c:set>  
                <td><fmt:formatNumber type="number" value="${pack.totalAmt}" pattern="0.00" maxFractionDigits="2"/></td>
                <c:set var="totalAmt" value="${pack.totalAmt+totalAmt}"></c:set>  
                <td><fmt:formatNumber type="number" value="${pack.exponential}" pattern="0.00" maxFractionDigits="4"/></td>
                <c:set var="exponential" value="${pack.exponential+exponential}"></c:set>  
                <td><fmt:formatNumber type="number" value="${pack.actualAmt}" pattern="0.00" maxFractionDigits="2"/></td>
                 <c:set var="actualAmt" value="${pack.actualAmt+actualAmt}"></c:set>  
                <td><fmt:formatNumber type="number" value="${pack.fee}" pattern="0.00" maxFractionDigits="2"/></td>
                <c:set var="fee" value="${pack.fee+fee}"></c:set>  
                <td><fmt:formatNumber type="number" value="${pack.ratio}" pattern="0.00" maxFractionDigits="2"/></td>
                <c:set var="ratio" value="${pack.ratio+ratio}"></c:set>  
                <td>${pack.allotTime}</td>
                 <td><c:if test="${pack.isAllot==1&&(pack.executeStatus==2)&&empty pack.ncOrderNo}"><font color="red">未同步:</font><input type="button" value="开始同步" onclick="To_resynchronize('${pack.id}')"/></c:if>
				 <c:if test="${pack.isAllot==1&&(pack.executeStatus==2)&&not empty pack.ncOrderNo}"><font color="green">同步成功：${pack.ncOrderNo}</font></c:if>
				 </td>
				<td><c:if test="${pack.isAllot==1&&pack.executeStatus==2}">已分配</c:if><c:if test="${pack.isAllot==2}">已取消</c:if> <c:if test="${pack.isAllot==0&&pack.executeStatus==0}"><a href="javascript:;" class="check-a">分配 </a> <a href="javascript:;" >取消</a></c:if> <c:if test="${pack.isAllot==0&&pack.executeStatus==1}">正在处理</c:if><c:if test="${pack.isAllot==1&&pack.executeStatus==1}">正在处理</c:if>  </td>
			</tr>
		</c:forEach>
		<tr>
		    <th>合计:</th>
		    <th></th>
		    <th><fmt:formatNumber type="number" value="${totalLove}" pattern="0.0000" maxFractionDigits="4"/></th>
            <th><fmt:formatNumber type="number" value="${totalPrice}" pattern="0.0000" maxFractionDigits="4"/></th>
            <th><fmt:formatNumber type="number" value="${totalAmt}" pattern="0.00" maxFractionDigits="2"/></th>
            <th><fmt:formatNumber type="number" value="${exponential }" pattern="0.00" maxFractionDigits="4"/></th>
            <th><fmt:formatNumber type="number" value="${actualAmt}" pattern="0.00" maxFractionDigits="2"/></th>
            <th><fmt:formatNumber type="number" value="${fee}" pattern="0.00" maxFractionDigits="2"/></th>
            <th><fmt:formatNumber type="number" value="${ratio}" pattern="0.00" maxFractionDigits="2"/></th>
            <th></th>
            <th></th>
		</tr>
	</table>
	<div class="pagination">${page}</div>
	  <div class="fix-in">
        <div class="fix-box">
            <p>编辑--收益分配 <!-- <img src="images/xxx-rzt.png" alt=""> --></p>
            <div>
                <ul>
                    <li>
                        <span>统计时间：</span>
                        <b>2017-04-11 00:00:00 ~ 2017-06-30 00:00:00</b>
                    </li>
                    <li>
                        <span>商家昨日让利总额：</span>
                        <b>330.6</b>
                    </li>
                    <li>
                        <span>分配积分总数：</span>
                        <b>0</b>
                    </li>
                    <li>
                        <span>今日积分指数：</span>
                       
                        <b></b>
                    </li>
                </ul>
                <div class="fix-btn">
                    <a class="fix-add" href="javascript:;">确定分配</a>
                    <a class="fix-del" href="javascript:;">取消</a>
                </div>
            </div>
        </div>
        
        <script>
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
				    url : "${ctxsys}/PmSysLoveAllot/exsel",   
				    success : function (data) {
				         window.location.href=data; 
				    }
		         });
	     });
	</script>
	
</div>