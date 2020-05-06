<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <title>用户管理</title>
    <meta name="decorator" content="default"/>
    <style>
        .mar-right{
            float:left;width: 50%
        }
    </style>
    <script type="text/javascript">
        $(document).ready(function() {
            $("#no").focus();
            $("#inputForm").validate({
                rules: {
                    mobile:{remote:"${ctxsys}/User/checkLoginName?mobile="+encodeURIComponent('${ebUser.mobile}')},
                    cartNum:{remote:"${ctxsys}/User/checkCartNum?cartNum="+encodeURIComponent('${ebUser.cartNum}')}
                },
                messages: {
                    mobile: {remote:"用户登录名已存在"},
                    cartNum: {remote:"邀请码不可用"},
                    confirmNewPassword: {equalTo: "输入与上面相同的密码"}
                },
                submitHandler: function(form){
                    loading('正在提交，请稍等...');
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
</head>
<body>
<ul class="nav nav-tabs">
    <li><a href="${ctxsys}/User/list">用户列表</a></li>
    <li class="active"><a href="${ctxsys}/User/form">用户<shiro:hasPermission name="merchandise:user:edit">${not empty ebUser.userId?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="merchandise:user:edit">查看</shiro:lacksPermission></a></li>
</ul><br/>
<form:form id="inputForm" modelAttribute="ebUser" action="${ctxsys}/User/save" method="post" class="form-horizontal">
    <form:hidden path="userId"/>
    <sys:message content="${message}"/>
    <div class="control-group">
        <label class="control-label">用户头像:</label>
        <div class="controls">
            <form:hidden path="avataraddress" htmlEscape="false" maxlength="100"  class="input-xlarge"/>
            <span class="help-inline" id="avataraddress"  style="color: blue;"></span>
            <tags:ckfinder input="avataraddress" type="images" uploadPath="/merchandise/user"/>
        </div>
    </div>

    <div class="control-group">
        <div class="mar-right">
            <label class="control-label">手机:</label>
            <div class="controls">
                <c:if test="${not empty ebUser.userId}">
                    ${ebUser.mobile}
                </c:if>
                <c:if test="${empty ebUser.userId}">
                    <form:input path="mobile" htmlEscape="false" maxlength="50" class="required userName"/>
                    <span class="help-inline"><font color="red">*</font> </span>
                </c:if>
            </div>
        </div>
        <div class="mar-right">
            <label class="control-label">姓名:</label>
            <div class="controls">
                <form:input path="username" htmlEscape="false" maxlength="50" />
                <span class="help-inline"><font color="red">*</font> </span>
            </div>
        </div>
    </div>

    <div class="control-group">
        <div class="mar-right">
            <label class="control-label">身份证号:</label>
            <div class="controls">
                <c:if test="${not empty ebUser.userId}">
                    ${ebUser.idcard}
                </c:if>
                <c:if test="${empty ebUser.userId}">
                    <form:input path="idcard" htmlEscape="false" maxlength="50" class="required"/>
                    <span class="help-inline"><font color="red" style="visibility: hidden;">*</font> </span>
                </c:if>
            </div>
        </div>
        <div class="mar-right">
            <label class="control-label">性别:</label>
            <div class="controls">
                <label ><form:radiobutton path="sex" value="0"  checked="checked"/>保密</label>
                <label ><form:radiobutton path="sex" value="1" />男</label>
                <label ><form:radiobutton path="sex" value="2"/>女</label>
            </div>
        </div>
    </div>

    <div class="control-group">
        <div class="mar-right">
            <label class="control-label">年龄:</label>
            <div class="controls">
                <form:input path="age"  htmlEscape="false" maxlength="50"/>
                <span class="help-inline"><font color="red" style="visibility: hidden;">*</font> </span>
            </div>
        </div>
        
        <div class="mar-right">
            <label class="control-label">邀请码:</label>
            <div class="controls">
             <c:if test="${not empty ebUser.userId}">
                    ${ebUser.cartNum}
               </c:if>
              <c:if test="${ empty ebUser.userId}">
                     <form:input path="cartNum" htmlEscape="false"  maxlength="50" class="required cartNum" />
               </c:if>
            </div>
        </div>
    </div>

    <div class="control-group">
        <div class="mar-right">
            <label class="control-label">所在地:</label>
            <div class="controls">
                <form:input path="stands" htmlEscape="false"  maxlength="50" />
                <span class="help-inline"><font color="red" style="visibility: hidden;">*</font> </span>
            </div>
        </div>
        <div class="mar-right">
            <label class="control-label">婚姻状况:</label>
            <div class="controls">
                <label class="sex"><form:radiobutton path="relationshipstatus" value="0"/>保密</label>
                <label class="sex"><form:radiobutton path="relationshipstatus" value="1"  checked="checked"/>已婚</label>
                <label class="sex"><form:radiobutton path="relationshipstatus" value="2"/>未婚</label>
            </div>
        </div>
    </div>
    <div class="control-group">
        <div class="mar-right">
            <label class="control-label">收货信息:</label>
            <div class="controls">
                <form:input path="information" htmlEscape="false"  maxlength="50" />
                <span class="help-inline"><font color="red" style="visibility: hidden;">*</font> </span>
            </div>
        </div>
        <div class="mar-right">
            <label class="control-label">生日:</label>
            <div class="controls">
                <input class="input-medium" name="birthday" onfocus="WdatePicker()" value="<fmt:formatDate value='${ebUser.birthday}' type='date' pattern='yyyy-MM-dd'/>" />
            </div>
        </div>
    </div>
    <div class="control-group">
        <div class="mar-right">
            <label class="control-label">密码:</label>
            <div class="controls">
                <input id="newPassword" name="newPassword" type="password" value="" maxlength="50" minlength="6" class="${empty ebUser.userId?'required':''}"/>
                <c:if test="${empty ebUser.userId}"><span class="help-inline"><font color="red">*</font> </span></c:if>
                <c:if test="${not empty ebUser.userId}"><span class="help-inline">若不修改密码，请留空。</span></c:if>
            </div>
        </div>
        <div class="mar-right">
            <label class="control-label">确认密码:</label>
            <div class="controls">
                <input id="confirmNewPassword" name="confirmNewPassword" type="password" value="" maxlength="50" minlength="6" equalTo="#newPassword"/>
                <c:if test="${empty ebUser.userId}"><span class="help-inline"><font color="red">*</font> </span></c:if>
            </div>
        </div>
    </div>
    <div class="control-group">
        <div class="mar-right">
            <label class="control-label">关联QQ帐号:</label>
            <div class="controls">
                <c:if test="${not empty ebUser.userId}">
                    ${ebUser.qqaccount}
                </c:if>
                <c:if test="${empty ebUser.userId}">
                    <form:input path="qqaccount"  htmlEscape="false" maxlength="50" />
                    <span class="help-inline"><font color="red" style="visibility: hidden;">*</font> </span>
                </c:if>
            </div>
        </div>
        <div class="mar-right">
            <label class="control-label">关联微博帐号:</label>
            <div class="controls">
                <c:if test="${not empty ebUser.userId}">
                    ${ebUser.weixingaccount}
                </c:if>
                <c:if test="${empty ebUser.userId}">
                    <form:input path="weiboaccount"  htmlEscape="false" maxlength="50" />
                </c:if>
            </div>
        </div>
    </div>
    <div class="control-group">
        <div class="mar-right">
            <label class="control-label">关联微信帐号:</label>
            <div class="controls">
                <c:if test="${not empty ebUser.userId}">
                    ${ebUser.weixingaccount}
                </c:if>
                <c:if test="${empty ebUser.userId}">
                    <form:input path="weixingaccount"  htmlEscape="false" maxlength="50" />
                    <span class="help-inline"><font color="red" style="visibility: hidden;">*</font> </span>
                </c:if>
            </div>
        </div>
        <div class="mar-right">
            <label class="control-label">用户状态:</label>
            <div class="controls">
                <label class="status"> <form:radiobutton path="status" value="1"  checked="checked"/>启用</label>
                <label class="status"><form:radiobutton path="status" value="2"/>禁用</label>
            </div>
        </div>
    </div>
    <div class="control-group">
        <div class="mar-right">
            <label class="control-label">联系电话:</label>
            <div class="controls">
                <form:input path="contactPhone" htmlEscape="false"  maxlength="50" />
                <span class="help-inline"><font color="red" style="visibility: hidden;">*</font> </span>
            </div>
        </div>
        <div class="mar-right">
            <label class="control-label">邮箱:</label>
            <div class="controls">
                <form:input path="email" htmlEscape="false" calss="email"  maxlength="50" />
            </div>
        </div>
    </div>
    <div class="control-group">
        <div class="mar-right">
            <label class="control-label">真实姓名:</label>
            <div class="controls">
                <form:input path="realName" htmlEscape="false"  maxlength="50" />
                <span class="help-inline"><font color="red" style="visibility: hidden;">*</font> </span>
            </div>
        </div>
        <div class="mar-right">
            <label class="control-label">收入:</label>
            <div class="controls">
                <form:select path="monthlyInCome">
                    <form:option value="0">无收入</form:option>
                    <form:option value="1">2000元以下 </form:option>
                    <form:option value="2">2000—3999元</form:option>
                    <form:option value="3">4000—5999元</form:option>
                    <form:option value="4">6000—7999元</form:option>
                    <form:option value="5">8000元以上</form:option>
                </form:select>
            </div>
        </div>
    </div>
    <div class="control-group">
        <div class="mar-right">
            <label class="control-label">兴趣爱好:</label>
            <div class="controls">
                <form:input path="interest" htmlEscape="false"  maxlength="50" />
                <span class="help-inline"><font color="red" style="visibility: hidden;">*</font> </span>
            </div>
        </div>
        <div class="mar-right">
            <label class="control-label">授权站点:</label>
            <div class="controls">
                <form:input path="authorizationSite" htmlEscape="false"   maxlength="50" />
            </div>
        </div>
    </div>
    <div class="control-group">
        <div class="mar-right">
            <label class="control-label">学历:</label>
            <div class="controls">
                <form:select path="degree">
                    <form:option value="0">高中/中专/职校及以下</form:option>
                    <form:option value="1">大专 </form:option>
                    <form:option value="2">本科</form:option>
                    <form:option value="3">硕士及以上</form:option>
                </form:select>
            </div>
        </div>
        <div class="mar-right">
            <label class="control-label">推荐人员手机号:</label>
            <div class="controls">
                ${ebUser.recommendMobile}
            </div>
        </div>
    </div>
    <div class="control-group">
        <div class="mar-right">
            <label class="control-label">职业:</label>
            <div class="controls">
                <form:input path="occupation" htmlEscape="false"  maxlength="50" />
                <span class="help-inline"><font color="red" style="visibility: hidden;">*</font> </span>
            </div>
        </div>
        <div class="mar-right">
            <label class="control-label">当前余额:</label>
            <div class="controls">
                <form:input path="currentAmt" htmlEscape="false"  maxlength="50" />
                <span class="help-inline"><font color="red" style="visibility: hidden;">*</font> </span>
            </div>

        </div>
    </div>
    <div class="control-group">
        <div class="mar-right">
            <label class="control-label">累计总额:</label>
            <div class="controls">
                <form:input path="totalAmt" htmlEscape="false"  maxlength="50" />
                <span class="help-inline"><font color="red" style="visibility: hidden;">*</font> </span>
            </div>
        </div>
        <div class="mar-right">
            <label class="control-label">冻结金额:</label>
            <div class="controls">
                <form:input path="frozenAmt" htmlEscape="false"  maxlength="50" />
                <span class="help-inline"><font color="red" style="visibility: hidden;">*</font> </span>
            </div>

        </div>
    </div>
    <div class="control-group">
        <div class="mar-right">
            <label class="control-label">当前金币:</label>
            <div class="controls">
                <form:input path="currentGold" htmlEscape="false"  maxlength="50" />
                <span class="help-inline"><font color="red" style="visibility: hidden;">*</font> </span>
            </div>
        </div>
        <div class="mar-right">
            <label class="control-label">历史金币:</label>
            <div class="controls">
                <form:input path="totalGold" htmlEscape="false"  maxlength="50" />
                <span class="help-inline"><font color="red" style="visibility: hidden;">*</font> </span>
            </div>

        </div>
    </div>
    <div class="control-group">
        <div class="mar-right">
            <label class="control-label">冻结积分:</label>
            <div class="controls">
                <form:input path="frozenGold" htmlEscape="false"  maxlength="50" />
                <span class="help-inline"><font color="red" style="visibility: hidden;">*</font> </span>
            </div>
        </div>
        <div class="mar-right">
            <label class="control-label">当前吉福数:</label>
            <div class="controls">
                <form:input path="currentLove" htmlEscape="false"  maxlength="50" />
                <span class="help-inline"><font color="red" style="visibility: hidden;">*</font> </span>
            </div>
        </div>
    </div>
    <div class="control-group">
        <div class="mar-right">
            <label class="control-label">累计吉福数:</label>
            <div class="controls">
                <form:input path="totalLove" htmlEscape="false"  maxlength="50" />
                <span class="help-inline"><font color="red" style="visibility: hidden;">*</font> </span>
            </div>
        </div>
        <div class="mar-right">
            <label class="control-label">传福达人:</label>
            <div class="controls">
                <label class="status"> <form:radiobutton path="isMessenger" value="0"  checked="checked"/>否</label>
                <label class="status"><form:radiobutton path="isMessenger" value="1"/>是</label>
            </div>
        </div>
    </div>
    <div class="control-group">
        <div class="mar-right">
            <label class="control-label">今日奖励金额（元）:</label>
            <div class="controls">
                <form:input path="todayAmt" htmlEscape="false"  maxlength="50" />
                <span class="help-inline"><font color="red" style="visibility: hidden;">*</font> </span>
            </div>
        </div>
        <div class="mar-right">
            <label class="control-label">是否代理身份 :</label>
            <div class="controls">
                <label class="status"> <form:radiobutton path="isAgent" value="0"  checked="checked"/>否</label>
                <label class="status"><form:radiobutton path="isAgent" value="1"/>是</label>
            </div>
        </div>
    </div>
    <div class="control-group">
        <div class="mar-right">
            <label class="control-label">累计吉福奖励金额:</label>
            <div class="controls">
                <form:input path="loveAmt" htmlEscape="false"  maxlength="50" />
                <span class="help-inline"><font color="red" style="visibility: hidden;">*</font> </span>
            </div>
        </div>
        <div class="mar-right">
            <label class="control-label">精英合伙人 :</label>
            <div class="controls">
                <label class="status"> <form:radiobutton path="isAmbassador" value="0"  checked="checked"/>否</label>
                <label class="status"><form:radiobutton path="isAmbassador" value="1"/>是</label>
            </div>
        </div>
    </div>
    <div class="control-group">
        <div class="mar-right">
            <label class="control-label">最大支付金额:</label>
            <div class="controls">
                <form:input path="maxPay" htmlEscape="false"  maxlength="50" />
                <span class="help-inline"><font color="red" style="visibility: hidden;">*</font> </span>
            </div>
        </div>
        <div class="mar-right">
            <label class="control-label">贷款总额 :</label>
            <div class="controls">
                <form:input path="borrowTotalAmt" htmlEscape="false"  maxlength="50" />
                <span class="help-inline"><font color="red" style="visibility: hidden;">*</font> </span>
            </div>
        </div>
    </div>
    <div class="control-group">
        <div class="mar-right">
            <label class="control-label">需要还款金额:</label>
            <div class="controls">
                <form:input path="needBackTotalAmt" htmlEscape="false"  maxlength="50" />
                <span class="help-inline"><font color="red" style="visibility: hidden;">*</font> </span>
            </div>
        </div>
        <div class="mar-right">
            <label class="control-label">已经还款金额:</label>
            <div class="controls">
                <form:input path="alreadyBackTotalAmt" htmlEscape="false"  maxlength="50" />
                <span class="help-inline"><font color="red" style="visibility: hidden;">*</font> </span>
            </div>
        </div>
    </div>
    <div class="control-group">
        <div class="mar-right">
            <label class="control-label">户借款后,每天分得的钱冻结:</label>
            <div class="controls">
                <form:input path="backAmt" htmlEscape="false"  maxlength="50" />
                <span class="help-inline"><font color="red" style="visibility: hidden;">*</font> </span>
            </div>
        </div>
        <div class="mar-right">
            <label class="control-label">已经还款金额:</label>
            <div class="controls">
                <form:input path="alreadyBackTotalAmt" htmlEscape="false"  maxlength="50" />
                <span class="help-inline"><font color="red" style="visibility: hidden;">*</font> </span>
            </div>
        </div>
    </div>
    <c:if test="${not empty ebUser.userId}">
        <div class="control-group">
            <div class="mar-right">
                <label class="control-label">创建时间:</label>
                <div class="controls">
                    <label class="lbl"><fmt:formatDate value="${ebUser.createtime}" type="both" dateStyle="full"/></label>
                </div>
            </div>
            <div class="mar-right">
                <label class="control-label">最后登陆:</label>
                <div class="controls">
                    <label class="lbl">IP: ${ebUser.lastlogintime}&nbsp;&nbsp;&nbsp;&nbsp;时间：<fmt:formatDate value="${ebUser.lastlogintime}" type="both" dateStyle="full"/></label>
                </div>
            </div>
        </div>
    </c:if>
    <div class="form-actions">
        <shiro:hasPermission name="merchandise:user:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
        <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
    </div>
</form:form>
</body>
</html>