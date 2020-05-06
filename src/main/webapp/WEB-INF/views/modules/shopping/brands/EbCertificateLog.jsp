<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<jsp:useBean id="ebCertificate" class="com.jq.support.model.certificate.EbCertificate" scope="request"/>
<html>
<head>
	<title>优惠券日志</title>
	<meta name="decorator" content="default"/>
	<link rel="stylesheet" href="${ctxStatic}/sbShop/css/build.css">
	<link href="${ctxStatic}/jquery-jbox/2.3/Skins/Default/jbox.css" type="text/css" rel="stylesheet" />
	<script src="${ctxStatic}/jquery-jbox/2.3/jquery.jBox-2.3.js" type="text/javascript"></script>
	<style type="text/css">
	.form-search .cerrtifcate li label{
		width: 80px;
		text-align: right;
		padding-right: 8px;
	}
	 
	
	</style>
		<script type="text/javascript">
			function page(n,s){
				if(n) $("#pageNo").val(n);
				if(s) $("#pageSize").val(s);
				// if(!checkProductId()){
				//     return false;
				// }
				$("#searchForm").attr("action","${ctxsys}/Product/certificateLoglist");
				$("#searchForm").submit();
					return false;

			}

			$(function(){
                // $("#searchForm").submit(function(){
                //     if(!checkProductId()){
                //         return false;
                //     }
				//
                //     return true;
                // })

                // //只有当选中指定商品的时候，商品id输入框才可输入
                // $("#product-type-select").change(function(){
                //     if($(this).val() == "1"){
                //         $("#productTypeId").attr("readonly",false);
                //     }else{
                //         $("#productTypeId").attr("readonly",true);
                //         $("#productTypeId").val("");
                //     }
                // })
			})



			// function checkProductId() {
			// 	if($("#product-type-select").val() == "1" && $("#productTypeId").val().length == 0){
			// 		alert("请填写商品id！")
			// 	    return false;
			// 	}
			//
			// 	return true;
            // }
		</script>


	<script type="text/javascript">
        $(function(){
            // 1、满减券，2、现金券 ，3、折扣券
            var typeValue = "${certificate.type}"
            //优惠券适用的产品类型范围
            var productTypeVlaue = "${certificate.productType}"

            var options = $("#type-select").find("option");
            for(var i = 0 ; i < options.length ; i++){
                if($(options[i]).val() == typeValue){
                    $(options[i]).attr("selected", "selected");
                    break;
                }
            }

            options = $("#product-type-select").find("option");
            for(var i = 0 ; i < options.length ; i++){
                if($(options[i]).val() == productTypeVlaue){
                    $(options[i]).attr("selected", "selected");
                    break;
                }
            }
        })

	</script>


	<style type="text/css">
		.line-td{
			color: #18AEA1;;
			cursor: pointer;
		}
	</style>
