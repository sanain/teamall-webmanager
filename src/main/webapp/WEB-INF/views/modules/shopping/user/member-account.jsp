<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0,minimal-ui">
    <meta name="Description" content="${fns:getProjectName()},会员账户"/>
	<meta name="Keywords" content="${fns:getProjectName()},会员账户"/>
    <title>会员账户</title>
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/admin-member-account.css">
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/bootstrap.min.css">
    <script src="${ctxStatic}/sbShop/js/jquery.min.js"></script>
     <script src="${ctxStatic}/sbShop/js/admin-member-account.js"></script>
    <script src="${ctxStatic}/bootstrap/2.3.1/js/bootstrap.min.js" type="text/javascript"></script>
    <script type="text/javascript">
    $(function(){
     $('body').one('click','#saveInfo2',function(){
       
		 if($("#maxPay").val()!=null&&$("#maxPay").val()!=''){
		  
		    	var userId=$('#userId').val();
		    	var maxPay=$('#maxPay').val();
		 	     $.ajax({
		             type: "POST",
		             url: "${ctxsys}/User/setCurrentAmt",
		             data: {userId:userId, maxPay:maxPay},
		             success: function(data){
		               location.href ="${ctxsys}/User/userAccount?userId=${userId}";
		             },error: function(XMLHttpRequest, textStatus, errorThrown) {
		             }
		          });
				}else{
				 alert("金额不能为空!");
				return false;
		}
	})
    $('body').one('click','#saveInfo',function(){
		if($('input[name="currentAmt"]').val()!=null&&$('input[name="currentAmt"]').val()!=''){
				var userId=$('#userId').val();
				var currentAmt=$('#currentAmt').val();
		 	     $.ajax({
		             type: "POST",
		             url: "${ctxsys}/User/currentAmt",
		             data: {userId:userId, currentAmt:currentAmt},
		             success: function(data){
		               location.href ="${ctxsys}/User/userAccount?userId=${userId}";
		               },error: function(XMLHttpRequest, textStatus, errorThrown) {
		             }
		           });
			}else{
				alert("金额不能为空!");
				return false;
			}
	})
    })
      
    </script>
