$(function(){
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

      /*  document.getElementById('LAY_demorange_s').onclick = function () {
            start.elem = this;
            laydate(start);
        }
        document.getElementById('LAY_demorange_e').onclick = function () {
            end.elem = this
            laydate(end);
        }*/
    })

    $('.num').cbNum();
    //全选
    $('.all-input').click(function(){
        if ($(this).is(':checked')){
            $('.body-ul input[type=checkbox]').attr('checked','checked');
        }else {
            $('.body-ul input[type=checkbox]').removeAttr('checked');
        }
    });
    $('body').on('click','.body-ul input[type=checkbox]',function(){
       if ($('.body-ul input[type=checkbox]').length==$('.body-ul input[type=checkbox]:checked').length){
           $('.all-input').attr('checked','checked');
       }else {
           $('.all-input').removeAttr('checked');
       }
    });
    //批量删除
    $('.piliang-del').click(function(){
        var del=$('.body-ul input[type=checkbox]:checked');
        for (i=0;i<del.length;i++){
            $(del[i]).closest('ul').remove();
        }
    });

    $('body').on('click','.box-a',function(){
        $(this).siblings('.a-box').show();
    });
    $('body').on('click','.s',function(){
       $(this).closest('.a-box').hide()
    });
    $('.a-box>img').click(function(){
    	console.log('11')
    	$(this).parent().hide()
    });
    $('.first-fen').click(function(){
        console.log('331');
        $(this).siblings('.a-box').show();
    });

    $('.ku-a').click(function(){
        $('.ku-box').show()
    });
    $('body').on('click','.del-ku',function(){
        $('.ku-box').hide()
    });
});