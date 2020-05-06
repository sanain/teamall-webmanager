package com.jq.support.main.controller.merchandise.mecontent;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.jq.support.common.interceptor.model.JPostMode;
import com.jq.support.common.web.BaseController;
import com.jq.support.jsoncode.JsonCode;
import com.jq.support.service.JsonService;
import com.jq.support.service.common.PcUserLoginException;
import com.jq.support.service.common.ServiceException;
import com.jq.support.service.common.UserLoginException;
import com.jq.support.service.common.UserStatusException;


@Controller
@RequestMapping("/json")
public class JsonController extends BaseController{
	private static Log logger = LogFactory.getLog("appgetjson"); 
	@Autowired
	private JsonService jsonService;
	
	@RequestMapping(value = "/index")
	@ResponseBody
	public String index (HttpServletRequest request,HttpServletResponse response){
		String contenthtm = request.getParameter("content");// 内容
		logger.info(contenthtm);
		ObjectMapper mapper = new ObjectMapper();
		String strRet=null;
		try {
			JPostMode jpost =  mapper.readValue(contenthtm, JPostMode.class);
			JsonCode code = JsonCode.valueOf(jpost.getHead().getCode());
			try {
				switch (code) {	
				case Version: // 获取版号本(1000)
					strRet = jsonService.Version(jpost);
					break;
				case Login://登陆(1001)
					strRet = jsonService.Login(jpost,request);
					break;
				case RegisterUser://注册(1002)
					strRet = jsonService.RegisterUser(jpost);
					break;
				case SmsCode: //发送验证码(1003)
					strRet = jsonService.SmsCode(jpost);
					break;
				case EbUserPassWordUpdate://修改密码(1004)
					strRet = jsonService.EbUserPassWordUpdate(jpost);
					break;
				case EbUserPassWordFind://找回密码(1005)
					strRet = jsonService.EbUserPassWordFind(jpost);
					break;
				case PmProtocol://平台服务协议(1006)
					strRet = jsonService.PmProtocol(jpost);
					break;
				case EbUserDataUpdate://修改用户信息
					strRet = jsonService.EbUserDataUpdate(jpost,request);
					break;	
				case PmLayouttype://首页广告(1007)
					strRet = jsonService.PmLayouttype(jpost);
					break;
				case PmLovely://猜你喜欢(1008)
					strRet = jsonService.PmLovely(jpost);
					break;
				case PmFunctionClass://功能按钮(1009)
					strRet = jsonService.PmFunctionClass(jpost);
					break;
				case OnePmProductTypeAndBrandList://一级的商品分类及下所有品牌列表(1237)
					strRet = jsonService.onePmProductTypeAndBrandList(jpost);
					break;
				case GetPmProductTypeList://获取商品分类列表(1010)
					strRet = jsonService.getPmProductTypeList(jpost);
					break;
				case GetHotPmProductTypeList://获取热门商品分类(1011)
					strRet = jsonService.getHotPmProductTypeList(jpost);
					break;
				case AddEbCollect://添加收藏(1012)
					strRet = jsonService.addEbCollect(jpost);
					break;
				case PmProductList://商品list(1013)
					strRet = jsonService.pmProductList(jpost);
					break;
				case BrandScreening://筛选品牌(1014)
					strRet = jsonService.brandScreening(jpost);
					break;
				case FilterCategory://筛选类别(1015)
					strRet = jsonService.filterCategory(jpost);
					break;
				case GetPmSysDistrictList://获取国家省市区地址列表(1016)
					strRet = jsonService.getPmSysDistrictList(jpost);
					break;
				case GetEbCollectList://获取收藏列表(1017)
					strRet = jsonService.getEbCollectList(jpost);
					break;
				case EbUseraddress://获取用户收货地址列表(1018)
					strRet = jsonService.ebUseraddress(jpost);
					break;
				case SelectShopProduct://搜索门店列表（包括商品）(1020)
					strRet = jsonService.selectShopProduct(jpost);
					break;
				case FindkeywordsList://搜索商品关键字列表(1021)
					strRet = jsonService.findkeywordsList(jpost);
					break;	
				case FindShopInfoList://根据门店名模糊搜索门店列表(1022)
					strRet = jsonService.findShopInfoList(jpost);
					break;	
				case GetPmShopProductTypeList://通过门店ID获取该门店下的商品分类(1023)
					strRet = jsonService.getPmShopProductTypeList(jpost);
					break;	
				case GetShopInfo://门店详细信息接口(1024)
					strRet = jsonService.getShopInfo(jpost);
					break;	
				case GetProductTypeSpertAttrAndValueList://根据三级分类查询属性以及属性值列表(1025)
					strRet = jsonService.getProductTypeSpertAttrAndValueList(jpost);
					break;	
				case ProductProvincesAndCityList://根据商品搜索条件获取商品所在地省市列表；(1026)
					strRet = jsonService.productProvincesAndCityList(jpost);
					break;
				case ServicePay://余额支付，微信支付，银联支付，支付宝支付调用接口(1056)
					strRet = jsonService.servicePay(jpost,request);
					break;
				case UnreadMessagesTotal://获取用户未读消息总数(1057)
					strRet = jsonService.unreadMessagesTotal(jpost);
					break;
				case MessageTypeList://获取分类下的消息列表(1058)
					strRet = jsonService.messageTypeList(jpost);
					break;
				case DeleteMessage://删除消息(1059)
					strRet = jsonService.deleteMessage(jpost);
					break;
				case NewMessageList://获取消息分类（包含未读消息数量和最新一条消息摘要）(1060)
					strRet = jsonService.newMessageList(jpost);
					break;
				case PmImComRoomAndRecordList://根据用户获取该用户与商家之间的IM房间列表（包含未读消息数量、最新一条消息内容、时间）
					strRet = jsonService.pmImComRoomAndRecordList(jpost);
					break;
				case FindPmImComRecordByRoomIdList://通过IM房间ID获取IM房间明细信息列表
					strRet = jsonService.findPmImComRecordByRoomIdList(jpost);
					break;
				case SavePmImComRecord://保存IM聊天记录接口
					strRet = jsonService.savePmImComRecord(jpost);
					break;
				case UpdatePmImComRecordIsRead://通过IM房间ID把用户未读商家消息状态修改为已读
					strRet = jsonService.updatePmImComRecordIsRead(jpost);
					break;
				case SaveThumbrecord://保存点赞接口
					strRet = jsonService.saveThumbrecord(jpost);
					break;
				case FindArticleTypeList://获取文章大类别下的分类列表
					strRet = jsonService.findArticleTypeList(jpost);
					break;
				case SearchEbArticleList://搜索获取文章列表
					strRet = jsonService.searchEbArticleList(jpost);
					break;
				case ArticleInfo://根据文章id获取文章
					strRet = jsonService.articleInfo(jpost);
					break;
				case SaveEbDiscuss://保存文章评论以及文章评论的评论接口
					strRet = jsonService.saveEbDiscuss(jpost);
					break;
				case SaveEbGoodPay://保存是否值得购买接口
					strRet = jsonService.saveEbGoodPay(jpost);
					break;
				case ProductOneClassList://商品一级分类列表
					strRet = jsonService.productOneClassList(jpost);
					break;
				case TwoClassProductList://通过商品一级分类查找二级分类列表；
					strRet = jsonService.twoClassProductList(jpost);
					break;
				case NearShopAndProductList://搜索获取附近商家列表（包括商家信息和商家橱窗商品）；
					strRet = jsonService.nearShopAndProductList(jpost);
					break;
				case GuessShopAndProductList://猜你喜欢 获取附近商家列表
					strRet = jsonService.guessShopAndProductList(jpost);
					break;
				case MyLoveDetail://我的御可贡茶
					strRet = jsonService.myLoveDetail(jpost);
					break;
				case MyOrderLoveList://御可贡茶明细列表
					strRet = jsonService.myOrderLoveList(jpost);
					break;
				case MyChangeLoveList://御可贡茶激励明细列表
					strRet = jsonService.myChangeLoveList(jpost);
					break;
				case CommentsArticleList://获取文章评论列表
					strRet = jsonService.commentsArticleList(jpost);
					break;
				case ChangeMessageState://改变消息状态为已读接口
					strRet = jsonService.changeMessageState(jpost);
					break;
				case QueryOrder://查询订单
					strRet = jsonService.queryOrder(jpost);
					break;
				case QueryShopId://查询商家id
					strRet = jsonService.queryShopId(jpost);
					break;
				case QueryUserId://查询用户
					strRet = jsonService.QueryUserId(jpost);
					break;
				case SaveUserArticleLog://保存公告阅读记录
					strRet = jsonService.saveUserArticleLog(jpost);
					break;
				case NewNotice://最新的平台公告
					strRet = jsonService.newNotice(jpost);
					break;
				case HotShopProductList://热销商品列表
					strRet = jsonService.hotShopProductList(jpost);
					break;
				case EditEbUserDefaultaddress://编辑用户默认收货地址(1027)
					strRet = jsonService.editEbUserDefaultaddress(jpost);
					break;
				case GetEbProductcommentGood://获取商品好评评价列表(1270)
					strRet = jsonService.getEbProductcommentGood(jpost);
					break;
				case GetEbProductcommentList://获取商品评价列表(1028)
					strRet = jsonService.getEbProductcommentList(jpost);
					break;
				case GetPmQaHelpList://获取问答帮助中心列表(1029)
					strRet = jsonService.getPmQaHelpList(jpost);
					break;
				case GetProductInfo://商品详情(1030)
					strRet = jsonService.getProductInfo(jpost);
					break;
				case GetStandardList://商品规格(1031)
					strRet = jsonService.getStandardList(jpost);
					break;
				case GetShoppingcartList://购物车list(1032)
					strRet = jsonService.getShoppingcartList(jpost);
					break;
				case AddShoppingcart://add购物车(1033)
					strRet = jsonService.addShoppingcart(jpost);
					break;
				case EditShoppingcart://修改购物车(1034)
					strRet = jsonService.editShoppingcart(jpost);
					break;
				case PmLayouttypeTop://根据类型取滚动图(1035)
					strRet = jsonService.pmLayouttypeTop(jpost);
					break;
				case AddEbProductcomment://添加商品评价(1036)
					strRet = jsonService.addEbProductcomment(jpost,request);
					break;
				case AddShopComment://添加商家评价
					strRet = jsonService.addShopComment(jpost,request);
					break;
				case GetSysDictLabel://获取系统字典数据(1037)
					strRet = jsonService.getSysDictLabel(jpost);
					break;
				case AddPmUserFeedback://添加意见反馈(1038)
					strRet = jsonService.addPmUserFeedback(jpost,request);
					break;
				case CreateOrder://生成订单(1040)
					strRet = jsonService.createOrder(jpost,request);
					break;
				case OrderList://订单List
					strRet = jsonService.orderList(jpost);
					break;
				case OrderDetails://订单详情
					strRet = jsonService.orderDetails(jpost);
					break;
				case EditOrder://修改订单
					strRet = jsonService.editOrder(jpost);
					break;
				case GetEbSalesrecordLog://获取退货协商历史日志(1040)
					strRet = jsonService.getEbSalesrecordLog(jpost);
					break;
				case AddEbSalesrecordMsg://添加退货协商留言(1041)
					strRet = jsonService.addEbSalesrecordMsg(jpost,request);
					break;
				case GetEbAftersaleList://获取退款售后服务列表(1042)
					strRet = jsonService.getEbAftersaleList(jpost);
					break;
				case GetEbAftersaleForm://获取退款售后服务详情(1043)
					strRet = jsonService.getEbAftersaleForm(jpost);
					break;
				case GetServerNowTime://获取服务器当前时间(1044)
					strRet = jsonService.getServerNowTime(jpost);
					break;
				case ApplyPmReturnGoodInterveneForm://申请退款申请介入(1045)
					strRet = jsonService.applyPmReturnGoodInterveneForm(jpost,request);
					break;
				case AddEbAftersaleForm://添加申请退款售后服务(1046)
					strRet = jsonService.addEbAftersaleForm(jpost,request);
					break;
				case UpDateEbAftersaleForm://修改申请退款售后服务(1047)
					strRet = jsonService.upDateEbAftersaleForm(jpost,request);
					break;
				case CancelEbAftersaleForm://取消申请退款售后服务(1048)
					strRet = jsonService.cancelEbAftersaleForm(jpost);
					break;
				case AddEbAftersaleAddress://添加退款售后服务地址(1049)
					strRet = jsonService.addEbAftersaleAddress(jpost,request);
					break;
				case DefaultAddress://默认地址
					strRet = jsonService.defaultAddress(jpost);
					break;
				case FreightCharge://运费计算
					strRet = jsonService.freightCharge(jpost);
					break;
				case AddPmBrowseRecord://保存浏览记录
					strRet = jsonService.addPmBrowseRecord(jpost);
					break;
				case GetContactsSum://用户人脉数
					strRet = jsonService.getContactsSum(jpost);
					break;
				case GetContacts://用户一级人脉
					strRet = jsonService.getContacts(jpost);
					break;
				case GetTowContacts://用户二级人脉
					strRet = jsonService.getTowContacts(jpost);
					break;
				case PhotoCompression://图片压缩接口
					strRet = jsonService.photoCompression(jpost,request);
					break;
				case ShopApplication://商家申请入驻
					strRet = jsonService.shopApplication(jpost,request);
					break;
				case GetModelUser://根据手机号查询用户
					strRet = jsonService.getModelUser(jpost,request);
					break;
				case ShopApplicationRecord://查询商家入驻申请记录
					strRet = jsonService.shopApplicationRecord(jpost,request);
					break;
				case EditShopApplicationRecord://修改商家
					strRet = jsonService.editShopApplicationRecord(jpost,request);
					break;
				case EbUserPayPassword://设置支付密码
					strRet = jsonService.EbUserPayPassword(jpost);
					break;
				case GetShopPendingRefundList://获取卖家待审核退款列表
					strRet = jsonService.getShopPendingRefundList(jpost);
					break;
				case GetShopPendingRefund://获取卖家待审核退款详情 
					strRet = jsonService.getShopPendingRefund(jpost);
					break;
				case ShopRefuseRefunds:
					strRet = jsonService.shopRefuseRefunds(jpost,request);
					break;
				case ShopAgreeRefunds:
					strRet = jsonService.shopAgreeRefunds(jpost);
					break;
				case GetMyBankCardList://获取我的银行卡列表(1201)
					strRet = jsonService.getMyBankCardList(jpost);
					break;
				case DeleteMyBankCard://删除我的银行卡(1202)
					strRet = jsonService.deleteMyBankCard(jpost);
					break;
				case AddMyBankCard://添加我的银行卡(1203)
					strRet = jsonService.addMyBankCard(jpost);
					break;
				case DefaultMyBankCard://默认我的银行卡(1204)
					strRet = jsonService.defaultMyBankCard(jpost);
					break;
				case ApplyToCash://申请提现(1205)
					strRet = jsonService.applyToCash(jpost);
					break;
				case GetMYAmtLogList://获取我的余额明细列表(1206)
					strRet = jsonService.getMYAmtLogList(jpost);
					break;
				case GetMyspendingAmountList://我的消费额度列表(1208)
					strRet = jsonService.getMyspendingAmountList(jpost);
					break;
				case GetAgentShopInfoList://获取代理分场信息列表(1209)
					strRet = jsonService.getAgentShopInfoList(jpost);
					break;
				case DetermineRealName://银行卡信息验证(1210)
					strRet = jsonService.determineRealName(jpost);
					break;
				case GetMyspendingAmount://获取我的消费额度(1211)
					strRet = jsonService.GetMyspendingAmount(jpost);
					break;
				case PostPmReturnGoodInterveneForm://提交退款申请介入凭证(1212)
					strRet = jsonService.postPmReturnGoodInterveneForm(jpost,request);
					break;
				case UpdateEbAftersale:
					strRet = jsonService.updateEbAftersale(jpost);
					break;	
				case QRCode:
					strRet = jsonService.qRCode(jpost);
					break;
				case IsThereAPaymentPassword:
					strRet = jsonService.isThereAPaymentPassword(jpost);
					break;
				case AddEbProductcomments://多评价添加
					strRet = jsonService.addEbProductcomments(jpost,request);
					break;
				case GetSysDictLabels:
					strRet = jsonService.getSysDictLabels(jpost);
					break;
				case OrderStatusMuns:
					strRet = jsonService.orderStatusMuns(jpost);
					break;
				case ProductDeleOrUpDown:
					strRet = jsonService.productDeleOrUpDown(jpost);
					break;
				case ReviseProduct:
					strRet = jsonService.reviseProduct(jpost,request);
					break;
				case ProductFrom:
					strRet = jsonService.productFrom(jpost);
					break;
				case ShopShipments://商家发货
					strRet = jsonService.shopShipments(jpost);
					break;
				case SanBaoShareMall://御可贡茶
					strRet = jsonService.sanBaoShareMall(jpost);
					break;
				case OfflineRechargeLogs:
					strRet = jsonService.offlineRechargeLogs(jpost);
					break;
				case OfflineRechargeApply:
					strRet = jsonService.offlineRechargeApply(jpost,request);
					break;
				case OfflineRechargeApplyRefunds:
					strRet = jsonService.offlineRechargeApplyRefunds(jpost);
					break;
				case UploadPictures:
					strRet = jsonService.uploadPictures(jpost,request);
					break;
				case FreightProductCharge://立即下单计算运费
					strRet = jsonService.freightProductCharge(jpost);
					break;
				case GetShopDepotAddressList:
					strRet = jsonService.getShopDepotAddressList(jpost);
					break;
				case EditShopDepotAddress:
					strRet = jsonService.editShopDepotAddress(jpost);
					break;
				case DelectShopDepotAddress:
					strRet = jsonService.delectShopDepotAddress(jpost);
					break;
				case DefaultShopDepotAddress:
					strRet = jsonService.defaultShopDepotAddress(jpost);
					break;
				case ShopTop:
					strRet = jsonService.shopTop(jpost);
					break;
				case PayType://支付方式，付款方式
					strRet = jsonService.payType(jpost);
					break;	
				case YzSmsCode:
					strRet = jsonService.yzSmsCode(jpost);
					break;	
				case ShopCoot:
					strRet = jsonService.shopCoot(jpost);
					break;
				case YacolSmsCode://酷宝快捷支付 支付发送短信
					strRet = jsonService.yacolSmsCode(jpost);
					break;	
				case RepeatSmsCode://酷宝快捷支付 短信重发
					strRet = jsonService.repeatSmsCode(jpost);
					break;	
				case GetUserUsloveInfo:
					strRet = jsonService.getUserUsloveInfo(jpost);
					break;
				case GetUserUfrozenGold:
					strRet = jsonService.getUserUfrozenGold(jpost);
					break;
				case GetOneLeveType:
					strRet = jsonService.getOneLeveType(jpost);
					break;
				case GetUserAwakenLog://用户带出积分明细
					strRet = jsonService.getUserAwakenLog(jpost);
					break;
				case PmConsumptionPointsLogList://我的消费金列表
					strRet = jsonService.pmConsumptionPointsLogList(jpost);
					break;
				case GetEbAPhysicalStoreList://实体店列表
//					strRet = jsonService.getEbAPhysicalStoreList(jpost);
					break;
				case GuessNearEbAPhysicalStoreList://下单附近实体店列表
//					strRet = jsonService.guessNearEbAPhysicalStoreList(jpost);
					break;
				case ShopIdSmallBApplication://入驻小B申请
					strRet = jsonService.shopIdSmallBApplication(jpost,request);
					break;
				case AtOnceProductFreight://按照价格立即下单计算运费
					strRet = jsonService.atOnceProductFreight(jpost);
					break;
				case ShoppingCartProductFreight://按照价格运费计算
					strRet = jsonService.shoppingCartProductFreight(jpost);
					break;
				case IncomeStatistics://统计总御可贡茶数量 totalLoveCount 合伙人下的所有用户userCout
					strRet = jsonService.incomeStatistics(jpost);
					break;
				case IncomeStatisticsList://收益统计 代理下的商家用户
					strRet = jsonService.incomeStatisticsList(jpost);
					break;
				case ContributeDetails://统计某个用户的总御可贡茶数量
					strRet = jsonService.contributeDetails(jpost);
					break;
				case ContributeDetailsList://统计某个用户的贡献明细
					strRet = jsonService.contributeDetailsList(jpost);
					break;
				case AgentUserCout://统计代理下面的总用户数量
					strRet = jsonService.agentUserCout(jpost);
					break;
				case AgentUserList://统计代理下面的用户列表
					strRet = jsonService.agentUserList(jpost);
					break;
				case AgentShanbao://我的积分
					strRet = jsonService.agentShanbao(jpost);
					break;
				case UsableLoveDetail://我的积分明细
					strRet = jsonService.usableLoveDetail(jpost);
					break;
				case AgentBalance://余额、金额明细页
					strRet = jsonService.agentBalance(jpost);
					break;
				case AgentAmtDetail://代理累计激励
					strRet = jsonService.agentAmtDetail(jpost);
					break;
				case AgentChangeLoveList://代理激励明细列表
					strRet = jsonService.agentChangeLoveList(jpost);
					break;
				case WithdrawalBank://代理提现返回默认银行卡，返回可提现金额
					strRet = jsonService.withdrawalBank(jpost);
					break;
				case WithdrawalRecordList://代理提现记录
					strRet = jsonService.withdrawalRecordList(jpost);
					break;
				case AgentBankList://代理银行卡列表
					strRet = jsonService.agentBankList(jpost);
					break;
				case AddAgentBankCard://添加代理银行卡
					strRet = jsonService.addAgentBankCard(jpost);
					break;
				case SetAgentDefaultBank://设置代理默认银行卡
					strRet = jsonService.setAgentDefaultBank(jpost);
					break;
				case DelAgentBank://删除代理指定银行卡
					strRet = jsonService.delAgentBank(jpost);
					break;
				case AgentInformationList://代理消息列表
					strRet = jsonService.agentInformationList(jpost);
					break;
				case AgentLoveList://代理御可贡茶明细列表
					strRet = jsonService.agentLoveList(jpost);
					break;
				case GetAgentAmtLogList://获取代理余额明细列表
					strRet = jsonService.getAgentAmtLogList(jpost);
					break;
				case Withdrawal://代理提现处理
					strRet = jsonService.withdrawal(jpost);
					break;
				case GetPmAgentInfo://获取代理信息
					strRet = jsonService.PmAgentInfo(jpost);
					break;
				case AddEbProductcommentTest://添加假评论
					strRet = jsonService.addEbProductcommentTest(jpost,request);
					break;
				case EbCertificateUserList://获取用户优惠券列表
					strRet = jsonService.ebCertificateUserList(jpost);
					break;
				case EbCertificateUserCount://获取用户优惠券数量
					strRet = jsonService.EbCertificateUserCount(jpost);
					break;
				case EbCertificateUserEnabledCount://获取用户下单时可用的优惠券数量
					strRet = jsonService.ebCertificateUserEnabledCount(jpost);
					break;
				case IsAPhysicalStoreEnabled://购物车结算时判断门店配送商品可不可下单
					strRet = jsonService.isAPhysicalStoreEnabled(jpost);
					break;
				case EbUserRemarkEdit://修改人脉备注名称
					strRet = jsonService.EbUserRemarkEdit(jpost);
					break;
				case IsShippingMethodEnabled://选择送货方式时可不可以选择送货上门下单
//					strRet = jsonService.isShippingMethodEnabled(jpost);
					break;
					
				case GetProductThreeClassList://获取一二三级分类pc
					strRet=jsonService.getProductThreeClassList(jpost);
					break;
				case GetPortPmLayoutType:
					strRet=jsonService.getPortPmLayoutType(jpost);
					break;
				case OrderListPC:
					strRet=jsonService.OrderListPC(jpost);
					break;
				case BatchdeleteCollect:
					strRet=jsonService.BatchdeleteCollect(jpost);
					break;
				case ProductList:// 购物车选择后结算获取商品详情list
					strRet=jsonService.ProductList(jpost);
					break;
				case PmProductCountList://获取商品list(含总条数)
                    strRet = jsonService.pmProductCountList(jpost);
                    break;
			 	case WxscanQuery: //微信支付查询订单
			 		strRet=jsonService.wxscanQuery(jpost);
					break; 
				case HoteEbArticle://获取热门文章
					 strRet = jsonService.getHoteEbArticle(jpost);
					break;
				case GetProEbCertificateList: //获取商品详情优惠券
					 strRet = jsonService.getProEbCertificateList(jpost);
					 break;
				case GetProEbCertificate: //领取优惠券
					strRet = jsonService.getProEbCertificate(jpost);
					break;
				case FindtracingSourceCode: //查询溯源码证书
//					strRet=jsonService.findtracingSourceCode(jpost);
					break;
				case UpdateImg: //图片上传接口
					strRet=jsonService.UpdateImg(jpost,request);
					break;
				case FindArticleTypeSyzdydhlList://首页自定义导航栏文章访问超链接
					strRet = jsonService.findArticleTypeSyzdydhlList(jpost);
					break;
				case OpenOld://御可贡茶导旧用户
					strRet = jsonService.OpenOld(jpost);
					break;
				case LogIp://logIp记录ip
					strRet = jsonService.LogIp(jpost,request);
					break;
				case PrisonEbProductList://监采系统商品
					strRet = jsonService.prisonEbProductList(jpost);
					break;
				default:
					strRet = jsonService.CodeError("Code有错:" + code);
					break;
					
				}	
 
			}catch (SecurityException ex) {// 效验不通过
				strRet = jsonService.HeadError(ex.getMessage());
			}catch (ServiceException ex) {// 判断用户错误信息
				strRet = jsonService.userError(ex.getMessage());
			}catch (UserLoginException ex) {// 判断用户是否登录
				strRet = jsonService.loginError(ex.getMessage());
			}catch (UserStatusException ex) {// 用户禁用
				strRet = jsonService.userStatusError(ex.getMessage());
			}catch (PcUserLoginException ex) {// 判断PC用户是否登录
				strRet = jsonService.pcLoginError(ex.getMessage());
			}catch (Exception ex) {// 其它错误
				strRet = jsonService.CodeError(ex.getMessage());
			}
			logger.info("codereturn:"+strRet);
			
	    }catch (Exception ex) {
			ex.printStackTrace();
			try {
				strRet = jsonService.HeadError(ex.getMessage());
			} catch (JsonProcessingException e) {
				e.printStackTrace();
			}
	    }
		
		return strRet;
	}
}