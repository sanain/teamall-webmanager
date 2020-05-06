<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>  
<head> 
	<title>溯源码添加</title>
	<meta name="decorator" content="default"/>
	<link href="${ctxStatic}/jquery-jbox/2.3/Skins/Default/jbox.css?v=1" type="text/css" rel="stylesheet" />
	<script src="${ctxStatic}/jquery-jbox/2.3/jquery.jBox-2.3.js?v=1" type="text/javascript"></script>
	<link href="${ctxStatic}/supplyshop/layui/css/modules/layer/default/layer.css?v=1" type="text/css" rel="stylesheet" />
	<script src="${ctxStatic}/supplyshop/layui/lay/modules/layer.js?v=1" type="text/javascript"></script>
	 <script src="${ctxStatic}/tracesource/upload.js"></script>
	 <script type="text/javascript">
	  $(function(){
		  $("#btnSubmit").click(function(){
    	    	// $("#searchForm").submit();
		  });
	
	  });
 
	   function checkScope(){
		   layer.open({
		        type: 2,
		        title: '商品列表',
		        shadeClose: true,
		        shade: false,
		        maxmin: true, //开启最大化最小化按钮
		        area: ['880px', '450px'],
		        content: '${ctxsys}/trace/chooseProducts',
		        btn: ['确定', '关闭'],
		        yes: function(index, layero){ //或者使用btn1
		        var id = layero.find("iframe")[0].contentWindow.$('#chooseIds').val();
		        var traceSourceCode=layero.find("iframe")[0].contentWindow.$('#traceSourceCode').val();
		        var chooseProductName=layero.find("iframe")[0].contentWindow.$('#chooseProductName').val();
		 	   if(id==""){
		 		  layer.msg("请先选中一行");
			   }else{
				   $("#productId").val(id);
				   $("#productName").val(chooseProductName);
				   $("#traceSourceCode").val(traceSourceCode);
				   if(traceSourceCode!="" && traceSourceCode.length>0){
					   $("#traceSourceCode").attr("readonly","readonly");
				   }else{
					   $("#traceSourceCode").removeAttr("readonly");
				   }
				   layer.close(index);
			   }
	        
		        }
		      });
		  
	   }
	   
	   
	   function addcerttext(){
		 var index=$(".certlist .certinfo:last").attr("index");
		 index=parseInt(index)+1;
		   $(".certlist").append(
		  "<div class='certinfo cert"+index+"' index='"+index+"'>"+
		  "<div class='control-group'>"+
			"<div class='cert'>"+
			"<label class='control-label' >证书:</label>"+
			"<div class='controls'>"+
			" <div id='drop_area"+index+"' class='certImg'></div>"+
 			"</div>"+
 			"</div>"+
 			"<div class='certtime'>"+
 			"<label class='control-label' >证书时间:</label>"+
			 " <div class='controls'>"+
			  "<input type='text' class='certtimevalue' onfocus=WdatePicker({dateFmt:'yyyy-MM-dd'})   />"+
			  "</div>"+
			  "</div>"+
			  "<div class='certname'>"+
			 " <label class='control-label' >证书名称:</label>"+
			"<div class='controls'>"+
			"<input type='text' class='certnamevalue'  />"+
			"</div></div>"+
			"<div class='controls'><input type='button' value='删除' class='btn btn-danger' onclick='deletecertItem(this)'/></div>"+
		"</div>");
		 
		   var dragImgUpload = new DragImgUpload("#drop_area"+index,{
				callback:function (files) {
					//回调函数，可以传递给后台等等
					var file = files[0];
					console.log(file.name);
					if (file) {
						var formData = new FormData();
						formData.append('file', file);
						var cicrle="";
					$.ajax({
			    			type: 'POST',
			    			url:"${ctxsys}/trace/uploadImg",
			    			beforeSend:function(){
			    				cicrle=layer.load(1, {
			    	          		  shade: [0.1,'#fff'] //0.1透明度的白色背景
			    	        		}); 
			    			},
			    			cache: false,
			    			data: formData,
			    			success: function (data){
			    				layer.close(cicrle);
			    				if(data!=null&&data.code=='00'){
			    					$("#drop_area"+index+" #preview img").attr("src","${ctxweb}"+data.mainPageimgs);
			    					$("#drop_area"+index+" #preview img").attr("url",data.mainPageimgs);
			    				}else {
			    				  layer.msg("上传失败，请重新上传");
			    				}
			    			},
			    			processData: false,
			    			contentType: false
			    		}).done(function(res) {
			    		}).fail(function(res) {
			            });				
					 
					
					}
				}
			},"${ctxStatic}/tracesource/upload.png")
		   
	   }
	  
	   /**删除**/
	   function  deletecertItem(obj){
		   $(obj).parents(".certinfo").remove();
	   }
	   
	   /**上传证书*/
	   function addcert(obj){
		   var flag=true;
		     var length=$(".certlist .certinfo").length;
			 var certImgs="";
			 var certTimes="";
			 var certNames="";
			 var productId=$("#productId").val();
			 var traceSourceCode=$("#traceSourceCode").val();
			 if(productId=="" || productId.length==0){
				 layer.msg("请选择商品");
				 flag=false;
				 return false;
			 }
			 if(traceSourceCode=="" || traceSourceCode.trim().length==0){
				 layer.msg("请输入溯源码");
				 flag=false;
				 return false;
			 }
			 for(var i=0;i<length;i++){
				 var certImg=$(".certlist .certinfo .cert").eq(i).find(".certImg").find(" #preview").find("img").attr("url");
				 var certtime= $(".certlist .certinfo").eq(i).find(".certtimevalue").val();
				 var certname= $(".certlist .certinfo").eq(i).find(".certnamevalue").val();
				  if(certImg==undefined){
					 layer.msg("请先上传证书图片");
					 flag=false;
					 return;
				 }
				 if(certtime=="" || certtime.length==0){
					 layer.msg("请填写证书时间");
					 flag=false;
					 return;
				 }
				 if(certname=="" || certname.length==0){
					 layer.msg("请填写证书名称");
					 flag=false;
					 return;
				 } 
				 certImgs+=certImg+",";
				 certTimes+=certtime+",";
				 certNames+=certname+",";
				  
			 }
			  if(flag){ 
			   $.ajax({
				 url:"${ctxsys}/trace/addCertInfo",
				 type:"post",
				 data:{
					 id:productId,
					 traceSourceCode:traceSourceCode,
					 certImgs:certImgs,
					 certTimes:certTimes,
					 certNames:certNames
				 },
				 success:function(data){
					  if(data.code=="00"){
						  layer.msg(data.msg);
						  setTimeout(function(){
							  window.location.href="${ctxsys}/trace/list";
						  },3000);
					  }else{
						  layer.msg(data.msg);
					  }
				 },
				 error:function(data){
					 
				 }
			 }); 
			  } }
		 
	 </script>
