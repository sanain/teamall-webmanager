package com.jq.support.main.controller.merchandise.order;

import java.io.File;
import java.io.FileOutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jq.support.model.order.*;
import com.jq.support.model.pay.PmOpenPayWay;
import com.jq.support.service.merchandise.order.*;
import com.jq.support.service.pay.PmOpenPayWayService;
import com.jq.support.service.utils.*;
import net.sf.json.JSONObject;

import org.apache.commons.collections.CollectionUtils;
import org.apache.http.impl.cookie.DateUtils;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFRichTextString;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.authz.annotation.RequiresUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.jq.support.common.config.Global;
import com.jq.support.common.persistence.Page;
import com.jq.support.common.utils.FileUtils;
import com.jq.support.common.utils.StringUtils;
import com.jq.support.common.web.BaseController;
import com.jq.support.model.message.EbMessage;
import com.jq.support.model.message.EbMessageUser;
import com.jq.support.model.pay.Transaction;
import com.jq.support.model.product.PmShopInfo;
import com.jq.support.model.shop.PmShopDepotAddress;
import com.jq.support.model.sys.SysDict;
import com.jq.support.model.sys.SysUser;
import com.jq.support.model.user.EbUser;
import com.jq.support.model.user.PmAmtLog;
import com.jq.support.service.merchandise.product.EbProductService;
import com.jq.support.service.merchandise.shop.PmShopDepotAddressService;
import com.jq.support.service.merchandise.shop.PmShopInfoService;
import com.jq.support.service.merchandise.user.EbUserService;
import com.jq.support.service.merchandise.user.PmAmtLogService;
import com.jq.support.service.message.EbMessageService;
import com.jq.support.service.message.EbMessageUserService;
import com.jq.support.service.pay.TransactionService;
import com.jq.support.service.sys.SysDictService;

@Controller
@RequestMapping(value = "${adminPath}/Order")
public class EbOrderController extends BaseController {

	@Autowired
	private EbOrderService ebOrderService;
	@Autowired
	private PmOrderLoveLogService pmOrderLoveLogService;
	@Autowired
	private EbOrderitemService ebOrderitemService;
	@Autowired
	private PmAmtLogService pmAmtLogService;
	@Autowired
	private PmFrozenLoveLogService frozenLoveLogService;

	@Autowired
	private TransactionService transactionService;
	@Autowired
	private SysDictService sysDictService;
	@Autowired
	private EbOrderLogService ebOrderLogService;
	@Autowired
	private EbMessageService ebMessageService;
	@Autowired
	private EbMessageUserService ebMessageUserService;
	@Autowired
	private EbAftersaleService ebAftersaleService;
	@Autowired
	private EbSalesrecordService ebSalesrecordService;
	@Autowired
	private EbUserService ebUserService;
	@Autowired
	private PmReturnGoodInterveneService pmReturnGoodInterveneService;
	@Autowired
	private PmShopDepotAddressService pmShopDepotAddressService;
	@Autowired
	private EbMessageUserService messageInfoUserService;
	@Autowired
	private PmShopInfoService pmShopInfoService;
	@Autowired
	private EbOrderitemChargingService ebOrderitemChargingService;
	@Autowired
	private EbProductService ebProductService;
	@Autowired
	private PmOpenPayWayService pmOpenPayWayService;

	private static String domainurl = Global.getConfig("domainurl");
	private final SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	private final SimpleDateFormat yyyy = new SimpleDateFormat("yyyy");
	private final SimpleDateFormat MM = new SimpleDateFormat("MM");

	@ModelAttribute
	public EbOrder get(@RequestParam(required = false) String orderId) {
		if (org.apache.commons.lang3.StringUtils.isNotBlank(orderId)) {
			return ebOrderService.findid(Integer.parseInt(orderId));
		} else {
			return new EbOrder();
		}
	}

	@RequiresPermissions("merchandise:Order:view")
	@RequestMapping(value = { "list", "" })
	public String getProductList(EbOrder ebOrder, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		String statrDate = request.getParameter("statrDate");
		String stopDate = request.getParameter("stopDate");
		Page<EbOrder> page = ebOrderService.getPageList(new Page<EbOrder>(
				request, response), ebOrder, statrDate, stopDate);
		model.addAttribute("page", page);
		model.addAttribute("statrDate", statrDate);
		model.addAttribute("stopDate", stopDate);
		model.addAttribute("ebOrder", ebOrder);
		return "modules/shopping/order/orderList";
	}

	@RequestMapping(value = { "invoicelist" })
	public String invoicelist(EbOrder ebOrder, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		String statrDate = request.getParameter("statrDate");
		String stopDate = request.getParameter("stopDate");
		Page<EbOrder> page = ebOrderService.getPageInvoiceList(
				new Page<EbOrder>(request, response), ebOrder, statrDate,
				stopDate);
		model.addAttribute("page", page);
		model.addAttribute("statrDate", statrDate);
		model.addAttribute("stopDate", stopDate);
		model.addAttribute("ebOrder", ebOrder);
		return "modules/shopping/order/invoicelist";
	}

	@RequestMapping(value = { "invoiceform" })
	public String invoiceform(HttpServletRequest request,
			HttpServletResponse response, Model model) {
		String orderId = request.getParameter("orderId");
		EbOrder ebOrder = ebOrderService.getEbOrderById(Integer
				.parseInt(orderId));
		EbOrderitem ebOrderitem = new EbOrderitem();
		ebOrderitem.setOrderId(Integer.parseInt(orderId));
		List<EbOrderitem> ebOrderitemList = ebOrderitemService
				.getEbOrderitemList(ebOrderitem);
		ebOrder.setEbOrderitems(ebOrderitemList);
		model.addAttribute("ebOrder", ebOrder);
		return "modules/shopping/order/invoiceform";
	}

	@RequestMapping(value = { "invoicesave" })
	public String invoicesave(EbOrder ebOrder, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		EbOrder ebOrder1 = ebOrderService.getEbOrderById(ebOrder.getOrderId());
		ebOrder1.setInvoiceTitle(ebOrder.getInvoiceTitle());
		ebOrder1.setInvoicePostEmail(ebOrder.getInvoicePostEmail());
		ebOrder1.setInvoiceStatus(ebOrder.getInvoiceStatus());
		ebOrder1.setInvoicePeopleNo(ebOrder.getInvoicePeopleNo());
		ebOrder1.setInvoiceTime(new Date());
		ebOrderService.save(ebOrder1);
		return "redirect:" + Global.getAdminPath() + "/Order/invoicelist";
	}

	@RequiresPermissions("merchandise:Order:view")
	@RequestMapping(value = { "saleorderlist" })
	public String getSaleList(EbOrder ebOrder, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		String statrDate = request.getParameter("statrDate");
		String stopDate = request.getParameter("stopDate");
		Page<EbOrder> page = ebOrderService.getPageList(new Page<EbOrder>(
				request, response), ebOrder, statrDate, stopDate);
		if (page != null && page.getList() != null)
			for (int i = 0; i < page.getList().size(); i++) {
				EbAftersale ebAftersale = ebAftersaleService.getMaxTime(page
						.getList().get(i).getOrderId());
				page.getList().get(i).setEbAftersale(ebAftersale);
			}

		List<EbUser> ebUserList = new ArrayList<EbUser>();

		for(EbOrder e:page.getList()){
			if(e.getUserId() != null){
				EbUser ebUser1 = ebUserService.getEbUser(e.getUserId().toString());
				if(ebUser1 != null){
					ebUserList.add(ebUser1);
				}else{
					ebUserList.add(new EbUser());
				}
			}else{
				ebUserList.add(new EbUser());
			}


		}

		model.addAttribute("page", page);
		model.addAttribute("ebUserList", ebUserList);
		model.addAttribute("statrDate", statrDate);
		model.addAttribute("stopDate", stopDate);
		model.addAttribute("ebOrder", ebOrder);
		model.addAttribute("shopShoppingFlag",Global.getConfig("shopShoppingFlag"));
		return "modules/shopping/order/saleorder_list";
	}

	@RequiresPermissions("merchandise:Order:view")
	@RequestMapping(value = "listx")
	public String listx(EbOrder ebOrder, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		String statrDate = request.getParameter("statrDate");
		String stopDate = request.getParameter("stopDate");
		Page<EbOrder> page = ebOrderService.getPageXList(new Page<EbOrder>(
				request, response), ebOrder, statrDate, stopDate, "1");
		model.addAttribute("page", page);
		model.addAttribute("statrDate", statrDate);
		model.addAttribute("stopDate", stopDate);
		model.addAttribute("ebOrder", ebOrder);
		return "modules/shopping/order/orderxList";
	}

	@RequiresPermissions("merchandise:Order:view")
	@RequestMapping(value = "lists")
	public String lists(EbOrder ebOrder, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		ebOrder.setOnoffLineStatus(1);
		String statrDate = request.getParameter("statrDate");
		String stopDate = request.getParameter("stopDate");
		Page<EbOrder> page = ebOrderService.getPageList(new Page<EbOrder>(
				request, response), ebOrder, statrDate, stopDate);
		List<EbOrder> ebOrders = page.getList();
		for (EbOrder ebOrder2 : ebOrders) {
			Double sRmoney = 0.0;
			EbOrderitem ebOrderitem = new EbOrderitem();
			ebOrderitem.setOrderId(ebOrder2.getOrderId());
			List<EbOrderitem> ebOrderitems = ebOrderitemService
					.getEbOrderitemList(ebOrderitem);
			for (EbOrderitem ebOrderitem2 : ebOrderitems) {
				sRmoney += (ebOrderitem2.getRealPrice()
						*  CountMoney.getQuantity(ebOrderitem2.getGoodsNums(),ebOrderitem2.getMeasuringType(),ebOrderitem2.getMeasuringUnit())
						* ebOrderitem2.getReturnRatio() / 100);
			}
			ebOrder2.setsRealAmount(sRmoney);
			Double totalLove = pmOrderLoveLogService.sumLoveByOrder(ebOrder2);
			ebOrder2.setTotalLove(totalLove);
		}
		model.addAttribute("statrDate", statrDate);
		model.addAttribute("stopDate", stopDate);
		model.addAttribute("page", page);
		model.addAttribute("ebOrder", ebOrder);
		return "modules/shopping/order/ordersList";
	}

