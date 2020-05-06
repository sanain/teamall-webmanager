<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0,minimal-ui">
    <meta name="Description" content="${fns:getProjectName()},会员信息"/>
	<meta name="Keywords" content="${fns:getProjectName()},会员信息"/>
    <title>设置运费</title>
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/admin-member-msg.css">
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/bootstrap.min.css">
    <link type="text/css" rel="stylesheet" href="${ctxStatic}/common/jqsite.min.css">
    <link rel="stylesheet" href="${ctxStatic}/tii/tii.css">
    <script src="${ctxStatic}/sbShop/js/jquery.min.js"></script>
    <script src="${ctxStatic}/tii/tii.js"></script>
    <script type="text/javascript" src="${ctxStatic}/common/mustache.min.js"></script>
	<script type="text/javascript" src="${ctxStatic}/common/jqsite.min.js"></script>
    <script type="text/javascript" src="${ctxStatic}/ckeditor/ckeditor.js"></script>
	<script type="text/javascript" src="${ctxStatic}/ckfinder/ckfinder.js"></script>
    <script src="${ctxStatic}/sbShop/js/admin-member-msg.js"></script>
	    <script src="${ctxStatic}/sbShop/layui/layui.js"></script>
	<script src="${ctxStatic}/sbShop/js/admin-company-msg.js"></script>
	
	
	 <link rel="stylesheet" href="${ctxStatic}/sbShop/css/admin-member-msg.css">
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/bootstrap.min.css">
    <link type="text/css" rel="stylesheet" href="${ctxStatic}/common/jqsite.min.css">
    <link rel="stylesheet" href="${ctxStatic}/tii/tii.css">
    <script src="${ctxStatic}/sbShop/js/jquery.min.js"></script>
    <script src="${ctxStatic}/tii/tii.js"></script>
	<script type="text/javascript" src="${ctxStatic}/common/jqsite.min.js"></script>
	 <script type="text/javascript" src="${ctxStatic}/common/mustache.min.js"></script>
    <script type="text/javascript" src="${ctxStatic}/ckeditor/ckeditor.js"></script>
	<script type="text/javascript" src="${ctxStatic}/ckfinder/ckfinder.js"></script>
    <script src="${ctxStatic}/sbShop/js/admin-member-msg.js"></script>
	 <style>
    	.fixed-img{dispaly:none;position:fixed;width:600px;left:50%;margin-left:-300px;}
    	.fixed-img img{width:100%;max-width:auto}
    	.fit-right ul li ol li:first-child{}
    </style>
</head>

