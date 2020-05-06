<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/front/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<meta name="decorator" content="frontdefault"/>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title></title>
	<meta name="keywords" content="" />
	<meta name="description" content="" />
</head>

<body>

<div id="content" class="Mee"> 
				<div class="mefixd">
				<div class="menav">
					<div class="center">
						<ul>
								<li><a href="${ctx}/userinfo/baseinfo" ><img src=""><p>个人信息</p></a></li>
								<li><a href="${ctx}/userinfo/attentioninfo"><img src=""><p>我的关注</p></a></li>
								<li><a href="${ctx}/userinfo/userregisterinfo"><img src=""><p>我的预约</p></a></li>
								<li><a href="${ctx}/userinfo/userconsultinfo"><img src=""><p>我的咨询</p></a></li>
								<li><a href="${ctx}/userinfo/reportinfo"><img src=""><p>我的报告</p></a></li>
								<li><a href="${ctx}/userinfo/useroutpatientinfo"><img src=""><p>我的门诊</p></a></li>
								<li><a href="${ctx}/userinfo/palyinfo"><img src=""><p>我的缴费</p></a></li>
								<li><a href="${ctx}/userinfo/orderinfo"><img src=""><p>我的订单</p></a></li>
								<li><a href="${ctx}/userinfo/newscollectinfo" class="on"><img src=""><p>我的收藏</p></a></li>
									<!-- 	<li><a href=""><img src=""><p>健康记录评估</p></a></li> -->
								<li><a href="${ctx}/userinfo/healthFile""><img src=""><p>我的健康档案</p></a></li>
							<li><a href="${ctx}/xnh/init""><img src=""><p>新农合</p></a></li>
						</ul>
					</div>

					</div>

				</div>
				<div class="bar">
					<ul>
					</ul>
			    </div>
				<div class="sec">
						<div class="center"> 
								<form action="${ctx}/userinfo/newscollectinfo" method="post">
        			<input id="pageNo" name="pageNo" type="hidden" value="${pageinfo.pageNo}"/>
					<input id="pageSize" name="pageSize" type="hidden" value="${pageinfo.pageSize}"/>
								 <input type="text" placeholder="请输入查询关键字" name="search" value="${serchkey}" id="search" style="width:300px">	
								 <input type="submit" value="搜索">
								</form>
						</div>
				</div>
				<div class="met mtn">
						<div class="center" >
								
									<table cellspacing="0" ceelpadding='0'>
									<tr class="tr1"><td width="130px" class="num">序号</td>
										<td width="700px">资讯</td>
										<!-- <td width="200px">科室</td>
										<td width="160px">医生</td> -->
										<td >操作</td>
									</tr>
									<c:forEach items="${pageinfo.list}" var="order" varStatus="i">
									<c:if test="${not empty order.newscollectid}"> 
									  <tr>
									 	<td class="num">${i.index+1}</td>
										<td>${order.newsdetail.newsdetailtitle}</td>
										<td><a class="looknews" href="../news/${order.newsdetail.newsdetailid}${urlSuffix}" target="_Blank">查看</a>
										     <input id="nornewid" type="hidden" value="${order.newsdetailid}"/>
										    <a onclick="check()">取消收藏</a>
										</td>
									  </tr>
									 </c:if> 
										
									 <c:if test="${empty order.newscollectid}">
									   <tr>
										<td class="num"></td>
										<td></td>
										<td><a href=""></a>
											<a href=""></a>
											<a href=""></a>
										</td>
									  </tr>
									</c:if>
									</c:forEach>
								</table>
								<div class="page pgb">${pageinfo}</div>
						</div>
				</div>
				
		</div>



<script>
function check(){
        layer.alert("确认取消收藏？",{ 
			btn:['确定','取消'],
			yes:function(){ 
                   window.location.href="${ctx}/userinfo/newscollectinfo?detaiId="+$('#nornewid').val()+"";
			},/*url跳转*/
			cancel:function(){/*点击取消*/
			}
			});
	       return false; /*整个js执行完后停止*/
      };

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


<script type="text/javascript">


$(".menav li").each(function(a){ 

		var me = $(".menav li:eq("+a+")"),i=a+1;
		if(me.find("a").hasClass("on")){ 
				me.find("img").attr("src","${ctxStaticFront}/images/me_"+i+"h.png")
		}else{ 
			me.find("img").attr("src","${ctxStaticFront}/images/me_"+i+".png")
		}
		
		me.hover(function(){ 
			
			me.find("img").attr("src","${ctxStaticFront}/images/me_"+i+"h.png")
		},function(){ 
			if(!me.find("a").hasClass("on")){ 
				me.find("img").attr("src","${ctxStaticFront}/images/me_"+i+".png")
			}
			

		})
})

</script>

<script type="text/javascript">
	$(document).ready(function(){  
        $("#button_submit").click(function(){  
            var uname = $("#uname").val();  
            var nname = $("#nickname").val(); 
            var umail = $("#mail").val();
             
            if(uname==""){
                $("#msgbox").show();
                $("#msgcontent").text("用户名不能为空");
            	
            	return false;
            }
            if(nname==""){
            	 $("#msgbox").show();
                $("#msgcontent").text("昵称不能为空");
            	return false;
            }
             if(umail==""){
            	 $("#msgbox").show();
                $("#msgcontent").text("邮箱不能为空");
            	return false;
            }
        }); 
        
        
//         	$(".looknews").on("click", function() {
// 	      debugger;
// 			layer.open({
// 				type : 2,
// 				title : '全部结果',
// 				shadeClose : true,
				
// 				area : [ '600px', '550px' ],
// 				content : '${ctx}/userinfo/newscollectinfo?newsid='+$(this).attr("id")

// 			})

// 		});
		function page(n, s) {
		if (n)
			$("#pageNo").val(n);
		if (s)
			$("#pageSize").val(s);
		//$("#searchForm").attr("action", "${ctx}/doctorinfo/myrepatient");
		$("#searchForm").submit();
		return false;
}
    });  
</script>


</body>
</html>
