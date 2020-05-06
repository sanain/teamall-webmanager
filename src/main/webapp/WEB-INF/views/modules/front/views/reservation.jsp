<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/modules/front/include/taglib.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>


<!DOCTYPE html>
<html>
<head>
	<title>预约挂号</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<body>
<link rel="stylesheet" type="text/css" href="${ctxStatic}/front/css/style.css" media="all" />
<link rel="stylesheet" type="text/css" href="${ctxStatic}/front/css/animat.css" media="all" />
<link rel="stylesheet" type="text/css" href="${ctxStatic}/static/front/css/filp.css" media="all" />
<script type="text/javascript" src="${ctxStaticFront}/js/jquery.min.js"></script>
<script type="text/javascript" src="${ctxStaticFront}/js/dome.js"></script>
<script type="text/javascript" src="${ctxStaticFront}/js/superslide.2.1.js"></script>
<script type="text/javascript" src="${ctxStaticFront}/js/imagesloaded.pkgd.min.js"></script>
<script type="text/javascript" src="${ctxStaticFront}/js/jquery.masonry.min.js"></script>
<script type="text/javascript" src="${ctxStaticFront}/js/layer/layer.js"></script>
<script type="text/javascript" src="${ctxStaticFront}/js/jquery.cascadingdropdown.js"></script>
<style type="text/css">
   	.cascading-dropdown-loading {
   		cursor: wait;
   		background: url('${ctxStaticFront}/images/ajax-loader.gif') 85% center no-repeat transparent;
   	}
   	body{min-width:0;}
   </style>
	
<div class="ghlb"><div class="Fontsbar"><p>预约挂号</p><span>APPOINTMENT REGISTER</span></div>
	<ul id="ghselect">
		<li><p>区域</p><select id="cityId" name="cityId" class="step1" >
											  	<option value="0" selected="selected">---请选择---</option>
												<c:forEach var="cityitem" items="${citys}">
													<option value="${cityitem.cityid}"><c:out value="${cityitem.city}"></c:out></option>
												</c:forEach>
											</select>
		</li>
	<%-- 	<li><p>级别</p>
		<select id="levelId" name="levelId" class="step2" >
												<option value="0" selected="selected">---请选择---</option>
												<c:forEach var="map" items="${level}">
													<option value="${map.id}"><c:out value="${map.hospitalLevelName	}"></c:out></option>
												</c:forEach>
											</select>
		</li> --%>
		<li><p>医院</p>
		<select id="hospId" name="hospId" class="step3">
													<option value="0">---请选择---</option>
												</select>	
		</li>
		<li><p>科室类别</p>
			<select id="departmenttypeId" name="departmenttypeId" class="step7" >
												<option value="0">---请选择---</option>
										</select>	
		</li>
		<li><p>科室</p>
			<select id="departmentId" name="departmentId" class="step4" >
												<option value="0">---请选择---</option>
										</select>	
		</li>
		<li><p>医生</p>
			<select id="doctorId" name="doctorId" class="step5" >
												<option value="0">---请选择---</option>
										</select>	
		</li>
		<li style="margin-right:0;">
			<input type="hidden" id="selectdoctorid" name="selectdoctorid"> 
		
		<input type="submit" id="gh_submit" value="快速挂号">
		
		</li>
	</ul>
</div>
</body>

<script type="text/javascript">



