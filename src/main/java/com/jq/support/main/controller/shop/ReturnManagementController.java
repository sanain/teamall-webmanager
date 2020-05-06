package com.jq.support.main.controller.shop;

import java.io.File;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.jq.support.common.config.Global;
import com.jq.support.common.persistence.Page;
import com.jq.support.common.utils.DateUtils;
import com.jq.support.common.utils.FileUtils;
import com.jq.support.common.utils.StringUtils;
import com.jq.support.common.web.BaseController;
import com.jq.support.model.message.EbMessage;
import com.jq.support.model.message.EbMessageUser;
import com.jq.support.model.order.EbAftersale;
import com.jq.support.model.order.EbOrder;
import com.jq.support.model.order.EbOrderitem;
import com.jq.support.model.order.EbSalesrecord;
import com.jq.support.model.order.PmReturnGoodIntervene;
import com.jq.support.model.product.PmShopInfo;
import com.jq.support.model.shop.PmShopDepotAddress;
import com.jq.support.model.user.EbUser;
import com.jq.support.model.user.PmAmtLog;
import com.jq.support.service.merchandise.order.EbAftersaleService;
import com.jq.support.service.merchandise.order.EbOrderService;
import com.jq.support.service.merchandise.order.EbOrderitemService;
import com.jq.support.service.merchandise.order.EbSalesrecordService;
import com.jq.support.service.merchandise.order.PmReturnGoodInterveneService;
import com.jq.support.service.merchandise.shop.PmShopDepotAddressService;
import com.jq.support.service.merchandise.shop.PmShopInfoService;
import com.jq.support.service.merchandise.user.EbUserService;
import com.jq.support.service.merchandise.user.PmAmtLogService;
import com.jq.support.service.message.EbMessageService;
import com.jq.support.service.message.EbMessageUserService;
import com.jq.support.service.utils.AllUtils;
/**
 * 商户退货管理
 * EbAftersaleController
 * @author Li-qi
 */
@Controller
@RequestMapping(value = "${adShopPath}/ReturnManagement/")
public class ReturnManagementController extends BaseController{
	@Autowired
	private EbMessageUserService messageInfoUserService;
	@Autowired
	private EbAftersaleService ebAftersaleService;
	@Autowired
	private EbSalesrecordService ebSalesrecordService;
	@Autowired
	private EbUserService ebUserService;
	@Autowired
	private PmShopInfoService pmShopInfoService;
	@Autowired
	private EbOrderitemService ebOrderitemService;
	@Autowired
	private EbOrderService ebOrderService;
	@Autowired
	private PmAmtLogService pmAmtLogService;
	@Autowired
	private PmReturnGoodInterveneService pmReturnGoodInterveneService;
	@Autowired
	private PmShopDepotAddressService pmShopDepotAddressService;
	@Autowired
	private EbMessageService ebMessageService;
	@RequestMapping(value = "ReturnManagementList")
	public String returnManagementList(HttpServletRequest request, HttpServletResponse response,Model model) throws JsonProcessingException {
		EbUser ebUser=(EbUser) request.getSession().getAttribute("shopuser");
		if(ebUser==null){
			model.addAttribute("messager", "登陆失效,请重新登陆");
			return "modules/shop/login2";
		}else {
			String saleNo=request.getParameter("saleNo");
			String orderNo=request.getParameter("orderNo");
			String mobileNo=request.getParameter("mobileNo");
			String refundStatus=request.getParameter("refundStatus");
			String startTime=request.getParameter("startTime");
			String endTime=request.getParameter("endTime");
			EbAftersale ebAftersale=new EbAftersale();
			ebAftersale.setShopId(ebUser.getShopId());
			if(StringUtils.isNotEmpty(saleNo)){
				ebAftersale.setSaleNo(saleNo);
			}
			if(StringUtils.isNotEmpty(refundStatus)&&!refundStatus.equals("0")){
				ebAftersale.setRefundStatus(Integer.valueOf(refundStatus));
			}
			Page<EbAftersale> page=ebAftersaleService.pageEbAftersaleList(ebAftersale,mobileNo,orderNo,startTime,endTime,new Page<EbAftersale>(request,response));
			if(page.getCount()!=0){
				model.addAttribute("page", page);
			}
			model.addAttribute("saleNo", saleNo);
			model.addAttribute("orderNo", orderNo);
			model.addAttribute("mobileNo", mobileNo);
			model.addAttribute("refundStatus", refundStatus);
			model.addAttribute("startTime", startTime);
			model.addAttribute("endTime", endTime);
			return "modules/shop/return-manage";
		}
	}
	
