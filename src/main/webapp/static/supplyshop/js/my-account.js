$(function(){
   $('.tab').click(function(){
       $('.my-account').hide();
       $('.my-bill').show();
   });
    $('.n-tab').click(function(){
        $('.my-account').show();
        $('.my-bill').hide();
    })
});