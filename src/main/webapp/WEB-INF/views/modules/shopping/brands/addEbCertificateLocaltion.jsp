<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<jsp:useBean id="ebCertificate" class="com.jq.support.model.certificate.EbCertificate" scope="request"/>
<html>  
<head> 
	<title>优惠券发放添加</title>
	<meta name="decorator" content="default"/>
	<link href="${ctxStatic}/jquery-jbox/2.3/Skins/Default/jbox.css?v=1" type="text/css" rel="stylesheet" />
	<script src="${ctxStatic}/jquery-jbox/2.3/jquery.jBox-2.3.js?v=1" type="text/javascript"></script>
	<link href="${ctxStatic}/supplyshop/layui/css/modules/layer/default/layer.css?v=1" type="text/css" rel="stylesheet" />
	<script src="${ctxStatic}/supplyshop/layui/lay/modules/layer.js?v=1" type="text/javascript"></script>
    <script type="text/javascript">
        function shopTypes() {
            displayType4();
        };

        //类型4显示隐藏
        function displayType4() {
            var shopType = $("input[class='shopType']:checked").val()
            if(shopType=="1"){
                $('#shopIds_div').css("display","block");
            }else{
                $('#shopIds_div').css("display","none");
            }

            var type=$("#type").val();
            if(type=="4"){
                $('#shopType_div').css("display","block");
            }else{
                $('#shopType_div').css("display","none");
            }

        }
        $(function() {
            displayType4();
            $('.shopType').click(function () {
                displayType4();
            });
        });
    </script>
    <script type="text/javascript">
	  $(function(){
	  
          $('#certificateIds').click(function(){
               layer.open({
				        type: 2,
				        title: '优惠券列表',
				        shadeClose: true,
				        shade: false,
				        maxmin: true, //开启最大化最小化按钮
				        area: ['1090px', '500px'],
				        content: '${ctxsys}/Product/chooseCertificate?chooseIds='+$('#certificateIds').val(),
				        btn: ['确定', '关闭'],
				        yes: function(index, layero){ //或者使用btn1
				        	content = layero.find("iframe")[0].contentWindow.$('#chooseIds').val();
				 	   if(content==""){
				 		  layer.msg("请先选中一行");
				 		  $("#certificateIds").val(content);
					   }else{
						   $("#certificateIds").val(content);
						   layer.close(index);
					   }
			        
				        }
				      });
            });
          $('#shopIds').click(function(){
              layer.open({
                  type: 2,
                  title: '门店列表',
                  shadeClose: true,
                  shade: false,
                  maxmin: true, //开启最大化最小化按钮
                  area: ['880px', '450px'],
                  content: '${ctxsys}/Product/chooseShops?shopIds='+$("#shopIds").val(),
                  btn: ['确定', '关闭'],
                  yes: function(index, layero){ //或者使用btn1
                      content = layero.find("iframe")[0].contentWindow.$('#chooseIds').val();
                      if(content==""){
                          layer.msg("请先选中一行");
                          $("#shopIds").val(content);
                      }else{
                          $("#shopIds").val(content);
                          layer.close(index);
                      }

                  }
              });
          });
		  $("#btnSubmit").click(function(){
    	      if($("#certificateLocationName").val()==""){
    	    	  $.jBox.error("请输入名称");  
    	    	  return false;
    	      }
    	      if($("#type").val()==""){
    	    	  $.jBox.error("请选择类型");  
    	    	  return false;
    	      }
    	      
    	      
    	      if($("#certificateIds").val()==""){
    	    	  $.jBox.error("请选择发放优惠券");  
    	    	  return false;
    	      }
  
    	     $("#searchForm").submit();
    	     
		  });
			
		
	
	  });
	  
	 </script>
