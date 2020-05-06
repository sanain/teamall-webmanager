<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/front/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<meta name="decorator" content="frontdefault"/>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title></title>
	<meta name="keywords" content="" />
	<meta name="description" content="" />
	<script type="text/javascript" src="${ctxStaticFront}/js/layer/layer.js"></script>
</head>

<body>
					<div id="content"> 
						<div class="newsnav"> 
								<div class="center">
										<a href="${ctx}/">首页   >   医疗服务   >   确认订单</a>

								</div>
								


						</div>
						<div class="queren">
								<div class="block_name mtt"> 
							
								<span class="">Confirm the payment</span>
								<p class="">确认支付</p>
								<div class="brd"></div>
								</div>

								<div class="qrnews">
									<div class="center">
										<p >确认信息</p>
										<p class="on">选择付款</p>

									</div>
										

								</div>
								<div class="center">
									<div class="poin">
										<div class="l">
												<img src="${ctxStaticFront}/images/pion.png">

										</div>
										<div class="r">
												<p>您的订单编号：${productorder.pono}，
												 <c:if test="${yinlian eq 'yes' }">请在15分钟内完成支付</c:if>
												 <c:if test="${yinlian != 'yes' }">请尽快提交现场支付确认，否则号源将被释放。</c:if>	
												</p>
												<span>应付金额：¥${productorder.poallprice}元</span>

										</div>


									</div>
									<form action="${ctx}/userinfo/paysubmit"  id="payform" >
									<div class="pay">
										<p class="tips">您可以使用以下支付方式</p>
										<ul>	
										<c:if test="${yinlian eq 'yes' }">
												<li>
													<div class="wip" > 
														<input type="radio" id="ipp2" value="1" checked="checked" name="payType">
														<label for="ipp2"></label>
													</div>
													<div class="wipf" style="background-image:url(${ctxStaticFront}/images/yl.png)">
														<span></span>
														<p>银联<span style="color:red;">&nbsp;&nbsp;&nbsp;&nbsp;请使用IE浏览器进行支付</span></p>
													</div>
	
												</li>
										</c:if>
										<c:if test="${locale eq 'yes' }">
													<li>
														<div class="wip" > 
														     <c:if test="${yinlian eq 'yes' }">
															   <input type="radio" id="ipp3"  value="3" name="payType">
															</c:if>	
															 <c:if test="${yinlian != 'yes' }">
															   <input type="radio" id="ipp3"  checked="checked" value="3" name="payType">
															</c:if>	
															<label for="ipp3"></label>
														</div>
														<div class="wipf" style="background-image:url(${ctxStaticFront}/images/xc.png)">
															<span></span>
															<p>现场支付</p>
														</div>
													</li> 
											</c:if>
										</ul>
		
										<div class="qrtj">
												
											    <!-- <input id="payType" name="payType" type="hidden" value="1"> -->
											    <input id="poId" name="poId" type="hidden" value="${productorder.poid}">
												<input type="submit"  id="subs"  value="提交"  >
											
											</div>

									</div>
									</form>
								</div>
					
						</div>

				
		</div>

		
<script type="text/javascript"> 
			var oldc=$($(".sel ul li.on"));

			$(".sel ul li").click(function(){ 
						if(!$(this).hasClass("add")){ 
									oldc.removeClass("on")
									$(this).addClass("on")
									oldc=$(this)
									oldc=$(this);
									$("#payType").val(oldc.attr("id"));
						}
						
			})
			
			/*$("#payform").submit(function(){
				var payType=$("input[name=payType]:checked").val();
				if(payType=="1"){
					if (!!window.ActiveXObject || "ActiveXObject" in window){
						//使用的IE浏览器--
						return true;
					}else{
							layer.alert("请使用IE浏览器进行银联支付!");
							return false;
					}
				}
				layer.load();
				document.myform("subs").disabled='true'; 
			});*/

			

</script>

</body>
</html>
