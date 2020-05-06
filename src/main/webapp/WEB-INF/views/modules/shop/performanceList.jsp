<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>交班统计列表</title>
    <meta name="decorator" content="default"/>
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/build.css">
    <script type="text/javascript">

        function page(n,s){
            if(n) $("#pageNo").val(n);
            if(s) $("#pageSize").val(s);
            $("#searchForm").attr("action","${ctxweb}/shop//shop/user/performanceList");
            $("#searchForm").submit();
            return false;
        }
    </script>

    <style type="text/css">
        .title-tr span{
            padding: 0px;
            margin: 0px;
            float: none;
            text-align: center;
            cursor: pointer;
        }


        .sore-th{
            color: #009688;
        }

        #btnSubmit{
            background:#393D49;
            margin-left: 25px;
        }
        #contentTable td , #contentTable td{
            text-align: left;
        }

        body{
            padding: 0px 20px;
        }
        .nav-tabs>li{width:130px;text-align:center;}
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
        
    </style>
</head>
<body>
<div style="color:#999;padding:19px 0 17px 30px;background:#f5f5f5;">
		<span>当前位置：</span><span>人员设置 - </span><span style="color:#009688;">业绩查看</span>
</div>

<div class="ibox-content">
<ul class="nav nav-tabs">
    <li class="active"><a>每日统计</a></li>
</ul>
<form:form id="searchForm" modelAttribute="pmShopUser" action="${ctxweb}/shop//shop/user/performanceList" method="post" class="breadcrumb form-search ">
    <input path="userId" type="hidden"/>
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
    <input id="shopId" name="shopId" type="hidden" value="${pmShopUser.shopId}"/>
    <tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
    <ul class="ul-form" style="margin-top:10px;">
        <li><label style="margin-right:10px;">员工名字:</label> <input type="text" style=" width: 230px;height:30px;padding:0;" name="username"   value="${pmShopUser.username}" placeholder=""/></li>
        <li> &nbsp;&nbsp;<input id="btnSubmit" style="width:80px;" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/></li>
        <div class="check1">
        </div>
    </ul>
</form:form>
<tags:message content="${message}"/>
<table id="contentTable" class="table table-striped table-bordered table-condensed" >
    <tr class="title-tr">
        <th><span>日期</span></th>
        <th><span>收银员姓名</span></th>
        <th class="sore-th" onclick="sortTable(2)"><span>交易单数</span><span class="flag-span">↕</span></th>
        <th class="sore-th" onclick="sortTable(3)"><span>总价</span><span class="flag-span">↕</span></th>
        <th class="sore-th" onclick="sortTable(4)"><span>实收</span><span class="flag-span">↕</span></th>
    </tr>
    <c:forEach items="${page.list}" var="statistics" varStatus="i">
        <tr id="${pack.id}" class="data-tr">
            <td> ${statistics.totalTime}</td>
            <td>${shopUsersList[i.index].username}</td>
            <td >${statistics.orderNumber}</td>
            <td >${statistics.totalAmt}</td>
            <td >${statistics.netReceiptsAmt}</td>
        </tr>
    </c:forEach>
</table>

<div class="pagination">${page}</div>
</div>
<script type="text/javascript">
    var dataArr = new Array();
    var fieldIndex ;

    function sortTable(index){

        fieldIndex = index;

        getDataArr();

        if($(".title-tr th").eq(fieldIndex).hasClass("desc-sort")){
            $(".title-tr th").removeClass("desc-sort");
            $(".title-tr th").removeClass("asc-sort");
            $(".title-tr .flag-span").text("↕")

            dataArr.sort(ascSort);

            $(".title-tr th").eq(fieldIndex).addClass("asc-sort");
            $(".title-tr th").eq(fieldIndex).find(".flag-span").text("↑");
        }else{
            $(".title-tr th").removeClass("desc-sort");
            $(".title-tr th").removeClass("asc-sort");
            $(".title-tr .flag-span").text("↕")

            dataArr.sort(descSort);
            $(".title-tr th").eq(fieldIndex).addClass("desc-sort");
            $(".title-tr th").eq(fieldIndex).find(".flag-span").text("↓");
        }

        overWriteTable();
    }

    /**
     * 收集表格的数据
     * */
    function getDataArr(){
        var dataTrArr = $(".data-tr");
        dataArr = new Array();

        for(var i = 0 ; i < dataTrArr.size() ; i++){
            var tdArr = $(dataTrArr[i]).find("td");  //列的数组
            var tdDataArr = new Array();    //每行的数据

            for(var j = 0 ; j < tdArr.size() ; j++){
                if($(tdArr[j]).text().trim() == ""){
                    tdDataArr.push(-999);
                }else{
                    tdDataArr.push($(tdArr[j]).text().trim());
                }

            }

            dataArr.push(tdDataArr);
        }
    }
    /**
     * 升序
     * @param a
     * @param b
     * @returns {number}
     */
    function ascSort(a ,b){
        var sortValue1 = a[fieldIndex];
        var sortValue2 = b[fieldIndex];

        return sortValue1 - sortValue2;
    }


    /**
     * 降序
     * @param a
     * @param b
     * @returns {number}
     */
    function descSort(a ,b){
        var sortValue1 = a[fieldIndex];
        var sortValue2 = b[fieldIndex];

        return sortValue2 - sortValue1;
    }

    /**
     * 根据排序重写表格的内容
     */
    function overWriteTable(){
        var dataTrArr = $(".data-tr");

        for(var i = 0 ; i < dataTrArr.size() ; i++){
            var tdArr = $(dataTrArr[i]).find("td");  //列的数组
            var tdDataArr = dataArr[i];    //每行的数据

            for(var j = 0 ; j < tdArr.size() ; j++){
                if(tdDataArr[j] == -999){
                    $(tdArr[j]).text("")
                }else{
                    $(tdArr[j]).text(tdDataArr[j])
                }

            }

            dataArr.push(tdDataArr);
        }
    }
</script>
</body>
</html>