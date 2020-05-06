<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/front/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>

<meta name="keywords" content="" />
<meta name="description" content="" />

	<link rel="stylesheet" type="text/css" href="${ctxStaticFront}/css/style.css" media="all" />
	<link rel="stylesheet" type="text/css" href="${ctxStaticFront}/css/animat.css" media="all" />
	<link rel="stylesheet" type="text/css" href="${ctxStaticFront}/css/filp.css" media="all" />
	<script type="text/javascript" src="${ctxStaticFront}/js/jquery.min.js"></script>
	<script type="text/javascript" src="${ctxStaticFront}/js/dome.js"></script>
	<script type="text/javascript" src="${ctxStaticFront}/js/superslide.2.1.js"></script>
	<script type="text/javascript" src="${ctxStaticFront}/js/layer/layer.js"></script>
	<script type="text/javascript" src="${ctxStaticFront}/js/jquery.mousewheel.js"></script>
	
	
</head>
<body>	

  <style type="text/css">
	body{min-width: 1000px}
	.center{width: 1000px !important;}
  </style>
		<div class="zixunn">
			<div class="center">
			 <ul class="Zmsg">
				<c:forEach var="contentmsg" items="${userinterrogationrecordmsg}">
								            <c:if test="${contentmsg.type=='2'}">
											 <li>
											    <c:if test="${contentmsg.conttype=='1'}">
											     <%-- <c:if test="${empty contentmsg.userurl}">
											       <div class="Msgpic"><img src="${ctxStaticFront}/images/defultUser.png"></div>
											     </c:if>
											     <c:if test="${not empty contentmsg.userurl}">
											       <div class="Msgpic"><img src="${ctxStaticFront}/${contentmsg.userurl}"></div>
											     </c:if> --%> 
											     <c:set var="url" value="${contentmsg.userurl}" />  
								                  <div class="Msgpic"><img src="${fnf:imageScaleUrl(url,'200','200','userpc')}"></div>
											      <div class="Msgfonts"><p>${contentmsg.content}</p></div>
											    </c:if>
											</li>
											
											</c:if>
											<c:if test="${contentmsg.type=='1'}">
											
											  <li class="me">
											    <c:if test="${contentmsg.conttype=='1'}">
											     <%--  <c:if test="${empty contentmsg.doctorurl}">
											         <div class="Msgpic"><img src="${ctxStaticFront}/images/defultDoctor.png"></div>
											      </c:if>
											       <c:if test="${not empty contentmsg.doctorurl}">
											        <div class="Msgpic"><img src="${ctxStaticFront}/${contentmsg.doctorurl}"></div>
											      </c:if> --%>
											      <c:set var="url" value="${contentmsg.userurl}" />
											       <div class="Msgpic"> <img src="${fnf:imageScaleUrl(url,'200','200','doctorpc')}"></div>
											       <div class="Msgfonts"><p>${contentmsg.content}</p></div>
											    </c:if>
											     
											  </li>
											</c:if>
										</c:forEach>
			</ul>
				<c:if test="${userinterrogationmsg.state!='9' and userinterrogationmsg.interrogationtype=='10' }">
			  <from class="Smsg" id="100" name="content" action="${ctx}/userinfo/userconsultinfo?interid=${userinterrogationmsg.userinterrogationid}&intertype=100" method="post" >
   
 	           <div class="l">
				<input type="text" name="sgfonts" placeholder="请输入咨询内容" id="sgfonts">
			  </div>
			  <div class="r">
				<input type="submit" onclick="clis();" value="提交" id="tj">
				<input type="hidden" id="ids" value="${userinterrogationmsg.userinterrogationid}" />
			  </div>
		     </c:if>
		</div>
	  </div>



</body>
<script type="text/javascript">
function setContent(str) {
	str = str.replace(/<\/?[^>]*>/g,'');          //去除HTML tag
	str.value = str.replace(/[ | ]*\n/g,'\n');    //去除行尾空白
	
	return str;
}
</script>

<script type="text/javascript">

	function clis(){
	        var idss = $("#ids").val();
	        var font = $("#sgfonts").val();
	        var fonts=setContent(font);
	        if(fonts==""||fonts==null){
	          layer.alert('咨询内容不能为空');
	          return false;
	          }
	        else if(fonts.length>160){
	           layer.alert('输入内容不能超过160字');
	           return false;
	          }
	          
	      else{
	         layer.load(1);
			$.post("${ctx}/userinfo/userconsultinfo",{intertype:100,interid:idss,contents:fonts},function(result){
  			 window.location.reload();
 		   });
 		 }
 		 
	}
	
</script>
</html>
