$(function(){
   //全选
    $('.allinput').click(function(){
        if ($(this).is(':checked')){
            $('.box-right-list input[type=checkbox]').attr('checked','checked');
        }else {
            $('.box-right-list input[type=checkbox]').removeAttr('checked');
        }
    });
    $('body').on('click','.box-right-list input[type=checkbox]',function(){
       if ($('.box-right-list input[type=checkbox]').length==$('.box-right-list input[type=checkbox]:checked').length){
           $('.allinput').attr('checked','checked');
       }else {
           $('.allinput').removeAttr('checked');
       }
    });


    $('.box-left ul a').click(function(){
        $(this).addClass('hove').parent().siblings().children().removeClass('hove');
    });

    $('.move-del').click(function(){
        $('.move').hide();
    });
});
