CKEDITOR.dialog.add( 'datepicker', function( editor )    
{    
    return {     
        title : '商品卡片',    
        minWidth : 300,    
        minHeight : 150,    
        contents : [    
            {    
            id: 'tab1',  
            label: '',  
            title: '',     
                elements :    
                [    
                    {      //.Wdate{border: #999 1px solid;height: 20px;background: #fff url('+'../images/datePicker.gif) no-repeat right;}onfocus="WdatePicker({dateFmt:\'yyyy-MM-dd HH:mm:ss\'})"
                    	type: 'html',  
                    	html:'<style> .article-box {overflow:hidden;background: #ffffff;padding: 15px;position:relative;width:300px;height:100px;}.article-box>img{width:40%;float:left}.article-box>p{white-space: normal;width:58%;position:absolute;top:10px;right:15px;float:right;}.article-box div{position:absolute;width:58%;bottom:13px;right:15px;}.article-box div i{color: #DC713D;margin-right: 1%;}.article-box div b{font-size: 0.34rem;marhin-left:5px;color: #AAA590;font-weight: normal;background: url("http://pmsc.5g88.com/static/ckeditor/plugins/linkbutton/dialogs/shanbao1.png") no-repeat center left;background-size: 40%;display: inline-block;padding-left: 15px;}.article-box div p{float: right;color: #ffffff;background: #FF0000;border-radius: 38px;text-align: center;height: 25px;line-height: 25px;padding:0 10px;text-decoration: none;font-size: 0.34rem}</style><div class="article-box"><img id="imgsval"  src="http://pmsc.5g88.com/uploads/4_1/images/shopImg/2017/05/293b970909a944fcaf5afbc7cb820966.png" alt=""><input type="hidden" id="advertiseTypeObjIds"><p id="pname">UR2017春夏新款魅力女装V领袖简约百搭T恤WB10B4D</p><div><i style="color:dc713d;"><i id="prices">¥109</i><i id="saleValue" style="display:none">¥109</i><i id="sale" style="display:none">¥109</i><i id="marketPrice" style="display:none">¥109</i></i><b id="redweb" style="display:none">83</b><p style="float: right;color: #ffffff;background: #FF0000;border-radius: 38px;text-align: center;height: 25px;line-height: 25px;padding:0 10px;text-decoration: none;font-size: 0.34rem">去购买</p></div></div><a class="elect-show" style="display:inline-block;height:30px;line-height:30px;padding:0 15px;color:#666;background:#fff;border-radius:3px;margin-top:10px;float:right;" href="javascript:;">选择</a></div>'
	
				   }    
                ]    
            }    
        ],  
         onOk: function(){
        	 // CKEDITOR.dom.element.createFromHtml('<div><style> .article-box {overflow:hidden;background: #ffffff;padding: 15px;position:relative}.article-box>img{width:39%;float:left}.article-box>p{width:58%;position:absolute;top:20px;right:0;float:right;overflow: hidden;text-overflow: ellipsis;white-space: nowrap;word-wrap: break-word;}.article-box div{position:absolute;width:58%;bottom:13px;right:0;}.article-box div i{color: #DC713D;margin-right: 10px}.article-box div b{font-size: 0.24rem;color: #AAA590;font-weight: normal;background: url("../images/shanbao1.png") no-repeat center left;background-size: 40%;display: inline-block;padding-left: 13px}.article-box div a{margin-right:20px;float: right;color: #ffffff;background: #FF0000;border-radius: 38px;text-align: center;height: 25px;line-height: 25px;padding:0 10px;text-decoration: none;font-size: 12px}</style><div class="article-box"><img id="imgsval"  src="http://localhost:8080/sbsc-webmanager/uploads/000000/images/merchandise/ebAdvertise/2017/06/396f959f2c9f4e75af04f1e5e25611e9.jpg" alt=""><input type="hidden" id="advertiseTypeObjId"><p id="pname">UR2017春夏新款魅力女装V领袖简约百搭T恤WB10B4D</p><div><i>¥&nbsp;<i id="price">109</i></i><b>83</b><a href="javascript:;">去购买</a></div></div></div></div>')
        	 //editor.insertHtml('<div><div class="article-box" style="overflow:hidden;background: #ffffff;padding: 15px;position:relative;width:300px;height:100px"><img id="imgsval" style="width:40%;float:left;"  src="'+document.getElementById('imgsval').src+'" alt=""><input type="hidden" id="advertiseTypeObjId" value="'+document.getElementById('advertiseTypeObjIds').value+'"><p style="white-space: normal;width:58%;position:absolute;top:0;right:0;float:right;" id="pname">'+document.getElementById('pname').innerHTML+'</p><div style="position:absolute;width:58%;bottom:13px;right:0;"><i style="color:dc713d;"><i id="price" style="color: #DC713D;margin-right: 1%;"> ¥'+document.getElementById('prices').innerHTML+'</i></i><b style="font-size: 0.34rem;margin-left:5px;color: #AAA590;font-weight: normal;background: url(http://pmsc.5g88.com/static/ckeditor/plugins/linkbutton/dialogs/shanbao1.png) no-repeat center left;background-size: 40%;display: inline-block;padding-left: 15px;">'+document.getElementById('redweb').innerHTML+'</b><p style="float: right;color: #ffffff;background: #FF0000;border-radius: 38px;text-align: center;height: 25px;line-height: 25px;padding:0 10px;text-decoration: none;font-size: 0.34rem" onclick="jsobject.clickWareId('+document.getElementById('advertiseTypeObjIds').value+')">去购买</p></div></div></div></div>')
        	 editor.insertHtml('<script>'
   +'function callJS(advertiseTypeObjIds){'
   + ' jsobject.clickWareId(advertiseTypeObjIds);clickWareId(advertiseTypeObjIds);'
  + '}'
+'</script><body><style>'
			 +'i{font-style:normal;}'
+'.article-box .left{width: 120px;height: 140px;float: left;}'
+'.article-box .right{float: right;}'
+'.article-box .right p{margin-top: 10px;}'
+'.second i{color:#fc5716;}'
+'.second i:last-child{padding:0px 15px 0px 15px;background:#fff0e5;color: #ff5821;border-radius: 20px;border:1px solid #fff0e5;margin-left: 15px;font-size: 10px;}'
+'h5{font-weight: normal;color: #333;}'
+'.article-box .right .price{padding-top:10px;background:none;}'
+' h5,p{margin-bottom: 0;}'
+'.price i{padding-right:20px;font-size: 14px;color:#666;font-size: 12px;}'
+'.price i:first-child b{text-decoration: line-through;font-weight: normal;font-size: 12px;margin-left: 10px;color: #808080;}'
+'.buy{border-radius: 30px;background: #FF0000;color: #ffffff;width: 60px;float: right;margin-right: 10px;font-size: 12px;text-align: center;}'
		+'</style>'
		+'<div class="article-box">'
	+'<div class="left">'
	+'<img id="imgsval" src="'+document.getElementById('imgsval').src+'" alt="">'
	+'<input type="hidden" id="advertiseTypeObjId" value="'+document.getElementById('advertiseTypeObjIds').value+'">'
	+'</div>'
	+'<div clas="right">'
	+'	<h5 id="pname">'+document.getElementById('pname').innerHTML+'</h5>'
	+'	<p class="second"><i>¥'+document.getElementById('prices').innerHTML+'</i><i>积分'+document.getElementById('redweb').innerHTML+'</i></p>'
	+'	<p class="price"><i>市场价<b>¥'+document.getElementById('marketPrice').innerHTML+'</b></i><i>'+document.getElementById('sale').innerHTML+'已售</i><i style="display:none">'+document.getElementById('saleValue').innerHTML+'好评</i></p>'
	+'	<p class="buy" onclick="callJS('+document.getElementById('advertiseTypeObjIds').value+')">去购买</p>'
	+'</div>'
	+'</div></body>'
		)			 },
    };    
} );    