<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>菜单管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});
			getProvince();
		});
		//获取省
		function getProvince(){
		var url="${ctxsys}/EbDelivery/getpList";
		$.getJSON(url,function(data){callbackfunProvince(data);});
		}
		function callbackfunProvince(jsonObj){
		var provinces=jsonObj.provinces;
		var str="<option value=''>-选择省份-</option>"; 
		var a=$("#provinceId").val();
		if(provinces!=undefined){
			$.each(provinces,function(i,pro){
			if(a==pro.provinceId){
			str+="<option  value='"+pro.provinceId+"' selected='selected'>"+pro.province+"</option>";
			onchangeProvince(a);
			}else{
			str+="<option  value='"+pro.provinceId+"'>"+pro.province+"</option>";
			}
			});
		}
		$("#provinceId").html(str);
		}
		//获取市
		function onchangeProvince(father){
		var url = "${ctxsys}/EbDelivery/getCList";
		  $.post(url,{father:father},function(data){callbackfunCity(data);});
    	}
    	function callbackfunCity(jsonObj){
			var cityList = jsonObj.citys;
			var str="<option value=''>-选择城市-</option>"; 
			var c=$("#cityid").val();
			if(cityList!=undefined){
				$.each(cityList,function(i,city){
				if(c==city.cityId){
				str+="<option value='"+city.cityId+"' selected='selected'>"+city.city+"</option>" ;
				onchangeProvince2(c);
			    }else{
			    str+="<option value='"+city.cityId+"'>"+city.city+"</option>" ;
			    }
				 });
		    	}
				$("#cityid").html(str); 
     }
     //地区
	     function onchangeProvince2(father){
		 var url = "${ctxsys}/EbDelivery/getAList";
		 $.getJSON(url,{father:father},function(data){callbackfunZone(data);});
		}
		function callbackfunZone(jsonObj){
		var areaList = jsonObj.Areas;
		var str="<option value=''>-选择区/县-</option>"; 
		var a=$("#areaId").val();
		if(areaList!=undefined){
			$.each(areaList,function(num,area){
			if(a==area.areaId){
			    str+="<option value='"+area.areaId+"' selected='selected'>"+area.area+"</option>" ;
			    }else{
			    str+="<option value='"+area.areaId+"'>"+area.area+"</option>" ;
			    }
			});
		}
		$("#areaId").html(str); 
		}
		
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
	<shiro:hasPermission name="merchandise:delivery:view"><li ><a href="${ctxsys}/EbDelivery">配送列表</a></li></shiro:hasPermission>
	    <li class="active"><a href="${ctxsys}/EbDelivery/form?id=${ebDelivery.deliveryId}">配送<shiro:hasPermission name="merchandise:delivery:edit">${not empty ebDelivery.deliveryId?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="merchandise:delivery:edit">查看</shiro:lacksPermission></a></li>
</ul>
	
	<form:form id="inputForm" modelAttribute="ebDelivery" action="${ctxsys}/EbDelivery/save" method="post" class="form-horizontal">
		<form:hidden path="deliveryId"/>
		<tags:message content="${message}"/>
		<div class="control-group">
			<label class="control-label">快递名称:</label>
			<div class="controls">
              <form:input path="deliveryName" htmlEscape="false" maxlength="50" required="required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">快递英文名称:</label>
			<div class="controls">
              <form:input path="description" htmlEscape="false" maxlength="50" required="required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="name">配送地址对应的首重价格:</label>
			<div class="controls">
				<form:input path="firstprice" htmlEscape="false" maxlength="50" onkeyup="value=value.replace(/[^\d{1,}\.\d{1,}|\d{1,}]/g,'')"/>
				<span class="help-inline"><font color="">*只能输入数字</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="href">配送地区对应的续重价格:</label>
			<div class="controls">
				<form:input path="secondprice" htmlEscape="false" maxlength="50" class="required" onkeyup="value=value.replace(/[^\d{1,}\.\d{1,}|\d{1,}]/g,'')"/>
				<span class="help-inline"><font color="">*只能输入数字</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="target">配送类型 :</label>
			<div class="controls">
			<form:select path="type"  htmlEscape="false" maxlength="50" style="width: 100px;" class="required">
		                       <option value="">请选择支付</option>
								<form:option value="0">先付款后发货</form:option>
								<form:option value="1">先发货后付款</form:option>
								<form:option value="2">自提点</form:option>
               			</form:select> 
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="icon">首重重量(克):</label>
			<div class="controls">
				<form:input path="firstWeight" htmlEscape="false" maxlength="50" onkeyup="value=value.replace(/[^\d{1,}\.\d{1,}|\d{1,}]/g,'')"/>
				<span class="help-inline"><font color="">*只能输入数字</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="sort">续重重量(克):</label>
			<div class="controls">
				<form:input path="secondWeight" htmlEscape="false" maxlength="50" onkeyup="value=value.replace(/[^\d{1,}\.\d{1,}|\d{1,}]/g,'')"/>
				<span class="help-inline"><font color="">*只能输入数字</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="isShow">首重价格:</label>
			<div class="controls">
				<form:input path="firstPrice" htmlEscape="false" maxlength="50" onkeyup="value=value.replace(/[^\d{1,}\.\d{1,}|\d{1,}]/g,'')"/>
				<span class="help-inline"><font color="">*只能输入数字</font> </span>
				</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="permission">续重价格:</label>
			<div class="controls">
				<form:input path="secondPrice" htmlEscape="false" maxlength="50" onkeyup="value=value.replace(/[^\d{1,}\.\d{1,}|\d{1,}]/g,'')"/>
				<span class="help-inline"><font color="">*只能输入数字</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="permission">开启状态 :</label>
			<div class="controls">
			<form:select path="status"  htmlEscape="false" maxlength="50" style="width: 100px;" required="required">
		                       <option value="">请选择</option>
								<form:option value="0"> 未开启</form:option>
								<form:option value="1">开启</form:option>
								<form:option value="9">删除</form:option>
               			</form:select> 
				<span class="help-inline"></span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="permission">排序 :</label>
			<div class="controls">
				<form:input path="sort" htmlEscape="false" maxlength="50" class="required"/>
				<span class="help-inline"><font color="">*只能输入数字</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="permission">是否支持物流保价 :</label>
			<div class="controls">
			<form:select path="isSavePrice"  htmlEscape="false" maxlength="50" style="width: 100px;" required="required">
		                       <option value="">请选择</option>
								<form:option value="1">支持保价</form:option>
								<form:option value="0">不支持保价</form:option>
               			</form:select> 
				<span class="help-inline"></span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="permission">保价费率 :</label>
			<div class="controls">
				<form:input path="saveRate" htmlEscape="false" maxlength="100" onkeyup="value=value.replace(/[^\d{1,}\.\d{1,}|\d{1,}]/g,'')"/>
				<span class="help-inline"><font color="">*只能输入数字</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="permission">最低保价:</label>
			<div class="controls">
				<form:input path="lowPrice" htmlEscape="false" maxlength="100" onkeyup="value=value.replace(/[^\d{1,}\.\d{1,}|\d{1,}]/g,'')"/>
				<span class="help-inline"><font color="">*只能输入数字</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="permission">费用类型:</label>
			<div class="controls">
			<form:select path="priceType"  htmlEscape="false" maxlength="100" required="required">
		                       <option value="">请选择</option>
								<form:option value="0">统一设置</form:option>
								<form:option value="1">指定地区费用 </form:option>
               			</form:select> 
				<span class="help-inline"></span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="permission">用默认费用:</label>
			<div class="controls">
			<form:select path="openDefault"  htmlEscape="false" maxlength="100"  required="required">
		                       <option value="">请选择</option>
								<form:option value="0">不启用</form:option>
								<form:option value="1">启用  </form:option>
               			</form:select> 
				<span class="help-inline"></span>
			</div>
		</div>
		<%-- <c:if test="${ empty ebDelivery.deliveryId}"> --%>
			<div class="control-group">
			<label class="control-label" for="permission">省份:</label>
			<div class="controls">
			<form:select path="province" id="provinceId" value="${ebDelivery.province}" htmlEscape="false" maxlength="100"  required="required" onchange="onchangeProvince(this.value)">
               			<option value="${ebDelivery.province}">${ebDelivery.province}</option>
               			</form:select> 
				<span class="help-inline"></span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="permission">市:</label>
			<div class="controls">
			<form:select path="city" id="cityid" value="${ebDelivery.city}"  maxlength="100"  required="required" onchange="onchangeProvince2(this.value)">
			<option value="${ebDelivery.city}">${ebDelivery.city}</option>
               			</form:select> 
				<span class="help-inline"></span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="permission">区域:</label>
			<div class="controls">
			<form:select path="area" id="areaId" value="${ebDelivery.area}"  maxlength="100"  required="required">
			<option value="${ebDelivery.area}">${ebDelivery.area}</option>
               			</form:select> 
				<span class="help-inline"></span>
			</div>
		</div>
		<%-- </c:if> --%>
		<div class="form-actions">
			<shiro:hasPermission name="merchandise:delivery:edit">
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;
			</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>