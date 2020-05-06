$(function(){
    $('.sub').click(function(){
    	var shopProblemDesc=$("#shopProblemDesc").val();
    	if(shopProblemDesc==""){
    		$("#shopProblemDesc").css("border", "1px solid red")
    		alert("请填写申请内容!");
			return false;
		}
        var frm =document.forms[0];
        frm.submit();
    });
})