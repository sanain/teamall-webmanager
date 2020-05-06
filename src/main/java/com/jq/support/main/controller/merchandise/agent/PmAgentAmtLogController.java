package com.jq.support.main.controller.merchandise.agent;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.jq.support.common.config.Global;
import com.jq.support.common.persistence.Page;
import com.jq.support.common.utils.DateUtils;
import com.jq.support.common.utils.StringUtils;
import com.jq.support.common.web.BaseController;
import com.jq.support.model.agent.PmAgentInfo;
import com.jq.support.model.frozenlove.PmAgentLoveLevel;
import com.jq.support.model.message.EbMessage;
import com.jq.support.model.order.PmAgentAmtLog;
import com.jq.support.model.pay.BusinessPayConfigure;
import com.jq.support.model.sys.SysDict;
import com.jq.support.model.sys.SysOffice;
import com.jq.support.model.sys.SysUser;
import com.jq.support.model.user.EbUser;
import com.jq.support.model.user.PmAgentBank;
import com.jq.support.model.user.PmAmtLog;
import com.jq.support.service.agent.PmAgentInfoService;
import com.jq.support.service.frozenlove.PmAgentLoveLevelService;
import com.jq.support.service.merchandise.order.PmAgentAmtLogService;
import com.jq.support.service.merchandise.order.PmOrderLoveLogService;
import com.jq.support.service.merchandise.user.EbUserService;
import com.jq.support.service.merchandise.user.PmAgentBankService;
import com.jq.support.service.message.EbMessageService;
import com.jq.support.service.pay.BusinessPayConfigureService;

import com.jq.support.service.sys.SysDictService;
import com.jq.support.service.sys.SysOfficeService;
import com.jq.support.service.sys.SystemService;
import com.jq.support.service.utils.DateUtil;
import com.jq.support.service.utils.DictUtils;
import com.jq.support.service.utils.RandomNumber;
import com.jq.support.service.utils.SysUserUtils;

/**
 * 代理余额日志
 */
@Controller
@RequestMapping(value = "${adminPath}/pmAgentAmtLog")
public class PmAgentAmtLogController extends BaseController {
	private static String domainurl = Global.getConfig("domainurl");
	@Autowired
	PmAgentAmtLogService pmAgentAmtLogService;
	@Autowired
	PmAgentBankService pmAgentBankService;
	@Autowired
	EbUserService ebUserService;
	@Autowired
	SysOfficeService sysOfficeService;
	@Autowired
	PmAgentLoveLevelService pmAgentLoveLevelService;
	@Autowired
	PmOrderLoveLogService pmOrderLoveLogService;
	@Autowired
	private SysDictService sysDictService;
	@Autowired
	private SystemService systemService;
	@Autowired
	private BusinessPayConfigureService businessPayConfigureService;
	@Autowired
	private PmAgentInfoService agentService;
	@Autowired
	private EbMessageService ebMessageService;
	
	@ModelAttribute
	public PmAgentAmtLog get(@RequestParam(required = false) String id) {
		if (StringUtils.isNotBlank(id)) {
			return pmAgentAmtLogService.getPmAgentAmtLog(id);
		} else {
			return new PmAgentAmtLog();
		}
	}

	@RequestMapping(value = { "list", "" })
	public String list(PmAgentAmtLog pmAgentAmtLog, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		// SysUser user=SysUserUtils.getUser();
		// pmAgentAmtLog.setAgentId(user.getCompany().getId());
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		String messageid = request.getParameter("id");
		
		pmAgentAmtLog.setAmtType(1);
		Page<PmAgentAmtLog> page = pmAgentAmtLogService.findPmAgentAmtLogList(
				new Page<PmAgentAmtLog>(request, response), pmAgentAmtLog,
				startTime, endTime, null);
		List<PmAgentAmtLog> list = page.getList();
		for (PmAgentAmtLog amtLog : list) {
//			if (amtLog.getOffice() != null) {
//				amtLog.setSysUser(systemService.getUserByCompanyid(amtLog
//						.getOffice().getId()));
//			}
			amtLog.setPmAgentInfo(agentService.get(Integer.parseInt(amtLog.getAgentId())));
		}
		model.addAttribute("page", page);
		model.addAttribute("startTime", startTime);
		model.addAttribute("endTime", endTime);
		
		if(StringUtils.isNotBlank(messageid)){
			EbMessage message = ebMessageService.get(Integer.parseInt(messageid));
			message.setIsRead(1);
			ebMessageService.saveflush(message);
		}
		
		return "modules/shopping/user/pmAgentAmtLogList";
	}

