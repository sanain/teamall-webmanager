<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="robots" content="noarchive">
    <title>发布商品</title>
    <link rel="stylesheet" href="${ctxStatic}/supplyshop/css/release-comm-step.css">
    <link rel="stylesheet" href="${ctxStatic}/supplyshop/css/bootstrap.min.css"><%--
    <link rel="stylesheet" href="${ctxStatic}/supplyshop/css/build.css">
    --%><script src="${ctxStatic}/supplyshop/js/jquery.min.js"></script>
    <script src="${ctxStatic}/supplyshop/js/kkk.js"></script>
    <script src="${ctxStatic}/supplyshop/js/base_form.js"></script>
    <script src="${ctxStatic}/supplyshop/js/release_comm_step.js"></script>
    <script src="${ctxStatic}/supplyshop/layui/layui.js"></script>
	<script src="${ctxStatic}/jquery/jquery-migrate-1.1.1.min.js" type="text/javascript"></script>
	<script type="text/javascript" src="${ctxStatic}/ckeditor/ckeditor.js" ></script>
	<script type="text/javascript" src="${ctxStatic}/ckfinder/ckfinder.js"></script>
	<script src="${ctxStatic}/bootstrap/2.3.1/js/bootstrap.min.js" type="text/javascript"></script>
	<script src="${ctxStatic}/common/mustache.min.js" type="text/javascript"></script>
	<link href="${ctxStatic}/common/jqsite.min.css" type="text/css" rel="stylesheet" />
	<script src="${ctxStatic}/common/jqsite.min.js" type="text/javascript"></script>
	<script src="${ctxStatic}/ueditor/ueditor.config.js" type="text/javascript"></script>
	<script src="${ctxStatic}/ueditor/ueditor.all.js" type="text/javascript" ></script>
	<script type="text/javascript">
	 
	 $(window.parent.document).find('.list-ul').find('a').removeClass('hove');
     $(window.parent.document).find('.comm').siblings('ul').find('li:nth-child(1)').children('a').addClass('hove');
     $(window.parent.document).find('.list-ul').find('ul').slideUp();
     $(window.parent.document).find('.list-ul').find('a').removeClass('active');
	 var contextPath="${pageContext.request.contextPath}";

	 console.log(contextPath);
	 console.log("${ctxStatic}");
	 
	</script>
	<style>

        .run-ball-box{
            position: fixed;
            top: 0;
            right: 0;
            left: 0;
            bottom: 0;
            z-index: 111111;
            background: rgba(0,0,0,0.3);
        }
        .loadEffect {
            width: 100px;
            height: 100px;
            top: 50%;
            left: 50%;
            margin-top:-50px;
            margin-left: -50px;
            position: absolute;
        }
        .loadEffect div{
            width: 100%;
            height: 100%;
            position: absolute;
            -webkit-animation: load 2.08s linear infinite;
        }
        .loadEffect div span{
            display: inline-block;
            width: 20px;
            height: 20px;
            border-radius: 50%;
            background: #5988D8;
            position: absolute;
            left: 50%;
            margin-top: -10px;
            margin-left: -10px;
        }
        @-webkit-keyframes load{
            0%{
                -webkit-transform: rotate(0deg);
            }
            10%{
                -webkit-transform: rotate(45deg);
            }
            50%{
                opacity: 1;
                -webkit-transform: rotate(160deg);
            }
            62%{
                opacity: 0;
            }
            65%{
                opacity: 0;
                -webkit-transform: rotate(200deg);
            }
            90%{
                -webkit-transform: rotate(340deg);
            }
            100%{
                -webkit-transform: rotate(360deg);
            }

        }
        .loadEffect div:nth-child(1){
            -webkit-animation-delay:0.2s;
        }
        .loadEffect div:nth-child(2){
            -webkit-animation-delay:0.4s;
        }
        .loadEffect div:nth-child(3){
            -webkit-animation-delay:0.6s;
        }
        .loadEffect div:nth-child(4){
            -webkit-animation-delay:0.8s;
        }
    </style>
	<style>
	body .btn{
		background: #4778C7;
	    color: #fff;
	    padding: 3px 12px;
	    margin-right: 10px;
	}
	.logistics-li>.radio>input{top:4px;left:5px}
	.shop-news select{margin-bottom:10px;}
	.shop-pic{margin-bottom:25px;}
	.shop-pic ol{overflow:hidden;}
	.shop-pic ol li{float:left}
	.maijia-ul input[type=radio]{top:4px}
	.maijia-ul li{margin-bottom:10px}
	.shop-pic .btn{margin-bottom:20px;}
	body .shop-news ul{padding-bottom:0}
	.checkbox, .radio {margin:0}
	.col-md-12.ala>div.sb-xian{width:100%;padding-bottom: 20px;background: #ffffff;clear:both;margin-bottom:20px;border-radius: 3px;box-shadow: 0 0 7px rgba(0,0,0,0.1);}
.sb-xian>p{height: 35px;line-height: 35px;background: #f7f7f7;color: #4B4B4B;padding-left: 25px}
.sb-xian .checkbox{display: inline-block;    width: 100px;
    padding-left: 20px;}
    .sb-xian .checkbox input{top:5px;}
.sb-xian>ul{display:none}
.sb-xian ul li{border: 1px solid #eee;height: 40px;}
.sb-xian ul>li{padding-top:3px}
.sb-xian .checkbox i{top:4px;left:-19px}
.sb-xian ul li:nth-child(1)>span{position:relative;top:-9px}
.sb-xian ul li>span{display: inline-block;width: 100px;text-align: right;margin-right: 10px;height:30px;line-height:30px}
.sb-xian input[type=text]{outline: none;border: 1px solid #DCDCDC;padding: 0 10px;height: 30px;}
.sb-xian ul li:nth-child(2) input{width: 150px;}
.sb-xian ul li:nth-child(3) input{width: 60px;text-align: center;margin-right: 15px;}
.sb-xian ul li:nth-child(4) input{width: 60px;text-align: center;margin-right: 15px;}
.sb-xian-b b{display: inline-block;width: 100px;font-weight: normal;text-align: right;margin-right: 10px;}
.sb-xian-b{padding-bottom: 15px;margin-bottom: 20px;border-bottom: 1px solid #CCCCCC}
.sb-xian b{font-weight: normal}
.norm{display: inline-block;position: relative}
.norm>span{display: block;cursor: pointer;width: 200px;height: 30px;line-height: 30px;border: 1px solid #eee;padding-left: 10px;padding-right: 30px;background: url("../images/zhankai1.png") no-repeat 179px 11px;overflow: hidden; text-overflow: ellipsis; white-space: nowrap; word-wrap: break-word}
.norm-box{position: absolute;width: 350px;display: none}
.norm-box ul{width: 100%;border: 1px solid #DCDCDC;overflow:hidden}
.norm-box ul:nth-child(1){background: #f0f0f0;text-align: center;height: 30px;}
.norm-box ul li:nth-child(1){width: 60%;text-align: center}
.norm-box ul li:nth-child(2){width: 20%;text-align: center}
.norm-box ul li:nth-child(3){width: 20%;text-align: center}
.norm-box ul li{margin-bottom: 0;float:left;line-height:30px;}
.norm-box ul{background: #ffffff;margin-bottom: 0;}
.norm-box ul li{text-align: center;height: 30px;border-right: 1px solid #DCDCDC;color: #666666;cursor: pointer}
.pic-list{padding-left:25px;}
    </style>
     <style>
        .xiaye{display:none;position: fixed;top: 0;left: 0;right: 0;bottom: 0;background: rgba(0,0,0,0.3);z-index: 10000}
        .xiaye-box{position: absolute;width: 300px;height: 200px;background: #FFFFFF;border-radius: 3px;top: 50%;left: 50%;margin-left: -150px;margin-top: -100px;}
        .xiaye-box>p{ height: 40px;line-height: 40px;text-align: center;font-size: 16px;background: #F0F0F0;}
        .xiaye-txt{text-align: center; padding-top: 30px;}
        .xiaye-btn a{display: inline-block;width: 80px;height: 35px;background: #337ab7;color: #FFFFFF;line-height: 35px;margin-top: 30px;border-radius: 5px;}
    </style>
</head>
<body style="background: #f9f9f9">

 <div class="run-ball-box">
        <div class="loadE">
            <div class="loadEffect">
                <div><span></span></div>
                <div><span></span></div>
                <div><span></span></div>
                <div><span></span></div>
            </div>
        </div>
    </div>
    <div>
        <div class="head-nav">
            <ul>
           
                <li  <c:if test="${empty ebProduct.productTypeId }"> class="active" </c:if>>商品分类</li>
                <li  <c:if test="${not empty ebProduct.productTypeId }"> class="active" </c:if>>基本信息</li>
                <li>商品详情</li>
            </ul>
        </div>

        <!--content1商品分类-->
        <div class="content1">
            <div class="search-div">
                <!-- <div>
                    <input type="text" placeholder="手机数码">
                    <a href="javascript:;"></a>
                </div>-->
            </div> 

            <div class="list">
                <ul class="list-ul">
                    <c:forEach items="${pmProductTypes}" var="pmProductTypes">
                       <li><a href="javascript:;" onclick="getTypeTow(${pmProductTypes.id})"  >${pmProductTypes.productTypeName}</a></li>
                    </c:forEach>
                    <script type="text/javascript">
                    function FreightTemList(){
                      var FreightTem="${ebProduct.freightTempId}";
                        $.ajax({
				             type: "POST",
				             url: "${ctxweb}/supplyshop/pmShopFreightTem/jsonPmShopFreightTemList",
				             data: {},
				             success: function(data){
				             var html="<option value=''>请选择物流模板</option>";
				                for(var i=0;i<data.length;i++){
					                if(data[i].id==FreightTem){
					                 html+="<option value="+data[i].id+"  selected = 'selected' > "+data[i].templateName+"</option>";
					                }else{
					                html+="<option value="+data[i].id+"  > "+data[i].templateName+"</option>";
					                }
									}
									$(".FreightTem").html(html);
				                }
				            });
                    }
                    function litext(){
	                    var min="${fns:getDictValue('minRatio','gyconfig','')}";
	                    var max="${fns:getDictValue('maxRatio','gyconfig','')}";
						var text=$('.right-ul1 li:nth-child(1)');
						var html="";
						for(i=0;i<text.length;i++){
						  var s=$(text[i]).text();
							html+="<th>"+s+"</th>";
						}
						html+="<th>批发价格（元）</th><th>库存数量</th>";
					    $('thead').html(html);
						console.log($('.right-ul1').length)
					    $('tfoot').html("<tr><td colspan="+$('.right-ul1').length+">批量设置</td><td><input class='num1' type='text' data-did='1'></td><td><input class='num1' type='text' data-did='5'></td></tr>")
				    }
                   	function qusb(aaa){
						var n = []; //一个新的临时数组
						for(var i = 0; i < aaa.length; i++){
						if (n.indexOf(aaa[i]) == -1) n.push(aaa[i]);
						}
						return n;
					}
                        $(document).ready(function(){
                             FreightTemList();
	                         var listtype="${pmProductTypes[0].id}";
	                         getTypeTow(listtype);
	                         var country="${ebProduct.country}";
	                         var provincesId="${ebProduct.provincesId}";
	                         var municipalId="${ebProduct.municipalId}";
	                         var area="${ebProduct.area}";
	                         if(country!=null&&country!=""){
	                         oneji(country);
	                         towji(country,1,provincesId);
                             towji(provincesId,2,municipalId);
                             towji(municipalId,3,area);
	                         }else{
	                           country=10000000;
	                            oneji(country);
	                         }
	                         $("#city").hide();
	                         $("#province").hide();
	                         $(".radio").change(function() {
							  var $selectedvalue = $("input[name='li2']:checked").val();
							  if ($selectedvalue == 1) {
								 $(".statendTo").show();
								  $("#shop-standard").hide();
							   }else{
							      $("#shop-standard").show();
								  $(".statendTo").hide();
							     
							}
						  });
                          var val_payPlatform =$("input[name='li2']:checked").val();
                          if(val_payPlatform==1){
                              $(".statendTo").show();
							  $("#shop-standard").hide();
                           }else{
                              $("#shop-standard").show();
						      $(".statendTo").hide();
                           }
                           //修改是进入
                           var id="${ebProduct.productTypeId}";
                           getPingTow(id);
                           if(id!=null&&id!=''){
                           var idvs="${stands}";
                           var idvsName="${standsName}";
                           var idName=idvsName.split(";");
                           var ids=idvs.split(";");
                           var lesize="${lesize}";
                           var html="";
                           if(lesize==0){
                           		$('.table-div table').hide();
                           }
                           for(var i=0;i<lesize;i++){
                            if(ids[i]!=null&&ids[i]!=''){
                               var is= ids[i].split(":");
                               var isname= idName[i].split(":");
                               if(i==0){
                                var st1= qusb("${st1}".split(","));
                                 html+="<ul class='right-ul1'>";
                                 html+="<li>"+isname[0]+" <input type='hidden' value='"+is[0]+"'></li> <li>";
                                 for(var j=0;j<st1.length;j++){
                                 if(st1[j]!=null&&st1[j]!=""){
                                   var st1name=st1[j].split(":");
                                   html+="<span>"+st1name[1]+"<input type='hidden' name='attrId' value='"+st1name[0]+"'><b></b></span>";
                                   }
                                 }
                                 html+="<a  href='javascript:;'><img src='${ctxStatic}/supplyshop/images/add-a.png' alt=''></a></li></ul>";
                               }
                                if(i==1){
                                 var st2= qusb("${st2}".split(","));
                                 html+="<ul class='right-ul1'>";
                                 html+="<li>"+isname[0]+" <input type='hidden' value='"+is[0]+"'></li> <li>";
                                 for(var j=0;j<st2.length;j++){
                                 if(st2[j]!=null&&st2[j]!=""){
                                   var st2name=st2[j].split(":");
                                   html+="<span>"+st2name[1]+"<input type='hidden' name='attrId' value='"+st2name[0]+"'><b></b></span>";
                                   }
                                 }
                                 html+="<a  href='javascript:;'><img src='${ctxStatic}/supplyshop/images/add-a.png' alt=''></a></li></ul>";
                               }
                                if(i==2){
                                  var st3= qusb("${st3}".split(","));
                                 html+="<ul class='right-ul1'>";
                                 html+="<li>"+isname[0]+" <input type='hidden' value='"+is[0]+"'></li> <li>";
                                 for(var j=0;j<st3.length;j++){
                                 if(st3[j]!=null&&st3[j]!=""){
                                   var st3name=st3[j].split(":");
                                   html+="<span>"+st3name[1]+"<input type='hidden' name='attrId' value='"+st3name[0]+"'><b></b></span>";
                                   }
                                 }
                                 html+="<a  href='javascript:;'><img src='${ctxStatic}/supplyshop/images/add-a.png' alt=''></a></li></ul>";
                               }
                               }else{
                               
                               }
                             }
                             
                              $("#ss").after(html);
                              console.log(html)
                              litext();
                           }
						}); 
						function oneji(country){
						   $.ajax({
					             type: "POST",
					             url: "${ctxweb}/supplyshop/supplyShopproduct/onejij",
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
					             url: "${ctxweb}/supplyshop/supplyShopproduct/towjij",
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
									 }else  if(type=='2'){
									  $("#city").html(html);
									 }else{
									   $("#area").html(html);
									  }
					                }
					            });
						   }
						//请求二三级类别
                       function getTypeTow(typeId){
                          $.ajax({
					             type: "POST",
					             url: "${ctxweb}/supplyshop/supplyShopproduct/productType",
					             data: {id:typeId},
					            success: function(data){
					             var html='';
					                for(var i=0;i<data.length;i++){
					                     html+="<ul class='msg-ul'> <li>"+data[i].productTypeName+"</li><li><ul>";
					                     if(data[i].pmProductTypes!=null){
					                    	 for(var j=0;j<data[i].pmProductTypes.length;j++){
					                    		 if(data[i].pmProductTypes[j]!=null){
					                    			 html+="<li><a href='javascript:;'' onclick='getPingTow("+data[i].pmProductTypes[j].id+")'>"+data[i].pmProductTypes[j].productTypeName+"</a></li>";
					                    		 }
		                                           
		                                      }
					                     }
					                      
                                         html+="</ul></li></ul>";
										}
										$("#msg-div").html(html);
					                }
					            });
                           }
                      
                       function getPingTow(id){
                        $(".run-ball-box").show();
                        
                        $.ajax({
			             type: "POST",
			             url: "${ctxweb}/supplyshop/supplyShopproduct/productTypeId",
			             data: {id:id},
			             success: function(data){
								$("#messyuyu").html(data);
			                }
			              });
                         $("#typeId").val(id);
                         var options="";
                         var html="";
                         //请求品牌
                          $.ajax({
					             type: "POST",
					             url: "${ctxweb}/supplyshop/supplyShopproduct/productTypeBrand",
					             data: {id:id},
					             success: function(data){
					                html+="<ul><li>品牌：</li><li>";
					                html+="<select name='standarBraind_id'> <option value=''>请选择</option>";
					                var brandId="${ebProduct.brandId}";
					                for(var i=0;i<data.length;i++){
					                   if(brandId==data[i].id){
					                   html+=" <option value='"+data[i].id+"' selected = 'selected'>"+data[i].brandName+"</option>  ";
					                   }else{
					                   html+=" <option value='"+data[i].id+"'>"+data[i].brandName+"</option>  ";
					                   }
					                 }
					                 html+="</select>";
                                     html+="</li></ul>";
                                     //按照分类请求规格
		                             $.ajax({
							             type: "POST",
							             url: "${ctxweb}/supplyshop/supplyShopproduct/commerciale",
							             data: {id:id},
							             success: function(data){
							              var option='';
							              var spiltStr="${pmProductPropertyStandard.propertyStandardIdStr}";
							              if(spiltStr!=null&&spiltStr!=undefined){
							                 var spil= spiltStr.split(';');
							                }
							                var a=0;
							                for(var i=0;i<data.length;i++){
							                   if(data[i].spertAttrType=='2'){
							                   if(spil[a]!=null&&spil[a]!=undefined){
							                     var attr= spil[a].split(':');
							                      a++;
							                     }
								                  html+="<ul><li>"+data[i].spertAttrName+"：</li><input name='standard_id' type='hidden' value='"+data[i].id+"'/><li>";
								                  if(data[i].showType=='2'||data[i].showType=='3'){
								                     html+="<select name='standard_name'> <option value=''>请选择</option>";
									                   if(data[i].pmProductTypeSpertAttrValues!=null&&data[i].pmProductTypeSpertAttrValues!=undefined&&data[i].pmProductTypeSpertAttrValues.length>0){
									                    for(var j=0;j<data[i].pmProductTypeSpertAttrValues.length;j++){
									                       if(data[i].pmProductTypeSpertAttrValues!=null){
									                       if(attr!=null){
									                        if(attr[1]==data[i].pmProductTypeSpertAttrValues[j].id){
									                            html+=" <option value='"+data[i].pmProductTypeSpertAttrValues[j].id+"' selected = 'selected'>"+data[i].pmProductTypeSpertAttrValues[j].spertAttrValue+"</option>  ";
									                           }else{
									                            html+=" <option value='"+data[i].pmProductTypeSpertAttrValues[j].id+"'>"+data[i].pmProductTypeSpertAttrValues[j].spertAttrValue+"</option>  ";
									                           }
									                          }else{
									                             html+=" <option value='"+data[i].pmProductTypeSpertAttrValues[j].id+"'>"+data[i].pmProductTypeSpertAttrValues[j].spertAttrValue+"</option>  ";
									                          }
									                         }
									                      }
									                   }
								                        html+="</select>";
								                     }
								                   if(data[i].showType=='1'){
									                   if(data[i].pmProductTypeSpertAttrValues!=null){
									                     html+="<input name='standard_name' type='hidden' value=''/>";
									                     for(var j=0;j<data[i].pmProductTypeSpertAttrValues.length;j++){
									                      if(attr!=null){
									                       if(attr[1]==data[i].pmProductTypeSpertAttrValues[j].id){
									                         html+=" <div class='radio'><input name='chu"+data[i].id+"' type='radio' checked='checked' value='"+data[i].pmProductTypeSpertAttrValues[j].id+"'><label>"+data[i].pmProductTypeSpertAttrValues[j].spertAttrValue+"</label></div>";
								                            }else{
								                             html+=" <div class='radio'><input name='chu"+data[i].id+"' type='radio' value='"+data[i].pmProductTypeSpertAttrValues[j].id+"'><label>"+data[i].pmProductTypeSpertAttrValues[j].spertAttrValue+"</label></div>";
								                              }
									                         }else{
									                          html+=" <div class='radio'><input name='chu"+data[i].id+"' type='radio' value='"+data[i].pmProductTypeSpertAttrValues[j].id+"'><label>"+data[i].pmProductTypeSpertAttrValues[j].spertAttrValue+"</label></div>";
									                         }
									                        }
									                      }
									                   }
			                                        html+="</li></ul>";
			                                       
			                                        $("#property-div").html(html);
			                                        
							                     }else if(data[i].spertAttrType=='1'){
							                         var stru=0; 
							                         var stand="${stands}";
							                         if(stand!=null){
							                           var stands= stand.split(';');
							                           for(var j=0;j<stands.length;j++){
							                            var standse= stands[j].split(':');
							                            if(standse[0]==data[i].id){
							                               stru++;
							                             }else{
							                             
							                             }
							                            }
							                         }
							                         if(stand==''){
							                            option+="<li class=''><input type='checkbox' value='"+data[i].id+"'><label>"+data[i].spertAttrName+"</label></li>";
							                         }else{
								                         if(stru>0){
								                           option+="<li class='checkbox'><input type='checkbox' checked='checked' value='"+data[i].id+"'><label><i></i>"+data[i].spertAttrName+"</label></li>";
								                         }else{
								                          option+="<li class='checkbox'><input type='checkbox' value='"+data[i].id+"'><label><i></i>"+data[i].spertAttrName+"</label></li>";
								                         }
							                         }
							                      }
							                   }
						                      $("#add-stan").html(option);
						                      $(".run-ball-box").hide();
						                      if($('#add-stan input[type=checkbox]:checked').length==0){
                        						console.log($('.add-stan input[type=checkbox]:checked').length)
                        						$('.standard-right .right-ul1').remove();
                        						addtable();
                        					  }
						                      $("#property-div").append("<ul><li></li><li>填错商品属性，可能会引起商品下架，影响您的正常销售，请认真准确填写</li></ul>")
							                 }
							               });
					              
					                      }
					                 });
					            
                          }
                            //买家付运费<a class='avb' href='####'>查看运费模板</a> 
						    $('body').on('click','.logistics-li>div>input',function(){
						        console.log($('.logistics-li:nth-child(2) ul')[0]);
						        if ($('.maijia').attr('checked')&&$('.logistics-li:nth-child(2) ul')[0]==undefined){
						            var s="";
						            s+="<ul class='maijia-ul'><li><div class='radio'><input name='freightTempType' type='radio' value='1'><label>使用运费模板：</label>";
						            s+="<select class='FreightTem' name='freightTempId'>";
						            s+="</select>";
						            s+="  </div></li>  <li><div class='radio'> <input name='freightTempType' type='radio' value='2'>";
						            s+="<label>快递</label><input type='text' name='freightTempMoney' value=''> <span>元</span> </div> </li></ul>  ";     
						            $('.logistics-li:nth-child(2)').append(s);    
						             FreightTemList();           
						        }else if(!$('.maijia').attr('checked')){
						            $('.maijia-ul').remove();
						        }
						    });
						    $('body').on('click','.avb',function(){
						      window.open('${ctxweb}/supplyshop/pmShopFreightTem/pmShopFreightTemList','Derek','height=100,width=100,status=yes,toolbar=yes,menubar=no,location=no');
						    });
                    </script>
                   
                </ul>
                <div class="list-msg">
                    <div class="msg-div" id="msg-div">
                   
                    </div>
                    <div class="msg-pic">
                      
                    </div>
                </div>
                <div style="clear: both"></div>
            </div>
            <!--搜索列表-->
            <div class="search-list">
                <ul class="msg-ul">
                    <li>手机配件</li>
                    <li>
                        <ul>
                            <li><a href="javascript:;">iPhone配件</a></li>
                            <li><a href="javascript:;">保护套</a></li>
                            <li><a href="javascript:;">便携/无线音箱</a></li>
                            <li><a href="javascript:;">充电器/数据线</a></li>
                            <li><a href="javascript:;">储存卡</a></li>
                            <li><a href="javascript:;">贴膜</a></li>
                            <li><a href="javascript:;">电池/移动电源</a></li>
                            <li><a href="javascript:;">蓝牙耳机</a></li>
                            <li><a href="javascript:;">拍照配件</a></li>
                            <li><a href="javascript:;">手机耳机</a></li>
                            <li><a href="javascript:;">手机饰品</a></li>
                            <li><a href="javascript:;">手机支架</a></li>
                        </ul>
                    </li>
                </ul>
                <ul class="msg-ul">
                    <li>手机配件</li>
                    <li>
                        <ul>
                            <li><a href="javascript:;">iPhone配件</a></li>
                            <li><a href="javascript:;">保护套</a></li>
                            <li><a href="javascript:;">便携/无线音箱</a></li>
                            <li><a href="javascript:;">充电器/数据线</a></li>
                            <li><a href="javascript:;">储存卡</a></li>
                            <li><a href="javascript:;">贴膜</a></li>
                            <li><a href="javascript:;">电池/移动电源</a></li>
                            <li><a href="javascript:;">蓝牙耳机</a></li>
                            <li><a href="javascript:;">拍照配件</a></li>
                            <li><a href="javascript:;">手机耳机</a></li>
                            <li><a href="javascript:;">手机饰品</a></li>
                            <li><a href="javascript:;">手机支架</a></li>
                        </ul>
                    </li>
                </ul>
                <ul class="msg-ul">
                    <li>手机配件</li>
                    <li>
                        <ul>
                            <li><a href="javascript:;">iPhone配件</a></li>
                            <li><a href="javascript:;">保护套</a></li>
                            <li><a href="javascript:;">便携/无线音箱</a></li>
                            <li><a href="javascript:;">充电器/数据线</a></li>
                            <li><a href="javascript:;">储存卡</a></li>
                            <li><a href="javascript:;">贴膜</a></li>
                            <li><a href="javascript:;">电池/移动电源</a></li>
                            <li><a href="javascript:;">蓝牙耳机</a></li>
                            <li><a href="javascript:;">拍照配件</a></li>
                            <li><a href="javascript:;">手机耳机</a></li>
                            <li><a href="javascript:;">手机饰品</a></li>
                            <li><a href="javascript:;">手机支架</a></li>
                        </ul>
                    </li>
                </ul>
                <div style="clear: both"></div>
            </div>
            <div class="content1-a">
                <a class="step1" href="javascript:;">下一步</a>
            </div>
        </div>
       <form id="formId" action="${ctxweb}/supplyshop/supplyShopproduct/save" method="post">
         <!--content2基本信息-->
        <div class="content2" >
           
            <!--商品信息-->
            <div class="col-md-12 shop-news">
                <p>一、商品信息</p>

                    <ul>
                        <li>
                            <span class="new-span">商品名称：</span>
                            <input id="news1" class="input" name="productName"   type="text" maxlength="40" value="${ebProduct.productName}">
                            <b>（不超过40字）</b>
                        </li>
                        <li>
                            <span class="new-span">规格设置：</span>

                            <div class="radio">
                                <input  checked id="li2-1" name="li2" type="radio" <c:if test="${empty  pmProductStandardDetails}"> checked="checked" </c:if> value="1">
                                <label for="li2-1">统一规格</label>
                            </div>
                            <div class="radio">
                                <input id="li2-2" name="li2" type="radio" <c:if test="${not empty  pmProductStandardDetails}"> checked="checked" </c:if> value="2">
                                <label for="li2-2">多规格</label>
                            </div>
                        </li>
                        <li class="statendTo">
                            <span class="new-span">批发价格：</span>
                            <input class="num1 input bshi" name="wholesalePrice"   type="text" value="${ebProduct.wholesalePrice}">
                            <span>元</span>
                        </li>
                        
                        <li class="statendTo">
                            <span class="new-span">库存数量：</span>
                            <input class="num1 input" name="wholesaleStoreNums"   type="text" value="${ebProduct.wholesaleStoreNums}">
                        </li>
                        <li>
                            <span class="new-span">商家条形码：</span>
                            <input class="input"  type="text" name="barCode"  value="${ebProduct.barCode}">
                        </li>
                        <li>
                            <span class="new-span">所在地区：</span>
                            <select id="nationality" name="country"   onchange="towji(this.value,'1','')">
                            </select>
                            <select id="province" name="provincesId"   onchange="towji(this.value,'2','')">
                            </select>
                            <select id="city" name="municipalId"  onchange="towji(this.value,'3','')">
                            </select>
                             <select id="area" name="area" >
		                    </select>
                        </li>
                    </ul>
            </div>
            <input type="hidden" id="typeId" name="type" value="">
			<!--商品分类-->
            <div class="col-md-12 ala">
            	<div class="shop-classify">
            		<p>二、商品类别</p>
            		<div class="classify-div">
                    <p>商品所属类别: <span id="messyuyu"></span></p>
                    <span>商品在门店所选分类：</span>
                     <c:forEach items="${pmShopProductTypes }" var="pmShopProductTypes">
                    <ul>
                        <li>${pmShopProductTypes.productTypeName}</li>
                        <li>
                            <ul>
                            <c:forEach items="${pmShopProductTypes.pmShopProductTypes}" var="pmShopProductTypesLi">
                                <li class="radio">
                                    <input  type="radio" name="pmshoprodic" <c:if test="${fn:contains(ebProduct.shopProTypeIdStr,pmShopProductTypesLi.id)}"> checked="checked" </c:if> value="${pmShopProductTypesLi.id}">
                                    <label><i></i>${pmShopProductTypesLi.productTypeName}</label>
                                </li>
                                </c:forEach>
                            </ul>
                        </li>
                    </ul>
                    </c:forEach>
                	</div>
            	</div>
            	<!--商品主图-->
                <div class="shop-pic">
                    <p>三、商品图片</p>
                    <div class="pic-list">
                          <input type="hidden" name="advertuseImg" id="advertuseImg" value="${ebProduct.prdouctImg}"   htmlEscape="false" maxlength="100"  class="input-xlarge"/>
						  <span class="help-inline" id="advertuseImg"  style="color: blue;"></span>
						  <tags:ckfinder input="advertuseImg" type="images" selectMultiple="true" isDecDate="true" uploadPath="${empty ebProduct?'/temp':pic}"/>
                    </div>
                </div>
                <!--商品属性-->
                <div class="shop-property">
                    <p>四、商品属性</p>
                    <div class="property-div" id="property-div">
                     
                    </div>
                </div>
            	
            </div>
			
            
               
                
           
                <!--商品规格-->
            <div class="col-md-12 shop-standard" id="shop-standard">
                <p>五、商品规格</p>
                <div class="standard-tel">填错商品属性，可能会引起商品下架，影响您的正常销售。请认真准确填写</div>
              <div class="standard-left">
                    <p>选择规格：</p>
                    <ul id="add-stan">
                       
                    </ul>
                </div>
                <div class="standard-right">
                    <p id="ss">编辑规格值：</p>
                   
                </div>
                <!--编辑价格-->
                <div class="table-div">
                    <p>编辑价格/库存</p>
                   <table border="1">
                        <thead>
                            <th>颜色</th>
                            <th>批发价格（元）</th>
                            <th>库存数量</th>
                            
                        </thead>
                        <tbody>
                         <c:forEach items="${pmProductStandardDetails}" var="pmProductStandardDetail">
                            <tr>
                            <c:forEach items="${pmProductStandardDetail.strlust}" var="strlusts" varStatus="status">
                             <td data-t="${strlusts.id}">${strlusts.name}
                             <c:if test="${status.index==0}">
                              <input name="standard_id_str" type="hidden" value="${pmProductStandardDetail.idStr}">
                              </c:if>
                             </td>
                            </c:forEach>
                            <td><input class="num t-shi" name="wholesale_price" type="text"  value="${pmProductStandardDetail.wholesalePrice}"></td>
		                    <td><input class="num" name="wholesale_store_nums" type="text" value="${pmProductStandardDetail.wholesaleStoreNums}"></td>
                           
                            </tr>
                            </c:forEach> 
                            
                        </tbody>
                        <tfoot class="tfoot">
                            <tr>
                                <td colspan="1">批量设置</td>
                                <td><input class="num1" type="text" data-did="1"></td>
                                <td><input class="num1" type="text" data-did="5"></td>
                            </tr>
                        </tfoot>
                    </table>
                </div>
                <input id="kk" name="productId" type="hidden" value="${ebProduct.productId}"/>
                <!--帮助说明-->
                <div class="assist-div">
                    <p>帮助说明：</p>
                    <ul>
                        <li>1.批发价格为供应给${fns:getProjectName()}的卖价</li>
                    </ul>
                </div>
                
            </div>
            
            <div class="step-div">
                <a class="step2" href="javascript:;">上一步</a>
                <a class="step3" href="javascript:;">下一步</a>
            </div>
           
        </div>

        <!--content3商品详情-->
        <div class="content3">
            <div class="textare">
              <textarea name="productHtml" id="productHtml">${ebProduct.productHtml}</textarea>
			  <tags:ckeditor replace="productHtml" uploadPath="${pic}" isDecDate="true"></tags:ckeditor>
            </div>
            <div class="content3-a">
                <a id="y" class="step4" href="javascript:;">上一步</a>
                <a class="ssa" id="s" href="javascript:;"  onclick="sbumitObj()" >保存商品</a>
            </div>
        </div>
        <script type="text/javascript">
               function sbumitObj(){
               productHtmlCkeditor.updateElement(); 
               $(".run-ball-box").show();
               $.ajax({
	             type: "POST",
	             url: "${ctxweb}/supplyshop/supplyShopproduct/save",
	             data: $('#formId').serialize(),
	             success: function(data){
	                $(".run-ball-box").hide();
	                 if(data.code=='00'){
	                   $('.yanzhen-box div span').text(data.msg);
                       $('.yanzhen').show();
                       location.href='${ctxweb}/supplyshop/supplyShopproduct/list3';
	                  }else if(data.code=='01'){
	                   $('.yanzhen-box div span').text(data.msg);
                       $('.yanzhen').show();
	                  }
	                }
	            });
         }
        </script>
         </form>
        <!--添加规格-->
        <div class="guige">
            <div class="guige-box">
                <span>请输入规格：</span>
                <input type="text"><br>
                <a class="guige-box-remove" href="javascript:;">取消</a>
                <a class="guige-box-add" href="javascript:;">确认</a>

            </div>
        </div>
        <!--验证不通过-->
        <div class="yanzhen">
            <div class="yanzhen-box">
                <p>提示</p>
                <div><span>有选项没有填完，请继续填写！</span><br><a href="javascript:;">继续填写</a></div>
            </div>
        </div>
    </div>
    <script>
        $(function(){
        $('.sb-xian>ul li input').attr('readonly','readonly');
         var isLovePay="${ebProduct.isLovePay}";
       if(isLovePay==1){
       		$('.sb-xian>ul').show();
       		$('.sb-xian input[type=checkbox]').attr('checked','checked');
       }
            $('.norm>span').click(function(){
                $('.norm-box').show();
            });
            $('.sb-xian-b input').click(function(){
            	if($(this).is(':checked')){
            		$(this).closest('.sb-xian-b').siblings('ul').show();
            		
            	}else{
            		$(this).closest('.sb-xian-b').siblings('ul').hide();
            		
            	}
            })
            $('body').on('click','.sb-xian .norm-box ul:not(:nth-child(1))',function(){
            	$('.sb-xian>ul input').removeAttr('readonly');
            	var zd=parseFloat($(this).children('li:nth-child(3)').text());
            	var zx=parseFloat($(this).children('li:nth-child(2)').text());
            	var t1=$(this).children('li:nth-child(1)').text();
            	if(t1=='默认'){
            		$('.date1').removeClass('input').removeAttr('readonly').val('');
            		$('.date2').removeClass('input').removeAttr('readonly').val('');
            	}else{
            		t1=t1.split('~');
            		$('.date1').val(t1[0]).attr('readonly','readonly');
            		$('.date2').val(t1[1]).attr('readonly','readonly');
            	}
            	$('.zx').text(zx+'%~');
            	$('.zd').text(zd+'%');
            	$('.norm-box').hide()
            });
            
          //选择开始结束日期
            	layui.use('laydate', function() {
                var laydate = layui.laydate;

                var start = {
                    min: '1900-01-01 00:00:00'
                    , max: '2099-06-16 23:59:59'
                    , istoday: false
                    , choose: function (datas) {
                        end.min = datas; //开始日选好后，重置结束日的最小日期
                        end.start = datas //将结束日的初始值设定为开始日
                    }
                };

                var end = {
                    min: laydate.now()
                    , max: '2099-06-16 23:59:59'
                    , istoday: false
                    , choose: function (datas) {
                        start.max = datas; //结束日选好后，重置开始日的最大日期
                    }
                };

                $(document.getElementById('LAY_demorange_1')).click(function(){
                	if($(this).attr('readonly')){
                		
                	}else{
                		 start.elem = this;
                    laydate(start);
                	}
                   
                }) 
                $(document.getElementById('LAY_demorange_2')).click(function() {
                    
                    if($(this).attr('readonly')){
                		
                	}else{
                	end.elem = this
                    laydate(end);
                	}
                })
            })
            
            
            
            
            $('body').on('input propertychange','.x-in',function(){
            	this.value= this.value.match(/\d+(\.\d{0,2})?/) ? this.value.match(/\d+(\.\d{0,2})?/)[0] : '';
            	if($('.s-in').val()==""){
            		var zx=parseInt($($('.zx')[0]).text());
            		var tzx=$($('.zx')[0]).text();
            		var zd=parseInt($($('.zd')[0]).text());
            		var tz=parseFloat($(this).val());
            		var ttz=$(this).val();
            		console.log(ttz.length)
            		console.log(tzx)
            		if(ttz.length>=zx.length){
            			if(tz<zx||tz>zd){
            				$(this).val('')
            			}
            		}
            	}else{
            		var zx=parseInt($($('.zx')[0]).text());
            		var tzx=$($('.zx')[0]).text();
            		var dd=parseFloat($('.s-in').val());
            		var tz=parseFloat($(this).val());
            		var ttz=$(this).val();
            		
            		if(ttz.length>=zx.length){
            			if(tz<zx||tz>dd){
            				$(this).val('')
            			}
            		}
            	}
            });
            $('body').on('input propertychange','.s-in',function(){
            this.value= this.value.match(/\d+(\.\d{0,2})?/) ? this.value.match(/\d+(\.\d{0,2})?/)[0] : '';
            	if($('.x-in').val()==""){
            		var tzx=$($('.zx')[0]).text();
            		var ttz=$(this).val();
            		var zx=parseInt($($('.zx')[0]).text());
            		var zd=parseInt($($('.zd')[0]).text());
            		var tz=parseFloat($(this).val());
            		if(ttz.length>=zx.length){
            			if(tz<zx||tz>zd){
            				$(this).val('')
            			}
            		}
            	}else{
            		var zx=parseInt($($('.zx')[0]).text());
            		var tzx=$($('.zx')[0]).text();
            		var zd=parseInt($($('.zd')[0]).text());
            		var dd=parseFloat($('.x-in').val());
            		var ttz=$(this).val();
            		var tz=parseFloat($(this).val());
            		if(ttz.length>=zx.length){
            			if(tz<dd||tz>zd){
            				$(this).val('')
            			}
            		}
            	}
            })
          
        });
    </script>
    <div class="xiaye">
    <div class="xiaye-box">
        <p>提示</p>
        <div class="xiaye-txt">
            <span>确认进入下一页？</span>
            <div class="xiaye-btn">
                <a class="xiaye-del" href="javascript:;">取消</a>
                <a class="xiaye-a" href="javascript:;">确认</a>
            </div>
        </div>
    </div>
</div>
</body>
</html>