	@RequestMapping(value = {"salesrecordlist"})
	public String salesrecordlist(HttpServletRequest request, HttpServletResponse response,Model model){
		String saleId= request.getParameter("saleId");
		EbSalesrecord ebSalesrecord=new EbSalesrecord();
		if(StringUtils.isNotEmpty(saleId)){
			ebSalesrecord.setSaleId(Integer.valueOf(saleId));
		}
		List<EbSalesrecord> salesrecords=ebSalesrecordService.getEbSalesrecordList(ebSalesrecord,2);
		if(CollectionUtils.isNotEmpty(salesrecords)){
			for(EbSalesrecord img:salesrecords){
				img.setRecordContent(img.getRecordContent().replace("\n","<br>"));
				if(img.getRecordObjType()==1){
					EbUser ebUser=ebUserService.getEbUser(img.getRecordObjId().toString());
					if(ebUser!=null){
						img.setRecordObjName(ebUser.getUsername());
						img.setRecordObjImg(ebUser.getAvataraddress());
					}
				}
				if(img.getRecordObjType()==2){
					PmShopInfo pmShopInfo=pmShopInfoService.getpmPmShopInfo(img.getRecordObjId().toString());
					if(pmShopInfo!=null){
						img.setRecordObjName(pmShopInfo.getShopName());
						img.setRecordObjImg(pmShopInfo.getShopLogo());
					}
				}
				if(StringUtils.isNotBlank(img.getRecordEvidencePicUrl())){
					String[] aStrings=img.getRecordEvidencePicUrl().split(",");
					img.setImgList(aStrings);
				}
			}
			model.addAttribute("salesrecords", salesrecords);
		}
		createPicFold(request);
		model.addAttribute("saleId", saleId);
		return "modules/shop/refund-history";
	}
	
