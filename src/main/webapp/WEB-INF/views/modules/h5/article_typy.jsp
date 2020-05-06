<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
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
    <title>文章详情</title>
    <link rel="stylesheet" href="${ctxStatic}/h5/css/article-details.css">
    <link rel="stylesheet" href="${ctxStatic}/h5/css/bootstrap.min.css">
    <script src="${ctxStatic}/h5/js/jquery.min.js"></script>
    <script>
        function ucode(a){
         a = "" + a;
         return a.replace(/&lt;/g, "<").replace(/&gt;/g, ">").replace(/&amp;/g, "&").replace(/&quot;/g, '"').replace(/&apos;/g, "'");
        };
        $(function(){
             console.log($('.context').html());
             var aaa=ucode($('.context').html());
             $('.context').html(aaa);
             var productTagsNames="${ebArticle.labelNames}";
               var html="";
             if(productTagsNames!=null&&productTagsNames!=''){
                var productTagsName=productTagsNames.split(",");
                  html+="<ul style=\"width: 100%;\"><p>相关标签</p>";
                for (var i=0;i<productTagsName.length;i++){
                  html+=" <li>"+productTagsName[i]+"</li>";
                 }
                html+="</ul>";
             }
             $(".related").html(html);
        
            $('html').css('font-size',$('body').width()/10+'px');

            $('.d-del').click(function(){
                $(this).closest('.download').remove()
            });
			ce();
        })
    </script>
	<script>
				function ce(){
                    var imgs = $('.context').find('img'); // 找到table标签
					console.log(imgs.length);
                    for(var i = 0; i<imgs.length; i++){  // 逐个改变
                    if (imgs[i].src.indexOf('http') >= 0 || imgs[i].src.indexOf('https') >= 0) {
                    imgs[i].style.width = '100%';
                    imgs[i].style.height = 'auto';
                    }
					}
				}
     </script>
	
	
</head>
<body>
    <div class="download">
        <img class="down-logo" src="${ctxStatic}/h5/images/logo.png" alt="">
        <span>下载${fns:getProjectName()}</span>
        <a href="javascript:;" style="background: #3BC969;">立即下载</a>
        <img class="d-del" src="${ctxStatic}/h5/images/d-del.png" alt="">
    </div>

    <div class="head-nav">
        <img class="img-responsive" src="${ctxStatic}/h5/images/fanhui.png" alt="" onclick="javascript:history.back(-1);">
        <span>${pmServiceProtocol.name}</span>
    </div>

    <div class="context" style="margin-top:20px">
         ${pmServiceProtocol.contentInfo}
       <%--  <img src="${ctxStatic}/h5/images/article-bg2.png" alt="">
        <div class="shop-msg">
            <p>2017西班牙的海边比基尼的维多利亚的秘密时装周</p>
            <div>225元起 双倍${fns:getProjectName()}包邮</div>
            <span>2017/05/24</span>
        </div>

        <div class="article">
            <p>在一般人的认知中，护照往往与出国挂钩，比如可以用来乘坐国际航班，出国旅游等。但在国内，除了乘坐飞机，护照还有何种用途？作为个人身份证明，为何有的部门拒绝人们使用护照？外国人的护照又用来做什么？带着这些问题，新京报采访了外交学院的夏莉萍教授。</p>
            <div>
                <img src="${ctxStatic}/h5/images/article-bg3.png" alt="">
            </div>
            <p>新京报：按照相关法律，中国公民在国内航段可以用护照坐飞机吗？</p>
            <p>夏莉萍：2006年中国已经出台了《中华人民共和国护照法》，并与2007年1月1日起执行。《护照法》第二条说明了护照的用途，即中华人民共和国护照是中华人民共和国公民出入国境和在国外证明国籍和身份的证件。</p>
            <div class="article-box">
                <ul>
                    <li><img src="${ctxStatic}/h5/images/article-bg4.png" alt=""></li>
                    <li>
                        <p>UR2017春夏新款魅力女装V领袖简约百搭T恤WB10B4D</p>
                        <div>
                            <span>¥&nbsp;109</span>
                            <b>83</b>
                            <a href="javascript:;">去购买</a>
                        </div>
                    </li>
                </ul>
            </div>
            <p>有意思的是，《护照法》还真没说护照可以作为国内使用的证件，从这个定义来看，说坐国内段飞机不能用护照，似乎说得过去。</p>
            <div class="article-box">
                <ul>
                    <li><img src="${ctxStatic}/h5/images/article-bg5.png" alt=""></li>
                    <li>
                        <p>UR2017春夏新款魅力女装V领袖简约百搭T恤WB10B4D</p>
                        <div>
                            <span>¥&nbsp;109</span>
                            <b>83</b>
                            <a href="javascript:;">去购买</a>
                        </div>
                    </li>
                </ul>
            </div>
            <p>有意思的是，《护照法》还真没说护照可以作为国内使用的证件，从这个定义来看，说坐国内段飞机不能用护照，似乎说得过去。</p>
        </div> --%>
        
    </div>
    <div class="related">
        
    </div>
    <ul class="bottom-msg" style="display:none">
        <li><b>值</b><a href="javascript:;">${s}%</a></li>
        <li><b><img src="${ctxStatic}/h5/images/icon-collect.png" alt=""></b><a href="javascript:;">${ebArticle.articleFavorites}</a></li>
        <li><b><img src="${ctxStatic}/h5/images/icon-msg.png" alt=""></b><a href="javascript:;">${ebArticle.articleMediumint}</a></li>
    </ul>
</body>
</html>
