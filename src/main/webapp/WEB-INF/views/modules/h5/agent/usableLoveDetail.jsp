<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta content="width=device-width,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0,user-scalable=no,minimal-ui" name="viewport">
    <meta name="format-detection" content="telephone=no">
    <meta content="yes" name="apple-mobile-web-app-capable">
    <meta content="black" name="apple-mobile-web-app-status-bar-style">
    <meta content="telephone=no" name="format-detection">
    <meta content="yes" name="apple-touch-fullscreen">
    <meta name="x5-page-mode" content="app">
    <meta name="screen-orientation" content="portrait">
    <meta name="x5-orientation" content="portrait">
    <title>可激励积分详情</title>
    <link rel="stylesheet" href="${ctxStatic}/h5/agent/css/jili-details.css">
    <link rel="stylesheet" href="${ctxStatic}/h5/css/bootstrap.min.css">
    <script src="${ctxStatic}/hAdmin/js/jquery.min.js"></script>
    <script>
        $(function(){
            $('html').css('font-size',$('body').width()/10+'px');

            $('.d-del').click(function(){
                $(this).closest('.download').remove()
            });

            $('.box-sb a').click(function(){
//                alert('1');
                $(this).closest('.box-sb').hide();
            });
            $('.detailed-list ul').click(function(e){
                if (!$(e.target).hasClass('ba')){
                    $(this).siblings('ul').find('.box-sb').hide();
                    $(this).find('.box-sb').show();
                    var bs= $(this).find('.box-sb');
                    setTimeout(function(){bs.hide()},3000);

                }

            });

        })
        
        function back(){
        	  location.href='${ctxweb}'+'/h5/agentUser/agentShanbao';
          }
    </script>
