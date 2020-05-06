package com.jq.support.main.controller.shop;

import java.io.File;
import java.io.FileOutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jq.support.model.order.EbOrderitemCharging;
import com.jq.support.model.pay.PmOpenPayWay;
import com.jq.support.model.shop.PmShopUser;
import com.jq.support.service.merchandise.order.*;
import com.jq.support.service.merchandise.shop.PmShopUserService;
import com.jq.support.service.merchandise.user.EbUserService;
import com.jq.support.service.pay.PmOpenPayWayService;
import com.jq.support.service.utils.StringUtil;
import com.jq.support.service.weixin.WeixinSendUtil;
import org.apache.commons.collections.CollectionUtils;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jq.support.common.config.Global;
import com.jq.support.common.persistence.Page;
import com.jq.support.common.utils.StringUtils;
import com.jq.support.common.web.BaseController;
import com.jq.support.model.message.EbMessage;
import com.jq.support.model.message.EbMessageUser;
import com.jq.support.model.order.EbOrder;
import com.jq.support.model.order.EbOrderitem;
import com.jq.support.model.sys.SysDict;
import com.jq.support.model.user.EbUser;
import com.jq.support.service.message.EbMessageService;
import com.jq.support.service.message.EbMessageUserService;
import com.jq.support.service.sys.SysDictService;
import com.jq.support.service.utils.DateUtil;
import com.jq.support.service.utils.HttpTookit;
import com.jq.support.service.utils.SysUserUtils;

@Controller
@RequestMapping(value = "${adShopPath}/PmShopOrders/")
public class PmShopOrders extends BaseController{
	@Autowired
	private EbOrderService ebOrderService;
	@Autowired
	private EbOrderitemService ebOrderitemService;
	@Autowired
	private SysDictService sysDictService;
	@Autowired
	private EbAftersaleService ebAftersaleService;
	@Autowired
	private EbMessageService ebMessageService;
	@Autowired
	private EbMessageUserService ebMessageUserService;
	@Autowired
	private EbOrderLogService ebOrderLogService;
	@Autowired
	private PmShopUserService pmShopUserService;
	@Autowired
	private EbOrderitemChargingService ebOrderitemChargingService;
	@Autowired
	private EbUserService ebUserService;
	@Autowired
	private PmOpenPayWayService pmOpenPayWayService;

	private static String domainurl = Global.getConfig("domainurl");
	
	
	
	
	
	
	
	
	@RequestMapping(value = "list")
	public String  getOrderList(EbOrder ebOrder,HttpServletRequest request, HttpServletResponse response,Model model){
		EbUser ebUser=(EbUser) request.getSession().getAttribute("shopuser");
		String startTime= request.getParameter("startTime");
	    String stopTime= request.getParameter("stopTime");
		String orderNo= request.getParameter("orderNo");
		String iv= request.getParameter("iv");
	    String name= request.getParameter("name");
//		String mobile= request.getParameter("mobile");
		String telphone= request.getParameter("telphone");
	    String status= request.getParameter("status");
	    String payType= request.getParameter("payType");
	    String isEvaluation= request.getParameter("isEvaluation");
	    if(StringUtils.isNotBlank(isEvaluation)){
	    	ebOrder.setIsEvaluation(Integer.parseInt(isEvaluation));
	    }
	    ebOrder.setShopId(ebUser.getShopId());
	    ebOrder.setOrderNo(orderNo);
	    ebOrder.setType(1);
	    if(StringUtils.isNotBlank(status)){
		      ebOrder.setStatus(Integer.parseInt(status));
		      if(StringUtils.isBlank(isEvaluation)){
		    	  if(status.equals("4")){
		    		  iv="0";
		    	  }
		      }
		 }
	    if(StringUtils.isNotBlank(payType)){
	      ebOrder.setPayType(Integer.parseInt(payType));
		}
		ebOrder.setOnoffLineStatus(1);
	    //ebOrder.setMobile(mobile);
	    ebOrder.setTelphone(telphone);
	    Page<EbOrder> page=new Page<EbOrder>();
//	    if(StringUtils.isNotBlank(status)&&status.equals("6")){
//	    	 page =ebAftersaleService.getPageEbOrderPageList(new Page<EbOrder>(request, response), ebUser.getShopId().toString());
//	    }else{
	    	 page =ebOrderService.getShopPageList(new Page<EbOrder>(request, response), ebOrder,name,startTime,stopTime);
//	    }
		for (EbOrder ebOrder2 : page.getList()) {
			EbOrderitem ebOrderitem=new EbOrderitem();
			ebOrderitem.setOrderId(ebOrder2.getOrderId());
	    	List<EbOrderitem> ebOrderitems=	ebOrderitemService.getEbOrderitemList(ebOrderitem);
	    		ebOrder2.setEbOrderitems(ebOrderitems);
		}

		List<EbUser> ebUserList = new ArrayList<EbUser>();

		for(EbOrder e:page.getList()){
			EbUser ebUser1 = ebUserService.getEbUser(e.getUserId().toString());
			ebUserList.add(ebUser1);
		}

		model.addAttribute("page", page);
		model.addAttribute("ebUserList", ebUserList);
		model.addAttribute("isEvaluation", isEvaluation);
	    model.addAttribute("status", status);
	    model.addAttribute("name", name);
	    model.addAttribute("iv", iv);
	    model.addAttribute("payType", payType);
	    model.addAttribute("ebOrder", ebOrder);
	    model.addAttribute("startTime", startTime);
	    model.addAttribute("stopTime", stopTime);
		return "modules/shop/sale-comm";
	}
	
