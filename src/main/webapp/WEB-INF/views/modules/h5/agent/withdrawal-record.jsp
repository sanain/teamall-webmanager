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
    <title>提现记录</title>
    <link rel="stylesheet" href="${ctxStatic}/h5/agent/css/withdrawal-record.css">
    <link rel="stylesheet" type="text/css" href="${ctxStatic}/h5/css/loding.css" media="all" />
    <link rel="stylesheet" href="${ctxStatic}/h5/css/bootstrap.min.css">
    <script src="${ctxStatic}/hAdmin/js/jquery.min.js"></script>
    <script>
    var range = 50; //距下边界长度/单位px
    var elemt = '500px'; //插入元素高度/单位px  
    var totalheight = 0;
    var endRow=0;
    var f=true;
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
	             url: "${ctxweb}/h5/agentUser/withdrawalRecordList",
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
	                     html+="<li><div><span>提现</span><b>"+data[i].amt+"</b></div><p><span>"+data[i].createTime+"</span><b>"+status+"</b></p></li>";
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
        function back(){
        	location.href="${ctxweb}/h5/agentUser/withdrawalBank?id=${id}";
        }
    </script>
</head>
<body>
    <div class="head-nav">
        <img class="img-responsive" src="${ctxStatic}/h5/agent/images/fanhui.png" onclick="back();">
        <span>提现记录</span>
    </div>

    <div class="context">
        <div class="withdrawal">
            <ul id="detailed"><%--
                <li>
                    <div>
                        <span>提现</span>
                        <b>+245.00</b>
                    </div>
                    <p>
                        <span>2017-01-03 16:30</span>
                        <b>处理中</b>
                    </p>
                </li>
                
            --%></ul>
        </div>
    </div>
 <div class="loading-fixed">
		<div class="load-container load" >
			<div class="loader">Loading...</div>
		</div>
	</div>
</body>
</html>