<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="robots" content="noarchive">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0,minimal-ui">
    <title>商品评论</title>
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/evaluate-manage.css">
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/bootstrap.min.css">
    <link rel="stylesheet" href="${ctxStatic}/sbShop/layui/css/layui.css">
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/build.css">
    <script src="${ctxStatic}/sbShop/js/jquery.min.js"></script>
    <script src="${ctxStatic}/sbShop/layui/layui.js"></script>
    <script src="${ctxStatic}/sbShop/js/base_form.js"></script>
    <script src="${ctxStatic}/sbShop/js/evaluate-manage.js"></script>
    <script>
    $(window.parent.document).find('.list-ul').find('ul').slideUp();
    $(window.parent.document).find('.list-ul').find('a').removeClass('active');
    </script>
</head>
<script type="text/javascript">
$(function(){ 
	selectStar();
}); 

function page(n,s){
			if(n) $("#pageNo").val(n);
			if(s) $("#pageSize").val(s);
			$("#searchForm").attr("action","${ctxweb}/shop/EbProductcomment/list");
			$("#searchForm").submit();
	    	return false;
	    }
 $(function(){
	  		$('body').on('click','.chongzhi',function(){
	  			$('.house-div input').val('');
	  			$('.house-div select option:nth-child(1)').attr('selected','selected');
	  		});
	  })
function selectStar(){
	$("#star").val(${star});
}
		
</script>

<style type="text/css">
    #btnSubmit{
        background: #393D49;
        height: 30px;
        width: 50px;
        float: left;
        margin-left: 20px;
    }


    .house{
        padding-top:0px;
        margin-top: -30px;
    }
</style>
<body>
    <div class="house">
       <form action="" id="searchForm" method="post" >
            <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
			<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
			<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
        <div class="house-div">
           <ul>
                <li>评分：</li>
                <li>
                    <select id="star" name="star">
                        <option value="0">全部评分</option>
                        <option value="5">好评</option>
                        <option value="2">中评</option>
                        <option value="1">差评</option>
                    </select>
                </li>
            </ul>
            <ul>
                <li>评价时间：</li>
                <li>
                    <input id="LAY_demorange_s" type="text" name="startTime" value="${startTime}">
                    <span>到</span>
                    <input id="LAY_demorange_e" type="text" name="endTime" value="${endTime}">
                </li>
            </ul>
            <ul class="sold-out two-btn-ul">
                <li style="width: 200px">
                    <input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/>

                </li>
            </ul>
        </div>
        </form>
             <ul class="house-list-top">
                <li>商品信息</li>
                <li>评分</li>
                <li>评价</li>
                <li>评价人</li>
                <li>评价时间</li>
            </ul>


        <div class="list-box">
          <c:forEach items="${page.list}" var="pc">
            <ul>
                <li title="${pc.productname}"><a href="${ctxweb}/shop/EbProductcomment/show?id=${pc.commentId}">${fns:abbr(pc.productname,30)}</a></li>
                <li>
                	<c:if test="${pc.overallMerit==1}">差评</c:if>
                	<c:if test="${pc.overallMerit==5}">好评</c:if>
                	<c:if test="${pc.overallMerit>=2&&pc.overallMerit<=4}">中评</c:if>
               	</li>
                <li title="${pc.contents}">${fns:abbr(pc.contents,30)}</li>
                <li>${pc.username}</li>
                <li><td><fmt:formatDate value="${pc.commentTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td></li>
            </ul>
           </c:forEach>
            
        </div>
        <!--分页-->
       <div class="pagination">
         ${page}
        </div>
    </div>

</body>
</html>