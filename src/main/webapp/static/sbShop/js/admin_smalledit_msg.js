$(function(){
	var message="";
	message=$('.message').attr('data-tid');
	if(message!=""){
		$('.tii').show();
		setTimeout(function(){$('.tii').hide()},800)
	}
	
    $('body').on('click','.save',function(){
       
       var contactName=$("#contactName").val();
       var mobilePhone=$("#mobilePhone").val();
       $(this).parents('form').find('input[type=text],textarea[type=text]').css("border", "1px solid #a9a9a9");
       $('.lei-bie ul').css("border", "none");
       if(contactName==""){
       	$("#contactName").css("border", "1px solid red");
   		alert("请填写申请人名称！");
   		return false;
       }else if(mobilePhone==""){
    	   $("#mobilePhone").css("border", "1px solid red");
    	   alert("请填写联系电话！");
   	   }else{
    	   var frm =document.forms[0];
    	   frm.submit();
       }
    });
})