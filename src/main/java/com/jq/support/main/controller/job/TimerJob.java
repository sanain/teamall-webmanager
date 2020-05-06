package com.jq.support.main.controller.job;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.jq.support.model.product.EbShopProduct;
import com.jq.support.service.merchandise.product.EbShopProductService;
import com.jq.support.service.merchandise.shop.PmShopInfoService;
import com.jq.support.service.pay.SbscPayService;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.time.DateUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;

import com.jq.support.common.config.Global;
import com.jq.support.common.utils.StringUtils;
import com.jq.support.model.agent.PmAgentInfo;
import com.jq.support.model.message.EbMessage;
import com.jq.support.model.message.EbMessageUser;
import com.jq.support.model.order.EbAftersale;
import com.jq.support.model.order.EbOrder;
import com.jq.support.model.order.EbOrderitem;
import com.jq.support.model.order.EbSalesrecord;
import com.jq.support.model.order.PmFrozenLoveLog;
import com.jq.support.model.order.PmLoveLifecycleLog;
import com.jq.support.model.order.PmOrderLoveLog;
import com.jq.support.model.pay.PmOpenPayWay;
import com.jq.support.model.pay.PmSysPayAmountStatistics;
import com.jq.support.model.product.EbProduct;
import com.jq.support.model.product.PmProductStandardDetail;
import com.jq.support.model.user.EbUserMoney;
import com.jq.support.model.user.EbUser;
import com.jq.support.model.user.PmSensitiveWordsFilter;
import com.jq.support.model.user.PmAmtStatistics;
import com.jq.support.model.user.PmSysLoveAllot;
import com.jq.support.model.user.PmUserIdentityLog;
import com.jq.support.model.user.PmUserOfflineRechargeLog;
import com.jq.support.service.agent.PmAgentInfoService;
import com.jq.support.service.merchandise.mecontent.PmSensitiveWordsFilterService;
import com.jq.support.service.merchandise.order.EbAftersaleService;
import com.jq.support.service.merchandise.order.EbOrderLogService;
import com.jq.support.service.merchandise.order.EbOrderService;
import com.jq.support.service.merchandise.order.EbOrderitemService;
import com.jq.support.service.merchandise.order.EbSalesrecordService;
import com.jq.support.service.merchandise.order.PmFrozenLoveLogService;
import com.jq.support.service.merchandise.order.PmLoveLifecycleLogService;
import com.jq.support.service.merchandise.order.PmOrderLoveLogService;
import com.jq.support.service.merchandise.product.EbProductService;
import com.jq.support.service.merchandise.product.PmProductStandardDetailService;
import com.jq.support.service.merchandise.user.EbUserMoneyService;
import com.jq.support.service.merchandise.user.EbUserService;
import com.jq.support.service.merchandise.user.PmAmtLogService;
import com.jq.support.service.merchandise.user.PmAmtStatisticsService;
import com.jq.support.service.merchandise.user.PmSysLoveAllotService;
import com.jq.support.service.merchandise.user.PmUserIdentityLogService;
import com.jq.support.service.merchandise.user.PmUserOfflineRechargeLogService;
import com.jq.support.service.message.EbMessageService;
import com.jq.support.service.message.EbMessageUserService;
import com.jq.support.service.pay.PmOpenPayWayService;
import com.jq.support.service.pay.PmSysPayAmountStatisticsService;
import com.jq.support.service.sys.SysOfficeService;
import com.jq.support.service.utils.AllUtils;
import com.jq.support.service.utils.CommonUtils;
import com.jq.support.service.utils.CountMoney;
import com.jq.support.service.utils.DateTest;
import com.jq.support.service.utils.DateUtil;
import com.jq.support.service.utils.StringUtil;
import com.jq.support.service.utils.SysUserUtils;
import com.jq.support.service.utils.rongcloud.RongCloudUtils;

@Controller
public class TimerJob {
	@Autowired
	private EbOrderService ebOrderService;
	@Autowired
	private PmUserIdentityLogService pmUserIdentityLogService;
	@Autowired
	private EbUserService userService;
	@Autowired
	private EbUserMoneyService ebExpandService;
	@Autowired
	private EbSalesrecordService ebSalesrecordService;
	@Autowired
	private EbAftersaleService ebAftersaleService;
	@Autowired
	private PmSensitiveWordsFilterService pmSensitiveWordsFilterService;
	@Autowired
	private EbMessageUserService ebMessageUserService;
	@Autowired
	private EbUserService ebUserService;
	@Autowired
	private PmAmtLogService pmAmtLogService;
	@Autowired
	private EbOrderitemService ebOrderitemService;
	@Autowired
	private PmUserOfflineRechargeLogService pmUserOfflineRechargeLogService;
	@Autowired
	private EbProductService ebProductService;
	@Autowired
	private EbMessageService ebMessageService;
	@Autowired
	private EbMessageUserService messageInfoUserService;
	@Autowired
	private SysOfficeService officeService;
	@Autowired
	private PmProductStandardDetailService pmProductStandardDetailService;
	@Autowired
	private  EbShopProductService ebShopProductService;
	@Autowired
	private PmOrderLoveLogService pmOrderLoveLogService;
	@Autowired
	private PmFrozenLoveLogService pmFrozenLoveLogService;
	@Autowired
	private PmLoveLifecycleLogService pmLoveLifecycleLogService;
	@Autowired
	private PmSysPayAmountStatisticsService pmSysPayAmountStatisticsService;
	@Autowired
	private PmOpenPayWayService pmOpenPayWayService;
	@Autowired
	private EbOrderLogService ebOrderLogService;
	@Autowired
	private PmAgentInfoService pmAgentInfoService;
	@Autowired
	private PmAmtStatisticsService pmAmtStatisticsService;
	@Autowired
	private PmSysLoveAllotService pmSysLoveAllotService;
	@Autowired
	private PmShopInfoService pmShopInfoService;
	@Autowired
	private SbscPayService sbscPayService;
	private static Log logger = LogFactory.getLog("appgetjson");
	
