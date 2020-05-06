<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ include file="/WEB-INF/views/include/head.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>积分级别天数配置</title>
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/platform-configuration.css">
     <style>
        .fix-in{position: fixed;top: 0;right: 0;left: 0;bottom: 0;background: rgba(0,0,0,0.3);display:none;}
        .fix-box{position: absolute;width: 400px;height: 200px;background: #ffffff;top: 50%;left: 50%;margin-top: -100px;margin-left: -200px}
        .fix-box>p{height: 35px;line-height: 35px;text-align: center;color: #333333;margin-bottom: 0;background: #f0f0f0;position: relative}
        .fix-box>p img{position: absolute;top: 12px;right: 15px;;cursor: pointer}
        .fix-box ul{list-style: none;padding: 0;color: #666666;margin-bottom: 0;margin-top: 15px}
        .fix-box ul li{line-height: 30px;margin-bottom: 5px}
        .fix-box ul span{width: 150px;text-align: right;display: inline-block}
        .fix-txt{text-align: center;margin-top:30px;}
        .fix-box ul b{font-weight: normal}
        .fix-box ul input{height: 30px;border: 1px solid #dcdcdc;border-radius: 3px;}
        .fix-btn{text-align: center;margin-top: 30px}
        .fix-btn a{display: inline-block;height: 30px;line-height: 30px;padding: 0 15px;background: #69AC72;color: #ffffff;border-radius: 5px;text-decoration: none}
        .fix-btn a:nth-child(1){margin-right: 10px}
        .fix-btn a:nth-child(2){background: #ffffff;border: 1px solid #dcdcdc;color: #666666;margin-left: 10px}
    </style>
    <script>
    $(document).ready(function() {
    		//$('input').blur(function(){
    		//	cin=$(this);
    		//	cval=$(this).val();
    		//	$('.fix-in').show();
    		//	cid=$(this).attr('id');
    		//});
    		$('.fix-del').click(function(){
    			$('.fix-in').hide();
    		});
    		
    		 jQuery.validator.addMethod("choose", function(value, element) {
    			 return choose(value, element);
    			 }, "必须大于前一级");
    		 
    		$("#inputForm").validate({
    			rules: {
    				level0Days:{
    					required:true,
    					digits:true,
    					choose:true
    					},
    				level1Days:{
    					required:true,
    					digits:true,
    					choose:true
    					},
    				level2Days:{
    					required:true,
    					digits:true,
    					choose:true
    					},
    				level3Days:{
    					required:true,
    					digits:true,
    					choose:true
    					},
    				level4Days:{
    					required:true,
    					digits:true,
    					choose:true
    					},
    				level5Days:{
    					required:true,
    					digits:true,
    					choose:true
    					},
    				level6Days:{
    					required:true,
    					digits:true,
    					choose:true
    					},
    				level7Days:{
    					required:true,
    					digits:true,
    					choose:true
    					},
    				level8Days:{
    					required:true,
    					digits:true,
    					choose:true
    					},
    				level9Days:{
    					required:true,
    					digits:true,
    					choose:true
    					},
    				level10Days:{
    					required:true,
    					digits:true,
    					choose:true
    					},
    				level11Days:{
    					required:true,
    					digits:true,
    					choose:true
    					},
    				level12Days:{
    					required:true,
    					digits:true,
    					choose:true
    					},
    				level13Days:{
    					required:true,
    					digits:true,
    					choose:true
    					},
    				level14Days:{
    					required:true,
    					digits:true,
    					choose:true
    					},
    				level15Days:{
    					required:true,
    					digits:true,
    					choose:true
    					},
    				level16Days:{
    					required:true,
    					digits:true,
    					choose:true
    					},
    				level17Days:{
    					required:true,
    					digits:true,
    					choose:true
    					},
    				level18Days:{
    					required:true,
    					digits:true,
    					choose:true
    					},
    				level19Days:{
    					required:true,
    					digits:true,
    					choose:true
    					}
    			},
				submitHandler: function(form){
					//loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});
    	});
    	
		function choose(val,lel){
			if(lel.name!="level0Days"){
				var num=parseInt(lel.attributes.num.nodeValue);
				var before=parseInt($("#level"+(num-1)+"Days").val());
				var after=parseInt($("#level"+num+"Days").val());
				if(before!=""&&after!=""&&(after-before)<=0){
					return false;
				}
				
			}
			return true;
		}
		function btn(){
			$("#inputForm").submit();
		}
    </script>
</head>
<body>
<form:form id="inputForm" modelAttribute="pmLoveLevelDaysConfig" action="${ctxsys}/pmLoveLevelDaysConfig/save" method="post" class="form-horizontal">
   <form:hidden path="id"/>
    <div class="platform">
        <p>级别天数配置</p>
        <div class="platform-list">
            <ul style="width: 32%;">
                <li>零级天数：</li>
                <li>
                    <input id="level0Days" num="0" type="text" name="level0Days"value="${pmLoveLevelDaysConfig.level0Days}">
                </li>
            </ul>
            
            <ul style="width: 32%;">
                <li>一级天数 ：</li>
                <li>
                    <input id="level1Days" num="1" type="text" name="level1Days"value="${pmLoveLevelDaysConfig.level1Days}">
                </li>
            </ul>
           <ul style="width: 32%;">
                <li>二级天数：</li>
                <li>
                    <input id="level2Days" num="2" type="text" name="level2Days"value="${pmLoveLevelDaysConfig.level2Days}">
                </li>
            </ul>
            <ul style="width: 32%;">
                <li>三级天数 ：</li>
                <li>
                    <input id="level3Days" num="3" type="text" name="level3Days"value="${pmLoveLevelDaysConfig.level3Days}">
                </li>
            </ul>
            <ul style="width: 32%;">
                <li>四级天数 ：</li>
                <li>
                    <input id="level4Days" num="4" type="text" name="level4Days"value="${pmLoveLevelDaysConfig.level4Days}">
                </li>
            </ul>
            <ul style="width: 32%;">
                <li>五级天数  ：</li>
                <li>
                    <input id="level5Days" num="5" type="text" name="level5Days"value="${pmLoveLevelDaysConfig.level5Days}">
                </li>
            </ul>
            <ul style="width: 32%;">
                <li>六级天数 ：</li>
                <li>
                    <input id="level6Days" num="6" type="text" name="level6Days"value="${pmLoveLevelDaysConfig.level6Days}">
                </li>
            </ul>
            <ul style="width: 32%;">
                <li>七级天数 ：</li>
                <li>
                    <input id="level7Days" num="7" type="text" name="level7Days"value="${pmLoveLevelDaysConfig.level7Days}">
                </li>
            </ul>
            
            <ul style="width: 32%;">
                <li>八级天数 ：</li>
                <li>
                    <input id="level8Days" num="8" type="text" name="level8Days"value="${pmLoveLevelDaysConfig.level8Days}">
                </li>
            </ul>
            <ul style="width: 32%;">
                <li>九级天数 ：</li>
                <li>
                    <input id="level9Days" num="9" type="text" name="level9Days"value="${pmLoveLevelDaysConfig.level9Days}">
                </li>
            </ul>
            <ul style="width: 32%;">
                <li>十级天数 ：</li>
                <li>
                    <input id="level10Days" num="10" type="text" name="level10Days"value="${pmLoveLevelDaysConfig.level10Days}">
                </li>
            </ul>
            <ul style="width: 32%;">
                <li>十一级天数 ：</li>
                <li>
                    <input id="level11Days" num="11" type="text" name="level11Days"value="${pmLoveLevelDaysConfig.level11Days}">
                </li>
            </ul>
            <ul style="width: 32%;">
                <li>十二级天数 ：</li>
                <li>
                    <input id="level12Days" num="12" type="text" name="level12Days"value="${pmLoveLevelDaysConfig.level12Days}">
                </li>
            </ul>
            <ul style="width: 32%;">
                <li>十三级天数 ：</li>
                <li>
                    <input id="level143Days" num="13" type="text" name="level13Days"value="${pmLoveLevelDaysConfig.level13Days}">
                </li>
            </ul>
            <ul style="width: 32%;">
                <li>十四级天数 ：</li>
                <li>
                    <input id="level14Days" num="14" type="text" name="level14Days"value="${pmLoveLevelDaysConfig.level14Days}">
                </li>
            </ul>
            <ul style="width: 32%;">
                <li>十五级天数 ：</li>
                <li>
                    <input id="level15Days" num="15" type="text" name="level15Days"value="${pmLoveLevelDaysConfig.level15Days}">
                </li>
            </ul>
            <ul style="width: 32%;">
                <li>十六级天数 ：</li>
                <li>
                    <input id="level16Days" num="16" type="text" name="level16Days"value="${pmLoveLevelDaysConfig.level16Days}">
                </li>
            </ul>
            <ul style="width: 32%;">
                <li>十七级天数 ：</li>
                <li>
                    <input id="level17Days" num="17" type="text" name="level17Days"value="${pmLoveLevelDaysConfig.level17Days}">
                </li>
            </ul>
            <ul style="width: 32%;">
                <li>十八级天数 ：</li>
                <li>
                    <input id="level18Days" num="18" type="text" name="level18Days"value="${pmLoveLevelDaysConfig.level18Days}">
                </li>
            </ul>
            <ul style="width: 32%;">
                <li>十九级天数 ：</li>
                <li>
                    <input id="level19Days" num="19" type="text" name="level19Days"value="${pmLoveLevelDaysConfig.level19Days}">
                </li>
            </ul>
            
            
            
            
        </div>
        
        
        
         <a class="pla-btn" href="javascript:;" onclick="btn();" style="position: relative;left: 22%;background: rgb(105, 172, 114);">保存</a>
    </div>
</form:form>
      <div class="fix-in">
        <div class="fix-box">
            <p>提示</p>
            <div>
             	<div class="fix-txt">
             		是否确认修改？
             	</div>
                <div class="fix-btn">
                    <a class="fix-add" href="javascript:;">确定</a>
                    <a class="fix-del" href="javascript:;">取消</a>
                </div>
            </div>
        </div>
</div>
</body>
</html>