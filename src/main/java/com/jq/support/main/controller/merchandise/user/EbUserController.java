package com.jq.support.main.controller.merchandise.user;

import java.io.File;
import java.io.FileOutputStream;
import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jq.support.model.certificate.EbCertificate;
import com.jq.support.model.certificate.EbCertificateUser;
import com.jq.support.model.order.*;
import com.jq.support.service.certificate.EbCertificateUserService;
import com.jq.support.service.merchandise.order.*;
import org.apache.commons.collections.CollectionUtils;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.jq.support.common.config.Global;
import com.jq.support.common.persistence.Page;
import com.jq.support.common.security.Md5Encrypt;
import com.jq.support.common.utils.DateUtils;
import com.jq.support.common.utils.FileUtils;
import com.jq.support.common.utils.StringUtils;
import com.jq.support.common.web.BaseController;
import com.jq.support.dao.sys.SysUserDao;
import com.jq.support.model.agent.PmAgentInfo;
import com.jq.support.model.product.PmShopInfo;
import com.jq.support.model.sys.SysDict;
import com.jq.support.model.sys.SysOffice;
import com.jq.support.model.sys.SysUser;
import com.jq.support.model.user.EbUserMoney;
import com.jq.support.model.user.EbUser;
import com.jq.support.model.user.PmAmtLog;
import com.jq.support.model.user.PmUserBank;
import com.jq.support.service.agent.PmAgentInfoService;
import com.jq.support.service.merchandise.shop.PmShopInfoService;
import com.jq.support.service.merchandise.user.EbUserMoneyService;
import com.jq.support.service.merchandise.user.EbUserService;
import com.jq.support.service.merchandise.user.PmAmtLogService;
import com.jq.support.service.merchandise.user.PmUserBankService;
import com.jq.support.service.merchandise.user.PmUserLevelRelationService;
import com.jq.support.service.sys.SysDictService;
import com.jq.support.service.sys.SysOfficeService;
import com.jq.support.service.utils.DateUtil;
import com.jq.support.service.utils.ShareCodeUtil;
import com.jq.support.service.utils.SysUserUtils;

/**
 * 会员
 * 
 * @author Administrator
 * 
 */
@Controller
@RequestMapping(value = "${adminPath}/User")
public class EbUserController extends BaseController {
	@Autowired
	private EbUserService ebUserService;
	@Autowired
	private EbUserMoneyService ebExpandService;
	@Autowired
	private PmUserLevelRelationService pmUserLevelRelationService;
	@Autowired
	private PmUserBankService pmUserBankService;
	@Autowired
	private PmAmtLogService pmAmtLogService;
	@Autowired
	private PmOrderLoveLogService pmOrderLoveLogService;
	@Autowired
	private EbOrderService ebOrderService;
	@Autowired
	private EbAftersaleService ebAftersaleService;
	@Autowired
	private PmFrozenLoveLogService pmFrozenLoveLogService;
	@Autowired
	private SysOfficeService officeService;
	@Autowired
	private SysUserDao sysUserDao;
	@Autowired
	private PmConsumptionPointsLogService consumptionPointsLogService;
	@Autowired
	PmShopInfoService pmShopInfoService;
	@Autowired
	private PmAgentInfoService agentService;
	@Autowired
	private SysDictService sysDictService;
	@Autowired
	private EbOrderitemService ebOrderitemService;

	//用户优惠券的service
	@Autowired
	private EbCertificateUserService ebCertificateUserService;

	private static String domainurl = Global.getConfig("domainurl");

	@ModelAttribute
	public EbUser get(@RequestParam(required = false) String userId,String mobile) {
		if (org.apache.commons.lang3.StringUtils.isNotBlank(userId)&&!"undefined".equals(userId)) {
			return ebUserService.getEbUser(userId);
		} else {
			return new EbUser();
		}
	}

	@RequiresPermissions("merchandise:user:view")
	@RequestMapping(value = { "list", "" })
	public String list(EbUser ebUser, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		SysUser user = SysUserUtils.getUser();
		SysOffice sysOffice = user.getCompany();
		if (sysOffice != null) {

			ebUser.setAgentId(sysOffice.getId());
			Page<EbUser> page = ebUserService.getPageList(new Page<EbUser>(
					request, response), ebUser, user,true);
			for(int i=0;i<page.getList().size();i++){
				ebUserService.getEbExpandByEbUser(page.getList().get(i));
			}


			model.addAttribute("page", page);
			model.addAttribute("ebUser", ebUser);
		}
		return "modules/shopping/user/userlist";
	}

	@RequiresPermissions("merchandise:user:view")
	@RequestMapping(value = { "supplyList" })
	public String supplyList(EbUser ebUser, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		SysUser user = SysUserUtils.getUser();
		SysOffice sysOffice = user.getCompany();

		if (sysOffice != null) {
			String key = ebUser.getUsername();
			ebUser.setUsername(null);
			ebUser.setAgentId(sysOffice.getId());
			Page<EbUser> page = ebUserService.getPageList(new Page<EbUser>(
					request, response), ebUser, user, key,false,true,false,false);
			ebUser.setUsername(key);
			model.addAttribute("page", page);
			model.addAttribute("ebUser", ebUser);
		}
		return "modules/shopping/user/supplylist";
	}

	@RequiresPermissions("merchandise:user:view")
	@RequestMapping(value = "userrelation")
	public String userrelation(HttpServletRequest request,
			HttpServletResponse response, Model model) {
		String userId = request.getParameter("userId");
		model.addAttribute("userId", userId);
		return "modules/shopping/user/member-relation";
	}