	/**
	 * 订单
	 */
	@Transactional(readOnly = false)
	public void orderStatus() {
		// 待付款订单，倒计时36小时，36小时后未付款订单自动取消；
		String date = DateUtil.getDateFormat(
				AllUtils.addDate(new Date(), 5, -1), "yyyy-MM-dd HH:mm:ss");
		String Hql = " and status=1 and payStatus=0 and createTime<'" + date
				+ "'";
		List<EbOrder> ebOrders = ebOrderService.getEbOrderHqlList(Hql);
		if (ebOrders != null && ebOrders.size() > 0) {
			for (EbOrder ebOrder2 : ebOrders) {
				if (ebOrder2.getType() != null) {
					ebOrder2.setStatus(5);
					ebOrder2.setCancelReason("系统自动取消");
					Date nowDate = new Date();
					ebOrder2.setCloseOrderTime(new Date());
					if (ebOrder2 != null && ebOrder2.getUserId() != null) {
						EbUser ebUser = userService.getEbUserById(ebOrder2
								.getUserId());
						// 拓展
						EbUserMoney ebExpand = ebExpandService
								.getEbExpandByUserId(ebOrder2.getUserId());

						if (ebOrder2.getType() == 1) {
							if (ebOrder2.getOnoffLineStatus() != null
									&& ebOrder2.getOnoffLineStatus() == 1) {
								EbOrderitem ebOrderitem = new EbOrderitem();
								ebOrderitem.setOrderId(ebOrder2.getOrderId());
								List<EbOrderitem> ebOrderitems = ebOrderitemService
										.getEbOrderitemList(ebOrderitem);
								for (EbOrderitem ebOrderitem2 : ebOrderitems) {
									if (StringUtils.isNotBlank(ebOrderitem2
											.getPropertyId())) {// 减去商品明细库存的数量
										PmProductStandardDetail detail = pmProductStandardDetailService
												.getPmProductStandardDetail(ebOrderitem2
														.getPropertyId());
										if (detail != null) {
											int count = detail
													.getDetailInventory() == null ? 0
													: detail.getDetailInventory();// 商品库存
											int goodsNums = ebOrderitem2
													.getGoodsNums() == null ? 0
													: ebOrderitem2
															.getGoodsNums();// 商品数量
											int storeNum = count + goodsNums;
											if (storeNum < 0) {
												storeNum = 0;
											}

											detail.setDetailInventory(storeNum);
											pmProductStandardDetailService
													.save(detail);

											//更新关联表库存
											EbShopProduct ebShopProduct = ebShopProductService.getByProductIdAndShopId(detail.getProductId(), detail.getShopId());
											if(ebShopProduct != null && ebShopProduct.getId()!=null){
												int allCount = ebShopProduct.getStoreNums() == null
														? 0: ebShopProduct.getStoreNums();// 商品库存
												allCount += goodsNums;
												allCount = (allCount < 0 ? 0 : allCount);
												ebShopProduct.setStoreNums(allCount);
												ebShopProductService.save(ebShopProduct);
											}
										}
									} else {
//										EbProduct ebProduct = ebProductService
//												.getEbProduct(ebOrderitem2
//														.getProductId()
//														.toString());
										//更新关联表库存
										EbShopProduct ebShopProduct = ebShopProductService.getByProductIdAndShopId(ebOrderitem2
												.getProductId(), ebOrderitem2.getShopId());
										if(ebShopProduct != null && ebShopProduct.getId()!=null){
											int allCount = ebShopProduct.getStoreNums() == null
													? 0: ebShopProduct.getStoreNums();// 商品库存
											int goodsNums = ebOrderitem2
													.getGoodsNums() == null ? 0 : ebOrderitem2.getGoodsNums();// 商品数量
											allCount += goodsNums;
											allCount = (allCount < 0 ? 0 : allCount);
											ebShopProduct.setStoreNums(allCount);
											ebShopProductService.save(ebShopProduct);
										}
//										ebProduct.setStoreNums(ebProduct
//												.getStoreNums()
//												+ ebOrderitem2.getGoodsNums());
//										ebProductService.saveProduct(ebProduct);
									}
								}
							}
						} else if (ebOrder2.getType() == 4) {

							// ebExpand.setCurrentLove(ebOrder2.getLovePayCount()+ebExpand.getCurrentLove());
							// ebExpand.setFrozenLove(ebOrder2.getFrozenLovePayCount()+ebExpand.getFrozenLove());
							ebExpandService.saveFlush(ebExpand, 0.0, 0.0,
									ebExpand.getFrozenLove(),
									ebExpand.getCurrentLove(), 0.0, 0.0,
									"兑换订单冻结积分和当前积分数变化");
							userService.save(ebUser);
							if (ebOrder2.getLovePayCount() > 0) {
								PmOrderLoveLog pmOrderLoveLog = new PmOrderLoveLog();
								pmOrderLoveLog.setLoveStatus(1);
								pmOrderLoveLog.setCreateTime(new Date());
								pmOrderLoveLog.setCurrencyType(1);
								pmOrderLoveLog.setIsExchange(1);
								pmOrderLoveLog.setLoveType(12);
								pmOrderLoveLog.setAllotProportion(ebOrder2
										.getLovePayChange() + "");
								pmOrderLoveLog.setLove(ebOrder2
										.getLovePayCount());
								pmOrderLoveLog.setObjId(ebUser.getUserId()
										.toString());
								pmOrderLoveLog.setObjName(ebUser.getMobile());
								pmOrderLoveLog.setObjType(1);
								pmOrderLoveLog
										.setOrderId(ebOrder2.getOrderId());
								pmOrderLoveLog.setRemark("退还积分兑换支付");
								pmOrderLoveLogService.save(pmOrderLoveLog);
								// 返回生命周期
								PmLoveLifecycleLog loveLifecycleLog = new PmLoveLifecycleLog();
								List<PmLoveLifecycleLog> pmLoveLifecycleLogs = pmLoveLifecycleLogService
										.getList(ebUser.getUserId().toString());
								if (pmLoveLifecycleLogs != null
										&& pmLoveLifecycleLogs.size() > 0) {
									loveLifecycleLog = pmLoveLifecycleLogs
											.get(0);
									loveLifecycleLog.setLove((loveLifecycleLog
											.getLove() == null ? 0.0
											: loveLifecycleLog.getLove())
											+ ebOrder2.getLovePayCount());
									pmLoveLifecycleLogService
											.save(loveLifecycleLog);
								} else {
									loveLifecycleLog.setCreateTime(new Date());
									loveLifecycleLog.setLoveStatus(1);
									loveLifecycleLog.setLoveType(12);
									loveLifecycleLog.setObjId(ebUser
											.getUserId().toString());
									loveLifecycleLog.setLove(ebOrder2
											.getLovePayCount());
									loveLifecycleLog.setObjName(ebUser
											.getMobile());
									loveLifecycleLog.setObjType(1);
									pmLoveLifecycleLogService
											.save(loveLifecycleLog);
								}
							}
							if (ebOrder2.getFrozenLovePayCount() > 0) {
								PmFrozenLoveLog frozenLoveLog1 = new PmFrozenLoveLog();
								frozenLoveLog1.setCreateTime(new Date());
								frozenLoveLog1.setLove(ebOrder2
										.getFrozenLovePayCount());
								frozenLoveLog1.setLoveStatus(1);
								frozenLoveLog1
										.setOrderId(ebOrder2.getOrderId());
								frozenLoveLog1.setLoveType(4);
								frozenLoveLog1.setObjId(ebUser.getUserId()
										.toString());
								frozenLoveLog1.setObjName(ebUser.getMobile());
								frozenLoveLog1.setObjType(1);
								frozenLoveLog1.setRemark("退还冻结积分兑换支付");
								pmFrozenLoveLogService.save(frozenLoveLog1);
							}
						}
					}

					ebOrderService.save(ebOrder2);
					ebOrderLogService.save(
							nowDate,
							ebOrder2.getOrderId(),
							ebOrder2.getOrderNo(),
							"买家：" + ebOrder2.getUserName() + "，收货人："
									+ ebOrder2.getGkuserName()
									+ "，系统自动取消订单,订单关闭", null, "系统自动取消订单,订单关闭",
							"", ebOrder2.getType(),
							ebOrder2.getOnoffLineStatus());
				}
			}
		}
		// 已发货订单，倒计时10天（240小时），10天后买家未确认收货，系统自动确认
		String date1 = DateUtil.getDateFormat(
				AllUtils.addDate(new Date(), 5, -10), "yyyy-MM-dd HH:mm:ss");
		String Hql1 = " and status=3 and payStatus=1 and sendTime<'" + date1
				+ "'";
		List<EbOrder> ebOrderls = ebOrderService.getEbOrderHqlList(Hql1);
		if (ebOrderls != null && ebOrderls.size() > 0) {
			for (EbOrder ebOrder2 : ebOrderls) {
				try {
					ebOrderService.EditOrderDetails(ebOrder2.getOrderId()
							.toString(), "4", "", "10天后买家未确认收货，系统自动确认收货");
				} catch (Exception e) {
					e.printStackTrace();
				}

			}
		}
	}
	
	/**
	 * 订单
	 */
	@Transactional(readOnly = false)
	public void cancelOrderStatus() {
		//30分钟后未支付订单取消
		Calendar nowBefore = Calendar.getInstance();
		nowBefore.add(Calendar.MINUTE, -30);

		String date = DateUtil.getDateFormat(nowBefore.getTime(), "yyyy-MM-dd HH:mm:ss");
		String Hql = " and status=1 and payStatus=0 and createTime<'" + date
				+ "'";
		List<EbOrder> ebOrders = ebOrderService.getEbOrderHqlList(Hql);
		if (ebOrders != null && ebOrders.size() > 0) {
			for (EbOrder ebOrder2 : ebOrders) {
				 if(ebOrder2.getType()!=null){
					try {
						ebOrderService.EditOrderDetails(ebOrder2.getOrderId()+"","11","系统自动取消",null);
					} catch (Exception e) {
						e.printStackTrace();
					}
				 }
				}
		}
	}

	public void orderStatusTmi() {
		String date1 = DateUtil
				.getDateFormat(new Date(), "yyyy-MM-dd HH:mm:ss");
		String Hql1 = " and status=4 and payStatus=1  and completionTime>'"
				+ date1 + "'";
		List<EbOrder> ebOrderls = ebOrderService.getEbOrderHqlList(Hql1);
		if (ebOrderls != null && ebOrderls.size() > 0) {

		}
	}

	/**
	 * 判断 精英合伙人 是否过期
	 * 
	 */
	public void upgradeRole() {
		List<PmUserIdentityLog> pmUserIdentityLogs = pmUserIdentityLogService
				.getPmUserIdentityLogs();
		for (PmUserIdentityLog pmUserIdentityLog : pmUserIdentityLogs) {
			if (new Date().before(pmUserIdentityLog.getEndTime()) == true) {
				EbMessageUser messageInfoUser = new EbMessageUser();
				messageInfoUser.setUserId(pmUserIdentityLog.getUserId());
				EbMessage eMessage = new EbMessage();
				eMessage.setCreateTime(new Date());
				eMessage.setCreateUser("平台管理员");
				eMessage.setMessageAbstract("您的精英合伙人角色已过期");
				eMessage.setMessageClass(2);// 1、交易物流消息；2、系统消息；3、商家助手；4、御可贡茶公告；
				eMessage.setMessageContent("您的精英合伙人角色已于"
						+ DateUtil.getDateTime("yyyy-MM-dd HH:mm:ss",
								pmUserIdentityLog.getEndTime())
						+ "过期，如果您想要继续享受精英合伙人特权，请重新开通");
				eMessage.setMessageIcon("");
				eMessage.setMessageObjId(pmUserIdentityLog.getId());
				eMessage.setMessageType(3);// 1、物流消息；2、退款消息；3、角色消息；4、人脉消息；5、系统消息；6、发货提醒；7、
											// 结算提醒；8、退货/售后提醒；9、系统公告；
				ebMessageService.saveflush(eMessage);
				messageInfoUser.setMessageInfo(eMessage);
				messageInfoUser.setState(0);
				messageInfoUser.setUserType(1);
				messageInfoUser.setCreateUser(SysUserUtils.getUser().getId());
				messageInfoUserService.sqlsaveEbMessage(messageInfoUser);
				// 推送
				messageInfoUserService.sendMsgJgEbMessageUser(
						pmUserIdentityLog.getUserId(),
						eMessage);
				pmUserIdentityLog.setStatus(2);
				pmUserIdentityLogService.save(pmUserIdentityLog);
				EbUser ebUser = userService.getEbUser(pmUserIdentityLog
						.getUserId().toString());
				ebUser.setIsAmbassador(0);
				userService.save(ebUser);
			}
			if (DateUtil.addDate(new Date(), 5, 7).before(
					pmUserIdentityLog.getEndTime()) == true) {
				EbMessageUser messageInfoUser = new EbMessageUser();
				messageInfoUser.setUserId(pmUserIdentityLog.getUserId());
				EbMessage eMessage = new EbMessage();
				eMessage.setCreateTime(new Date());
				eMessage.setCreateUser("平台管理员");
				eMessage.setMessageAbstract("您的精英合伙人角色即将到期");
				eMessage.setMessageClass(2);// 1、交易物流消息；2、系统消息；3、商家助手；4、御可贡茶公告；
				eMessage.setMessageContent("您的精英合伙人角色已于"
						+ DateUtil.getDateTime("yyyy-MM-dd HH:mm:ss",
								pmUserIdentityLog.getEndTime())
						+ "到期，过期后将不能享受到精英合伙人特权哦，请及时续费！");
				eMessage.setMessageIcon("/uploads/drawable-xhdpi/xtxx.png");
				eMessage.setMessageObjId(pmUserIdentityLog.getId());
				eMessage.setMessageType(3);// 1、物流消息；2、退款消息；3、角色消息；4、人脉消息；5、系统消息；6、发货提醒；7、
											// 结算提醒；8、退货/售后提醒；9、系统公告；
				ebMessageService.saveflush(eMessage);
				messageInfoUser.setMessageInfo(eMessage);
				messageInfoUser.setState(0);
				messageInfoUser.setUserType(1);
				messageInfoUser.setCreateUser(SysUserUtils.getUser().getId());
				messageInfoUserService.sqlsaveEbMessage(messageInfoUser);
				// 推送
				messageInfoUserService.sendMsgJgEbMessageUser(
						pmUserIdentityLog.getUserId(),
						eMessage);
			}
		}
	}

