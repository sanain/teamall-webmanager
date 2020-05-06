function addboft(){
	
    $.ajax({
        type: "POST",
        url:  contextPath+"/supplyshop/supplyShopproduct/commercialeDetail",
        data: {id:$('#add-stan option:selected').val(),productId:$("#kk").val()},
        success:function(data){
          var attval="";
           for(var i=0;i<data.length;i++){
               attval+="<span>"+data[i].spertAttrValue+"<input type='hidden'  name='attrId' value='"+data[i].id+"'/><b></b></span>";
            }
            attval+="<a data-did='9' href='javascript:;'><img src="+contextPath+"/supplyshop/images/add-a.png' alt=''></a>"
            $('.standard-right ul:nth-child(2) li:last-child').append(attval);
            addtable();   
            }
        });
}
var at;

$(function(){
	$('body').click(function(e){
		if($(e.target).closest('.norm').length==0){
			$('.norm-box').hide();
		}
	})
	
	
	$('.rangli input[type=radio]').click(function(){
		if($(this).hasClass('imo')){
			var smo=parseFloat($('.smo').text());
			var ben=parseFloat($('.bend').val());
			if(!isNaN(smo)&&!isNaN(ben)){
				var jie=ben*(1-smo/100);
				jie=jie.toFixed(2)
				$('.jies').val(jie);
			}
		}
	});
	$('body').on('blur','.t-shi',function(){
		var tshi=parseFloat($(this).val());
		var tben=parseFloat($(this).closest('tr').find('.t-ben').val());
		var ttben=parseFloat($(this).closest('tr').find('.tt-ben').val());
		if($(this).closest('tr').find('.tt-ben').length==0){
			if(!isNaN(tben)&&tshi<tben){
				$(this).css('border','1px solid #ff0000');
				$('.yanzhen-box div span').text('市场价格必须大于本店价格！');
	            $('.yanzhen').show();
			}else{
				$(this).css('border','1px solid #eee');
			}
		}else{
			if(!isNaN(ttben)&&tshi<ttben){
				$(this).css('border','1px solid #ff0000');
				$('.yanzhen-box div span').text('市场价格必须大于本店价格！');
	            $('.yanzhen').show();
			}else{
				$(this).css('border','1px solid #eee');
			}
		}
		
	});
	$('body').on('blur','.tt-ben',function(){
		var ttben=parseFloat($(this).val());
		var tshi=parseFloat($(this).closest('tr').find('.t-shi').val());
			if(!isNaN(ttben)&&!isNaN(tshi)&&tshi<ttben){
				$(this).css('border','1px solid #ff0000');
				$('.yanzhen-box div span').text('市场价格必须大于本店价格！');
	            $('.yanzhen').show();
			}else{
				$(this).css('border','1px solid #eee');
			}
	});
	$('body').on('blur','.t-ben',function(){
		var tben=parseFloat($(this).val());
		var tshi=parseFloat($(this).closest('tr').find('.t-shi').val());
			if(!isNaN(tshi)&&tshi<tben){
				$(this).css('border','1px solid #ff0000');
				$('.yanzhen-box div span').text('市场价格必须大于本店价格！');
	            $('.yanzhen').show();
	          
			}else{
				$('.t-shi').css('border','1px solid #eee');
			}
		
		
	});
	$('body').on('blur','.bshi',function(){
		var bshi=parseFloat($(this).val());
		var bend=parseFloat($('.bend').val());
			if(!isNaN(bend)&&bshi<bend){
				$(this).css('border','1px solid #ff0000');
				$('.yanzhen-box div span').text('市场价格必须大于销售价！');
	            $('.yanzhen').show();
	          
			}else{
				$(this).css('border','1px solid #eee');
			}
	});
	$('body').on('blur','.bend',function(){
		var bend=parseFloat($(this).val());
		var bshi=parseFloat($('.bshi').val());
			if(!isNaN(bshi)&&bshi<bend){
				$(this).css('border','1px solid #ff0000');
				$('.yanzhen-box div span').text('市场价格必须大于销售价！');
	            $('.yanzhen').show();
	          
			}else{
				$('.bshi').css('border','1px solid #eee');
			}
	});
	
	
	$('body').on('input propertychange','.t-ben',function(){
		var ben=parseFloat($(this).val());
		var ran=parseFloat($(this).parent().next().children('input').val());
		if(!isNaN(ran)&&!isNaN(ben)){
			var jie=ben*(1-ran/100);
			jie=jie.toFixed(2)
			$(this).parent().next().next().children('input').val(jie);
		}
	});
	$('body').on('input propertychange','.t-ran',function(){
		var ran=parseFloat($(this).val());
		var ben=parseFloat($(this).parent().prev().children('input').val());
		var val1=parseInt($('.ran1').text());
		var val2=parseInt($('.ran2').text());
		if($(this).val().length>=$('.ran1').text().length){
			if(!isNaN(ben)&&!isNaN(ran)){
				if(ran>=val1&&ran<=val2){
					var jie=ben*(1-ran/100);
					jie=jie.toFixed(2)
					$(this).parent().next().children('input').val(jie);
					
				}else{
					$(this).val('');
				}
			}else if(ran>val2){
				$(this).val('');
			}
			
		}
		
	});
	$('body').on('blur','.t-ran',function(){
		var val1=parseInt($('.ran1').text());
		var val2=parseInt($('.ran2').text());
		if(parseFloat($(this).val())<val1||parseFloat($(this).val())>val2){
			$('.yanzhen-box div span').text('让利比不在范围内！');
            $('.yanzhen').show();
            $(this).val('');
		};
	});
	
	$('body').on('input propertychange','.tt-ben',function(){
		var ben=parseFloat($(this).val());
		var ran=parseFloat($(this).parent().next().children('input').val());
		if(!isNaN(ran)&&!isNaN(ben)){
			var jie=ben*(1-ran/100);
			jie=jie.toFixed(2)
			$('.t-jie').val(jie);
		}else if(isNaN(ran)){
			$('.tt-jie').val('')
			
				var tyr=$(this).closest('table').find('tbody').find('tr');
				for(h=0;h<tyr.length;h++){
					var jben=parseFloat($(tyr[h]).find('.t-ran').val());
					var jjie=ben*(1-jben/100);
					jjie=jjie.toFixed(2)
					$(tyr[h]).find('.t-jie').val(jjie);
				}
			
		}
	});
	$('body').on('input propertychange','.tt-ran',function(){
		var ran=parseFloat($(this).val());
		var ben=parseFloat($(this).parent().prev().children('input').val());
		var val1=parseInt($('.ran1').text());
		var val2=parseInt($('.ran2').text());
		if($(this).val().length>=$('.ran1').text().length){
			if(!isNaN(ben)&&!isNaN(ran)){
				if(ran>=val1&&ran<=val2){
					if(!isNaN(ben)){
						var jie=ben*(1-ran/100);
						jie=jie.toFixed(2)
						$('.t-jie').val(jie);
					}
				}else{
					$(this).val('');
				}
			}else if(isNaN(ben)){
				$('.tt-jie').val('')
				if(ran<=val2){
					var tyr=$(this).closest('table').find('tbody').find('tr');
					for(h=0;h<tyr.length;h++){
						var jben=parseFloat($(tyr[h]).find('.t-ben').val());
						var jjie=jben*(1-ran/100);
						jjie=jjie.toFixed(2)
						$(tyr[h]).find('.t-jie').val(jjie);
					}
				}else{
					$(this).val('');
				}
			}
			
		}
	
	});
	$('body').on('blur','.tt-ran',function(){
		var val1=parseInt($('.ran1').text());
		var val2=parseInt($('.ran2').text());
		if(parseFloat($(this).val())<val1||parseFloat($(this).val())>val2){
			$('.yanzhen-box div span').text('让利比不在范围内！');
            $('.yanzhen').show();
            $(this).val('');
		};
	});
	
	$('body').on('input propertychange','.bend',function(){
		if($('.imo').is(':checked')){
			var smo=parseFloat($('.smo').text());
			var ben=parseFloat($('.bend').val());
			if(!isNaN(smo)&&!isNaN(ben)){
				var jie=ben*(1-smo/100);
				jie=jie.toFixed(2)
				$('.jies').val(jie);
			}
		}else{
			var ben=parseFloat($(this).val());
			var ran=parseFloat($('.ran').val())
			if(!isNaN(ran)&&!isNaN(ben)){
				var jie=ben*(1-ran/100);
				jie=jie.toFixed(2)
				$('.jies').val(jie);
			}
		}
	});
	$('body').on('input propertychange','.ran',function(){
		var tval=$(this).val();
		var val1=parseInt($('.ran1').text());
		var val2=parseInt($('.ran2').text());
		if(tval.length>=$('.ran1').text().length){
			if(tval>=val1&&tval<=val2){
				var ben=parseFloat($('.bend').val());
				if(!isNaN(ben)){
					var jie=ben*(1-tval/100);
					jie=jie.toFixed(2)
					$('.jies').val(jie);
				}
			}else{
				$(this).val('');
			}
		}
	});
	
	
	
	if($('#kk').val()!=''){
		$('.content1').hide();
		$('.content2').show();
	}
	  //获取选中的值 
    //下面用于多图片上传预览功能
    function setImagePreviews(avalue) {
        var docObj = avalue;
        var dd = $(avalue).siblings('label');
        console.log(dd)
        //dd.innerHTML = "";
        var fileList = docObj.files;
        console.log(fileList)
        for (var i = 0; i < fileList.length; i++) {
            console.log('111')
            dd.html("<img class='img-responsive'/>");
            var imgObjPreview = dd.children('img');
            console.log(imgObjPreview)
            if (docObj.files && docObj.files[i]) {
                console.log('444')
                console.log(window.URL.createObjectURL(docObj.files[i]))
                imgObjPreview.attr('src',window.URL.createObjectURL(docObj.files[i]))
            }
            else {
                //IE下，使用滤镜
                docObj.select();
                var imgSrc = document.selection.createRange().text;
                alert(imgSrc)
                var localImagId = document.getElementById("img" + i);
                //必须设置初始大小
                localImagId.style.width = "150px";
                localImagId.style.height = "180px";
                //图片异常的捕捉，防止用户修改后缀来伪造图片
                try {
                    localImagId.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale)";
                    localImagId.filters.item("DXImageTransform.Microsoft.AlphaImageLoader").src = imgSrc;
                }
                catch (e) {
                    alert("您上传的图片格式不正确，请重新选择!");
                    return false;
                }
                imgObjPreview.style.display = 'none';
                document.selection.empty();
            }
        }

        return true;
    }
    $('.pic-list input[type=file]').change(function(){
        setImagePreviews(this);
    })

  
    //div切换
    $('body').on('click','.step1',function(){
        for (i=0;i<$('.msg-ul a').length;i++){
            if ($($('.msg-ul a')[i]).hasClass('active')){
                $('.content1').hide();
                $('.content2').show();
                $('.head-nav li:nth-child(2)').addClass('active').siblings().removeClass('active');
                
            }
        }

    })
    $('.num').cbNum();
    $('.num1').cbNum();
	$('.xiaye-del').click(function(){
		$('.xiaye').hide();
	});
    $('body').on('click','.step2',function(){
		$('.xiaye-a').addClass('xiaye-a1').removeClass('xiaye-a2')
		$('.xiaye-txt span').text('确认进入上一页？');
		$('.xiaye').show();
    })
	$('body').on('click','.xiaye-a1',function(){
		$('.xiaye').hide();
		$('.content1').show();
		$('.content2').hide();
		$('.head-nav li:nth-child(1)').addClass('active').siblings().removeClass('active');
	})
	$('body').on('click','.xiaye-a2',function(){
		$('.xiaye').hide();
		$('.content2 select').css('border','1px solid #eee');
		$('.content2').hide();
		$('.content3').show();
		$('.head-nav li:nth-child(3)').addClass('active').siblings().removeClass('active');
	})
    $('body').on('click','.step3',function(){
		

		
		var ttxin=parseFloat($('.x-in').val());
		var ttsin=parseFloat($('.s-in').val());
		if(ttxin>ttsin){
			$('.yanzhen-box div span').text('下限大于上限！');
			$('.yanzhen').show();
			return;
		}

		var value  = $('input[name="li2"]:checked').val();
		if(value==2){
			if($('.standard-left ul li').length==0){
				$('.yanzhen-box div span').text('请选择统一规格！');
				$('.yanzhen').show();
				return;
			}
		}

		var zx=parseFloat($($('.zx')[0]).text());
		var zd=parseFloat($($('.zd')[0]).text());
		if(zx!=NaN&&zd!=NaN){
			if($('.sb-xian-b input[type=checkbox]').is(':checked')){
				if($('#LAY_demorange_1').val()!=''&&$('#LAY_demorange_2').val()!=''){
					if($('.x-in').val()<zx||$('.x-in').val()>zd||$('.s-in').val()<zx||$('.s-in').val()>zd){
						console.log(zx);
						console.log(zd);
						console.log($('.x-in').val());
						console.log($('.s-in').val());
						$('.yanzhen-box div span').text('上限下限超出范围！');
						$('.yanzhen').show();
						return;
					}
				}else{
					$('.yanzhen-box div span').text('请选择生效周期！');
					$('.yanzhen').show();
					return;
				}

			}
		}

		var val1=parseInt($('.ran1').text());
		var val2=parseInt($('.ran2').text());
		if($('.shop-news ul li:nth-child(2) .radio:nth-child(2) input').is(':checked')){
			if(parseFloat($('.ran').val())<val1||parseFloat($('.ran').val())>val2){
				$('.yanzhen-box div span').text('让利比不在范围内，请重输！');
				$('.yanzhen').show();
				return;
			}
		}

		if($('.shop-news ul li:nth-child(2) .radio:nth-child(3) input').is(':checked')){
			if($('#add-stan input:checked').length==0){
				$('.yanzhen-box div span').text('请选择至少一个规格！');
				$('.yanzhen').show();
				return;
			}
		}

		if($('.maijia-ul li:nth-child(1) input').is(":checked")){
			if($('.maijia-ul li:nth-child(1) select option:selected').val()==''){
				$('.yanzhen-box div span').text('请选择运费模板！');
				$('.yanzhen').show();
				return;
			}
		}

		for(g=0;g<$('.t-ran').length;g++){
			if(parseFloat($($('.t-ran')[g]).val())<val1||parseFloat($($('.t-ran')[g]).val())>val2){
				$('.yanzhen-box div span').text('让利比不在范围内，请重输！');
				$('.yanzhen').show();
				return;
			}
		}

		var sele=$('.shop-property select');
		if($('.shop-news ul li:nth-child(2) input:checked').val()==1){
			if($(this).cbNull('input','step3')==1){
				$('.yanzhen-box div span').text('有选项没有填完，请继续填写！');
				$('.yanzhen').show();
			}else {
				for (i=0;i<sele.length;i++){
					if ($(sele[i]).find('option:selected').val()==""){
						$(sele[i]).css('border','1px solid #ff0000');
						$('.yanzhen-box div span').text('有选项没有填完，请继续填写！');
						$('.yanzhen').show();
						return;
					}
				}
				if($('#advertuseImgPreview li img').length==0){
					$('.yanzhen-box div span').text('请添加商品主图。');
					$('.yanzhen').show();
					return
				}
				if($('.property-div ul .radio').length!=0){
					for(m=0;m<$('.property-div ul').length;m++){
						var roperty=0;
						if($($('.property-div ul')[m]).children('li').children('.radio').length!=0){
							var mmv=$($('.property-div ul')[m]).find('.radio');
							for(l=0;l<mmv.length;l++){
								if($(mmv[l]).children('input').is(':checked')){
									roperty=1;
								}
							}
							if(roperty==0){
								$('.yanzhen-box div span').text('商品属性有选项没有填完，请继续填写！');
								$('.yanzhen').show();
								return
							}
						}
					}

				}
				$('.xiaye-a').addClass('xiaye-a2').removeClass('xiaye-a1')
				$('.xiaye-txt span').text('确认进入下一页？');
				$('.xiaye').show();
				
			}
		}else{
			var btben=parseFloat($('.t-ben').val());
			var btshi=parseFloat($('.t-shi').val());
			for(var x=0;x<btben.length;x++){
				if(btben>btshi){
					$('.yanzhen-box div span').text('市场价格必须大于本店价格！');
					$('.yanzhen').show();
					return;
				}
			}
			
			// if($('.table-div table tbody tr').length>50){
			// 	$('.yanzhen-box div span').text('规格数量'+$('.table-div table tbody tr').length+'条，不能超过50条！');
			// 	$('.yanzhen').show();
			// 	return
			// }
			
			if($(this).cbNull('num','step3')==1){
				$('.yanzhen-box div span').text('有选项没有填完，请继续填写！');
				$('.yanzhen').show();
			}else {
				for (i=0;i<sele.length;i++){
					if ($(sele[i]).find('option:selected').val()==""){
						$(sele[i]).css('border','1px solid #ff0000');
						$('.yanzhen-box div span').text('有选项没有填完，请继续填写！');
						$('.yanzhen').show();
						return;
					}
				}
				if($('#advertuseImgPreview li img').length==0){
					$('.yanzhen-box div span').text('请添加商品主图。');
					$('.yanzhen').show();
					return
				}
				if($('.property-div ul .radio').length!=0){
					var roperty=0;
					for(m=0;m<$('.property-div ul .radio').length;m++){
						if($($('.property-div ul .radio')[m]).children('input').is(':checked')){
							roperty=1;
						}
					}
					if(roperty==0){
						$('.yanzhen-box div span').text('商品属性有选项没有填完，请继续填写！');
						$('.yanzhen').show();
						return
					}
				}
				$('.xiaye-a').addClass('xiaye-a2').removeClass('xiaye-a1')
				$('.xiaye-txt span').text('确认进入下一页？');
				$('.xiaye').show();
				
			}
		}
        //if ($($('#news1')).validity.valueMissing){
        //    console.log('321')
        //    document.getElementById('news1').setCustomValidity('用户名不能为空')
        //}else {

        //}

    })
    $('body').on('click','.step4',function(){
        $('.content3').hide();
        $('.content2').show();
        $('.head-nav li:nth-child(2)').addClass('active').siblings().removeClass('active');
    })

    $('body').on('click','.msg-ul ul li a',function(){
        $(this).addClass('active').parent().siblings().children().removeClass('active');
        $(this).closest('.msg-ul').siblings('.msg-ul').find('a').removeClass('active')
    })

    //得到规格值
    $('body').on('click','.standard-left input[type=checkbox]',function(){
    		if($('.standard-left input:checked').length<=3){
    			if($(this).is(':checked')){
    				$(this).attr('checked','checked');
    			}else{
    				$(this).removeAttr('checked');
    			}
    			if($(this).is(':checked')){
    				
                	var tte=$(this).siblings('label').text();
                	var tval=$(this).val();
                	var html2=`<ul class="right-ul1"><li>${tte}<input type='hidden' value=${tval}></li><li>`;
                	  $(".run-ball-box").show();
                    //获取选中的值 
                    $.ajax({
			             type: "POST",
			             url: contextPath+"/supplyshop/supplyShopproduct/commercialeDetail",
			             data: {id:tval,productId:$("#kk").val()},
			             success:function(date){
			            	  $(".run-ball-box").hide();
			                for(var j=0;j<date.length;j++){
			                	html2+=`<span>${date[j].spertAttrValue}<input type="hidden"  name="attrId" value=${date[j].id}><b></b></span>`;
		                     }
			                html2+=`<a href="javascript:;"><img src="${contextPath}/static/supplyshop/images/add-a.png" alt=""></a></li></ul>`;
		                    $('.standard-right').append(html2);
		                    var trnum=$('.standard-right ul').length-1;
		                    if(date.length!=0){$('table thead th:nth-child('+trnum+')').after('<th>'+tte+'</th>');}
		                    
							 if ($('.standard-left input[type=checkbox]:checked').length==1){
								 addtable()
							 }else {
								 if (date.length!=0){
									 var tshi=$('.t-shi').val();
									 var tlast=$('tfoot tr td:last-child input').val();
									 var ttm='';
									 if($('.standard-left input[type=checkbox]:checked').length==2){
										 var ssp=$($('.right-ul1')[0]).find('span');
										 $('tfoot tr td:nth-child(1)').attr('colspan','2');
										$('.table-div table tbody tr td:nth-child(1)').after(`<td data-t="${date[0].id}">${date[0].spertAttrValue}</td>`);
										 var nth1=$('.table-div table tbody tr td:nth-child(1)');
										 for(c=0;c<nth1.length;c++){
											 $(nth1[c]).find('input').val($(nth1[c]).find('input').val()+':'+date[0].id);
										 }
										 for (var f=0;f<ssp.length;f++){
											 for (var d=1;d<date.length;d++){
												ttm+=`<tr><td data-t="${$(ssp[f]).find('input').val()}">${$(ssp[f]).text()}<input name="standard_id_str" type="hidden" value="${$(ssp[f]).find('input').val()+':'+date[d].id}"></td><td data-t="${date[d].id}">${date[d].spertAttrValue}</td>`;
												 if(tshi==''){ttm+=`<td><input class="num t-shi" name="wholesale_price" type="text"></td>`;}else{ttm+=`<td><input class="num t-shi" name="wholesale_price" type="text" value="${tshi}"></td>`;}
												 if(tlast==''){ttm+=`<td><input class="num" name="wholesale_store_nums" type="text"></td></tr>`;}else{ttm+=`<td><input class="num" name="wholesale_store_nums" type="text" value="${tlast}"></td></tr>`;}
											 }
										 }
										 
										 $('.table-div table tbody').append(ttm)
									 }
									 if($('.standard-left input[type=checkbox]:checked').length==3){
										 $('tfoot tr td:nth-child(1)').attr('colspan','3');
										 var ssp1=$($('.right-ul1')[0]).find('span');
										 var ssp2=$($('.right-ul1')[1]).find('span');
										 $('.table-div table tbody tr td:nth-child(2)').after(`<td data-t="${date[0].id}">${date[0].spertAttrValue}</td>`);
										 var nth1=$('.table-div table tbody tr td:nth-child(1)');
										 for(c=0;c<nth1.length;c++){
											 $(nth1[c]).find('input').val($(nth1[c]).find('input').val()+':'+date[0].id);
										 }
										 for (var f=0;f<ssp1.length;f++){
											 for(var g=0;g<ssp2.length;g++){
												 for (var d=1;d<date.length;d++){
													 ttm+=`<tr><td data-t="${$(ssp1[f]).find('input').val()}">${$(ssp1[f]).text()}<input name="standard_id_str" type="hidden" value="${$(ssp1[f]).find('input').val()+':'+$(ssp2[g]).find('input').val()+':'+date[d].id}"></td><td data-t="${$(ssp2[g]).find('input').val()}">${$(ssp2[g]).text()}</td><td data-t="${date[d].id}">${date[d].spertAttrValue}</td>`;
													 if(tshi==''){ttm+=`<td><input class="num t-shi" name="wholesale_price" type="text"></td>`;}else{ttm+=`<td><input class="num t-shi" name="wholesale_price" type="text" value="${tshi}"></td>`;}
													 if(tlast==''){ttm+=`<td><input class="num" name="wholesale_store_nums" type="text"></td></tr>`;}else{ttm+=`<td><input class="num" name="wholesale_store_nums" type="text" value="${tlast}"></td></tr>`;}
												 }
											 }
										 }
										 $('.table-div table tbody').append(ttm)
									 }
								 }
							 }
							 $('.num').cbNum();
							    $('.num1').cbNum();

			               }
			             });           
//                    var trnum=$('.standard-right ul').length-1;
//                    $('table thead th:nth-child('+trnum+')').after('<th>'+tte+'</th>');
//                    addtable()
                  
                }else{
                	
                	var tte=$(this).val();
                	for(i=0;i<$('.standard-right ul').length;i++){
                		if($($('.standard-right ul')[i]).children('li:nth-child(1)').children('input').val()==tte){
                			var num1=$($('.standard-right ul')[i]).index();
                			if($($('.standard-right ul')[i]).find('span').length!=0){
                				
                				var delv=$('.table-div table tbody tr td:nth-child(1)');
                				var delv2=$('.table-div table tbody tr td:nth-child(2)');
                				if(num1==3){
                					for(b=0;b<delv.length;b++){
                						var dii=$(delv[b]).find('input').val();
                						dii=dii.split(":");
                						dii.splice(2,1);
                						dii=dii.join(':');
                						$(delv[b]).find('input').val(dii);
                					}
                				}else if(num1==2){
                					for(b=0;b<delv.length;b++){
                						var dii=$(delv[b]).find('input').val();
                						dii=dii.split(":");
                						dii.splice(1,1);
                						dii=dii.join(':');
                						$(delv[b]).find('input').val(dii);
                					}
                				}else if(num1==1){
                					for(b=0;b<delv.length;b++){
                						var dii=$(delv[b]).find('input').val();
                						dii=dii.split(":");
                						dii.splice(0,1);
                						dii=dii.join(':');
                						$(delv[b]).find('input').val(dii);
                					}
                					if(delv2.length!=0){
                						for(m=0;m<delv.length;m++){
                							$(delv2[m]).append(`<input name="standard_id_str" type="hidden" value="${$(delv[m]).find('input').val()}"/>`);
                						}
                					}
                				}
                				$('table tbody tr td:nth-child('+num1+')').remove();
                				$('table th:nth-child('+num1+')').remove();
                			}
                			$($('.standard-right ul')[i]).remove();
                		}
                	}
                     
                     
					if ($('.standard-left input[type=checkbox]:checked').length==1){
						var rem=$('.table-div tbody tr td:nth-child(1)');
						for (c=0;c<rem.length;c++){
							for (v=c+1;v<rem.length;v++){
								if ($(rem[c]).attr('data-t')==$(rem[v]).attr('data-t')){
									$(rem[v]).closest('tr').remove();
								}
							}
						}
						$('.table-div tfoot tr td:nth-child(1)').attr('colspan',$('.right-ul1').length)
					}else if($('.standard-left input[type=checkbox]:checked').length==2){
						var rem1=$('.table-div tbody tr td:nth-child(1)');
						var rem2=$('.table-div tbody tr td:nth-child(2)');
						for (c=0;c<rem1.length;c++){
							for (v=c+1;v<rem1.length;v++){
								var allrem1=$(rem1[c]).attr('data-t')+$(rem2[c]).attr('data-t')+'';
								var allrem2=$(rem1[v]).attr('data-t')+$(rem2[v]).attr('data-t')+'';
								if (allrem1==allrem2){
									$(rem1[v]).closest('tr').remove();
								}
							}
						}
						$('.table-div tfoot tr td:nth-child(1)').attr('colspan',$('.right-ul1').length)
					}else{
						$('.table-div tbody tr').remove();
						addtable();
					}
                }
    		}
    		if($('.standard-left input:checked').length==3){
    			for(h=0;h<$('.standard-left input[type=checkbox]').length;h++){
    				if(!$($('.standard-left input[type=checkbox]')[h]).is(':checked')){
    					$($('.standard-left input[type=checkbox]')[h]).attr('disabled','disabled');
    				}
    			}
    		}else{
    			for(h=0;h<$('.standard-left input[type=checkbox]').length;h++){
    				if(!$($('.standard-left input[type=checkbox]')[h]).is(':checked')){
    					$($('.standard-left input[type=checkbox]')[h]).removeAttr('disabled');
    				}
    			}
    		}    
                    
          
    });
    //select选项值改变
    $('body').on('change','.standard-left select',function(){
        var val=$(this).children('option:selected').text();
        var num=$(this).parent().parent().index()+2;
        var num1=$(this).parent().parent().index()+1;
        $('.standard-right ul:nth-child('+num+')').children('li:first-child').html(val);
        $('table thead th:nth-child('+num1+')').html(val);
        addtable()
    });

    $('body').on('click','.shop-news ul li:nth-child(2) input',function(){
    	console.log('22')
    	if($(this).val()==1){
    		$(".statendTo").show();
			  $("#shop-standard").hide();
			  console.log('11')
    	}else{
    		 $("#shop-standard").show();
			  $(".statendTo").hide();
			  console.log('00')
    	}
    })
    
    //删除tr
    $('body').on('click','.table-div tbody a',function(){
        $(this).closest('tr').remove();
    })



    //批量添加
    $('body').on('input propertychange','.tfoot input',function(){
        var did=$(this).parent().index();
        var val=$(this).val();

        var dtr=$('tbody tr');
        for (i=0;i<dtr.length;i++){
            $($(dtr[i]).find('input:[type=text]')[did-1]).val(val)
        }
    });
    //删除子规格
    $('body').on('click','.right-ul1  li b',function(){
        var ta=$(this).siblings('input').val();
        var lasp=$(this).closest('li').find('span').length;
        var bid=$(this).siblings('input').val();
        var tnum=$(this).closest('ul').index();
        var bt=$(this);
        $.ajax({
            type: "POST",
            url:  contextPath+"/supplyshop/supplyShopproduct/deletecommercialeDehors",
            data: {typeId:bid,productId:$("#kk").val()},
            success:function(date){
            	if(date.code=='00'){
					
            		$('.yanzhen-box div span').text(date.msg);
    				$('.yanzhen').show();
    				 
    			        if(tnum==1){
    			        	if(lasp==1){
    			        		var delv=$('.table-div table tbody tr td:nth-child(1)');
                				var delv2=$('.table-div table tbody tr td:nth-child(2)');
                				var dia=$('.right-ul1');
								console.log(delv.length);
    			        		for(b=0;b<delv.length;b++){
            						var dii=$(delv[b]).find('input').val();
            						dii=dii.split(":");
            						dii.splice(0,1);
            						dii=dii.join(':');
            						$(delv[b]).find('input').val(dii);
            					}
								console.log($(dia[1]).find('span').length);
            					if($(dia[1]).find('span').length!=0){
									$('.table-div table thead th:nth-child(1)').remove();
            						for(m=0;m<delv.length;m++){
            							$(delv2[m]).append(`<input name="standard_id_str" type="hidden" value="${$(delv[m]).find('input').val()}"/>`);
            						}
            						$('tbody td[data-t='+ta+']').remove();
            					}else{
									$('.table-div table thead th:nth-child(1)').html('');
            						$('tbody td[data-t='+ta+']').parent().remove();
            					}
    			        		
    			        		
    			        		for(f=0;f<$('.standard-left li').length;f++){
    			        			if($($('.standard-left li')[f]).children('input').val()==bt.closest('.right-ul1').children('li:nth-child(1)').children('input').val()){
    			        				$($('.standard-left li')[f]).find('input').removeAttr('checked');
    			        			}
    			        		}
    			        		for(h=0;h<$('.standard-left input[type=checkbox]').length;h++){
    			    				if(!$($('.standard-left input[type=checkbox]')[h]).is(':checked')){
    			    					$($('.standard-left input[type=checkbox]')[h]).removeAttr('disabled');
    			    				}
    			    			}
    			        		bt.closest('.right-ul1').remove();
    			        		$('.table-div table tfoot tr td:nth-child(1)').attr('colspan',$('.right-ul1').length);
    			        	}else{
    			        		$('tbody td[data-t='+ta+']').parent().remove();
    			        	}
    			        }else if(tnum==2){
    			        	if(lasp==1){
    			        		var delv=$('.table-div table tbody tr td:nth-child(1)');
    			        		for(b=0;b<delv.length;b++){
            						var dii=$(delv[b]).find('input').val();
            						dii=dii.split(":");
            						dii.splice(1,1);
            						dii=dii.join(':');
            						$(delv[b]).find('input').val(dii);
            					}
    			        		$('tbody td[data-t='+ta+']').remove();
    			        		$('.table-div table thead th:nth-child(2)').remove();
    			        		
    			        		for(f=0;f<$('.standard-left li').length;f++){
    			        			if($($('.standard-left li')[f]).children('input').val()==bt.closest('.right-ul1').children('li:nth-child(1)').children('input').val()){
    			        				$($('.standard-left li')[f]).find('input').removeAttr('checked');
    			        			}
    			        		}
    			        		for(h=0;h<$('.standard-left input[type=checkbox]').length;h++){
    			    				if(!$($('.standard-left input[type=checkbox]')[h]).is(':checked')){
    			    					$($('.standard-left input[type=checkbox]')[h]).removeAttr('disabled');
    			    				}
    			    			}
    			        		bt.closest('.right-ul1').remove();
    			        		$('.table-div table tfoot tr td:nth-child(1)').attr('colspan',$('.right-ul1').length);
    			        	}else{
    			        		$('tbody td[data-t='+ta+']').parent().remove();
    			        	}
    			        }else if(tnum==3){
    			        	if(lasp==1){
    			        		var delv=$('.table-div table tbody tr td:nth-child(1)');
    			        		for(b=0;b<delv.length;b++){
            						var dii=$(delv[b]).find('input').val();
            						dii=dii.split(":");
            						dii.splice(2,1);
            						dii=dii.join(':');
            						$(delv[b]).find('input').val(dii);
            					}
    			        		$('tbody td[data-t='+ta+']').remove();
    			        		$('.table-div table thead th:nth-child(3)').remove();
    			        		
    			        		for(f=0;f<$('.standard-left li').length;f++){
    			        			if($($('.standard-left li')[f]).children('input').val()==bt.closest('.right-ul1').children('li:nth-child(1)').children('input').val()){
    			        				$($('.standard-left li')[f]).find('input').removeAttr('checked');
    			        			}
    			        		}
    			        		for(h=0;h<$('.standard-left input[type=checkbox]').length;h++){
    			    				if(!$($('.standard-left input[type=checkbox]')[h]).is(':checked')){
    			    					$($('.standard-left input[type=checkbox]')[h]).removeAttr('disabled');
    			    				}
    			    			}
    			        		bt.closest('.right-ul1').remove();
    			        		$('.table-div table tfoot tr td:nth-child(1)').attr('colspan',$('.right-ul1').length);
    			        	}else{
    			        		$('tbody td[data-t='+ta+']').parent().remove();
    			        	}
    			        }
    			        
    			        bt.parent().remove();
            	}else{
            		$('.yanzhen-box div span').text(date.msg);
    				$('.yanzhen').show();
            	}
				
              }
           });        
       
    });
   

    $('body').on('click','.list-ul>li>a',function(){
        $(this).addClass('hove').parent().siblings().children('a').removeClass('hove')
    });

    //关闭弹窗--未输入
    $('.yanzhen-box div a').click(function(){
        $('.yanzhen').hide();
    });

    //添加子规格
    var th;
    var next;
    var next2;
    var next3;
    var next4;
    var next5;
    var uu;
    var html1;
    var html2;
    var html3;
    var sib;
	var snu;
	var snv;
    $('body').on('click','.right-ul1 a',function(){
    	
    		 	th=$(this);
    	        sib=th.siblings();
    	        next=th.closest('.right-ul1').next('ul').find('span');
    	        next1=th.closest('.right-ul1').next().next().find('span');
    	        next2=th.closest('.right-ul1').prev().find('span');
    	        next3=th.closest('.right-ul1').next().find('span');
    	        next4=th.closest('.right-ul1').prev().prev().find('span');
    	        next5=th.closest('.right-ul1').prev().find('span');
    	        uu=$(this).closest('.right-ul1').index();
    	        snv=$(this).closest('.right-ul1').find('li:nth-child(1)').find('input').val();
    			snu=$(this).closest('.right-ul1').find('span').length+1;
    	        if(uu==2){
    	        	if($($('.right-ul1')[0]).find('span').length==0){
    	        		$('.yanzhen-box div span').text('请先添加上一级规格！');
    	           	 	$('.yanzhen').show();
    	           	 	return
    	        	}
    	        }else if(uu==3){
    	        	if($($('.right-ul1')[1]).find('span').length==0){
    	        		$('.yanzhen-box div span').text('请先添加上一级规格！');
    	           	 	$('.yanzhen').show();
    	           	 	return
    	        	}
    	        }
    	        $('.guige').show();
    	
       
    });


        $('.guige .guige-box-add').click(function(){
            var txt=addval($(this),th);
            if(txt==''){
            	$('.yanzhen-box div span').text('规格值不能为空！');
           	 	$('.yanzhen').show();
           	 	return
            }
            txt=Trim(txt,'g');
            var html2='';
            $.ajax({
	             type: "POST",
	             url:  contextPath+"/supplyshop/supplyShopproduct/addcommercialeDehors",
	             data: {values:txt,typeId:snv,productId:$("#kk").val()},
	             success:function(date){
	            	 for(var j=0;j<date.length;j++){
		                	html2+=`<span>${date[j].spertAttrValue}<input type="hidden"  name="attrId" value=${date[j].id}><b></b></span>`;
	                    }
		                html2+=`<a href="javascript:;"><img src=${contextPath}/static/supplyshop/images/add-a.png" alt=""></a>`;
	                   $('.standard-right ul:nth-child('+(uu+1)+')').children('li:last-child').html(html2);
	                   var trnum=$('.standard-right ul').length-1;
//	                   $('table thead th:nth-child('+trnum+')').after('<th>'+$('.standard-left ul:last-child select option:selected').text()+'</th>');
	                   if ($('.right-ul1').length==1){
						   	if ($('.right-ul1').find('span').length==snu){
								$('.table-div table tbody').append(`<tr><td data-t="${date[date.length-1].id}">${txt}<input name="standard_id_str" type="hidden" value="${date[date.length-1].id}"></td>
	                            <td><input class="num t-shi" name="wholesale_price" type="text"></td>
	                            
	                            
	                              
	                              <td><input class="num" name="wholesale_store_nums" type="text"></td>
	                             </tr>`);
							}else {
								for (s=snu-1;s<date.length;s++){
									$('.table-div table tbody').append(`<tr><td data-t="${date[s].id}">${date[s].spertAttrValue}<input name="standard_id_str" type="hidden" value="${date[s].id}"></td>
	                            <td><input class="num t-shi" name="wholesale_price" type="text"></td>
	                            
	                            
	                              
	                              <td><input class="num" name="wholesale_store_nums" type="text"></td>
	                             </tr>`);
								}
							}
						 }else if($('.right-ul1').length==2){
							 if (uu==1){
								 if ($($('.right-ul1')[0]).find('span').length==snu){
									 var addspan=$($('.right-ul1')[1]).find('span');
									 if($($('.right-ul1')[0]).find('span').length==1){
										 var trt2=$($('.right-ul1')[0]).children('li:nth-child(1)').text();
										 //$('.table-div table thead tr th:nth-child(1)').after(`<th data-t="${trt2}">${trt2}</th>`)
										 if($($('.right-ul1')[1]).find('span').length!=0){
											 var sp1=$($('.right-ul1')[1]).find('span');
											 for (s=0;s<sp1.length;s++){
													$('.table-div table tbody').append(`<tr><td data-t="${date[s].id}">${date[s].spertAttrValue}<input name="standard_id_str" type="hidden" value="${date[s].id+':'+$(sp1[s]).find('input').val()}"></td>
													<td data-t="${$(sp1[s]).find('input').val()}">${$(sp1[s]).text()}</td>
					                            <td><input class="num t-shi" name="wholesale_price" type="text"></td>
					                            
					                            
					                              
					                              <td><input class="num" name="wholesale_store_nums" type="text"></td>
					                             </tr>`);
												}
											 $('.table-div table tfoot tr td:nth-child(1)').attr('colspan',$('.right-ul1').length)
										 }else{
											 $('.table-div table tbody').append(`<tr><td data-t="${date[date.length-1].id}">${txt}<input name="standard_id_str" type="hidden" value="${date[date.length-1].id}"></td><td><input class="num t-shi" name="wholesale_price" type="text"></td>
					                            
					                            
					                              
					                              <td><input class="num" name="wholesale_store_nums" type="text"></td>
					                             </tr>`)
											 $('.table-div table tfoot tr td:nth-child(1)').attr('colspan','1')
										 }
										 
									 }else{
										 if(addspan.length!=0){
											 for (x=0;x<addspan.length;x++){
												 $('.table-div table tbody').append(`<tr><td data-t="${date[date.length-1].id}">${txt}<input name="standard_id_str" type="hidden" value="${date[date.length-1].id+':'+$(addspan[x]).find('input').val()}"></td><td data-t="${$(addspan[x]).find('input').val()}">${$(addspan[x]).text()}</td>
													<td><input class="num t-shi" name="wholesale_price" type="text"></td>
													
													
													  
													  <td><input class="num" name="wholesale_store_nums" type="text"></td>
													 </tr>`);
											 }
										 }else{
											 $('.table-div table tbody').append(`<tr><td data-t="${date[date.length-1].id}">${txt}<input name="standard_id_str" type="hidden" value="${date[date.length-1].id}"></td><td><input class="num t-shi" name="wholesale_price" type="text"></td>
					                           
					                              <td><input class="num" name="wholesale_store_nums" type="text"></td>
					                             </tr>`)
										 }
										 
									 }
								 }else {
									 var addspan=$($('.right-ul1')[1]).find('span');
									 for(s=snu-1;s<date.length;s++){
										 for (x=0;x<addspan.length;x++){
											 $('.table-div table tbody').append(`<tr><td data-t="${date[s].id}">${date[s].spertAttrValue}<input name="standard_id_str" type="hidden" value="${date[s].id+':'+$(addspan[x]).find('input').val()}"></td><td data-t="${$(addspan[x]).find('input').val()}">${$(addspan[x]).text()}</td>
												<td><input class="num t-shi" name="wholesale_price" type="text"></td>
												  <td><input class="num" name="wholesale_store_nums" type="text"></td>
												 </tr>`);
										 }
									 }
								 }


							 }else if(uu==2){
								 if ($($('.right-ul1')[1]).find('span').length==snu){
									 var addspan=$($('.right-ul1')[0]).find('span');
									 if($($('.right-ul1')[1]).find('span').length==1){
										 var trt2=$($('.right-ul1')[1]).children('li:nth-child(1)').text();
										 $('.table-div table thead th:nth-child(1)').after(`<th data-t="${trt2}">${trt2}</th>`)
										 $('.table-div table tbody tr td:nth-child(1)').after(`<td data-t="${date[date.length-1].id}">${txt}</td>`)
										 $('.table-div table tfoot tr td:nth-child(1)').attr('colspan','2')
										 var nth1=$('.table-div table tbody tr td:nth-child(1)');
										 for(c=0;c<nth1.length;c++){
											 $(nth1[c]).find('input').val($(nth1[c]).find('input').val()+':'+date[date.length-1].id);
										 }
									 }else{
										 for (x=0;x<addspan.length;x++){
											 $('.table-div table tbody').append(`<tr><td data-t="${$(addspan[x]).find('input').val()}">${$(addspan[x]).text()}<input name="standard_id_str" type="hidden" value="${$(addspan[x]).find('input').val()+':'+date[date.length-1].id}"></td><td data-t="${date[date.length-1].id}">${txt}</td>
											<td><input class="num t-shi" name="wholesale_price" type="text"></td>
											  <td><input class="num" name="wholesale_store_nums" type="text"></td>
											 </tr>`);
										 }
									 }
								 }else {
									 var addspan=$($('.right-ul1')[0]).find('span');
									 for (x=0;x<addspan.length;x++){
										 for(s=snu-1;s<date.length;s++){
											 $('.table-div table tbody').append(`<tr><td data-t="${$(addspan[x]).find('input').val()}">${$(addspan[x]).text()}<input name="standard_id_str" type="hidden" value="${$(addspan[x]).find('input').val()+':'+date[s].id}"></td><td data-t="${date[s].id}">${date[s].spertAttrValue}</td>
											<td><input class="num t-shi" name="wholesale_price" type="text"></td>
											
											
											  
											  <td><input class="num" name="wholesale_store_nums" type="text"></td>
											 </tr>`);
										 }
									 }
								 }

								
							 }
						 }else if($('.right-ul1').length==3){
							 if (uu==1){
								 var addspan1=$($('.right-ul1')[1]).find('span');
								 var addspan2=$($('.right-ul1')[2]).find('span');
								 var addspana1=$($('.right-ul1')[1]).find('span').length;
								 var addspana2=$($('.right-ul1')[2]).find('span').length;
								 if ($($('.right-ul1')[0]).find('span').length==snu){
									 if($($('.right-ul1')[0]).find('span').length==1){
										 if(addspana1==0&&addspana2==0){
											 var trt2=$($('.right-ul1')[1]).children('li:nth-child(1)').text();

											 $('.table-div table tbody').append(`<tr><td data-t="${date[date.length-1].id}">${txt}<input name="standard_id_str" type="hidden" value="${date[date.length-1].id}"></td><td><input class="num t-shi" name="wholesale_price" type="text"></td>
	                              		 <td><input class="num" name="wholesale_store_nums" type="text"></td>
	                               		 </tr>`)
											 $('.table-div table tfoot tr td:nth-child(1)').attr('colspan','1')
										 }else if(addspana1!=0&&addspana2!=0){
											 for (x=0;x<addspan1.length;x++){
												 for (z=0;z<addspan2.length;z++){
													 $('.table-div table tbody').append(`<tr><td data-t="${date[date.length-1].id}">${txt}<input name="standard_id_str" type="hidden" value="${date[date.length-1].id+':'+$(addspan1[x]).find('input').val()+':'+$(addspan2[z]).find('input').val()}"></td><td data-t="${$(addspan1[x]).find('input').val()}">${$(addspan1[x]).text()}</td>
											 <td data-t="${$(addspan2[z]).find('input').val()}">${$(addspan2[z]).text()}</td>
		                              		 <td><input class="num t-shi" name="wholesale_price" type="text"></td>
		                                	 <td><input class="num" name="wholesale_store_nums" type="text"></td>
		                               		 </tr>`);
												 }
											 }
											 $('.table-div table tfoot tr td:nth-child(1)').attr('colspan','3')
										 }

									 }else {
										 if ($($('.right-ul1')[2]).find('span').length!=0){
											 for (x=0;x<addspan1.length;x++){
												 for (z=0;z<addspan2.length;z++){
													 $('.table-div table tbody').append(`<tr><td data-t="${date[date.length-1].id}">${txt}<input name="standard_id_str" type="hidden" value="${date[date.length-1].id+':'+$(addspan1[x]).find('input').val()+':'+$(addspan2[z]).find('input').val()}"></td><td data-t="${$(addspan1[x]).find('input').val()}">${$(addspan1[x]).text()}</td>
											 <td data-t="${$(addspan2[z]).find('input').val()}">${$(addspan2[z]).text()}</td>
		                              		 <td><input class="num t-shi" name="wholesale_price" type="text"></td>
		                                	 <td><input class="num" name="wholesale_store_nums" type="text"></td>
		                               		 </tr>`);
												 }
											 }
										 }else if ($($('.right-ul1')[1]).find('span').length!=0){
											 for (x=0;x<addspan1.length;x++){
												 $('.table-div table tbody').append(`<tr><td data-t="${date[date.length-1].id}">${txt}<input name="standard_id_str" type="hidden" value="${$(date[date.length-1]).id+':'+$(addspan1[x]).find('input').val()}"></td><td data-t="${$(addspan1[x]).find('input').val()}">${$(addspan1[x]).text()}</td>
												 <td><input class="num t-shi" name="wholesale_price" type="text"></td>
												 <td><input class="num" name="wholesale_store_nums" type="text"></td>
												 </tr>`);
											 }
										 }else {
											 $('.table-div table tbody').append(`<tr><td data-t="${date[date.length-1].id}">${txt}<input name="standard_id_str" type="hidden" value="${date[date.length-1].id}"></td>
												 <td><input class="num t-shi" name="wholesale_price" type="text"></td>
												 <td><input class="num" name="wholesale_store_nums" type="text"></td>
												 </tr>`);
										 }

									 }
								 }else {
									 if (snu==1){
										 for (s=0;s<date.length;s++){
											 $('.table-div table tbody').append(`<tr><td data-t="${date[s].id}">${date[s].spertAttrValue}<input name="standard_id_str" type="hidden" value="${date[s].id}"></td><td><input class="num t-shi" name="wholesale_price" type="text"></td>
	                              		
	                                	 <td><input class="num" name="wholesale_store_nums" type="text"></td>
	                               		 </tr>`)
										 }
									 }else {
										 if ($($('.right-ul1')[2]).find('span').length!=0){
											 for (s=snu;s<date.length;s++){
												 for (x=0;x<addspan1.length;x++){
													 for (z=0;z<addspan2.length;z++){
														 $('.table-div table tbody').append(`<tr><td data-t="${date[s].id}">${date[s].spertAttrValue}<input name="standard_id_str" type="hidden" value="${date[s].id+':'+$(addspan1[x]).find('input').val()+':'+$(addspan2[z]).find('input').val()}"></td><td data-t="${$(addspan1[x]).find('input').val()}">${$(addspan1[x]).text()}</td>
											 <td data-t="${$(addspan2[z]).find('input').val()}">${$(addspan2[z]).text()}</td>
		                              		 <td><input class="num t-shi" name="wholesale_price" type="text"></td>
		                                	 <td><input class="num" name="wholesale_store_nums" type="text"></td>
		                               		 </tr>`);
													 }
												 }
											 }
										 }else if ($($('.right-ul1')[1]).find('span').length!=0){
											 for (s=snu;s<date.length;s++){
												 for (x=0;x<addspan1.length;x++){
													 $('.table-div table tbody').append(`<tr><td data-t="${date[s].id}">${date[s].spertAttrValue}<input name="standard_id_str" type="hidden" value="${date[s].id+':'+$(addspan1[x]).find('input').val()}"></td><td data-t="${$(addspan1[x]).find('input').val()}">${$(addspan1[x]).text()}</td>
		                              		 <td><input class="num t-shi" name="wholesale_price" type="text"></td>
		                                	 <td><input class="num" name="wholesale_store_nums" type="text"></td>
		                               		 </tr>`);

												 }
											 }
										 }

									 }
								 }
							 }else if(uu==2){
								 var addspan1=$($('.right-ul1')[0]).find('span');
								 var addspan2=$($('.right-ul1')[2]).find('span');
								 if ($($('.right-ul1')[1]).find('span').length==snu){
									 if($($('.right-ul1')[1]).find('span').length==1){
										 if(addspan2.length!=0&&addspan1.length!=0){
											 for (x=0;x<addspan1.length;x++){
												 for (z=0;z<addspan2.length;z++){
													 $('.table-div table tbody').append(`<tr><td data-t="${$(addspan1[x]).find('input').val()}">${$(addspan1[x]).text()}<input name="standard_id_str" type="hidden" value="${$(addspan1[x]).find('input').val()+':'+date[date.length-1].id+':'+$(addspan2[z]).find('input').val()}"></td><td data-t="${date[date.length-1].id}">${txt}</td>
											 <td data-t="${$(addspan2[z]).find('input').val()}">${$(addspan2[z]).text()}</td>
		                              		 <td><input class="num t-shi" name="wholesale_price" type="text"></td>
		                                	 <td><input class="num" name="wholesale_store_nums" type="text"></td>
		                               		 </tr>`);
												 }
											 }
											 $('.table-div table tfoot tr td:nth-child(1)').attr('colspan','3')
										 }else if(addspan1.length!=0&&addspan2.length==0){
											 var trt2=$($('.right-ul1')[1]).children('li:nth-child(1)').text();
											 $('.table-div table thead th:nth-child(1)').after(`<th data-t="${trt2}">${trt2}</th>`)
											 $('.table-div table tbody tr td:nth-child(1)').after(`<td data-t="${date[date.length-1].id}">${txt}</td>`)
											 $('.table-div table tfoot tr td:nth-child(1)').attr('colspan','2')
											 var nth1=$('.table-div table tbody tr td:nth-child(1)');
											 for(c=0;c<nth1.length;c++){
												 $(nth1[c]).find('input').val($(nth1[c]).find('input').val()+':'+date[date.length-1].id);
											 }
										 }
										 
									 }else {
										 if (addspan2.length!=0){
											 for (x=0;x<addspan1.length;x++){
												 for (z=0;z<addspan2.length;z++){
													 $('.table-div table tbody').append(`<tr><td data-t="${$(addspan1[x]).find('input').val()}">${$(addspan1[x]).text()}<input name="standard_id_str" type="hidden" value="${$(addspan1[x]).find('input').val()+':'+date[date.length-1].id+':'+$(addspan2[z]).find('input').val()}"></td><td data-t="${date[date.length-1].id}">${txt}</td>
											 <td data-t="${$(addspan2[z]).find('input').val()}">${$(addspan2[z]).text()}</td>
		                            		 <td><input class="num t-shi" name="wholesale_price" type="text"></td>
		                              	 <td><input class="num" name="wholesale_store_nums" type="text"></td>
		                             		 </tr>`);
												 }
											 }
										 }else {
											 for (x=0;x<addspan1.length;x++){
													 $('.table-div table tbody').append(`<tr><td data-t="${$(addspan1[x]).find('input').val()}">${$(addspan1[x]).text()}<input name="standard_id_str" type="hidden" value="${$(addspan1[x]).find('input').val()+':'+date[date.length-1].id}"></td><td data-t="${date[date.length-1].id}">${txt}</td>
		                            		 <td><input class="num t-shi" name="wholesale_price" type="text"></td>
		                              	 <td><input class="num" name="wholesale_store_nums" type="text"></td>
		                             		 </tr>`);
											 }
										 }
									 }
								 }else {
									 if (snu==1){
										 var trt2=$($('.right-ul1')[1]).children('li:nth-child(1)').text();
										 $('.table-div table thead th:nth-child(1)').after(`<th data-t="${trt2}">${trt2}</th>`)
										 $('.table-div table tbody tr td:nth-child(1)').after(`<td data-t="${date[0].id}">${date[0].spertAttrValue}</td>`)
										 $('.table-div table tfoot tr td:nth-child(1)').attr('colspan','2');
										 var nth1=$('.table-div table tbody tr td:nth-child(1)');
										 for(c=0;c<nth1.length;c++){
											 $(nth1[c]).find('input').val($(nth1[c]).find('input').val()+':'+date[0].id);
										 }
										 for (x=0;x<addspan1.length;x++){
											 for (s=1;s<date.length;s++){
												 $('.table-div table tbody').append(`<tr><td data-t="${$(addspan1[x]).find('input').val()}">${$(addspan1[x]).text()}<input name="standard_id_str" type="hidden" value="${$(addspan1[x]).find('input').val()+':'+date[s].id}"></td><td data-t="${date[s].id}">${date[s].spertAttrValue}</td>
		                            		 <td><input class="num t-shi" name="wholesale_price" type="text"></td>
		                              	 <td><input class="num" name="wholesale_store_nums" type="text"></td>
		                             		 </tr>`);
											 }
										 }
									 }else {
										 if ($($('.right-ul1')[2]).find('span').length==0){
											 for (x=0;x<addspan1.length;x++){
												 for (s=snu;s<date.length;s++){
													 $('.table-div table tbody').append(`<tr><td data-t="${$(addspan1[x]).find('input').val()}">${$(addspan1[x]).text()}<input name="standard_id_str" type="hidden" value="${$(addspan1[x]).find('input').val()+':'+date[s].id}"></td><td data-t="${date[s].id}">${date[s].spertAttrValue}</td>
		                            		 <td><input class="num t-shi" name="wholesale_price" type="text"></td>
		                              	 <td><input class="num" name="wholesale_store_nums" type="text"></td>
		                             		 </tr>`);
												 }
											 }
										 }else {
											 for (x=0;x<addspan1.length;x++){
												 for (s=snu;s<date.length;s++){
													 for (z=0;z<addspan2.length;z++){
														 $('.table-div table tbody').append(`<tr><td data-t="${$(addspan1[x]).find('input').val()}">${$(addspan1[x]).text()}<input name="standard_id_str" type="hidden" value="${$(addspan1[x]).find('input').val()+':'+date[s].id+':'+$(addspan2[z]).find('input').val()}"></td><td data-t="${date[s].id}">${date[s].spertAttrValue}</td>
											 <td data-t="${$(addspan2[z]).find('input').val()}">${$(addspan2[z]).text()}</td>
		                            		 <td><input class="num t-shi" name="wholesale_price" type="text"></td>
		                              	 <td><input class="num" name="wholesale_store_nums" type="text"></td>
		                             		 </tr>`);
													 }
												 }
											 }
										 }
									 }
								 }
							 }else if(uu==3){
								 var addspan1=$($('.right-ul1')[0]).find('span');
								 var addspan2=$($('.right-ul1')[1]).find('span');
								 if ($($('.right-ul1')[2]).find('span').length==snu){
									 if($($('.right-ul1')[2]).find('span').length==1){
										 var trt2=$($('.right-ul1')[2]).children('li:nth-child(1)').text();
										 $('.table-div table thead th:nth-child(2)').after(`<th data-t="${trt2}">${trt2}</th>`)
										 $('.table-div table tbody tr td:nth-child(2)').after(`<td data-t="${date[date.length-1].id}">${txt}</td>`)
										 $('.table-div table tfoot tr td:nth-child(1)').attr('colspan','3');
										 var nth1=$('.table-div table tbody tr td:nth-child(1)');
										 for(c=0;c<nth1.length;c++){
											 $(nth1[c]).find('input').val($(nth1[c]).find('input').val()+':'+date[date.length-1].id);
										 }
									 }else {
										 for (x=0;x<addspan1.length;x++){
											 for (z=0;z<addspan2.length;z++){
												 $('.table-div table tbody').append(`<tr><td data-t="${$(addspan1[x]).find('input').val()}">${$(addspan1[x]).text()}<input name="standard_id_str" type="hidden" value="${$(addspan1[x]).find('input').val()+':'+$(addspan2[z]).find('input').val()+':'+date[date.length-1].id}"></td><td data-t="${$(addspan2[z]).find('input').val()}">${$(addspan2[z]).text()}</td>
										 <td data-t="${date[date.length-1].id}">${txt}</td>
	                            		 <td><input class="num t-shi" name="wholesale_price" type="text"></td>
	                              	 <td><input class="num" name="wholesale_store_nums" type="text"></td>
	                             		 </tr>`);
											 }
										 }
									 }
								 }else {
									 if (snu==1){
										 var trt2=$($('.right-ul1')[2]).children('li:nth-child(1)').text();
										 $('.table-div table thead th:nth-child(2)').after(`<th data-t="${trt2}">${trt2}</th>`)
										 $('.table-div table tbody tr td:nth-child(2)').after(`<td data-t="${date[0].id}">${date[0].spertAttrValue}</td>`)
										 $('.table-div table tfoot tr td:nth-child(1)').attr('colspan','3');
										 var nth1=$('.table-div table tbody tr td:nth-child(1)');
										 for(c=0;c<nth1.length;c++){
											 $(nth1[c]).find('input').val($(nth1[c]).find('input').val()+':'+date[date.length-1].id);
										 }
										 for (x=0;x<addspan1.length;x++){
											 for (z=0;z<addspan2.length;z++){
												 for(s=1;s<date.length;s++){
													 $('.table-div table tbody').append(`<tr><td data-t="${$(addspan1[x]).find('input').val()}">${$(addspan1[x]).text()}<input name="standard_id_str" type="hidden" value="${$(addspan1[x]).find('input').val()+':'+$(addspan2[z]).find('input').val()+':'+date[s].id}"></td><td data-t="${$(addspan2[z]).find('input').val()}">${$(addspan2[z]).text()}</td>
												 <td data-t="${date[s].id}">${date[s].spertAttrValue}</td>
												 <td><input class="num t-shi" name="wholesale_price" type="text"></td>
											 <td><input class="num" name="wholesale_store_nums" type="text"></td>
												 </tr>`);
												 }
											 }
										 }
									 }else {
										 for (x=0;x<addspan1.length;x++){
											 for (z=0;z<addspan2.length;z++){
												 for(s=snu-1;s<date.length;s++){
													 $('.table-div table tbody').append(`<tr><td data-t="${$(addspan1[x]).find('input').val()}">${$(addspan1[x]).text()}<input name="standard_id_str" type="hidden" value="${$(addspan1[x]).find('input').val()+':'+$(addspan2[z]).find('input').val()+':'+date[s].id}"></td><td data-t="${$(addspan2[z]).find('input').val()}">${$(addspan2[z]).text()}</td>
												 <td data-t="${date[s].id}">${date[s].spertAttrValue}</td>
												 <td><input class="num t-shi" name="wholesale_price" type="text"></td>
											 <td><input class="num" name="wholesale_store_nums" type="text"></td>
												 </tr>`);
												 }
											 }
										 }
									 }
								 }

							 }
						 }
	                   $('.num').cbNum();
	                   $('.num1').cbNum();
	               }
	             });        
//            if(txt!=undefined){
//                //th=null;
//                if (uu==1){
//                    if(next.length!=0){
//                        for (i=0;i<next.length;i++){
//                            if(next1.length!=0){
//                                console.log('9')
//                                for (j=0;j<next1.length;j++){
//                                    html1=`<tr><td data-t="${txt}">${txt}</td><td data-tt="${$(next[i]).text()}">${$(next[i]).text()}</td>`;
//                                    html1+=`<td data-ttt="${$(next1[j]).text()}">${$(next1[j]).text()}</td><td><input class="num" type="text"></td>
//                                <td><input class="num" type="text"></td>
//                                <td><input class="num" type="text"></td>
//                                <td><input class="num" type="text"></td>
//                                <td><input class="num" type="text"></td>
//                                <td><a href="javascript:;">删除</a></td></tr>`;
//                                    $('table tbody').append(html1);
//                                }
//                            }else {
//                                html1=`<tr><td data-t="${txt}">${txt}</td><td data-tt="${$(next[i]).text()}">${$(next[i]).text()}</td>`;
//                                html1+=`<td><input class="num" type="text"></td>
//                                <td><input class="num" type="text"></td>
//                                <td><input class="num" type="text"></td>
//                                <td><input class="num" type="text"></td>
//                                <td><input class="num" type="text"></td>
//                                <td><a href="javascript:;">删除</a></td></tr>`;
//                                $('table tbody').append(html1);
//                            }
//
//                        }
//                    }else {
//                        html1=`<tr><td data-t="${txt}">${txt}</td><td><input class="num" type="text"></td>
//                                <td><input class="num" type="text"></td>
//                                <td><input class="num" type="text"></td>
//                                <td><input class="num" type="text"></td>
//                                <td><input class="num" type="text"></td>
//                                <td><a href="javascript:;">删除</a></td></tr>`;
//                        $('table tbody').append(html1);
//
//                    }
//
//
//                }else if (uu==2){
//                    if (next2.length!=0){
//                        var txt=addval($(this),th);
//                        var P=0;
//                        var O=0;
//                        if (next3.length!=0){
//                            for (i=0;i<next2.length;i++){
//                                var txt1=$(next2[i]).text();
//                                for (j=0;j<next3.length;j++){
//                                    html2=`<tr><td data-t="${txt1}">${txt1}</td><td data-tt="${txt}">${txt}</td><td data-ttt="${$(next3[j]).text()}">${$(next3[j]).text()}</td><td><input class="num" type="text"></td>
//                                <td><input class="num" type="text"></td>
//                                <td><input class="num" type="text"></td>
//                                <td><input class="num" type="text"></td>
//                                <td><input class="num" type="text"></td>
//                                <td><a href="javascript:;">删除</a></td></tr>`;
//                                    $($('tbody tr td[data-t='+txt1+']')[$('tbody tr td[data-t='+txt1+']').length-1]).parent().after(html2);
//
//                                }
//
//                                console.log('1')
//                            }
//                        }else {
//                            if(sib.length>0){
//                                for (i=0;i<next2.length;i++){
//                                    var txt1=$(next2[i]).text();
//                                    $($('tbody tr td[data-t='+txt1+']')[$('tbody tr td[data-t='+txt1+']').length-1]).parent().after(`<tr><td data-t="${txt1}">${txt1}</td><td data-tt="${txt}">${txt}</td><td><input class="num" type="text"></td>
//                                <td><input class="num" type="text"></td>
//                                <td><input class="num" type="text"></td>
//                                <td><input class="num" type="text"></td>
//                                <td><input class="num" type="text"></td>
//                                <td><a href="javascript:;">删除</a></td></tr>`)
//                                }
//                            }else {
//                                if ($('tbody tr').length!=0){
//                                    $($('tbody tr td:first-child')).after("<td data-tt="+txt+">"+txt+"</td>");
//                                    $('thead th:nth-child(1)').after(`<th>${$('.standard-right .right-ul1:nth-child(3) li:first-child').text()}</th>`);
//                                    $('tfoot td:first-child').attr('colspan','2');
//                                }else {
//                                    addtable();
//                                }
//
//                            }
//                        }
//
//                    }
//                }else if (uu==3){
//                    if (next2.length!=0){
//                        $('.guige').show();
//                        var txt=addval($(this),th);
//                        var rt='';
//                        if($('tbody tr').length!=0){
//                            if(sib.length>0){
//                                for (i=0;i<next4.length;i++){
//
//                                    for (j=0;j<next5.length;j++){
//                                        html3=`<tr><td data-t="${$(next4[i]).text()}">${$(next4[i]).text()}</td>`;
//                                        html3+=`<td data-tt="${$(next5[j]).text()}">${$(next5[j]).text()}</td><td data-ttt="${txt}">${txt}</td><td><input class="num" type="text"></td>
//                                <td><input class="num" type="text"></td>
//                                <td><input class="num" type="text"></td>
//                                <td><input class="num" type="text"></td>
//                                <td><input class="num" type="text"></td>
//                                <td><a href="javascript:;">删除</a></td></tr>`;
//                                        var ara=$(next5[j]).text();
//                                        rt+=html3;
//                                        console.log('6');
//
//                                        $($('tbody tr td[data-t='+$(next4[i]).text()+']').parent().find('td[data-tt='+ara+']')[$('tbody tr td[data-t='+$(next4[i]).text()+']').parent().find('td[data-tt='+ara+']').length-1]).parent().after(html3);
//
//
//                                        //debugger;
//                                    }
//                                }
//                            }else {
//                                addtable()
//                            }
//                        }else {
//                                for (i=0;i<next4.length;i++){
//
//                                    for (j=0;j<next5.length;j++){
//                                        html3=`<tr><td data-t="${$(next4[i]).text()}">${$(next4[i]).text()}</td>`;
//                                        html3+=`<td data-tt="${$(next5[j]).text()}">${$(next5[j]).text()}</td><td data-ttt="${txt}">${txt}</td><td><input class="num" type="text"></td>
//                                <td><input class="num" type="text"></td>
//                                <td><input class="num" type="text"></td>
//                                <td><input class="num" type="text"></td>
//                                <td><input class="num" type="text"></td>
//                                <td><a href="javascript:;">删除</a></td></tr>`;
//                                        $('tbody').append(html3)
//                                    }
//
//                                }
//
//                        }
//
//
//
//                    }
//                }
//            }

})
    function addval(a,b){
        if ( a.siblings('input').val()){
            var html=`<span>${a.siblings('input').val()}<b></b></span> <a href="javascript:;"><img src="${contextPath}/static/supplyshop/images/add-a.png" alt=""></a>`;
            b.parent().append(html);
            b.remove();


            $('.guige').hide();
            var txt=a.siblings('input').val();
            return txt;
        }
    }
       
    $('body').on('click','.guige-box-remove',function(){
        $('.guige').hide();
    })
});
function addtable(){
	var option1=$('.standard-right ul:nth-child(2) li:nth-child(1) input').val();
	var option2=$('.standard-right ul:nth-child(3) li:nth-child(1) input').val();
	var option3=$('.standard-right ul:nth-child(4) li:nth-child(1) input').val();
	var text1=$('.standard-right ul:nth-child(2) li:nth-child(1)').text();
	var text2=$('.standard-right ul:nth-child(3) li:nth-child(1)').text();
	var text3=$('.standard-right ul:nth-child(4) li:nth-child(1)').text();
    var span1=$('.standard-right ul:nth-child(2) span');
    var span2=$('.standard-right ul:nth-child(3) span');
    var span3=$('.standard-right ul:nth-child(4) span');
    var htm=`<table border="1">`;
    if(span3.length!=0){
    	if(span2.length==0&&span1.length!=0){
    		htm+=`<thead><th>${$('.standard-right ul:nth-child(2) li:first-child').text()}</th><th>${$('.standard-right ul:nth-child(4) li:first-child').text()}</th><th>批发价格（元）</th><th>库存数量</th></thead><tbody>`;
            for (i=0;i<span1.length;i++){
                    for (n=0;n<span3.length;n++){
                        htm+=`<tr><td data-t="${$(span1[i]).find('input').val()}">${$(span1[i]).text()}<input type="hidden" name="standard_id_str" value="${$(span1[i]).children('input').val()+':'+$(span3[n]).children('input').val()}"><input name="standard_value_str" type="hidden" value="${text1+':'+$(span1[i]).text()+';'+text3+':'+$(span3[n]).text()}"></td><td data-t="${$(span3[n]).find('input').val()}">${$(span3[n]).text()}</td><td><input class="num t-shi" name="wholesale_price"  type="text"></td>
                               
                                <td><input class="num" name="wholesale_store_nums" type="text"></td>
                                </tr>`;
                    }
            }
            htm+=`</tbody><tfoot class="tfoot">
                            <tr>
                                <td colspan="2">批量设置</td>
                                <td><input class="num1 t-shi" type="text" data-did="1"></td>
                                <td><input class="num1" type="text" data-did="5"></td>
                               
                            </tr>
                        </tfoot>
                    </table>`;
    	}else if(span1.length!=0&&span2.length!=0){
    		htm+=`<thead><th>${$('.standard-right ul:nth-child(2) li:first-child').text()}</th><th>${$('.standard-right ul:nth-child(3) li:first-child').text()}</th><th>${$('.standard-right ul:nth-child(4) li:first-child').text()}</th><th>批发价格（元）</th>th>库存数量</th></thead><tbody>`;
            for (i=0;i<span1.length;i++){
                for (j=0;j<span2.length;j++){
                    for (n=0;n<span3.length;n++){
                        htm+=`<tr><td data-t="${$(span1[i]).find('input').val()}">${$(span1[i]).text()}<input type="hidden" name="standard_id_str" value="${$(span1[i]).children('input').val()+':'+$(span2[j]).children('input').val()+':'+$(span3[n]).children('input').val()}"><input name="standard_value_str" type="hidden" value="${text1+':'+$(span1[i]).text()+';'+text2+':'+$(span2[j]).text()+';'+text3+':'+$(span3[n]).text()}"></td><td data-t="${$(span2[j]).find('input').val()}">${$(span2[j]).text()}</td><td data-t="${$(span3[n]).find('input').val()}">${$(span3[n]).text()}</td><td><input class="num t-shi" name="wholesale_price"  type="text"></td>
                                
                                <td><input class="num" name="wholesale_store_nums" type="text"></td>
                                </tr>`
                    }
                }
            }
            htm+=`</tbody><tfoot class="tfoot">
                            <tr>
                                <td colspan="3">批量设置</td>
                                <td><input class="num1 t-shi" type="text" data-did="1"></td>
                                
                                <td><input class="num1" type="text" data-did="5"></td>
                                
                            </tr>
                        </tfoot>
                    </table>`;
    	}else if(span2.length!=0&&span1.length==0){
    		htm+=`<thead><th>${$('.standard-right ul:nth-child(2) li:first-child').text()}</th><th>${$('.standard-right ul:nth-child(3) li:first-child').text()}</th><th>${$('.standard-right ul:nth-child(4) li:first-child').text()}</th><th>批发价格（元）</th><th>库存数量</th></thead><tbody>`;
            
                for (j=0;j<span2.length;j++){
                    for (n=0;n<span3.length;n++){
                        htm+=`<tr><td data-t="${$(span2[j]).find('input').val()}">${$(span2[j]).text()}</td><td data-t="${$(span3[n]).find('input').val()}">${$(span3[n]).text()}</td><td><input class="num t-shi" name="wholesale_price"  type="text"></td>
                                
                                <td><input class="num" name="wholesale_store_nums" type="text"></td>
                               </tr>`
                    }
                }
            
            htm+=`</tbody><tfoot class="tfoot">
                            <tr>
                                <td colspan="2">批量设置</td>
                                <td><input class="num1 t-shi" type="text" data-did="1"></td>
                                
                                <td><input class="num1" type="text" data-did="5"></td>
                                
                            </tr>
                        </tfoot>
                    </table>`;
    	}else if(span2.length==0&&span1.length==0){
    		htm+=`<thead><th>${$('.standard-right ul:nth-child(4) li:first-child').text()}</th><th>批发价格（元）</th><th>库存数量</th></thead><tbody>`;
           
                    for (n=0;n<span3.length;n++){
                        htm+=`<tr><td data-t="${$(span3[n]).find('input').val()}">${$(span3[n]).text()}</td><td><input class="num t-shi" name="wholesale_price"  type="text"></td>
                                
                                <td><input class="num" name="wholesale_store_nums" type="text"></td>
                               </tr>`
                    }
            
            htm+=`</tbody><tfoot class="tfoot">
                            <tr>
                                <td colspan="1">批量设置</td>
                                <td><input class="num1 t-shi" type="text" data-did="1"></td>
                                
                                <td><input class="num1" type="text" data-did="5"></td>
                               
                            </tr>
                        </tfoot>
                    </table>`;
    	}
        
        $('.table-div table').remove();
        $('.table-div').append(htm);
    }else {
        if (span2.length!=0){
            htm+=`<thead><th>${$('.standard-right ul:nth-child(2) li:first-child').text()}</th><th>${$('.standard-right ul:nth-child(3) li:first-child').text()}</th><th>批发价格（元）</th><th>库存数量</th></thead><tbody>`;
            for (i=0;i<span1.length;i++){
                for (j=0;j<span2.length;j++){
                    htm+=`<tr><td data-t="${$(span1[i]).find('input').val()}">${$(span1[i]).text()}<input name="standard_id_str" type="hidden" value="${$(span1[i]).children('input').val()+':'+$(span2[j]).children('input').val()}"><input type="hidden" name="standard_value_str" value="${text1+':'+$(span1[i]).text()+';'+text2+':'+$(span2[j]).text()}"></td><td data-t="${$(span2[j]).find('input').val()}">${$(span2[j]).text()}</td><td><input class="num t-shi" name="wholesale_price" type="text"></td>
		                    
		                    <td><input class="num" name="wholesale_store_nums" type="text"></td>
                           </tr>`
                }
            }
            htm+=`</tbody><tfoot class="tfoot">
                        <tr>
                            <td colspan="2">批量设置</td>
                            <td><input class="num1 t-shi" type="text" data-did="1"></td>
                            
                            
                            
                            <td><input class="num1" type="text" data-did="5"></td>
                           
                        </tr>
                    </tfoot>
                </table>`;
            $('.table-div table').remove();
            $('.table-div').append(htm);
        }else {
            htm+=`<thead><th>${$('.standard-right ul:nth-child(2) li:first-child').text()}</th><th>批发价格（元）</th><th>库存数量</th></thead><tbody>`;
            for (i=0;i<span1.length;i++){
                htm+=`<tr><td data-t="${$(span1[i]).find('input').val()}">${$(span1[i]).text()}<input name="standard_id_str" type="hidden" value="${$(span1[i]).children('input').val()}"><input name="standard_value_str" type="hidden" value="${text1+':'+$(span1[i]).text()}"></td><td><input class="num t-shi" name="wholesale_price" type="text"></td>
		                
		                
		                
		                <td><input class="num" name="wholesale_store_nums" type="text"></td>
                       </tr>`

            }
            htm+=`</tbody><tfoot class="tfoot">
                        <tr>
                            <td colspan="1">批量设置</td>
                            <td><input class="num1 t-shi" type="text" data-did="1"></td>
                            
                            
                            
                            <td><input class="num1" type="text" data-did="5"></td>
                           
                        </tr>
                    </tfoot>
                </table>`;
            $('.table-div table').remove();
            $('.table-div').append(htm);
        }
    }
}
function Trim(str,is_global)
{
    var result;
    result = str.replace(/(^\s+)|(\s+$)/g,"");
    if(is_global.toLowerCase()=="g")
    {
        result = result.replace(/\s/g,"");
     }
    return result;
}
