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
    <title>商家管理</title>
    <link rel="stylesheet" href="${ctxStatic}/h5/agent/css/vip-management.css">
    <link rel="stylesheet" href="${ctxStatic}/h5/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="${ctxStatic}/h5/css/loding.css" media="all" />
    <script src="${ctxStatic}/hAdmin/js/jquery.min.js"></script>
    <script>
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
	             url: "${ctxweb}/h5/agentUser/userList",
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
	                	  var dor=data[i].isAmbassador;
	                	  dor=dor==1?'精英合伙人':'普通合伙人 ';
	                     html+="<a class='tou' href='${ctxweb}/h5/agentUser/contributeDetails?userId="+data[i].userId+"'><div class='img-box'><img src='${ctxStatic}/h5/agent/images/tou-bg.png'></div><div class='name-iph'><span>"+data[i].mobile+"</span><p>"+dor+"</p></div><div class='sb-img'><span>人脉 <i>"+data[i].myAnswer+"</i></span><p>"+timeStamp2String(data[i].shopBindTime)+"</p></div></a>";
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
    	function timeStamp2String (time){
    		if(typeof(time)=="undefined"){
    			return "";
    		}
    		var datetime = new Date(time);
    	    //datetime.setTime(time);
    	    var year = datetime.getFullYear();
    	    var month = datetime.getMonth() + 1;
    	    var date = datetime.getDate();
    	    var hour = datetime.getHours();
    	    var minute = datetime.getMinutes();
    	    var second = datetime.getSeconds();
    	    var mseconds = datetime.getMilliseconds();
    	    return year + "-" + month + "-" + date;
    	};
    </script>
</head>
<body>
    <div class="head-nav">
        <img class="img-responsive" src="${ctxStatic}/h5/agent/images/fanhui.png" onclick="javascript:history.go(-1);">
        <span>商家管理</span>
    </div>

    <div class="context">
        <div class="vip-num">
           <p>${shopUserCout}</p>
            <span>商家数 (个)</span>
        </div>

        <div class="detailed">
            <div class="detailed-list" id="detailed">
                <%--<a class="tou" href="contribute-details.html">
                    <div class="img-box">
                        <img src="${ctxStatic}/h5/agent/images/tou-bg.png" alt="">
                    </div>
                    <div class="name-iph">
                        <span>13864556684</span>
                        <p>普通会员</p>
                    </div>

                    <div class="sb-img">
                        <span>人脉 <i>52</i></span>
                        <p>2017-05-23</p>
                    </div>
                </a>

            --%></div>
        </div>
    </div>
	<div class="loading-fixed">
		<div class="load-container load" >
			<div class="loader">Loading...</div>
		</div>
	</div>
</body>
</html>