	/**
	 * applicationType 申请类型（0，退货退款,1，退款 2，换货) takeStatus 收货状态：0.未发货
	 * 1、未收到货；2、已收到货； refundStatus 退款状态： 1、待卖家处理；2、卖家已拒绝；3、退款成功；4、关闭退款；5、等待买家退货；
	 * 6、等待卖家确认收货；7、等待买家确认收款；8、等待卖家退款；9、平台已介入处理；
	 */
	public void upDateebAftersale() {
		/** 仅退款申请确认收货前（卖家未发货），卖家2天内未处理系统自动同意退款； */
		String date = DateUtil.getDateFormat(
				AllUtils.addDate(new Date(), 5, -2), "yyyy-MM-dd HH:mm:ss");
		String hqlString = " and applicationType=1 and takeStatus=0 and refundStatus=1 and applicationTime<='"
				+ date + "'";
		List<EbAftersale> ebAftersales = ebAftersaleService
				.getEbAftersaleList(hqlString);
		if (ebAftersales != null && ebAftersales.size() > 0) {
			for (EbAftersale ebAftersale : ebAftersales) {
				ebAftersale.setRefundStatus(3);
				// ebAftersale.setRefundWay(1);
				Date nowTime = new Date();
				ebAftersale.setUpdateTime(nowTime);
				ebAftersaleService.save(ebAftersale);

				EbSalesrecord ebSalesrecord = new EbSalesrecord();
				ebSalesrecord.setRecordDate(nowTime);
				ebSalesrecord.setRecordObjType(3);// 协商对象类型：1、买家；2、卖家；3平台
				ebSalesrecord.setSaleId(ebAftersale.getSaleId());
				ebSalesrecord.setRecordName("平台自动处理了订单。");
				ebSalesrecord.setRecordContent("商家订单处理超时,平台已自动退款。");
				ebSalesrecordService.save(ebSalesrecord);

				// 保存退款退货信息
				EbOrderitem ebOrderitem = ebAftersale.getOrderitem();// 订单明细
				ebAftersaleService.saveAftersaleInfo(null, ebAftersale,
						ebOrderitem, nowTime,false);

				// EbUser
				// userMsg=userService.getEbUser(ebAftersale.getUserId().toString());
				// ebMessageService.chuandis(userMsg, "退款进度有更新！",
				// "退款提醒：您的"+ebAftersale.getDeposit()+"元退款进度有更新，快来看看吧！",
				// "/uploads/drawable-xhdpi/tzxx.png", 1, 2);
				// EbUser
				// shopMsg=userService.getShop(ebAftersale.getShopId().toString());
				// ebMessageService.chuandis(shopMsg, "退款进度有更新！",
				// "退款进度有更新，请及时处理！", "/uploads/drawable-xhdpi/sjzs.png", 3, 8);
			}
		}
		/** 仅退款申请确认收货前（卖家已发货，买家未确认收货），卖家5天内未处理系统自动同意退款； */
		String date1 = DateUtil.getDateFormat(
				AllUtils.addDate(new Date(), 5, -5), "yyyy-MM-dd HH:mm:ss");
		String hqlString1 = " and applicationType=1 and takeStatus=1 and refundStatus=1 and applicationTime<='"
				+ date1 + "'";
		List<EbAftersale> ebAftersales1 = ebAftersaleService
				.getEbAftersaleList(hqlString1);
		if (ebAftersales1 != null && ebAftersales1.size() > 0) {
			for (EbAftersale ebAftersale : ebAftersales1) {
				ebAftersale.setRefundStatus(3);
				// ebAftersale.setRefundWay(1);
				Date nowTime = new Date();
				ebAftersale.setUpdateTime(nowTime);
				ebAftersaleService.save(ebAftersale);

				EbSalesrecord ebSalesrecord = new EbSalesrecord();
				ebSalesrecord.setRecordDate(nowTime);
				ebSalesrecord.setRecordObjType(3);// 协商对象类型：1、买家；2、卖家；3平台
				ebSalesrecord.setSaleId(ebAftersale.getSaleId());
				ebSalesrecord.setRecordName("平台自动处理了订单。");
				ebSalesrecord.setRecordContent("卖家确认收货超时,平台已默认收货。");
				ebSalesrecordService.save(ebSalesrecord);

				// 保存退款退货信息
				EbOrderitem ebOrderitem = ebAftersale.getOrderitem();// 订单明细
				ebAftersaleService.saveAftersaleInfo(null, ebAftersale,
						ebOrderitem, nowTime,false);

				EbUser userMsg = userService.getEbUser(ebAftersale.getUserId()
						.toString());
				ebMessageService.chuandis(ebAftersale.getSaleId(), userMsg,
						"退款提醒", "退款进度有更新！",
						"退款提醒：您的" + ebAftersale.getDeposit()
								+ "元退款进度有更新，快来看看吧！",
						"/uploads/drawable-xhdpi/tzxx.png", 1, 2);
				EbUser shopMsg = userService.getShop(ebAftersale.getShopId()
						.toString());
				ebMessageService.chuandis(ebAftersale.getSaleId(), shopMsg,
						"退款提醒", "退款进度有更新！", "退款进度有更新，请及时处理！",
						"/uploads/drawable-xhdpi/sjzs.png", 3, 8);
			}
		}
		/** 退款退货申请确认收货前，卖家5天内未处理系统自动同意申请，用户退货后商家收到货平台退款；（发商家的退货地址消息给用户） */
		String date2 = DateUtil.getDateFormat(
				AllUtils.addDate(new Date(), 5, -5), "yyyy-MM-dd HH:mm:ss");
		String hqlString2 = " and applicationType=0 and takeStatus=1 and refundStatus=1 and applicationTime<='"
				+ date2 + "'";
		List<EbAftersale> ebAftersales2 = ebAftersaleService
				.getEbAftersaleList(hqlString2);
		if (ebAftersales2 != null && ebAftersales2.size() > 0) {
			for (EbAftersale ebAftersale : ebAftersales2) {
				ebAftersale.setRefundStatus(5);
				Date nowTime = new Date();
				ebAftersale.setUpdateTime(nowTime);
				EbSalesrecord ebSalesrecord = new EbSalesrecord();
				ebSalesrecord.setRecordDate(nowTime);
				ebSalesrecord.setRecordObjType(3);// 协商对象类型：1、买家；2、卖家；3平台
				ebSalesrecord.setSaleId(ebAftersale.getSaleId());
				ebSalesrecord.setRecordName("平台自动处理了订单。");
				ebSalesrecord.setRecordContent("卖家处理申请超时,平台已自动同意。");
				ebSalesrecordService.save(ebSalesrecord);
				ebAftersaleService.save(ebAftersale);
				EbUser userMsg = userService.getEbUser(ebAftersale.getUserId()
						.toString());
				ebMessageService.chuandis(ebAftersale.getSaleId(), userMsg,
						"退款提醒", "退款进度有更新！", "退款进度有更新，请及时处理！",
						"/uploads/drawable-xhdpi/tzxx.png", 1, 2);
				EbUser shopMsg = userService.getShop(ebAftersale.getShopId()
						.toString());
				ebMessageService.chuandis(ebAftersale.getSaleId(), shopMsg,
						"退款提醒", "退款进度有更新！", "退款进度有更新，请及时处理！",
						"/uploads/drawable-xhdpi/sjzs.png", 3, 8);
			}
		}
		/** 退款退货申请确认收货前，卖家已同意，用户7天内未提交退货信息，系统自动关闭退款申请； */
		String date3 = DateUtil.getDateFormat(
				AllUtils.addDate(new Date(), 5, -7), "yyyy-MM-dd HH:mm:ss");
		String hqlString3 = " and applicationType=0 and takeStatus=1 and refundStatus=5 and updateTime<='"
				+ date3 + "'";
		List<EbAftersale> ebAftersales3 = ebAftersaleService
				.getEbAftersaleList(hqlString3);
		if (ebAftersales3 != null && ebAftersales3.size() > 0) {
			for (EbAftersale ebAftersale : ebAftersales3) {
				ebAftersale.setRefundStatus(4);
				Date nowTime = new Date();
				ebAftersale.setUpdateTime(nowTime);
				EbSalesrecord ebSalesrecord = new EbSalesrecord();
				ebSalesrecord.setRecordDate(nowTime);
				ebSalesrecord.setRecordObjType(3);// 协商对象类型：1、买家；2、卖家；3平台
				ebSalesrecord.setSaleId(ebAftersale.getSaleId());
				ebSalesrecord.setRecordName("平台自动处理了订单。");
				ebSalesrecord.setRecordContent("买家提交退货信息超时,退款申请已关闭。");
				ebSalesrecordService.save(ebSalesrecord);
				ebAftersaleService.save(ebAftersale);

				// 更新订单明细状态
				EbOrderitem ebOrderitem = ebOrderitemService.findid(ebAftersale
						.getOrderitemId());
				if (ebOrderitem != null) {
					ebOrderitem.setIsSend(1);
					ebOrderitemService.save(ebOrderitem);
				}

				EbUser userMsg = userService.getEbUser(ebAftersale.getUserId()
						.toString());
				ebMessageService.chuandis(ebAftersale.getSaleId(), userMsg,
						"退款提醒", "退款进度有更新！", "退款进度有更新，请及时处理！",
						"/uploads/drawable-xhdpi/tzxx.png", 1, 2);
				EbUser shopMsg = userService.getShop(ebAftersale.getShopId()
						.toString());
				ebMessageService.chuandis(ebAftersale.getSaleId(), shopMsg,
						"退款提醒", "退款进度有更新！", "退款进度有更新，请及时处理！",
						"/uploads/drawable-xhdpi/sjzs.png", 3, 8);
			}
		}
		/** 退款退货申请确认收货前，用户已退货，卖家10天内未确认收货，系统自动确认收货并且退款； */
		String date4 = DateUtil.getDateFormat(
				AllUtils.addDate(new Date(), 5, -10), "yyyy-MM-dd HH:mm:ss");
		String hqlString4 = " and applicationType=0 and takeStatus=1 and refundStatus=6 and updateTime<='"
				+ date4 + "'";
		List<EbAftersale> ebAftersales4 = ebAftersaleService
				.getEbAftersaleList(hqlString4);
		if (ebAftersales4 != null && ebAftersales4.size() > 0) {
			for (EbAftersale ebAftersale : ebAftersales4) {
				Date nowTime = new Date();
				ebAftersale.setUpdateTime(nowTime);
				EbSalesrecord ebSalesrecord = new EbSalesrecord();
				ebSalesrecord.setRecordDate(nowTime);
				ebSalesrecord.setRecordObjType(3);// 协商对象类型：1、买家；2、卖家；3平台
				ebSalesrecord.setSaleId(ebAftersale.getSaleId());
				ebSalesrecord.setRecordName("平台自动处理了订单。");
				ebSalesrecord.setRecordContent("卖家确认收货超时,退款已默认收货。");
				ebSalesrecordService.save(ebSalesrecord);

				// 判断退款途径，根据不同退款途径更新订单和退款退货状态
				if (ebAftersale.getRefundWay() == 1) {// 退款途径：1、平台退款；2、商家退款；
					// 原来是7
					ebAftersale.setRefundStatus(3);// 1、待卖家处理；2、卖家已拒绝；3、退款成功；4、关闭退款；5、等待买家退货；6、等待卖家确认收货；7、等待买家确认收款；8、等待卖家退款；9、平台已介入处理；
					ebAftersaleService.save(ebAftersale);
					// 保存退款退货信息
					EbOrderitem ebOrderitem = ebAftersale.getOrderitem();// 订单明细
					ebAftersaleService.saveAftersaleInfo(null, ebAftersale,
							ebOrderitem, nowTime,false);
				} else {
					ebAftersale.setRefundStatus(8);
					ebAftersaleService.save(ebAftersale);
				}

				EbUser userMsg = userService.getEbUser(ebAftersale.getUserId()
						.toString());
				ebMessageService.chuandis(ebAftersale.getSaleId(), userMsg,
						"退款提醒", "退款进度有更新！",
						"退款提醒：您的" + ebAftersale.getDeposit()
								+ "元退款进度有更新，快来看看吧！",
						"/uploads/drawable-xhdpi/tzxx.png", 1, 2);
				EbUser shopMsg = userService.getShop(ebAftersale.getShopId()
						.toString());
				ebMessageService.chuandis(ebAftersale.getSaleId(), shopMsg,
						"退款提醒", "退款进度有更新！", "退款进度有更新，请及时处理！",
						"/uploads/drawable-xhdpi/sjzs.png", 3, 8);
			}
		}
		/** 仅退款申请确认收货后，卖家5天内未处理，系统自动修改状态为卖家拒绝申请； */
		String date5 = DateUtil.getDateFormat(
				AllUtils.addDate(new Date(), 5, -5), "yyyy-MM-dd HH:mm:ss");
		String hqlString5 = " and applicationType=1 and takeStatus=2 and refundStatus=1 and applicationTime<='"
				+ date5 + "'";
		List<EbAftersale> ebAftersales5 = ebAftersaleService
				.getEbAftersaleList(hqlString5);
		if (ebAftersales5 != null && ebAftersales5.size() > 0) {
			for (EbAftersale ebAftersale : ebAftersales5) {
				ebAftersale.setRefundStatus(2);
				Date nowTime = new Date();
				ebAftersale.setUpdateTime(nowTime);
				EbSalesrecord ebSalesrecord = new EbSalesrecord();
				ebSalesrecord.setRecordDate(nowTime);
				ebSalesrecord.setRecordObjType(3);// 协商对象类型：1、买家；2、卖家；3平台
				ebSalesrecord.setSaleId(ebAftersale.getSaleId());
				ebSalesrecord.setRecordName("平台自动处理了订单。");
				ebSalesrecord.setRecordContent("卖家处理申请超时,平台已默认拒绝。");
				ebSalesrecordService.save(ebSalesrecord);
				ebAftersaleService.save(ebAftersale);

				// 更新订单明细状态
				EbOrderitem ebOrderitem = ebOrderitemService.findid(ebAftersale
						.getOrderitemId());
				if (ebOrderitem != null) {
					ebOrderitem.setIsSend(2);
					ebOrderitemService.save(ebOrderitem);
				}

				EbUser userMsg = userService.getEbUser(ebAftersale.getUserId()
						.toString());
				ebMessageService.chuandis(ebAftersale.getSaleId(), userMsg,
						"退款提醒", "退款进度有更新！", "退款进度有更新，请及时处理！",
						"/uploads/drawable-xhdpi/tzxx.png", 1, 2);
				EbUser shopMsg = userService.getShop(ebAftersale.getShopId()
						.toString());
				ebMessageService.chuandis(ebAftersale.getSaleId(), shopMsg,
						"退款提醒", "退款进度有更新！", "退款进度有更新，请及时处理！",
						"/uploads/drawable-xhdpi/sjzs.png", 3, 8);
			}
		}
		/** 仅退款申请确认收货后，卖家同意退款，用户3天内未确认收到退款，系统自动修改状态为用户确认收到退款； */
		String date6 = DateUtil.getDateFormat(
				AllUtils.addDate(new Date(), 5, -3), "yyyy-MM-dd HH:mm:ss");
		String hqlString6 = " and applicationType=1 and takeStatus=2 and refundStatus=7 and updateTime<='"
				+ date6 + "'";
		List<EbAftersale> ebAftersales6 = ebAftersaleService
				.getEbAftersaleList(hqlString6);
		if (ebAftersales6 != null && ebAftersales6.size() > 0) {
			for (EbAftersale ebAftersale : ebAftersales6) {
				ebAftersale.setRefundStatus(3);
				// ebAftersale.setRefundWay(1);
				Date nowTime = new Date();
				ebAftersale.setUpdateTime(nowTime);
				EbSalesrecord ebSalesrecord = new EbSalesrecord();
				ebSalesrecord.setRecordDate(nowTime);
				ebSalesrecord.setRecordObjType(3);// 协商对象类型：1、买家；2、卖家；3平台
				ebSalesrecord.setSaleId(ebAftersale.getSaleId());
				ebSalesrecord.setRecordName("平台自动处理了订单。");
				ebSalesrecord.setRecordContent("买家确认收款超时,平台已默认收款。");
				ebSalesrecordService.save(ebSalesrecord);
				ebAftersaleService.save(ebAftersale);

				// 更新订单明细状态
				EbOrderitem ebOrderitem = ebOrderitemService.findid(ebAftersale
						.getOrderitemId());
				if (ebOrderitem != null) {
					ebOrderitem.setIsSend(4);
					ebOrderitemService.save(ebOrderitem);
				}

				EbOrderitem ebOrderitemSel = new EbOrderitem();
				ebOrderitemSel.setOrderId(ebAftersale.getOrderId());
				List<EbOrderitem> ebOrderitems = ebOrderitemService
						.getEbOrderitemList(ebOrderitemSel);
				List<EbAftersale> ebAftersales_s = ebAftersaleService
						.getEbAftersaleList(" and orderId="
								+ ebAftersale.getOrderId()
								+ " and refundStatus=3");
				EbOrder ebOrder = ebAftersale.getOrder();
				if (ebAftersales_s.size() == ebOrderitems.size()
						&& ebOrder.getStatus() != 4) {// 如果是最后一个商品运费也退回
					ebOrder.setStatus(5);// 订单状态：1、等待买家付款；2、等待发货；3、已发货,待收货；4、交易成功，已完成；5、已关闭；
					ebOrderService.save(ebOrder);
				}

				EbUser userMsg = userService.getEbUser(ebAftersale.getUserId()
						.toString());
				ebMessageService.chuandis(ebAftersale.getSaleId(), userMsg,
						"退款提醒", "退款进度有更新！",
						"退款提醒：您的" + ebAftersale.getDeposit()
								+ "元退款进度有更新，快来看看吧！",
						"/uploads/drawable-xhdpi/tzxx.png", 1, 2);
				EbUser shopMsg = userService.getShop(ebAftersale.getShopId()
						.toString());
				ebMessageService.chuandis(ebAftersale.getSaleId(), shopMsg,
						"退款提醒", "退款进度有更新！", "退款进度有更新，请及时处理！",
						"/uploads/drawable-xhdpi/sjzs.png", 3, 8);
			}
		}
		/** 退款退货申请确认收货后，卖家5天内未处理，系统自动修改状态为卖家拒绝申请； */
		String date7 = DateUtil.getDateFormat(
				AllUtils.addDate(new Date(), 5, -5), "yyyy-MM-dd HH:mm:ss");
		String hqlString7 = " and applicationType=0 and takeStatus=2 and refundStatus=1 and applicationTime<='"
				+ date7 + "'";
		List<EbAftersale> ebAftersales7 = ebAftersaleService
				.getEbAftersaleList(hqlString7);
		if (ebAftersales7 != null && ebAftersales7.size() > 0) {
			for (EbAftersale ebAftersale : ebAftersales7) {
				ebAftersale.setRefundStatus(2);
				Date nowTime = new Date();
				ebAftersale.setUpdateTime(nowTime);
				EbSalesrecord ebSalesrecord = new EbSalesrecord();
				ebSalesrecord.setRecordDate(nowTime);
				ebSalesrecord.setRecordObjType(3);// 协商对象类型：1、买家；2、卖家；3平台
				ebSalesrecord.setSaleId(ebAftersale.getSaleId());
				ebSalesrecord.setRecordName("平台自动处理了订单。");
				ebSalesrecord.setRecordContent("卖家处理申请超时,平台已默认拒绝。");
				ebSalesrecordService.save(ebSalesrecord);
				ebAftersaleService.save(ebAftersale);

				// 更新订单明细状态
				EbOrderitem ebOrderitem = ebOrderitemService.findid(ebAftersale
						.getOrderitemId());
				if (ebOrderitem != null) {
					ebOrderitem.setIsSend(2);
					ebOrderitemService.save(ebOrderitem);
				}

				EbUser userMsg = userService.getEbUser(ebAftersale.getUserId()
						.toString());
				ebMessageService.chuandis(ebAftersale.getSaleId(), userMsg,
						"退款提醒", "退款进度有更新！", "退款进度有更新，请及时处理！",
						"/uploads/drawable-xhdpi/tzxx.png", 1, 2);
				EbUser shopMsg = userService.getShop(ebAftersale.getShopId()
						.toString());
				ebMessageService.chuandis(ebAftersale.getSaleId(), shopMsg,
						"退款提醒", "退款进度有更新！", "退款进度有更新，请及时处理！",
						"/uploads/drawable-xhdpi/sjzs.png", 3, 8);
			}
		}
		/** 退款退货申请确认收货后，卖家同意退款退货，用户7天内未提交退货信息，系统自动关闭退款申请； */
		String date8 = DateUtil.getDateFormat(
				AllUtils.addDate(new Date(), 5, -7), "yyyy-MM-dd HH:mm:ss");
		String hqlString8 = " and applicationType=0 and takeStatus=2 and refundStatus=5 and updateTime<='"
				+ date8 + "'";
		List<EbAftersale> ebAftersales8 = ebAftersaleService
				.getEbAftersaleList(hqlString8);
		if (ebAftersales8 != null && ebAftersales8.size() > 0) {
			for (EbAftersale ebAftersale : ebAftersales8) {
				ebAftersale.setRefundStatus(4);
				Date nowTime = new Date();
				ebAftersale.setUpdateTime(nowTime);
				EbSalesrecord ebSalesrecord = new EbSalesrecord();
				ebSalesrecord.setRecordDate(nowTime);
				ebSalesrecord.setRecordObjType(3);// 协商对象类型：1、买家；2、卖家；3平台
				ebSalesrecord.setSaleId(ebAftersale.getSaleId());
				ebSalesrecord.setRecordName("平台自动处理了订单。");
				ebSalesrecord.setRecordContent("买家提交退货信息超时,退款申请已关闭。");
				ebSalesrecordService.save(ebSalesrecord);
				ebAftersaleService.save(ebAftersale);

				// 更新订单明细状态
				EbOrderitem ebOrderitem = ebOrderitemService.findid(ebAftersale
						.getOrderitemId());
				if (ebOrderitem != null) {
					ebOrderitem.setIsSend(2);
					ebOrderitemService.save(ebOrderitem);
				}

				EbUser userMsg = userService.getEbUser(ebAftersale.getUserId()
						.toString());
				ebMessageService.chuandis(ebAftersale.getSaleId(), userMsg,
						"退款提醒", "退款进度有更新！", "退款进度有更新，请及时处理！",
						"/uploads/drawable-xhdpi/tzxx.png", 1, 2);
				EbUser shopMsg = userService.getShop(ebAftersale.getShopId()
						.toString());
				ebMessageService.chuandis(ebAftersale.getSaleId(), shopMsg,
						"退款提醒", "退款进度有更新！", "退款进度有更新，请及时处理！",
						"/uploads/drawable-xhdpi/sjzs.png", 3, 8);
			}
		}
		/** 退款退货申请确认收货后，用户已退货，卖家10天内未确认收货 */
		String date9 = DateUtil.getDateFormat(
				AllUtils.addDate(new Date(), 5, -10), "yyyy-MM-dd HH:mm:ss");
		String hqlString9 = " and applicationType=0 and takeStatus=2 and refundStatus=6 and updateTime<='"
				+ date9 + "'";
		List<EbAftersale> ebAftersales9 = ebAftersaleService
				.getEbAftersaleList(hqlString9);
		if (ebAftersales9 != null && ebAftersales9.size() > 0) {
			for (EbAftersale ebAftersale : ebAftersales9) {
				ebAftersale.setRefundStatus(7);
				Date nowTime = new Date();
				ebAftersale.setUpdateTime(nowTime);
				EbSalesrecord ebSalesrecord = new EbSalesrecord();
				ebSalesrecord.setRecordDate(nowTime);
				ebSalesrecord.setRecordObjType(3);// 协商对象类型：1、买家；2、卖家；3平台
				ebSalesrecord.setSaleId(ebAftersale.getSaleId());
				ebSalesrecord.setRecordName("平台自动处理了订单。");
				ebSalesrecord.setRecordContent("卖家确认收货超时,平台已默认收货。");
				ebSalesrecordService.save(ebSalesrecord);
				ebAftersaleService.save(ebAftersale);
				EbUser userMsg = userService.getEbUser(ebAftersale.getUserId()
						.toString());
				ebMessageService.chuandis(ebAftersale.getSaleId(), userMsg,
						"退款提醒", "退款进度有更新！", "退款进度有更新，请及时处理！",
						"/uploads/drawable-xhdpi/tzxx.png", 1, 2);
				EbUser shopMsg = userService.getShop(ebAftersale.getShopId()
						.toString());
				ebMessageService.chuandis(ebAftersale.getSaleId(), shopMsg,
						"退款提醒", "退款进度有更新！", "退款进度有更新，请及时处理！",
						"/uploads/drawable-xhdpi/sjzs.png", 3, 8);
			}
		}
		/** 退款退货申请确认收货后，卖家收到退货后同意退款，用户3天内未确认收到退款，系统自动修改状态为用户确认收到退款 */
		String date10 = DateUtil.getDateFormat(
				AllUtils.addDate(new Date(), 5, -3), "yyyy-MM-dd HH:mm:ss");
		String hqlString10 = " and applicationType=0 and takeStatus=2 and refundStatus=7 and updateTime<='"
				+ date10 + "'";
		List<EbAftersale> ebAftersales10 = ebAftersaleService
				.getEbAftersaleList(hqlString10);
		if (ebAftersales10 != null && ebAftersales10.size() > 0) {
			for (EbAftersale ebAftersale : ebAftersales10) {
				ebAftersale.setRefundStatus(3);
				// ebAftersale.setRefundWay(1);
				Date nowTime = new Date();
				ebAftersale.setUpdateTime(nowTime);
				EbSalesrecord ebSalesrecord = new EbSalesrecord();
				ebSalesrecord.setRecordDate(nowTime);
				ebSalesrecord.setRecordObjType(3);// 协商对象类型：1、买家；2、卖家；3平台
				ebSalesrecord.setSaleId(ebAftersale.getSaleId());
				ebSalesrecord.setRecordName("平台自动处理了订单。");
				ebSalesrecord.setRecordContent("买家确认收款超时,平台已默认收款。");
				ebSalesrecordService.save(ebSalesrecord);
				ebAftersaleService.save(ebAftersale);

				// 更新订单明细状态
				EbOrderitem ebOrderitem = ebOrderitemService.findid(ebAftersale
						.getOrderitemId());
				if (ebOrderitem != null) {
					ebOrderitem.setIsSend(4);
					ebOrderitemService.save(ebOrderitem);
				}
				EbOrderitem ebOrderitemSel = new EbOrderitem();
				ebOrderitemSel.setOrderId(ebAftersale.getOrderId());
				List<EbOrderitem> ebOrderitems = ebOrderitemService
						.getEbOrderitemList(ebOrderitemSel);
				List<EbAftersale> ebAftersales_s = ebAftersaleService
						.getEbAftersaleList(" and orderId="
								+ ebAftersale.getOrderId()
								+ " and refundStatus=3");
				EbOrder ebOrder = ebAftersale.getOrder();
				if (ebAftersales_s.size() == ebOrderitems.size()
						&& ebOrder.getStatus() != 4) {// 如果是最后一个商品运费也退回
					ebOrder.setStatus(5);// 订单状态：1、等待买家付款；2、等待发货；3、已发货,待收货；4、交易成功，已完成；5、已关闭；
					ebOrderService.save(ebOrder);
				}
				EbUser userMsg = userService.getEbUser(ebAftersale.getUserId()
						.toString());
				ebMessageService.chuandis(ebAftersale.getSaleId(), userMsg,
						"退款提醒", "退款进度有更新！",
						"退款提醒：您的" + ebAftersale.getDeposit()
								+ "元退款进度有更新，快来看看吧！",
						"/uploads/drawable-xhdpi/tzxx.png", 1, 2);
				EbUser shopMsg = userService.getShop(ebAftersale.getShopId()
						.toString());
				ebMessageService.chuandis(ebAftersale.getSaleId(), shopMsg,
						"退款提醒", "退款进度有更新！", "退款进度有更新，请及时处理！",
						"/uploads/drawable-xhdpi/sjzs.png", 3, 8);
			}
		}
		/** 退款申请，状态为卖家已拒绝3天内用户没有修改申请状态，系统自动修改状态为撤销申请 */
		String date11 = DateUtil.getDateFormat(
				AllUtils.addDate(new Date(), 5, -3), "yyyy-MM-dd HH:mm:ss");
		String hqlString11 = " and applicationType=0 and takeStatus=2 and refundStatus=2 and updateTime<='"
				+ date11 + "'";
		List<EbAftersale> ebAftersales11 = ebAftersaleService
				.getEbAftersaleList(hqlString11);
		if (ebAftersales11 != null && ebAftersales11.size() > 0) {
			for (EbAftersale ebAftersale : ebAftersales11) {
				ebAftersale.setRefundStatus(4);
				Date nowTime = new Date();
				ebAftersale.setUpdateTime(nowTime);
				EbSalesrecord ebSalesrecord = new EbSalesrecord();
				ebSalesrecord.setRecordDate(nowTime);
				ebSalesrecord.setRecordObjType(3);// 协商对象类型：1、买家；2、卖家；3平台
				ebSalesrecord.setSaleId(ebAftersale.getSaleId());
				ebSalesrecord.setRecordName("平台自动处理了订单。");
				ebSalesrecord.setRecordContent("买家处理申请超时,申请已关闭。");
				ebSalesrecordService.save(ebSalesrecord);
				ebAftersaleService.save(ebAftersale);

				// 更新订单明细状态
				EbOrderitem ebOrderitem = ebOrderitemService.findid(ebAftersale
						.getOrderitemId());
				if (ebOrderitem != null) {
					ebOrderitem.setIsSend(0);
					ebOrderitemService.save(ebOrderitem);
				}

				EbUser userMsg = userService.getEbUser(ebAftersale.getUserId()
						.toString());
				ebMessageService.chuandis(ebAftersale.getSaleId(), userMsg,
						"退款提醒", "退款进度有更新！", "退款进度有更新，请及时处理！",
						"/uploads/drawable-xhdpi/tzxx.png", 1, 2);
				EbUser shopMsg = userService.getShop(ebAftersale.getShopId()
						.toString());
				ebMessageService.chuandis(ebAftersale.getSaleId(), shopMsg,
						"退款提醒", "退款进度有更新！", "退款进度有更新，请及时处理！",
						"/uploads/drawable-xhdpi/sjzs.png", 3, 8);
			}
		}
	}