	@RequestMapping(value = "form")
	public String form(PmAgentAmtLog pmAgentAmtLog, HttpServletRequest request,
			HttpServletResponse response) {
		if (pmAgentAmtLog.getBankId() != null) {
			pmAgentAmtLog.setPmAgentBank(pmAgentBankService.get(pmAgentAmtLog
					.getBankId()));
		}
		return "modules/shopping/user/pmAgentAmtLogFrom";
	}

	@RequestMapping(value = "add")
	public String addSave(PmAgentAmtLog pmAgentAmtLog,
			HttpServletRequest request, RedirectAttributes redirectAttributes,
			HttpServletResponse response, Model model) {
		SysUser user = SysUserUtils.getUser();
//		SysOffice sysOffice = user.getCompany();
		PmAgentInfo pmAgentInfo = agentService.get(Integer
				.parseInt(pmAgentAmtLog.getAgentId()));
		if (pmAgentInfo != null) {
			pmAgentAmtLog.setAgentId(pmAgentInfo.getAgentId()+"");
			double currentAmt = pmAgentInfo.getCurrentAmt();// 金额
			if (currentAmt >= pmAgentAmtLog.getAmt()) {
//				sysOffice.setCurrentAmt(currentAmt - pmAgentAmtLog.getAmt());
				agentService.updataPmAgentInfo(pmAgentInfo, Math.abs(pmAgentAmtLog.getAmt()));
			} else {
				addMessage(redirectAttributes, "失败，不能大于余额！");
				return "redirect:" + Global.getAdminPath()
						+ "/pmAgentAmtLog/withdraw";
			}
			if (pmAgentAmtLog.getBankId() == null) {
				addMessage(redirectAttributes, "失败，请添加银行卡！");
				return "redirect:" + Global.getAdminPath()
						+ "/pmAgentAmtLog/withdraw";
			}

			pmAgentAmtLog.setAmt(-pmAgentAmtLog.getAmt());
			pmAgentAmtLog.setStatus(0);
			pmAgentAmtLog.setAmtType(1);
			pmAgentAmtLog.setCreateUser(user.getName());
			pmAgentAmtLog.setCreateTime(new Date());
			pmAgentAmtLog.setRemark("代理提现申请");
			pmAgentAmtLogService.save(pmAgentAmtLog);
//			sysOfficeService.save(sysOffice);
			addMessage(redirectAttributes, "申请成功！");
		}
		return "redirect:" + Global.getAdminPath() + "/pmAgentAmtLog/withdraw";
	}
	@Transactional
	@RequestMapping(value = "save")
	public String save(PmAgentAmtLog pmAgentAmtLog, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		SysUser user = SysUserUtils.getUser();
//		EbUser ebUser = null;
		if (pmAgentAmtLog.getId() != null) {
			PmAgentAmtLog old = pmAgentAmtLogService
					.getPmAgentAmtLog(pmAgentAmtLog.getId() + "");
			if (old != null && old.getStatus() != null
					&& old.getStatus().equals(0)) {
				// 交易完成
				if (pmAgentAmtLog.getStatus() != null
						&& pmAgentAmtLog.getStatus().equals(1)
						&& StringUtils.isNotBlank(pmAgentAmtLog.getApplycode())) {
					pmAgentAmtLog.setModifyTime(new Date());
					pmAgentAmtLogService.save(pmAgentAmtLog);
					// 交易取消
				} else if (pmAgentAmtLog.getStatus() != null
						&& pmAgentAmtLog.getStatus().equals(2)) {
//					SysOffice sysOffice = user.getCompany();
					PmAgentInfo pmAgentInfo = agentService.get(Integer
							.parseInt(pmAgentAmtLog.getAgentId()));
					if (pmAgentInfo != null) {
//						sysOffice = sysOfficeService.get(sysOffice.getId());
//						ebUser = ebUserService.findByAgentId(sysOffice.getId());
						pmAgentAmtLog.setId(null);
						pmAgentAmtLog.setAgentId(pmAgentInfo.getAgentId()+"");
//						double currentAmt = sysOffice.getCurrentAmt();// 金额
//						sysOffice.setCurrentAmt(currentAmt
//								- pmAgentAmtLog.getAmt());
						agentService.updataPmAgentInfo(pmAgentInfo, -pmAgentAmtLog.getAmt());
						pmAgentAmtLog.setAmt(-pmAgentAmtLog.getAmt());
						pmAgentAmtLog.setStatus(2);
						pmAgentAmtLog.setAmtType(3);
						pmAgentAmtLog.setRemark("提现审核不通过");
//						if (ebUser != null) {
							pmAgentAmtLog.setCreateUser(user.getName());
//						}
						pmAgentAmtLog.setCreateTime(new Date());
						pmAgentAmtLog.setModifyTime(new Date());
						pmAgentAmtLogService.save(pmAgentAmtLog);
//						sysOfficeService.save(sysOffice);
					}

				}

			}
		}

		return "redirect:" + Global.getAdminPath() + "/pmAgentAmtLog/list";
	}

