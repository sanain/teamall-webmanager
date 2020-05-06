<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>菜单管理</title>
	<meta name="decorator" content="default"/> 
	<script type="text/javascript">
		$(document).ready(function() {
			var type=$("#advertiseType").val();
			if(type=='1'){
				$("#categoryId").show();
				$("#productNo").hide();
				$("#advertiseId").hide();
				$("#linkUrls").hide();
				$("#shopId").hide();
				$("#keywords").hide();
			}
			if(type=='2'){
				$("#categoryId").hide();
				$("#productNo").show();
				$("#advertiseId").hide();
				$("#linkUrls").hide();
				$("#shopId").hide();
				$("#keywords").hide();
			}
			if(type=='3'){
				$("#categoryId").hide();
				$("#productNo").hide();
				$("#advertiseId").hide();
				$("#linkUrls").show();
				$("#shopId").hide();
				$("#keywords").hide();
			}
			if(type=='4'){
				$("#categoryId").hide();
				$("#productNo").hide();
				$("#advertiseId").hide();
				$("#linkUrls").hide();
				$("#shopId").show();
				$("#keywords").hide();
			}
			if(type=='5'){
				$("#categoryId").hide();
				$("#productNo").hide();
				$("#advertiseId").show();
				$("#linkUrls").hide();
				$("#shopId").hide();
				$("#keywords").hide();
				$("#adMultiple").hide();
			}
			if(type=='6'){
				$("#categoryId").hide();
				$("#productNo").hide();
				$("#advertiseId").hide();
				$("#linkUrls").hide();
				$("#shopId").hide();
				$("#keywords").show();
				$("#adMultiple").html("关键词:");
			}
			if(type=='7'){
				$("#categoryId").hide();
				$("#productNo").hide();
				$("#advertiseId").hide();
				$("#linkUrls").hide();
				$("#shopId").hide();
				$("#keywords").show();
				$("#adMultiple").html("专区倍数:");
			}
			if(type=='8'){
				$("#categoryId").hide();
				$("#productNo").hide();
				$("#advertiseId").hide();
				$("#linkUrls").hide();
				$("#shopId").hide();
				$("#keywords").hide();
			}
			var layouttypeId=$("#layouttypeId").val();
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
		}); 
		function getwords(type){
			if(type=='1'){
				$("#categoryId").show();
				$("#productNo").hide();
				$("#advertiseId").hide();
				$("#linkUrls").hide();
				$("#shopId").hide();
				$("#keywords").hide();
			}
			if(type=='2'){
				$("#categoryId").hide();
				$("#productNo").show();
				$("#advertiseId").hide();
				$("#linkUrls").hide();
				$("#shopId").hide();
				$("#keywords").hide();
		   	}
			if(type=='3'){
				$("#categoryId").hide();
				$("#productNo").hide();
				$("#advertiseId").hide();
				$("#linkUrls").show();
				$("#shopId").hide();
				$("#keywords").hide();
			}
			if(type=='4'){
				$("#categoryId").hide();
				$("#productNo").hide();
				$("#advertiseId").hide();
				$("#linkUrls").hide();
				$("#shopId").show();
				$("#keywords").hide();
			}
			if(type=='5'){
				$("#categoryId").hide();
				$("#productNo").hide();
				$("#advertiseId").show();
				$("#linkUrls").hide();
				$("#shopId").hide();
				$("#keywords").hide();
			 }
			 if(type=='6'){
				$("#categoryId").hide();
				$("#productNo").hide();
				$("#advertiseId").hide();
				$("#linkUrls").hide();
				$("#shopId").hide();
				$("#keywords").show();
				$("#adMultiple").html("关键词:");
			 }
			 if(type=='7'){
				$("#categoryId").hide();
				$("#productNo").hide();
				$("#advertiseId").hide();
				$("#linkUrls").hide();
				$("#shopId").hide();
				$("#keywords").show();
				$("#adMultiple").html("专区倍数:");
			 }
			 if(type=='8'){
				$("#categoryId").hide();
				$("#productNo").hide();
				$("#advertiseId").hide();
				$("#linkUrls").hide();
				$("#shopId").hide();
				$("#keywords").hide();
			}
		}
	</script>
	 <script>
        $(function(){
             $('.elect-show').click(function(){
                window.open('${ctxsys}/Product/list?stule=99','newwindow','height=500,width=800,top=100,left=300,toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no') ;
            });
             $('.elecb-show').click(function(){
                window.open('${ctxsys}/ebArticle/list?stule=99','newwindow','height=500,width=800,top=100,left=300,toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no') ;
            });
              $('.elecs-show').click(function(){
                window.open('${ctxsys}/PmShopInfo/list?stule=99','newwindow','height=500,width=800,top=100,left=300,toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no') ;
            });
            $('#menuId').bind('input propertychange', function() {  
		});  
        });
         function remoenpm(){
           document.getElementById('advertiseTypeObjId').value=''
           document.getElementById('imgsval').src='';
           document.getElementById('pname').innerHTML='';
         }
          function remoenpms(){
           document.getElementById('advertiseTypeObjId').value=''
           document.getElementById('imgsvals').src='';
           document.getElementById('pnames').innerHTML='';
         }
          function remoenpma(){
           document.getElementById('advertiseTypeObjId').value=''
           document.getElementById('imgsvala').src='';
           document.getElementById('pnamea').innerHTML='';
         }
    </script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctxsys}/EbAdvertise/list?layouttypeId=${ebAdvertise.layouttypeId}">广告列表</a></li>
		<li class="active"><a href="${ctxsys}/EbAdvertise/form?layouttypeId=${ebAdvertise.layouttypeId}">广告<shiro:hasPermission name="merchandise:EbArticle:edit">${not empty ebAdvertise.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="merchandise:EbArticle:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<p id="price" style="display:none;"></p>
	<form:form id="inputForm" style="position:relative" modelAttribute="ebAdvertise" action="${ctxsys}/EbAdvertise/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<form:hidden path="layouttypeId"/>
		<input id="advertiseTypeObjIds" name="advertiseTypeObjIds" type="hidden" value="${advertiseTypeObjIds}"/>
		<div style="position:absolute;top:0;right:0;"><img id="imgs" src="${ebLayouttypes.moduleDemoUrl}" style="width: 700px; height: 290px;"/></div>
		<tags:message content="${message}"/>
		<div class="control-group">
			<label class="control-label" for="name">广告名称:</label>
			<div class="controls">
				<form:input path="advertiseName" htmlEscape="false" maxlength="50" required="required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="name">广告标题:</label>
			<div class="controls">
				<form:input path="advertiseTitle" htmlEscape="false" maxlength="50" required="required"/>
			</div>
		</div>
		<div class="control-group" >
			<label class="control-label" for="href">广告类别:</label>
			<div class="controls">
				<form:select path="advertiseType" id="advertiseType" onchange="getwords(this.value)" class="input-medium" >
		           <form:option value="1">类别</form:option>
		           <form:option value="2">商品</form:option>
				   <form:option value="3">链接</form:option>
				   <form:option value="4">商家</form:option>
				   <form:option value="5">文章</form:option>
				   <form:option value="6">关键词</form:option>
				   <form:option value="7">专区倍数</form:option>
				   <form:option value="8">邀请好友</form:option>
               </form:select> 
			</div>
		</div>
		<div class="control-group" id="categoryId">
					<label class="control-label">商品所属类别：</label>
					 <div class="controls">
		              <tags:treeselect id="menu" name="advertiseTypeObjId" value="${ebAdvertise.advertiseTypeObjId}" labelName="advertiseTypeObjName" labelValue="${ebAdvertise.advertiseTypeObjName}"
					     title="菜单" url="${ctxsys}/PmProductType/treeData" extId="" cssClass="required"/> 
					</div> 
		</div>
		<div class="control-group" id="productNo">
			<label class="control-label" for="name">选择商品:</label>
			<div class="controls">
				<div class="xuan-img" >
					<div style="width:150px;height:100px;overflow:hidden;"><img id="imgsval" style="width:100%" src="${fn:split(ebAdvertise.ebProduct.prdouctImg, '|')[0]}"/></div>
					<p title="${ebAdvertise.ebProduct.productName}" id="pname" style="width:150px;margin-top:10px;overflow: hidden;text-overflow: ellipsis;white-space: nowrap;word-wrap: break-word;">${ebAdvertise.ebProduct.productName }</p>
				</div>
				<a class="elect-show btn" href="javascript:;">选择</a>
				<a class="btn" href="javascript:;" onclick="remoenpm()">清除</a>
			</div>
		</div>
		<div class="control-group" id="advertiseId">
			<label class="control-label" for="name">选择文章:</label>
			<div class="controls">
			<div class="xuan-img" >
					<div style="width:150px;height:100px;overflow:hidden;"><img id="imgsvala" style="width:100%" src="${ebAdvertise.ebArticle.adImg}"/></div>
					<p title="${ebAdvertise.ebArticle.articleTitle}" id="pnamea" style="width:150px;margin-top:10px;overflow: hidden;text-overflow: ellipsis;white-space: nowrap;word-wrap: break-word;">${ebAdvertise.ebArticle.articleTitle}</p>
				</div>
				<a class="elecb-show btn" href="javascript:;">选择</a>
				<a class="btn" href="javascript:;" onclick="remoenpma()">清除</a>
			</div>
		</div>
		<div class="control-group" id="shopId">
			<label class="control-label" for="name">选择商家:</label>
			<div class="controls">
			<div class="xuan-img" >
					<div style="width:150px;height:100px;overflow:hidden;"><img id="imgsvals" style="width:100%" src="${ebAdvertise.pmShopInfo.shopLogo}"/></div>
					<p title="${ebAdvertise.pmShopInfo.shopName}" id="pnames" style="width:150px;margin-top:10px;overflow: hidden;text-overflow: ellipsis;white-space: nowrap;word-wrap: break-word;">${ebAdvertise.pmShopInfo.shopName }</p>
				</div>
				<a class="elecs-show btn" href="javascript:;">选择</a>
				<a class="btn" href="javascript:;" onclick="remoenpms()">清除</a>
			</div>
		</div>
		<div class="control-group" id="linkUrls">
			<label class="control-label" for="name">链接:</label>
			<div class="controls">
				<form:input path="linkUrl" htmlEscape="false" maxlength="500" />
				<sapn></sapn>
			</div>
		</div>
		<div class="control-group" id="keywords">
			<label class="control-label" for="name" id="adMultiple">关键词:</label>
			<div class="controls">
				<form:input path="adKeyWord" htmlEscape="false" maxlength="500" />
				<sapn></sapn>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="name">广告图片:</label>
			<div class="controls">
			<form:hidden path="advertuseImg" htmlEscape="false" maxlength="100"  class="input-xlarge"/>
				<span class="help-inline" id="advertuseImg"  style="color: blue;"></span>
				<tags:ckfinder input="advertuseImg" type="images"  uploadPath="/merchandise/ebAdvertise"/>
			</div>
		</div>
		<div class="control-group" id="adcertuseDetailsd">
			<label class="control-label" for="sort">广告详情:</label>
			<div class="controls">
			 <form:textarea path="adcertuseDetails" id="adcertuseDetails" htmlEscape="false"/>
			<tags:ckeditor replace="adcertuseDetails" uploadPath="merchandise/ebAdvertise"></tags:ckeditor>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="icon">状态</label>
			<div class="controls">
			<form:select path="status" style="width: 100px;" class="input-medium">
		           <form:option value="0">开启</form:option>
		           <form:option value="1">隐藏</form:option>
					<form:option value="2">删除</form:option>
               </form:select>  
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="icon">否滚动显示</label>
			<div class="controls">
			<form:select path="isBack" style="width: 100px;" class="input-medium">
		           <form:option value="1">不滚动</form:option>
		           <form:option value="2">滚动 </form:option>
		            <form:option value="3">置顶滚动 </form:option>
               </form:select>  
               <span>置顶滚动,首页置顶滚动</span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="icon">排序</label>
			<div class="controls">
			 <form:input path="orderNo" htmlEscape="false" maxlength="500" required="required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="icon">热点</label>
			<div class="controls">
			<form:select path="pints" style="width: 100px;" class="input-medium">
			       <form:option value="2">不开启 </form:option>
		           <form:option value="1">开启</form:option>
               </form:select>  
               <span></span>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="merchandise:EbArticle:edit">
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;
			</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
	<!-- <div class="elect">
        <div class="elect-box">
            <p>商品选择 - 双击单号快速选择 <img class="elect-del" src="images/xxx-rzt.png" alt=""></p>
            <div class="elect-search">
                <span>商品名称：<input type="text"></span>
                <span>门店名称：<input type="text"></span>
                <a href="javascript:;">搜索</a>
            </div>
            <ul class="elect-ul-top">
                <li>图片</li>
                <li>商品名称</li>
                <li>商品价格</li>
                <li>品牌</li>
                <li>门店</li>
                <li>操作</li>
            </ul>
            <div class="elect-ul-box">
                <ul class="elect-ul-body">
                    <li>
                        <div>
                            <img src="images/lishi.png" alt="">
                        </div>
                    </li>
                    <li>衬衣一一</li>
                    <li>200</li>
                    <li>塔七</li>
                    <li>211门店</li>
                    <li><a href="javascript:;">选择</a></li>
                </ul>

                <ul class="elect-ul-body">
                    <li>
                        <div>
                            <img src="images/lishi.png" alt="">
                        </div>
                    </li>
                    <li>衬衣一一</li>
                    <li>200</li>
                    <li>塔七</li>
                    <li>211门店</li>
                    <li><a href="javascript:;">选择</a></li>
                </ul>

                <ul class="elect-ul-body">
                    <li>
                        <div>
                            <img src="images/lishi.png" alt="">
                        </div>
                    </li>
                    <li>衬衣一一</li>
                    <li>200</li>
                    <li>塔七</li>
                    <li>211门店</li>
                    <li><a href="javascript:;">选择</a></li>
                </ul>

                <ul class="elect-ul-body">
                    <li>
                        <div>
                            <img src="images/lishi.png" alt="">
                        </div>
                    </li>
                    <li>衬衣一一</li>
                    <li>200</li>
                    <li>塔七</li>
                    <li>211门店</li>
                    <li><a href="javascript:;">选择</a></li>
                </ul>

                <ul class="elect-ul-body">
                    <li>
                        <div>
                            <img src="images/lishi.png" alt="">
                        </div>
                    </li>
                    <li>衬衣一一</li>
                    <li>200</li>
                    <li>塔七</li>
                    <li>211门店</li>
                    <li><a href="javascript:;">选择</a></li>
                </ul>

                <ul class="elect-ul-body">
                    <li>
                        <div>
                            <img src="images/lishi.png" alt="">
                        </div>
                    </li>
                    <li>衬衣一一</li>
                    <li>200</li>
                    <li>塔七</li>
                    <li>211门店</li>
                    <li><a href="javascript:;">选择</a></li>
                </ul>
            </div>
            分页
            <div></div>
        </div>
    </div> -->
</body>
</html>