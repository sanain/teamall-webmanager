$(function(){
    $('.num').cbNum();
   $('.delete-del').click(function(){
      $('.delete').hide();
   });
    var del;
    $('body').on('click','.delete-a',function(){
        $('.delete').show();
        del=$(this)
    });
    $('.delete-yes').click(function(){
        del.closest('.list-body').remove();
        $('.delete').hide();
    });

    //设为默认
    $('body').on('click','.mo-a',function(){
       $('.site-list .active').removeClass('active').children('li:last-child').append(`<a class="mo-a" href="javascript:;">设为默认</a>`).children('span').remove();
        $(this).closest('ul').children('li:last-child').append(`<span>默认地址</span>`);
        $(this).closest('ul').addClass('active').children('li:last-child').children('a:nth-child(5)').remove();

    });
});