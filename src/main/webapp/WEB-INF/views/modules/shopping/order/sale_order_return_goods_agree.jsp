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
    <script src="${ctxStatic}/sbShop/js/jquery.min.js"></script>
	<link rel="stylesheet" href="${ctxStatic}/sbShop/css/refund-agree.css">
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/bootstrap.min.css">
    <script src="${ctxStatic}/sbShop/js/jquery.min.js"></script>
	
	 <link rel="stylesheet" href="${ctxStatic}/sbShop/css/shipments-detail.css">
	<link rel="stylesheet" href="${ctxStatic}/sbShop/css/sale_css.css">
    <script>
    $(window.parent.document).find('.list-ul').find('ul').slideUp();
    $(window.parent.document).find('.list-ul').find('a').removeClass('active');
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
                }else if(a==1){
                    $('.li-1').hide();
                    $('.li-2').show();
                    $('.li-3').hide();
                }else if(a==2){
                	 $('.li-1').hide();
                     $('.li-2').hide();
                     $('.li-3').show();
                }
            });
        })
        
           	
  
    </script>
    <script type="text/javascript">
    $(function(){
    	var hhr=$('.submit-a').attr('href');
    	
    	 $('.consent-a').click(function(){
			 var act=1;
                if ('${aftersale.returnGoodsMethod}'!='2'&&!$('.li-1').is(':hidden')){
					var expressNumber=$("#expressNumber").val();
					var logisticsComCode=$("#logisticsComCode").val();
					var returnRemark=$("#kdreturnRemark").val();
					var returnStorePeople=$("#returnStorePeople").val();
					var returnStorePeoplePhone=$("#returnStorePeoplePhone").val();
					var returnGoodAddress=$("#returnGoodAddress").val();
					var consigneeName=$("#consigneeName").val();
					var consigneePhone=$("#consigneePhone").val();
					var zipCode=$("#zipCode").val();
					if(expressNumber==""){
						alert("请填写运单编号");
						act=0;
					}else if(logisticsComCode==""){
						alert("请选择快递公司");
						act=0;
					}else if(returnStorePeople==""){
						alert("请填写快递上门取件人名字");
						act=0;
					}else if(returnStorePeoplePhone==""){
						alert("请填写快递上门取件人联系电话");
						act=0;
					}else if(returnGoodAddress==""){
						alert("请填写商品返货地址");
						act=0;
					}else if(consigneeName==""){
						alert("请填写商品返货收货人姓名");
						act=0;
					}else if(consigneePhone==""){
						alert("请填写商品返货收货人电话");
						act=0;
					}else if(zipCode==""){
						alert("请填写商品返货邮编号码");
						act=0;
					}else{
					$('.submit-a').attr('href',encodeURI(encodeURI(hhr+'&returnGoodAddress='+returnGoodAddress+'&consigneeName='+consigneeName+'&consigneePhone='+consigneePhone+'&zipCode='+zipCode+'&returnStorePeople='+returnStorePeople+'&returnStorePeoplePhone='+returnStorePeoplePhone+'&expressNumber='+expressNumber+'&logisticsComCode='+logisticsComCode+'&returnRemark='+returnRemark+'&typeMethod=1')));
					}
                }else if ('${aftersale.returnGoodsMethod}'!='2'&&!$('.li-3').is(':hidden')){
					var store=$("#storeName").val();
					var storeId=$("#storeId").val();
					if(store==""){
						alert("请选择上门退货门店");
						act=0;
					}else if(storeId==""){
						alert("请选择上门退货门店");
						act=0;
					}else{
					$('.submit-a').attr('href',encodeURI(encodeURI(hhr+'&storeName='+storeName+'&storeId='+storeId+'&returnRemark='+returnRemark+'&typeMethod=2')));
					}
                }else{
					$('.submit-a').attr('href',encodeURI(encodeURI(hhr+'&typeMethod=3')));
				}
    	        if(act==1){
    	        	$('.consent').show();
    	        }
    	    });
    	    $('.consent-del').click(function(){
    	        $('.consent').hide();
    	        $('.submit-a').attr('href',hhr)
    	    });
    })
    </script>
