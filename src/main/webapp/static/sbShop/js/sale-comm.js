$(function(){
   $('.house-nav li').click(function(){
       $(this).addClass('active').siblings().removeClass('active');
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

    //选择开始结束日期
    layui.use('laydate', function() {
        var laydate = layui.laydate;

        var start = {
            min: '1900-01-01 00:00:00'
            , max: '2099-06-16 23:59:59'
            , istoday: false
            , choose: function (datas) {
                end.min = datas; //开始日选好后，重置结束日的最小日期
                end.start = datas //将结束日的初始值设定为开始日
            }
        };

        var end = {
            min: laydate.now()
            , max: '2099-06-16 23:59:59'
            , istoday: false
            , choose: function (datas) {
                start.max = datas; //结束日选好后，重置开始日的最大日期
            }
        };

        document.getElementById('LAY_demorange_s').onclick = function () {
            start.elem = this;
            laydate(start);
        }
        document.getElementById('LAY_demorange_e').onclick = function () {
            end.elem = this
            laydate(end);
        }
    })

    var listright=$('.house-list-body');
    for (i=0;i<listright.length;i++){
        $(listright[i]).children('.list-right').children('li').height($(listright[i]).height()-30);
//        $(listright[i]).children('.list-right').children('li').css('line-height',$(listright[i]).height()-30+'px')
    }
   
    $('body').on('click','.shut-show',function(){
    	$('.divid').val($(this).closest('.house-list-body').find('#id').val());
    
    	$('.shut-sel select option:nth-child(1)').attr('selected','selected');
       $('.shut').show()
    });
    $('body').on('click','.shut-del',function(){
        $('.shut').hide()
    });
});