	@RequiresPermissions("merchandise:user:view")
	@RequestMapping(value = "form")
	public String form(EbUser ebUser, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		createPicFold(request);
		model.addAttribute("userId", ebUser.getUserId());
		if (StringUtils.isNotBlank(ebUser.getAgentId())) {
//			if (StringUtils.isNotBlank(ebUser.getAgentId())) {
//				List<SysUser> sysUsers = sysUserDao.findUserByCompanyid(ebUser
//						.getAgentId());
//				if (sysUsers != null && sysUsers.size() > 0) {
//					model.addAttribute("sysUser", sysUsers.get(0));
//				}
//				model.addAttribute("sysUsers", sysUsers);
//			}
			PmAgentInfo pmAgentInfo=agentService.get(Integer.parseInt(ebUser.getAgentId()));
			model.addAttribute("pmAgentInfo", pmAgentInfo);
		}
		model.addAttribute("ebUser", ebUser);


		//创建上传头像的路径
		String realPath = request.getSession().getServletContext().getRealPath("/");
		File file = new File(realPath + "/merchandise/avataraddress");
		if(!file.exists()){
			file.mkdirs();
		}

		return "modules/shopping/user/member-msg";
	}

	@RequiresPermissions("merchandise:user:view")
	@RequestMapping(value = "supplyuseredit")
	public String supplyUseredit(EbUser ebUser, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		createPicFold(request);
		model.addAttribute("userId", ebUser.getUserId());
		ebUser.setPassword("");
		model.addAttribute("ebUser", ebUser);
		return "modules/shopping/user/supply_useredit";
	}

	/**
	 * 供应商添加或者修改
	 * 
	 * @param ebUser
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception 
	 */
	@RequiresPermissions("merchandise:user:edit")
	@RequestMapping(value = "savesupplyuser")
	@Transactional
	@ResponseBody
	public Map<String, Object> saveSupplyuser(EbUser ebUser, 
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		String userId = request.getParameter("userId");
		String districtName = request.getParameter("districtName");
		String avataraddress = request.getParameter("avataraddress");
		String mobile = request.getParameter("mobile");
		String companyName = request.getParameter("companyName");
		String shopName = request.getParameter("shopName");
		String contactName = request.getParameter("contactName");
		String customerPhone = request.getParameter("customerPhone");
		String contactAddress = request.getParameter("contactAddress");
		String district = request.getParameter("district");
		String longitude = request.getParameter("longitude");
		String latitude = request.getParameter("latitude");
		String businessCodeLogo = request.getParameter("businessCodeLogo");
		String legalPerson = request.getParameter("legalPerson");
		String capital = request.getParameter("capital");
		String licenseAppScope = request.getParameter("licenseAppScope");
		String reviewReason = request.getParameter("reviewReason");
		String businessStartTime = request.getParameter("businessStartTime");
		String businessEndTime = request.getParameter("businessEndTime");
		String password = request.getParameter("password");
		PmShopInfo pmShopInfo = null;
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("code", "01");
		if (!StringUtils.isNotBlank(mobile)) {
			map.put("msg", "请填写供应商联系人手机号");
			return map;
		}else if (!ebUserService.isMobile(mobile)) {
			map.put("msg", "请填写正确供应商联系人手机号");
			return map;
		} else if (!StringUtils.isNotBlank(companyName)) {
			map.put("msg", "请填写供应商公司");
			return map;
		} else if (!StringUtils.isNotBlank(shopName)) {
			map.put("msg", "请填写供应商门店");
			return map;
		} else if (!StringUtils.isNotBlank(contactName)) {
			map.put("msg", "请填写联系人");
			return map;
		} else if (!StringUtils.isNotBlank(customerPhone)) {
			map.put("msg", "请填写联系人电话/手机");
			return map;
		} else if (!StringUtils.isNotBlank(contactAddress)) {
			map.put("msg", "请填写所在详细地址");
			return map;
		} else if (!StringUtils.isNotBlank(businessCodeLogo)) {
			map.put("msg", "请上传营业执照");
			return map;
		} else if (!StringUtils.isNotBlank(legalPerson)) {
			map.put("msg", "请填写法人代表");
			return map;
		} else if (!StringUtils.isNotBlank(capital)) {
			map.put("msg", "请填写注册资金");
			return map;
		} else if (!StringUtils.isNotBlank(businessStartTime)
				|| !StringUtils.isNotBlank(businessEndTime)) {
			map.put("msg", "请填写营业执照有效期");
			return map;
		} else if (!StringUtils.isNotBlank(licenseAppScope)) {
			map.put("msg", "请填写营业执照经营范围");
			return map;
		}else if (!StringUtils.isNotBlank(licenseAppScope)) {
			map.put("msg", "请填写营业执照经营范围");
			return map;
		}else if (!StringUtils.isNotBlank(userId)
				&& !StringUtils.isNotBlank(password)) {
			map.put("msg", "请填写密码");
			return map;
		}
		ebUser=null;
		
		if (StringUtils.isNotBlank(userId)) {
			ebUser = ebUserService.getEbUser(userId);
			ebUser.setAvataraddress(avataraddress);
			if(StringUtils.isNotBlank(password))
			ebUser.setPassword(Md5Encrypt.getMD5Str(password).toLowerCase());
		} else {
			ebUser=ebUserService.getEbUserByMobile(mobile);
			if(ebUser!=null){
				map.put("msg", "该手机账号已被注册");
				return map;
			}
			Map<String,Object> userhm=ebUserService.registerUser(mobile, Md5Encrypt.getMD5Str(password).toLowerCase(), null,6,"后台供应商添加");
			ebUser = (EbUser) userhm.get("objuser");
			if(ebUser==null){
				return userhm;
			}
			ebUser.setUserType("1");
			ebUser.setAvataraddress(avataraddress);
			ebUser.setMobile(mobile);
			
			
			SysDict parameterDict=new SysDict();
			parameterDict.setType("gyconfig");
			parameterDict.setLabel("Envoy_Pay");
			SysDict maxPay=sysDictService.getDict(parameterDict);
			ebUser.setMaxPay(Double.parseDouble(maxPay.getValue()));
		}
		if (ebUser != null && ebUser.getShopIdBigB() != null)
			pmShopInfo = pmShopInfoService.getpmPmShopInfo(ebUser.getShopIdBigB()
					+ "");
		if (pmShopInfo == null) {
			pmShopInfo = new PmShopInfo();
			pmShopInfo.setShopType(2);
			pmShopInfo.setDistrictName(districtName);
			pmShopInfo.setCompanyName(companyName);
			pmShopInfo.setShopName(shopName);
			pmShopInfo.setContactName(contactName);
			pmShopInfo.setCustomerPhone(customerPhone);
			pmShopInfo.setContactAddress(contactAddress);
			pmShopInfo.setShopLongitude(longitude);
			pmShopInfo.setShopLatitude(latitude);
			pmShopInfo.setBusinessCodeLogo(businessCodeLogo);
			pmShopInfo.setLegalPerson(legalPerson);
			pmShopInfo.setCapital(new BigDecimal(capital));
			pmShopInfo.setLicenseAppScope(licenseAppScope);
			pmShopInfo.setReviewReason(reviewReason);
			pmShopInfo.setShopTypeIdentity(1);
			Date date = new Date();
			pmShopInfo.setCreateTime(date);
			SysUser user = SysUserUtils.getUser();
			pmShopInfo.setCreateUser(user.getLoginName());
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			if (StringUtils.isNotEmpty(businessStartTime)) {
				pmShopInfo.setBusinessStartTime(sdf.parse(businessStartTime));
			}
			if (StringUtils.isNotEmpty(businessEndTime)) {
				pmShopInfo.setBusinessEndTime(sdf.parse(businessEndTime));
			}
			if (StringUtils.isNotBlank(districtName)) {
				String area[] = districtName.split(",");
				if (area.length == 5) {
					pmShopInfo.setDistrictName(area[0] + "," + area[1] + ","
							+ area[2] + "," + area[3]);
					pmShopInfo.setShopLlAddress(districtName.substring(
							districtName.lastIndexOf(",") + 1,
							districtName.length()));
				} else if (area.length == 4) {
					pmShopInfo.setDistrictName(area[0] + "," + area[1] + ","
							+ area[2] + "," + area[3]);
					pmShopInfo.setShopLlAddress("");
				}

			}
		} else {
			pmShopInfo.setDistrictName(districtName);
			pmShopInfo.setCompanyName(companyName);
			pmShopInfo.setShopName(shopName);
			pmShopInfo.setContactName(contactName);
			pmShopInfo.setCustomerPhone(customerPhone);
			pmShopInfo.setContactAddress(contactAddress);
			pmShopInfo.setShopLongitude(longitude);
			pmShopInfo.setShopLatitude(latitude);
			pmShopInfo.setBusinessCodeLogo(businessCodeLogo);
			pmShopInfo.setLegalPerson(legalPerson);
			pmShopInfo.setCapital(new BigDecimal(capital));
			Date date = new Date();
			pmShopInfo.setModifyTime(date);
			SysUser user = SysUserUtils.getUser();
			pmShopInfo.setModifyUser(user.getLoginName());
			pmShopInfo.setLicenseAppScope(licenseAppScope);
			pmShopInfo.setReviewReason(reviewReason);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			if (StringUtils.isNotEmpty(businessStartTime)) {
				pmShopInfo.setBusinessStartTime(sdf.parse(businessStartTime));
			}
			if (StringUtils.isNotEmpty(businessEndTime)) {
				pmShopInfo.setBusinessEndTime(sdf.parse(businessEndTime));
			}
			if (StringUtils.isNotBlank(districtName)) {
				String area[] = districtName.split(",");
				if (area.length == 5) {
					pmShopInfo.setDistrictName(area[0] + "," + area[1] + ","
							+ area[2] + "," + area[3]);
					pmShopInfo.setShopLlAddress(districtName.substring(
							districtName.lastIndexOf(",") + 1,
							districtName.length()));
				} else if (area.length == 4) {
					pmShopInfo.setDistrictName(area[0] + "," + area[1] + ","
							+ area[2] + "," + area[3]);
					pmShopInfo.setShopLlAddress("");
				}

			}
		}
		pmShopInfoService.save(pmShopInfo);
		ebUser.setShopIdBigB(pmShopInfo.getId());
		ebUserService.save(ebUser);
		if(StringUtils.isBlank(ebUser.getCartNum())){
		String code = ShareCodeUtil.toSerialCode(ebUser.getUserId());
		ebUser.setCartNum(code);
		ebUserService.save(ebUser);
		}
		map.put("code","00");
		map.put("userId",ebUser.getUserId()+"");
		map.put("msg", "保存成功");
		return map;
	}

