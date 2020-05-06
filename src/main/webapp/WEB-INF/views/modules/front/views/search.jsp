<%@ page trimDirectiveWhitespaces="true" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/front/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<meta name="decorator" content="frontindexother"/>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>搜索</title>
	<meta name="keywords" content="" />
	<meta name="description" content="" />
	
		<style type="text/css">
        	.cascading-dropdown-loading {
        		cursor: wait;
        		background: url('${ctxStaticFront}/images/ajax-loader.gif') 85% center no-repeat transparent;
        	}
mico {
    padding: 0px 6px;
    height: 17px;
    float: left;
    display: block;
    background: #FE824C none repeat scroll 0% 0%;
    text-align: center;
    border-radius: 6px;
    margin-left: 5px;
    font-size: 10px;
    line-height: 16px;
    color: #FFF;
    font-weight: normal;
}
* {
    padding: 0px;
    margin: 0px;
    list-style-type: none;
    text-decoration: none;
    font-family: "5FAE8F6F96C59ED1","Microsoft Yahei";
}
.lefsta{
 position: relative;
  left: -6px;
  top: 8px;

}

        </style>
</head>
<body >	
		<div id="content" class="index"> 
		<div class="newsnav"> 
				<div class="center">
				<a href="${ctx}/">首页    >  </a>
			    <a href="${ctx}/search/search${urlSuffix}">搜索</a>
			    </div>
        </div>
		
			<div class="jblb">
				<div class="block_name mtt"> 
							
							<span class="">SEARCH</span>
							<p class="">搜索</p>
							<div class="brd"></div>
				</div>

				<div class="cxbg">
				<form id="searchForm" name="searchForm" class="cxform" action="${ctx}/search/search${urlSuffix}" method="POST">
				  	<input id="pageNo" name="pageNo" type="hidden"  value="${hospage.pageNo}"/>
	                <input id="pageSize" name="pageSize" type="hidden" value="${hospage.pageSize}"/>
										<p>
										
										<select name="theselect" id="theSearch">
											<c:if test="${empty theSelect or theSelect=='' }">
												<option value="hospitalName" id="" selected ="selected">医院查询</option>
												<option value="doctorName">医生查询</option>
												 <option value="newsInfo">资讯查询</option>
											</c:if>
											<c:if test="${theSelect eq  'doctorName'}">
												<option value="doctorName" selected ="selected">医生查询</option>
												 <option value="newsInfo">资讯查询</option>
												 <option value="hospitalName" id="">医院查询</option>
											</c:if>
											<c:if test="${theSelect eq  'newsInfo'}">
												 <option value="newsInfo" selected ="selected">资讯查询</option>
												   <option value="doctorName">医生查询</option>
												 <option value="hospitalName" id="">医院查询</option>
											</c:if>
											 <c:if test="${theSelect eq  'hospitalName'}">
											 	<option value="hospitalName" id="" selected ="selected">医院查询</option>
												 <option value="newsInfo">资讯查询</option>
												   <option value="doctorName">医生查询</option>
												 
											</c:if>     
										      
										 </select>
										<input name="searchValue" type="text" placeholder="请输入查询关键字:例如医院名、医生名、资讯标题" class="cx" value=${searchtext}>
										<input type="submit" value="查询" class="tj">
										</p>
										
				</form>
				</div>
				<c:if test="${!empty hospage.list}">
					<div class="yiy" style="margin-top:20px">
									<div class="center">
										<ul> 
										<c:if test="${!empty nullInfo}">
										   <li>${nullInfo}</li>
										</c:if>
										<c:forEach items="${hospage.list}" var="hospital">
												<li>
													<a href="../hospital/${hospital.hospitalId}${urlSuffix}">
														<div class="l">
															<img height="70" width="70" src="${hospital.photourl}">
														</div>
														<div class="r">
																<p>
																<b>${hospital.name}</b>
