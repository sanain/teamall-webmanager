<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>三级分类列表</title>
	<meta name="decorator" content="default"/>
	<link rel="stylesheet" href="${ctxStatic}/h5/css/timePicker.css">
	<script src="${ctxStatic}/jquery/jquery-1.9.1.min.js" type="text/javascript"></script>
	<script type="text/javascript" src="${ctxStatic}/h5/js/jquery-timepicker.js"></script>
	<script type="text/javascript">
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").attr("action","${ctxsys}/PmProductType/threeLevelList");
			$("#searchForm").submit();
	    	return false;
	    }
	 
	</script>
	<%--点击图片放大--%>
	<script>
        $(function(){
            $(".type-img").click(function(){
                var _this = $(this);//将当前的pimg元素作为_this传入函数
                imgShow("#outerdiv", "#innerdiv", "#bigimg", _this);
            });
        });

        function imgShow(outerdiv, innerdiv, bigimg, _this){
            var src = _this.attr("src");//获取当前点击的pimg元素中的src属性
            $(bigimg).attr("src", src);//设置#bigimg元素的src属性

            /*获取当前点击图片的真实大小，并显示弹出层及大图*/
            $("<img/>").attr("src", src).load(function(){
                var windowW = $(window).width();//获取当前窗口宽度
                var windowH = $(window).height();//获取当前窗口高度
                var realWidth = this.width;//获取图片真实宽度
                var realHeight = this.height;//获取图片真实高度
                var imgWidth, imgHeight;
                var scale = 0.8;//缩放尺寸，当图片真实宽度和高度大于窗口宽度和高度时进行缩放

                if(realHeight>windowH*scale) {//判断图片高度
                    imgHeight = windowH*scale;//如大于窗口高度，图片高度进行缩放
                    imgWidth = imgHeight/realHeight*realWidth;//等比例缩放宽度
                    if(imgWidth>windowW*scale) {//如宽度扔大于窗口宽度
                        imgWidth = windowW*scale;//再对宽度进行缩放
                    }
                } else if(realWidth>windowW*scale) {//如图片高度合适，判断图片宽度
                    imgWidth = windowW*scale;//如大于窗口宽度，图片宽度进行缩放
                    imgHeight = imgWidth/realWidth*realHeight;//等比例缩放高度
                } else {//如果图片真实高度和宽度都符合要求，高宽不变
                    imgWidth = realWidth;
                    imgHeight = realHeight;
                }
                $(bigimg).css("width",imgWidth);//以最终的宽度对图片缩放

                var w = (windowW-imgWidth)/2;//计算图片与窗口左边距
                var h = (windowH-imgHeight)/2;//计算图片与窗口上边距
                $(innerdiv).css({"top":h, "left":w});//设置#innerdiv的top和left属性
                $(outerdiv).fadeIn("fast");//淡入显示#outerdiv及.pimg
            });

            $(outerdiv).click(function(){//再次点击淡出消失弹出层
                $(this).fadeOut("fast");
            });
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
		<li class="active"><a href="${ctxsys}/PmProductType/threeLevelList">三级分类列表</a></li>

	</ul>
	 <form:form id="searchForm" modelAttribute="pmProductType" action="${ctxsys}/EbAdvertisement" method="post" class="breadcrumb form-search ">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
		<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form">
		    <li><label>分类名称:</label><form:input path="productTypeName" htmlEscape="false" maxlength="80" class="input-medium"  placeholder=""/></li>
		    <li><label>门店名称:</label><form:input path="shopName" htmlEscape="false" maxlength="80" class="input-medium"  placeholder=""/></li>

		    <li><label></label><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/></li>
		</ul>
	</form:form> 
	<tags:message content="${message}"/>
	
	<table id="treeTable" class="table table-striped table-condensed table-bordered" >
		<tr>
		 <th class="center123">编号</th>
		 <th class="center123">分类名称</th>
		 <%--<th class="center123">广告内容</th>--%>
		 <th class="center123">分类图片</th>
		 <th class="center123">层次关系</th>
		 <th class="center123">来源</th>
		 <th class="center123">使用状态</th>
		 <th class="center123 ">描述</th>
		  <shiro:hasPermission name="merchandise:EbProductCharging:view">
		 	<th class="center123">操作</th>
		  </shiro:hasPermission>
		</tr>
		<c:forEach items="${page.list}" var="productType" varStatus="status">
			<tr>
			    <td class="center123">${status.index+1}</td>
				<td class="center123 " style="color:#18AEA1;cursor: pointer"><a href="${ctxsys}/EbProductCharging/list?productTypeId=${productType.id}">${productType.productTypeName}</a></td>
				<%--显示图片--%>
				<td class="center123">
					<%--<c:if test="${not empty ebAdvertisement.asPic}" >--%>
						<%--<c:forEach items="${fn:split(ebAdvertisement.asPic,',')}" var="asPic" varStatus="vs">--%>
							<%--<c:if test="${vs.index <5}">--%>
								<img src="${productType.productTypeLogo}" class="type-img" style="height: 34px; padding: 3px"/>
							<%--</c:if>--%>
						<%--</c:forEach>--%>
					<%--</c:if>--%>
				</td>
				<td class="center123">${productType.productTypeStr} </td>
				<td class="center123">
					${productType.shopName != null && !''.equals(productType.shopName) ? productType.shopName : '平台'}
				</td>
				<td class="center123">
					<c:if test="${productType.isPublic == 0 || productType.isPublic == null}">
						平台使用
					</c:if>
					<c:if test="${productType.isPublic == 1}">
						商家使用
					</c:if>
					<c:if test="${productType.isPublic == 2}">
						平台和商家共用
					</c:if>
				</td>
				<td class="center123">
					${productType.describeInfo}
				</td>

				<shiro:hasPermission name="merchandise:EbProductCharging:view">
			    <td class="center123">
					<a href="${ctxsys}/EbProductCharging/list?productTypeId=${productType.id}">查看加料</a>
					<%--<a href="${ctxsys}/EbAdvertisement/delete?id=${ebAdvertisement.id}" onclick="return confirmx('确定删除该标签？', this.href)">删除</a>--%>
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