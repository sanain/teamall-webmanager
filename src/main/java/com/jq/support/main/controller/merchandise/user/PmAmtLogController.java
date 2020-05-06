package com.jq.support.main.controller.merchandise.user;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jq.support.service.merchandise.shop.PmShopInfoService;
import com.jq.support.service.utils.FormatUtil;
import org.apache.commons.collections.CollectionUtils;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.openxmlformats.schemas.spreadsheetml.x2006.main.CTRow;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.jq.support.common.config.Global;
import com.jq.support.common.persistence.Page;
import com.jq.support.common.utils.StringUtils;
import com.jq.support.common.web.BaseController;
import com.jq.support.model.message.EbMessage;
import com.jq.support.model.pay.BusinessPayConfigure;
import com.jq.support.model.product.PmShopInfo;
import com.jq.support.model.sys.SysUser;
import com.jq.support.model.user.EbUserMoney;
import com.jq.support.model.user.EbUser;
import com.jq.support.model.user.PmAmtLog;
import com.jq.support.model.user.PmUserOfflineRechargeLog;
import com.jq.support.service.merchandise.user.EbUserMoneyService;
import com.jq.support.service.merchandise.user.EbUserService;
import com.jq.support.service.merchandise.user.PmAmtLogService;
import com.jq.support.service.merchandise.user.PmUserOfflineRechargeLogService;
import com.jq.support.service.message.EbMessageService;
import com.jq.support.service.pay.BusinessPayConfigureService;

import com.jq.support.service.utils.DateUtil;
import com.jq.support.service.utils.RandomNumber;
import com.jq.support.service.utils.SysUserUtils;
import net.sf.json.JSONObject;

/**
 * 用户提现列表功能
 * 御可贡茶_用户余额日志 Controller
 * @author Li-qi
 */
@Controller
@RequestMapping(value = "${adminPath}/UserAmtLog")
public class PmAmtLogController extends BaseController {

	private static String domainurl = Global.getConfig("domainurl");

	@Autowired
	private PmAmtLogService pmAmtLogService;
	@Autowired
	private EbUserService ebUserService;
	@Autowired
	private EbUserMoneyService ebExpandService;
	@Autowired
	private PmUserOfflineRechargeLogService pmUserOfflineRechargeLogService;
	@Autowired
	private EbMessageService ebMessageService;
	@Autowired
	private BusinessPayConfigureService businessPayConfigureService;
	@Autowired
	private PmShopInfoService pmShopInfoService;

	@ModelAttribute
	public PmAmtLog get(@RequestParam(required=false) String id) {
		if (org.apache.commons.lang3.StringUtils.isNotBlank(id)){
			return pmAmtLogService.get(Integer.valueOf(id));
		}else{
			return new PmAmtLog();
		}
	}

	@RequiresPermissions("merchandise:UserAmtLog:view")
	@RequestMapping(value ={"list",""})
	public String list(HttpServletRequest request, HttpServletResponse response, Model model){
		String phoneNum= request.getParameter("phoneNum");
		String mobile= request.getParameter("mobile");
		String startTime=request.getParameter("startTime");
		String endTime=request.getParameter("endTime");
		String status=request.getParameter("status");
		String messageid = request.getParameter("id");
		String shopIds = request.getParameter("shopIds");

		PmAmtLog pmAmtLog=new PmAmtLog();
		if(StringUtils.isNotBlank(status)){
			pmAmtLog.setStatus(Integer.valueOf(status));
		}
		if(StringUtils.isNotBlank(shopIds)){
			List<EbUser> ebUserList = ebUserService.getByShopIds(shopIds);
			if(CollectionUtils.isNotEmpty(ebUserList)){
				String userIds = FormatUtil.getFieldAllValue(ebUserList, "userId");
				pmAmtLog.setUserIds(userIds);
			}
		}
		pmAmtLog.setAmtType(4);
		Page<PmAmtLog>page=pmAmtLogService.findPmAmtLogList(mobile,phoneNum, startTime, endTime,"", pmAmtLog, new Page<PmAmtLog>(request, response));
		for(PmAmtLog pmAmtLog1:page.getList()){

			if(pmAmtLog1.getEbUser() != null && pmAmtLog1.getEbUser().getShopId() != null){
				PmShopInfo pmShopInfo = pmShopInfoService.getpmPmShopInfo(pmAmtLog1.getEbUser().getShopId().toString());
				pmAmtLog1.setPmShopInfo(pmShopInfo);
			}


		}
		model.addAttribute("page", page);
		model.addAttribute("phoneNum", phoneNum);
		model.addAttribute("mobile", mobile);
		model.addAttribute("startTime", startTime);
		model.addAttribute("endTime", endTime);
		model.addAttribute("status", status);

		if(StringUtils.isNotBlank(messageid)){
			EbMessage message = ebMessageService.get(Integer.parseInt(messageid));
			message.setIsRead(1);
			ebMessageService.saveflush(message);
		}

		String shopNames = pmShopInfoService.getNamesByIds(shopIds);
		model.addAttribute("shopNames",shopNames);
		model.addAttribute("shopIds",shopIds);
		return "modules/shopping/user/userAmtLogList";
	}

	@RequiresPermissions("merchandise:UserAmtLog:view")
	@ResponseBody
	@RequestMapping(value ="form")
	public Map form(HttpServletRequest request, HttpServletResponse response){
		String id= request.getParameter("id");
		Map map=new HashMap();
		PmAmtLog pmAmt=pmAmtLogService.get(Integer.valueOf(id));
		map.put("pmAmt",pmAmt);
		map.put("pmUserBank",pmAmt.getPmUserBank());
		return map;

//		JSONObject pmAmtLog1 = JSONObject.fromObject(pmAmt);
//		String pmAmtLog=String.valueOf(pmAmtLog1);
//        return pmAmtLog;
	}

