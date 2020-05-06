package com.jq.support.main.controller.payback;

import java.io.BufferedReader;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.security.PrivateKey;
import java.util.*;
import java.util.Map.Entry;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jq.support.dao.pay.EbShopIsvPayconfigDao;
import com.jq.support.model.order.EbOrder;
import com.jq.support.model.pay.EbShopIsvPayconfig;
import com.jq.support.service.merchandise.order.EbOrderService;
import com.jq.support.service.pay.helipay.*;
import com.jq.support.service.utils.StringUtil;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.alipay.api.internal.util.AlipaySignature;
import com.jq.support.common.config.Global;
import com.jq.support.dao.merchandise.order.EbOrderDao;
import com.jq.support.model.pay.BusinessPayConfigure;
import com.jq.support.model.user.EbConversion;
import com.jq.support.service.merchandise.user.EbConversionService;
import com.jq.support.service.pay.BusinessPayConfigureService;
import com.jq.support.service.pay.SbscPayService;

import com.jq.support.service.pay.ecopay.allinpay.lib.SybConstants;
import com.jq.support.service.pay.ecopay.allinpay.lib.SybUtil;
import com.jq.support.service.pay.ecopay.mobilepay.SunMd5;
import com.jq.support.service.pay.ecopay.quickpay.client.TransactionClient;
import com.jq.support.service.pay.ecopay.quickpay.demo.Constants;
import com.jq.support.service.pay.unionpay.CertUtil;
import com.jq.support.service.pay.unionpay.SDKConfig;
import com.jq.support.service.pay.unionpay.SDKConstants;
import com.jq.support.service.pay.unionpay.SDKUtil;
import com.jq.support.service.pay.yacolPay.tools.MerchantConfig;
import com.jq.support.service.pay.yacolPay.tools.SignUtil;
import com.jq.support.service.pay.yacolPay.tools.Tools;
import com.jq.support.service.pay.yeepay.paymobile.utils.PaymobileUtils;
import com.jq.support.service.pay.yeepay.wxpay.YeepayService;
import com.jq.support.service.utils.WeixinUtil;
import com.jq.support.service.utils.alipay.AlipayConfig;

import net.sf.json.JSONObject;


@Controller
@RequestMapping("/")
public class PayBackController {
	
	private static Log buypaylogger = LogFactory.getLog("buypaylog"); 
	
	@Autowired
	private SbscPayService sbscPayService;
	
	@Autowired
	private EbOrderDao productorderDao;
	@Autowired
	private EbOrderService ebOrderService;
	@Autowired
	private BusinessPayConfigureService businessPayConfigureService;
	@Autowired
	private EbShopIsvPayconfigDao ebShopIsvPayconfigDao;
	
