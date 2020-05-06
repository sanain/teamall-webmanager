<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>商品添加</title>
		<style type="text/css">
	li{ list-style-type: none;}
	</style>
	<meta name="decorator" content="default"/>
	<%@include file="/WEB-INF/views/include/treetable.jsp" %>
  <script type="text/javascript">
	$(document).ready(function() {
			var type=$("#type").val();
			if(type=='0'){
				$("#num").show();
				$("#salePrice").hide();
				$("#manic").hide();
				$("#isAll").hide();
				$("#ckeke").hide();
				$("#categoryId").show();
			}else if(type=='1'){
				$("#num").hide();
				$("#state").hide();
				$("#salePrice").show();
				$("#manic").show();
				$("#isAll").hide();
				$("#ckeke").hide();
				$("#categoryId").show();
			}else if(type=='2'){
				    $("#salePrice").show();
				    $("#ckeke").hide();
				    $("#salePrice").show();
			        $("#categoryId").show();
					$("#num").show();
					$("#state").hide();
					$("#manic").hide();
					$("#isAll").hide();
				}else if(type=='3'){
					$("#standard").show();
					$("#salePrice").show();
					$("#num").hide();
					$("#state").hide();
					$("#manic").hide();
					$("#isAll").hide();
					$("#ckeke").hide();
					$("#categoryId").show();
					
				}else if(type=='4'){
					$("#standard").show();
					$("#salePrice").show();
					$("#num").hide();
					$("#state").hide();
					$("#manic").hide();
					$("#isAll").hide();
					$("#ckeke").hide();
					$("#categoryId").show();
					
				}
					});
					
					function favoraType(ftype){
						if(ftype=='0'){
								$("#num").show();
								$("#salePrice").hide();
								$("#manic").hide();
								$("#state").show();
								$("#isAll").hide();
								$("#ckeke").hide();
								$("#categoryId").show();
							}else if(ftype=='1'){
								$("#num").hide();
								$("#state").hide();
								$("#salePrice").show();
								$("#manic").show();
								$("#isAll").hide();
								$("#ckeke").hide();
								$("#categoryId").show();
							}else if(ftype=='2'){
							    $("#salePrice").show();
				                $("#ckeke").hide();
				                $("#salePrice").show();
							    $("#categoryId").show();
								$("#num").hide();
								$("#state").hide();
								$("#manic").hide();
								$("#isAll").show();
							}else if(ftype=='3'){
							    $("#categoryId").show();
								$("#standard").show();
								$("#salePrice").show();
								$("#num").hide();
								$("#state").hide();
								$("#manic").hide();
								$("#isAll").hide();
								$("#ckeke").hide();
							}else if(ftype=='4'){
							    $("#categoryId").show();
								$("#standard").show();
								$("#salePrice").show();
								$("#num").hide();
								$("#state").hide();
								$("#manic").hide();
								$("#isAll").hide();
								$("#ckeke").hide();
							}
					}
					function favora(ftype){
					  if(ftype=='0'){
					  $("#num").hide();
					  $("#state").hide();
					  $("#salePrice").show();
					  $("#ckeke").hide();
					  $("#manic").hide();
				       }else if(ftype=='1'){
				       $("#num").hide();
					   $("#state").hide();
					   $("#salePrice").show();
						$("#manic").hide();
				       	$("#ckeke").show();
				       }
					}
	 	</script>