	@RequestMapping(value = "ReturnManagementForm")
	public String returnManagementForm(HttpServletRequest request, HttpServletResponse response,Model model) throws JsonProcessingException {
		EbUser ebUser=(EbUser) request.getSession().getAttribute("shopuser");
		if(ebUser==null){
			model.addAttribute("messager", "登陆失效,请重新登陆");
			return "modules/shop/login2";
		}else {
			String id=request.getParameter("id");
			if(StringUtils.isNotEmpty(id)){
				EbAftersale ebAftersale=ebAftersaleService.getebAftersale(id);
				if(ebAftersale!=null){
					EbOrderitem ebOrderitem=new EbOrderitem();
					ebOrderitem.setOrderId(ebAftersale.getOrderId());
					EbAftersale aftersale=new EbAftersale();
					aftersale.setOrderId(ebAftersale.getOrderId());
					Integer aftersaleCount=Integer.valueOf(ebAftersaleService.getCount(aftersale));
					Integer oderitemCount=Integer.valueOf(ebOrderitemService.getCount(ebOrderitem));
					if(aftersaleCount==oderitemCount){
						EbAftersale maxtime=ebAftersaleService.getMaxTime(ebAftersale.getOrderId());
						Double postage=maxtime.getOrder().getPayableFreight();
						if(id.equals(maxtime.getSaleId().toString())){
							model.addAttribute("postage", postage.toString());
						}
					}
					if(StringUtils.isNotBlank(ebAftersale.getRefundEvidencePicUrl())){
						String[] aStrings=ebAftersale.getRefundEvidencePicUrl().split(",");
						ebAftersale.setImgList(aStrings);
					}
					EbSalesrecord ebSalesrecord=new EbSalesrecord();
					ebSalesrecord.setSaleId(Integer.valueOf(id));
					List<EbSalesrecord> salesrecords=ebSalesrecordService.getEbSalesrecordList(ebSalesrecord,1);
					if(CollectionUtils.isNotEmpty(salesrecords)){
						model.addAttribute("salesrecords", salesrecords);
					}
					if(ebAftersale.getUpdateTime()!=null){
						long nowTime =new Date().getTime();
						long createTime=0;
						if(ebAftersale.getApplicationType()==1&&ebAftersale.getTakeStatus()==0&&ebAftersale.getRefundStatus()==1){
							createTime=AllUtils.addDate(ebAftersale.getUpdateTime(), 5, 2).getTime();
						}
						if(ebAftersale.getApplicationType()==1&&ebAftersale.getTakeStatus()==1&&ebAftersale.getRefundStatus()==1){
							createTime=AllUtils.addDate(ebAftersale.getUpdateTime(), 5, 5).getTime();
						}
						if(ebAftersale.getApplicationType()==0&&ebAftersale.getTakeStatus()==1&&ebAftersale.getRefundStatus()==1){
							createTime=AllUtils.addDate(ebAftersale.getUpdateTime(), 5, 5).getTime();
						}
						if(ebAftersale.getApplicationType()==0&&ebAftersale.getTakeStatus()==1&&ebAftersale.getRefundStatus()==5){
							createTime=AllUtils.addDate(ebAftersale.getUpdateTime(), 5, 7).getTime();
						}
						if(ebAftersale.getApplicationType()==0&&ebAftersale.getTakeStatus()==1&&ebAftersale.getRefundStatus()==6){
							createTime=AllUtils.addDate(ebAftersale.getUpdateTime(), 5, 10).getTime();
						}
						if(ebAftersale.getApplicationType()==1&&ebAftersale.getTakeStatus()==2&&ebAftersale.getRefundStatus()==1){
							createTime=AllUtils.addDate(ebAftersale.getUpdateTime(), 5, 5).getTime();
						}
						if(ebAftersale.getApplicationType()==1&&ebAftersale.getTakeStatus()==2&&ebAftersale.getRefundStatus()==7){
							createTime=AllUtils.addDate(ebAftersale.getUpdateTime(), 5, 3).getTime();
						}
						if(ebAftersale.getApplicationType()==0&&ebAftersale.getTakeStatus()==2&&ebAftersale.getRefundStatus()==1){
							createTime=AllUtils.addDate(ebAftersale.getUpdateTime(), 5, 5).getTime();
						}
						if(ebAftersale.getApplicationType()==0&&ebAftersale.getTakeStatus()==2&&ebAftersale.getRefundStatus()==5){
							createTime=AllUtils.addDate(ebAftersale.getUpdateTime(), 5, 7).getTime();
						}
						if(ebAftersale.getApplicationType()==0&&ebAftersale.getTakeStatus()==2&&ebAftersale.getRefundStatus()==6){
							createTime=AllUtils.addDate(ebAftersale.getUpdateTime(), 5, 10).getTime();
						}
						if(ebAftersale.getApplicationType()==0&&ebAftersale.getTakeStatus()==2&&ebAftersale.getRefundStatus()==3){
							createTime=AllUtils.addDate(ebAftersale.getUpdateTime(), 5, 3).getTime();
						}
						if(ebAftersale.getApplicationType()==0&&ebAftersale.getTakeStatus()==2&&ebAftersale.getRefundStatus()==2){
							createTime=AllUtils.addDate(ebAftersale.getUpdateTime(), 5, 3).getTime();
						}
						if(ebAftersale.getTakeStatus()==0&&ebAftersale.getRefundStatus()==1){
							createTime=AllUtils.addDate(ebAftersale.getUpdateTime(), 5, 2).getTime();
						}
						if(ebAftersale.getTakeStatus()==1&&ebAftersale.getRefundStatus()==1){
							createTime=AllUtils.addDate(ebAftersale.getUpdateTime(), 5, 5).getTime();
						}
						if(ebAftersale.getTakeStatus()==1&&ebAftersale.getRefundStatus()==5){
							createTime=AllUtils.addDate(ebAftersale.getUpdateTime(), 5, 7).getTime();
						}
						if(ebAftersale.getTakeStatus()==1&&ebAftersale.getRefundStatus()==6){
							createTime=AllUtils.addDate(ebAftersale.getUpdateTime(), 5, 10).getTime();
						}
						if(ebAftersale.getTakeStatus()==2&&ebAftersale.getRefundStatus()==1){
							createTime=AllUtils.addDate(ebAftersale.getUpdateTime(), 5, 5).getTime();
						}
						if(ebAftersale.getTakeStatus()==2&&ebAftersale.getRefundStatus()==5){
							createTime=AllUtils.addDate(ebAftersale.getUpdateTime(), 5, 7).getTime();
						}
						if(ebAftersale.getTakeStatus()==2&&ebAftersale.getRefundStatus()==6){
							EbUser username=ebUserService.getEbUser(ebAftersale.getUserId().toString());
							if(username!=null){
								ebAftersale.setUsermobile(username.getMobile());
							}
							if(StringUtils.isNotBlank(ebAftersale.getSendGoodsPicUrl())){
								String[] aStrings=ebAftersale.getSendGoodsPicUrl().split(",");
								ebAftersale.setImgList(aStrings);
							}
							createTime=AllUtils.addDate(ebAftersale.getUpdateTime(), 5, 10).getTime();
						}
						if(ebAftersale.getTakeStatus()==2&&ebAftersale.getRefundStatus()==7){
							createTime=AllUtils.addDate(ebAftersale.getUpdateTime(), 5, 3).getTime();
						}
						if(ebAftersale.getTakeStatus()==2&&ebAftersale.getRefundStatus()==8){
							createTime=AllUtils.addDate(ebAftersale.getUpdateTime(), 5, 3).getTime();
						}
						if(ebAftersale.getRefundStatus()==9){
							createTime=AllUtils.addDate(ebAftersale.getUpdateTime(), 5, 3).getTime();
							PmReturnGoodIntervene returnGoodIntervene=pmReturnGoodInterveneService.getSaleId(Integer.valueOf(id));
							if(returnGoodIntervene!=null){
								model.addAttribute("returnGoodIntervene", returnGoodIntervene);
							}
						}
						long updateTime=createTime-nowTime;
						if(updateTime>0){
							model.addAttribute("updateTime", updateTime);
						}
					}
					model.addAttribute("aftersale", ebAftersale);
				}
			}
			return "modules/shop/return-shop";
		}
	}
	
