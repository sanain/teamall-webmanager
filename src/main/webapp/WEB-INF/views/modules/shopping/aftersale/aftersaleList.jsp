<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<meta name="decorator" content="default"/>
	<meta name="Description" content="${fns:getProjectName()},退款售后服务"/>
	<meta name="Keywords" content="${fns:getProjectName()},退款售后服务"/>
	<title>退款售后服务</title>
	<style type="text/css">
	p{margin: 0;}
        .lishi{display:none;position: fixed;top: 0;left: 0;right: 0;bottom: 0;background: rgba(0,0,0,0.3);}
        .lishi-box{position: absolute;width: 550px;height: 430px;background: #ffffff;border-radius: 5px;top: 50%;left: 50%;margin-left: -275px;margin-top: -215px}
        .lishi-box>p{line-height: 50px;height: 50px;color: #666666;padding: 0 20px;border-bottom: 1px solid #e5e5e5;font-size: 16px;margin: 0;}
        .lishi-box>p img{float: right;margin-top: 20px;cursor: pointer}
        .lishi-div{height: 375px;overflow-y:auto; color: #666666}
        .lishi-body{padding: 20px;;border-bottom: 1px solid #e5e5e5}
        .lishi-body>p{height: 30px;line-height: 30px;margin-bottom: 15px}
        .lishi-body>p i{width: 30px;height: 30px;text-align: center;line-height: 30px;border-radius: 50%;border: 1px solid #e5e5e5;float: left}
        .lishi-body>p i img{border-radius: 50%;width:100%}
        .lishi-body>p b{font-weight: normal; color: #529E5C;margin-left: 10px}
        .lishi-body>p span{float: right;color: #999999}
        .lishi-body u{display: inline-block;width: 160px;height: 160px;line-height: 160px;text-align: center;overflow: hidden;margin-right: 1px}
        .lishi-body>div{margin-bottom: 5px}
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
	<script type="text/javascript">
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").attr("action","${ctxsys}/AfterSale");
			$("#searchForm").submit();
	    	return false;
	    }
		function post(saleId){
			$.ajax({
		    	type:'post',
		      	contentType:"application/x-www-form-urlencoded;charset=UTF-8",
		    	url:"${ctxsys}/AfterSale/salesrecordlist",
		       	datatype:"json",
		       	data:{
		       		saleId:saleId
		       	},
		       	success:function(data){
		       		if(data!=""){
			       		var html="";
			      		html+='<div class="lishi-box">';
			      		html+='<p>协商历史 <img class="lishi-del" src="${ctxStatic}/hAdmin/img/xxx-rzt.png" alt=""></p>';
			      		html+='<div class="lishi-div">';
			      	    for(var i in data){
			      	        var list=data[i];
			      			html+='<div class="lishi-body">';
			      			html+='<p>';
			      			if(list.recordObjType==3){
			      				html+='<i><img class="lishi-del" src="${ctxStatic}/sbShop/images/logo.png" alt=""></i><b>${fns:getProjectName()}平台</b>';
			      			}else{
			      				html+='<i><img class="lishi-del" src="'+list.recordObjImg+'" alt=""></i><b>'+list.recordObjName+'</b>';
			      			}
			      			/* var newTime = new Date(list.recordDate); */
			      			/* var strdate2 = timeStamp2String(list.recordDate.time); */
			      			html+='<span>'+list.recordDate+'</span></p>';
			      			html+='<div>'+list.recordName+'</div>';
			      			html+='<div>'+list.recordContent+'</div>';
			      			if(list.recordEvidencePicUrl!=""){
					      	html+='<div>';
			      			for(var i in list.imgList){
			      				var img=list.imgList[i];
					      		html+='<u><img src="'+img+'" alt=""></u>';
			      			}
					      	html+='</div>';
			      			}
			      			html+='</div>';
			      	    }
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
		<li class="active"><a href="${ctxsys}/AfterSale">退款售后服务列表</a></li>
	</ul>
	 <form id="searchForm" action="${ctxsys}/AfterSale" method="post" class="breadcrumb form-search ">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
		<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form">
		    <li>
		    <label>退货编号</label>
		    <input id="saleNo" name="saleNo" type="text" htmlEscape="false" maxlength="20" class="input-medium" value="${saleNo}"  placeholder="请输入退款编号"/></li>
			<li>
			<label>申请类型</label>
		      <select name="applicationType"  htmlEscape="false" maxlength="50"  class="input-medium">
		           <option value="">请选择申请类型</option>
		           <option value="0" <c:if test="${applicationType==0 }">selected="selected"</c:if> >退货退款</option>
		           <option value="1" <c:if test="${applicationType==1 }">selected="selected"</c:if> >退款</option>
		           <option value="2" <c:if test="${applicationType==2 }">selected="selected"</c:if> >换货</option>
               </select>
		      </li> 
		      <li>
			  <label>退款状态</label>
		      <select name="refundStatus"  htmlEscape="false" maxlength="50"  class="input-medium">
		           <option value="">请选择退款状态</option>
		           <option value="1" <c:if test="${refundStatus==1 }">selected="selected"</c:if>>待卖家处理</option>
		           <option value="2" <c:if test="${refundStatus==2 }">selected="selected"</c:if>>卖家已拒绝</option>
		           <option value="3" <c:if test="${refundStatus==3 }">selected="selected"</c:if>>退款成功</option>
		           <option value="4" <c:if test="${refundStatus==4 }">selected="selected"</c:if>>关闭退款</option>
		           <option value="5" <c:if test="${refundStatus==5 }">selected="selected"</c:if>>等待买家退货</option>
		           <option value="6" <c:if test="${refundStatus==6 }">selected="selected"</c:if>>等待卖家确认收货</option>
		           <option value="7" <c:if test="${refundStatus==7 }">selected="selected"</c:if>>等待买家确认收款</option>
		           <option value="8" <c:if test="${refundStatus==8 }">selected="selected"</c:if>>等待卖家退款</option>
		           <option value="9" <c:if test="${refundStatus==9 }">selected="selected"</c:if>>平台已介入处理</option>
               </select>
		      </li> 
			<li><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/></li>
			<li><input id="btnExport" class="btn btn-primary check-a1" type="button" value="导出"/></li>
		</ul>
			<div class="check1">
    <div class="check-box">
        <p>导出选项<img class="check-del1" src="${ctxStatic}/sbShop/images/xxx-rzt.png" alt=""></p>
          <ul class="mn1">
	          <li class="checkbox"><input type="checkbox" class="kl" value="" id="all"><label><i></i>全选</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="1"><label><i></i>用户账号</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="2"><label><i></i>退款编号</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="3"><label><i></i>退款原因</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="4"><label><i></i>申请类型</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="5"><label><i></i>申请时间</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="6"><label><i></i>退款金额</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="7"><label><i></i>退款说明</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="8"><label><i></i>收货状态</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="9"><label><i></i>退款状态</label></li>
          </ul>
        <div class="check-btn">
            <a href="javascript:;" id="fromNewActionSbM" >确定</a>
            <a class="check-del1" href="javascript:;">取消</a>
        </div>
      </div>
    </div>
	</form> 
	<tags:message content="${message}"/>
	<table id="treeTable" class="table table-striped table-condensed table-bordered" >
		<tr>
		<th>编号</th>
		<th>用户账号</th>
		<th>退款编号</th>
		<th>退款原因</th>
		<th>申请类型</th>
	    <th calss="sort-column applicationTime">申请时间</th>
		<th>退款金额</th>
		<th>退款说明</th>
		<th>收货状态</th>
		<th>退款状态</th>
		</tr>
		<c:forEach items="${page.list}" var="AfterSale" varStatus="status">
			<tr>
			     <td>${status.index+1}</td> 
			    <td>${fns:getUser(AfterSale.userId).mobile}</td>
			    <td><a href="${ctxsys}/Order/saleorderreturngoods?orderId=${AfterSale.orderId}&saleId=${AfterSale.saleId}">${AfterSale.saleNo}</a></td>
			    <td>${AfterSale.travelingApplicants}</td>
			    <td>
			    	<c:if test="${AfterSale.applicationType==0}">退货退款</c:if>
			    	<c:if test="${AfterSale.applicationType==1}">退款</c:if>
			    	<c:if test="${AfterSale.applicationType==2}">换货</c:if>
			    </td>
			    <td><fmt:formatDate value="${AfterSale.applicationTime}" type="both"/></td>
				<td>${AfterSale.deposit}</td>
				<td>${AfterSale.refundExplain}</td>
				<td>         
		            <c:if test="${AfterSale.takeStatus==0}">未发货</c:if>
			    	<c:if test="${AfterSale.takeStatus==1}">未收货</c:if>
			    	<c:if test="${AfterSale.takeStatus==2}">已收货</c:if>
				</td>
				<td ><c:if test="${AfterSale.refundStatus==1}">待卖家处理</c:if>
				     <c:if test="${AfterSale.refundStatus==2}">卖家已拒绝</c:if>
					 <c:if test="${AfterSale.refundStatus==3}">退款成功</c:if>
					 <c:if test="${AfterSale.refundStatus==4}">关闭退款</c:if>
					 <c:if test="${AfterSale.refundStatus==5}">等待买家退货</c:if>
					 <c:if test="${AfterSale.refundStatus==6}">等待卖家确认收货</c:if>
					 <c:if test="${AfterSale.refundStatus==7}">等待买家确认收款</c:if>
					 <c:if test="${AfterSale.refundStatus==8}">等待卖家退款</c:if>
					 <c:if test="${AfterSale.refundStatus==9}">平台已介入处理</c:if>
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
			    url : "${ctxsys}/AfterSale/exsel",   
			    success : function (data) {
			         window.location.href=data; 
			    }
	         });
     });
	</script>
	<div class="lishi">
    </div>
</body>
</html>