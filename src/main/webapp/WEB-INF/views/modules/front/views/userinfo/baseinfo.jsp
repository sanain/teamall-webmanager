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
							<%--<li><a href="${ctx}/jkpg/init""><img src=""><p>健康评估</p></a></li>--%>

						</ul>
					</div>

					</div>

				</div>
				
				<div class="bar">
					<ul>
							<li><a href="${ctx}/userinfo/baseinfo" class="opacity on">个人资料</a></li>
							<li><a href="${ctx}/userinfo/authinfo" class="opacity">实名认证</a></li>
							<li><a href="${ctx}/userinfo/passwordinfo" class="opacity">密码修改</a></li>
							<li><a href="${ctx}/userinfo/peoplecardinfo?UID=${userinfo.userId}" class="opacity">就诊卡管理</a></li>
					</ul>
				</div>
				<div class="met" >
								
						<form class="zl" name="msgfrom" method = 'post'  action ='${ctx}/userinfo/baseinfoupdate'>
						<input id="usermobile" name="usermobile"  type="hidden" value="${userinfo.mobileNo}">
								<div class="userpic"> 
								<%--  <c:if test="${empty userinfo.photo}">
								 <img class="checkupdate" src="${ctxStaticFront}/images/defultUser.png">
							     </c:if>
							    <c:if test="${ not empty userinfo.photo}">
								<img class="checkupdate" src="${ctx}/${userinfo.photo}"> 
								</c:if> --%>
								 <c:set var="url" value="${userinfo.photo}" />  
								 <img class="checkupdate" id="userpoto" src="${fnf:imageScaleUrl(url,'200','200','userpc')}">
								<p>用户头像</p>
								</br>
								<!-- <input name="hi" class="checkupdate" type="button" value="修改头像" > --> 
								</div>
								<ul> 
								<li><p class="l">用户名</p><input type="text" id="uname"  name="uname" value="${userinfo.username}"></li>
								<li><p class="l">昵称</p><input type="text" id="nickname"  name="nickname"  value="${userinfo.nickname}"></li>
								<li><p class="l">手机号码</p><input type="text"  disabled="value"  value="${userinfo.mobileNo}">
								               
								</li>
								<li><p class="l">电子邮箱</p><input type="text" id="mail"  name="mail" value="${userinfo.email}"></li>
								
								<li id="msgbox" class="msg"  <c:if test="${msg == null}"> style="display:none" </c:if>>
									<div class="msg_err">
									<div class="msg_ct">
									<span><i class="icono-exclamation"></i></span>
									<p id="msgcontent">${msg}</p>
									</div>
									</div>
								</li>
								<li class="sb"><input id="button_submit"  type="submit" value="提交"></li>


								</ul>
						</form>
				</div>
		</div>

<script type="text/javascript">
	/* 头像修改提示弹出框 */
$(".checkupdate").on("mouseenter", function () {
		layer.tips('点击修改头像', '.checkupdate', {
        tips: 3
      });
    });

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

<script type="text/javascript">

	$(document).ready(function(){  
        $("#button_submit").click(function(){  
            var uname = $("#uname").val();  
            var nname = $("#nickname").val(); 
            var umail = $("#mail").val();
            var reg=/\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/;
             
            if(uname==""){
                $("#msgbox").show();
                $("#msgcontent").text("用户名不能为空");
            	
            	return false;
            }
            if(nname==""){
            	 $("#msgbox").show();
                $("#msgcontent").text("昵称不能为空");
            	return false;
            }
            if(!reg.test(umail)){
                $("#msgbox").show();
                $("#msgcontent").text("邮箱地址格式不正确");
            	return false;
            }
             if(umail==""){
            	 $("#msgbox").show();
                $("#msgcontent").text("邮箱不能为空");
            	return false;
            }
        }); 
        
    });  
    
    
    $(".checkupdate").on("click", function() {
	/* 	var idsvlaue = $(this).attr("id");
		var idss = $("#ids"+idsvlaue).val(); */
		$("body").css("overflow", "hidden")
		layer.open({
			type : 2,
			title : '用户修改头像',
			shadeClose : true,
			maxmin : true, //开启最大化最小化按钮
			area : ['1160px', '650px'],
			content : '${ctx}/userinfo/intouserphoto',
			end : function() {
				$("body").css("overflow", "auto")
			}

		})

	})
    
    
    
    
</script>


</body>
</html>
