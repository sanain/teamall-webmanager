package com.jq.support.main.controller.h5;

import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.alipay.util.httpClient.HttpRequest;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jq.support.common.config.Global;
import com.jq.support.common.persistence.Page;
import com.jq.support.common.utils.RandomNumber;
import com.jq.support.common.utils.StringUtils;
import com.jq.support.common.web.BaseController;
import com.jq.support.model.frozenlove.PmAgentLoveLevel;
import com.jq.support.model.message.EbMessage;
import com.jq.support.model.message.EbMessageUser;
import com.jq.support.model.order.EbOrder;
import com.jq.support.model.order.PmAgentAmtLog;
import com.jq.support.model.order.PmOrderLoveLog;
import com.jq.support.model.sys.SysDict;
import com.jq.support.model.sys.SysOffice;
import com.jq.support.model.sys.SysUser;
import com.jq.support.model.user.EbUser;
import com.jq.support.model.user.PmAgentBank;
import com.jq.support.service.frozenlove.PmAgentLoveLevelService;
import com.jq.support.service.merchandise.order.EbOrderService;
import com.jq.support.service.merchandise.order.PmAgentAmtLogService;
import com.jq.support.service.merchandise.order.PmOrderLoveLogService;
import com.jq.support.service.merchandise.product.EbCollectService;
import com.jq.support.service.merchandise.user.EbUserService;
import com.jq.support.service.merchandise.user.PmAgentBankService;
import com.jq.support.service.merchandise.user.PmUserSmsCodeService;
import com.jq.support.service.message.EbMessageService;
import com.jq.support.service.message.EbMessageUserService;
import com.jq.support.service.sys.SysDictService;
import com.jq.support.service.sys.SysOfficeService;
import com.jq.support.service.sys.SystemService;
import com.jq.support.service.utils.BankUtil;
import com.jq.support.service.utils.CommonUtils;
import com.jq.support.service.utils.DateUtil;
import com.jq.support.service.utils.DictUtils;
import com.jq.support.service.utils.SmsUtil;
import com.jq.support.service.utils.SysUserUtils;

@Controller
@RequestMapping("/h5/agentUser")
public class H5UserController extends BaseController{ 
	@Autowired
	private SystemService userService;
	@Autowired
	private SysOfficeService sysOfficeService;
	@Autowired
	private EbUserService ebUserService;
	@Autowired
	private PmOrderLoveLogService pmOrderLoveLogService;
	@Autowired
	private PmAgentBankService pmAgentBankService;
	@Autowired
	private PmAgentAmtLogService pmAgentAmtLogService;
	@Autowired
	private EbCollectService EbCollectService;
	@Autowired
	private EbOrderService ebOrderService;
	@Autowired
	private SysDictService sysDictService;
	@Autowired
	private PmUserSmsCodeService pmUserSmsCodeService;
	@Autowired
	private PmAgentLoveLevelService pmAgentLoveLevelService;
	
	/**导航到主页面*/
	@RequestMapping("/home")
	public String home(String code,HttpSession session){
		return "modules/h5/agent/home";
	}
	
	/**导航到登录页面*/
	@RequestMapping("/formLogin")
	public String formLogin(String code, HttpSession session){
		return "modules/h5/agent/login";
	}
	
	/**导航到修改密码页面*/
	@RequestMapping("/formChangePassword")
	public String formChangePassword(String code,HttpSession session){
		return "modules/h5/agent/change-password";
	}

	/**导航到注册页面*/
	@RequestMapping("/formRegister")
	public String formRegister(){
		return "modules/h5/register";
	}
	
	/**导航到账号管理页面*/
	@RequestMapping("/formAccountManage")
	public String formAccountManage(){
		return "modules/h5/agent/account-manage";
	}
	
	/**导航到御可贡茶明细页面*/
	@RequestMapping("/agentLoveDetail")
	public String agentLoveDetail(Model model,HttpSession session){
		SysUser user=(SysUser) session.getAttribute("agentUser");
		SysOffice sysOffice=user.getCompany();
		model.addAttribute("totalLove", sysOffice.getTotalLove());
		return "modules/h5/agent/sb-statistics";
	}
	
	/**导航到代理余额明细页面*/
	@RequestMapping("/agentAmtDetail")
	public String agentAmtDetail(Model model,HttpSession session){
		SysUser user=(SysUser) session.getAttribute("agentUser");
		SysOffice sysOffice=user.getCompany();
		model.addAttribute("changeAmt", pmAgentAmtLogService.changeAmt(sysOffice.getId()));//激励总金额
		return "modules/h5/agent/stimulate-statistics";
	}
	
