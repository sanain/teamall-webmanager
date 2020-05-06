<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
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
    <title>商品评价</title>
    <link rel="stylesheet" href="${ctxStatic}/h5/css/commodity-evaluate.css">
    <link rel="stylesheet" href="${ctxStatic}/h5/css/bootstrap.min.css">
    <script src="${ctxStatic}/h5/js/jquery.min.js"></script>
    <link rel="stylesheet" type="text/css" href="${ctxStatic}/h5/css/loding.css" media="all" />
    <script>
        var range = 50; //距下边界长度/单位px
        var elemt = '500px'; //插入元素高度/单位px  
        var totalheight = 0;
        var tttz=0;
        var operationType="0";
        var endRow="0";
        var id="${ebProduct.productId}";
        var downtime = 3600;
	    Date.prototype.toLocaleString = function() {
	          return this.getFullYear() + "-" + (this.getMonth() + 1) + "-" + this.getDate();
	    };
	    function timee(tim){
	    	var unixTimestamp = new Date(tim) ;
			commonTime = unixTimestamp.toLocaleString();
			return commonTime;
	    }
        $(function(){
            $('html').css('font-size',$('body').width()/10+'px');

            $('.d-del').click(function(){
                $(this).closest('.download').remove()
            });
            
            $('.pin-list li').click(function(){
            	$(this).addClass('active').siblings().removeClass('active')
            });

        })
        $(document).ready(function(){
             $(".loading-fixed").hide();
              ajke();
            $(window).scroll(function(){
                var srollPos = $(window).scrollTop(); //滚动条距顶部距离(页面超出窗口的高度)
                totalheight = parseFloat($(window).height()) + parseFloat(srollPos);
                if(($(document).height()) <= totalheight&&tttz==0) {
                var main = $(".pin-jia"); //主体元素
                   $.ajax({
			             type: "POST",
			             url: "${ctxweb}/ProductDetailsHtml/EbProductcomment/jsonTo",
			             data: {id:id,operationType:operationType,endRow:(parseInt(endRow)+10),stateRow:endRow},
			             beforeSend:function(){
		    		     $(".loading-fixed").show();
		    	         },success: function(data){
		    	          $(".loading-fixed").hide();
			             console.log(data);
			             endRow=data.endRow;
			             var html="";
			             if(data.ebProductcommentsList!=null&&data.ebProductcommentsList.length>0){ 
			                  $('.over').hide();
                              tttz=0;
			                  for (var i=0;i<data.ebProductcommentsList.length;i++){
			                      html+=" <div class='pin-box'><p><img src='${ctxStatic}/h5/images/comm-toux.png' alt=''><span>"+data.ebProductcommentsList[i].username+"</span></p>";
			                      html+="<span>"+data.ebProductcommentsList[i].contents+"</span><div>"+timee(data.ebProductcommentsList[i].commentTime)+"   "+data.ebProductcommentsList[i].productname+"</div>";
			                      if(data.ebProductcommentsList[i].picture!=null){
			                       var pictrues= data.ebProductcommentsList[i].picture.split(",");
			                       html+="<ul>";
			                       for (var j=0;j<pictrues.length;j++){
			                         html+="<li><img src="+pictrues[j]+" alt=''></li>";
			                         }
			                        html+="</ul>";
			                      }
			                        html+="</div>";
			                   }
			               }else{
			               	$('.over').show();
			                 tttz=1;
			               }
			               if(endRow=='10'){
			                main.html(html);
			               }else{
			                main.append(html);
			               }
			             }
			         });
                }
            });
        });
         function fak(type){
         if(type=='0'){
           operationType="0";
           endRow="0";
           ajke();
         }else if(type=='1'){
           operationType="1";
           endRow="0";
           ajke();
         }else if(type=='2'){
           operationType="2";
           endRow="0";
           ajke();
         }else if(type=='3'){
           operationType="3";
           endRow="0";
           ajke();
          
         }else if(type=='4'){
           operationType="4";
           endRow="0";
           ajke();
         }
        }
         function ajke(){
          var main = $(".pin-jia"); //主体元素
          $.ajax({
             type: "POST",
             url: "${ctxweb}/ProductDetailsHtml/EbProductcomment/jsonTo",
             data: {id:id,operationType:operationType,endRow:(parseInt(endRow)+10),stateRow:endRow},
             beforeSend:function(){
   		     $(".loading-fixed").show();
   	         },success: function(data){
   	          $(".loading-fixed").hide();
             console.log(data);
             endRow=data.endRow;
             var html="";
             if(data.ebProductcommentsList!=null&&data.ebProductcommentsList.length>0){ 
                  $('.over').hide();
                  tttz=0;
                  for (var i=0;i<data.ebProductcommentsList.length;i++){
                      html+=" <div class='pin-box'><p><img src='${ctxStatic}/h5/images/comm-toux.png' alt=''><span>"+data.ebProductcommentsList[i].username+"</span></p>";
                      html+="<span>"+data.ebProductcommentsList[i].contents+"</span><div>"+timee(data.ebProductcommentsList[i].commentTime)+"  "+data.ebProductcommentsList[i].productname+"</div>";
                      if(data.ebProductcommentsList[i].picture!=null){
                       var pictrues= data.ebProductcommentsList[i].picture.split(",");
                       html+="<ul>";
                       for (var j=0;j<pictrues.length;j++){
                         html+="<li><img src="+pictrues[j]+" alt=''></li>";
                         }
                        html+="</ul>";
                      }
                        html+="</div>";
                   }
               }else{
               	$('.over').show();
                 tttz=1;
               }
               if(endRow=='10'){
                main.html(html);
               }else{
                main.append(html);
               }
              
             }
         });
        }
    </script>
