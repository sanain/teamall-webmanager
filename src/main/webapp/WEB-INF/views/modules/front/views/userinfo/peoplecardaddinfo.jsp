<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/front/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<meta name="decorator" content="frontdefault"/>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title></title>
	<meta name="keywords" content="" />
	<meta name="description" content="" />
	<link rel="stylesheet" type="text/css" href="${ctxStaticFront}/css/video-js.css" media="all" />
    <script type="text/javascript" src="${ctxStaticFront}/js/26f2fc0d.index.js"></script>
	<script type="text/javascript" src="${ctxStaticFront}/js/49f8daee.vendors.js"></script>
    <script type="text/javascript" src="${ctxStaticFront}/js/jquery.slider.js"></script>
	<script type="text/javascript" src="${ctxStaticFront}/js/power-slider.js"></script>
	<link rel="stylesheet" type="text/css" href="${ctxStaticFront}/css/select2.css" media="all" />
	<script type="text/javascript" src="${ctxStaticFront}/js/select2.min.js"></script>
	<script type="text/javascript" src="${ctxStaticFront}/js/dome.js"></script>
</head>

<body>


<div id="content" class="Mee"> 
				<div class="mefixd">
				<div class="menav">
					<div class="center">
						<ul>
								<li><a href="${ctx}/userinfo/baseinfo" class="on"><img src=""><p>个人信息</p></a></li>
								<li><a href="${ctx}/userinfo/attentioninfo"><img src=""><p>我的关注</p></a></li>
								<li><a href="${ctx}/userinfo/userregisterinfo"><img src=""><p>我的预约</p></a></li>
								<li><a href="${ctx}/userinfo/userconsultinfo"><img src=""><p>我的咨询</p></a></li>
								<!-- <li><a href="${ctx}/userinfo/reportinfo"><img src=""><p>我的报告</p></a></li>
								<li><a href="${ctx}/userinfo/useroutpatientinfo"><img src=""><p>我的门诊</p></a></li>
								<li><a href="${ctx}/userinfo/palyinfo" ><img src=""><p>我的缴费</p></a></li>  -->
								<li><a href="${ctx}/userinfo/orderinfo" ><img src=""><p>我的订单</p></a></li>
								<li><a href="${ctx}/userinfo/newscollectinfo"><img src=""><p>我的收藏</p></a></li>
									<!-- 	<li><a href=""><img src=""><p>健康记录评估</p></a></li> -->
								<!-- <li><a href="${ctx}/userinfo/healthFile""><img src=""><p>我的健康档案</p></a></li>
								<li><a href="${ctx}/xnh/init""><img src=""><p>新农合</p></a></li> -->
						</ul>
					</div>

					</div>

				</div>
				
				<div class="bar">
					<ul>
							<li><a href="${ctx}/userinfo/baseinfo" class="opacity">个人资料</a></li>
							<li><a href="${ctx}/userinfo/authinfo" class="opacity ">实名认证</a></li>
							<li><a href="${ctx}/userinfo/passwordinfo" class="opacity ">密码修改</a></li>
							<li><a href="${ctx}/userinfo/peoplecardinfo" class="opacity on">就诊卡管理</a></li>
					</ul>
				</div>
				<div class="met" >
                  <form class="zl" name="atmsgfrom" method = 'post' id="atmsgfrom" >
								<ul> 
								   <li><p class="l">就诊人</p><input type="text" id="pname"  name="pname" value="${userinfo.patientname}"  placeholder="输入姓名例如：张三" ></li>
								   <li><p class="l">联系电话</p><input type="text" id="ptelephone" value="${userinfo.mobileNo}" name="ptelephone"  placeholder="输入手机号码例如：13898989898" onmouseout="checkmobileno();" ></li>
								          <li><p class="l">性别</p>
								          <div class="wip" > 
									      	  <input type="radio" id="ipp1" name="Sex" value="1" checked="checked">
									        <label for="ipp1"></label>
								            <span>男</span>
							            </div>
							            
							            <div class="wip" > 
									      <input type="radio" id="ipp2" name="Sex" value="0">
									      <label for="ipp2"></label>
										  <span>女</span>
								         </div>
								      </li>
								    
								<li><p class="l">身份证号</p><input type="text" id="pid"  name="pid" value="${userinfo.cardid}" onmouseout="changeLac(this);"placeholder="输入身份证号码例如：500283199303175999"></li>
								<li><p class="l">就诊医院</p>
								<select value="" onchange="changeLac(this.value)" id="hospit" name="hospit" class="js-example-data-array" style="width: 513px;" >
								 <c:if test="${hosid == null or hosid == ' ' }"> 
								  <option value="" selected="selected"><a style=" color:#666; font-size:5px;">请选择医院</a></option>
								 </c:if>
								</select></li>
								<li id="selects"  style="display:block"><p class="l">就诊卡号</p><select value="" id="careno" name="carenoselect" style="width: 513px;size: 45px; height:45px;">
								<option value="" selected="selected">--------------------------------------请选择--------------------------------------</option>
								</select>
								</li>
								<li id="inputs" style="display:none"  ><p class="l">就诊卡号</p><input placeholder="输入就诊卡号例如：890080989" type="text" id="carenoinput"  name="careno" value="" ></li>
								
								<li id="msgbox" class="msg"  <c:if test="${msg == null}"> style="display:none" </c:if>>
								
									<div class="msg_err">
									<div class="msg_ct">
									<span><i class="icono-exclamation"></i></span>
									<p id="msgcontent">${msg}</p>
									</div>
									</div>
								</li>
								
								<input   id="rtids"  name="rtids" type="hidden" value="${rtIds}" >
						    	<li class="sb"><input id="button_submit"  type="submit"  onclick="return addCardInfo();" value="提交" ></li>


								</ul>
						</form>
   
		</div>
		
		
