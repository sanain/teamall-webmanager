<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<meta name="decorator" content="default"/>
	<title>门店信息</title>
	<link rel="stylesheet" href="${ctxStatic}/sbShop/css/build.css">
	<link rel="stylesheet" href="${ctxStatic}/h5/css/timePicker.css">
	<script type="text/javascript" src="${ctxStatic}/My97DatePicker/WdatePicker.js"></script>
	<script type="text/javascript" src="${ctxStatic}/h5/js/jquery-timepicker.js"></script>
	<link rel="stylesheet" href="${ctxStatic}/sbShop/layui/css/modules/layer/default/layer.css">
	<script src="${ctxStatic}/sbShop/layui/lay/modules/layer.js"></script>
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
		body .form-search .ul-form li label{width:100px;
			text-align: right;
			padding-right: 8px;
		}
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

            //提交之前验证时间格式
            $("#searchForm").submit(function(){
                var reg = /([0-1][0-9]|2[0-3]):([0-5][0-9])/
                var openingTime = $("#openingTime").val().trim();
                var closingTime = $("#closingTime").val().trim();

                if(openingTime!=undefined && openingTime != "" && !reg.test(openingTime)){
                    alert("开始营业时间不符合格式");
                    return false;
                }

                if(closingTime!=undefined && closingTime != "" &&  !reg.test(closingTime)){
                    alert("结束营业时间不符合格式");
                    return false;
                }

                return true;
            })
        });
        function page(n,s){
            if(n) $("#pageNo").val(n);
            if(s) $("#pageSize").val(s);
            $("#searchForm").attr("action","${ctxsys}/PmShopInfo");
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

	<script>
        $().ready(function(e) {

            $("#timePicker").hunterTimePicker();
            $(".time-picker").hunterTimePicker();
        });
	</script>


	<%--快速增加商品--%>
	<script type="text/javascript">
        function quickChooseProduct(shopId){
            var shopId = shopId;
            layer.open({
                type: 2,
                title: '商品列表',
                shadeClose: true,
                shade: false,
                maxmin: true, //开启最大化最小化按钮
                area: ['880px', '450px'],
                content: '${ctxsys}/Product/quickChooseProduct?shopId='+shopId,
                btn: [ '确定','关闭'],
                yes: function(index, layero){ //或者使用btn1
                    var content = layero.find("iframe")[0].contentWindow.$('#chooseIds').val();

                    if(content.trim()==""){
                        layer.msg("没有选中的商品");
                    }else{
                        layer.confirm('确定给该门店增加选中的商品？',{title:'增加确定'},function(){
                            $.ajax({
                                type:"POST",
                                url:"${ctxsys}/Product/quickInsertProduct",
                                data:{
                                    'shopId':shopId,
                                    'productIds':content
                                },
                                datatype: "json",
                                success:function(data){
                                    layer.msg(data.prompt);
                                },error: function(){
                                    layer.msg(data.prompt);
                                }
                            });
                        })
                        layer.close(index);
                    }
                }
            })
        }
	</script>
</head>
<body>
<ul class="nav nav-tabs">
	<shiro:hasPermission name="merchandise:PmShopInfo:view">
		<li class="active"><c:if test="${stule!='99'}"><a href="${ctxsys}/PmShopInfo">门店信息</a></c:if><c:if test="${stule=='99'}"><a>商户信息</a></c:if></li>
		<li><a href="${ctxsys}/PmShopInfo/shopinfo?flag=add">增加门店</a></li>
	</shiro:hasPermission>
</ul>
<form:form id="searchForm" modelAttribute="pmShopInfo" action="${ctxsys}/PmShopInfo" method="post" class="breadcrumb form-search ">
	<input type="hidden" name="stule" value="${stule}">
	<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
	<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
	<ul class="ul-form">

			<%--<li><label>公司名/店名/商户码:</label><form:input path="shopCode" htmlEscape="false" maxlength="80" class="input-medium"  placeholder=""/></li>--%>
		<li><label>店名:</label><form:input path="shopName" htmlEscape="false" maxlength="80" class="input-medium"  placeholder=""/></li>
		<li><label>门店地址:</label><form:input path="contactAddress" htmlEscape="false" maxlength="80" class="input-medium"  placeholder=""/></li>
		<li><label>开始营业时间:</label><form:input path="openingTime" id="openingTime" type="text"  htmlEscape="false" value="${openingTime}" maxlength="80" class="input-medium time-picker"  placeholder="请输入开始营业时间"/></li>
		<li><label>结束营业时间:</label><form:input path="closingTime" id="closingTime" type="text" htmlEscape="false" value="${closingTime}" maxlength="80" class="input-medium time-picker"  placeholder="请输入结束营业时间"/></li>

		<li style="margin-left:10px">&nbsp;&nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/></li>

		<c:if test="${stule!='99'}">
			<shiro:hasPermission name="merchandise:PmShopInfo:edit">
				<li style="margin-left:10px"><input id="btnExport" class="btn btn-primary check-a1" type="button" value="导出"/></li>
			</shiro:hasPermission>
		</c:if>
	</ul>
	<div class="check1">
		<div class="check-box">
			<p>导出选项<img class="check-del1" src="${ctxStatic}/sbShop/images/xxx-rzt.png" alt=""></p>
			<ul class="mn1">
				<li class="checkbox"><input type="checkbox" class="kl" value="" id="all"><label><i></i>全选</label></li>
				<li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="1"><label><i></i>店名</label></li>
				<li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="2"><label><i></i>地址</label></li>
				<li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="3"><label><i></i>开始营业时间</label></li>
				<li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="4"><label><i></i>结束营业时间</label></li>
			</ul>
			<div class="check-btn">
				<a href="javascript:;" id="fromNewActionSbM" >确定</a>
				<a class="check-del1" href="javascript:;">取消</a>
			</div>
		</div>
	</div>
</form:form>
<tags:message content="${message}"/>

<table id="treeTable" class="table table-striped table-condensed table-bordered" >
	<tr>
		<th class="center123">编号</th>
		<th class="center123">门店名称</th>
		<th class="center123">门店账号</th>
		<th class="center123">门店地址</th>
		<th class="center123">营业时间</th>
		<th class="center123">创建时间 </th>
		<shiro:hasPermission name="merchandise:PmShopInfo:edit">
			<th class="center123">操作</th>
		</shiro:hasPermission>
	</tr>
	<c:forEach items="${page.list}" var="PmShopInfoList" varStatus="status">
		<tr>
			<td class="center123">${status.index+1}</td>
			<td class="center123">${PmShopInfoList.shopName}</td>
			<td class="center123">${PmShopInfoList.shopCode}</td>
			<td class="center123">${PmShopInfoList.contactAddress}</td>
			<td class="center123">${PmShopInfoList.openingTime} ~ ${PmShopInfoList.closingTime}</td>
			<td class="center123">${PmShopInfoList.createTime}</td>
			<td class="center123">
				<c:if test="${stule=='99'}">
				</c:if>

				<c:if test="${stule!='99'}">
					<shiro:hasPermission name="merchandise:PmShopInfo:view">
					</shiro:hasPermission>
					<shiro:hasPermission name="merchandise:PmShopInfo:edit">
						<a href="${ctxsys}/PmShopInfo/shopinfo?id=${PmShopInfoList.id}">修改</a>
						<a href="javascript:;" onclick="quickChooseProduct('${PmShopInfoList.id}')">增加商品</a>
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
				<p><span>是否有推荐收益:</span><span><input name="reavw" type="radio" value="0" checked="checked"/>否<input name="reavw" type="radio" value="1"/>是</span></p>
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
<script type="text/javascript">

    $(function () {
        var arr = [ "成功"," 用户已经有门店",  " 用户不存在 " , "失败 " , " 账号为空"];
        if('${prompt}' != "" ){
            var index = parseInt('${prompt}');
            alert(arr[index])
        }

    })

</script>

</html>