	//代理登陆
	@RequestMapping("/login")
	@ResponseBody
	public String  login(SysUser user,Model model,HttpSession session,HttpServletRequest request){
		Map<String, Object> objmap = userService.userLogin(user.getLoginName(), user.getPassword());
		if(objmap.get("errorcode").equals("00")){//登录成功，将登录用户放到session
			session.setAttribute("agentUser", objmap.get("jsonresponse"));
			return "00";
		}
		return objmap.get("msg").toString();
	}
	
	//退出登录
	@RequestMapping("/logout")
	public String  logout(SysUser user,Model model,HttpSession session,HttpServletRequest request){
		session.setAttribute("agentUser", null);
		return "modules/h5/agent/login";
	}
	
	//代理修改密码
	@RequestMapping("/updatePasswd")
	@ResponseBody
	public String updatePasswd(String newPassword,String confirmPassword,Model model,HttpSession session,HttpServletRequest request){
		SysUser sysUser=(SysUser) session.getAttribute("agentUser");
		Map<String, Object> objmap = userService.updatePasswd(sysUser,newPassword, confirmPassword);
		if(objmap.get("errorcode").equals("00")){
			return "00";
		}
		return objmap.get("msg").toString();
	}
	
	
	/**导航到会员管理页面*/
	@RequestMapping("/vipManagement")
	public String vipManagement(HttpSession session, Model model){
		SysUser user=(SysUser) session.getAttribute("agentUser");
		SysOffice sysOffice=user.getCompany();
		String agentIds= sysOfficeService.getAgentIdList(sysOffice);
		model.addAttribute("shopUserCout", ebUserService.getShopUserCout(agentIds));//代理的所有商家
		return "modules/h5/agent/vip-management";
	}
	
	
	//会员管理 代理下的商家用户json
	@RequestMapping("/userList")
	@ResponseBody
	public List<EbUser> userList(EbUser ebUser,HttpSession session,HttpServletRequest request, HttpServletResponse response, Model model){
		SysUser user=(SysUser) session.getAttribute("agentUser");
		SysOffice sysOffice=user.getCompany();
		
		String stateRow=request.getParameter("stateRow");
		String endRow=request.getParameter("endRow");
		Integer stateNum = 0;// 开始行数
		if (StringUtils.isNotBlank(stateRow)) {
			stateNum = Integer.parseInt(stateRow);
		}
		Integer endNum = 10;// 结束行数
		if (StringUtils.isNotBlank(endRow)) {
			endNum = Integer.parseInt(endRow);
		}
		String agentIds= sysOfficeService.getAgentIdList(sysOffice);
		List<EbUser> users =ebUserService.getPageUserByAgentIdList(stateNum, endNum,ebUser,agentIds);
		for (EbUser eu : users) {
			eu.setMyAnswer(ebUserService.getNextUser(eu).size());//来存人脉
		}
		return users;
	}
	
	
	//御可贡茶明细页
	@RequestMapping(value ="agentShanbao")
	public String agentShanbao(PmAgentAmtLog pmAgentAmtLog,HttpSession session,HttpServletRequest request, Model model) throws IOException{
		SysUser user=(SysUser) session.getAttribute("agentUser");
		SysOffice sysOffice=user.getCompany();
		if (sysOffice!=null) {
		//今日御可贡茶指数
		SysDict sysDict=new SysDict();
		sysDict.setLabel("LoveIndex");
		sysDict.setType("gyconfig");
		SysDict dict =sysDictService.getDict(sysDict);
		String loveIndex=dict==null?"":dict.getValue();
		//String loveIndex=DictUtils.getDictValue("LoveIndex", "gyconfig", "");
		//统计金额提现情况
		JSONArray jSONArray=pmOrderLoveLogService.loveDetail(sysOffice.getId());
		double loveCount=pmOrderLoveLogService.getAgentLoveCount(sysOffice.getId());
		
		model.addAttribute("loveCount", loveCount);
		model.addAttribute("loveIndex", loveIndex);
		model.addAttribute("sysOffice", user.getCompany());
		model.addAttribute("txt", jSONArray.toString());
		}
		return "modules/h5/agent/sb-my";
	}
	