	@RequiresPermissions("merchandise:user:edit")
	@RequestMapping(value = "userinfoedit")
	public String userinfoedit(HttpServletRequest request,
			HttpServletResponse response, Model model) {
		String userId = request.getParameter("userId");
		String avataraddress = request.getParameter("avataraddress");
		String username = request.getParameter("username");
		String sex = request.getParameter("sex");
		String email = request.getParameter("email");
		String status = request.getParameter("status");
		String contactPhone = request.getParameter("contactPhone");
		EbUser ebUser = ebUserService.getEbUser(userId);
		if (ebUser != null) {
			ebUser.setAvataraddress(avataraddress);
			if (StringUtils.isNotBlank(username)) {
				ebUser.setUsername(username);
			}
			if (StringUtils.isNotBlank(contactPhone)) {
				ebUser.setContactPhone(contactPhone);
			}
			if (StringUtils.isNotBlank(sex)) {// 性别：0保密、1男、2女
				ebUser.setSex(sex);
			}
			if (StringUtils.isNotBlank(email)) {
				ebUser.setEmail(email);
			}
			if (StringUtils.isNotBlank(status)) {
				ebUser.setStatus(Integer.valueOf(status));
			}
			ebUserService.save(ebUser);
			model.addAttribute("message", "保存成功");
		}
		model.addAttribute("userId", ebUser.getUserId());
		model.addAttribute("ebUser", ebUser);
		return "modules/shopping/user/member-msg";
	}

