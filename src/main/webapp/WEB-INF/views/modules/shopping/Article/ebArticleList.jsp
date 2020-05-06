<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>规格列表</title>
	<meta name="decorator" content="default"/>
	 <link rel="stylesheet" href="${ctxStatic}/sbShop/css/build.css">
	<script type="text/javascript">
	function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").attr("action","${ctxsys}/ebArticle/list");
			$("#searchForm").submit();
	    	return false;
	    }
	
	function sort(t,oneId,num,sno){
		var count=parseInt(${page.count});
		var pageNo=parseInt(${page.pageNo});
		var pageSize=parseInt(${page.pageSize});
		var twoId;
		//向下
		if(num=="-1"){
		   var nn=count-pageSize*(pageNo-1);
		   if(nn==sno){
			    alert("最后面了")
				return; 
		   }
			if(sno==pageSize){
				alert("最后面了")
				return;
			}
		   twoId=$(t).parent().parent().next().attr("id");
		}
		//点向上
		if(num=="1"){
			if(pageNo==1&&sno==1){
				alert("最前面了")
				return;
			}
			twoId=$(t).parent().parent().prev().attr("id");
		}

       	 $.ajax({
	             type: "POST",
	             url: "${ctxsys}/ebArticle/sort?oneId="+oneId+"&twoId="+twoId+"",
   	        	 success: function(data){
	             if(data!=null&&data.length>0){ 
	            	 $("#searchForm").submit();
	             }
	             }
	             });
	}
	
	</script>
	<style>
        .check{position: fixed;top:0;left: 0;right: 0;bottom: 0;background: rgba(0,0,0,0.3);z-index: 10000}
        .check-box{width: 750px;background: #ffffff;position: absolute;top: 50%;left: 50%;margin-left: -375px;margin-top: -200px;}
        .check-box>p{height: 35px;line-height: 35px;background: #f0f0f0;position: relative;text-align: center}
        .check-box>p img{position: absolute;top:12px;right: 15px;cursor: pointer}
        .check-box ul{overflow: hidden;padding: 10px;outline:none;list-style:none}
        .check-box ul li.checkbox{float: left;width: 33.33%;line-height: 30px;margin-top: 0;}
        .check-btn{text-align: center;padding-bottom: 20px}
        .check-btn a{display: inline-block;width: 80px;height: 30px;line-height: 30px;border-radius: 5px;border: 1px solid #dcdcdc}
        .check-btn a:nth-child(1){background: #68C250;border: 1px solid #68C250;color: #ffffff;margin-right: 5px}
        .check-btn a:nth-child(2){color: #666666;margin-left: 5px}
        .check-box .checkbox input[type="checkbox"]:checked + label::before {
            background: #68C250;
            top:0 px;
            border: 1px solid #68C250;
        }
        .check-box .checkbox label::before{
            top: 0px;
        }
        .check-box .checkbox i{
            position: absolute;
            width: 12px;
            height: 8px;
            background: url(../images/icon_pick.png) no-repeat;
            top: 4px;
            left: -18px;
            cursor: pointer;
        }
        a{cursor: pointer;}
        .check-box .checkbox input{top: 10px;position:relative}
    </style>
     <script type="text/javascript">
    	$(function(){
    	$('.check').hide();
	    	$('body').on('click','.check-a',function(){
	    		$('.check').show();
	    	});
	    	$('body').on('click','.check-del',function(){
	    		$('.check').hide();
	    	});
    	})
    	function writable(a,va){
    	  $("#ids").val(a);
    	   var html="";
    	   $.ajax({
				type: "POST",
				url: "${ctxsys}/Product/classOne",
				data: {"type":"2"},
				success: function(data){
				  for(var i=0;i<data.length;i++){
				  if(va!=null){
				  var strs= new Array(); 
				     strs= va.split(",");
				    if(strs!=null){
				      html+="<li class='checkbox'><input type='checkbox' name='tag' value='"+data[i].id+"'";
				     for(var j=0;j<strs.length;j++){
				        if(strs[j]==data[i].id){
				           html+="  checked='checked'  ";
				          }
				      }
				        html+="><label><i></i>"+data[i].name+"</label></li>";
				      }
				   }
				 }
				$(".mn").html(html);
			   }
		  });
    	$('.check').show();
    	}
    	function sbmit(){
    	$("#fromsb").submit();
    	}
    </script>
    <script type="text/javascript">
      function loke(vals,id){
       window.opener.document.getElementById('advertiseTypeObjIds').value=id;
       window.opener.document.getElementById('imgsvala').src='${ctxStatic}/uploads/000000/images/merchandise/ebAdvertise/2017/06/396f959f2c9f4e75af04f1e5e25611e9.jpg';
       window.opener.document.getElementById('pnamea').innerHTML=vals;
       window.opener.document.getElementById('pnamea').title=vals;
       window.open("about:blank","_self").close();
     }
    </script>
</head>
<body>

	<ul class="nav nav-tabs">
	<li class="active"><a href="${ctxsys}/ebArticle/list?articleTypeId=${articleTypeId}">文章列表</a></li>
	<li>
	  <shiro:hasPermission name="merchandise:ebArticle:edit">
	   <a href="${ctxsys}/ebArticle/from?articleTypeId=${articleTypeId}">文章添加</a>
	  </shiro:hasPermission>
	</li>
	</ul>
	 <form:form id="searchForm" modelAttribute="ebArticle" action="${ctxsys}/ebArticle/list" method="post" class="breadcrumb form-search ">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
	    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
		<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<form:hidden path="articleTypeId" value="${articleTypeId}" />
		<input type="hidden" name="stule" value="${stule}">
		 <ul class="ul-form">
		    <li><label>标题:</label><form:input path="articleTitle" htmlEscape="false" maxlength="50" class="input-medium"   placeholder=""/></li>
		    <li><label>作者姓名:</label><form:input path="articleAuthor" htmlEscape="false" maxlength="50" class="input-medium"   placeholder=""/></li>
			<%--<li><label>类型：</label>
			 <form:select path="spertAttrType">
			   <form:option value="">请选择</form:option>
			   <form:option value="1">规格</form:option>
			   <form:option value="2">属性</form:option>
			 </form:select>
			</li>
			--%>
			<li><label></label><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/></li>
		</ul> 
	</form:form> 
	<tags:message content="${message}"/>
	<table id="treeTable" class="table table-striped table-condensed table-bordered" >
		<tr>
		<th class="center123">序号</th>
		<th class="center123">标题</th>
		<th class="center123">作者</th>
		 <c:if test="${ebArticleType.articleTypeCode!='syzdydhl'}">
		<th class="center123">导购文章</th>
		<th class="center123">关键词</th>
		</c:if>
		<c:if test="${ebArticleType.articleTypeCode=='syzdydhl'}">
		<th class="center123">超链接</th>
		</c:if>
		<c:if test="${stule!='99'}">
		 <c:if test="${ebArticleType.articleTypeCode!='syzdydhl'}">
		<th class="center123">浏览数</th>
		<th class="center123">收藏数 </th>
		</c:if>
		<th class="center123">状态</th>
		</c:if>
		<th class="center123">发布时间</th>
		<th class="center123">操作</th>
		</tr>
		<c:forEach items="${page.list}" var="ebArticle" varStatus="status" >
			 <tr id="${ebArticle.articleId}">
			    <td class="center123"><a>${status.index+1}.</a></td>
			    <td title='${ebArticle.articleTitle}'>${fns:abbr(ebArticle.articleTitle,30)}</td>	
			    <td class="center123">${ebArticle.articleAuthor}</td>
				 <c:if test="${ebArticleType.articleTypeCode!='syzdydhl'}">
			    <td class="center123">${ebArticle.articleIsguide==0?"是":"否"}</td>
			    <td class="center123">${ebArticle.articleKeyword}</td>
				</c:if>
				<c:if test="${ebArticleType.articleTypeCode=='syzdydhl'}">
				<td class="center123">${ebArticle.articleUrl}</td>
				</c:if>
			    <c:if test="${stule!='99'}">
				<c:if test="${ebArticleType.articleTypeCode!='syzdydhl'}">
			    <td class="center123">${empty ebArticle.articleMediumint?0:ebArticle.articleMediumint}</td>
			    <td class="center123">${empty ebArticle.articleFavorites?0:ebArticle.articleFavorites}</td>
				</c:if>
			    <td class="center123"> 
			        <c:if test="${ebArticle.articleStatus==1}">隐藏</c:if>
					<c:if test="${ebArticle.articleStatus==2}">删除</c:if>
					<c:if test="${ebArticle.articleStatus==0}">显示</c:if>
				</td>
				</c:if>
				 <td class="center123"><fmt:formatDate value="${ebArticle.releasetime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
			   	 <td class="center123">
			   	   <c:if test="${stule!='99' }">
			   	    <a  onclick="sort(this,${ebArticle.articleId},1,'${status.index+1}')"><i title="向上排" class="icon icon-arrow-up"></i></a>
			   	    <a  onclick="sort(this,${ebArticle.articleId},-1,'${status.index+1}')"><i title="往下排"class="icon icon-arrow-down"></i></a>
			   	    <a  onclick="writable(${ebArticle.articleId},'${ebArticle.labelIds}')">添加标签</a>
			   	    <a href="${ctxsys}/ebArticle/detail?articleId=${ebArticle.articleId}">详情</a>
			   	 	<a href="${ctxsys}/ebArticle/from?articleId=${ebArticle.articleId}">修改</a>
			   	 	<a href="${ctxsys}/ebArticle/commentlist?articleTypeId=${ebArticle.articleTypeId}&articleId=${ebArticle.articleId}">查看评论</a>
					<a href="${ctxsys}/ebArticle/delete?id=${ebArticle.articleId}" onclick="return confirmx('是否删除该条信息？', this.href)">删除</a>
				    </c:if>
				    <c:if test="${stule=='99' }">
				     <a onclick="loke('${ebArticle.articleTitle}','${ebArticle.articleId}')" >选择</a>
				    </c:if>
				 </td>
			</tr>
		</c:forEach>
	</table>
	<div class="pagination">${page}</div>
	 <form action="${ctxsys}/ebArticle/saveTags" id="fromsb">
    <div class="check">
    <div class="check-box">
        <p>请选择标签<img class="check-del" src="${ctxStatic}/sbShop/images/xxx-rzt.png" alt=""></p>
         <input type="hidden" value="" name="id" id="ids">
          <ul class="mn">
        </ul>
        <div class="check-btn">
            <a href="javascript:;" onclick="sbmit()">确定</a>
            <a class="check-del" href="javascript:;">取消</a>
        </div>
      </div>
    </div>
  </form>
</body>
</html>