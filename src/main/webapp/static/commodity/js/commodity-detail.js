$(function(){
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
                //火狐下，直接设img属性
                //imgObjPreview.style.display = 'block';
                //imgObjPreview.style.width = '150px';
                //imgObjPreview.style.height = '180px';
                //imgObjPreview.src = docObj.files[0].getAsDataURL();
                //火狐7以上版本不能用上面的getAsDataURL()方式获取，需要一下方式
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

    //买家付运费
    $('body').on('click','.logistics-li>div>input',function(){
        console.log($('.logistics-li:nth-child(2) ul')[0]);
        if ($('.maijia').attr('checked')&&$('.logistics-li:nth-child(2) ul')[0]==undefined){
            $('.logistics-li:nth-child(2)').append(`<ul class="maijia-ul">
                                <li>
                                    <div class="">
                                        <input name="money2" type="radio">
                                        <label>使用运费模板：</label>
                                        <select>
                                            <option value="">国家</option>
                                            <option value="">中国</option>
                                            <option value="">...</option>
                                        </select>
                                        <a href="javascript:;">查看运费模板</a>
                                    </div>
                                </li>
                                <li>
                                    <div class="">
                                        <input name="money2" type="radio">
                                        <label>快递</label>
                                        <input type="text">
                                        <span>元</span>
                                    </div>
                                </li>
                            </ul>`)
        }else if(!$('.maijia').attr('checked')){
            $('.maijia-ul').remove()
        }
    });
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
    $('body').on('click','.step2',function(){
        $('.content1').show();
        $('.content2').hide();
        $('.head-nav li:nth-child(1)').addClass('active').siblings().removeClass('active');
    })
    $('body').on('click','.step3',function(){
        //$(this).cbInput('step3');
        var sele=$('.content2 select');
        if($(this).cbInput('step3')==1){
            $('.yanzhen').show();
        }else {
            for (i=0;i<sele.length;i++){
               if ($(sele[i]).find('option:selected').val()==0){
                   $(sele[i]).css('border','1px solid #ff0000');
                   $('.yanzhen').show();
                   return;
               }
            }
            $('.content2 select').css('border','1px solid #dcdcdc');
            $('.content2').hide();
            $('.content3').show();
            $('.head-nav li:nth-child(3)').addClass('active').siblings().removeClass('active');
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
    $('body').on('click','.add-stan',function(){
        //得到select选中的内容
        var selist= $(this).closest('.standard-left').find('select');
        var selarr=[];
        for (i=0;i<selist.length;i++){
            selarr.push($(selist[i]).find("option:selected").text())
        }
        console.log(selarr);

        //添加规格
        if($('.standard-left ul').length<3){
            var html1=`<ul>
                        <li>二级规格：<a class="del-stan" href="javascript:;">(删除规格)</a></li>
                        <li>
                            <select>
                                <option value="0">尺寸</option>
                                <option value="1">s</option>
                            </select>
                        </li>
                    </ul>`;
            $('.standard-left').append(html1);
            var html2=`<ul class="right-ul1">
                        <li>
                            ${$('.standard-left ul:last-child select option:selected').text()}
                        </li>
                        <li>
                            <a href="javascript:;"><img src="images/add-a.png" alt=""></a>
                        </li>
                    </ul>`;
            $('.standard-right').append(html2);
            var trnum=$('.standard-right ul').length-1;
            $('table thead th:nth-child('+trnum+')').after('<th>'+$('.standard-left ul:last-child select option:selected').text()+'</th>');
            addtable()
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
    //删除规格
    $('body').on('click','.del-stan',function(){
        var num=$(this).closest('ul').index()+2;
        var num1=$(this).closest('ul').index()+1;
        $('.standard-right ul:nth-child('+num+')').remove();
        $(this).closest('ul').remove();
        $('table th:nth-child('+num1+')').remove();
        $('table tbody tr:nth-child('+num1+')').remove();
        addtable()
    });

    //删除tr
    $('body').on('click','.table-div tbody a',function(){
        $(this).closest('tr').remove();
    })

    $('.rangli input[type=radio]').click(function(){
       if($('.rang').is(':checked') ){
           $('.rang').siblings('label').html('让利<input class="num" type="text"><span>%</span> <b>（让利比范围10%~80%）</b>')
           $('.jiaspan').remove()
       }else {
           $('.rang').siblings('label').html('让利 <span class="jiaspan"></span>  <span>%</span> <b>（让利比范围10%~80%）</b>')
       }
    });

    //批量添加
    $('body').on('input propertychange','.tfoot input',function(){
        var did=$(this).attr('data-did');
        var val=$(this).val();

        var dtr=$('tbody tr');
        for (i=0;i<dtr.length;i++){
            $($(dtr[i]).find('input')[did-1]).val(val)
        }
    });
    //删除子规格
    $('body').on('click','.right-ul1  li b',function(){
        var ta=$(this).parent().text();
        var tnum=$(this).closest('ul').index();
        if(tnum==1){
            $('tbody td[data-t='+ta+']').parent().remove();
        }else if(tnum==2){
            $('tbody td[data-tt='+ta+']').parent().remove();
        }else if(tnum==3){
            $('tbody td[data-ttt='+ta+']').parent().remove();
        }

        $(this).parent().remove();
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
        $('.guige').show();
    });


        $('.guige .guige-box-add').click(function(){
            var txt=addval($(this),th);
            if(txt!=undefined){
                //th=null;
                if (uu==1){
                    if(next.length!=0){
                        for (i=0;i<next.length;i++){

                            if(next1.length!=0){
                                console.log('9')
                                for (j=0;j<next1.length;j++){
                                    html1=`<tr><td data-t="${txt}">${txt}</td><td data-tt="${$(next[i]).text()}">${$(next[i]).text()}</td>`;
                                    html1+=`<td data-ttt="${$(next1[j]).text()}">${$(next1[j]).text()}</td><td><input class="num" type="text"></td>
                                <td><input class="num" type="text"></td>
                                <td><input class="num" type="text"></td>
                                <td><input class="num" type="text"></td>
                                <td><input class="num" type="text"></td>
                                <td><a href="javascript:;">删除</a></td></tr>`;
                                    $('table tbody').append(html1);
                                }
                            }else {
                                html1=`<tr><td data-t="${txt}">${txt}</td><td data-tt="${$(next[i]).text()}">${$(next[i]).text()}</td>`;
                                html1+=`<td><input class="num" type="text"></td>
                                <td><input class="num" type="text"></td>
                                <td><input class="num" type="text"></td>
                                <td><input class="num" type="text"></td>
                                <td><input class="num" type="text"></td>
                                <td><a href="javascript:;">删除</a></td></tr>`;
                                $('table tbody').append(html1);
                            }

                        }
                    }else {
                        html1=`<tr><td data-t="${txt}">${txt}</td><td><input class="num" type="text"></td>
                                <td><input class="num" type="text"></td>
                                <td><input class="num" type="text"></td>
                                <td><input class="num" type="text"></td>
                                <td><input class="num" type="text"></td>
                                <td><a href="javascript:;">删除</a></td></tr>`;
                        $('table tbody').append(html1);

                    }


                }else if (uu==2){
                    if (next2.length!=0){
                        var txt=addval($(this),th);
                        var P=0;
                        var O=0;
                        if (next3.length!=0){
                            for (i=0;i<next2.length;i++){
                                var txt1=$(next2[i]).text();
                                for (j=0;j<next3.length;j++){
                                    html2=`<tr><td data-t="${txt1}">${txt1}</td><td data-tt="${txt}">${txt}</td><td data-ttt="${$(next3[j]).text()}">${$(next3[j]).text()}</td><td><input class="num" type="text"></td>
                                <td><input class="num" type="text"></td>
                                <td><input class="num" type="text"></td>
                                <td><input class="num" type="text"></td>
                                <td><input class="num" type="text"></td>
                                <td><a href="javascript:;">删除</a></td></tr>`;
                                    $($('tbody tr td[data-t='+txt1+']')[$('tbody tr td[data-t='+txt1+']').length-1]).parent().after(html2);

                                }

                                console.log('1')
                            }
                        }else {
                            if(sib.length>0){
                                for (i=0;i<next2.length;i++){
                                    var txt1=$(next2[i]).text();
                                    $($('tbody tr td[data-t='+txt1+']')[$('tbody tr td[data-t='+txt1+']').length-1]).parent().after(`<tr><td data-t="${txt1}">${txt1}</td><td data-tt="${txt}">${txt}</td><td><input class="num" type="text"></td>
                                <td><input class="num" type="text"></td>
                                <td><input class="num" type="text"></td>
                                <td><input class="num" type="text"></td>
                                <td><input class="num" type="text"></td>
                                <td><a href="javascript:;">删除</a></td></tr>`)
                                }
                            }else {
                                if ($('tbody tr').length!=0){
                                    $($('tbody tr td:first-child')).after("<td data-tt="+txt+">"+txt+"</td>");
                                    $('thead th:nth-child(1)').after(`<th>${$('.standard-right .right-ul1:nth-child(3) li:first-child').text()}</th>`);
                                    $('tfoot td:first-child').attr('colspan','2');
                                }else {
                                    addtable();
                                }

                            }
                        }

                    }
                }else if (uu==3){
                    if (next2.length!=0){
                        $('.guige').show();
                        var txt=addval($(this),th);
                        var rt='';
                        if($('tbody tr').length!=0){
                            if(sib.length>0){
                                for (i=0;i<next4.length;i++){

                                    for (j=0;j<next5.length;j++){
                                        html3=`<tr><td data-t="${$(next4[i]).text()}">${$(next4[i]).text()}</td>`;
                                        html3+=`<td data-tt="${$(next5[j]).text()}">${$(next5[j]).text()}</td><td data-ttt="${txt}">${txt}</td><td><input class="num" type="text"></td>
                                <td><input class="num" type="text"></td>
                                <td><input class="num" type="text"></td>
                                <td><input class="num" type="text"></td>
                                <td><input class="num" type="text"></td>
                                <td><a href="javascript:;">删除</a></td></tr>`;
                                        var ara=$(next5[j]).text();
                                        rt+=html3;
                                        console.log('6');

                                        $($('tbody tr td[data-t='+$(next4[i]).text()+']').parent().find('td[data-tt='+ara+']')[$('tbody tr td[data-t='+$(next4[i]).text()+']').parent().find('td[data-tt='+ara+']').length-1]).parent().after(html3);


                                        //debugger;
                                    }
                                }
                            }else {
                                addtable()
                            }
                        }else {
                                for (i=0;i<next4.length;i++){

                                    for (j=0;j<next5.length;j++){
                                        html3=`<tr><td data-t="${$(next4[i]).text()}">${$(next4[i]).text()}</td>`;
                                        html3+=`<td data-tt="${$(next5[j]).text()}">${$(next5[j]).text()}</td><td data-ttt="${txt}">${txt}</td><td><input class="num" type="text"></td>
                                <td><input class="num" type="text"></td>
                                <td><input class="num" type="text"></td>
                                <td><input class="num" type="text"></td>
                                <td><input class="num" type="text"></td>
                                <td><a href="javascript:;">删除</a></td></tr>`;
                                        $('tbody').append(html3)
                                    }

                                }

                        }



                    }
                }
            }

})
    function addval(a,b){
        if ( a.siblings('input').val()){
            var html=`<span>${a.siblings('input').val()}<b></b></span> <a href="javascript:;"><img src="images/add-a.png" alt=""></a>`;
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

    function addtable(){
        var span1=$('.standard-right ul:nth-child(2) span');
        var span2=$('.standard-right ul:nth-child(3) span');
        var span3=$('.standard-right ul:nth-child(4) span');
        var htm=`<table border="1">`;
        if(span3.length!=0){
            htm+=`<thead><th>${$('.standard-right ul:nth-child(2) li:first-child').text()}</th><th>${$('.standard-right ul:nth-child(3) li:first-child').text()}</th><th>${$('.standard-right ul:nth-child(4) li:first-child').text()}</th><th>市场价格（元）</th><th>本店价格（元）</th><th>让利比例（%）</th><th>结算价格（元）</th><th>库存数量</th><th>操作</th></thead><tbody>`;
            for (i=0;i<span1.length;i++){
                for (j=0;j<span2.length;j++){
                    for (n=0;n<span3.length;n++){
                        htm+=`<tr><td data-t="${$(span1[i]).text()}">${$(span1[i]).text()}</td><td data-tt="${$(span2[j]).text()}">${$(span2[j]).text()}</td><td data-ttt="${$(span3[n]).text()}">${$(span3[n]).text()}</td><td><input class="num" type="text"></td>
                                <td><input class="num" type="text"></td>
                                <td><input class="num" type="text"></td>
                                <td><input class="num" type="text"></td>
                                <td><input class="num" type="text"></td>
                                <td><a href="javascript:;">删除</a></td></tr>`
                    }
                }
            }
            htm+=`</tbody><tfoot class="tfoot">
                            <tr>
                                <td colspan="3">批量设置</td>
                                <td><input class="num" type="text" data-did="1"></td>
                                <td><input class="num" type="text" data-did="2"></td>
                                <td><input class="num" type="text" data-did="3"></td>
                                <td><input class="num" type="text" data-did="4"></td>
                                <td><input class="num" type="text" data-did="5"></td>
                                <td><a href="javascript:;">删除</a></td></td>
                            </tr>
                        </tfoot>
                    </table>`;
            $('.table-div table').remove();
            $('.table-div').append(htm);
        }else {
            if (span2.length!=0){
                htm+=`<thead><th>${$('.standard-right ul:nth-child(2) li:first-child').text()}</th><th>${$('.standard-right ul:nth-child(3) li:first-child').text()}</th><th>市场价格（元）</th><th>本店价格（元）</th><th>让利比例（%）</th><th>结算价格（元）</th><th>库存数量</th><th>操作</th></thead><tbody>`;
                for (i=0;i<span1.length;i++){
                    for (j=0;j<span2.length;j++){
                        htm+=`<tr><td data-t="${$(span1[i]).text()}">${$(span1[i]).text()}</td><td data-tt="${$(span2[j]).text()}">${$(span2[j]).text()}</td><td><input class="num" type="text"></td>
                               <td><input class="num" type="text"></td>
                               <td><input class="num" type="text"></td>
                               <td><input class="num" type="text"></td>
                               <td><input class="num" type="text"></td>
                               <td><a href="javascript:;">删除</a></td></tr>`
                    }
                }
                htm+=`</tbody><tfoot class="tfoot">
                            <tr>
                                <td colspan="2">批量设置</td>
                                <td><input class="num" type="text" data-did="1"></td>
                                <td><input class="num" type="text" data-did="2"></td>
                                <td><input class="num" type="text" data-did="3"></td>
                                <td><input class="num" type="text" data-did="4"></td>
                                <td><input class="num" type="text" data-did="5"></td>
                                <td><a href="javascript:;">删除</a></td></td>
                            </tr>
                        </tfoot>
                    </table>`;
                $('.table-div table').remove();
                $('.table-div').append(htm);
            }else {
                htm+=`<thead><th>${$('.standard-right ul:nth-child(2) li:first-child').text()}</th><th>市场价格（元）</th><th>本店价格（元）</th><th>让利比例（%）</th><th>结算价格（元）</th><th>库存数量</th><th>操作</th></thead><tbody>`;
                for (i=0;i<span1.length;i++){
                    htm+=`<tr><td data-t="${$(span1[i]).text()}">${$(span1[i]).text()}</td><td><input class="num" type="text"></td>
                            <td><input class="num" type="text"></td>
                            <td><input class="num" type="text"></td>
                            <td><input class="num" type="text"></td>
                            <td><input class="num" type="text"></td>
                            <td><a href="javascript:;">删除</a></td></tr>`

                }
                htm+=`</tbody><tfoot class="tfoot">
                            <tr>
                                <td colspan="1">批量设置</td>
                                <td><input class="num" type="text" data-did="1"></td>
                                <td><input class="num" type="text" data-did="2"></td>
                                <td><input class="num" type="text" data-did="3"></td>
                                <td><input class="num" type="text" data-did="4"></td>
                                <td><input class="num" type="text" data-did="5"></td>
                                <td><a href="javascript:;">删除</a></td></td>
                            </tr>
                        </tfoot>
                    </table>`;
                $('.table-div table').remove();
                $('.table-div').append(htm);
            }
        }
    }


});