	@RequestMapping(value = "OrderListx")
	public String  getOrderListx(EbOrder ebOrder,HttpServletRequest request, HttpServletResponse response,Model model){
		EbUser ebUser=(EbUser) request.getSession().getAttribute("shopuser");
		String startTime= request.getParameter("startTime");
	    String stopTime= request.getParameter("stopTime");
		String orderNo= request.getParameter("orderNo");
	    String name= request.getParameter("name");
		String mobile= request.getParameter("mobile");
	    String status= request.getParameter("status");
	    String payType= request.getParameter("payType");
	    String iv= request.getParameter("iv");
	    String isEvaluation= request.getParameter("isEvaluation");
	    if(StringUtils.isNotBlank(isEvaluation)){
	    	ebOrder.setIsEvaluation(Integer.parseInt(isEvaluation));
	    }
	    ebOrder.setShopId(ebUser.getShopId());
	    ebOrder.setOrderNo(orderNo);
	    ebOrder.setType(1);
	    if(StringUtils.isNotBlank(status)){
		      ebOrder.setStatus(Integer.parseInt(status));
		      if(StringUtils.isBlank(isEvaluation)){
		    	  if(status.equals("4")){
		    		  iv="0";
		    	  }
		      }
		 }
	    if(StringUtils.isNotBlank(payType)){
	      ebOrder.setPayType(Integer.parseInt(payType));
		}
		ebOrder.setOnoffLineStatus(2);
	    ebOrder.setMobile(mobile);
	    Page<EbOrder> page=new Page<EbOrder>();
	    if(StringUtils.isNotBlank(status)&&status.equals("6")){
	    	 page =ebAftersaleService.getPageEbOrderPageList(new Page<EbOrder>(request, response), ebUser.getShopId().toString());
	    }else{
	    	 page =ebOrderService.getShopPageList(new Page<EbOrder>(request, response), ebOrder,name,startTime,stopTime);
	    }
		for (EbOrder ebOrder2 : page.getList()) {
			EbOrderitem ebOrderitem=new EbOrderitem();
			ebOrderitem.setOrderId(ebOrder2.getOrderId());
	    	List<EbOrderitem> ebOrderitems=	ebOrderitemService.getEbOrderitemList(ebOrderitem);
	    		ebOrder2.setEbOrderitems(ebOrderitems);
		}
		model.addAttribute("payType", payType);
		model.addAttribute("isEvaluation", isEvaluation);
		model.addAttribute("iv", iv);
		model.addAttribute("page", page);
	    model.addAttribute("status", status);
	    model.addAttribute("name", name);
	    model.addAttribute("startTime", startTime);
	    model.addAttribute("stopTime", stopTime);
	    model.addAttribute("ebOrder", ebOrder);
		return "modules/shop/order-Listx";
	}
	@RequestMapping(value = "orderDetail")
	public String  orderDetail(HttpServletRequest request, HttpServletResponse response,Model model) throws Exception{
	    String orderId=request.getParameter("orderId");
	    EbOrder ebOrder1=ebOrderService.OrderDetails(orderId);

		if (ebOrder1 != null) {
			EbOrderitem ebOrderitem = new EbOrderitem();
			ebOrderitem.setOrderId(ebOrder1.getOrderId());
			List<EbOrderitem> ebOrderitems = ebOrderitemService
					.getEbOrderitemList(ebOrderitem);
			if (CollectionUtils.isNotEmpty(ebOrderitems)) {
				ebOrder1.setEbOrderitems(ebOrderitems);

				//根据订单明细查询订单明细规格
				List<List<EbOrderitemCharging>> ebOrderitemChargingList = new ArrayList();
				for (EbOrderitem item :ebOrderitems) {
					List<EbOrderitemCharging> list = ebOrderitemChargingService.getChargingByOrderItemId(item.getOrderitemId());
					ebOrderitemChargingList.add(list);
				}
				model.addAttribute("ebOrderitemChargingList",ebOrderitemChargingList);
			}

			PmOpenPayWay openPayWayByCode = pmOpenPayWayService.getOpenPayWayByCode(ebOrder1.getPayType());
			model.addAttribute("openPayWayByCode",openPayWayByCode);
		}
		EbUser ebUser = ebUserService.getEbUser(ebOrder1.getUserId() + "");

		model.addAttribute("ebUser", ebUser);
	    model.addAttribute("ebOrder", ebOrder1);
		return "modules/shop/order-detail";
	}

