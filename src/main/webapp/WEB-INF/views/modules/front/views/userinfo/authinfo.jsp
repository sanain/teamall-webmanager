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
								<li><a href="${ctx}/userinfo/reportinfo"><img src=""><p>我的报告</p></a></li>
								<li><a href="${ctx}/userinfo/useroutpatientinfo"><img src=""><p>我的门诊</p></a></li>
								<li><a href="${ctx}/userinfo/palyinfo"><img src=""><p>我的缴费</p></a></li>
								<li><a href="${ctx}/userinfo/orderinfo"><img src=""><p>我的订单</p></a></li>
								<li><a href="${ctx}/userinfo/newscollectinfo"><img src=""><p>我的收藏</p></a></li>
									<!-- 	<li><a href=""><img src=""><p>健康记录评估</p></a></li> -->
								<li><a href="${ctx}/userinfo/healthFile""><img src=""><p>我的健康档案</p></a></li>
								<li><a href="${ctx}/xnh/init""><img src=""><p>新农合</p></a></li>
						</ul>
					</div>

					</div>

				</div>
				
				<div class="bar">
					<ul>
							<li><a href="${ctx}/userinfo/baseinfo" class="opacity">个人资料</a></li>
							<li><a href="${ctx}/userinfo/authinfo" class="opacity  on">实名认证</a></li>
							<li><a href="${ctx}/userinfo/passwordinfo" class="opacity">密码修改</a></li>
							<li><a href="${ctx}/userinfo/peoplecardinfo" class="opacity">就诊卡管理</a></li>
					</ul>
				</div>
				<div class="met" >
							<c:if test="${ userinfo.verifstatus=='1'}" >
							<form class="zl" name="atmsgfrom" method = 'post'  action ='${ctx}/userinfo/authinfoupdate'>
								<ul> 
								   <li><p class="l">姓名</p><input type="text" id="pname"  name="pname" disabled="value" value="${userinfo.patientname}"></li>
								    <c:if test="${userinfo.gender=='1'}">
								    <li><p class="l">性别</p><input type="text" name="Sex"  id="Sex" disabled="value"  value="男士" ></li>
								    </c:if>
								    <c:if test="${userinfo.gender=='0'}">
								     <li><p class="l">性别</p> <input type="text" name="Sex"  id="Sex" disabled="value"  value="女士" ></li>
								    </c:if>
								    
								<li><p class="l">年龄</p><input type="text" id="uage"  name="uage" disabled="value" value="${userinfo.age}"></li>
								<li><p class="l">身份证号</p><input type="text"   name="ucardid"  disabled="value" value="${userinfo.cardid}"></li>
								<%-- <li><p class="l">社保卡号</p><input type="text" id="uvistcard"  name="uvistcard" disabled="value"  value="${userinfo.visitcardnum}"></li> --%>             

								</ul>
						</form>
							</c:if>	
					<c:if test="${userinfo.verifstatus!='1'}"  >
						<form class="zl" name="atmsgfrom" method = 'post'  action ='${ctx}/userinfo/authinfoupdate' >
						<input id="usermobile" name="usermobile"  type="hidden" value="${userinfo.mobileNo}" >
								<ul> 
								   <li><p class="l">姓名<font color="red">*</font></p><input type="text" id="pname"  name="pname" value="${userinfo.patientname}"></li>
								   
								     <c:if test="${empty  userinfo.gender}">
								         <li>
								         <p class="l">性别
								         <font color="red">*</font>
								          </p>
								          <div class="wip" > 
									        <input type="radio" id="ipp1" name="Sex" value="1" checked>
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
							            
								         
								   <%--  <li><p class="l">性别</p>
								                                 男士<input type="radio" name="Sex"  id="Sex" value="1" >
								                                                女士<input type="radio" name="Sex"  id="Sex" value="0" ></li>
								    </c:if> --%>
								    
								    <c:if test="${userinfo.gender=='1'}">
								       <li><p class="l">性别<font color="red">*</font></p>
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
								      
								      
								   <%--  <li><p class="l">性别</p>男士<input type="radio" name="Sex"  id="Sex" value="1" checked="checked">
								                                                女士<input type="radio" name="Sex"  id="Sex" value="0" ></li>
								    </c:if> --%>
								    <c:if test="${userinfo.gender=='0'}">
								      <li><p class="l">性别<font color="red">*</font></p>
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
								    <!--  <li><p class="l">性别</p>男士<input type="radio" name="Sex"  id="Sex" value="1" >
								                                                                   女士<input type="radio" name="Sex"  id="Sex" value="0" checked="checked" ></li> -->
								    </c:if>
								    
								<%-- <li><p class="l">年龄<font color="red">*</font></span></p><input type="text" id="uageinput"  name="uage" value="${userinfo.age}"></li> --%>
								<li><p class="l">身份证号<span><font color="red">*</font> </span></p><input type="text" id="ucardid"  name="ucardid" onmouseout="reproving()" value="${userinfo.cardid}"></li>
								<%-- <li><p class="l">社保卡号</p><input type="text" id="uvistcard"  name="uvistcard" value="${userinfo.visitcardnum}"></li>   --%>           
								
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
			     	</c:if>	
				</div>
		</div>

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


</script>
<script>
        function reproving() { //验证身份证
            var code=$("#ucardid").val().toUpperCase();
            $("#ucardid").val(code);
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


<script type="text/javascript">

	$(document).ready(function(){  
        $("#button_submit").click(function(){  
            var pnames = $("#pname").val();  
            var uages = $("#uageinput").val(); 
            var ucardids = $("#ucardid").val();
            var uvistcards = $("#uvistcard").val();
            var reg=/^[1-9]{1}[0-9]{14}$|^[1-9]{1}[0-9]{16}([0-9]|[xX])$/;
            var a=0;
            var regs=/^([0-9]|[0-9]{2}|100)$/;
           /* if(!regs.test(uages)){
               $("#msgbox").show();
               $("#msgcontent").text("年龄只能为数字");
            	a++;
            } */
            if(pnames==""){
                $("#msgbox").show();
                $("#msgcontent").text("姓名不能为空");
            	a++;
            	
            }
          /* if(uages==""){
            	 $("#msgbox").show();
                $("#msgcontent").text("年龄不能为空");
            	a++;
            } */
             if(ucardids==""){
            	 $("#msgbox").show();
                $("#msgcontent").text("身份证号不能为空");
            	a++;
            }
            if(!reproving()){
                reproving();
            	a++;
            }
            
              if(a==0){
	            	 layer.alert("请确认输入信息的真实性，数据提交后将无法修改！",{ 
				btn:['确定','取消'],
				yes:function(){ 
					$("form.zl").submit()
				},
				cancel:function(){ 
				}
				})
			
            
            }
            return false
            
          
	
            
        }); 
        
    });  
</script>



</body>
</html>