</head>
<body>
    <div class="head-nav">
         <img class="img-responsive" src="${ctxStatic}/h5/agent/images/fanhui.png" onclick="back();">
        <span>可激励积分详情</span>
    </div>

    <div class="context">

        <div class="detailed">
            <ul class="list-head">
                <li>等级</li>
                <li>周期</li>
                <li>持有积分数量</li>
                <li>是否可激励</li>
            </ul>
            <div class="detailed-list">
                <ul>
                    <li>
                        0
                        <div class="box-sb">
                            <img src="${ctxStatic}/h5/agent/images/jili-s.png" alt="">
                           <p>马上就有${level.level0ULove}个积分掉落到下一级啦，还不抓紧唤醒他们！</p>
                            <a class="ba" href="javascript:;">我知道了</a>
                        </div>
                    </li>
                    <li>0天~${level.level0Dates}天</li>
                    <li>${level.level0Love}</li>
                    <li>
                        <c:if test="${level.level0LoveIsStimulate==0}">否</c:if>
			    	    <c:if test="${level.level0LoveIsStimulate==1}">是</c:if>
			    	    </li>
                </ul>
                <ul>
                    <li>
                        1
                        <div class="box-sb">
                            <img src="${ctxStatic}/h5/agent/images/jili-s.png" alt="">
                            <p>马上就有${level.level1ULove}个积分掉落到下一级啦，还不抓紧唤醒他们！</p>
                            <a class="ba" href="javascript:;">我知道了</a>
                        </div>
                    </li>
                    <li>${level.level0Dates+1}天~${level.level1Dates}天</li>
                        <li>${level.level1Love}</li>
                        <li>
                        <c:if test="${level.level1LoveIsStimulate==0}">否</c:if>
			    	    <c:if test="${level.level1LoveIsStimulate==1}">是</c:if>
			    	    </li>
                </ul>
                <ul>
                    <li>
                       2
                        <div class="box-sb">
                            <img src="${ctxStatic}/h5/agent/images/jili-s.png" alt="">
                            <p>马上就有${level.level2ULove}个积分掉落到下一级啦，还不抓紧唤醒他们！</p>
                            <a class="ba" href="javascript:;">我知道了</a>
                        </div>
                    </li>
                    <li>${level.level1Dates+1}天~${level.level2Dates}天</li>
                        <li>${level.level2Love}</li>
                        <li>
                        <c:if test="${level.level2LoveIsStimulate==0}">否</c:if>
			    	    <c:if test="${level.level2LoveIsStimulate==1}">是</c:if>
			    	    </li>
                </ul>
                <ul>
                    <li>
                        3
                        <div class="box-sb">
                            <img src="${ctxStatic}/h5/agent/images/jili-s.png" alt="">
                            <p>马上就有${level.level3ULove}个积分掉落到下一级啦，还不抓紧唤醒他们！</p>
                            <a class="ba" href="javascript:;">我知道了</a>
                        </div>
                    </li>
                    <li>${level.level2Dates+1}天~${level.level3Dates}天</li>
                        <li>${level.level3Love}</li>
                        <li>
                        <c:if test="${level.level3LoveIsStimulate==0}">否</c:if>
			    	    <c:if test="${level.level3LoveIsStimulate==1}">是</c:if>
			    	    </li>
                </ul>
                <ul>
                    <li>
                        4
                        <div class="box-sb">
                            <img src="${ctxStatic}/h5/agent/images/jili-s.png" alt="">
                            <p>马上就有${level.level4ULove}个积分掉落到下一级啦，还不抓紧唤醒他们！</p>
                            <a class="ba" href="javascript:;">我知道了</a>
                        </div>
                    </li>
                    <li>${level.level3Dates+1}天~${level.level4Dates}天</li>
                        <li>${level.level4Love}</li>
                        <li>
                        <c:if test="${level.level4LoveIsStimulate==0}">否</c:if>
			    	    <c:if test="${level.level4LoveIsStimulate==1}">是</c:if>
			    	    </li>
                </ul>
                <ul>
                    <li>
                        5
                        <div class="box-sb">
                            <img src="${ctxStatic}/h5/agent/images/jili-s.png" alt="">
                            <p>马上就有${level.level5ULove}个积分掉落到下一级啦，还不抓紧唤醒他们！</p>
                            <a class="ba" href="javascript:;">我知道了</a>
                        </div>
                    </li>
                    <li>${level.level4Dates+1}天~${level.level5Dates}天</li>
                        <li>${level.level5Love}</li>
                        <li>
                        <c:if test="${level.level5LoveIsStimulate==0}">否</c:if>
			    	    <c:if test="${level.level5LoveIsStimulate==1}">是</c:if>
			    	    </li>
                </ul>
                <ul>
                    <li>
                        6
                        <div class="box-sb">
                            <img src="${ctxStatic}/h5/agent/images/jili-s.png" alt="">
                            <p>马上就有${level.level6ULove}个积分掉落到下一级啦，还不抓紧唤醒他们！</p>
                            <a class="ba" href="javascript:;">我知道了</a>
                        </div>
                    </li>
                    <li>${level.level5Dates+1}天~${level.level6Dates}天</li>
                        <li>${level.level6Love}</li>
                        <li>
                        <c:if test="${level.level6LoveIsStimulate==0}">否</c:if>
			    	    <c:if test="${level.level6LoveIsStimulate==1}">是</c:if>
			    	    </li>
                </ul>
                <ul>
                    <li>
                        7
                        <div class="box-sb">
                            <img src="${ctxStatic}/h5/agent/images/jili-s.png" alt="">
                            <p>马上就有${level.level7ULove}个积分掉落到下一级啦，还不抓紧唤醒他们！</p>
                            <a class="ba" href="javascript:;">我知道了</a>
                        </div>
                    </li>
                    <li>${level.level6Dates+1}天~${level.level7Dates}天</li>
                        <li>${level.level7Love}</li>
                        <li>
                        <c:if test="${level.level7LoveIsStimulate==0}">否</c:if>
			    	    <c:if test="${level.level7LoveIsStimulate==1}">是</c:if>
			    	    </li>
                </ul>
                <ul>
                    <li>
                        8
                        <div class="box-sb">
                            <img src="${ctxStatic}/h5/agent/images/jili-s.png" alt="">
                            <p>马上就有${level.level8ULove}个积分掉落到下一级啦，还不抓紧唤醒他们！</p>
                            <a class="ba" href="javascript:;">我知道了</a>
                        </div>
                    </li>
                    <li>${level.level7Dates+1}天~${level.level8Dates}天</li>
                        <li>${level.level8Love}</li>
                        <li>
                        <c:if test="${level.level8LoveIsStimulate==0}">否</c:if>
			    	    <c:if test="${level.level8LoveIsStimulate==1}">是</c:if>
			    	    </li>
                </ul>
                <ul>
                    <li>
                        9
                        <div class="box-sb">
                            <img src="${ctxStatic}/h5/agent/images/jili-s.png" alt="">
                            <p>马上就有${level.level9ULove}个积分掉落到下一级啦，还不抓紧唤醒他们！</p>
                            <a class="ba" href="javascript:;">我知道了</a>
                        </div>
                    </li>
                    <li>${level.level8Dates+1}天~${level.level9Dates}天</li>
                        <li>${level.level9Love}</li>
                        <li>
                        <c:if test="${level.level9LoveIsStimulate==0}">否</c:if>
			    	    <c:if test="${level.level9LoveIsStimulate==1}">是</c:if>
			    	    </li>
                </ul>
                <ul>
                    <li>
                        10
                        <div class="box-sb">
                            <img src="${ctxStatic}/h5/agent/images/jili-s.png" alt="">
                            <p>马上就有${level.level10ULove}个积分掉落到下一级啦，还不抓紧唤醒他们！</p>
                            <a class="ba" href="javascript:;">我知道了</a>
                        </div>
                    </li>
                    <li>${level.level9Dates+1}天~${level.level10Dates}天</li>
                        <li>${level.level10Love}</li>
                        <li>
                        <c:if test="${level.level10LoveIsStimulate==0}">否</c:if>
			    	    <c:if test="${level.level10LoveIsStimulate==1}">是</c:if>
			    	    </li>
                </ul>
                <ul>
                    <li>
                        11
                        <div class="box-sb">
                            <img src="${ctxStatic}/h5/agent/images/jili-s.png" alt="">
                            <p>马上就有${level.level11ULove}个积分掉落到下一级啦，还不抓紧唤醒他们！</p>
                            <a class="ba" href="javascript:;">我知道了</a>
                        </div>
                    </li>
                    <li>${level.level10Dates+1}天~${level.level11Dates}天</li>
                        <li>${level.level11Love}</li>
                        <li>
                        <c:if test="${level.level11LoveIsStimulate==0}">否</c:if>
			    	    <c:if test="${level.level11LoveIsStimulate==1}">是</c:if>
			    	    </li>
                </ul>
                <ul>
                    <li>
                        12
                        <div class="box-sb">
                            <img src="${ctxStatic}/h5/agent/images/jili-s.png" alt="">
                            <p>马上就有${level.level12ULove}个积分掉落到下一级啦，还不抓紧唤醒他们！</p>
                            <a class="ba" href="javascript:;">我知道了</a>
                        </div>
                    </li>
                    <li>${level.level11Dates+1}天~${level.level12Dates}天</li>
                        <li>${level.level12Love}</li>
                        <li>
                        <c:if test="${level.level12LoveIsStimulate==0}">否</c:if>
			    	    <c:if test="${level.level12LoveIsStimulate==1}">是</c:if>
			    	    </li>
                </ul>
                <ul>
                    <li>
                        13
                        <div class="box-sb">
                            <img src="${ctxStatic}/h5/agent/images/jili-s.png" alt="">
                            <p>马上就有${level.level13ULove}个积分掉落到下一级啦，还不抓紧唤醒他们！</p>
                            <a class="ba" href="javascript:;">我知道了</a>
                        </div>
                    </li>
                    <li>${level.level12Dates+1}天~${level.level13Dates}天</li>
                        <li>${level.level13Love}</li>
                        <li>
                        <c:if test="${level.level13LoveIsStimulate==0}">否</c:if>
			    	    <c:if test="${level.level13LoveIsStimulate==1}">是</c:if>
			    	    </li>
                </ul>
                <ul>
                    <li>
                        14
                        <div class="box-sb">
                            <img src="${ctxStatic}/h5/agent/images/jili-s.png" alt="">
                            <p>马上就有${level.level14ULove}个积分掉落到下一级啦，还不抓紧唤醒他们！</p>
                            <a class="ba" href="javascript:;">我知道了</a>
                        </div>
                    </li>
                    <li>${level.level13Dates+1}天~${level.level14Dates}天</li>
                        <li>${level.level14Love}</li>
                        <li>
                        <c:if test="${level.level14LoveIsStimulate==0}">否</c:if>
			    	    <c:if test="${level.level14LoveIsStimulate==1}">是</c:if>
			    	    </li>
                </ul>
                <ul>
                    <li>
                        15
                        <div class="box-sb">
                            <img src="${ctxStatic}/h5/agent/images/jili-s.png" alt="">
                            <p>马上就有${level.level15ULove}个积分掉落到下一级啦，还不抓紧唤醒他们！</p>
                            <a class="ba" href="javascript:;">我知道了</a>
                        </div>
                    </li>
                    <li>${level.level14Dates+1}天~${level.level15Dates}天</li>
                        <li>${level.level15Love}</li>
                        <li>
                        <c:if test="${level.level15LoveIsStimulate==0}">否</c:if>
			    	    <c:if test="${level.level15LoveIsStimulate==1}">是</c:if>
			    	    </li>
                </ul>
                <ul>
                    <li>
                        16
                        <div class="box-sb">
                            <img src="${ctxStatic}/h5/agent/images/jili-s.png" alt="">
                            <p>马上就有${level.level16ULove}个积分掉落到下一级啦，还不抓紧唤醒他们！</p>
                            <a class="ba" href="javascript:;">我知道了</a>
                        </div>
                    </li>
                    <li>${level.level15Dates+1}天~${level.level16Dates}天</li>
                        <li>${level.level16Love}</li>
                        <li>
                        <c:if test="${level.level16LoveIsStimulate==0}">否</c:if>
			    	    <c:if test="${level.level16LoveIsStimulate==1}">是</c:if>
			    	    </li>
                </ul>
                <ul>
                    <li>
                        17
                        <div class="box-sb">
                            <img src="${ctxStatic}/h5/agent/images/jili-s.png" alt="">
                            <p>马上就有${level.level17ULove}个积分掉落到下一级啦，还不抓紧唤醒他们！</p>
                            <a class="ba" href="javascript:;">我知道了</a>
                        </div>
                    </li>
                    <li>${level.level16Dates+1}天~${level.level17Dates}天</li>
                        <li>${level.level17Love}</li>
                        <li>
                        <c:if test="${level.level17LoveIsStimulate==0}">否</c:if>
			    	    <c:if test="${level.level17LoveIsStimulate==1}">是</c:if>
			    	    </li>
                </ul>
                <ul>
                    <li>
                        18
                        <div class="box-sb">
                            <img src="${ctxStatic}/h5/agent/images/jili-s.png" alt="">
                            <p>马上就有${level.level18ULove}个积分掉落到下一级啦，还不抓紧唤醒他们！</p>
                            <a class="ba" href="javascript:;">我知道了</a>
                        </div>
                    </li>
                    <li>${level.level17Dates+1}天~${level.level18Dates}天</li>
                        <li>${level.level18Love}</li>
                        <li>
                        <c:if test="${level.level18LoveIsStimulate==0}">否</c:if>
			    	    <c:if test="${level.level18LoveIsStimulate==1}">是</c:if>
			    	    </li>
                </ul>
                <ul>
                    <li>
                        19
                        <div class="box-sb">
                            <img src="${ctxStatic}/h5/agent/images/jili-s.png" alt="">
                            <p>马上就有${level.level19ULove}个积分掉落到下一级啦，还不抓紧唤醒他们！</p>
                            <a class="ba" href="javascript:;">我知道了</a>
                        </div>
                    </li>
                    <li>${level.level18Dates+1}天~${level.level19Dates}天</li>
                        <li>${level.level19Love}</li>
                        <li>
                        <c:if test="${level.level19LoveIsStimulate==0}">否</c:if>
			    	    <c:if test="${level.level19LoveIsStimulate==1}">是</c:if>
			    	    </li>
                </ul>
            </div>
        </div>

        <div class="xg">
            <p>相关说明</p>
            <ul>
                <li>1.满1个积分才能参与积分激励</li>
                <li>2.参与积分激励后，对应的积分数量同步减少</li>
                <li>3.积分激励需扣除10%税收及平台维护费用</li>
            </ul>
        </div>
    </div>

</body>
</html>