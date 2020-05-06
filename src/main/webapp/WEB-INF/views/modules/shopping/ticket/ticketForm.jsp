<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title></title>
    <script type="text/javascript">
        // 显示弹框
        function show() {
            $('#modal-overlays').css("display","block");
        }
        // 隐藏弹框
        function hide() {
            $('#modal-overlays').css("display","none");
        }
        //确定
        function submit() {
            var modelName=$("#modelName").val();
            var raType=$('input:radio[name="type"]:checked').val();
            if(modelName==''){
                alert('请输入小票模板名称');
                return;
            }
            var text=$(".text").val();
            var size=$('input:radio[name="radio"]:checked').val();
            if(size==0){
                size=58;
            }else if(size==1){
                size=80;
            }
            var dibu=$("#dibu").val();
            var name=$("#name").val();
            var templateText='';
            if(type=="高级设置"){
               templateText=text;
            }else if(type=="快捷设置"){
                templateText=name+"\n\n"+$("#templateText").val()+"\n"+dibu;
            }
            $.ajax({
                type : "POST",
                url : "${ctxsys}/ticket/insertTicket", //请求的url地址
                data:{modelName:modelName,size:size,templateText:templateText,type:raType},
                success : function(data) {
                    if(data.code=='00'){
                        hide();
                        alert("添加成功！");
                        window.location.href="${ctxsys}/ticket/ticketList";
                    }
                }
            });
        }

    </script>
    <style>
        .close{
            position:relative;
            width:2px;
            height:15px;
            background: #808080;
            -webkit-transform: rotate(45deg);
            -moz-transform: rotate(45deg);
            -o-transform: rotate(45deg);
            -ms-transform: rotate(45deg);
            transform: rotate(45deg);
            display: inline-block;
            position: absolute;
            right:15px;
            top:5px;
            cursor: pointer;
        }
        .close:after{
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            width:2px;
            height:15px;
            background: #808080;
            -webkit-transform: rotate(270deg);
            -moz-transform: rotate(270deg);
            -o-transform: rotate(270deg);
            -ms-transform: rotate(270deg);
            transform: rotate(270deg);
            cursor: pointer;
        }
        *{margin:0;padding:0;}
        .left{float: left;}
        .right{float: right;}
        .clearfix:before,.clearfix:after {display: table; content: " ";}
        .clearfix:after { clear: both;}
        .clearfix{*zoom: 1;}
        .right-title{width:100%;border:1px solid #e5e5e5;}
        .right-title ul li{float:left;height:30px;line-height:30px;width:47%;list-style: none;text-align: center;font-size: 13px;cursor: pointer;}
        .right-title ul li:first-child{margin-right:0%;}
        .right-title ul .active{background:#08d;color:#fff;transition:.3s;}
        .right-box{width:365px;border-left:1px solid #e5e5e5;padding:0 15px;}
        .left-box{width:378px;}
        .contentbox{position: relative;}
        .radiobox .left{width:50%;}
        .radiobox .radio{width: 30px;position: relative;top:4px;cursor: pointer;}
        .radiobox .left label{display: block;}
        .radiobox .left label:last-child{font-size:12px;color:#999;}
        .radiobox p,.contentbox p{line-height: 50px;}
        .contentbox textarea{width:90%;height:100px;border:1px solid #e5e5e5;padding:10px;font-size: 14px;}
        .body{width:800px;margin:20px auto;}
        .demo-mod{height:400px;border:1px solid #e5e5e5;padding:5px;}
        .dictionaries{position: absolute;right:-50px;top:50px;width:30px;height:97px;border:1px solid #e5e5e5;background:#eee;text-align: center;padding-top:7px; cursor: pointer;}
        .dictionaries1{width:180px;position: absolute;right:-199px;top:50px;border:1px solid #ccc;z-index: 999;}
        .dictionaries1 h5{height:30px;line-height:30px;background:#f4f4f4;padding-left:15px;}
        .dictionaries1-con {height:300px;overflow: auto;}
        .dictionaries1-con p{line-height:30px;margin-top:0;border-bottom:1px solid #ccc;padding-left:15px;font-size: 13px;}
        .dictionaries1-con p:last-child{border-bottom:0;}
        .preview{background:#f3f3f3;height:610px;}
        .preview1{width:264px;height:99%;margin:0 auto;}
        .left-box p{text-align: center;line-height: 50px;}
        .preview2{width:100%;height:99%;margin:0 auto;padding-left: 12px;}
        .preview-con,.contentbox{display:none;}
        .dictionaries1{display: none;}
        .title-con{height:50px;line-height:50px;border-bottom:1px solid #ccc;text-align: center;font-size: 15px;}
        .save-box{border-top:1px solid #e5e5e5;margin-top:30px;}
        .save-box button{cursor:pointer;background:#08d;transition:.3s;width:92px;height:40px;padding:0;line-height:40px;color:#fff;float:right;margin-top:30px;}
        .button {
            background-color: #4CAF50; /* Green */
            border: none;
            color: white;
            padding: 15px 32px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            margin: 4px 2px;
            cursor: pointer;
        }
        .button2 {background-color: #008CBA;} /* Blue */

        a{
            color: #009688;
        }

        a:hover{
            color: #009688;
        }

        #btnSubmit{
            background: #393D49;
        }
    </style>
    <style>
        /* 定义模态对话框外面的覆盖层样式 */
        #modal-overlays {
            display: none;
            position: absolute; /* 使用绝对定位或固定定位  */
            left: 0px;
            top: 0px;
            width: 100%;
            height: 1000px;
            text-align: center;
            z-index: 1000;
            background-color: #3333;
            cursor:pointer;
        }

        /* 模态框样式 */
        .modal-data {
            width: 200px;
            height:130px;
            margin: 250px auto;
            background-color: #fff;
            border: 1px solid #000;
            border-color: #ffff;
            padding: 15px;
            text-align: center;
            cursor:pointer;
        }
        input[type="button"]:focus{outline:none;}
        .mod1:focus{outline:none;}
        .mod2:focus{outline:none;}
    </style>
</head>
<body style="background-color: #ffffff">

<input type="hidden" id="ctxweb" value="${ctxweb}">
<input type="hidden" value="${ebRecommend.templateText}" id="templateText">
<div class="title-con">收银小票模版设置</div>
<div class="clearfix body">
    <div class="left-box left">
        <p>预览<input type="button" class="button" style="cursor:pointer; width:30px; height:30px;position: relative;
                top:-4px; border:0; background:url('${ctxStatic}/images/update.png') no-repeat left top"></p>
        <div class="preview">
            <div class="preview1 preview-con" style="display: block;">
                <textarea class="mod1" style="border: 0;padding-top:20px;background: url('${ctxStatic}/images/xiaopiaobeijing2.png')center center;background-size:100% 100%;
                        margin: 0px;resize:none; width: 262px; height: 604px;    padding-top: 45px;
                        padding-left: 10px;
                        padding-right: 10px;" readonly="readonly">模板1</textarea>
            </div>
            <div class="preview2 preview-con">
                <textarea class="mod2" style="border: 0;padding-top:20px;background: url('${ctxStatic}/images/xiaopiaobeijing2.png')center center;background-size:100% 100%;
                        margin: 0px; resize:none; width: 336px; height: 602px;   padding-top: 45px; padding-left: 10px;
                        padding-right: 10px;" readonly="readonly">模板2</textarea>
            </div>
        </div>

    </div>


    <div class="right-box right">
        <div class="right-title">
            <ul class="clearfix" style="width: 390px">
                <li var="快捷设置" class="active">快捷设置</li>
                <li var="高级设置">高级设置</li>
            </ul>
        </div>

        <div class="clearfix radiobox">
            <p>小票规格</p>
            <div class="left  clearfix">
                <input type="radio" class="left radio" name="radio" value="0" checked="checked" />
                <div class="left"> <label>58mm</label>
                    <label>每行16个汉字</label> </div>
            </div>

            <div class="left clearfix">
                <input type="radio" class="left radio" name="radio" value="1" />
                <div class="left"> <label>80mm</label>
                    <label>每行24个汉字</label></div>
            </div>
        </div>
        <div class="clearfix radiobox">
            <p>模板类型</p>
            <div class="left  clearfix">
                <input type="radio" class="left radio" name="type" value="1" checked="checked" />
                <div class="left"> <label>收银留底</label>
                    <label>收银留底</label> </div>
            </div>

            <div class="left clearfix">
                <input type="radio" class="left radio" name="type" value="2" />
                <div class="left"> <label>外卖配送</label>
                    <label>外卖配送</label></div>
            </div>
        </div>
        <div>
            <div class="contentbox" style="display: block;">
                <div>
                    <p>小票头部标题</p>
                    <textarea style="resize:none;" id="name">&{店名}</textarea>
                </div>
                <div>
                    <p>小票底部文本</p>
                    <textarea style="resize:none;" id="dibu">谢谢惠顾，欢迎下次光临！</textarea>
                </div>
            </div>

            <div class="contentbox">
                <div>
                    <p>小票模版内容</p>
                    <div class="demo-mod"><textarea class="text" style="margin: 0px;resize:none; height: 439px; width: 347px;">${ebRecommend.templateText}</textarea></div>
                </div>
                <div class="dictionaries">参考字典</div>
                <div class="dictionaries1">
                    <h5>参考字典 <span class="close"></span></h5>
                    <div class="dictionaries1-con">
                    </div>
                </div>
            </div>
        </div>
        <div class="save-box">
            <button class="submit">保存</button>
        </div>
    </div>
</div>
<div id="modal-overlays">
    <div class="modal-data">
        <div class="msg-btn">
            <label id="title" style="margin-top:10px;">请输入小票模板名称</label>
            <input type="text" id="modelName" style="margin-top:10px; width: 90%;
    border: 1px solid #e5e5e5;
    padding: 10px;
    font-size: 14px;">
        </div>
        <div class="msg-btn">
            <a onclick="submit()" style="background-color:#4778C7;width:50px;height:30px;line-height:30px;color:#fff;margin-top:20px;display: inline-block;">保存</a>
            <a onclick="hide()" style="background-color:#999;width:50px;height:30px;line-height:30px;color:#fff;margin-top:20px;display: inline-block;">取消</a>
        </div>
    </div>
</div>
<script src="${ctxStatic}/sbShop/js/jquery.min.js"></script>

<script>
    var type="快捷设置";
    var ctxweb=$("#ctxweb").val();
    function EbDictionaries(v){
        $(".text").val($(".text").val()+"&{"+v+"}");
    }
    $.ajax({
        type : "POST",
        url : "${ctxsys}/ticket/getEbDictionaries", //请求的url地址
        success : function(data) {
            var str="";
            $.each(data.obj,function(index,item){
                str+="<p onclick=EbDictionaries('"+item.name+"')>"+item.name+"</p>";
            });
            $(".dictionaries1-con").append(str);
        }
    });
    $(".submit").click(function(){
        show();
    });
    $(".radio").click(function(){
        var val=$('input:radio[name="radio"]:checked').val();
        if(val==0){
            $(".mod1").val($(".mod2").val());
        }else if(val==1){
            $(".mod2").val($(".mod1").val());
        }
    });
    function replace(){
        var dibu=$("#dibu").val();
        var name=$("#name").val();
        var templateText='';
        if(type=="高级设置"){
            templateText=$(".text").val();
        }else if(type=="快捷设置"){
            templateText=name+"\n\n"+$("#templateText").val()+"\n\n"+dibu;
        }
        $.ajax({
            type : "POST",
            url : "${ctxsys}/ticket/replace", //请求的url地址
            data:{templateText:templateText},
            success : function(data) {
                $(".mod1").val(data.obj.templateText);
                $(".mod2").val(data.obj.templateText);
            }
        });
    }


    $(".button").click(function(){
        replace();
    });
    $(".right-title li").click(function() {
        $(this).addClass("active").siblings().removeClass("active");
        var index = $(this).index();
        $(".contentbox").eq(index).show().siblings().hide();
        type =$(this).attr("var");
    })
    $('input[type=radio][name=radio]').change(function() {
        if ($(this).prop('checked')) {
            var checkVal = $(this).val();
            $(".preview-con").eq(checkVal).show().siblings().hide();
        }
    })
    $(".dictionaries").click(function(){
        $(".dictionaries1").show();
        $(".dictionaries").hide();
    })
    $(".close").click(function(){
        $(".dictionaries1").hide();
        $(".dictionaries").show();
    })
    replace();
</script>
</body>
</html>
