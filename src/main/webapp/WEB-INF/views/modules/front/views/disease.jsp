<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/front/include/taglib.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
<style type="text/css">
        	.cascading-dropdown-loading {
        		cursor: wait;
        		background: url('${ctxStaticFront}/images/ajax-loader.gif') 85% center no-repeat transparent;
        	}
        </style>
<script type="text/javascript" src="${ctxStaticFront}/js/jquery.cascadingdropdown.js"></script>

		<div id="content"> 
		<div class="newsnav" style="margin:10px 0"> 
								<div class="center">
										<a href="${ctx}/">首页    >  </a> <a href="${ctx}/IllnessInfo/reqIllness">疾病列表</a>

								</div>
								


						</div> 
			<div class="jblb">
				<div class="block_name mtt"> 
							
							<span class="">INTELLIGENT GUIDE</span>
							<p class="">疾病列表</p>
							<div class="brd"></div>
				</div>

				<div class="cxbg">
					<form id="inputForm" action="${ctx}/IllnessInfo/reqIllness" method="post" class="cxform">
						<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
						<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
										<p>
										<select><option>疾病查询</option></select>
										<input id="" name="qeuryName" type="text"  value="${qeuryName}" placeholder="请输入查询关键字" class="cx">
										<input type="submit" value="查询" class="tj">
										</p>
										
				
				</div>
				<div class="secbg sle">
						<div class="center"> 
								<ul> 
								
								<li>
										<p>性别</p>
											<select id="sex" name="sex">
												<c:if test="${sex eq 1 }">
													<option value="1">男</option>
													<option value="2">女</option>
													<option value="0">所有</option> 
												</c:if>
												<c:if test="${sex eq 2 }">
													<option value="2">女</option>
													<option value="1">男</option>
													<option value="0">所有</option> 
												</c:if>
												<c:if test="${empty sex}">
													<option value="0">所有</option> 
													<option value="2">女</option>
													<option value="1">男</option>
												</c:if>	
												<c:if test="${sex eq 0}">
													<option value="0">所有</option> 
													<option value="2">女</option>
													<option value="1">男</option>
												</c:if>		
											</select>	
										
										</li> 
								
								
								
											<li><p>部位</p>
											<select id="selpart" name="partName" onchange="changeLac(this.value)">
												<c:if test="${empty repartID}">
													<option value="">所有</option>
												</c:if>
												<%-- <c:forEach items="${part}" var="part">
														 <c:if test="${part.id == repartID}"> 
																<option value="${part.id}">
																		${part.partName}			
																</option>
															</c:if>
												</c:forEach>
												
												<c:forEach items="${part}" var="parts">
																<c:if test="${parts.id != repartID}"> 
																	<option value="${parts.id}">
																		${parts.partName}			
																	</option>
																</c:if>
												</c:forEach> --%>	
												<c:forEach items="${part}" var="parts">
													<c:if test="${parts.partName!='其他'}">
														<option value="${parts.id}"  ${parts.id == repartID?'selected':''}>${parts.partName}</option>
													</c:if>
												</c:forEach>
												<c:forEach items="${part}" var="parts">
													<c:if test="${parts.partName=='其他'}">
														<option value="${parts.id}"  ${parts.id == repartID?'selected':''}>${parts.partName}</option>
													</c:if>
												</c:forEach>
												
													
															
												<c:if test="${!empty repartID}">
													<option value="">所有</option>
												</c:if>
											</select>
											</li>
										<li>
										<p>器官</p>
											<!-- <select id="ci" name="childName" onchange="changeLact(this.value)"> -->
											<select id="ci" name="childName" onchange="changeLact(this.value)">
											<c:if test="${empty childID}">
													<option value="">所有</option>
												</c:if>
													<c:forEach items="${childList}" var="childs" >
														 <c:if test="${childs.id == childID}"> 
																<option value="${childs.id}">
																		${childs.partName}			
																</option>
															</c:if>
												</c:forEach>
												
												<c:forEach items="${childList}" var="child">
																<c:if test="${child.id != childID}"> 
																	<option value="${child.id}">
																			${child.partName}			
																	</option>
																</c:if>
													</c:forEach>		
															
												<c:if test="${!empty childID}">
													<option value="">所有</option>
												</c:if>
												
											</select>	
										
										</li>
									
										 <%-- <li>
										<p>症状</p>
											<select id="symp" name="symptomId">
											<c:if test="${empty symptomId}">
													<option value="">所有</option>
												</c:if>
													<c:forEach items="${symptomList}" var="symptom" >
														 <c:if test="${symptom.id == symptomId}"> 
																<option value="${symptom.id}">
																		${symptom.syName}			
																</option>
															</c:if>
												</c:forEach>
												<c:forEach items="${symptomList}" var="symptoms">
																<c:if test="${symptoms.id != symptomId}"> 
																	<option value="${symptoms.id}">
																			${symptoms.syName}			
																	</option>
																</c:if>
													</c:forEach>		
												<c:if test="${!empty symptomId}">
													<option value="">所有</option>
												</c:if>
												
												
												
											</select>	
										
										</li> --%>
								
								</ul>
								
								

						</div>

				
				</div>
				</form>
				<div class="shaixuanlb">
					<div class="center">
							<div class="title"><p>当前筛选条件共查到${page.count}条疾病知识 </p></div>
						<ul>
							<c:forEach items="${page.list}" var="s">
							<li>
								<p class="p1"><a href="${ctx}/IllnessInfo/diseaseInfo?id=${s.id}">
								 <c:set var="illAliasdesc" value="${fns:abbr(s.illAlias,40)}"/>
								<span>${s.illName}<%-- 【别称：${illAliasdesc}】 --%></a></span></p>
								<div class="jbjs">
									<!-- <p>就诊科室：<span>感染科</span></p> -->
									<p>主要症状：<span>${s.illSymptomsTxt}</span></p>
									<p>疾病简介：<span>${s.illName}${fns:abbr(s.illTxt,30000)}</span></p>

								</div>
							</li>
							</c:forEach>	


						</ul>


					</div>
				</div>
			<div class="page pgb">${page}</div>


			</div>
		</div>
	

