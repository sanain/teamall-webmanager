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
								<li><a href="${ctx}/userinfo/palyinfo" ><img src=""><p>我的缴费</p></a></li> -->
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
                  <form class="zl" name="atmsgfrom" method = 'post'  action ='${ctx}/userinfo/peoplecardinfo?opid=4&upno=${userHospitalmsges.upid}' >
								<ul> 
								 <li><p class="l">就诊人</p><input type="text" id="pname"  name="pname" value="${userHospitalmsges.patientname}" placeholder="输入姓名例如：张三"></li>
								  <li><p class="l">联系电话</p><input type="text" id="ptelephone"  name="ptelephone" value="${userHospitalmsges.patienttelephone}" placeholder="输入手机号码例如：13898989898" onmouseout="checkmobileno();" ></li>
								 <c:if test="${empty  userHospitalmsges.patientsex}">
								         <li>
								         <p class="l">性别</p>
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
								  </c:if>
								   
								 <c:if test="${userHospitalmsges.patientsex=='1'}">
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
								      </c:if>
								      
								    <c:if test="${userHospitalmsges.patientsex=='0'}">
								      <li><p class="l">性别</p>
								          <div class="wip" > 
									        <input type="radio" id="ipp1" name="Sex" value="1" >
									        <label for="ipp1"></label>
								            <span>男</span>
							              </div>
							            
							           <div class="wip" > 
									      <input type="radio" id="ipp2" name="Sex" value="0" checked="checked">
									      <label for="ipp2"></label>
										  <span>女</span>
								       </div>
								       </li>
								    </c:if>
								    
								<li><p class="l">身份证号</p><input type="text" id="pid"  name="pid" value="${userHospitalmsges.patientidcardno}"  onmouseout="reproving()" placeholder="输入身份证号码例如：500283199303175999"></li>
								<li><p class="l">就诊医院</p><select id="hospit" name="hospit"  class="js-example-data-array"  style="width: 513px;"></select></li>
								<li><p class="l">就诊卡号</p><input type="text" id="careno"  name="careno" value="${userHospitalmsges.medicareno}" placeholder="输入就诊卡号例如：890080989"></li>
								<li id="msgbox" class="msg"  <c:if test="${msg == null}"> style="display:none" </c:if>>
									<div class="msg_err">
									<div class="msg_ct">
									<span><i class="icono-exclamation"></i></span>
									<p id="msgcontent">${msg}</p>
									</div>
									</div>
								</li>
						    	<li class="sb"><input id="button_submit"  type="submit" value="提交" ></li>


								</ul>
						</form>
   
		      </div>

		</div>
	
		
		
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
  data: data
})
</script>

<script type="text/javascript">
	 $(document).ready(function(){  
        $("#button_submit").click(function(){  
            var pids = $("#pid").val();  
            var pnames = $("#pname").val(); 
            var carenos = $("#careno").val();
            var hospits = $("#hospit").val();
            var reg=/^[1-9]{1}[0-9]{14}$|^[1-9]{1}[0-9]{16}([0-9]|[xX])$/;
             
            if(pids==""){
                $("#msgbox").show();
                $("#msgcontent").text("身份证号码不能为空！");
            	
            	return false;
            }
            
           else  if(!reproving()){
               reproving();
               return false;
            }
           else if(pnames==""){
            	 $("#msgbox").show();
                $("#msgcontent").text("就诊人不能为空！");
            	return false;
            }
          /* else  if(carenos==""){
            	 $("#msgbox").show();
                $("#msgcontent").text("就诊卡号不能为空！");
            	return false;
            } */
            else if(hospits==""){
            	 $("#msgbox").show();
                $("#msgcontent").text("医院未选择！");
            	return false;
            }
        }); 
        
    });  
     
</script>


</body>
</html>
