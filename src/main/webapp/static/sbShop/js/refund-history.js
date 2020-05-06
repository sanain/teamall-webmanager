$(function(){
    $('.sub').click(function(){
    	var recordContent=$("#recordContent").val();
    	if(recordContent==""){
    		$("#recordContent").css("border", "1px solid red")
    		alert("请填写留言内容!");
			return false;
		}
        var frm =document.forms[0];
        frm.submit();
    });
})