	@RequiresPermissions("merchandise:user:view")
	@RequestMapping(value = "userAccount")
	public String userAccount(HttpServletRequest request,
			HttpServletResponse response, Model model) {
		String userId = request.getParameter("userId");
		EbUser ebUser = pmAmtLogService.myLoveDetail(userId);
		PmUserBank parameterUserBank = new PmUserBank();
		parameterUserBank.setUserId(ebUser.getUserId());
		parameterUserBank.setIsdelete(0);
		parameterUserBank.setBankType(0);
		String userBankCount = "";
		userBankCount = pmUserBankService.getCount(parameterUserBank);
		Double spendingAmount = Math.abs(Double.valueOf(ebOrderService
				.spendingOrderAmount(ebUser.getUserId())));
		String spendingEbAftersaleAmount = ebAftersaleService
				.spendingEbAftersaleAmount(ebUser.getUserId());// 订单退款总金额
		Double amt = ebUser.getMaxPay() - spendingAmount
				+ Double.parseDouble(spendingEbAftersaleAmount);// 剩余消费额度
		model.addAttribute("surplusAmount", amt);
		model.addAttribute("userBankCount", userBankCount);
		model.addAttribute("userId", ebUser.getUserId());
		model.addAttribute("ebUser", ebUser);
		return "modules/shopping/user/member-account";
	}

	@RequiresPermissions("merchandise:user:edit")
	@RequestMapping(value = "save")
	public String save(EbUser ebUser, HttpServletRequest request,
			HttpServletResponse response, Model model,
			RedirectAttributes redirectAttributes) {
		if (ebUser.getUserId() == null) {
			if (StringUtils.isNotBlank(ebUser.getCartNum())) {
				EbUser ebUser2 = ebUserService.findBycartNum(ebUser
						.getCartNum());
				if (ebUser2 != null) {
					ebUser.setParentId(ebUser2.getUserId());
					ebUser.setRecommendMobile(ebUser2.getMobile());
					ebUser.setUserType("1");
					if (ebUser2.getParentId() == null) {
						ebUser.setUserLevel(2);
					} else {
						ebUser.setUserLevel(ebUser2.getUserLevel() + 1);
					}
				} else {
					EbUser ebUser3 = ebUserService
							.getEbUserByMobileStatus(ebUser.getCartNum());
					if (ebUser3 != null) {
						ebUser.setParentId(ebUser3.getUserId());
						ebUser.setRecommendMobile(ebUser3.getMobile());
						ebUser.setUserType("1");
						if (ebUser3.getParentId() == null) {
							ebUser.setUserLevel(2);
						} else {
							ebUser.setUserLevel(ebUser3.getUserLevel() + 1);
						}
					}
				}
			}
		}
		ebUserService.save(ebUser);
		if (ebUser.getUserId() == null) {
			String code = ShareCodeUtil.toSerialCode(ebUser.getUserId());
			ebUser.setCartNum(code);
			ebUserService.save(ebUser);
			// 储存用户层级关息
			// pmUserLevelRelationService.fosave(ebUser);
		}
		addMessage(redirectAttributes, "保存成功");
		return "redirect:" + Global.getAdminPath() + "/User/list";
	}

    @ResponseBody
    @RequestMapping("/updatePassword")
    public String updatePassword(String password , String shopId){
	    String msg = "0";
        /* 进行用户表的的密码修改*/
        if (StringUtils.isNotBlank(password)){

            String pws= Md5Encrypt.getMD5Str(password).toLowerCase();//加密
            boolean b = ebUserService.updatePassByShopId(pws,shopId);

            if(b){
                msg="1";
            }
        }
	    return msg;
    }
	@RequiresPermissions("DeleteMyBankCard")
	@RequestMapping(value = "saveStstus")
	public String saveStstus(EbUser ebUser, HttpServletRequest request,
			HttpServletResponse response, Model model,
			RedirectAttributes redirectAttributes) {
		Integer status;
		if (ebUser.getStatus() == 1) {
			status = 2;
		} else {
			status = 1;
		}
		ebUser.setStatus(status);
		ebUserService.save(ebUser);
		addMessage(redirectAttributes, "保存成功");
		return "redirect:" + Global.getAdminPath() + "/User";
	}

	@RequiresPermissions("merchandise:user:edit")
	@RequestMapping(value = "delete")
	public String delete(EbUser ebUser, HttpServletRequest request,
			HttpServletResponse response, Model model,
			RedirectAttributes redirectAttributes) {
		ebUserService.delete(ebUser);
		addMessage(redirectAttributes, "删除成功");
		return "redirect:" + Global.getAdminPath() + "/User/list";
	}

	@ResponseBody
	@RequestMapping(value = "checkLoginName")
	public boolean checkLoginName(String mobile, HttpServletRequest request,
			HttpServletResponse response) {
		if (StringUtils.isNotBlank(mobile)) {
			mobile = mobile.replace(",", "");
			EbUser ebUser = ebUserService.getEbUserByMobile(mobile);
			if (ebUser == null) {
				return true;
			}
		}
		return false;
	}

	@ResponseBody
	@RequestMapping(value = "checkCartNum")
	public boolean checkCartNum(String cartNum, HttpServletRequest request,
			HttpServletResponse response) {
		if (StringUtils.isNotBlank(cartNum)) {
			cartNum = cartNum.replace(",", "");
			EbUser ebUser = ebUserService.findBycartNum(cartNum);
			if (ebUser != null) {
				return true;
			} else {
				EbUser ebUser2 = ebUserService.getEbUserByMobile(cartNum);
				if (ebUser2 != null) {
					return true;
				}
			}
		}
		return false;
	}

