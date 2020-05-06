<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>广告列表</title>
    <meta name="decorator" content="default"/>
    <script type="text/javascript">
        $(document).ready(function() {
            $("#btnExport").click(function(){
                top.$.jBox.confirm("确认要导出用户数据吗？","系统提示",function(v,h,f){
                    if(v=="ok"){
                        $("#searchForm").attr("action","${ctxsys}/EbThemeQuestion/export?themeId=${themeId }");
                        $("#searchForm").submit();
                    }
                },{buttonsFocus:1});
                top.$('.jbox-body .jbox-icon').css('top','55px');
            });

            $('body').on('mouseover','.fu',function(){
                var i = $(this).attr("i");
                $(this).siblings('.kla'+i).show();
            });
            $('body').on('mouseout','.fu',function(){
                var i = $(this).attr("i");
                $(this).siblings('.kla'+i).hide();
            });
        });

        function page(n,s){
            if(n) $("#pageNo").val(n);
            if(s) $("#pageSize").val(s);
            $("#searchForm").attr("action","${ctxweb}/shop/EbAdvertisement/list");
            $("#searchForm").submit();
            return false;
        }
    </script>


    <style type="text/css">
        .sort-column{
            color: #555;
        }

    #searchForm,#inputForm{background:#fff;}
    .nav-tabs>.active>a{border-top:3px solid #009688;color:#009688;}
      .nav-tabs>li>a{color:#000;}
      .pagination{padding-bottom:25px;}
      .ibox-content{margin:0 30px;}
      body{background:#f5f5f5;}
      .ibox-content{background:#fff;}
      .nav{margin-bottom:0;}
      .form-horizontal{margin:0;}
      .nav-tabs{border-bottom:0;}
    </style>
</head>
<body>
	<div style="color:#999;padding:19px 0 17px 30px;background:#f5f5f5;">
		<span>当前位置：</span><span>门店管理 - </span><span style="color:#009688;">收银端广告</span>
	</div>
<div class="ibox-content">
    <form id="searchForm" action="${ctxweb}/shop/EbAdvertisement/list" method="post"
               class="breadcrumb form-search ">
        <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
        <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>

    </form>
    <input type="hidden" name="pictureUrl" id="ctxweb" value="${ctxweb}"/>
    <ul class="nav nav-tabs">
        <li class="active"><a href="">广告列表</a></li>
    </ul>
    <table class="table table-striped table-bordered table-hover dataTables-example">
        <thead>
            <tr>
                <th class="sort-column loginName">广告名字</th>
                <th class="sort-column name">创建时间</th>
                <th>广告内容</th>
                <th>广告图片</th>
                <th>操作</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${page.list}" var="list">
                <tr class="gradeX">
                    <td>${list.asName}</td>
                    <td>${list.createTime}</td>
                    <td>${list.asContent}</td>
                    <td>
                        <c:if test="${not empty list.asPic}">
                            <c:set value="${fn:split(list.asPic,',')}" var="imgurls" />
                            <c:forEach items="${imgurls}" var="imgBO" varStatus="i">
                                <img src="${ctxweb}${imgBO}" width="50" class="fu" i="${i.index }"/>
                                <img class="kla${i.index }" style="position: fixed; top: 5%; left: 60%; display: none; width:10%;" alt="" src="${ctxweb}${imgBO}"  />
                            </c:forEach>
                        </c:if>
                    </td>
                    <td>
                        <a style="color:#009688; " href="${ctxweb}/shop/EbAdvertisement/download?pictureUrl=${list.asPic}">修改</a>
                        <label style="color:#009688; " onclick="comtit(${list.id},${list.isEbAdvertisementShop})" id="ebAdvertisementShop">
                            <c:if test="${not empty list.ebAdvertisementShop}">
                                禁用
                            </c:if>
                            <c:if test="${empty list.ebAdvertisementShop}">
                                启用
                            </c:if>
                        </label>

                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    <div class="pagination">${page}</div>
</div>
<%--<script type="text/javascript">
    var ctxweb=$("#ctxweb").val();
    function nextstepn(obj) {
        var url=$(obj).attr("pid");
        var arrl=url.split(",");
        for ( var i = 0; i <arrl.length; i++){
            console.log(arrl[i])
            $("#urls").val(arrl[i]);
            $("#searchForm").attr("action", ctxweb+"/shop/EbAdvertisement/download");
            $("#searchForm").submit();
            break;
        }
    }
</script>--%>
<script>
    var ctxweb=$("#ctxweb").val();
    function comtit(id,ebAdvertisementShop) {
        var a='';
        if(ebAdvertisementShop==1){
            a='禁用';
        }else{
            a='启用';
        }
        var r=confirm("确定"+a+"吗？");
        if(r){
            $.ajax({
                url: ctxweb+"/shop/EbAdvertisement/ebAdvertisementShop",
                data:{id:id},
                success: function(data) {
                    page();
                },
                error: function(e) {

                }
            });
            // window.location.href=+'?id='+;
        }
    }

</script>
</body>
</html>