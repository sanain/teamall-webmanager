<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>商品列表</title>
<meta name="decorator" content="default" />
<link rel="stylesheet" href="${ctxStatic}/sbShop/css/build.css?v=1">
<link rel="stylesheet"
	href="${ctxStatic}/sbShop/css/quick-choose-product.css">
<%--<script type="text/javascript" src="${ctxStatic}/sbShop/js/quick-choose-product.js"></script>--%>
<%--<script type="text/javascript">--%>
<%--&lt;%&ndash;function writable(a,va){&ndash;%&gt;--%>
<%--&lt;%&ndash;$("#ids").val(a);&ndash;%&gt;--%>
<%--&lt;%&ndash;var html="";&ndash;%&gt;--%>
<%--&lt;%&ndash;$.ajax({&ndash;%&gt;--%>
<%--&lt;%&ndash;type: "POST",&ndash;%&gt;--%>
<%--&lt;%&ndash;url: "${ctxsys}/Product/classOne",&ndash;%&gt;--%>
<%--&lt;%&ndash;data: {"type":"1"},&ndash;%&gt;--%>
<%--&lt;%&ndash;success: function(data){&ndash;%&gt;--%>
<%--&lt;%&ndash;for(var i=0;i<data.length;i++){&ndash;%&gt;--%>
<%--&lt;%&ndash;if(va!=null){&ndash;%&gt;--%>
<%--&lt;%&ndash;var strs= new Array();&ndash;%&gt;--%>
<%--&lt;%&ndash;strs= va.split(",");&ndash;%&gt;--%>
<%--&lt;%&ndash;if(strs!=null){&ndash;%&gt;--%>
<%--&lt;%&ndash;html+="<li class='checkbox'><input type='checkbox' name='tag' value='"+data[i].id+"'";&ndash;%&gt;--%>
<%--&lt;%&ndash;for(var j=0;j<strs.length;j++){&ndash;%&gt;--%>
<%--&lt;%&ndash;if(strs[j]==data[i].id){&ndash;%&gt;--%>
<%--&lt;%&ndash;html+="  checked='checked'  ";&ndash;%&gt;--%>
<%--&lt;%&ndash;}&ndash;%&gt;--%>
<%--&lt;%&ndash;}&ndash;%&gt;--%>
<%--&lt;%&ndash;html+="><label><i></i>"+data[i].name+"</label></li>";&ndash;%&gt;--%>
<%--&lt;%&ndash;}&ndash;%&gt;--%>
<%--&lt;%&ndash;}&ndash;%&gt;--%>
<%--&lt;%&ndash;}&ndash;%&gt;--%>
<%--&lt;%&ndash;$(".mn").html(html);&ndash;%&gt;--%>
<%--&lt;%&ndash;}&ndash;%&gt;--%>
<%--&lt;%&ndash;});&ndash;%&gt;--%>
<%--&lt;%&ndash;$('.check').show();&ndash;%&gt;--%>
<%--&lt;%&ndash;}&ndash;%&gt;--%>
<%--function sbmit(){--%>
<%--$("#fromsb").submit();--%>

<%--}--%>

<%--&lt;%&ndash;function eblabelLs(){&ndash;%&gt;--%>
<%--&lt;%&ndash;$.ajax({&ndash;%&gt;--%>
<%--&lt;%&ndash;type: "POST",&ndash;%&gt;--%>
<%--&lt;%&ndash;url: "${ctxsys}/EbLabel/eblabelLs",&ndash;%&gt;--%>
<%--&lt;%&ndash;data: {},&ndash;%&gt;--%>
<%--&lt;%&ndash;success: function(data){&ndash;%&gt;--%>
<%--&lt;%&ndash;var html='<option value="">全部</option>';&ndash;%&gt;--%>
<%--&lt;%&ndash;var productTagname="${productTags}";&ndash;%&gt;--%>
<%--&lt;%&ndash;for(var i=0;i<data.length;i++){&ndash;%&gt;--%>
<%--&lt;%&ndash;if(productTagname==data[i].name){&ndash;%&gt;--%>
<%--&lt;%&ndash;html+="<option value="+data[i].name+" selected='selected'>"+data[i].name+"</option>";&ndash;%&gt;--%>
<%--&lt;%&ndash;}else{&ndash;%&gt;--%>
<%--&lt;%&ndash;html+="<option value="+data[i].name+">"+data[i].name+"</option>";&ndash;%&gt;--%>
<%--&lt;%&ndash;}&ndash;%&gt;--%>
<%--&lt;%&ndash;}&ndash;%&gt;--%>
<%--&lt;%&ndash;$("#productTags").html(html);&ndash;%&gt;--%>
<%--&lt;%&ndash;}&ndash;%&gt;--%>
<%--&lt;%&ndash;});&ndash;%&gt;--%>
<%--&lt;%&ndash;}&ndash;%&gt;--%>