	// 提现
	@RequestMapping(value = "withdraw")
	public String withdraw(PmAgentAmtLog pmAgentAmtLog,
			HttpServletRequest request, Model model) {
		SysUser user = SysUserUtils.getUser();
		List<PmAgentBank> pBanks = pmAgentBankService
				.getAllAgentAmtLogByAgentId(user.getCompany().getId());
		model.addAttribute("pmAgentBanks", pBanks);
		model.addAttribute("sysOffice", user.getCompany());
		return "modules/shopping/user/pmAgentAmtLogWithdrawFrom";
	}

	// 提现通过或不通过
	@RequestMapping(value = "withdrawState")
	public String withdrawState(PmAgentAmtLog pmAgentAmtLog,
			HttpServletRequest request, Model model) throws Exception {
		SysUser user = SysUserUtils.getUser();
		String status = request.getParameter("status");// 1.同意(手动打款) 2.拒绝 3.银行打款
		PmAgentAmtLog amt = pmAgentAmtLogService.getPmAgentAmtLog(pmAgentAmtLog
				.getId().toString());
		if (amt != null && amt.getStatus() != null && amt.getStatus() == 0) {

			if (status.equals("1")) {
				pmAgentAmtLog.setStatus(1);// 同意打款
				pmAgentAmtLog.setModifyUser(user.getName());
				pmAgentAmtLog.setModifyTime(new Date());
				pmAgentAmtLog.setRemark(pmAgentAmtLog.getRemark() + "，提现成功。");
				pmAgentAmtLogService.save(pmAgentAmtLog);
			} else if (status.equals("2")) {// 拒绝
				

				// SysOffice
				// sysOffice=sysOfficeService.get(pmAgentAmtLog.getAgentId());
				PmAgentInfo pmAgentInfo = agentService.get(Integer
						.parseInt(pmAgentAmtLog.getAgentId()));
				// if (sysOffice!=null) {
				if (pmAgentInfo != null) {
					pmAgentAmtLog.setStatus(2);
					pmAgentAmtLog.setModifyUser(user.getName());
					pmAgentAmtLog.setModifyTime(new Date());
					pmAgentAmtLog.setRemark(pmAgentAmtLog.getRemark() + "，拒绝提现。");
					pmAgentAmtLogService.save(pmAgentAmtLog);
					
//					double currentAmt = sysOffice.getCurrentAmt();// 金额
//					sysOffice.setCurrentAmt(currentAmt
//							+ Math.abs(pmAgentAmtLog.getAmt()));
					agentService.updataPmAgentInfo(pmAgentInfo, Math.abs(pmAgentAmtLog.getAmt()));
					PmAgentAmtLog plog = new PmAgentAmtLog();
					plog.setId(null);
					plog.setAgentId(pmAgentInfo.getAgentId()+"");
					plog.setAmt(Math.abs(pmAgentAmtLog.getAmt()));
					plog.setStatus(1);
					plog.setAmtType(3);
					plog.setRemark("拒绝提现原因：" + pmAgentAmtLog.getRemark()
							+ "，交易取消。");
					plog.setCreateUser("系统");
					plog.setCreateTime(new Date());
					pmAgentAmtLogService.save(plog);
//					sysOfficeService.save(sysOffice);

				}
			}

		}
		/*
		 * //交易完成 if
		 * (pmAgentAmtLog.getStatus()!=null&&pmAgentAmtLog.getStatus().
		 * equals(1)&&StringUtils.isNotBlank(pmAgentAmtLog.getApplycode())) {
		 * //交易取消 }else if
		 * (pmAgentAmtLog.getStatus()!=null&&pmAgentAmtLog.getStatus
		 * ().equals(2)) { SysOffice
		 * sysOffice=sysOfficeService.get(pmAgentAmtLog.getAgentId()); if
		 * (sysOffice!=null) { PmAgentAmtLog plog=new PmAgentAmtLog();
		 * plog.setId(null); plog.setAgentId(sysOffice.getId()); double
		 * currentAmt=sysOffice.getCurrentAmt();//金额
		 * sysOffice.setCurrentAmt(currentAmt-pmAgentAmtLog.getAmt());
		 * 
		 * plog.setAmt(-pmAgentAmtLog.getAmt()); plog.setStatus(2);
		 * plog.setAmtType(3); plog.setRemark(pmAgentAmtLog.getRemark());
		 * plog.setCreateUser(user.getName()); plog.setCreateTime(new Date());
		 * plog.setModifyTime(new Date()); pmAgentAmtLogService.save(plog);
		 * sysOfficeService.save(sysOffice); }
		 * 
		 * }
		 */
		return "redirect:" + Global.getAdminPath() + "/pmAgentAmtLog/list";
	}