	@RequestMapping(value = {"addRecordContent"})
	public String addRecordContent(HttpServletRequest request, HttpServletResponse response,Model model){
		String saleId= request.getParameter("saleId");
		String recordContent= request.getParameter("recordContent");
		String recordEvidencePicUrl= request.getParameter("recordEvidencePicUrl");
		EbUser ebUser=(EbUser) request.getSession().getAttribute("shopuser");
		if(ebUser==null){
			model.addAttribute("messager", "登陆失效,请重新登陆");
			return "modules/shop/login2";
		}else {
			EbSalesrecord ebSalesrecord=new EbSalesrecord();
			Date nowTime=new Date();
			ebSalesrecord.setRecordDate(nowTime);
			ebSalesrecord.setRecordObjType(2);//协商对象类型：1、买家；2、卖家；3平台
			ebSalesrecord.setRecordObjId(ebUser.getShopId());
			ebSalesrecord.setSaleId(Integer.valueOf(saleId));
			ebSalesrecord.setRecordName("卖家留言。");
			ebSalesrecord.setRecordContent("卖家留言。"+recordContent);
			if(StringUtils.isNotBlank(recordEvidencePicUrl)){
				String[] aStrings=recordEvidencePicUrl.substring(1, recordEvidencePicUrl.length()).replace("|", ",").split(",");
				String imgString="";
				for (int i = 0; i < aStrings.length; i++) {
					if(i<6){
						imgString+=aStrings[i]+",";
					}
				}
				ebSalesrecord.setRecordEvidencePicUrl(imgString);
			}
			ebSalesrecordService.save(ebSalesrecord);
			model.addAttribute("messager", "留言成功!");
			return "redirect:/shop/ReturnManagement/salesrecordlist?saleId="+saleId;
		}
	}

	@RequestMapping(value = {"refundRefusejsp"})
	public String refundRefusejsp(HttpServletRequest request, HttpServletResponse response,Model model){
		String saleId= request.getParameter("saleId");
		String recordContent= request.getParameter("recordContent");
		if(StringUtils.isNotBlank(recordContent)){
			String rejectRefundPicUrl= request.getParameter("rejectRefundPicUrl");
			EbUser ebUser=(EbUser) request.getSession().getAttribute("shopuser");
			if(ebUser==null){
				model.addAttribute("messager", "登陆失效,请重新登陆");
				return "modules/shop/login2";
			}else {
				Date nowTime=new Date();
				EbAftersale ebAftersale=ebAftersaleService.getebAftersale(saleId);
				ebAftersale.setRefundStatus(2);
				if(StringUtils.isNotBlank(recordContent)){
					ebAftersale.setRejectRefundExplain("理由："+recordContent);
				}else {
					recordContent="理由：未填写";
					ebAftersale.setRejectRefundExplain(recordContent);
				}
				if(StringUtils.isNotBlank(rejectRefundPicUrl)){
					String[] aStrings=rejectRefundPicUrl.substring(1, rejectRefundPicUrl.length()).replace("|", ",").split(",");
					String imgString="";
					for (int i = 0; i < aStrings.length; i++) {
						if(i<6){
							imgString+=aStrings[i]+",";
						}
					}
					if(StringUtils.isNotBlank(imgString)){
						imgString = imgString.substring(0, imgString.length()-1);
						ebAftersale.setRejectRefundPicUrl(imgString);
					}
				}
				ebAftersale.setUpdateTime(nowTime);
				EbSalesrecord ebSalesrecord=new EbSalesrecord();
				ebSalesrecord.setRecordDate(nowTime);
				ebSalesrecord.setRecordObjType(2);//协商对象类型：1、买家；2、卖家；3平台
				ebSalesrecord.setRecordObjId(ebUser.getShopId());
				ebSalesrecord.setSaleId(Integer.valueOf(saleId));
				ebSalesrecord.setRecordName("卖家拒绝了退款申请。");
				ebSalesrecord.setRecordContent("您拒绝了买家的退款申请。\n理由："+recordContent);
				ebSalesrecord.setRecordEvidencePicUrl(ebAftersale.getRejectRefundPicUrl());
				ebAftersaleService.save(ebAftersale);
				ebSalesrecordService.save(ebSalesrecord);
				//消息
				EbMessageUser messageInfoUser=new EbMessageUser();
				messageInfoUser.setUserId(ebAftersale.getUserId());
				EbMessage eMessage=new EbMessage();
				eMessage.setCreateTime(new Date());
				eMessage.setCreateUser(""+ebAftersale.getShopId());
				eMessage.setMessageAbstract("退款消息！");
				eMessage.setMessageTitle("退款消息！");
				eMessage.setMessageClass(1);//1、交易物流消息；2、系统消息；3、商家助手；4、御可贡茶公告；
				eMessage.setMessageContent("卖家拒绝了退款申请。");
				eMessage.setMessageIcon("/uploads/drawable-xhdpi/rm.png");
				eMessage.setMessageObjId(ebAftersale.getSaleId());
				eMessage.setMessageType(2);//1、物流消息；2、退款消息；3、角色消息；4、人脉消息；5、系统消息；6、发货提醒；7、 结算提醒；8、退货/售后提醒；9、系统公告；
				ebMessageService.saveflush(eMessage);
				messageInfoUser.setMessageInfo(eMessage);
				messageInfoUser.setState(3);
				messageInfoUser.setUserType(1);
				messageInfoUser.setCreateUser(ebUser.getUserId()+"");
				messageInfoUser.setObjType("1");
				messageInfoUserService.sqlsaveEbMessage(messageInfoUser);
				//推送
				messageInfoUserService.sendMsgJgEbMessageUser(ebAftersale.getUserId(), eMessage);
				model.addAttribute("messager", "拒绝成功!");
				return "redirect:/shop/ReturnManagement/ReturnManagementForm?id="+saleId;
			}
		}
		createPicFold(request);
		model.addAttribute("saleId", saleId);
		return "modules/shop/refund-refuse";
	}
	
