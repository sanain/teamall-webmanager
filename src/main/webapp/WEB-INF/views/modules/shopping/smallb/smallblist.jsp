<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
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
        body .form-search .ul-form li label{width:125px;}
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
			$("#searchForm").attr("action","${ctxsys}/PmShopInfo/smallBList");
			$("#searchForm").submit();
	    	return false;
	   }
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
			    url : "${ctxsys}/PmShopInfo/exsel",   
			    success : function (data) {
			         window.location.href=data; 
			    }
	         });
     });
	</script>
	<script type="text/javascript">
    function loke(vals,id,img){
       window.opener.document.getElementById('advertiseTypeObjIds').value=id;
       window.opener.document.getElementById('imgsvals').src=""+img;
       window.opener.document.getElementById('pnames').innerHTML=vals;
       window.opener.document.getElementById('pnames').title=vals;
       window.parent.opener.fkent();
       window.open("about:blank","_self").close();
     }
    </script>
</head>
<body>
	<ul class="nav nav-tabs">
		<shiro:hasPermission name="merchandise:PmShopInfo:view"><li class="active"><c:if test="${stule!='99'}"><a href="${ctxsys}/PmShopInfo/smallBList">店商信息</a></c:if><c:if test="${stule=='99'}"><a>店商信息</a></c:if></li></shiro:hasPermission>
	</ul>
	 <form:form id="searchForm" modelAttribute="pmShopInfo" action="${ctxsys}/PmShopInfo/smallBList" method="post" class="breadcrumb form-search ">
		 <input type="hidden" name="stule" value="${stule}">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
		<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form">
		    <li><label style="width:180px;margin-right:10px">姓名/店商代码（账号）/理由:</label><form:input path="shopCode" htmlEscape="false" maxlength="80" class="input-medium"  placeholder=""/></li>
		   
		    <c:if test="${stule!='99'}">
		    <li><label style="width:180px;margin-right:10px">审核状态:</label>
		       <form:select path="reviewStatus" class="input-medium">
		         <form:option value="">全部</form:option>
		         <form:option value="0">未审核</form:option>
		         <form:option value="1">审核通过</form:option>
		         <form:option value="2">审核不通过</form:option>
		       </form:select>
		    </li>
		   
		    </c:if>
		    <li style="margin-left:10px">&nbsp;&nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/></li>
		    
		    <c:if test="${stule!='99'}">
		    <shiro:hasPermission name="merchandise:PmShopInfo:edit">
		    <li style="margin-left:10px;display:none"><input id="btnExport" class="btn btn-primary check-a1" type="button" value="导出"/></li>
		    </shiro:hasPermission>
		    </c:if>
		</ul>
		<div class="check1">
    <div class="check-box">
        <p>导出选项<img class="check-del1" src="${ctxStatic}/sbShop/images/xxx-rzt.png" alt=""></p>
          <ul class="mn1">
	          <li class="checkbox"><input type="checkbox" class="kl" value="" id="all"><label><i></i>全选</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="1"><label><i></i>商户代码</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="2"><label><i></i>公司名称</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="3"><label><i></i>门店名称</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="4"><label><i></i>联系手机</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="5"><label><i></i>审核状态</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="6"><label><i></i>在线状态</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="7"><label><i></i>审核人</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="8"><label><i></i>线下门店</label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="9"><label><i></i>折扣比 </label></li>
	          <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="10"><label><i></i>审核时间 </label></li>
          </ul>
        <div class="check-btn">
            <a href="javascript:;" id="fromNewActionSbM" >确定</a>
            <a class="check-del1" href="javascript:;">取消</a>
        </div>
      </div>
    </div>
    </form:form> 
	<tags:message content="${message}"/>
	<table id="treeTable" class="table table-striped table-condensed table-bordered" style="table-layout: fixed;
	/*(允许设置列宽,通过th)  默认为 */table-layout: automatic;/*默认每一列列宽均分(不可设置列宽)*/">
		<tr>
		 <th class="center123">编号</th>
		 <th class="center123">店商代码（账号）</th>
		 <th class="center123">申请人姓名</th>
		 <th class="center123">联系方式</th>
		 <th class="center123">申请理由</th>
		 <th class="center123" style="width:10%;">备注</th>
		 <th class="center123">审核状态</th>
		 <c:if test="${stule!='99'}">
		 <th class="center123">审核人 </th>
		 </c:if>
		 <th class="center123">审核时间 </th>
		 <shiro:hasPermission name="merchandise:PmShopInfo:edit">
		 <th class="center123">操作</th>
		 </shiro:hasPermission>
		</tr>
		<c:forEach items="${page.list}" var="PmShopInfoList" varStatus="status">
			<tr>
			    <td class="center123">${status.index+1}</td>
				<td class="center123">${PmShopInfoList.shopCode}</td>
			    <td class="center123">${PmShopInfoList.contactName}</td>
			    <td class="center123">${PmShopInfoList.mobilePhone}</td>
			    <td class="center123" title="${PmShopInfoList.describeInfo}">${PmShopInfoList.describeInfo}</td>
			    <td class="center123" title="${PmShopInfoList.remarkDesc}" style="width:10%;
				white-space: nowrap;/*控制单行显示*/
