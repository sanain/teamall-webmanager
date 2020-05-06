<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>人员管理</title>
    <meta name="decorator" content="default"/>
    <script type="text/javascript">

        function page(n, s) {
            if (n) $("#pageNo").val(n);
            if (s) $("#pageSize").val(s);
            $("#searchForm").attr("action", "${ctxsys}/ticket/ticketList");
            $("#searchForm").submit();
            return false;
        }
    </script>
    <script type="text/javascript">
        // 隐藏弹框
        function hide1() {
            $('#modal-overlays1').css("display","none");
        }
        // 显示弹框
        function show1(ebTicketId) {
            $('#modal-overlays1').css("display","block");
            $.ajax({
                type : "POST",
                url : "${ctxsys}/ticket/ebTicketReplace", //请求的url地址
                data:{id:ebTicketId},
                success : function(data) {
                    if(data.ebTicket.size==58){
                        $(".mod1").val(data.templateText);
                        $(".preview-con").eq(0).show().siblings().hide();
                    }else{
                        $(".mod2").val(data.templateText);
                        $(".preview-con").eq(1).show().siblings().hide();
                    }
                }
            });
        }
        // 显示弹框
        function show(ebTicketType,ebTicketId,title,state,type) {
            $('#modal-overlays').css("display","block");
            $('#ebTicketId').val(ebTicketId);
            $('#type').val(type);
            if(ebTicketType=='1'){
                $('#title').html(title);
            }else{
                if(state=='0'){
                    $('#title').html('确定启用小票模板？');
                }else{
                    $('#title').html('确定禁用小票模板？');
                }
            }

            $('#ebTicketType').val(ebTicketType);
        }
        // 隐藏弹框
        function hide() {
            $('#modal-overlays').css("display","none");
        }
        //确定
        function update() {
            var ebTicketType=$('#ebTicketType').val();
            if(ebTicketType=='1'){
                del();
            }else{
                state();
            }

        }

        function state() {
            var id = $('#ebTicketId').val();
            var type = $('#type').val();
            var params = {
                id: id,
                type: type
            }
            $.ajax({
                type: "post",
                url: "${ctxsys}/ticket/stateTicket",
                data: params,
                beforeSend: function () {

                },
                success: function (data) {
                    alert(data.msg);
                    if(data.code=="00") {
                        hide();
                        page('', '');
                    }
                }
                , error: function (res) {
                    alert("执行失败");
                }
            })
        }
        function del() {
            var id = $('#ebTicketId').val();
            var params = {
                id: id,
            }
            $.ajax({
                type: "post",
                url: "${ctxsys}/ticket/delTicket",
                data: params,
                beforeSend: function () {

                },
                success: function (data) {
                    alert(data.msg);
                    if(data.code=="00") {
                        hide();
                        page('', '');
                    }
                }
                , error: function (res) {
                    alert("执行失败");
                }
            })
        }
    </script>
    <style type="text/css">
        a{
            color:#009688;
        }
        a:hover{
            color:#009688;
        }
    </style>
    <style>
        /* 定义模态对话框外面的覆盖层样式 */
        #modal-overlays {
            display: none;
            position: absolute; /* 使用绝对定位或固定定位  */
            left: 0px;
            top: 0px;
            width: 100%;
            height: 100%;
            text-align: center;
            z-index: 1000;
            background-color: #3333;
            cursor:pointer;
        }

        /* 模态框样式 */
        .modal-data {
            width: 200px;
            height:80px;
            margin: 140px auto;
            background-color: #fff;
            border: 1px solid #000;
            border-color: #ffff;
            padding: 15px;
            text-align: center;
            cursor:pointer;
        }
    </style>
    <style>
        /* 定义模态对话框外面的覆盖层样式 */
        #modal-overlays1 {
            display: none;
            position: absolute; /* 使用绝对定位或固定定位  */
            left: 0px;
            top: 0px;
            width: 100%;
            height: 1000px;
            text-align: center;
            z-index: 1000;
            background-color: #3333;
            cursor:pointer;
        }

        /* 模态框样式 */
        .modal-data1 {
            width: 450px;
            height:750px;
            margin:50px auto;
            background-color: #fff;
            border: 1px solid #000;
            border-color: #ffff;
            padding: 15px;
            text-align: center;
            cursor:pointer;
        }
    </style>
    <style>
        .preview{background:#f3f3f3;height:610px;padding-bottom: 80px;}
        .preview1{width:264px;height:99%;margin:0 auto;}
        .preview2{width:100%;height:99%;margin:0 auto;padding-left: 12px;}
        .preview-con,.contentbox{display:none;}

    </style>
</head>
<body>
<form action="" id="searchForm" method="post" >
<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
</form>
<div class="ibox-content">
    <ul class="nav nav-tabs">
        <li class="active"><a href="#">小票模板</a></li>
        <li><a href="${ctxsys}/ticket/ticketForm">添加模板</a></li>
    </ul>
    <table class="table table-striped table-bordered table-hover dataTables-example">
        <thead>
            <tr>
                <th>序号</th>
                <th>模板类型</th>
                <th>模板名称</th>
                <th>大小（mm）</th>
                <th>创建时间</th>
                <th>当前状态</th>
                <th>操作</th>
            </tr>
        </thead>
        <tbody>
        <c:forEach items="${page.list}" var="ebTickets" varStatus="status">
            <tr>
                <th>${status.index+1}</th>
                <th>
                    <c:if test="${ebTickets.type==1}">收银留底</c:if>
                    <c:if test="${ebTickets.type==2}">外卖配送</c:if>
                </th>
                <th>${ebTickets.modelName}</th>
                <th>${ebTickets.size}mm</th>
                <th>${ebTickets.creationTime}</th>
                <th><a onclick="show('2','${ebTickets.id}','','${ebTickets.state}','${ebTickets.type}')" style="margin-left: 10px;cursor:pointer;"><c:if test="${ebTickets.state==0}">禁用</c:if><c:if test="${ebTickets.state==1}">启用</c:if></a></th>
                <th><a onclick="show('1','${ebTickets.id}','确定删除${ebTickets.modelName}模板？','','${ebTickets.type}')" style="color:red;cursor:pointer;">删除</a>
                    <a onclick="show1('${ebTickets.id}')" style="margin-left: 10px;color:blue;cursor:pointer;">预览</a>
                </th>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
<div class="pagination">${page}</div>
<div id="modal-overlays">
    <div class="modal-data">
        <div class="msg-btn">
            <label id="title" style="margin-top:10px;">标题</label>
            <input type="hidden" id="ebTicketId">
            <input type="hidden" id="ebTicketType">
            <input type="hidden" id="type">
        </div>
        <div class="msg-btn">
            <a onclick="update()" style="background-color:#4778C7;width:50px;height:30px;line-height:30px;color:#fff;margin-top:20px;display: inline-block;">确定</a>
            <a onclick="hide()" style="background-color:#999;width:50px;height:30px;line-height:30px;color:#fff;margin-top:20px;display: inline-block;">取消</a>
        </div>
    </div>
</div>
<div id="modal-overlays1">
    <div class="modal-data1">
        <div class="msg-btn1">
            <div class="preview">
                <div class="preview1 preview-con" style="display: block;">
                <textarea class="mod1" style="border: 0;padding-top:20px;background: url('${ctxStatic}/images/xiaopiaobeijing2.png')center center;background-size:100% 100%;
                        margin: 0px;resize:none; width: 262px; height: 604px;    padding-top: 45px;
                        padding-left: 10px;
                        padding-right: 10px;" readonly="readonly">模板1</textarea>
                </div>
                <div class="preview2 preview-con">
                <textarea class="mod2" style="border: 0;padding-top:20px;background: url('${ctxStatic}/images/xiaopiaobeijing2.png')center center;background-size:100% 100%;
                        margin: 0px; resize:none; width: 336px; height: 602px;   padding-top: 45px; padding-left: 10px;
                        padding-right: 10px;" readonly="readonly">模板2</textarea>
                </div>
            </div>
        </div>
        <div class="msg-btn1">
            <a onclick="hide1()" style="background-color:#999;width:50px;height:30px;line-height:30px;color:#fff;margin-top:20px;display: inline-block;">关闭</a>
        </div>
    </div>
</div>
</body>

</html>