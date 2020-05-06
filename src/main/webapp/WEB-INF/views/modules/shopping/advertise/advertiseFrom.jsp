<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>
        <c:if test="${'0'.equals(isChange)}">
            查看申请详情
        </c:if>
        <c:if test="${!'0'.equals(isChange) && 'add'.equals(flag)}">
            增加广告申请
        </c:if>
        <c:if test="${!'0'.equals(isChange) && !'add'.equals(flag)}">
            修改广告申请
        </c:if>
    </title>
    <meta name="decorator" content="default"/>
    <script type="text/javascript" src="${ctxStatic}/jquery-validation/1.11.0/lib/jquery-1.9.0.js"></script>
    <script type="text/javascript" src="${ctxStatic}/jquery-validation/1.11.0/jquery.validate.js"></script>

    <link rel="stylesheet" href="${ctxStatic}/layui/css/layui.css"  media="all">
    <script src="${ctxStatic}/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript">

        <%--function toProductApplyList(){--%>
            <%--window.location.href='${ctxsys}/ebProductApply'--%>
        <%--}--%>

        $(function(){
            //查看详情情况下不能修改
            if('${isChange}'== '0'){
                $("input").attr("readonly","readonly");
                $("textarea").attr("readonly","readonly");
            }

            if('${flag}' ==  'add'){
                $("#inputForm").attr("action","${ctxsys}/ebShopAdvertise/insertAdvertise")
            }

            if('${flag}' !=  'add'){
                $("#inputForm").attr("action","${ctxsys}/ebShopAdvertise/updateAdvertise")
            }
        })

    </script>

    <script type="text/javascript">
        $(function(){
            if('${prompt}' != ""){
                alert('${prompt}')
            }

            $("#inputForm").submit(function(){
                if($("#name").val() == undefined || $("#name").val().trim()==""){
                    layer.msg("广告名称不能为空！");
                    return false;
                }

                if($("#name").val().length > 20){
                    layer.msg("广告名称不能超过20个字！");
                    return false;
                }

                if($("#test5").val() == undefined || $("#test5").val().trim()==""){
                    layer.msg("有效时间不能为空！");
                    return false;
                }

                if($("#pic").val() == "" && $("input[name='type']:checked").val() == 1){
                    layer.msg("广告图片不能为空！");
                    return false;
                }

                if($("#certificateId").val() == "" && $("input[name='type']:checked").val()==2){
                    layer.msg("优惠券不能为空！");
                    return false;
                }

                return true;
            })
        })

    </script>

    <style type="text/css">
        .control-group .control-label{
            padding-right: 10px;
        }
        .form-check-inline{
            float: left;
            padding-left: 10px;
        }
    </style>
</head>
<body>
<ul class="nav nav-tabs">
    <ul class="nav nav-tabs">
        <li><a style="color: #009688;" href="${ctxsys}/ebShopAdvertise/advertiseList">广告列表</a></li>
        <li  class="active">
            <c:if test="${'add'.equals(flag)}">
                <a  href="${ctxsys}/ebShopAdvertise/advertiseFrom?flag=add">
                    广告增加
                </a>
            </c:if>
            <c:if test="${!'add'.equals(flag)}">
                <a  href="${ctxsys}/ebShopAdvertise/advertiseFrom?id=${ebShopAdvertise.id}">
                    广告修改
                </a>
            </c:if>
        </li>
    </ul>
</ul><br/>
<p id="price" style="display:none;"></p>
<form:form id="inputForm" style="position:relative" modelAttribute="ebShopAdvertise" method="post" class="form-horizontal">

    <form:hidden path="id"  htmlEscape="false" maxlength="20" />
    <div class="control-group">
        <label class="control-label" for="asName">广告名称:</label>
        <div class="controls">
            <form:input path="name"  htmlEscape="false" maxlength="20" />
        </div>
    </div>

    <div class="control-group">
        <label class="control-label" for="name">有效时间:</label>
        <div class="controls">
            <input type="text" name="startTime" readonly="readonly"  value="${ebShopAdvertise.entryTimeStr}" id="test5" placeholder="yyyy-MM-dd HH:mm:ss">
        </div>
    </div>
    <div class="control-group">
        <label class="control-label" for="name">广告位置:</label>
        <div class="controls">
        <form:select path="site">
            <form:option value="1">弹窗广告</form:option>
            <form:option value="2">banner广告</form:option>
        </form:select>
        </div>
    </div>

    <div class="control-group">
        <label class="control-label" for="name">广告类型:</label>
        <div class="form-check form-check-inline">
            <input class="form-check-input" type="radio"  <c:if test="${ebShopAdvertise.type != 2}">checked="checked"</c:if> onclick="changeType(1)" name="type" id="inlineRadio1" value="1">
            <label class="form-check-label" for="inlineRadio1">图片广告</label>
        </div>
        <div class="form-check form-check-inline">
            <input class="form-check-input" <c:if test="${ebShopAdvertise.type == 2}">checked="checked"</c:if> type="radio" onclick="changeType(2)" name="type" id="inlineRadio2" value="2">
            <label class="form-check-label" for="inlineRadio2">优惠券广告</label>
        </div>
    </div>

    <div class="control-group" id="update-img">
        <label class="control-label" for="name">广告图片:</label>
        <div style="margin-left: 20px;display:inline-block">
            <input type="hidden" name="pic" id="pic" value="${ebShopAdvertise.pic}"  htmlEscape="false" maxlength="100" class="input-xlarge"/>
                <span class="help-inline" id="pic"  style="color: blue;"></span>
                <tags:ckfinder input="pic" type="images" uploadPath="/merchandise/advertise"/>
        </div>
    </div>
    <input type="hidden" id="certificateId" name="certificateId" value="${ebShopAdvertise.certificateId}"/>
    <%--<input type="text" id="certificateNames" name="certificateId"/>--%>
    <div class="control-group" id="certificate-div">
        <label class="control-label" for="name">已选择的优惠券:</label>
        <div class="controls">
            <input type="text"  id="certificateNames"  readonly name="certificateName" value="${ebShopAdvertise.certificateName}" >
        </div>
    </div>

    <%--<div class="control-group">--%>
        <%--<label class="control-label">申请理由</label>--%>
        <%--<div class="controls">--%>
        <%--<textarea class="form-control" name="remark" id="exampleFormControlTextarea1" rows="3">${ebShopAdvertise.remark} </textarea>--%>
        <%--</div>--%>
    <%--</div>--%>

    <shiro:hasPermission name="merchandise:ebShopAdvertise:edit">
        <div class="form-actions" >
            <input id="btnCancel" class="btn" type="submit" value="${'add'.equals(flag) ? "增加":"修改"}"/>
        </div>
    </shiro:hasPermission>