	@ResponseBody
	@RequiresPermissions("merchandise:UserAmtLog:edit")
	@RequestMapping(value ="edit")
	public String edit(PmAmtLog pmAmtLog,HttpServletRequest request, HttpServletResponse response,RedirectAttributes redirectAttributes) throws ServletException, IOException{
		String id= request.getParameter("id");
		String status= request.getParameter("Vstatus");//1.同意 2.拒绝 3.银行打款
		SysUser user = SysUserUtils.getUser();
		PmAmtLog pmAmt=pmAmtLogService.get(Integer.valueOf(id));
		if(pmAmt!=null&&pmAmt.getAmtType()==4&&pmAmt.getStatus()==0){//交易状态：0交易中，1交易完成，2交易取消
			if(StringUtils.isNotBlank(status)){
				Date nowTime=new Date();
				EbUser ebUser=ebUserService.getModel(pmAmt.getEbUser().getMobile());
				//拓展
				EbUserMoney ebExpand=ebExpandService.getEbExpandByUserId(ebUser.getUserId());


				if(status.equals("1")){//1.同意
					pmAmt.setStatus(1);
					pmAmt.setModifyTime(nowTime);
					pmAmt.setModifyUser(user.getLoginName());
					pmAmt.setRemark(pmAmtLog.getRemark()+"，提现成功。");
					pmAmtLogService.save(pmAmt);
//						ebUser.setCurrentAmt(ebUser.getCurrentAmt()-pmAmt.getAmt());
					if (ebUser!=null) {
//							ebExpand.setFrozenAmt(ebExpand.getFrozenAmt()-Math.abs(pmAmt.getAmt()));
						ebExpandService.saveFlush(ebExpand,0.0,-Math.abs(pmAmt.getAmt()),0.0,0.0,0.0,0.0,"提现成功冻结金额变化");
						ebExpandService.saveFlush(ebExpand,-Math.abs(pmAmt.getAmt()));
						pmAmtLogService.save(pmAmt);
						String title="提现申请已审核通过！";
						String count="您申请提现"+pmAmt.getAmt()+"元已审核通过，提现金额会自动转入您申请的提现账户，请留意到账！";
						String img="/uploads/drawable-xhdpi/tzxx.png";
						ebMessageService.chuandis(null,ebUser,"消息提醒", title, count, img, 2, 5);
					}
				}
				if(status.equals("2")){// 2.拒绝
					pmAmt.setStatus(2);
					pmAmt.setModifyTime(nowTime);
					pmAmt.setModifyUser(user.getLoginName());
					pmAmt.setRemark(pmAmtLog.getRemark()+"，拒绝提现。");
					pmAmtLogService.save(pmAmt);

					String remark= request.getParameter("remark");
						/*PmAmtLog newpmAmt=new PmAmtLog();
						newpmAmt=pmAmt;
						if(StringUtils.isNotBlank(remark)){
							newpmAmt.setRemark("拒绝提现原因："+remark+"，交易取消");
						}
						newpmAmt.setId(null);
						newpmAmt.setStatus(1);
						newpmAmt.setAmtType(14);
						newpmAmt.setCreateUser(user.getLoginName());
						newpmAmt.setCreateTime(nowTime);
						pmAmtLogService.save(newpmAmt);*/
					if (ebUser!=null) {
//							ebExpand.setFrozenAmt(ebExpand.getFrozenAmt()-Math.abs(pmAmt.getAmt()));
						//ebUser.setCurrentAmt(ebUser.getCurrentAmt()+Math.abs(pmAmt.getAmt()));
						ebExpandService.saveFlush(ebExpand,0.0,-Math.abs(pmAmt.getAmt()),0.0,0.0,0.0,0.0,"拒绝提醒冻结金额变化");
						ebExpandService.saveFlush(ebExpand, 0.0,Math.abs(pmAmt.getAmt()), Math.abs(pmAmt.getAmt()), "拒绝提现返回", Math.abs(pmAmt.getAmt()));
						String title="提现申请审核不通过！";
						String count="您申请提现"+pmAmt.getAmt()+"元审核不通过，理由是："+remark+"。如需帮助，请联系平台客服。";
						String img="/uploads/drawable-xhdpi/tzxx.png";
						ebMessageService.chuandis(null,ebUser,"消息提醒", title, count, img, 2, 5);
					}
				}
			}
		}
		return "redirect:"+Global.getAdminPath()+"/UserAmtLog";
	}