	@RequiresPermissions("merchandise:Order:view")
	@RequestMapping(value = "form")
	public String form(EbOrder ebOrder, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		PmFrozenLoveLog frozenLoveLog = new PmFrozenLoveLog();
		if (ebOrder != null) {
			EbOrderitem ebOrderitem = new EbOrderitem();
			ebOrderitem.setOrderId(ebOrder.getOrderId());
			List<EbOrderitem> orderitems = ebOrderitemService
					.getEbOrderitemList(ebOrderitem);
			ebOrder.setEbOrderitems(orderitems);
			List<PmFrozenLoveLog> pmFrozenLoveLogs = frozenLoveLogService
					.getGlist(ebOrder.getOrderId().toString(), "积分商城模式1-暂缓鑫宝转入");
			if (pmFrozenLoveLogs != null && pmFrozenLoveLogs.size() > 0) {
				frozenLoveLog = pmFrozenLoveLogs.get(0);
			}
		}
		model.addAttribute("frozenLoveLog", frozenLoveLog);
		model.addAttribute("ebOrder", ebOrder);
		return "modules/shopping/order/order-detail";
	}

	@RequiresPermissions("merchandise:Order:view")
	@RequestMapping(value = "saleorderform")
	public String saleOrderform(EbOrder ebOrder, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		PmFrozenLoveLog frozenLoveLog = new PmFrozenLoveLog();
		if (ebOrder != null) {
			EbOrderitem ebOrderitem = new EbOrderitem();
			ebOrderitem.setOrderId(ebOrder.getOrderId());
			List<EbOrderitem> orderitems = ebOrderitemService
					.getEbOrderitemList(ebOrderitem);
			ebOrder.setEbOrderitems(orderitems);
			List<PmFrozenLoveLog> pmFrozenLoveLogs = frozenLoveLogService
					.getGlist(ebOrder.getOrderId().toString(), "积分商城模式1-暂缓鑫宝转入");
			if (pmFrozenLoveLogs != null && pmFrozenLoveLogs.size() > 0) {
				frozenLoveLog = pmFrozenLoveLogs.get(0);
			}

			PmOpenPayWay openPayWayByCode = pmOpenPayWayService.getOpenPayWayByCode(ebOrder.getPayType());
			model.addAttribute("openPayWayByCode",openPayWayByCode);
		}
		model.addAttribute("frozenLoveLog", frozenLoveLog);
		model.addAttribute("ebOrder", ebOrder);
		return "modules/shopping/order/saleorder_detail";
	}

	@RequiresPermissions("merchandise:Order:view")
	@RequestMapping(value = "saleorderdata")
	public String saleOrderdata(EbOrder ebOrder, HttpServletRequest request,
			HttpServletResponse response, Model model) {

		List<Transaction> traList = null;
		if (ebOrder != null) {
			EbOrderitem ebOrderitem = new EbOrderitem();
			ebOrderitem.setOrderId(ebOrder.getOrderId());
			List<EbOrderitem> orderitems = ebOrderitemService
					.getEbOrderitemList(ebOrderitem);
			ebOrder.setEbOrderitems(orderitems);
			traList = transactionService.getTransaction(ebOrder.getOrderId());

			PmOpenPayWay openPayWayByCode = pmOpenPayWayService.getOpenPayWayByCode(ebOrder.getPayType());
			model.addAttribute("openPayWayByCode",openPayWayByCode);
		}

		EbUser ebUser = new EbUser();
		if(ebOrder.getUserId() != null){
			EbUser ebUser1 = ebUserService.getEbUser(ebOrder.getUserId().toString());
			if(ebUser1 != null){
				ebUser = ebUser1;
			}
		}


		model.addAttribute("ebOrder", ebOrder);
		model.addAttribute("ebUser", ebUser);
		model.addAttribute("traList", traList);
		if (traList == null) {
			model.addAttribute("traListsize", 0);
		} else {
			model.addAttribute("traListsize", traList.size());
		}
		model.addAttribute("shopShoppingFlag",Global.getConfig("shopShoppingFlag"));
		return "modules/shopping/order/saleorder_data";
	}

	@RequiresPermissions("merchandise:Order:view")
	@RequestMapping(value = "saleorderemail")
	public String saleOrderemail(EbOrder ebOrder, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		model.addAttribute("ebOrder", ebOrder);
		return "modules/shopping/order/saleorder_email";
	}

	@RequiresPermissions("merchandise:Order:view")
	@RequestMapping(value = "saleorderlog")
	public String saleOrderlog(EbOrder ebOrder, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		model.addAttribute("ebOrder", ebOrder);
		return "modules/shopping/order/saleorder_log";
	}

	@RequiresPermissions("merchandise:Order:view")
	@RequestMapping(value = "saleorderdeliverylog")
	public String saleOrderdeliverylog(EbOrder ebOrder,
			HttpServletRequest request, HttpServletResponse response,
			Model model) throws Exception {
		ebOrder = ebOrderService.OrderDetails(ebOrder.getOrderId() + "");
		model.addAttribute("ebOrder", ebOrder);
		// 反转lists
		if (ebOrder.getBusiness() != null
				&& ebOrder.getBusiness().getTraces() != null)
			Collections.reverse(ebOrder.getBusiness().getTraces());
		return "modules/shopping/order/saleorder_deliverylog";
	}