	/**
	 * 代理御可贡茶明细列表json
	 */
	@RequestMapping("agentLoveList")
	@ResponseBody
	public List<PmOrderLoveLog> agentLoveList(PmOrderLoveLog pmOrderLoveLog,HttpSession session,HttpServletRequest request, HttpServletResponse response, Model model){
		SysUser user=(SysUser) session.getAttribute("agentUser");
		SysOffice sysOffice=user.getCompany();
		
		String stateRow=request.getParameter("stateRow");
		String endRow=request.getParameter("endRow");
		Integer stateNum = 0;// 开始行数
		if (StringUtils.isNotBlank(stateRow)) {
			stateNum = Integer.parseInt(stateRow);
		}
		Integer endNum = 10;// 结束行数
		if (StringUtils.isNotBlank(endRow)) {
			endNum = Integer.parseInt(endRow);
		}
		
		pmOrderLoveLog.setObjId(sysOffice.getId());
		pmOrderLoveLog.setCurrencyType(1);
		pmOrderLoveLog.setObjType(3);
		List<PmOrderLoveLog> list =pmOrderLoveLogService.findmyloveList(stateNum,endNum,pmOrderLoveLog,"","");
		//model.addAttribute("maxLove", pmOrderLoveLogService.getMaxLove(page.getList()));
		return list;
	}
	
	
	/**
	 * 代理激励明细列表json
	 */
	@RequestMapping("agentChangeLoveList")
	@ResponseBody
	public List<PmAgentAmtLog> agentChangeLoveList(PmAgentAmtLog pmAgentAmtLog,HttpSession session,HttpServletRequest request, HttpServletResponse response, Model model){
		SysUser user=(SysUser) session.getAttribute("agentUser");
		
		String stateRow=request.getParameter("stateRow");
		String endRow=request.getParameter("endRow");
		Integer stateNum = 0;// 开始行数
		if (StringUtils.isNotBlank(stateRow)) {
			stateNum = Integer.parseInt(stateRow);
		}
		Integer endNum = 10;// 结束行数
		if (StringUtils.isNotBlank(endRow)) {
			endNum = Integer.parseInt(endRow);
		}
		
		SysOffice sysOffice=user.getCompany();
		pmAgentAmtLog.setAgentId(sysOffice.getId());
		pmAgentAmtLog.setAmtType(7);
		List<PmAgentAmtLog> list =pmAgentAmtLogService.findPmAgentAmtLogList(stateNum,endNum,pmAgentAmtLog);
		return list;
	}
	
	//金额明细页
	@RequestMapping(value ="agentBalance")
	public String agentBalance(PmAgentAmtLog pmAgentAmtLog,HttpSession session,HttpServletRequest request, Model model) throws IOException{
		SysUser user=(SysUser) session.getAttribute("agentUser");
		SysOffice sysOffice=user.getCompany();
		if (sysOffice!=null) {
		//银行卡数量
		Integer pBankCount=pmAgentBankService.getAllAgentAmtLogByAgentId(sysOffice.getId()).size();
		//冻结金额
		double freezeAmt = pmAgentAmtLogService.freezeAmt(sysOffice.getId());
		//激励总金额
		double changeAmt = pmAgentAmtLogService.changeAmt(sysOffice.getId());
		
		model.addAttribute("sysOffice", sysOffice);
		model.addAttribute("pBankCount", pBankCount);
		model.addAttribute("freezeAmt", freezeAmt);
		model.addAttribute("changeAmt", changeAmt);
		}
		
		return "modules/h5/agent/my-balance";
	}
	
	/**跳转到我的银行卡页面*/
	@RequestMapping("/myBankcard")
	public String myBankcard(Model model,HttpSession session){
		SysUser user=(SysUser) session.getAttribute("agentUser");
		SysOffice sysOffice=user.getCompany();
		//银行卡数量
		List<PmAgentBank> banks=pmAgentBankService.getAllAgentAmtLogByAgentId(sysOffice.getId());
		model.addAttribute("banks", banks);
		return "modules/h5/agent/my-bankcard";
	}
	
	/**我的银行卡列表json*/
	@RequestMapping("/myBankcardList")
	@ResponseBody
	public List<PmAgentBank> myBankcardList(Model model,HttpSession session){
		SysUser user=(SysUser) session.getAttribute("agentUser");
		SysOffice sysOffice=user.getCompany();
		//银行卡数量
		List<PmAgentBank> banks=pmAgentBankService.getAllAgentAmtLogByAgentId(sysOffice.getId());
		model.addAttribute("banks", banks);
		return banks;
	}
	