<script>
$(document).ready(function(){
   var hid= $("#hospit").val();
   if(hid.length>1){
   var hosismode=findhos(hid);
  if(hosismode.ismedicalcard!='1'){//医院不支持就诊卡，不用输入就诊卡
         $("#inputs").hide();
         $("#selects").hide(); 
      } 
      
      
    if(hosismode.ismedicalcard=='1'){//医院不支持就诊卡，不用输入就诊卡
      if(hosismode.hisInterfaceType=='1'){//接口类型为1 陶思乐原有接口
      $("#inputs").show();
      $("#selects").hide();
      }
      
      }   
   }
})
</script>		
<script>
 function addCardInfo(){
	    if(buttonsubmit()){
				 	var form=$("#atmsgfrom");
				 	var rtId=$("#rtids").val();
				 	
				 	$.ajax({
					 	type: "POST",
							url: "${ctx}/userinfo/addcardinfo", //这是跳转目标地址
							data: form.serialize(),//将form表单内容序列化
							cache:false,
							async: false, //表示异步传输
							success: function(jsonJson){// jsonJson表示返回的数据
									if(jsonJson.success){
									   if(rtId!=""&&rtId!=null){//跳转回预约确认页面
									   window.location.href=jsonJson.url;
									   layer.msg(jsonJson.msg);
									    }
									  else{
									   window.location.href="${ctx}/userinfo/peoplecardinfo";  //跳转至就诊卡列表
									   layer.msg(jsonJson.msg);
									    }
									
								}else{
								   layer.msg(jsonJson.msg);
									}
							}
						});
					 	
		 				 return false;
	 			 }
	 			  return false;
 }
</script>
<script>
        function reproving() { //验证身份证
            var code=$("#pid").val().toUpperCase();
            $("#pid").val(code);
            var city={11:"北京",12:"天津",13:"河北",14:"山西",15:"内蒙古",21:"辽宁",22:"吉林",23:"黑龙江 ",31:"上海",32:"江苏",33:"浙江",34:"安徽",35:"福建",36:"江西",37:"山东",41:"河南",42:"湖北 ",43:"湖南",44:"广东",45:"广西",46:"海南",50:"重庆",51:"四川",52:"贵州",53:"云南",54:"西藏 ",61:"陕西",62:"甘肃",63:"青海",64:"宁夏",65:"新疆",71:"台湾",81:"香港",82:"澳门",91:"国外 "};
            var tip = "";
            var pass= true;
            if(!code || !/^\d{6}(18|19|20)?\d{2}(0[1-9]|1[0-2])(0[1-9]|[12]\d|3[01])\d{3}(\d|X)$/i.test(code)){
                tip = "身份证号格式错误！";
                pass = false;
               $("#msgbox").show();
               $("#msgcontent").text(tip);
               return false;
                
            }
            
           else if(!city[code.substr(0,2)]){
                tip = "身份证号输入有误！";
                pass = false;
                $("#msgbox").show();
                $("#msgcontent").text(tip);
               return false;
            }
            else{
                //18位身份证需要验证最后一位校验位
                if(code.length == 18){
                    code = code.split('');
                    //∑(ai×Wi)(mod 11)
                    //加权因子
                    var factor = [ 7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2 ];
                    //校验位
                    var parity = [ 1, 0, 'X', 9, 8, 7, 6, 5, 4, 3, 2 ];
                    var sum = 0;
                    var ai = 0;
                    var wi = 0;
                    for (var i = 0; i < 17; i++)
                    {
                        ai = code[i];
                        wi = factor[i];
                        sum += ai * wi;
                    }
                    var last = parity[sum % 11];
                    if(parity[sum % 11] != code[17]){
                        pass =false;
                         tip = "身份证号输入有误！";
		                $("#msgbox").show();
		                $("#msgcontent").text(tip);
		                return false;
                        
                    }
                }
            }
            if(pass){
             $("#msgbox").hide();
              return true;
            }
        }
