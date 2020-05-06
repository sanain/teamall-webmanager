<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>提现记录</title>
<%@include file="/WEB-INF/views/include/dialog.jsp" %>
<meta name="decorator" content="default"/>
<link rel="stylesheet" href="${ctxStatic}/sbShop/css/build.css">
	<link rel="stylesheet" href="${ctxStatic}/sbShop/css/admin_userAmtlog.css">
	<%--<script type="text/javascript" src="${ctxStatic}/sbShop/js/admin_userAmtlog.js"></script>
	--%><style>
        .check{position: fixed;top:0;left: 0;right: 0;bottom: 0;background: rgba(0,0,0,0.3);z-index: 10000}
        .check-box{width: 750px;background: #ffffff;position: absolute;top: 50%;left: 50%;margin-left: -375px;margin-top: -200px;}
        .check-box>p{height: 35px;line-height: 35px;background: #f0f0f0;position: relative;text-align: center}
        .check-box>p img{position: absolute;top:12px;right: 15px;cursor: pointer}
        .check-box ul{overflow: hidden;padding: 10px;outline:none;list-style:none}
        .check-box ul li.checkbox{float: left;width: 30%;line-height: 30px;margin-top: 0;}
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
	    $('body').on('click','.lishi-del-yes',function(){
			$(this).closest('.lishi-yes').hide();
			$(this).closest('.pi-yes').hide();
		})
		$('.check-a2').click(function(){
			deleteService();
		});
	 $('body').on('click','.lishi-del',function(){
			$('.lishi').hide();
		})
		 	$('.check1').hide();
	    	$('body').on('click','.check-a1',function(){
	    		$('.check1').show();
	    	});
	    	
	    	$('body').on('click','.check-del1',function(){
	    		$('.check1').hide();
	    	});
	     });
 
 //function applypiEdit(status){
  $('body').one('click','.applypiEdit',function(){
	 var status=$(this).attr('status');
	 var idstr=check_val.join(',');
	 $.ajax({
	    type:'post',
	    contentType:"application/x-www-form-urlencoded;charset=UTF-8",
	    url:"${ctxsys}/pmAgentAmtLog/piEdit",
	    datatype:"json",
	    data:{ids:idstr,status:status},
	    success:function(data){
		  $("#searchForm").attr("action","${ctxsys}/pmAgentAmtLog");
		  $("#searchForm").submit();
	    }
	})
  })

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

var check_val;
function deleteService(){
	obj = document.getElementsByName("checkRow");
	check_val = [];
	for(k in obj){
		if(obj[k].checked)
			check_val.push(obj[k].value);
	}
	if(check_val!=null&&check_val.length>0){
		$('.pi-yes').show();
	}else{
		alert("至少选择一条");
	}
	
}

function sale(){
	obj = document.getElementsByName("checkRow");
	
	check_val = [];
	for(k in obj){
		if(obj[k].checked)
			check_val.push(obj[k].value);
	}
	if(check_val.length==0){
		alert("请选择要启用的服务包");
	}else{
		return confirmx('确认要启用该服务包吗？', '${ctxsys}/bsky/product/sale?ids=' + check_val);
}
}

function page(n,s){
	if(n) $("#pageNo").val(n);
	if(s) $("#pageSize").val(s);
	$("#searchForm").attr("action","${ctxsys}/pmAgentAmtLog/list");
	$("#searchForm").submit();
	return false;
}
function postid(id){
	$.ajax({
		type: "POST",
	    url:"${ctxsys}/pmAgentAmtLog/show",
		data: {id:id},
	    success:function(obj){console.log(obj)
	    	if(obj!=""){
		       	var html="";
		       	html+='<div class="lishi-box" style="height: auto;">';
		      	html+='<p>查看提现详情<img class="lishi-del" src="${ctxStatic}/hAdmin/img/xxx-rzt.png" alt=""></p>';
		      	html+='<div class="lishi-div">';
		      	html+='<div class="lishi-body">';
		      	html+='<p>';
		      	html+='<div><span>开&nbsp;户&nbsp;名：</span>'+obj.pmAgentBank.accountName+'</div>';
		      	html+='<div><span>银行账号：</span>'+obj.pmAgentBank.account+'</div>';
		      	html+='<div><span>提现金额：</span>'+obj.amt+'</div>';
		      	html+='<div><span>提现编码：</span>'+handle(obj.applycode)+'</div>';
		      	html+='<div><span>返回原因：</span>'+handle(obj.reasonBack)+'</div>';
		      	
		    	html+=statusString(obj,html);
		    	
		      	html+='</div>';
		      	html+='</div>';
		      	html+='</div>';
		      	$(".lishi").html(html).show();
	       	}
	    }
	});
}
function statusString (obj){
	var html='';
	if(obj.status==0){
  		html+='<div><span>提现状态：</span>待审核</div>';
  	}
	if(obj.status==1){
		html+='<div><span>提现状态：</span>已完成</div>';
  	}
	if(obj.status==3){
		html+='<div><span>提现状态：</span>审核完成</div>';
  	}
	if(obj.status==2){
		html+='<div><span>提现状态：</span>已取消</div>';
		html+='<div><span>取消原因：</span>'+obj.remark+'</div>';
  	}
	/* if(obj.status!=0){
		if(obj.batchNo!=''){
      		html+='<div><span>提现方式：</span>代付提现</div>';
		}else{
      		html+='<div><span>提现方式：</span>手工提现</div>';
		}
  	} */
	return html;
}
//处理空字符串
function handle(str){
	if(typeof(str)=="undefined"){
		return "";
	}
	return str;
}  	
function timeStamp2String (time){
	var datetime = new Date();
    datetime.setTime(time);
    var year = datetime.getFullYear();
    var month = datetime.getMonth() + 1;
    var date = datetime.getDate();
    var hour = datetime.getHours();
    var minute = datetime.getMinutes();
    var second = datetime.getSeconds();
    var mseconds = datetime.getMilliseconds();
    return year + "-" + month + "-" + date+"&nbsp;&nbsp;"+hour+":"+minute+":"+second;
};
</script>   

