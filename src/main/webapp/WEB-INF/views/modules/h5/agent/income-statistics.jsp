<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
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
    <title>收益统计</title>
    <link rel="stylesheet" href="${ctxStatic}/h5/agent/css/income-statistics.css">
    <link rel="stylesheet" href="${ctxStatic}/h5/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="${ctxStatic}/h5/css/loding.css" media="all" />
    <script src="${ctxStatic}/hAdmin/js/jquery.min.js"></script>
    <script>
    var endRow=0;
    var f=true;
    var s=0;
        $(function(){
            $('html').css('font-size',$('body').width()/10+'px');
            scrollHtml(endRow);
            $(window).scroll(function(){
      		　　var scrollTop = $(this).scrollTop();
      		　　var scrollHeight = document.body.scrollHeight ;
      		　　var windowHeight = window.screen.height ;
      		   var  scrollTotal=scrollTop + windowHeight
      		　　if(scrollTotal = scrollHeight){
      			if(f){
      		　　　　scrollHtml(endRow);
      			}
      		　　}
      		});
            
        })
        
        function scrollHtml(lastRow){
        	 $.ajax({
	             type: "POST",
	             async: false,
	             url: "${ctxweb}/h5/agentUser/incomeStatisticsList",
	             data: {endRow:10,stateRow:lastRow},
	             beforeSend:function(){
    		     $(".loading-fixed").show();
    	         },
    	         success: function(data){
    	          $(".loading-fixed").hide();
	             var html="";
	             if(data!=null&&data.length>0){ 
	            	 endRow=parseInt(lastRow)+10;
	                  for (var i=0;i<data.length;i++){
	                	  s=parseInt(s)+1;
	                	  var dor=data[i].isAmbassador;
	                	  dor=dor==1?'精英合伙人':'普通合伙人 ';
	                     html+="<a class='tou' href='${ctxweb}/h5/agentUser/contributeDetails?userId="+data[i].userId+"'><i class='ixu'>"+s+"</i><div class='img-box'><img src='${ctxStatic}/h5/agent/images/tou-bg.png' alt=''></div><div class='name-iph'><span>"+data[i].mobile+"</span><p>"+dor+"</p></div><b class='sb-num'><img src='${ctxStatic}/h5/agent/images/shanbao1.png' alt=''>"+data[i].totalLoveCount+"</b></a>";
	                   }
	                  if(data.length<10){ 
	                	  f=false;
	                	  html+="<div style='padding-left: 38%;font-size: 0.312rem;color: #6E6161;font-weight: 550;'>没有更多数据了！</div>";
	                  }
	               }else{
	            	   f=false;
	            	   html+="<div style='padding-left: 38%;font-size: 0.312rem;color: #6E6161;font-weight: 550;'>没有更多数据了！</div>";
	               }
	             $("#detailed").append(html);
	            }
		     });
        }
        function handle(str){
    		if(typeof(str)=="undefined"){
    			return "";
    		}
    		return str;
    	}
    </script>
</head>
<body>
    <div class="head-nav">
        <img class="img-responsive" src="${ctxStatic}/h5/agent/images/fanhui.png" onclick="javascript:history.go(-1);">
        <span>收益统计</span>
    </div>

    <div class="context">
        <div class="money">
            <div class="money-left">
                <p>${shopUserCout}</p>
                <span>商家数 (个)</span>
            </div>
            <div class="money-right">
                <p>${totalLoveCount}</p>
                <span>共贡献积分 (个)</span>
            </div>
        </div>

        <div class="detailed">
            <p class="list-head">
                积分贡献
            </p>
            <div class="detailed-list" id="detailed"><%--
                <a class="tou" href="contribute-details.html">
                    <!--序号-->
                    <i class="ixu">1</i>

                    <div class="img-box">
                        <img src="${ctxStatic}/h5/agent/images/tou-bg.png" alt="">
                    </div>
                    <div class="name-iph">
                        <span>13864556684</span>
                        <p>普通会员</p>
                    </div>
                    <!--御可贡茶数-->
                    <b class="sb-num"><img src="${ctxStatic}/h5/agent/images/shanbao1.png" alt="">908.098</b>
                </a>
            --%></div>
        </div>
    </div>

</body>
</html>