<%--function loke(vals,id,price,img,redweb,marketPrice,sale,poorTotal,middleTotal,goodTotal){--%>
<%--window.opener.document.getElementById('advertiseTypeObjIds').value=id;--%>
<%--if(window.opener.document.getElementById('price')!=null||window.opener.document.getElementById('price')!=undefined){--%>
<%--window.opener.document.getElementById('price').innerHTML=price;--%>
<%--}--%>
<%--if(window.opener.document.getElementById('prices')!=null||window.opener.document.getElementById('prices')!=undefined){--%>
<%--window.opener.document.getElementById('prices').innerHTML=price;--%>
<%--}--%>
<%--var poor = poorTotal == null ? 0 :poorTotal;--%>
<%--var middle = middleTotal== null ? 0 : middleTotal;--%>
<%--var good = goodTotal == null ? 0 : goodTotal;--%>
<%--var all = poor + middle + good;--%>
<%--var ty = 0;--%>
<%--if (all != 0) {--%>
<%--ty = Double.valueOf(good) / Double.valueOf(all);--%>
<%--}--%>
<%--if(window.opener.document.getElementById('saleValue')!=null||window.opener.document.getElementById('saleValue')!=undefined){--%>
<%--window.opener.document.getElementById('saleValue').innerHTML=ty;--%>
<%--}--%>
<%--if(window.opener.document.getElementById('marketPrice')!=null||window.opener.document.getElementById('marketPrice')!=undefined){--%>
<%--window.opener.document.getElementById('marketPrice').innerHTML=marketPrice;--%>
<%--}--%>
<%--if(window.opener.document.getElementById('sale')!=null||window.opener.document.getElementById('sale')!=undefined){--%>
<%--window.opener.document.getElementById('sale').innerHTML=sale;--%>
<%--}--%>
<%--if(window.opener.document.getElementById('pname')!=null||window.opener.document.getElementById('pname')!=undefined){--%>
<%--window.opener.document.getElementById('pname').innerHTML=vals;--%>
<%--}--%>
<%--if(window.opener.document.getElementById('imgsval')!=null||window.opener.document.getElementById('imgsval')!=undefined){--%>
<%--window.opener.document.getElementById('imgsval').src=""+img.split("|")[0];--%>
<%--}--%>
<%--if(window.opener.document.getElementById('pname')!=null||window.opener.document.getElementById('pname')!=undefined){--%>
<%--window.opener.document.getElementById('pname').innerHTML=vals;--%>
<%--window.opener.document.getElementById('pname').title=vals;--%>
<%--}--%>
<%--if(window.opener.document.getElementById('redweb')!=null||window.opener.document.getElementById('redweb')!=undefined){--%>
<%--window.opener.document.getElementById('redweb').innerHTML=redweb;--%>
<%--}--%>

<%--window.open("about:blank","_self").close();--%>
<%--}--%>

<%--$(function(){--%>
<%--eblabelLs();//加载标签--%>
<%--$(".run-ball-box").hide();--%>
<%--$("#priceType").val("${priceType}");--%>
<%--$('body').on('mouseover','.fu',function(){$(this).siblings('.kla').show()});--%>
<%--$('body').on('mouseout','.fu',function(){$(this).siblings('.kla').hide()});--%>
<%--$('.check').hide();--%>
<%--$('body').on('click','.check-a',function(){--%>
<%--$('.check').show();--%>
<%--});--%>

<%--$('body').on('click','.check-del',function(){--%>
<%--$('.check').hide();--%>
<%--});--%>



<%--})--%>

<%--function page(n,s){--%>
<%--if(n) $("#pageNo").val(n);--%>
<%--if(s) $("#pageSize").val(s);--%>
<%--$("#searchForm").attr("action","${ctxweb}/shop/product/chooseProduct");--%>
<%--$("#searchForm").submit();--%>
<%--return false;--%>
<%--}--%>
<%--</script>--%>
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
		$("#searchForm").attr("action", "${ctxweb}/shop/product/chooseProduct");
		$("#searchForm").submit();
		return false;
	}
