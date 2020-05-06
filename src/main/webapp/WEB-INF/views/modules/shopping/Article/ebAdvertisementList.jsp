<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>门店广告投放</title>
	<meta name="decorator" content="default"/>
	<link rel="stylesheet" href="${ctxStatic}/h5/css/timePicker.css">
	<script src="${ctxStatic}/jquery/jquery-1.9.1.min.js" type="text/javascript"></script>
	<script type="text/javascript" src="${ctxStatic}/h5/js/jquery-timepicker.js"></script>
	<script type="text/javascript">
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").attr("action","${ctxsys}/EbAdvertisement");
			$("#searchForm").submit();
	    	return false;
	    }
	 
	</script>
	<%--点击图片放大--%>
	<script>
        $(function(){
            $(".adversite-img").click(function(){
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
	<%--时间插件--%>
	<script>
        $().ready(function(e) {

            $("#timePicker").hunterTimePicker();
            $(".time-picker").hunterTimePicker();

        });
	</script>

	<script type="text/javascript">
        $(function(){
            $(".createTime").val('${createTime}')
			var options = $("#adervitisement-stutas").find("option");
            for(var i = 1 ; i < options.length ;i++){
                if($(options[i]).val() == '${ebAdvertisement.status}'){
                    $(options[i]).attr("selected","selected");
				}
			}
		})
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
		<li class="active"><a href="${ctxsys}/EbAdvertisement">广告列表</a></li>
		<li >
			<shiro:hasPermission name="merchandise:EbAdvertisement:edit">
				<a href="${ctxsys}/EbAdvertisement/form?flag=add">增加广告</a>
			</shiro:hasPermission>
		</li>

	</ul>
	 <form:form id="searchForm" modelAttribute="ebAdvertisement" action="${ctxsys}/EbAdvertisement" method="post" class="breadcrumb form-search ">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
		<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form">
		    <li><label>广告名字:</label><form:input path="asName" htmlEscape="false" maxlength="80" class="input-medium"  placeholder=""/></li>
		    <li><label>创建时间:</label><form:input path="createTime" maxlength="80" class="input-medium time-picker createTime"  placeholder=""/></li>
		    <li><label>状态:</label>
			     <select name="status" id="adervitisement-stutas">
					 <option value="">全部</option>
					 <option <c:if test="${ebAdertisement.status}==1">selected</c:if> value="1" >启用</option>
					 <option <c:if test="${ebAdertisement.status}==2">selected</c:if>  value="2" >禁用</option>
	            </select>
		    </li>

		    <li><label></label><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/></li>
		</ul>
	</form:form> 
	<tags:message content="${message}"/>
	
	<table id="treeTable" class="table table-striped table-condensed table-bordered" >
		<tr>
		 <th class="center123">编号</th>
		 <th class="center123">广告名字</th>
		 <%--<th class="center123">广告内容</th>--%>
		 <th class="center123">广告图片</th>
		 <th class="center123">创建时间</th>
		 <th class="center123 ">状态</th>
		  <shiro:hasPermission name="merchandise:EbAdvertisement:edit">
		 	<th class="center123">操作</th>
		  </shiro:hasPermission>
		</tr>
		<c:forEach items="${page.list}" var="ebAdvertisement" varStatus="status">
			<tr>
			    <td class="center123">${status.index+1}</td>
				<td class="center123"><a href="${ctxsys}/EbAdvertisement/form?id=${ebAdvertisement.id}">${ebAdvertisement.asName}</a></td>
				<%--<td class="center123"><c:if test="${fn:length(ebAdvertisement.asContent)>11 }">${fn:substring(ebAdvertisement.asContent, 0, 11)}..</c:if></td>--%>
				<%--显示图片--%>
				<td class="center123">
					<c:if test="${not empty ebAdvertisement.asPic}" >
						<c:forEach items="${fn:split(ebAdvertisement.asPic,',')}" var="asPic" varStatus="vs">
							<c:if test="${vs.index <5}">
								<img src="${asPic}" class="adversite-img" style="height: 34px; padding: 3px"/>
							</c:if>
						</c:forEach>
					</c:if>

				<td class="center123"><fmt:formatDate value="${ebAdvertisement.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/> </td>
				<td class="center123">
						<c:if test="${ebAdvertisement.status == 1 }">启用</c:if>
						<c:if test="${ebAdvertisement.status == 2}">禁用</c:if>
				</td>

			    <shiro:hasPermission name="merchandise:EbAdvertisement:edit">
			    <td class="center123">
					<a href="${ctxsys}/EbAdvertisement/form?id=${ebAdvertisement.id}">修改</a>
					<a href="${ctxsys}/EbAdvertisement/delete?id=${ebAdvertisement.id}" onclick="return confirmx('确定删除该广告？', this.href)">删除</a>
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