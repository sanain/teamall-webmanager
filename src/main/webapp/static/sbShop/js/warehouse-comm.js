$(function(){
   $('.house-nav li').click(function(){
       $(this).addClass('active').siblings().removeClass('active');
   });
    $('.sell-out').click(function(){
        $('.sold-out').hide();
    });
    $('.putaway').click(function(){
        $('.sold-out').show();
    });

    $('body').on('click','.fenlei-ul b',function(){
       $(this).parent().toggleClass('active-b');
    });
    $('body').on('click','.readonly',function(){
       $(this).siblings().toggleClass('active');
    });

    $('body').on('click','.fenlei-ul span',function(){
       $('.readonly').val($(this).text());
        $('.fenlei').removeClass('active');
    });

   /* //分页
    $('.fenye').pagination({
        pageCount:10,
        count: 0,				//当前页前后分页个数
        jump:true,
        coping:true,
        keepShowPN: true,
        prevContent:'上一页',
        nextContent:'下一页'
    });
*/
    //全选
    $('body').on('click','.quanxuan',function(){
       if ($(this).is(':checked')){
           $('.house-list-body input[type=checkbox]').attr('checked','checked');
           $('.quanxuan').attr('checked','checked');
       }else {
           $('.house-list-body input[type=checkbox]').removeAttr('checked');
           $('.quanxuan').removeAttr('checked');
       }
    });
    //选择商品
    $('body').on('click','.house-list-body input[type=checkbox]',function(){
        if ($('.house-list-body input[type=checkbox]').length==$('.house-list-body input[type=checkbox]:checked').length){
            $('.quanxuan').attr('checked','checked');
        }else {
            $('.quanxuan').removeAttr('checked');
        }
    });
    //删除商品
    $('body').on('click','.del-ul',function(){
       var ula=$('.house-list-body input[type=checkbox]:checked');
        for (i=0;i<ula.length;i++){
            $(ula[i]).closest('ul').remove()
        }
    });
    //编辑商品名称
    $('body').on('click','.bianji',function(){
       var text=$(this).siblings('u').text();
        $(this).siblings('u').hide();
        $(this).siblings('.area').show();
        $(this).siblings('.area').children('textarea').val(text)
    });
    $('body').on('click','.area-a',function(){
        var text=$(this).siblings('textarea').val();
        $(this).parent().hide();
        $(this).parent().siblings('u').show().text(text);
    });
    //重置
    $('.chong').click(function(){
        $('.house-div input[type=text]').val('');
        $(".house-div select").find("option[value='0']").attr("selected",true);
    });
    $('.num').cbNum()
});