	/**
	 * 银联后台通知 (没有界面的，纯粹的后台业务处理)
	 */
	@RequestMapping(value = {"unionpaybacknotify"})
	public String unionpaybacknotify(HttpServletRequest request, HttpServletResponse response, Model model,RedirectAttributes redirectAttributes) {
		try{
			request.setCharacterEncoding("ISO-8859-1");
			String encoding = request.getParameter(SDKConstants.param_encoding);
			// 获取请求参数中所有的信息
			Map<String, String> reqParam = getAllRequestParam(request);
			// 打印请求报文
			buypaylogger.info("支付回调--后台通知--支付返回的参数：" + reqParam);
	
			Map<String, String> valideData = null;
			if (null != reqParam && !reqParam.isEmpty()) {
				Iterator<Entry<String, String>> it = reqParam.entrySet().iterator();
				valideData = new HashMap<String, String>(reqParam.size());
				while (it.hasNext()) {
					Entry<String, String> e = it.next();
					String key = e.getKey();
					String value = e.getValue();
					value = new String(value.getBytes("ISO-8859-1"), encoding);
					valideData.put(key, value);
				}
			}
			//Todo 支付校验
			//SDKConfig.getConfig().loadPropertiesFromSrc();// 从classpath加载acp_sdk.properties文件
			
			String  out_trade_no = valideData.get("orderId");// 商户网站唯一订单号
			
			/*EbOrder productorder = productorderDao.getEbOrderByNo(out_trade_no);
			if(productorder==null){
				buypaylogger.info("获取订单失败"); 
				return "";
			}*/
			String merId = "";
			String certPwd="";
			BusinessPayConfigure businessPayConfigure=null;
			/*if(productorder.getShopId()!=null){
				businessPayConfigure=businessPayConfigureService.getByPamentTypeAndShopId(1, productorder.getShopId());
			}*/
			if(businessPayConfigure==null){
				businessPayConfigure=businessPayConfigureService.getDefaultByPaymentType(1);
			}
			if(businessPayConfigure!=null){
				SDKConfig.getConfig().loadPropertiesFromSrc(businessPayConfigure);//从数据库加载
				merId=SDKConfig.getConfig().getMerId();
				certPwd=businessPayConfigure.getYlSignCertPwd();
			}else{
				SDKConfig.getConfig().loadPropertiesFromSrc();
				merId=SDKConfig.getConfig().getProperties().getProperty("site.merId");
				certPwd=SDKConfig.getConfig().getSignCertPwd();
			}
			String frontUrl = SDKConfig.getConfig().getFrontRequestUrl();
			String backUrl = SDKConfig.getConfig().getBackRequestUrl();
			CertUtil.init();
			PrivateKey privateKey=CertUtil.getSignCertPrivateKey(certPwd);
			//String certId=CertUtil.getSignCertId();
			String certId=reqParam.get("certId");
			
		    if (!SDKUtil.validate(valideData, encoding,certId)) {
		     //如果校验失败
		    	buypaylogger.info("银联支付校验失败！"); 
				redirectAttributes.addAttribute("msg",URLEncoder.encode("失败：银联支付校验失败！","utf-8"));
//				return "redirect:" + Global.getFrontPath() + "errornotice";
				return "modules/front/views/errornotice";
			}else{
				String  txnAmtStr =valideData.get("txnAmt"); //ParamUtils.getParameter(request, "total_fee");// 交易金额
				String  txnAmt=SDKUtil.FenConvertYuan(txnAmtStr);//银联返回金额为分单位转换为元单位
				String  trade_no = valideData.get("queryId");// 银联交易流水号
				String  gmt_payment = valideData.get("txnTime");// 交易付款时间
				String  txnType = valideData.get("txnType");// 交易类型
				if(txnType.equals("01")){//消费
					try {
						sbscPayService.payMentCallBack(null,null,null,out_trade_no, trade_no,Double.parseDouble(txnAmt), "4", request, null);
					} catch (Exception e) {
						e.printStackTrace();
					}
					//查询订单状态
					buypaylogger.info("--------------查询订单状态------------"); 
					
				}else{
					redirectAttributes.addAttribute("msg",URLEncoder.encode("失败！","utf-8") );
					return "modules/front/views/errornotice";
				} 
			} 
	    
		}catch(Exception ex){
			buypaylogger.info("支付回调失败：" + ex.toString());
			try {
				redirectAttributes.addAttribute("msg",URLEncoder.encode("失败：银联支付校验失败！" + ex.toString(),"utf-8"));
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
			ex.printStackTrace();
			return "redirect:" + Global.getFrontPath() + "errornotice";
		}
		return null;
	}
	
	
	/**
	 * 获取请求参数中所有的信息
	 * 
	 * @param request
	 * @return
	 */
	public Map<String, String> getAllRequestParam(HttpServletRequest request) {
		Map<String, String> res = new HashMap<String, String>();
		Enumeration<?> temp = request.getParameterNames();
		if (null != temp) {
			while (temp.hasMoreElements()) {
				String en = (String) temp.nextElement();
				String value = request.getParameter(en);
				res.put(en, value);
				// 在报文上送时，如果字段的值为空，则不上送<下面的处理为在获取所有参数数据时，判断若值为空，则删除这个字段>
				if (null == res.get(en) || "".equals(res.get(en))) {
					res.remove(en);
				}
			}
		}
		return res;
	}
	
	
	
	
	/**
	 * 支付宝后台通知 (没有界面的，纯粹的后台业务处理)
	 * @throws Exception 
	 * @throws NumberFormatException 
	 */
	@RequestMapping(value = {"alipaybacknotify"})
	@ResponseBody
	public String alipaybacknotify(HttpServletRequest request, HttpServletResponse response, Model mode) throws NumberFormatException, Exception {
		buypaylogger.info("-----------------------进入支付宝支付处理-------------------------");
		//获取支付宝POST过来反馈信息
		Map<String,String> params = new HashMap<String,String>();
		Map requestParams = request.getParameterMap();
		for (Iterator iter = requestParams.keySet().iterator(); iter.hasNext();) {
		    String name = (String) iter.next();
		    String[] values = (String[]) requestParams.get(name);
		    String valueStr = "";
		    for (int i = 0; i < values.length; i++) {
		        valueStr = (i == values.length - 1) ? valueStr + values[i]
		                    : valueStr + values[i] + ",";
		  }
		  //乱码解决，这段代码在出现乱码时使用。
		  //valueStr = new String(valueStr.getBytes("ISO-8859-1"), "utf-8");
		  params.put(name, valueStr);
		 }
		//获取支付宝的通知返回参数，可参考技术文档中页面跳转同步通知参数列表(以下仅供参考)//
		//交易状态
		String trade_status = new String(request.getParameter("trade_status").getBytes("ISO-8859-1"),"UTF-8");
		
		boolean flag = false;
		
		//获取数据库中默认的配置数据
		BusinessPayConfigure businessPayConfigure=businessPayConfigureService.getDefaultByPaymentType(2);
		if(businessPayConfigure!=null){
			System.out.println("------------------获取支付宝配置成功------------------");
			//verify=AlipayNotify.verify(params,businessPayConfigure.getZfbPublicKey(),businessPayConfigure.getZfbPartner());
			flag=AlipaySignature.rsaCheckV1(params, businessPayConfigure.getZfbKey(), AlipayConfig.input_charset, "RSA2");
		}else{
			//verify=AlipayNotify.verify(params,AlipayConfig.alipay_public_key,AlipayConfig.partner);
			flag=AlipaySignature.rsaCheckV1(params, AlipayConfig.alipay_public_key, AlipayConfig.input_charset, "RSA2");
		}
		if(flag){//验证成功
			if (trade_status.equals("TRADE_SUCCESS")){//交易成功且结束，即不可再做任何操作。
				//商户订单号
				String out_trade_no = new String(request.getParameter("out_trade_no").getBytes("ISO-8859-1"),"UTF-8");
				//支付宝交易号
				String trade_no = new String(request.getParameter("trade_no").getBytes("ISO-8859-1"),"UTF-8");
				//支付金额
				String total_fee = new String(request.getParameter("total_amount").getBytes("ISO-8859-1"),"UTF-8");
				buypaylogger.info("订单号:"+out_trade_no);
				sbscPayService.payMentCallBack(null,null,null,out_trade_no, trade_no, Double.parseDouble(total_fee), "2", request, null);
			}
			buypaylogger.info("------------------支付宝支付callback结束！------------------"); 
			return "success";
		}else{//验证失败
			buypaylogger.info("------------------支付宝支付校验失败！------------------"); 
			return "fail";
		}
	}
	
	
	/**
	 * 支付宝后台通知 (没有界面的，纯粹的后台业务处理)
	 * @throws Exception 
	 * @throws NumberFormatException 
	 */
	@RequestMapping(value = {"alipayscannotify"})
	@ResponseBody
	public String alipayscannotify(HttpServletRequest request, HttpServletResponse response, Model mode) throws NumberFormatException, Exception {
		buypaylogger.info("-----------------------进入支付宝支付处理-------------------------");
		//获取支付宝POST过来反馈信息
		Map<String,String> params = new HashMap<String,String>();
		Map requestParams = request.getParameterMap();
		for (Iterator iter = requestParams.keySet().iterator(); iter.hasNext();) {
		    String name = (String) iter.next();
		    String[] values = (String[]) requestParams.get(name);
		    String valueStr = "";
		    for (int i = 0; i < values.length; i++) {
		        valueStr = (i == values.length - 1) ? valueStr + values[i]
		                    : valueStr + values[i] + ",";
		  }
		  //乱码解决，这段代码在出现乱码时使用。
		  //valueStr = new String(valueStr.getBytes("ISO-8859-1"), "utf-8");
		  params.put(name, valueStr);
		 }
		//获取支付宝的通知返回参数，可参考技术文档中页面跳转同步通知参数列表(以下仅供参考)//
		//交易状态
		String trade_status = new String(request.getParameter("trade_status").getBytes("ISO-8859-1"),"UTF-8");
		
		boolean flag = false;
		
		//获取数据库中默认的配置数据
		BusinessPayConfigure businessPayConfigure=businessPayConfigureService.getDefaultByPaymentType(21);
		if(businessPayConfigure!=null){
			System.out.println("------------------获取支付宝配置成功------------------");
			//verify=AlipayNotify.verify(params,businessPayConfigure.getZfbPublicKey(),businessPayConfigure.getZfbPartner());
			flag=AlipaySignature.rsaCheckV1(params, businessPayConfigure.getZfbKey(), AlipayConfig.input_charset, "RSA2");
		}else{
			//verify=AlipayNotify.verify(params,AlipayConfig.alipay_public_key,AlipayConfig.partner);
			flag=AlipaySignature.rsaCheckV1(params, AlipayConfig.alipay_public_key, AlipayConfig.input_charset, "RSA2");
		}
		if(flag){//验证成功
			if (trade_status.equals("TRADE_SUCCESS")){//交易成功且结束，即不可再做任何操作。
				//商户订单号
				String out_trade_no = new String(request.getParameter("out_trade_no").getBytes("ISO-8859-1"),"UTF-8");
				//支付宝交易号
				String trade_no = new String(request.getParameter("trade_no").getBytes("ISO-8859-1"),"UTF-8");
				//支付金额
				String total_fee = new String(request.getParameter("total_amount").getBytes("ISO-8859-1"),"UTF-8");
				buypaylogger.info("订单号:"+out_trade_no);
				sbscPayService.payMentCallBack(null,null,null,out_trade_no, trade_no, Double.parseDouble(total_fee), "21", request, null);
			}
			buypaylogger.info("------------------支付宝支付callback结束！------------------"); 
			return "success";
		}else{//验证失败
			buypaylogger.info("------------------支付宝支付校验失败！------------------"); 
			return "fail";
		}
	}
 
	
	
	
	
	/**
	 * 通联支付的支付宝支付后台通知 
	 * @throws IOException 
	 */
	@RequestMapping(value = {"allinPaybacknotify"})
	@ResponseBody
	public String allinPaybacknotify(HttpServletRequest request, HttpServletResponse response, Model mode) throws IOException {
		System.out.println("-----------------------进入通联支付宝处理-------------------------");
		request.setCharacterEncoding("gbk");//通知传输的编码为GBK
		response.setCharacterEncoding("gbk");
		TreeMap<String, String> params = new TreeMap<String, String>();//动态遍历获取所有收到的参数,此步非常关键,因为收银宝以后可能会加字段,动态获取可以兼容
		Map reqMap = request.getParameterMap();
		for(Object key:reqMap.keySet()){
			String value = ((String[])reqMap.get(key))[0];
			System.out.println(key+";"+value);
			params.put(key.toString(),value);
		}
		//商户订单号
		String out_trade_no = params.get("cusorderid");
		//支付宝交易号
		String trade_no = params.get("outtrxid");
		//交易状态
		String trade_status = params.get("trxstatus");
		//支付金额
		String total_fee = params.get("trxamt");
		
		String appkey=SybConstants.SYB_APPKEY;
		
		//获取数据库中默认的配置数据
		BusinessPayConfigure businessPayConfigure=businessPayConfigureService.getDefaultByPaymentType(10);
		if(businessPayConfigure!=null){
			appkey=businessPayConfigure.getZfbKey();
		}
		buypaylogger.info("订单号:"+out_trade_no);
		try {
			boolean isSign = SybUtil.validSign(params, appkey);// 接受到推送通知,首先验签
			buypaylogger.info("验签结果:"+isSign);
			//验签完毕进行业务处理
			if (trade_status.equals("0000")) {
				sbscPayService.payMentCallBack(null,null,null,out_trade_no, trade_no, Double.parseDouble(total_fee)/100, "10", request, null);
			}
			buypaylogger.info("通联支付宝支付callback结束！"); 
		} catch (Exception e) {//处理异常
			e.printStackTrace();
			buypaylogger.info("通联支付宝支付校验失败！"); 
			return "fail";
		}
		finally{//收到通知,返回success
			return "success";
		}
		
	}
	
	/**
	 * 易联支付的快捷支付后台通知 
	 * @throws IOException 
	 */
	@RequestMapping(value = {"ecopayQuickaybacknotify"})
	@ResponseBody
	public String ecopayQuickaybacknotify(HttpServletRequest request, HttpServletResponse response, Model mode) throws IOException {
		System.out.println("-----------------------进入支付处理-------------------------");
		
		// 设置编码
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		// 结果通知参数，易联异步通知采用GET提交
		String version = request.getParameter("Version");
		String merchantId = request.getParameter("MerchantId");
		String merchOrderId = request.getParameter("MerchOrderId");
		String amount = request.getParameter("Amount");
		String extData = request.getParameter("ExtData");
		String orderId = request.getParameter("OrderId");
		String status = request.getParameter("Status");
		String payTime = request.getParameter("PayTime");
		String settleDate = request.getParameter("SettleDate");
		String sign = request.getParameter("Sign");
		
		// 需要对必要输入的参数进行检查，本处省略...
		String publickey=Constants.PAYECO_RSA_PUBLIC_KEY;
		BusinessPayConfigure businessPayConfigure=businessPayConfigureService.getDefaultByPaymentType(9);
		if(businessPayConfigure!=null){
			publickey=businessPayConfigure.getZfbPublicKey();
		}
		
		// 订单结果逻辑处理
		String retMsgJson = "";
		try {
			//验证订单结果通知的签名
			boolean b = TransactionClient.bCheckNotifySign(version, merchantId, merchOrderId, 
					amount, extData, orderId, status, payTime, settleDate, sign, 
					publickey);
			if (!b) {
				retMsgJson = "{\"RetCode\":\"E101\",\"RetMsg\":\"验证签名失败!\"}";
				buypaylogger.info("验证签名失败!");
			}else{
				// 签名验证成功后，需要对订单进行后续处理
				if ("02".equals(status)) { // 订单已支付;
				//if ("0000".equals(status)) { // 若是互联金融行业, 订单已支付的状态为【0000】
					// 1、检查Amount和商户系统的订单金额是否一致
					// 2、订单支付成功的业务逻辑处理请在本处增加（订单通知可能存在多次通知的情况，需要做多次通知的兼容处理）；
					// 3、返回响应内容
					
					sbscPayService.payMentCallBack(null,null,null,merchOrderId, orderId, Double.parseDouble(amount), "9", request, null);
					retMsgJson = "{\"RetCode\":\"0000\",\"RetMsg\":\"订单已支付\"}";
					buypaylogger.info("订单已支付!");
				} else {
					// 1、订单支付失败的业务逻辑处理请在本处增加（订单通知可能存在多次通知的情况，需要做多次通知的兼容处理，避免成功后又修改为失败）；
					// 2、返回响应内容
					retMsgJson = "{\"RetCode\":\"E102\",\"RetMsg\":\"订单支付失败+"+status+"\"}";
					buypaylogger.info("订单支付失败!status="+status);
				}
			}
		} catch (Exception e) {
			retMsgJson = "{\"RetCode\":\"E103\",\"RetMsg\":\"处理通知结果异常\"}";
			System.out.println("处理通知结果异常!e="+e.getMessage());
		}
		buypaylogger.info("-----处理完成----");
		//返回数据
	    return retMsgJson;
		
	}
	
	
	
	/**
	 * 微信支付通知
	 * @throws IOException 
	 */
	@RequestMapping(value = {"weixinnotify"})
	@ResponseBody
	public void weixinnotify(HttpServletRequest request, HttpServletResponse response, Model mode)  {
        try {
			InputStream inStream = request.getInputStream();
			ByteArrayOutputStream outSteam = new ByteArrayOutputStream();
			byte[] buffer = new byte[1024];
			int len = 0;
			while ((len = inStream.read(buffer)) != -1) {
				outSteam.write(buffer, 0, len);
			}
			outSteam.close();
			inStream.close();
			String result = new String(outSteam.toByteArray(), "utf-8");//获取微信调用我们notify_url的返回信息
			Map<Object, Object> map = WeixinUtil.doXMLParse(result);
			 StringBuilder weixinnotifyResultTxt=new StringBuilder("微信支付回调参数：");
	        for(Object keyValue : map.keySet()){//输出参数
	            System.out.println(keyValue+"="+map.get(keyValue));
	            weixinnotifyResultTxt.append(keyValue+" : "+map.get(keyValue)+" | ");
	        }
	        System.out.println(weixinnotifyResultTxt.toString());
	        
	        if (map.get("result_code").toString().equalsIgnoreCase("SUCCESS")) {
	        	String out_trade_no=(String) map.get("out_trade_no");//商户订单（我们的）
	        	String transaction_id=(String) map.get("transaction_id");//交易单号(微信的)
	        	String total_fee=(String) map.get("total_fee");//交易金额,单位为分
	        	System.out.println("微信订单号："+transaction_id);
	        	/*EbOrder productorder=null;
	    		if(StringUtils.isNotBlank(out_trade_no)){
	    			productorder=productorderDao.getEbOrderByNo(out_trade_no);
	    		}*/
	        	String payType="5";
	    		BusinessPayConfigure businessPayConfigure=null;
	    		if (map.get("trade_type").toString().equals("APP")){
	    			businessPayConfigure=businessPayConfigureService.getDefaultByPaymentType(5);
	    			payType="5"; //App支付
	    		}else if (map.get("trade_type").toString().equals("JSAPI")){
	    			businessPayConfigure=businessPayConfigureService.getDefaultByPaymentType(52);
	    			payType="52"; //公众号支付
	    		}else if (map.get("trade_type").toString().equals("NATIVE")){
	    			businessPayConfigure=businessPayConfigureService.getDefaultByPaymentType(53);
	    			payType="53"; //扫码支付
	    		}else{
	    			businessPayConfigure=businessPayConfigureService.getDefaultByPaymentType(5);
	    		}
	        	
	        	Map<String,String> searchOrder=WeixinUtil.searchOrder(transaction_id, businessPayConfigure.getWxIosAppId(), businessPayConfigure.getWxPartner(), businessPayConfigure.getWxPartnerKey());
	        	System.out.println("查询订单的结果:"+searchOrder.get("return_code")+"    原因："+searchOrder.get("return_msg"));
	        	if(searchOrder!=null&&searchOrder.get("return_code").equalsIgnoreCase("SUCCESS")&&searchOrder.get("trade_state").equalsIgnoreCase("SUCCESS")){
	        		sbscPayService.payMentCallBack(null,null,null,out_trade_no, transaction_id, Double.parseDouble(fromFenToYuan(total_fee)), payType, request, null);
	        	}
	        }
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			try {
				response.getWriter().write(WeixinUtil.setXML("SUCCESS", "OK"));
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

	/**
	 * 合利宝扫码支付（刷卡(被扫)）支付通知
	 * @throws IOException
	 */
	@RequestMapping(value = {"isvPayBackNotify"})
	@ResponseBody
	public String isvPayBackNotify(HttpServletRequest request, HttpServletResponse response, NotifyResponseVo notifyResponseVo, Model mode)  {
		try {
			String dineType=request.getParameter("dineType");
			String tableNum=request.getParameter("tableNum");
			String appType=request.getParameter("appType");
			buypaylogger.info("---dineType：" + dineType);
			buypaylogger.info("---appType：" + appType);
			BusinessPayConfigure businessPayConfigure=businessPayConfigureService.getDefaultByPaymentType(56);
			buypaylogger.info("---获取合利宝扫码支付（刷卡(被扫)）支付参数成功");
			String assemblyRespOriSign = MyBeanUtils.getSigned(
					notifyResponseVo, null,businessPayConfigure.getIsvSignkeyMd5());
			buypaylogger.info("组装返回结果签名串：" + assemblyRespOriSign);
			String responseSign = notifyResponseVo.getSign();
			buypaylogger.info("响应签名：" + responseSign);
			String checkSign = Disguiser
					.disguiseMD5(assemblyRespOriSign.trim());
			buypaylogger.info("验证签名：" + checkSign);
			if (checkSign.equals(responseSign)) {
				buypaylogger.info("fail 验证签名成功");
				String payType="56";
				String out_trade_no=notifyResponseVo.getRt2_orderId();//商户订单（我们的）
				String transaction_id=notifyResponseVo.getRt3_systemSerial();//交易单号(合利宝的)
				String total_fee=notifyResponseVo.getRt5_orderAmount();//交易金额,单位为元
				buypaylogger.info("交易单号：" + transaction_id);
				buypaylogger.info("商户订单（我们的）：" + out_trade_no);
				buypaylogger.info("交易单号(合利宝的)：" + transaction_id);
				buypaylogger.info("交易金额,单位为元：" + total_fee);
				EbOrder productorder=productorderDao.getEbOrderByNo(out_trade_no);
				Integer shopId=productorder.getShopId();
				String ISV= Global.getConfig("ISV");
				if(StringUtil.isBlank(ISV)||"0".equals(ISV)){
					shopId=1;
				}
				EbShopIsvPayconfig ebShopIsvPayconfig=ebShopIsvPayconfigDao.getEbShopIsvPayconfigByShopId(shopId);//合利付商户配置信息
				if(ebShopIsvPayconfig==null){
					buypaylogger.info("---获取商户信息参数失败");
					return "fail";
				}
				// 验证签名成功()
				// 商户根据根据支付结果做业务处理
				QueryOrderVo queryOrderVo=new QueryOrderVo();
				queryOrderVo.setP1_bizType("AppPayQuery");
				queryOrderVo.setP2_orderId(out_trade_no);
				queryOrderVo.setP3_customerNumber(ebShopIsvPayconfig.getCustomerUmber());
//				queryOrderVo.setP4_serialNumber(notifyResponseVo.getRt3_systemSerial());
				Map searchOrder= HeliPay.searchOrder(queryOrderVo,businessPayConfigure);
				buypaylogger.info("查询订单的结果:"+searchOrder.get("code")+"    原因："+searchOrder.get("msg"));
				if(searchOrder!=null&&searchOrder.get("code").equals("00")){
					sbscPayService.payMentCallBack((StringUtil.isBlank(tableNum)||"null".equals(tableNum))?null:Integer.parseInt(tableNum),appType,Integer.parseInt(StringUtil.isBlank(dineType)?"0":dineType),out_trade_no, transaction_id, Double.parseDouble(total_fee), payType, request, null);
					return "SUCCESS";
				}
			} else {
				buypaylogger.info("fail 验证签名失败");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return "fail";
	}

	/**
	 * 合利宝扫码支付（主扫）退款回调
	 * @throws IOException
	 */
	@RequestMapping(value = {"isvPayBackNotifyRefund"})
	@ResponseBody
	public String isvPayBackNotifyRefund(HttpServletRequest request, HttpServletResponse response, NotifyRefundResponseVo notifyResponseVo, Model mode)  {
		try {

			BusinessPayConfigure businessPayConfigure=businessPayConfigureService.getDefaultByPaymentType(58);
			buypaylogger.info("---获取合利宝支付退款回调");
			buypaylogger.info("---获取合利宝支付退款回调参数");
			String assemblyRespOriSign = MyBeanUtils.getSigned(
					notifyResponseVo, new String[]{"rt9_refundOrderCompleteDate","rt10_refundChannelOrderNum"},businessPayConfigure.getIsvSignkeyMd5());
			buypaylogger.info("组装返回结果签名串：" + assemblyRespOriSign);
			String responseSign = notifyResponseVo.getSign();
			buypaylogger.info("响应签名：" + responseSign);
			String checkSign = Disguiser
					.disguiseMD5(assemblyRespOriSign.trim());
			buypaylogger.info("验证签名：" + checkSign);
			if (checkSign.equals(responseSign)) {
				buypaylogger.info("fail 验证签名成功");
				String out_trade_no=notifyResponseVo.getRt2_orderId();//商户订单（我们的）
				String transaction_id=notifyResponseVo.getRt4_systemSerial();//交易单号(合利宝的)
				String total_fee=notifyResponseVo.getRt6_amount();//交易金额,单位为元
				buypaylogger.info("交易单号：" + transaction_id);
				EbOrder productorder=productorderDao.getEbOrderByNo(out_trade_no);
				sbscPayService.heliPayRefundQueryHandle(productorder);

			} else {
				buypaylogger.info("fail 验证签名失败");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return "SUCCESS";
	}
	/**
	 * 合利宝扫码支付（主扫）支付通知
	 * @throws IOException
	 */
	@RequestMapping(value = {"isvPayBackNotifyScan"})
	@ResponseBody
	public String isvPayBackNotifyScan(HttpServletRequest request, HttpServletResponse response, NotifyResponseVo notifyResponseVo, Model mode)  {
		try {
			String dineType=request.getParameter("dineType");
			String tableNum=request.getParameter("tableNum");
			String appType=request.getParameter("appType");
			buypaylogger.info("---dineType：" + dineType);
			buypaylogger.info("---appType：" + appType);
			BusinessPayConfigure businessPayConfigure=businessPayConfigureService.getDefaultByPaymentType(56);
			buypaylogger.info("---获取合利宝扫码支付（主扫）支付参数成功");
			String assemblyRespOriSign = MyBeanUtils.getSigned(
					notifyResponseVo, null,businessPayConfigure.getIsvSignkeyMd5());
			buypaylogger.info("组装返回结果签名串：" + assemblyRespOriSign);
			String responseSign = notifyResponseVo.getSign();
			buypaylogger.info("响应签名：" + responseSign);
			String checkSign = Disguiser
					.disguiseMD5(assemblyRespOriSign.trim());
			buypaylogger.info("验证签名：" + checkSign);
			if (checkSign.equals(responseSign)) {
				buypaylogger.info("fail 验证签名成功");
				String payType="71";
				String out_trade_no=notifyResponseVo.getRt2_orderId();//商户订单（我们的）
				String transaction_id=notifyResponseVo.getRt3_systemSerial();//交易单号(合利宝的)
				String total_fee=notifyResponseVo.getRt5_orderAmount();//交易金额,单位为元
				buypaylogger.info("交易单号：" + transaction_id);
				EbOrder productorder=productorderDao.getEbOrderByNo(out_trade_no);
				Integer shopId=productorder.getShopId();
				String ISV= Global.getConfig("ISV");
				if(StringUtil.isBlank(ISV)||"0".equals(ISV)){
					shopId=1;
				}
				EbShopIsvPayconfig ebShopIsvPayconfig=ebShopIsvPayconfigDao.getEbShopIsvPayconfigByShopId(shopId);//合利付商户配置信息
				if(ebShopIsvPayconfig==null){
					buypaylogger.info("---获取商户信息参数失败");
					return "fail";
				}
				// 验证签名成功()
				// 商户根据根据支付结果做业务处理
				QueryOrderVo queryOrderVo=new QueryOrderVo();
				queryOrderVo.setP1_bizType("AppPayQuery");
				queryOrderVo.setP2_orderId(out_trade_no);
				queryOrderVo.setP3_customerNumber(ebShopIsvPayconfig.getCustomerUmber());
//				queryOrderVo.setP4_serialNumber(notifyResponseVo.getRt3_systemSerial());
				Map searchOrder= HeliPay.searchOrder(queryOrderVo,businessPayConfigure);
				buypaylogger.info("查询订单的结果:"+searchOrder.get("code")+"    原因："+searchOrder.get("msg"));
				if(searchOrder!=null&&searchOrder.get("code").equals("00")){
					sbscPayService.payMentCallBack((StringUtil.isBlank(tableNum)||"null".equals(tableNum))?null:Integer.parseInt(tableNum),appType,Integer.parseInt(StringUtil.isBlank(dineType)?"0":dineType),out_trade_no, transaction_id, Double.parseDouble(total_fee), payType, request, null);
					return "SUCCESS";
				}
			} else {
				buypaylogger.info("fail 验证签名失败");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return "fail";
	}
	/**
	 * 合利宝微信小程序支付支付通知
	 * @throws IOException
	 */
	@RequestMapping(value = {"upPay"})
	@ResponseBody
	public String upPay(HttpServletRequest request, HttpServletResponse response, NotifyResponseVo notifyResponseVo, Model mode)  {
//		List<Map> list=new ArrayList<Map>();
//		Map map=null;
//		map=new HashMap();
//		map.put("out_trade_no","20201193237250642");
//		map.put("transaction_id","4136792480");
//		map.put("payType","56");
//		map.put("appType","WXPAY");
//		list.add(map);
//		map=new HashMap();
//		map.put("out_trade_no","2020119479391097");
//		map.put("transaction_id","4137020744");
//		map.put("payType","56");
//		map.put("appType","WXPAY");
//		list.add(map);
//		map=new HashMap();
//		map.put("out_trade_no","20201195241227971");
//		map.put("transaction_id","4137111445");
//		map.put("payType","56");
//		map.put("appType","WXPAY");
//		list.add(map);
//		map=new HashMap();
//		map.put("out_trade_no","20201110013430223");
//		map.put("transaction_id","4137236934");
//		map.put("payType","56");
//		map.put("appType","WXPAY");
//		list.add(map);
//		map=new HashMap();
//		map.put("out_trade_no","202011101152405364");
//		map.put("transaction_id","4137436147");
//		map.put("payType","56");
//		map.put("appType","WXPAY");
//		list.add(map);
//		map=new HashMap();
//		map.put("out_trade_no","202011101248018754");
//		map.put("transaction_id","4137451893");
//		map.put("payType","56");
//		map.put("appType","WXPAY");
//		list.add(map);
//		map=new HashMap();
//		map.put("out_trade_no","20201110176466005");
//		map.put("transaction_id","4137531202");
//		map.put("payType","56");
//		map.put("appType","ALIPAY");
//		list.add(map);
//		map=new HashMap();
//		map.put("out_trade_no","202011102121672280");
//		map.put("transaction_id","4137608502");
//		map.put("payType","56");
//		map.put("appType","WXPAY");
//		list.add(map);
//		map=new HashMap();
//		map.put("out_trade_no","202011102331255342");
//		map.put("transaction_id","4137646092");
//		map.put("payType","56");
//		map.put("appType","WXPAY");
//		list.add(map);
//		map=new HashMap();
//		map.put("out_trade_no","202011103018270180");
//		map.put("transaction_id","4137772528");
//		map.put("payType","56");
//		map.put("appType","WXPAY");
//		list.add(map);
//		map=new HashMap();
//		map.put("out_trade_no","202011103131837631");
//		map.put("transaction_id","4137794451");
//		map.put("payType","56");
//		map.put("appType","WXPAY");
//		list.add(map);
//		map=new HashMap();
//		map.put("out_trade_no","202011103752291186");
//		map.put("transaction_id","4137920697");
//		map.put("payType","56");
//		map.put("appType","WXPAY");
//		list.add(map);
//		map=new HashMap();
//		map.put("out_trade_no","202011104152274526");
//		map.put("transaction_id","4137996635");
//		map.put("payType","56");
//		map.put("appType","WXPAY");
//		list.add(map);
//		map=new HashMap();
//		map.put("out_trade_no","202011104451584623");
//		map.put("transaction_id","4138057148");
//		map.put("payType","56");
//		map.put("appType","WXPAY");
//		list.add(map);
//		map=new HashMap();
//		map.put("out_trade_no","202011104856805070");
//		map.put("transaction_id","4138133884");
//		map.put("payType","56");
//		map.put("appType","WXPAY");
//		list.add(map);
//		map=new HashMap();
//		map.put("out_trade_no","202011105639173458");
//		map.put("transaction_id","4138133884");
//		map.put("payType","56");
//		map.put("appType","WXPAY");
//		list.add(map);
//		map=new HashMap();
//		map.put("out_trade_no","202011115525727417");
//		map.put("transaction_id","4139739291");
//		map.put("payType","57");
//		map.put("appType","WXPAY");
//		list.add(map);
//		map=new HashMap();
//		map.put("out_trade_no","20201102838705264");
//		map.put("transaction_id","4140744819");
//		map.put("payType","57");
//		map.put("appType","WXPAY");
//		list.add(map);
//		map=new HashMap();
//		map.put("out_trade_no","20201104727770037");
//		map.put("transaction_id","4141292799");
//		map.put("payType","56");
//		map.put("appType","WXPAY");
//		list.add(map);
//		map=new HashMap();
//		map.put("out_trade_no","20201104825004128");
//		map.put("transaction_id","4141318655");
//		map.put("payType","56");
//		map.put("appType","WXPAY");
//		list.add(map);
//
//		map=new HashMap();
//		map.put("out_trade_no","f20201105455984559");
//		map.put("transaction_id","4141504383");
//		map.put("payType","56");
//		map.put("appType","ALIPAY");
//		list.add(map);
//		for(Map m:list) {
//			buypaylogger.info( m.get("out_trade_no").toString());
//			try {
//				sbscPayService.payMentCallBack1(null, m.get("appType").toString(), null, m.get("out_trade_no").toString(),m.get("transaction_id").toString() , 0.0,m.get("payType").toString() , request, null);
//			} catch (Exception e) {
//				e.printStackTrace();
//			}
//		}
		return "true";
	}
	/**
	 * 合利宝微信小程序支付支付通知
	 * @throws IOException
	 */
	@RequestMapping(value = {"isvMiniPayBackNotify"})
	@ResponseBody
	public String isvMiniPayBackNotify(HttpServletRequest request, HttpServletResponse response, NotifyResponseVo notifyResponseVo, Model mode)  {
		try {
			BusinessPayConfigure businessPayConfigure=businessPayConfigureService.getDefaultByPaymentType(57);
			buypaylogger.info("---获取合利宝微信小程序支付支付参数成功");
			String assemblyRespOriSign = MyBeanUtils.getSigned(
					notifyResponseVo, null,businessPayConfigure.getIsvSignkeyMd5());
			buypaylogger.info("组装返回结果签名串：" + assemblyRespOriSign);
			String responseSign = notifyResponseVo.getSign();
			buypaylogger.info("响应签名：" + responseSign);
			String checkSign = Disguiser
					.disguiseMD5(assemblyRespOriSign.trim());
			buypaylogger.info("验证签名：" + checkSign);
			if (checkSign.equals(responseSign)) {
				buypaylogger.info("验证签名成功");
				String payType="57";
				String out_trade_no=notifyResponseVo.getRt2_orderId();//商户订单（我们的）
				String transaction_id=notifyResponseVo.getRt3_systemSerial();//交易单号(合利宝的)
				String total_fee=notifyResponseVo.getRt5_orderAmount();//交易金额,单位为元
				buypaylogger.info("交易单号：" + transaction_id);
				EbOrder productorder=productorderDao.getEbOrderByNo(out_trade_no);
				Integer shopId=productorder.getShopId();
				String ISV= Global.getConfig("ISV");
				if(StringUtil.isBlank(ISV)||"0".equals(ISV)){
					shopId=1;
				}
				EbShopIsvPayconfig ebShopIsvPayconfig=ebShopIsvPayconfigDao.getEbShopIsvPayconfigByShopId(shopId);//合利付商户配置信息
				if(ebShopIsvPayconfig==null){
					buypaylogger.info("---获取商户信息参数失败");
					return "fail";
				}
				// 验证签名成功()
				// 商户根据根据支付结果做业务处理
				QueryOrderVo queryOrderVo=new QueryOrderVo();
				queryOrderVo.setP1_bizType("AppPayQuery");
				queryOrderVo.setP2_orderId(out_trade_no);
				queryOrderVo.setP3_customerNumber(ebShopIsvPayconfig.getCustomerUmber());
//				queryOrderVo.setP4_serialNumber(notifyResponseVo.getRt3_systemSerial());
				Map searchOrder= HeliPay.searchOrder(queryOrderVo,businessPayConfigure);
				buypaylogger.info("查询订单的结果:"+searchOrder.get("code")+"    原因："+searchOrder.get("msg"));
				if(searchOrder!=null&&searchOrder.get("code").equals("00")){
					sbscPayService.payMentCallBack(null,null,null,out_trade_no, transaction_id, Double.parseDouble(total_fee), payType, request, null);
					return "SUCCESS";
				}
			} else {
				buypaylogger.info("fail 验证签名失败");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return "fail";
	}
	/**
	 * 微信小程序支付通知
	 * @throws IOException
	 */
	@RequestMapping(value = {"weixinMiniNotify"})
	@ResponseBody
	public void weixinMiniNotify(HttpServletRequest request, HttpServletResponse response, Model mode)  {
		try {
			InputStream inStream = request.getInputStream();
			ByteArrayOutputStream outSteam = new ByteArrayOutputStream();
			byte[] buffer = new byte[1024];
			int len = 0;
			while ((len = inStream.read(buffer)) != -1) {
				outSteam.write(buffer, 0, len);
			}
			outSteam.close();
			inStream.close();
			String result = new String(outSteam.toByteArray(), "utf-8");//获取微信调用我们notify_url的返回信息
			Map<Object, Object> map = WeixinUtil.doXMLParse(result);
			StringBuilder weixinnotifyResultTxt=new StringBuilder("微信支付回调参数：");
			for(Object keyValue : map.keySet()){//输出参数
				System.out.println(keyValue+"="+map.get(keyValue));
				weixinnotifyResultTxt.append(keyValue+" : "+map.get(keyValue)+" | ");
			}
			System.out.println(weixinnotifyResultTxt.toString());

			if (map.get("result_code").toString().equalsIgnoreCase("SUCCESS")) {
				String out_trade_no=(String) map.get("out_trade_no");//商户订单（我们的）
				String transaction_id=(String) map.get("transaction_id");//交易单号(微信的)
				String total_fee=(String) map.get("total_fee");//交易金额,单位为分
				System.out.println("微信订单号："+transaction_id);
	        	/*EbOrder productorder=null;
	    		if(StringUtils.isNotBlank(out_trade_no)){
	    			productorder=productorderDao.getEbOrderByNo(out_trade_no);
	    		}*/
				String payType="5";
				BusinessPayConfigure businessPayConfigure=null;
				if (map.get("trade_type").toString().equals("JSAPI")){
					businessPayConfigure=businessPayConfigureService.getDefaultByPaymentType(54);
					payType="54"; //小程序支付
				}

				Map<String,String> searchOrder=WeixinUtil.searchOrder(transaction_id, businessPayConfigure.getWxIosAppId(), businessPayConfigure.getWxPartner(), businessPayConfigure.getWxPartnerKey());
				System.out.println("查询订单的结果:"+searchOrder.get("return_code")+"    原因："+searchOrder.get("return_msg"));
				if(searchOrder!=null&&searchOrder.get("return_code").equalsIgnoreCase("SUCCESS")&&searchOrder.get("trade_state").equalsIgnoreCase("SUCCESS")){
					sbscPayService.payMentCallBack(null,null,null,out_trade_no, transaction_id, Double.parseDouble(fromFenToYuan(total_fee)), payType, request, null);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			try {
				response.getWriter().write(WeixinUtil.setXML("SUCCESS", "OK"));
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
	
	/**
	 * 汇卡支付 通知
	 * @throws IOException 
	 */
	@RequestMapping(value = {"quickpaybacknotify"})
	@ResponseBody
	public void quickpaybacknotify(HttpServletRequest request, HttpServletResponse response, Model mode)  {
		try {
			request.setCharacterEncoding("utf-8");
			InputStreamReader in = new InputStreamReader(request.getInputStream());
			BufferedReader br = new BufferedReader(in);
			String line = null;
			String result = "";
			try {
				while ((line = br.readLine()) != null) {
					result += line;
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				br.close();
			}
			System.out.println("result:" +result);
			Map<String,String> reqMap = jsonToMapString(result);
			String reqSign = reqMap.get("sign");
			String respCode = reqMap.get("respCode");//返回码 00：成功
			String sign = com.jq.support.service.pay.quickPay.Safe.sign(reqMap);
			
			String merchOrderNo=(String) reqMap.get("merchOrderNo");//商户订单（我们的）
			String out_trade_no=merchOrderNo.substring(0,merchOrderNo.indexOf("_"));
			
        	String transaction_id=(String) reqMap.get("hicardOrderNo");//交易单号(汇卡的)
        	String total_fee=(String) reqMap.get("amount");//交易金额,单位为分
			if(sign.equals(reqSign)){
				if (respCode.equals("00")) {
					sbscPayService.payMentCallBack(null,null,null,out_trade_no, transaction_id, Double.parseDouble(total_fee)/100, "8", request, null);
				}
				System.out.println("验签通过");
			}else{
				System.out.println("验签不通过");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			try {
				response.getWriter().print("SUCCESS");
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
	
	/**
	 * 易宝支付 通知
	 * @throws Exception 
	 * @throws NumberFormatException 
	 */
	@RequestMapping(value = {"yeepaybacknotify12","yeepaybacknotify13","yeepaybacknotify14"})
	@ResponseBody
	public void yeepaybacknotify(HttpServletRequest request, HttpServletResponse response, Model mode) throws NumberFormatException, Exception  {
		buypaylogger.info("易宝支付 通知开始");
		//UTF-8编码
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html");
		PrintWriter out	= response.getWriter();

		String popaytype="12";
		String sp=request.getServletPath();
		if (sp.contains("yeepaybacknotify13")) {
			popaytype="13";
		}else if (sp.contains("yeepaybacknotify14")) {
			popaytype="14";
		}
		
		String data	= request.getParameter("data")== null ? "" : request.getParameter("data").trim();
		String encryptkey = request.getParameter("encryptkey")== null ? "" : request.getParameter("encryptkey").trim();
		BusinessPayConfigure businessPayConfigure=businessPayConfigureService.getDefaultByPaymentType(12);
		StringBuffer privateKey=null;
		String publicKey="";
		if(businessPayConfigure!=null){
			privateKey=new StringBuffer(businessPayConfigure.getZfbPrivateKey());
			publicKey=businessPayConfigure.getZfbPublicKey();
		}
		//解密data
		TreeMap<String, String>	dataMap	= PaymobileUtils.decrypt(data, encryptkey,privateKey);

		buypaylogger.info("返回的明文参数：" + dataMap);

		//sign验签
		if(!PaymobileUtils.checkSign(dataMap,publicKey)) {
			out.println("sign 验签失败！");
			out.println("<br><br>dataMap:" + dataMap);
			buypaylogger.info("易宝支付 验签失败");
			return;
		}

		String merchOrderNo=(String) dataMap.get("orderid");//商户订单（我们的）
		String out_trade_no=merchOrderNo.substring(0,merchOrderNo.indexOf("_"));
		int status=Integer.valueOf(dataMap.get("status"));
    	String transaction_id=(String) dataMap.get("yborderid");//交易流水号
    	String total_fee=(String) dataMap.get("amount");//交易金额,单位为分
    	if (status==1) {
    		sbscPayService.payMentCallBack(null,null,null,out_trade_no, transaction_id, Double.parseDouble(total_fee)/100, popaytype, request, null);
		}
		//回写SUCCESS
		out.println("SUCCESS");
		out.flush();
		out.close();
		buypaylogger.info("易宝支付 结束");
	}
	
	
	/**
	 * 酷宝快捷支付 通知
	 * @throws IOException 
	 */
	@RequestMapping(value = {"yacolfastpaybacknotify"})
	@ResponseBody
	public void yacolFastPaybacknotify(HttpServletRequest request, HttpServletResponse response, Model mode)  {
		buypaylogger.info("酷宝快捷支付 通知开始");
		String sign=request.getParameter("sign");
		String sign_type = request.getParameter("sign_type");//
		 // 参数Map
        Map properties = Tools.getParameterMap(request,true);
		String like_result = Tools.createLinkString(properties, false);
		String _input_charset=request.getParameter("_input_charset");
		String signKey = "";
		String publicCheckKey = "";
		String trade_status = (String) properties.get("trade_status");//交易状态  PAY_FINISHED 已付款 TRADE_FAILED 失败 TRADE_FINISHED 结束(系统会异步通知)  
		BusinessPayConfigure businessPayConfigure=businessPayConfigureService.getDefaultByPaymentType(11);
		if(businessPayConfigure!=null){
			publicCheckKey=businessPayConfigure.getZfbKey();
		}else{
			MerchantConfig.getConfig().loadPropertiesFromSrc();
			publicCheckKey = MerchantConfig.getConfig().getPublicCheckKey();
		}
		
		try {
			if ("RSA".equalsIgnoreCase(sign_type.toString())) {
				signKey = publicCheckKey;
			}
			try {
				if (SignUtil.Check_sign(like_result.toString(),sign,sign_type,signKey,_input_charset )) 
				{
					if (trade_status.equals("PAY_FINISHED")) {//已付款(系统会异步通知)
						String outer_trade_no = (String) properties.get("outer_trade_no");//订单号
						outer_trade_no=outer_trade_no.substring(0,outer_trade_no.indexOf("_"));
						String inner_trade_no = (String) properties.get("inner_trade_no");//酷宝产生的交易凭证号
						String trade_amount = (String) properties.get("trade_amount");//交易金额
						sbscPayService.payMentCallBack(null,null,null,outer_trade_no, inner_trade_no, Double.parseDouble(trade_amount), "11", request, null);
					}
					response.setContentType("text/html;charset=UTF-8");
					response.getWriter().print("success");
				} else {
					response.setContentType("text/html;charset=UTF-8");
					response.getWriter().print("sign error!");
					buypaylogger.info("sign error！！！");
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		} catch (Exception e) {
			buypaylogger.info("非法请求！！！");
		}
		buypaylogger.info("酷宝快捷支付 通知结束");
	}
	
	
	
	/**
	 * 通联移动支付 通知
	 * @throws Exception 
	 * @throws NumberFormatException 
	 * @throws IOException 
	 */
	@RequestMapping(value = {"tonglianmobilepaybacknotify"})
	@ResponseBody
	public void tonglianMobilePaybacknotify(HttpServletRequest request, HttpServletResponse response, Model mode) throws NumberFormatException, Exception  {
		buypaylogger.info("通联移动支付 通知开始");
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html");
		PrintWriter out	= response.getWriter();
		
		String md5key="";
		BusinessPayConfigure businessPayConfigure=businessPayConfigureService.getDefaultByPaymentType(15);
		if(businessPayConfigure!=null){
			md5key=businessPayConfigure.getZfbKey();
		}
		 // 参数Map
        //Map properties = Tools.getParameterMap(request,false);
		//String like_result = Tools.createLink(properties, false);
		
		String merchantId=request.getParameter("merchantId");
		String version = request.getParameter("version");//
		String signType = request.getParameter("signType");//
		String payType = request.getParameter("payType");//
		String paymentOrderId = request.getParameter("paymentOrderId");//通联订单号  
		String orderNo = request.getParameter("orderNo");//商户订单号 
		String orderDatetime = request.getParameter("orderDatetime");//商户订单提交时间
		String orderAmount = request.getParameter("orderAmount");//商户订单金额
		String payDatetime = request.getParameter("payDatetime");//支付完成时间
		String payAmount = request.getParameter("payAmount");//订单实际支付金额
		String ext1 = request.getParameter("ext1");//
		String payResult = request.getParameter("payResult");//1：支付成功 0：未付款
		String returnDatetime = request.getParameter("returnDatetime");//系统返回支付结果的时间，日期格式 yyyyMMDDhhmmss
		String signMsg = request.getParameter("signMsg");//以上所有非空参数按上述顺序与密钥 key 组合，经加密后生成该值。
		
		StringBuilder inputString = new StringBuilder("");
		inputString.append("merchantId=" + merchantId);
		inputString.append("&version=" + version);
		inputString.append("&signType=" + signType);
		inputString.append("&payType=" + payType);
		inputString.append("&paymentOrderId=" + paymentOrderId);
		inputString.append("&orderNo=" + orderNo);
		inputString.append("&orderDatetime=" + orderDatetime);
		inputString.append("&orderAmount=" + orderAmount);
		inputString.append("&payDatetime=" + payDatetime);
		inputString.append("&payAmount=" + payAmount);
		inputString.append("&ext1=" + ext1);
		inputString.append("&payResult=" + payResult);
		inputString.append("&returnDatetime=" + returnDatetime);
		inputString.append("&key=" + md5key);
		buypaylogger.info("订单号："+orderNo);
		if (payResult.equals("1")) {
			String signmsg=SunMd5.md5(inputString.toString());
			if (signmsg.equalsIgnoreCase(signMsg)) {
				String outer_trade_no = orderNo;
				outer_trade_no=orderNo.substring(0,orderNo.indexOf("_"));//订单号
				String inner_trade_no = paymentOrderId;//流水号
				String trade_amount = orderAmount;//交易金额
				sbscPayService.payMentCallBack(null,null,null,outer_trade_no, inner_trade_no, Double.parseDouble(trade_amount)/100, "15", request, null);
			}else {
				buypaylogger.info("签名错误："+signmsg+",inputString:"+inputString);
			}
		}
		//回写SUCCESS
		out.println("SUCCESS");
		out.flush();
		out.close();
		buypaylogger.info("通联移动支付 通知结束");
		}
	
	/**
	 * 易宝微信支付 通知
	 * @throws Exception 
	 * @throws NumberFormatException 
	 * @throws IOException 
	 */
	@RequestMapping(value ={"yeewxpaybacknotify16","yeewxpaybacknotify17"})
	public void yeewxpaybacknotify(HttpServletRequest request, HttpServletResponse response, Model mode) throws NumberFormatException, Exception  {
		buypaylogger.info("易宝微信支付  通知开始");
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html");
		PrintWriter out	= response.getWriter();
		
		String popaytype="16";
		String sp=request.getServletPath();
		if (sp.contains("yeewxpaybacknotify17")) {
			popaytype="17";
		}
		
		String responseMsg = request.getParameter("response");
		String customerId = request.getParameter("customerIdentification");

		Map<String,String> result = YeepayService.callback(responseMsg);
		
		String parentMerchantNo = YeepayService.formatString(result.get("parentMerchantNo"));
		String merchantNo = YeepayService.formatString(result.get("merchantNo"));
		String orderId = YeepayService.formatString(result.get("orderId"));
		String uniqueOrderNo = YeepayService.formatString(result.get("uniqueOrderNo"));
		String status = YeepayService.formatString(result.get("status"));
		String orderAmount = YeepayService.formatString(result.get("orderAmount"));
		String payAmount = YeepayService.formatString(result.get("payAmount"));
		String requestDate = YeepayService.formatString(result.get("requestDate"));
		String paySuccessDate = YeepayService.formatString(result.get("paySuccessDate"));
		
		buypaylogger.info("result："+result);
		buypaylogger.info("订单号："+orderId);
		
		if (status.equals("SUCCESS")) {
			String outer_trade_no = orderId;
			outer_trade_no=outer_trade_no.substring(0,outer_trade_no.indexOf("_"));//订单号
			String inner_trade_no = uniqueOrderNo;//流水号
			String trade_amount = orderAmount;//交易金额
			sbscPayService.payMentCallBack(null,null,null,outer_trade_no, inner_trade_no, Double.parseDouble(trade_amount), popaytype, request, null);
		}
		//回写SUCCESS
		out.println("SUCCESS");
		out.flush();
		out.close();
		buypaylogger.info("易宝微信支付 通知结束");
	}
	
	
	/**
	 * json转map
	 */
	public static Map<String, String> jsonToMapString(String result){
		
		Map<String, String> data = new HashMap<String, String>();	
		JSONObject jsonObject = JSONObject.fromObject(result);
        Iterator<?> it = jsonObject.keys();  
        // 遍历jsonObject数据，添加到Map对象  
        while (it.hasNext()){  
           String key = String.valueOf(it.next());  
           String value = jsonObject.getString(key);  
           data.put(key, value);  
       }  
       return data;  
	}
	
	/**  
     * 分转换为元.  
     *   
     * @param fen  
     *            分  
     * @return 元  
     */  
    public static String fromFenToYuan(String fen) {  
        String yuan = "";  
        final int MULTIPLIER = 100;  
        Pattern pattern = Pattern.compile("^[1-9][0-9]*{1}");
        Matcher matcher = pattern.matcher(fen);  
        if (matcher.matches()) {  
            yuan = new BigDecimal(fen).divide(new BigDecimal(MULTIPLIER)).setScale(2).toString();  
        } else {  
            System.out.println("参数格式不正确!");  
        }  
        return yuan;  
    }
    
	/**
	 * 快钱支付 页面跳转
	 * @throws IOException 
	 */
	@RequestMapping(value = {"billPaySuccess"})
	public String billPaySuccess(HttpServletRequest request, HttpServletResponse response, Model model) {
		String orderId=(String)request.getParameter("orderId");
		String orderAmount=(String)request.getParameter("orderAmount");
		String dealId=(String)request.getParameter("dealId");
		String orderTime=(String)request.getParameter("orderTime");
		String payResult=(String)request.getParameter("payResult");
		String msg=(String)request.getParameter("msg");
		model.addAttribute("orderId", orderId);
		model.addAttribute("orderAmount", orderAmount);
		model.addAttribute("dealId", dealId);
		model.addAttribute("orderTime", orderTime);
		model.addAttribute("payResult", payResult);
		model.addAttribute("msg", msg);
		return "modules/h5/billPaySuccess";
	 }	

	
	/**
	 * 微信h5支付 页面跳转
	 * @throws IOException 
	 */
	@RequestMapping(value = {"wxh5PaySuccess"})
	public String wxh5PaySuccess(HttpServletRequest request, HttpServletResponse response, Model model) {
		return "modules/h5/wxh5_success";
	 }
	
	
 
	 
}
	
	
 