</form:form>
<%--<c:if test="${'0'.equals(isChange)}">--%>
    <%--<c:forEach var="remark" items="${remarkList}" varStatus="vs">--%>
        <%--<div class="control-group">--%>
            <%--<label class="control-label" for="name">回复${vs.index+1}:</label>--%>
            <%--<div class="controls">--%>
                <%--<textarea style="width: 200px; height: 100px;" cols="100" rows="5">${remark.applyRemark}</textarea>--%>
            <%--</div>--%>
        <%--</div>--%>
    <%--</c:forEach>--%>
<%--</c:if>--%>
<script>
    layui.use('laydate', function(){
        var laydate = layui.laydate;

        //日期时间选择器
        laydate.render({
            elem: '#test5'
            ,type: 'datetime'
        });

        // //初始赋值
        // laydate.render({
        //     elem: '#test19'
        //     ,value: '1989-10-14'
        //     ,isInitValue: true
        // });

    });
</script>

<script>
    layui.use('upload', function(){
        var $ = layui.jquery
            ,upload = layui.upload;

        //普通图片上传
        var uploadInst = upload.render({
            elem: '#test1'
            ,url: '${ctxsys}/ebShopAdvertise/updateAdvertisePic/'
            ,accept: 'image'
            ,size: 10240
            ,before: function(obj){
                //预读本地文件示例，不支持ie8
                obj.preview(function(index, file, result){
                    $('#demo1').css("display","inline-block");
                    $('#demo1').attr('src', result); //图片链接（base64）
                });
            }
            ,done: function(res){
                //如果上传失败
                if(res.url == ""){
                    return layer.msg('上传失败');
                }else{
                    $("#pic").val(res.url)
                    return layer.msg('上传成功');
                }
            }
            ,error: function(){
                return layer.msg('上传失败');
            }
        });


    });
</script>
<script type="text/javascript">
    function changeType(type){
        if(type ==1){
            $("#update-img").css("display","block")
            $("#certificate-div").css("display","none")
            $("#certificateId").val("");
            $("#certificateNames").val("");
        }else{
            $("#update-img").css("display","none")
            $("#pic").val("");
            $("#picPreview").empty();
            $("#certificate-div").css("display","block")

            chooseShop();
        }
    }
    function chooseShop(){
        layer.open({
            type: 2,
            title: '优惠券列表',
            shadeClose: true,
            shade: false,
            maxmin: true, //开启最大化最小化按钮
            area: ['880px', '450px'],
            content: '${ctxsys}/ebShopAdvertise/chooseCertificate?ids='+$("#certificateId").val(),
            btn: ['确定', '关闭'],
            yes: function(index, layero){ //或者使用btn1
                content = layero.find("iframe")[0].contentWindow.$('#chooseIds').val();
                var names = layero.find("iframe")[0].contentWindow.$('#chooseNames').val();
                if(content==""){
                    layer.msg("请先选中一行");
                    $("#shopIds").val(content);
                }else if(content.split(",").length >3 ){
                    layer.msg("最多选择三个优惠券");

                }else{
                    $("#certificateId").val(content);
                    $("#certificateNames").val(names);
                    layer.close(index);
                }


            }
        })

    }
</script>


<script type="text/javascript">
    if('${ebShopAdvertise.type}' == 2){
        $("#certificate-div").css("display","block")
        $("#update-img").css("display","none")
    }else{
        $("#certificate-div").css("display","none")
        $("#update-img").css("display","block")
    }

    $(function(){
        $(".layui-upload-file").attr("display","none");
    })

</script>
</body>

</html>