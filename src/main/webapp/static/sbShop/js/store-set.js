$(function(){
    $('#picker').colpick({
        layout:'hex',
        submit:0,
        colorScheme:'dark',
        onChange:function(hsb,hex,rgb,el,bySetColor) {
            $(el).css('border-color','#'+hex);
            if(!bySetColor) $(el).val(hex);
        }
    }).keyup(function(){
        $(this).colpickSetColor(this.value);
    });
    $('body').on('click','.store-bc',function(){
        var shopName=$("#shopName").val();
        var checkedisLineShop=$("input[name='isLineShop']:checkbox").is(':checked');
        $("#shopName").css("border", "1px solid #a9a9a9");
        $("#returnRatio").css("border", "1px solid #a9a9a9");
        if(shopName==""){
        	$("#shopName").css("border", "1px solid red");
    		alert("请填写门店名称！");
    		return false;
        }else if(checkedisLineShop==true){
        	var returnRatio=$("#returnRatio").val();
        	if(returnRatio=""){
        		$("#returnRatio").css("border", "1px solid red");
        		alert("请填写默认让利比！");
        		return false;
        	}
    	}
        var frm =document.forms[0];
        frm.submit();
    });
})