</script>
 <script>

  function  checkmobileno(){//输入手机号码的时候验证
     var ptelePhone=$("#ptelephone").val();
     var phoneregexr=/^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1})|(17[0-9]{1}))+\d{8})$/;
       
         if(ptelePhone==""){
         $("#msgbox").show();
               $("#msgcontent").text("输入的手机号不能为空！");
               return false;
         }
        else if(ptelePhone.length>11){
                $("#msgbox").show();
				$("#msgcontent").text("手机号码位数不正确，请仔细检查！");
				return false;
			}
		 else if(!phoneregexr.test(ptelePhone)){
	             $("#msgbox").show();
	             $("#msgcontent").text("输入的手机号码有误！");
	             return false;
         } 
       else{
              $("#msgbox").hide();
              return true;
       }
   }

 </script>

<script type="text/javascript">


if($("#careno option").size() < 2){
		$('#careno').attr("disabled","desabled");
	}
  function changeLac(v) {
   
     var pname=$("#pname").val();
     var pcarid=$("#pid").val();
     var hid= $("#hospit").val();
     var hosismode=findhos(hid);
   if(reproving()){ //身份证号码通过验证  
     if(hosismode.ismedicalcard!='1'){//医院不支持就诊卡，不用输入就诊卡
         $("#inputs").hide();
         $("#selects").hide(); 
      } 
      
  if(hosismode.ismedicalcard=='1'){//医院支持就诊卡，必须输入或选择就诊卡
     
     if(pname!=null&&pname!=""&&pcarid!=null&&pcarid!=""&&hid!=null&&hid!=""){
     if(hosismode.hisInterfaceType=='1'){//接口类型为1 陶思乐原有接口
      $("#inputs").show();
      $("#selects").hide();
      return true;
     }
     layer.load(2);
      //此处演示关闭
     setTimeout(function(){
     layer.closeAll('loading');}, 2000);
    jQuery('#careno').html(""); //把ci内容设为空  
    var ciValue = jQuery('#careno');  
    ciValue.append('<option value="0">--------------------------------------请选择--------------------------------------</option>');  
   	   $("#careno").css({"background":"#fff url(${ctxStaticFront}/images/selectLoad.gif) no-repeat 84% 50%"});    
    //异步请求查询ci列表的方法并返回json数组  
    jQuery.ajax({  
        url : '${ctx}/userinfo/doCardInfoList',  
        type : 'post',  
        data : { patientName : $("#pname").val(),patientIdcardNo: $("#pid").val(),hospitalId: $("#hospit").val() },  
        dataType : 'json',  
        success : function (opts) {
            if (opts && opts.length > 0) {  
                    var html = []; 
                    $("#inputs").hide();
                    $("#selects").show(); 
                    for (var i = 0; i < opts.length; i++) { 
                        html.push('<option value="'+opts[i].medicareno+"|"+opts[i].patientno+'">'+opts[i].medicareno+'</option>');  
                    }  
                    ciValue.append(html.join(''));  
                    $("#careno").removeAttr("disabled");  
                    $("#careno").css({"background":"#fff"});  
                }else{
                      /* layer.alert('系统中未查询到您选中医院就诊卡信息，请重新选择医院或手动输入就诊卡号'); */
                      $("#selects").hide();
                      $("#inputs").show();
                	  $("#careno").css({"background":"#D6D6D6"});  
                	  $('#careno').attr("disabled","desabled");
                }  
            }  
        });  
        
        
        }
    
	   }//结束验证   
	 } 
	    
}  