</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctxsys}/pmAgentAmtLog/list">提现列表</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="pmAgentAmtLog" action="" method="post" class="breadcrumb form-search ">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form">
			<li style="display:none"><label>代理账号：</label><form:input path="sysUser.loginName"  htmlEscape="false" maxlength="50" class="input-medium"/></li>
			<li><label>银行账号 ：</label><form:input  path="pmAgentBank.account"  htmlEscape="false" maxlength="50" class="input-medium"/></li>
			<%--<li><label>手机号 ：</label><form:input  path="pmAgentBank.phoneNum"  htmlEscape="false" maxlength="50" class="input-medium"/></li>
		    --%><li>
			<label>申请时间 ：</label>
		    <input class="small" type="text" style="width:130px" name="startTime" id="startTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" value="${startTime}" placeholder="请输入开始时间"/>
		    <span>-</span>
		     <input class="small" type="text" name="endTime" style="width:130px" id="endTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" style=" width: 100px;" value="${endTime}" placeholder="请输入结束时间"/>
            </li>
			<li><label>交易状态:</label>
				<form:select path="status" class="input-small">
				<form:option value=""></form:option>
				<form:option value="0">待审核</form:option>
				<form:option value="1">交易完成</form:option>
				<form:option value="2">交易取消</form:option>
				<!-- <form:option value="3">审核完成</form:option> -->
				
				</form:select>
			</li>
			
			 <li class="btns">
			 	<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/>
			 	<li style="margin-right:10px"><input id="btnExport" class="btn btn-primary check-a2" type="button" value="批量同意"/></li>
				<li><input id="btnExport" class="btn btn-primary check-a1" type="button" value="导出"/></li>
			</li> 
		</ul>
	<div class="check1">
    	<div class="check-box">
        <p>导出选项<img class="check-del1" src="${ctxStatic}/sbShop/images/xxx-rzt.png" alt=""></p>
          <ul class="mn1">
	          <li class="checkbox"><input type="checkbox" class="kl" value="" id="all"><label><i></i>全选</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="0"><label><i></i>代理名称</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="1"><label><i></i>开户名</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="2"><label><i></i>提现账号</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="3"><label><i></i>提现金额</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="4"><label><i></i>手续费</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="5"><label><i></i>手机号</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="6"><label><i></i>交易状态</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="7"><label><i></i>申请时间</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="8"><label><i></i>开户银行</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="9"><label><i></i>所属支行</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="10"><label><i></i>提现编码</label></li>
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
		<tr>
			<th><input type="checkbox" class="checkAll" name="checkAll" onclick="checkAll();"/></th>
			<th>申请时间</th>
			<th>代理名称</th>
			<th>开户名</th>
			<th>提现账号</th>
			<th>开户银行</th>
			<th>所属支行</th>
			<th>提现金额</th>
			<th>手续费</th>
			<th>手机号</th>
			<th>状态</th>
		</tr>
		<c:forEach items="${page.list}" var="record">
			<tr id="${record.id}">
				<td><input type="checkbox" value="${record.id}" class="checkRow" name="checkRow"/></td> 
				<td><fmt:formatDate value="${record.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				<td>${record.pmAgentInfo.agentName}</td>
				<td>${record.pmAgentBank.accountName}</td>
				<td>${record.pmAgentBank.account}</td>
				<td>${record.pmAgentBank.bankName}</td>
				<td>${record.pmAgentBank.subbranchName}</td>
				<c:set var="amt" value="${record.amt+amt}"></c:set> 
				<td>${record.amt}</td>
				<c:set var="fee" value="${record.fee+fee}"></c:set> 
				<td>${record.fee}</td>
				<td>${record.pmAgentBank.phoneNum}</td>
				<td>
					    <c:if test="${record.status==0}">待审核
					    	<a class="yes" amtLogid="${record.id}" onclick="sapply('${record.id}','1');">同意提现</a>
					    	<a class="no" amtLogid="${record.id}" onclick="sapply('${record.id}','2');">拒绝提现</a>
					    </c:if>
					    <c:if test="${record.status==1}">已完成</c:if>
					    <c:if test="${record.status==2}">已取消</c:if>
					    <c:if test="${record.status==3}">审核完成</c:if>
						<a onclick="postid('${record.id}')">查看</a>
				</td>
				
				<%--<td><a href="${ctxsys}/pmAgentAmtLog/form?id=${record.id}">查看详细</a></td>
			--%></tr>
		</c:forEach>
		   <tr>
			<th></th>
			<th></th>
			<th></th>
			<th></th>
			<th></th>
			<th></th>
			<th></th>
			<th>${amt}</th>
			<th>${fee}</th>
			<th></th>
			<th></th>
			<th></th>
		  </tr>
	</table>
	<div class="pagination">${page}</div>
	<div class="lishi"></div>
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
     	var id_array=new Array();  
		$('.checkRow[type=checkbox]:checked').each(function(){  
		    id_array.push($(this).val());//向数组中添加元素  
		});  
		var idstr=id_array.join(',');
	     $.ajax({
			    type : "POST",
			    data:$('#searchForm').serialize(),
			    url : "${ctxsys}/pmAgentAmtLog/exsel?ids="+idstr,   
			    success : function (data) {
			         window.location.href=data; 
			    }
	         });
     });
	
	//提交
    //function apply(i){
  $('body').one('click','.apply',function(){
	 var i=$(this).attr('i');
     var applycode=$('#applycode').val();
     var remark=$('#remark').val();
     if(i=="1"||i=="3"){
    	$("#yesForm").attr("action","${ctxsys}/pmAgentAmtLog/withdrawState?status="+i+"&id="+recordid);
    	$("#yesForm").submit();
     }
     
     if(i=="2"){
    	 if(remark==""){
        	 alert("拒绝原因不能空"); 
			 return;
         }
    	$("#noForm").attr("action","${ctxsys}/pmAgentAmtLog/withdrawState?status=2&id="+recordid);
    	$("#noForm").submit();
     }
	 
	});
	var recordid="";
    function sapply(id,i){
    	if(i=='1'){
    		$('.lishi-yes').show();
    	}else if(i=='2'){
    		$('.lishi-no').show();
    	}
    	
		recordid=id;
    }	
	function sapplyhide(){
    		$('.lishi-yes').hide();
    		$('.lishi-no').hide();
    }	
	</script>
		<input type="hidden" id="ctxsys" name="ctxsys" value="${ctxsys}"/>
	<div class="lishi-yes">
		<div class="lishi-yes-box">
			<p>同意提现<img class="lishi-del-yes" src="${ctxStatic}/hAdmin/img/xxx-rzt.png" alt=""></p>
			<div class="lishi-yes-div">
				<div class="lishi-yes-body">
					<form id="yesForm" method="post" >
					<div>是否同意提现</div>
					 	<%--<div>提现编码：<input id="applycode" name="applycode" type="text" maxlength="25" onkeydown="if(event.keyCode==13)event.keyCode=9" onKeyPress="if((event.keyCode<48 || event.keyCode>57)) event.returnValue=false"/></div>
					--%></form>
					<div style="text-align:center;margin-top:8px;">
						<a class="btn btn-primary apply" i="1">手动打款</a>
						<a class="btn btn-primary apply" i="3">银行打款</a>
						<a class="btn btn-primary lishi-del-yes" href="javascript:;">取消</a>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="lishi-no">
		<div class="lishi-no-box">
			<p>拒绝提现<img class="lishi-del-no" src="${ctxStatic}/hAdmin/img/xxx-rzt.png" alt=""/></p>
			<div class="lishi-no-div">
				<div class="lishi-no-body">
					<div>拒绝原因：</div>
					<form id="noForm" method="post" >
						<div><textarea id="remark" name="remark"></textarea></div>
					</form>
					<div style="text-align:center;margin-top:12px;">
						<a class="btn btn-primary apply" i="2">保存</a>
						<a class="btn btn-primary lishi-del-no" href="javascript:;" onclick="sapplyhide()">关闭</a>
					</div>
				</div>
			</div>
		</div>
	</div>
	
		<div class="pi-yes">
		<div class="lishi-yes-box">
			<p>同意提现<img class="lishi-del-yes" src="${ctxStatic}/hAdmin/img/xxx-rzt.png" alt=""></p>
			<div class="lishi-yes-div">
				<div class="lishi-yes-body">
					<form id="yesForm1" method="post">
						<!-- <input type="hidden" id="id-y" name="id"/> -->
						<div>是否把选中的批量同意</div>
					 	<%-- <div>提现编码：<input id="applycode" name="applycode" type="text" maxlength="25" onkeydown="if(event.keyCode==13)event.keyCode=9" onKeyPress="if((event.keyCode<48 || event.keyCode>57)) event.returnValue=false"/></div> --%>
					</form>
					<div style="text-align:center;margin-top:8px;">
						<a class="btn btn-primary post-yto applypiEdit" status="1">手动打款</a>
						<a class="btn btn-primary post-yto applypiEdit" status="3">银行打款</a>
						<a class="btn btn-primary lishi-del-yes" href="javascript:;">取消</a>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>