	@RequiresPermissions("merchandise:Order:view")
	@RequestMapping(value = "saleorderreturngoods")
	public String saleOrderreturngoods(EbOrder ebOrder,
			HttpServletRequest request, HttpServletResponse response,
			Model model) {
		model.addAttribute("ebOrder", ebOrder);
		String saleId = request.getParameter("saleId");
		EbAftersale ebAftersale = ebAftersaleService.getebAftersale(saleId);
		if (ebAftersale != null) {
			EbOrderitem ebOrderitem = new EbOrderitem();
			ebOrderitem.setOrderId(ebAftersale.getOrderId());
			EbAftersale aftersale = new EbAftersale();
			aftersale.setOrderId(ebAftersale.getOrderId());
			Integer aftersaleCount = Integer.valueOf(ebAftersaleService
					.getCount(aftersale));
			Integer oderitemCount = Integer.valueOf(ebOrderitemService
					.getCount(ebOrderitem));
			if (aftersaleCount == oderitemCount) {
				EbAftersale maxtime = ebAftersaleService.getMaxTime(ebAftersale
						.getOrderId());
				Double postage = maxtime.getOrder().getPayableFreight();
				if (ebAftersale.getSaleId().toString()
						.equals(maxtime.getSaleId().toString())) {
					model.addAttribute("postage", postage.toString());
				}
			}
			if (StringUtils.isNotBlank(ebAftersale.getRefundEvidencePicUrl())) {
				String[] aStrings = ebAftersale.getRefundEvidencePicUrl()
						.split(",");
				ebAftersale.setImgList(aStrings);
			}
			EbSalesrecord ebSalesrecord = new EbSalesrecord();
			ebSalesrecord.setSaleId(Integer.valueOf(ebAftersale.getSaleId()
					.toString()));
			List<EbSalesrecord> salesrecords = ebSalesrecordService
					.getEbSalesrecordList(ebSalesrecord, 1);
			if (CollectionUtils.isNotEmpty(salesrecords)) {
				model.addAttribute("salesrecords", salesrecords);
			}
			if (ebAftersale.getUpdateTime() != null) {
				long nowTime = new Date().getTime();
				long createTime = 0;
				if (ebAftersale.getApplicationType() == 1
						&& ebAftersale.getTakeStatus() == 0
						&& ebAftersale.getRefundStatus() == 1) {
					createTime = AllUtils.addDate(ebAftersale.getUpdateTime(),
							5, 2).getTime();
				}
				if (ebAftersale.getApplicationType() == 1
						&& ebAftersale.getTakeStatus() == 1
						&& ebAftersale.getRefundStatus() == 1) {
					createTime = AllUtils.addDate(ebAftersale.getUpdateTime(),
							5, 5).getTime();
				}
				if (ebAftersale.getApplicationType() == 0
						&& ebAftersale.getTakeStatus() == 1
						&& ebAftersale.getRefundStatus() == 1) {
					createTime = AllUtils.addDate(ebAftersale.getUpdateTime(),
							5, 5).getTime();
				}
				if (ebAftersale.getApplicationType() == 0
						&& ebAftersale.getTakeStatus() == 1
						&& ebAftersale.getRefundStatus() == 5) {
					createTime = AllUtils.addDate(ebAftersale.getUpdateTime(),
							5, 7).getTime();
				}
				if (ebAftersale.getApplicationType() == 0
						&& ebAftersale.getTakeStatus() == 1
						&& ebAftersale.getRefundStatus() == 6) {
					createTime = AllUtils.addDate(ebAftersale.getUpdateTime(),
							5, 10).getTime();
				}
				if (ebAftersale.getApplicationType() == 1
						&& ebAftersale.getTakeStatus() == 2
						&& ebAftersale.getRefundStatus() == 1) {
					createTime = AllUtils.addDate(ebAftersale.getUpdateTime(),
							5, 5).getTime();
				}
				if (ebAftersale.getApplicationType() == 1
						&& ebAftersale.getTakeStatus() == 2
						&& ebAftersale.getRefundStatus() == 7) {
					createTime = AllUtils.addDate(ebAftersale.getUpdateTime(),
							5, 3).getTime();
				}
				if (ebAftersale.getApplicationType() == 0
						&& ebAftersale.getTakeStatus() == 2
						&& ebAftersale.getRefundStatus() == 1) {
					createTime = AllUtils.addDate(ebAftersale.getUpdateTime(),
							5, 5).getTime();
				}
				if (ebAftersale.getApplicationType() == 0
						&& ebAftersale.getTakeStatus() == 2
						&& ebAftersale.getRefundStatus() == 5) {
					createTime = AllUtils.addDate(ebAftersale.getUpdateTime(),
							5, 7).getTime();
				}
				if (ebAftersale.getApplicationType() == 0
						&& ebAftersale.getTakeStatus() == 2
						&& ebAftersale.getRefundStatus() == 6) {
					createTime = AllUtils.addDate(ebAftersale.getUpdateTime(),
							5, 10).getTime();
				}
				if (ebAftersale.getApplicationType() == 0
						&& ebAftersale.getTakeStatus() == 2
						&& ebAftersale.getRefundStatus() == 3) {
					createTime = AllUtils.addDate(ebAftersale.getUpdateTime(),
							5, 3).getTime();
				}
				if (ebAftersale.getApplicationType() == 0
						&& ebAftersale.getTakeStatus() == 2
						&& ebAftersale.getRefundStatus() == 2) {
					createTime = AllUtils.addDate(ebAftersale.getUpdateTime(),
							5, 3).getTime();
				}
				if (ebAftersale.getTakeStatus() == 0
						&& ebAftersale.getRefundStatus() == 1) {
					createTime = AllUtils.addDate(ebAftersale.getUpdateTime(),
							5, 2).getTime();
				}
				if (ebAftersale.getTakeStatus() == 1
						&& ebAftersale.getRefundStatus() == 1) {
					createTime = AllUtils.addDate(ebAftersale.getUpdateTime(),
							5, 5).getTime();
				}
				if (ebAftersale.getTakeStatus() == 1
						&& ebAftersale.getRefundStatus() == 5) {
					createTime = AllUtils.addDate(ebAftersale.getUpdateTime(),
							5, 7).getTime();
				}
				if (ebAftersale.getTakeStatus() == 1
						&& ebAftersale.getRefundStatus() == 6) {
					createTime = AllUtils.addDate(ebAftersale.getUpdateTime(),
							5, 10).getTime();
				}
				if (ebAftersale.getTakeStatus() == 2
						&& ebAftersale.getRefundStatus() == 1) {
					createTime = AllUtils.addDate(ebAftersale.getUpdateTime(),
							5, 5).getTime();
				}
				if (ebAftersale.getTakeStatus() == 2
						&& ebAftersale.getRefundStatus() == 5) {
					createTime = AllUtils.addDate(ebAftersale.getUpdateTime(),
							5, 7).getTime();
				}
				if (ebAftersale.getTakeStatus() == 2
						&& ebAftersale.getRefundStatus() == 6) {
					EbUser username = ebUserService.getEbUser(ebAftersale
							.getUserId().toString());
					if (username != null) {
						ebAftersale.setUsermobile(username.getMobile());
					}
					if (StringUtils
							.isNotBlank(ebAftersale.getSendGoodsPicUrl())) {
						String[] aStrings = ebAftersale.getSendGoodsPicUrl()
								.split(",");
						ebAftersale.setImgList(aStrings);
					}
					createTime = AllUtils.addDate(ebAftersale.getUpdateTime(),
							5, 10).getTime();
				}
				if (ebAftersale.getTakeStatus() == 2
						&& ebAftersale.getRefundStatus() == 7) {
					createTime = AllUtils.addDate(ebAftersale.getUpdateTime(),
							5, 3).getTime();
				}
				if (ebAftersale.getTakeStatus() == 2
						&& ebAftersale.getRefundStatus() == 8) {
					createTime = AllUtils.addDate(ebAftersale.getUpdateTime(),
							5, 3).getTime();
				}
				if (ebAftersale.getRefundStatus() == 9) {
					createTime = AllUtils.addDate(ebAftersale.getUpdateTime(),
							5, 3).getTime();
					PmReturnGoodIntervene returnGoodIntervene = pmReturnGoodInterveneService
							.getSaleId(Integer.valueOf(ebAftersale.getSaleId()
									.toString()));
					if (returnGoodIntervene != null) {
						model.addAttribute("returnGoodIntervene",
								returnGoodIntervene);
					}
				}
				long updateTime = createTime - nowTime;
				if (updateTime > 0) {
					model.addAttribute("updateTime", updateTime);
				}
			}
			model.addAttribute("aftersale", ebAftersale);
		}
		model.addAttribute("saleId", saleId);
		return "modules/shopping/order/saleorder_returngoods";
	}

	@ResponseBody
	@RequestMapping(value = { "saveEbAftersale" })
	public Map<String, Object> saveEbAftersale(HttpServletRequest request,
			HttpServletResponse response) {
		String deposit = request.getParameter("deposit");
		String saleId = request.getParameter("saleId");
		String orderId = request.getParameter("orderId");
		EbOrder ebOrder = ebOrderService.findid(Integer.parseInt(orderId));
		Map<String, Object> map = new HashMap<String, Object>();
		EbAftersale ebAftersale = ebAftersaleService.getebAftersale(saleId);
		EbUser ebUser = ebUserService.getShop(ebAftersale.getShopId() + "");
		if (ebAftersale.getMaxDeposit() >= Float.parseFloat(deposit)) {
			ebAftersale.setDeposit(Float.parseFloat(deposit));
			ebAftersaleService.save(ebAftersale);

			EbSalesrecord ebSalesrecord = new EbSalesrecord();
			ebSalesrecord.setRecordDate(new Date());
			ebSalesrecord.setRecordObjType(2);// 协商对象类型：1、买家；2、卖家；3平台
			ebSalesrecord.setRecordObjId(ebUser.getShopId());
			ebSalesrecord.setSaleId(ebAftersale.getSaleId());
			ebSalesrecord.setRecordName("卖家修改了退款金额：￥" + deposit + "（不含运费："
					+ ebOrder.getPayableFreight() + "）");
			ebSalesrecordService.save(ebSalesrecord);

			map.put("code", "00");
		} else {
			map.put("code", "01");
		}
		return map;
	}

	@RequiresPermissions("merchandise:Order:view")
	@RequestMapping(value = { "saleOrderReturnGoodsAgree" })
	public String saleOrderReturnGoodsAgree(EbOrder ebOrder,
			HttpServletRequest request, HttpServletResponse response,
			Model model) {

		String saleId = request.getParameter("saleId");
		EbAftersale ebAftersale = ebAftersaleService.getebAftersale(saleId);
		if (ebAftersale != null) {
			model.addAttribute("aftersale", ebAftersale);
		}
		PmShopDepotAddress pmShopDepotAddress = new PmShopDepotAddress();
		pmShopDepotAddress.setShopId(ebAftersale.getShopId());
		List<PmShopDepotAddress> pmShopDepotAddressList = pmShopDepotAddressService
				.getList(pmShopDepotAddress);
		if (CollectionUtils.isNotEmpty(pmShopDepotAddressList)) {
			model.addAttribute("pmShopDepotAddressList", pmShopDepotAddressList);
		}
		SysDict sysDict = new SysDict();
		sysDict.setType("logisticsCompany");
		sysDict.setDelFlag("0");
		List<SysDict> dicts = sysDictService.getDicts(sysDict);
		if (CollectionUtils.isNotEmpty(dicts)) {
			model.addAttribute("dicts", dicts);
		}
		model.addAttribute("ebOrder", ebOrder);
		model.addAttribute("saleId", saleId);
		return "modules/shopping/order/sale_order_return_goods_agree";
	}