$(".menav li").each(function(a){ 

		var me = $(".menav li:eq("+a+")"),i=a+1;
		if(me.find("a").hasClass("on")){ 
				me.find("img").attr("src","${ctxStaticFront}/images/me_"+i+"h.png")
		}else{ 
			me.find("img").attr("src","${ctxStaticFront}/images/me_"+i+".png")
		}
		
		me.hover(function(){ 
			
			me.find("img").attr("src","${ctxStaticFront}/images/me_"+i+"h.png")
		},function(){ 
			if(!me.find("a").hasClass("on")){ 
				me.find("img").attr("src","${ctxStaticFront}/images/me_"+i+".png")
			}
			

		})
})



$(".swch a").each(function(a){ 
			$(".swch a:eq("+a+")").click(function(){ 
					if(!$(".swch a:eq("+a+")").hasClass("on")){
						$('.me_qh ul').removeClass("on")
						$('.me_qh ul:eq('+a+')').addClass("on")	
						$(".swch a").removeClass("on")
						$(".swch a:eq("+a+")").addClass("on")
						if(a==1){ 
							$(".secbg").show()
						}else{

							$(".secbg").hide()
						}
					}
			})
	


})
   
 var data =${hospitaljson};
  $(".js-example-data-array").select2({
  
  placeholder: '请选择医院',
  allowClear: true ,
  data: data
});

</script>
<script type="text/javascript">
        
       function  buttonsubmit(){ 
            var pcarids=$("#pid").val();
            var pnames = $("#pname").val(); 
            var carenos = $("#careno").val();
            var hospits = $("#hospit").val();
            var carenoinputs = $("#carenoinput").val();
            var ptelephones = $("#ptelephone").val();
            
            var reg=/^[1-9]{1}[0-9]{14}$|^[1-9]{1}[0-9]{16}([0-9]|[xX])$/;
            var phoneregexr=/^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1})|(17[0-9]{1}))+\d{8})$/;
        /*     if(carenoinputs!=""||carenoinputs!=0){
            var html = []; 
             html.push('<option value="'+opts[i].medicareno+'">'+opts[i].medicareno+'</option>');
            } */
                
            if(ptelephones==""){
                $("#msgbox").show();
                $("#msgcontent").text("电话号码不能为空！");
            	return false;
            }
             else if(ptelephones.length>11){
                $("#msgbox").show();
				$("#msgcontent").text("手机号码位数不正确，请仔细检查！");
				return false;
			}
            else   if(pcarids==""){
                $("#msgbox").show();
                $("#msgcontent").text("身份证号码不能为空！");
            	return false;
            }
                        
           else  if(pnames==""){
            	 $("#msgbox").show();
                $("#msgcontent").text("就诊人不能为空！");
            	return false;
            }
            
            else  if(hospits==""){
            	 $("#msgbox").show();
                $("#msgcontent").text("医院未选择！");
            	return false;
            }
            
             else  if(!reproving()){
               reproving();
               return false;
            }
             else if (!phoneregexr.test(ptelephones)) {
			   $("#msgbox").show();
               $("#msgcontent").text("输入的电话号码有误!");
				return false;
							}
			else if($("#inputs").is(':visible')){//输入就诊卡验证
			   if(carenoinputs==""||carenoinputs==0){
			     $("#msgbox").show();
                 $("#msgcontent").text("就诊卡不能为空！");
				 return false;
			    }
			 else {
               return true;
                }
			   }
		    else if($("#selects").is(':visible')){//选择就诊卡验证
			   if(carenos==""||carenos==0){
			     $("#msgbox").show();
                 $("#msgcontent").text("请选择就诊卡！");
				 return false;
			    }
			 else {
               return true;
                }
			   }
			   
			/*  else { return true;}
			  }				 */
			  			
            else {
               return true;
              
             }
            
            
           
          /*    if(carenos==""||carenos==0){
            	 $("#msgbox").show();
                $("#msgcontent").text("就诊卡号不能为空！");
            	return false;
            }
            
             if(!reg.test(pcarids)){
               $("#msgbox").show();
               $("#msgcontent").text("输入的身份证号有误");
               return false;
            } */
}        
   
</script>
<script>
function findhos(hosid){
var hosId=hosid;
var ismed="";
$.ajax({
	 	type: "POST",
			url: "${ctx}/userinfo/gethospital?hosptialid="+hosId, //这是跳转目标地址
			cache:false,
			async: false, //表示异步传输
			success: function(jsonJson){// jsonJson表示返回的数据
				if(jsonJson.success){
				     ismed=jsonJson.msg;
				}else{
				  /*  layer.msg(jsonJson.msg); */
					}
			}
		});
     return ismed;
}
</script>

</body>
</html>
