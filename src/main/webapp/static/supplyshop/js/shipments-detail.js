$(function(){
	var par=$('.mag-list');
   	for(j=0;j<par.length;j++){
   		var standardName=$(par[j]).find('#standardName');
   		var vasd=$(par[j]).find('.standardName');
   		for(i=0;i<standardName.length;i++){
   			var b=[];
   		    if($(standardName[i]).val().indexOf(';')==-1){
   		    	var re1=$(standardName[i]).val().split(':');
   		    	b=re1[1];
   		    }else{
   		    	var result=$(standardName[i]).val().split(";");
   		        for(n=0;n<result.length;n++){
   		        	var re1=result[n].split(':');
   		        	b.push(re1[1]);
   		       	}
   		       	b=b.join(',');
   		   	}
   		   	$(vasd[i]).html(b);
   	   	}
   	}
   	
});

function btn(){
	if($("#logistics").val()==""||$("#comCode").val()==""){
		/*$("#expressNumber").css("border", "1px solid red")*/
		alert("请填物流公司!");
		return false;
	}
	var expressNumber=$("#expressNumber").val();
if(expressNumber==""){
	/*$("#expressNumber").css("border", "1px solid red")*/
	alert("请填写运单编号!");
	return false;
}
var frm =document.forms[0];
frm.submit();
}