	/**跳转到我的提现页面*/
	@RequestMapping("/withdrawalBank")
	public String withdrawalBank(String id,Model model,HttpSession session){
		SysUser user=(SysUser) session.getAttribute("agentUser");
		SysOffice sysOffice=user.getCompany();
		PmAgentBank bank =null;
		if (StringUtils.isNotBlank(id)) {
			bank=pmAgentBankService.get(Integer.valueOf(id));
		}else {
			//银行卡
			List<PmAgentBank> banks=pmAgentBankService.getAllAgentAmtLogByAgentId(sysOffice.getId());
			if (CollectionUtils.isNotEmpty(banks)) {
				bank=banks.get(0);
			}
		}
		model.addAttribute("bank", bank);
		model.addAttribute("currentAmt", sysOffice.getCurrentAmt());
		return "modules/h5/agent/withdrawal-bank";
	}
	
	/**提现处理*/
	@RequestMapping("/withdrawal")
	@ResponseBody
	public String withdrawal(String bankId,String amt,Model model,HttpSession session){
		SysUser user=(SysUser) session.getAttribute("agentUser");
		SysOffice sysOffice=user.getCompany();
		if (sysOffice!=null) {
			
		}
        if (!StringUtils.isNumeric(bankId)||!StringUtils.isNumeric(amt)||Integer.valueOf(amt)<0) {
			return "参数不正确";
		}
		if(Integer.parseInt(amt) % 100 != 0){ 
			return "提现金额不是100的倍数！";
	    }
        
        PmAgentAmtLog amtLog=new PmAgentAmtLog();
        amtLog.setAgentId(sysOffice.getId());
        List<PmAgentAmtLog> pmAmtLogs=pmAgentAmtLogService.findPmAgentAmtLogList(0, 1, amtLog);
		if(pmAmtLogs!=null&&pmAmtLogs.size()>0){
			long min=pmUserSmsCodeService.getDistanceTimes(DateUtil.getDateFormat(pmAmtLogs.get(0).getCreateTime(), "yyyy-MM-dd HH:mm:ss"), DateUtil.getDateFormat(new Date(), "yyyy-MM-dd HH:mm:ss"));
			if(min<2){
				return "不能频繁提现，两分钟后再试!";
			}
		}
		
		PmAgentBank bank=pmAgentBankService.get(Integer.valueOf(bankId));
		if (bank!=null) {
			if (sysOffice.getCurrentAmt()>=Double.valueOf(amt)) {
				PmAgentAmtLog pmAgentAmtLog =new PmAgentAmtLog();
				pmAgentAmtLog.setAgentId(sysOffice.getId());
				pmAgentAmtLog.setAmt(-Double.valueOf(amt));
				pmAgentAmtLog.setStatus(0);
				pmAgentAmtLog.setAmtType(1);
				pmAgentAmtLog.setBankId(bank.getId());
			    pmAgentAmtLog.setCreateUser(sysOffice.getName());
				pmAgentAmtLog.setCreateTime(new Date());
				pmAgentAmtLogService.save(pmAgentAmtLog);
				
				sysOffice.setCurrentAmt(sysOffice.getCurrentAmt()-Double.valueOf(amt));
				sysOfficeService.save(sysOffice);
			}else {
				return "余额不足";
			}
			
		}
		return "00";
	}
	
	/**提现申请成功页面*/
	@RequestMapping("/withdrawalSubmit")
	public String withdrawalSubmit(Model model,HttpSession session){
		return "modules/h5/agent/withdrawal-submit";
	}
	
	
	/**选择银行卡页面*/
	@RequestMapping("/selectBank")
	public String selectBank(Model model,HttpSession session){
		SysUser user=(SysUser) session.getAttribute("agentUser");
		SysOffice sysOffice=user.getCompany();
		//银行卡
		List<PmAgentBank> banks=pmAgentBankService.getAllAgentAmtLogByAgentId(sysOffice.getId());
		model.addAttribute("banks", banks);
		return "modules/h5/agent/select-bank";
	}
	