	@ResponseBody
	@RequestMapping(value = "piEdit")
	public String piEdit(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String ids= request.getParameter("ids");
		System.out.println(ids);
		String status= request.getParameter("status");//1.同意(手动打款) 2.拒绝  3.银行打款
		SysUser user = SysUserUtils.getUser();
		BusinessPayConfigure businessPayConfigure=null;
		if(status.equals("3")){
			businessPayConfigure=businessPayConfigureService.getDefaultByPaymentType(-1);//打款通道
		}
		if(StringUtils.isNotBlank(ids)){
			String idv[]=ids.split(",");
			for (int i = 0; i < idv.length; i++) {
				if(idv[i]!=null){
					PmAmtLog pmAmt=pmAmtLogService.get(Integer.valueOf(idv[i]));
					if(pmAmt.getAmtType()==4&&pmAmt.getStatus()==0){//交易状态：0交易中，1交易完成，2交易取消
						EbUser ebUser=ebUserService.getEbUserById(pmAmt.getUserId());//ebUserService.getModel(pmAmt.getEbUser().getMobile());
						//拓展
						EbUserMoney ebExpand=ebExpandService.getEbExpandByUserId(ebUser.getUserId());

						if(status.equals("1")){
							pmAmt.setStatus(1);
							pmAmt.setModifyTime(new Date());
							pmAmt.setModifyUser(user.getLoginName());
							pmAmt.setRemark("提现成功。");
							pmAmtLogService.save(pmAmt);
							if (ebUser!=null) {
//							ebExpand.setFrozenAmt(ebExpand.getFrozenAmt()-pmAmt.getAmt());
								ebExpandService.saveFlush(ebExpand,0.0,-pmAmt.getAmt(),0.0,0.0,0.0,0.0,"提现成功冻结金额变化");
								pmAmtLogService.save(pmAmt);
								String title="提现申请已审核通过！";
								String count="您申请提现"+pmAmt.getAmt()+"元已审核通过，提现金额会自动转入您申请的提现账户，请留意到账！";
								String img="/uploads/drawable-xhdpi/tzxx.png";
								ebMessageService.chuandis(null,ebUser,"消息提醒", title, count, img, 2, 5);
							}
						}else if(status.equals("2")){//拒绝
							pmAmt.setStatus(2);
							pmAmt.setModifyTime(new Date());
							pmAmt.setModifyUser(user.getLoginName());
							pmAmt.setRemark("拒绝提现。");
							pmAmtLogService.save(pmAmt);

							String remark= request.getParameter("remark");
							if (ebUser!=null) {
//							ebExpand.setFrozenAmt(ebExpand.getFrozenAmt()-pmAmt.getAmt());
								//ebUser.setCurrentAmt(ebUser.getCurrentAmt()+pmAmt.getAmt());
								ebExpandService.saveFlush(ebExpand,0.0,-pmAmt.getAmt(),0.0,0.0,0.0,0.0,"拒绝提醒冻结金额变化");
								ebExpandService.saveFlush(ebExpand, 0.0,Math.abs(pmAmt.getAmt()), Math.abs(pmAmt.getAmt()), "拒绝提现返回", Math.abs(pmAmt.getAmt()));
								String title="提现申请审核不通过！";
								String count="您申请提现"+pmAmt.getAmt()+"元审核不通过，理由是："+remark+"。如需帮助，请联系平台客服。";
								String img="/uploads/drawable-xhdpi/tzxx.png";
								ebMessageService.chuandis(null,ebUser,"消息提醒", title, count, img, 2, 5);
							}
						}
					}
				}
			}
		}
		return "00";
	}
	@SuppressWarnings("deprecation")
	@ResponseBody
	@RequestMapping(value = "exsel")
	public String exsel(HttpServletRequest request, HttpServletResponse response) {
		String url="";
		String syllable[]= request.getParameterValues("syllable");
		if(syllable!=null&&syllable.length>0){
			int t=1;
			int pageNo=1;
			int rowNum=1;
			int rowNums=100;
			HSSFWorkbook wb = new HSSFWorkbook();
			HSSFSheet sheet = wb.createSheet("用户提现表");


			HSSFRow row = sheet.createRow((int) 0);


			HSSFCellStyle style = wb.createCellStyle();
			style.setWrapText(true);
			style.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 创建一个居中格式

			HSSFCell cell = row.createCell((short) 0);
			cell.setCellValue("序号");
			cell.setCellStyle(style);
			for (int i = 0; i < syllable.length; i++) {
				cell = row.createCell((short) i);
				if(syllable[i].equals("1")){
					cell.setCellValue("申请时间");
				}
				if(syllable[i].equals("2")){
					cell.setCellValue("类型");
				}
				if(syllable[i].equals("3")){
					cell.setCellValue("开户名");
				}
				if(syllable[i].equals("4")){
					cell.setCellValue("银行卡号");
				}
				if(syllable[i].equals("5")){
					cell.setCellValue("开户银行");
				}
				if(syllable[i].equals("6")){
					cell.setCellValue("所属支行");
				}
				if(syllable[i].equals("7")){
					cell.setCellValue("状态");
				}
				if(syllable[i].equals("8")){
					cell.setCellValue("可提现金额");
				}
				if(syllable[i].equals("9")){
					cell.setCellValue("现申请提现金额");
				}
				if(syllable[i].equals("10")){
					cell.setCellValue("用户账号");
				}
				if(syllable[i].equals("11")){
					cell.setCellValue("提现编码");
				}

				cell.setCellStyle(style);
			}
			while(t==1){
				String mobile= request.getParameter("mobile");
				String phoneNum= request.getParameter("phoneNum");
				String startTime=request.getParameter("startTime");
				String endTime=request.getParameter("endTime");
				String status=request.getParameter("status");
				String ids=request.getParameter("ids");
				PmAmtLog pmAmtLog=new PmAmtLog();
				if(StringUtils.isNotBlank(status)){
					pmAmtLog.setStatus(Integer.valueOf(status));
				}
				pmAmtLog.setAmtType(4);
				Page<PmAmtLog>page=pmAmtLogService.findPmAmtLogList(mobile,phoneNum, startTime, endTime,ids, pmAmtLog, new Page<PmAmtLog>(pageNo, rowNums));
				List<PmAmtLog> amtLogs=new ArrayList<PmAmtLog>();
				amtLogs=page.getList();
				if ((page.getCount() == rowNums && pageNo > 1)
						|| (page.getCount() / rowNums) < 1 && pageNo > 1) {
					amtLogs = null;
				}
				if(amtLogs!=null&&amtLogs.size()>0){
					for (PmAmtLog amtLog : amtLogs) {
						try {
							//SmsUserblacklist userblacklist=smsUserblacklists.get(i);
							row = sheet.createRow((int) rowNum);
							row.createCell((short) 0).setCellValue(rowNum);

							for (int i = 0; i < syllable.length; i++) {
//								HSSFCell c = row.createCell((short) i);
//								c.setCellType(style);
								HSSFCell c = row.createCell((short) i);
								c.setCellStyle(style);
								if(syllable[i].equals("1")){
									c.setCellValue(amtLog.getCreateTime().toString());
								}
								if(syllable[i].equals("2")){
									String type="";
									if(amtLog.getPmUserBank().getBankType()==0){
										type="银行卡";
									}else{
										type="支付宝";
									}
									c.setCellValue(type);
								}
								if(syllable[i].equals("3")){
									c.setCellValue(amtLog.getPmUserBank().getAccountName());
								}
								if(syllable[i].equals("4")){
									c.setCellValue(amtLog.getPmUserBank().getAccount());
								}
								if(syllable[i].equals("5")){
									c.setCellValue(amtLog.getPmUserBank().getBankName());
								}
								if(syllable[i].equals("6")){
									c.setCellValue(amtLog.getPmUserBank().getSubbranchName());
								}
								if(syllable[i].equals("7")){
									String ststus="";
									if(amtLog.getStatus()==0){
										ststus="待审核";
									}else if(amtLog.getStatus()==1){
										ststus="已完成";
									}else if(amtLog.getStatus()==3){
										ststus="审核完成";
									}else{
										ststus="已取消";
									}
									c.setCellValue(ststus);
								}
								if(syllable[i].equals("8")){
									c.setCellValue(amtLog.getCurrentAmt()==null?0.0:amtLog.getCurrentAmt());
								}
								if(syllable[i].equals("9")){
									c.setCellValue(amtLog.getAmt()==null?0.0:amtLog.getAmt());
								}
								if(syllable[i].equals("10")){
									c.setCellValue(amtLog.getEbUser().getMobile());
								}
								if(syllable[i].equals("11")){
									c.setCellValue(amtLog.getApplycode());
//									c.setCellValue("11111");
								}


							}
						} catch (Exception e) {
							/*System.out.print(e.getCause());*/
						}
						rowNum++;
					}
					pageNo++;
				}else{
					t=2;
				}
			}

			String RootPath = request.getSession().getServletContext().getRealPath("/").replace("\\", "/");
			String path = "upload/xlsfile/tempfile";
			Random r = new Random();
			String strfileName = DateUtil.getDateFormat(new Date(),"yyyyMMddHHmmss") + r.nextInt();
			File f = new File(RootPath + path);
			if (!f.exists())
				f.mkdirs();
			String tempPath = RootPath + path + "/" + strfileName + ".xls";
			try
			{
				FileOutputStream fout = new FileOutputStream(tempPath);


//				int d = (int)(68*256/syllable.length);
//                sheet.setAutobreaks(true);
//                sheet.setDefaultColumnWidth(d);
//                for(int i = 0; i<= rowNum ; i++){
//                    sheet.setColumnWidth(rowNum,500);
//                }
				//3.output
//				sheet.setDisplayGridlines(false);
//				sheet.setPrintGridlines(false);
				HSSFPrintSetup printSetup = sheet.getPrintSetup();
//                printSetup.setFitWidth((short) 500);
				//A4纸
				printSetup.setPaperSize(HSSFPrintSetup.A4_PAPERSIZE);

				wb.write(fout);
				fout.close();
				url= domainurl+"/" + path + "/" + strfileName + ".xls";
			}
			catch (Exception e)
			{
				e.printStackTrace();
			}
		}else{

		}
		return url;
	}

