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
    <title>交易明细</title>
    <link rel="stylesheet" href="${ctxStatic}/h5/agent/css/transaction-details.css">
    <link rel="stylesheet" href="${ctxStatic}/h5/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="${ctxStatic}/h5/css/loding.css" media="all" />
    <script src="${ctxStatic}/hAdmin/js/jquery.min.js"></script>
    <script>
    var endRow=0;
    var f=true;
    var time="";
        $(function(){
            $('html').css('font-size',$('body').width()/10+'px');

            $('.d-del').click(function(){
                $(this).closest('.download').remove()
            });
            Date.prototype.toLocaleString = function() {
                return this.getFullYear() + "-" + (this.getMonth() + 1) + "-" + this.getDate();
            };
            var myDate = new Date('${time}');
            var dates= myDate.getTime();
           // var dates=new Date().getTime();
            //var timestamp=new Date();
            var newTime =myDate.toLocaleString();
            time=newTime;
            $('.date-span').text(newTime);
            $('.date-del').click(function(){
                dates-=86400000;
                timestamp=new Date(dates);
                newTime =timestamp.toLocaleString();
                time=newTime;
                $('.date-span').text(newTime);
                $("#detailed").html("");
                f=true;
                endRow=0;
                scrollHtml(endRow);
            });
            $('.date-add').click(function(){
                dates+=86400000;
                timestamp=new Date(dates);
                newTime =timestamp.toLocaleString();
                time=newTime;
                $('.date-span').text(newTime);
                $("#detailed").html("");
                f=true;
                endRow=0;
                scrollHtml(endRow);
            });
            
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
	             url: "${ctxweb}/h5/agentUser/transactionDetailsList?time="+time,
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
	                     html+="<ul><li>"+handle(data[i].ebUser.mobile)+"</li><li>"+handleStatus(data[i].onoffLineStatus)+"</li><li>"+data[i].orderAmount+"</li></ul>";
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
        function handleStatus(str){
    		if(typeof(str)=="undefined"){
    			return "";
    		}
    		if(str==1){
    			str="线上订单";
    		}else if(str==2){
    			str="线下订单";
    		}else if(str==3){
    			str="商家付款订单";
    		}
    		return str;
    	}
    </script>
</head>
<body>
    <div class="head-nav">
        <img class="img-responsive" src="${ctxStatic}/h5/agent/images/fanhui.png" onclick="javascript:history.go(-1);">
        <span>交易明细</span>
    </div>

    <div class="context">
        <div class="dates">
            <a class="date-del" href="javascript:;"><img src="${ctxStatic}/h5/agent/images/sel-left.png" alt=""></a>
            <span class="date-span">2017-01-09</span>
            <a class="date-add" href="javascript:;"><img src="${ctxStatic}/h5/agent/images/sel-right.png" alt=""></a>
        </div>

        <div class="detailed">
            <ul class="list-head">
                <li>会员账号</li>
                <li>订单类型</li>
                <li>金额 (元)</li>
            </ul>
            <div class="detailed-list" id="detailed"><%--
                <ul>
                    <li>2017-6-29</li>
                    <li>167.22</li>
                    <li>5615.02</li>
                </ul>
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