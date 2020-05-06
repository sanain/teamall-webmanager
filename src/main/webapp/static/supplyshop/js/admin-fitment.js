$(function(){
	var th;
	var ctxsys=$("#ctxsys").val();
    $('body').on('click','.con-a',function(){
    	var advertiseid=$(this).attr('advertiseid')
    	var shopid=$(this).attr('shopid')
        $('.consent').show()
        th=$(this).closest('ul');
    	$('.con-yes').attr('href',''+ctxsys+'/PmShopInfo/status?status=2&shopid='+shopid+'&advertiseid='+advertiseid+''); 
    });
    $('.con-yes').click(function(){
        th.remove();
        $('.consent').hide()
    });
    $('.consent-del').click(function(){
        $('.consent').hide()
    });
})