	@ResponseBody
	@RequestMapping(value = "piEdit")
	public String piEdit(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		BusinessPayConfigure businessPayConfigure = null;
		String ids = request.getParameter("ids");
		System.out.println(ids);
		String status = request.getParameter("status");// 1.同意 2.拒绝 3审核同意银行打款
		SysUser user = SysUserUtils.getUser();
		if (status.equals("3")) {
			businessPayConfigure = businessPayConfigureService
					.getDefaultByPaymentType(-1);// 打款通道
		}

		if (StringUtils.isNotBlank(ids)) {
			String idv[] = ids.split(",");
			for (int i = 0; i < idv.length; i++) {
				if (StringUtils.isNotBlank(idv[i])) {
					PmAgentAmtLog pmAgentAmtLog = pmAgentAmtLogService
							.getPmAgentAmtLog(Integer.valueOf(idv[i])
									.toString());
					if (pmAgentAmtLog != null
							&& pmAgentAmtLog.getAmtType() == 1
							&& pmAgentAmtLog.getStatus() == 0) {

						if (status.equals("1")) {// 1.同意
							pmAgentAmtLog.setStatus(1);
							pmAgentAmtLog.setModifyUser(user.getName());
							pmAgentAmtLog.setModifyTime(new Date());
							pmAgentAmtLog.setRemark(pmAgentAmtLog.getRemark()
									+ "，提现成功。");
							pmAgentAmtLogService.save(pmAgentAmtLog);
						} else if (status.equals("2")) {// 2.拒绝
							pmAgentAmtLog.setStatus(2);
							pmAgentAmtLog.setModifyUser(user.getName());
							pmAgentAmtLog.setModifyTime(new Date());
							pmAgentAmtLog.setRemark(pmAgentAmtLog.getRemark()
									+ "，拒绝提现。");
							pmAgentAmtLogService.save(pmAgentAmtLog);

//							SysOffice sysOffice = sysOfficeService
//									.get(pmAgentAmtLog.getAgentId());
							PmAgentInfo pmAgentInfo = agentService.get(Integer
									.parseInt(pmAgentAmtLog.getAgentId()));
							if (pmAgentInfo != null) {
//								double currentAmt = sysOffice.getCurrentAmt();// 金额
//								sysOffice.setCurrentAmt(currentAmt
//										+ Math.abs(pmAgentAmtLog.getAmt()));
								
								PmAgentAmtLog plog = new PmAgentAmtLog();
								plog.setId(null);
								plog.setAgentId(pmAgentInfo.getAgentId()+"");
								plog.setAmt(Math.abs(pmAgentAmtLog.getAmt()));
								plog.setStatus(1);
								plog.setAmtType(3);
								plog.setRemark("拒绝提现原因："
										+ pmAgentAmtLog.getRemark() + "，交易取消。");
								plog.setCreateUser("系统");
								plog.setCreateTime(new Date());
								pmAgentAmtLogService.save(plog);
								agentService.updataPmAgentInfo(pmAgentInfo, Math.abs(pmAgentAmtLog.getAmt()));
//								sysOfficeService.save(sysOffice);
							}
						}

					}
				}
			}
		}
		return "00";
	}

