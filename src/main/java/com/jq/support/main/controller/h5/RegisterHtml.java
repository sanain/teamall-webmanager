package com.jq.support.main.controller.h5;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jq.support.common.security.Md5Encrypt;
import com.jq.support.common.utils.StringUtils;
import com.jq.support.common.web.BaseController;
import com.jq.support.model.product.PmServiceProtocol;
import com.jq.support.model.user.EbUser;
import com.jq.support.model.user.PmUserSmsCode;
import com.jq.support.service.merchandise.mecontent.PmServiceProtocolService;
import com.jq.support.service.merchandise.user.EbUserService;
import com.jq.support.service.merchandise.user.PmUserSmsCodeService;
import com.jq.support.service.utils.CommonUtils;
import com.jq.support.service.utils.RandomNumber;


@Controller
@RequestMapping("/RegisterHtml")
public class RegisterHtml extends BaseController {
	@Autowired
	private EbUserService ebUserService;
	@Autowired
	private PmServiceProtocolService pmServiceProtocolService;
	@Autowired
	private PmUserSmsCodeService pmUserSmsCodeService;
	@RequestMapping(value="{id}${urlSuffix}")
	public String Registers(@PathVariable String id, HttpServletRequest request,Model model) throws Exception {
		String registerType = request.getParameter("registerType");/** 1Android,、2,ios、3分享H5注册、4递推二维码H5、5广告二维码H5、6后台供应商添加  */
		String registerName = request.getParameter("registerName");/** 注册来源名字  */
		String cartNum = request.getParameter("cartNum");/** 注册邀请码  */
		PmServiceProtocol pmServiceProtocol = pmServiceProtocolService.getSbServiceProtocolCode("2");
		model.addAttribute("pmServiceProtocol", pmServiceProtocol);
		model.addAttribute("cartNum", cartNum);
		model.addAttribute("registerType", registerType);
		model.addAttribute("registerName", registerName);
		return "modules/h5/register";
	}
	@RequestMapping(value="show")
	public String show( HttpServletRequest request,Model model) throws Exception {
		PmServiceProtocol pmServiceProtocol = pmServiceProtocolService.getSbServiceProtocolCode("2");
		model.addAttribute("pmServiceProtocol", pmServiceProtocol);
		return "modules/h5/article_typy";
	}
	@ResponseBody
	@RequestMapping(value = "SmsCode")
	public Map<String, Object> SmsCode(HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("application/json; charset=UTF-8");
		Map<String, Object> map=new HashMap<String, Object>();
		String smscode="";
		String msg="";
		String mobile=request.getParameter("mobile");
		String type = request.getParameter("type");// 1,注册 2，找回密码3,添加银行卡
		if (StringUtils.isNotBlank(mobile)) {
			if (type.equals("1")) {
				EbUser ebuser = ebUserService.getEbUserByMobile(mobile);
				if (ebuser == null) {
					String smsCode = RandomNumber.getRandomCode();
					String smsmsg="尊敬的用户，您本次使用服务的短信验证码为："+smsCode+"。请注意查收，勿向他人泄露此验证码，2分钟内有效。";
					boolean flag = CommonUtils.sendMsg(mobile, smsmsg);
					if (flag) {
						PmUserSmsCode pmUserSmsCode = new PmUserSmsCode();
						pmUserSmsCode.setCreateTime(new Date());
						pmUserSmsCode.setSmsCode(smsCode);
						pmUserSmsCode.setMobile(mobile);
						pmUserSmsCode.setType(1);
						pmUserSmsCodeService.save(pmUserSmsCode);
						smscode = "00";
						msg="已发送";
					} else{
						smscode = "";
						msg="发送验证码失败";
					}
				} else {
					smscode = "";
					msg="当前手机号码已被注册过";
				}
			} else if (type.equals("2")) {
				EbUser ebuser = ebUserService.getEbUserByMobile(mobile);
				if (ebuser != null) {
					String smsCode = RandomNumber.getRandomCode();
					String smsmsg="尊敬的用户，您本次使用服务的短信验证码为："+smsCode+"。请注意查收，勿向他人泄露此验证码，2分钟内有效。";
					boolean flag = CommonUtils.sendMsg(mobile, smsmsg);
					if (flag) {
						PmUserSmsCode pmUserSmsCode = new PmUserSmsCode();
						pmUserSmsCode.setCreateTime(new Date());
						pmUserSmsCode.setSmsCode(smsCode);
						pmUserSmsCode.setMobile(mobile);
						pmUserSmsCode.setType(2);
						pmUserSmsCodeService.save(pmUserSmsCode);
						smscode = "00";
						msg="已发送";
					} else {
						smscode = "";
						msg="发送验证码失败";
					}
				} else {
					smscode = "";
					msg="请重新检查您的手机号！";
				}
			} else if (type.equals("3")) {
				if(ebUserService.isMobile(mobile)==false){
					smscode = "";
					msg="手机号码格式不对！";
				}else {
					String smsCode = RandomNumber.getRandomCode();
					String smsmsg="尊敬的用户，您本次使用服务的短信验证码为："+smsCode+"。请注意查收，勿向他人泄露此验证码，2分钟内有效。";
					boolean flag = CommonUtils.sendMsg(mobile, smsmsg);
					if (flag) {
						PmUserSmsCode pmUserSmsCode = new PmUserSmsCode();
						pmUserSmsCode.setCreateTime(new Date());
						pmUserSmsCode.setSmsCode(smsCode);
						pmUserSmsCode.setMobile(mobile);
						pmUserSmsCode.setType(3);
						pmUserSmsCodeService.save(pmUserSmsCode);
						smscode = "00";
						msg="已发送";
					} else {
						smscode = "";
						msg="发送验证码失败";
					}
				}
			}
		} else {
			smscode = "";
			msg="当前手机号码不能为空或不合法，请确认后重试！";
		}
		map.put("smscode", smscode);
		map.put("msg", msg);
		return map;
	}
	@ResponseBody
	@RequestMapping(value = "save")
	public Map<String, Object> save(HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("application/json; charset=UTF-8");
		Map<String, Object> map=new HashMap<String, Object>();
		String smscode="01";
		String msg="注册失败";
		String mobile = request.getParameter("mobile");// 账号
		String cartNum = request.getParameter("cartNum");// 邀请码
		String registerType = request.getParameter("registerType");/** 1Android,、2,ios、3分享H5注册、4递推二维码H5、5广告二维码H5、6后台供应商添加  */
		String registerName = request.getParameter("registerName");/** 注册来源名字  */
		String password = request.getParameter("password");// 密码
		String sccode=request.getParameter("smsCode");


		com.alibaba.fastjson.JSONObject jsonCode = pmUserSmsCodeService
				.yzSmacode(mobile, sccode, 1);
		if (jsonCode.get("code").equals("01")) {
			msg="短信验证码错误！";
			map.put("smscode", smscode);
			map.put("msg", msg);
			return map;
		}
		if (StringUtils.isBlank(mobile) && StringUtils.isBlank(password)) {
			msg="手机号或密码不能为空！";
			map.put("smscode", smscode);
			map.put("msg", msg);
			return map;
		}
		if (ebUserService.isMobile(mobile) == false) {
			msg="手机号格式错误！";
			map.put("smscode", smscode);
			map.put("msg", msg);
			return map;
		}
		if (password==null||password.length()>20||password.length()<6){
			msg="密码长度6~20！";
			map.put("smscode", smscode);
			map.put("msg", msg);
			return map;
		}
		if (ebUserService.isPassword(password) == false){
			msg="密码不能有特殊符号！";
			map.put("smscode", smscode);
			map.put("msg", msg);
			return map;
		}
		String pass = Md5Encrypt.getMD5Str(password).toLowerCase();// 加密
		EbUser ebuser = ebUserService.getEbUserByMobile(mobile);
		if (ebuser!= null) {
			msg="该用户已注册！";
			map.put("smscode", smscode);
			map.put("msg", msg);
			return map;
		}
		if (StringUtils.isBlank(pass)) {
			msg="密码不能为空！";
			map.put("smscode", smscode);
			map.put("msg", msg);
			return map;
		}
//		if (StringUtils.isBlank(cartNum)) {
//			msg="邀请人不能为空！";
//			map.put("smscode", smscode);
//			map.put("msg", msg);
//			return map;
//		}
		Map<String, Object> maps=new HashMap<String, Object>();
		Integer registerType_num=null;
		if(StringUtils.isNumeric(registerType)){
			registerType_num=Integer.parseInt(registerType);
		}else{
			registerName="分享H5注册";
			registerType_num=3;
		}
		maps=ebUserService.registerUser(mobile, pass, cartNum,registerType_num,registerName);
		if(maps.get("code").equals("00")){
			map.put("smscode", "00");
			map.put("msg", "注册成功");
			return map;
		 }else{
			 map.put("smscode", "01");
			 map.put("msg", maps.get("msg"));
			 return map;
		 }
   }
}
