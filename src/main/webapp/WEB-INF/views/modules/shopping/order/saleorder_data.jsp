<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, Order-scalable=0,minimal-ui">
	<meta name="Description" content="${fns:getProjectName()},销售信息"/>
	<meta name="Keywords" content="${fns:getProjectName()},销售信息"/>
	<title>销售信息</title>
	<link rel="stylesheet" href="${ctxStatic}/sbShop/css/sale_css.css">
	<link href="${ctxStatic}/jquery-jbox/2.3/Skins/Bootstrap/jbox.css" rel="stylesheet">
	<script src="${ctxStatic}/sbShop/js/jquery.min.js"></script>
	<script src="${ctxStatic}/jquery-jbox/2.3/jquery.jBox-2.3.js" type="text/javascript"></script>
	<script type="text/javascript">
        function divtkhide(){
            $('.divtk').hide();
        }
        function divtkshow(content,type){
            $('.divtk').show();
            $('.content-input').val(content)
            $('.type-input').val(type)
            if(type=='1'){
                $('.type-label').html("确定修改收货人名字");
            }else if(type=='2'){
                $('.type-label').html("确定修改收货人邮箱");
            }else if(type=='3'){
                $('.type-label').html("确定修改收货人电话");
            }

        }
	</script>
	<script type="text/javascript">
        function statusSave(){
            var content=$('.content-input').val();
            var orderId=$('.orderId-input').val();
            var type=$('.type-input').val();
            var msg = "保存成功";
            var msgerr = "操作异常，请刷新页面";
            // 提交保存
            $.ajax({
                url : "${ctxsys}/Order/userSave",
                type : 'post',
                data : {
                    content : content,
                    orderId : orderId,
                    type : type
                },
                cache : false,
                success : function(data) {
                    // 保存成功
                    if(data=='00'){
                        top.$.jBox.tip(msg, 'info');
                        // 保存完成后重新查询
                        divtkhide();
                        if(type=='1'){
                            $('.acceptName-input').html(content);
                        }else if(type=='2'){
                            $('.acceptEmail-input').html(content);
                        }else if(type=='3'){
                            $('.telphone-input').html(content);
                        }
                    } else {
                        top.$.jBox.tip(msgerr, 'info');
                    }
                }
            });
        }
	</script>
</head>
<body>
<div class="c-context">
	<ul class="nav-ul" style="margin-bottom:0px">
		<li><a class="active" href="${ctxsys}/Order/saleorderdata?orderId=${ebOrder.orderId}">订单资料</a></li>
		<li><a href="${ctxsys}/OrderLog/saleorderhis?orderId=${ebOrder.orderId}">历史分析</a></li>
		<li><a href="${ctxsys}/Order/saleorderdeliverylog?orderId=${ebOrder.orderId}">递送日志</a></li>
		<%--<li><a href="${ctxsys}/Order/saleorderAftersalelist?orderId=${ebOrder.orderId}">订单退货处理</a></li>--%>
		<li><a href="${ctxsys}/Order/saleorderdeliverymanager?orderId=${ebOrder.orderId}">递送管理</a></li>
		<%--<li><a href="${ctxsys}/Order/saleorderendreply?orderId=${ebOrder.orderId}">最终批复</a></li>--%>
		<%--<li><a href="${ctxsys}/NcMessageTable/saleordernc?orderId=${ebOrder.orderId}">nc同步</a></li>--%>
	</ul>