</head>
<body>
    <div class="c-context">
        <ul class="nav-ul">
            <li><a href="${ctxsys}/User/form?userId=${userId}">会员信息</a></li>
            <li><a class="active" href="${ctxsys}/User/userAccount?userId=${userId}">会员账户</a></li>
            <li><a href="${ctxsys}/User/userrelation?userId=${userId}">会员关系</a></li>
        </ul>
        <input id="userId" name="userId" type="hidden" value="${ebUser.userId}"/>
        <input id="ctxStatic" name="ctxStatic" type="hidden" value="${ctxStatic}"/>
        <div class="context-box">
            <ul>
                <li>
                    <span>当前余额：</span>
                    <b>${ebUser.currentAmt}</b>
                    <shiro:hasPermission name="merchandise:user:editInfo">
                    	<a href="javascript:;" data-toggle="modal" data-target="#myModal">充值</a>
                    </shiro:hasPermission>
                </li>
                 <%--<li>--%>
                    <%--<span>线下大额充值余额：</span>--%>
                    <%--<b>${ebUser.currentAmtOffline}</b>--%>
                 <%--</li>--%>
                <li>
                    <span>可激励积分：</span>
                    <b>${ebUser.usableLove}</b>
                </li>
                <li>
                    <span>冻结金额：</span>
                    <b>${ebUser.frozenAmt}</b>
                </li>
                <li>
                    <span>当前积分：</span>
                    <b><fmt:formatNumber value="${ebUser.currentLove}" pattern="0.0000"/></b>
                </li>
                    <%--<span>今日激励金额：</span>--%>
                    <%--<b>${ebUser.todayAmt}</b>--%>
                <%--</li>--%>
                <li>
                    <span>今日新增积分：</span>
                    <b><fmt:formatNumber value="${ebUser.todayAddLove}" pattern="0.0000"/></b>
                </li>

                <li>
                    <span>今日退还积分：</span>
                    <b><fmt:formatNumber value="${ebUser.todayRefundLove}" pattern="0.0000"/></b>
                </li>
                <%--<li>--%>
                    <%--<span>累计奖励金额：</span>--%>
                    <%--<b>${ebUser.loveAmt}</b><!-- haveChangeLove -->--%>
                <%--</li>--%>
                <li>
                    <span>累计积分：</span>
                    <b>${ebUser.totalLove}</b>
                </li>
                 <li>
                    <span>冻结积分：</span>
                    <b>${ebUser.frozenLove}</b>
                </li>
                <%--<li>--%>
                    <%--<span>银行卡数量：</span>--%>
                    <%--<b>${userBankCount}</b>--%>
                    <%--<a class="bank-show" href="${ctxsys}/User/userbanks?userId=${userId}">查看详情</a>--%>
                <%--</li>--%>
                <%--<li>--%>
                    <%--<span>今日剩余额度：</span>--%>
                    <%--<b>${surplusAmount}</b>--%>
                <%--</li>--%>
                <%--<li>--%>
                    <%--<span>最大消费额度：</span>--%>
                    <%--<b>${ebUser.maxPay}</b>--%>
                    <%--<a href="javascript:;" data-toggle="modal" data-target="#myModal_d">设置</a>--%>
                <%--</li>--%>
                <%--<li>--%>
                    <%--<span>消费金：</span>--%>
                    <%--<b><fmt:formatNumber type="number" value="${ebUser.consumptionPoints}" pattern="0.00" maxFractionDigits="2"/></b>--%>
                <%--</li>--%>
            </ul>
            <div class="msg-btn">
                <a class="btn sb-show" href="${ctxsys}/User/useramtlog?userId=${userId}">查看余额明细</a>
                <%--<a class="btn sb-show" href="${ctxsys}/User/userlovelog?userId=${userId}">查看积分明细</a>--%>
                <%--<a class="btn sb-show" href="${ctxsys}/User/fzuserlovelog?userId=${userId}">查看冻结积分明细</a>--%>
                <%--<a class="btn sb-show" href="${ctxsys}/User/consumptionPoints?userId=${userId}">查看消费金明细</a>--%>
                <a class="btn sb-show" href="${ctxsys}/User/certificateLog?userId=${userId}">查看优惠券明细</a>
            </div>
        </div>
        <%-- <div class="bank">
            <div class="bank-list">
                <ul>
                    <li>添加时间</li>
                    <li>开户行</li>
                    <li>所属支行</li>
                    <li>卡号</li>
                    <li>手机号</li>
                    <li>操作</li>
                </ul>
                <div class="list-body">
                  <c:forEach items="${userBanks}" var="userBank">
                    <ul>
                        <li><fmt:formatDate value="${userBank.createTime}" type="both"/></li>
                        <li>${userBank.bankName}</li>
                        <li>${userBank.districtName}</li>
                        <li>${userBank.account}</li>
                        <li>${userBank.phoneNum}</li>
                        <li>
                            <a href="javascript:;">设为默认</a>
                            <a href="javascript:;">删除</a>
                        </li>
                    </ul>
                 </c:forEach>
                </div>
            </div>
        </div> --%>
    </div>
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title">会员充值</h4>
	        </div>
		        <div class="modal-body">
			        <form id="form2">
			           <p><span>请输入金额:</span><input type="number" step="0.1" min="0" id="currentAmt" name="currentAmt" value="0" required /></p>
			        </form>
		        </div>
	        <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	        <button type="button" class="btn btn-primary" id="saveInfo" >保存</button>
	        </div>
		    </div>
		  </div>
		</div>
		<div class="modal fade" id="myModal_d" tabindex="-1" role="dialog">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		        <h4 class="modal-title">金额设置</h4>
		        </div>
			        <div class="modal-body">
				        <form id="form3">
				           <p><span>每日支付最大额度:</span><input id="maxPay" name="maxPay" type="number" step="0.1" min="0" value="${ebUser.maxPay}"/></p>
				        </form>
			        </div>
		        <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	        <button type="button" class="btn btn-primary" id="saveInfo2" >保存</button>
	        </div>
		    </div>
		  </div>
		</div>
</body>
</html>