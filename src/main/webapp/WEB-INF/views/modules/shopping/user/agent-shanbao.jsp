<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <meta charset="UTF-8">
    <title>代理我的积分</title>
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
		.balance{overflow: hidden;width: 60%;margin: 0 auto}
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
        $("#loveIndex").html(returnFloat($("#loveIndex").html()));
        $("#usableLove").html(returnFloat($("#usableLove").html()));
        $("#currentLove").html(returnFloat($("#currentLove").html()));
        $("#totalLove").html(returnFloat($("#totalLove").html()));
        $("#freezeAmt").html(returnFloat($("#freezeAmt").html()));
    });

    //绘制统计图
    function can(txt,scope) {
            //定义画布的相关变量
            var canvas=document.getElementById('can');
            var ctx=canvas.getContext('2d');
            var w =780; //宽
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
    function returnFloat(value){
   	 var xsd=value.toString().split(".");
   	 if(xsd.length==1){
   	 value=value.toString()+".0000";
   	 return value;
   	 }
   	 if(xsd.length>1){
   	  for(var i=0;i<4-xsd[1].length;i++){
   	 value=value.toString()+"0";
   	 }
   	 return value;
   	 }
   	}
    </script>
    
			<style>
        .detailed{margin-top: 10px;background: #ffffff;padding: 0;color: #666666;}
        .detailed>p{border: 1px solid #dcdcdc;height: 35px;line-height: 35px;background: #f0f0f0;padding-left: 15px;margin-bottom: 0;}
        .detailed ul{margin-bottom: 0;position: relative;height: 35px;border-right: 1px solid #dcdcdc;border-left: 1px solid #dcdcdc;}
        .detailed ul li{float: left;width: 25%;text-align: center;color: #4F4F4F;}
        .detailed .list-head{height: 50px;line-height: 35px;font-weight: 600;padding-top: 15px}
        .detailed .detailed-list ul li{height: 35px;line-height: 35px;}
        .detailed .detailed-list{padding: 0;}
        .xg{border: 1px solid #dcdcdc;border-top: none}
        .canv .xg{padding: 20px;}
        .xg p{margin-bottom: 0;color: #999999;}
        .xg p:first-child{border-top: 1px solid #dcdcdc;padding-top: 10px}
        .canv .chakan{padding: 0;border: 1px solid #dcdcdc;margin-bottom: 20px;}
        .chakan>p{border-bottom: 1px solid #dcdcdc;height: 35px;line-height: 35px;background: #f0f0f0;padding:0 15px;margin-bottom: 0;}

    </style>
</head>
<body>
    <div class="my-balance">
        <ul class="balance">
            <li>
                <p>今日积分指数</p>
                <div>
                    <span id="loveIndex">${loveIndex }</span>
                </div>
            </li>
            <li>
                <p>可激励积分</p>
                <div>
                    <span id="usableLove">${sysOffice.usableLove }</span>
                </div>
            </li>
            <li>
                <p>当前积分</p>
                <div>
                    <span id="currentLove">${sysOffice.currentLove }</span>
                </div>
            </li>
            <li>
                <p>累计积分</p>
                <div>
                    <span id="totalLove">${sysOffice.totalLove }</span>
                </div>
            </li>
            <li>
                <p>冻结积分</p>
                <div>
                    <span id="freezeAmt">${sysOffice.frozenLove}</span>
                </div>
            </li>
        </ul>

        <div class="canv">
          <div class="detailed">
                <p>可激励积分详情</p>
                <ul class="list-head">
                    <li>等级</li>
                    <li>周期</li>
                    <li>持有积分数量</li>
                    <li>是否可激励</li>
                </ul>
                <div class="detailed-list">
                    <ul>
                        <li>0</li>
                        <li>0天~${level.level0Dates}天</li>
                        <li>${level.level0Love}</li>
                        <li>
                        <c:if test="${level.level0LoveIsStimulate==0}">否</c:if>
			    	    <c:if test="${level.level0LoveIsStimulate==1}">是</c:if>
			    	    </li>
                    </ul>
                    <ul>
                        <li>1</li>
                        <li>${level.level0Dates+1}天~${level.level1Dates}天</li>
                        <li>${level.level1Love}</li>
                        <li>
                        <c:if test="${level.level1LoveIsStimulate==0}">否</c:if>
			    	    <c:if test="${level.level1LoveIsStimulate==1}">是</c:if>
			    	    </li>
                    </ul>
                    <ul>
                        <li>2</li>
                        <li>${level.level1Dates+1}天~${level.level2Dates}天</li>
                        <li>${level.level2Love}</li>
                        <li>
                        <c:if test="${level.level2LoveIsStimulate==0}">否</c:if>
			    	    <c:if test="${level.level2LoveIsStimulate==1}">是</c:if>
			    	    </li>
                    </ul>
                    <ul>
                        <li>3</li>
                        <li>${level.level2Dates+1}天~${level.level3Dates}天</li>
                        <li>${level.level3Love}</li>
                        <li>
                        <c:if test="${level.level3LoveIsStimulate==0}">否</c:if>
			    	    <c:if test="${level.level3LoveIsStimulate==1}">是</c:if>
			    	    </li>
                    </ul>
                    <ul>
                        <li>4</li>
                        <li>${level.level3Dates+1}天~${level.level4Dates}天</li>
                        <li>${level.level4Love}</li>
                        <li>
                        <c:if test="${level.level4LoveIsStimulate==0}">否</c:if>
			    	    <c:if test="${level.level4LoveIsStimulate==1}">是</c:if>
			    	    </li>
                    </ul>
                    <ul>
                        <li>5</li>
                        <li>${level.level4Dates+1}天~${level.level5Dates}天</li>
                        <li>${level.level5Love}</li>
                        <li>
                        <c:if test="${level.level5LoveIsStimulate==0}">否</c:if>
			    	    <c:if test="${level.level5LoveIsStimulate==1}">是</c:if>
			    	    </li>
                    </ul>
                    <ul>
                        <li>6</li>
                        <li>${level.level5Dates+1}天~${level.level6Dates}天</li>
                        <li>${level.level6Love}</li>
                        <li>
                        <c:if test="${level.level6LoveIsStimulate==0}">否</c:if>
			    	    <c:if test="${level.level6LoveIsStimulate==1}">是</c:if>
			    	    </li>
                    </ul>
                    <ul>
                        <li>7</li>
                        <li>${level.level6Dates+1}天~${level.level7Dates}天</li>
                        <li>${level.level7Love}</li>
                        <li>
                        <c:if test="${level.level7LoveIsStimulate==0}">否</c:if>
			    	    <c:if test="${level.level7LoveIsStimulate==1}">是</c:if>
			    	    </li>
                    </ul>
                    <ul>
                        <li>8</li>
                        <li>${level.level7Dates+1}天~${level.level8Dates}天</li>
                        <li>${level.level8Love}</li>
                        <li>
                        <c:if test="${level.level8LoveIsStimulate==0}">否</c:if>
			    	    <c:if test="${level.level8LoveIsStimulate==1}">是</c:if>
			    	    </li>
                    </ul>
                    <ul>
                        <li>9</li>
                        <li>${level.level8Dates+1}天~${level.level9Dates}天</li>
                        <li>${level.level9Love}</li>
                        <li>
                        <c:if test="${level.level9LoveIsStimulate==0}">否</c:if>
			    	    <c:if test="${level.level9LoveIsStimulate==1}">是</c:if>
			    	    </li>
                    </ul>
                    <ul>
                        <li>10</li>
                        <li>${level.level9Dates+1}天~${level.level10Dates}天</li>
                        <li>${level.level10Love}</li>
                        <li>
                        <c:if test="${level.level10LoveIsStimulate==0}">否</c:if>
			    	    <c:if test="${level.level10LoveIsStimulate==1}">是</c:if>
			    	    </li>
                    </ul>
                    <ul>
                        <li>11</li>
                        <li>${level.level10Dates+1}天~${level.level11Dates}天</li>
                        <li>${level.level11Love}</li>
                        <li>
                        <c:if test="${level.level11LoveIsStimulate==0}">否</c:if>
			    	    <c:if test="${level.level11LoveIsStimulate==1}">是</c:if>
			    	    </li>
                    </ul>
                    <ul>
                        <li>12</li>
                        <li>${level.level11Dates+1}天~${level.level12Dates}天</li>
                        <li>${level.level12Love}</li>
                        <li>
                        <c:if test="${level.level12LoveIsStimulate==0}">否</c:if>
			    	    <c:if test="${level.level12LoveIsStimulate==1}">是</c:if>
			    	    </li>
                    </ul>
                    <ul>
                        <li>13</li>
                        <li>${level.level12Dates+1}天~${level.level13Dates}天</li>
                        <li>${level.level13Love}</li>
                        <li>
                        <c:if test="${level.level13LoveIsStimulate==0}">否</c:if>
			    	    <c:if test="${level.level13LoveIsStimulate==1}">是</c:if>
			    	    </li>
                    </ul>
                    <ul>
                        <li>14</li>
                        <li>${level.level13Dates+1}天~${level.level14Dates}天</li>
                        <li>${level.level14Love}</li>
                        <li>
                        <c:if test="${level.level14LoveIsStimulate==0}">否</c:if>
			    	    <c:if test="${level.level14LoveIsStimulate==1}">是</c:if>
			    	    </li>
                    </ul>
                    <ul>
                        <li>15</li>
                        <li>${level.level14Dates+1}天~${level.level15Dates}天</li>
                        <li>${level.level15Love}</li>
                        <li>
                        <c:if test="${level.level15LoveIsStimulate==0}">否</c:if>
			    	    <c:if test="${level.level15LoveIsStimulate==1}">是</c:if>
			    	    </li>
                    </ul>
                    <ul>
                        <li>16</li>
                        <li>${level.level15Dates+1}天~${level.level16Dates}天</li>
                        <li>${level.level16Love}</li>
                        <li>
                        <c:if test="${level.level16LoveIsStimulate==0}">否</c:if>
			    	    <c:if test="${level.level16LoveIsStimulate==1}">是</c:if>
			    	    </li>
                    </ul>
                    <ul>
                        <li>17</li>
                        <li>${level.level16Dates+1}天~${level.level17Dates}天</li>
                        <li>${level.level17Love}</li>
                        <li>
                        <c:if test="${level.level17LoveIsStimulate==0}">否</c:if>
			    	    <c:if test="${level.level17LoveIsStimulate==1}">是</c:if>
			    	    </li>
                    </ul>
                    <ul>
                        <li>18</li>
                        <li>${level.level17Dates+1}天~${level.level18Dates}天</li>
                        <li>${level.level18Love}</li>
                        <li>
                        <c:if test="${level.level18LoveIsStimulate==0}">否</c:if>
			    	    <c:if test="${level.level18LoveIsStimulate==1}">是</c:if>
			    	    </li>
                    </ul>
                    <ul>
                        <li>19</li>
                        <li>${level.level18Dates+1}天~${level.level19Dates}天</li>
                        <li>${level.level19Love}</li>
                        <li>
                        <c:if test="${level.level19LoveIsStimulate==0}">否</c:if>
			    	    <c:if test="${level.level19LoveIsStimulate==1}">是</c:if>
			    	    </li>
                    </ul>
                </div>
                <div class="xg">
                    <p>相关说明</p>
                    <p>1.满1个积分才能参与积分激励</p>
                    <p>2.参与积分激励后，对应的积分数量同步减少</p>
                    <p>3.积分激励需扣除10%税收及平台维护费用</p>
                </div>
            </div>
            <div>
            	<div class="chakan">
            		<p>
            			<span>新增积分</span>
                		<a href="${ctxsys}/pmOrderLoveLog/agentLoveList">查看明细</a>
            		</p>
            		<canvas id="can"></canvas>
            	</div>
                
            </div>
            
        </div>
    </div>
</body>
</html>