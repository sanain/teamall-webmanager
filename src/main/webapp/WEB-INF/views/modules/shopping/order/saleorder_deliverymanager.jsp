<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="robots" content="noarchive">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, Order-scalable=0,minimal-ui">
	<meta name="Description" content="${fns:getProjectName()},销售信息"/>
	<meta name="Keywords" content="${fns:getProjectName()},销售信息"/>
	<title>销售信息</title>

	<script src="${ctxStatic}/sbShop/js/jquery.min.js"></script>
	<link rel="stylesheet" href="${ctxStatic}/sbShop/css/shipments-detail.css">
	<link rel="stylesheet" href="${ctxStatic}/sbShop/css/bootstrap.min.css">
	<link rel="stylesheet" href="${ctxStatic}/sbShop/css/sale_css.css">
	<link rel="stylesheet" href="${ctxStatic}/sbShop/css/build.css">
	<script src="${ctxStatic}/sbShop/js/shipments-detail.js"></script>
	<link rel="stylesheet" href="${ctxStatic}/h5/css/build.css">
	<link rel="stylesheet" href="${ctxStatic}/supplyshop//layui/css/modules/layer/default/layer.css?v=33">
	<script src="${ctxStatic}/supplyshop/layui/lay/modules/layer.js?v=35"></script>

	<style type="text/css">
		.charging-div{
			padding: 20px 0px 20px 15px;
		}
		.charging-title{
			font-weight: bold;
		}
		.charging-content{
			padding: 10px;
		}
	</style>
	<script>
        $(window.parent.document).find('.list-ul').find('ul').slideUp();
        $(window.parent.document).find('.list-ul').find('a').removeClass('active');
	</script>
	<script type="text/javascript">
        function paggshhide(){
            $('.run-ball-box').hide();
            $('.paggsh').hide();
        }
        function paggshshow(){
            $('.paggsh').show();
        }


	</script>
	<script>
        $(function(){

            $('.ul-tab li').click(function () {
                $(this).addClass('active').siblings().removeClass('active');
                var a=$(this).index();
                if (a==0){
                    $('.li-1').show();
                    $('.li-2').hide();
                    $('.li-3').hide();
                    $('.li-4').hide();
                    $('.li-5').hide();
                }else if(a==1){
                    $('.li-1').hide();
                    $('.li-2').show();
                    $('.li-3').hide();
                    $('.li-4').hide();
                    $('.li-5').hide();
                }else if(a==2){
                    $('.li-1').hide();
                    $('.li-2').hide();
                    $('.li-3').show();
                    $('.li-4').hide();
                    $('.li-5').hide();
                }else if(a==3){
                    $('.li-1').hide();
                    $('.li-2').hide();
                    $('.li-3').hide();
                    $('.li-4').show();
                    $('.li-5').hide();

                }else if(a==4){
                    $('.li-1').hide();
                    $('.li-2').hide();
                    $('.li-3').hide();
                    $('.li-4').hide();
                    $('.li-5').show();
                }
            });
        })


        function wubtna(){
            var expressNumber=$("#expressNumber").val();
            if(expressNumber==""){
                /*$("#expressNumber").css("border", "1px solid red")*/
                layer.alert("请填写运单编号!");
                return;
            }
            //询问框
            layer.open({
                content: '确定发货？'
                ,btn: ['确定', '取消']
                ,yes: function(index){
                    layer.close(index);
                    var index2= layer.load(1, {shade: [0.1,'#fff']});
                    var frm =document.forms[0];
                    setTimeout(function(){
                        frm.submit();
                    }, 1200);
                }
            });

        }


        function splitOrderItems(it){

            var falg=false;
            $(".orderitemdiv"+it+" input[type='text']").each(function(){
                if($(this).val()==""){
                    falg=false;
                }else{
                    falg=true;
                }
            });
            if(falg==false){
                layer.alert("请填写完整页面内容");
            }
            if(falg){
                var splitcontent="";
                for(var i=0;i<$(".orderitemdiv"+it).length;i++){
                    var orderitemId= $(".productname"+it).eq(i).attr("itemid");
                    var logisticsComCode=$("#logisticsComCode"+it+i+"Id").val();
                    var expressNumber=$("#expressNumber"+it+i).val();
                    var content=orderitemId+"-"+logisticsComCode+"-"+expressNumber;
                    /*  if($(".orderitemdiv"+it).length==1){
                         splitcontent=content;
                     }else{

                     } */
                    splitcontent+=content+",";

                }
                $("#splitContent").val(splitcontent);
                if(splitcontent.length>0){
                    var frm =document.forms[3];
                    setTimeout(function(){
                        frm.submit();
                    }, 1200);
                }
            }



        }




        function cxtb(){
            //询问框
            layer.open({
                content: '确定重新同步？'
                ,btn: ['确定', '取消']
                ,yes: function(index){
                    layer.close(index);
                    cxtbajax();
                }
            });

        }
        function cxtbajax(){
            var index;
            $.ajax({
                url : "${ctxsys}/Order/ordereditnc?orderId=${ebOrder.orderId}",
                type : 'post',
                data:{},
                cache : false,
                beforeSend:function(){
                    index= layer.load(1, {shade: [0.1,'#fff']});
                },
                success : function (data) {
                    layer.close(index);
                    if(data.code=='00'){
                        window.location.href="${ctxsys}/Order/saleorderdeliverymanager?orderId=${ebOrder.orderId}";
                    }else{
                        alert(data.msg);
                    }
                },
                error:function(data){
                    layer.close(index);
                }
            });
        }
        function fhck(){
            var warehouseRemark=$("#warehouseRemark").val();
            var warehouseIdId=$("#warehouseIdId").val();
            if(warehouseRemark==""){
                /*$("#expressNumber").css("border", "1px solid red")*/
                layer.open({content: "请填写仓库备注!",skin: 'msg',time: 2000 });
                return;
            }
            if(warehouseIdId==""){
                /*$("#expressNumber").css("border", "1px solid red")*/
                layer.open({content: "请选择仓库!",skin: 'msg',time: 2000 });
                return;
            }
            //询问框
            layer.open({
                content: '确定由该仓库进行发货？'
                ,btn: ['确定', '取消']
                ,yes: function(index){
                    layer.close(index);
                    var index2= layer.load(1, {shade: [0.1,'#fff']});
                    var frm =document.forms[2];
                    setTimeout(function(){
                        frm.submit();
                    }, 1200);



                }
            });

        }

        function send(){
            //询问框
            layer.open({
                content: '确认发货？'
                ,btn: ['确定', '取消']
                ,yes: function(index){
                    layer.close(index);

                    var index2= layer.load(1, {shade: [0.1,'#fff']});
                    setTimeout(function(){
                        window.location.href="${ctxsys}/Order/orderedit?orderId=${ebOrder.orderId}";
                    }, 1200);
                }
            });

        }

        function storesend(t){
            var store=$("#store"+t+"Name").val();
            var storeId=$("#store"+t+"Id").val();
            layer.open({
                content: "确认由' "+store+"' 门店进行派送？"
                ,btn: ['确定', '取消']
                ,yes: function(index){
                    layer.close(index);
                    /* window.location.href="${ctxsys}/Order/orderedit?storeId="+storeId+"&orderId=${ebOrder.orderId}";   */
                    var frm =document.forms[1];
                    var index2= layer.load(1, {shade: [0.1,'#fff']});
                    setTimeout(function(){
                        frm.submit();
                    }, 1200);
                }
            });
        }
	</script>
