<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>商品申请</title>
    <style>
    body{background:#f5f5f5;}
    .nav-tabs li{width:130px;text-align:center;color:#333;}
     .nav-tabs .active a{border-top:3px solid #3E9388;color:#3E9388;}
     #searchForm{background:#fff;}
    </style>
    <meta name="decorator" content="default"/>

    <script type="text/javascript">
    	function page(n, s) {
    		if (n) $("#pageNo").val(n);
    		if (s) $("#pageSize").val(s);
    		$("#searchForm").attr("action", "${ctxweb}/shop/ebProductApplyShop/list");
    		$("#searchForm").submit();
    		return false;
    	}
    </script>

    <style type="text/css">

        #download-file:hover,.btns input:hover{
            color: rgb(120,120,120);
        }

        /*.nav-tabs a{*/
            /*color: rgb(120,120,120);*/
        /*}*/
    </style>
</head>

<body style="background:#f5f5f5;">
	<div style="color:#999;margin:19px 0 17px 30px;">
		<span>当前位置：</span><span>商品管理 - </span><span style="color:#009688;">申请列表</span>
	</div>
<div class="ibox-content"  style="background:#fff;margin:0 30px 30px 30px;padding-bottom:15px;">

    <ul class="nav nav-tabs">
        <li class="active"><a href="">申请列表</a></li>
        <li><a style="color: #333;" href="${ctxweb}/shop/ebProductApplyShop/productApplyForm">商品申请</a></li>
    </ul>

    <form:form id="searchForm" modelAttribute="getShop" action="${ctxweb}/shop/ebProductApply/list" method="post"
               class="breadcrumb form-search ">
        <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
        <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
        <tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
        <div class="p-xs">
            <ul class="ul-form">

                <li>
                    <label>审核状态：</label>
                    <form:select path="applyStatus">
                        <form:option value="0">全部</form:option>
                        <form:option value="1">审核通过</form:option>
                        <form:option value="2">审核不通过</form:option>
                        <form:option value="4">等待审核</form:option>
                        <form:option value="3">取消申请</form:option>
                    </form:select>
                </li>
                <li class="btns"><input style="background: #fff;color:#495572;padding:4px 12px;margin:0 20px;border:1px solid #495572; " id="btnSubmit" class="btn btn-primary" type="submit" value="查询"
                                        onclick="return page();"/>
                </li>
                <li>
                    <a id="download-file" style="background: #495572;" href="javascript:;" onclick="downloadFile('model' , -111 , 'downloadApplyModelFile')"  class="btn btn-primary"  >下载申请模板</a>
                </li>
            </ul>
        </div>
    </form:form>


    <table class="table table-striped table-bordered table-hover dataTables-example">
        <thead>
            <tr>
                <th>商品名称</th>
                <th>门店名称</th>
                <th>申请理由</th>
                <th>下载附件</th>
                <th>申请时间</th>
                <th>审核时间</th>
                <th>审核状态</th>
                <th>操作</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${page.list}" var="ls">
                    <tr>
                        <th style="cursor: pointer" onclick="showAll(1,'${ls.productName}')">
                                ${ls.productName.length() > 15 ? ls.productName.substring(0,15) : ls.productName}${ls.productName.length() > 15 ? "...":""}
                        </th>
                        <th style="cursor: pointer" onclick="showAll(2,'${ls.shopName}')">
                                ${ls.shopName.length() > 25 ? ls.shopName.substring(0,25) : ls.shopName}${ls.shopName.length() > 25 ? "...":""}
                        </th>
                        <th class="remark" style="cursor: pointer" onclick="showAll(2,'${ls.remark}')">
                                ${ls.remark.length() > 15 ? ls.remark.substring(0,15) : ls.remark}${ls.remark.length() > 15 ? "...":""}
                        </th>
                        <%--<th><a style="color: #009688;" onclick="downloadFile('applyFile','${ls.id}','downloadApplyFile')" href="${ctxweb}/shop/ebProductApplyShop/downloadApplyFile?fileName=${ls.fileUrl}" >下载</a></th>--%>
                        <th><a style="color: #009688;" onclick="downloadFile('applyFile','${ls.id}','downloadApplyFile')" href="javascript:;" >下载</a></th>
                        <th><fmt:formatDate value="${ls.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></th>
                        <th>${ls.applyTime}</th>
                        <th>
                            <c:if test="${ls.isapply==1}">
                                <c:if test="${ls.applyStatus==1}">
                                    <label style="color:#00aa00">审核通过</label>
                                </c:if>
                                <c:if test="${ls.applyStatus==2}">
                                    <label style="color:#dd0000">审核不通过</label>
                                </c:if>
                            </c:if>
                            <c:if test="${ls.isapply==2 && ls.applyStatus==0}">
                                <label style="color:#0b2c89">等待审核</label>
                            </c:if>
                            <c:if test="${ls.applyStatus==3}">
                                <label style="color:#8B91A0">取消申请</label>
                            </c:if>
                        </th>
                        <th>
                            <c:if test="${ls.isapply==2 && ls.applyStatus==0}">
                                <a style="color: #009688;" href="${ctxweb}/shop/ebProductApplyShop/update?id=${ls.id}" >取消申请</a> |
                            </c:if>
                            <c:if test="${ls.applyStatus==2}">
                                <a data-toggle="modal" style="color: #009688;" data-target="#myModal" onclick="magss(${ls.id})" style="color:#dd0000">审核信息</a> |
                            </c:if>
                            <a  style="color: #009688;" href="${ctxweb}/shop/ebProductApplyShop/productApplyForm?id=${ls.id}" style="color:#0b2c89">修改</a>
                        </th>
                    </tr>
            </c:forEach>
        </tbody>
    </table>
    <input type="hidden" id="ctxweb" value="${ctxweb}">
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">审核信息</h4>
                </div>
                <div class="modal-body">
                    <table class="table table-striped table-bordered table-hover dataTables-example">
                        <thead>
                            <tr>
                                <th>编号</th>
                                <th>审核信息</th>
                                <th>时间</th>
                            </tr>
                        </thead>
                        <tbody id="lists">

                        </tbody>
                    </table>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                </div>
            </div><!-- /.modal-content -->

            <div class="modal fade" id="remark-modal" tabindex="-1" role="dialog">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title">回复</h4>
                        </div>
                        <div class="modal-body">
                            <form id="form2">
                                <input type="hidden" value="" id="applyId" name="applyId">
                                <textarea readonly style="width: 100%;height: 140px" name="applyRemark" id="applyRemark" rows="5" cols="100"></textarea>
                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        </div>
                    </div><!-- /.modal-content -->
                </div><!-- /.modal-dialog -->
            </div><!-- /.modal -->


        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->
    <div class="pagination">${page}</div>
    <script>
    	var ctxweb = $("#ctxweb").val();
    	function formatDate(now) {
    		var year = now.getFullYear();
    		var month = now.getMonth() + 1;
    		var date = now.getDate();
    		var hour = now.getHours();
    		var minute = now.getMinutes();
    		var second = now.getSeconds();
    		return year + "-" + month + "-" + date + " " + hour + ":" + minute + ":" + second;
    	}
    	function magss(id) {
    		$("#lists").html('');
    		$.ajax({
    			url : ctxweb + "/shop/ebProductApplyShop/remarkList",
    			type : "post",
    			data : {
    				id : id
    			},
    			success : function(data) {
    				var str = "";
    				$.each(data.obj, function(index, item) {
    					str += "<tr>";
    					str += "<th>" + (index + 1) + "</th>";
    					str += "<th>" + item.applyRemark + "</th>";
    					str += "<th>" + formatDate(new Date(item.createTime)) + "</th>";
    					str += "</tr>";
    				});
    				$("#lists").append(str);
    			}
    		});
    	}
    </script>


    <script type="text/javascript">
    	function downloadFile(fileType, id, downloadPath) {
    		if (fileType == undefined || fileType == "") {
    			alert("文件不存在！");
    			return false;
    		}
    
    		$.ajax({
    			url : "${ctxweb}/shop/ebProductApplyShop/fileIsExists",
    			data : {
    				"id" : id,
    				"fileType" : fileType
    			},
    			dataType : "json",
    			success : function(data) {
    				if (data.flag == "yes") {
    					if ("model" == fileType) {
    						window.location.href = "${ctxweb}/shop/ebProductApplyShop/" + downloadPath;
    					} else {
    						window.location.href = "${ctxweb}/shop/ebProductApplyShop/" + downloadPath + "?id=" + id;
    					}
    				} else {
    					alert("文件不存在");
    				}
    			},
    			error : function() {
    				alert("aaa");
    			}
    		})
    	}
    </script>

    <%--<script type="text/javascript">--%>
        <%--$(function(){--%>
            <%--$(".remark").click(function(){--%>
                <%--$("#applyRemark").text($(this).attr("value"));--%>
<%----%>
                <%--$("#remark-modal").modal("show");--%>
            <%--})--%>
        <%--})--%>
    <%--// </script>--%>
</div>
</body>
</html>