$(function(){
    function toDecimal2(x) {
        var f = parseFloat(x);
        if (isNaN(f)) {
            return false;
        }
        var f = Math.round(x*100)/100;
        var s = f.toString();
        var rs = s.indexOf('.');
        if (rs < 0) {
            rs = s.length;
            s += '.';
        }
        while (s.length <= rs + 2) {
            s += '0';
        }
        return s;
    }
    $('.num').cbNum();
    //添加指定城市
    $('body').on('click','.city-a',function(){
        $('.add-city').show();
        $('.add-city').append(`<ul>
                                <li><input type="hidden" id="pmShopShippingMethodid" value=""><input type="hidden" id="districtid" value=""><a class="bianji" href="javascript:;">编辑</a></li>
                                <li><input type="text"></li>
                                <li><input type="text"></li>
                                <li><input type="text"></li>
                                <li><input type="text"></li>
                                <li><a class="city-del" href="javascript:;">删除</a></li>
                            </ul>`);
    });
    //删除指定城市
    $('body').on('click','.city-del',function(){
    	var ssid=$(this).attr('ssid');
    	var path=$(this).attr('path');
    	if(ssid!=""&&ssid!=undefined&&path!=""&&path!=undefined){
    		$.ajax({
		    	type:'post',
		      	contentType:"application/x-www-form-urlencoded;charset=UTF-8",
		    	url:path+"/shop/pmShopFreightTem/pmssmdelete",
		       	datatype:"json",
		       	data:{
		       		ssid:ssid
		       	},
		       	success:function(data){}
		 	  });
    	}
    	var vid=$(this).closest('ul').children('li:nth-child(1)').children('#districtid').val();
    	if(vid!=""&&vid!=undefined){
    		vid=vid.split(',');
	    	var lab1=$('.region-div label');
	    	for(i=0;i<vid.length;i++){
	    		for(j=0;j<lab1.length;j++){
	    			if($(lab1[j]).attr('districtid')==vid[i]){
	    				$(lab1[j]).prev().removeAttr('disabled','disabled').removeAttr('checked','checked')
	    			}
	    		}
	    	}
    	}
    	$(this).closest('ul').remove();
    })
    $('body').on('click','.region-div>ul>li>div>.checkbox>label',function(){
    	if($(this).closest('.checkbox').siblings('ul').length!=0){
    		if($(this).closest('.checkbox').hasClass('active')){
    			$(this).parent().removeClass('active').next().hide()
    		}else{
    			$(this).parent().addClass('active').next().show()
    		}
    	}
    });
    $('body').on('click','.two-list li:last-child a',function(){
        $(this).closest('.two-list').hide();
        $(this).closest('ul').prev().removeClass('active');
    });
    $('.region-box>p span').click(function(){
        $('.region').hide();
    });
    $('.region-btn-qx').click(function(){
        $('.region').hide();
    });
    //选择具体地区
    //一级
    $('body').on('click','.input-all',function(){
        if ($(this).is(':checked')){
            $(this).closest('ul').find('input[type=checkbox]').attr('checked','checked')
        }else {
            $(this).closest('ul').find('input[type=checkbox]').removeAttr('checked')
        }
    });
    //二级
    $('body').on('click','.region-div div.checkbox input',function(){
        if ($(this).is(':checked')){
            $(this).closest('div').next().find('input').attr('checked','checked');
            if ($(this).closest('li').find('div.checkbox input').length==$(this).closest('li').find('div.checkbox input:checked').length){
                $(this).closest('.region-ul').find('.input-all').attr('checked','checked');
            }
        }else {
            $(this).parent().parent().find('input[type=checkbox]').removeAttr('checked');
            $(this).closest('.region-ul').find('.input-all').removeAttr('checked');
        }
    });
    //三级
    $('body').on('click','.two-list input',function(){
        if ($(this).is(':checked')){
            if ($(this).closest('ul').find('input').length==$(this).closest('ul').find('input:checked').length){
                $(this).closest('div').find('div.checkbox input').attr('checked','checked');
                if($(this).closest('.region-ul').children('li:last-child').find('input').length==$(this).closest('.region-ul').children('li:last-child').find('input:checked').length){
                    console.log($(this).closest('.region-ul>li:last-child input'))
                    $(this).closest('.region-ul').find('.input-all').attr('checked','checked');
                }
            }
        }else {
            $(this).closest('div').find('div.checkbox input').removeAttr('checked');
            $(this).closest('.region-ul').find('.input-all').removeAttr('checked');
        }
    });
    var thisa;
    var tid;
    var arrc;
    $('body').on('click','.bianji',function(){
        $('.region').show();
        thisa=$(this).parent();
        tid=$(this).prev().val();
        arrc=$(this).parent().text().substring(0,$(this).parent().text().length-2)
        var iid=$('#distrctCode').val().split(",")
        var lab=$('.region-div label');
        for(i=0;i<iid.length;i++){
        	for(j=0;j<lab.length;j++){
        		if($(lab[j]).attr('districtid')==iid[i]){
        			$(lab[j]).prev().attr('disabled','disabled').attr('checked','checked')
        		}
        	}
        }
//        $('.region input[type=checkbox]').removeAttr('checked')
    });
    //保存选择地区
    $('body').on('click','.region-btn-bc',function(){
       var chec=$('.region-div ul input:checked');
        var arrd=tid;
        var arrid=thisa.children('#pmShopShippingMethodid').val();
        for (i=0;i<chec.length;i++){
        	if(!$(chec[i]).is(':disabled')){
        		 arrc+=$(chec[i]).siblings('label').text()+',';
                 arrd+=$(chec[i]).siblings('label').attr('districtid')+',';
                 $(chec[i]).attr('disabled','disabled');
        	}
           
        }
        thisa.html(`<input type="hidden" id="pmShopShippingMethodid" value="${arrid}"><input type="hidden" id="districtid" value="${arrd}">`+arrc+`<a class="bianji" href="javascript:;">编辑</a>`);
        thisa.attr('title',arrc);
        $('.region').hide();
    });
    var hid='';
    for(h=1;h<$('.add-city ul').length;h++){
    	hid+=$($('.add-city ul')[h]).children('li:nth-child(1)').children('#distrctCode').val();
    }
    var iid=hid.split(",")
    var lab=$('.region-div label');
    for(i=0;i<iid.length;i++){
    	for(j=0;j<lab.length;j++){
    		if($(lab[j]).attr('districtid')==iid[i]){
    			$(lab[j]).prev().attr('disabled','disabled').attr('checked','checked')
    		}
    	}
    }
});