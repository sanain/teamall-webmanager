<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>咨询师个人资料详情</title>
	<meta name="decorator" content="default"/>
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/lightbox/lightbox.min.css">
	<script type="text/javascript" src="${ctxStatic}/lightbox/lightbox.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
		});
	</script>
	<style>
		body{
			padding:0;
			margin:0;
		}
		.main-box{
			margin-left:50px;
		}
		.table-box{
			width:543px;
			float:left;
			background-color:#f5f5f5;
			border:1px solid #E8E8E8;
			margin-right:30px;
		}
		.table-box table{
			padding:10px;
		}
		
		.table-box table caption{
			padding:8px 10px;
			text-align:left;
			border-bottom:1px solid #E8E8E8;
			font-weight:bold;
		}
		.table-box table th{
			width:113px;
			text-align:right;
		}
		.table-box table td{
			width:160px;
		}
		.table-box table th,.table-box table td{
			padding:8px 5px;
			font-weight:normal;
		}
		.listbox{
			margin-top:30px;
			background-color:#f5f5f5;
			width:1118px;
			border:1px solid #E8E8E8;
			padding-bottom:8px;
			overflow:hidden;
		}
		.listbox dt{
			padding:0 20px 8px 8px;
		}
		.listbox dt,.listbox dd{
			display:inline-block;
			float:left;
		}
		.content-box{
			width:960px;
			border:1px solid #E8E8E8;
			background-color:#fff;
			padding:8px 0 0 8px;
			margin-bottom:30px;
		}
		.pborder{
			border-bottom:1px solid #E8E8E8;
			padding-bottom:8px;
		}
		.clearfloat:after{display:block;clear:both;content:"";visibility:hidden;height:0} 
		.clearfloat{zoom:1}
	</style>
