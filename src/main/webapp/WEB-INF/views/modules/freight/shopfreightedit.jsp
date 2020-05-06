<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0,minimal-ui">
<meta name="Description" content="${fns:getProjectName()},会员信息" />
<meta name="Keywords" content="${fns:getProjectName()},会员信息" />
<title>配送费设置</title>
<link rel="stylesheet"
	href="${ctxStatic}/sbShop/css/admin-member-msg.css">
<link rel="stylesheet" href="${ctxStatic}/sbShop/css/bootstrap.min.css">
<link type="text/css" rel="stylesheet"
	href="${ctxStatic}/common/jqsite.min.css">
<link rel="stylesheet" href="${ctxStatic}/tii/tii.css">
<link rel="stylesheet" href="${ctxStatic}/layui/css/layui.css?v=1">
<script src="${ctxStatic}/sbShop/js/jquery.min.js"></script>
<script src="${ctxStatic}/tii/tii.js"></script>
<script type="text/javascript" src="${ctxStatic}/common/mustache.min.js"></script>
<script type="text/javascript" src="${ctxStatic}/common/jqsite.min.js"></script>
<script type="text/javascript" src="${ctxStatic}/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="${ctxStatic}/ckfinder/ckfinder.js"></script>
<script src="${ctxStatic}/sbShop/js/admin-member-msg.js"></script>
<script src="${ctxStatic}/sbShop/layui/layui.js"></script>
<script src="${ctxStatic}/sbShop/js/admin-company-msg.js"></script>


<link rel="stylesheet"
	href="${ctxStatic}/sbShop/css/admin-member-msg.css">
<link rel="stylesheet" href="${ctxStatic}/sbShop/css/bootstrap.min.css">
<link type="text/css" rel="stylesheet"
	href="${ctxStatic}/common/jqsite.min.css">
<link rel="stylesheet" href="${ctxStatic}/tii/tii.css">
<script src="${ctxStatic}/sbShop/js/jquery.min.js"></script>
<script src="${ctxStatic}/tii/tii.js"></script>
<script type="text/javascript" src="${ctxStatic}/common/jqsite.min.js"></script>
<script type="text/javascript" src="${ctxStatic}/common/mustache.min.js"></script>
<script type="text/javascript" src="${ctxStatic}/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="${ctxStatic}/ckfinder/ckfinder.js"></script>
<script src="${ctxStatic}/sbShop/js/admin-member-msg.js"></script>
<style>
.layui-tab-title{height:43px;}
.fixed-img {
	dispaly: none;
	position: fixed;
	width: 600px;
	left: 50%;
	margin-left: -300px;
}

.fixed-img img {
	width: 100%;
	max-width: auto
}

.fit-right ul li ol li:first-child {
	
}

.nav-ul li .active {
	color: #009688;
	border-bottom: 2px solid #009688;
}

.save:hover {
	color: rgb(120, 120, 120);
}

.save {
	background: #393D49;
	color: #ffffff;
}
</style>
</head>

<body style="background:#f5f5f5;">
	<div style="color:#999;margin:19px 0 13px 30px;">
		<span>当前位置：</span><span>物流管理 - </span><span style="color:#009688;">配送费设置</span>
	</div>

	<div class="c-context" style="background:#fff;margin:0 30px 30px 30px;">
		<div class="layui-tab">
  <ul class="layui-tab-title">
    <li class="layui-this"
					style="width:145px;border-top:2px solid  #009688;background:#fff;"><a
					class="active" href="${ctxweb}/shop/shopinfofeight/feightEdit"
					style=" color: #009688;">配送费设置</a></li>
  </ul>
</div>


<!--     <ul class="nav-ul" style="margin-bottom:10px">
        <li>配送费设置</a></li>
    </ul> -->
    <form class="form-horizontal" style="margin:0px" method="post"
			id="searchForm" name="form2">
        <input id="freightModelId" name="freightModelId" type="hidden"
				value="${ebProductFreightModel.freightModelId}" />
        <div class="context-box" style="padding:10px 10px 40px 10px;">
            <div>
                <li
						style="display:flex;content-justify:flex-start;aglin-items:baseline;flex-wrap: wrap">

                    <div>
                        <p
								style="margin-top:10px;margin-left:10px;margin-bottom:20px;">
								<label style="width:120px">配送费：</label>
                            <input type="text"
									style="margin-right: 10px; border-width: 1px;border-style: solid;border-color: rgb(220, 220, 220);border-image: initial;
						border-radius: 3px;padding: 0px 10px;height:35px;width:230px;"
									id="normalFreight" name="normalFreight"
									value="${ebProductFreightModel.normalFreight}" />
                            <font color="red"> *必填</font>
							</p>
                        <p style="margin-top:10px;margin-left:10px">
								<label style="width:120px">满多少免配送费：</label>
                            <input type="text"
									style="margin-right: 10px; border-width: 1px;border-style: solid;border-color: rgb(220, 220, 220);border-image: initial;
						border-radius: 3px;padding: 0px 10px;height:35px;width:230px;"
									id="fullFreight" name="fullFreight"
									value="${ebProductFreightModel.fullFreight}" />
                            <font color="red"> *必填</font>
							</p>
                    </div>
                </li>

                <div style="padding-left: 10px;padding-top: 10px">
                    <input class="save" type="button" onclick="bent()"
							style="display: inline-block;line-height: 35px;padding: 0 15px;border-radius: 4px;background:#495572;width:95px;height:35px;margin-left:195px;"
							value="保存"></a>
                </div>
            </div>
    
		</form>
</div>
<script type="text/javascript">
	function bent() {
		var freightModelId = $('#freightModelId').val();
		var normalFreight = $('#normalFreight').val();
		var fullFreight = $('#fullFreight').val();

		$.ajax({
			url : "${ctxweb}/shop/shopinfofeight/savefeight",
			type : 'post',
			data : {
				freightModelId : freightModelId,
				normalFreight : normalFreight,
				fullFreight : fullFreight,
			},
			cache : false,
			success : function(data) {
				if (data.code == '00') {
					alert(data.msg);
				} else {
					alert(data.msg);
				}
			}
		});
	}
</script>
	<div class="tii">
		<span class="tii-img"></span> <span class="message"
			data-tid="${message}">${message}</span>
	</div>
	<div class="fixed-img"></div>
	</body>
</html>