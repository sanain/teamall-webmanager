<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>商品添加</title>
	<meta name="decorator" content="default"/>
	<%@include file="/WEB-INF/views/include/treetable.jsp" %>
  <script type="text/javascript">
	$(document).ready(function() {
	$(document).ready(function(){
	CKEDITOR.replace('TextArea1'); 
	/* //初始化编辑器
		 var um = UE.getEditor('myEditor',{
	     initialFrameWidth :850,//设置编辑器宽度
	     initialFrameHeight:150,//设置编辑器高度
	     scaleEnabled:true
	    });
	     var um = UE.getEditor('mytoEditor',{
	     initialFrameWidth :850,//设置编辑器宽度
	     initialFrameHeight:150,//设置编辑器高度
	     scaleEnabled:true
	    }); */
});
	$("#upload1").click(function(){
		 var a;
		var formData = new FormData();
		formData.append('file1', $('#file1')[0].files[0]);
		$.ajax({
		    url: '${ctxsys}/Product/pohotuploadimg',
		    type: 'POST',
		    cache: false,
		    data: formData,
		     success: function (data){//上传成功
		     a=data;
		     if(a!=""){
		     $("#ju1").remove();
		     $("#poth1").append("<span id='ju1'><input type='hidden' name='prdouctImg' value='"+a+"'/><img  width='70px;' height='50px;' alt='' src='"+a+"'></span>");
             }else{
             alert("请选择上传的图片");
             }
              },
		    processData: false,
		    contentType: false
		}).done(function(res) {

		}).fail(function(res) {
	
		});
            });
			
	 $("#upload").click(function(){
		 var a;
		var formData = new FormData();
		formData.append('file', $('#file')[0].files[0]);
		$.ajax({
		    url: '${ctxsys}/Product/pohotupload',
		    type: 'POST',
		    cache: false,
		    data: formData,
		     success: function (data){//上传成功
		     a=data;
		     if(a!=""){
		     $("#poth").append("<dl style=' float: left; width: 100px; height: 100px;'><dt style='margin: 10px;'><input type='hidden' name='pothname' value='"+a+"'/><img width='70px;' height='50px;' alt='' src='"+a+"'></dt><dd style='text-align: center; margin: 9px;'><a href='#' onclick='deleteimg(this)'>删除</a></dd></dl>");
             }else{
             alert("请选择上传的图片");
             }
              },
		    processData: false,
		    contentType: false
		}).done(function(res) {

		}).fail(function(res) {
	
		});
            });
			$("#treeTable").treeTable({expandLevel : 5});
			$("#name").focus();
			$("#inputForm").validate();
	
					});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
	    	return false;
	    }
	  function selecttab(v){
	   if(v=='1'){
	    $("#table_box_1").show();
	    $("#li_1").addClass("active");
	     $("#table_box_2").hide();
	      $("#li_2").removeClass("active");
	     $("#table_box_3").hide();
	      $("#li_3").removeClass("active");
	    }
	    if(v=='2'){
	    $("#table_box_1").hide();
	     $("#li_1").removeClass("active");
	     $("#table_box_2").show();
	      $("#li_2").addClass("active");
	     $("#table_box_3").hide();
	     $("#li_3").removeClass("active");
	    }
	     if(v=='3'){
	    $("#table_box_1").hide();
	    $("#li_1").removeClass("active");
	     $("#table_box_2").hide();
	     $("#li_2").removeClass("active");
	     $("#table_box_3").show();
	     $("#li_3").addClass("active");
	    }
	    }
	   function deleteimg(img){
	    var a=$(img).prev().val();
	   if(a!=""&&a!=null){
	   $.ajax({
		    url:"${ctxsys}/Product/deleteimg",
		    type: 'POST',
		    cache: false,
		    data: {img:a},
		     success: function (data){//上
		     }
	   });
	    }
	   $(img).parent().parent().remove();
	  
	   }
	 
	 	</script>
