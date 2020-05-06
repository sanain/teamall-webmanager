<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>公益平台配置</title>
     <script src="${ctxStatic}/sbShop/js/jquery.min.js"></script>
    <link rel="stylesheet" href="${ctxStatic}/sbShop/css/platform-configuration.css">
     <style>
        .fix-in{position: fixed;top: 0;right: 0;left: 0;bottom: 0;background: rgba(0,0,0,0.3);display:none;}
        .fix-box{position: absolute;width: 400px;height: 200px;background: #ffffff;top: 50%;left: 50%;margin-top: -100px;margin-left: -200px}
        .fix-box>p{height: 35px;line-height: 35px;text-align: center;color: #333333;margin-bottom: 0;background: #f0f0f0;position: relative}
        .fix-box>p img{position: absolute;top: 12px;right: 15px;;cursor: pointer}
        .fix-box ul{list-style: none;padding: 0;color: #666666;margin-bottom: 0;margin-top: 15px}
        .fix-box ul li{line-height: 30px;margin-bottom: 5px}
        .fix-box ul span{width: 150px;text-align: right;display: inline-block}
        .fix-txt{text-align: center;margin-top:30px;}
        .fix-box ul b{font-weight: normal}
        .fix-box ul input{height: 30px;border: 1px solid #dcdcdc;border-radius: 3px;}
        .fix-btn{text-align: center;margin-top: 30px}
        .fix-btn a{display: inline-block;height: 30px;line-height: 30px;padding: 0 15px;background: #69AC72;color: #ffffff;border-radius: 5px;text-decoration: none}
        .fix-btn a:nth-child(1){margin-right: 10px}
        .fix-btn a:nth-child(2){background: #ffffff;border: 1px solid #dcdcdc;color: #666666;margin-left: 10px}
    </style>
    <script>
    	$(function(){
    		var cval='';
    		var cid='';
    		var cin;
    		$('.fix-add').click(function(){
    			$('.fix-in').hide();
    			if(!isNaN(cval)){
					   $.ajax({
				      url:"${ctxsys}/PmBenefit/save",
				      data:{id:cid, val:cval},
				      success:function(data){
				       cin.val(data.value);
				      }
				    }); 
					}else{
					   alert("参数错误！");
					}
    		});
    		
    		$('input').blur(function(){
    			cin=$(this);
    			cval=$(this).val();
    			cid=$(this).attr('id');
    			if($(this).hasClass('minStimulateLevel')){
    			   if(parseInt($(this).val())<0){
    			      alert("请输入整数");
    			      window.location.href="${ctxsys}/PmBenefit";
    			      return;
    			   }  
    			   if(parseInt($(this).val())>=parseInt($(".maxStimulateLevel").val())){
    			      alert("最小激励级别大于最大激励级别");
    			      window.location.href="${ctxsys}/PmBenefit";
    			      return;
    			   }
    			}
    			if($(this).hasClass('maxStimulateLevel')){
    			   if(parseInt($(this).val())<0){
    			      alert("请输入整数");
    			      window.location.href="${ctxsys}/PmBenefit";
    			      return;
    			   }
    			   if(parseInt($(this).val())<=parseInt($(".minStimulateLevel").val())){
    			      alert("最大激励级别小于最小激励级别");
    			      window.location.href="${ctxsys}/PmBenefit";
    			      return;
    			   }
    		     }
    		     $('.fix-in').show();
    		});
    		$('.fix-del').click(function(){
    			$('.fix-in').hide();
    		});
    	});
    </script>
</head>
<body>
    <div class="platform">
        <p>平台积分配置</p>
        <div class="platform-list">
            <ul>
                <li>积分获得：</li>
                <li>
                  <c:forEach items="${sysDicts}" var="sysDicts">
                  <c:if test="${sysDicts.label=='InLove_One'}">
                    <input id="${sysDicts.id}" type="text" value="${sysDicts.value}">元=1个积分
                    </c:if>
                   </c:forEach>
                </li>
            </ul>
            <ul>
                <li>积分消耗：</li>
                <li>
                 <c:forEach items="${sysDicts}" var="sysDicts">
                  <c:if test="${sysDicts.label=='OutLove_One'}">
                    <input id="${sysDicts.id}" type="text" value="${sysDicts.value}">元=1个积分
                    </c:if>
                   </c:forEach>
                </li>
            </ul>
            <ul>
                <li>激励消费金比例：</li>
                <li>
                  <c:forEach items="${sysDicts}" var="sysDicts">
                  <c:if test="${sysDicts.label=='consumptionPointsRatio'}">
                    <input id="${sysDicts.id}" type="text" value="${sysDicts.value}">%
                    </c:if>
                   </c:forEach>
                </li>
            </ul>
            <ul>
                <li>消费金对比余额倍数：</li>
                <li>
                  <c:forEach items="${sysDicts}" var="sysDicts">
                  <c:if test="${sysDicts.label=='pointsCompareBalance'}">
                    <input id="${sysDicts.id}" type="text" value="${sysDicts.value}">倍
                    </c:if>
                   </c:forEach>
                </li>
            </ul>
        </div>

        <p>利益分配</p>
        <div class="platform-list">
         <ul>
                <li>平台总收益：</li>
                <li>
                  <c:forEach items="${sysDicts}" var="sysDicts">
                  <c:if test="${sysDicts.label=='sysEarnings'}">
                    <input  id="${sysDicts.id}" type="text" value="${sysDicts.value}">%金额
                  </c:if>
                  </c:forEach>
                </li>
            </ul>
            <ul>
                <li>${fns:getProjectName()}平台：</li>
                <li>
                  <c:forEach items="${sysDicts}" var="sysDicts">
                  <c:if test="${sysDicts.label=='Platform_Rate'}">
                    <input  id="${sysDicts.id}" type="text" value="${sysDicts.value}">%平台总收益
                  </c:if>
                  </c:forEach>
                </li>
            </ul>
            <ul>
                <li>集团公司：</li>
                <li>
                 <c:forEach items="${sysDicts}" var="sysDicts">
                  <c:if test="${sysDicts.label=='group_company'}">
                    <input  id="${sysDicts.id}" type="text" value="${sysDicts.value}">%平台总收益
                    </c:if>
                    </c:forEach>
                </li>
            </ul>
            <ul>
                <li>分享基金：</li>
                <li>
                 <c:forEach items="${sysDicts}" var="sysDicts">
                  <c:if test="${sysDicts.label=='Fund'}">
                    <input  id="${sysDicts.id}" type="text" value="${sysDicts.value}">%平台总收益
                    </c:if>
                    </c:forEach>
                </li>
            </ul>
            <ul>
                <li>税费：</li>
                <li>
                 <c:forEach items="${sysDicts}" var="sysDicts">
                  <c:if test="${sysDicts.label=='Taxes'}">
                    <input  id="${sysDicts.id}" type="text" value="${sysDicts.value}">%金额
                    </c:if>
                    </c:forEach>
                </li>
            </ul>
        </div>

        <p>会员支付额度分配</p>
        <div class="platform-list">
            <ul>
                <li>普通会员：</li>
                <li>
                   <c:forEach items="${sysDicts}" var="sysDicts">
                  <c:if test="${sysDicts.label=='Envoy_Pay'}">
                    <input  id="${sysDicts.id}" type="text" value="${sysDicts.value}">元
                    </c:if>
                    </c:forEach>
                </li>
            </ul>
            <ul>
                <li>普通合伙人：</li>
                <li>
                   <c:forEach items="${sysDicts}" var="sysDicts">
                  <c:if test="${sysDicts.label=='Inherit_Pay'}">
                    <input  id="${sysDicts.id}" type="text"  value="${sysDicts.value}">元
                    </c:if>
                    </c:forEach>
                </li>
            </ul>
            <ul>
                <li>精英合伙人：</li>
                <li>
                   <c:forEach items="${sysDicts}" var="sysDicts">
                    <c:if test="${sysDicts.label=='Special_Pay'}">
                    <input  id="${sysDicts.id}" type="text" value="${sysDicts.value}">元
                    </c:if>
                    </c:forEach>
                </li>
            </ul>
        </div>

        <p>代理收入</p>
        <div class="platform-list">
            <ul>
                <li>区代理收入：</li>
                <li>
                   <c:forEach items="${sysDicts}" var="sysDicts">
                  <c:if test="${sysDicts.label=='AgencyFee'}">
                    <input  id="${sysDicts.id}" type="text" value="${sysDicts.value}">%积分激励
                    </c:if>
                    </c:forEach>
                </li>
            </ul>
            <ul>
                <li>市代理收入：</li>
                <li>
                   <c:forEach items="${sysDicts}" var="sysDicts">
                  <c:if test="${sysDicts.label=='CityAgency'}">
                    <input  id="${sysDicts.id}" type="text" value="${sysDicts.value}">%积分激励
                    </c:if>
                    </c:forEach>
                </li>
            </ul>
            <ul>
                <li>省代理收入：</li>
                <li>
                   <c:forEach items="${sysDicts}" var="sysDicts">
                     <c:if test="${sysDicts.label=='ProvincialAgent'}">
                    <input  id="${sysDicts.id}" type="text" value="${sysDicts.value}">%积分激励
                    </c:if>
                    </c:forEach>
                </li>
            </ul>
        </div>

        <p>普通合伙人升级配置</p>
        <div class="platform-list">
            <ul>
                <li>一次性最低消费：</li>
                <li>
                   <c:forEach items="${sysDicts}" var="sysDicts">
                    <c:if test="${sysDicts.label=='minConsume'}">
                    <input  id="${sysDicts.id}" type="text" value="${sysDicts.value}">元
                    </c:if>
                    </c:forEach>
                </li>
            </ul>
            <ul>
                <li>最低推荐注册人数：</li>
                <li>
                   <c:forEach items="${sysDicts}" var="sysDicts">
                   <c:if test="${sysDicts.label=='minRef'}">
                    <input  id="${sysDicts.id}" type="text" value="${sysDicts.value}">人
                     </c:if>
                    </c:forEach>
                  
                </li>
            </ul>
        </div>

        <p>精英合伙人年费配置</p>
        <div class="platform-list">
            <ul>
                <li>费用：</li>
                <li>
                   <c:forEach items="${sysDicts}" var="sysDicts">
                   <c:if test="${sysDicts.label=='annualFee'}">
                    <input  id="${sysDicts.id}" type="text"  value="${sysDicts.value}">元
                     </c:if>
                    </c:forEach>
                </li>
            </ul>
        </div>

        <p>商家门店配置</p>
        <div class="platform-list">
            <ul>
                <li>门店最低折扣比例：</li>
                <li>
                   <c:forEach items="${sysDicts}" var="sysDicts">
                    <c:if test="${sysDicts.label=='minRatio'}">
                    <input  id="${sysDicts.id}" type="text" value="${sysDicts.value}">%
                     </c:if>
                    </c:forEach>
                </li>
            </ul>
            <ul>
                <li>门店最大折扣比例：</li>
                <li>
                   <c:forEach items="${sysDicts}" var="sysDicts">
                     <c:if test="${sysDicts.label=='maxRatio'}">
                    <input  id="${sysDicts.id}" type="text" value="${sysDicts.value}">%
                     </c:if>
                    </c:forEach>
                </li>
            </ul>
        </div>
 		<p>消费激励配置</p>
        <div class="platform-list">
            <ul>
                <li>一级推荐人奖励：</li>
                <li>
                   <c:forEach items="${sysDicts}" var="sysDicts">
                    <c:if test="${sysDicts.label=='One_RefLove'}">
                    <input  id="${sysDicts.id}" type="text" value="${sysDicts.value}">%积分激励
                     </c:if>
                    </c:forEach>
                </li>
            </ul>
            <ul>
                <li>二级推荐人奖励：</li>
                <li>
                   <c:forEach items="${sysDicts}" var="sysDicts">
                     <c:if test="${sysDicts.label=='Two_RefLove'}">
                    <input  id="${sysDicts.id}" type="text" value="${sysDicts.value}">%积分激励
                     </c:if>
                    </c:forEach>
                </li>
            </ul>
            <ul>
                <li>商家推荐人奖励：</li>
                <li>
                   <c:forEach items="${sysDicts}" var="sysDicts">
                   <c:if test="${sysDicts.label=='Shop_RefLove'}">
                    <input  id="${sysDicts.id}" type="text" value="${sysDicts.value}">%积分激励
                    </c:if>
                    </c:forEach>
                </li>
            </ul>
             <ul>
                <li>消费奖励倍数：</li>
                <li>
                   <c:forEach items="${sysDicts}" var="sysDicts">
                   <c:if test="${sysDicts.label=='Out_Folds'}">
                    <input  id="${sysDicts.id}" type="text" value="${sysDicts.value}">
                    </c:if>
                    </c:forEach>
                </li>
            </ul>
            <ul>
                <li>商家奖励倍数：</li>
                <li>
                   <c:forEach items="${sysDicts}" var="sysDicts">
                   <c:if test="${sysDicts.label=='Shop_Folds'}">
                    <input  id="${sysDicts.id}" type="text" value="${sysDicts.value}">
                    </c:if>
                    </c:forEach>
                </li>
            </ul>
        </div>
         <p>线下充值的补贴比例</p>
        <div class="platform-list">
            <ul>
                <li>线下充值补贴：</li>
                <li>
                  <c:forEach items="${sysDicts}" var="sysDicts">
                  <c:if test="${sysDicts.label=='rargeRechargeAllowanceRatio'}">
                    <input id="${sysDicts.id}" type="text" value="${sysDicts.value}">%
                    </c:if>
                   </c:forEach>
                </li>
            </ul>
        </div>
        <p>预设积分指数</p>
         <div class="platform-list">
            <ul>
                <li>预设积分指数：</li>
                <li>
                  <c:forEach items="${sysDicts}" var="sysDicts">
                  <c:if test="${sysDicts.label=='preinstallLoveIndex'}">
                    <input id="${sysDicts.id}" type="text" value="${sysDicts.value}">
                    </c:if>
                   </c:forEach>
                </li>
            </ul>
             <ul>
                <li>冻结积分激活倍数：</li>
                <li>
                  <c:forEach items="${sysDicts}" var="sysDicts">
                  <c:if test="${sysDicts.label=='loveActivateMultiple'}">
                    <input id="${sysDicts.id}" type="text" value="${sysDicts.value}">倍
                    </c:if>
                   </c:forEach>
                </li>
            </ul>
             <ul>
                <li>唤醒倍数：</li>
                <li>
                  <c:forEach items="${sysDicts}" var="sysDicts">
                  <c:if test="${sysDicts.label=='loveAwakenMultiple'}">
                    <input id="${sysDicts.id}" type="text" value="${sysDicts.value}">倍
                    </c:if>
                   </c:forEach>
                </li>
            </ul>
            <ul>
                <li>每天消耗备用金最大取值：</li>
                <li>
                  <c:forEach items="${sysDicts}" var="sysDicts">
                  <c:if test="${sysDicts.label=='todayMaxImprestConsume'}">
                    <input id="${sysDicts.id}" type="text" value="${sysDicts.value}">
                    </c:if>
                   </c:forEach>
                </li>
            </ul>
            <ul>
                <li>最小激励级别：</li>
                <li>
                  <c:forEach items="${sysDicts}" var="sysDicts">
                  <c:if test="${sysDicts.label=='minStimulateLevel'}">
                    <input id="${sysDicts.id}" class="minStimulateLevel" type="text" value="${sysDicts.value}">
                    </c:if>
                   </c:forEach>
                </li>
            </ul>
            <ul>
                <li>最大激励级别：</li>
                <li>
                  <c:forEach items="${sysDicts}" var="sysDicts">
                  <c:if test="${sysDicts.label=='maxStimulateLevel'}">
                    <input id="${sysDicts.id}" class="maxStimulateLevel"  type="text" value="${sysDicts.value}">
                    </c:if>
                   </c:forEach>
                </li>
            </ul>
             <ul>
                <li>积分商城模式1账号：</li>
                <li>
                  <c:forEach items="${sysDicts}" var="sysDicts">
                    <c:if test="${sysDicts.label=='pointsMallLoveAccount'}">
                    <input id="${sysDicts.id}" type="text" style="width:120px;" value="${sysDicts.value}"><span style="color: red;">（注：必须是会员账号）</span>
                    </c:if>
                   </c:forEach>
                </li>
            </ul>
        </div>
      <div class="fix-in">
        <div class="fix-box">
            <p>提示</p>
            <div>
             	<div class="fix-txt">
             		是否确认修改？
             	</div>
                <div class="fix-btn">
                    <a class="fix-add" href="javascript:;">确定</a>
                    <a class="fix-del" href="${ctxsys}/PmBenefit">取消</a>
                </div>
            </div>
        </div>
</div>
      <!--   <a class="pla-btn" href="javascript:;">保存</a> -->
    </div>
</body>
</html>