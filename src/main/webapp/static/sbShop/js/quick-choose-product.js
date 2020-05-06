function writable(a,va){
    $("#ids").val(a);
    var html="";
    $.ajax({
        type: "POST",
        url: "${ctxsys}/Product/classOne",
        data: {"type":"1"},
        success: function(data){
            for(var i=0;i<data.length;i++){
                if(va!=null){
                    var strs= new Array();
                    strs= va.split(",");
                    if(strs!=null){
                        html+="<li class='checkbox'><input type='checkbox' name='tag' value='"+data[i].id+"'";
                        for(var j=0;j<strs.length;j++){
                            if(strs[j]==data[i].id){
                                html+="  checked='checked'  ";
                            }
                        }
                        html+="><label><i></i>"+data[i].name+"</label></li>";
                    }
                }
            }
            $(".mn").html(html);
        }
    });
    $('.check').show();
}
function sbmit(){
    $("#fromsb").submit();

}

function eblabelLs(){
    $.ajax({
        type: "POST",
        url: "${ctxsys}/EbLabel/eblabelLs",
        data: {},
        success: function(data){
            var html='<option value="">全部</option>';
            var productTagname="${productTags}";
            for(var i=0;i<data.length;i++){
                if(productTagname==data[i].name){
                    html+="<option value="+data[i].name+" selected='selected'>"+data[i].name+"</option>";
                }else{
                    html+="<option value="+data[i].name+">"+data[i].name+"</option>";
                }
            }
            $("#productTags").html(html);
        }
    });
}





function loke(vals,id,price,img,redweb,marketPrice,sale,poorTotal,middleTotal,goodTotal){
    window.opener.document.getElementById('advertiseTypeObjIds').value=id;
    if(window.opener.document.getElementById('price')!=null||window.opener.document.getElementById('price')!=undefined){
        window.opener.document.getElementById('price').innerHTML=price;
    }
    if(window.opener.document.getElementById('prices')!=null||window.opener.document.getElementById('prices')!=undefined){
        window.opener.document.getElementById('prices').innerHTML=price;
    }
    var poor = poorTotal == null ? 0 :poorTotal;
    var middle = middleTotal== null ? 0 : middleTotal;
    var good = goodTotal == null ? 0 : goodTotal;
    var all = poor + middle + good;
    var ty = 0;
    if (all != 0) {
        ty = Double.valueOf(good) / Double.valueOf(all);
    }
    if(window.opener.document.getElementById('saleValue')!=null||window.opener.document.getElementById('saleValue')!=undefined){
        window.opener.document.getElementById('saleValue').innerHTML=ty;
    }
    if(window.opener.document.getElementById('marketPrice')!=null||window.opener.document.getElementById('marketPrice')!=undefined){
        window.opener.document.getElementById('marketPrice').innerHTML=marketPrice;
    }
    if(window.opener.document.getElementById('sale')!=null||window.opener.document.getElementById('sale')!=undefined){
        window.opener.document.getElementById('sale').innerHTML=sale;
    }
    if(window.opener.document.getElementById('pname')!=null||window.opener.document.getElementById('pname')!=undefined){
        window.opener.document.getElementById('pname').innerHTML=vals;
    }
    if(window.opener.document.getElementById('imgsval')!=null||window.opener.document.getElementById('imgsval')!=undefined){
        window.opener.document.getElementById('imgsval').src=""+img.split("|")[0];
    }
    if(window.opener.document.getElementById('pname')!=null||window.opener.document.getElementById('pname')!=undefined){
        window.opener.document.getElementById('pname').innerHTML=vals;
        window.opener.document.getElementById('pname').title=vals;
    }
    if(window.opener.document.getElementById('redweb')!=null||window.opener.document.getElementById('redweb')!=undefined){
        window.opener.document.getElementById('redweb').innerHTML=redweb;
    }

    window.open("about:blank","_self").close();
}