	// 查看
	@RequestMapping(value = "show")
	@ResponseBody
	public PmAgentAmtLog show(PmAgentAmtLog pmAgentAmtLog,
			HttpServletRequest request, Model model) {
		// JSONObject pmAmtLog = JSONObject.fromObject(pmAgentAmtLog);
		pmAgentAmtLog.setPmAgentBank(pmAgentBankService.get(pmAgentAmtLog
				.getBankId()));
		return pmAgentAmtLog;
	}

	// 金额明细页
	@RequestMapping(value = "agentBalance")
	public String agentBalance(PmAgentAmtLog pmAgentAmtLog,
			HttpServletRequest request, Model model) throws IOException {
		SysUser user = SysUserUtils.getUser();
		SysOffice sysOffice = user.getCompany();
		if (sysOffice != null) {
			// 银行卡数量
			Integer pBankCount = pmAgentBankService.getAllAgentAmtLogByAgentId(
					sysOffice.getId()).size();
			// 冻结金额
			double freezeAmt = pmAgentAmtLogService
					.freezeAmt(sysOffice.getId());
			// 统计金额提现情况
			JSONArray jSONArray = pmAgentAmtLogService.balanceDetail(sysOffice
					.getId());

			model.addAttribute("sysOffice", sysOffice);
			model.addAttribute("pBankCount", pBankCount);
			model.addAttribute("freezeAmt", freezeAmt);
			model.addAttribute("txt", jSONArray.toString());
		}

		return "modules/shopping/user/agent-balance";
	}

	// 代理金额列表
	@RequestMapping("agentAmtList")
	public String agentAmtList(PmAgentAmtLog pmAgentAmtLog,
			HttpServletRequest request, HttpServletResponse response,
			Model model) {
		SysUser user = SysUserUtils.getUser();
		pmAgentAmtLog.setAgentId(user.getCompany().getId());
		pmAgentAmtLog.setAmtType(1);
		Page<PmAgentAmtLog> page = pmAgentAmtLogService.findPmAgentAmtLogList(
				new Page<PmAgentAmtLog>(request, response), pmAgentAmtLog,
				null, null, null);
		model.addAttribute("page", page);
		return "modules/shopping/user/agentAmtList";
	}