</head>
<body>
<ul class="nav nav-tabs">
		<shiro:hasPermission name="merchandise:sales:view"><li class="active"><a href="${ctxsys}/Product/list">优惠商品列表</a></li></shiro:hasPermission>
	</ul>
	<div class="content_box">
	<div class="content form_content">
	<tags:message content="${message}"/>
	<form:form id="inputForm"  modelAttribute="ebCommoditytrial" action="${ctxsys}/EbCommoditytria/save"  method="post" class="form-horizontal">
			<form:hidden path="commoditytrialId"/>
			<div id="table_box_1">
			<div class="control-group">
					<label class="control-label">商品id：</label>
					<div class="controls">
		            <form:input path="productId" htmlEscape="false" maxlength="50" required="required" readonly="true"/>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label">商品名称：</label>
					<div class="controls">
					
		            <form:input path="produtName" htmlEscape="false" maxlength="50" class="required" readonly="true"/>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label">商品编号：</label>
					<div class="controls">
		           <form:input path="productNo" htmlEscape="false" maxlength="15" class="required" readonly="true"/>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label">开始时间：</label>
					<div class="controls">
					<input class="small"   name="startTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" value="<fmt:formatDate value='${ebCommoditytrial.startTime}' type='date' pattern='yyyy-MM-dd HH:mm:ss'/>" >  
					</div>
				</div>
				<div class="control-group">
					<label class="control-label">结束时间：</label>
					<div class="controls">
					<input class="small"  name="stopTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" value="<fmt:formatDate value='${ebCommoditytrial.stopTime}' type='date' pattern='yyyy-MM-dd HH:mm:ss'/>" >  
					</div>
				</div>
				<div class="control-group" >
					<label class="control-label">优惠类型 ：</label>
					<div class="controls">
				<form:select path="type" id="type"  htmlEscape="false" maxlength="50" style="width: 100px;" class="input-medium" onchange="favoraType(this.value)">
		           <option value="">请选择</option>  
                   <form:option value="0">免费 </form:option> 
                   <form:option value="1">摇一摇</form:option>
                   <form:option value="2">限时抢购</form:option>
                   <form:option value="3">一元夺宝</form:option>
                    <form:option value="4">h5一元夺宝</form:option>
               </form:select> 
					</div>
				</div>
				<div class="control-group" id="num">
					<label class="control-label">数量：</label>
					<div class="controls">
		          			<form:input path="num" htmlEscape="false" maxlength="50" onkeyup="value=value.replace(/[^\d{1,}\.\d{1,}|\d{1,}]/g,'')"/>
							<span class="help-inline"><font color="">*只能输入数字</font> </span>
					</div>
				</div>
				<div class="control-group" id="state">
					<label class="control-label">申请状态：</label>
					<div class="controls">
					<form:select path="state"  htmlEscape="false" maxlength="50" style="width: 100px;" class="input-medium">
				           <option value="">请选择</option>  
		                   <form:option value="0">接受申请中 </form:option> 
		                   <form:option value="1">确认名单中</form:option>
		                     <form:option value="2">已发货</form:option>
		                      <form:option value="3">已完成</form:option>
               		</form:select> 
					</div>
				</div>
			</div>
			<div class="control-group" id="manic">
					<label class="control-label">撸一撸概率:</label>
					<div class="controls">
		          			<form:input path="manic" htmlEscape="false" maxlength="20" onkeyup="value=value.replace(/[^\d{1,}\.\d{1,}|\d{1,}]/g,'')"/>%
							<span class="help-inline"><font color="">*只能输入数字</font> </span>
					</div>
				</div>
				<div class="control-group" id="isAll">
					<label class="control-label">是否全部打折：</label>
					<div class="controls">
					<form:select path="isAll" id="isall"  htmlEscape="false" maxlength="50" style="width: 100px;" class="input-medium" onchange="favora(this.value)">
		                   <form:option value="0">是 </form:option> 
		                   <form:option value="1">否</form:option>
               		</form:select> 
					</div>
				</div>
				<div class="control-group" id="salePrice">
					<label class="control-label">优惠折扣价:</label>
					<div class="controls">
		          			<form:input path="salePrice" htmlEscape="false" maxlength="50" onkeyup="value=value.replace(/[^\d{1,}\.\d{1,}|\d{1,}]/g,'')"/>
							<span class="help-inline"></span>
					</div>
				</div>
					<div class="control-group" id="categoryId">
					<label class="control-label">选择属性:</label>
					<div class="controls">
		                <tags:treeselect id="menu" name="propertyId" value="${ebCommoditytrial.propertyId}" labelName="standard" labelValue="${ebCommoditytrial.standard}"
							title="菜单" url="${ctxsys}/EbCommoditytria/treeData"  extId="${ebCommoditytrial.productId}" />
					</div>
				</div>
				<%-- <div class="control-group" id="ckeke">
						<label class="control-label">属性添加:</label>
						<div class="controls"> 
							<a href="${ctxsys}/EbCommoditytria/maplist?id=${ebCommoditytrial.commoditytrialId}">查看</a>
						</div>
					</div> --%>
					<div class="control-group">
					<label class="control-label">状态：</label>
					<div class="controls">
					<form:select path="status"  htmlEscape="false" maxlength="50" style="width: 100px;" class="input-medium">
                   <form:option value="0">生效 </form:option> 
                   <form:option value="1">失效 </form:option>
                   <form:option value="2">开奖中 </form:option>
              	 </form:select> 
					</div>
				</div>
			<table class="form_table">
				<col width="150px" />
				<col />
				<tr>
				<td></td>
				<td><shiro:hasPermission name="merchandise:sales:edit"><button class="btn btn-primary" type="submit"><span>保存</span></button></shiro:hasPermission><input id="btnCancel" class="btn  btn-primary" type="button" value="返 回" onclick="history.go(-1)"/></td>
				</tr>
			</table>
	</form:form>
	</div>
</div>
</body>