	@RequestMapping(value = "ReturnManagementAffirm")
	public String returnManagementAffirm(HttpServletRequest request, HttpServletResponse response,Model model) {
		EbUser ebUser=(EbUser) request.getSession().getAttribute("shopuser");
		if(ebUser==null){
			model.addAttribute("messager", "登陆失效,请重新登陆");
			return "modules/shop/login2";
		}else {
			String aftersaleid=request.getParameter("aftersaleid");
			if(StringUtils.isNotEmpty(aftersaleid)){
				EbAftersale ebAftersale=ebAftersaleService.getebAftersale(aftersaleid);
				if(ebAftersale!=null && ebAftersale.getRefundStatus()!=null && ebAftersale.getRefundStatus()==1){
					EbOrderitem  ebOrderitem =ebAftersale.getOrderitem();//订单明细
					Integer type=ebAftersale.getApplicationType();//申请类型（0，退货退款,1，退款 2，换货)
					if(type==0){//申请类型（0，退货退款,1，退款 2，换货)
						String shopDepotAddressid= request.getParameter("shopDepotAddressid");
						if(StringUtils.isNotBlank(shopDepotAddressid)){
							PmShopDepotAddress pmShopDepotAddress=pmShopDepotAddressService.getPmShopDepotAddress(shopDepotAddressid);
							if(pmShopDepotAddress!=null){
								Date nowTime=new Date();
								ebAftersale.setUpdateTime(nowTime);
								ebAftersale.setRefundStatus(5);//1、待卖家处理；2、卖家已拒绝；3、退款成功；4、关闭退款；5、等待买家退货；6、等待卖家确认收货；7、等待买家确认收款；8、等待卖家退款；9、平台已介入处理；
								ebAftersale.setUpdateTime(nowTime);
								String ContactName=null;
								String ProvinceName=null;
								String CityName=null;
								String AreName=null;
								String DetailAddress=null;
								if(StringUtils.isNotBlank(pmShopDepotAddress.getContactName())){
									ContactName=pmShopDepotAddress.getContactName();
								}
								if(StringUtils.isNotBlank(pmShopDepotAddress.getProvinceName())){
									ProvinceName=pmShopDepotAddress.getProvinceName();
								}
								if(StringUtils.isNotBlank(pmShopDepotAddress.getCityName())){
									CityName=pmShopDepotAddress.getCityName();
								}
								if(StringUtils.isNotBlank(pmShopDepotAddress.getAreaName())){
									AreName=pmShopDepotAddress.getAreaName();
								}
								if(StringUtils.isNotBlank(pmShopDepotAddress.getDetailAddress())){
									DetailAddress=pmShopDepotAddress.getDetailAddress();
								}
								String ReturnGoodAddress=ContactName+ProvinceName+CityName+AreName+DetailAddress;
								ebAftersale.setReturnGoodAddress(ReturnGoodAddress);
								if(StringUtils.isNotBlank(pmShopDepotAddress.getZipCode())){
									ebAftersale.setZipCode(pmShopDepotAddress.getZipCode());
								}else {
									ebAftersale.setZipCode("000000");
								}
								if(StringUtils.isNotBlank(pmShopDepotAddress.getContactName())){
									ebAftersale.setConsigneeName(pmShopDepotAddress.getContactName());
								}
								if(StringUtils.isNotBlank(pmShopDepotAddress.getPhoneNumber())){
									ebAftersale.setConsigneePhone(pmShopDepotAddress.getPhoneNumber());
								}
								
								//明细设置退货中状态
								if (ebOrderitem!=null) {
									ebOrderitem.setIsSend(5);
									ebOrderitemService.save(ebOrderitem);
								}
								
								EbSalesrecord ebSalesrecord=new EbSalesrecord();
								ebSalesrecord.setRecordDate(nowTime);
								ebSalesrecord.setRecordObjType(2);//协商对象类型：1、买家；2、卖家；3平台
								ebSalesrecord.setRecordObjId(ebUser.getShopId());
								ebSalesrecord.setSaleId(ebAftersale.getSaleId());
								ebSalesrecord.setRecordName("卖家同意了退款申请。");
								ebSalesrecord.setRecordContent("卖家同意您的退款申请\n 等待买家退货。");

								ebAftersaleService.save(ebAftersale);
								ebSalesrecordService.save(ebSalesrecord);
								
								//发送消息
								ebMessageService.sendAftersaleMessage(ebAftersale);
							}
						}
					}
					if(type==1){//申请类型（0，退货退款,1，退款 2，换货)
						Date nowTime=new Date();
						ebAftersale.setShopId(ebUser.getShopId());
						ebAftersale.setUpdateTime(nowTime);
						/*if(ebAftersale.getRefundStatus()==1){
							ebAftersale.setRefundWay(1);
						}
						if(ebAftersale.getRefundStatus()==8){
							ebAftersale.setRefundWay(2);
						}*/
						ebAftersale.setRefundStatus(3);//1、待卖家处理；2、卖家已拒绝；3、退款成功；4、关闭退款；5、等待买家退货；6、等待卖家确认收货；7、等待买家确认收款；8、等待卖家退款；9、平台已介入处理；
						ebAftersaleService.save(ebAftersale);
						
						EbSalesrecord ebSalesrecord=new EbSalesrecord();
						ebSalesrecord.setRecordDate(nowTime);
						ebSalesrecord.setRecordObjType(2);//协商对象类型：1、买家；2、卖家；3平台
						ebSalesrecord.setRecordObjId(ebUser.getShopId());
						ebSalesrecord.setSaleId(ebAftersale.getSaleId());
						ebSalesrecord.setRecordName("卖家同意了退款申请。");
						ebSalesrecord.setRecordContent("卖家同意您的退款申请。\n卖家退款成功,等待买家确认收款。");
						ebSalesrecordService.save(ebSalesrecord);
						
						//保存退款退货信息
						ebAftersaleService.saveAftersaleInfo(ebUser, ebAftersale, ebOrderitem, nowTime);
						//发送消息
						ebMessageService.sendAftersaleMessage(ebAftersale);
					}
				}
			}
		}
		request.getSession().setAttribute("shopuser", ebUser);
		return "redirect:/shop/ReturnManagement/ReturnManagementList";
	}
	
