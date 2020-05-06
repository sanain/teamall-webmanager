<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<meta name="decorator" content="default"/>
	<title>用户提现列表</title>
	<link rel="stylesheet" href="${ctxStatic}/sbShop/css/build.css">
	<link rel="stylesheet" href="${ctxStatic}/sbShop/css/admin_userAmtlog.css">
	<script type="text/javascript" src="${ctxStatic}/sbShop/js/admin_userAmtlog.js"></script>
	<script src="${ctxStatic}/supplyshop/layui/lay/modules/layer.js?v=1" type="text/javascript"></script>
	<link href="${ctxStatic}/supplyshop/layui/css/modules/layer/default/layer.css?v=1" type="text/css" rel="stylesheet" />
	<script type="text/javascript">
	function page(n,s){
		if(n)$("#pageNo").val(n);
		if(s)$("#pageSize").val(s);
		$("#searchForm").attr("action","${ctxsys}/UserAmtLog");
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
	    $('body').on('click','.lishi-del',function(){
			$('.lishi').hide();
		})
	});
	
	function postid(id){
		$.ajax({
		    type:'post',
		    contentType:"application/x-www-form-urlencoded;charset=UTF-8",
		    url:"${ctxsys}/UserAmtLog/form",
		    datatype:"json",
		    data:{
		       	id:id
		    },
		    success:function(data){
		    	var obj = data.pmAmt;//eval('(' + data + ')');
				var pmUserBank = data.pmUserBank;
		    	if(obj!=""){
			       	var html="";
			      	html+='<div class="lishi-box" style="height: auto;">';
			      	html+='<p>查看提现详情<img class="lishi-del" src="${ctxStatic}/hAdmin/img/xxx-rzt.png" alt=""></p>';
			      	html+='<div class="lishi-div">';
			      	html+='<div class="lishi-body">';
			      	html+='<p>';
			      	// var strdate2 = timeStamp2String(obj.createTime.time);
			      	html+='<span>'+obj.createTime+'</span></p>';
			      	html+='<div><span>开&nbsp;户&nbsp;名：</span>'+pmUserBank.accountName+'</div>';
			      	html+='<div><span>银行账号：</span>'+pmUserBank.account+'</div>';
			      	html+='<div><span>提现金额：</span>'+obj.amt+'</div>';
			      	html+='<div><span>提现编码：</span>'+((obj.applycode+"")=='undefined'?'':obj.applycode)+'</div>';
			      	html+='<div><span>返回原因：</span>'+((obj.reasonBack+"")=='undefined'?'':obj.reasonBack)+'</div>';
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
		if(obj.status==2){
			html+='<div><span>提现状态：</span>已取消</div>';
			html+='<div><span>取消原因：</span>'+obj.remark+'</div>';
      	}
		if(obj.status==3){
			html+='<div><span>提现状态：</span>审核通过</div>';
      	}
		return html;
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
	//function applypiEdit(status){
	$('body').one('click','.applypiEdit',function(){
	    var status=$(this).attr('status');
		var id_array=new Array();  
		$('.kl-to[type=checkbox]:checked').each(function(){  
		    id_array.push($(this).val());//向数组中添加元素  
		});  
		var idstr=id_array.join(',');
		 $.ajax({
		    type:'post',
		    contentType:"application/x-www-form-urlencoded;charset=UTF-8",
		    url:"${ctxsys}/UserAmtLog/piEdit",
		    datatype:"json",
		    beforeSend: function(){
				     loading('请等待。。');
				    },
		    data:{ids:idstr,status:status},
		    success:function(data){
			  $("#searchForm").attr("action","${ctxsys}/UserAmtLog");
			  $("#searchForm").submit();
		    }
		})
	})
	
	</script>
	<script>
	function To_resynchronize(uid){
	var msg = "同步成功";
	debugger;
	$.ajax({
	 					url : "${ctxsys}/NcMessageTable/cashWithdrawalnc_reset",
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
								  $("#searchForm").attr("action","${ctxsys}/UserAmtLog");
								 $("#searchForm").submit();
	 						} else {
	 							top.$.jBox.tip(data.msg, 'info');
	 						}
	 					}
	 				});
	    }

	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctxsys}/UserAmtLog">用户提现列表</a></li>
	</ul>
	 <form id="searchForm" action="UserAmtLog" method="post" class="breadcrumb form-search ">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
		 <input id="chooseShopId" name="shopIds" type="hidden" value="${shopIds}"/>
		 <tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form">
		    <li>
		       <select id="status" name="status" class="input-medium">
		         <option value="">状态</option>
		         <option ${status=='0'?'selected':''} value="0">待审核</option>
		         <option ${status=='1'?'selected':''} value="1">已完成</option>
		         <option ${status=='2'?'selected':''} value="2">已取消</option>
		         <option ${status=='3'?'selected':''} value="3">审核通过</option>
		       <select>
		    </li>
		    <li>
		    <input class="small" type="text" style="width:130px" name="startTime" id="create_time_start" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" value="${startTime}" placeholder="请输入开始时间"/>
		    <span>-</span>
		     <input class="small" type="text" name="endTime" style="width:130px" id="create_time_start" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" style=" width: 100px;" value="${endTime}" placeholder="请输入结束时间"/>
              
            </li>
		    <li style="margin-left:10px;>
		    	<input value="${mobile}" id="phoneNum" name="mobile" type="text" maxlength="11" placeholder="账号" onkeyup="value=value.replace(/[^\d]/g,'')" onbeforepaste="clipboardData.setData('text',clipboardData.getData('text').replace(/[^\d]/g,''))" />
		    </li>
			<li><label>显示方式:</label>
				<input class="form-check-input" type="radio" onclick="chooseShop(1)" style="padding: 10px 0px" name="isAllShop" value="1" <c:if test="${shopIds ==null||  ''.equals(shopIds)}">checked="checked"</c:if>>所有门店
				<input class="form-check-input" type="radio"  onclick="chooseShop(0)" style="padding: 10px 0px" name="isAllShop" value="0" <c:if test="${shopIds != null && !''.equals(shopIds)}">checked="checked"</c:if>>指定门店
			</li>
			<li id="shop-name-li"
					<c:if test="${shopNames == null || ''.equals(shopNames)}">
						style="display: none"
					</c:if>
			><label class="layui-form-label">当前门店:</label>  <input type="text" onclick="chooseShop(0)" class="input-medium" readonly id="shopName" name="shopNames" value="${shopNames}"  style=" width: 200px;margin: 4px 0px;"></li>
			</li>
		    <li style="margin-left:10px;"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/></li>
		     <li style="margin-left:10px;margin-right:10px"><input id="btnExport" class="btn btn-primary check-a2" type="button" value="批量同意"/></li>
		    <li class="clearfix" style="margin-left:10px;"><input id="btnExport" class="btn btn-primary check-a1" type="button" value="导出"/></li>
		   
		</ul>

	<div class="check1">
    <div class="check-box">
        <p>导出选项<img class="check-del1" src="${ctxStatic}/sbShop/images/xxx-rzt.png" alt=""></p>
          <ul class="mn1">
	          <li class="checkbox"><input type="checkbox" class="kl" value="" id="all"><label><i></i>全选</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="1"><label><i></i>申请时间</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="2"><label><i></i>类型</label></li>
	          <!-- <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="3"><label><i></i>开户国家</label></li> -->
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="3"><label><i></i>开户名</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="4"><label><i></i>银行卡号</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="5"><label><i></i>开户银行</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="6"><label><i></i>所属支行</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="7"><label><i></i>状态</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="8"><label><i></i>可提现金额</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="9"><label><i></i>现申请提现金额</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="10"><label><i></i>手机</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="11"><label><i></i>提现编码</label></li>
          </ul>
        <div class="check-btn">
            <a href="javascript:;" id="fromNewActionSbM" >确定</a>
            <a class="check-del1" href="javascript:;">取消</a>
        </div>
      </div>
    </div>
    </form> 
	<tags:message content="${message}"/>
	<table id="treeTable" class="table table-striped table-condensed table-bordered">
		<tr>
		 <th><input type="checkbox"  id="all-to">全选</th>
		 <th>门店名称</th>
		 <th>申请时间</th>
		 <th>类型</th>
		 <th>可提现金额</th>
		 <th>现申请提现金额</th>
		 <%-- <th>开户国家</th> --%>
		 <th>开户姓名</th>
		 <!-- <th>预留号码</th> -->
		 <th>银行卡号</th>
		 <th>开户银行</th>
		 <th>所属支行</th>
		 <th>状态</th>
		</tr>
		<c:forEach items="${page.list}" var="pmAmtLog">
			<c:set var="amt" value="${pmAmtLog.amt+amt}"></c:set> 
			<tr>
			    <td><input type="checkbox" class="kl-to" value="${pmAmtLog.id}"></td>
				<td><a href="${ctxsys}/PmShopInfo/amtlogIndex?id=${pmAmtLog.pmShopInfo.id}">${pmAmtLog.pmShopInfo.shopName}</a></td>
			    <td>
			    <fmt:formatDate value="${pmAmtLog.createTime}" type="both"/></td>
			    <td>
					<c:if test="${pmAmtLog.pmUserBank.bankType==0}">银行卡</c:if>
					<c:if test="${pmAmtLog.pmUserBank.bankType==1}">支付宝</c:if>
				</td>
				<td>${pmAmtLog.currentAmt}</td>
				<td>${pmAmtLog.amt}</td>
				<%-- <c:if test="${empty pmAmtLog.pmUserBank.countryName}">
				<td>中国</td>
				</c:if>
				<c:if test="${!empty pmAmtLog.pmUserBank.countryName}">
				<td>${pmAmtLog.pmUserBank.countryName}</td>
				</c:if> --%>
			    <td>${pmAmtLog.pmUserBank.accountName}</td>
			  <%--   <td>${pmAmtLog.pmUserBank.phoneNum}</td> --%>
			    <td>${pmAmtLog.pmUserBank.account}</td>
			    <td>${pmAmtLog.pmUserBank.bankName}</td>
			    <td>${pmAmtLog.pmUserBank.subbranchName}</td>
			    <td>
			    	<shiro:hasPermission name="merchandise:UserAmtLog:edit">
					    <c:if test="${pmAmtLog.status==0}">待审核
					    	<a class="yes" amtLogid="${pmAmtLog.id}" href="javascript:;">同意提现</a>
					    	<a class="no" amtLogid="${pmAmtLog.id}" href="javascript:;">拒绝提现</a>
					    </c:if>
				    </shiro:hasPermission>
				    <shiro:hasPermission name="merchandise:UserAmtLog:view">
					    <c:if test="${pmAmtLog.status==1}">已完成</c:if>
					    <c:if test="${pmAmtLog.status==2}">已取消</c:if>
					    <c:if test="${pmAmtLog.status==3}">审核通过</c:if>
						 <a href="javascript:;" onclick="postid(${pmAmtLog.id})">查看</a> 
					</shiro:hasPermission>
				</td>
			</tr>
		</c:forEach>
		<tr>
			<th></th>
			<th></th>
			<th></th>
			<th></th>
			<th></th>
			<th>${amt}</th>
			<th></th>
			<th></th>
			<th></th>
			<th></th>
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
    });
     $('#fromNewActionSbM').click(function(){
     	var id_array=new Array();  
		$('.kl-to[type=checkbox]:checked').each(function(){  
		    id_array.push($(this).val());//向数组中添加元素  
		});  
		var idstr=id_array.join(',');
		
	     $.ajax({
			    type : "POST",
			    data:$('#searchForm').serialize(),
			    url : "${ctxsys}/UserAmtLog/exsel?ids="+idstr,   
			    success : function (data) {
			        window.location.href=data; 
			    }
	         });
     });
      $('#all-to').click(function(){
        if($(this).is(':checked')){
            $('.kl-to').prop('checked',true).attr('checked',true);
            $('#all-to').prop('checked',true).attr('checked',true);
        }else {
            $('.kl-to').removeAttr('checked');
            $('#all-to').removeAttr('checked');
        }
    });
	$('body').on('click','.kl-to',function(){
        if ($('.kl-to').length==$('.kl-to[type=checkbox]:checked').length){
            $('#all-to').prop('checked',true).attr('checked',true);
        }else {
            $('#all-to').removeAttr('checked');
        }
    });
	 //function apply(i){
	$('body').one('click','.apply',function(){
	  var i=$(this).attr('i');
	  $.ajax({
		    type : "POST",
		    data:{id:$('#id-y').val(),Vstatus:i},
		    url : "${ctxsys}/UserAmtLog/edit",   
		    async: false,
		    beforeSend: function(){
				     loading('请等待。。');
				    },
		    success : function (data) {
		       alertx('操作成功');
		        page();
		    }
         });
	})
	//提交

      //选择指定门店或者汇总
      function chooseShop(isAll){
          $(".isAll").val(isAll);

          if(isAll == 0){
              layer.open({
                  type: 2,
                  title: '门店列表',
                  shadeClose: true,
                  shade: false,
                  maxmin: true, //开启最大化最小化按钮
                  area: ['880px', '450px'],
                  content: '${ctxsys}/Product/chooseShops?shopIds='+ $("#chooseShopId").val() ,
                  btn: ['确定', '关闭'],
                  yes: function(index, layero){ //或者使用btn1
                      debugger;
                      var content = layero.find("iframe")[0].contentWindow.$('#chooseIds').val();
                      var chooseNames = layero.find("iframe")[0].contentWindow.$('#shopNames').val();
                      if(content==""){
                          layer.msg("请选择一个门店");
                      }else{
                          $("#chooseShopId").val(content);
                          $("#shopName").val(chooseNames);
                          $("#shop-name-li").css("display","inline-block");
                          layer.close(index);
                      }
                  }
              })
          }else{
              $("#chooseShopId").val("");
              $("#shopName").val("");
              $("#shop-name-li").css("display","none");
          }
      }

	</script>
	<input type="hidden" id="ctxsys" name="ctxsys" value="${ctxsys}"/>
	
			<div class="lishi-yes">
		<div class="lishi-yes-box">
			<p>同意提现<img class="lishi-del-yes" src="${ctxStatic}/hAdmin/img/xxx-rzt.png" alt=""></p>
			<div class="lishi-yes-div">
				<div class="lishi-yes-body">
					<form id="yesForm" method="post">
						<input type="hidden" id="id-y" name="id"/> 
						<div>是否同意提现</div>
					 	<%-- <div>提现编码：<input id="applycode" name="applycode" type="text" maxlength="25" onkeydown="if(event.keyCode==13)event.keyCode=9" onKeyPress="if((event.keyCode<48 || event.keyCode>57)) event.returnValue=false"/></div> --%>
					</form>
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
			<p>拒绝提现<img class="lishi-del-no" src="${ctxStatic}/hAdmin/img/xxx-rzt.png" alt=""></p>
			<div class="lishi-no-div">
				<div class="lishi-no-body">
					<div>拒绝原因：</div>
					<form id="noForm" method="post">
						<input type="hidden" id="id-n" name="id"/>
						<div><textarea id="remark" name="remark"></textarea></div>
					</form>
					<div style="text-align:center;margin-top:12px;">
						<a class="btn btn-primary post-n" href="javascript:;">保存</a>
						<a class="btn btn-primary lishi-del-no" href="javascript:;">关闭</a>
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