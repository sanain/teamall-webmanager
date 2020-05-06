
$(function () {
    $('#amt').val('');
    $('#payPassword').val('');
    //点击提交
    $("#submitBtn").click(function () {
        if ($("#amt").val() == "" || $("#pmUserBanks").val() == "") {
            layer.msg("请完善填写信息");
        }  else {
            applyToCash();
        }
    })

})


//提现申请
function applyToCash() {
    debugger;
    var ctxweb=$('#ctxweb').val();
    var amt= $.trim($("#amt").val());
    var bankCardId= $.trim($("#pmUserBanks").val());
    var payPassword=$('#payPassword').val();
    $.ajax({
        url:  ctxweb+"/shop/shopPmAmtLog/applyToCash",
        data: {
            amt: amt,
            payPassword: payPassword,
            bankCardId: bankCardId
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
                layer.msg(data.msg);
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

