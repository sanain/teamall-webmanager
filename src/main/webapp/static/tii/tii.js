$(function(){
	var message="";
	message=$('.message').attr('data-tid');
	if(message!=""){
		$('.tii').show();
		setTimeout(function(){$('.tii').hide()},800)
	}
})