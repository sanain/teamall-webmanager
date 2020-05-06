<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="robots" content="noarchive">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0,minimal-ui">
    <title>地址管理</title>
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/site-manage.css">
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/bootstrap.min.css">
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/build.css">
    <script src="${ctxStatic}/sbShop/js/jquery.min.js"></script>
    <script src="${ctxStatic}/sbShop/js/base_form.js"></script>
    <script src="${ctxStatic}/sbShop/js/site-manage.js"></script>
    <script src="${ctxStatic}/sbShop/js/kkk.js"></script>
    <script>
    $(window.parent.document).find('.list-ul').find('ul').slideUp();
    $(window.parent.document).find('.list-ul').find('a').removeClass('active');
    </script>
    <script type="text/javascript">
    $(function(){
        $('body').on('click','.adda1',function(){
        var anum=$('.site-new').offset().top;
        $('body,html').animate({ scrollTop: anum }, 700);
        });
    })
     $(document).ready(function(){
       var pmShopDepotAddress="${pmShopDepotAddress}";
        if(pmShopDepotAddress!=null){
	        var anum=$('.site-new').offset().top;
	        /* $('body,html').animate({ scrollTop: anum }, 700); */
         }
     var country="${pmShopDepotAddress.country}";
     if(country!=null&&country!=""){
        var telephoneNumber="${pmShopDepotAddress.telephoneNumber}";
         var tele= telephoneNumber.split("_");
         $("#qu").val(tele[0]);
         $("#mo").val(tele[1]);
         $("#fq").val(tele[2]);
     }else{
       country=10000000;
     }
      oneji(country);
      var provincesId="${pmShopDepotAddress.province}";
      towji(country,1,provincesId);
      var municipalId="${pmShopDepotAddress.city}";
      towji(provincesId,2,municipalId);
      var area="${pmShopDepotAddress.area}";
      towji(municipalId,3,area);
     })
    function oneji(country){
	   $.ajax({
             type: "POST",
             url: "${ctxweb}/shop/product/onejij",
             data: {},
             success: function(data){
             if(country==10000000){
                  $("#province").hide();
                  $("#city").hide();
                  $("#area").hide();
             }
             var html="<option value=''>请选择国家</option>";
                for(var i=0;i<data.length;i++){
	                if(data[i].id==country){
	                  html+="<option value="+data[i].id+"  selected = 'selected' > "+data[i].districtName+"</option>";
	                 }else{
	                  html+="<option value="+data[i].id+"  > "+data[i].districtName+"</option>";
	                 }
					}
					$("#nationality").html(html);
                }
            });
	   }
	   function towji(id,type,nextId){
	   $.ajax({
             type: "POST",
             url: "${ctxweb}/shop/product/towjij",
             data: {id:id},
             success: function(data){
                if(type=='1'){
                  var html="<option value=''>请选择省</option>";
	                 if(data==undefined || data=="" || data==null){
	                  $("#province").hide();
	                  }else{
	                  $("#province").show();
	                  }
                 }else if(type=='2'){
                   var html="<option value=''>请选择市</option>";
                    if(data==undefined || data=="" || data==null){
	                  $("#city").hide();
	                  }else{
	                  $("#city").show();
	                  }
                 }else{
                    var html="<option value=''>请选择区</option>";
                    if(data==undefined || data=="" || data==null){
	                  $("#area").hide();
	                  }else{
	                  $("#area").show();
	                  }
                 }
                for(var i=0;i<data.length;i++){
                   if(nextId==data[i].id){
                      html+="<option value="+data[i].id+" selected = 'selected'> "+data[i].districtName+"</option>";
                     }else{
                      html+="<option value="+data[i].id+"> "+data[i].districtName+"</option>";
                     }
					}
				 if(type=='1'){
				  $("#province").html(html);
				 }else if(type=='2'){
				  $("#city").html(html);
				 }else{
				  $("#area").html(html);
				 }
                }
            });
		}
		function deleteOb(ob,saleId){
			var saleId=$('#saleId').val();
			var bh="";
			if(saleId!=''&&saleId!=undefined){
				 bh="${ctxweb}/shop/shopInfo/delete?view=1&saleId='"+saleId+"'&id="+ob;
			}else{
				bh="${ctxweb}/shop/shopInfo/delete?id="+ob;
			}
		 $('.delete-yes').attr('href',bh);
		}
    </script>

    <style type="text/css">
        #save{
            background: #393D49;
        }
        a{
            color:#009688;
        }

        a:hover{
            color:#009688;
        }
    </style>