	/**
	 * 日统计每日新增御可贡茶与让利金额
	 * 
	 */
	public void myhomegy() {
		// 日统计每日新增御可贡茶与让利金额
		pmUserIdentityLogService.sktuw(DateUtil.getDateFormat(
				DateUtils.addDays(new Date(), -1), "yyyy-MM-dd"));
	}

	// 日统计公益收益
	public void splevel() {
		// 日统计公益收益
		pmUserIdentityLogService.splevel();
	}

	// 红包汇总
	public void summarizing() {
		// 红包汇总
		pmUserIdentityLogService.summarizing(DateUtil.getDateFormat(
				AllUtils.addDate(new Date(), 5, -1), "yyyy-MM-dd"));
	}

	/**
	 * 定时过滤
	 */
	public void GuolvSize() {
		PmSensitiveWordsFilter pmSensitiveWordsFilter = new PmSensitiveWordsFilter();
		pmSensitiveWordsFilter.setFilterStatus(1);
		List<PmSensitiveWordsFilter> filters = pmSensitiveWordsFilterService
				.getList(pmSensitiveWordsFilter);
		for (PmSensitiveWordsFilter pmSensitiveWordsFilter2 : filters) {
			pmSensitiveWordsFilterService.guolv(pmSensitiveWordsFilter2.getId()
					.toString());
		}
	}