	@RequiresPermissions("merchandise:UserAmtLog:view")
	@RequestMapping(value ="pageAmtLog")
	public String pageAmtLog(HttpServletRequest request, HttpServletResponse response, Model model){
//		String phoneNum= request.getParameter("phoneNum");
		String startTime=request.getParameter("startTime");
		String endTime=request.getParameter("endTime");
		String status=request.getParameter("status");
		String amtType=request.getParameter("amtType");
		PmAmtLog pmAmtLog=new PmAmtLog();
		if(StringUtils.isNotBlank(status)){
			pmAmtLog.setStatus(Integer.valueOf(status));
		}
		if(StringUtils.isNotBlank(amtType)){
			pmAmtLog.setAmtType(Integer.valueOf(amtType));
		}
		Page<PmAmtLog>page=pmAmtLogService.findPmAmtLogList("","", startTime, endTime,"", pmAmtLog, new Page<PmAmtLog>(request, response));
		model.addAttribute("page", page);
//		model.addAttribute("phoneNum", phoneNum);
		model.addAttribute("startTime", startTime);
		model.addAttribute("endTime", endTime);
		model.addAttribute("status", status);
		model.addAttribute("amtType", amtType);
		return "modules/shopping/user/amtLogList";
	}

	@RequiresPermissions("merchandise:UserAmtLog:view")
	@RequestMapping(value ="balanceStatistics")
	public String balanceStatistics(HttpServletRequest request, HttpServletResponse response, Model model){
//		String phoneNum= request.getParameter("phoneNum");
		String startTime=request.getParameter("startTime");
		String endTime=request.getParameter("endTime");
		String status=request.getParameter("status");
		String amtType=request.getParameter("amtType");
		PmAmtLog pmAmtLog=new PmAmtLog();
		if(StringUtils.isNotBlank(status)){
			pmAmtLog.setStatus(Integer.valueOf(status));
		}
		if(StringUtils.isNotBlank(amtType)){
			pmAmtLog.setAmtType(Integer.valueOf(amtType));
		}
		Page<PmAmtLog>page=pmAmtLogService.findPmAmtLogList("","", startTime, endTime,"", pmAmtLog, new Page<PmAmtLog>(request, response));
		model.addAttribute("page", page);
//		model.addAttribute("phoneNum", phoneNum);
		model.addAttribute("startTime", startTime);
		model.addAttribute("endTime", endTime);
		model.addAttribute("status", status);
		model.addAttribute("amtType", amtType);
		return "modules/shopping/user/balanceList";
	}

	@RequiresPermissions("merchandise:UserAmtLog:view")
	@RequestMapping(value ="onlineRechargeList")
	public String onlineRechargeList(HttpServletRequest request, HttpServletResponse response, Model model,RedirectAttributes redirectAttributes){
		String mobile= request.getParameter("mobile");
		String startTime=request.getParameter("startTime");
		String endTime=request.getParameter("endTime");
		PmAmtLog pmAmtLog=new PmAmtLog();
		pmAmtLog.setStatus(1);
		pmAmtLog.setAmtType(9);
		Page<PmAmtLog>page=pmAmtLogService.findPmAmtLogList(mobile,"", startTime, endTime, "",pmAmtLog, new Page<PmAmtLog>(request, response));
		model.addAttribute("page", page);
		model.addAttribute("mobile", mobile);
		model.addAttribute("startTime", startTime);
		model.addAttribute("endTime", endTime);
		List<EbUser>userlist=ebUserService.getEbUserList(0, 10,new EbUser());
		if(userlist.size()>0){
			String userCount=ebUserService.getCount(new EbUser());
			int pageCount=0;
			if(Integer.valueOf(userCount)<=10){
				pageCount=1;
			}else {
				pageCount=Integer.valueOf(userCount)/10;
				Integer pageCount2=Integer.valueOf(userCount)%10;
				if(pageCount2>0){
					pageCount=pageCount+1;
				}
			}
			model.addAttribute("userlist",userlist);
			model.addAttribute("userpageNo", 1);
			model.addAttribute("userpageSize", 10);
			model.addAttribute("userCount", userCount);
			model.addAttribute("pageCount", pageCount);
		}
		return "modules/shopping/user/onlineRechargeList";
	}

