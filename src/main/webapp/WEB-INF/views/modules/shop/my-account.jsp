<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="robots" content="noarchive">
    <title>我的账户</title>
     <link rel="stylesheet" href="${ctxStatic}/sbShop/css/my-account.css">
     <link rel="stylesheet" href="${ctxStatic}/sbShop/css/bootstrap.min.css">
     <link rel="stylesheet" href="${ctxStatic}/sbShop/css/pageloader.css">
    <script src="${ctxStatic}/sbShop/js/jquery.min.js"></script>
    <script>
    $(window.parent.document).find('.list-ul').find('ul').slideUp();
    $(window.parent.document).find('.list-ul').find('a').removeClass('active');
    </script>
    <script>
    $(function(){
    	   $('.tab').click(function(){
    	       $('.my-account').hide();
    	       $('.my-bill').show();
    	   });
    	    $('.n-tab').click(function(){
    	        $('.my-account').show();
    	        $('.my-bill').hide();
    	    })

    	    $('.shan').click(function(){
    	        $('.my-account').hide();
    	        $('.shan-bao').show();
    	    });
    	    $('.n-shan').click(function(){
    	        $('.my-account').show();
    	        $('.shan-bao').hide();
    	    })
    	});
    
    
    
    </script>
</head>
<body>
    <div class="my-account">
        <p><a href="javascript:;">门店管理</a> > <span>我的账户</span></p>

        <div class="shanbao">
            <div>
                <span>今日积分指数：</span>
                <b>${loveIndex}</b>
                <span>可激励积分：</span>
                <b>${ebUser.canChangeLove}</b>个
            </div>
            <ul>
                <li><span>今日新增积分：</span><b>${ebUser.todayAddLove}</b>个</li>
                <li>
                    <span>当前积分：<b>${ebUser.currentLove}</b>个</span>
                    <a class="shan" href="${ctxweb}/shop/shopAccount/mylove">【查看积分明细】</a>
                </li>
                <li>
                    今日激励金额：<b>¥${ebUser.todayAmt}</b></li>
                <li>
                    <span>已激励金额：<b>¥${ebUser.haveChangeLove}</b></span>
                    <a class="tab" href="${ctxweb}/shop/shopAccount/mybill?amtType=7">【查看激励金额明细】</a>
                </li>
                <li>
                    <span>当前余额：<b>¥${ebUser.currentAmt}</b></span>
                    <a class="tab" href="${ctxweb}/shop/shopAccount/mybill">【查看我的账单】</a>
                </li>
                <li>
                    <span>冻结金额：<b>¥${ebUser.frozenAmt}</b></span>
                    <a class="tab" href="${ctxweb}/shop/shopAccount/mybill?amt=0">【查看冻结明细】</a>
                </li>
                
            </ul>
        </div>
    </div>
    </div>
</body>
</html>