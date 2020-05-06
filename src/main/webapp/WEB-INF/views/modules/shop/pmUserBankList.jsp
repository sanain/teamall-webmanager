<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>商品申请</title>
    <meta name="decorator" content="default"/>

    <script type="text/javascript">
        function page(n, s) {
            if (n) $("#pageNo").val(n);
            if (s) $("#pageSize").val(s);
            $("#searchForm").attr("action", "${ctxweb}/shop/pmUserBank/list");
            $("#searchForm").submit();
            return false;
        }
    </script>
    <style type="text/css">

        #download-file:hover,.btns input:hover{
            color: rgb(120,120,120);
        }

        /*.nav-tabs a{*/
            /*color: rgb(120,120,120);*/
        /*}*/
 		    #searchForm,#inputForm{background:#fff;}
    .nav-tabs>.active>a{border-top:3px solid #009688;color:#009688;}
      .nav-tabs>li>a{color:#000;}
      .pagination{padding-bottom:25px;}
      .ibox-content{margin:0 30px;}
      body{background:#f5f5f5;}
      .ibox-content{background:#fff;}
      .nav{margin-bottom:0;}
      .form-horizontal{margin:0;}
       .breadcrumb{background:#fff;padding:0;}
       .p-xs{margin-top:7px;}
    </style>
</head>
<body>
	<div style="color:#999;padding:19px 0 17px 30px;background:#f5f5f5;">
		<span>当前位置：</span><span>门店管理 - </span><span style="color:#009688;">银行卡管理</span>
	</div>
<div class="ibox-content">
    <ul class="nav nav-tabs">
        <li class="active"><a href="">银行卡列表</a></li>
        <li><a href="${ctxweb}/shop/pmUserBank/form">添加银行卡</a></li>
    </ul>

    <form id="searchForm" modelAttribute="pmUserBank" action="${ctxweb}/shop/ebProductApply/list" method="post"
               class="breadcrumb form-search ">
        <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
        <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
        <tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
        <div class="p-xs">
            <ul class="ul-form">

                <li>
                    <label>关键字：</label>
                    <input id="keyword" name="keyword" type="text" value="${keyword}"/>
                </li>
                <li class="btns"><input style="background: #393D49; " id="btnSubmit" class="btn btn-primary" type="submit" value="查询"
                                        onclick="return page();"/>
                </li>

            </ul>
        </div>
    </form>


    <table class="table table-striped table-bordered table-hover dataTables-example">
        <thead>
            <tr>
                <th>开户名（持卡人）</th>
                <th>交易银行账号</th>
                <th>银行名称（开户行）</th>
                <th>所属支行</th>
                <th>银行预留手机号</th>
                <th>身份证号</th>
                <th>操作</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${page.list}" var="ls">
                    <tr>
                        <th >
                                ${ls.accountName}
                        </th>
                        <th>
                                ${ls.account}
                        </th>
                        <th >
                                ${ls.bankName}
                        </th>
                        <th >
                                ${ls.subbranchName}
                        </th>

                        <th >
                                ${ls.phoneNum}
                        </th>

                        <th >
                                ${ls.idcard}
                        </th>

                        <th>
                            <label  onclick="comtit(${ls.id})" style="color:#0b2c89">移除银行卡</label>
                        </th>
                    </tr>
            </c:forEach>
        </tbody>
    </table>
    <div class="pagination">${page}</div>

</div>
<script>
    function comtit(id) {
        var r=confirm("确定移除银行卡吗？");
        if(r){
            window.location.href='${ctxweb}/shop/pmUserBank/isdelete?pageNo=${page.pageNo}&pageSize=${page.pageSize}&id='+id;
        }
    }

</script>
</body>
</html>