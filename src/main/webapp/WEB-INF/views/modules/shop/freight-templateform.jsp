<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="Description" content="${fns:getProjectName()},运费模板"/>
	<meta name="Keywords" content="${fns:getProjectName()},运费模板"/>
	<meta name="robots" content="noarchive">
    <title>${empty form?'新增':'修改'}运费模板</title>
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/freight-template.css">
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/bootstrap.min.css">
    <script src="${ctxStatic}/sbShop/js/jquery.min.js"></script>
    <script src="${ctxStatic}/sbShop/js/base_form.js"></script>
    <script src="${ctxStatic}/sbShop/js/freight-template.js"></script>
    <script>
    $(window.parent.document).find('.list-ul').find('ul').slideUp();
    $(window.parent.document).find('.list-ul').find('a').removeClass('active');
    </script>
	<script type="text/javascript">
	function lis(){
		var tul=$('.add-city ul');
		var ae=[];
		for(i=1;i<tul.length;i++){
			var arrq=[];
			for(n=0;n<$(tul[i]).find('input[type=hidden]').length;n++){
				arrq.push($($(tul[i]).find('input[type=hidden]')[n]).val());
			}
			var city=$(tul[i]).children('li:nth-child(1)').clone().children().remove().end().text();
			arrq.push(city);
			for(j=0;j<$(tul[i]).find('input[type=text]').length;j++){
				arrq.push($($(tul[i]).find('input[type=text]')[j]).val())
			}
			ae.push(arrq);
		}
		return ae;
	}
	function edit(){
		var pmShopFreightTemId=$("#pmShopFreightTemId").val();
		var templateName=$("#templateName").val();
		$("#templateName").css("border", "1px solid #a9a9a9");
		if(templateName==""){
			$("#templateName").css("border", "1px solid red");
			alert("请填写模板名称！");
			return false;
		}
		var checkedisFullFree=$("input[name='isFullFree']:checkbox").is(':checked');
		if(checkedisFullFree==true){
			var isFullFree=1;
		}else{
			var isFullFree=0;
		}
		var fullNum=$("#fullNum").val();
		$("#fullNum").css("border", "1px solid #a9a9a9");
		if(isFullFree==1){
			if(fullNum==""){
				$("#fullNum").css("border", "1px solid red");
				alert("请填写满X件包邮！");
				return false;
			}
		}
		var checkedisFullFree=$("input[name='areaRestricted']:checkbox").is(':checked');
		if(checkedisFullFree==true){
			var areaRestricted=1;
		}else{
			var areaRestricted=0;
		}
		var pmShopShippingMethodId=$("#pmShopShippingMethodId").val();
		var shippingMethod= $('input:radio[name="shippingMethod"]:checked').val();
		if(shippingMethod==""){
			alert("请选择运送方式！");
			return false;
		}
		var firstArticleKg=$("#firstArticleKg").val();
		var firstCharge=$("#firstCharge").val();
		var continueArticleKg=$("#continueArticleKg").val();
		var continueCharge=$("#continueCharge").val();
		$("#firstArticleKg").css("border", "1px solid #a9a9a9");
		$("#firstCharge").css("border", "1px solid #a9a9a9");
		$("#continueArticleKg").css("border", "1px solid #a9a9a9");
		$("#continueCharge").css("border", "1px solid #a9a9a9");
		if(firstArticleKg==""){
			$("#firstArticleKg").css("border", "1px solid red");
			alert("请填写首件/首重！");
			return false;
		}else if(firstCharge==""){
			$("#firstCharge").css("border", "1px solid red");
			alert("请填写首费！");
			return false;
		}else if(continueArticleKg==""){
			$("#continueArticleKg").css("border", "1px solid red");
			alert("请填写续件/续重！");
			return false;
		}else if(continueCharge==""){
			$("#continueCharge").css("border", "1px solid red");
			alert("请填写续费！");
			return false;
		}
		var pmSSM=lis();
	    $.ajax({
		    	type: "POST",
		      	//contentType:"application/x-www-form-urlencoded;charset=UTF-8",
		    	url:"${ctxweb}/shop/pmShopFreightTem/edit",
		       	//datatype:"json",
		       	data:{
		       		pmShopFreightTemId:pmShopFreightTemId,
		       		templateName:templateName,
		       		isFullFree:isFullFree,
		       		fullNum:fullNum,
		       		areaRestricted:areaRestricted,
		       		pmShopShippingMethodId:pmShopShippingMethodId,
		       		shippingMethod:shippingMethod,
		       		firstArticleKg:firstArticleKg,
		       		firstCharge:firstCharge,
		       		continueArticleKg:continueArticleKg,
		       		continueCharge:continueCharge,
		       		pmSSM:JSON.stringify(pmSSM)
		       	},
		       	success:function(data){
			       	if(data.code=='00'){
			       	 location.href="${ctxweb}/shop/pmShopFreightTem/pmShopFreightTemList";
			       	}else{
			         alert(data.msg);
			       	}
		       		
		        }
		});
	}
	</script> 