<body>
    <div class="c-context">
      <ul class="nav-ul" style="margin-bottom:10px">
          <li><a class="active" href="${ctxsys}/productfeight/feightEdit">设置运费</a></li>
      </ul>
      <form class="form-horizontal" style="margin:0px" method="post" id="searchForm" name="form2">
        <input id="freightModelId" name="freightModelId" type="hidden" value="${ebProductFreightModel.freightModelId}"/>
        <div class="context-box" style="padding:10px">
            <div>
				 <li style="display:flex;content-justify:flex-start;aglin-items:baseline;flex-wrap: wrap">
                       
						<div>

							<p style="margin-top:10px;margin-left:10px"><label style="width:50px">运费：</label>
								<input type="text" style="margin-right: 10px; border-width: 1px;border-style: solid;border-color: rgb(220, 220, 220);border-image: initial;
								border-radius: 3px;padding: 0px 10px;" id="normalFreight" name="normalFreight" value="${ebProductFreightModel.normalFreight}"/>
								<font color="red"> *</font>
							</p>
							<p style="margin-top:10px;margin-left:10px"><label style="width:50px">满免：</label>
								<input type="text" style="margin-right: 10px; border-width: 1px;border-style: solid;border-color: rgb(220, 220, 220);border-image: initial;
									border-radius: 3px;padding: 0px 10px;" id="fullFreight" name="fullFreight" value="${ebProductFreightModel.fullFreight}" />
								<font color="red"> *</font>
							</p>
				 		<%--<c:choose>--%>
				 		<%--<c:when test="${ebProductFreightModel.isWholesale == 2}">--%>
						<%--<p style="margin-top:10px;margin-left:10px"><label style="width:120px">市内邮费：</label>--%>
						<%--</c:when>--%>
						<%--<c:otherwise>--%>
						<%--<p style="margin-top:10px;margin-left:10px"><label style="width:120px">省内邮费：</label>--%>
						<%--</c:otherwise>--%>
						<%--</c:choose>--%>
						<%--<input type="text" style="margin-right: 10px; border-width: 1px;border-style: solid;border-color: rgb(220, 220, 220);border-image: initial;--%>
						<%--border-radius: 3px;padding: 0px 10px;" id="normalFreight" name="normalFreight" value="${ebProductFreightModel.normalFreight}"/>--%>
						<%--<font color="red"> *</font></p>--%>
						
					 	<%--<c:choose>--%>
				 		<%--<c:when test="${ebProductFreightModel.isWholesale == 2}">--%>
						<%--<p style="margin-top:10px;margin-left:10px"><label style="width:120px">市内满多少钱免邮：</label>--%>
						<%--</c:when>--%>
						<%--<c:otherwise>--%>
					    <%--<p style="margin-top:10px;margin-left:10px"><label style="width:120px">省内满多少钱免邮：</label>--%>
					    <%--</c:otherwise>--%>
						<%--</c:choose>--%>
						<%--<input type="text" style="margin-right: 10px; border-width: 1px;border-style: solid;border-color: rgb(220, 220, 220);border-image: initial;--%>
						<%--border-radius: 3px;padding: 0px 10px;" id="fullFreight" name="fullFreight" value="${ebProductFreightModel.fullFreight}" />--%>
						<%--<font color="red"> *</font></p>--%>
						<%----%>
						<%--<c:choose>--%>
				 		<%--<c:when test="${ebProductFreightModel.isWholesale == 2}">--%>
						<%--<p style="margin-top:10px;margin-left:10px"><label style="width:120px">市外邮费：</label>--%>
						<%--</c:when>--%>
						<%--<c:otherwise>--%>
						<%--<p style="margin-top:10px;margin-left:10px"><label style="width:120px">省外邮费：</label>--%>
						<%--</c:otherwise>--%>
						<%--</c:choose>--%>
						<%--<input type="text" style="margin-right: 10px; border-width: 1px;border-style: solid;border-color: rgb(220, 220, 220);border-image: initial;--%>
						<%--border-radius: 3px;padding: 0px 10px;" id="provinceOutNormalFreight" name="provinceOutNormalFreight" value="${ebProductFreightModel.provinceOutNormalFreight}"/>--%>
						<%--<font color="red"> *</font></p>--%>
						<%----%>
					    <%--<c:choose>--%>
				 		<%--<c:when test="${ebProductFreightModel.isWholesale == 2}">--%>
						<%--<p style="margin-top:10px;margin-left:10px"><label style="width:120px">市外满多少钱免邮：</label>--%>
						<%--</c:when>--%>
						<%--<c:otherwise>--%>
					    <%--<p style="margin-top:10px;margin-left:10px"><label style="width:120px">省外满多少钱免邮：</label>--%>
					    <%--</c:otherwise>--%>
						<%--</c:choose>--%>
						<%--<input type="text" style="margin-right: 10px; border-width: 1px;border-style: solid;border-color: rgb(220, 220, 220);border-image: initial;--%>
						<%--border-radius: 3px;padding: 0px 10px;" id="provinceOutFullFreight" name="provinceOutFullFreight" value="${ebProductFreightModel.provinceOutFullFreight}" />--%>
						<%--<font color="red"> *</font></p>--%>
						 </div>
                    </li>
                    
             <shiro:hasPermission name="merchandise:feight:edit">
            <div class="msg-btn">
                <input  type="button" onclick="bent()" style="display: inline-block;background: #69AC72;color: #ffffff;height: 30px;line-height: 30px;padding: 0 15px;border-radius: 4px;" value="保存"></a>
            </div>
			</shiro:hasPermission>
        </div>
		</div>
      </form>
    </div>
    <script type="text/javascript">
       function bent(){
		 var freightModelId=$('#freightModelId').val();
		 var normalFreight=$('#normalFreight').val();
		 var fullFreight=$('#fullFreight').val();
		 // var provinceOutNormalFreight=$('#provinceOutNormalFreight').val();
		 // var provinceOutFullFreight=$('#provinceOutFullFreight').val();
		
	     $.ajax({
			    url : "${ctxsys}/productfeight/savefeight",   
			    type : 'post',
			    data:{
                    "freightModelId":freightModelId,
					"normalFreight":normalFreight,
					"fullFreight":fullFreight,
					},
					cache : false,
			    success : function (data) {
			     if(data.code=='00'){
			        alertx(data.msg);
			      }else{
			       alertx(data.msg);
			      }
			    }
	         });
	      }
       
       
    </script>
<div class="tii">
	<span class="tii-img"></span>
	<span class="message" data-tid="${message}">${message}</span>
</div>
<div class="fixed-img">
</div>
</body>
</html>