	/**
	 * 定时处理未推送的消息
	 */
	/*
	 * public void SendStatusMessin(){ EbMessageUser ebMessageUser=new
	 * EbMessageUser(); ebMessageUser.setState(0); List<EbMessageUser>
	 * ebMessageUsers=ebMessageUserService.getMessageUserList(ebMessageUser);
	 * for (EbMessageUser ebMessageUser2 : ebMessageUsers) {
	 * ebMessageUserService
	 * .sendMsgJgEbMessageUser(ebMessageUser2.getUserId(),ebMessageUser2
	 * .getMessageInfo
	 * ()==null?null:ebMessageUser2.getMessageInfo().getMessageObjId(),
	 * ebMessageUser2.getMessageInfo().getMessageTitle(),
	 * ebMessageUser2.getMessageInfo().getMessageContent(),
	 * ebMessageUser2.getMessageInfo().getMessageType()); }
	 * 
	 * }
	 */

	/**
	 * 5分钟定时处理退款未处理
	 */
	public void userOfflineRechargeStatus() {
		PmUserOfflineRechargeLog parmeteRechargeLog = new PmUserOfflineRechargeLog();
		parmeteRechargeLog.setStatus(5);
		List<PmUserOfflineRechargeLog> userOfflineRechargeLogs = pmUserOfflineRechargeLogService
				.findAll(parmeteRechargeLog);
		if (CollectionUtils.isNotEmpty(userOfflineRechargeLogs)) {
			for (PmUserOfflineRechargeLog status : userOfflineRechargeLogs) {
				long modifytime = status.getModifyTime().getTime();
				long endtime = modifytime + 14400;
				long nowtime = new Date().getTime();
				if (nowtime >= endtime) {
					status.setStatus(3);
					status.setModifyTime(new Date());
					status.setModifyUser("处理超时,平台自动处理");
					pmUserOfflineRechargeLogService.save(status);
				}
			}
		}
	}