</head>
<body>
    <div class="templatae">
        <!--编辑运费模板-->
        <form action="">
        	<input type="hidden" id="pmShopFreightTemId" value="${pmShopFreightTem.id}"/>
            <div class="templatae-add">
                <p>${empty form?'新增':'修改'}运费模板</p>
                <ul class="add-mc">
                    <li><b>*</b>模板名称：</li>
                    <li>
                        <input id="templateName" name="templateName" value="${pmShopFreightTem.templateName}" class="input" type="text">
                    </li>
                </ul>
                <ul class="add-sz">
                    <li>&nbsp;&nbsp;包邮设置：</li>
                    <li class="checkbox">
                    	<c:choose>
        					<c:when test="${pmShopFreightTem.isFullFree==1}">
        						<input name="isFullFree" type="checkbox" checked>
        						<label></label>
		                        <span>满</span>
		                        <input id="fullNum" name="fullNum" value="${pmShopFreightTem.fullNum}" class="num" type="text">
		                        <span>件包邮</span>
        					</c:when>
        					<c:when test="${pmShopFreightTem.isFullFree==0}">
        						<input name="isFullFree" type="checkbox">
        						<label></label>
		                        <span>满</span>
		                        <input id="fullNum" name="fullNum" value="" class="num" type="text">
		                        <span>件包邮</span>
        					</c:when>
        					<c:otherwise>
        						<input name="isFullFree" type="checkbox">
        						<label></label>
		                        <span>满</span>
		                        <input id="fullNum" name="fullNum" value="" class="num" type="text">
		                        <span>件包邮</span>
        					</c:otherwise>
        				</c:choose>
                       
                    </li>
                </ul>
                <ul class="add-xs">
                    <li>&nbsp;&nbsp;区域限售：</li>
                    <li class="checkbox">
                    <c:choose>
        				<c:when test="${pmShopFreightTem.areaRestricted==0}">
        					<input name="areaRestricted" type="checkbox">
        					<label><i></i>仅限运送区区域限售</label>
                        	<span>勾选后商品只能在设置了运费的指定地区城市销售</span>
        				</c:when>
        				<c:when test="${pmShopFreightTem.areaRestricted==1}">
        					<input name="areaRestricted" type="checkbox" checked>
        					<label><i></i>仅限运送区区域限售</label>
                        	<span>勾选后商品只能在设置了运费的指定地区城市销售</span>
        				</c:when>
        				<c:otherwise>
        					<input name="areaRestricted" type="checkbox">
        					<label><i></i>仅限运送区区域限售</label>
                        	<span>勾选后商品只能在设置了运费的指定地区城市销售</span>
        				</c:otherwise>
        			</c:choose>
                    </li>
                </ul>
                <input type="hidden" id="pmShopShippingMethodId" value="${pmShopShippingMethod.id}"/>
                <ul class="add-fs">
                    <li><b>*</b>运送方式：</li>
                    <li>
                        <span>除指定区域外，其余地区的运费采用“默认运费”</span><span>（运费必须是数字且最多保留两位小数）</span><br>
                        <c:if test="${empty pmShopShippingMethod||pmShopShippingMethod==null}">
                        	<div class="radio">
				        		<input name="shippingMethod" type="radio" value="1" checked disabled>
		                    	<label><i></i></label>快递
		                    </div>
		                    <%-- <div class="radio">
		                         <input name="shippingMethod" type="radio" value="2">
		                         <label><i></i></label>EMS
		                    </div>	
		                    <div class="radio">
		                         <input name="shippingMethod" type="radio" value="3">
		                         <label><i></i></label>平邮
		                    </div> --%>
		                </c:if>
                        <c:if test="${!empty pmShopShippingMethod||pmShopShippingMethod!=null}">
                        <c:choose>
			        		<c:when test="${pmShopShippingMethod.shippingMethod==1}">
		                        <div class="radio">
				        			<input name="shippingMethod" type="radio" value="1" checked disabled>
		                            <label><i></i></label>快递
		                        </div>
		                        <%-- <div class="radio">
		                         	<input name="shippingMethod" type="radio" value="2">
		                            <label><i></i></label>EMS
		                        </div>	
		                        <div class="radio">
		                            <input name="shippingMethod" type="radio" value="3">
		                            <label><i></i></label>平邮
		                        </div> --%>
			        		</c:when>
			        		<%-- <c:when test="${pmShopShippingMethod.shippingMethod==2}">
		                        <div class="radio">
				        			<input name="shippingMethod" type="radio" value="1">
		                            <label><i></i></label>快递
		                        </div>
		                        <div class="radio">
		                         	<input name="shippingMethod" type="radio" value="2" checked>
		                            <label><i></i></label>EMS
		                        </div>	
		                        <div class="radio">
		                            <input name="shippingMethod" type="radio" value="3">
		                            <label><i></i></label>平邮
		                        </div>
			        		</c:when>
			        		<c:when test="${pmShopShippingMethod.shippingMethod==3}">
		                        <div class="radio">
				        			<input name="shippingMethod" type="radio" value="1">
		                            <label><i></i></label>快递
		                        </div>
		                        <div class="radio">
		                         	<input name="shippingMethod" type="radio" value="2">
		                            <label><i></i></label>EMS
		                        </div>	
		                        <div class="radio">
		                            <input name="shippingMethod" type="radio" value="3" checked>
		                            <label><i></i></label>平邮
		                        </div>
			        		</c:when> --%>
			        	</c:choose>
			        	</c:if>
                        <div class="fs-box">
                            <div class="box-moren"> 默认运费：
                                <input id="firstArticleKg" value="${pmShopShippingMethod.firstArticleKg}" class="input num" type="text">件内，
                                <input id="firstCharge" value="${pmShopShippingMethod.firstCharge}" class="input num" type="text">元，每增加
                                <input id="continueArticleKg" value="${pmShopShippingMethod.continueArticleKg}" class="input num" type="text">件，增加运费
                                <input id="continueCharge" value="${pmShopShippingMethod.continueCharge}" class="input num" type="text">元
                            </div>
                            <!--增加指定城市-->
                            <div class="add-city">
                                <ul class="city-one">
                                    <li>运送到</li>
                                    <li>首件（件）</li>
                                    <li>首费（元）</li>
                                    <li>续件（件）</li>
                                    <li>续费（元）</li>
                                    <li>操作</li>
                                </ul>
                            <c:if test="${!empty pmShopShippingMethods||pmShopShippingMethods!=null}">
								<c:forEach items="${pmShopShippingMethods}" var="pmShopShippingMethodlist">
								<ul>
                                <li title="${pmShopShippingMethodlist.distrctName}"><input id="pmShopShippingMethodid" type="hidden" value="${pmShopShippingMethodlist.id}"><input type="hidden" id="distrctCode" value="${pmShopShippingMethodlist.distrctCode}">${pmShopShippingMethodlist.distrctName}<a class="bianji" href="javascript:;">编辑</a></li>
	                                <li><input value="${pmShopShippingMethodlist.firstArticleKg}" type="text"></li>
	                                <li><input value="${pmShopShippingMethodlist.firstCharge}" type="text"></li>
	                                <li><input value="${pmShopShippingMethodlist.continueArticleKg}" type="text"></li>
	                                <li><input value="${pmShopShippingMethodlist.continueCharge}" type="text"></li>
                                <li><a class="city-del" path="${ctxweb}" ssid="${pmShopShippingMethodlist.id}" href="javascript:;">删除</a></li>
                            	</ul>
								</c:forEach>
							</c:if>
                            </div>
                            <a class="city-a" href="javascript:;">为指定地区城市添加运费</a>
                        </div>

                    </li>
                </ul>
                <div class="templatae-add-a">
                    <a class="temp2 btn btn-primary" onclick="edit()" href="javascript:;">保存并返回</a>
                    <a class="temp3 btn btn-default" onclick="history.go(-1)" href="javascript:;">取消</a>
                </div>
            </div>
        </form>
    </div>
    <!--地区选择框-->
    <div class="region">
        <div class="region-box">
            <p>选择区域 <span></span></p>
            <div class="region-div">
                <!--一个ul一个地区-->
                <c:forEach items="${pmSysDistrictList}" var="pmSysDistrictList0">
                <ul class="region-ul">
                    <li class="checkbox">
                        <input class="input-all" type="checkbox">
                        <label districtid="${pmSysDistrictList0.id}">${pmSysDistrictList0.districtName}</label>
                    </li>
	                <li>
                    	<c:forEach items="${pmSysDistrictList0.pmSysDistricts}" var="pmSysDistrictList1">
	                        <div>
	                        <c:if test="${empty pmSysDistrictList1.pmSysDistricts||pmSysDistrictList1.pmSysDistricts==null}">
	                        <div class="checkbox">
	                        	<input type="checkbox">
	                            <label districtid="${pmSysDistrictList1.id}" style="background:none"><i></i>${pmSysDistrictList1.districtName}</label>
	                            <b></b>
	                        </div>
	                        </c:if>
	                        <c:if test="${!empty pmSysDistrictList1.pmSysDistricts||pmSysDistrictList1.pmSysDistricts!=null}">
	                        <div class="checkbox">
	                        	<input type="checkbox">
	                            <label districtid="${pmSysDistrictList1.id}">${pmSysDistrictList1.districtName}</label>
	                            <b></b>
	                        </div>
		                    <ul class="two-list">
		                    	<c:forEach items="${pmSysDistrictList1.pmSysDistricts}" var="pmSysDistrictList2">
				                	<li class="checkbox">
					                	<input type="checkbox">
					                    	<label districtid="${pmSysDistrictList2.id}">${pmSysDistrictList2.districtName}</label>
				                    </li>
		                        </c:forEach>
			                    <li><a href="javascript:;">关闭</a></li>
		                    </ul>
		                    </c:if>
	                        </div>
                    	</c:forEach>
	               </li>
                </ul>
              </c:forEach>
            </div>
            <div class="region-btn">
                <a class="region-btn-bc btn btn-primary" href="javascript:;">保存</a>
                <a class="region-btn-qx btn btn-default" href="javascript:;">取消</a>
            </div>
        </div>
    </div>
</body>
</html>