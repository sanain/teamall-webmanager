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
	
	 <style>
	 .certlist{overflow: hidden;}
	 .mod{width:25%;margin-right:10px;margin-top:20px;border:1px solid #e5e5e5;height:380px;float:left;}
	 .mod:nth-child(4n){margin-right:0;}
	 .certinfo{margin-left: 20px;}
	 .left{margin-left:10px;}
	 .fleft{float: left;padding-top: 25px; padding-left: 3px;}
	 /* .certImg{width: 200px; height: auto; border: 1px solid rgb(204, 204, 204); padding: 10px; cursor: pointer;}
	 .preview{height: 100%; overflow: hidden;}
	 .certImg img{width: 200px;height: 150px;} */
	 </style>
	  <script type="text/javascript">
	  function updatecert(id,obj){
		  var submit = function (v, h, f) {
	       if (v == true){
	     
		  var img=$(obj).parents(".certinfo").find(".cert").find(".controls").find(".certImg").find("#preview").find("img").attr("url");
		  if(img==undefined){
			  img="";
		  }
		  var time=$(obj).parents(".certinfo").find(".certtime").find(".certtimevalue").val().trim();
		  var name=$(obj).parents(".certinfo").find(".certname").find(".certnamevalue").val().trim();
		  if(time=="" || time.length==0){
			  alertx("证书时间不能为空");
			  return false;
		  }
		  if(name=="" || name.length==0){
			  alertx("证书名称不能为空");
			  return false;
		  }
		  $.jBox.tip("正在修改...", 'loading');  
		 $.ajax({
			 url:"${ctxsys}/trace/updatecert",
			 type:"post",
			 data:{
				 id:id,
				 image:img,
				 certificateTime:time,
				 certificateName:name
				
			 },
			 
			 success:function(data){
				 if(data.code=="00"){
					 $.jBox.tip(data.msg, 'success'); 
				 }else{
					 $.jBox.tip(data.msg, 'error'); 
				 }
				 
			 },
			 error:function(data){
				 $.jBox.tip('修改失败', 'error'); 
			 }
		 });
	          
	       }
	       };
  	   $.jBox.confirm("确认修改证书？", "提示", submit,{showScrolling: false, buttons: {"确定": true, "取消": false } });

	  }
	  
	  
	  
	  function deletecert(id,obj){
          var submit = function (v, h, f) {
	            if (v == true){
	            	   $.jBox.tip("正在删除数据...", 'loading');  
	    	    	   $.ajax({
	    	   			type: "get",
	    	   			url:"${ctxsys}/trace/deletecert",
	    	   			data:{
	    	   				id:id
	    	   			}, 
	    	   			async: false,
	    	   			success: function(data) {
	    	   				if(data.code=="00"){
	    	   				 $.jBox.tip('删除成功。', 'success'); 
	    	   			     $(obj).parents(".mod").remove();
	    	   				}else{
	    	   				 $.jBox.tip('删除失败。', 'error'); 
	    	   				}
	    	   			},
	    	   			error: function(data) {
	    	   				 alertx("操作失败");
	    	   			}
	    	   			
	    	   		});    

	            }
	        };
	    	   $.jBox.confirm("是否删除证书？删除后不可恢复", "提示", submit,{showScrolling: false, buttons: {"确定": true, "取消": false } });
		 
	  }
	  
	  function updatecode(code){
		  var newcode=$("#tracingSourceCode").val();
		  var submit = function (v, h, f) {
	            if (v == true){
	            	 $.ajax({
	            		 url:"${ctxsys}/trace/updatecode",
	            		 type:"post",
	            		 data:{
	            			 code:code,
	            			 newcode: newcode
	            		 },
	            		 success:function(data){
	            			 if(data.code=="00"){
	            				 alertx("修改成功");
	            				 setTimeout(function(){
	            					 window.location.href="${ctxsys}/trace/tracelist";
	            				 },3000);
	            			 }
	            		 },
	            		 error:function(data){
	            			 alertx("修改失败");
	            		 }
	            	 });
	           
	            	}
		  };
	   	   $.jBox.confirm("确认修改溯源码？", "提示", submit,{showScrolling: false, buttons: {"确定": true, "取消": false } });

	  }
	  
	  /*查看证书大图*/
	  function viewcert(obj){
		  var src=$(obj).parents(".certinfo").find(".cert").find(".controls").find(".certImg").find("#preview").find("img").attr("src");
		  layer.photos({ photos: {"data": [{"src": src}]} });
	  }
	  
	 </script>
</head>
<body style="height: 100%">
    
	 <ul class="nav nav-tabs">
	  <li  class="active"><a href="javascript:;">查看证书</a></li> 
	  <li><a href="${ctxsys}/trace/tracelist">溯源码列表</a></li> 
 	</ul><br/> 
 	   <div class="form-horizontal">
		<div class="control-group left">溯源码：
			<input type="text" value="${code}" name="tracingSourceCode" id="tracingSourceCode"/>
			<input type="button" class="btn btn-success" value="修改" onclick="updatecode('${code}')"/>
		</div> 
		</div>
		 
	  <div class="certlist left">
	  <c:if test="${not empty certs }">
	  <c:forEach items="${certs}" var="cert" varStatus="i"> 
	   <div class="mod">
		<div class="control-group certinfo" >
			<div class="cert" certid="${cert.id}">
			<label class="control-label" for="href">证书:</label>
			<div class="controls">
		  <div id="drop_area${i.index}" class="certImg"></div>
		  <script> 
		   new DragImgUpload("#drop_area${i.index}",{
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
    					$("#drop_area${i.index} #preview img").attr("src","${ctxweb}"+data.mainPageimgs);
    					$("#drop_area${i.index} #preview img").attr("url",data.mainPageimgs);
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
},"${ctxweb}${cert.image}");
		  </script>
 	   </div>
 	   </div>
 			<div class="certtime">
 			<label class="control-label" >证书时间:</label>
			  <div class="controls">
			  <input type="text"  class="certtimevalue"  value="<fmt:formatDate value="${cert.certificateTime}" pattern="yyyy-MM-dd" />"  maxlength="20" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
			  </div>
			  </div>
			  <div class="certname">
			  <label class="control-label" >证书名称:</label>
			<div class="controls">
			<input type="text" class="certnamevalue" value="${cert.certificateName }"/>
			</div></div>
			  <div class="operation">
			   <div class="fleft"> <input type="button" class="btn btn-success" value="修改" onclick="javascript:updatecert('${cert.id}',this)"/></div>
			   <div class="fleft"><input type="button" class="btn btn-danger" value="删除" onclick="javascript:deletecert('${cert.id}',this)"/></div>
			  <div class="fleft"> <input type="button" class="btn btn-default" value="查看证书大图" onclick="javascript:viewcert(this)"/></div>
			
			</div>
 		</div>
		 </div>
		 
		 </c:forEach></c:if>
		 
		 </div>
 </div>
 
 
  
</body>

</html>