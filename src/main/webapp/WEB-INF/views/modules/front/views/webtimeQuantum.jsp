<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/modules/front/include/taglib.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<link rel="stylesheet" type="text/css" href="${ctxStatic}/front/css/style.css" media="all" />
<link rel="stylesheet" type="text/css" href="${ctxStatic}/front/css/animat.css" media="all" />
<link rel="stylesheet" type="text/css" href="${ctxStatic}/static/front/css/filp.css" media="all" />
<script type="text/javascript" src="${ctxStaticFront}/js/jquery.min.js"></script>
<script type="text/javascript" src="${ctxStaticFront}/js/dome.js"></script>
<script type="text/javascript" src="${ctxStaticFront}/js/superslide.2.1.js"></script>
<script type="text/javascript" src="${ctxStaticFront}/js/imagesloaded.pkgd.min.js"></script>
<script type="text/javascript" src="${ctxStaticFront}/js/jquery.masonry.min.js"></script>
<script type="text/javascript" src="${ctxStaticFront}/js/layer/layer.js"></script>

	<title>时间段选择</title>

	<style type="text/css"> 
		*{padding: 0;margin: 0;font-family:"5FAE8F6F96C59ED1", "Microsoft Yahei";list-style-type: none;}

		.jztime{width: 510px;height: 270px;background: #f1f6fa;margin: 0 auto;text-align: center;}
		h1{font-weight: normal;font-size: 22px;color: #404d5e;margin: 30px 0;text-align: center;float: left;width: 100%}
		input{width: 160px;height: 35px;background: #fe824c;border: none;color: #fff}
		.select{border: 1px solid #bbc6dd;overflow:hidden;width: 350px;margin: 0 auto;margin-bottom: 50px}
		.select p{float: left;font-size: 14px;color: #404d5e;border-right: 1px solid #d2d2d2;width: 69px;text-align: center;padding: 11px 0;background: #fff}
		.select select{font-size: 14px;color: #404d5e;border: none;float: left;width: 280px;text-indent: 20px;padding: 10px 0}
		body {
    min-width: 575px;
}
	</style>
</head>
<body>
		<div class="jztime">
					<input type="hidden" id="sourcedate" name="sourcedate" value="${sourcedate}"/>
					<input type="hidden" id="doctorid" name="doctorid" value="${doctorid}"/>
					<input type="hidden" id="types" name="types" value="${types}"/>
					<h1>请选择<c:if test="${types=='1'}">图文咨询</c:if><c:if test="${types=='2'}">电话咨询</c:if><c:if test="${types=='3'}">视频咨询</c:if>就诊时间</h1>
					<div class="select" ><p>时段</p><select id="sel" name="timestypeNoName"></select></div>
					<input type="submit" id="gh_submit" value ="挂号">


		</div>

</body>

<script type="text/javascript">

$(function(){ 
	    var ciValue = jQuery('#sel');  
		var times='<%=request.getAttribute("timestypeNoName")%>'; 
		 var obj = eval('(' + times + ')');
		for(var i=0; i < obj.length; i++){
		  var html = [];  
				 html.push('<option value="'+obj[i].sourceid+'">'+obj[i].timeDesc+':'+obj[i].starttime+'-'+obj[i].endtime+'</option>'); 
				ciValue.append(html.join('')); 
		}
	 
}); 
/**


$("#gh_submit").click(function(){  
	 jQuery.ajax({  
        url : '${ctx}/userinfo/recordconfirm',  
        type : 'post',  
        data : { sourceid:$("#sourceid").val(),numSourceTime:$("#numSourceTime").val(),timestypeNoName:$("#sel").val()}, 
        dataType: "json", 
        success : function (result) {
        	alert(result);
       			var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
   				parent.window.location.href = "${ctx}/"+result;
   	    	    parent.layer.close(index);
            }  
        });  
			

   	    	
 	  
 });
 	  	**/		
$("#gh_submit").click(function(){  
  var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
    parent.window.location.href = "${ctx}/userinfo/webrecordconfirm?sourceid="+$("#sel").val()+"&types="+$("#types").val();
  	 parent.layer.close(index);
});	
 	  	

</script>

</html>

