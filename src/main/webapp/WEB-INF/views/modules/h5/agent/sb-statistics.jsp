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
    <title>${fns:getProjectName()}明细</title>
    <link rel="stylesheet" href="${ctxStatic}/h5/css/bootstrap.min.css">
    <script src="${ctxStatic}/hAdmin/js/jquery.min.js"></script>
    <link rel="stylesheet" href="${ctxStatic}/h5/agent/css/sb-statistics.css">
    
    <link rel="stylesheet" type="text/css" href="${ctxStatic}/h5/css/loding.css" media="all" />
    <script>
    var range = 50; //距下边界长度/单位px
    var elemt = '500px'; //插入元素高度/单位px  
    var totalheight = 0;
    var endRow=0;
    var nums=[]; 
    var max=0;
        $(function(){
            $('html').css('font-size',$('body').width()/10+'px');

            scrollHtml(endRow);
          //  $(window).scroll(function(){
                //    var srollPos = $(window).scrollTop(); //滚动条距顶部距离(页面超出窗口的高度)
                //    totalheight = parseFloat($(window).height()) + parseFloat(srollPos);
               //     if(($(document).height()) <= totalheight) {
              //      	scrollHtml(endRow);
              //      }
            //    });

        })
        
        function scrollHtml(lastRow){
        	 $.ajax({
	             type: "POST",
	             async: false,
	             url: "${ctxweb}/h5/agentUser/agentLoveList",
	             data: {endRow:30,stateRow:lastRow},
	             beforeSend:function(){
    		     $(".loading-fixed").show();
    	         },
    	         success: function(data){
    	          $(".loading-fixed").hide();
	             var html="";
	             if(data!=null&&data.length>0){ 
	            	 endRow=parseInt(lastRow)+10;
	                  for (var i=0;i<data.length;i++){
	                	  nums.push(data[i].love);
	                     html+="<li><span>"+timeStamp2String(data[i].createTime)+"</span><div><p style='width: 100%'><b>"+data[i].love+"</b></p></div></li>";
	                   }
	               }else{
	              }
	             $("#detailed").append(html);
	             findattr();
	            }
		     });
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
        function findattr() {
        	max=getMaximin(nums,"max");
        	 $("#detailed").find("li").each(function(){ 
        		var p= $(this).find("p");
        		var b= $(this).find("b").text();
        		var s=b/max*100<1?1:b/max*100;
        		$(p).css("width",""+s+"%");
        		
        	})
        }
        function getMaximin(arr,maximin) 
        { 
        if(maximin=="max") 
        { 
        return Math.max.apply(Math,arr); 
        }
        else if(maximin=="min") 
        { 
        return Math.min.apply(Math, arr); 
        } 
        } 
        function back(){
      	  location.href='${ctxweb}'+'/h5/agentUser//agentShanbao';
        }
    </script>
</head>
<body>
    <div class="head-nav">
        <img class="img-responsive" src="${ctxStatic}/h5/agent/images/fanhui.png" onclick="back();">
        <span>${fns:getProjectName()}明细</span>
    </div>

    <div class="context">
        <div class="lei">
            <p>累计积分数 (个)</p>
            <span>${totalLove }</span>
        </div>

        <div class="detailed">
            <ul id="detailed"><%--
                <li>
                    <span><fmt:formatDate value="${pc.createTime}" pattern="yyyy-MM-dd HH:ss"/></span>
                    <div>
                        <p style="width: 80%">
                            <b>${pc.love}</b>
                        </p>
                    </div>
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