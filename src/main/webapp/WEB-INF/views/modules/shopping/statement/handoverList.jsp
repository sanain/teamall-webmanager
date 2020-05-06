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
		$("#searchForm").attr("action","${ctxsys}/statement/handoverList");
		$("#searchForm").submit();
		return false;
	}
</script>
    <style>
        .check{position: fixed;top:0;left: 0;right: 0;bottom: 0;background: rgba(0,0,0,0.3);z-index: 10000}
        .check-box{width: 750px;background: #ffffff;position: absolute;top: 50%;left: 50%;margin-left: -375px;margin-top: -200px;}
        .check-box>p{height: 35px;line-height: 35px;background: #f0f0f0;position: relative;text-align: center}
        .check-box>p img{position: absolute;top:12px;right: 15px;cursor: pointer}
        .check-box ul{overflow: hidden;padding: 10px;outline:none;list-style:none}
        .check-box ul li.checkbox{float: left;width: 30%;line-height: 30px;margin-top: 0;}
        .check-box ul li.checkbox input{position:relative;left:8px}
        .check-btn{text-align: center;padding-bottom: 20px}
        .check-btn a{display: inline-block;width: 80px;height: 30px;line-height: 30px;border-radius: 5px;border: 1px solid #dcdcdc}
        .check-btn a:nth-child(1){background: #68C250;border: 1px solid #68C250;color: #ffffff;margin-right: 5px}
        .check-btn a:nth-child(2){color: #666666;margin-left: 5px}
        .check-box .checkbox input[type="checkbox"]:checked + label::before {
            background: #68C250;
            top:0px;
            border: 1px solid #68C250;
        }
        .check-box .checkbox label::before{
            top: 0px;
        }
        .check-box .checkbox i{
            position: absolute;
            width: 12px;
            height: 8px;
            background: url(../images/icon_pick.png) no-repeat;
            top: 4px;
            left: -18px;
            cursor: pointer;
        }
        .check-box .checkbox input{top: 10px;position:relative}
    </style>
    <style type="text/css">
        .title-tr span{
            padding: 0px;
            margin: 0px;
            float: none;
            text-align: center;
            cursor: pointer;
        }

        .sore-th:hover{
            color: #69AC72;
        }
        #contentTable td , #contentTable td{
            text-align: left;
        }
    </style>
    <link rel="stylesheet" href="${ctxStatic}/layui/css/layui.css"  media="all">
    <script type="text/javascript" src="${ctxStatic}/layui/layui.js"></script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a>每日统计</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="pmShopUser" action="${ctxsys}/statement/handoverList" method="post" class="breadcrumb form-search ">
		<input path="userId" type="hidden"/>
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
		<ul class="ul-form">
		  <li><label>员工名字:</label> <input type="text" style=" width: 100px;" name="username"   value="${pmShopUser.username}" placeholder=""/></li>
		  <li><label>员工编号:</label><input  type="text" name="jobNumber"   style=" width: 100px;" value="${pmShopUser.jobNumber}" placeholder=""/></li>
		  <li> &nbsp;&nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/></li>
		  <li><input id="btnExport" class="btn btn-primary check-a1" type="button" value="导出"/></li>

            <div class="check1">
                <div class="check-box">
                    <p>导出选项<img class="check-del1" src="${ctxStatic}/sbShop/images/xxx-rzt.png" alt=""></p>
                    <ul class="mn1">
                        <li class="checkbox"><input type="checkbox" class="kl" value="" id="all"><label><i></i>全选</label></li>
                        <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="1"><label><i></i>开始时间</label></li>
                        <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="2"><label><i></i>结束时间</label></li>
                        <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="3"><label><i></i>收银员姓名</label></li>
                        <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="4"><label><i></i>收银员编号</label></li>
                        <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="5"><label><i></i>销售总额</label></li>
                        <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="6"><label><i></i>现金支付</label></li>
                        <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="7"><label><i></i>微信支付</label></li>
                        <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="8"><label><i></i>支付宝</label></li>
                        <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="9"><label><i></i>余额</label></li>
                        <li class="checkbox"><input type="checkbox" class="kl" name="syllable" value="10"><label><i></i>实收金额</label></li>
                    </ul>
                    <div class="check-btn">
                        <a href="javascript:;" id="fromNewActionSbM" >确定</a>
                        <a class="check-del1" href="javascript:;">取消</a>
                    </div>
                </div>
            </div>

		</ul>
	</form:form>
	<tags:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed" >
		<tr class="title-tr">
			  <th><span>开始时间</span></th>
              <th><span>结束时间</span></th>
              <th><span>收银员姓名</span></th>
              <th><span>收银员编号</span></th>

              <th class="sore-th" onclick="sortTable(this)"><span>销售总额</span><span class="flag-span">↕</span></th>
                <c:forEach items="${allPay}" var="pay" varStatus="vs">
                    <th class="sore-th" onclick="sortTable(this)"><span>${pay[1]}</span><span class="flag-span">↕</span></th>
                </c:forEach>
              <th class="sore-th" onclick="sortTable(9)"><span>实收金额</span><span class="flag-span">↕</span></th>
		</tr>
		<c:forEach items="${page.list}" var="statistics" varStatus="i">
			<tr id="${pack.id}" class="data-tr">
				<td> ${statistics.loginTime}</td>
				<td> ${statistics.loginOutTime}</td>
                <td>${shopUsersList[i.index].username}</td>
                <td>${shopUsersList[i.index].jobNumber}</td>
                <td >${statistics.totalAmt}</td>
                <c:forEach items="${allPay}" var="pay" varStatus="vs">
                    <td class="no-sore">
                        <c:forEach var="source" items="${sourceList[i.index]}">
                            <c:if test="${source.payType == pay[0]}">
                                ${source.realAmount}
                            </c:if>
                        </c:forEach>
                    </td>
                </c:forEach>
                <td >${statistics.netReceiptsAmt}</td>
			</tr>
		</c:forEach>
	</table>
    <table class="layui-hide" id="test">

    </table>
	<div class="pagination">${page}</div>
	<script type="text/javascript">
        var dataArr = new Array();
        var fieldIndex ;

        function sortTable(element){
            var index = $(element).index()
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
    <%--导出的脚本--%>
    <script type="text/javascript">
        $(function(){
            $('.check1').hide();
            $('body').on('click','.check-a1',function(){
                $('.check1').show();
            });

            $('body').on('click','.check-del1',function(){
                $('.check1').hide();
            });
        });

        $('#all').click(function(){
            if($(this).is(':checked')){
                $('.kl').prop('checked',true).attr('checked',true);
                $('#all').prop('checked',true).attr('checked',true);
            }else {
                $('.kl').removeAttr('checked');
                $('#all').removeAttr('checked');
            }
        });

        $('body').on('click','.kl',function(){
            if ($('.kl').length==$('.kl[type=checkbox]:checked').length){
                $('#all').prop('checked',true).attr('checked',true);
            }else {
                $('#all').removeAttr('checked');
            }
        })

        $('#fromNewActionSbM').click(function(){
            $.ajax({
                type : "post",
                data:$('#searchForm').serialize(),
                url : "${ctxsys}/statement/handoverExsel",
                success : function (data) {
                    window.location.href=data;
                }
            });
        });
    </script>

</body>
</html>