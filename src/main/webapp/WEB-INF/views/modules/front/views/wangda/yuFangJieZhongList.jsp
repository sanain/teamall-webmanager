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
<script type="text/javascript" src="${ctxStaticFront}/js/jquery.cascadingdropdown.js"></script>
<body>
 <style>
   .gywm .r .block_name {
    margin: 20px 0px;
     margin-right: 300px;
        margin-bottom: 29px;
        margin-left: 0px;
        }
 </style>
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
								<li><a href="${ctx}/userinfo/newscollectinfo"><img src=""><p>我的收藏</p></a></li>
									<!-- 	<li><a href=""><img src=""><p>健康记录评估</p></a></li> -->
							<li><a href="${ctx}/userinfo/healthFile" class="on"><img src=""><p>我的健康档案</p></a></li>
								<li><a href="${ctx}/xnh/init""><img src=""><p>新农合</p></a></li>
						</ul>
					</div>

					</div>

				</div>


		<div class="gywm">
			<div class="center">
				<div class="l">
					<div class="Gnavbar" style="">
						<ul style="">
							<li><a href="${ctx}/userinfo/aduitMedical/aduitMedicalInfo" class="opacity">成人体检信息</a>
							</li>
							<li><a href="${ctx}/userinfo/antenatal/antenatalInfo"  class="opacity" >产检记录</a>
							</li>
							<li><a href="${ctx}/userinfo/erTongJianKangTiJianDan/erTongJianKangTiJianDanInfo" >儿童体检记录</a>
							</li>
							<li><a href="${ctx}/userinfo/yuFangJieZhong/yuFangJieZhongInfo"class="opacity on ">预防疫苗记录</a>
							</li>
						</ul>

					</div>
				</div>
				<div class="r">
					<div class="block_name">
						<p class="">预防疫苗记录</p>
						<div class="brd"></div>
					</div>
					<div class="Gselect on">
						<table cellspacing="0" cellpadding="0">
							<tr class="tr1">
								<td  align="center">疫苗接种日期</td>
								<td  align="center">疫苗接种医院</td>
								<td align="center">疫苗接种人</td>
								<td  align="center">操作</td>
							</tr>
						<c:forEach items="${page.list }" var="aduitMedical" varStatus="varStatus" >	
						<tr class="tr1">	
								<td align="center">${aduitMedical.inoculationDate }</td>
								<td align="center">${aduitMedical.buildCardOrgName }</td>
									<td align="center">${aduitMedical.name }</td>
								<td align="center"><a href="" id="${aduitMedical.id}" class="chakan">查看</a></td>
						</tr>
								</c:forEach>
						</table>
					</div>

					</div>

				</div>
			</div>

		</div>

<div class="page pgb">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${page}</div>
	</div>

<script type="text/javascript">

function page(n, s) {
		if (n)
			$("#pageNo").val(n);
		if (s)
			$("#pageSize").val(s);
		$("#searchForm").submit();
		return false;
}

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

$(".Gselect.on").fadeIn()

function muo(o){ 

		if($(".Gselect.on").height() > $(".Gnavbar").height()){ 
		 o = $(".Gselect.on").height() + 143
		}else{ 
		 o = $(".Gnavbar").height() + 143
		}
		return o ;
}

$(".gywm").height(muo())
$(".Gnavbar li").each(function(){ 


	
		var i = $(this).index()
		var a = $(".Gselect:eq("+i+")")
		$(this).click(function(){ 
			if(!$(this).find("a").hasClass("on")){ 
			$(".Gselect.on").fadeOut().removeClass("on")
			$(".Gnavbar li a.on").removeClass("on")
			a.fadeIn().addClass("on")
			$(this).find("a").addClass("on")
			var ma  = muo();
			$(".gywm").animate({ 
					"height":ma
			})
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
        
    });  
    
    
    

$("a.chakan").on("click",function(){ 
	layer.open({ 
			  type: 2,
			    title: '报告详情',
			    shadeClose: true,
			    shade: 0.8,
			    area : [ '900px', '600px' ],
			    content : '${ctx}/userinfo/yuFangJieZhong/yuFangJieZhongDetails?id='+$(this).attr("id")

	})





})
    
    
</script>


</body>
</html>
