<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%
	String path = request.getContextPath();

	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
%>
<html>
<head>
	<title>反馈列表</title>
	<meta name="decorator" content="default"/>

	<%--点击查看图片--%>
	<script>
        $(function(){
            $(".feedback-img").click(function(){
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
	<script type="text/javascript">
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").attr("action","${ctxsys}/PmUserFeedback");
			$("#searchForm").submit();
	    	return false;
	    }

        function showContent( content){
		    $("#feedback-content").html(content)
		}
	</script>


</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctxsys}/PmUserFeedback">用户反馈列表</a></li>
		<%-- <li ><a href="${ctxsys}/SbUserFeedback/form">用户反馈<shiro:lacksPermission name="merchandise:SbQaHelp:edit">查看</shiro:lacksPermission></a></li>
 --%>	</ul>
	 <form:form id="searchForm" modelAttribute="sbUserFeedback" action="${ctxsys}/PmUserFeedback" method="post" class="breadcrumb form-search ">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
		<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form">
		    <li><label>反馈内容:</label>
				<input type="text" value="${sbUserFeedback.fbContent}" name="fbContent"/>
		    <%--<form:select path="fbType">--%>
		        <%--<form:option value="">请选择</form:option>--%>
			    <%--<form:option value="1">功能建议</form:option>--%>
			    <%--<form:option value="2">问题反馈</form:option>--%>
			    <%--<form:option value="3">服务反馈</form:option>--%>
			    <%--<form:option value="4">商品问题反馈</form:option>--%>
			    <%--<form:option value="5">操作反馈</form:option>--%>
			    <%--<form:option value="6">其他反馈</form:option>--%>
			    <%--<form:option value="7">性能问题</form:option>--%>
		    <%--</form:select>--%>

		    <li><label></label><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/></li>
		</ul>
	</form:form> 
	<tags:message content="${message}"/>
	<table id="treeTable" class="table table-striped table-condensed table-bordered" >
		<tr>
		 <th class="center123">编号</th>
		 <th class="center123">用户名</th>
		 <%--<th class="center123">反馈类型</th>--%>
		 <th class="center123">反馈内容</th>
		 <th class="center123">反馈图片</th>
		 <th class="center123 sort-column createTime">创建时间</th>
		 <shiro:hasPermission name="merchandise:PmUserFeedback:edit">
		 <th class="center123">操作</th>
		 </shiro:hasPermission></tr>
		<c:forEach items="${page.list}" var="SbUserFeedbackList" varStatus="status">
			<tr>
			    <td class="center123">${status.index+1}</td>
				<td class="center123"><a href="${ctxsys}/PmUserFeedback/form?id=${SbUserFeedbackList.id}">${fns:getUser(SbUserFeedbackList.userId).username}</a></td>
				<%--<td class="center123">--%>
					<%--1、功能建议；2、问题反馈；3、服务反馈；4、商品问题反馈；5、操作反馈；6、其他反馈；7、性能问题；--%>
				<%--<c:if test="${SbUserFeedbackList.fbType==1}">功能建议</c:if>--%>
				<%--<c:if test="${SbUserFeedbackList.fbType==2}">问题反馈</c:if>--%>
				<%--<c:if test="${SbUserFeedbackList.fbType==3}">服务反馈</c:if>--%>
				<%--<c:if test="${SbUserFeedbackList.fbType==4}">商品问题反馈</c:if>--%>
				<%--<c:if test="${SbUserFeedbackList.fbType==5}">操作反馈</c:if>--%>
				<%--<c:if test="${SbUserFeedbackList.fbType==6}">其他反馈</c:if>--%>
				<%--<c:if test="${SbUserFeedbackList.fbType==7}">性能问题</c:if>--%>
				<%--</td>--%>
			    <td class="center123 "  data-toggle="modal" data-target="#myModal" onclick="showContent('${SbUserFeedbackList.fbContent}')" style="color: #18AEA1;cursor: pointer">${fns:abbr(SbUserFeedbackList.fbContent,10)}</td>
			    <td class="center123 ">
					<%--SbUserFeedbackList.fbPicUrl--%>
					<c:forEach items="${imgUrlList[status.index]}" var="imgUrl" varStatus="s">
						<c:if test="${s.index < 5}">
							<img src="${imgUrl}" class="feedback-img" style="height: 40px;margin-left: 5px;" />
						</c:if>

					</c:forEach>
				</td>
				<td class="center123">${SbUserFeedbackList.createTime}</td>
			    <shiro:hasPermission name="merchandise:PmUserFeedback:edit">
			    <td class="center123">
					<%-- <a href="${ctxsys}/PmUserFeedback/form?id=${SbUserFeedbackList.id}">修改</a> --%>
					<a href="${ctxsys}/PmUserFeedback/delete?id=${SbUserFeedbackList.id}" onclick="return confirmx('要删除该区域及所有子区域项吗？', this.href)">删除</a>
				</td>
				</shiro:hasPermission>
			</tr>
		</c:forEach>
	</table>
	<div class="pagination">${page}</div>

	<div id="outerdiv" style="position:fixed;top:0;left:0;background:rgba(0,0,0,0.7);z-index:2;width:100%;height:100%;display:none;">
		<div id="innerdiv" style="position:absolute;">
			<img id="bigimg" style="border:5px solid #fff;" src="" />
		</div>
	</div>


	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
						&times;
					</button>
					<h4 class="modal-title" id="myModalLabel">
						反馈内容
					</h4>
				</div>
				<div class="modal-body " id="feedback-content">

				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭
					</button>
				</div>
			</div><!-- /.modal-content -->
		</div><!-- /.modal -->
	</div>
</body>

</html>