	@RequestMapping(value = "confirmReceipt")
	public String confirmReceipt(HttpServletRequest request, HttpServletResponse response,Model model) throws JsonProcessingException {
		EbUser ebUser=(EbUser) request.getSession().getAttribute("shopuser");
		if(ebUser==null){
			model.addAttribute("messager", "登陆失效,请重新登陆");
			return "modules/shop/login2";
		}else {
			String aftersaleid=request.getParameter("aftersaleid");
			if(StringUtils.isNotEmpty(aftersaleid)){
				EbAftersale ebAftersale=ebAftersaleService.getebAftersale(aftersaleid);
				if(ebAftersale!=null){
					Date nowTime=new Date();
					ebAftersale.setUpdateTime(nowTime);
					
					
					EbSalesrecord ebSalesrecord=new EbSalesrecord();
					ebSalesrecord.setRecordDate(nowTime);
					ebSalesrecord.setRecordObjType(2);//协商对象类型：1、买家；2、卖家；3平台
					ebSalesrecord.setRecordObjId(ebUser.getShopId());
					ebSalesrecord.setSaleId(ebAftersale.getSaleId());
					ebSalesrecord.setRecordName("卖家确认收货。");
					ebSalesrecord.setRecordContent("卖家确认收货。\n退款成功。");
					ebSalesrecordService.save(ebSalesrecord);

					//判断退款途径，根据不同退款途径更新订单和退款退货状态
					if(ebAftersale.getRefundWay()==1){//退款途径：1、平台退款；2、商家退款；
						//原来是7
						ebAftersale.setRefundStatus(3);//1、待卖家处理；2、卖家已拒绝；3、退款成功；4、关闭退款；5、等待买家退货；6、等待卖家确认收货；7、等待买家确认收款；8、等待卖家退款；9、平台已介入处理；
						ebAftersaleService.save(ebAftersale);
						
						//保存退款退货信息
						EbOrderitem ebOrderitem=ebAftersale.getOrderitem();//订单明细
						ebAftersaleService.saveAftersaleInfo(ebUser, ebAftersale, ebOrderitem, nowTime);
						
						//消息
						EbMessageUser messageInfoUser=new EbMessageUser();
						messageInfoUser.setUserId(ebAftersale.getUserId());
						EbMessage eMessage=new EbMessage();
						eMessage.setCreateTime(new Date());
						eMessage.setCreateUser(""+ebAftersale.getShopId());
						eMessage.setMessageAbstract("退款消息！");
						eMessage.setMessageTitle("退款消息！");
						eMessage.setMessageClass(1);//1、交易物流消息；2、系统消息；3、商家助手；4、御可贡茶公告；
						eMessage.setMessageContent("您收到一笔"+ebAftersale.getDeposit()+"退款");
						eMessage.setMessageIcon("/uploads/drawable-xhdpi/rm.png");
						eMessage.setMessageObjId(ebAftersale.getSaleId());
						eMessage.setMessageType(2);//1、物流消息；2、退款消息；3、角色消息；4、人脉消息；5、系统消息；6、发货提醒；7、 结算提醒；8、退货/售后提醒；9、系统公告；
						ebMessageService.saveflush(eMessage);
						messageInfoUser.setMessageInfo(eMessage);
						messageInfoUser.setState(3);
						messageInfoUser.setUserType(1);
						messageInfoUser.setObjType("2");
						messageInfoUser.setCreateUser(ebUser.getUserId()+"");
						messageInfoUserService.sqlsaveEbMessage(messageInfoUser);
						//推送
						messageInfoUserService.sendMsgJgEbMessageUser(ebAftersale.getUserId(), eMessage);
						
					}else{
						ebAftersale.setRefundStatus(8);
						ebAftersaleService.save(ebAftersale);
					}
					model.addAttribute("aftersale", ebAftersale);
				}
			}
			//return "modules/shop/return-shop";
			request.getSession().setAttribute("shopuser", ebUser);
			return "redirect:/shop/ReturnManagement/ReturnManagementList";
		}
	}
	
