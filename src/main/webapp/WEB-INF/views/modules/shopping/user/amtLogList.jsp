<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<meta name="decorator" content="default"/>
	<meta name="Description" content="${fns:getProjectName()},余额日志列表"/>
	<meta name="Keywords" content="${fns:getProjectName()},余额日志列表"/>
	<title>余额日志列表</title>
	<link rel="stylesheet" href="${ctxStatic}/sbShop/css/build.css">
	<%-- <style>
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
    </style> --%>
	<style type="text/css">
	p{margin: 0;}
        .lishi{display:none;position: fixed;top: 0;left: 0;right: 0;bottom: 0;background: rgba(0,0,0,0.3);}
        .lishi-box{border:3px solid #69AC72;position: absolute;width: 450px;height: 300px;background: #ffffff;border-radius: 5px;top: 50%;left: 50%;margin-left: -225px;margin-top: -150px}
        .lishi-box>p{background:#69AC72;line-height: 39px;height: 39px;color: #fff;padding: 0 20px;border-bottom: 1px solid #e5e5e5;font-size: 16px;margin: 0;}
        .lishi-box>p img{float: right;margin-top: 14px;cursor: pointer}
        .lishi-div{height: 300px;overflow-y:auto; color: #000}
        .lishi-body{padding: 20px;}
        .lishi-body>p{height: 30px;line-height: 30px;margin-bottom: 15px}
        .lishi-body>p i{width: 30px;height: 30px;text-align: center;line-height: 30px;border-radius: 50%;border: 1px solid #e5e5e5;float: left}
        .lishi-body>p i img{border-radius: 50%;width:100%}
        .lishi-body>p b{font-weight: normal; color: #529E5C;margin-left: 10px}
        .lishi-body>p span{float: left;color: #000}
        .lishi-body u{display: inline-block;width: 160px;height: 160px;line-height: 160px;text-align: center;overflow: hidden;margin-right: 1px}
        .lishi-body>div{margin-bottom: 10px;font-size: 14px;}
        .lishi-body>div>span:nth-child(1){width:30%;text-align:right;display:inline-block;}
    </style>
	<script type="text/javascript">
	 /* $(function(){
		 	$('.check1').hide();
	    	$('body').on('click','.check-a1',function(){
	    		$('.check1').show();
	    	});
	    	$('body').on('click','.check-del1',function(){
	    		$('.check1').hide();
	    	});
	     }); */
	function page(n,s){
		$("#pageNo").val(n);
		$("#pageSize").val(s);
		$("#searchForm").attr("action","${ctxsys}/UserAmtLog/pageAmtLog");
		$("#searchForm").submit();
	    return false;
	}
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
		    	var obj = eval('(' + data + ')');
		    	if(obj!=""){
			       	var html="";
			      	html+='<div class="lishi-box">';
			      	html+='<p>查看提现详情<img class="lishi-del" src="${ctxStatic}/hAdmin/img/xxx-rzt.png" alt=""></p>';
			      	html+='<div class="lishi-div">';
			      	html+='<div class="lishi-body">';
			      	html+='<p>';
			      	var strdate2 = timeStamp2String(obj.createTime.time);
			      	html+='<span>'+strdate2+'</span></p>';
			      	html+='<div><span>开户姓名：</span>'+obj.pmUserBank.accountName+'</div>';
			      	html+='<div><span>预留号码：</span>'+obj.pmUserBank.phoneNum+'</div>';
			      	html+='<div><span>银行账号：</span>'+obj.pmUserBank.account+'</div>';
			      	html+='<div><span>提现金额：</span>'+obj.amt+'</div>';
			      	html+='<div><span>提现编码：</span>'+obj.applycode+'</div>';
			      	if(obj.status==0){
			      		html+='<div><span>提现状态：</span>交易中</div>';
			      	}
					if(obj.status==1){
						html+='<div><span>提现状态：</span>已完成</div>';
			      	}
					if(obj.status==2){
						html+='<div><span>提现状态：</span>已取消</div>';
			      	}
			      	html+='</div>';
			      	html+='</div>';
			      	html+='</div>';
			      	$(".lishi").html(html).show();
		       	}
		    }
		});
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
	$(function(){
		$('body').on('click','.lishi-del',function(){
			$('.lishi').hide();
		})
	})
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctxsys}/UserAmtLog">余额日志列表</a></li>
	</ul>
	 <form id="searchForm" action="UserAmtLog" method="post" class="breadcrumb form-search ">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
		<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form">
		    <li>
		       <select id="status" name="status" class="input-medium">
		         <option value="">交易状态</option>
		         <option value="0" <c:if test="${status==0}">selected="selected" </c:if> >交易中</option>
		         <option value="1"  <c:if test="${status==1}">selected="selected" </c:if>>已完成</option>
		         <option value="2"  <c:if test="${status==2}">selected="selected" </c:if>>已取消</option>
		       <select>
		    </li>
		    <li>
		       <select id="amtType" name="amtType" class="input-medium">
		         <option value="">金额类型</option>
		         <option value="1" <c:if test="${amtType==1}">selected="selected" </c:if>>购物</option>
		         <option value="2" <c:if test="${amtType==2}">selected="selected" </c:if>>充值</option>
		         <option value="3" <c:if test="${amtType==3}">selected="selected" </c:if>>返现</option>
		         <option value="4" <c:if test="${amtType==4}">selected="selected" </c:if>>提现</option>
		         <option value="5" <c:if test="${amtType==5}">selected="selected" </c:if>>积分兑现</option>
		         <option value="6" <c:if test="${amtType==6}">selected="selected" </c:if>>领取积分</option>
		         <option value="7" <c:if test="${amtType==7}">selected="selected" </c:if>>积分奖励</option>
		         <option value="8" <c:if test="${amtType==8}">selected="selected" </c:if>>线下门店消费</option>
		         <option value="9" <c:if test="${amtType==9}">selected="selected" </c:if>>后台充值,转账</option>
		         <option value="10" <c:if test="${amtType==10}">selected="selected" </c:if>>线上货款</option>
		         <option value="11" <c:if test="${amtType==11}">selected="selected" </c:if>>爱心奖励</option>
		         <option value="12" <c:if test="${amtType==12}">selected="selected" </c:if>>商家付款</option>
		         <option value="13" <c:if test="${amtType==13}">selected="selected" </c:if>>线下货款</option>
		         <option value="14" <c:if test="${amtType==14}">selected="selected" </c:if>>退款</option>
		         <option value="15" <c:if test="${amtType==15}">selected="selected" </c:if>>购买精英合伙人</option>
		       <select>
		    </li>
		    <li>
               <input id="startTime" name="startTime" type="date" style="width:130px" value="${startTime}">
               <span>-</span>
               <input id="startTime" name="endTime" type="date" style="width:130px" value="${endTime}">
            </li>
		    <%-- <li>
		    	<input id="phoneNum" name="phoneNum" type="text" maxlength="11" placeholder="会员手机号码"/>
		    </li> --%>
		    <li><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/></li>
		    <%-- <li class="clearfix"><input id="btnExport" class="btn btn-primary check-a1" type="button" value="导出"/></li> --%>
		</ul>
	<tags:message content="${message}"/>
	<table id="treeTable" class="table table-striped table-condensed table-bordered">
		<tr>
		 <th>序号</th>
		 <th>交易状态</th>
		 <th>金额类型</th>
		 <th>用户账号</th>
		 <th>门店名称</th>
		 <th>消费余额</th>
		 <th>提现编码</th>
		 <th>手续费</th>
		 <th>赠送金额</th>
		 <th>总货款</th>
		 <th>备注说明</th>
		 <th>创建时间</th>
		 <!-- <th>创建人</th> -->
		 <th>修改时间</th>
		 <!-- <th>修改人</th> -->
		</tr>
		<c:forEach items="${page.list}" var="pmAmtLog" varStatus="status">
			<tr>
			    <td>${status.index+1}</td>
			    <td>
				    <shiro:hasPermission name="	merchandise:UserAmtLog:view">
					    <c:if test="${pmAmtLog.status==0}">交易中</c:if>
					    <c:if test="${pmAmtLog.status==1}">已完成</c:if>
					    <c:if test="${pmAmtLog.status==2}">已取消</c:if>
					    <c:if test="${pmAmtLog.amtType==4}">
							<a href="javascript:;" onclick="postid(${pmAmtLog.id})">查看</a>
						</c:if>
					</shiro:hasPermission>
				</td>
				<td>
					<c:if test="${pmAmtLog.amtType==1}">购物</c:if>
					<c:if test="${pmAmtLog.amtType==2}">充值</c:if>
					<c:if test="${pmAmtLog.amtType==3}">返现</c:if>
					<c:if test="${pmAmtLog.amtType==4}">提现</c:if>
					<c:if test="${pmAmtLog.amtType==5}">积分兑现</c:if>
					<c:if test="${pmAmtLog.amtType==6}">领取积分</c:if>
					<c:if test="${pmAmtLog.amtType==7}">积分奖励</c:if>
					<c:if test="${pmAmtLog.amtType==8}">线下门店消费</c:if>
					<c:if test="${pmAmtLog.amtType==9}">后台充值,转账</c:if>
					<c:if test="${pmAmtLog.amtType==10}">线上货款</c:if>
					<c:if test="${pmAmtLog.amtType==11}">爱心奖励</c:if>
					<c:if test="${pmAmtLog.amtType==12}">商家付款</c:if>
					<c:if test="${pmAmtLog.amtType==13}">线下货款</c:if>
					<c:if test="${pmAmtLog.amtType==14}">退款</c:if>
					<c:if test="${pmAmtLog.amtType==15}">购买精英合伙人</c:if>
				</td>
				<td>
					<c:if test="${pmAmtLog.ebUser.shopShoppingId != null}">
						${fns:replaceMobile(pmAmtLog.ebUser.mobile)}
					</c:if>

					<c:if test="${pmAmtLog.ebUser.shopShoppingId == null}">
						${pmAmtLog.ebUser.mobile}
					</c:if>
				</td>
			    <td>${pmAmtLog.pmShopInfo.shopName}</td>
			    <td><fmt:formatNumber type="number" value="${pmAmtLog.amt}" pattern="0.00" maxFractionDigits="2"/></td>
			    <td>${pmAmtLog.applycode}</td>
			    <td><fmt:formatNumber type="number" value="${pmAmtLog.fee}" pattern="0.00" maxFractionDigits="2"/></td>
			    <td><fmt:formatNumber type="number" value="${pmAmtLog.giftAmt}" pattern="0.00" maxFractionDigits="2"/></td>
			    <td><fmt:formatNumber type="number" value="${pmAmtLog.totalamt}" pattern="0.00" maxFractionDigits="2"/></td>
			    <td>${pmAmtLog.remark}</td>
			    <td><fmt:formatDate value="${pmAmtLog.createTime}" type="both"/></td>
			    <%-- <td>${pmAmtLog.createUser}</td> --%>
			    <td><fmt:formatDate value="${pmAmtLog.modifyTime}" type="both"/></td>
			    <%-- <td>${pmAmtLog.modifyUser}</td> --%>
			</tr>
		</c:forEach>
	</table>
	<div class="pagination">${page}</div>
	<%-- <div class="check1">
    <div class="check-box">
        <p>导出选项<img class="check-del1" src="${ctxStatic}/sbShop/images/xxx-rzt.png" alt=""></p>
          <ul class="mn1">
	          <li class="checkbox"><input type="checkbox" class="kl" value="" id="all"><label><i></i>全选</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="1"><label><i></i>申请时间</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="2"><label><i></i>类型</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="3"><label><i></i>开户国家</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="4"><label><i></i>开户名</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="5"><label><i></i>银行卡号</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="6"><label><i></i>开户银行</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="7"><label><i></i>所属支行</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="8"><label><i></i>状态</label></li>
          </ul>
        <div class="check-btn">
            <a href="javascript:;" id="fromNewActionSbM" >确定</a>
            <a class="check-del1" href="javascript:;">取消</a>
        </div>
      </div>
    </div> --%>
    </form> 
	<div class="lishi"></div>
	<%-- <script type="text/javascript">
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
			    url : "${ctxsys}/UserAmtLog/exsel",   
			    success : function (data) {
			       alert(data);
			         window.location.href=data; 
			    }
	         });
     });
	</script> --%>
</body>
</html>