	/**
	 * 后台人工充值
	 * 
	 * @param userId
	 *            用户id
	 * @param currentAmt
	 *            充值金额
	 * @param request
	 * @param response
	 * @return
	 */
	@RequiresPermissions("merchandise:user:editInfo")
	@ResponseBody
	@RequestMapping(value = "currentAmt")
	public String currentAmt(String userId, String currentAmt,
			HttpServletRequest request, HttpServletResponse response) {
		// 拓展
		EbUserMoney ebExpand = ebExpandService.getEbExpandByUserId(Integer
				.parseInt(userId));
		if (StringUtils.isNotBlank(currentAmt)) {
			// ebUser.setCurrentAmt(ebUser.getCurrentAmt()+Double.parseDouble(currentAmt));
			ebExpand.setTotalAmt(ebExpand.getTotalAmt()
					+ Double.parseDouble(currentAmt));
			// ebExpandService.save(ebExpand);
			ebExpandService.saveFlush(ebExpand, 0.0,
					Double.parseDouble(currentAmt),
					Double.parseDouble(currentAmt), "后台人工充值",0.0);
			SysUser user = SysUserUtils.getUser();
			PmAmtLog pmAmtLog = new PmAmtLog();
			pmAmtLog.setUserId(ebExpand.getUserId());
			pmAmtLog.setAmt(Double.parseDouble(currentAmt));
			pmAmtLog.setRemark("后台充值");
			pmAmtLog.setStatus(1);
			pmAmtLog.setAmtType(9);
			pmAmtLog.setCreateTime(new Date());
			pmAmtLog.setCreateUser(user.getLoginName());

			pmAmtLogService.save(pmAmtLog);
		}
		return "00";
	}

	/**
	 * 后台改变最大消费额度
	 * 
	 * @param userId
	 *            用户id
	 * @param maxPay
	 *            最大消费额度
	 * @param request
	 * @param response
	 * @return
	 */
	@RequiresPermissions("merchandise:user:editInfo")
	@ResponseBody
	@RequestMapping(value = "setCurrentAmt")
	public String setCurrentAmt(String userId, String maxPay,
			HttpServletRequest request, HttpServletResponse response) {
		EbUser ebUser = ebUserService.getEbUser(userId);
		if (StringUtils.isNotBlank(maxPay)) {
			ebUser.setMaxPay(Double.parseDouble(maxPay));
			ebUserService.save(ebUser);
		}
		return "00";
	}

	@SuppressWarnings("rawtypes")
	@ResponseBody
	@RequestMapping(value = "userNextList")
	public JSONArray userNextList(String userId, String currentAmt,
			HttpServletRequest request, HttpServletResponse response) {
		EbUser ebUser = ebUserService.getEbUser(userId);
		List list = ebUserService.getNextUser(ebUser);
		List<EbUser> ebUsers = new ArrayList<EbUser>();
		for (int i = 0; i < list.size(); i++) {
			Object[] obj = (Object[]) list.get(i);
			EbUser ebUser2 = (EbUser) obj[0];
			ebUsers.add(ebUser2);
		}
		JSONArray jsonArray = new JSONArray();
		ebUsers.add(ebUser);
		List users = ebUserService.getNoNextUser(ebUser);
		for (int j = 0; j < users.size(); j++) {
			Object[] obj = (Object[]) users.get(j);
			EbUser ebUser2 = (EbUser) obj[0];
			ebUsers.add(ebUser2);
		}
		for (EbUser ebUser2 : ebUsers) {
			JSONObject json = new JSONObject();
			json.put("id", ebUser2.getUserId());
			json.put("pId", ebUser2.getParentId());
			json.put("name", ebUser2.getUsername() + "(" + ebUser2.getMobile()
					+ ")");
			if (ebUser.getUserId() == ebUser2.getUserId()) {
				json.put("icon", "/static/sbShop/images/sss.png");
			}
			jsonArray.add(json);
		}
		return jsonArray;
	}

	/**
	 * 后台展示用户余额日志
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("merchandise:user:view")
	@RequestMapping(value = "useramtlog")
	public String useramtlog(HttpServletRequest request,
			HttpServletResponse response, Model model) {
		String userId = request.getParameter("userId");
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		String amt = request.getParameter("amt");
		String amtType = request.getParameter("amtType");
		PmAmtLog pmAmtLog = new PmAmtLog();
		if (StringUtils.isNotBlank(amt)) {
			Double aDouble = Double.parseDouble(amt);
			if (aDouble == 1) {// 消费余额，1 收入 2消费
				pmAmtLog.setAmt(aDouble);
			}
			if (aDouble == 2) {
				pmAmtLog.setAmt(aDouble);
			}
		}
		pmAmtLog.setUserId(Integer.valueOf(userId));
		if (StringUtils.isNotBlank(amtType)) {
			pmAmtLog.setAmtType(Integer.valueOf(amtType));
		}
		Page<PmAmtLog> page = pmAmtLogService.findPmAmtLogList("", "",
				startTime, endTime, "", pmAmtLog, new Page<PmAmtLog>(request,
						response));

		if(page != null && page.getList() !=  null){
			Map<Integer ,String> map = new HashMap<Integer, String>();
			map.put(1,"消费");
			map.put(2,"充值");
			map.put(9,"后台充值");
			map.put(10,"线上货款");

			List<PmAmtLog> list = page.getList();
			for(PmAmtLog log : list){
				log.setContent(map.get(log.getAmtType()));
				log.setShopName("平台");
				//获取相对应的订单
				if(log.getAmtType() == 1 && log.getOrderId() != null){
					EbOrder ebOrder = ebOrderService.getEbOrderById(log.getOrderId());

					List<EbOrderitem> itemList = ebOrderitemService.getByOrderId(ebOrder.getOrderId());
					log.setContent(formatLogContent(itemList));
					log.setShopName(ebOrder.getShopName());
				}
			}
		}


		model.addAttribute("page", page);
		model.addAttribute("startTime", startTime);
		model.addAttribute("endTime", endTime);
		model.addAttribute("amt", amt);
		model.addAttribute("amtType", amtType);
		model.addAttribute("userId", userId);
		return "modules/shopping/user/member-amtlog";
	}


	/**
	 * 处理余额日志列表的商品名、规格、加料的格式
	 * @return
	 */
	public String formatLogContent(List<EbOrderitem> itemList ){
		if(itemList == null || itemList.size() == 0){
			return "";
		}

		StringBuffer content = new StringBuffer();
		for(EbOrderitem item : itemList){
			content.append(item.getProductName()+" * "+item.getGoodsNums());
			if((item.getStandardName()!=null && !"".equals(item.getStandardName()))){
				content.append("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;("+item.getStandardName()+")");
			}

			if(item.getChargingNames()!=null && !"".equals(item.getChargingNames())){
				content.append("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;["+item.getChargingNames()+"]");
			}

			content.append(" | ");
		}

		if(content.length() > 2){
			content.setLength(content.length()-2);
		}

		return content.toString();
	}