	@RequestMapping(value = {"returnPlatform"})
	public String returnPlatform(HttpServletRequest request, HttpServletResponse response,Model model){
		String saleId= request.getParameter("saleId");
		String shopProblemDesc= request.getParameter("shopProblemDesc");
		if(StringUtils.isNotBlank(shopProblemDesc)){
			String shopEvidencePicUrl= request.getParameter("shopEvidencePicUrl");
			EbUser ebUser=(EbUser) request.getSession().getAttribute("shopuser");
			if(ebUser==null){
				model.addAttribute("messager", "登陆失效,请重新登陆");
				return "modules/shop/login2";
			}else {
				EbAftersale ebAftersale=ebAftersaleService.getebAftersale(saleId);
				if(ebAftersale!=null){
					String count=pmReturnGoodInterveneService.getCount(saleId);
					if(count.equals("0")){
						Date nowTime=new Date();
						ebAftersale.setRefundStatus(9);					
						ebAftersale.setUpdateTime(nowTime);
						
						PmReturnGoodIntervene pmReturnGoodIntervene=new PmReturnGoodIntervene();
						pmReturnGoodIntervene.setSaleId(Integer.valueOf(saleId));
						pmReturnGoodIntervene.setShopId(ebUser.getShopId());
						pmReturnGoodIntervene.setShopProblemDesc(shopProblemDesc);
						pmReturnGoodIntervene.setShopSubmitTime(nowTime);
						if(StringUtils.isNotBlank(shopEvidencePicUrl)){
							String[] aStrings=shopEvidencePicUrl.substring(1, shopEvidencePicUrl.length()).replace("|", ",").split(",");
							String imgString="";
							for (int i = 0; i < aStrings.length; i++) {
								if(i<6){
									imgString+=aStrings[i]+",";
								}
							}
							pmReturnGoodIntervene.setShopEvidencePicUrl(imgString);
						}
						pmReturnGoodIntervene.setInterveneStatus(2);
						pmReturnGoodIntervene.setCreateTime(nowTime);
						pmReturnGoodIntervene.setUpdateTime(nowTime);
						
						EbSalesrecord ebSalesrecord=new EbSalesrecord();
						ebSalesrecord.setRecordDate(nowTime);
						ebSalesrecord.setRecordObjType(2);//协商对象类型：1、买家；2、卖家；
						ebSalesrecord.setRecordObjId(ebUser.getShopId());
						ebSalesrecord.setSaleId(Integer.valueOf(saleId));
						ebSalesrecord.setRecordName("");
						ebSalesrecord.setRecordContent("卖家申请了平台客服介入\n"+shopProblemDesc);
						ebSalesrecord.setRecordEvidencePicUrl(pmReturnGoodIntervene.getShopEvidencePicUrl());

						ebAftersaleService.save(ebAftersale);
						ebSalesrecordService.save(ebSalesrecord);
						pmReturnGoodInterveneService.save(pmReturnGoodIntervene);
						model.addAttribute("messager", "申请成功!");
					}else {
						Date nowTime=new Date();
						PmReturnGoodIntervene pmReturnGoodIntervene=pmReturnGoodInterveneService.getSaleId(Integer.valueOf(saleId));
						pmReturnGoodIntervene.setShopId(ebUser.getShopId());
						pmReturnGoodIntervene.setShopProblemDesc(shopProblemDesc);
						pmReturnGoodIntervene.setShopSubmitTime(nowTime);
						if(StringUtils.isNotBlank(shopEvidencePicUrl)){
							String[] aStrings=shopEvidencePicUrl.substring(1, shopEvidencePicUrl.length()).replace("|", ",").split(",");
							String imgString="";
							for (int i = 0; i < aStrings.length; i++) {
								if(i<6){
									imgString+=aStrings[i]+",";
								}
							}
							pmReturnGoodIntervene.setShopEvidencePicUrl(imgString);
						}
						pmReturnGoodIntervene.setInterveneStatus(3);
						pmReturnGoodIntervene.setUpdateTime(nowTime);
						
						EbSalesrecord ebSalesrecord=new EbSalesrecord();
						ebSalesrecord.setRecordDate(nowTime);
						ebSalesrecord.setRecordObjType(2);//协商对象类型：1、买家；2、卖家；
						ebSalesrecord.setRecordObjId(ebUser.getShopId());
						ebSalesrecord.setSaleId(Integer.valueOf(saleId));
						ebSalesrecord.setRecordName("");
						ebSalesrecord.setRecordContent("卖家提交了凭证。\n"+shopProblemDesc);
						ebSalesrecord.setRecordEvidencePicUrl(pmReturnGoodIntervene.getShopEvidencePicUrl());

						ebSalesrecordService.save(ebSalesrecord);
						pmReturnGoodInterveneService.save(pmReturnGoodIntervene);
						model.addAttribute("messager", "提交成功!");
					}
					return "redirect:/shop/ReturnManagement/ReturnManagementForm?id="+saleId;
				}
			}
		}
		createPicFold(request);
		model.addAttribute("saleId", saleId);
		return "modules/shop/return-platform";
	}
	
