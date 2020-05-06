
$(function () {
   
    var expnum = /^1[345678]\d{9}$/; //验证手机输入格式
    // 点击按钮，发送验证码
    $("#sendMessageBtn").click(function () {

        if ($("#phoneNum").val() == "") {
            layer.msg("请输入手机号");
        }
       else if (!(/^1[3|5|6|7|8][0-9]\d{4,8}$/.test($("#phoneNum").val()))) {
            layer.msg("手机号格式不正确，请重新输入");
        } else if ($("#phoneNum").val().length < 11) {
            layer.msg("手机号格式不正确，请重新输入");
        } else {
            getsmsCode();
        }
    })

    //点击提交
    $("#submitBtn").click(function () {
        if ($("#account").val() == "" || $("#accountName").val() == "" || $("#bankName").val() == "" || $("#subbranchName").val() == "" || $("#phoneNum").val() == "" || $("#vCode").val() == "" || $("#idcard").val() == "") {
            layer.msg("请完善填写信息");
        }  else {
            addMyBankCard();
        }
    })

})


var timer;
var count = 60; //间隔函数
var curCount; //当前剩余秒数

function getsmsCode() {
    var ctxweb=$('#ctxweb').val();
    $.ajax({
        type: "POST",
        url: ctxweb+"/shop/pmUserBank/smsCode",
        data: {
            mobile: $.trim($("#phoneNum").val())
        },
        success: function (data) {
            if (data.code == "00") {
                curCount = count; //开始计时
                $("#sendMessageBtn").attr("disabled", "true");
                $("#sendMessageBtn").text("发送倒计时" + curCount + "秒");
                timer = window.setInterval(SetRemainTime, 1000); //启动计时器，1秒执行一次
            } else {
                layer.msg(data.msg);
            }
        }
    })
}

//timer处理函数
function SetRemainTime() {
    if (curCount == 0) {
        window.clearInterval(timer); //停止计时器
        $("#sendMessageBtn").removeAttr("disabled");
        $("#sendMessageBtn").text("获取验证码");
    } else {
        curCount--;
        $("#sendMessageBtn").text("发送倒计时" + curCount + "秒");
    }
}

//添加银行卡
function addMyBankCard() {
    var ctxweb=$('#ctxweb').val();
    var account= $.trim($("#account").val());
    var accountName= $.trim($("#accountName").val());
    var bankName=$.trim($("#bankName").val());
    var subbranchName= $.trim($("#subbranchName").val());
    var phoneNum= $.trim($("#phoneNum").val());
    var vCode= $.trim($("#vCode").val());
    var idcard=$.trim($("#idcard").val());
    $.ajax({
        url:  ctxweb+"/shop/pmUserBank/addMyBankCard",
        data: {
            account: account,
            accountName: accountName,
            bankName: bankName,
            subbranchName: subbranchName,
            phoneNum:phoneNum,
            vCode:vCode,
            idcard:idcard
        },
        type: 'post',
        beforeSend: function () {
            index = layer.load(2, {
                shade: [0.1, '#fff'] //0.1透明度的白色背景
            });
        },
        success: function (data) {
            layer.close(index);
            if (data.code == "00") {
                layer.msg("添加成功");
                setTimeout(function () {
                    var ctxweb=$('#ctxweb').val();
                    window.location.href = ctxweb+"/shop/pmUserBank/list";
                }, 200);
            } else {
                layer.msg(data.msg);
            }
        },

    });
}


//身份证校验
function chickCard() {
    var card = $("#identityCard").val();
    // 身份证号码为15位或者18位，15位时全为数字，18位前17位为数字，最后一位是校验位，可能为数字或字符X
    var reg = /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/;
    if (reg.test(card) === false) {
        layer.msg("身份证输入不合法");
        $("#identityCard").val("");
        return false;
    }
}