</head>
<body>

<div class="c-context">
	<ul class="nav-ul" style="margin:0px">
		<li><a style="height:100%;font-size:16px" href="${ctxsys}/Order/saleorderdata?orderId=${ebOrder.orderId}">订单资料</a></li>
		<li><a style="height:100%;font-size:16px" href="${ctxsys}/OrderLog/saleorderhis?orderId=${ebOrder.orderId}">历史分析</a></li>
		<li><a style="height:100%;font-size:16px" href="${ctxsys}/Order/saleorderdeliverylog?orderId=${ebOrder.orderId}">递送日志</a></li>
		<%--<li><a style="height:100%;font-size:16px" href="${ctxsys}/Order/saleorderAftersalelist?orderId=${ebOrder.orderId}">订单退货处理</a></li>--%>
		<li><a class="active" style="height:100%;font-size:16px" href="${ctxsys}/Order/saleorderdeliverymanager?orderId=${ebOrder.orderId}">递送管理</a></li>
		<%--<li><a style="height:100%;font-size:16px" href="${ctxsys}/Order/saleorderendreply?orderId=${ebOrder.orderId}">最终批复</a></li>--%>
		<%--<li><a href="${ctxsys}/NcMessageTable/saleordernc?orderId=${ebOrder.orderId}">nc同步</a></li>--%>
	</ul>