</div>
<table style="width: 100%;" border="0" cellspacing="0" cellpadding="0">
	<tbody>
	<tr>

		<td>
			<table style="width: 100%; height: 500px; border-right-color: rgb(102, 102, 102); border-bottom-color: rgb(102, 102, 102); border-left-color: rgb(102, 102, 102); border-right-width: 1px; border-bottom-width: 1px; border-left-width: 1px; border-right-style: solid; border-bottom-style: solid; border-left-style: solid;" border="0" cellspacing="0" cellpadding="0">
				<tbody><tr><td valign="top" style="background: rgb(255, 255, 255);">

					<table id="pane615D9AA2E653CF843EFA3A724F5593B5" style="width: 100%;" border="0" cellspacing="0" cellpadding="0"><tbody><tr><td style="background: rgb(255, 255, 255);">


						<br><br>
						<link href="../../css/style.css" rel="stylesheet" type="text/css">
						<table width="98%" align="center" cellspacing="1" cellpadding="3">
							<tbody>
							<tr>
								<td width="43%" align="center" valign="top">
									<table width="98%" style="border: 1px solid rgb(204, 204, 204); border-image: none;" border="0" cellspacing="2" cellpadding="3">

										<tbody><tr class="table_minor">
											<td colspan="2"><b>本订单一共拥有<font size="+2">${traListsize}</font>次交易信息</b></td>
										</tr>
										<c:forEach items="${traList}" var="traList" varStatus="status">
											<tr class="table_minor" style="background-color:#13f9cb">
												<td colspan="2"><b>第${status.index+1}次交易信息</b></td>
											</tr>
											<tr class="table_main">
												<td width="141"><b>交易日期</b></td>
												<td width="294"><font color="blue"><strong><fmt:formatDate value="${traList.payTranstime}" pattern="yyyy-MM-dd HH:mm:ss"/></strong></font></td>
											</tr>
											<%--<tr class="table_minor">--%>
											<%--<td width="141"><b>站点名称</b></td>--%>
											<%--<td><font color="blue"><strong></strong></font></td>--%>
											<%--</tr>--%>
											<tr class="table_main">
												<td width="141"><b>交易流水号</b></td>
												<td>${traList.payTransid}</td>
											</tr>
											<tr class="table_minor">
												<td width="141"><b>订单号</b></td>
												<td>${traList.poNo}</td>
											</tr>



											<tr class="table_main">
												<td width="141"><b>付款金额</b></td>
												<c:if test="${traList.transactionLogo==1}">
												<td style="color: green;"><strong>${traList.payMoney} ${traList.currencyType} 已核对</strong>
													</c:if>
													<c:if test="${traList.transactionLogo==2}">
												<td style="color: orange;"><strong>${traList.payMoney} ${traList.currencyType} 未核对</strong>
													</c:if>
													<c:if test="${traList.transactionLogo==3}">
												<td style="color: red;"><strong>${traList.payMoney} ${traList.currencyType} 原路退款</strong>
													</c:if>
													<c:if test="${traList.transactionLogo==4}">
												<td style="color: blue;"><strong>${traList.payMoney} ${traList.currencyType} 再次发送支付成功请求</strong>
													</c:if>
												</td>
											</tr>
											<tr class="table_minor">
												<td width="141"><b>支付类型</b></td>
												<td><strong>
														${fns:getPayRemark(ebOrder.payType,ebOrder.isvScanType)}
													<%--<c:if test="${traList.payType==1}">货到付款</c:if>--%>
													<%--<c:if test="${traList.payType==2}">支付宝支付</c:if>--%>
													<%--<c:if test="${traList.payType==3}">快钱支付 </c:if>--%>
													<%--<c:if test="${traList.payType==4}">银联支付</c:if>--%>
													<%--<c:if test="${traList.payType==5}">微信支付</c:if>--%>
													<%--<c:if test="${traList.payType==6}">现场支付</c:if>--%>
													<%--<c:if test="${traList.payType==7}">余额支付</c:if>--%>
													<%--<c:if test="${traList.payType==8}">汇卡支付 </c:if>--%>
													<%--<c:if test="${traList.payType==9}">易联支付 </c:if>--%>
													<%--<c:if test="${traList.payType==10}">通联支付 </c:if>--%>
													<%--<c:if test="${traList.payType==11}">酷宝快捷支付  </c:if>--%>
													<%--<c:if test="${traList.payType==12}">易宝微信支付 </c:if>--%>
													<%--<c:if test="${traList.payType==13}">易宝支付宝支付  </c:if>--%>
													<%--<c:if test="${traList.payType==14}">易宝一键支付 </c:if>--%>
													<%--<c:if test="${traList.payType==15}">通联移动支付 </c:if>--%>
													<%--<c:if test="${traList.payType==16}">易宝微信支付2  </c:if>--%>
													<%--<c:if test="${traList.payType==17}">易宝一键支付2 </c:if>--%>
													<%--<c:if test="${traList.payType==52}">H5微信支付</c:if>--%>
												</strong></td>
											</tr>
											<tr class="table_main">
												<td width="141"><b>支付号</b></td>
												<td>${traList.paymentNo}</td>
											</tr>
											<tr class="table_minor">
												<td width="141"><b>支付人姓名</b></td>
												<td>${traList.payerName}</td>
											</tr>
											<c:if test="${not empty traList.payerPhone}">
												<tr class="table_main">
													<td width="141"><b>支付人手机号码</b></td>
													<td>${traList.payerPhone}</td>
												</tr>
											</c:if>
											<c:if test="${not empty traList.payerEmail}">
												<tr class="table_main">
													<td width="141"><b>支付人邮箱</b></td>
													<td>${traList.payerEmail}</td>
												</tr>
											</c:if>
										</c:forEach>
										</tbody></table>



								</td>
								<td width="57%" align="center" valign="top">



									<table width="98%" style="border: 1px solid rgb(204, 204, 204); border-image: none;" border="0" cellspacing="2" cellpadding="3">
										<tbody><tr class="table_minor">
											<td width="95"><b>下单日期</b></td>
											<td><font color="blue"><strong><fmt:formatDate value="${ebOrder.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></strong></font></td>
										</tr>
										<tr class="table_main">
											<td width="95"><b>订单类型</b></td>
											<td><font color="blue"><strong> <c:if test="${ebOrder.type==1}">商品订单</c:if>
												<c:if test="${ebOrder.type==2}">精英合伙人订单</c:if>
												<c:if test="${ebOrder.type==3}">充值订单</c:if>
												<c:if test="${ebOrder.type==4}">兑换订单</c:if>
											</strong></font></td>
										</tr>
										<tr class="table_minor">
											<td width="95"><b>订单号</b></td>
											<td><a style="color:#18AEA1" href="${ctxsys}/Order/saleorderform?orderId=${ebOrder.orderId}">${ebOrder.orderNo}</a></td>
										</tr>
										<tr class="table_main">
											<td width="141"><b>买家姓名/手机</b></td>
											<td>
												<c:if test="${ebOrder.userId!=null}">
													<a style="color:#18AEA1" href="${ctxsys}/User/form?userId=${ebOrder.userId}">${ebOrder.userName}/
														<c:if test="${ebUser.shopShoppingId != null}">
															${fns:replaceMobile(ebOrder.mobile)}
														</c:if>

														<c:if test="${ebUser.shopShoppingId == null}">
															${ebOrder.mobile}
														</c:if>
													</a>
												</c:if>
												<%--<c:if test="${ebOrder.userId==null}">--%>
												<%--fdsadfsa--%>
												<%--${ebOrder.gkuserName}/--%>
												<%--<c:if test="${ebOrder.gkuserMobile.contains(shopShoppingFlag)}">--%>
												<%--${fns:replaceMobile(ebOrder.gkuserMobile)}--%>
												<%--</c:if>--%>
												<%----%>
												<%--<c:if test="${!ebOrder.gkuserMobile.contains(shopShoppingFlag)}">--%>
												<%--${ebOrder.gkuserMobile}--%>
												<%--</c:if>--%>
												<%--</c:if>--%>
											</td>
											</td>
										</tr>
										<tr class="table_minor">
											<td width="95"><b>货币</b></td>
											<td>RMB</td>
										</tr>
										<%--<tr class="table_main">--%>
										<%--<td width="95"><b>应付商品总金额</b></td>--%>
										<%--<td>  --%>
										<%--<fmt:formatNumber type="number" value="${ebOrder.payableAmount+ebOrder.realFreight-ebOrder.certificateAmount}" pattern="0.00" maxFractionDigits="2"/>--%>
										<%--</td>--%>
										<%--</tr>--%>
										<%--<tr class="table_minor">--%>
										<%--<td width="95"><b>实付商品总金额</b></td>--%>
										<%--<td>--%>
										<%--<fmt:formatNumber type="number" value="${ebOrder.payableAmount+ebOrder.realFreight-ebOrder.certificateAmount}" pattern="0.00" maxFractionDigits="2"/>--%>
										<%----%>
										<%--</td>--%>
										<%--</tr>--%>
										<tr class="table_main">
											<td width="95"><b>订单总金额</b></td>
											<td>
												<fmt:formatNumber type="number" value="${ebOrder.payableAmount+ebOrder.realFreight}" pattern="0.00" maxFractionDigits="2"/>
											</td>
										</tr>

										<%--<tr class="table_minor">--%>
										<%--<td width="95"><b>促销优惠金额</b></td>--%>
										<%--<td>-<fmt:formatNumber type="number" value="${ebOrder.certificateAmount}" pattern="0.00" maxFractionDigits="2"/>--%>
										<%--（${ebOrder.certificateName }）--%>
										<%--</td>--%>
										<%--</tr>--%>
										<%--<tr class="table_main">--%>
										<%--<td width="95"><b>订单折扣或涨价</b></td>--%>
										<%--<td>${ebOrder.discount}</td>--%>
										<%--</tr>--%>
										<tr class="table_minor">
											<td width="95"><b>总运费金额</b></td>
											<td>${ebOrder.payableFreight}</td>
										</tr>
										<tr class="table_main">
											<td width="95"><b>实付运费</b></td>
											<td>${ebOrder.realFreight}</td>
										</tr>
										<tr class="table_minor">
											<td width="95"><b>支付状态</b></td>
											<c:if test="${ebOrder.payStatus==0}">
												<td bgcolor="#aaf4f7">
													未支付	</td>
											</c:if>
											<c:if test="${ebOrder.payStatus==1}">
												<td bgcolor="#aaf4f7">
													已支付	</td>
											</c:if>
										</tr>
										<tr class="table_main">
											<td width="95"><b>支付方式</b></td>
											<td bgcolor="#aaf4f7">
												${openPayWayByCode.payRemark}
											</td>
										</tr>
										<tr class="table_main">
											<td width="95"><b>支付号</b></td>
											<td bgcolor="#aaf4f7">${ebOrder.paymentNo}</td>
										</tr>
										<tr class="table_minor">
											<td width="95"><b>付款时间</b></td>
											<td bgcolor="#aaf4f7"><fmt:formatDate value="${ebOrder.payTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
										</tr>
										<c:if test="${not empty ebOrder.sendTime}">
											<tr class="table_main">
												<td width="95"><b>发货时间</b></td>
												<td><fmt:formatDate value="${ebOrder.sendTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
											</tr>
										</c:if>
										<c:if test="${not empty ebOrder.completionTime}">
											<tr class="table_minor">
												<td width="95"><b>订单完成时间</b></td>
												<td><fmt:formatDate value="${ebOrder.completionTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
											</tr>
										</c:if>
										<c:if test="${not empty ebOrder.refundTime}">
											<tr class="table_minor">
												<td width="95"><b>订单退款时间</b></td>
												<td><fmt:formatDate value="${ebOrder.refundTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
											</tr>
										</c:if>
										<%--<tr class="table_main">--%>
										<%--<td width="95"><b>营销方式</b></td>--%>
										<%--<td> <c:if test="${ebOrder.saleMode==1}">自主 </c:if></td>--%>
										<%--</tr>--%>
										<%--<tr class="table_minor">--%>
										<%--<td width="95" nowrap=""><b>来源名称</b></td>--%>
										<%--<td>${ebOrder.saleSource}</td>--%>
										<%--</tr>--%>
										<tr class="table_main">
											<td width="95" nowrap=""><b>订单来源</b></td>
											<td>
												<%--<c:if test="${ebOrder.saleSource == 1}">--%>
												<%--安卓应用程序--%>
												<%--</c:if>--%>
												<%--<c:if test="${ebOrder.saleSource == 2}">--%>
												<%--苹果应用程序--%>
												<%--</c:if>--%>
												<%--<c:if test="${ebOrder.saleSource == 3}">--%>
												<%--网页端--%>
												<%--</c:if>--%>
												<%--<c:if test="${ebOrder.saleSource == 4}">--%>
												<%--电脑应用程序--%>
												<%--</c:if>--%>
												<c:if test="${ebOrder.saleSource == 5}">
													收银端
												</c:if>
												<c:if test="${ebOrder.saleSource == 6}">
													小程序
												</c:if>
											</td>
										</tr>

										<tr class="table_main">
											<td width="95" nowrap=""><b>设备版本信息</b></td>
											<td>${ebOrder.saleDevVersion}</td>
										</tr>
										<tr class="table_minor">
											<td width="95" nowrap=""><b>IP 地址</b></td>
											<td nowrap="">${ebOrder.saleIp}</td>
										</tr>
										<tr>
											<td style="border: 2px solid rgb(204, 204, 204); border-image: none;" colspan="2">
												<table width="100%" border="0" cellspacing="2" cellpadding="3">
													<tbody>
													<c:if test="${not empty ebOrder.gkuserName}">
														<tr class="table_main">
															<td width="95" nowrap=""><b>顾客姓名</b></td>
															<td nowrap="">${ebOrder.gkuserName}</td>
														</tr>
													</c:if>

													<c:if test="${not empty ebOrder.gkuserEmail}">
														<tr class="table_minor">
															<td width="95" nowrap=""><b>顾客邮箱</b></td>
															<td nowrap="">${ebOrder.gkuserEmail}</td>
														</tr>
													</c:if>

													<c:if test="${not empty ebOrder.gkuserPhone}">
														<tr class="table_main">
															<td width="95"><b>顾客电话</b></td>
															<td>${ebOrder.gkuserPhone}</td>
														</tr>
													</c:if>

													<c:if test="${not empty ebOrder.gkuserMobile}">
														<tr class="table_minor">
															<td width="95"><b>顾客手机/Fax</b></td>
															<td>${fns:replaceMobile(ebOrder.gkuserMobile)}</td>
														</tr>
													</c:if>

													<c:if test="${not empty ebOrder.gkuserStreet}">
														<tr class="table_main">
															<td width="95" nowrap=""><b>顾客街道</b></td>
															<td nowrap="">${ebOrder.gkuserStreet}</td>
														</tr>
													</c:if>

													<c:if test="${not empty ebOrder.gkuserCity}">
														<tr class="table_minor">
															<td width="95"><b>顾客城市</b></td>
															<td>${ebOrder.gkuserCity}</td>
														</tr>
													</c:if>

													<c:if test="${not empty ebOrder.gkuserProvince}">
														<tr class="table_main">
															<td width="95"><b>顾客省</b></td>
															<td>${ebOrder.gkuserProvince}
															</td>
														</tr>
													</c:if>

													<%--<c:if test="${not empty ebOrder.gkuserNative}">--%>
													<%--<tr class="table_minor">--%>
													<%--<td width="95"><b>顾客国家</b></td>--%>
													<%--<td>${ebOrder.gkuserNative}</td>--%>
													<%--</tr>--%>
													<%--</c:if>--%>
													<%--<tr class="table_main">--%>
													<%--<td width="95"><b>顾客邮编</b></td>--%>
													<%--<td>${ebOrder.gkuserZipCode}</td>--%>
													<%--</tr>--%>
													<c:if test="${not empty ebOrder.gkuserQq}">
														<tr class="table_minor">
															<td width="95"><b>顾客QQ</b></td>
															<td>${ebOrder.gkuserQq}</td>
														</tr>
													</c:if>
													</tbody></table>
											</td>
										</tr>
										<tr>
											<td style="border: 2px solid rgb(204, 204, 204); border-image: none;" colspan="2">
												<table width="100%" border="0" cellspacing="2" cellpadding="3">
													<tbody>
													<c:if test="${not empty ebOrder.acceptName}">
														<tr class="table_main">
															<td width="95"><b>收货人姓名</b>
																<br>
																<a style="color:#18AEA1" onclick="divtkshow('${ebOrder.acceptName}','1')"><u>[修改名字]</u></a></td>
															<td class="acceptName-input">${ebOrder.acceptName}</td>
														</tr>
													</c:if>

													<c:if test="${not empty ebOrder.acceptEmail}">
														<tr class="table_minor">
															<td width="95"><b>收货人邮箱</b>
																<br>
																<a style="color:#18AEA1" onclick="divtkshow('${ebOrder.acceptEmail}','2')"><u>[修改Email]</u></a>
															</td>
															<td class="acceptEmail-input">${ebOrder.acceptEmail}</td>
														</tr>
													</c:if>

													<c:if test="${not empty ebOrder.telphone}">
														<tr class="table_main">
															<td width="95"><b>收货人电话</b>
																<br>
																<a style="color:#18AEA1" onclick="divtkshow('${ebOrder.telphone}','3')"><u>[修改电话]</u></a></td>
															<td class="telphone-input">${ebOrder.telphone}</td>
														</tr>
													</c:if>

													<c:if test="${not empty ebOrder.deliveryAddress}">
														<tr class="table_main">
															<td width="95"><b>收货人地址</b></td>
															<td>${ebOrder.deliveryAddress}</td>
														</tr>
													</c:if>

													<c:if test="${not empty ebOrder.postcode}">
														<tr class="table_main">
															<td width="95"><b>收货人邮编</b></td>
															<td>${ebOrder.postcode}</td>
														</tr>
													</c:if>

													<c:if test="${not empty ebOrder.userQq}">
														<tr class="table_minor">
															<td width="95"><b>收货人QQ</b></td>
															<td>${ebOrder.userQq}</td>
														</tr>
													</c:if>
													</tbody></table>
											</td>
										</tr>
										<tr class="table_main">
											<td width="95"><strong>配送状态</strong></td>
											<td>
												<c:if test="${ebOrder.deliveryStatus==0}">未发送</c:if>
												<c:if test="${ebOrder.deliveryStatus==1}">已发送</c:if>
												<c:if test="${ebOrder.deliveryStatus==2}">部分发送</c:if>
											</td>
										</tr>
										<%--<tr class="table_minor">--%>
										<%--<td width="95"><b>运送方式</b></td>--%>
										<%--<td>--%>
										<%--<c:if test="${ebOrder.shippingMethod==1}">快递</c:if>--%>
										<%--<c:if test="${ebOrder.shippingMethod==2}">EMS</c:if>--%>
										<%--<c:if test="${ebOrder.shippingMethod==3}">平邮</c:if>--%>
										<%--<c:if test="${ebOrder.shippingMethod==4}">买家自提</c:if>--%>
										<%--<c:if test="${ebOrder.shippingMethod==5}">送货上门</c:if>--%>
										<%--</td>--%>
										<%--</tr>--%>
										<%--<tr class="table_minor">--%>
										<%--<td width="95"><b>物流公司/门店</b></td>--%>
										<%--<td>${ebOrder.logisticsCompany}</td>--%>
										<%--</tr>--%>
										<%--<tr class="table_main">--%>
										<%--<td width="95"><b>快递编号</b></td>--%>
										<%--<td>${ebOrder.expressNumber}</td>--%>
										<%--</tr>--%>
										<c:if test="${not empty ebOrder.postscript}">
											<tr class="table_minor">
												<td width="95"><b>用户附言</b></td>
												<td>${ebOrder.postscript}</td>
											</tr>
										</c:if>
										<%--<tr class="table_minor">--%>
										<%--<td width="95"><b>是否开发发票</b></td>--%>
										<%--<td>--%>
										<%--<c:if test="${ebOrder.isLnvoice==0}">否</c:if>--%>
										<%--<c:if test="${ebOrder.isLnvoice==1}">是</c:if>--%>
										<%--</td>--%>
										<%--</tr>--%>
										<%--<tr class="table_minor">--%>
										<%--<td width="95"><b>发票抬头</b></td>--%>
										<%--<td>${ebOrder.invoiceTitle}</td>--%>
										<%--</tr>--%>
										<%--<tr class="table_minor">--%>
										<%--<td width="95"><b>发送邮箱</b></td>--%>
										<%--<td>${ebOrder.invoicePostEmail}</td>--%>
										<%--</tr>--%>
										<%--<tr class="table_minor">--%>
										<%--<td width="95"><b>发票状态</b></td>--%>
										<%--<td>--%>
										<%--<c:if test="${empty ebOrder.invoiceStatus || ebOrder.invoiceStatus == 0 }">未发送</c:if>--%>
										<%--<c:if test="${not empty ebOrder.invoiceStatus && ebOrder.invoiceStatus == 1 }">已发送</c:if>--%>
										<%--</td>--%>
										<%--</tr>--%>
										<%--<tr class="table_minor">--%>
										<%--<td width="95"><b>纳税人识别号</b></td>--%>
										<%--<td>${ebOrder.invoicePeopleNo}</td>--%>
										<%--</tr>--%>
										<tr class="table_main">
											<td width="95"><b>订单状态</b></td>
											<td align="center" bgcolor="#0909f7">
												<font color="#ffffff"><strong> <c:if test="${ebOrder.status==1}">等待买家付款</c:if>
													<c:if test="${ebOrder.status==2}">等待发货</c:if>
													<c:if test="${ebOrder.status==3}">已发货,待收货</c:if>
													<c:if test="${ebOrder.status==4}">交易成功，已完成</c:if>
													<c:if test="${ebOrder.status==5}">已关闭</c:if>
													<c:if test="${ebOrder.refundOrderNo != null && !''.equals(ebOrder.refundOrderNo)}">
														<c:if test="${ebOrder.status!=null&&ebOrder.status==6}">
															已退款
														</c:if>
														<c:if test="${ebOrder.status==null||ebOrder.status!=6}">
															退款中
														</c:if>
													</c:if>
												</strong></font></td>
										</tr>
										<%--<tr class="table_minor">--%>
										<%--<td width="95"><b>取消订单理由</b></td>--%>
										<%--<td>--%>
										<%--${ebOrder.cancelReason}--%>
										<%--</td>--%>
										<%--</tr>--%>
										<%--<tr class="table_main">--%>
										<%--<td width="95"><b>退款流水号</b></td>--%>
										<%--<td>--%>
										<%--${ebOrder.serialNumber}--%>
										<%--</td>--%>
										<%--</tr>--%>
										<%--<tr class="table_minor">--%>
										<%--<td width="95"><b>是否延长收货</b> <br>推迟3天收货</td>--%>
										<%--<td>--%>
										<%--<c:if test="${ebOrder.isExtendTake==1}">是</c:if>--%>
										<%--<c:if test="${ebOrder.isExtendTake==0}">否</c:if>--%>
										<%--</td>--%>
										<%--</tr>--%>
										<tr class="table_minor">
											<td width="95"><b>递送状态</b></td>
											<td align="center" bgcolor="#4dd52b">
												<font color="#ffffff"><strong>FINI</strong></font></td>
										</tr>


										<tr class="table_main">

											<td width="95"><b>订单信息</b></td>
											<td>
												<c:if test="${ebOrder.onoffLineStatus==1||ebOrder.onoffLineStatus==4}">
													<table width="100%" border="0">
														<tbody><tr class="table_title">
															<td align="left"><b>商品名称</b></td>
															<td align="left"><strong>属性</strong></td>
															<td align="left"><strong>售价</strong></td>
															<td align="left"><strong>计量类型</strong></td>
															<td align="left"><strong>数量</strong></td>
																<%--<td align="left"><strong>让利比</strong></td>--%>
														</tr>


														<c:forEach items="${ebOrder.ebOrderitems}" var="ebOrderitems">
														<tr class="table_minor">
															<td align="left"><a style="color:#18AEA1" href="${ctxsys}/Product/show?productId=${ebOrderitems.productId}"><u>${ebOrderitems.productName}</u></a></td>
															<td align="left">${ebOrderitems.standardName}
															</td>
															<td align="left" nowrap=""> ¥${ebOrderitems.realPrice}</td>
															<td>${ebOrderitems.measuringType == null || ebOrderitems.measuringType==1 ? "件":"重量"}</td>
															<td>
																	${fns:replaceStoreNum(ebOrderitems.measuringType,ebOrderitems.measuringUnit,ebOrderitems.goodsNums)}
																<c:if test="${ebOrderitems.measuringType != null && ebOrderitems.measuringType==2}">
																	<c:if test="${fns:isShowWeight()}">
																		<c:if test="${ebOrderitems.measuringUnit == 1}">
																			公斤
																		</c:if>
																		<c:if test="${ebOrderitems.measuringUnit == 2}">
																			克
																		</c:if>
																		<c:if test="${ebOrderitems.measuringUnit == 3}">
																			斤
																		</c:if>
																		<%--${ebOrderitems.measuringUnit == null || ebOrderitems.measuringUnit==1 ? "公斤":"克"}--%>
																	</c:if>
																</c:if>
															</td>
																<%--<td align="left" nowrap="">${ebOrderitems.returnRatio}%</td>--%>
															</c:forEach>

														<tr>
														</tr>
														</tbody></table>
												</c:if>
											</td>
										</tr>
										<%--<tr>--%>
										<%--<td style="border: 2px solid rgb(204, 204, 204); border-image: none;" colspan="2">--%>
										<%--<table width="100%" border="0" cellspacing="2" cellpadding="3">--%>
										<%--<tbody><tr class="table_main">--%>
										<%--<td width="95" nowrap=""><b>线上让利金额</b></td>--%>
										<%--<td nowrap="">${ebOrder.sRealAmount}</td>--%>
										<%--</tr>	--%>
										<%--<tr class="table_minor">--%>
										<%--<td width="95" nowrap=""><b>御可贡茶兑换价值，御可贡茶对货币价值</b></td>--%>
										<%--<td nowrap="">${ebOrder.lovePayChange}</td>--%>
										<%--</tr>--%>
										<%--<tr class="table_main">--%>
										<%--<td width="95"><b>抵付御可贡茶数</b></td>--%>
										<%--<td>${ebOrder.lovePayCount}</td>--%>
										<%--</tr>--%>
										<%--<tr class="table_minor">--%>
										<%--<td width="95"><b>抵付御可贡茶折合金额</b></td>--%>
										<%--<td>${ebOrder.lovePayAmount}</td>--%>
										<%--</tr>		--%>
										<%--<tr class="table_main">--%>
										<%--<td width="95" nowrap=""><b>让利比</b></td>--%>
										<%--<td nowrap="">${ebOrder.returnRatio}</td>--%>
										<%--</tr>	--%>
										<%--<tr class="table_minor">--%>
										<%--<td width="95"><b>商家付款总金额</b></td>--%>
										<%--<td>${ebOrder.shopPayAmount}</td>--%>
										<%--</tr>--%>
										<%--<tr class="table_main">--%>
										<%--<td width="95"><b>消费金折合金额</b></td>--%>
										<%--<td>${ebOrder.consumptionPointsAmount}--%>
										<%--</td>--%>
										<%--</tr>				--%>
										<%--<tr class="table_minor">--%>
										<%--<td width="95"><b>抵付冻结love数</b></td>--%>
										<%--<td>${ebOrder.frozenLovePayCount}</td>--%>
										<%--</tr>	--%>
										<%--<tr class="table_main">--%>
										<%--<td width="95"><b>抵付冻结love折合金额</b></td>--%>
										<%--<td>${ebOrder.frozenLovePayAmount}</td>--%>
										<%--</tr>--%>
										<%----%>
										<%--<tr class="table_minor">--%>
										<%--<td width="95"><b>积分支付获取方</b></td>--%>
										<%--<td><c:if test="${ebOrder.lovePayGain==1}">平台</c:if>--%>
										<%--<c:if test="${ebOrder.lovePayGain==2}">商家</c:if></td>--%>
										<%--</tr>		--%>
										<%----%>
										<%--<tr class="table_main">--%>
										<%--<td width="95"><b>是否使用消费金支付</b></td>--%>
										<%--<td><c:if test="${ebOrder.isConsumptionPointsPay==1}">是</c:if>--%>
										<%--<c:if test="${ebOrder.isConsumptionPointsPay==0}">否</c:if></td>--%>
										<%--</tr>			--%>
										<%--<tr class="table_minor">--%>
										<%--<td width="95"><b>消费金对比余额倍数</b></td>--%>
										<%--<td>${ebOrder.pointsCompareBalance}</td>--%>
										<%--</tr>--%>
										<%--<tr class="table_minor">--%>
										<%--<td width="95"><b>是否激活专区商品订单</b></td>--%>
										<%--<td><c:if test="${ebOrder.isActivateProduct==1}">是</c:if>--%>
										<%--<c:if test="${ebOrder.isActivateProduct==0}">否</c:if></td>--%>
										<%--</tr>	--%>
										<%--</tbody></table>--%>
										<%--</td>--%>
										<%--</tr>	--%>
										</tbody></table>


									<br><br>
								</td>
							</tr>
							</tbody></table><br><br>

					</td></tr></tbody></table>


					<table id="pane615D9AB2E96F4F5E012C6741970CF57E" style="width: 100%; display: none;" border="0" cellspacing="0" cellpadding="0"><tbody><tr><td style="background: rgb(255, 255, 255);">


						<br><br>
						<link href="../../css/style.css" rel="stylesheet" type="text/css">
						<br>




					</td></tr></tbody></table></td></tr></tbody></table>
			</div>
			<div class="divtk" style="position:fixed;top:0;left:0;right:0;bottom:0;z-index:1111;background:rgba(0,0,0,0.4);display:none">
				<div style="position:absolute;width:300px;height:100px;top:50%;left:50%;margin-left:-50px;margin-top:-80px;background:#fff;padding:10px">
					<form:form id="inputFormTiket" modelAttribute="ebOrder" action="" method="post" class="form-horizontal" style="margin-top:10px;">
						<form:hidden path="orderId" class="orderId-input"/>
						<tags:message content="${message}"/>
						<div>
							<label class="type-label">确认修改收货人信息吗?</label>
						</div>
						<input type="text" class="content-input"/>
						<input type="hidden" class="type-input"/>
						<div style="margin-top:10px;text-align:right">
							<input id="btnSubmit" type="button" onclick="statusSave();" value="确认"/>&nbsp;
							<input id="btnCancel" type="button" value="取消" onclick="divtkhide()"/>
						</div>
					</form:form>
				</div>
</body>
</html>