<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<jsp:useBean id="ebCertificate" class="com.jq.support.model.certificate.EbCertificate" scope="request"/>
<html>  
<head> 
	<title>优惠券添加</title>
	<meta name="decorator" content="default"/>
	<link href="${ctxStatic}/jquery-jbox/2.3/Skins/Default/jbox.css?v=1" type="text/css" rel="stylesheet" />
	<script src="${ctxStatic}/jquery-jbox/2.3/jquery.jBox-2.3.js?v=1" type="text/javascript"></script>
	<link href="${ctxStatic}/supplyshop/layui/css/modules/layer/default/layer.css?v=1" type="text/css" rel="stylesheet" />
	<script src="${ctxStatic}/supplyshop/layui/lay/modules/layer.js?v=1" type="text/javascript"></script>
	 <script type="text/javascript">
	  $(function(){
		  $("#btnSubmit").click(function(){
    	      if($("#certificateName").val()==""){
    	    	  $.jBox.error("请输入优惠券名称");  
    	    	  return false;
    	      }
    	      if($("#type").val()==""){
    	    	  $.jBox.error("请选择类型");  
    	    	  return false;
    	      }
    	    if($("#provinceOutFullFreight").val()==""&&$("#provinceOutFullFreight").val()<0){
    	    	$.jBox.error("满减金额不能为空或者小于0");
				return false;
    	    }
    	      if($("#amount").val()==""){
    	    	  $.jBox.error("请输入金额/折扣");  
    	    	  return false;
    	      }
			  if(($("#type").val()==3||$("#type").val()==4)&&($("#amount").val()<0||$("#amount").val()>=10)){
				  $.jBox.error("折扣不得大于等于10或小于0");
				  return false;
			  }
    	      if($("#productType").val()==""){
    	    	  $.jBox.error("请选择产品类型适用范围");  
    	    	  return false;
    	      }
    	      if($("#productType").val()==""){
    	    	  $.jBox.error("请选择产品类型适用范围");  
    	    	  return false;
    	      }
              if($("#shopType").val()==""){
                  $.jBox.error("请选择门店范围");
                  return false;
              }
    	      if($("#startDate").val()==""){
    	    	  $.jBox.error("请输入有效开始日期");  
    	    	  return false;
    	      }
    	      if($("#endDate").val()==""){
    	    	  $.jBox.error("请输入有效结束日期");  
    	    	  return false;
    	      }
    	     
    	      if($("#sendtime").val()==""){
    	    	  $.jBox.error("请输入发起时间");  
    	    	  return false;
    	      }
    	      if($('input[name=enabledSys]:checked').val()=="1"){
      	    	   if($("#enabledSysRemark").val().trim().length==0){
        	    		  $.jBox.error("禁用原因不能为空");  
        	    		 return false;
        	    	   } 
        	    	   
        	      }
    	    	  var cid=$("#menuId").val();
    	    	  if(cid!=""){
    	    		  cid=cid.substring(0,cid.length-1);
    	    		  $("#productTypeId").val(cid);
    	    	  }
    	    	 
    	    	 $("#searchForm").submit();
    	     
		  });
			
		
	
	  });
	  function enablesyss(){
		  var enabled= $('input[name=enabledSys]:checked').val();
	   if(enabled=="0"){
			  $("#enabledSysRemark").val("");
			  $("#enabledReason").css("display","none");
		  }  
	   if(enabled=="1"){
			  $("#enabledReason").css("display","block");
		  }  
	  }

	  //清空选中的门店id
	  function clearShopId(){
	      $("#shopTypeId").val("");
	  }

	   function checkScope(){
			   if($("#productType").val()=="1"){
				  // $("#porcId").css("display","block");
				    layer.open({
				        type: 2,
				        title: '商品列表',
				        shadeClose: true,
				        shade: false,
				        maxmin: true, //开启最大化最小化按钮
				        area: ['880px', '450px'],
				        content: '${ctxsys}/Product/chooseProducts',
				        btn: ['确定', '关闭'],
				        yes: function(index, layero){ //或者使用btn1
				        	content = layero.find("iframe")[0].contentWindow.$('#chooseIds').val();
				 	   if(content==""){
				 		  layer.msg("请先选中一行");
				 		  $("#productTypeId").val(content);
					   }else{
						   $("#productTypeId").val(content);
						   layer.close(index);
					   }
			        
				        }
				      });
				    $("#cids").css("display","none");   
			   } if($("#productType").val()=="2"){
				  $("#cids").css("display","block");   
				  $("#productTypeId").val("");
				  $("#porcId").css("display","none");
			   } else{
				   $("#cids").css("display","none");   
				   $("#productTypeId").val("");
			   }
			 
		  
	   }

      function checkScope2(){
          if($("#shopType").val()=="1"){
              // $("#porcId").css("display","block");
              layer.open({
                  type: 2,
                  title: '门店列表',
                  shadeClose: true,
                  shade: false,
                  maxmin: true, //开启最大化最小化按钮
                  area: ['880px', '450px'],
                  content: '${ctxsys}/Product/chooseShops?shopIds='+$("#shopTypeId").val(),
                  btn: ['确定', '关闭'],
                  yes: function(index, layero){ //或者使用btn1
                      content = layero.find("iframe")[0].contentWindow.$('#chooseIds').val();
                      if(content==""){
                          layer.msg("请先选中一行");
                          $("#shopTypeId").val(content);
                      }else{
                          $("#shopTypeId").val(content);
                          layer.close(index);
                      }

                  }
              });
              // $("#cids").css("display","none");
          } if($("#shopType").val()=="2"){
              // $("#cids").css("display","block");
              // $("#shopTypeId").val("");
              // $("#porcId").css("display","none");
          } else{
              // $("#cids").css("display","none");
              // $("#shopTypeId").val("");
          }


      }
	 </script>
	<script>
		$(function(){
			$("body").on('change', "#type", function(){
				typechange();
			});
			typechange();
		});
	function typechange() {
		var type=($("#type").val());
		if(type=='1'){
			//满减券
			$('#cash_coupon_amount_div').css("display","none");
		}else if(type=='2'){
			//现金券
			$('#cash_coupon_amount_div').css("display","none");
		}else if(type=='3'){
			//折扣券
			$('#cash_coupon_amount_div').css("display","none");
		}else if(type=='4'){
			//代金券
			$('#cash_coupon_amount_div').css("display","block");
		}else{
			$('#cash_coupon_amount_div').css("display","none");
		}
	}
	</script>