<script type="text/javascript">
function page(n, s) {
		if (n)
			$("#pageNo").val(n);
		if (s)
			$("#pageSize").val(s);
		$("#inputForm").submit();
		return false;
}




$(".menav li").each(function(a){ 
		var me = $(".menav li:eq("+a+")"),i=a+1;
		me.find("img").attr("src","${ctxStaticFront}/images/me_"+i+".png")
		me.hover(function(){ 
			me.find("img").attr("src","${ctxStaticFront}/images/me_"+i+"h.png")
		},function(){ 
			me.find("img").attr("src","${ctxStaticFront}/images/me_"+i+".png")

		})
})





</script>

<script type="text/javascript"> 
function pySegSort(arr,empty) {
if(!String.prototype.localeCompare)
return null;

var letters ="*ABCDEFGHJKLMNOPQRSTWXYZ".split('');
var zh ="啊把差大额发噶哈级卡啦吗那哦爬器然啥他哇西呀咋".split('');

var segs = [];
var curr;
$.each(letters, function(i){
curr = {letter: this, data:[]};
$.each(arr, function() {
if((!zh[i-1] || zh[i-1].localeCompare(this) <= 0) && this.localeCompare(zh[i]) == -1) {
curr.data.push(this);
}
});
if(empty || curr.data.length) {
segs.push(curr);
curr.data.sort(function(a,b){
return a.localeCompare(b);
});
}
});
return segs;
}



		var jso = pySegSort(["高血压","骨折","冠心病","肝硬化","冠状动脉粥样硬化性心脏病","急性阑尾炎","慢性支气管炎"])
		var q=jso.length 
		for(var i=0;i<q;i++){ 
			var w = jso[i].data.length
			$("#zndz").append("<li class='Zn lt"+jso[i].letter+"'><div class='title'><h2>"+jso[i].letter+"</h2></div></li>")
			for(var e=0;e<w;e++){ 
					$(".lt"+jso[i].letter+"").append("<a href=''>"+jso[i].data[e]+"</a>")
			}
		}



            
   function changeLac(v) {  
    jQuery('#ci').html(""); //把ci内容设为空  
    var ciValue = jQuery('#ci');  
    ciValue.append('<option value="">所有</option>');  
      var ciValue = jQuery('#ci'); 
    //异步请求查询ci列表的方法并返回json数组  
    jQuery.ajax({  
        url : '${ctx}/IllnessInfo/reqChildList',  
        type : 'post',  
        data : { partId : $("#selpart").val(),sex:$("#sex").val() },  
        dataType : 'json',  
        success : function (opts) {  
            if (opts && opts.length > 0) {  
                    var html = [];  
                    for (var i = 0; i < opts.length; i++) {  
                        html.push('<option value="'+opts[i].id+'">'+opts[i].partName+'</option>');  
                    }  
                    ciValue.append(html.join(''));  
                }  
            }  
        });  

}  




    function changeLact(v) {  
    jQuery('#symp').html(""); //把ci内容设为空  
    var ciValuet = jQuery('#symp');  
    ciValuet.append('<option value="">所有</option>');  
      var ciValue = jQuery('#ci'); 
    //异步请求查询ci列表的方法并返回json数组  
   var sympt = jQuery('#symp'); 
        jQuery.ajax({  
        url : '${ctx}/IllnessInfo/reqSymptomList',  
        type : 'post',  
        data : { partId : $("#selpart").val(),childName : $("#ci").val() },  
        dataType : 'json',  
        success : function (opts) {  
            if (opts && opts.length > 0) {  
                    var html = [];  
                    for (var i = 0; i < opts.length; i++) {  
                        html.push('<option value="'+opts[i].id+'">'+opts[i].syName+'</option>');  
                    }  
                    ciValuet.append(html.join(''));  
                }  
            }  
        });  


}  





  




</script>






</body>
</html>