	/**
	 * 查询未发货订单列表
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "orderList")
	public String  orderList(HttpServletRequest request, HttpServletResponse response,Model model){
		EbUser ebUser=(EbUser) request.getSession().getAttribute("shopuser");
		String startTime= request.getParameter("startTime");
		String stopTime= request.getParameter("stopTime");
		String orderNo= request.getParameter("orderNo");
		EbOrder ebOrder=new EbOrder();
		ebOrder.setShopId(ebUser.getShopId());
	    ebOrder.setOrderNo(orderNo);
	    ebOrder.setOnoffLineStatus(1);
	    ebOrder.setStatus(2);
	    ebOrder.setDeliveryStatus(0);//配送状态 0：未发送,1：已发送
		Page<EbOrder> page=	ebOrderService.getShopFake(new Page<EbOrder>(request, response),ebOrder.getShopId().toString(),ebOrder,startTime,stopTime);
		if(page.getCount()>0){
			for (EbOrder ebOrder2 : page.getList()) {
				EbOrderitem ebOrderitem=new EbOrderitem();
				ebOrderitem.setOrderId(ebOrder2.getOrderId());
		    	List<EbOrderitem> ebOrderitems=	ebOrderitemService.getEbOrderitemList(ebOrderitem);
		    	ebOrder2.setEbOrderitems(ebOrderitems);
			}
		}
		model.addAttribute("page", page);
	    model.addAttribute("startTime", startTime);
	    model.addAttribute("stopTime", stopTime);
	    model.addAttribute("orderNo", orderNo);
	    model.addAttribute("ebOrder", ebOrder);
		return "modules/shop/shipments";
	}
	
	@RequestMapping(value = "orderfrom")
	public String  orderfrom(HttpServletRequest request, HttpServletResponse response,Model model){
		String orderId=request.getParameter("orderId");
		EbOrder ebOrder=ebOrderService.findid(Integer.valueOf(orderId));
	    if(ebOrder!=null){
	    	EbOrderitem ebOrderitem=new EbOrderitem();
			ebOrderitem.setOrderId(ebOrder.getOrderId());
			List<EbOrderitem>ebOrderitems=ebOrderitemService.getEbOrderitemList(ebOrderitem);
			if(CollectionUtils.isNotEmpty(ebOrderitems)){
				ebOrder.setEbOrderitems(ebOrderitems);
			}
			model.addAttribute("ebOrder", ebOrder);
	    }
	    SysDict sysDict=new SysDict();
	    sysDict.setType("logisticsCompany");
	    sysDict.setDelFlag("0");
	    List<SysDict> dicts=sysDictService.getDicts(sysDict);
	    if(CollectionUtils.isNotEmpty(dicts)){
	    	model.addAttribute("dicts", dicts);
	    }
		return "modules/shop/shipments-detail";
	}
	
	@RequestMapping(value = "logisticsCompany")
	@ResponseBody
	public Map<String , Object>  logisticsCompany(HttpServletRequest request, HttpServletResponse response,Model model){
		Map<String , Object> map=new HashMap<String, Object>();
		SysDict sysDict=new SysDict();
		sysDict.setType("logisticsCompany");
		sysDict.setDelFlag("0");
		List<SysDict> dicts=sysDictService.getDicts(sysDict);
		map.put("dicts", dicts);
		return map;
	}
	
//	@ResponseBody
//	@RequestMapping(value = "userInfoTreeData")
//	public List<Map<String, Object>> userInfoTreeData(String extId,HttpServletResponse response){
//		response.setContentType("application/json; charset=UTF-8");
//		List<Map<String, Object>> mapList = Lists.newArrayList();
//		List<SysDict> list=null;
//		SysDict sysDict=new SysDict();
//		sysDict.setType("logisticsCompany");
//		sysDict.setDelFlag("0");
//		list = sysDictService.getDicts(sysDict);
//		for (int i = 0; i < list.size(); i++) {
//			SysDict e = list.get(i);
//			if (extId == null || (extId != null && !extId.equals(e.getId()))) {
//				Map<String, Object> map = Maps.newHashMap();
//				map.put("id", e.getId());
//				map.put("name", e.getLabel());
//				mapList.add(map);
//			}
//		}
//		return mapList;
//	}
	@RequestMapping(value = "orderedit")
	public String  orderedit(EbOrder updateEborder , HttpServletRequest request, HttpServletResponse response,Model model){
		EbUser ebUser=(EbUser) request.getSession().getAttribute("shopuser");
		EbOrder ebOrder=ebOrderService.findid(updateEborder.getOrderId());

		//判断数据是否正常
		if(ebOrder == null || ebOrder.getStatus() == null || ebOrder.getShippingMethod() == null){
			model.addAttribute("prompt" , "订单数据异常！");

			request.getSession().setAttribute("shopuser", ebUser);
			return "redirect:/shop/PmShopOrders/orderDetail?orderId="+updateEborder.getOrderId();
		}

		EbOrderitem orderitem=new EbOrderitem();
		orderitem.setOrderId(ebOrder.getOrderId());
		orderitem.setIsSend(0);//是否已发货（0 未 1 已发 2已收 3已评价 4已退货 5退货中）
		String img="";
		List<EbOrderitem> ebOrderitem=ebOrderitemService.getEbOrderitemList(orderitem);

		Date nowDate = new Date();

		//自提
		if(ebOrder.getShippingMethod() == 4){
			//未发货
			if(ebOrder.getStatus() == 2){
				ebOrder.setStatus(3);
				ebOrder.setDeliveryStatus(1);
				ebOrder.setSendTime(nowDate);
				ebOrder.setAssignedOpName(ebOrder.getShopName());
				ebOrder.setAssignedStoreOfferSelf(2);
				ebOrder.setLogisticsCompany("该订单由买家自提");

				ebOrderService.save(ebOrder);

				if(CollectionUtils.isNotEmpty(ebOrderitem)){
					for (EbOrderitem send:ebOrderitem) {
//						img=send.getProductImg();
						send.setIsSend(1);
					}
					ebOrderitemService.batchSave(ebOrderitem);
				}

				//保存订单修改
				ebOrderService.save(ebOrder);
				//保存订单日志
				ebOrderLogService.save(nowDate, ebOrder.getOrderId(),
						ebOrder.getOrderNo(), "买家：" + ebOrder.getUserName()
								+ "，收货人：" + ebOrder.getGkuserName()
								+ "，该订单由买家自提", ebOrderitem,
						"系统人员：该订单由买家自提", HttpTookit.getIpAddress(request),
						ebOrder.getType(), ebOrder.getOnoffLineStatus());
				EbUser ebUser1 = ebUserService.getEbUser(ebOrder.getUserId() + "");
				WeixinSendUtil.sendModel4(ebUser.getOpenid(), ebOrder.getDiningNumber() + "", ebOrder.getShopName(), ebOrder.getOrderNo(), new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(ebOrder.getPayTime()), ebUser.getFormId());

			}else{	//已发货
				ebOrderService.DistributionRecords(ebOrder.getOrderId().toString());
				ebOrder.setStatus(4);
				ebOrder.setCompletionTime(nowDate);
				ebOrder.setAssignedStoreOfferSelf(1);
				ebOrder.setAssignedStoreOfferSelfTime(nowDate);

				ebOrderService.save(ebOrder);


				if(CollectionUtils.isNotEmpty(ebOrderitem)){
					for (EbOrderitem send:ebOrderitem) {
//						img=send.getProductImg();
						send.setIsSend(2);
					}
					ebOrderitemService.batchSave(ebOrderitem);
				}

				//保存订单修改
				ebOrderService.save(ebOrder);

				EbUser ebUser2 = ebUserService.getEbUserById(ebOrder
						.getUserId());
				ebUserService.upgradeRoles(ebUser2, "1");
				//保存订单日志
				if (ebUser.getShopShoppingId() == null) {
					ebOrderLogService.save(nowDate, ebOrder.getOrderId(),
							ebOrder.getOrderNo(), "买家：收银端订单"
									+ "，收货人：收银端订单"
									+ "，该订单已被自提", ebOrderitem,
							"系统人员：该订单已被自提", HttpTookit.getIpAddress(request),
							ebOrder.getType(), ebOrder.getOnoffLineStatus());
				}else{
					ebOrderLogService.save(nowDate, ebOrder.getOrderId(),
							ebOrder.getOrderNo(), "买家：" + ebOrder.getUserName()
									+ "，收货人：" + ebOrder.getGkuserName()
									+ "，该订单已被自提", ebOrderitem,
							"系统人员：该订单已被自提", HttpTookit.getIpAddress(request),
							ebOrder.getType(), ebOrder.getOnoffLineStatus());
				}


			}
		}else if(ebOrder.getShippingMethod() == 5){
			//未发货
			if(ebOrder.getStatus() == 2){

				ebOrder.setStatus(3);
				ebOrder.setDeliveryStatus(1);
				ebOrder.setSendTime(nowDate);
				ebOrder.setAssignedOpName(ebOrder.getShopName());
				ebOrder.setAssignedStoreOffer(2);
				//配送人员信息
				ebOrder.setAssignedStorePeople(updateEborder.getAssignedStorePeople());
				ebOrder.setAssignedStorePeoplePhone(updateEborder.getAssignedStorePeoplePhone());

				ebOrderService.save(ebOrder);


				if(CollectionUtils.isNotEmpty(ebOrderitem)){
					for (EbOrderitem send:ebOrderitem) {
						img=send.getProductImg();
						send.setIsSend(1);
					}
					ebOrderitemService.batchSave(ebOrderitem);
				}

				//保存订单修改
				ebOrderService.save(ebOrder);
				//保存订单日志
				ebOrderLogService.save(nowDate, ebOrder.getOrderId(),
						ebOrder.getOrderNo(), "买家：" + ebOrder.getUserName()
								+ "，收货人：" + ebOrder.getGkuserName()
								+ "，该订单由门店派送",
						ebOrderitem, "系统人员：该订单由门店派送", HttpTookit.getIpAddress(request),
						ebOrder.getType(), ebOrder.getOnoffLineStatus());

				//推送
				String projectName = Global.getConfig("projectName");
				sendMessage(ebOrder ,img ,ebUser , "系统人员" ,"配送信息",
							"配送信息","订单已配送！您在"+projectName+"购买的宝贝已配送，请耐心等待！");

			}else{	//已发货
				ebOrderService.DistributionRecords(ebOrder.getOrderId().toString());
				ebOrder.setStatus(4);
				ebOrder.setCompletionTime(nowDate);
				ebOrder.setAssignedStoreOffer(1);
				ebOrder.setAssignedStoreOfferTime(new Date());

				ebOrderService.save(ebOrder);


				if(CollectionUtils.isNotEmpty(ebOrderitem)){
					for (EbOrderitem send:ebOrderitem) {
						img=send.getProductImg();
						send.setIsSend(2);
					}
					ebOrderitemService.batchSave(ebOrderitem);
				}

				//保存订单修改
				ebOrderService.save(ebOrder);

				EbUser ebUser2 = ebUserService.getEbUserById(ebOrder
						.getUserId());
				ebUserService.upgradeRoles(ebUser2, "1");
				//保存订单日志
				ebOrderLogService.save(nowDate, ebOrder.getOrderId(),
						ebOrder.getOrderNo(), "买家：" + ebOrder.getUserName()
								+ "，收货人：" + ebOrder.getGkuserName()
								+ "，该订单已送达", ebOrderitem,
						"系统人员：该订单已送达", HttpTookit.getIpAddress(request),
						ebOrder.getType(), ebOrder.getOnoffLineStatus());

				//推送
				String projectName = Global.getConfig("projectName");
				sendMessage(ebOrder ,img ,ebUser , "系统人员" ,"配送信息",
						"配送信息","订单已送达！您在"+projectName+"购买的宝贝已送达！");

			}
		}else {
			model.addAttribute("prompt" , "配送方式不正确！");

			request.getSession().setAttribute("shopuser", ebUser);
			return "redirect:/shop/PmShopOrders/orderDetail?orderId="+updateEborder.getOrderId();
		}

		request.getSession().setAttribute("shopuser", ebUser);
		return "redirect:/shop/PmShopOrders/orderDetail?orderId="+updateEborder.getOrderId();
	}

	/**
	 * 修改订单状态后推送信息
	 * @param ebOrder
	 * @param img
	 * @param ebUser
	 * @param createUser
	 * @param messageAbstract
	 * @param title
	 * @param content
	 */
	public void sendMessage(EbOrder ebOrder , String img , EbUser ebUser , String createUser
		,String messageAbstract , String title , String content){
		EbMessageUser messageInfoUser=new EbMessageUser();
		messageInfoUser.setUserId(ebOrder.getUserId());
		EbMessage eMessage=new EbMessage();
		eMessage.setCreateTime(new Date());
		eMessage.setCreateUser(ebUser.getUsername());
		eMessage.setCreateUser(createUser);
		eMessage.setMessageAbstract(messageAbstract);
		eMessage.setMessageTitle(title);
		eMessage.setMessageClass(1);
		eMessage.setMessageContent(content);
		eMessage.setMessageIcon(img);
		eMessage.setMessageObjId(ebOrder.getOrderId());
		eMessage.setMessageType(1);
		ebMessageService.saveflush(eMessage);
		messageInfoUser.setMessageInfo(eMessage);
		messageInfoUser.setState(3);
		messageInfoUser.setUserType(1);
		messageInfoUser.setCreateUser(SysUserUtils.getUser().getId());
		ebMessageUserService.sqlsaveEbMessage(messageInfoUser);
		//推送
		try{
			ebMessageUserService.sendMsgJgEbMessageUser(ebOrder.getUserId(), eMessage);
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	@RequestMapping(value = "coderc")
	@ResponseBody
	public String coderc(HttpServletRequest request, HttpServletResponse response) {
		String divid=request.getParameter("divid");
		String shutSel=request.getParameter("shutSel");
		if(StringUtils.isNotBlank(divid)){
		  EbOrder ebOrder=ebOrderService.findid(Integer.parseInt(divid));
		  ebOrder.setStatus(5);
		  ebOrder.setIsBusinessDel(1);
		  ebOrder.setBusinessDelDate(new Date());
		  ebOrder.setBusinessDelReason(shutSel);
		  ebOrderService.save(ebOrder);
		  return "00";
		}
		return "01";
	}
	@SuppressWarnings("deprecation")
	@RequestMapping(value = "exsel")
	@ResponseBody
	public String exsel(HttpServletRequest request, HttpServletResponse response) {
		String url="";
		int t=1;
		int pageNo=1;
		int rowNum=1;
		int rowNums=100;
		HSSFWorkbook wb = new HSSFWorkbook();
		HSSFSheet sheet = wb.createSheet("买家收货信息");
		HSSFRow row = sheet.createRow((int) 0);
		HSSFCellStyle style = wb.createCellStyle();
		style.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 创建一个居中格式
		HSSFCell cell = row.createCell((short) 0);
		cell.setCellStyle(style);
		for (int i = 0; i < 7; i++) {
			cell = row.createCell((short) i);
			if(i==0){
				cell.setCellValue("序号");
			}
			if(i==1){
					cell.setCellValue("订单编号");
			}
			if(i==2){
				cell.setCellValue("买家电话");
			}
			if(i==3){
				cell.setCellValue("收货人");
			}
			if(i==4){
				cell.setCellValue("手机");
			}
			if(i==5){
				cell.setCellValue("收货地址");
			}
			if(i==6){
				cell.setCellValue("买家备注");
			}
			if(i==7){
				cell.setCellValue("发票抬头");
			}
			cell.setCellStyle(style);
		}
		while(t==1){
			EbUser ebUser=(EbUser) request.getSession().getAttribute("shopuser");
			EbOrder ebOrder=new EbOrder();
			ebOrder.setShopId(ebUser.getShopId());
			Page<EbOrder> page=	ebOrderService.getShopFake(new Page<EbOrder>(request, response),ebOrder.getShopId().toString(),ebOrder,"","");
			List<EbOrder> products=new ArrayList<EbOrder>();
			products=page.getList();
			if ((page.getCount() == rowNums && pageNo > 1)|| (page.getCount() / rowNums) < 1 && pageNo > 1) {
					products = null;
			}
			if(products!=null&&products.size()>0){
				for (EbOrder product : products) {
					try {
						row = sheet.createRow((int) rowNum);
						row.createCell((short) 0).setCellValue(rowNum);
					for (int i = 0; i < 7; i++) {
						if(i==1){
							row.createCell((short) i).setCellValue(product.getOrderNo());
						}
						if(i==2){
							row.createCell((short) i).setCellValue(product.getMobile());
						}
						if(i==3){
							row.createCell((short) i).setCellValue(product.getAcceptName());
						}
						if(i==4){
							row.createCell((short) i).setCellValue(product.getTelphone());
						}
						if(i==5){
							row.createCell((short) i).setCellValue(product.getDeliveryAddress());
						}
						if(i==6){
							row.createCell((short) i).setCellValue(product.getPostcode());
						}
						if(i==7){
							row.createCell((short) i).setCellValue(product.getInvoiceTitle());
						}
					}
					} catch (Exception e) {
						System.out.print(e.getCause());
					}
					rowNum++;
				}
				pageNo++;
			}else{
				t=2;
			}
		}
		String RootPath = request.getSession().getServletContext().getRealPath("/").replace("\\", "/");
		String path = "uploads/xlsfile/tempfile";
		Random r = new Random();
		String strfileName = DateUtil.getDateFormat(new Date(),"yyyyMMddHHmmss") + r.nextInt();
		File f = new File(RootPath + path);
		// 不存在则创建它
		if (!f.exists())
			f.mkdirs();
		String tempPath = RootPath + path + "/" + strfileName + ".xls";
		try{
			FileOutputStream fout = new FileOutputStream(tempPath);
			wb.write(fout);
			fout.close();
			url= domainurl+"/" + path + "/" + strfileName + ".xls";
//			url= "http://localhost:8080/sbsc-webmanager"+"/" + path + "/" + strfileName + ".xls";
		}
		catch (Exception e){
			e.printStackTrace();
		}
		return url;
	}
	/**
	 * 订单导出
	 * @param request
	 * @param response
	 * @return
	 */
	@SuppressWarnings("deprecation")
	@RequestMapping(value = "exselOrder")
	@ResponseBody
	public String exselOrder(HttpServletRequest request, HttpServletResponse response) {
		String url="";
		int t=1;
		int pageNo=1;
		int rowNum=1;
		int rowNums=10000;
		EbOrder ebOrder=new EbOrder();
		EbUser ebUser=(EbUser) request.getSession().getAttribute("shopuser");
		String startTime= request.getParameter("startTime");
	    String stopTime= request.getParameter("stopTime");
		String orderNo= request.getParameter("orderNo");
		String iv= request.getParameter("iv");
	    String name= request.getParameter("name");
//		String mobile= request.getParameter("mobile");
		String telphone= request.getParameter("telphone");
	    String status= request.getParameter("status");
	    String payType= request.getParameter("payType");
	    String isEvaluation= request.getParameter("isEvaluation");
	    if(StringUtils.isNotBlank(isEvaluation)){
	    	ebOrder.setIsEvaluation(Integer.parseInt(isEvaluation));
	    }
	    if(StringUtils.isNotBlank(startTime)||StringUtils.isNotBlank(stopTime)){
	    	status="4";
	    }
	    ebOrder.setShopId(ebUser.getShopId());
	    ebOrder.setOrderNo(orderNo);
	    ebOrder.setType(1);
	    if(StringUtils.isNotBlank(status)){
		      ebOrder.setStatus(Integer.parseInt(status));
		      if(StringUtils.isBlank(isEvaluation)){
		    	  if(status.equals("4")){
		    		  iv="0";
		    	  }
		      }
		 }
	    if(StringUtils.isNotBlank(payType)){
	      ebOrder.setPayType(Integer.parseInt(payType));
		}
		ebOrder.setOnoffLineStatus(1);
	    //ebOrder.setMobile(mobile);
	    ebOrder.setTelphone(telphone);
	    Page<EbOrder> page=new Page<EbOrder>();
		HSSFWorkbook wb = new HSSFWorkbook();
		HSSFSheet sheet = wb.createSheet("订单列表");
		HSSFRow row = sheet.createRow((int) 0);
		HSSFCellStyle style = wb.createCellStyle();
		style.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 创建一个居中格式
		HSSFCell cell = row.createCell((short) 0);
		cell.setCellStyle(style);
		for (int i = 0; i < 11; i++) {
			cell = row.createCell((short) i);
			if(i==0){
				cell.setCellValue("序号");
			}
			if(i==1){
					cell.setCellValue("订单编号");
			}
			if(i==2){
				cell.setCellValue("买家电话");
			}
			if(i==3){
				cell.setCellValue("收货人");
			}
			if(i==4){
				cell.setCellValue("手机");
			}
			if(i==5){
				cell.setCellValue("收货地址");
			}
			if(i==6){
				cell.setCellValue("买家备注");
			}
			if(i==7){
				cell.setCellValue("发票抬头");
			}
			if(i==8){
				cell.setCellValue("订单状态");
			}
			if(i==9){
				cell.setCellValue("订单总金额");
			}
			cell.setCellStyle(style);
		}
		while(t==1){
		    if(StringUtils.isNotBlank(status)&&status.equals("6")){
		    	 page =ebAftersaleService.getPageEbOrderPageList(new Page<EbOrder>(rowNum, rowNums), ebUser.getShopId().toString());
		    }else{
		    	 page =ebOrderService.getShopPageList(new Page<EbOrder>(rowNum, rowNums), ebOrder,name,startTime,stopTime);
		    }
			List<EbOrder> products=new ArrayList<EbOrder>();
			products=page.getList();
			if ((page.getCount() == rowNums && pageNo > 1)|| (page.getCount() / rowNums) < 1 && pageNo > 1) {
					products = null;
			}
			if(products!=null&&products.size()>0){
				for (EbOrder product : products) {
					try {
						row = sheet.createRow((int) rowNum);
						row.createCell((short) 0).setCellValue(rowNum);
					for (int i = 0; i < 11; i++) {
						if(i==1){
							row.createCell((short) i).setCellValue(product.getOrderNo());
						}
						if(i==2){
							row.createCell((short) i).setCellValue(product.getMobile());
						}
						if(i==3){
							row.createCell((short) i).setCellValue(product.getAcceptName());
						}
						if(i==4){
							row.createCell((short) i).setCellValue(product.getTelphone());
						}
						if(i==5){
							row.createCell((short) i).setCellValue(product.getDeliveryAddress());
						}
						if(i==6){
							row.createCell((short) i).setCellValue(product.getPostcode());
						}
						if(i==7){
							row.createCell((short) i).setCellValue(product.getInvoiceTitle());
						}
						if(i==8){
							String statusName="";
					    	if(product.getStatus()==1){
					    		statusName="等待买家付款";
					    	}else if(product.getStatus()==2){
					    		statusName="等待发货";
					    	}else if(product.getStatus()==3){
					    		statusName="已发货,待收货";
					    	}else if(product.getStatus()==4){
					    		statusName="交易成功，已完成";
					    	}else if(product.getStatus()==5){
					    		statusName="已关闭；";
					    	}else if(StringUtil.isNotBlank(product.getRefundOrderNo())){
					    		if(product.getStatus() != null && product.getStatus()==6){
									statusName="已退款；";
								}else{
					    			statusName="退款中";
								}
							}
							row.createCell((short) i).setCellValue(statusName);
						}
						if(i==9){
							row.createCell((short) i).setCellValue(product.getOrderAmount());
						}
					}
					} catch (Exception e) {
						System.out.print(e.getCause());
					}
					rowNum++;
				}
				pageNo++;
			}else{
				t=2;
			}
		}
		String RootPath = request.getSession().getServletContext().getRealPath("/").replace("\\", "/");
		String path = "uploads/xlsfile/tempfile";
		Random r = new Random();
		String strfileName = DateUtil.getDateFormat(new Date(),"yyyyMMddHHmmss") + r.nextInt();
		File f = new File(RootPath + path);
		// 不存在则创建它
		if (!f.exists())
			f.mkdirs();
		String tempPath = RootPath + path + "/" + strfileName + ".xls";
		try{
			FileOutputStream fout = new FileOutputStream(tempPath);
			wb.write(fout);
			fout.close();
			url= domainurl+"/" + path + "/" + strfileName + ".xls";
		}
		catch (Exception e){
			e.printStackTrace();
		}
		return url;
	}


	/**
	 * 选择配送人员
	 * @param pmShopUser
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("chooseDeliveryStaff")
	public String chooseDeliveryStaff(Integer chooseShopUserId  ,String chooseName ,String choosePhoneNumber,  PmShopUser pmShopUser ,  Model model , HttpServletRequest request, HttpServletResponse response ){

        pmShopUser.setType(2);
        EbUser ebUser=(EbUser) request.getSession().getAttribute("shopuser");

        Page<PmShopUser> page = pmShopUserService.getEmployees(new Page<PmShopUser>(request, response), pmShopUser);

        if(chooseShopUserId != null && StringUtils.isBlank(chooseName)){
			PmShopUser user = pmShopUserService.getUser(chooseShopUserId);
			chooseName = user != null ? user.getUsername() : "";
			choosePhoneNumber = user != null ? user.getPhoneNumber() : "";
		}
		model.addAttribute("page" , page);
		model.addAttribute("chooseShopUserId" , chooseShopUserId);
		model.addAttribute("chooseName" , chooseName);
		model.addAttribute("choosePhoneNumber" , choosePhoneNumber);
		model.addAttribute("pmShopUser",pmShopUser);

         request.getSession().setAttribute("shopuser",ebUser);
		return "modules/shop/chooseShopUser";
	}
}