</head>
<body style="height: 100%">
    <c:if test="${not empty msg }">
     <script type="text/javascript">
	   $(function(){
		   $.jBox.success("${msg}","信息提示");
		   if("${type}"=="edit"){
			   setTimeout(function(){
					  location.href="${ctxsys}/Product/certificatelist";
				  },500);
		   }
	   })
	</script> 
    </c:if>
    <input type="hidden" id="flag" value="${flag}"/>
	 <ul class="nav nav-tabs">
	  <li ><a href="javascript:;">优惠券${flag=='edit'?'修改':'添加'}</a></li> 
 	</ul><br/> 
 	   <form:form id="searchForm" modelAttribute="ebCertificate" action="${ctxsys}/Product/addcertificateJson" method="post" class="form-horizontal">
 		<div class="control-group">
			<label class="control-label">优惠券名称:</label>
			<div class="controls" >
			  <form:input path="certificateName" htmlEscape="false" maxlength="50" class="input-medium"   placeholder="请输入优惠券名称"/>
			</div>
		</div>
		  <form:hidden path="certificateId" value="${ebCertificate.certificateId}"/>
		<div class="control-group">
			<label class="control-label">类型:</label>
			<div class="controls">
        		<form:select path="type" class="input-medium">
			      <form:option value="">请选择</form:option>
			      <form:option value="1">满减券</form:option>
			      <form:option value="2">现金券</form:option>
			       <form:option value="3">折扣券</form:option>
			       <form:option value="4">代金券</form:option>
			    </form:select>
			</div>
		</div> 
		<div class="control-group" id="provinceOutFullFreight_div">
			<label class="control-label">满减金额:</label>
			<div class="controls">
			 <form:input path="provinceOutFullFreight" htmlEscape="false" maxlength="50" class="input-medium"   placeholder="请输入满减金额" onkeyup="value=value.replace(/[^\d{1,}\.\d{1,}|\d{1,}]/g,'')"/>
				<b>(要求满多少金额才能使用该优惠券)</b>
			</div>
		</div>
		 <div class="control-group" id="cash_coupon_amount_div">
			   <label class="control-label">代金券总金额:</label>
			   <div class="controls">
				   <form:input path="cashCouponAmount" htmlEscape="false" maxlength="50" class="input-medium"   placeholder="请输入代金券总金额" onkeyup="value=value.replace(/[^\d{1,}\.\d{1,}|\d{1,}]/g,'')"/>
				   <b>(每次消费可以使用赠送的金额抵扣消费总金额的十分之几.)</b>
			   </div>
		 </div>
		<div class="control-group">
			<label class="control-label" id="amount_label">金额/折扣:</label>
			  <div class="controls">
	 <form:input path="amount" htmlEscape="false" maxlength="50" class="input-medium"   placeholder="请输入金额/折扣" onkeyup="value=value.replace(/[^\d{1,}\.\d{1,}|\d{1,}]/g,'')"/>
	 <b>(当类型为满减卷、现金卷时、输入可以抵扣的金额，当类型为代金券、折扣卷时按十分之几算)</b>
			  </div>
		   </div>
		   <div class="control-group" style="display: none">
			<label class="control-label">产品类型适用范围:</label>
			<div class="controls">
			 <form:select path="productType" class="input-medium" onchange="checkScope()">
				 <form:option value="3">所有商品</form:option>
			      <form:option value="">请选择</form:option>
			      <form:option value="1">指定商品</form:option>
			  <%--     <form:option value="2">指定类别</form:option> --%>

			    </form:select>
			</div>
		</div>
		
		 <div class="control-group" id="cids" style="display:none;">
			<label class="control-label">选择类别:</label>
			<div class="controls">
			 <tags:treeselect id="menu" name="cid" value="${sbProductType.id}" labelName="productTypeStr" labelValue="${sbProductType.productTypeStr}" title="菜单" url="${ctxsys}/Product/category/treeData" extId="${sbProductType.id}" 
		cssClass="required input-medium" allowClear="true" /> 
			</div>
		</div>
		 
		
			 
  	<div class="control-group" id="porcId" style="display: none">
			<label class="control-label">商品ID:</label>
			<div class="controls">
			 <form:input path="productTypeId" htmlEscape="false" maxlength="50"  readonly="readonly" class="input-medium" placeholder=""  />
			 <%--<b>(当产品类型适用范围是指定商品时，输入的id以,隔开)</b>--%>
 			</div>
		</div>  
		 
		<div class="control-group">   
			<label class="control-label">门店范围:</label>
			<div class="controls">
			 <form:select path="shopType" id="shopType" class="input-medium"  onchange="checkScope2()">
			      <form:option value="" >请选择</form:option>
			      <form:option value="1" >指定门店</form:option>
			       <form:option value="2">所有门店</form:option>
			 </form:select>

		       <%--<form:hidden path="shopTypeId" value="1"/>--%>

			</div>
		</div>

		   <div class="control-group" id="porcId" style="display:block">
			   <label class="control-label">门店ID:</label>
			   <div class="controls">
				   <form:input path="shopTypeId" id="shopTypeId" htmlEscape="false" maxlength="50"  readonly="readonly" class="input-medium" placeholder=""  />
				   <%--<b>(当门店适用范围是指定门店时，输入的ID以,隔开)</b>--%>
				   <input type="button" value="清空" onclick="clearShopId()" class="btn btn-primary"/>
			   </div>
		   </div>
		   <%-- <div class="control-group">
               <label class="control-label">商家ID:</label>
               <div class="controls">
            <form:input path="shopTypeId" htmlEscape="false" maxlength="50" class="input-medium"   placeholder="请输入商家ID"/>
               </div>
           </div> --%>
		<div class="control-group">
			<label class="control-label">有效开始日期:</label>
			<div class="controls">
				 <form:input path="certificateStartDate" htmlEscape="false" maxlength="50" class="input-medium"   placeholder="请输入有效开始日期"  onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" 
				 value="${ebCertificate.certificateStartDate}"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">有效结束日期:</label>
			<div class="controls">
	   <form:input path="certificateEndDate" htmlEscape="false" maxlength="50" class="input-medium"   placeholder="请输入有效结束日期" 
onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"   value="${ebCertificate.certificateEndDate}"/>
 
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">发起时间:</label>
			<div class="controls">
	   <form:input path="sendTime" htmlEscape="false" maxlength="50" class="input-medium"   placeholder="请输入发起时间"
       onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"  value="${ebCertificate.sendTime}" /> 
			</div>
		</div>
		
		<div class="control-group">
			<label class="control-label">优惠券备注:</label>
			<div class="controls" >
      <form:textarea path="remark" htmlEscape="false" maxlength="500" class="input-medium"   placeholder="请输入备注"/>
			</div>
		</div> 
		<c:if test="${flag=='edit'}">
		<div class="control-group">
			<label class="control-label">是否禁用优惠券:</label>
			<div class="controls">  
  	     <form:radiobutton path="enabledSys"  value="0"  onclick="enablesyss()" />否
         <form:radiobutton path="enabledSys" value="1"  onclick="enablesyss()"/>是
 		</div>
		</div> 
		 
		<div class="control-group" id="enabledReason" style="display:${ebCertificate.enabledSys==1?'block':'none'}">
			<label class="control-label">禁用原因:</label>
			<div class="controls">
			<textarea  id="enabledSysRemark" name="enabledSysRemark" maxlength="500"  placeholder="请输入禁用原因">${remarksys}</textarea>
			</div>
		</div>  
		</c:if>
	<%-- 	<c:if test="${not empty ebCertificateLocations}">
				<div class="control-group">
			<label class="control-label">投放位置:</label>
			<div class="controls">
			 <form:select path="locationId" class="input-medium">
			 <form:option value="">请选择</form:option>
			 <c:forEach var="locations" items="${ebCertificateLocations}">
			 <form:option value="${locations.id}">${locations.certificateLocationName }</form:option>
			 </c:forEach>
			</form:select>
			</div>
		</div> 
		</c:if>
 --%>
		
		
		<div class="form-actions">
		<shiro:hasPermission name="merchandise:certificatelist:edit">
				 <input id="btnSubmit" class="btn btn-primary" type="button" value="保 存"/> 
		</shiro:hasPermission> 
				 <span></span>
				 <input id="btnCancel" class="btn" type="button" value="返 回" onclick="window.location.href='${ctxsys}/Product/certificatelist'"/>
		</div>
 </form:form>
 
  <script type="text/javascript">
	  $(function(){
          $("#shopTypeId").attr("readonly","readonly")
          $("#productTypeId").attr("readonly","readonly")
	  })

  </script>


	<script type="text/javascript">
        $(function(){
            var flag = '${flag}';
            if(flag == "edit"){
                //把input设置成不可用
                var inputArr = $("input");
                for(var i = 0 ; i < inputArr.length ; i++){
                    if($(inputArr[i]).attr("name") == "enabledSys"){
                        continue;
                    }

                    if($(inputArr[i]).attr("name") == "certificateStartDate" || $(inputArr[i]).attr("name") == "certificateEndDate" ||
                        $(inputArr[i]).attr("name") == "sendTime" ){

                        $(inputArr[i]).attr("disabled","disabled")
					}

                    $(inputArr[i]).attr("readonly","readonly")
                }

                //select设置成不可用
                var selectArr = $("select");
                for(var i = 0 ; i < inputArr.length ; i++){
                    //设置成可点击，但是不会变化
                    $(selectArr[i]).attr({"onfocus":"this.defaultIndex=this.selectedIndex","onchange":"this.selectedIndex=this.defaultIndex"})
                    $(selectArr[i]).attr({"readonly":"readonly"})
                }

                //textarea设置成不可用
                var textareaArr = $("textarea");
                for(var i = 0 ; i < inputArr.length ; i++){
                    if($(textareaArr[i]).attr("name")=="remark") {
                        $(textareaArr[i]).attr("readonly", "readonly")
                    }
                }
            }


        })
	</script>
</body>
</html>