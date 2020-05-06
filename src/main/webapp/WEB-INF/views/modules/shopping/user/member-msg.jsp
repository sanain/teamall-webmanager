<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0,minimal-ui">
    <meta name="Description" content="${fns:getProjectName()},会员信息"/>
	<meta name="Keywords" content="${fns:getProjectName()},会员信息"/>
    <title>会员信息</title>
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/admin-member-msg.css">
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/bootstrap.min.css">
    <link type="text/css" rel="stylesheet" href="${ctxStatic}/common/jqsite.min.css">
    <link rel="stylesheet" href="${ctxStatic}/tii/tii.css">
    <script src="${ctxStatic}/sbShop/js/jquery.min.js"></script>
    <script src="${ctxStatic}/tii/tii.js"></script>
    <script type="text/javascript" src="${ctxStatic}/common/mustache.min.js"></script>
	<script type="text/javascript" src="${ctxStatic}/common/jqsite.min.js"></script>
    <script type="text/javascript" src="${ctxStatic}/ckeditor/ckeditor.js"></script>
	<script type="text/javascript" src="${ctxStatic}/ckfinder/ckfinder.js"></script>
    <script src="${ctxStatic}/sbShop/js/admin-member-msg.js"></script>
</head>
<body>
    <div class="c-context">
      <ul class="nav-ul">
          <li><a class="active" href="${ctxsys}/User/form?userId=${userId}">会员信息</a></li>
          <li><a href="${ctxsys}/User/userAccount?userId=${userId}">会员账户</a></li>
          <li><a href="${ctxsys}/User/userrelation?userId=${userId}">会员关系</a></li>
      </ul>
      <form class="form-horizontal" action="${ctxsys}/User/userinfoedit" method="post" id="searchForm" name="form2">
          <input id="userId" name="userId" type="hidden" value="${userId}"/>
        <div class="context-box">
            <div class="msg-left">
                <ul>
                    <li>头像：</li>
                    <li>
                        <div class="img-btn">
                            <input type="hidden" name="avataraddress" id="avataraddress" value="${ebUser.avataraddress}"  htmlEscape="false" maxlength="100" class="input-xlarge"/>
							<span class="help-inline" id="avataraddress"  style="color: blue;"></span>
							<tags:ckfinder input="avataraddress" type="images" uploadPath="/merchandise/avataraddress"/>
                        </div>
                    </li>
                </ul>
                <ul>
                    <li>账号：</li>
                    <li>
                        <c:if test="${ebUser.shopShoppingId != null}">
                            ${fns:replaceMobile(ebUser.mobile)}
                        </c:if>

                        <c:if test="${ebUser.shopShoppingId == null}">
                            ${ebUser.mobile}
                        </c:if>
                    </li>
                <!--    <input type="hidden" id="userId" name="userId" value="${ebUser.userId}"/>-->
                </ul>
                <%--<ul>--%>
                    <%--<li>姓名：</li>--%>
                    <%--<c:if test="${ebUser.isCertification==0}">--%>
                    	<%--<li>未实名认证</li>--%>
                    <%--</c:if>--%>
                    <%--<c:if test="${ebUser.isCertification==1}">--%>
                    	<%--<li>${ebUser.realName}</li>--%>
                    <%--</c:if>--%>
                <%--</ul>--%>
                <%--<ul>--%>
                    <%--<li>身份证：</li>--%>
                    <%--<li>${ebUser.idcard}</li>--%>
                <%--</ul>--%>
                <ul>
                    <li>昵称：</li>
                    <li><input id="username" name="username" value="${ebUser.username}" type="text"></li>
                </ul>
                <ul>
                    <li>性别：</li>
                    <li>
                        <select name="sex" id="sex">
                        	<option selected="selected" disabled="disabled" value="">请选择类型</option>
                            <option ${ebUser.sex=='0'?'selected':''} value="0">保密</option>
                            <option ${ebUser.sex=='1'?'selected':''} value="1">男</option>
                            <option ${ebUser.sex=='2'?'selected':''} value="2">女</option>
                        </select>
                    </li>
                </ul>
                <ul>
                    <li>邮箱：</li>
                    <li><input id="email" name="email" value="${ebUser.email}" type="text"></li>
                </ul>
                 <ul>
                    <li>联系手机号：</li>
                    <li><input id="contactPhone" name="contactPhone" value="${ebUser.contactPhone}" type="text"></li>
                </ul>
                <%--<ul>--%>
                    <%--<li>是否商家：</li>--%>
                    <%--<li>--%>
                    	<%--<c:if test="${!empty ebUser.shopId}">--%>
                        	<%--<span><input type="radio" name="mo" disabled="disabled" checked="checked">是</span>--%>
                        	<%--<span><input type="radio" name="mo" disabled="disabled">否</span>--%>
                        <%--</c:if>--%>
                    	<%--<c:if test="${empty ebUser.shopId}">--%>
                        	<%--<span><input type="radio" name="mo" disabled="disabled">是</span>--%>
                        	<%--<span><input type="radio" name="mo" disabled="disabled" checked="checked">否</span>--%>
                        <%--</c:if>--%>
                    <%--</li>--%>
                <%--</ul>--%>
                <ul>
                    <li>会员状态：</li>
                    <li>
                    	<c:if test="${ebUser.status==1}">
	                        <span><input type="radio" id="status" name="status" value="1" checked="checked">启用</span>
	                        <span><input type="radio" id="status" name="status" value="2">禁用</span>
                    	</c:if>
                    	<c:if test="${ebUser.status==2}">
	                        <span><input type="radio" id="status" name="status" value="1">启用</span>
	                        <span><input type="radio" id="status" name="status" value="2" checked="checked">禁用</span>
                    	</c:if>
                    </li>
                </ul>
                <ul>
                    <li>测试用户：</li>
                    <li>
	                  <span><input type="radio" id="test" name="test" value="1"
                                   <c:if test="${not empty ebUser.test&&ebUser.test==1}">checked="checked"</c:if>
                      >是</span>
                        <span><input type="radio" id="test" name="test" value="0"
                                     <c:if test="${empty ebUser.test||ebUser.test==0}">checked</c:if>
                        >否</span>
                    </li>
                </ul>
            </div>
            <div class="msg-right">
                <ul>
                    <li>
                    	<span>邀请人：</span>
                    	<b>${ebUser.recommendMobile}</b>
                    </li>
                    <%--<li>--%>
                    	<%--<span>邀请码：</span>--%>
                    	<%--<b>${ebUser.cartNum}</b>--%>
                    <%--</li>--%>
                   <%--  <li>
                        <span>注册IP：</span>
                        <b>${ebUser.regIp}</b>
                    </li> --%>
                    <li>
                        <span>注册时间：</span>
                        <b><fmt:formatDate value="${ebUser.createtime}" type="both"/></b>
                    </li>
                    <%--<li>--%>
                        <%--<span>所属合伙人：</span>--%>
                        <%--<!-- 新用户id -->--%>
                        <%--<input name="sysId" type="hidden" id="sysId" value="">--%>
                        <%--<b id="sysloginName"><span >${pmAgentInfo.agentName}</span><c:if test="${empty pmAgentInfo.agentName}"><span style="color: red;">该用户的代理异常</span></c:if><c:if test="${sysUsers.size()>1}"><span style="color: red;">该用户的代理异常(sysUsers.size())</span></c:if></b>--%>
                        <%--<shiro:hasPermission name="merchandise:user:edit">--%>
                           <%--<span style="padding-left:3px;"  class="btn  "  onclick="windowOpen('${ctxsys}/sys/user/openDaililist','合伙人选择','700','400')"><font color="blue">修改所属合伙人</font></span>--%>
                        <%--</shiro:hasPermission>--%>
                        <%--<b id="btu" ></b>--%>
                    <%--</li>--%>
                    <%--<li style="display:none">--%>
                        <%--<span>所属代理公司：</span>--%>
                        <%--<!-- 原代理id -->--%>
                        <%--<input name="agentId" type="hidden" id="agentId" value="${ebUser.agentId}">--%>
                        <%--<!-- 新代理id -->--%>
                        <%--<input type="hidden" name="xagentId" id="xagentId" value="">--%>
                        <%--<b id="sysname"><span >${ebUser.office.name}</span><c:if test="${empty  ebUser.office.name}"><span style="color: red;">所属代理公司异常</span></c:if></b>--%>
                    <%--</li>--%>
                    <%-- <li>
                        <span>最后登录IP：</span>
                        <b>${ebUser.ip}</b>
                    </li> --%>
                    <!-- <li>
                        <span>最后登录时间：</span>
                        <b>2017-02-32</b>
                    </li> -->
                </ul>
            </div>
            <div class="msg-btn">
                <a class="btn-pos" href="javascript:;">保存</a>
            </div>
        </div>
      </form>
    </div>
    <script type="text/javascript">
       function bent(){
         if($("#userId").val()==''||$("#userId").val()==null||$("#userId").val()==undefined){
           alertx("请刷新当前页面");
           return;
         }
          if($("#sysId").val()==''||$("#sysId").val()==null||$("#sysId").val()==undefined){
           alertx("请重新选择代理用户");
            return;
         }
	     $.ajax({
			    type : "POST",
			    data:{userId:$("#userId").val(),sysId:$("#sysId").val()},
			    url : "${ctxsys}/User/editAgentId",   
			    success : function (data) {
			     if(data.code='00'){
			        alertx(data.msg);
			        window.location.href="${ctxsys}/User/form?userId=${userId}"; 
			      }else{
			       alertx(data.msg);
			      }
			    }
	         });
	      }
    </script>
<div class="tii">
	<span class="tii-img"></span>
	<span class="message" data-tid="${message}">${message}</span>
</div>
</body>
</html>