</div>
<div class="house">
	<p class="bu">确认收货信息及交易详情</p>

	<div class="house-list-body">
		<p>
			<span>门店：<a <c:if test="${ebOrder.shopId==1}">style="color:#18AEA1"</c:if> <c:if test="${ebOrder.shopId!=1}">style="color:blue"</c:if> href="${ctxsys}/PmShopInfo/shopinfo?id=${ebOrder.shopId}" target="tager">${ebOrder.shopName}</a></span>
			<span>订单编号：<a style="color:#18AEA1" href="${ctxsys}/Order/saleorderform?orderId=${ebOrder.orderId}" target="tager">${ebOrder.orderNo}</a></span>
			<span>创建时间：<span><fmt:formatDate value="${ebOrder.createTime}" type="both"/></span></span>
			<span>买家姓名/手机： <span><c:if test="${ebOrder.userId!=null}">
				<a style="color:#18AEA1" href="${ctxsys}/User/form?userId=${ebOrder.userId}">${ebOrder.userName}/${fns:replaceMobile(ebOrder.mobile)}</a></c:if>
				 <c:if test="${ebOrder.userId==null}">${ebOrder.gkuserName}/${fns:replaceMobile(ebOrder.gkuserMobile)}</c:if></span></span>
			<%--<span>运送方式：<span><c:if test="${ebOrder.shippingMethod==1}">快递</c:if>--%>
			<%--<c:if test="${ebOrder.shippingMethod==2}">EMS</c:if>--%>
			<%--<c:if test="${ebOrder.shippingMethod==3}">平邮</c:if>--%>
			<%--<c:if test="${ebOrder.shippingMethod==4}">买家自提</c:if>--%>
			<%--<c:if test="${ebOrder.shippingMethod==5}">送货上门</c:if></span></span>--%>
		</p>
		<ul class="list-left">
			<li>收货人：<c:if test="${ebOrder.shippingMethod!=4}">
				${ebOrder.acceptName}
			</c:if>
				<c:if test="${ebOrder.shippingMethod==4}">
					${ebOrder.userName}
				</c:if></li>
			<li>手机：<c:if test="${ebOrder.shippingMethod!=4}">
				${fns:replaceMobile(ebOrder.telphone)}
			</c:if>
				<c:if test="${ebOrder.shippingMethod==4}">
					${fns:replaceMobile(ebOrder.mobile)}
				</c:if></li>
			<li>收货地址：
				<c:if test="${ebOrder.shippingMethod != null && ebOrder.shippingMethod!=4}">
					${ebOrder.deliveryAddress}
				</c:if>
				<c:if test="${ebOrder.shippingMethod==4}">
					买家自提
				</c:if></li>
		</ul>
		<ul class="list-right">
			<%--<li>发票抬头：${ebOrder.invoiceTitle}</li>--%>
			<li>买家备注：${ebOrder.postscript}</li>
		</ul>
	</div>
	<div class="shop-mag">
		<ul class="mag-top">
			<li style="width:10%">商品ID</li>
			<li style="width:20%">商品图片</li>
			<li style="width:30%">商品名称</li>
			<li style="width:10%">价格</li>
			<c:if test="${fns:isShowWeight()}">
				<li style="width:10%">计量类型</li>
			</c:if>
			<li style="width:10%">商品数量</li>
			<%--<li style="width:10%">单位</li>--%>

			<%--<li style="width:10%">是否只能门店配送</li>--%>

			<%--<li style="width:10%">存货编码</li>--%>
		</ul>
		<c:forEach items="${ebOrder.ebOrderitems}" var="items" varStatus="vs">
			<ul class="mag-list">
				<li style="width:10%">${items.orderitemId}</li>
				<li style="width:20%">
					<div class="img-kuang">
						<c:choose>
							<c:when test="${empty items.productImg}"><img src="${ctxStatic}/sbShop/images/logo.png" alt=""></c:when>
							<c:when test="${items.productImg=='null'}"><img src="${ctxStatic}/sbShop/images/logo.png" alt=""></c:when>
							<c:otherwise><img src="${items.productImg}" alt=""></c:otherwise>
						</c:choose>
					</div>
				</li>
				<li style="width:30%"><input id="standardName" name="standardName" type="hidden" style="display:none;" value="${items.standardName}"/>
					<span>${items.productName}</span>
					<p >${items.standardName}</p>
				</li>
				<li style="width:10%">¥${items.realPrice}</li>
				<c:if test="${fns:isShowWeight()}">
					<li style="width:10%">${items.measuringType == null || items.measuringType==1 ? "件":"重量"}</li>
				</c:if>
				<li style="width:10%">
						${fns:replaceStoreNum(items.measuringType,items.measuringUnit,items.goodsNums)}
					<c:if test="${fns:isShowWeight()}">
						<c:if test="${items.measuringType != null && items.measuringType==2}">
							<c:if test="${items.measuringUnit == 1}">
								公斤
							</c:if>
							<c:if test="${items.measuringUnit == 2}">
								克
							</c:if>
							<c:if test="${items.measuringUnit == 3}">
								斤
							</c:if>
						</c:if>
					</c:if>
				</li>
					<%--<li style="width:10%">${items.unitName}</li>--%>
					<%--<li style="width:10%"><c:if test="${items.isAPhysicalStore==1}">是</c:if>--%>
					<%--<c:if test="${empty items.isAPhysicalStore||items.isAPhysicalStore==0}">否</c:if>--%>
					<%--</li>--%>

					<%--<li style="width:10%">${items.invcode}</li>--%>
			</ul>

			<div class="charging-div">
				<span class="charging-title">加料详情：</span>
				<c:if test="${ebOrderitemChargingList[vs.index] == null || ebOrderitemChargingList[vs.index].size() == 0}">
					无
				</c:if>

				<c:if test="${ebOrderitemChargingList[vs.index] != null && ebOrderitemChargingList[vs.index].size() > 0}">
					<c:forEach items="${ebOrderitemChargingList[vs.index]}" var="orderitemCharging">
						  <span class="charging-content">
								  ${orderitemCharging.lable}/￥ ${orderitemCharging.sellPrice}
						  </span>
					</c:forEach>
				</c:if>

			</div>
		</c:forEach>
	</div>

	<!--<c:if test="${ebOrder.status>=2&&ebOrder.shippingMethod!=4&&ebOrder.shippingMethod!=5&&ebOrder.warehouseId==null&&false}">
        <p class="bu">选择发货仓库</p>
		
        <div class="wu-liu">
            <ul class="ul-tab1">
                <li class="active"></li>
            </ul>
            <div class="div-tab">
            	<form class="form-horizontal" action="${ctxsys}/Order/ordereditwarehouse" method="post" name="form2">
                <div class="li-4">
                    <ul>
                        <li style="height:60px">选择发货仓库：
							 <tags:treeselect id="warehouseId" name="warehouseId" value="" labelName="" labelValue=""
							title="发货仓库" url="${ctxsys}/warehouse/treeDictsData"/>
                        </li>
						<input id="orderId" name="orderId" type="hidden" style="display:none;" value="${ebOrder.orderId}"/>
                          <div class="control-group" >
			        <label class="control-label">备注： </label>
			       <div class="controls" style="margin-top:10px">
			       <textarea id="warehouseRemark" name="warehouseRemark" class="input" 
			       style="resize: none;width: 300px;border-width: 1px;border-style: solid;border-color: rgb(220, 220, 220);border-image: initial;
			       border-radius: 3px;outline: none;padding: 5px 10px;" maxlength="150" placeholder="请输入150字以内....."></textarea>
		         	</div> 
		          </div>  
                         
                    </ul>
                    <a class="btn btn-primary" href="javascript:;" onclick="fhck();">确定</a>
                </div>
                </form>
            </div>
        </div>
		
		</c:if>

		<c:if test="${ebOrder.status>=2&&ebOrder.shippingMethod!=4&&ebOrder.shippingMethod!=5&&ebOrder.warehouseId!=null&&false}">
        <p class="bu">发货仓库信息</p>
		
        <div class="wu-liu">
            <ul class="ul-tab1">
                <li class="active"></li>
            </ul>
            <div class="div-tab">
            	<form class="form-horizontal">
                <div class="li-4">
                    <ul>
                      <table width="98%" align="center" cellspacing="1" cellpadding="3">
		<tr class="table_minor">
				<td width="145" style="padding:5px"><b>发货仓库</b></td>
					<td style="padding:5px">
						<font color="#0909f7"><strong> ${ebOrder.wareName}</strong></font></td>
				</tr>
				
				<tr class="table_main">
					<td width="145" style="padding:5px"><b>仓库编码</b></td>
					<td style="padding:5px">${ebOrder.wareNo}</td>
				</tr>
				<tr class="table_minor">
					<td width="145" style="padding:5px"><b>选择发货仓库时间</b></td>
					<td style="padding:5px"><fmt:formatDate value="${ebOrder.wareOptionTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				</tr>
				<tr class="table_main">
					<td width="145" style="padding:5px"><b>选择发货仓库备注</b></td>
					<td style="padding:5px">${ebOrder.warehouseRemark}</td>
				</tr>
				<tr class="table_minor">
					<td width="145" style="padding:5px"><b>nc同步信息</b></td>
					<td style="padding:5px">
					<a href="${ctxsys}/Order/saleorderdeliverylog?orderId=${ebOrder.orderId}" > <font size="2px" color="#18AEA1">重新同步</font></a>
					</td>
				</tr>
				<tr class="table_main">
				<table style="width:99%;margin:10px;border: 1px solid rgb(204, 204, 204); border-image: none;" border="0" cellspacing="2" cellpadding="3" id="aa">
			
				<tbody>
				<tr>
				  <td align="center" bgcolor="#0909f7"><font size="2px" color="#ffffff">action</font></td>
				  <td align="center" bgcolor="#0909f7"><font size="2px" color="#ffffff">单据标识</font></td>
				<td align="center" bgcolor="#0909f7"><font size="2px" color="#ffffff">操作时间</font></td>
				  <td align="center" bgcolor="#0909f7"><font size="2px" color="#ffffff">状态</font></td>
				<td align="center" bgcolor="#0909f7"><font size="2px" color="#ffffff">操作信息</font></td>
				  <td align="center" bgcolor="#0909f7"><font size="2px" color="#ffffff">请求入参</font></td>
				</tr>
			<c:forEach items="${ncMessageTablelist}" var="ncMessageTablelist" varStatus="status">
			<tr>
				  <td class="table_main"><font size="2px" color="#787777">${ncMessageTablelist.action}</font></td>
				<td class="table_main"><font size="2px" color="#787777">${ncMessageTablelist.billid}</font></td>
				  <td class="table_minor"><font size="2px" color="#787777">${ncMessageTablelist.maketime}</font></td>
				
				
				<td class="table_main"><font size="2px" color="#787777">
				<c:if test="${ncMessageTablelist.stauts==0}">成功</c:if>
				<c:if test="${ncMessageTablelist.stauts==1}">失败</c:if>
				<c:if test="${ncMessageTablelist.stauts==2}">异常</c:if>
				</font>
				</td>
				  <td class="table_minor"><font size="2px" color="#787777">
				  <c:if test="${ncMessageTablelist.stauts==0}">${ncMessageTablelist.description}</c:if>
				<c:if test="${ncMessageTablelist.stauts==1}">${ncMessageTablelist.message}</c:if>
				<c:if test="${ncMessageTablelist.stauts==2}">${ncMessageTablelist.message}</c:if>
				
				</font>
				  </td>
				    <td class="table_minor" ><xmp style="display:none">${ncMessageTablelist.startStr}</xmp><input type="button" value="复制" class="bb"/></td>
				</tr>
			
				
				</c:forEach>
			</tbody></table>
				</tr>
				
		</table>
                         
                    </ul>
                </div>
                </form>
            </div>
        </div>
		
		</c:if>
		-->
	<c:if test="${ebOrder.status==2&&ebOrder.shippingMethod==4}">
		<p class="bu">该订单由买家自提，需由门店<a style="color:#18AEA1" href="${ctxsys}/psstore/storeEdit?storeId=${ebOrder.assignedStoreId}">${ebOrder.storeName}</a>发货（门店地址：${ebOrder.storeAddr}，门店电话：${ebOrder.storePhone}）</p>
	</c:if>
	<c:if test="${ebOrder.status==2&&ebOrder.shippingMethod!=4&&ebOrder.shippingMethod!=5&&ebOrder.warehouseId==null}">
		<%--<p class="bu">发货方式</p>--%>
		<%--<div class="wu-liu" >--%>
		<%--<ul class="ul-tab">--%>
		<%----%>
		<%--<li class="active">旧版快递</li>--%>
		<%--<c:if test="${ebOrder.shopId==1}">--%>
		<%--<li style="display:none">无需物流</li>--%>
		<%--<li>门店派送</li>--%>
		<%--<li>仓库快递</li>--%>
		<%--<c:if test="${fn:length(ebOrder.ebOrderitems)>1}">--%>
		<%--<li>拆分快递</li>--%>
		<%--</c:if>--%>
		<%--</c:if>--%>
		<%----%>
		<%--</ul>--%>
		<%--<div class="div-tab" >--%>
		<%--<form class="form-horizontal" action="${ctxsys}/Order/orderedit" method="post" name="form2">--%>
		<%--<div class="li-1">--%>
		<%--<ul>--%>
		<%--&lt;%&ndash;              <li>商品名称:--%>
		<%--<select id="orderiteminfo" name="orderiteminfo">--%>
		<%--<c:forEach items="${ebOrder.ebOrderitems}" var="items">--%>
		<%--<c:if test="${items.isSend==0}">--%>
		<%--<option value="${items.orderitemId}">${items.productName}</option>--%>
		<%--</c:if>--%>
		<%--</c:forEach>--%>
		<%--</select>--%>
		<%--</li> &ndash;%&gt;--%>
		<%--<li style="height:60px">物流公司：--%>
		<%--<tags:treeselect id="logisticsComCode" name="logisticsComCode" value="" labelName="" labelValue=""--%>
		<%--title="物流公司" url="${ctxsys}/Order/treeDictsData"/>  --%>
		<%--</li>--%>
		<%--<li><input id="orderId" name="orderId" type="hidden" style="display:none;" value="${ebOrder.orderId}"/>--%>
		<%--运单编号： <input id="expressNumber" name="expressNumber" type="text">--%>
		<%--</li>--%>
		<%----%>
		<%--</ul>--%>
		<%--<a class="btn btn-primary" href="javascript:;" onclick="wubtna();">确定</a>--%>
		<%--</div>--%>
		<%--</form>--%>
		<%----%>
		<%--<div class="li-2">--%>
		<%--<ul>--%>
		<%--<li>--%>
		<%--<div class="radio1">--%>
		<%--<input checked type="radio">--%>
		<%----%>
		<%--</div>该订单由买家自提--%>
		<%--</li>--%>
		<%--<li>请仅在买家同意自提的情况下选择此项。</li>--%>
		<%--</ul>--%>
		<%--<a class="btn btn-primary" href="javascript:;" onclick="send();">确定</a>--%>
		<%--</div>--%>
		<%----%>
		<%--<form class="form-horizontal" action="${ctxsys}/Order/orderedit" method="post" name="form3">--%>
		<%--<input id="orderId" name="orderId" type="hidden" style="display:none;" value="${ebOrder.orderId}"/>--%>
		<%--<div class="li-3">--%>
		<%--<div class="control-group">--%>
		<%--<label class="control-label">选择门店： </label>--%>
		<%--<div class="controls" style="margin-top:10px">--%>
		<%--<tags:treeselect id="store" name="assignedStoreId" value="" labelName="" labelValue=""--%>
		<%--title="门店" url="${ctxsys}/Order/treeStoreData?orderId=${ebOrder.orderId}"  />  --%>
		<%--</div>--%>
		<%--</div>  --%>
		<%--<div class="control-group" >--%>
		<%--<label class="control-label">备注： </label>--%>
		<%--<div class="controls" style="margin-top:10px">--%>
		<%--<textarea id="assignedRemark" name="assignedRemark" class="input" --%>
		<%--style="resize: none;width: 300px;border-width: 1px;border-style: solid;border-color: rgb(220, 220, 220);border-image: initial;--%>
		<%--border-radius: 3px;outline: none;padding: 5px 10px;" maxlength="150" placeholder="请输入150字以内....."></textarea>--%>
		<%--</div> --%>
		<%--</div>  --%>
		<%--<div class="control-group" style="margin-top: 10px;">--%>
		<%--<label class="control-label">  <a class="btn btn-primary" href="javascript:;" onclick="storesend('');">确定</a></label>--%>
		<%--</div> --%>
		<%--</div></form>--%>
		<%----%>
		<%--<form class="form-horizontal" action="${ctxsys}/Order/ordereditwarehouse" method="post" name="form4">--%>
		<%--<div class="li-4" style="display:none;">--%>
		<%--<ul>--%>
		<%--<li style="height:60px">选择发货仓库：--%>
		<%--<tags:treeselect id="warehouseId" name="warehouseId" value="" labelName="" labelValue=""--%>
		<%--title="发货仓库" url="${ctxsys}/warehouse/treeDictsData?status=0"/>  --%>
		<%--</li>--%>
		<%--<input id="orderId" name="orderId" type="hidden" style="display:none;" value="${ebOrder.orderId}"/>--%>
		<%--<div class="control-group" >--%>
		<%--<label class="control-label">备注： </label>--%>
		<%--<div class="controls" style="margin-top:10px">--%>
		<%--<textarea id="warehouseRemark" name="warehouseRemark" class="input" --%>
		<%--style="resize: none;width: 300px;border-width: 1px;border-style: solid;border-color: rgb(220, 220, 220);border-image: initial;--%>
		<%--border-radius: 3px;outline: none;padding: 5px 10px;" maxlength="150" placeholder="请输入150字以内....."></textarea>--%>
		<%--</div> --%>
		<%--</div>  --%>
		<%--</ul>--%>
		<%--<a class="btn btn-primary" href="javascript:;" onclick="fhck();">确定</a>--%>
		<%--</div>--%>
		<%--</form>--%>
		<%----%>
		<%----%>
		<%--<form class="form-horizontal" action="${ctxsys}/Order/orderedit" method="post" name="form5" id="form5">--%>
		<%--<input type="hidden" id="splitContent" name="splitContent">--%>
		<%--<input name="orderId" type="hidden" style="display:none;" value="${ebOrder.orderId}"/>--%>
		<%--<div class="li-5" style="display:none;" >--%>
		<%----%>
		<%--<c:forEach items="${ebOrder.ebOrderitems}" var="items" varStatus="i">--%>
		<%--<c:if test="${items.isSend==0}">--%>
		<%--<div id="orderitem${items.orderitemId }" class="orderitemdiv">--%>
		<%--<div class="control-group">--%>
		<%--<label class="control-label" for="href">商品名称:</label>--%>
		<%--<div class="controls productname"  itemId="${items.orderitemId}">--%>
		<%--${items.productName} --%>
		<%--</div>--%>
		<%--</div>--%>
		<%----%>
		<%--<div class="control-group"  >--%>
		<%--<label class="control-label" for="href"> 物流公司:</label>--%>
		<%--<div class="controls">--%>
		<%--<tags:treeselect id="logisticsComCode${i.index}" name="logisticsComCode${i.index }" value="" labelName="" labelValue="" title="物流公司" url="${ctxsys}/Order/treeDictsData"/>  --%>

		<%--</div>--%>
		<%--</div>--%>
		<%----%>
		<%--<div class="control-group"  >--%>
		<%--<label class="control-label" for="href">运单编号： </label>--%>
		<%--<div class="controls">--%>
		<%--<input id="expressNumber${i.index }" name="expressNumber${i.index}" type="text">--%>
		<%--</div>--%>
		<%--</div>--%>
		<%--<hr style="width:20%; height:1px;border:none;border-top:1px dashed ;" />  --%>
		<%--</div>             --%>
		<%----%>
		<%----%>
		<%----%>
		<%--</c:if>--%>
		<%--</c:forEach>--%>
		<%----%>
		<%----%>
		<%--<a class="btn btn-primary"   href="javascript:;" onclick="splitOrderItems('');">  确定</a>--%>
		<%----%>
		<%----%>
		<%----%>
		<%----%>
		<%----%>
		<%--</div>--%>
		<%--</form>--%>
		<%----%>
		<%--</div>--%>
		<%--</div>--%>

	</c:if>
	<c:if test="${(ebOrder.status!=1&&ebOrder.status!=2)||ebOrder.shippingMethod==4||ebOrder.shippingMethod==5||ebOrder.warehouseId!=null}">
		<table width="98%" align="center" cellspacing="1" cellpadding="3">
			<tr class="table_minor">
				<td width="115" style="padding:5px"><b>nc同步状态</b></td>
				<td style="padding:5px">
					<c:if test="${ebOrder.status==2&&(ebOrder.assignedStoreId!=null||ebOrder.warehouseId!=null)&&(ebOrder.billcode==null||ebOrder.billcodeApprove==null||(ebOrder.billcodeScomment==null&&ebOrder.payType!=7)||(ebOrder.billcodeScomment==''&&ebOrder.payType!=7)||ebOrder.billcode==''||ebOrder.billcodeApprove=='')}">
						<font color="red"><strong>
							<a href="${ctxsys}/NcMessageTable/saleordernc?orderId=${ebOrder.orderId}">同步失败</a>
							<a class="btn btn-primary" href="javascript:;" onclick="cxtb();">重新同步</a>
						</strong></font>
					</c:if>

					<c:if test="${ebOrder.status==2&&(ebOrder.assignedStoreId!=null||ebOrder.warehouseId!=null)&&(ebOrder.billcode!=null&&ebOrder.billcodeApprove!=null&&(ebOrder.billcodeScomment!=null||ebOrder.payType==7))&&(ebOrder.billcode!=''&&ebOrder.billcodeApprove!=''&&(ebOrder.billcodeScomment!=''||ebOrder.payType==7))}">
						<font color="green"><strong>
							<a href="${ctxsys}/NcMessageTable/saleordernc?orderId=${ebOrder.orderId}">同步成功</a>
						</strong></font>
					</c:if>

					<c:if test="${ebOrder.status==3&&(ebOrder.assignedStoreId!=null||ebOrder.warehouseId!=null)&&((ebOrder.billcode==null||ebOrder.billcodeApprove==null||(ebOrder.billcodeScomment==null&&ebOrder.payType!=7)||ebOrder.billcode==''||ebOrder.billcodeApprove==''||(ebOrder.billcodeScomment==''&&ebOrder.payType!=7))||(ebOrder.billcodeXcds==null||ebOrder.billcodeXcdsApprove==null||ebOrder.billcodeSIDS==null||ebOrder.billcodeSIDSApprove==null||ebOrder.billcodeXcds==''||ebOrder.billcodeXcdsApprove==''||ebOrder.billcodeSIDS==''||ebOrder.billcodeSIDSApprove==''))}">
						<font color="red"><strong>
							<a href="${ctxsys}/NcMessageTable/saleordernc?orderId=${ebOrder.orderId}">同步失败</a>
							<a class="btn btn-primary" href="javascript:;" onclick="cxtb();">重新同步</a>
						</strong></font>
					</c:if>

					<c:if test="${ebOrder.status==3&&(ebOrder.assignedStoreId!=null||ebOrder.warehouseId!=null)&&((ebOrder.billcode!=null&&ebOrder.billcodeApprove!=null&&(ebOrder.billcodeScomment!=null||ebOrder.payType==7)&&ebOrder.billcode!=''&&ebOrder.billcodeApprove!=''&&(ebOrder.billcodeScomment!=''||ebOrder.payType==7))&&(ebOrder.billcodeXcds!=null&&ebOrder.billcodeXcdsApprove!=null&&ebOrder.billcodeSIDS!=null&&ebOrder.billcodeSIDSApprove!=null&&ebOrder.billcodeXcds!=''&&ebOrder.billcodeXcdsApprove!=''&&ebOrder.billcodeSIDS!=''&&ebOrder.billcodeSIDSApprove!=''))}">
						<font color="red"><strong>
							<a href="${ctxsys}/NcMessageTable/saleordernc?orderId=${ebOrder.orderId}">同步成功</a>
						</strong></font>
					</c:if>

					<c:if test="${ebOrder.status==3&&((ebOrder.billcode!=null&&ebOrder.billcode!='')||(ebOrder.billcodeApprove!=null&&ebOrder.billcodeApprove!=''))&&(ebOrder.ncCxOrderStatus!=null&&ebOrder.ncCxOrderStatus==1)}">
						<font color="red"><strong>
							<a href="${ctxsys}/NcMessageTable/saleordernc?orderId=${ebOrder.orderId}">作废失败</a>
							<a class="btn btn-primary" href="javascript:;" onclick="cxtb();">重新同步</a>
						</strong></font>
					</c:if>

				</td>
			</tr>
			<tr class="table_minor">
				<td width="115" style="padding:5px"><b>订单状态</b></td>
				<td style="padding:5px">
					<font color="#0909f7"><strong> <c:if test="${ebOrder.status==1}">等待买家付款</c:if>
						<c:if test="${ebOrder.status==2}">等待发货</c:if>
						<c:if test="${ebOrder.status==3}">已发货,待收货</c:if>
						<c:if test="${ebOrder.status==4}">交易成功，已完成</c:if>
						<c:if test="${ebOrder.status==5}">已关闭</c:if>
						<c:if test="${not empty ebOrder.refundOrderNo}">
							<c:if test="${ebOrder.status!=null&&ebOrder.status==6}">
								已退款
							</c:if>
							<c:if test="${ebOrder.status==null||ebOrder.status!=6}">
								退款中
							</c:if>

						</c:if>
					</strong></font></td>
			</tr>
			<tr class="table_main">
				<td width="115" style="padding:5px"><b>发货时间</b></td>
				<td style="padding:5px"><fmt:formatDate value="${ebOrder.sendTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
			</tr>
			<tr class="table_minor">
				<td width="115" style="padding:5px"><b>运送方式</b></td>
				<td style="padding:5px"><c:if test="${ebOrder.shippingMethod==1}">快递</c:if>
					<c:if test="${ebOrder.shippingMethod==2}">EMS</c:if>
					<c:if test="${ebOrder.shippingMethod==3}">平邮</c:if>
					<c:if test="${ebOrder.shippingMethod==4}">买家自提</c:if>
					<c:if test="${ebOrder.shippingMethod==5}">送货上门</c:if>
					<a href="${ctxsys}/Order/saleorderdeliverylog?orderId=${ebOrder.orderId}" > <font size="2px" color="#18AEA1">递送日志</font></a>
				</td>
			</tr>
			<c:if test="${ebOrder.shippingMethod==1}">
				<c:choose>
					<c:when test="${fn:length(ebOrder.ebOrderitems)>1&&(ebOrder.isSplitOrder!=null&&ebOrder.isSplitOrder==1)}">
						<c:forEach items="${ebOrder.ebOrderitems}" var="items" varStatus="i">
							<tr class="table_main">
								<td width="115" style="padding:5px"><b>商品名称</b></td>
								<td style="padding:5px">${items.productName}</td>
							</tr>

							<tr class="table_main">
								<td width="115" style="padding:5px"><b>物流公司</b></td>
								<td style="padding:5px">${items.logisticsCompany}
									<c:if test="${ebOrder.status==3}"><font color="#0909f7"  onclick="paggshshow();"><strong>【修改】</strong></font></c:if>
								</td>
							</tr>
							<tr class="table_minor">
								<td width="115" style="padding:5px"><b>快递编号</b></td>
								<td style="padding:5px">${items.expressNumber}</td>
							</tr>

						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr class="table_main">
							<td width="115" style="padding:5px"><b>物流公司</b></td>
							<td style="padding:5px">${ebOrder.logisticsCompany}
								<c:if test="${ebOrder.status==3}"><font color="#0909f7"  onclick="paggshshow();"><strong>【修改】</strong></font></c:if>
							</td>
						</tr>
						<tr class="table_minor">
							<td width="115" style="padding:5px"><b>快递编号</b></td>
							<td style="padding:5px">${ebOrder.expressNumber}</td>
						</tr>
					</c:otherwise>
				</c:choose>

			</c:if>
			<c:if test="${ebOrder.shippingMethod==4||ebOrder.shippingMethod==5}">
				<c:if test="${not empty ebOrder.storeName}">
				<tr class="table_main">
					<td width="115" style="padding:5px"><b>门店名字</b></td>
					<td style="padding:5px"><a style="color:#18AEA1" href="${ctxsys}/psstore/storeEdit?storeId=${ebOrder.assignedStoreId}">${ebOrder.storeName}</a><c:if test="${ebOrder.status==2}"><font color="#0909f7"  onclick="paggshshow();"><strong>【修改】</strong></font></c:if></td>
				</tr>
				</c:if>
				<c:if test="${not empty ebOrder.storePhone}">
				<tr class="table_minor">
					<td width="115" style="padding:5px"><b>门店电话</b></td>
					<td style="padding:5px">${ebOrder.storePhone}</td>
				</tr>
				</c:if>
				<c:if test="${not empty ebOrder.storeAddr}">
				<tr class="table_minor">
					<td width="115" style="padding:5px"><b>门店地址</b></td>
					<td style="padding:5px">${ebOrder.storeAddr}</td>
				</tr>
				</c:if>
				<c:if test="${not empty ebOrder.storeBusinessTime}">
				<tr class="table_minor">
					<td width="115" style="padding:5px"><b>营业时间</b></td>
					<td style="padding:5px">${ebOrder.storeBusinessTime}</td>
				</tr>
				</c:if>
			</c:if>

			<c:if test="${ebOrder.warehouseId!=null}">
				<tr class="table_main">
					<td width="115" style="padding:5px"><b>仓库名称</b></td>
					<td style="padding:5px"><a style="color:#18AEA1" href="${ctxsys}/warehouse/form?id=${ebOrder.warehouseId}">${ebOrder.wareName}</a> <c:if test="${ebOrder.status==2}"><font color="#0909f7"  onclick="paggshshow();"><strong>【修改】</strong></font></c:if></td>
				</tr>
				<tr class="table_minor">
					<td width="115" style="padding:5px"><b>仓库编码</b></td>
					<td style="padding:5px">${ebOrder.wareNo}</td>
				</tr>
				<tr class="table_minor">
					<td width="115" style="padding:5px"><b>仓库备注</b></td>
					<td style="padding:5px">${ebOrder.warehouseRemark}</td>
				</tr>
				<tr class="table_minor">
					<td width="115" style="padding:5px"><b>选择仓库时间</b></td>
					<td style="padding:5px"><fmt:formatDate value="${ebOrder.wareOptionTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				</tr>
			</c:if>


			<c:if test="${not empty ebOrder.assignedRemark}">
				<tr class="table_main">
					<td width="115" style="padding:5px"><b>备注</b></td>
					<td style="padding:5px">${ebOrder.assignedRemark}</td>
				</tr>
			</c:if>


		</table>
	</c:if>