	/**
	 * 同意退款申请
	 * 
	 * @param ebOrder
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "ReturnManagementAffirm")
	public String returnManagementAffirm(EbOrder ebOrder,
			HttpServletRequest request, HttpServletResponse response,
			Model model) throws Exception {
		model.addAttribute("ebOrder", ebOrder);
		String saleId = request.getParameter("saleId");

		EbAftersale ebAftersale = ebAftersaleService.getebAftersale(saleId);
		EbUser ebUser = ebUserService.getShop(ebAftersale.getShopId() + "");
		String expressNumber = request.getParameter("expressNumber");// 退货单号
		String logisticsComCode = request.getParameter("logisticsComCode");// 退货物流公司
		String typeMethod = request.getParameter("typeMethod");// 退货方式 1快递上门
																// 2门店上门 3送至实体店
		String storeName = request.getParameter("storeName");// 指定上门退货门店名字
		String storeId = request.getParameter("storeId");// 指定上门退货门店id
		String returnRemark = request.getParameter("returnRemark");// 退货备注

		String returnStorePeople = request.getParameter("returnStorePeople");// 快递或门店上门取货人信息
		String returnStorePeoplePhone = request
				.getParameter("returnStorePeoplePhone");// 快递或门店上门取货人信息
		String returnGoodAddress = request.getParameter("returnGoodAddress");// 商品返货地址
		String consigneeName = request.getParameter("consigneeName");// 商品返货收货人姓名
		String consigneePhone = request.getParameter("consigneePhone");// 商品返货收货人电话
		String zipCode = request.getParameter("zipCode");// 商品返货邮编号码
		try {
			if (expressNumber != null)
				expressNumber = URLDecoder.decode(expressNumber, "UTF-8");
			if (logisticsComCode != null)
				logisticsComCode = URLDecoder.decode(logisticsComCode, "UTF-8");
			if (typeMethod != null)
				typeMethod = URLDecoder.decode(typeMethod, "UTF-8");
			if (storeName != null)
				storeName = URLDecoder.decode(storeName, "UTF-8");
			if (storeId != null)
				storeId = URLDecoder.decode(storeId, "UTF-8");
			if (returnRemark != null)
				returnRemark = URLDecoder.decode(returnRemark, "UTF-8");
			if (returnStorePeople != null)
				returnStorePeople = URLDecoder.decode(returnStorePeople,
						"UTF-8");
			if (returnStorePeoplePhone != null)
				returnStorePeoplePhone = URLDecoder.decode(
						returnStorePeoplePhone, "UTF-8");
			if (returnGoodAddress != null)
				returnGoodAddress = URLDecoder.decode(returnGoodAddress,
						"UTF-8");
			if (consigneeName != null)
				consigneeName = URLDecoder.decode(consigneeName, "UTF-8");
			if (consigneePhone != null)
				consigneePhone = URLDecoder.decode(consigneePhone, "UTF-8");
			if (zipCode != null)
				zipCode = URLDecoder.decode(zipCode, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if (ebAftersale != null && ebAftersale.getRefundStatus() != null
				&& ebAftersale.getRefundStatus() == 1) {
			EbOrderitem ebOrderitem = ebAftersale.getOrderitem();// 订单明细
			Integer type = ebAftersale.getApplicationType();// 申请类型（0，退货退款,1，退款
															// 2，换货)

			if (type == 0) {// 申请类型（0，退货退款,1，退款 2，换货)
				Date nowTime = new Date();
				ebAftersale.setUpdateTime(nowTime);
				ebAftersale.setRefundStatus(5);// 1、待卖家处理；2、卖家已拒绝；3、退款成功；4、关闭退款；5、等待买家退货；6、等待卖家确认收货；7、等待买家确认收款；8、等待卖家退款；9、平台已介入处理；
				ebAftersale.setUpdateTime(nowTime);
				if ("1".equals(typeMethod)) {// 快递上门退款
					SysDict sysDict = sysDictService.get(logisticsComCode);
					ebAftersale.setLogisticsComCode(sysDict.getValue());
					ebAftersale.setLogisticsCompany(sysDict.getLabel());
					ebAftersale.setTrackCode(expressNumber);
					ebAftersale.setReturnGoodAddress(returnGoodAddress);// 商品返货地址
					ebAftersale.setReturnStorePeople(returnStorePeople);
					ebAftersale
							.setReturnStorePeoplePhone(returnStorePeoplePhone);
					ebAftersale.setConsigneeName(consigneeName);// 商品返货收货人姓名
					ebAftersale.setConsigneePhone(consigneePhone);// 商品返货收货人电话
					ebAftersale.setZipCode(zipCode);// 商品返货邮编号码
					ebAftersale.setReturnGoodsMethod(1);// 快递上门

				} else if ("2".equals(typeMethod)) {// 门店上门退款
					ebAftersale.setReturnGoodsMethod(3);// 上门取件
					ebAftersale.setAssignedOpStoreIsshow(1);// 门店是否可以看见 1可以
					ebAftersale.setAssignedOpName(SysUserUtils.getUser()
							.getName());// 上门取件指派操作人
					ebAftersale.setAssignedOpTime(new Date());// 上门取件指派操作时间

				} else if ("3".equals(typeMethod)) {// 送至自提点
					ebAftersale.setAssignedOpStoreIsshow(1);// 门店是否可以看见 1可以
					ebAftersale.setAssignedOpName(SysUserUtils.getUser()
							.getName());// 上门取件指派操作人
					ebAftersale.setAssignedOpTime(new Date());// 上门取件指派操作时间
				}
				ebAftersale.setReturnRemark(returnRemark);
				// 明细设置退货中状态
				if (ebOrderitem != null) {
					ebOrderitem.setIsSend(5);
					ebOrderitemService.save(ebOrderitem);
				}

				EbSalesrecord ebSalesrecord = new EbSalesrecord();
				ebSalesrecord.setRecordDate(nowTime);
				ebSalesrecord.setRecordObjType(2);// 协商对象类型：1、买家；2、卖家；3平台
				ebSalesrecord.setRecordObjId(ebUser.getShopId());
				ebSalesrecord.setSaleId(ebAftersale.getSaleId());
				ebSalesrecord.setRecordName("卖家同意了退款申请。");
				ebSalesrecord.setRecordContent("卖家同意您的退款申请\n 等待买家退货。");

				ebAftersaleService.save(ebAftersale);
				ebSalesrecordService.save(ebSalesrecord);
				// 发送消息
				ebMessageService.sendAftersaleMessage(ebAftersale);

			}
			if (type == 1) {// 申请类型（0，退货退款,1，退款 2，换货)
				Date nowTime = new Date();
				ebAftersale.setShopId(ebUser.getShopId());
				ebAftersale.setUpdateTime(nowTime);
				/*
				 * if(ebAftersale.getRefundStatus()==1){
				 * ebAftersale.setRefundWay(1); }
				 * if(ebAftersale.getRefundStatus()==8){
				 * ebAftersale.setRefundWay(2); }
				 */
				ebAftersale.setRefundStatus(3);// 1、待卖家处理；2、卖家已拒绝；3、退款成功；4、关闭退款；5、等待买家退货；6、等待卖家确认收货；7、等待买家确认收款；8、等待卖家退款；9、平台已介入处理；
				ebAftersaleService.save(ebAftersale);

				EbSalesrecord ebSalesrecord = new EbSalesrecord();
				ebSalesrecord.setRecordDate(nowTime);
				ebSalesrecord.setRecordObjType(2);// 协商对象类型：1、买家；2、卖家；3平台
				ebSalesrecord.setRecordObjId(ebUser.getShopId());
				ebSalesrecord.setSaleId(ebAftersale.getSaleId());
				ebSalesrecord.setRecordName("卖家同意了退款申请。");
				ebSalesrecord.setRecordContent("卖家同意您的退款申请。\n卖家退款成功,等待买家确认收款。");
				ebSalesrecordService.save(ebSalesrecord);

				// 保存退款退货信息
				ebAftersaleService.saveAftersaleInfo(ebUser, ebAftersale,
						ebOrderitem, nowTime);

