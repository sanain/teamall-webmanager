<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <meta name="decorator" content="default"/>
    <title>${sysSource.id == null ? "资源添加":"资源修改"}</title>
    <script type="text/javascript" src="${ctxStatic}/jquery-validation/1.11.0/lib/jquery-1.9.0.js"></script>
    <script type="text/javascript" src="${ctxStatic}/jquery-validation/1.11.0/jquery.validate.js"></script>
    <script type="text/javascript" src="${ctxStatic}/ckfinder/ckfinder.js"></script>
    <link href="${ctxStatic}/supplyshop/layui/css/modules/layer/default/layer.css?v=1" type="text/css" rel="stylesheet" />
    <script src="${ctxStatic}/supplyshop/layui/lay/modules/layer.js?v=1" type="text/javascript"></script>

    <script type="text/javascript">
        $(document).ready(function() {

        });

    </script>

    <script type="text/javascript">
        function submitData(){
            if(!verification()){
                return ;
            }

            $.ajax({
                url:"${ctxsys}/sysSource/save",
                type:"post",
                data:$("#inputForm").serialize(),
                success:function(data){
                    layer.confirm(data.msg,{title:"操作结果"},function(){
                        window.location.href="${ctxsys}/sysSource/list"
                    })
                }
            })
        }

        function verification(){
            var eleArr = new Array();
            var promptArr = new Array();
            debugger;
            if($("[name='contentType']").val() == 1){
                $("[name='value']").val($("#value1").val())
            }else{
                $("[name='value']").val($("#value2").val())
            }
            eleArr.push($("[name='value']"));
            eleArr.push($("[name='contentType']"));
            eleArr.push($("[name='sourceType']"));
            eleArr.push($("[name='positionType']"));
            eleArr.push($("[name='sort']"));
            eleArr.push($("[name='description']"));

            promptArr.push("请输入内容");
            promptArr.push("请选择内容类型");
            promptArr.push("请选择来源类型");
            promptArr.push("请选择位置类型");
            promptArr.push("请输入排序");
            promptArr.push("请输入描述");

            for(var i = 0 ; i < eleArr.length ; i++){
                if(eleArr[i].val() == undefined || eleArr[i].val().trim().length == 0){
                    layer.msg(promptArr[i]);
                    return false;
                }
            }

            return true;
        }
    </script>
</head>
<body>
<ul class="nav nav-tabs">
    <li ><a href="${ctxsys}/sysSource/list">资源列表</a></li>
    <shiro:hasPermission name="merchandise:sysSource:view">
        <li class="active"><a href="${ctxsys}/sysSource/form?id=${sysSource.id}">
                ${sysSource.id == null ? "资源添加":"资源修改"}
        </a></li>
    </shiro:hasPermission>
</ul>

<tags:message content="${message}"/>
<form:form id="inputForm"  modelAttribute="sysSource" action="${ctxsys}/sysSource/save"  method="post" class="form-horizontal">
    <form:hidden path="id"/>
    <div class="control-group">
        <label class="control-label">内容：</label>
        <form:hidden path="value" htmlEscape="false" maxlength="50" />
        <div class="controls" id="value-div1">
            <input id="value1" type="text" value="${sysSource.value}" htmlEscape="false" maxlength="50" />
        </div>
        <div class="controls" id="value-div2">
            <input type="hidden" id="value2" value="${sysSource.value}" htmlEscape="false" maxlength="100"  class="input-xlarge"/>
            <tags:ckfinder input="value2" type="images" uploadPath="/merchandise/sysSource"/>
        </div>
        </div>
        <%--<div class="controls" id="value-div2"--%>
                <%--<c:if test="${empty sysSource.contentType || sysSource.contentType == 1}">--%>
                    <%--style="display: none"--%>
                <%--</c:if>--%>
        <%-->--%>
            <%--&lt;%&ndash;<c:if test="${contentType == 2}">&ndash;%&gt;--%>
                <%--<input type="hidden" id="contentImgs"  value="${sysSource.value}" htmlEscape="false" maxlength="100"  class="input-xlarge"/>--%>
                <%--<tags:ckfinder input="contentImgs" type="images" selectMultiple="true" uploadPath="/merchandise/sysSource"/>--%>
                <%--&lt;%&ndash;<input type="hidden" name="prdouctImg" id="prdouctImg" value="${ebProduct.prdouctImg}"   htmlEscape="false" maxlength="100"  class="input-xlarge"/>&ndash;%&gt;--%>
                <%--&lt;%&ndash;<span class="help-inline" id="prdouctImg"  style="color: blue;"></span>&ndash;%&gt;--%>
                <%--&lt;%&ndash;<tags:ckfinder input="prdouctImg" type="images" selectMultiple="true" uploadPath="/merchandise/product/adImg"/>&ndash;%&gt;--%>

            <%--&lt;%&ndash;</c:if>&ndash;%&gt;--%>
        <%--</div>--%>
    </div>
    <div class="control-group type1-div">
        <label class="control-label" >内容类型：</label>
        <div class="controls">
            <select id="type1" name="contentType" onchange="changeType(this.value,1)">
                <option value="">请选择</option>
            </select>
        </div>
    </div>

    <div class="control-group type2-div">
        <label class="control-label">来源类型：</label>
        <div class="controls">
            <select id="type2" name="sourceType" onchange="changeType(this.value,2)">
                <option value="">请选择</option>
            </select>
        </div>
    </div>

    <div class="control-group type3-div">
        <label class="control-label">位置类型：</label>
        <div class="controls">
            <select id="type3" name="positionType" >
                <option value="">请选择</option>
            </select>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">排序：</label>
        <div class="controls">
                <input type="number" id="sort" name="sort" value="${sysSource.sort}" htmlEscape="false" maxlength="50"/>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">描述：</label>
        <div class="controls">
            <textarea cols="50" rows="5" id="description" name="description">${sysSource.description}</textarea>
        </div>
    </div>
    <div class="form-actions">
        <shiro:hasPermission name="merchandise:sysSource:edit">
            <input id="btnSubmit" class="btn btn-primary" type="button" onclick="submitData()" value="提交"/>&nbsp;
        </shiro:hasPermission>
        <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
    </div>
