<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>代理商列表</title>
    <meta name="decorator" content="default"/>
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/build.css?v=1">
    <style>
        /*运动的球效果*/
        .run-ball-box{
            text-align: center;
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(0,0,0,0.3);
            color: #ffffff;
            z-index:100000000;
        }
        .run-ball {
            background-color: #69AC72;
            width: 60px;
            height: 60px;
            border-radius: 100%;
            -webkit-animation: sk-innerCircle 1s linear infinite;
            -moz-animation: sk-innerCircle 1s linear infinite;
            -o-animation: sk-innerCircle 1s linear infinite;
            animation: sk-innerCircle 1s linear infinite;
            position: absolute;
            top: 50%;
            left: 50%;
            margin-top: -30px;
            margin-left: -30px;;
        }
        .sh-ju{
            position: absolute;top: 50%;left: 50%;margin-top: 50px;margin-left: -36px;
        }
        .run-ball .sk-inner-circle {
            display: block;
            background-color: #fff;
            width: 25%;
            height: 25%;
            position: absolute;
            border-radius: 100%;
            top: 5px;
            left: 5px;
        }

        @-webkit-keyframes sk-innerCircle {
            0% {
                -webkit-transform: rotate(0deg);
            }
            100% {
                -webkit-transform: rotate(360deg);
            }
        }
        @-moz-keyframes sk-innerCircle {
            0% {
                -moz-transform: rotate(0deg);
            }
            100% {
                -moz-transform: rotate(360deg);
            }
        }
        @-o-keyframes sk-innerCircle {
            0% {
                -o-transform: rotate(0deg);
            }
            100% {
                -o-transform: rotate(360deg);
            }
        }
        @keyframes sk-innerCircle {
            0% {
                transform: rotate(0deg);
            }
            100% {
                transform: rotate(360deg);
            }
        }
        .sb-xian{padding-bottom: 20px;background: #ffffff;clear:both;margin-bottom:20px}
        .sb-xian>p{height: 35px;line-height: 35px;background: #F0F0F0;color: #4B4B4B;padding-left: 25px}
        .sb-xian .checkbox{display: inline-block}
        .sb-xian>ul{display:none}
        .sb-xian ul li{margin-bottom: 15px;}
        .sb-xian .checkbox i{top:4px;left:-19px}
        .sb-xian ul li:nth-child(1)>span{position:relative;top:-9px}
        .sb-xian ul li>span{display: inline-block;width: 100px;text-align: right;margin-right: 10px;height:30px;line-height:30px}
        .sb-xian input[type=text]{outline: none;border: 1px solid #DCDCDC;padding: 0 10px;height: 30px;}
        .sb-xian ul li:nth-child(2) input{width: 150px;}
        .sb-xian ul li:nth-child(3) input{width: 60px;text-align: center;margin-right: 15px;}
        .sb-xian ul li:nth-child(4) input{width: 60px;text-align: center;margin-right: 15px;}
        .sb-xian-b b{display: inline-block;width: 100px;font-weight: normal;text-align: right;margin-right: 10px;}
        .sb-xian-b{padding-bottom: 15px;margin-bottom: 20px;border-bottom: 1px solid #CCCCCC}
        .sb-xian b{font-weight: normal}
        .norm{display: inline-block;position: relative}
        .norm>span{display: block;cursor: pointer;width: 200px;height: 30px;line-height: 30px;border: 1px solid #DCDCDC;padding-left: 10px;padding-right: 30px;background: url("../images/zhankai1.png") no-repeat 179px 11px;overflow: hidden; text-overflow: ellipsis; white-space: nowrap; word-wrap: break-word}
        .norm-box{position: absolute;width: 350px;display: none}
        .norm-box ul{width: 100%;border: 1px solid #DCDCDC;overflow:hidden}
        .norm-box ul:nth-child(1){background: #f0f0f0;text-align: center;height: 30px;}
        .norm-box ul li:nth-child(1){width: 60%;text-align: center}
        .norm-box ul li:nth-child(2){width: 20%;text-align: center}
        .norm-box ul li:nth-child(3){width: 20%;text-align: center}
        .norm-box ul li{margin-bottom: 0;float:left;line-height:30px;}
        .norm-box ul{background: #ffffff;margin-bottom: 0;}
        .norm-box ul li{text-align: center;height: 30px;border-right: 1px solid #DCDCDC;color: #666666;cursor: pointer}
        .pic-list{padding-left:25px;}
    </style>
    <style>
        .check{position: fixed;top:0;left: 0;right: 0;bottom: 0;background: rgba(0,0,0,0.3);z-index: 10000}
        .check-box{width: 750px;background: #ffffff;position: absolute;top: 50%;left: 50%;margin-left: -375px;margin-top: -200px;}
        .check-box>p{height: 35px;line-height: 35px;background: #f0f0f0;position: relative;text-align: center}
        .check-box>p img{position: absolute;top:12px;right: 15px;cursor: pointer}
        .check-box>p a{color:#68C250;position:absolute;left:15px;top:0px}
        .check-box ul{overflow: hidden;padding: 10px;outline:none;list-style:none}
        .check-box ul li.checkbox{float: left;width: 30%;line-height: 30px;margin-top: 0;}
        .check-box ul li.checkbox input{position:relative;left:8px}
        .check-btn{text-align: center;padding-bottom: 20px}
        .check-btn a{display: inline-block;width: 80px;height: 30px;line-height: 30px;border-radius: 5px;border: 1px solid #dcdcdc}
        .check-btn a:nth-child(1){background: #68C250;border: 1px solid #68C250;color: #ffffff;margin-right: 5px}
        .check-btn a:nth-child(2){color: #666666;margin-left: 5px}
        .check-box .checkbox input[type="checkbox"]:checked + label::before {
            background: #68C250;
            top:0 px;
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
    <script type="text/javascript">
        $(function(){
            eblabelLs();//加载标签
            $(".run-ball-box").hide();
            $("#priceType").val("${priceType}");
            $('body').on('mouseover','.fu',function(){$(this).siblings('.kla').show()});
            $('body').on('mouseout','.fu',function(){$(this).siblings('.kla').hide()});
            $('.check').hide();
            $('body').on('click','.check-a',function(){
                $('.check').show();
            });

            $('body').on('click','.check-del',function(){
                $('.check').hide();
            });



        })
        function writable(a,va){
            $("#ids").val(a);
            var html="";
            $.ajax({
                type: "POST",
                url: "${ctxsys}/Product/classOne",
                data: {"type":"1"},
                success: function(data){
                    for(var i=0;i<data.length;i++){
                        if(va!=null){
                            var strs= new Array();
                            strs= va.split(",");
                            if(strs!=null){
                                html+="<li class='checkbox'><input type='checkbox' name='tag' value='"+data[i].id+"'";
                                for(var j=0;j<strs.length;j++){
                                    if(strs[j]==data[i].id){
                                        html+="  checked='checked'  ";
                                    }
                                }
                                html+="><label><i></i>"+data[i].name+"</label></li>";
                            }
                        }
                    }
                    $(".mn").html(html);
                }
            });
            $('.check').show();
        }
        function sbmit(){
            $("#fromsb").submit();

        }
        function page(n,s){
            if(n) $("#pageNo").val(n);
            if(s) $("#pageSize").val(s);
            $("#searchForm").attr("action","${ctxsys}/pmAgent/chooseAgent");
            $("#searchForm").submit();
            return false;
        }
        function eblabelLs(){
            $.ajax({
                type: "POST",
                url: "${ctxsys}/EbLabel/eblabelLs",
                data: {},
                success: function(data){
                    var html='<option value="">全部</option>';
                    var productTagname="${productTags}";
                    for(var i=0;i<data.length;i++){
                        if(productTagname==data[i].name){
                            html+="<option value="+data[i].name+" selected='selected'>"+data[i].name+"</option>";
                        }else{
                            html+="<option value="+data[i].name+">"+data[i].name+"</option>";
                        }
                    }
                    $("#productTags").html(html);
                }
            });
        }






    </script>
    <script type="text/javascript">
        function loke(vals,id,price,img,redweb,marketPrice,sale,poorTotal,middleTotal,goodTotal){
            window.opener.document.getElementById('advertiseTypeObjIds').value=id;
            if(window.opener.document.getElementById('price')!=null||window.opener.document.getElementById('price')!=undefined){
                window.opener.document.getElementById('price').innerHTML=price;
            }
            if(window.opener.document.getElementById('prices')!=null||window.opener.document.getElementById('prices')!=undefined){
                window.opener.document.getElementById('prices').innerHTML=price;
            }
            var poor = poorTotal == null ? 0 :poorTotal;
            var middle = middleTotal== null ? 0 : middleTotal;
            var good = goodTotal == null ? 0 : goodTotal;
            var all = poor + middle + good;
            var ty = 0;
            if (all != 0) {
                ty = Double.valueOf(good) / Double.valueOf(all);
            }
            if(window.opener.document.getElementById('saleValue')!=null||window.opener.document.getElementById('saleValue')!=undefined){
                window.opener.document.getElementById('saleValue').innerHTML=ty;
            }
            if(window.opener.document.getElementById('marketPrice')!=null||window.opener.document.getElementById('marketPrice')!=undefined){
                window.opener.document.getElementById('marketPrice').innerHTML=marketPrice;
            }
            if(window.opener.document.getElementById('sale')!=null||window.opener.document.getElementById('sale')!=undefined){
                window.opener.document.getElementById('sale').innerHTML=sale;
            }
            if(window.opener.document.getElementById('pname')!=null||window.opener.document.getElementById('pname')!=undefined){
                window.opener.document.getElementById('pname').innerHTML=vals;
            }
            if(window.opener.document.getElementById('imgsval')!=null||window.opener.document.getElementById('imgsval')!=undefined){
                window.opener.document.getElementById('imgsval').src=""+img.split("|")[0];
            }
            if(window.opener.document.getElementById('pname')!=null||window.opener.document.getElementById('pname')!=undefined){
                window.opener.document.getElementById('pname').innerHTML=vals;
                window.opener.document.getElementById('pname').title=vals;
            }
            if(window.opener.document.getElementById('redweb')!=null||window.opener.document.getElementById('redweb')!=undefined){
                window.opener.document.getElementById('redweb').innerHTML=redweb;
            }

            window.open("about:blank","_self").close();
        }
    </script>
</head>
<body>
<div class="run-ball-box">
    <div class="run-ball"><span class="sk-inner-circle"></span></div>
    <div class="sh-ju">数据加载中...</div>
</div>
<ul class="nav nav-tabs">
    <%--<shiro:hasPermission name="merchandise:pro:view"><li class="active"><a href="${ctxsys}/Product/chooseShops">门店列表</a></li></shiro:hasPermission>--%>
</ul>

<form:form id="searchForm" modelAttribute="pmAgent" action="${ctxsys}/pmAgent" method="post" class="breadcrumb form-search ">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
    <input id="chooseIds" name="agentIds" type="hidden" value="${agentIds}" />
    <tags:tableSort id="orderBy" name="orderBy" value="${page.orderBy}" callback="page();"/>
    <ul class="ul-form">

        <li><label>代理商账号:</label><form:input path="agentCode" htmlEscape="false" maxlength="80" class="input-medium"  placeholder=""/></li>
        <li><label>代理商名称:</label><form:input path="agentName" htmlEscape="false" maxlength="80" class="input-medium"  placeholder=""/></li>
        <li style="margin-left:10px">&nbsp;&nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" onclick="return page();"/></li>

    </ul>
</form:form>
<tags:message content="${message}"/>


<table id="treeTable" class="table table-striped table-condensed table-bordered" >
    <tr>
        <th class="center123"></th>
        <th class="center123">编号</th>
        <th class="center123">代理商名称</th>
        <th class="center123">地址</th>
        <th class="center123">创建时间</th>
        <th class="center123" style="display: none">状态</th>
        <shiro:hasPermission name="merchandise:pmAgent:edit">
            <th class="center123">操作</th>
        </shiro:hasPermission>
    </tr>
    <c:forEach items="${page.list}" var="agent" varStatus="status">
        <tr>
            <td class="center123"><input type="checkbox" name="ktvs" class="kty chooseItem"  value="${agent.id}"></td>
            <td class="center123">${agent.agentCode}</td>
            <td class="center123">${fns:abbr(agent.agentName,20)}</td>
            <td class="center123">${fns:abbr(agent.agentName,30)}</td>
            <td class="center123"><fmt:formatDate value="${agent.createTime}" pattern="yyyy-MM-dd"/></td>
            <td class="center123" style="display: none">
                <c:if test="${agent.onlineStatus == 0}">
                    不在线
                </c:if>

                <c:if test="${agent.onlineStatus == 1}">
                    在线
                </c:if>
            </td>
            <td class="center123">
                <shiro:hasPermission name="merchandise:pmAgent:edit">
                    <a href="${ctxsys}/pmAgent/form?agentId=${agent.id}">修改</a>
                    <%--<a href="javascript:;" onclick="deletePmAgent('${agent.id}')">删除</a>--%>
                    <a href="${ctxsys}/pmAgent/delete?agentId=${agent.id}" onclick="return confirmx('确认要删除该用户吗？', this.href)">删除</a>
                </shiro:hasPermission>
            </td>
        </tr>
    </c:forEach>
</table>
<div class="pagination">${page}</div>

<script type="text/javascript">

</script>


<script type="text/javascript">
    var agentIds;

    $(function(){
        if($("#chooseIds").val() == undefined || $("#chooseIds").val() == ""){
            agentIds = new Array();
        }else{
            agentIds = $("#chooseIds").val().split(",");
        }


        //初始化原来已经选好的代理商
        initAlreadyChecked();

        /**
         * 控制选择和取消
         * */
        $(".chooseItem").click(function(){
            if($(this).attr("checked") == "checked"){
                if(agentIds.indexOf($(this).attr("value")) == -1){
                    agentIds.push($(this).attr("value"));
                }
            }else{
                var index = agentIds.indexOf($(this).attr("value"));
                if(index != -1){
                    agentIds.splice(index , 1);
                }
            }
            $("#chooseIds").val(agentIds.toString());
        })
    })

    /**
     * 初始化原来已经选好的门店
     * */
    function initAlreadyChecked(){
        var arr = $(".chooseItem");
        for(var i = 0 ; i < arr.length ; i++){
            if(agentIds.indexOf($(arr[i]).attr("value")) >= 0){
                $(arr[i]).attr("checked",true);
            }
        }
    }

</script>
</body>
</html>