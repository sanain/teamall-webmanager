$(function(){
    //添加子分类
    $('body').on('click','.add-child',function(){
        var li=`<ul class="ul-list">
            <li><input type="text"></li>
            <li></li>
            <li><a class="sy-ul" href="javascript:;"><img src="supplyshop/images/zhankai2.png" alt=""></a></li>
            <li><a class="xy-ul" href="javascript:;"><img src="supplyshop/images/zhankai1.png" alt=""></a></li>
            <li><a class="ul-list-del" href="javascript:;"><img src="supplyshop/images/xxx-rzt.png" alt=""></a></li>
            </ul>`;
        $(this).closest('.new-div').append(li);
    })

    //添加新分类
    $('body').on('click','.add-fu',function(){
        var div=`
        <div class="new-div">
            <ul class="new-ul">
            	<li>
            		<a class="add-child btn btn-primary" href="javascript:;">添加子分类</a>
            	</li>
                <li class="ul-one">
                    <input type="text">
                </li>
                <li><a class="sy-div" href="javascript:;"><img src="supplyshop/images/zhankai2.png" alt=""></a></li>
                <li><a class="xy-div" href="javascript:;"><img src="supplyshop/images/zhankai1.png" alt=""></a></li>
                <li><a class="new-ul-del" href="javascript:;"><img src="supplyshop/images/xxx-rzt.png" alt=""></a></li>
            </ul>
            <ul class="ul-list">
            	<li></li>
                <li><input type="text"></li>
                <li><a class="sy-ul" href="javascript:;"><img src="supplyshop/images/zhankai2.png" alt=""></a></li>
                <li><a class="xy-ul" href="javascript:;"><img src="supplyshop/images/zhankai1.png" alt=""></a></li>
                <li><a class="ul-list-del" href="javascript:;"><img src="supplyshop/images/xxx-rzt.png" alt=""></a></li>
            </ul>
        </div>`;
        $('.add-box').append(div);
    })

    //删除总分类
    $('body').on('click','.new-ul-del',function(){
        $(this).closest('.new-div').remove()
    })
    //删除子分类
    $('body').on('click','.ul-list-del',function(){
        $(this).closest('.ul-list').remove();
    })
    //上移父选项；
    $(document).on('click','.sy-div',function(){
        var $li=$(this).closest('.new-div');
        console.log('111')
        if($li.index()>1){
            console.log('222')
            $li.fadeOut().fadeIn();
            $li.prev('.new-div').before($li);
        }
    });
    //下移父选项；
    $(document).on('click','.xy-div',function(){
        var $li=$(this).closest('.new-div');
        var len=$(this).closest('.new-div').siblings('.new-div').length;
        if($li.index()!==len+1){
            $li.fadeOut().fadeIn();
            $li.next('.new-div').after($li);
        }
    });
    //上移子选项；
    $(document).on('click','.sy-ul',function(){
        var $li=$(this).closest('.ul-list');
        if($li.index()>1){
            $li.fadeOut().fadeIn();
            $li.prev('.ul-list').before($li);
        }
    });
    //下移子选项；
    $(document).on('click','.xy-ul',function(){
        var $li=$(this).closest('.ul-list');
        var len=$(this).closest('.ul-list').siblings('.ul-list').length;
        if($li.index()!==len+1){
            $li.fadeOut().fadeIn();
            $li.next('.ul-list').after($li);
        }
    });
})