	/**
	 * 1分钟定时发送定时消息
	 */
	public void sendMsgToUser() {
		EbMessage ebMessage = new EbMessage();
		ebMessage.setIsTimingSend(1);
		ebMessage.setSendStatus(0);
		ebMessage.setSendTime(new Date());
		List<EbMessage> eMessages = ebMessageService.findMessages(0, 1000,
				ebMessage);
		if (CollectionUtils.isNotEmpty(eMessages)) {
			for (EbMessage eMessage : eMessages) {
				String receiverType = eMessage.getReceiverType().toString();// 1.所有用户;2.所有商家;3.所有买家;4.指定用户;

				if (receiverType.equals("1")) {// 1. 所有用户
					List<Integer  > userIdList=userService.findAllUserToIds(receiverType);

					for (int i = 0; i < userIdList.size(); i++) {
						Integer userId = userIdList.get(i);
						EbMessageUser messageInfoUser = new EbMessageUser();
						messageInfoUser.setUserId(userId);
						messageInfoUser.setMessageInfo(eMessage);
						messageInfoUser.setState(3);
						messageInfoUser.setUserType(1);
						messageInfoUser.setSendTime(new Date());
						messageInfoUser.setCreateUser(SysUserUtils.getUser()
								.getId());
						messageInfoUserService
								.sqlsaveEbMessage(messageInfoUser);
						// 推送
						messageInfoUserService.sendMsgJgEbMessageUser(userId,
								eMessage);
					}
				} else if (StringUtil.isNotBlank(eMessage.getSendUserIds())
						&& receiverType.equals("4")) {// 4、指定用户；
					String[] arr = eMessage.getSendUserIds().split(",");
					for (int i = 0; i < arr.length; i++) {
						EbMessageUser messageInfoUser = new EbMessageUser();
						messageInfoUser.setUserId(Integer.valueOf(arr[i]));
						messageInfoUser.setMessageInfo(eMessage);
						messageInfoUser.setSendTime(new Date());
						messageInfoUser.setState(3);
						messageInfoUser.setUserType(1);
						messageInfoUser.setCreateUser(SysUserUtils.getUser()
								.getId());
						messageInfoUserService
								.sqlsaveEbMessage(messageInfoUser);
					}

				} else if (receiverType.equals("2")) {// 6、所有门店
					List<Integer > list =pmShopInfoService.getAllShopId();
					for (int i = 0; i < list.size(); i++) {
						EbMessageUser messageInfoUser = new EbMessageUser();
						EbUser ebUser = ebUserService.getByShopId(list.get(0));
						messageInfoUser.setUserType(2);
						messageInfoUser.setUserId(ebUser.getUserId());
						messageInfoUser.setMessageInfo(eMessage);
						messageInfoUser.setSendTime(new Date());
						messageInfoUser.setState(3);
						messageInfoUser.setCreateUser(SysUserUtils.getUser()
								.getId());
						messageInfoUserService
								.sqlsaveEbMessage(messageInfoUser);

						messageInfoUserService.sendMsgJgEbMessageUser(list.get(0),
								eMessage);
					}

				} else if (StringUtil.isNotBlank(eMessage.getSendUserIds())
						&& receiverType.equals("4")) {// 7.指定门店
					String[] arr = eMessage.getSendUserIds().split(",");
					for (int i = 0; i < arr.length; i++) {
						EbMessageUser messageInfoUser = new EbMessageUser();
						EbUser ebUser = ebUserService.getByShopId(Integer.valueOf(arr[i]));
						messageInfoUser.setUserId(ebUser.getUserId());
						messageInfoUser.setMessageInfo(eMessage);
						messageInfoUser.setState(3);
						messageInfoUser.setUserType(2);
						messageInfoUser.setCreateTime(new Date());
						messageInfoUser.setSendTime(new Date());
						messageInfoUser.setCreateUser(SysUserUtils.getUser()
								.getId());
						 messageInfoUserService.sqlsaveEbMessage(messageInfoUser);
//						messageInfoUserService.save(messageInfoUser);
						// 推送
						messageInfoUserService.sendMsgJgEbMessageUser(
								Integer.valueOf(ebUser.getUserId()),
								eMessage);

					}
				}

				eMessage.setSendStatus(1);
				ebMessageService.saveflush(eMessage);
			}

		}

	}

//	/**
//	 * 1分钟定时发送定时消息(旧版)
//	 */
//	public void sendMsgToUser() {
//		EbMessage ebMessage = new EbMessage();
//		ebMessage.setIsTimingSend(1);
//		ebMessage.setSendStatus(0);
//		ebMessage.setSendTime(new Date());
//		List<EbMessage> eMessages = ebMessageService.findMessages(0, 1000,
//				ebMessage);
//		if (CollectionUtils.isNotEmpty(eMessages)) {
//			for (EbMessage eMessage : eMessages) {
//				String receiverType = eMessage.getReceiverType().toString();// 1.所有用户;2.所有商家;3.所有买家;4.指定用户;
//
//				if (receiverType.equals("1") || receiverType.equals("2")
//						|| receiverType.equals("3")) {// 1. 2. 3
//					List<Integer> userIdList = userService
//							.findAllUserToIds(receiverType.toString());
//					for (int i = 0; i < userIdList.size(); i++) {
//						Integer userId = userIdList.get(i);
//						EbMessageUser messageInfoUser = new EbMessageUser();
//						messageInfoUser.setUserId(userId);
//						messageInfoUser.setMessageInfo(eMessage);
//						messageInfoUser.setState(0);
//						messageInfoUser.setUserType(1);
//						messageInfoUser.setCreateUser(SysUserUtils.getUser()
//								.getId());
//						messageInfoUserService
//								.sqlsaveEbMessage(messageInfoUser);
//						// 推送
//						messageInfoUserService.sendMsgJgEbMessageUser(userId,
//								eMessage);
//					}
//				} else if (StringUtil.isNotBlank(eMessage.getSendUserIds())
//						&& receiverType.equals("5")) {// 5、指定代理；
//					String[] arr = eMessage.getSendUserIds().split(",");
//					for (int i = 0; i < arr.length; i++) {
//						// SysOffice office=new SysOffice();
//						// office.setId(arr[i]);
//						EbMessageUser messageInfoUser = new EbMessageUser();
//						messageInfoUser.setObjType("2");
//						messageInfoUser.setAgentId(arr[i]);
//						messageInfoUser.setMessageInfo(eMessage);
//						messageInfoUser.setState(3);
//						messageInfoUser.setCreateUser(SysUserUtils.getUser()
//								.getId());
//						messageInfoUserService
//								.sqlsaveEbMessage(messageInfoUser);
//					}
//
//				} else if (receiverType.equals("6")) {// 6、所有代理
//					// List<SysOffice> list = officeService.findAll();
//					// SysOffice office=new SysOffice();
//					List<PmAgentInfo> list = pmAgentInfoService
//							.findAllTypes(new PmAgentInfo());
//					for (int i = 0; i < list.size(); i++) {
//						// SysOffice e = list.get(i);
//						// if (e.getIsAgent()!=null&&e.getIsAgent().equals("1"))
//						// {
//						// office.setId(e.getId());
//						EbMessageUser messageInfoUser = new EbMessageUser();
//						messageInfoUser.setObjType("2");
//						// messageInfoUser.setOffice(office);
//						messageInfoUser.setAgentId(list.get(i).getAgentId()
//								+ "");
//						messageInfoUser.setMessageInfo(eMessage);
//						messageInfoUser.setState(3);
//						messageInfoUser.setCreateUser(SysUserUtils.getUser()
//								.getId());
//						messageInfoUserService
//								.sqlsaveEbMessage(messageInfoUser);
//						// }
//					}
//
//				} else if (StringUtil.isNotBlank(eMessage.getSendUserIds())
//						&& receiverType.equals("4")) {// 4.指定用户
//					String[] arr = eMessage.getSendUserIds().split(",");
//					for (int i = 0; i < arr.length; i++) {
//						EbMessageUser messageInfoUser = new EbMessageUser();
//						messageInfoUser.setUserId(Integer.valueOf(arr[i]));
//						eMessage.setId(Integer.valueOf(eMessage.getId()));
//						messageInfoUser.setMessageInfo(eMessage);
//						// messageInfoUser.setMessageId(Integer.valueOf(messageId));
//						messageInfoUser.setState(0);
//						messageInfoUser.setSendTime(new Date());
//						messageInfoUser.setCreateTime(new Date());
//						messageInfoUser.setCreateUser(SysUserUtils.getUser()
//								.getId());
//						// messageInfoUserService.sqlsaveEbMessage(messageInfoUser);
//						messageInfoUserService.save(messageInfoUser);
//						// 推送
//						messageInfoUserService.sendMsgJgEbMessageUser(
//								Integer.valueOf(arr[i]),
//								eMessage);
//
//					}
//				}
//
//				eMessage.setSendStatus(1);
//				ebMessageService.saveflush(eMessage);
//			}
//
//		}
//
//	}

