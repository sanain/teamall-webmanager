﻿<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <meta charset="UTF-8">
    <title>我的余额</title>
     <link rel="stylesheet" href="${ctxStatic}/h5/css/bootstrap.min.css">
    <script src="${ctxStatic}/hAdmin/js/jquery.min.js"></script>
    <style type="text/css">
	    *{padding: 0;margin: 0;list-style-type: none;text-decoration: none;font-family:"Microsoft YaHei",Helvetica,Hiragino Sans GB,Tahoma,Geneva,\5FAE\8F6F\96C5\9ED1,simhei,Arial, sans-serif;}
		a{color: #000;text-decoration: none !important;}
		
		h1{font-weight: normal;}
		img{border: none;max-width: 100%;}
		html, body {position: relative;color: #666666;}
		input:focus{outline:none; }
		body .container{padding-left: 20px;padding-right: 20px}
		
		.my-balance{padding-top: 30px}
		.balance{overflow: hidden;width: 780px;margin: 0 auto}
		.balance li{float: left;width: 180px;margin-right: 20px;background: #77C381;height: 160px;color: #ffffff;position: relative}
		.balance li:last-child{margin-right: 0;}
		.balance li p{text-align: center;margin: 0 10px;font-size: 12px;height: 40px;line-height: 40px;border-bottom: 1px solid #ffffff}
		.balance li div{text-align: center;padding-top: 30px}
		.balance li div b{font-weight: normal;font-size: 12px}
		.balance li div span{font-size: 18px}
		.balance li a{position: absolute;width: 100%;text-align: center;height: 35px;line-height: 35px;color: #ffffff;bottom: 0;background: #44AB52}
		.canv{width: 900px;margin: 0 auto;}
		.canv div{padding: 40px 60px 0}
		.canv div span{color: #666666}
		.canv div a{float:right;color: #258BC5}
    </style>
    <script>
    $(function(){
        //数据
        txt=${txt};
        var scope=100;  //y轴最大范围
        can(txt,scope);
    });

    //绘制统计图
    function can(txt,scope) {
            //定义画布的相关变量
            var canvas=document.getElementById('can');
            var ctx=canvas.getContext('2d');
            var w =900; //宽
            var h =475; //高
            var fontSize=14;
            var padding=60;
            var origin={x:padding,y:h-padding};
            var xEnd={x:w-padding,y:h - padding};
            var yEnd={x:padding,y:padding};
            var count=txt.length;
            canvas.width=w;
            canvas.height=h;
            ctx.font=fontSize+'px SimHei';
            ctx.textBaseline='bottom';
            ctx.beginPath();
            //绘制x轴和轴点
            ctx.moveTo(origin.x,origin.y);
            ctx.lineTo(xEnd.x,xEnd.y);
            //ctx.lineTo(xEnd.x-15,xEnd.y+10);
            //ctx.moveTo(xEnd.x,xEnd.y);
            //ctx.lineTo(xEnd.x-15,xEnd.y-10);
            var xpoint=(w-2*padding)/(count+1);
            var ypoint=(h-2*padding)/6;
            for (var i=0;i<count;i++) {
                var x=origin.x+(i+1)*xpoint;
                var y=origin.y;
                ctx.moveTo(x,y);
                ctx.lineTo(x,y-5);
                var text=txt[i].fname;
                var txtwidth=ctx.measureText(text).width;
                ctx.fillText(text,x-txtwidth/2,y+fontSize+20);

            }
            ////绘制y轴和轴点
            //
            //ctx.moveTo(origin.x,origin.y);
            //ctx.lineTo(yEnd.x, yEnd.y);
            //ctx.lineTo(yEnd.x-10,yEnd.y+15);
            //ctx.moveTo(yEnd.x,yEnd.y);
            //ctx.lineTo(yEnd.x+10,yEnd.y+15);
            //for(var a=0;a<5;a++){
            //    var x1=origin.x;
            //    var y1=origin.y-(a+1)*ypoint;
            //    ctx.moveTo(x1,y1);
            //    ctx.lineTo(x1+6,y1);
            //    var text1=20000*(a+1)+'元';
            //    var txtwidth1=ctx.measureText(text1).width;
            //    ctx.fillText(text1,x1-txtwidth1,y1+fontSize/ 2);
            //    ctx.fillStyle="#000";
            //}
            ctx.stroke();
        var yuans=['147,184,188','119,195,129','237,211,188'];
            //绘制矩形图
            for(var j= 0,s=0;j<count;j++){
                var num=txt[j].price;
                ctx.strokeRect((origin.x+xpoint*(j+1))-(xpoint/4),origin.y-num*(ypoint*5/scope),xpoint/2,num*(ypoint*5/scope));
                var g=yuans[s];
                if (s==2){
                    s=-1
                }
                s++;
                ctx.fillStyle='rgb('+g+')';
                ctx.fillRect((origin.x+xpoint*(j+1))-xpoint/4,origin.y-num*(ypoint*5/scope),xpoint/2,num*(ypoint*5/scope));
                if(j<count-1){
                    ctx.fillText(num,(origin.x+xpoint*(j+1))-xpoint/4,origin.y-num*(ypoint*5/scope));
                    ctx.fillStyle="#000";
                }
            }
            ctx.fillText(txt[count- 1].price,(origin.x+xpoint*count)-xpoint/4,origin.y-txt[count-1].price*(ypoint*5/scope));
            //随机颜色
            //function yuan(){
            //    var r=parseInt(Math.random()*256);
            //    var g=parseInt(Math.random()*256);
            //    var b=parseInt(Math.random()*256);
            //    return r+','+g+','+b
            //}

    }
    </script>
</head>
<body>
    <div class="my-balance">
        <ul class="balance">
            <li>
                <p>累计奖励金额</p>
                <div>
                    <b>¥</b><span>${sysOffice.loveAmt }</span>
                </div>
            </li>
            <li>
                <p>当前金额</p>
                <div>
                    <b>¥</b><span>${sysOffice.currentAmt }</span>
                </div>
                <a href="${ctxsys}/pmAgentAmtLog/withdraw">提现</a>
            </li>
            <li>
                <p>冻结金额</p>
                <div>
                    <b>¥</b><span>${freezeAmt }</span>
                </div>
            </li>
            <li>
                <p>我的银行卡</p>
                <div>
                    <span>${pBankCount }</span><b>张</b>
                </div>
                <a href="${ctxsys}/pmAgentBank/list">查看银行卡</a>
            </li>
        </ul>

        <div class="canv">
            <div>
                <span>已激励金额</span>
                <a href="${ctxsys}/pmAgentAmtLog/agentAmtList">查看明细</a>
            </div>
            <canvas id="can" width="500" height="400"></canvas>
        </div>
    </div>
</body>
</html>