	@RequiresPermissions("merchandise:UserAmtLog:view")
	@ResponseBody
	@RequestMapping(value ="userPage")
	public String userPage(HttpServletRequest request, HttpServletResponse response){
		String usermobile= request.getParameter("usermobile");
		String userstatus=request.getParameter("userstatus");
//		String oldpageCount=request.getParameter("pageCount");
		String userpageNo=request.getParameter("userpageNo");
		String userpageSize=request.getParameter("userpageSize");

		String data="";
		JSONObject json=new JSONObject();
		Boolean flag=false;

		EbUser parameter=new EbUser();
		if(StringUtils.isNotBlank(usermobile)){
			parameter.setMobile(usermobile);
			json.put("usermobile", usermobile);
		}else {
			json.put("usermobile", "");
		}
		if(StringUtils.isNotBlank(userstatus)){
			parameter.setStatus(Integer.valueOf(userstatus));
			json.put("userstatus", userstatus);
		}else {
			json.put("userstatus", "");
		}
		String userCount=ebUserService.getCount(parameter);
		Integer stateNum = 0;// 开始行数
//		Integer endNum = 10;// 结束行数
		if (StringUtils.isNotBlank(userpageNo)&&StringUtils.isNotBlank(userpageSize)) {
			if(Integer.parseInt(userpageNo)>1){
				if(Integer.valueOf(userpageSize)<=Integer.valueOf(userCount)){
					stateNum = (Integer.parseInt(userpageNo)-1)*Integer.parseInt(userpageSize);
				}
			}
		}
//		if(oldpageCount.equals(userpageNo)){
//			endNum = Integer.parseInt(userCount);
//		}else {
//			if (StringUtils.isNotBlank(userpageSize)) {
//				if(!userpageNo.equals("1")){
//					if (StringUtils.isNotBlank(userpageNo)) {
//						endNum = (Integer.parseInt(userpageNo)+1)*Integer.parseInt(userpageSize);
//					}
//					if (StringUtils.isBlank(userpageNo)) {
//						endNum = Integer.parseInt(userCount);
//					}
//				}
//			}
//		}
		List<EbUser>userlist=ebUserService.getEbUserList(stateNum, Integer.parseInt(userpageSize), parameter);
		if(CollectionUtils.isNotEmpty(userlist)){
			for(EbUser pffice:userlist){
				pffice.setOffice(null);
			}
			json.put("userlist", userlist);
			if(StringUtils.isNotBlank(userpageNo)){
				if(Integer.valueOf(userpageSize)<=Integer.valueOf(userCount)){
					json.put("userpageNo", userpageNo);
				}else {
					json.put("userpageNo", 1);
				}
			}else {
				json.put("userpageNo", 1);
			}
			if(StringUtils.isNotBlank(userpageSize)){
				json.put("userpageSize", userpageSize);
			}else {
				json.put("userpageSize", 10);
			}
			flag=true;
			int pageCount=0;
			if(Integer.valueOf(userCount)<=Integer.valueOf(userpageSize)){
				pageCount=1;
			}else {
				pageCount=Integer.valueOf(userCount)/10;
				Integer pageCount2=Integer.valueOf(userCount)%10;
				if(pageCount2>0){
					pageCount=pageCount+1;
				}
			}
			json.put("pageCount", pageCount);
			json.put("userCount", userlist.size());
		}else {
			json.put("userpageNo", 1);
			json.put("userpageSize", 10);
			json.put("pageCount", 0);
			json.put("userCount", 0);
		}
		json.put("flag", flag);
		data=json.toString();
		return data;
	}

	@RequiresPermissions("merchandise:UserAmtLog:edit")
	@ResponseBody
	@RequestMapping(value ="onlineRechargeadds")
	public String onlineRechargeadds(HttpServletRequest request, HttpServletResponse response){
		String contents= request.getParameter("contents");

		String data="";
		JSONObject json=new JSONObject();
		Map<String , Object>map=new HashMap<String, Object>();
		List<Map<String, Object>>listmap=new ArrayList<Map<String,Object>>();
		Boolean flag=false;
		String url="";
		String msg="";
		if(StringUtils.isBlank(contents)){
			msg="请填写数据";
			json.put("flag", flag);
			json.put("msg", msg);
			data=json.toString();
			return data;
		}else {
			contents = contents.replaceAll("，",",");
			contents = contents.replaceAll(" ","\n");
			String content1[]=contents.split("\n");
			if(content1.length==0||content1==null){
				msg="请填写数据";
				json.put("flag", flag);
				json.put("msg", msg);
				data=json.toString();
				return data;
			}else {
				for (int i = 0; i < content1.length; i++) {
					String content2=content1[i];
					if(StringUtils.isBlank(content2)){
						msg="请填写数据";
						json.put("flag", flag);
						json.put("msg", msg);
						data=json.toString();
						return data;
					}else {
						String content3[]=content2.split(",");
						if(content3.length==0||content3==null){
							msg="请填写数据";
							json.put("flag", flag);
							json.put("msg", msg);
							data=json.toString();
							return data;
						}else if(content3.length==1){
							msg="参数有误，请输入金额;位置："+content2;
							json.put("flag", flag);
							json.put("msg", msg);
							data=json.toString();
							return data;
						}else {
							String mobile=content3[0];
							String amt=content3[1];
							if(StringUtils.isBlank(mobile)){
								msg="参数有误，请输入会员;位置："+content2;
								json.put("flag", flag);
								json.put("msg", msg);
								data=json.toString();
								return data;
							}else if (ebUserService.isMobile(mobile) == false) {
								msg="参数有误，请检查会员;位置："+content2;
								json.put("flag", flag);
								json.put("msg", msg);
								data=json.toString();
								return data;
							}else if(StringUtils.isBlank(amt)){
								msg="参数有误，请输入金额;位置："+content2;
								json.put("flag", flag);
								json.put("msg", msg);
								data=json.toString();
								return data;
							}
							Double amtDouble=0.0;
							try {
								amtDouble=Double.parseDouble(amt);
							} catch (Exception e) {
								msg="参数有误，请检查输入的金额;位置："+content2;
								json.put("flag", flag);
								json.put("msg", msg);
								data=json.toString();
								return data;
							}
							if(amtDouble<=0){
								msg="参数有误，充值金额要大于0;位置："+content2;
								json.put("flag", flag);
								json.put("msg", msg);
								data=json.toString();
								return data;
							}else {
								EbUser ebUser=ebUserService.getModel(mobile);
								if(ebUser==null){
									msg="该帐户不存在;位置："+content2;
									json.put("flag", flag);
									json.put("msg", msg);
									data=json.toString();
									return data;
								}else {
									if(ebUser.getStatus()==2){
										msg="该会员已被禁用;位置："+content2;
										json.put("flag", flag);
										json.put("msg", msg);
										data=json.toString();
										return data;
									}else {
										map.put("mobile", mobile);
										map.put("amt", amt);
										listmap.add(map);
									}
								}
							}
						}
					}
				}
			}
		}
		if(listmap.size()>0){
			for (int i = 0; i < listmap.size(); i++) {
				EbUser ebUser=ebUserService.getModel(listmap.get(i).get("mobile").toString());
				//拓展
				EbUserMoney ebExpand=ebExpandService.getEbExpandByUserId(ebUser.getUserId());

				//ebUser.setCurrentAmt(ebUser.getCurrentAmt()+Double.parseDouble(listmap.get(i).get("amt").toString()));
//				ebExpand.setTotalAmt(ebExpand.getTotalAmt()+Double.parseDouble(listmap.get(i).get("amt").toString()));

				PmAmtLog pmAmtLog=new PmAmtLog();
				pmAmtLog.setUserId(ebExpand.getUserId());
				pmAmtLog.setAmt(Double.parseDouble(listmap.get(i).get("amt").toString()));
				pmAmtLog.setRemark("后台充值");
				pmAmtLog.setStatus(1);
				pmAmtLog.setAmtType(9);
				pmAmtLog.setCreateTime(new Date());
				SysUser user = SysUserUtils.getUser();
				pmAmtLog.setCreateUser(user.getName());
				ebExpandService.saveFlush(ebExpand,0.0,0.0,0.0,0.0,0.0,Double.parseDouble(listmap.get(i).get("amt").toString()),"后台充值累计总额变化");
				ebExpandService.saveFlush(ebExpand, 0.0,Double.parseDouble(listmap.get(i).get("amt").toString()),Double.parseDouble(listmap.get(i).get("amt").toString()), "后台充值",0.0);
				pmAmtLogService.save(pmAmtLog);

				flag=true;
				msg="充值成功";
				url=domainurl+Global.getAdminPath()+"/UserAmtLog/onlineRechargeList";
				json.put("flag", flag);
				json.put("msg", msg);
				json.put("url",url);
				data=json.toString();
			}
		}
		flag=true;
		url=domainurl+Global.getAdminPath()+"/UserAmtLog/onlineRechargeList";
		return data;
	}