	/**
	 * 月销量统计
	 */
	public void monthSalesAmountSum() {
		List<EbProduct> ebProducts = ebProductService.findAlls();
		for (EbProduct ebProduct : ebProducts) {
			String sum = ebProductService.molSunn(ebProduct.getProductId()
					.toString());
			if (StringUtils.isNotBlank(sum)) {
				ebProduct.setMonthSalesAmount(Integer.parseInt(sum));
			} else {
				ebProduct.setMonthSalesAmount(0);
			}
			ebProductService.saveProduct(ebProduct);
		}
	}

	/**
	 * 更新用户融云token
	 * 
	 * @throws Exception
	 */
	public void updateRongCloudToken() throws Exception {
		String sqlString = "select * from eb_user eu where (token = '' or token is null) and createtime >'2017-09-19 00:00:00'";
		List<EbUser> ebUsers = ebUserService.findBySql(sqlString);
		for (EbUser objuser : ebUsers) {
			String userToken = RongCloudUtils.userGetTokenResult(
					objuser.getUserId(), objuser.getMobile(),
					Global.getAdminPath() + "/static/h5/images/comm-toux.png");
			objuser.setToken(userToken);
			ebUserService.save(objuser);
		}
	}

	/**
	 * 更新2017-1-19之前的用户融云token
	 * 
	 * @throws Exception
	 */
	public void updateUserToken() throws Exception {
		String sqlString = "select * from eb_user eu where createtime <'2017-09-19 00:00:00'";
		List<EbUser> ebUsers = ebUserService.findBySql(sqlString);
		for (EbUser objuser : ebUsers) {
			String userToken = RongCloudUtils.userGetTokenResult(
					objuser.getUserId(), objuser.getMobile(),
					Global.getAdminPath() + "/static/h5/images/comm-toux.png");
			objuser.setToken(userToken);
			ebUserService.save(objuser);
		}
	}