</head>
<body>
      <ul class="nav nav-tabs">
		<shiro:hasPermission name="merchandise:pro:view">
		   <li><a href="${ctxsys}/Product/list?shopType=${EbProduct.shopType}">商品列表</a></li>
		</shiro:hasPermission>
	      <li class="active">
	        <a href="${ctxsys}/Product/form?id=${EbProduct.productId}">商品<shiro:hasPermission name="merchandise:pro:edit">${not empty EbProduct.productId?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="merchandise:pro:view">查看</shiro:lacksPermission></a>
	      </li>
	 </ul>
	<div class="headbar clearfix">
		<ul class="nav nav-tabs">
			<li id="li_1" class="active"><a href="javascript:void(0)" hidefocus="true" onclick="selecttab(1)">商品信息</a></li>
			<li id="li_2"><a href="javascript:void(0)" hidefocus="true" onclick="selecttab(2)">描述</a></li>
			<li id="li_3"><a href="javascript:void(0)" hidefocus="true" onclick="selecttab(3)">营销选项</a></li>
		</ul>
    </div>
	<div class="content_box">
		<div class="content form_content">
		<tags:message content="${message}"/>
		<form:form id="inputForm"  modelAttribute="EbProduct" action="${ctxsys}/Product/savepro" enctype="multipart/form-data" method="post" class="form-horizontal">
			<form:hidden path="productId"/>
			<form:hidden path="createTime"/>
			<div id="table_box_1">
				<div class="control-group">
					<label class="control-label">商品名称：</label>
						<div class="controls">
			               <form:input path="productName" htmlEscape="false" maxlength="50" class="required"/>
						</div>
				</div>
				<div class="control-group">
					<label class="control-label">关键词：</label>
						<div class="controls">
			                 <form:input path="searchWords" htmlEscape="false" maxlength="15" class="required"/>
						</div>
				</div>
				<div class="control-group">
					<label class="control-label">SEO关键词:</label>
						<div class="controls">
			                  <form:input path="keywords" htmlEscape="false" maxlength="50"/>
						</div>
				</div>
				<div class="control-group">
					<label class="control-label">所属分类：</label>
						<div class="controls">
				            <tags:treeselect id="menu" name="ebProCategory.id" value="${EbProduct.ebProCategory.id}" labelName="EbProduct.ebProCategory.categoryName" labelValue="${EbProduct.ebProCategory.categoryName}"
							title="菜单" url="${ctxsys}/EbProCategory/treeData" extId="" cssClass="required"/>
						</div>
				</div>
				<div class="control-group">
					<label class="control-label">是否上架：</label>
						<div class="controls">
			          			 <label class="attr"> <form:radiobutton path="prdouctStatus" value="0" checked="checked"/>是</label>
								<label class="attr"><form:radiobutton path="prdouctStatus" value="2" class="required"/>否</label>
						</div>
				</div>
				<div class="control-group">
					<label class="control-label">商品服务</label>
						<div class="controls">
			          			   <form:checkboxes path="roles" items="${roleMap}"/>  
									<span class="help-inline"><a href="${ctxsys}/EbProductservices/list">添加</a></span>
						</div>
				</div>
				<div class="control-group">
					<label class="control-label">商品标签</label>
						<div class="controls">
			          		<form:select path="productTags">
			          			<form:option value="">请选择</form:option>
			          			<form:options items="${ebadvertiselist}" itemLabel="advertiseName" itemValue="id" htmlEscape="false"/>
			          		</form:select>  
						</div>
				</div>
				<div class="control-group">
					<label class="control-label">购买成功增加积分:</label>
						<div class="controls">
			          			<form:input path="point" htmlEscape="false" maxlength="50" onkeyup="value=value.replace(/[^\d{1,}\.\d{1,}|\d{1,}]/g,'')"/>
							    <span class="help-inline"><font color="">*只能输入数字</font> </span>
						</div>
				</div>
				<div class="control-group">
					<label class="control-label">重量:</label>
						<div class="controls">
			          			<form:input path="weight" htmlEscape="false" maxlength="50" onkeyup="value=value.replace(/[^\d{1,}\.\d{1,}|\d{1,}]/g,'')"/>
								<span class="help-inline"><font color="">*只能输入数字</font> </span>
						</div>
				</div>
				<div class="control-group">
					<label class="control-label">商品货号:</label>
						<div class="controls">
			          			<form:input path="productNo" htmlEscape="false" maxlength="50" style="width:100px;" readonly= "true"/>
						</div>
				</div>
				<div class="control-group">
					<label class="control-label">库存:</label>
						<div class="controls">
			          			<form:input path="storeNums" htmlEscape="false" maxlength="50" style="width:100px;" onkeyup="value=value.replace(/[^\d{1,}\.\d{1,}|\d{1,}]/g,'')"/>
								<span class="help-inline"><font color="">*只能输入数字</font> </span>
						</div>
				</div>
				<div class="control-group">
					<label class="control-label">市场价格:</label>
						<div class="controls">
			          			<form:input path="marketPrice" htmlEscape="false" maxlength="50" style="width:100px;" onkeyup="value=value.replace(/[^\d{1,}\.\d{1,}|\d{1,}]/g,'')"/>
								<span class="help-inline"><font color="">*只能输入数字</font> </span>
						</div>
				</div>
				<div class="control-group">
					<label class="control-label">销售价格:</label>
						<div class="controls">
			          			<form:input path="sellPrice" htmlEscape="false" maxlength="50" style="width:100px;" onkeyup="value=value.replace(/[^\d{1,}\.\d{1,}|\d{1,}]/g,'')"/>
								<span class="help-inline"><font color="">*只能输入数字</font> </span>		
						</div>
				</div>
				<div class="control-group">
					<label class="control-label">成本价格:</label>
						<div class="controls">
			          			<form:input path="costPrice" htmlEscape="false" maxlength="50" style="width:100px;" onkeyup="value=value.replace(/[^\d{1,}\.\d{1,}|\d{1,}]/g,'')"/>
								<span class="help-inline"><font color="">*只能输入数字</font> </span>
						</div>
				</div>
				<div class="control-group">
					<label class="control-label">商品原图</label>
						<div class="controls">
			          			<%-- <input id="file1" type="file"/><button id="upload1" type="button">上传</button>
			          			<span id="poth1"><span id='ju1'><img  width="70px;" height="50px;"  src="${EbProduct.prdouctImg}"></span> </span> --%>
						    <form:hidden path="prdouctImg" htmlEscape="false" maxlength="100"  class="input-xlarge"/>
					        <span class="help-inline" id="prdouctImg"  style="color: blue;"></span>
					        <tags:ckfinder input="prdouctImg" type="images" uploadPath="/merchandise/product"/>
						</div>
				</div>
				<div class="control-group">
					  <label class="control-label">相册地址:</label>
						<div class="controls">
						  <form:input path="photoAlbum" htmlEscape="false" maxlength="200" />
						<!-- <div id="uploadForm">
			          			<input id="file" type="file"/><button id="upload" type="button">上传</button>
			          			</div>
						</div> -->
					   </div>
				   <div class="control-group">
					<label class="control-label">产品相册:</label>
						<div class="controls" id="poth" style="padding-bottom: 10px;">
						    <c:forEach items="${ebpimages}" var="ebimg">
								<dl style=" float: left; width: 100px; height: 100px;" >
										<dt style="margin: 10px;"><img width="70px;" height="50px;" alt="" src="${ebimg.name}"></dt>
										<dd style="text-align: center; margin: 9px;"><input type="hidden" name="${ebimg.id}" value="${ebimg.id}"/><!-- <a href="#" onclick="deleteimg(this)">删除</a> --></dd>
								</dl>
							</c:forEach>
						</div>
			       </div>
			   </div>
			</div>
			<div id="table_box_2" cellpadding="0" cellspacing="0" style="display:none">
				<table class="form_table">
					<colgroup>
						<col width="150px" />
						<col />
					</colgroup>
				    <tr>
						<th>广告内容:</th>
						<td>
						<form:textarea path="productHtml" id="productHtml" htmlEscape="false"/>
						<tags:ckeditor replace="productHtml" uploadPath="/merchandise/product"></tags:ckeditor>
						</td>
					</tr>
				</table>
			</div>

			  <div id="table_box_3" cellpadding="0" cellspacing="0" style="display:none">
					<table class="form_table">
							<colgroup>
								<col width="150px" />
								<col />
							</colgroup>
						   <tr>
								<th>规格属性:</th>
								<td>
				                   <form:textarea style="width: 630px; height: 300px;"  path="specification" htmlEscape="false" maxlength="5000" class="required"/>
				                    <span>每一项以->结尾</span>
								</td>
							</tr>
						</table>
						<table class="form_table">
							<col width="150px" />
							<col />
							<tr>
								<th>SEO描述：</th>
								<td>
									<form:textarea path="description" id="description" htmlEscape="false"/>
									<tags:ckeditor replace="description" uploadPath="/merchandise/product"></tags:ckeditor>
								</td>
							</tr>
						</table>
			      </div>
			<table class="form_table">
				<col width="150px" />
				<col />
					<tr>
						<td></td>
						<td><shiro:hasPermission name="merchandise:pro:edit"><button class="btn btn-primary" type="submit"><span>保存</span></button></shiro:hasPermission><input id="btnCancel" class="btn  btn-primary" type="button" value="返 回" onclick="history.go(-1)"/></td>
					</tr>
			</table>
	    </form:form>
	  </div>
   </div>
</body>
</html>