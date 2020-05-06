$(function(){
    $('.sub').click(function(){
    	var legalPerson=$("#legalPerson").val();
    	var capital=$("#capital").val();
    	var businessStartTime=$(".businessStartTime").val();
    	var businessEndTime=$(".businessEndTime").val();
    	var licenseAppScope=$("#licenseAppScope").val();
    	var officialUrl=$("#officialUrl").val();
    	var customerPhone=$("#customerPhone").val();
    	var fax=$("#fax").val();
    	var contactName=$("#contactName").val();
    	var email=$("#email").val();
    	$(this).parents('form').find('input[type=text],input[type=number],textarea[type=text]').css("border", "1px solid #eee");
    	if(legalPerson==""){
			$("#legalPerson").css("border", "1px solid red").attr("placeholder","请在此填写法人代表！");
			alert("请填写法人代表！");
			return false;
		}else if(capital==""){
			$("#capital").css("border", "1px solid red").attr("placeholder","请在此填写注册资金！");
			alert("请填写注册资金！");
			return false;
		}else if(businessStartTime==""||businessEndTime==""){
			if(businessStartTime==""){
				$("#businessStartTime").css("border", "1px solid red").attr("placeholder","请在此选择营业执照有效期！");
			}
			if(businessEndTime==""){				
				$("#businessEndTime").css("border", "1px solid red").attr("placeholder","请在此选择营业执照有效期！");
			}
			alert("请填写营业执照有效期！");
			return false;
		}else if(licenseAppScope==""){
			$("#licenseAppScope").css("border", "1px solid red").attr("placeholder","请在此填写营业执照经营范围！");
			alert("请填写营业执照经营范围！");
			return false;
		}else if(contactName==""){
			$("#contactName").css("border", "1px solid red").attr("placeholder","请在此填写联系人！");
			alert("请填写联系人！");
			return false;
		}else if(email== ""||!/^[A-Za-z\d]+([-_.][A-Za-z\d]+)*@([A-Za-z\d]+[-.])+[A-Za-z\d]{2,5}$/.test(email)){
			$("#email").css("border", "1px solid red").attr("placeholder","请检查电子邮箱！");
			alert("请检查电子邮箱！");
			return false;
		}else if(customerPhone!=""&&!/^[1][345678][0-9]{9}$/.test(customerPhone)){
			$("#customerPhone").css("border", "1px solid red").attr("placeholder","请检查电话号码！");
			alert("请检查电话号码！");
			return false;
		}
        var frm =document.forms[0];
        frm.submit();
    });
    layui.use('laydate', function(){
        var laydate = layui.laydate;
        var start = {
            min: '1900-01-01 00:00:00'
            ,max: '2099-06-16 23:59:59'
            ,istoday: false
            ,choose: function(datas){
                end.min = datas;
                end.start = datas
            }
        };
        var end = {
            min: laydate.now()
            ,max: '2099-06-16 23:59:59'
            ,istoday: false
            ,choose: function(datas){
                start.max = datas; //结束日选好后，重置开始日的最大日期
            }
        };
        document.getElementById('LAY_demorange_s').onclick = function(){
            start.elem = this;
            laydate(start);
        }
        document.getElementById('LAY_demorange_e').onclick = function(){
            end.elem = this
            laydate(end);
        }
    });
})