	@RequiresPermissions("merchandise:UserAmtLog:edit")
	@RequestMapping(value ="onlineRechargeAdd")
	public String onlineRechargeAdd(HttpServletRequest request, HttpServletResponse response, Model model,RedirectAttributes redirectAttributes){
		String addmobile= request.getParameter("addmobile");
		String addamt=request.getParameter("addamt");
		EbUser ebUser=ebUserService.getModel(addmobile);
		//拓展
		EbUserMoney ebExpand=ebExpandService.getEbExpandByUserId(ebUser.getUserId());

		if(ebUser!=null){
			if(ebUser.getStatus()==2){
				addMessage(redirectAttributes, "该会员已被禁用");
			}else {
				//ebUser.setCurrentAmt(ebUser.getCurrentAmt()+Double.parseDouble(addamt));
//				ebExpand.setTotalAmt(ebExpand.getTotalAmt()+Double.parseDouble(addamt));

				PmAmtLog pmAmtLog=new PmAmtLog();
				pmAmtLog.setUserId(ebUser.getUserId());
				pmAmtLog.setAmt(Double.parseDouble(addamt));
				pmAmtLog.setRemark("后台充值");
				pmAmtLog.setStatus(1);
				pmAmtLog.setAmtType(9);
				pmAmtLog.setCreateTime(new Date());
				SysUser user = SysUserUtils.getUser();
				pmAmtLog.setCreateUser(user.getName());
				ebExpandService.saveFlush(ebExpand,0.0,0.0,0.0,0.0,0.0,+Double.parseDouble(addamt),"后台充值累计总额变化");
				ebExpandService.saveFlush(ebExpand, 0.0,Double.parseDouble(addamt),Double.parseDouble(addamt), "后台充值",0.0);
				pmAmtLogService.save(pmAmtLog);
				addMessage(redirectAttributes, "充值成功");
			}
		}else {
			addMessage(redirectAttributes, "没有该会员");
		}
		return "redirect:"+Global.getAdminPath()+"/UserAmtLog/onlineRechargeList";
	}

	@RequiresPermissions("merchandise:UserAmtLog:view")
	@RequestMapping(value ="lineRechargeList")
	public String lineRechargeList(HttpServletRequest request, HttpServletResponse response, Model model,RedirectAttributes redirectAttributes){
		String mobile= request.getParameter("mobile");
		String accountName= request.getParameter("accountName");
		String applyCode= request.getParameter("applyCode");
		String status= request.getParameter("status");
		String startTime=request.getParameter("startTime");
		String endTime=request.getParameter("endTime");
		PmUserOfflineRechargeLog pameter=new PmUserOfflineRechargeLog();
		if(StringUtils.isNotBlank(mobile)){
			pameter.setMobile(mobile);
		}
		if(StringUtils.isNotBlank(accountName)){
			pameter.setAccountName(accountName);
		}
		if(StringUtils.isNotBlank(applyCode)){
			pameter.setApplyCode(applyCode);
		}
		if(StringUtils.isNotBlank(status)){
			pameter.setStatus(Integer.valueOf(status));
		}
		Page<PmUserOfflineRechargeLog>page=pmUserOfflineRechargeLogService.pagePmUserOfflineRechargeLog(startTime, endTime, pameter, new Page<PmUserOfflineRechargeLog>(request, response));
		model.addAttribute("page", page);
		model.addAttribute("mobile", mobile);
		model.addAttribute("accountName", accountName);
		model.addAttribute("applyCode", applyCode);
		model.addAttribute("status", status);
		model.addAttribute("startTime", startTime);
		model.addAttribute("endTime", endTime);
		return "modules/shopping/user/lineRechargeList";
	}

	@RequiresPermissions("merchandise:UserAmtLog:view")
	@ResponseBody
	@RequestMapping(value ="lineRechargeimg")
	public String lineRechargeimg(HttpServletRequest request, HttpServletResponse response){
		String id= request.getParameter("id");

		String data="";
		JSONObject json=new JSONObject();
		Boolean flag=false;
		String imgs="";
		if(StringUtils.isNotBlank(id)){
			PmUserOfflineRechargeLog pmUserOfflineRechargeLog=pmUserOfflineRechargeLogService.get(Integer.valueOf(id));
			if(pmUserOfflineRechargeLog!=null){
				if(StringUtils.isNotBlank(pmUserOfflineRechargeLog.getRechargeEvidencePicUrl())){
					imgs=pmUserOfflineRechargeLog.getRechargeEvidencePicUrl();
					flag=true;
				}
			}
		}

		json.put("flag", flag);
		json.put("imgs", imgs);
		data=json.toString();
		return data;
	}

