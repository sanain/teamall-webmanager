<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<jsp:useBean id="ebCertificate" class="com.jq.support.model.certificate.EbCertificate" scope="request"/>
<html>  
<head> 
	<title>商家入驻申请资料</title>
	<meta name="decorator" content="default"/>
	<link href="${ctxStatic}/jquery-jbox/2.3/Skins/Default/jbox.css?v=1" type="text/css" rel="stylesheet" />
	<script src="${ctxStatic}/jquery-jbox/2.3/jquery.jBox-2.3.js?v=1" type="text/javascript"></script>
	<link href="${ctxStatic}/supplyshop/layui/css/modules/layer/default/layer.css?v=1" type="text/css" rel="stylesheet" />
	<script src="${ctxStatic}/supplyshop/layui/lay/modules/layer.js?v=1" type="text/javascript"></script>
	 <script type="text/javascript">
		function auditing(status,id,reason){
			var index;
			$.ajax({  
				url:"${ctxsys}/PmShopInfo/auditing",
				type:"get",
				  beforeSend:function(){
                	  index= layer.load(1, {
                		  shade: [0.1,'#fff'] //0.1透明度的白色背景
                		}); 
				  },
				data:{
					status:status,
					id:id,
					reviewReason:reason
				},
				success:function(data){
					layer.close(index);
					if(data.code=="00"){
						 layer.msg("操作成功！");
						 setTimeout(function(){
							 window.location.href="${ctxsys}/PmShopInfo/applylist";
						 },3000);
					}
				},
				error:function(data){
					layer.close(index);
					 layer.msg("操作失败");
				}
			});
		}
		
		
		function refuse(status,id){
			  layer.prompt({title: '请填写拒绝理由', formType: 2,allowBlank: true}, function(text,index){
				   if(text=="" || text.length==0){
					   layer.msg("请填写拒绝理由");
				   }else{
					   layer.close(index);
					   auditing(status,id,text);
				   }
				 
				   
				  });
			 
			  return;
			  
		}
	   $(function(){
			$("body").on("click",".img-details img",function(e){
				 layer.photos({ photos: {"data": [{"src": e.target.src}]} });
			});
			
			
			
		
	   });
	 </script>
</head>
<body style="height: 100%">
     
	 <ul class="nav nav-tabs">
	  <li class="active"><a href="javascript:;">查看详情</a></li> 
	  <li><a href="${ctxsys}/PmShopInfo/applylist">商家入驻申请资料</a></li> 
 	</ul><br/>  
 	<div class="form-horizontal">
  		<div class="control-group">
			<label class="control-label" for="href"></label>
			<div class="controls" >
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="href">申请人姓名:</label>
			<div class="controls">
             ${apply.contactName }
			</div>
		</div> 
		<div class="control-group" id="manjian">
			<label class="control-label" for="href">联系方式:</label>
			<div class="controls">
			${apply.mobilePhone }
 			</div>
		</div>
		    
		<div class="control-group">
			<label class="control-label" for="isShow">企业名称:</label>
			  <div class="controls">
				${apply.companyName }
			  </div>
		   </div>
		   <div class="control-group">
			<label class="control-label" for="href">经营地址:</label>
			<div class="controls">
			 ${apply.contactAddress }
			</div>
		</div>
			 
  	<div class="control-group" id="porcId" >
			<label class="control-label" for="href">经营范围:</label>
			<div class="controls">
			  ${apply.licenseAppScope } 
 			</div>
		</div>  
		 
		 <div class="control-group">   
			<label class="control-label" for="href">营业执照:</label>
			<div class="controls img-details">
			<c:if test="${fn:length(fn:split(apply.businessCodeLogo,'|')) >1}">
			<c:forEach begin="1" end="${fn:length(fn:split(apply.businessCodeLogo,'|')) }" varStatus="i"> 
			<p>  <img src="${imgPrefix}${fn:split(apply.businessCodeLogo,'|')[i.index-1] }" style="width: 260px;height: 260px;"/> </p>
		 	</c:forEach>
			</c:if>
			
			</div>
		</div>  
		 
		<div class="control-group">
			<label class="control-label" for="href">申请时间:</label>
			<div class="controls">
			 ${apply.createTime }   
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="href">状态:</label>
			<div class="controls">
			<c:if test="${apply.reviewStatus=='0'}">待审核</c:if>
			<c:if test="${apply.reviewStatus=='1'}">已通过</c:if>
			<c:if test="${apply.reviewStatus=='2'}">已拒绝</c:if>
			</div>
		</div>
			<c:if test="${apply.reviewStatus=='2'}">
		<div class="control-group">
			<label class="control-label" for="href">拒绝理由:</label>
			<div class="controls">
			 ${apply.reviewReason }
			</div>
		</div> </c:if>
		 </div>
		  
		<div class="form-actions">
		          <center>
		          <c:choose>
		          <c:when test="${not empty apply && apply.reviewStatus>0}">
		         <input id="btnCancel" class="btn" type="button" value="返回" onclick="window.location.href='${ctxsys}/PmShopInfo/applylist'"/>
		          </c:when>
		          <c:otherwise>
		           <input id="btnSubmit" class="btn btn-primary" type="button" value="通过" onclick="javascript:auditing(1,'${apply.id}','');"/> 
				   <input id="btnCancel" class="btn" type="button" value="拒绝" onclick="javascript:refuse(2,'${apply.id}');"/><%--  javascript:auditing(2,'${apply.id}'); --%>
		          </c:otherwise>
		          </c:choose>
				
				  </center>
		</div>
 
 
  
</body>
</html>