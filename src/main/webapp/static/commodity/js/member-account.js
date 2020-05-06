$(function(){
    var sbnum=0;
    var banknum=0;
    var balancenum=0;
    $('.bank-show').click(function(){
        if (banknum==0){
            $('.nav-ul li a').removeClass('active');
            $('.nav-ul').append('<li><a class="active bank-aa" href="javascript:;">银行卡详情</a><img class="bank-img" src="images/xxx-rzt.png" alt=""></li>');
            $('.bank').show();
            $('.context-box').hide();
            $('.balance').hide();
            $('.sb').hide();
            banknum=1;
        }
    });
    $('body').on('click','.bank-img',function(){
        $('.nav-ul li:nth-child(2) a').addClass('active');
        $(this).closest('li').remove();
        $('.bank').hide();
        $('.context-box').show();
        $('.balance').hide();
        $('.sb').hide();
        banknum=0;
    });
    $('body').on('click','.bank-aa',function(){
        $('.nav-ul li a').removeClass('active');
        $(this).addClass('active');
        $('.bank').show();
        $('.context-box').hide();
        $('.balance').hide();
        $('.sb').hide();
    });
    $('.balance-show').click(function(){
        if (balancenum==0){
            $('.nav-ul li a').removeClass('active');
            $('.nav-ul').append('<li><a class="active balance-aa" href="javascript:;">余额明细</a><img class="balance-img" src="images/xxx-rzt.png" alt=""></li>');
            $('.bank').hide();
            $('.context-box').hide();
            $('.balance').show();
            $('.sb').hide();
            balancenum=1;
        }
    });
    $('body').on('click','.balance-img',function(){
        $('.nav-ul li:nth-child(2) a').addClass('active');
        $(this).closest('li').remove();
        $('.bank').hide();
        $('.context-box').show();
        $('.balance').hide();
        $('.sb').hide();
        balancenum=0;
    });
    $('body').on('click','.balance-aa',function(){
        $('.nav-ul li a').removeClass('active');
        $(this).addClass('active');
        $('.bank').hide();
        $('.context-box').hide();
        $('.balance').show();
        $('.sb').hide();
    });
    $('.sb-show').click(function(){
        if (sbnum==0){
            $('.nav-ul li a').removeClass('active');
            $('.nav-ul').append('<li><a class="active sb-aa" href="javascript:;">御可贡茶明细</a><img class="sb-img" src="images/xxx-rzt.png" alt=""></li>');
            $('.bank').hide();
            $('.context-box').hide();
            $('.balance').hide();
            $('.sb').show();
            sbnum=1;
        }
    });
    $('body').on('click','.sb-img',function(){
        $('.nav-ul li:nth-child(2) a').addClass('active');
        $(this).closest('li').remove();
        $('.bank').hide();
        $('.context-box').show();
        $('.balance').hide();
        $('.sb').hide();
        sbnum=0;
    });
    $('body').on('click','.sb-aa',function(){
        $('.nav-ul li a').removeClass('active');
        $(this).addClass('active');
        $('.bank').hide();
        $('.context-box').hide();
        $('.balance').hide();
        $('.sb').show();
    });
    $('.nav-ul li:nth-child(2) a').click(function(){
        $('.nav-ul li a').removeClass('active');
        $(this).addClass('active');
        $('.bank').hide();
        $('.context-box').show();
        $('.balance').hide();
        $('.sb').hide();
    });

});