	@RequiresPermissions("merchandise:UserAmtLog:edit")
	@RequestMapping(value ="lineRechargeEdit")
	public String lineRechargeEdit(HttpServletRequest request, HttpServletResponse response, Model model,RedirectAttributes redirectAttributes){
		String id= request.getParameter("id");
		String reason= request.getParameter("reason");
		String statusString= request.getParameter("status");
		String reString= request.getParameter("re");//0.同意  1.拒绝
		SysUser user = SysUserUtils.getUser();

		if(StringUtils.isNotBlank(id)){
			PmUserOfflineRechargeLog pmUserOfflineRechargeLog=pmUserOfflineRechargeLogService.get(Integer.valueOf(id));
			if(pmUserOfflineRechargeLog!=null){
				if(StringUtils.isNotBlank(statusString)){
					if(StringUtils.isNotBlank(reString)){
						Integer re=Integer.valueOf(reString);
						Integer status=Integer.valueOf(statusString);
						Date nowDate=new Date();
						if(status==1){//状态：1、审核中；2、审核不通过；3、充值中；4、充值成功；5、退款中；6、退款成功
							if(re==0){//0.同意  1.拒绝
								pmUserOfflineRechargeLog.setStatus(3);//充值中
								addMessage(redirectAttributes, "审核通过");
								String title="线下充值已审核通过！";
								String count="您的线下充值已审核通过，平台正在处理充值。4小时内未充值成功可申请退款，如需帮助，请联系平台客服。";
								String img="/uploads/drawable-xhdpi/tzxx.png";
								String imgs[]=null;
								if(StringUtils.isNotBlank(pmUserOfflineRechargeLog.getRechargeEvidencePicUrl())){
									imgs=pmUserOfflineRechargeLog.getRechargeEvidencePicUrl().split(",");
									if(imgs.length>0){
										img=imgs[0];
									}
								}
								EbUser ebUser=ebUserService.getEbUser(pmUserOfflineRechargeLog.getUserId().toString());
								ebMessageService.chuandis(null,ebUser,"消息提醒", title, count, img, 2, 5);
							}
							if(re==1){
								if(StringUtils.isNotBlank(reason)){
									pmUserOfflineRechargeLog.setRefuseReason(reason);
								}
								pmUserOfflineRechargeLog.setStatus(2);//2、审核不通过；
								addMessage(redirectAttributes, "审核不通过");
								String title="线下充值审核不通过！";
								String count="您提交的线下充值审核未通过，原因是："+reason+"。如需帮助，请联系平台客服。";
								String img="/uploads/drawable-xhdpi/tzxx.png";
								String imgs[]=null;
								if(StringUtils.isNotBlank(pmUserOfflineRechargeLog.getRechargeEvidencePicUrl())){
									imgs=pmUserOfflineRechargeLog.getRechargeEvidencePicUrl().split(",");
									if(imgs.length>0){
										img=imgs[0];
									}
								}
								EbUser ebUser=ebUserService.getEbUser(pmUserOfflineRechargeLog.getUserId().toString());
								ebMessageService.chuandis(null,ebUser,"消息提醒", title, count, img, 2, 5);
							}
						}
						if(status==3){
							if(re==0){//0.同意  1.拒绝
								PmAmtLog pmAmtLogSel=new PmAmtLog();
								pmAmtLogSel.setUserId(pmUserOfflineRechargeLog.getUserId());
								pmAmtLogSel.setBankId(pmUserOfflineRechargeLog.getId());
								pmAmtLogSel.setAmtType(16);
								Map<String, Object> list=pmAmtLogService.getPageList(0, 10, pmAmtLogSel);
								List<PmAmtLog> pmAmtLogList =(List<PmAmtLog>)list.get("list");
								if(CollectionUtils.isEmpty(pmAmtLogList)){
									EbUser ebUser=ebUserService.getModel(pmUserOfflineRechargeLog.getMobile());
									//拓展
									EbUserMoney ebExpand=ebExpandService.getEbExpandByUserId(ebUser.getUserId());

									if(pmUserOfflineRechargeLog.getSubsidyAmount()!=null){
										//ebUser.setCurrentAmtOffline(ebUser.getCurrentAmtOffline()+pmUserOfflineRechargeLog.getTransferAmount().add(pmUserOfflineRechargeLog.getSubsidyAmount()).doubleValue());
										ebExpandService.saveFlush(ebExpand,pmUserOfflineRechargeLog.getTransferAmount().add(pmUserOfflineRechargeLog.getSubsidyAmount()).doubleValue(),0.0,pmUserOfflineRechargeLog.getTransferAmount().add(pmUserOfflineRechargeLog.getSubsidyAmount()).doubleValue(), "后台充值",0.0);
//										ebExpand.setTotalAmt(ebExpand.getTotalAmt()+pmUserOfflineRechargeLog.getTransferAmount().add(pmUserOfflineRechargeLog.getSubsidyAmount()).doubleValue());
										ebExpandService.saveFlush(ebExpand,0.0,0.0,0.0,0.0,0.0,pmUserOfflineRechargeLog.getTransferAmount().add(pmUserOfflineRechargeLog.getSubsidyAmount()).doubleValue(),"后台充值累计总额变化");
									}else {
										//ebUser.setCurrentAmtOffline(ebUser.getCurrentAmtOffline()+pmUserOfflineRechargeLog.getTransferAmount().doubleValue());
										ebExpandService.saveFlush(ebExpand,pmUserOfflineRechargeLog.getTransferAmount().doubleValue(),0.0,pmUserOfflineRechargeLog.getTransferAmount().doubleValue(), "后台充值",0.0);
//										ebExpand.setTotalAmt(ebExpand.getTotalAmt()+pmUserOfflineRechargeLog.getTransferAmount().doubleValue());
										ebExpandService.saveFlush(ebExpand,0.0,0.0,0.0,0.0,0.0,pmUserOfflineRechargeLog.getTransferAmount().doubleValue(),"后台充值累计总额变化");
									}
									PmAmtLog pmAmtLog=new PmAmtLog();
									pmAmtLog.setUserId(ebUser.getUserId());
									if(pmUserOfflineRechargeLog.getSubsidyAmount()!=null){
										pmAmtLog.setAmt(pmUserOfflineRechargeLog.getTransferAmount().add(pmUserOfflineRechargeLog.getSubsidyAmount()).doubleValue());
									}else {
										pmAmtLog.setAmt(pmUserOfflineRechargeLog.getTransferAmount().doubleValue());
									}
									pmAmtLog.setRemark("线下充值");
									pmAmtLog.setStatus(1);
									pmAmtLog.setAmtType(16);
									pmAmtLog.setCreateTime(new Date());
									pmAmtLog.setCreateUser(user.getName());
									pmAmtLog.setBankId(pmUserOfflineRechargeLog.getId());

									pmAmtLogService.save(pmAmtLog);
									pmUserOfflineRechargeLog.setStatus(4);//4、充值成功；
									addMessage(redirectAttributes, "充值成功");
									String title="线下充值成功！";
									String count="您已成功充值"+pmUserOfflineRechargeLog.getTransferAmount()+"元，请留意查收。";
									String img="/uploads/drawable-xhdpi/tzxx.png";
									String imgs[]=null;
									if(StringUtils.isNotBlank(pmUserOfflineRechargeLog.getRechargeEvidencePicUrl())){
										imgs=pmUserOfflineRechargeLog.getRechargeEvidencePicUrl().split(",");
										if(imgs.length>0){
											img=imgs[0];
										}
									}
									ebMessageService.chuandis(null,ebUser,"消息提醒", title, count, img, 2, 5);
								}
							}
						}
						if(status==5){//5、退款中；
							if(re==0){//0.同意  1.拒绝
								pmUserOfflineRechargeLog.setStatus(6);//6、退款成功
								addMessage(redirectAttributes, "退款完成");
								String title="线下充值退款已通过！";
								String count="您提交的线下充值退款已审核通过，充值款将原路退回充值账户，请留意到账。如需帮助，请联系平台客服。";
								String img="/uploads/drawable-xhdpi/tzxx.png";
								String imgs[]=null;
								if(StringUtils.isNotBlank(pmUserOfflineRechargeLog.getRechargeEvidencePicUrl())){
									imgs=pmUserOfflineRechargeLog.getRechargeEvidencePicUrl().split(",");
									if(imgs.length>0){
										img=imgs[0];
									}
								}
								EbUser ebUser=ebUserService.getEbUser(pmUserOfflineRechargeLog.getUserId().toString());
								ebMessageService.chuandis(null,ebUser,"退款提醒", title, count, img, 2, 5);
							}
							if(re==1){
								pmUserOfflineRechargeLog.setStatus(3);//3、充值中
								addMessage(redirectAttributes, "拒绝退款");
								String title="线下充值退款审核未通过！";
								String count="您提交的线下充值退款审核未通过，原因是："+reason+"。如需帮助，请联系平台客服。";
								String img="/uploads/drawable-xhdpi/tzxx.png";
								String imgs[]=null;
								if(StringUtils.isNotBlank(pmUserOfflineRechargeLog.getRechargeEvidencePicUrl())){
									imgs=pmUserOfflineRechargeLog.getRechargeEvidencePicUrl().split(",");
									if(imgs.length>0){
										img=imgs[0];
									}
								}
								EbUser ebUser=ebUserService.getEbUser(pmUserOfflineRechargeLog.getUserId().toString());
								ebMessageService.chuandis(null,ebUser,"线下充值退款提醒", title, count, img, 2, 5);
							}
						}
						pmUserOfflineRechargeLog.setModifyTime(nowDate);
						pmUserOfflineRechargeLog.setModifyUser(user.getLoginName());
						pmUserOfflineRechargeLogService.save(pmUserOfflineRechargeLog);
					}
				}
			}
		}
		return "redirect:"+Global.getAdminPath()+"/UserAmtLog/lineRechargeList";
	}
	@ResponseBody
	@RequestMapping(value = "userListest")
	public String userListest(HttpServletRequest request, HttpServletResponse response) {
		String ramk="";
		PmAmtLog amtLog=new PmAmtLog();
		amtLog.setAmtType(4);
		amtLog.setStatus(2);
		List<PmAmtLog> amtLogs=pmAmtLogService.findmybillList(amtLog);
		if(amtLogs!=null&&amtLogs.size()>0){
			ramk=amtLogs.get(0).getRemark();
			String ramks[]=ramk.split("，");
			if(ramks!=null&&ramks.length>0){
				ramk=ramks[0];
			}
		}
		return ramk;
	}
	@SuppressWarnings("deprecation")
	@ResponseBody
	@RequestMapping(value = "userOfflineRechargeLogExsel")
	public String userOfflineRechargeLogExsel(HttpServletRequest request, HttpServletResponse response) {
		String url="";
		int t=1;
		int pageNo=1;
		int rowNum=1;
		int rowNums=100;
		HSSFWorkbook wb = new HSSFWorkbook();
		HSSFSheet sheet = wb.createSheet("会员线下充值申请记录");
		HSSFRow row = sheet.createRow((int) 0);
		HSSFCellStyle style = wb.createCellStyle();
		style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		HSSFCell cell = row.createCell((short) 0);
		cell.setCellStyle(style);
		for (int i = 0; i < 12; i++) {
			cell = row.createCell((short) i);
			if(i==0){
				cell.setCellValue("序号");
			}
			if(i==1){
				cell.setCellValue("申请编号");
			}
			if(i==2){
				cell.setCellValue("会员账号");
			}
			if(i==3){
				cell.setCellValue("转账金额");
			}
			if(i==4){
				cell.setCellValue("补贴金额");
			}
			if(i==5){
				cell.setCellValue("转账姓名");
			}
			if(i==6){
				cell.setCellValue("银行账号");
			}
			if(i==7){
				cell.setCellValue("开户银行");
			}
			if(i==8){
				cell.setCellValue("状态");
			}
			if(i==9){
				cell.setCellValue("拒绝原因");
			}
			if(i==10){
				cell.setCellValue("备注说明");
			}
			if(i==10){
				cell.setCellValue("创建时间");
			}
			if(i==11){
				cell.setCellValue("创建人");
			}
			if(i==12){
				cell.setCellValue("修改时间");
			}
			if(i==13){
				cell.setCellValue("修改人");
			}
			cell.setCellStyle(style);
		}
		while(t==1){
			Page<PmUserOfflineRechargeLog>  page=pmUserOfflineRechargeLogService.pagePmUserOfflineRechargeLog("", "",new PmUserOfflineRechargeLog(), new Page<PmUserOfflineRechargeLog>(pageNo,rowNums));
			List<PmUserOfflineRechargeLog> exsels=new ArrayList<PmUserOfflineRechargeLog>();
			exsels=page.getList();
			if ((page.getCount() == rowNums && pageNo > 1)|| (page.getCount() / rowNums) < 1 && pageNo > 1) {
				exsels = null;
			}
			if(exsels!=null&&exsels.size()>0){
				for (PmUserOfflineRechargeLog exsel : exsels) {
					try {
						row = sheet.createRow((int) rowNum);
						row.createCell((short) 0).setCellValue(rowNum);
						for (int i = 0; i < 7; i++) {
							if(i==1){
								row.createCell((short) i).setCellValue(exsel.getMobile());
							}
							if(i==2){
								row.createCell((short) i).setCellValue(exsel.getApplyCode());
							}
							if(i==3){
								row.createCell((short) i).setCellValue(exsel.getSubsidyAmount().doubleValue());
							}
							if(i==4){
								row.createCell((short) i).setCellValue(exsel.getAccountName());
							}
							if(i==5){
								row.createCell((short) i).setCellValue(exsel.getAccount());
							}
							if(i==6){
								row.createCell((short) i).setCellValue(exsel.getBankName());
							}
							if(i==7){
								row.createCell((short) i).setCellValue(exsel.getStatus());
							}
							if(i==8){
								row.createCell((short) i).setCellValue(exsel.getRefuseReason());
							}
							if(i==9){
								row.createCell((short) i).setCellValue(exsel.getRemark());
							}
							if(i==10){
								row.createCell((short) i).setCellValue(exsel.getCreateTime());
							}
							if(i==11){
								row.createCell((short) i).setCellValue(exsel.getCreateUser());
							}
							if(i==12){
								row.createCell((short) i).setCellValue(exsel.getModifyTime());
							}
							if(i==13){
								row.createCell((short) i).setCellValue(exsel.getModifyUser());
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
}