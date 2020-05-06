$(function(){
	var cooperTypesid=$("#cooperTypesid").val();
	var cooperTypesid1=[];
	if(cooperTypesid!=""||cooperTypesid!=undefined){
		cooperTypesid1=cooperTypesid.split(','); 
		for(i=0;i<cooperTypesid1.length;i++){
			for(a=0;a<$('.lei-bie ul li input').length;a++){
				if(cooperTypesid1[i]==$($('.lei-bie ul li input')[a]).val()){
					$($('.lei-bie ul li input')[a]).attr('checked','checked')
				}
			}
		}
	}
	
	var message="";
	message=$('.message').attr('data-tid');
	if(message!=""){
		$('.tii').show();
		setTimeout(function(){$('.tii').hide()},800)
	}
	
    $('body').on('click','.save',function(){
       var chec=$('.lei-bie ul li input:checked');
       var arrc='';
       for (i=0;i<chec.length;i++){
    	arrc+=$(chec[i]).val()+',';
       }
       arrc=arrc.substring(0,arrc.length-1);;
       $("#cooperTypesid").val(arrc);
       
       var shopName=$("#shopName").val();
       var returnRatio=$("#returnRatio").val();
       $(this).parents('form').find('input[type=text],textarea[type=text]').css("border", "1px solid #a9a9a9");
       $('.lei-bie ul').css("border", "none");
       if(shopName==""){
       	$("#shopName").css("border", "1px solid red");
   		alert("请填写门店名称！");
   		return false;
       }else if(returnRatio==""){
    	   $("#returnRatio").css("border", "1px solid red");
    	   alert("请填写默认让利比！");
   	   }else if(arrc==""){
   		$('.lei-bie ul').css("border", "1px solid red");
    	   alert("请经营类别！");
   	   }else{
    	   var frm =document.forms[0];
    	   frm.submit();
       }
    });
})