<!-- 																<img src="${ctxStaticFront}/images/ico1.png"> -->



                                                            <div class="lefsta">	
                                                               	<c:if test="${hospital.hasRegConfirm == '1'}">
																	<mico >
																</c:if>
																<c:if test="${hospital.hasRegConfirm != '1'}">
																	<mico  class="off" >
																</c:if>
																挂号
																</mico>
																
																
																<c:if test="${hospital.isinterrogation == '1'}">
																	<mico >
																</c:if>
																<c:if test="${hospital.isinterrogation != '1'}">
																	<mico class="off">
																</c:if>
																远程
																</mico>
																
																
																
															<c:if test="${hospital.waitstat =='1'}">
															<mico >
																</c:if>
																<c:if test="${hospital.waitstat !=1}">
																	<mico class="off" >
																</c:if>
																
																排队</mico>
																<c:if test="${hospital.reportstat ==1}">
																	<mico >
																</c:if>
																<c:if test="${hospital.reportstat !=1}">
																	<mico class="off" >
																</c:if>
																报告</mico> 
																<c:if test="${hospital.payonlinestat ==1}">
																	<mico >
																</c:if>
																<c:if test="${hospital.payonlinestat !=1}">
																	<mico class="off" >
																</c:if>
																门诊</mico> 
																<c:if test="${hospital.payonlinestat ==1}">
																	<mico >
																</c:if>
																<c:if test="${hospital.payonlinestat !=1}">
																	<mico class="off" >
																</c:if>
																缴费</mico> 
                                                              </div>	
                                                              </br>
                                                            


                                                            <%--  <c:if test="${hospital.waitstat==1}">
                                                             <mico class="on">排队就诊</mico>
                                                             </c:if>
                                                             <c:if test="${hospital.waitstat==0}">
                                                             <mico class="off">排队就诊</mico>
                                                             </c:if>
                                                             <c:if test="${hospital.payonlinestat==1}">
                                                             <mico class="on">门诊缴费</mico>
                                                             </c:if>
                                                             <c:if test="${hospital.payonlinestat==0}">
                                                             <mico class="off">门诊缴费</mico>
                                                             </c:if>
                                                             <c:if test="${hospital.emrstat==1}">
                                                             <mico class="on">电子病历</mico>
                                                             </c:if>
                                                             <c:if test="${hospital.emrstat==0}">
                                                             <mico class="off">电子病历</mico>
                                                             </c:if>
                                                             <c:if test="${hospital.isopenalipay==1}">
                                                             <mico class="on">支付宝</mico>
                                                             </c:if>
                                                             <c:if test="${hospital.isopenalipay==0}">
                                                             <mico class="off">支付宝</mico>
                                                             </c:if> --%>
																
																
															</p>
															 <c:set var="hosbrief" value="${fns:abbr(hospital.brief,100)}"/>
															<span><%-- ${hospital.brief} --%>${hosbrief}</span>
														</div>
													</a>
												</li>
										</c:forEach>
										</ul>
									</div>
							</div>
						</c:if>
						
						<c:if test="${!empty docpage.list}">
						  <div class="i5 sel5">
						     <div class="center">
					        	<ul>
					        	  <c:forEach items="${docpage.list}" var="doctor">
					        	  <c:set var="doctorType" value="${fnf:getDoctorTypeByid(doctor.doctortype)}"/>
					        	  <c:set var="hospital" value="${fnf:getHospitalByintId(doctor.hospitalId)}"/>
					        	   <c:set var="docdesc" value="${fns:abbr(doctor.ddesc,100)}"/>
					        	   
										<li class="">
										<c:set var="url" value="${doctor.photourl}" />
											<div class="userpic animate-element scale" style="background:url(${fnf:imageScaleUrl(url,'180','180','doctorpc')}) center no-repeat"> 
												<a href="../doctor/${doctor.doctorId}${urlSuffix}">
												<p class="opacity"><span>
												  ${docdesc}
												</span></p>
												</a>
											</div>
											<div class="fonts animate-element bottom_to_top">
												<p class="p1">${doctor.name} <span>${doctor.jobsString}</span></p>
												<p class="p2"><span style="font-size:11px;">${hospital.name}</span></p>
												<div class="State">