</form:form>

<script type="text/javascript">

    $(function(){
        $("#type3").hide();
        $("#type2").hide();
        $(".type2-div").css("display","none");
        $(".type3-div").css("display","none");
        debugger;
        getType("${sysSource.contentType}",'1',"${sysSource.contentType}");

        if("${sysSource.contentType}"!=null&&"${sysSource.contentType}"!=''&&"${sysSource.contentType}"!=undefined){
            getType("${sysSource.contentType}",'2',"${sysSource.sourceType}");
        }
        if("${sysSource.sourceType}"!=null&&"${sysSource.sourceType}"!=''&&"${sysSource.sourceType}"!=undefined){
            getType("${sysSource.sourceType}",'3',"${sysSource.positionType}");
        }
        contentShow();
        //监控内容类型切换
        $("#type1").change(function () {
            contentShow();
        })

    })

    //加载类别
    function getType(typeId,levelNum , chooseTypeId){
        var html="<option value=''>请选择</option>";

        if(levelNum=='2'){
            $("#type2").show();
            $("#type3").hide();
            $(".type2-div").css("display","block");
            $(".type3-div").css("display","none");
        }else if(levelNum=='3'){
            $(".type3-div").css("display","block");
            $("#type3").show();
        }

        $.ajax({
            type: "POST",
            url:"${ctxsys}/sysSource/getTypes",
            data:{
                typeId:typeId,
                levelNum:levelNum
            },
            async: false,
            success: function(result){
                if(result.code != "01"){
                    alert(result.msg);
                    return ;
                }
                console.log(result);
                if(levelNum == 1){
                    chooseTypeId = typeId;
                }
                for(var i=0;i<result.data.length;i++){
                    console.log(result.data[i].label);
                    if(result.data[i].id==chooseTypeId){
                        html+="<option value="+result.data[i].id+"  selected = 'selected' > "+result.data[i].label+"</option>";
                    }else{
                        html+="<option value="+result.data[i].id+" > "+result.data[i].label+"</option>";
                    }
                }
                if(levelNum=='1'){
                    $("#type1").html(html);
                }else if(levelNum=='2'){
                    $("#type2").html(html);
                }else{
                    $("#type3").html(html);
                }
            }
        });
    }

    function changeType(typeId,levelNum ){
        var html="<option value=''>请选择</option>";

        if(levelNum=='1'){
            $("#type2").show();
            $("#type3").hide();
            $(".type2-div").css("display","block");
            $(".type3-div").css("display","none");
        }else if(levelNum=='2'){
            $("#type3").show();
            $(".type3-div").css("display","block");
        }

        $.ajax({
            type: "POST",
            url:"${ctxsys}/sysSource/getTypes",
            data:{
                typeId:typeId,
                levelNum:levelNum+1
            },
            success: function(result){
                if(result.code != "01"){
                    alert(result.msg);
                    return ;
                }
                console.log(result);

                for(var i=0;i<result.data.length;i++){
                    console.log(result.data[i].label);

                        html+="<option value="+result.data[i].id+" > "+result.data[i].label+"</option>";

                }
                if(levelNum=='1'){
                    $("#type2").html(html);
                }else{
                    $("#type3").html(html);
                }
            }
        });
    }
    <%--function getFirstLevel(chooseTypeId){--%>
        <%--$.ajax({--%>
            <%--type: "POST",--%>
            <%--url:"${ctxsys}/sysSource/getTypes",--%>
            <%--data:{--%>
                <%--typeId:typeId,--%>
                <%--levelNum:levelNum--%>
            <%--},--%>
            <%--success: function(data){--%>
                <%--if(data.msg != "01"){--%>
                    <%--alert(data.msg);--%>
                    <%--return ;--%>
                <%--}--%>
                <%--console.log(data);--%>
                <%--for(var i=0;i<data.length;i++){--%>
                    <%--console.log(data[i].label);--%>
                    <%--if(data[i].id==chooseTypeId){--%>
                        <%--html+="<option value="+data[i].id+"  selected = 'selected' > "+data[i].productTypeName+"</option>";--%>
                    <%--}else{--%>
                        <%--html+="<option value="+data[i].id+" > "+data[i].productTypeName+"</option>";--%>
                    <%--}--%>
                <%--}--%>
                <%--if(type=='1'){--%>
                    <%--$("#type2").html(html);--%>
                <%--}else{--%>
                    <%--$("#type3").html(html);--%>
                <%--}--%>
            <%--}--%>
        <%--});--%>
    <%--}--%>


    function contentShow(){
        debugger;
        // $("[name='value']").removeAttr("value");
        if($("[name='contentType']").val() == 1){
            $("#value-div2").css("display","none");
            $("#value-div1").css("display","block");

            $("#value2").val("")
            $("#value2Preview").empty();
            // $("#value-div2").find("#value").removeAttr("name")
            // $("#value-div2").find("[name='value']").val("")
            // $("#value-div1").find("#value").attr("name","value")
        }else{
            $("#value-div2").css("display","block");
            $("#value-div1").css("display","none");

            $("#value1").val("");

            // $("#value-div1").find("#value").removeAttr("name")
            // $("#value-div1").find
            // $("#value-div2").find("#value").attr("name","value")
        }
    }
</script>
</body>
</html>