	/**
	 *查询用户优惠券明细
	 */
	@RequiresPermissions("merchandise:user:view")
	@RequestMapping(value = "/certificateLog")
	public String getCertificatelist(EbCertificateUser ebCertificateUser,
									 HttpServletRequest request, HttpServletResponse response,
									 Model model, @ModelAttribute("msg") String msg, String startDate,
									 String endDate) {
		if(ebCertificateUser.getUserId() == null){
			model.addAttribute("msg", "获取失败");
			return "modules/shopping/user/member-certificatelog";
		}

		Page<EbCertificateUser> page = ebCertificateUserService.getList(ebCertificateUser , new Page<EbCertificateUser>(request, response), startDate, endDate);
		System.out.println(request.getParameter("startDate"));
		System.out.println(page);
		model.addAttribute("page", page);
		model.addAttribute("msg", msg);
		model.addAttribute("certificate", ebCertificateUser);
		model.addAttribute("startDate", startDate);
		model.addAttribute("endDate", endDate);
		model.addAttribute("userId", ebCertificateUser.getUserId());
		return "modules/shopping/user/member-certificatelog";
	}
//	@RequiresPermissions("merchandise:user:view")
//	@RequestMapping(value = "/certificateLog")
//	public String certificateLog(HttpServletRequest request, HttpServletResponse response, Model model,
//								 EbCertificateUser user , Integer endRow , Integer stateRow) {
////		Page<EbCertificate> page = ebCertificateService.getList(ebCertificate,
////				, startDate, endDate);
//
//		List<EbCertificateUser> list = ebCertificateUserService.ebCertificateUserList(stateRow, endRow, user , new Page<EbCertificateUser>(request, response));
////		System.out.println(request.getParameter("startDate"));
////		System.out.println(page);
////		model.addAttribute("page", page);
////		model.addAttribute("msg", msg);
//		return "modules/shopping/brands/EbCertificatelist";
//	}