</div>
<div class="paggsh" style="position:fixed;top:0;left:0;right:0;bottom:0;z-index:1111;background:rgba(0,0,0,0.4);display:none">
	<div style="position:absolute;width:800px;height:430px;top:20%;left:10%;margin-left:-30px;margin-top:-50px;background:#fff;">

		<p class="bu" style="margin:10px"><label >选择发货方式</label></p>
		<div class="wu-liu" >
			<ul class="ul-tab">

				<li class="active">旧版快递</li>
				<c:if test="${ebOrder.shopId==1}">
					<li style="display:none">无需物流</li>
					<li>门店派送</li>
					<li>仓库快递</li>
					<c:if test="${fn:length(ebOrder.ebOrderitems)>1}">
						<li>拆分快递</li>
					</c:if>
				</c:if>
			</ul>
			<div class="div-tab" style="height: 300px;
    overflow: auto;">
				<form class="form-horizontal" action="${ctxsys}/Order/orderedit?cx=1" method="post" name="form2">
					<div class="li-1 li-11">
						<ul>
							<%--              <li>商品名称:
                                       <select id="orderiteminfo" name="orderiteminfo">
                                       <c:forEach items="${ebOrder.ebOrderitems}" var="items">
                                              <c:if test="${items.isSend==0}">
                                               <option value="${items.orderitemId}">${items.productName}</option>
                                               </c:if>
                                         </c:forEach>
                                          </select>
                                          </li> --%>
							<li style="height:60px">物流公司：
								<tags:treeselect id="logisticsComCodet" name="logisticsComCodet" value="" labelName="" labelValue=""
												 title="物流公司" url="${ctxsys}/Order/treeDictsData"/>
							</li>
							<li><input id="orderId" name="orderId" type="hidden" style="display:none;" value="${ebOrder.orderId}"/>
								运单编号： <input id="expressNumber" name="expressNumber" type="text">
							</li>

						</ul>
						<a class="btn btn-primary" href="javascript:;" onclick="wubtna();">确定</a>
						<a class="btn btn-primary" href="javascript:;" onclick="paggshhide();">取消</a>
					</div>
				</form>

				<div class="li-2">
					<ul>
						<li>
							<div class="radio1">
								<input checked type="radio">

							</div>该订单由买家自提
						</li>
						<li>请仅在买家同意自提的情况下选择此项。</li>
					</ul>
					<a class="btn btn-primary" href="javascript:;" onclick="send();">确定</a>
					<a class="btn btn-primary" href="javascript:;" onclick="paggshhide();">取消</a>
				</div>

				<form class="form-horizontal" action="${ctxsys}/Order/orderedit?cx=1" method="post" name="form3">
					<input id="orderId" name="orderId" type="hidden" style="display:none;" value="${ebOrder.orderId}"/>
					<div class="li-3 li-13">
						<div class="control-group">
							<label class="control-label">选择门店： </label>
							<div class="controls" style="margin-top:10px">
								<tags:treeselect id="store1" name="assignedStoreId1" value="" labelName="" labelValue=""
												 title="门店" url="${ctxsys}/Order/treeStoreData?orderId=${ebOrder.orderId}"  />
							</div>
						</div>
						<div class="control-group" >
							<label class="control-label">备注： </label>
							<div class="controls" style="margin-top:10px">
			       <textarea id="assignedRemark" name="assignedRemark" class="input"
							 style="resize: none;width: 300px;border-width: 1px;border-style: solid;border-color: rgb(220, 220, 220);border-image: initial;
			       border-radius: 3px;outline: none;padding: 5px 10px;" maxlength="150" placeholder="请输入150字以内....."></textarea>
							</div>
						</div>
						<div class="control-group" style="margin-top: 10px;">
							<label class="control-label">  <a class="btn btn-primary" href="javascript:;" onclick="storesend('1');">确定</a></label>
							<a class="btn btn-primary" href="javascript:;" onclick="paggshhide();">取消</a> </div>
					</div></form>

				<form class="form-horizontal" action="${ctxsys}/Order/ordereditwarehouse?cx=1" method="post" name="form4">
					<div class="li-4" style="display:none;">
						<ul>
							<li style="height:60px">选择发货仓库：
								<tags:treeselect id="warehouseId1" name="warehouseId1" value="" labelName="" labelValue=""
												 title="发货仓库" url="${ctxsys}/warehouse/treeDictsData?status=0"/>
							</li>
							<input id="orderId" name="orderId" type="hidden" style="display:none;" value="${ebOrder.orderId}"/>
							<div class="control-group" >
								<label class="control-label">备注： </label>
								<div class="controls" style="margin-top:10px">
			       <textarea id="warehouseRemark" name="warehouseRemark" class="input"
							 style="resize: none;width: 300px;border-width: 1px;border-style: solid;border-color: rgb(220, 220, 220);border-image: initial;
			       border-radius: 3px;outline: none;padding: 5px 10px;" maxlength="150" placeholder="请输入150字以内....."></textarea>
								</div>
							</div>

						</ul>
						<a class="btn btn-primary" href="javascript:;" onclick="fhck();">确定</a>
						<a class="btn btn-primary" href="javascript:;" onclick="paggshhide();">取消</a>
					</div>
				</form>


				<form class="form-horizontal" action="${ctxsys}/Order/orderedit?cx=1" method="post" name="form5" id="form5">
					<input type="hidden" id="splitContent" name="splitContent">
					<input name="orderId" type="hidden" style="display:none;" value="${ebOrder.orderId}"/>
					<div class="li-5" style="display:none;" >

						<c:forEach items="${ebOrder.ebOrderitems}" var="items" varStatus="i">
							<c:if test="${items.isSend==0||items.isSend==1}">
								<div id="orderitem${items.orderitemId }" class="orderitemdivt" style="overflow: hidden;">
									<div class="control-group" style="float: left;width: 200px;">
										<label class="control-label" for="href">商品名称:</label>
										<div class="controls productnamet"  itemId="${items.orderitemId}">
												${items.productName}
										</div>
									</div>

									<div class="control-group"  style="float: left;margin-left:20px" >
										<label class="control-label" for="href"> 物流公司:</label>
										<div class="controls">
											<tags:treeselect id="logisticsComCodet${i.index}" name="logisticsComCodet${i.index}" value="" labelName="" labelValue="" title="物流公司" url="${ctxsys}/Order/treeDictsData"/>

										</div>
									</div>

									<div class="control-group"  style="float: left;" >
										<label class="control-label" for="href">运单编号： </label>
										<div class="controls">
											<input id="expressNumbert${i.index }" name="expressNumbert${i.index}" type="text">
										</div>
									</div>

								</div>
								<hr style="width:80%; height:1px;border:none;border-top:1px dashed ;" />
							</c:if>
						</c:forEach>


						<a class="btn btn-primary"   href="javascript:;" onclick="splitOrderItems('t');">  确定</a>
						<a class="btn btn-primary" href="javascript:;" onclick="paggshhide();">取消</a>

					</div>
				</form>

			</div>
		</div>

	</div>
	<div class="run-ball-box" style="display:none">
		<div class="loadE">
			<div class="loadEffect">
				<div><span></span></div>
				<div><span></span></div>
				<div><span></span></div>
				<div><span></span></div>
			</div>
		</div>
	</div>
</body>
</html>