	/**添加银行卡页面
	 * @throws Exception */
	@RequestMapping("/addBank")
	public String addBank(PmAgentBank pmAgentBank,String type,Model model,HttpSession session) throws Exception{
		SysUser user=(SysUser) session.getAttribute("agentUser");
		SysOffice sysOffice=user.getCompany();
		if (type.equals("1")) {
			return "modules/h5/agent/add-bank";
		}else if (type.equals("2")) {
			//判断重复
			PmAgentBank agentBank=new PmAgentBank();
			agentBank.setAgentId(sysOffice.getId());
			agentBank.setAccount(pmAgentBank.getAccount());
			if (CollectionUtils.isNotEmpty(pmAgentBankService.findPmAgentBankList(agentBank))) {
				return "modules/h5/agent/add-bank";
			}
			
			List<PmAgentBank> banks=pmAgentBankService.getAllAgentAmtLogByAgentId(sysOffice.getId());
			if (CollectionUtils.isNotEmpty(banks)) {
				PmAgentBank bank=banks.get(0);
				pmAgentBank.setAccountName(bank.getAccountName());
				pmAgentBank.setIdcard(bank.getIdcard());
			}
			pmAgentBank.setBankName(BankUtil.getBankName(pmAgentBank.getAccount()));
			return "modules/h5/agent/add-bankmsg";
		}else if (type.equals("3")) {
			String smscode=(String) session.getAttribute(pmAgentBank.getPhoneNum()+"_smscode");
			if (StringUtils.isBlank(smscode)) {
				String smsCode = RandomNumber.getRandomCode();//随机生成的6位数验证码
				String smsmsg="尊敬的用户，您本次使用服务的短信验证码为："+smsCode+"。请注意查收，勿向他人泄露此验证码，2分钟内有效。";
				boolean flag = CommonUtils.sendMsg(pmAgentBank.getPhoneNum(), smsmsg);
				session.setAttribute(pmAgentBank.getPhoneNum()+"_smscode", smsCode);
				session.setMaxInactiveInterval(2*60);////以秒为单位，即在没有活动2分钟后，session将失效
			}
			return "modules/h5/agent/verify-bank";
	    }
		return "modules/h5/agent/add-bank";
	}
	
	/**发送验证码
	 * @throws Exception */
	@RequestMapping("/sendSmsCode")
	@ResponseBody
	public String sendSmsCode(String phoneNum,Model model,HttpSession session) throws Exception{
		if (StringUtils.isBlank(phoneNum)) {
			return "手机号不可空";
		}
		String smscode=(String) session.getAttribute(phoneNum+"_smscode");
		if (StringUtils.isNotBlank(smscode)) {
			return "短信已发送！";
		}
		String smsCode = RandomNumber.getRandomCode();//随机生成的6位数验证码
		String smsmsg="尊敬的用户，您本次使用服务的短信验证码为："+smsCode+"。请注意查收，勿向他人泄露此验证码，2分钟内有效。";
		boolean flag = CommonUtils.sendMsg(phoneNum, smsmsg);
		session.setAttribute(phoneNum+"_smscode", smsCode);
		session.setMaxInactiveInterval(2*60);////以秒为单位，即在没有活动2分钟后，session将失效
		if(flag){//测试中，发布时删掉感叹号
		}else {
			return "短信发送失败,请重试";
		}
		return "00";
	}
	
	/**保存银行卡*/
	@RequestMapping("/saveBank")
	@ResponseBody
	public String saveBank(PmAgentBank pmAgentBank,String smscode,Model model,HttpSession session){
		SysUser user=(SysUser) session.getAttribute("agentUser");
		SysOffice sysOffice=user.getCompany();
		String smsCode=(String) session.getAttribute(pmAgentBank.getPhoneNum()+"_smscode");
		if (StringUtils.isBlank(smscode)) {
			return "请输入验证码";
		}
		if (StringUtils.isBlank(smsCode)) {
			return "请重新获取验证码";
		}
		if (smscode.equals(smsCode)) {
			if (StringUtils.isNotBlank(pmAgentBank.getAccount())) {
				PmAgentBank bank=new PmAgentBank();
				bank.setAccount(pmAgentBank.getAccount());
				List<PmAgentBank>  banks=pmAgentBankService.findPmAgentBankList(bank);
				if (CollectionUtils.isNotEmpty(banks)) {
					return "银行卡已存在";
				}
				pmAgentBank.setAgentId(sysOffice.getId());
				pmAgentBank.setBankType(0);
				pmAgentBank.setCreateTime(new Date());
				pmAgentBank.setIsDefault(0);
				pmAgentBank.setIsdelete(0);
				pmAgentBankService.save(pmAgentBank);
			}else {
				return "银行卡不存在";
			}
			
		}else {
			return "验证码不正确";
		}
		return "00";
	}
	
	/**银行卡详细管理*/
	@RequestMapping("/bankStyle")
	public String bankStyle(PmAgentBank pmAgentBank,String smscode,Model model,HttpSession session){
		SysUser user=(SysUser) session.getAttribute("agentUser");
		SysOffice sysOffice=user.getCompany();
		pmAgentBank=pmAgentBankService.get(pmAgentBank.getId());
		model.addAttribute("pmAgentBank", pmAgentBank);
		return "modules/h5/agent/bank-style";
	}
	