</script>
</head>
<body>
	<%--<div class="run-ball-box">--%>
	<%--<div class="run-ball"><span class="sk-inner-circle"></span></div>--%>
	<%--<div class="sh-ju">数据加载中...</div>--%>
	<%--</div>--%>

	<div style="overflow:hidden;height:350px;">
		<div style="float:left;width:25%;overflow:scroll;height:100%;">
			<table
				class="table table-striped table-condensed table-bordered table1">
				<thead>
					<tr>
						<td>商品名称</td>
						<td></td>
					</tr>
				</thead>

				<tbody class="tbody">
					<!-- 	<tr>
						<td>奶茶1</td>
						<td>1</td>
					</tr> -->

				</tbody>


			</table>

		</div>

		<div style="float:left;width:75%;overflow:scroll;height:100%;">
			<form:form id="searchForm" modelAttribute="ebProduct"
				action="${ctxweb}/shop/product/chooseProduct" method="post"
				class="breadcrumb form-search ">
				<input id="pageNo" name="pageNo" type="hidden"
					value="${page.pageNo}" />
				<input id="pageSize" name="pageSize" type="hidden"
					value="${page.pageSize}" />
				<input id="chooseIds" name="productIds" type="hidden"
					value="${productIds}" />
				<input id="productNames" name="productNames" type="hidden"
					value="${productNames}" />
				<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}"
					callback="page();" />
				<ul class="ul-form">
					<li><label>商品名字:</label> <form:input path="productName"
							htmlEscape="false" maxlength="50" class="input-medium"
							placeholder="请输入商品名字" /></li>
					<li><input style="margin-left:10px;background: #2e8ded"
						id="btnSubmit" class="btn btn-primary " type="submit" value="查询"
						onclick="return page();" /></li>
				</ul>
			</form:form>
			<tags:message content="${message}" />
			<!-- 	<div style="width: 100%;">
		<input class="btn btn-primary"
			style="margin:0px 0px 5px 5px;padding-top:2px;border-radius:0px;background: #2e8ded;font-size:12px;height: 25px;width: 50px"
			id="choose-all-btn" status="0" type="button" value="全选"
			onclick="return chooseAll();" />
	</div> -->
			<table class="table table-striped table-condensed table-bordered">
				<tr>
					<th class="center123"><input type="checkbox" class="kty"
						value="" id="all"></th>
					<%--<th class="center123"><input type="checkbox"  id="all-choose"></th>--%>
					<th class="center123" style="width:150px">商品名称</th>
					<th class="center123">商品图片</th>
					<th class="center123">所属分类</th>
					<th class="center123 sellPrice">销售价</th>
					<th class="center123  ">会员价</th>

				</tr>
				<c:forEach items="${page.list}" var="product" varStatus="status">
					<tr>
						<td class="center123"><input type="checkbox" name="subcheck"
							class="kty choose-item" value="${product.productId}"
							productName="${product.productName}"></td>
						<td class="center123">${fns:abbr(product.productName,20)}</td>
						<td class="center123"><img class="fu"
							src="${fn:split(product.prdouctImg,'|')[0]}"
							style="width:30px;height:30px" /><img class="kla"
							style="display:none;position:fixed;top:30%;left:40%" alt=""
							src="${fn:split(productlist.prdouctImg,'|')[0]}"></td>
						<td class="center123">${fns:getsbProductTypeName(product.productTypeId).productTypeStr}</td>
						<td class="center123">${product.sellPrice}</td>
						<td class="center123">${product.memberPrice}</td>
					</tr>
				</c:forEach>
			</table>
			<div class="pagination">${page}</div>
		</div>
	</div>
	<%--<input type="hidden" id="chooseIds" value=""/>--%>



	<script type="text/javascript">
		var idArr;
		var nameArr;
		var size = '${page.count}'; //商品总数
	
		//初始化数据
		function init() {
			var chooseIds = $("#chooseIds").val();
			var productNames = $("#productNames").val();
	
			if (chooseIds == undefined || chooseIds == "") {
				idArr = new Array();
			} else {
				idArr = chooseIds.split(",");
			}
	
			if (productNames == undefined || productNames == "") {
				nameArr = new Array();
			} else {
				nameArr = productNames.split(",");
			}
			var itemArr = $(".choose-item");
			for (var i = 0; i < itemArr.length; i++) {
				if (chooseIds.indexOf($(itemArr[i]).attr("value")) >= 0) {
					$(itemArr[i]).attr("checked", true);
				} else {
					$(itemArr[i]).attr("checked", false);
				}
			}
			adTable(nameArr, idArr);
	
			multipleBtnStatus();
		}
	
		function adTable(nameArr, idArr) {
			var str = "";
			for (var i = 0; i < nameArr.length; i++) {
				str += "<tr>\
							<td>" + nameArr[i] + "</td>\
							 <td>" + idArr[i] + "</td>\
							 <td  onclick='removethis(\"" + idArr[i] + "\",\"" + nameArr[i] + "\")'>移除</td>\
							</tr>"
			}
			$(".tbody").html(str);
		}
		function removethis(id, name) {
			if (idArr.indexOf(id) >= 0) {
				idArr.splice(idArr.indexOf(id), 1);
				nameArr.splice(nameArr.indexOf(name), 1);
			}
	
			$("#chooseIds").val(idArr.toString());
			$("#productNames").val(nameArr.toString());
			init();
		}
	
		$(function() {
			init();
			//单个元素点击的情况
			$(".choose-item").click(function() {
	
				if ($(this).is(':checked')) {
					idArr.push($(this).attr("value"))
					nameArr.push($(this).attr("productName"))
				} else {
					if (idArr.indexOf($(this).attr("value")) >= 0) {
						idArr.splice(idArr.indexOf($(this).attr("value")), 1);
						nameArr.splice(nameArr.indexOf($(this).attr("productName")), 1);
					}
				}
				$("#chooseIds").val(idArr.toString());
				$("#productNames").val(nameArr.toString());
				//检查全选按钮是否应该勾选
				multipleBtnStatus();
				init();
			})
			// 子选
			/*    $("body").on("click", "input[name='subcheck']", function () {
			       var $subcheck = $("input[name='subcheck']");
			       
			   })	 */
	
			//点击全选多多选框
			$("#all").click(function() {
				var itemArr = $(".choose-item");
	
				//选中的情况
				if ($(this).attr("checked") == "checked") {
					for (var i = 0; i < itemArr.length; i++) {
						if (idArr.indexOf($(itemArr[i]).attr("value")) < 0) {
							idArr.push($(itemArr[i]).attr("value"))
							nameArr.push($(itemArr[i]).attr("productName"))
						}
					}
	
				} else {
					for (var i = 0; i < itemArr.length; i++) {
						var index = idArr.indexOf($(itemArr[i]).attr("value"));
						if (index >= 0) {
							idArr.splice(index, 1);
							nameArr.splice(index, 1);
						}
					}
				}
	
				$("#chooseIds").val(idArr.toString());
				$("#productNames").val(nameArr.toString());
	
				multipleBtnStatus();
				init();
			})
		})
	
		/**
		 * 一键所有
		 */
		function chooseAll() {
			var status = $("#choose-all-btn").attr("status"); // 0 当前未选中，1 当前已经选中
	
			if (status == 1) {
				$("#chooseIds").val("");
				$("#productNames").val("");
	
				$("#all").attr("checked", false);
				init();
				$("#choose-all-btn").attr("status", "0");
	
				return;
			}
	
	
			$.ajax({
				url : "${ctxweb}/shop/product/getAllProduct",
				type : "POST",
				data : $("#searchForm").serialize(),
				datatype : "json",
				success : function(data) {
					$("#chooseIds").val(data.productIds);
					$("#productNames").val(data.productNames);
	
					$("#all").attr("checked", false);
					init();
					$("#choose-all-btn").attr("status", "1");
				}
			})
	
		}
	
	
		/**
		 * 控制俩种全选按钮的状态
		 */
		function multipleBtnStatus() {
			if ($(".choose-item[type=checkbox]:checked").length == $(".choose-item").length) {
				$("#all").attr("checked", true);
			} else {
				$("#all").attr("checked", false);
			}
	
			if (idArr.length == size) {
				$("#choose-all-btn").attr("status", 1);
			} else {
				$("#choose-all-btn").attr("status", 0);
			}
		}
	</script>
</body>
</html>