<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>加料列表</title>
	<meta name="decorator" content="default"/>
	<link rel="stylesheet" href="${ctxStatic}/h5/css/timePicker.css">
	<script src="${ctxStatic}/jquery/jquery-1.9.1.min.js" type="text/javascript"></script>
	<script type="text/javascript" src="${ctxStatic}/h5/js/jquery-timepicker.js"></script>
	<script type="text/javascript">
        function page(n,s){
            $("#pageNo").val(n);
            $("#pageSize").val(s);
            $("#searchForm").attr("action","${ctxsys}/EbProductCharging");

            if($("#sellPrice").val() != "" && !/^(-?\d+)(\.\d+)?$/.test($("#sellPrice").val())){
                alert("价格的格式不正确！");
                return false;
                return false;
            }
            $("#searchForm").submit();
            return false;
        }

        //商品状态改变
        var chargingStatus;
        var chargingId;
        function editStatus(){
            // alert(productChargingId)
            $.ajax({
                type: "POST",
                url: "${ctxsys}/EbProductCharging/updateStatus",
                data: {'chargingStatus':chargingStatus,'chargingId':chargingId},
                success: function(data){

                    page( $("#pageNo").val(),$("#pageSize").val());
                }
            });
        }
        function editProductCharging(productChargingId,status){
            // chargingStatus=status;
            chargingId=productChargingId;

            var msg="";
            if(status==1){
                chargingStatus = 0;
                msg="是否把该加料状态改成不可用";

            }else{
                chargingStatus = 1;
                msg="是否把该加料状态改成可用";
            }
            confirmx(msg,editStatus);
        }
	</script>



	<style>
		.list-ul{
			width: 42%;
			float: left;
			list-style: none;
			padding: 0;
			border: 1px solid #69AC72;
			box-sizing: border-box;
			margin:30px;
		}
		.list-ul li:nth-child(1){padding-left: 20px}
		.list-ul li:nth-child(2){padding-left: 20px}
		.list-ul li:nth-child(3) img{width: 100%}
	</style>
</head>
<body>
<ul class="nav nav-tabs">
	<li class="active"><a href="${ctxsys}/EbProductCharging?productTypeId=${ebProductCharging.productTypeId}">加料列表</a></li>
	<li >
		<%--<shiro:hasPermission name="merchandise:EbProductCharging:edit">--%>
		<a href="${ctxsys}/EbProductCharging/form?flag=add&productTypeId=${ebProductCharging.productTypeId}">增加加料</a>
		<%--</shiro:hasPermission>--%>
	</li>

</ul>
<form:form id="searchForm" modelAttribute="ebProductCharging" action="${ctxsys}/EbProductCharging" method="post" class="breadcrumb form-search ">
	<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
	<input id="productTypeId" name="productTypeId" type="hidden" value="${ebProductCharging.productTypeId}" />
	<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
	<ul class="ul-form">
		<li><label>加料名字:</label><form:input path="cName" htmlEscape="false" maxlength="80" class="input-medium"  placeholder=""/></li>
		<li><label>标签名字:</label><form:input path="lable" htmlEscape="false" maxlength="80" class="input-medium"  placeholder=""/></li>
		<li><label>价格:</label><form:input id="sellPrice" path="sellPrice" htmlEscape="false" maxlength="80" class="input-medium"  placeholder="" required="required"/></li>
		<li><label></label><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/></li>
	</ul>
</form:form>
<%--<tags:message content="${message}"/>--%>

<table id="treeTable" class="table table-striped table-condensed table-bordered" >
	<tr>
		<th class="center123">编号</th>
		<th class="center123">加料名字</th>
		<th class="center123">标签名字</th>
		<th class="center123">价格</th>
		<th class="center123">来源</th>
		<th class="center123">使用状态</th>
		<th class="center123">创建时间</th>
		<th class="center123 ">状态</th>
		<shiro:hasPermission name="merchandise:EbProductCharging:edit">
			<th class="center123">操作</th>
		</shiro:hasPermission>
	</tr>
	<c:forEach items="${page.list}" var="productCharging" varStatus="status">
		<tr>
			<td class="center123">${status.index+1}</td>
			<td class="center123" style="color:#18AEA1;cursor: pointer"><a href="${ctxsys}/EbProductCharging/form?id=${productCharging.id}&productTypeId=${productCharging.productTypeId}">${productCharging.cName}</a></td>
			<td class="center123">${productCharging.lable}</td>
			<td class="center123">￥${productCharging.sellPrice}</td>

			<td class="center123">
					${productCharging.shopName != null && !''.equals(productCharging.shopName) ? productCharging.shopName : '平台'}
			</td>
			<td class="center123">
				<c:if test="${productCharging.isPublic == 0 || productCharging.isPublic == null}">
					平台使用
				</c:if>
				<c:if test="${productCharging.isPublic == 1}">
					商家使用
				</c:if>
				<c:if test="${productCharging.isPublic == 2}">
					平台和商家共用
				</c:if>
			</td>

			<td class="center123"><fmt:formatDate value="${productCharging.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/> </td>

			<td class="center123">
				<c:if test="${productCharging.status == 0}">不可用</c:if>
				<c:if test="${productCharging.status == 1}">可用</c:if>
				|
				<span id="status-span2" style="cursor: pointer;color: #18AEA1;" onclick="editProductCharging('${productCharging.id}','${productCharging.status}')">
                        <c:if test="${productCharging.status == 0}">
                            <%--<span id="status-span1">--%>
                                可用
                            <%--<span/>--%>

                        </c:if>
                        <c:if test="${productCharging.status == 1}">
                                不可用

                        </c:if>
                    <span/>
			</td>

			<shiro:hasPermission name="merchandise:EbProductCharging:edit">
				<td class="center123">
					<a href="${ctxsys}/EbProductCharging/form?id=${productCharging.id}&productTypeId=${productCharging.productTypeId}">修改</a>
					<a href="${ctxsys}/EbProductCharging/delete?id=${productCharging.id}" onclick="return confirmx('确定删除该标签？', this.href)">删除</a>
				</td>
			</shiro:hasPermission>
		</tr>
	</c:forEach>
</table>


<div id="outerdiv" style="position:fixed;top:0;left:0;background:rgba(0,0,0,0.7);z-index:2;width:100%;height:100%;display:none;">
	<div id="innerdiv" style="position:absolute;">
		<img id="bigimg" style="border:5px solid #fff;" src="" />
	</div>
</div>

<div class="pagination">${page}</div>
</body>

</html>