	/**删除银行卡*/
	@RequestMapping("/delBank")
	public String delBank(PmAgentBank pmAgentBank,String smscode,Model model,HttpSession session){
		SysUser user=(SysUser) session.getAttribute("agentUser");
		SysOffice sysOffice=user.getCompany();
		pmAgentBank=pmAgentBankService.get(pmAgentBank.getId());
		if (pmAgentBank!=null) {
			pmAgentBank.setIsdelete(0);
			pmAgentBankService.save(pmAgentBank);
		}
		return "redirect:/h5/agentUser/myBankcard";
	}
	
	/**设置默认银行卡*/
	@RequestMapping("/setDefaultBank")
	public String setDefaultBank(PmAgentBank pmAgentBank,String smscode,Model model,HttpSession session){
		SysUser user=(SysUser) session.getAttribute("agentUser");
		SysOffice sysOffice=user.getCompany();
		pmAgentBankService.resetDefaultBank(sysOffice.getId());//全部默认0
		pmAgentBank=pmAgentBankService.get(pmAgentBank.getId());
		if (pmAgentBank!=null) {
			pmAgentBank.setIsDefault(1);
			pmAgentBankService.save(pmAgentBank);
		}
		return "redirect:/h5/agentUser/myBankcard";
	}
	
	/**提现记录页面*/
	@RequestMapping("/withdrawalRecord")
	public String withdrawalRecord(String id,Model model,HttpSession session){
		model.addAttribute("id", id);
		return "modules/h5/agent/withdrawal-record";
	}
	
	
	/**提现记录json*/
	@RequestMapping("/withdrawalRecordList")
	@ResponseBody
	public List<PmAgentAmtLog> withdrawalRecordList(Model model,HttpSession session,HttpServletRequest request){
		SysUser user=(SysUser) session.getAttribute("agentUser");
		SysOffice sysOffice=user.getCompany();
		String stateRow=request.getParameter("stateRow");
		String endRow=request.getParameter("endRow");
		Integer stateNum = 0;// 开始行数
		if (StringUtils.isNotBlank(stateRow)) {
			stateNum = Integer.parseInt(stateRow);
		}
		Integer endNum = 10;// 结束行数
		if (StringUtils.isNotBlank(endRow)) {
			endNum = Integer.parseInt(endRow);
		}
		PmAgentAmtLog pmAgentAmtLog=new PmAgentAmtLog();
		pmAgentAmtLog.setAgentId(sysOffice.getId());
		pmAgentAmtLog.setAmtType(1);
		List<PmAgentAmtLog> pmAgentAmtLogs=pmAgentAmtLogService.findPmAgentAmtLogList(stateNum, endNum, pmAgentAmtLog);
		return pmAgentAmtLogs;
	}
	
	
	
	/**消息页面*/
	@RequestMapping("/information")
	public String information(String smscode,Model model,HttpSession session){
		return "modules/h5/agent/information";
	}
	
	/**消息json*/
	@RequestMapping("/informationList")
	@ResponseBody
	public List<EbMessageUser> informationList(Model model,HttpSession session,HttpServletRequest request){
		SysUser user=(SysUser) session.getAttribute("agentUser");
		SysOffice sysOffice=user.getCompany();
		String stateRow=request.getParameter("stateRow");
		String endRow=request.getParameter("endRow");
		Integer stateNum = 0;// 开始行数
		if (StringUtils.isNotBlank(stateRow)) {
			stateNum = Integer.parseInt(stateRow);
		}
		Integer endNum = 10;// 结束行数
		if (StringUtils.isNotBlank(endRow)) {
			endNum = Integer.parseInt(endRow);
		}
		EbMessageUser ebMessageUser=new EbMessageUser();
		ebMessageUser.setOffice(sysOffice);
		List<EbMessageUser> ebMessageUsers=EbCollectService.getEbMessageUsers(stateNum, endNum, ebMessageUser);
		return ebMessageUsers;
	}
	
