$(function(){
	var th;
	var ctxweb=$("#ctxweb").val();
    $('body').on('click','.con-a',function(){
    	var advertiseid=$(this).attr('advertiseid')
        $('.consent').show()
        th=$(this).closest('ul');
    	$('.con-yes').attr('href',''+ctxweb+'/shop/ShopAdvertise/status?status=2&advertiseid='+advertiseid+''); 
    });
    $('.con-yes').click(function(){
        th.remove();
        $('.consent').hide()
    });
    $('.consent-del').click(function(){
        $('.consent').hide()
    });
})