</head>
<body style="height: 100%">
    <c:if test="${not empty msg }">
     <script type="text/javascript">
	   $(function(){
		   $.jBox.success("${msg}","信息提示");
		   if("${type}"=="edit"){
			   setTimeout(function(){
					  location.href="${ctxsys}/Product/EbCertificateLocaltionlist";
				  },500);
		   }
	   })
	</script> 
    </c:if>
    <input type="hidden" id="flag" value="${flag}"/>
   
   
    
	 <ul class="nav nav-tabs">
	  <li ><a href="${ctxsys}/Product/certificatelocaltionlist">优惠券发放列表</a></li>
	  <li class="active"><a href="javascript:;">优惠券发放${ebCertificateLocation.id==null?'修改':'添加'}</a></li> 
 	</ul><br/> 
 	   <form:form id="searchForm" modelAttribute="ebCertificateLocation" action="${ctxsys}/Product/saveCertificatelocaltion" method="post" class="form-horizontal">
 		<div class="control-group">
			<label class="control-label">名称:</label>
			<div class="controls" >
			  <form:input path="certificateLocationName" htmlEscape="false" maxlength="50" class="input-medium"   placeholder="请输入优惠券发放名称"/>
			</div>
		</div>
		<form:hidden path="id" value="${ebCertificateLocation.id}"/>
		<div class="control-group">
			<label class="control-label">类型:</label>
			<div class="controls">
                <form:select path="type" class="input-medium"  onchange="shopTypes()">
			      <form:option value="1">注册</form:option>
			      <form:option value="2">被邀请注册</form:option>
			       <form:option value="3">邀请人</form:option>
                    <form:option value="4">小程序门店首页领取</form:option>
                    <form:option value="5">一级邀请人</form:option>
                    <form:option value="6">二级邀请人</form:option>
                    <form:option value="7">三级邀请人</form:option>
			    </form:select>
			</div>
		</div>
           <div class="control-group" id="shopType_div" style="display: none">
               <label class="control-label">投放门店:</label>
               <div class="controls">
                   <input type="radio" name="shopType" class="shopType" value="2" <c:if test="${ebCertificateLocation.shopType==null||ebCertificateLocation.shopType==2}"> checked="checked" </c:if>/>所有门店
                   <input type="radio" name="shopType" class="shopType" value="1" <c:if test="${ebCertificateLocation.shopType==1}"> checked="checked" </c:if>/>指定门店
               </div>
           </div>
           <div class="control-group" id="shopIds_div" style="display: none">
               <label class="control-label">投放门店ID:</label>
               <div class="controls">
                   <form:input path="shopIds" htmlEscape="false" maxlength="150" class="input-medium" placeholder="投放门店ID"  readonly="readonly" />
                   <b>(输入的id以,隔开)</b>
               </div>
           </div>
           <div class="control-group">
			<label class="control-label">优惠券ID:</label>
			<div class="controls">
			 <form:input path="certificateIds" htmlEscape="false" maxlength="150" class="input-medium" placeholder="优惠券ID"  readonly="readonly" />
			 <b>(输入的id以,隔开)</b>
 			</div>
		</div>  
		 
		<div class="control-group">
			<label class="control-label">是否开启:</label>
			<div class="controls">  
	  	        <form:radiobutton path="status"  value="0" />否
	            <form:radiobutton path="status"  value="1"   />是
 		   </div>
		</div> 
		 
		<div class="control-group" >
			<label class="control-label">描述:</label>
			<div class="controls">
			<textarea  id="certificateLocationDesc" name="certificateLocationDesc" maxlength="500"  placeholder="请输入描述">${remarksys}</textarea>
			</div>
		</div>  
		
		<div class="form-actions">
				 <input id="btnSubmit" class="btn btn-primary" type="button" value="保 存"/> 
				 <span></span>
				 <input id="btnCancel" class="btn" type="button" value="返 回" onclick="window.location.href='${ctxsys}/Product/EbCertificateLocaltionlist'"/>
		</div>
 </form:form>
 
  
</body>
</html>