</head>
<body>
    <div class="site">
    <c:if test="${view==1}">
    	<div class="crumbs-div">
            <span>您的位置：</span>
            <a href="${ctxweb}/shop/ReturnManagement/ReturnManagementList" target="tager">首页</a>>
            <a href="${ctxweb}/shop/ReturnManagement/ReturnManagementList" target="tager">退款管理</a>>
            <a href="${ctxweb}/shop/ReturnManagement/ReturnManagementForm?id=${saleId}" target="tager">退款详情</a>>
            <a href="${ctxweb}/shop/ReturnManagement/refundAgree?saleId=${saleId}" target="tager">同意退款申请</a>>
            <span>添加退货地址</span>
        </div>
    </c:if>
        <p>
            <b>已保存地址（共<span>${fn:length(pmShopDepotAddressList)}</span>条）</b>
            <span>最多保存10条</span>
           
        </p>
        
        <form id="saveAddress" action="${ctxweb}/shop/shopInfo/saveAddress" method="post">
        <input id="saleId" name="saleId" type="hidden" value="${saleId}"/>
        <input id="id" name="id" type="hidden" value="${pmShopDepotAddress.id}"/>
        <input id="view" name="view" type="hidden" value="${view}"/>
        <div class="site-new">
            <p>新增地址</p>
            <ul>
                <li><b>*</b>所在地区：</li>
                <li>
                    <select id="nationality" name="country" onchange="towji(this.value,'1','')" required="required">
                        <option value="">国家</option>
                    </select>
                    <select id="province" name="provincesId" onchange="towji(this.value,'2','')"  >
                        <option value="">省份</option>
                    </select>
                    <select id="city" name="municipalId"  onchange="towji(this.value,'3','')" >
                        <option value="">地级市</option>
                    </select>
                    <select id="area" name="area" >
                        <option value="">区/县</option>
                    </select>
                </li>
            </ul>
            <ul>
                <li><b>*</b>详细地址：</li>
                <li>
                    <input type="text" name="detailAddress" value="${pmShopDepotAddress.detailAddress}" required="required">
                </li>
            </ul>
            <ul>
                <li><b>*</b>联系人：</li>
                <li>
                    <input type="text" name="contactName" value="${pmShopDepotAddress.contactName}"  required="required">
                </li>
            </ul>
            <ul>
                <li><b>*</b>手机号码：</li>
                <li>
                    <input class="num" type="text" name="phoneNumber" value="${pmShopDepotAddress.phoneNumber}" required="required">
                </li>
            </ul>
            <ul>
                <li>固定电话：</li>
                <li>
                    <input class="num" id="qu" name="qu" placeholder="区号" type="text">
                    <span>-</span>
                    <input class="num" id="mo" name="mo" placeholder="电话号码" type="text">
                    <span>-</span>
                    <input class="num" id="fq" name="fq" placeholder="分区号（可选）" type="text">
                </li>
            </ul>
            <ul>
                <li></li>
                <li class="checkbox1">
                    <input id="moren" type="checkbox" name="isDefault" value="1"  <c:if test="${pmShopDepotAddress.isDefault==1}">  checked</c:if> >
                    <label for="moren" style="font-weight:normal">设为默认地址</label>
                </li>
            </ul>
            <ul>
                <li></li>
                <li>
                    <button class="btn btn-primary" type="submit" id="save"> 保存</button>
                </li>
            </ul>
        </div>
        </form>
        <div class="site-list">
            <ul class="list-top">
                <li>地址</li>
                <li>联系人</li>
                <li>联系电话</li>
                <li>操作</li>
            </ul>
            <c:forEach items="${pmShopDepotAddressList}" var="ShopDepotAddressList">
            <ul class="list-body  <c:if test="${ShopDepotAddressList.isDefault==1}">active</c:if>">
                <li>
                    <span>${ShopDepotAddressList.countryName}</span><span>${ShopDepotAddressList.provinceName}</span><span>${ShopDepotAddressList.cityName}</span><span>${ShopDepotAddressList.areaName}</span><span>${ShopDepotAddressList.detailAddress}</span>
                </li>
                <li>${ShopDepotAddressList.contactName}</li>
                <li>${ShopDepotAddressList.phoneNumber}</li>
                <li>
                    <a class="adda" href="${ctxweb}/shop/shopInfo/form?view=1&saleId=${saleId}&id=${ShopDepotAddressList.id}">编辑</a>
                    <b>|</b>
                    <a class="delete-a" href="javascript:;" onclick="deleteOb(${ShopDepotAddressList.id})">删除</a>
                    <b>|</b>
                     <c:if test="${ShopDepotAddressList.isDefault==1}">设为默认</c:if>
                     <c:if test="${ShopDepotAddressList.isDefault==0}"><a class="mo-a" href="${ctxweb}/shop/shopInfo/saveAddress?view=1&saleId=${saleId}&id=${ShopDepotAddressList.id}&se=1">设为默认</a></c:if>
                    
                </li>
            </ul>
            </c:forEach>
        </div>
    </div>
    <!--是否删除-->
    <div class="delete">
        <div class="delete-box">
            <p>提示 <img class="delete-del" src="${ctxStatic}/sbShop/images/xxx-rzt.png" alt=""></p>
            <div>
                <p>确定要删除该数据吗？</p>
                <a class="delete-yes" href="">确定</a>
                <a class="delete-del" href="javascript:;">取消</a>
            </div>
        </div>
    </div>
</body>
</html>