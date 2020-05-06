package com.jq.support.main.controller.h5;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jq.support.common.utils.StringUtils;
import com.jq.support.common.web.BaseController;
import com.jq.support.model.article.EbArticle;
import com.jq.support.model.certificate.EbCertificate;
import com.jq.support.model.certificate.EbCertificateUser;
import com.jq.support.model.user.EbUser;
import com.jq.support.service.certificate.EbCertificateService;
import com.jq.support.service.certificate.EbCertificateUserService;
import com.jq.support.service.merchandise.article.EbArticleService;
import com.jq.support.service.merchandise.user.EbUserService;


@Controller
@RequestMapping("/EbCertificateHtml")
public class EbCertificateHtml extends BaseController {
	@Autowired
	private EbCertificateService ebCertificateService;
	@Autowired
	private EbCertificateUserService ebCertificateUserService;
	@Autowired
	private EbUserService ebUserService;
	/**
	 * 领取优惠卷
	 * @param id
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/ebcertificate/{certificateId}${urlSuffix}")
	public String ebCertificate(@PathVariable String certificateId,  HttpServletRequest request,Model model) throws Exception {
		model.addAttribute("certificateId", certificateId);
		return "modules/h5/ebcertificate";
	}

	
	/**
	 * 领取优惠卷
	 * @param certificateId
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value="/ebCertificateUser")
	public Map ebCertificateUser(HttpServletRequest request) throws Exception {
		String certificateId=request.getParameter("certificateId");
		String userId=request.getParameter("userId");
		String msg="";
		Map map=new HashMap<String, String>();
		EbCertificate ebCertificate=new EbCertificate();
		if(StringUtils.isNotBlank(certificateId)){
			ebCertificate=ebCertificateService.getEbCertificateById(Integer.parseInt(certificateId));
		 }
		EbUser ebUser=new EbUser();
		if(StringUtils.isNotBlank(userId)){
			ebUser=ebUserService.getEbUserById(Integer.parseInt(userId));
		 }
		Date now=new Date();
		if(ebUser==null){
			msg="用户不存在";
		}else if(ebCertificate==null){
			msg="优惠券不存在";
		}else if(ebCertificate.getDelflag()==null||ebCertificate.getDelflag()==1){
			msg="优惠券不存在";
		}else if(ebCertificate.getSendTime()==null||ebCertificate.getSendTime().getTime()>now.getTime()){
			msg="优惠券未到领取时间";
		}else if(ebCertificate.getCertificateEndDate()==null||ebCertificate.getCertificateEndDate().getTime()<now.getTime()){
			msg="优惠券已过领取时间";
		}else{
//			EbCertificateUser ebc=new EbCertificateUser(null, ebUser.getUserId(), 0, ebUser.getUsername(), null, now, ebCertificate.getCertificateId(), ebCertificate.getType(), ebCertificate.getAmount(), ebCertificate.getProductType(), ebCertificate.getShopType(), ebCertificate.getProductTypeId(), ebCertificate.getShopTypeId(), ebCertificate.getProvinceOutFullFreight(), ebCertificate.getCertificateStartDate(), ebCertificate.getCertificateEndDate(), ebCertificate.getSendTime(), 0, ebCertificate.getCertificateName(), ebCertificate.getRemark(), ebCertificate.getCreateTime()); 
//			ebCertificateUserService.save(ebc);
//			msg="优惠券领取成功";
		}
		map.put("msg", msg);
		return map;
	}

}
