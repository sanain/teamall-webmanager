$(function(){
    //下面用于多图片上传预览功能
    function setImagePreviews(avalue) {
        var docObj = avalue;
        var dd = $(avalue).parent().siblings('.left-img');
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
    $('.fit-right input[type=file]').change(function(){
        setImagePreviews(this);
    })

    $('.fil-del').click(function(){
        $(this).parent().siblings('.left-img').html('')
    });
})
