<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>文章内容</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#newsdetailtitle").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					 if (CKEDITOR.instances.newsdetailcontent.getData()=="" ){
                        top.$.jBox.tip('请填写内容','warning');
                    }else{
                        loading('正在提交，请稍等...');
                        form.submit();
                    }
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
			$("#btnSubmit").click(function(){
					/* var newstypetype = $('input[name="newstypetype"]:checked').val();
					if ("1" == newstypetype) {
						var newstypeurl = $.trim($("#newstypeurl").val());
						if (null == newstypeurl || "" == newstypeurl) {
							top.$.jBox("URL类型必须输入URL地址!",  {title:"错误", buttons:{"关闭":true}, 
							bottomText:""});
							return false;
						}
					} */
					$("#inputForm").submit();
			});
		});
		
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctxsys}/news/newsdetail/listForIf">医院资讯内容列表</a></li>
		<li class="active"><a href="#">医院资讯内容${not empty newsdetail.newsdetailid?'修改':'添加'}</a></li>
	</ul><br/>
	
	<form:form id="inputForm" modelAttribute="newsdetail" action="${ctxsys}/news/newsdetail/saveForIf" method="post" class="form-horizontal">
		<form:hidden path="newsdetailid"/>
		<form:hidden path="status"/>
		<form:hidden path="sysfrom"/>
		<form:hidden path="pubby.id"/>
		<form:hidden path="hospitalid.hospitalId"/>
		<tags:message content="${message}"/>
		<div class="control-group">
			<label class="control-label" >来源医院:</label>
			<div class="controls">
				<label class="lbl">${newsdetail.hospitalid.name}</label>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="newstypeid.newstypeid">栏目:</label>
			<div class="controls">
				<tags:treeselect id="newstype" name="newstypeid.newstypeid" value="${newsdetail.newstypeid.newstypeid}" labelName="newstypeid.newstypename" labelValue="${newsdetail.newstypeid.newstypename}"
					title="栏目" url="${ctxsys}/news/newstype/treeData" extId="" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="newsdetailclassify">分类:</label>
			<div class="controls">
				<form:select path="newsdetailclassify" class="input">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('newsdetailclassify')}" itemLabel="label" itemValue="value" htmlEscape="false" />
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="targetList">发布目标位置:</label>
			<div class="controls">
				<form:checkboxes path="targetList" items="${fns:getDictList('newsdetail_target')}" itemLabel="label" itemValue="value" htmlEscape="false" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="newsdetailtitle">标题:</label>
			<div class="controls">
				<form:input path="newsdetailtitle" htmlEscape="false" maxlength="200"  class="required input-xxlarge"  />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="newsdetailabstract">副标（简述）:</label>
			<div class="controls">
				<form:textarea path="newsdetailabstract" htmlEscape="false" rows="4" maxlength="1000" class="input-xxlarge" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="newsdetailauthor">作者:</label>
			<div class="controls">
				<form:input path="newsdetailauthor" htmlEscape="false" maxlength="20"  class="input-medium" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="newsdetailsfrom">引用（来自）:</label>
			<div class="controls">
				<form:input path="newsdetailsfrom" htmlEscape="false" maxlength="50"   class="input-xxlarge" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="newsdetailspicture">新闻小图:</label>
			<div class="controls">
				<form:hidden path="newsdetailspicture" htmlEscape="false" maxlength="100"  class="input-xlarge"/>
				<tags:ckfinder input="newsdetailspicture" type="images" uploadPath="/news/newsdetail"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="newsdetailcontent">内容:</label>
			<div class="controls">
				<form:textarea id="newsdetailcontent" htmlEscape="true" path="newsdetailcontent" rows="6"  class="input-xxlarge"/>
				<tags:ckeditor replace="newsdetailcontent" uploadPath="/news/newsdetail" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="newsdetailvideourl">视频:</label>
			<div class="controls">
				<form:hidden path="newsdetailvideourl" htmlEscape="false" maxlength="100"  class="input-xlarge"/>
				<tags:ckfinder input="newsdetailvideourl" type="files" uploadPath="/news/newsdetail"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="newsdetailhot">是否热点:</label>
			<div class="controls">
				<form:radiobutton path="newsdetailhot" htmlEscape="false" class="required"  value="0"  checked="checked" />正常
				<form:radiobutton path="newsdetailhot" htmlEscape="false" class="required"   value="1" />热点
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" >相关图片:</label>
			<div class="controls">
				<shiro:hasPermission name="news:newsdetail:edit">
				<c:if test="${!empty newsdetail.newsdetailid}">
				<ul class="ul-form" style="list-style-type: none;">
				<li >
				<a id="addPicButton"  href="${ctxsys}/news/newsdetail/picform?newsdetailid.newsdetailid=${newsdetail.newsdetailid}&fromType=form" class="btn">添加相关图片</a>
				</li>
				<li class="clearfix"></li>
				</ul>
				</c:if>
				</shiro:hasPermission>
				<table id="treeTable" class="table table-striped table-bordered table-condensed">
					<tr><th style="text-align:center;">排序</th><th>描述</th><th >图片</th><shiro:hasPermission name="news:newsdetail:edit"><th>操作</th></shiro:hasPermission></tr>
					<c:forEach items="${newsdetail.picList}" var="pic">
						<tr id="${pic.newsdetailpicid}" >
							<td style="text-align:center;">
								${pic.newsdetailpicindex}
							</td>
							<td>${pic.newsdetaildescribe}</td>
							<td><c:if test="${!empty pic.newsdetailpicsrc}"><img width="100px" height="60px" src="${pic.newsdetailpicsrc}"/></c:if></td>
							<shiro:hasPermission name="news:newsdetail:edit"><td>
								<a href="${ctxsys}/news/newsdetail/picform?newsdetailpicid=${pic.newsdetailpicid}&fromType=form">修改</a>
								<a href="${ctxsys}/news/newsdetail/deletePic?newsdetailpicid=${pic.newsdetailpicid}" onclick="return confirmx('确定要删除该图片吗？', this.href)">删除</a>
							</td></shiro:hasPermission>
						</tr>
					</c:forEach>
				</table>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="cityid">区域:</label>
			<div class="controls">
				<form:select path="cityid" class="input">
					<form:option value="" label=""/>
					<form:options items="${citys}" itemLabel="city" itemValue="cityid" htmlEscape="false" />
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" >状态:</label>
			<div class="controls">
				<label class="lbl">${fns:getDictLabel(newsdetail.status, "newsdetail_status", "")}</label>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"  for="newsdetailcreatetime">创建时间:</label>
			<div class="controls">
				<input id="newsdetailcreatetime" name="newsdetailcreatetime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${newsdetail.newsdetailcreatetime}" pattern="yyyy-MM-dd HH:mm:ss"/>"  />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"  for="newsdetailupdatetime">修改时间:</label>
			<div class="controls">
				<input id="newsdetailupdatetime" name="newsdetailupdatetime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${newsdetail.newsdetailupdatetime}" pattern="yyyy-MM-dd HH:mm:ss"/>"  />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"  for="pubtime">发布时间:</label>
			<div class="controls">
				<input id="pubtime" name="pubtime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${newsdetail.pubtime}" pattern="yyyy-MM-dd HH:mm:ss"/>"  />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="pubby.name">发布人:</label>
			<div class="controls">
				<form:input path="pubby.name" htmlEscape="false" maxlength="50"  readonly="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="djWxcnt">点击次数（微信）:</label>
			<div class="controls">
				<form:input path="djWxcnt" htmlEscape="false" maxlength="50"  readonly="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="djWzcnt">点击次数（网站）:</label>
			<div class="controls">
				<form:input path="djWzcnt" htmlEscape="false" maxlength="50"  readonly="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="djApcnt">点击次数（APP）:</label>
			<div class="controls">
				<form:input path="djApcnt" htmlEscape="false" maxlength="50"  readonly="true"/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="news:newsdetail:edit">
				<input id="btnSubmit" class="btn btn-primary" type="button" value="保 存" />&nbsp;
			</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>