</head>
<body style="height: 100%">
    
	 <ul class="nav nav-tabs">
	  <li class="active"><a href="${ctxsys}/trace/list">录入溯源码</a></li> 
	  <li><a href="${ctxsys}/trace/tracelist">溯源码列表</a></li> 
 	</ul><br/> 
 	   <div class="form-horizontal">
 		<div class="control-group">
			<label class="control-label" for="href">选择商品:</label>
			<div class="controls">
			<input type="text" id="productName" class="input-medium" onclick="checkScope()">
			<input type="hidden" id="productId" class="input-medium" >
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="href">溯源码:</label>
			<div class="controls">
			<input type="text" id="traceSourceCode" class="input-large"  maxlength="20">
			</div>
		</div> 
		<div class="certlist">
		<div class="certinfo cert1" index="1">
		<div class="control-group " >
			<div class="cert">
			<label class="control-label" for="href">证书:</label>
			<div class="controls">
		 <div id="drop_area" class="certImg"></div>
 	   </div>
 	   </div>
 			<div class="certtime">
 			<label class="control-label" >证书时间:</label>
			  <div class="controls">
			  <input type="text"  class="certtimevalue"   maxlength="20"  onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
			  </div>
			  </div>
			  <div class="certname">
			  <label class="control-label" >证书名称:</label>
			<div class="controls">
			<input type="text" class="certnamevalue" />
			</div></div>
 		</div>
	   </div>
		</div>
		   <div class="control-group">
			<label class="control-label" for="href" onclick="addcerttext()">
			 <strong><img src="${ctxStatic}/tracesource/addcert.png" style="width:15px;height:15px" />  添加证书</strong>
			</label>
			 
		</div>
		 
		<div class="form-actions">
				 <input id="btnSubmit" class="btn btn-primary" type="button" value="保 存" onclick="addcert()"/> 
				 <span></span>
				 <input id="btnCancel" class="btn" type="button" value="返 回" onclick="window.location.href='${ctxsys}/trace/tracelist'"/>
		</div>
 </div>
 
 <script type="text/javascript">
var dragImgUpload = new DragImgUpload("#drop_area",{
	callback:function (files) {
		//回调函数，可以传递给后台等等
		var file = files[0];
		console.log(file.name);
		if (file) {
			var formData = new FormData();
			formData.append('file', file);
			var cicrle="";
		$.ajax({
    			type: 'POST',
    			url:"${ctxsys}/trace/uploadImg",
    			beforeSend:function(){
    				cicrle=layer.load(1, {
    	          		  shade: [0.1,'#fff'] //0.1透明度的白色背景
    	        		}); 
    			},
    			cache: false,
    			data: formData,
    			success: function (data){
    				layer.close(cicrle);
    				if(data!=null&&data.code=='00'){
    					$("#drop_area #preview img").attr("src","${ctxweb}"+data.mainPageimgs);
    					$("#drop_area #preview img").attr("url",data.mainPageimgs);
    				}else {
    				  layer.msg("上传失败，请重新上传");
    				}
    			},
    			processData: false,
    			contentType: false
    		}).done(function(res) {
    		}).fail(function(res) {
            });				
		 
		
		} 
	}
},"${ctxStatic}/tracesource/upload.png");
</script>
  
</body>
</html>