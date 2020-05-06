$(function(){
    var standardNames=$("#standardName").val();
    var b=[];
    if(standardNames.indexOf(';')==-1){
    	var re1=standardNames.split(':');
    	b=re1[1];
    }else{
    	var result=standardNames.split(";");
        for(i=0;i<result.length;i++){
        	var re1=result[i].split(':');
        	b.push(re1[1]);
       	}
       	b=b.join(',');
   	}
   	$('.standardName').html(b)
   	
    var lili=$('.crumbs-ul li');
    for (i=1;i<lili.length;i++){
        $(lili[i]).css('left',(128*i)+'px');
    }
    $('.consent-a').click(function(){
        $('.consent').show();
    });
    $('.consent-del').click(function(){
        $('.consent').hide();
    });
    var updateTime=$("#updateTime").val();
    var date=parseInt((updateTime/1000/86400)%365);
    var hour=parseInt((updateTime/1000/3600)%24);
    var minute=parseInt((updateTime/1000/60)%60);
    $('.DD').html(date);
    $('.HH').html(hour);
    $('.mm').html(minute);
});