	/**
	 * 统计一天内的支付金额情况
	 * 
	 * @throws Exception
	 */
	public void oneDayPayDetail() throws Exception {
		Date date1 = DateUtil.addDate(new Date(), 5, -1);
		SimpleDateFormat simpledateformat = new SimpleDateFormat("yyyy-MM-dd");
		String startTime = simpledateformat.format(date1) + " 00:00:00";
		String endTime = simpledateformat.format(date1) + " 23:59:59";
		Map<Integer, String> map = new HashMap<Integer, String>();
		List<PmOpenPayWay> list = pmOpenPayWayService
				.getList(new PmOpenPayWay());
		if (CollectionUtils.isNotEmpty(list)) {
			for (PmOpenPayWay pmOpenPayWay : list) {
				map.put(pmOpenPayWay.getPayWayCode(),
						pmOpenPayWay.getPayWayName());
			}
		}
		PmSysPayAmountStatistics ps = new PmSysPayAmountStatistics();
		ps.setCreateUser("系统");
		ps.setCreateTime(new Date());
		ps.setStatisticsTime(date1);
		ps = pmSysPayAmountStatisticsService.payAmountStatistics(map,
				startTime, endTime, ps);
		pmSysPayAmountStatisticsService.save(ps);

	}

	/**
	 * 每周一定时发送短信提醒
	 * 4.每周一，给御可贡茶积分大于或等于1的用户发送短信。尊敬的御可贡茶用户：您的账号目前总积分XX，上周消耗掉XX积分获得XX元分红
	 * 。详情请看御可贡茶APP或公众号，邀请好友消费分红越高噢！ 积分和分红那里截取到小数点后一位就可以了
	 * 
	 * @throws Exception
	 */
	@Transactional(readOnly = false)
	public void smsOneDay() throws Exception {
		Date now = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		// 上周消耗积分列表
		List<Object> loveList = ebExpandService.getWeekLove(
				sdf.format(DateTest.getDate(now, -7)),
				sdf.format(DateTest.getDate(now, -1)));
		// 上周消耗积分获取到的金额列表
		List<Object> moneyList = ebExpandService.getWeekMoney(
				sdf.format(DateTest.getDate(now, -7)),
				sdf.format(DateTest.getDate(now, -1)));
		// 遍历存值
		Map<String, Map<String, Object>> mapmap = new HashMap<String, Map<String, Object>>();
		Map<String, Object> map = new HashMap<String, Object>();
		// 存入积分信息
		for (int i = 0; i < loveList.size(); i++) {
			// 用户id 手机号 当前积分 消耗积分
			Object[] str = (Object[]) loveList.get(i);
			map = new HashMap<String, Object>();
			map.put("userId", str[0]);
			map.put("mobile", str[1]);
			map.put("currentLove", str[2]);
			map.put("sum_love", str[3]);
			map.put("love_amt", str[4]);
			if(str[0]!=null)
			mapmap.put(str[0].toString(), map);
		}
		// 存入金额信息
		for (int i = 0; i < moneyList.size(); i++) {
			// 用户id 手机号 当前积分 获得金额
			Object[] str = (Object[]) moneyList.get(i);
			// 重复数据合并
			if(str[0]!=null)
			if (mapmap.get(str[0].toString()) != null) {
				mapmap.get(str[0].toString()).put("sum_money", str[3]);
			} else {
				map = new HashMap<String, Object>();
				map.put("userId", str[0]);
				map.put("mobile", str[1]);
				map.put("currentLove", str[2]);
				map.put("sum_money", str[3]);
				map.put("love_amt", str[4]);
				mapmap.put(str[0].toString(), map);
			}
		}

		for (Map.Entry<String, Map<String, Object>> entry : mapmap.entrySet()) {
			System.out.println("Key = " + entry.getKey() + ", Value = "
					+ entry.getValue());
			String projectName = Global.getConfig("projectName");
			String smsmsg = "尊敬的"+projectName+"用户：您的账号目前总积分"+entry.getValue().get("currentLove")+"，上周消耗掉"+entry.getValue().get("sum_love")+"积分获得"+entry.getValue().get("sum_money")+"元分红,"+"累计积分奖励金额"+entry.getValue().get("love_amt")+"元。详情请看"+projectName+"APP或公众号，邀请好友消费分红越高噢！"
					;
			
			if(entry.getValue().get("mobile")!=null){
			boolean flag = CommonUtils.sendMsg(entry.getValue().get("mobile").toString(), smsmsg);
			if(flag){
				System.out.println("Key = " + entry.getKey() + ", Value =短信发送成功 ");
			}else{
				System.out.println("Key = " + entry.getKey() + ", Value =短信发送失败 ");
			}
			}
		}

	}



	/**
	 * 统计余额汇总
	 * 
	 * @throws Exception
	 */
	@Transactional(readOnly = false)
	public void saveAmtStatistics() {
		Date date = new Date();
		SimpleDateFormat format0 = new SimpleDateFormat("yyyy-MM-dd");
        String time = format0.format(date.getTime());//这个就是把时间戳经过处理得到期望格式的时间
        Double totalAmt = ebExpandService.sumCurrentAmt() + pmAgentInfoService.sumCurrentAmt();
        Double recharge = pmAmtLogService .sumRecharge(time);
        Double todayAmt = ebExpandService .sumTodayAmt() + pmAgentInfoService .sumTodayAmt();
        Double refund = pmAmtLogService .sumRefund(time);
        /** 用户余额，不包含总平台 */
        Double userCurrentAmt = ebExpandService.sumUserCurrentAmt();
        /** 充值余额 */
        Double rechargeAmt = pmAmtLogService.sumRechargeAmt();
        /** 第三方支付渠道退款（非余额退款）*/
        Double refundPayAmt = pmAmtLogService.sumRefundPayAmt();
        /**用户分红余额 */
        Double userTodayAmt = pmAmtLogService.sumUserTodayAmt();
        /**代理分红余额*/
        Double agentTodayAmt = pmAmtLogService.sumAgentTodayAmt();
        /**代理当前余额*/
        Double agentCurrentAmt = pmAgentInfoService.sumCurrentAmt();
        /**余额交易金额 余额付款*/
        Double amtPayAmt = ebOrderService.sumAmtPayAmt();
        /**余额交易金额 余额退款 */
        Double amtRefundAmt = pmAmtLogService.sumAmtRefundAmt();
        /**用户冻结金额 */
        Double userFrozenAmt = ebExpandService.sumUserFrozenAmt();
        
		PmAmtStatistics pmAmtStatistics = new PmAmtStatistics();
		pmAmtStatistics.setTime(time);
		pmAmtStatistics.setTotalAmt(CountMoney.get2Double(totalAmt, 2));
		pmAmtStatistics.setRecharge(CountMoney.get2Double(recharge, 2));
		pmAmtStatistics.setTodayAmt(CountMoney.get2Double(todayAmt, 2));
		pmAmtStatistics.setRefund(CountMoney.get2Double(refund, 2));
		pmAmtStatistics.setUserCurrentAmt(CountMoney.get2Double(userCurrentAmt, 2));
		pmAmtStatistics.setRechargeAmt(CountMoney.get2Double(rechargeAmt, 2));
		pmAmtStatistics.setRefundPayAmt(CountMoney.get2Double(refundPayAmt, 2));
		pmAmtStatistics.setUserTodayAmt(CountMoney.get2Double(userTodayAmt, 2));
		pmAmtStatistics.setAgentTodayAmt(CountMoney.get2Double(agentTodayAmt, 2));
		pmAmtStatistics.setAgentCurrentAmt(CountMoney.get2Double(agentCurrentAmt, 2));
		pmAmtStatistics.setAmtPayAmt(CountMoney.get2Double(amtPayAmt, 2));
		pmAmtStatistics.setAmtRefundAmt(CountMoney.get2Double(amtRefundAmt, 2));
		pmAmtStatistics.setUserFrozenAmt(CountMoney.get2Double(userFrozenAmt, 2));
		pmAmtStatistics.setCreateTime(date);
		pmAmtStatisticsService.save(pmAmtStatistics);
	}


	/**
	 * 定时器 - 收款10分钟定时查询更新状态
	 *
	 * @throws Exception
	 */
	@Transactional(readOnly = false)
	public void invalidOrderInfo() throws Exception {


		//查询收款订单
		EbOrder ebOrder = new EbOrder();
		ebOrder.setType(1);
		String status = "2,3,4";
		List<EbOrder> ebOrders = ebOrderService.getOrderListByKey(ebOrder, status);
		logger.info("查询合利宝退款订单状态---:" + ebOrders.size() + "条");
		for (int i = 0; i < ebOrders.size(); i++) {
			ebOrder = ebOrders.get(i);
			Map<String, Object> retMap = sbscPayService.heliPayRefundQueryHandle(ebOrder);

		}

	}

}