	/**贡献明细页面*/
	@RequestMapping("/contributeDetails")
	public String contributeDetails(String userId,Model model,HttpSession session){
		if (StringUtils.isNotBlank(userId)) {
			EbUser ebUser=ebUserService.getEbUser(userId);
			if (ebUser!=null) {
				//统计总御可贡茶数量
				double totalLoveCount=pmOrderLoveLogService.totalLoveCount("'"+ebUser.getShopId()+"'");
				model.addAttribute("user", ebUser);
				model.addAttribute("totalLoveCount", totalLoveCount);
			}
		}
		return "modules/h5/agent/contribute-details";
	}
	
	
	/**贡献明细json
	 * @throws ParseException */
	@RequestMapping("/contributeDetailsList")
	@ResponseBody
	public List<EbUser> contributeDetailsList(String shopId,Model model,HttpSession session,HttpServletRequest request) throws ParseException{
		SysUser user=(SysUser) session.getAttribute("agentUser");
		SysOffice sysOffice=user.getCompany();
		String stateRow=request.getParameter("stateRow");
		String endRow=request.getParameter("endRow");
		Integer stateNum = 0;// 开始行数
		if (StringUtils.isNotBlank(stateRow)) {
			stateNum = Integer.parseInt(stateRow);
		}
		Integer endNum = 10;// 结束行数
		if (StringUtils.isNotBlank(endRow)) {
			endNum = Integer.parseInt(endRow);
		}
		List<Object> times =ebOrderService.getPageObjectList(stateNum, endNum,"'"+shopId+"'");
		List<EbUser> ebUsers=new ArrayList<EbUser>();
		EbUser ebUser=null;
		for (Object  s : times) {
			if (s==null) {
				continue;
			}
			ebUser=new EbUser();
			String stime=s+" 00:00:00";
			Date ttime =DateUtil.addDate(DateUtil.convertStringToDate("yyyy-MM-dd HH:mm:ss", stime), 5, 1);
			String  etime =DateUtil.getDateTime("yyyy-MM-dd HH:mm:ss", ttime);
			double oneDayRevenue=ebOrderService.oneDayRevenue(shopId, stime, etime);//统计一天的总营业额
			double oneDayLoveCount=pmOrderLoveLogService.oneDayLoveCount(shopId, stime, etime);//统计一天的总御可贡茶数量
			ebUser.setTotalRevenue(oneDayRevenue);
			ebUser.setTotalLoveCount(oneDayLoveCount);
			ebUser.setInformation(s+"");
			ebUsers.add(ebUser);
		}
		return ebUsers;
	}
	
	
	/**导航到营业统计页面*/
	@RequestMapping("/businessStatistics")
	public String businessStatistics(HttpSession session, Model model){
		SysUser user=(SysUser) session.getAttribute("agentUser");
		SysOffice sysOffice=user.getCompany();
		String agentIds= sysOfficeService.getAgentIdList(sysOffice);
		String agentShopIds=ebUserService.getAgentShopIds(agentIds);//所有商家ids
		if (StringUtils.isNotBlank(agentShopIds)) {
			//统计总营业额
			double totalRevenue=ebOrderService.totalRevenue(agentShopIds);
			//统计总交易量
			Integer totalVolume=ebOrderService.totalVolume(agentShopIds,null,null);
			model.addAttribute("totalRevenue", totalRevenue);
			model.addAttribute("totalVolume", totalVolume);
		}
		return "modules/h5/agent/business-statistics";
	}
	
