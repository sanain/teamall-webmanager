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




    //选择商品
    $('body').on('click','.house-list-body input[type=checkbox]',function(){
        if ($('.house-list-body input[type=checkbox]').length==$('.house-list-body input[type=checkbox]:checked').length){
            $('.quanxuan').attr('checked','checked');
        }else {
            $('.quanxuan').removeAttr('checked');
        }
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
});