<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title></title>
	<meta name="decorator" content="default"/>
	<%@include file="/WEB-INF/views/include/treeview.jsp" %>
	<script type="text/javascript">
	$(document).ready(function(){
			var hige=window.screen.height;
			var higet=hige-250;
			$(".col-md-8").css('height',higet+'px')
			$(".col-md-4").css('height',higet+'px')
			$("#openClose").css('height',higet+'px')
				var openClose=true;
				$('#openClose').click(function(){
					
					if(openClose==true){
						$('.top1').animate({width:'0'},900);
						$('.up1').animate({width:'98%'},900);
						openClose=false;
					
					}else{
						$('.top1').animate({width:'20%'},900);
						$('.up1').animate({width:'78%'},900);
						openClose=true;
					
					}
				})
			});
	</script>
	<style>
		.col-md-8{
			float:left;
			width:20%;
			border:1px solid #ddd;
		}
		.col-md-4{
			float:left;
			width:78%;
			border:1px solid #ddd;
		}
	</style>
      </head>
               <body scroll="no" >
  					<div class="col-md-8 top1">
  					<iframe name="left" src="${ctxsys}/PmProductTypeBrand/tree" style="width: 100%; height: 100%;border: 1px solid #69AC72;"></iframe>
  					    <!-- <div id="menuTree" class="ztree" style="margin-top:3px;float:left;"></div> -->
  					</div>
  					<div id="openClose" class="close">&nbsp;</div>
					<div class="col-md-4 up1">
					  <iframe name="right" src="${ctxsys}/PmProductTypeBrand/list?productTypeId=1" style="width: 100%; height: 100%;border: 1px solid #69AC72;" ></iframe>
					</div>
              </body>
        </html>