	/**营业统计明细json*/
	@RequestMapping("/businessStatisticsList")
	@ResponseBody
	public List<EbUser> businessStatisticsList(Model model,HttpSession session,HttpServletRequest request) throws ParseException{
		SysUser user=(SysUser) session.getAttribute("agentUser");
		SysOffice sysOffice=user.getCompany();
		String agentIds= sysOfficeService.getAgentIdList(sysOffice);
		String agentShopIds=ebUserService.getAgentShopIds(agentIds);//所有商家ids
		if (StringUtils.isBlank(agentShopIds)) {
			return null;
		}
		String stateRow=request.getParameter("stateRow");
		String endRow=request.getParameter("endRow");
		Integer stateNum = 0;// 开始行数
		if (StringUtils.isNotBlank(stateRow)) {
			stateNum = Integer.parseInt(stateRow);
		}
		Integer endNum = 10;// 结束行数
		if (StringUtils.isNotBlank(endRow)) {
			endNum = Integer.parseInt(endRow);
		}
		List<Object> times =ebOrderService.getRevenueAndVolumeList(stateNum, endNum,agentShopIds);
		List<EbUser> ebUsers=new ArrayList<EbUser>();
		EbUser ebUser=null;
		for (Object  s : times) {
			if (s==null) {
				continue;
			}
			ebUser=new EbUser();
			String stime=s+" 00:00:00";
			Date ttime =DateUtil.addDate(DateUtil.convertStringToDate("yyyy-MM-dd HH:mm:ss", stime), 5, 1);
			String  etime =DateUtil.getDateTime("yyyy-MM-dd HH:mm:ss", ttime);
			//统计一天的总营业额
			double oneDayRevenue=ebOrderService.oneDayRevenue(agentShopIds, stime, etime);
			//统计一天总交易量
			Integer oneDaytotalVolume=ebOrderService.totalVolume(agentShopIds, stime, etime);
			ebUser.setTotalRevenue(oneDayRevenue);
			ebUser.setTotalVolume(oneDaytotalVolume);
			ebUser.setInformation(s+"");
			ebUsers.add(ebUser);
		}
		return ebUsers;
	}
	
	
	/**导航到交易明细页面*/
	@RequestMapping("/transactionDetails")
	public String transactionDetails(String time,HttpSession session, Model model){
		model.addAttribute("time", time+" 00:00:00");
		return "modules/h5/agent/transaction-details";
	}
	
	
	/**交易明细明细json*/
	@RequestMapping("/transactionDetailsList")
	@ResponseBody
	public List<EbOrder> transactionDetailsList(String time,Model model,HttpSession session,HttpServletRequest request) throws ParseException{
		SysUser user=(SysUser) session.getAttribute("agentUser");
		SysOffice sysOffice=user.getCompany();
		String agentIds= sysOfficeService.getAgentIdList(sysOffice);
		String agentShopIds=ebUserService.getAgentShopIds(agentIds);//所有商家ids
		if (StringUtils.isBlank(agentShopIds)) {
			return null;
		}
		String stime=time+" 00:00:00";
		Date ttime =DateUtil.addDate(DateUtil.convertStringToDate("yyyy-MM-dd HH:mm:ss", stime), 5, 1);
		String  etime =DateUtil.getDateTime("yyyy-MM-dd HH:mm:ss", ttime);
		
		String stateRow=request.getParameter("stateRow");
		String endRow=request.getParameter("endRow");
		Integer stateNum = 0;// 开始行数
		if (StringUtils.isNotBlank(stateRow)) {
			stateNum = Integer.parseInt(stateRow);
		}
		Integer endNum = 10;// 结束行数
		if (StringUtils.isNotBlank(endRow)) {
			endNum = Integer.parseInt(endRow);
		}
		List<EbOrder> ebOrders =ebOrderService.getEbOrderList(stateNum, endNum,agentShopIds,stime,etime);
		for (EbOrder eo : ebOrders) {
			EbUser ebUser=ebUserService.getShop(eo.getShopId()+"");
			eo.setEbUser(ebUser);
		}
		return ebOrders;
	}
	
	/**导航到收益统计页面*/
	@RequestMapping("/incomeStatistics")
	public String incomeStatistics(HttpSession session, Model model){
		SysUser user=(SysUser) session.getAttribute("agentUser");
		SysOffice sysOffice=user.getCompany();
		String agentIds= sysOfficeService.getAgentIdList(sysOffice);
		String agentShopIds=ebUserService.getAgentShopIds(agentIds);//所有商家ids
		if (StringUtils.isNotBlank(agentShopIds)) {
			//统计总御可贡茶数量
			double totalLoveCount=pmOrderLoveLogService.totalLoveCount(agentShopIds);
			model.addAttribute("totalLoveCount", totalLoveCount);
		}
		//代理的所有商家
		model.addAttribute("shopUserCout", ebUserService.getShopUserCout(agentIds));
		return "modules/h5/agent/income-statistics";
	}
	
	//收益统计 代理下的商家用户json
	@RequestMapping("/incomeStatisticsList")
	@ResponseBody
	public List<EbUser> incomeStatisticsList(EbUser ebUser,HttpSession session,HttpServletRequest request, HttpServletResponse response, Model model){
		SysUser user=(SysUser) session.getAttribute("agentUser");
		SysOffice sysOffice=user.getCompany();
		
		String stateRow=request.getParameter("stateRow");
		String endRow=request.getParameter("endRow");
		Integer stateNum = 0;// 开始行数
		if (StringUtils.isNotBlank(stateRow)) {
			stateNum = Integer.parseInt(stateRow);
		}
		Integer endNum = 10;// 结束行数
		if (StringUtils.isNotBlank(endRow)) {
			endNum = Integer.parseInt(endRow);
		}
		String agentIds= sysOfficeService.getAgentIdList(sysOffice);
		List<EbUser> users =ebUserService.getUserByAgentIdsList(stateNum, endNum,ebUser,agentIds);
		return users;
	}
	/**可激love详情*/
	@RequestMapping("/usableLoveDetail")
	public String usableLoveDetail(HttpSession session, Model model){
		SysUser user=(SysUser) session.getAttribute("agentUser");
		SysOffice sysOffice=user.getCompany();
		List<PmAgentLoveLevel> levels=pmAgentLoveLevelService.getList(sysOffice.getId());
		if (CollectionUtils.isNotEmpty(levels)) {
			model.addAttribute("level", levels.get(0));
		}
		return "modules/h5/agent/usableLoveDetail";
	}
	
	
}
