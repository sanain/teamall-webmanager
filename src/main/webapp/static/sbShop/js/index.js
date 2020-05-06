$(function(){
    $('.list-ul>li>a').click(function(){
    	if($(this).hasClass('active')){
    		$(this).removeClass('active');
    		$(this).siblings().slideUp();
    	}else{
    		$(this).addClass('active');
    		$(this).siblings().slideDown();
            $(this).parent().siblings().children('ul').slideUp();
            $(this).parent().siblings().children('a').removeClass('active');
    	}
    })
    $('iframe').height($(window).height()-5);
    
    /*$('.left-div').height($(window).height())*/
})