</head>
<body modelAttribute="doctor">
	<ul class="nav nav-tabs">
		<li><a href="${ctxsys}/User">用户列表</a></li>
		<li class="active"><a href="#">资料${not empty ebuser.userId?'详情':''}</a></li>
	</ul>
	<div class="main-box">
	<div class="clearfloat">
	<div class="table-box">
		<table>
			<caption>个人信息</caption>
			<tr>
				<th>姓名:</th>
				<td>${ebuser.username}</td>
				<th>头像:</th>
				<td rowspan="3"><c:if test="${not empty ebuser.avataraddress}">
						<a class="example-image-link" data-lightbox="example-set" href="${ebuser.avataraddress}"> 
							<img class="example-image img-thumbnail marimg" src="${ebuser.avataraddress}" style="width: 100px; height: 100px;"> 
						</a>
				</c:if></td>
			</tr>
			<tr>
				<th>状态:</th>
				<td>
				<c:if test="${ebuser.status==1}">启用</c:if><c:if test="${ebuser.status==2}">禁用</c:if>
				</td>	
			</tr>
			<tr>
				<th>个信签名:</th>
				<td>
				${ebuser.signature}
				</td>	
			</tr>
			<tr>
				<th>手机号:</th>
				<td>${ebuser.mobile}</td>	
			</tr>
			<tr>
				<th>年龄:</th>
				<td>${ebuser.age}</td>	
			</tr>
			<tr>
				<th>星座:</th>
				<td>${ebuser.constellatory}</td>	
			</tr>
			<tr>
				<th>所在地:</th>
				<td>${ebuser.provincesId}${ebuser.municipalId}${ebuser.districtId}</td>
			</tr>
			<tr>
				<th>性别:</th>
				<td><c:if test="${ebuser.sex==1}">女</c:if><c:if test="${ebuser.sex==0}">男</c:if></td>
			</tr>
			<tr>
				<th>生日:</th>
				<td colspan="3"><fmt:formatDate value="${ebuser.birthday}" pattern="yyyy-MM-dd" /></td>
			</tr>
			<tr>
				<th>创建时间:</th>
				<td colspan="3"><fmt:formatDate value="${ebuser.createtime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
			</tr>
			<tr>
				<th>上次登录时间:</th>
				<td colspan="3"><fmt:formatDate value="${ebuser.lastlogintime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
			</tr>
		</table>
	</div>
	
	<div class="table-box">
		<table>
			<caption>信息记录</caption>
			<tr>
				<th>回答问题数:</th>
				<td>${ebuser.myAnswer}</td>
				<th>粉丝数量:</th>
				<td>
				</td>
			</tr>
			<tr>
				<th>最佳回答数:</th>
				<td>${ebuser.mybestAnswer}</td>
				<th>提问数量:</th>
				<td></td>
			</tr>
			<tr>
				<th style="color:#f5f5f5">.</th>
				<td></td>
			</tr>
		</table>
	</div>
	</div>
	
	<div class="listbox">
		<dl>
			<dt>信息绑定</dt>
			<dd class="content-box">
				<p>微信绑定:${not empty ebuser.weixingaccount?'绑定':'未绑定'}</p>
				<p>微博绑定:${not empty ebuser.weiboaccount?'绑定':'未绑定'}</p>
				<p>QQ绑定  : ${not empty ebuser.qqaccount?'绑定':'未绑定'}</p>
			</dd>
		</dl>
	</div>	
	
	<div class="listbox">
		<dl>
			<dt>收到礼物</dt>
			<dd class="content-box">
			<p>暂未开放</p>
			</dd>
		</dl>
		<dl>
			<div>
			<dt>提现信息</dt>
			<dd class="content-box">
			<p>可提现金额:${ebuser.carryBalance}</p>
			<p>不可提现金额:${ebuser.balance}</p>
				<%-- <c:choose>
					<c:when test="${services.size()==0}">暂无服务</c:when>
					<c:otherwise>
						<c:forEach items="${services}" var="service">
							<p>
							<span>【${fns:getDictLabel(service.serviceType, 'doctorService_serviceType', '')}】</span>
							<span>￥${service.servicePrice}</span>&nbsp;&nbsp;
							<span>${service.serviceDuration}分钟/次${fns:getDictLabel(service.serviceType, 'doctorServer_serviceTypeDec', '')}</span>&nbsp;&nbsp;
							状态：<span>${fns:getDictLabel(service.serviceState, 'serviceState', '')}</span>
							</p>
						</c:forEach>
					</c:otherwise>
				</c:choose> --%>
			</dd>
			</div>
		</dl>
		<dl>
			<%-- <div>
			<dt>服务介绍</dt>
			<dd class="content-box">
				<p>【服务内容】</p>
				<p class="pborder">
					<c:choose>
						<c:when test="${empty doctor.serviceContent}">暂无信息</c:when>
						<c:otherwise>${doctor.serviceContent}</c:otherwise>
					</c:choose>
				</p>
				<p>【服务流程】</p>
				<p class="pborder">
					<c:choose>
						<c:when test="${empty doctor.serviceFlow}">暂无信息</c:when>
						<c:otherwise>${doctor.serviceFlow}</c:otherwise>
					</c:choose>
				</p>
				<p>【服务时间】</p>
				<p>
					<c:choose>
						<c:when test="${empty doctor.serviceTime}">暂无信息</c:when>
						<c:otherwise>${doctor.serviceTime}</c:otherwise>
					</c:choose>
				</p>
			</dd>
			</div>
		</dl>
	</div> --%>
	
	<div class="listbox">
		<dl>
			<dt>个人资料</dt>
			<dd class="content-box">
				<c:choose>
					<c:when test="${empty doctor.ddesc}">暂无描述</c:when>
					<c:otherwise><p class="pcontent">${doctor.ddesc}</p></c:otherwise>
				</c:choose>
			</dd>
		</dl>
	</div>
	</div>
	<div style="margin:10px 0 0 50px">
		<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
	</div>
</body>
</html>