overflow: hidden;/*超出隐藏*/
text-overflow: ellipsis;/*隐藏的字符用省略号表示*/
				">${PmShopInfoList.remarkDesc}</td>
			    <td class="center123"><c:if test="${PmShopInfoList.reviewStatus==0}">未审核</c:if><c:if test="${PmShopInfoList.reviewStatus==1}">审核通过</c:if><c:if test="${PmShopInfoList.reviewStatus==2}">审核不通过</c:if></td>
			    <c:if test="${stule!='99'}">
			    <td class="center123">${PmShopInfoList.reviewName}</td>
			    </c:if>
			    <td class="center123"><c:if test="${PmShopInfoList.isLineShop==0}">未开通</c:if><c:if test="${PmShopInfoList.isLineShop==1}">已开通</c:if></td>
			    <td class="center123">
					<c:if test="${stule=='99'}">
					<a onclick="loke('${PmShopInfoList.shopName}','${PmShopInfoList.id}','${PmShopInfoList.shopwapBanner}')" >选择</a>
					</c:if>
					
					<c:if test="${stule!='99'}">
					 <shiro:hasPermission name="merchandise:PmShopInfo:edit">
					<a href="${ctxsys}/PmShopInfo/smallBShopinfo?id=${PmShopInfoList.id}">修改</a>
					<a onclick="keyword('${PmShopInfoList.id}')"  data-toggle="modal" data-target="#myModal" ><c:if test="${PmShopInfoList.reviewStatus==0}">审核</c:if></a>
				   </shiro:hasPermission>
				    </c:if>
				</td>
				
			</tr>
		</c:forEach>
	</table>
	<div class="pagination">${page}</div>
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		        <h4 class="modal-title">数据审核</h4>
		      </div>
		      <div class="modal-body">
		         <p><span>审核状态:</span><span><input name="Fruit" type="radio" value="1" checked="checked"/>通过<input name="Fruit" type="radio" value="2"/>不通过</span></p>
		         <p style="display:none"><span>是否有推荐收益:</span><span><input name="reavw" type="radio" value="0" checked="checked"/>否<input name="reavw" type="radio" value="1"/>是</span></p>
		         <p><span>审核原因:</span><span><textarea name="fult" id="fult"></textarea></span></p>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
		        <button id="saveInfo" type="button" class="btn btn-primary" >保存</button>
		      </div>
		    </div><!-- /.modal-content -->
		  </div><!-- /.modal-dialog -->
		</div><!-- /.modal -->
		<script type="text/javascript">
	        var o;
			function keyword(a){
			    o=a;
			}
			$('body').one('click','#saveInfo',function(){
			  $.ajax({
	             type: "POST",
	             url: "${ctxsys}/PmShopInfo/geturl",
	             data: {id:o, Fruit:$('input[name="Fruit"]:checked ').val(),reavw:$('input[name="reavw"]:checked').val(),fult:$("#fult").val()},
	             success: function(data){
	               alertx("操作成功");
	               page();
	             }
	           });
			})
	   </script>
</body>
</html>