				// 发送消息
				ebMessageService.sendAftersaleMessage(ebAftersale);
			}
		}

		return "redirect:" + Global.getAdminPath()
				+ "/Order/saleorderreturngoods?orderId=" + ebOrder.getOrderId()
				+ "&saleId=" + saleId;
	}

	@RequestMapping(value = { "salesrecordlist" })
	public String salesrecordlist(EbOrder ebOrder, HttpServletRequest request,
			HttpServletResponse response, Model model) {

		String saleId = request.getParameter("saleId");
		EbAftersale ebAftersale = ebAftersaleService.getebAftersale(saleId);
		EbSalesrecord ebSalesrecord = new EbSalesrecord();
		ebSalesrecord.setSaleId(ebAftersale.getSaleId());
		List<EbSalesrecord> salesrecords = ebSalesrecordService
				.getEbSalesrecordList(ebSalesrecord, 2);
		if (CollectionUtils.isNotEmpty(salesrecords)) {
			for (EbSalesrecord img : salesrecords) {
				if (img.getRecordContent() != null)
					img.setRecordContent(img.getRecordContent().replace("\n",
							"<br>"));
				if (img.getRecordObjType() == 1) {
					EbUser ebUser = ebUserService.getEbUser(img
							.getRecordObjId().toString());
					if (ebUser != null) {
						img.setRecordObjName(ebUser.getUsername());
						img.setRecordObjImg(ebUser.getAvataraddress());
					}
				}
				if (img.getRecordObjType() == 2) {
					PmShopInfo pmShopInfo = pmShopInfoService
							.getpmPmShopInfo(img.getRecordObjId().toString());
					if (pmShopInfo != null) {
						img.setRecordObjName(pmShopInfo.getShopName());
						img.setRecordObjImg(pmShopInfo.getShopLogo());
					}
				}
				if (StringUtils.isNotBlank(img.getRecordEvidencePicUrl())) {
					String[] aStrings = img.getRecordEvidencePicUrl()
							.split(",");
					img.setImgList(aStrings);
				}
			}
			model.addAttribute("salesrecords", salesrecords);
		}
		createPicFold(request);
		model.addAttribute("saleId", ebAftersale.getSaleId());
		model.addAttribute("ebOrder", ebOrder);
		return "modules/shopping/order/saleorderrefun_history";
	}

	@RequestMapping(value = { "addRecordContent" })
	public String addRecordContent(EbOrder ebOrder, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		model.addAttribute("ebOrder", ebOrder);
		String saleId = request.getParameter("saleId");
		EbAftersale ebAftersale = ebAftersaleService.getebAftersale(saleId);
		String recordContent = request.getParameter("recordContent");
		String recordEvidencePicUrl = request
				.getParameter("recordEvidencePicUrl");
		EbUser ebUser = ebUserService.getShop(ebOrder.getShopId() + "");
		EbSalesrecord ebSalesrecord = new EbSalesrecord();
		Date nowTime = new Date();
		ebSalesrecord.setRecordDate(nowTime);
		ebSalesrecord.setRecordObjType(2);// 协商对象类型：1、买家；2、卖家；3平台
		ebSalesrecord.setRecordObjId(ebUser.getShopId());
		ebSalesrecord.setSaleId(ebAftersale.getSaleId());
		ebSalesrecord.setRecordName("卖家留言");
		ebSalesrecord.setRecordContent("留言内容：" + recordContent);
		if (StringUtils.isNotBlank(recordEvidencePicUrl)) {
			String[] aStrings = recordEvidencePicUrl
					.substring(1, recordEvidencePicUrl.length())
					.replace("|", ",").split(",");
			String imgString = "";
			for (int i = 0; i < aStrings.length; i++) {
				if (i < 6) {
					imgString += aStrings[i] + ",";
				}
			}
			ebSalesrecord.setRecordEvidencePicUrl(imgString);
		}
		ebSalesrecordService.save(ebSalesrecord);
		model.addAttribute("messager", "留言成功!");
		return "redirect:" + Global.getAdminPath()
				+ "/Order/saleorderreturngoods?orderId=" + ebOrder.getOrderId()
				+ "&saleId=" + saleId;
	}

	@RequestMapping(value = "confirmReceipt")
	public String confirmReceipt(EbOrder ebOrder, HttpServletRequest request,
			HttpServletResponse response, Model model)
			throws JsonProcessingException {
		model.addAttribute("ebOrder", ebOrder);
		String saleId = request.getParameter("saleId");
		EbAftersale ebAftersale = ebAftersaleService.getebAftersale(saleId);
		EbUser ebUser = ebUserService.getShop(ebAftersale.getShopId() + "");
		if (ebAftersale != null) {
			Date nowTime = new Date();
			ebAftersale.setUpdateTime(nowTime);

			EbSalesrecord ebSalesrecord = new EbSalesrecord();
			ebSalesrecord.setRecordDate(nowTime);
			ebSalesrecord.setRecordObjType(2);// 协商对象类型：1、买家；2、卖家；3平台
			ebSalesrecord.setRecordObjId(ebUser.getShopId());
			ebSalesrecord.setSaleId(ebAftersale.getSaleId());
			ebSalesrecord.setRecordName("卖家确认收货。");
			ebSalesrecord.setRecordContent("卖家确认收货。\n退款成功。");
			ebSalesrecordService.save(ebSalesrecord);

			// 判断退款途径，根据不同退款途径更新订单和退款退货状态
			if (ebAftersale.getRefundWay() == 1) {// 退款途径：1、平台退款；2、商家退款；
				// 原来是7
				ebAftersale.setRefundStatus(3);// 1、待卖家处理；2、卖家已拒绝；3、退款成功；4、关闭退款；5、等待买家退货；6、等待卖家确认收货；7、等待买家确认收款；8、等待卖家退款；9、平台已介入处理；

				ebAftersaleService.save(ebAftersale);

				// 保存退款退货信息
				EbOrderitem ebOrderitem = ebAftersale.getOrderitem();// 订单明细
				ebAftersaleService.saveAftersaleInfo(ebUser, ebAftersale,
						ebOrderitem, nowTime);

				// 消息
				EbMessageUser messageInfoUser = new EbMessageUser();
				messageInfoUser.setUserId(ebAftersale.getUserId());
				EbMessage eMessage = new EbMessage();
				eMessage.setCreateTime(new Date());
				eMessage.setCreateUser("" + ebAftersale.getShopId());
				eMessage.setMessageAbstract("退款消息！");
				eMessage.setMessageTitle("退款消息！");
				eMessage.setMessageClass(1);// 1、交易物流消息；2、系统消息；3、商家助手；4、御可贡茶公告；
				eMessage.setMessageContent("您收到一笔" + ebAftersale.getDeposit()
						+ "退款");
				eMessage.setMessageIcon("/uploads/drawable-xhdpi/rm.png");
				eMessage.setMessageObjId(ebAftersale.getSaleId());
				eMessage.setMessageType(2);// 1、物流消息；2、退款消息；3、角色消息；4、人脉消息；5、系统消息；6、发货提醒；7、
											// 结算提醒；8、退货/售后提醒；9、系统公告；
				ebMessageService.saveflush(eMessage);
				messageInfoUser.setMessageInfo(eMessage);
				messageInfoUser.setState(3);
				messageInfoUser.setUserType(1);
				messageInfoUser.setCreateUser(SysUserUtils.getUser().getId());
				messageInfoUserService.sqlsaveEbMessage(messageInfoUser);
				// 推送
				messageInfoUserService.sendMsgJgEbMessageUser(
						ebAftersale.getUserId(), eMessage);

			} else {
				ebAftersale.setRefundStatus(8);
				ebAftersaleService.save(ebAftersale);
			}
			model.addAttribute("aftersale", ebAftersale);
		}

		return "redirect:" + Global.getAdminPath()
				+ "/Order/saleorderreturngoods?orderId=" + ebOrder.getOrderId()
				+ "&saleId=" + saleId;
	}

	@RequestMapping(value = { "refundRefusejsp" })
	public String refundRefusejsp(EbOrder ebOrder, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		String saleId = request.getParameter("saleId");
		String recordContent = request.getParameter("recordContent");
		model.addAttribute("ebOrder", ebOrder);
		EbUser ebUser = ebUserService.getShop(ebOrder.getShopId() + "");
		EbAftersale ebAftersale = ebAftersaleService.getebAftersale(saleId);
		createPicFold(request);
		if (StringUtils.isNotBlank(recordContent)) {
			String rejectRefundPicUrl = request
					.getParameter("rejectRefundPicUrl");
			Date nowTime = new Date();

			ebAftersale.setRefundStatus(2);
			if (StringUtils.isNotBlank(recordContent)) {
				ebAftersale.setRejectRefundExplain("理由：" + recordContent);
			} else {
				recordContent = "理由：未填写";
				ebAftersale.setRejectRefundExplain(recordContent);
			}
			if (StringUtils.isNotBlank(rejectRefundPicUrl)) {
				String[] aStrings = rejectRefundPicUrl
						.substring(1, rejectRefundPicUrl.length())
						.replace("|", ",").split(",");
				String imgString = "";
				for (int i = 0; i < aStrings.length; i++) {
					if (i < 6) {
						imgString += aStrings[i] + ",";
					}
				}
				if (StringUtils.isNotBlank(imgString)) {
					imgString = imgString.substring(0, imgString.length() - 1);
					ebAftersale.setRejectRefundPicUrl(imgString);
				}
			}
			ebAftersale.setUpdateTime(nowTime);
			EbSalesrecord ebSalesrecord = new EbSalesrecord();
			ebSalesrecord.setRecordDate(nowTime);
			ebSalesrecord.setRecordObjType(2);// 协商对象类型：1、买家；2、卖家；3平台
			ebSalesrecord.setRecordObjId(ebUser.getShopId());
			ebSalesrecord.setSaleId(ebAftersale.getSaleId());
			ebSalesrecord.setRecordName("卖家拒绝了退款申请。");
			ebSalesrecord.setRecordContent("您拒绝了买家的退款申请。\n理由：" + recordContent);
			ebSalesrecord.setRecordEvidencePicUrl(ebAftersale
					.getRejectRefundPicUrl());
			ebAftersaleService.save(ebAftersale);
			ebSalesrecordService.save(ebSalesrecord);
			// 消息
			EbMessageUser messageInfoUser = new EbMessageUser();
			messageInfoUser.setUserId(ebAftersale.getUserId());
			EbMessage eMessage = new EbMessage();
			eMessage.setCreateTime(new Date());
			eMessage.setCreateUser("" + ebAftersale.getShopId());
			eMessage.setMessageAbstract("退款消息！");
			eMessage.setMessageTitle("退款消息！");
			eMessage.setMessageClass(1);// 1、交易物流消息；2、系统消息；3、商家助手；4、御可贡茶公告；
			eMessage.setMessageContent("卖家拒绝了退款申请。");
			eMessage.setMessageIcon("/uploads/drawable-xhdpi/rm.png");
			eMessage.setMessageObjId(ebAftersale.getSaleId());
			eMessage.setMessageType(2);// 1、物流消息；2、退款消息；3、角色消息；4、人脉消息；5、系统消息；6、发货提醒；7、
										// 结算提醒；8、退货/售后提醒；9、系统公告；
			ebMessageService.saveflush(eMessage);
			messageInfoUser.setMessageInfo(eMessage);
			messageInfoUser.setState(3);
			messageInfoUser.setUserType(1);
			messageInfoUser.setCreateUser(SysUserUtils.getUser().getId());
			messageInfoUserService.sqlsaveEbMessage(messageInfoUser);
			// 推送
			messageInfoUserService.sendMsgJgEbMessageUser(
					ebAftersale.getUserId(), eMessage);
			model.addAttribute("messager", "拒绝成功!");
			return "redirect:" + Global.getAdminPath()
					+ "/Order/saleorderreturngoods?orderId="
					+ ebOrder.getOrderId() + "&saleId=" + saleId;
		}

		model.addAttribute("saleId", saleId);
		return "modules/shopping/order/salerefund_refuse";
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
		folder.append("000000");
		folder.append(File.separator);
		folder.append("images");
		folder.append(File.separator);
		folder.append(File.separator);
		folder.append("ebSalesrecordImg");
		folder.append(File.separator);
		folder.append(com.jq.support.common.utils.DateUtils.getYear());
		folder.append(File.separator);
		folder.append(com.jq.support.common.utils.DateUtils.getMonth());
		FileUtils.createDirectory(folder.toString());
	}

	@RequiresPermissions("merchandise:Order:view")
	@RequestMapping(value = "saleorderdeliverymanager")
	public String saleOrderdeliverymanager(EbOrder ebOrder,
			HttpServletRequest request, HttpServletResponse response,
			Model model) {
		String messageid = request.getParameter("id");

		ebOrder = ebOrderService.findid(ebOrder.getOrderId());
		if (ebOrder != null) {
			EbOrderitem ebOrderitem = new EbOrderitem();
			ebOrderitem.setOrderId(ebOrder.getOrderId());
			List<EbOrderitem> ebOrderitems = ebOrderitemService
					.getEbOrderitemList(ebOrderitem);
			if (CollectionUtils.isNotEmpty(ebOrderitems)) {
				ebOrder.setEbOrderitems(ebOrderitems);

				//根据订单明细查询订单明细规格
				List<List<EbOrderitemCharging>> ebOrderitemChargingList = new ArrayList();
				for (EbOrderitem item :ebOrderitems) {
					List<EbOrderitemCharging> list = ebOrderitemChargingService.getChargingByOrderItemId(item.getOrderitemId());
					ebOrderitemChargingList.add(list);
				}
				model.addAttribute("ebOrderitemChargingList",ebOrderitemChargingList);
			}
			model.addAttribute("ebOrder", ebOrder);
		}
		SysDict sysDict = new SysDict();
		sysDict.setType("logisticsCompany");
		sysDict.setDelFlag("0");
		List<SysDict> dicts = sysDictService.getDicts(sysDict);
		if (CollectionUtils.isNotEmpty(dicts)) {
			model.addAttribute("dicts", dicts);
		}
		if (StringUtils.isNotBlank(messageid)) {
			EbMessage message = ebMessageService.get(Integer
					.parseInt(messageid));
			message.setIsRead(1);
			ebMessageService.saveflush(message);
		}

		return "modules/shopping/order/saleorder_deliverymanager";
	}

	@RequiresPermissions("merchandise:Order:view")
	@RequestMapping(value = "saleorderendreply")
	public String saleOrderendreply(EbOrder ebOrder,
			HttpServletRequest request, HttpServletResponse response,
			Model model) {
		SysDict sysDict = new SysDict();
		sysDict.setId("1");
		sysDict.setLabel("通过");
		SysDict sysDict1 = new SysDict();
		sysDict1.setId("2");
		sysDict1.setLabel("不通过");
		List<SysDict> dicts = new ArrayList<SysDict>();
		dicts.add(sysDict);
		dicts.add(sysDict1);
		model.addAttribute("ebOrder", ebOrder);
		model.addAttribute("dicts", dicts);
		return "modules/shopping/order/saleorder_endreply";
	}



	@RequestMapping(value = "orderedit")
	@Transactional
	public String orderedit(HttpServletRequest request,
			HttpServletResponse response, Model model) throws Exception {
		String orderId = request.getParameter("orderId");
		String expressNumber = request.getParameter("expressNumber");
		String logisticsComCode = request.getParameter("logisticsComCode");
		String storeId = request.getParameter("assignedStoreId");
		String assignedRemark = request.getParameter("assignedRemark");
		String splitContent = request.getParameter("splitContent");
		String cx = request.getParameter("cx");// 1为修改
		if ("1".equals(cx)) {
			storeId = request.getParameter("assignedStoreId1");
			logisticsComCode = request.getParameter("logisticsComCodet");
		}
		EbOrder ebOrder = ebOrderService.findid(Integer.valueOf(orderId));
		if (ebOrder != null) {
			Date nowDate = new Date();
			if (StringUtils.isNotBlank(expressNumber)
					|| StringUtils.isNotBlank(splitContent)) {
				if ("1".equals(cx)) {
					// 重新发货清空仓库信息
					ebOrder.setWarehouseId(null);
					ebOrder.setWarehouseRemark(null);
					ebOrder.setWareNo(null);
					ebOrder.setWareName(null);
					ebOrder.setWareOptionTime(null);
					// 重新发货清空门店信息
					ebOrder.setStoreName(null);
					ebOrder.setStoreBanner(null);
					ebOrder.setStoreAddr(null);
					ebOrder.setStoreLongitude(null);
					ebOrder.setStoreLatitude(null);
					ebOrder.setStoreBusinessTime(null);
					ebOrder.setStorePhone(null);
					ebOrder.setAssignedOpName(null);
					ebOrder.setAssignedRemark(null);
					ebOrder.setAssignedStoreId(null);
					ebOrder.setIsSplitOrder(null); // 拆分订单 1.表示拆分 0或null表示未拆分
				}

				String img = "";
				List<EbOrderitem> ebOrderitem = new ArrayList<EbOrderitem>();
				SysDict sysDict = new SysDict();
				if (StringUtils.isNotBlank(splitContent)) { // 拆分物流
					String content[] = splitContent.split(",");
					System.out.println(content.length);

					for (int i = 0; i < content.length; i++) {
						String singles = content[i];
						String single[] = singles.split("-");
						sysDict = sysDictService.get(single[1]);
						if (sysDict != null) {
							EbOrderitem orderitem = ebOrderitemService
									.findid(Integer.parseInt(single[0]));
							if (orderitem != null) {
								img = orderitem.getProductImg();
								orderitem.setIsSend(1);// 是否已发货（0 未 1 已发 2已收
														// 3已评价 4已退货 5退货中）
								orderitem.setExpressNumber(single[2]);
								orderitem.setLogisticsComCode(sysDict
										.getValue());
								orderitem.setLogisticsCompany(sysDict
										.getLabel());
								ebOrderitemService.save(orderitem);
								ebOrderitem.add(orderitem);
							}

						}

					}
					ebOrder.setIsSplitOrder(1); // 拆分订单 1.表示拆分 0或null表示未拆分
				}

				if (StringUtils.isNotBlank(expressNumber)) {
					sysDict = sysDictService.get(logisticsComCode);
					if (sysDict != null) {
						EbOrderitem orderitem = new EbOrderitem();
						orderitem.setOrderId(ebOrder.getOrderId());
						orderitem.setIsSend(0);// 是否已发货（0 未 1 已发 2已收 3已评价 4已退货
												// 5退货中）
						orderitem.setExpressNumber(expressNumber);
						ebOrderitem = ebOrderitemService
								.getEbOrderitemList(orderitem);
						if (CollectionUtils.isNotEmpty(ebOrderitem)) {
							for (EbOrderitem send : ebOrderitem) {
								img = send.getProductImg();
								send.setIsSend(1);
								ebOrderitemService.save(send);
							}
						}

					}

				}
				ebOrder.setStatus(3);
				ebOrder.setDeliveryStatus(1);
				ebOrder.setSendTime(nowDate);
				ebOrder.setExpressNumber(expressNumber);
				ebOrder.setLogisticsComCode(sysDict.getValue());
				ebOrder.setLogisticsCompany(sysDict.getLabel());
				ebOrder.setShippingMethod(1);
				ebOrderService.save(ebOrder);
				ebOrderLogService.save(nowDate, ebOrder.getOrderId(),
						ebOrder.getOrderNo(), "买家：" + ebOrder.getUserName()
								+ ",收货人：" + ebOrder.getGkuserName() + "，物流公司："
								+ ebOrder.getLogisticsCompany() + "，物流单号："
								+ ebOrder.getExpressNumber(), ebOrderitem,
						"系统人员：物流发货", HttpTookit.getIpAddress(request),
						ebOrder.getType(), ebOrder.getOnoffLineStatus());
				EbMessageUser messageInfoUser = new EbMessageUser();
				messageInfoUser.setUserId(ebOrder.getUserId());
				EbMessage eMessage = new EbMessage();
				eMessage.setCreateTime(new Date());
				eMessage.setCreateUser("系统人员");
				eMessage.setMessageAbstract("物流消息");
				eMessage.setMessageTitle("物流消息");
				eMessage.setMessageClass(1);
				String projectName = Global.getConfig("projectName");
				eMessage.setMessageContent("订单已发货！您在"+projectName+"门店购买的宝贝已经发货啦，请耐心等待！");
				eMessage.setMessageIcon(img);
				eMessage.setMessageObjId(ebOrder.getOrderId());
				eMessage.setMessageType(1);
				ebOrder.setShippingMethod(1);
				ebMessageService.saveflush(eMessage);
				messageInfoUser.setMessageInfo(eMessage);
				messageInfoUser.setState(3);
				messageInfoUser.setUserType(1);
				messageInfoUser.setCreateUser(SysUserUtils.getUser().getId());
				ebMessageUserService.sqlsaveEbMessage(messageInfoUser);
				// 推送
				try {
					ebMessageUserService.sendMsgJgEbMessageUser(
							ebOrder.getUserId(), eMessage);
				} catch (Exception e) {
					e.printStackTrace();
				}
				ebOrderService.save(ebOrder);
			} else {
				if (StringUtils.isNotBlank(storeId)) {// 门店派送

					ebOrder.setWarehouseId(null);
					ebOrder.setWarehouseRemark(null);
					ebOrder.setWareNo(null);
					ebOrder.setWareName(null);
					ebOrder.setWareOptionTime(null);
					
					if (StringUtils.isNotBlank(ebOrder.getExpressNumber())||(ebOrder.getIsSplitOrder()!=null&&ebOrder.getIsSplitOrder()==1)) {
						EbOrderitem orderitem = new EbOrderitem();
						orderitem.setOrderId(ebOrder.getOrderId());
						orderitem.setIsSend(1);// 是否已发货（0 未 1 已发 2已收 3已评价 4已退货
												// 5退货中）
						List<EbOrderitem> ebOrderitem = ebOrderitemService
								.getEbOrderitemList(orderitem);
						if (CollectionUtils.isNotEmpty(ebOrderitem)) {
							for (EbOrderitem send : ebOrderitem) {
								send.setIsSend(0);
								send.setExpressNumber(null);
								// 3已评价 4已退货 5退货中）
								orderitem.setLogisticsComCode(null);
								orderitem.setLogisticsCompany(null);
								ebOrderitemService.save(send);
							}
						}
						ebOrder.setSendTime(null);
						ebOrder.setExpressNumber(null);
						ebOrder.setLogisticsComCode(null);
						ebOrder.setLogisticsCompany(null);
						ebOrder.setIsSplitOrder(null); // 拆分订单 1.表示拆分 0或null表示未拆分
					}
					ebOrder.setStatus(2);
					ebOrder.setDeliveryStatus(1);
					/* ebOrder.setSendTime(nowDate); */
					ebOrder.setAssignedOpTime(new Date());
					ebOrder.setAssignedOpName(SysUserUtils.getUser().getId());
					ebOrder.setAssignedRemark(assignedRemark);
					ebOrder.setAssignedStoreId(Integer.parseInt(storeId));
					ebOrder.setShippingMethod(5);
					ebOrderService.save(ebOrder);
					EbOrderitem orderitem = new EbOrderitem();
					orderitem.setOrderId(ebOrder.getOrderId());
					orderitem.setIsSend(0);// 是否已发货（0 未 1 已发 2已收 3已评价 4已退货 5退货中）

					List<EbOrderitem> ebOrderitem = ebOrderitemService
							.getEbOrderitemList(orderitem);// 订单查询详细
					ebOrderLogService.save(nowDate, ebOrder.getOrderId(),
							ebOrder.getOrderNo(), "买家：" + ebOrder.getUserName()
									+ "，收货人：" + ebOrder.getGkuserName()
									+ "，该订单由门店派送",
							ebOrderitem, "系统人员：该订单由门店派送", HttpTookit.getIpAddress(request),
							ebOrder.getType(), ebOrder.getOnoffLineStatus());


				} else {// 买家自提
					EbOrderitem orderitem = new EbOrderitem();
					orderitem.setOrderId(ebOrder.getOrderId());
					orderitem.setIsSend(0);// 是否已发货（0 未 1 已发 2已收 3已评价 4已退货 5退货中）
					List<EbOrderitem> ebOrderitem = ebOrderitemService
							.getEbOrderitemList(orderitem);
					if (CollectionUtils.isNotEmpty(ebOrderitem)) {
						for (EbOrderitem send : ebOrderitem) {
							send.setIsSend(1);
							ebOrderitemService.save(send);
						}
					}
					ebOrder.setStatus(3);
					ebOrder.setDeliveryStatus(1);
					ebOrder.setShippingMethod(4);
					ebOrder.setSendTime(nowDate);
					// ebOrder.setExpressNumber("");
					// ebOrder.setLogisticsComCode("");
					ebOrder.setLogisticsCompany("该订单由买家自提");
					ebOrderService.save(ebOrder);
					ebOrderLogService.save(nowDate, ebOrder.getOrderId(),
							ebOrder.getOrderNo(), "买家：" + ebOrder.getUserName()
									+ "，收货人：" + ebOrder.getGkuserName()
									+ "，该订单由买家自提", ebOrderitem,
							"系统人员：该订单由买家自提", HttpTookit.getIpAddress(request),
							ebOrder.getType(), ebOrder.getOnoffLineStatus());
				}

			}

		}
		return "redirect:" + Global.getAdminPath()
				+ "/Order/saleorderdeliverymanager?orderId="
				+ ebOrder.getOrderId();
	}



	@RequiresPermissions("merchandise:AfterSale:view")
	@RequestMapping(value = { "saleorderAftersalelist" })
	public String aftersalelist(EbAftersale ebAftersale,
			HttpServletRequest request, HttpServletResponse response,
			Model model) {
		String shopId = request.getParameter("shopId");
		String saleNo = request.getParameter("saleNo");
		String orderId = request.getParameter("orderId");
		String applicationType = request.getParameter("applicationType");
		String refundStatus = request.getParameter("refundStatus");
		String messageid = request.getParameter("id");
		if (StringUtils.isNotEmpty(shopId)) {
			ebAftersale.setShopId(Integer.valueOf(shopId));
		}
		if (StringUtils.isNotEmpty(applicationType)) {
			ebAftersale.setApplicationType(Integer.parseInt(applicationType));
		}
		if (StringUtils.isNotEmpty(refundStatus)) {
			ebAftersale.setRefundStatus(Integer.parseInt(refundStatus));
		}
		if (StringUtils.isNotEmpty(saleNo)) {
			ebAftersale.setSaleNo(saleNo);
		}

		if (StringUtils.isNotEmpty(orderId)) {
			ebAftersale.setOrderId(Integer.parseInt(orderId));
		}
		String orderNo = request.getParameter("orderNo");
		String mobileNo = request.getParameter("mobileNo");
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		Page<EbAftersale> page = ebAftersaleService.pageEbAftersaleList(
				ebAftersale, orderNo, mobileNo, startTime, endTime,
				new Page<EbAftersale>(request, response));
		List<EbAftersale> list = page.getList();
		if(list != null && list.size() >0){
			for(int i = 0 ; i < list.size() ; i++){
				EbOrderitem ebOrderitem = new EbOrderitem();
				ebOrderitem.setOrderId(list.get(i).getOrderId());
				EbAftersale aftersale = new EbAftersale();
				aftersale.setOrderId(list.get(i).getOrderId());
				Integer aftersaleCount = Integer.valueOf(ebAftersaleService
						.getCount(aftersale));
				Integer oderitemCount = Integer.valueOf(ebOrderitemService
						.getCount(ebOrderitem));
				if (aftersaleCount == oderitemCount) {
					EbAftersale maxtime = ebAftersaleService.getMaxTime(list.get(i)
							.getOrderId());
					Double postage = maxtime.getOrder().getPayableFreight();
					if (list.get(i).getSaleId().toString()
							.equals(maxtime.getSaleId().toString())) {
						list.get(i).setRealFreight(Double.parseDouble(postage.toString()));
					}
				}
			}
		}
		page.setList(list);
		model.addAttribute("page", page);
		model.addAttribute("shopId", shopId);
		model.addAttribute("saleNo", saleNo);
		model.addAttribute("applicationType", applicationType);
		model.addAttribute("refundStatus", refundStatus);

		if (StringUtils.isNotBlank(messageid)) {
			EbMessage message = ebMessageService.get(Integer
					.parseInt(messageid));
			message.setIsRead(1);
			ebMessageService.saveflush(message);
		}

		return "modules/shopping/order/saleorderAftersalelist";
	}

	@RequestMapping(value = "ordereditendReply")
	@Transactional
	public String ordereditendReply(HttpServletRequest request,
			HttpServletResponse response, Model model) {
		String orderId = request.getParameter("orderId");
		String endReply = request.getParameter("endReply");
		String endReplyRemark = request.getParameter("endReplyRemark");
		ebOrderService.saveFlush(Integer.parseInt(endReply), endReplyRemark,
				Integer.valueOf(orderId));
		return "redirect:" + Global.getAdminPath()
				+ "/Order/saleorderendreply?orderId=" + orderId;
	}

	/**
	 * 更新收货人信息
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequiresPermissions("merchandise:Order:view")
	@ResponseBody
	@RequestMapping(value = "userSave")
	public String userSave(HttpServletRequest request,
			HttpServletResponse response) {
		String orderId = request.getParameter("orderId");
		String content = request.getParameter("content");
		String type = request.getParameter("type");
		String acceptName = null, acceptEmail = null, telphone = null;
		String data = "00";
		if ("1".equals(type)) {
			acceptName = content;
		} else if ("2".equals(type)) {
			acceptEmail = content;
		} else if ("3".equals(type)) {
			telphone = content;
		} else {
			data = "无数据类型";
			return data;
		}

		ebOrderService.saveFlush(acceptName, acceptEmail, telphone,
				Integer.parseInt(orderId));
		return data;
	}

	@RequiresPermissions("merchandise:Order:view")
	@RequestMapping(value = "fenpei")
	public String fenpei(EbOrder ebOrder, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		List<PmAmtLog> pmAmtLog = pmAmtLogService.getshopList(ebOrder
				.getOrderId());
		PmOrderLoveLog pmOrderLoveLog = new PmOrderLoveLog();
		pmOrderLoveLog.setOrderId(ebOrder.getOrderId());
		List pmOrderLoveLogs = pmOrderLoveLogService.getSqlList(pmOrderLoveLog,
				ebOrder.getOnoffLineStatus().toString(), ebOrder.getType());
		model.addAttribute("pmOrderLoveLogs", pmOrderLoveLogs);
		model.addAttribute("pmAmtLog", pmAmtLog);
		return "modules/shopping/order/fenpei";
	}

	/**
	 * 线下订单图片
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequiresPermissions("merchandise:Order:view")
	@ResponseBody
	@RequestMapping(value = "listximgs")
	public String listximgs(HttpServletRequest request,
			HttpServletResponse response) {
		String orderId = request.getParameter("id");

		String data = "";
		JSONObject json = new JSONObject();
		Boolean flag = false;
		String imgs = "";
		if (StringUtils.isNotBlank(orderId)) {
			EbOrder ebOrder = ebOrderService.getEbOrderById(Integer
					.valueOf(orderId));
			if (ebOrder != null) {
				if (StringUtils.isNotBlank(ebOrder.getOrderEvidencePicUrl())) {
					imgs = ebOrder.getOrderEvidencePicUrl();
					flag = true;
				}
			}
		}

		json.put("flag", flag);
		json.put("imgs", imgs);
		data = json.toString();
		return data;
	}

	@SuppressWarnings("deprecation")
	@ResponseBody
	@RequestMapping(value = "exsel")
	public String exsel(HttpServletRequest request, HttpServletResponse response) {
		String url = "";
		String syllable[] = request.getParameterValues("syllable");
		String payStatus = request.getParameter("payStatus");
		String orderNo = request.getParameter("orderNo");
		String status = request.getParameter("status");
		String onoffLineStatus = request.getParameter("onoffLineStatus");
		if (syllable != null && syllable.length > 0) {
			int t = 1;
			int pageNo = 1;
			int rowNum = 1;
			int rowNums = 100000;
			HSSFWorkbook wb = new HSSFWorkbook();
			HSSFSheet sheet = wb.createSheet("订单列表");
			HSSFRow row = sheet.createRow((int) 0);
			HSSFCellStyle style = wb.createCellStyle();
			style.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 创建一个居中格式
			HSSFCell cell = row.createCell((short) 0);
			cell.setCellValue("序号");
			cell.setCellStyle(style);
			for (int i = 0; i < syllable.length; i++) {
				cell = row.createCell((short) i);
				if (syllable[i].equals("1")) {
					cell.setCellValue("门店名称");
				}
				if (syllable[i].equals("2")) {
					cell.setCellValue("订单总金额");
				}
				if (syllable[i].equals("3")) {
					cell.setCellValue("运费");
				}
				if (syllable[i].equals("4")) {
					cell.setCellValue("买家信息");
				}
				if (syllable[i].equals("5")) {
					cell.setCellValue("订单状态");
				}
				if (syllable[i].equals("6")) {
					cell.setCellValue("支付状态");
				}
				if (syllable[i].equals("7")) {
					cell.setCellValue("下单时间");
				}
				if (syllable[i].equals("8")) {
					cell.setCellValue("付款时间");
				}
				if (syllable[i].equals("9")) {
					cell.setCellValue("结束时间");
				}
				if (syllable[i].equals("10")) {
					cell.setCellValue("收货地址");
				}
				if (syllable[i].equals("11")) {
					cell.setCellValue("买家留言");
				}
				if (syllable[i].equals("12")) {
					cell.setCellValue("发票抬头");
				}
				if (syllable[i].equals("13")) {
					cell.setCellValue("订单编号");
				}
				if (syllable[i].equals("14")) {
					cell.setCellValue("门店让利比");
				}
				if (syllable[i].equals("15")) {
					cell.setCellValue("订单类型");
				}
				if (syllable[i].equals("16")) {
					cell.setCellValue("快递编号");
				}
				if (syllable[i].equals("17")) {
					cell.setCellValue("物流公司");
				}
				if (syllable[i].equals("18")) {
					cell.setCellValue("订单商品(注:商品名称/规格/单价/数量/获得积分数)");
				}
				cell.setCellStyle(style);
			}
			SysUser currentUser = SysUserUtils.getUser();
			while (t == 1) {
				String statrDate = request.getParameter("statrDate");
				String s = request.getParameter("s");
				String stopDate = request.getParameter("stopDate");
				String types = request.getParameter("type");
				EbOrder ebOrde = new EbOrder();
				if (StringUtils.isNotBlank(payStatus)) {
					ebOrde.setPayStatus(Integer.parseInt(payStatus));
				}
				if (StringUtils.isNotBlank(status)) {
					ebOrde.setStatus(Integer.parseInt(status));
				}
				if (StringUtils.isNotBlank(orderNo)) {
					ebOrde.setOrderNo(orderNo);
				}
				if (StringUtils.isNotBlank(onoffLineStatus)) {
					ebOrde.setOnoffLineStatus(Integer.parseInt(onoffLineStatus));
				}
				if (StringUtils.isNotBlank(types)) {
					ebOrde.setType(Integer.parseInt(types));
				}
				Page<EbOrder> page = ebOrderService.getPageXList(
						new Page<EbOrder>(pageNo, rowNums), ebOrde, statrDate,
						stopDate, s);
				List<EbOrder> ebOrders = new ArrayList<EbOrder>();
				ebOrders = page.getList();
				if ((page.getCount() == rowNums && pageNo > 1)
						|| (page.getCount() / rowNums) < 1 && pageNo > 1) {
					ebOrders = null;
				}
				if (ebOrders != null && ebOrders.size() > 0) {
					for (EbOrder ebOrder : ebOrders) {
						try {
							// SmsUserblacklist
							// userblacklist=smsUserblacklists.get(i);
							row = sheet.createRow((int) rowNum);
							row.createCell((short) 0).setCellValue(rowNum);
							for (int i = 0; i < syllable.length; i++) {
								if (syllable[i].equals("1")) {
									if (StringUtils.isNotBlank(ebOrder
											.getShopName())) {
										row.createCell((short) i).setCellValue(
												ebOrder.getShopName());
									} else {
										row.createCell((short) i).setCellValue(
												"");
									}
								}
								if (syllable[i].equals("2")) {
									row.createCell((short) i).setCellValue(
											ebOrder.getOrderAmount());
								}
								if (syllable[i].equals("3")) {
									row.createCell((short) i).setCellValue(
											ebOrder.getRealFreight());
								}
								if (syllable[i].equals("4")) {
									if (StringUtils.isNotBlank(ebOrder
											.getMobile())) {
										row.createCell((short) i).setCellValue(
												ebOrder.getMobile());
									} else {
										row.createCell((short) i).setCellValue(
												"");
									}

								}
								if (syllable[i].equals("5")) {
									String statusName = "";
									if (ebOrder.getStatus() == 1) {
										statusName = "等待买家付款";
									} else if (ebOrder.getStatus() == 2) {
										statusName = "等待发货";
									} else if (ebOrder.getStatus() == 3) {
										statusName = "已发货,待收货";
									} else if (ebOrder.getStatus() == 4) {
										statusName = "交易成功，已完成";
									} else if (ebOrder.getStatus() == 5) {
										statusName = "已关闭；";
									}else if(StringUtil.isNotBlank(ebOrder.getRefundOrderNo())){
										if(ebOrder.getStatus() != null && ebOrder.getStatus()==6){
											statusName="已退款；";
										}else{
											statusName="退款中";
										}
									}
									row.createCell((short) i).setCellValue(
											statusName);
								}
								if (syllable[i].equals("6")) {
									/** 支付状态 0：未支付; 1：已支付; */
									String PayStatus = "";
									if (ebOrder.getPayStatus() == 0) {
										PayStatus = "未支付";
									} else if (ebOrder.getPayStatus() == 1) {
										PayStatus = "已支付";
									}
									row.createCell((short) i).setCellValue(
											PayStatus);
								}
								if (syllable[i].equals("7")) {
									if (ebOrder.getCreateTime() != null) {
										row.createCell((short) i)
												.setCellValue(
														DateUtil.convertDateToString(ebOrder
																.getCreateTime()));
									} else {
										row.createCell((short) i).setCellValue(
												"");
									}
								}
								if (syllable[i].equals("8")) {
									if (ebOrder.getPayTime() != null) {
										row.createCell((short) i)
												.setCellValue(
														DateUtil.convertDateToString(ebOrder
																.getPayTime()));
									} else {
										row.createCell((short) i).setCellValue(
												"");
									}
								}
								if (syllable[i].equals("9")) {
									if (ebOrder.getCompletionTime() != null) {
										row.createCell((short) i)
												.setCellValue(
														DateUtil.convertDateToString(ebOrder
																.getCompletionTime()));
									} else {
										row.createCell((short) i).setCellValue(
												"");
									}

								}
								if (syllable[i].equals("10")) {
									row.createCell((short) i).setCellValue(
											ebOrder.getDeliveryAddress());
								}
								if (syllable[i].equals("11")) {
									row.createCell((short) i).setCellValue(
											ebOrder.getPostscript());
								}
								if (syllable[i].equals("13")) {
									row.createCell((short) i).setCellValue(
											new HSSFRichTextString(ebOrder
													.getOrderNo() + ""));
								}
								if (syllable[i].equals("12")) {
									row.createCell((short) i).setCellValue(
											ebOrder.getInvoiceTitle());
								}
								if (syllable[i].equals("14")) {
									row.createCell((short) i).setCellValue(
											ebOrder.getReturnRatio());
								}
								if (syllable[i].equals("15")) {
									String type = "";
									if (ebOrder.getType() != null) {
										if (ebOrder.getType() == 1) {
											if (ebOrder.getOnoffLineStatus() == 1) {
												type = "线上商品订单";
											} else if (ebOrder
													.getOnoffLineStatus() == 2) {
												type = "线下买单";
											} else if (ebOrder
													.getOnoffLineStatus() == 3) {
												type = "商家付款";
											} else {
												type = "暂无";
											}
										} else if (ebOrder.getType() == 2) {
											type = "精英合伙人订单";
										} else if (ebOrder.getType() == 3) {
											type = "充值订单";
										} else if (ebOrder.getType() == 4) {
											type = "兑换订单";
										} else {
											type = "暂无";
										}
										row.createCell((short) i).setCellValue(
												type);
									} else {
										row.createCell((short) i).setCellValue(
												"异常订单");
									}

								}
								if (syllable[i].equals("16")) {
									row.createCell((short) i).setCellValue(
											ebOrder.getExpressNumber());
								}
								if (syllable[i].equals("17")) {
									row.createCell((short) i).setCellValue(
											ebOrder.getLogisticsCompany());
								}
								if (syllable[i].equals("18")) {
									EbOrderitem ebOrderitem = new EbOrderitem();
									ebOrderitem
											.setOrderId(ebOrder.getOrderId());
									List<EbOrderitem> ebOrderItemList = ebOrderitemService
											.getEbOrderitemList(ebOrderitem);
									if (ebOrderItemList != null
											&& ebOrderItemList.size() > 0) {
										for (int j = 0; j < ebOrderItemList
												.size(); j++) {
											EbOrderitem ebOrderitems = ebOrderItemList
													.get(j);
											row.createCell((short) i + j + 1)
													.setCellValue(
															ebOrderitems
																	.getProductName()
																	+ "/"
																	+ ebOrderitems
																			.getStandardName()
																	+ "/"
																	+ ebOrderitems
																			.getGoodsPrice()
																	+ "/"
																	+ CountMoney.getQuantity(ebOrderitem.getGoodsNums(),ebOrderitem.getMeasuringType())
																	+ "/"
																	+ ebOrderitems
																			.getVipGold()
																			.toString());// 商品名称+规格+单价+数量+获得积分数
										}
									}
								}
							}
						} catch (Exception e) {
						}
						rowNum++;
					}
					pageNo++;
				} else {
					t = 2;
				}
			}
			String RootPath = request.getSession().getServletContext()
					.getRealPath("/").replace("\\", "/");
			String path = "upload/xlsfile/tempfile";
			Random r = new Random();
			String strfileName = DateUtil.getDateFormat(new Date(),
					"yyyyMMddHHmmss") + r.nextInt();
			File f = new File(RootPath + path);
			// 不存在则创建它
			if (!f.exists())
				f.mkdirs();
			String tempPath = RootPath + path + "/" + strfileName + ".xls";
			try {
				FileOutputStream fout = new FileOutputStream(tempPath);
				wb.write(fout);
				fout.close();
				url = domainurl + "/" + path + "/" + strfileName + ".xls";
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else {

		}
		return url;
	}

	/***
	 * 选择快递
	 */
	@RequiresUser
	@ResponseBody
	@RequestMapping("treeDictsData")
	public List<Map<String, Object>> treeDictsData(HttpServletResponse response) {

		response.setContentType("application/json; charset=UTF-8");
		List<Map<String, Object>> mapList = Lists.newArrayList();

		SysDict sysDict = new SysDict();
		sysDict.setType("logisticsCompany");
		sysDict.setDelFlag("0");
		List<SysDict> dicts = sysDictService.getDicts(sysDict);
		for (int i = 0; i < dicts.size(); i++) {
			SysDict e = dicts.get(i);
			Map<String, Object> map = Maps.newHashMap();
			map.put("id", e.getId());
			map.put("name", e.getLabel());
			mapList.add(map);
		}
		return mapList;
	}

}
