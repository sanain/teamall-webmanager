<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>门店配送人员列表</title>
	<meta name="decorator" content="default"/>
	<link rel="stylesheet" href="${ctxStatic}/sbShop/css/build.css?v=1">
	<link rel="stylesheet"
		  href="${ctxStatic}/sbShop/css/quick-choose-product.css">

	<style>
		.table1 tr {
			height: 35px;
		}

		.breadcrumb {
			background: #fff;
		}
	</style>
	<script>
        function page(n, s) {
            if (n) $("#pageNo").val(n);
            if (s) $("#pageSize").val(s);
            $("#searchForm").attr("action", "${ctxweb}/shop/PmShopOrders/chooseDeliveryStaff");
            $("#searchForm").submit();
            return false;
        }
	</script>
</head>
<body>
<div style="overflow:hidden;height:350px;">
	<div style="float:left;width:25%;overflow:scroll;height:100%;">
		<table
				class="table table-striped table-condensed table-bordered table1">
			<thead>
			<tr>
				<td>人员名称</td>
				<td></td>
			</tr>
			</thead>

			<tbody class="tbody">
			</tbody>
		</table>

	</div>

	<div style="float:left;width:75%;overflow:scroll;height:100%;">
		<form:form id="searchForm" modelAttribute="pmShopUser" action="${ctxweb}/shop/PmShopOrders/chooseDeliveryStaff" method="post" class="breadcrumb form-search ">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
		<input type="hidden" id="shopUserId" name="chooseShopUserId" value="${chooseShopUserId}"/>
		<input type="hidden" id="username" name="chooseName" value="${chooseName}"/>
		<input type="hidden" id="phoneNumber" name="choosePhoneNumber" value="${choosePhoneNumber}"/>
		<input type="hidden" id="shopId" name="shopId" value="${pmShopUser.shopId}"/>

			<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form">
			<li><label>员工名字:</label><form:input path="username" value="${pmShopUser.username}" htmlEscape="false" maxlength="50" class="input-medium"  placeholder="请输入员工名字"/><input style="margin-left:10px" id="btnSubmit" class="btn btn-primary " type="submit" value="查询" onclick="return page();"/></li>
		</ul>
		</form:form>
		<tags:message content="${message}"/>
		<table  class="table table-striped table-condensed table-bordered" >
			<tr>
				<th class="center123"></th>
				<th class="center123">编号</th>
				<th class="center123">名字</th>
				<th class="center123">工号</th>
				<th class="center123">联系号码</th>

			</tr>
			<c:forEach items="${page.list}" var="ps" varStatus="status">
				<tr>
					<td class="center123"><input type="checkbox"  class="kty chooseItem"  shopUserId="${ps.shopUserId}"  username="${ps.username}" phoneNumber="${ps.phoneNumber}"></td>
					<td class="center123">${status.index+1}</td>
					<td class="center123">${ps.username}</td>
					<td class="center123">${ps.jobNumber}</td>
					<td class="center123">${ps.phoneNumber}</td>

				</tr>
			</c:forEach>
		</table>
		<div class="pagination">${page}</div>
		<input type="hidden" />




		<script type="text/javascript">

		</script>


		<script type="text/javascript">

            //选择的人员id
            var  shopUserId =  "";
            var  username =  "";
            var  phoneNumber =  "";

            $(function(){
                shopUserId =  $("#shopUserId").val();
                username =  $("#username").val();
                phoneNumber =  $("#phoneNumber").val();

                adTable();

                /**
                 * 控制选择和取消
                 * */
                $(".chooseItem").click(function(){
                    if($(this).attr("checked") == "checked"){
                        shopUserId =  $(this).attr("shopUserId");
                        username =  $(this).attr("username");
                        phoneNumber =  $(this).attr("phoneNumber");
                    }else{
                        shopUserId =  "";
                        username =  "";
                        phoneNumber =  "";
                    }

                    $("#shopUserId").val(shopUserId);
                    $("#username").val(username);
                    $("#phoneNumber").val(phoneNumber);
                    adTable();
                })

            })


            /**
             * 初始化原来已经选好的门店
             * */
            function initAlreadyChecked(){
                var arr = $(".chooseItem");
                for(var i = 0 ; i < arr.length ; i++){
                    if(shopUserId == $(arr[i]).attr("shopUserId")){
                        $(arr[i]).attr("checked",true);
                    }else{
                        $(arr[i]).attr("checked",false);
                    }
                }
            }

            function adTable() {

                var str = "";
                if(username != '' && shopUserId!='') {
                    str += "<tr>\
							<td>" + username + "</td>\
							 <td>" + shopUserId + "</td>\
							 <td  onclick='removethis()'>移除</td>\
							</tr>"
                }
                $(".tbody").html(str);

                initAlreadyChecked();
            }

            function removethis() {
                debugger;
                $(".tbody").html("");
                username='';
                shopUserId='';
                phoneNumber='';

                initAlreadyChecked();
            }
		</script>
</body>
</html>