	// 御可贡茶明细页
	@RequestMapping(value = "agentShanbao")
	public String agentShanbao(PmAgentAmtLog pmAgentAmtLog,
			HttpServletRequest request, Model model) throws IOException {
		SysUser user = SysUserUtils.getUser();
		SysOffice sysOffice = user.getCompany();
		if (sysOffice != null) {
			// 今日御可贡茶指数
			SysDict sysDict = new SysDict();
			sysDict.setLabel("LoveIndex");
			sysDict.setType("gyconfig");
			SysDict dict = sysDictService.getDict(sysDict);
			String loveIndex = dict == null ? "" : dict.getValue();
			// 统计金额提现情况
			JSONArray jSONArray = pmOrderLoveLogService.loveDetail(sysOffice
					.getId());
			List<PmAgentLoveLevel> levels = pmAgentLoveLevelService
					.getList(sysOffice.getId());
			if (CollectionUtils.isNotEmpty(levels)) {
				model.addAttribute("level", levels.get(0));
			}
			model.addAttribute("loveIndex", loveIndex);
			model.addAttribute("sysOffice", user.getCompany());
			model.addAttribute("txt", jSONArray.toString());
		}
		return "modules/shopping/user/agent-shanbao";
	}

	/*
	 * @RequestMapping(value ="delete") public String delete(PmAgentAmtLog
	 * pmAgentAmtLog,HttpServletRequest request, HttpServletResponse response){
	 * if (pmAgentAmtLog!=null) { pmAgentAmtLogService.delete(pmAgentAmtLog); }
	 * return "redirect:"+Global.getAdminPath()+"/pmAgentAmtLog"; }
	 */
	@ResponseBody
	@RequestMapping(value = "exsel")
	public String exsel(HttpServletRequest request, HttpServletResponse response) {
		String url = "";
		String syllable[] = request.getParameterValues("syllable");
		if (syllable != null && syllable.length > 0) {
			int t = 1;
			int pageNo = 1;
			int rowNum = 1;
			int rowNums = 100000;
			HSSFWorkbook wb = new HSSFWorkbook();
			HSSFSheet sheet = wb.createSheet("用户列表");
			HSSFRow row = sheet.createRow((int) 0);
			HSSFCellStyle style = wb.createCellStyle();
			style.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 创建一个居中格式
			HSSFCell cell = row.createCell((short) 0);
			cell.setCellValue("序号");
			cell.setCellStyle(style);
			for (int i = 0; i < syllable.length; i++) {
				cell = row.createCell((short) i);
				if (syllable[i].equals("0")) {
					cell.setCellValue("代理名称");
				}
				if (syllable[i].equals("1")) {
					cell.setCellValue("开户名");
				}
				if (syllable[i].equals("2")) {
					cell.setCellValue("提现账号");
				}
				if (syllable[i].equals("3")) {
					cell.setCellValue("提现金额");
				}
				if (syllable[i].equals("4")) {
					cell.setCellValue("手续费");
				}
				if (syllable[i].equals("5")) {
					cell.setCellValue("手机号");
				}
				if (syllable[i].equals("6")) {
					cell.setCellValue("交易状态");
				}
				if (syllable[i].equals("7")) {
					cell.setCellValue("申请时间");
				}
				if (syllable[i].equals("8")) {
					cell.setCellValue("开户银行");
				}
				if (syllable[i].equals("9")) {
					cell.setCellValue("所属支行");
				}
				if (syllable[i].equals("10")) {
					cell.setCellValue("提现编码");
				}
				cell.setCellStyle(style);
			}
			SysUser currentUser = SysUserUtils.getUser();
			while (t == 1) {
				String accountName = request
						.getParameter("pmAgentBank.accountName");
				String account = request.getParameter("pmAgentBank.account");
				String phoneNum = request.getParameter("pmAgentBank.phoneNum");
				String status = request.getParameter("status");
				String startTime = request.getParameter("startTime");
				String endTime = request.getParameter("endTime");
				String ids = request.getParameter("ids");
				PmAgentAmtLog pmAgentAmtLog = new PmAgentAmtLog();
				PmAgentBank pmAgentBank = new PmAgentBank();
				pmAgentBank.setAccountName(accountName);
				pmAgentBank.setAccount(account);
				pmAgentBank.setPhoneNum(phoneNum);
				pmAgentAmtLog.setAmtType(1);
				if (StringUtils.isNotBlank(status)) {
					pmAgentAmtLog.setStatus(Integer.parseInt(status));
				}
				Page<PmAgentAmtLog> page = pmAgentAmtLogService
						.findPmAgentAmtLogList(new Page<PmAgentAmtLog>(pageNo,
								rowNums), pmAgentAmtLog, startTime, endTime,
								ids);
				List<PmAgentAmtLog> amtLogs = page.getList();
				if ((page.getCount() == rowNums && pageNo > 1)
						|| (page.getCount() / rowNums) < 1 && pageNo > 1) {
					amtLogs = null;
				}
				if (amtLogs != null && amtLogs.size() > 0) {
					for (PmAgentAmtLog agentAmtLog : amtLogs) {
//						agentAmtLog
//								.setSysUser(systemService
//										.getUserByCompanyid(agentAmtLog
//												.getOffice() == null ? "-99999"
//												: agentAmtLog.getOffice()
//														.getId()));
						agentAmtLog.setPmAgentInfo(agentService.get(Integer.parseInt(agentAmtLog.getAgentId())));
						try {
							row = sheet.createRow((int) rowNum);
							row.createCell((short) 0).setCellValue(rowNum);
							for (int i = 0; i < syllable.length; i++) {
								if (syllable[i].equals("0")) {
									row.createCell((short) i).setCellValue(
											agentAmtLog.getPmAgentInfo().getAgentName());
								}
								if (syllable[i].equals("1")) {
									row.createCell((short) i).setCellValue(
											agentAmtLog.getPmAgentBank()
													.getAccountName());
								}
								if (syllable[i].equals("2")) {
									row.createCell((short) i).setCellValue(
											agentAmtLog.getPmAgentBank()
													.getAccount());
								}
								if (syllable[i].equals("3")) {
									row.createCell((short) i).setCellValue(
											agentAmtLog.getAmt());
								}
								if (syllable[i].equals("4")) {
									row.createCell((short) i).setCellValue(
											agentAmtLog.getFee() == null ? 0.0
													: agentAmtLog.getFee());
								}
								if (syllable[i].equals("5")) {
									row.createCell((short) i).setCellValue(
											agentAmtLog.getPmAgentBank()
													.getPhoneNum());
								}
								if (syllable[i].equals("6")) {
									String ststus = "";
									if (agentAmtLog.getStatus() == 0) {
										ststus = "待审核";
									} else if (agentAmtLog.getStatus() == 1) {
										ststus = "已完成";
									} else if (agentAmtLog.getStatus() == 2) {
										ststus = "已取消";
									} else if (agentAmtLog.getStatus() == 3) {
										ststus = "审核通过";
									}
									row.createCell((short) i).setCellValue(
											ststus);
								}
								if (syllable[i].equals("7")) {
									row.createCell((short) i).setCellValue(
											DateUtils
													.formatDateTime(agentAmtLog
															.getCreateTime()));
								}
								if (syllable[i].equals("8")) {
									row.createCell((short) i).setCellValue(
											agentAmtLog.getPmAgentBank()
													.getBankName());
								}
								if (syllable[i].equals("9")) {
									row.createCell((short) i).setCellValue(
											agentAmtLog.getPmAgentBank()
													.getSubbranchName());
								}
								if (syllable[i].equals("10")) {
									row.createCell((short) i).setCellValue(
											agentAmtLog.getApplycode());
								}
							}
						} catch (Exception e) {
							/* System.out.print(e.getCause()); */
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
			String path = "uploads/xlsfile/tempfile";
			Random r = new Random();
			String strfileName = DateUtil.getDateFormat(new Date(),
					"yyyyMMddHHmmss") + r.nextInt();
			File f = new File(RootPath + path);
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
}