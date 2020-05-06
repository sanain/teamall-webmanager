<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>编辑加盟信息</title>
	<meta name="decorator" content="default"/>
	<link href="${ctxStatic}/bootstrap/2.3.1/css_cerulean/bootstrap.min.css" type="text/css" rel="stylesheet">
	<style type="text/css">
		.modal-title {
			margin: 0;
			line-height: 1.42857143;
			color: #000;
			font-weight: normal;
		}

		.h4, h4 {
			font-size: 18px;
		}

		.form-group {
			margin-bottom: 15px;
		}

		.form-control {
			display: block;
			width: 100%;
			height: 34px;
			padding: 6px 12px;
			font-size: 14px;
			line-height: 1.42857143;
			color: #555;
			background-color: #fff;
			background-image: none;
			border: 1px solid #ccc;
			border-radius: 4px;
			-webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,.075);
			box-shadow: inset 0 1px 1px rgba(0,0,0,.075);
			-webkit-transition: border-color ease-in-out .15s,-webkit-box-shadow ease-in-out .15s;
			-o-transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
			transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
		}
	</style>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					// loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});
		});
	</script>
	<script type="text/javascript">

        $(function () {
            if('${prompt}' != ""){
                alert('${prompt}');
            }

            init();
        })
        var phoneArr;

        //初始化
        function init(){
            if('${ebJoinIn.phone}'=="null" || '${ebJoinIn.phone}' == ""){
                phoneArr = new Array();
            }else{
                phoneArr = '${ebJoinIn.phone}'.split(",");
            }
        }


        //点击增加，弹出模态框
        function addPhone(){
            $("#phone-table").css("display","table")
            $("#phone-modal").modal("show");
            $("#new-phone").val("");
        }

        //点击确定是，验证手机号码，并且
        function addNewPhone(){
            var phone = $("#new-phone").val();

            if(phone == undefined || phone == ""){
                alert("加盟电话为空");
                return ;
			}

            if(/^1[3456789]\d{9}$/.test(phone) || /^(\(\d{3,4}\)|\d{3,4}-|\s)?\d{7,14}$/.test(phone)){	//手机号码
                addTableTr(phone);
                $("#phone-modal").modal("hide")
            }else{
				alert("加盟电话格式错误");
				return ;
			}

        }

        //把新的号码增加表格中
        function addTableTr(phone){
            if(phoneArr.indexOf(phone) >= 0){
                alert("该号码已经存在！");
                return ;
            }
            phoneArr.push(phone);

            var trStr = "<tr value='"+phone+"'>"
            trStr += "<td>"+phone+"</td>";
            trStr += "<td><input type='button' class='btn btn-primary' value='删除' onclick='removePhone("+phone+")'/> </td>";

            $("#phone-tbody").append(trStr);

            $("#phone-input").val(phoneArr.toString())
        }

        //移除一个号码
        function removePhone(phone){
            var trArr = $("#phone-tbody").find("tr");

            for(var i = 0 ; i < trArr.length ; i++){
                if($(trArr[i]).attr("value") == phone){
                    $(trArr[i]).remove();
                }
            }

            //从数组中移除
            phoneArr.splice(phoneArr.indexOf(phone) , 1);
            $("#phone-input").val(phoneArr.toString())
        }

        //清空加盟号码
        function clearPhone(){
            $("#phone-input").val("");
            $("#phone-tbody").empty();
            phoneArr = new Array();
        }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctxsys}/EbJoinIn/from">编辑加盟信息</a></li>
	</ul>
	<form:form id="inputForm" modelAttribute="ebJoinIn" action="${ctxsys}/EbJoinIn/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<div class="control-group">
			<label class="control-label">内容:</label>
			<div class="controls">
				<form:textarea id="content" path="content" htmlEscape="false" maxlength="1000"/>
				<tags:ckeditor replace="content" uploadPath="/merchandise/EbJoinIn" />
			</div>
		</div>
		<form:hidden path="phone" id="phone-input"></form:hidden>
		<div class="control-group">
			<label class="control-label">加盟电话:</label>
			<div class="controls" >
				<table  class="table"  style="width: 50%" id="phone-table" <c:if test="${ebJoinIn.phone == null}">disabled="none"</c:if>>
						<thead>
						<tr>
							<%--<th scope="col">序号</th>--%>
							<th scope="col">电话</th>
							<th scope="col">操作</th>
						</tr>
						</thead>
						<tbody id="phone-tbody">
						<c:forEach varStatus="status" items="${ebJoinIn.phone.split(',')}" var="phone">
							<tr value="${phone}">
								<%--<th scope="row">${status.index}</th>--%>
								<td>${phone}</td>
								<td><input type="button" class="btn btn-primary" value="删除" onclick="removePhone('${phone}')"/> </td>
							</tr>
						</c:forEach>
						</tbody>
					</table>

				<div class="row" id="phone-control-div" style="margin-left: 10px">
					<input type="button" class="btn btn-primary" value="增加" onclick="addPhone()"/>
					<input type="button" class="btn btn-primary" value="清空" onclick="clearPhone()"/>
				</div>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="merchandise:EbJoinIn:edit">
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;
			</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>

	<!-- 模态框（Modal） -->
	<div class="modal fade" id="phone-modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
						&times;
					</button>
					<h4 class="modal-title" id="myModalLabel">
						增加加盟电话
					</h4>
				</div>
				<div class="modal-body">
					<form>
						<div class="form-group row">
							<label for="new-phone" style="font-size: 14px;color: #333;width: 15%;text-align: right;line-height: 32px;font-weight: bolder;" class="col-sm-2 col-form-label">加盟电话</label>
							<div class="col-sm-10" style="width: 75%;float: right;margin-right: 6%;">
								<input type="text" style="padding: 6px 12px;height: 20px" class="form-control-plaintext form-control" id="new-phone" placeholder="请输入加盟电话">
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" onclick="addNewPhone()">
						确定
					</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭
					</button>
				</div>
			</div><!-- /.modal-content -->
		</div><!-- /.modal -->
	</div>
</body>

</html>