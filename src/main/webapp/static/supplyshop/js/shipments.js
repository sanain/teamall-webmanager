$(function(){
    var par=$('.house-list-body');
   	for(j=0;j<par.length;j++){
   		var goodsNums=0;
   		var goodsNum=$(par[j]).find('.goodsNum');
   		for(i=0;i<goodsNum.length;i++){
   	   		goodsNums+=parseInt($(goodsNum[i]).html().replace('x',''));
   	   	}
   		var standardName=$(par[j]).find('#standardName');
   		var vasd=$(par[j]).find('.standardName');
   		for(i=0;i<standardName.length;i++){
   			var b=[];
   		    if($(standardName[i]).val().indexOf(';')==-1){
   		    	var re1=$(standardName[i]).val().split(':');
   		    	b=re1[1];
   		    }else{
   		    	var result=$(standardName[i]).val().split(";");
   		        for(n=0;n<result.length;n++){
   		        	var re1=result[n].split(':');
   		        	b.push(re1[1]);
   		       	}
   		       	b=b.join(',');
   		   	}
   		    $(vasd[i]).html(b);
   	   	}
   		$(par[j]).find('.goodsNums').text('总共'+goodsNums+'件商品');
   	}
    //选择开始结束日期
    layui.use('laydate', function() {
        var laydate = layui.laydate;
        var start = {
            min: '1900-01-01 00:00:00'
            , max: '2099-06-16 23:59:59'
            , istoday: false
            , choose: function (datas) {
            	var time = new Date(datas.replace("-","/"));
            	var s=time.getFullYear()+"-"+(time.getMonth()+1)+"-"+(time.getDate()+1);
                end.min = s; //开始日选好后，重置结束日的最小日期
                end.start = s //将结束日的初始值设定为开始日
            }
        };
        var end = {
        	min: '1900-01-01 00:00:00'
            , max: '2099-06-16 23:59:59'
            , istoday: false
            , choose: function (datas) {
            	var time = new Date(datas.replace("-","/"));
            	var s=time.getFullYear()+"-"+(time.getMonth()+1)+"-"+(time.getDate()-1);
                start.max = s; //结束日选好后，重置开始日的最大日期
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
    var listright=$('.list-left');
    for (i=0;i<listright.length;i++){
        $(listright[i]).siblings('.list-right').height($(listright[i]).height());
        $(listright[i]).siblings('.list-right').css('padding',($(listright[i]).height()-60)/2+'px  4%');
    }
    $('.excel').click(function(){
    	var ctxweb=$("#ctxweb").val();
	     $.ajax({
			    type : "POST",
			    data:{},
			    url : ctxweb+"/shop/PmShopOrders/exsel",   
			    success : function (data) {
			    	window.location.href=data;
			    }
	         });
    });
});