	/**
	 * 后台冻结积分显示
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("merchandise:user:view")
	@RequestMapping(value = "fzuserlovelog")
	public String fzuserlovelog(HttpServletRequest request,
			HttpServletResponse response, Model model) {
		String userId = request.getParameter("userId");
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		String loveStatus = request.getParameter("loveStatus");// （1：增加，2：减少）
		String loveType = request.getParameter("loveType");

		PmFrozenLoveLog pmFrozenLoveLog = new PmFrozenLoveLog();
		pmFrozenLoveLog.setObjType(1);// 对象类型：1、用户；2、商家；3、代理；4、平台
		pmFrozenLoveLog.setObjId(userId);
		if (StringUtils.isNotBlank(loveStatus)) {
			pmFrozenLoveLog.setLoveStatus(Integer.valueOf(loveStatus));
		}
		if (StringUtils.isNotBlank(loveType)) {
			pmFrozenLoveLog.setLoveType(Integer.valueOf(loveType));
		}
		Page<PmFrozenLoveLog> page = pmFrozenLoveLogService.findmyloveList(
				new Page<PmFrozenLoveLog>(request, response), pmFrozenLoveLog,
				startTime, endTime);
		model.addAttribute("page", page);
		model.addAttribute("startTime", startTime);
		model.addAttribute("endTime", endTime);
		model.addAttribute("loveStatus", loveStatus);
		model.addAttribute("loveType", loveType);
		model.addAttribute("userId", userId);
		return "modules/shopping/user/member-sanfzblog";
	}

	/**
	 * 后台展示积分日志
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("merchandise:user:view")
	@RequestMapping(value = "userlovelog")
	public String userlovelog(HttpServletRequest request,
			HttpServletResponse response, Model model) {
		String userId = request.getParameter("userId");
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		String loveStatus = request.getParameter("loveStatus");// （1：增加，2：减少）
		String loveType = request.getParameter("loveType");
		PmOrderLoveLog pmOrderLoveLog = new PmOrderLoveLog();
		pmOrderLoveLog.setObjType(1);// 对象类型：1、用户；2、商家；3、代理；4、平台
		pmOrderLoveLog.setObjId(userId);
		pmOrderLoveLog.setCurrencyType(1);
		if (StringUtils.isNotBlank(loveStatus)) {
			pmOrderLoveLog.setLoveStatus(Integer.valueOf(loveStatus));
		}
		if (StringUtils.isNotBlank(loveType)) {
			pmOrderLoveLog.setLoveType(Integer.valueOf(loveType));
		}
		Page<PmOrderLoveLog> page = pmOrderLoveLogService.findmyloveList(
				new Page<PmOrderLoveLog>(request, response), pmOrderLoveLog,
				startTime, endTime);
		model.addAttribute("page", page);
		model.addAttribute("startTime", startTime);
		model.addAttribute("endTime", endTime);
		model.addAttribute("loveStatus", loveStatus);
		model.addAttribute("loveType", loveType);
		model.addAttribute("userId", userId);
		return "modules/shopping/user/member-sanblog";
	}

	/**
	 * 查看该用户银行卡
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions("merchandise:user:view")
	@RequestMapping(value = "userbanks")
	public String userbanks(HttpServletRequest request,
			HttpServletResponse response, Model model,
			RedirectAttributes redirectAttributes) {
		String userId = request.getParameter("userId");
		String message = request.getParameter("message");
		PmUserBank parameterUserBank = new PmUserBank();
		parameterUserBank.setUserId(Integer.valueOf(userId));
		parameterUserBank.setIsdelete(0);
		parameterUserBank.setBankType(0);
		List<PmUserBank> userBanks = pmUserBankService
				.getPmUserBankList(parameterUserBank);
		if (CollectionUtils.isNotEmpty(userBanks)) {
			model.addAttribute("userBanks", userBanks);
		}
		if (StringUtils.isNotBlank(message)) {
			if (message.equals("1")) {
				message = "已删除";
				model.addAttribute("message", message);
			}
			if (message.equals("2")) {
				message = "已默认";
				model.addAttribute("message", message);
			}
		}
		model.addAttribute("userId", userId);
		return "modules/shopping/user/member-userbanks";
	}

	/**
	 * 改变银行卡状态
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("merchandise:user:edit")
	@RequestMapping(value = "bankdelete")
	public String bankdelete(HttpServletRequest request,
			HttpServletResponse response, Model model) {
		String userId = request.getParameter("userId");
		String id = request.getParameter("id");
		pmUserBankService.isdelete(id);
		model.addAttribute("userId", userId);
		return "redirect:" + Global.getAdminPath()
				+ "/User/userbanks?message=1";
	}

	/**
	 * 默认银行卡
	 * 
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("merchandise:user:edit")
	@RequestMapping(value = "bankdefault")
	public String bankdefault(HttpServletRequest request,
			HttpServletResponse response, Model model) {
		String userId = request.getParameter("userId");
		String id = request.getParameter("id");
		SysUser user = SysUserUtils.getUser();
		PmUserBank userBank = pmUserBankService.findid(Integer.valueOf(id));
		pmUserBankService.isNoDefault(Integer.valueOf(userId));
		userBank.setIsDefault(1);
		userBank.setModifyUser(user.getLoginName());
		userBank.setModifyTime(new Date());
		pmUserBankService.save(userBank);
		model.addAttribute("userId", userId);
		return "redirect:" + Global.getAdminPath()
				+ "/User/userbanks?message=2";
	}

	/**
	 * 导出
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@SuppressWarnings("deprecation")
	@ResponseBody
	@RequestMapping(value = "exsel")
	public String exsel(HttpServletRequest request, HttpServletResponse response) {
		String url = "";
		String syllable[] = request.getParameterValues("syllable");
		String username = request.getParameter("username");
		String mobile = request.getParameter("mobile");
		if (syllable != null && syllable.length > 0) {
			int t = 1;
			int pageNo = 1;
			int rowNum = 1;
			int rowNums = 100;
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
				if (syllable[i].equals("1")) {
					cell.setCellValue("账号");
				}
				if (syllable[i].equals("2")) {
					cell.setCellValue("称匿");
				}
				if (syllable[i].equals("3")) {
					cell.setCellValue("邀请码");
				}
				if (syllable[i].equals("4")) {
					cell.setCellValue("当前余额");
				}
				if (syllable[i].equals("5")) {
					cell.setCellValue("当前积分");
				}
				if (syllable[i].equals("6")) {
					String projectName = Global.getConfig("projectName");
					cell.setCellValue("当前"+projectName);
				}
				if (syllable[i].equals("7")) {
					cell.setCellValue("普通合伙人");
				}
				if (syllable[i].equals("8")) {
					cell.setCellValue("精英合伙人");
				}
				if (syllable[i].equals("9")) {
					cell.setCellValue("注册时间");
				}
				if (syllable[i].equals("10")) {
					cell.setCellValue("会员状态");
				}
				if (syllable[i].equals("11")) {
					cell.setCellValue("每天最大支付额度");
				}
				cell.setCellStyle(style);
			}
			while (t == 1) {
				EbUser ebUser = new EbUser();
				if (StringUtils.isNotBlank(username)) {
					ebUser.setUsername(username);
				}
				if (StringUtils.isNotBlank(mobile)) {
					ebUser.setMobile(mobile);
				}
				SysUser user = SysUserUtils.getUser();
				SysOffice sysOffice = user.getCompany();
				if (sysOffice != null) {
					ebUser.setAgentId(sysOffice.getId());
				}
				Page<EbUser> page = ebUserService.getPageList(new Page<EbUser>(
						pageNo, rowNums), ebUser, user,true);
				List<EbUser> ebUsers = new ArrayList<EbUser>();
				ebUsers = page.getList();
				if ((page.getCount() == rowNums && pageNo > 1)
						|| (page.getCount() / rowNums) < 1 && pageNo > 1) {
					ebUsers = null;
				}
				if (ebUsers != null && ebUsers.size() > 0) {
					for (EbUser ebUser2 : ebUsers) {
						try {
							// SmsUserblacklist
							// userblacklist=smsUserblacklists.get(i);
							row = sheet.createRow((int) rowNum);
							row.createCell((short) 0).setCellValue(rowNum);
							for (int i = 0; i < syllable.length; i++) {
								if (syllable[i].equals("1")) {
									row.createCell((short) i).setCellValue(
											ebUser2.getMobile());
								}
								if (syllable[i].equals("2")) {
									row.createCell((short) i).setCellValue(
											ebUser2.getUsername());
								}
								if (syllable[i].equals("3")) {
									row.createCell((short) i).setCellValue(
											ebUser2.getCartNum());
								}
								if (syllable[i].equals("4")) {
									row.createCell((short) i).setCellValue(
											ebUser2.getCurrentAmt());
								}
								if (syllable[i].equals("5")) {
									row.createCell((short) i).setCellValue(
											ebUser2.getCurrentGold());
								}
								if (syllable[i].equals("6")) {
									row.createCell((short) i).setCellValue(
											ebUser2.getCurrentLove());
								}
								if (syllable[i].equals("7")) {
									String Messenger = "";
									if (ebUser2.getIsMessenger() == 1) {
										Messenger = "是";
									} else {
										Messenger = "否";
									}
									row.createCell((short) i).setCellValue(
											Messenger);
								}
								if (syllable[i].equals("8")) {
									String Messenger = "";
									if (ebUser2.getIsAmbassador() == 1) {
										Messenger = "是";
									} else {
										Messenger = "否";
									}
									row.createCell((short) i).setCellValue(
											Messenger);
								}
								if (syllable[i].equals("9")) {
									row.createCell((short) i).setCellValue(
											ebUser2.getCreatetime());
								}
								if (syllable[i].equals("10")) {
									String Messenger = "";
									if (ebUser2.getStatus() == 1) {
										Messenger = "正常";
									} else {
										Messenger = "隐藏";
									}
									row.createCell((short) i).setCellValue(
											Messenger);
								}
								if (syllable[i].equals("11")) {
									row.createCell((short) i).setCellValue(
											ebUser2.getMaxPay());
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
			// JSONObject json=new JSONObject();
			// String code="01";
			String RootPath = request.getSession().getServletContext()
					.getRealPath("/").replace("\\", "/");
			String path = "uploads/xlsfile/tempfile";
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

	/**
	 * 改变用户状态
	 * 
	 * @param userId
	 *            用户id
	 * @param request
	 * @param response
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "byStatus")
	public String byStatus(String userId, HttpServletRequest request,
			HttpServletResponse response) {
		EbUser ebUser = new EbUser();
		if (StringUtils.isNotBlank(userId)) {
			ebUser = ebUserService.getEbUser(userId);
			if (ebUser != null) {
				if (ebUser.getStatus() != null) {
					if (ebUser.getStatus() == 1) {
						ebUser.setStatus(2);
					} else {
						ebUser.setStatus(1);
					}
				} else {
					ebUser.setStatus(2);
				}
				ebUserService.save(ebUser);
			}
		}
		return "00";
	}
	/**
	 * 改变测试状态
	 *
	 * @param userId
	 *            用户id
	 * @param request
	 * @param response
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "byTest")
	public String byTest(String userId, HttpServletRequest request,
						   HttpServletResponse response) {
		EbUser ebUser = new EbUser();
		if (StringUtils.isNotBlank(userId)) {
			ebUser = ebUserService.getEbUser(userId);
			if (ebUser != null) {
				if (ebUser.getTest() != null) {
					if (ebUser.getTest() == 1) {
						ebUser.setTest(0);
					} else {
						ebUser.setTest(1);
					}
				} else {
					ebUser.setTest(0);
				}
				ebUserService.save(ebUser);
			}
		}
		return "00";
	}
	/**
	 * 用户层级关息变更
	 * 
	 * @param userId
	 *            用户id
	 * @param sysId
	 *            代理用户id
	 * @param request
	 * @param response
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "editAgentId")
	public Map<String, Object> editAgentId(String userId, String sysId,
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("code", "01");
		map.put("msg", "修改失败请联系管理员");
		EbUser ebUser = new EbUser();
		if (StringUtils.isNotBlank(userId)) {
			ebUser = ebUserService.getEbUser(userId);
			if (ebUser != null&&StringUtils.isNotBlank(ebUser.getMobile())) {
				if (StringUtils.isBlank(sysId)) {
					map.put("code", "01");
					map.put("msg", "代理id为空");
					return map;
				}
//				SysUser sysUser = sysUserDao.get(sysId);
				PmAgentInfo pmAgentInfo=agentService.get(Integer.parseInt(sysId));
				if (pmAgentInfo == null) {
					map.put("code", "01");
					map.put("msg", "该代理不存在");
					return map;
				}
				ebUserService.mvUserRelationByAgent(ebUser.getMobile(),
						pmAgentInfo.getAgentId()+"");
				map.put("code", "00");
				map.put("msg", "成功");
				return map;
			}else{
				map.put("code", "01");
				map.put("msg", "用户未绑定手机号");
				return map;
			}
		}
		return map;
	}

	/**
	 * 用户更换代理查询代理用户
	 * 
	 * @param userId
	 *            用户id
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "sysShow")
	public String sysShow(String userId, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		if (StringUtils.isNotBlank(userId)) {
			EbUser ebUser = ebUserService.getEbUserById(Integer
					.parseInt(userId));
			if (ebUser != null) {
				if (StringUtils.isNotBlank(ebUser.getAgentId())) {
					SysOffice sysOffice = officeService
							.get(ebUser.getAgentId());
					model.addAttribute("sysOffice", sysOffice);
				}
				model.addAttribute("ebUser", ebUser);
				model.addAttribute("userId", userId);
			}
		}
		return "modules/shopping/user/editSysShow";
	}

	@RequiresPermissions("merchandise:user:view")
	@RequestMapping(value = "consumptionPoints")
	public String consumptionPoints(HttpServletRequest request,
			HttpServletResponse response, Model model) {
		PmConsumptionPointsLog consumptionPointsLog = new PmConsumptionPointsLog();
		String userId = request.getParameter("userId");
		String amt = request.getParameter("amt");
		String amtType = request.getParameter("amtType");
		consumptionPointsLog.setUserId(Integer.valueOf(userId));
		Page<PmConsumptionPointsLog> page = consumptionPointsLogService
				.getpage(new Page<PmConsumptionPointsLog>(request, response),
						consumptionPointsLog, amtType, amt);
		model.addAttribute("page", page);
		model.addAttribute("amt", amt);
		model.addAttribute("amtType", amtType);
		model.addAttribute("userId", userId);
		return "modules/shopping/user/member-points";
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
		// ===========集群文件字段处理 end===============
		folder.append("000000");
		folder.append(File.separator);
		folder.append("images");
		folder.append(File.separator);
		folder.append("merchandise");
		folder.append(File.separator);
		folder.append("avataraddress");
		folder.append(File.separator);
		folder.append(DateUtils.getYear());
		folder.append(File.separator);
		folder.append(DateUtils.getMonth());
		FileUtils.createDirectory(folder.toString());
	}
}