</head>
<body>
    <div class="c-context">
      <ul class="nav-ul" style="margin:0px">
          <li><a href="${ctxsys}/Order/saleorderdata?orderId=${ebOrder.orderId}">订单资料</a></li>
          <li><a href="${ctxsys}/OrderLog/saleorderhis?orderId=${ebOrder.orderId}">历史分析</a></li>
          <li><a href="${ctxsys}/Order/saleorderdeliverylog?orderId=${ebOrder.orderId}">递送日志</a></li>
          <li><a class="active" href="${ctxsys}/Order/saleorderAftersalelist?orderId=${ebOrder.orderId}">订单退货处理</a></li>
          <li><a href="${ctxsys}/Order/saleorderdeliverymanager?orderId=${ebOrder.orderId}">递送管理</a></li>
          <li><a href="${ctxsys}/Order/saleorderendreply?orderId=${ebOrder.orderId}">最终批复</a></li>
      </ul>
    
	</div>
	<div class="order">
        <div class="crumbs-div">
            <span>您的位置：</span>
            <a href="${ctxsys}/Order/saleorderreturngoods?orderId=${ebOrder.orderId}&saleId=${saleId}"><font color="#18AEA1">订单退货详情</font></a>>
            <span>同意退款申请</span>
        </div>
        <div class="refuse">
            <p>同意退款申请</p>
			<ul style="display:inline-block;width:60%">

                <li><span>退货联系人：</span><span>${aftersale.returnGoodsPeople}</span></li>
                <li><span>退货联系人电话：</span><span>${aftersale.returnGoodsPeoplePhone}</span></li>
				<li><span>退货方式：</span><span>
				<c:if test="${empty aftersale.returnGoodsMethod}">需指派上门取件</c:if>
				<c:if test="${aftersale.returnGoodsMethod==1}">快递</c:if>
                		<c:if test="${aftersale.returnGoodsMethod==2}">送至自提点</c:if>
						<c:if test="${aftersale.returnGoodsMethod==3}">门店上门取件</c:if>
				</span></li>
				<c:if test="${aftersale.returnGoodsMethod==2}">
                <li><span>门店名字：</span><span>${aftersale.storeName}</span></li>
                <li><span>门店地址：</span>
	                <span>
		               ${aftersale.storeAddr}
	                </span>
                </li>
                <li><span>门店联系电话：</span>
                ${aftersale.storePhone}
                </li>
				</c:if>
				<c:if test="${aftersale.returnGoodsMethod==3}">
                <li>
                	<span>上门取贷地址：</span>
                	<span>
                		${aftersale.address}
                	</span>
                </li>
				</c:if>
            </ul>
		<c:if test="${aftersale.returnGoodsMethod!=2}">	
        
        <div class="wu-liu" style="margin-top:10px">
		<font color="red" height="20px">》》*请选择上门取件方式</font>
            <ul class="ul-tab">
                <li class="active">快递上门</li>
                <li style="display:none">无需物流</li>
                <li>门店上门</li>
            </ul>
            <div class="div-tab">
                <div class="li-1">
                    <ul>
                        <li>物流公司：
                            <select name="logisticsComCode" id="logisticsComCode">
                            <c:forEach items="${dicts}" var="dict">
                                <option value="${dict.id}">${dict.label}</option>
                            </c:forEach>
                            </select>
                        </li>
                        <li><input id="orderId" name="orderId" type="hidden" style="display:none;" value="${ebOrder.orderId}"/>
                        	运单编号： <input id="expressNumber" name="expressNumber" type="text">
                        </li>
                        <li>
                        	快递员： <input id="returnStorePeople" name="returnStorePeople" type="text">
                        </li>
                        <li>
                        	快递员电话： <input id="returnStorePeoplePhone" name="returnStorePeoplePhone" type="text">
                        </li>
                        <li>
                        	商品返货地址： <input id="returnGoodAddress" name="returnGoodAddress" type="text">
                        </li>
                        <li>
                        	商品返货收货人姓名 ： <input id="consigneeName" name="consigneeName" type="text">
                        </li>
                        <li>
                        	商品返货收货人电话： <input id="consigneePhone" name="consigneePhone" type="text">
                        </li>
                        <li>
                        	商品返货邮编号码 ： <input id="zipCode" name="zipCode" type="text">
                        </li>
                     <div class="control-group" style="margin-top:10px" >
			        <label class="control-label">备注： </label>
			       <div class="controls" style="margin-top:2px">
			       <textarea id="kdReturnRemark" name="kdReturnRemark" class="input" 
			       style="resize: none;width: 300px;border-width: 1px;border-style: solid;border-color: rgb(220, 220, 220);border-image: initial;
			       border-radius: 3px;outline: none;padding: 5px 10px;" maxlength="150" placeholder="请输入150字以内....."></textarea>
		         	</div> 
		          </div>  
                    </ul>
                </div>
				 
                <div class="li-2">
                    <ul>
                        <li>
                            <div class="radio1">
                                <input checked type="radio">
                       
                            </div>该订单由买家自提
                        </li>
                        <li>请仅在买家同意自提的情况下选择此项。</li>
                    </ul>
                </div>
                
                <input id="orderId" name="orderId" type="hidden" style="display:none;" value="${ebOrder.orderId}"/>
                  <div class="li-3">
                    <div class="control-group">
			        <label class="control-label">选择门店： </label>
			       <div class="controls" style="margin-top:2px">
                   <tags:treeselect id="store" name="assignedStoreId" value="" labelName="" labelValue=""
					title="门店" url="${ctxsys}/Order/treeStoreData1"  />  
		         	</div>
		          </div>  
                   <div class="control-group" style="margin-top:10px" >
			        <label class="control-label">备注： </label>
			       <div class="controls" style="margin-top:2px">
			       <textarea id="returnRemark" name="returnRemark" class="input" 
			       style="resize: none;width: 300px;border-width: 1px;border-style: solid;border-color: rgb(220, 220, 220);border-image: initial;
			       border-radius: 3px;outline: none;padding: 5px 10px;" maxlength="150" placeholder="请输入150字以内....."></textarea>
		         	</div> 
		          </div>  
                </div>
            </div>
        </div>
		</c:if>
            <div class="refuse-btn">
                <a class="consent-a btn btn-primary" href="javascript:;">同意申请</a>
            </div>
        </div>
    </div>
    <div class="consent">
        <div class="consent-box">
            <p>提示<img class="consent-del" src="${ctxStatic}/sbShop/images/xxx-rzt.png" alt=""></p>
            <div class="consent-div">
               <span>同意退款？退款金额¥<b>${aftersale.deposit}</b>元</span>
               <br>
               <a class="submit-a" href="${ctxsys}/Order/ReturnManagementAffirm?saleId=${aftersale.saleId}&orderId=${ebOrder.orderId}">确定</a>
               <a class="consent-del" href="javascript:;">取消</a>
            </div>
        </div>
    </div>
</body>
</html>