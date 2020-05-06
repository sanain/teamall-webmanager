package com.jq.support.main.controller.shop;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jq.support.common.config.Global;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.jq.support.common.security.Md5Encrypt;
import com.jq.support.common.utils.StringUtils;
import com.jq.support.common.web.BaseController;
import com.jq.support.model.product.EbBlockTrading;
import com.jq.support.model.product.PmShopInfo;
import com.jq.support.model.sys.SysUser;
import com.jq.support.model.user.EbUser;
import com.jq.support.service.merchandise.product.EbBlockTradingService;
import com.jq.support.service.merchandise.shop.PmShopInfoService;
import com.jq.support.service.merchandise.user.EbUserService;
import com.jq.support.service.utils.SysUserUtils;
import com.jq.support.service.utils.ValidateCode;


@Controller
@RequestMapping(value = "/")
public class ShopController extends BaseController{
	
	@Autowired
	private EbUserService ebUserService;
	@Autowired
	private PmShopInfoService pmShopInfoService;
	@Autowired
	private EbBlockTradingService ebBlockTradingService;
	private static String shopLoginFlag = Global.getConfig("shopLoginFlag");
	@RequestMapping(value="shoplogin")
	public String login (@RequestParam(required=false) String username,@RequestParam(required=false) String password,@RequestParam(required=false) String imageCode,HttpServletResponse response,HttpServletRequest request, Model model){
	    	String imgcode=(String) request.getSession().getAttribute("random_image_code");
			if(StringUtils.isNotBlank(username)&&StringUtils.isNotBlank(password)){
				String pass=Md5Encrypt.getMD5Str(password).toLowerCase();//加密
				EbUser ebuser = ebUserService.getEbUserByMobileStatus(shopLoginFlag+username);
				if(ebuser!=null){
					if(ebuser.getPassword().equals(pass)){
						if(ebuser.getShopId()!=null){
							PmShopInfo pmShopInfo=pmShopInfoService.getpmPmShopInfo(ebuser.getShopId().toString());
							if(pmShopInfo!=null){
								if(pmShopInfo.getReviewStatus()!=null&&pmShopInfo.getOnlineStatus()!=null){
									if(pmShopInfo.getReviewStatus()==1){
										if(pmShopInfo.getOnlineStatus()==1){
											if (StringUtils.isBlank(imageCode)) {
												model.addAttribute("messager", "验证码不能为空");
											}else if (imageCode.equals(imgcode)) {
												SysUser user = SysUserUtils.getUser();
												if (user!=null) {
													SecurityUtils.getSubject().logout();
												}
												ebuser.setShopName(pmShopInfo.getShopName());
												request.getSession().setAttribute("shopuser", ebuser);
												request.getSession().setAttribute("userShopId", ebuser.getUserId()+"_"+ebuser.getShopId());
												return "redirect:/shop";
											}else {
												model.addAttribute("messager", "验证码错误");
											}
										}else{
											 model.addAttribute("messager", "商户被禁用！请联系管理员");
										}
									}else{
										 model.addAttribute("messager", "该商户申请未通过");
									}
								}else{
									 model.addAttribute("messager", "商户被禁用！请联系管理员");
								}
							}else{
								 model.addAttribute("messager", "商户未开通");
							}
						}else{
							 model.addAttribute("messager", "商户未开通");
						}
					 }else{
						 model.addAttribute("messager", "用户名密码错误");
					 }
				  }else{
					  model.addAttribute("messager", "用户名密码错误");
				}
			}
		 return "modules/shop/login2";
	}
	@RequestMapping(value="outLogin")
	public String outLogin (HttpServletRequest request, Model model){
		request.getSession().setAttribute("shopuser", null);
		return "redirect:/shop";
	}
	/**
	 * 生成验证码
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="randomCode")
	public String RandomCode(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String sessionName="random_image_code";
		ValidateCode.createRandomImageCode(request, response, sessionName);
		//ImageTool.createRandomImageCode(request,response);	
		return null;
	}
	
	
	//跳到百度地图选经纬度
	@RequestMapping(value = "mapBaidu")
	public String mapBaidu(PmShopInfo pmShopInfo,HttpServletRequest request, HttpServletResponse response, Model model){
		return "modules/shopping/shop/mapBaidu";
	}
	
	
	@RequestMapping(value="login" , method = RequestMethod.POST)
	public String login(@RequestParam(required=false) String username,@RequestParam(required=false) String password,HttpServletRequest request, HttpServletResponse response, Model model) {
		if(StringUtils.isNotBlank(username)&&StringUtils.isNotBlank(password)){
			String pass=Md5Encrypt.getMD5Str(password).toLowerCase();//加密
			EbUser ebuser = ebUserService.getEbUserByMobileStatus(username);
			if(ebuser!=null){
				if(ebuser.getPassword().equals(pass)){
					if(ebuser.getShopId()!=null){
						PmShopInfo pmShopInfo=pmShopInfoService.getpmPmShopInfo(ebuser.getShopId().toString());
						if(pmShopInfo!=null){
							if(pmShopInfo.getReviewStatus()==1){
								if(pmShopInfo.getOnlineStatus()==1){
									SysUser user = SysUserUtils.getUser();
									if (user!=null) {
										SecurityUtils.getSubject().logout();
									}
									request.getSession().setAttribute("shopuser", ebuser);
									request.getSession().setAttribute("userShopId", ebuser.getUserId()+"_"+ebuser.getShopId());
									return "redirect:/shop";
								}else{
									 model.addAttribute("messager", "商户被禁用！请联系管理员");
								}
							}else{
								 model.addAttribute("messager", "该商户申请未通过");
							}
						}else{
							 model.addAttribute("messager", "商户未开通");
						}
					}else{
						 model.addAttribute("messager", "商户未开通");
					}
				 }else{
					 model.addAttribute("messager", "用户名密码错误");
				 }
			  }else{
				  model.addAttribute("messager", "用户名密码错误");
			}
		}
		 model.addAttribute("messager", "用户名密码错误");
		return "modules/shop/login2";
	}
	
	/**
	 * 商铺主页
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws JsonProcessingException
	 */
	@RequestMapping(value = "shop")
	public String index(HttpServletRequest request, HttpServletResponse response,Model model) throws JsonProcessingException {
		EbUser ebUser=(EbUser) request.getSession().getAttribute("shopuser");
		PmShopInfo pmShopInfo=pmShopInfoService.getpmPmShopInfo(ebUser.getShopId()+"");
		model.addAttribute("shopUser", ebUser);
		model.addAttribute("pmShopInfo", pmShopInfo);
		return "modules/shop/new/index";
	}
	
	@RequestMapping(value="sfuzShop")
	public String sfuzShop(HttpServletRequest request, HttpServletResponse response, Model model) {
		return "modules/shop/login2";
	}

	
	/**
	 * 大宗贸易滚动列表
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value="scroll")
	public String scroll(HttpServletRequest request, HttpServletResponse response, Model model) {
		List<EbBlockTrading> list=ebBlockTradingService.getList(new EbBlockTrading());
		model.addAttribute("list", list);
		return "modules/shopping/brands/scolltrade";
	}
	 
	
}
