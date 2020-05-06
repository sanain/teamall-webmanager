$(function(){
    $('.btn-pos').click(function(){
    	/*var email=$("#email").val();*/
    	var status=$("#status").val();
    	/*$("#email").css("border", "1px solid #a9a9a9");*/
    	/*if(email!=""){
    		if(!/^[A-Za-z\d]+([-_.][A-Za-z\d]+)*@([A-Za-z\d]+[-.])+[A-Za-z\d]{2,5}$/.test(email)){
    			$("#email").css("border", "1px solid red");
    			alert("邮箱格式错误");
    		}
    	}else*/ 
    	if(status==""){
			alert("请选择会员状态");
			return false;
		}else{
			var contactPhone=$("#contactPhone").val();
			var myreg = /^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1}))+\d{8})$/; 
		    if(!myreg.test(contactPhone)){
		    	alert("请输入正确的联系手机号");
		    	return false;
			}else{
				var frm =document.forms[0];
				frm.submit();
			}
			
		}
    });
});
