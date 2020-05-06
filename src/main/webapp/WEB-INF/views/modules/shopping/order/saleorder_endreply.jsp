<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
	<meta name="robots" content="noarchive">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, Order-scalable=0,minimal-ui">
    <meta name="Description" content="${fns:getProjectName()},销售信息"/>
	<meta name="Keywords" content="${fns:getProjectName()},销售信息"/>
    <title>销售信息</title>
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/sale_css.css">
    <script src="${ctxStatic}/sbShop/js/jquery.min.js"></script>
	 <link rel="stylesheet" href="${ctxStatic}/sbShop/css/shipments-detail.css">
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/bootstrap.min.css">
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/build.css">
    <script src="${ctxStatic}/sbShop/js/shipments-detail.js"></script>
    <link rel="stylesheet" href="${ctxStatic}/h5/agent/css/layer.css">
    <script src="${ctxStatic}/h5/js/layer.js"></script>
		 <script>          	
   	function wubtna(){
    	var endReplyRemark=$("#endReplyRemark").val();
    	if(endReplyRemark==""){
    		 layer.open({content: "请填写批复备注!",skin: 'msg',time: 2 });
			return;
		}
    	  //询问框
    	  layer.open({
    	    content: '确定批复？'
    	    ,btn: ['确定', '取消']
    	    ,yes: function(index){
    	        layer.close(index);
    	    	var frm =document.forms[0];
    	   		frm.submit();
    	    }
    	  });
    	
    }
    	function send(){
    		//询问框
      	  layer.open({
      	    content: '确认批复？'
      	    ,btn: ['确定', '取消']
      	    ,yes: function(index){
      	        layer.close(index);
      	    	window.location.href="${ctxsys}/Order/ordereditendReply?orderId=${ebOrder.orderId}";
      	    }
      	  });
      	
    	}
        
        
    </script>
</head>
<body>
    <div class="c-context">
      <ul class="nav-ul" style="margin:0px">
          <li><a style="height:100%;font-size:16px" href="${ctxsys}/Order/saleorderdata?orderId=${ebOrder.orderId}">订单资料</a></li>
          <li><a style="height:100%;font-size:16px" href="${ctxsys}/OrderLog/saleorderhis?orderId=${ebOrder.orderId}">历史分析</a></li>
          <li><a style="height:100%;font-size:16px" href="${ctxsys}/Order/saleorderdeliverylog?orderId=${ebOrder.orderId}">递送日志</a></li>
          <li><a style="height:100%;font-size:16px" href="${ctxsys}/Order/saleorderAftersalelist?orderId=${ebOrder.orderId}">订单退货处理</a></li>
          <li><a style="height:100%;font-size:16px" href="${ctxsys}/Order/saleorderdeliverymanager?orderId=${ebOrder.orderId}">递送管理</a></li>
          <li><a style="height:100%;font-size:16px" class="active" href="${ctxsys}/Order/saleorderendreply?orderId=${ebOrder.orderId}">最终批复</a></li>
		<li><a href="${ctxsys}/NcMessageTable/saleordernc?orderId=${ebOrder.orderId}">nc同步</a></li>
     
	 </ul>
    
	</div>
	<c:if test="${ebOrder.endReply!=null}">
	<div style="margin:10px">
	 <p><font color="red">*已批复</font></p>
	<form class="form-horizontal" action="${ctxsys}/Order/ordereditendReply" method="post" name="form2">
                <div class="li-1">
                    <ul>
                        <li>批复结果：
                          <c:if test="${ebOrder.endReply==1}"><font color="green">通过</font></c:if>
                           <c:if test="${ebOrder.endReply==2}"><font color="red">不通过</font></c:if>
							
                        </li>
                        <li style="margin-top:10px">
                        	批复备注： ${ebOrder.endReplyRemark}
                        </li>
                    </ul>
      </div>
	</c:if>
	<c:if test="${ebOrder.endReply==null}">
	<div style="margin:10px">
	 <p>最终批复</p>
	<form class="form-horizontal" action="${ctxsys}/Order/ordereditendReply" method="post" name="form2">
                <div class="li-1">
                    <ul>
                        <li>批复结果：
                            <select name="endReply" id="endReply">
                            <c:forEach items="${dicts}" var="dict">
                                <option value="${dict.id}">${dict.label}</option>
                            </c:forEach>
                            </select>
							
                        </li>
                        <li style="margin-top:10px"><input id="orderId" name="orderId" type="hidden" style="display:none;" value="${ebOrder.orderId}"/>
                        	批复备注： <input id="endReplyRemark" value="${ebOrder.endReplyRemark}" name="endReplyRemark" type="text">
                        </li>
                    </ul>
                    <a class="btn btn-primary" href="javascript:;" onclick="wubtna();">确定</a>
      </div>
    </form>
	 </div>
	 </c:if>
</body>
</html>