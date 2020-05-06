

$(function(){
$.ajaxSetup({//如果session超时则跳转到登录页面
    contentType:"application/x-www-form-urlencoded;charset=utf-8",
    complete:function(XMLHttpRequest,textStatus){
            var sessionstatus=XMLHttpRequest.getResponseHeader("sessionstatus"); //通过XMLHttpRequest取得响应头，sessionstatus，  
            var path =XMLHttpRequest.getResponseHeader("contextPath");
            if(sessionstatus=="timeout"){
               //如果超时就处理 ，指定要跳转的页面  
                if(window.opener!=null&&(typeof(window.opener)!='undefined')){
                    window.location.replace((path==null?"":path)+'/shoplogin');
                }else{ 
                    window.close();
                    window.parent.top.location.replace((path==null?"":path)+'/shoplogin');
                }
            }
      }
});
});