	@RequestMapping(value = {"refundAgree"})
	public String refundAgree(HttpServletRequest request, HttpServletResponse response,Model model){
		String saleId= request.getParameter("saleId");
		EbUser ebUser=(EbUser) request.getSession().getAttribute("shopuser");
		if(ebUser==null){
			model.addAttribute("messager", "登陆失效,请重新登陆");
			return "modules/shop/login2";
		}else {
			EbAftersale ebAftersale=ebAftersaleService.getebAftersale(saleId);
			if(ebAftersale!=null){
				model.addAttribute("ebAftersale", ebAftersale);
			}
			PmShopDepotAddress pmShopDepotAddress=new PmShopDepotAddress();
			pmShopDepotAddress.setShopId(ebUser.getShopId());
			List<PmShopDepotAddress> pmShopDepotAddressList= pmShopDepotAddressService.getList(pmShopDepotAddress);
			if(CollectionUtils.isNotEmpty(pmShopDepotAddressList)){
				model.addAttribute("pmShopDepotAddressList", pmShopDepotAddressList);
			}
		}
		model.addAttribute("saleId", saleId);
		return "modules/shop/refund-agree";
	}
	
	/**
	 * 创建图片存放目录
	 */
	private void createPicFold(HttpServletRequest request) {
		String root = request.getSession().getServletContext().getRealPath("/");
		StringBuffer folder = new StringBuffer(root);
		folder.append("uploads");
		folder.append(File.separator);
		// ===========集群文件处理 start===============
		String wfsName = Global.getConfig("wfsName");
		if (StringUtils.isNotBlank(wfsName)) {
			folder.append(wfsName);
			folder.append(File.separator);
		}
		String userShopId="";
		// ===========集群文件字段处理 end===============
		if(request.getSession().getAttribute("userShopId")!=null){
			  userShopId = (String)request.getSession().getAttribute("userShopId");
	    }
		 folder.append(userShopId);
		 folder.append(File.separator);
		 folder.append("images");
		 folder.append(File.separator);
		 folder.append(File.separator);
		 folder.append("ebSalesrecordImg");
		 folder.append(File.separator);
		 folder.append(DateUtils.getYear());
		 folder.append(File.separator);
		 folder.append(DateUtils.getMonth());
		 FileUtils.createDirectory(folder.toString());
	}
}