<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%response.setStatus(200);%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title> - 404 页面</title>
    <meta name="keywords" content="">
    <meta name="description" content="">
    <link rel="shortcut icon" href="favicon.ico"> <link href="${ctxStatic}/hAdmin/css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
    <link href="${ctxStatic}/hAdmin/css/font-awesome.css?v=4.4.0" rel="stylesheet">
    <link href="${ctxStatic}/hAdmin/css/animate.css" rel="stylesheet">
    <link href="${ctxStatic}/hAdmin/css/style.css?v=4.1.0" rel="stylesheet">
    <style>
    .middle-box{max-width:700px;}
    .middle-box img{max-width:100%;}
    </style>
</head>
<body class="gray-bg" style="background:#fff;">
    <div class="middle-box text-center animated fadeInDown">
<!--         <h1>404</h1> -->
         <img src="${ctxStatic}/images/404img.png"/>

        <div class="error-desc" style="margin-top:20px;">
           <p style="margin-left:120px;"> 页面未找到</p>
           <p style="margin-left:120px;"> 抱歉，页面好像去火星了~</p>
            <form class="form-inline m-t" role="form" style="margin-top:30px;">
                <div class="form-group">
                    <input type="email" class="form-control" placeholder="请输入您需要查找的内容 …" style="width:300px;height:35px;margin-left:120px;">
                </div>
                <button type="submit" class="btn btn-primary"  style="width:80px;height:35px;background:#495572;">搜索</button>
            </form>
        </div>
    </div>

    <!-- 全局js -->
    <script src="${ctxStatic}/hAdmin/js/jquery.min.js?v=2.1.4"></script>
    <script src="${ctxStatic}/hAdmin/js/bootstrap.min.js?v=3.3.6"></script>

</body>

</html>