</head>
<body>
    <div class="head-nav">
        <img class="img-responsive" src="${ctxStatic}/h5/images/back-icon1.png" alt="" style="width: 6.33%;">
        <ul>
            <li><a href="${ctxweb}/ProductDetailsHtml/${ebProduct.productId}.html" style="color: #adadad;">商品</a></li>
            <li><a href="${ctxweb}/ProductDetailsHtml/ProductDetailsId/${ebProduct.productId}.html" style="color: #adadad;">详情</a></li>
            <li><a class="active" href="${ctxweb}/ProductDetailsHtml/EbProductcomment/${ebProduct.productId}.html" style="color: #333333;
    border-bottom: 0px solid #ff0000;
    display: inline-block;">评价</a></li>
        </ul>
    </div>
    
    <div class="context">
        <!--评价-->
        <div class="comm-pin">
            <p>宝贝评价（<span>${ebProduct.comments}</span>）</p>
            <ul class="pin-list">
                <li class="active"   onclick="fak('0')" ><span>全部<b>(${all})</b></span></li>
                <li  onclick="fak('1')" ><span>有图<b>(${ picture})</b></span></li>
                <li  onclick="fak('2')" ><span>满意<b>(${ good})</b></span></li>
                <li  onclick="fak('3')" ><span>一般<b>(${ middle})</b></span></li>
                <li  onclick="fak('4')" ><span>不满意<b>(${bad })</b></span></li>
            </ul>
            
            <div class="pin-jia">
           <%--     <c:forEach items="${ebProductcommentsList}" var="ebProductcommentsList">
                <div class="pin-box">
                    <p>
                        <img src="${ctxStatic}/h5/images/comm-toux.png" alt="">
                        <span>${ebProductcommentsList.username}</span>
                    </p>
                    <span>${ebProductcommentsList.contents}<!-- 超好看，身高175体重110斤，m码刚刚好，腰围有一点松腿型好看，亚麻色适合夏天。 --></span>
                    <div><fmt:formatDate value='${ebProductcommentsList.commentTime}' pattern='yyyy-MM-dd'/> ${ebProductcommentsList.productname}</div>
                    <c:if test="${not empty ebProductcommentsList.picture}">
                    <ul>
                       <c:set value="${fn:split(ebProductcommentsList.picture, ',')}" var="names" />
                       <c:forEach items="${names}" var="name">
                        <li>
                            <img src="${name}" alt="">
                        </li>
                        </c:forEach>
                        <li>
                            <img src="${ctxStatic}/h5/images/comm-pin1.png" alt="">
                        </li>
                        <li>
                            <img src="${ctxStatic}/h5/images/comm-pin1.png" alt="">
                        </li>
                    </ul>
                   </c:if>
                </div>
                </c:forEach> --%>
<%-- 
                <div class="pin-box">
                    <p>
                        <img src="${ctxStatic}/h5/images/comm-toux.png" alt="">
                        <span>爱丽巴迪</span>
                    </p>
                    <span>超好看，身高175体重110斤，m码刚刚好，腰围有一点松腿型好看，亚麻色适合夏天。</span>
                    <div>2017-05-05 颜色分类：黑色；尺寸：m</div>
                    <ul>
                        <li>
                            <img src="${ctxStatic}/h5/images/comm-pin1.png" alt="">
                        </li>
                        <li>
                            <img src="${ctxStatic}/h5/images/comm-pin1.png" alt="">
                        </li>
                        <li>
                            <img src="${ctxStatic}/h5/images/comm-pin1.png" alt="">
                        </li>
                    </ul>
                </div> --%>
<%-- 
                <div class="pin-box">
                    <p>
                        <img src="${ctxStatic}/h5/images/comm-toux.png" alt="">
                        <span>爱丽巴迪</span>
                    </p>
                    <span>超好看，身高175体重110斤，m码刚刚好，腰围有一点松腿型好看，亚麻色适合夏天。</span>
                    <div>2017-05-05 颜色分类：黑色；尺寸：m</div>
                    <ul>
                        <li>
                            <img src="${ctxStatic}/h5/images/comm-pin1.png" alt="">
                        </li>
                        <li>
                            <img src="${ctxStatic}/h5/images/comm-pin1.png" alt="">
                        </li>
                        <li>
                            <img src="${ctxStatic}/h5/images/comm-pin1.png" alt="">
                        </li>
                    </ul>
                </div> --%>
            </div>
	<div class="loading-fixed">
		<div class="load-container load" >
			<div class="loader">Loading...</div>
		</div>
	</div>
            <div class='over' style='display:none;width: 30%;margin: 0 auto;background: #CCCCCC;border-radius: 38px;text-align: center;height: 0.8rem;line-height: 0.8rem;margin-top: 20px;color: #fff;font-size: 0.35rem'>已经没有啦！</div>
            <div></div>
        </div>
    </div>

    <div class="download">
        <img class="down-logo" src="${ctxStatic}/h5/images/logo.png" alt="">
        <span>下载${fns:getProjectName()}</span>
        <a href="${ctxweb}/download" style="background: #3BC969;">立即下载</a>
        <img class="d-del" src="${ctxStatic}/h5/images/d-del.png" alt="">
    </div>

</body>
</html>