$('#ghselect').cascadingDropdown({
    selectBoxes: [
        {
            selector: '.step1'
        },
        {
            selector: '.step2'
        },
        {
            selector: '.step3',
            requires: ['.step1'],
            requireAll: true,
            source: function(request, response) {
                if(request.levelId=="0" || request.cityId=="0" || request.departmentId=="0"){
                	response();
                }else{
                   request.gh=1;
                	$.getJSON('${ctx}/medical/hospitalbycityAndlevel', request, function(data) {
	                    response($.map(data, function(item, index) {
	                        return {
	                            label: item.name,
	                            value: item.hospitalId,
	                            //selected: index == 0 // set to true to mark it as the selected item
	                        };
	                    }));
                	});	
                }
                
            }
        }, 
         {
            selector: '.step7',
            requires: ['.step3'],
            source: function(request, response) {
                if(request.hospId=="0"){
                	response();
                }else{
                	request.gh=1;
                	$.getJSON('${ctx}/medical/hospitalBydepartmentType', request, function(data) {
	                    response($.map(data, function(item, index) {
	                        return {
	                            label: item.name,
	                            value: item.departmentId,
	                            //selected: index == 0 // set to true to mark it as the selected item
	                        };
	                    }));
                	});	
                }
                
            }
        },
        {
            selector: '.step4',
            requires: ['.step7'],
            source: function(request, response) {
                if(request.departmenttypeId=="0" ){
                	response();
                }else{
                	request.gh=1;
                	$.getJSON('${ctx}/medical/hospitalBydepartments', request, function(data) {
	                    response($.map(data, function(item, index) {
	                        return {
	                            label: item.name,
	                            value: item.departmentId,
	                            //selected: index == 0 // set to true to mark it as the selected item
	                        };
	                    }));
                	});	
                }
                
            }
        },
        {
            selector: '.step5',
            requires: ['.step4'],
            source: function(request, response) {
                if(request.departmentId=="0"){
                	response();
                }else{
                	request.gh=1;
                	$.getJSON('${ctx}/medical/departmentBydoctor', request, function(data) {
	                    response($.map(data, function(item, index) {
	                        return {
	                            label: item.name,
	                            value: item.doctorId,
	                            //selected: index == 0 // set to true to mark it as the selected item
	                        };
	                    }));
                	});	
                }
                
            }
        }
    ],
    onChange: function(event, value, requiredValues, requirementsMet){
    	
        // do stuff
        // dropdownData is an object with values from all the dropdowns in this group
    },
    onReady: function(event, dropdownData) {
    	//alert("onReady");
        // do stuff
    }
});


 $("#gh_submit").click(function(){  
 	  var doctorId = $("#doctorId").val();
 	  if(doctorId=="0"){
 	  layer.alert("您还未选择医生，请选择医生！"); 
 	  	  }
 	  else{
 	  	//window.location.href="${ctx}/doctor/"+doctorId+".html"; 
 	  	
 	  	var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
 	  	
  		//  parent.layer.msg("${ctx}/doctor/"+doctorId+".html");
     	//    parent.$('#parentIframe').text("${ctx}/doctor/"+doctorId+".html");
   		//	 parent.layer.tips('Look here', '#parentIframe', {time: 5000});
   		//  parent.window.location.href = "${ctx}/doctor/"+doctorId+".html"
   		  window.open("${ctx}/doctor/"+doctorId+".html");
   	    	// parent.layer.close(index);
   	    	
 	  }
 	  
 });


/****
$(function(){
		
	 jQuery('#city').html(""); //把ci内容设为空  
     var ciValue = jQuery('#city');  	
	 var opts = ${city};
	 if (opts && opts.length > 0) {  
           var html = [];  
           for (var i = 0; i < opts.length; i++) {  
               html.push('<option value="'+opts[i]+'">'+opts[i]+'</option>');  
           }  
           ciValue.append(html.join(''));  
      	} 
      	
      	
      	
      	
     jQuery('#hos').html(""); //把ci内容设为空  
     var lValue = jQuery('#level');  	
      var types = ${types};
   		  lValue.append('<option value="">请选择</option>');
	 if (types && opts.length > 0) {  
           var html = [];  
           for (var i = 0; i < types.length; i++) {  
               html.push('<option value="'+types[i]+'">'+types[i]+'</option>');  
           }  
           lValue.append(html.join(''));  
      	}  	 


}); 



            
   function hosptalLac(v) {  
    jQuery('#hos').html(""); //把ci内容设为空  
    var hosValue = jQuery('#hos');  
    hosValue.append('<option value="">请选择</option>');  
    //异步请求查询ci列表的方法并返回json数组  
    jQuery.ajax({  
        url : '${ctx}/Reservation/hospitalInfo',  
        type : 'post',  
        data : { city : $("#city").val(),level:$("#level").val()},  
        dataType : 'json',  
        success : function (opts) {  
            if (opts && opts.length > 0) {  
                    var html = [];  
                    for (var i = 0; i < opts.length; i++) {  
                        html.push('<option value="'+opts[i]+'">'+opts[i]+'</option>');  
                    }  
                    hosValue.append(html.join(''));  
                }  
            }  
        });  

}  


function depme(v) {  
    jQuery('#hos').html(""); //把ci内容设为空  
    var hosValue = jQuery('#hos');  
    ciValue.append('<option value="">所有</option>');  
    //异步请求查询ci列表的方法并返回json数组  
    jQuery.ajax({  
        url : '${ctx}/Reservation/hospitalInfo',  
        type : 'post',  
        data : { city : $("#city").val(),level:$("#level").val()},  
        dataType : 'json',  
        success : function (opts) {  
            if (opts && opts.length > 0) {  
                    var html = [];  
                    for (var i = 0; i < opts.length; i++) {  
                        html.push('<option value="'+opts[i]+'">'+opts[i]+'</option>');  
                    }  
                    hosValue.append(html.join(''));  
                }  
            }  
        });  

}  



**/



</script>


</html>