</head>
<body>
	<ul class="nav nav-tabs">
		<shiro:hasPermission name="merchandise:certificatelist:view"><li class="active"><a href="${ctxsys}/Product/certificateLoglist">优惠券日志</a></li></shiro:hasPermission>
		 <%--<shiro:hasPermission name="merchandise:certificatelist:edit"><li><a href="${ctxsys}/Product/addcertificate" >优惠券添加</a></li></shiro:hasPermission> --%>
	</ul>
 <c:if test="${not empty msg}">
 <script type="text/javascript">
	   $(function(){
		   $.jBox.success("${msg}","信息提示");
	   })
	</script> 
 </c:if>
  	   <form:form id="searchForm" modelAttribute="ebCertificate" action="${ctxsys}/Product/certificateLoglist" method="post" class="form-search breadcrumb">
  	   <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
	    <input id="userId" name="userId" type="hidden" value="${userId}" />
    		<ul class="ul-form cerrtifcate">
    		<%--<li><label>类型:</label>--%>
			    <%--<form:select path="type" class="input-medium" id="type-select">--%>
			      <%--<form:option value="">请选择</form:option>--%>
			      <%--<form:option value="1">满减券</form:option>--%>
			      <%--<form:option value="2">现金券</form:option>--%>
			       <%--<form:option value="3">折扣券</form:option>--%>
			    <%--</form:select>--%>
			 <%--</li> --%>
			 <%--<li><label>产品类型适用范围:</label>--%>
			  <%--<form:select path="productType" class="input-medium" id="product-type-select">--%>
			      <%--<form:option value="">请选择</form:option>--%>
			      <%--<form:option value="1" >指定商品</form:option>--%>
			      <%--&lt;%&ndash;<form:option value="2">指定类别</form:option>&ndash;%&gt;--%>
			       <%--<form:option value="3">所有商品</form:option>--%>
			    <%--</form:select>--%>
			 <%--</li>--%>
			<li><label>优惠券名称:</label><input  type="text" value="${certificate.certificateName}"  name="certificateName" htmlEscape="false" maxlength="50" class="input-medium"  placeholder="请输入优惠券名称"/></li>
			<li><label>用户名字:</label><input  type="text" name="userName" value="${certificate.userName}"   htmlEscape="false" maxlength="50" class="input-medium"  placeholder="请输入用户名字"/></li>
		 	<li>
				<label>有效时间:</label>
				<input type="text" name="serviceTime" htmlEscape="false" maxlength="50" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"  placeholder="请输入有效使用日期"  value="${serviceTime}" class="input-medium" >
			</li>
					<%--<li><label>有效结束日期:</label>--%>
		  <%--<input type="text" id="endDate" name="endDate" htmlEscape="false" maxlength="50" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"  placeholder="请输入有效结束日期" value="${endDate}" class="input-medium" >--%>
			<%--<li><label>优惠券名称:</label><form:input path="certificateName" value="${certificate.certificateName}" htmlEscape="false" maxlength="50" class="input-medium"  placeholder="请输入优惠券名称"/></li>--%>
  			<li style="margin-left:10px"><button type="submit" class="btn btn-primary">查询</button></li>
		</ul>
	</form:form>
	<table  class="table table-striped table-condensed table-bordered" >
		<tr>
		<th class="center123" width="150px">优惠券名称</th>
		<%--<th class="center123" width="150px">优惠券名称</th>--%>
		<th class="center123" width="150px">用户名称</th>
		<th class="center123" width="150px">使用时间</th>
		<th class="center123" width="150px">有效开始时间</th>
		<th class="center123" width="150px">有效结束时间</th>
		<th class="center123" width="150px">订单号</th>
		<th class="center123" width="150px">订单金额</th>
		<%--<th class="center123" width="150px">单号ID</th>--%>
		<%--<th class="center123"  width="60px">类型</th>--%>
		<%--<th class="center123" width="60px">满减金额</th>--%>
		<%--<th class="center123" width="50px">金额/折扣</th>--%>
		<%--<th class="center123" width="60px">产品类型适用范围</th>--%>
		<%--<th class="center123" >商品ID</th>--%>
		<%--<th class="center123" width="100px">商家范围</th>--%>
		<!-- <th class="center123">商家id</th> -->
		<%--<th class="center123" width="140px">有效开始日期</th>--%>
		<%--<th class="center123" width="140px">有效结束日期</th>--%>

		<%--<th class="center123" width="140px">是否过期</th>--%>
		<%--<th class="center123" width="140px">发起时间</th>--%>
 		<%--<th class="center123" width="140px">创建时间</th>  --%>
 		<%--<th class="center123" >优惠券备注</th>--%>
		<%--<shiro:hasPermission name="merchandise:pro:edit">--%>
 	    <%--<th class="center123" width="80px">操作</th>  --%>
		<%--</shiro:hasPermission> --%>
		</tr>
		<c:forEach items="${page.list}" var="ebCertificate" varStatus="status">
			<tr>
			   <td class="center123 line-td" onclick="toCertificateInfo('${ebCertificate.certificateId}')">${ebCertificate.certificateName}</td>
			   <%--<td class="center123">${ebCertificate.certificateName}</td>--%>
			   <td class="center123 line-td" onclick="toUserInfo('${ebCertificate.userId}')">${ebCertificate.userName}</td>
			   <td class="center123">${ebCertificate.serviceTime}</td>
			   <td class="center123">${ebCertificate.certificateStartDate}</td>
			   <td class="center123">${ebCertificate.certificateEndDate}</td>
				<td class="center123 line-td" onclick="toSaleorderForm('${orderList[status.index].orderId}')">${orderList[status.index].orderNo}</td>
				<td class="center123">${orderList[status.index].orderAmount}</td>
			   <%--<td class="center123"></td>--%>
				<%--<td class="center123"> --%>
				<%--<c:choose> --%>
				<%--<c:when test="${ebCertificate.type==1 }">满减券</c:when>--%>
				<%--<c:when test="${ebCertificate.type==2 }">现金券</c:when>--%>
				<%--<c:otherwise>折扣券</c:otherwise>--%>
				<%--</c:choose>--%>
				<%--</td>--%>
				<%--<td class="center123">${ebCertificate.provinceOutFullFreight}</td>--%>
				<%--<td class="center123">${ebCertificate.amount}</td>--%>
				<%--<td class="center123">--%>
				<%--<c:choose> --%>
				<%--<c:when test="${ebCertificate.productType==1 }">指定商品</c:when>--%>
				<%--<c:when test="${ebCertificate.productType==2 }">指定类别</c:when>--%>
				<%--<c:otherwise>所有商品</c:otherwise>--%>
				<%--</c:choose>  --%>
				<%--</td>--%>
				<%--<td class="center123">${ebCertificate.certificateUserId}</td>--%>
				<%--<td class="center123">${ebCertificate.productTypeId}</td>--%>
				<%--<td class="center123">${ebCertificate.shopType=='1'?'御可贡茶':'所有商家'}</td>--%>
				<%--<td class="center123"> ${ebCertificate.certificateStartDate} </td>--%>
				<%--<td class="center123">--%>
					<%--${ebCertificate.certificateEndDate}--%>
				<%--</td>--%>
				<%--<td class="center123">--%>
					<%--<c:choose>--%>
					<%--<c:when test="${ebCertificate.status==0 }">未使用</c:when>--%>
					<%--<c:when test="${ebCertificate.status==1 }">已使用</c:when>--%>
					<%--<c:when test="${ebCertificate.status==2 }">已过期</c:when>--%>
					<%--</c:choose>--%>

			<%--&lt;%&ndash;${ebCertificate.sendTime}&ndash;%&gt;--%>
				<%--</td>--%>
				<%--<td class="center123">--%>
				<%--${ebCertificate.sendTime}--%>
				<%--</td>--%>
				<%--<td class="center123">${ebCertificate.createTime}</td>--%>
				<%--<td class="center123">${ebCertificate.remark}</td>--%>
			     <%--<shiro:hasPermission name="merchandise:certificatelist:edit">--%>
			    <%--<td class="center123">--%>
    				<%--<a href="${ctxsys}/Product/addcertificate?id=${ebCertificate.certificateId}&flag=edit">修改</a> --%>
    				<%--&nbsp;|&nbsp;--%>
    				<%--<a href="${ctxsys}/Product/deletecertificate?id=${ebCertificate.certificateId}" onclick="return confirmx('确定要删除信息吗？', this.href)">删除</a>--%>
				<%--</td>  --%>
				<%--</shiro:hasPermission> --%>
			</tr>
		</c:forEach>
	</table>
	<div class="pagination">${page}</div>
 
  
	<script type="text/javascript">
		//跳转到优惠券修改页面
        function toCertificateInfo(id){
            if(id == undefined || id == ""){
                return false;
            }

            var path='${ctxsys}/Product/addcertificate?id='+id+'&flag=edit'

            window.location.href=path;
        }

        function toUserInfo(id) {
            if(id == undefined || id == ""){
                return false;
            }

            var path='${ctxsys}/User/form?userId='+id;

            window.location.href=path;
        }

        function toSaleorderForm(id) {
            if(id == undefined || id == ""){
                return false;
            }
            var path='${ctxsys}/Order/saleorderform?orderId='+id;

            window.location.href=path;
        }
	</script>
</body>
</html>