<!-- 												background-image:url(${ctxStaticFront}/images/seico3.png) -->
                                                   <c:if test="${doctor.chartartconsult==1}">
													<a class="on" style="">图文</a>
												   </c:if>
												   <c:if test="${doctor.chartartconsult!=1}">
													<a class="off" style="">图文</a>
												   </c:if>
												   <c:if test="${doctor.videoconsult==1}">
													<a class="on" style="">视频</a>
													</c:if>
												   <c:if test="${doctor.videoconsult!=1}">
													<a class="off" style="">视频</a>
													</c:if>
													<c:if test="${doctor.telconsult==1}">
													<a class="on" style="">电话</a>
													</c:if>
												   <c:if test="${doctor.telconsult!=1}">
													<a class="off" style="">电话</a>
													</c:if>
													<c:if test="${doctor.isReg=='1'}">
													<a class="on" style="">挂号</a>
													</c:if>
												    <c:if test="${doctor.isReg!='1'}">
													<a class="off" style="">挂号</a>
													</c:if>
													<c:if test="${doctor.isWebDoctor==1}">
													<a class="on" style="">咨询</a>
													</c:if>
													<c:if test="${doctor.isWebDoctor!='1'}">
													<a class="off" style="">咨询</a>
													</c:if>
												</div>
											</div>
										</li>
									</c:forEach>
								</ul>
						</div>
					</div>
			   </c:if>
			            <c:if test="${!empty newspage.list}">
			             <div class="yil">
					       <div class="i7 zlm" > 
							<div class="center">
										<ul>
										  <c:forEach items="${newspage.list}" var="news">
										    <li class="">
												<a href="../news/${news.newsdetailid}${urlSuffix}" class="opacity zc">
												<div class="l">
													<c:choose>
														<c:when test="${news.newsdetailspicture == '' || news.newsdetailspicture == null}">
															<img src="${ctxStaticFront}/images/pic2.jpg">
														</c:when>
														<c:otherwise>
															<img width="103" height="103" src="${news.newsdetailspicture}">
														</c:otherwise>
													</c:choose>
												</div>
												<div class="r">
													<p><b>${news.newsdetailtitle}</b>&nbsp;&nbsp;&nbsp;<fmt:formatDate value="${news.pubtime}" pattern="yyyy/MM/dd HH:mm:ss"/>	</p>
													<span>${news.newsdetailabstract}</span>
												</div>
												</a>
											</li>
										  </c:forEach>
										</ul>
							 </div>
					  </div>	
				    </div>
			     </c:if>
    <c:if test="${!empty hospage.list}">	     
       <div class="page pgb">
<!-- <ul> -->
<!-- <li class="disabled"><a href="javascript:">&#171; 上一页</a></li> -->
<!-- <li class="active"><a href="javascript:">1</a></li> -->
<!-- <li class="disabled"><a href="javascript:">下一页 &#187;</a></li> -->
<!-- <li class="disabled controls"><a href="javascript:">当前 <input type="text" value="1" onkeypress="var e=window.event||this;var c=e.keyCode||e.which;if(c==13)page(this.value,10);" onclick="this.select();"/> / <input type="text" value="10" onkeypress="var e=window.event||this;var c=e.keyCode||e.which;if(c==13)page(1,this.value);" onclick="this.select();"/> 条，共 1 条</a><li> -->
<!-- </ul> -->
         ${hospage}
       </div>
       </c:if>
           <c:if test="${!empty docpage.list}">	     
             <div class="page pgb">${docpage}</div>
           </c:if>
           <c:if test="${!empty newspage.list}">	     
              <div class="page pgb">${newspage}</div>
           </c:if>
			</div>
		</div>
<script type="text/javascript">
$(".menav li").each(function(a){ 
		var me = $(".menav li:eq("+a+")"),i=a+1;
		me.find("img").attr("src","images/me_"+i+".png")
		me.hover(function(){ 
			me.find("img").attr("src","images/me_"+i+"h.png")
		},function(){ 
			me.find("img").attr("src","images/me_"+i+".png")

		})
})





</script>

<script type="text/javascript">
/* 筛选条件改变后初始化页码 */
$(function(){
  var select = document.getElementById('theSearch');
    select.onchange = function(){
      $("#pageNo").val(1); 
    }
})
function page(n, s) {
		if (n)
			$("#pageNo").val(n);
		if (s)
			$("#pageSize").val(s);
		//$("#searchForm").attr("action", "${ctx}/doctorinfo/myrepatient");
		$("#searchForm").submit();
		return false;
}
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

</script>
<script>
 if( !('placeholder' in document.createElement('input')) ){  
   
    $('input[placeholder],textarea[placeholder]').each(function(){   
      var that = $(this),   
      text= that.attr('placeholder');   
      if(that.val()===""){   
        that.val(text).addClass('placeholder');   
      }   
      that.focus(function(){   
        if(that.val()===text){   
          that.val("").removeClass('placeholder');   
        }   
      })   
      .blur(function(){   
        if(that.val()===""){   
          that.val(text).addClass('placeholder');   
        }   
      })   
      .closest('form').submit(function(){   
        if(that.val() === text){   
          that.val('');   
        }   
      });   
    });   
  } 
</script>	
</body>
</html>
