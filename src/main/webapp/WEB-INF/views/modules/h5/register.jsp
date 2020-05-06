<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no,minimal-ui" name="viewport">
    <meta name="format-detection" content="telephone=no">
    <meta content="yes" name="apple-mobile-web-app-capable">
    <meta content="black" name="apple-mobile-web-app-status-bar-style">
    <meta content="telephone=no" name="format-detection">
    <meta content="yes" name="apple-touch-fullscreen">
    <meta name="x5-page-mode" content="app">
    <meta name="screen-orientation" content="portrait">
    <meta name="x5-orientation" content="portrait">
    <title>注册${fns:getProjectName()}</title>
    <link rel="stylesheet" href="${ctxStatic}/h5/css/register.css">
    <link rel="stylesheet" href="${ctxStatic}/h5/css/bootstrap.min.css">
    <link rel="stylesheet" href="${ctxStatic}/h5/css/build.css">
	 <link rel="stylesheet" href="${ctxStatic}/h5/css/commodity-details.css">
    <script src="${ctxStatic}/h5/js/jquery.min.js"></script>
	   
     <link rel="stylesheet" type="text/css" href="${ctxStatic}/h5/css/loding.css" media="all" />
    <script>
        $(function(){
         $(".loading-fixed").hide();
            $('html').css('font-size',$('body').width()/10+'px');

            $('.check input').click(function(){
                if ($(this).is(':checked')){
                    $('.check .checkbox i').show();
                }else {
                    $('.check .checkbox i').hide();
                }
            });
            

            $('.xx-rzt').click(function(){
                $(this).siblings('input').val('')
            });
            $('.see-pass').click(function(){
                if($(this).prev('input').attr('type')=='password'){
                    var vall=$(this).prev('input').val();
                    $(this).prev('input').remove();
                    var hh='<input id="password" name="password" placeholder="登录密码（6~12位字符）" type="text" value='+vall+'>';
                    $(this).parent().prepend(hh);
                }else {
                    var vall=$(this).prev('input').val();
                    $(this).prev('input').remove();
                    var hh='<input id="password" name="password" placeholder="登录密码（6~12位字符）" type="password" value='+vall+'>';
                    $(this).parent().prepend(hh);
                }

            });
        })
		  function yzmf(){
				$('.yaz').attr('disabled',"true");
                $.ajax({
	             type: "POST",
	             url: "${ctxweb}/RegisterHtml/SmsCode",
	             data: {mobile:$("#mobile").val(),type:'1'},
	             success: function(data){
					 console.log(data.smscode)
    	            if(data.smscode!=''&& data.smscode!=null&& data.smscode!=undefined){
						
		              $('.tis span').text(data.msg);
		              $('.tis p').addClass('active2').removeClass('active1');
		              $('.tis').show();
					  jsq();
		              setTimeout(function(){$('.tis').hide();},2000);
					 
                 }else{
					 $('.yaz').removeAttr("disabled");
    	              $('.tis span').text(data.msg);
		              $('.tis').show();
		              $('.tis p').addClass('active1').removeClass('active2');
		              setTimeout(function(){$('.tis').hide();},2000);
    	              }
    	            }
    	         })
		 }
			function jsq(){
    	       var tt=60;
                $('.yaz').val(tt+'秒后再次发送');
                $(this).css('background','#ccc');
                var timm=setInterval(function(){
                    tt--;
                    $('.yaz').val(tt+'秒后再次发送');
                    if(tt<=0){
                        clearInterval(timm);
                        $('.yaz').val('发送验证码');
                        $('.yaz').css('background','#3BC969');
						$('.yaz').removeAttr("disabled");
                        return;
                    }
                },1000)
           
			}

    </script>
    <style>
        .tis{display:none;position: fixed;top: 0;bottom: 0;left: 0;right: 0;background: rgba(0,0,0,0.3);z-index: 1000}
        .tis-box{position: absolute;width: 3rem;background: #ffffff;border-radius: 10px;top: 50%;left: 50%;margin-top: -1.5rem;margin-left: -1.5rem;text-align: center;padding-top: 0.5rem;padding-bottom:0.4rem}
        .tis-box p.active1{background-size: 100%;width: 0.9rem;height: 0.9rem;margin: 0 auto}
        .tis-box p.active2{background-size: 100%;width: 0.9rem;height: 0.9rem;margin: 0 auto}
        .tis-box span{color: #666666;display: inline-block;padding:0 0.2rem}
    </style>
	<style type="text/css">    
     body{    
        background-image: url(${ctxStatic}/h5/images/g_bg_bg.png);  
		background-repeat:no-repeat;	
        background-size:cover;  
     }    
 </style> 
</head>
<body onload="createCode()">
  <form action="" id="formid" style="margin-top:45%">
             <input  type="hidden" id="cartNum" name="cartNum" value="${cartNum}">
             <input  type="hidden" id="registerName" name="registerName" value="${registerName}">
             <input  type="hidden" id="registerType" name="registerType" value="${registerType}">
    <div class="context">
        <ul>
            <li>
                <input placeholder="手机号" type="text" id="mobile" name="mobile">
                <img class="xx-rzt" src="${ctxStatic}/h5/images/xx-rzt.png" alt="">
            </li>
            <li><span>邀请码：</span><b>${cartNum}</b></li>
            <li style="display: none">
                <input placeholder="图片验证码" type="text" id="inputCode">
                <div class="img-box" id="checkCode" onclick="createCode()" style="width: 30%;float: right;background: #fff;text-align: center;height: 1rem;line-height: 1rem;margin-top: 0.15rem;" >
                   <%--  <img src="${ctxStatic}/h5/images/yanzma.png" alt=""> --%>
                </div>
            </li>
            <li>
                <input placeholder="短信验证码" type="text" id="smsCode" name="smsCode">
                <input type="button" class="yaz" onclick="yzmf()" href="javascript:;" style="float: right;height: 0.85rem;line-height: 0.85rem;text-align: center;width: 2.53rem;color: #ffffff;background: #3BC969;border-radius: 38px;margin-top: 0.23rem;font-size: 0.346rem;" value="发送验证码"/>
            </li>
            <li>
                <input placeholder="登录密码（6~12位字符）" type="password" id="password" name="password">
                <img class="see-pass" src="${ctxStatic}/h5/images/see-pass.png" alt="" style="float: right;width: 5.8%;margin-top: 0.5rem;">
            </li>
        </ul>
        <div class="check">
            <div class="checkbox">
                <input checked type="checkbox">
                <label><i></i>同意</label>
            </div>
            <a href="${ctxweb}/RegisterHtml/show">《${pmServiceProtocol.name}》</a>
        </div>

        <a class="reg-a" href="javascript:;" onclick="validate()" style="background: #3BC969;border-radius: 18px;font-size: 0.346rem;">注册</a>
    </div>
    <div class="tis">
        <div class="tis-box">
            <p class="active1" style="display:none"></p>
            <span>密码错误</span>
        </div>
    </div>
    </form>
	 <div class="download" style="display:none">
        <img class="down-logo" src="${ctxStatic}/h5/images/logo.png" alt="">
        <span>下载${fns:getProjectName()}</span>
        <a href="${ctxweb}/download" id="down" style="background: #3BC969;" >立即下载</a>
        <img class="d-del" src="${ctxStatic}/h5/images/d-del.png" alt="">
    </div>
    <div class="loading-fixed">
		<div class="load-container load" >
			<div class="loader">Loading...</div>
		</div>
	</div>
    <script language="javascript" type="text/javascript">
        var code;
        function createCode() {
            code = "";
            var codeLength = 6; //验证码的长度
            var checkCode = document.getElementById("checkCode");
            var codeChars = new Array(0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 
            'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z',
            'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'); //所有候选组成验证码的字符，当然也可以用中文的
            for (var i = 0; i < codeLength; i++) 
            {
                var charNum = Math.floor(Math.random() * 52);
                code += codeChars[charNum];
            }
            if (checkCode) 
            {
                checkCode.className = "img-box";
                checkCode.innerHTML = code;
            }
        }
        
        
        
        function validate() {
             var inputCode = document.getElementById("inputCode").value;
             var myreg = /^(((13[0-9]{1})|(15[0-9]{1})|(17[0-9]{1})|(18[0-9]{1}))+\d{8})$/; 
             if($("#mobile").val()==''||$("#mobile").val()==null||$("#mobile").val()==undefined){
             //手机号不能为空
             	$('.tis span').text('手机号不能为空')
             	$('.tis').show()
             	$('.tis p').addClass('active1').removeClass('active2');
             	setTimeout(function(){$('.tis').hide();},2000);
             }else if(!myreg.test($("#mobile").val())){
              //手机号格式不对
                $('.tis span').text('手机号格式不对')
             	$('.tis').show()
             	$('.tis p').addClass('active1').removeClass('active2');
             	setTimeout(function(){$('.tis').hide();},2000);
             }
             //else if(inputCode.length <= 0){
             //请输入验证码！
             //   $('.tis span').text('请输入图片验证码！')
             //	$('.tis').show()
             //	$('.tis p').addClass('active1').removeClass('active2');
             //	setTimeout(function(){$('.tis').hide();},2000);
             //}else if(inputCode.toUpperCase() != code.toUpperCase()){
             //验证码输入有误！
              //  $('.tis span').text('图片验证码输入有误！')
             //	$('.tis').show()
             	//$('.tis p').addClass('active1').removeClass('active2');
             	//setTimeout(function(){$('.tis').hide();},2000);
             //}
             else if($("#smsCode").val()==''||$("#smsCode").val()==null||$("#smsCode").val()==undefined){
             //验证码不能为空
                $('.tis span').text('短信验证码不能为空')
             	$('.tis').show()
             	$('.tis p').addClass('active1').removeClass('active2');
             	setTimeout(function(){$('.tis').hide();},2000);
             }else if($("#smsCode").val().length!=6){
             //验证码有误
                $('.tis span').text('请输入6位短信验证码')
             	$('.tis').show()
             	$('.tis p').addClass('active1').removeClass('active2');
             	setTimeout(function(){$('.tis').hide();},2000);
             }else if($("#password").val()==''||$("#password").val()==null||$("#password").val()==undefined){
             //密码mull
                $('.tis span').text('密码不能为空')
             	$('.tis').show()
             	$('.tis p').addClass('active1').removeClass('active2');
             	setTimeout(function(){$('.tis').hide();},2000);
             }else if($("#password").val().length<6&&$("#password").val().length>20){
             //密码长度6~20
                $('.tis span').text('密码长度6~20')
             	$('.tis').show()
             	$('.tis p').addClass('active1').removeClass('active2');
             	setTimeout(function(){$('.tis').hide();},2000);
             }else if(!($('input[type=checkbox]').is(':checked'))){
             //请同意登录协议
             	$('.tis span').text('请同意登录协议')
             	$('.tis').show()
             	$('.tis p').addClass('active1').removeClass('active2');
             	setTimeout(function(){$('.tis').hide();},2000);
             }else{
              $.ajax({
	             type: "POST",
	             url: "${ctxweb}/RegisterHtml/save",
	             data: $('#formid').serialize(),
	             beforeSend:function(){
	   		     $(".loading-fixed").show();
	   	         },success: function(data){
	   	          $(".loading-fixed").hide();
	   	          if(data.smscode=='00'){
	   	            $('.tis span').text(data.msg);
	   	            $('.tis p').addClass('active2').removeClass('active1');
	             	$('.tis').show()
	             	setTimeout(function(){
	             		location.href="../download";
	             		//$('.tis').hide();
	             		},2000);
	             	
	   	           }else{
	   	            $('.tis span').text(data.msg)
	   	            $('.tis p').addClass('active1').removeClass('active2');
	             	$('.tis').show()
	             	setTimeout(function(){$('.tis').hide();},2000);
	   	           }
	             }
	         });
             }
           
        }    
     </script>
</body>
</html>