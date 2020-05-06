package com.jq.support.main.controller.shop;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.alibaba.fastjson.JSONArray;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.google.gson.JsonObject;
import com.jq.support.common.config.Global;
import com.jq.support.common.persistence.Page;
import com.jq.support.common.utils.StringUtils;
import com.jq.support.common.web.BaseController;
import com.jq.support.dao.redis.JedisPoolTilems;
import com.jq.support.dao.redis.SerializeUtil;
import com.jq.support.model.region.PmSysDistrict;
import com.jq.support.model.shop.PmShopFreightTem;
import com.jq.support.model.shop.PmShopShippingMethod;
import com.jq.support.model.user.EbUser;
import com.jq.support.service.merchandise.mecontent.PmSysDistrictService;
import com.jq.support.service.merchandise.shop.PmShopFreightTemService;
import com.jq.support.service.merchandise.shop.PmShopShippingMethodService;

import redis.clients.jedis.Jedis;

@Controller
@RequestMapping(value = "${adShopPath}/pmShopFreightTem")
public class ShopFreightTemController extends BaseController{
	
	@Autowired
	private PmShopFreightTemService pmShopFreightTemService;
	@Autowired
	private PmShopShippingMethodService pmShopShippingMethodService;
	@Autowired
	private PmSysDistrictService pmSysDistrictService;
	@Autowired
	private JedisPoolTilems jedisPoolTilems;
	
	private static String domainurl = Global.getConfig("domainurl");
	
	@ResponseBody
	@RequestMapping(value = "jsonPmShopFreightTemList")
	 public List jsonPmShopFreightTemList (HttpServletRequest request,HttpServletResponse response,Model model,RedirectAttributes redirectAttributes) throws ParseException{
		EbUser ebUser=(EbUser) request.getSession().getAttribute("shopuser");
		PmShopFreightTem pmShopFreightTem=new PmShopFreightTem();
		pmShopFreightTem.setShopId(ebUser.getShopId());
	    List<PmShopFreightTem> freightTems=	pmShopFreightTemService.PmShopFreightTemList(pmShopFreightTem);
		return freightTems;
	}
	
	
	@RequestMapping(value = "pmShopFreightTemList")
	public String addShows(HttpServletRequest request, HttpServletResponse response,Model model,RedirectAttributes redirectAttributes) throws JsonProcessingException {
		EbUser ebUser=(EbUser) request.getSession().getAttribute("shopuser");
		String stule=request.getParameter("stule");
		if(ebUser==null){
			model.addAttribute("messager", "登陆失效,请重新登陆");
			return "modules/shop/login2";
		}else {
			PmShopFreightTem pmShopFreightTem=new PmShopFreightTem();
			pmShopFreightTem.setShopId(ebUser.getShopId());
			Page<PmShopFreightTem> page=pmShopFreightTemService.pagePmShopFreightTemList(pmShopFreightTem,new Page<PmShopFreightTem>(request,response));
			if(page.getCount()!=0){
				PmShopShippingMethod pmShopShippingMethod=new PmShopShippingMethod();
				for (int i = 0; i < page.getList().size(); i++) {
					pmShopShippingMethod.setTemplateId(page.getList().get(i).getId());
					page.getList().get(i).setPmShopShippingMethods(pmShopShippingMethodService.getPmShopShippingMethodList(pmShopShippingMethod));	
				}
				model.addAttribute("page", page);
				model.addAttribute("stule", stule);
			}
			return "modules/shop/freight-template";
		}
	}
	
	@RequestMapping(value = "delete")
	public String delete(PmShopFreightTem pmShopFreightTem,HttpServletRequest request,
		HttpServletResponse response, Model model,RedirectAttributes redirectAttributes){
		EbUser ebUser=(EbUser) request.getSession().getAttribute("shopuser");
		if(ebUser!=null){
			if(pmShopFreightTem!=null){
				PmShopShippingMethod pmShopShippingMethod=new PmShopShippingMethod();
				pmShopShippingMethod.setTemplateId(pmShopFreightTem.getId());
				pmShopShippingMethodService.deleteTemplateId(pmShopShippingMethod);
				pmShopFreightTemService.delete(pmShopFreightTem);
				addMessage(redirectAttributes, "删除成功");
			}
			return "redirect:/shop/pmShopFreightTem/pmShopFreightTemList";
		}else {
			model.addAttribute("messager", "登陆失效,请重新登陆");
			return "modules/shop/login2";
		}
	}
	
	@RequestMapping(value = "copy")
	public String copy(PmShopFreightTem pmShopFreightTem,HttpServletRequest request,
		HttpServletResponse response, Model model,RedirectAttributes redirectAttributes){
		EbUser ebUser=(EbUser) request.getSession().getAttribute("shopuser");
		if(ebUser!=null){
			if(pmShopFreightTem!=null){
				pmShopFreightTem=pmShopFreightTemService.findid(pmShopFreightTem.getId());
				PmShopFreightTem newPmShopFreightTem=new PmShopFreightTem();
				newPmShopFreightTem.setShopId(pmShopFreightTem.getShopId());
				newPmShopFreightTem.setTemplateName(pmShopFreightTem.getTemplateName());
				newPmShopFreightTem.setIsPackageMail(pmShopFreightTem.getIsPackageMail());
				newPmShopFreightTem.setAreaRestricted(pmShopFreightTem.getAreaRestricted());
				newPmShopFreightTem.setIsFullFree(pmShopFreightTem.getIsFullFree());
				newPmShopFreightTem.setFullNum(pmShopFreightTem.getFullNum());
				newPmShopFreightTem.setCreateUser(ebUser.getMobile());
				newPmShopFreightTem.setCreateTime(new Date());
				newPmShopFreightTem.setModifyUser(ebUser.getMobile());
				newPmShopFreightTem.setModifyTime(new Date());
				pmShopFreightTemService.save(newPmShopFreightTem);
				PmShopShippingMethod pmShopShippingMethod=new PmShopShippingMethod();
				pmShopShippingMethod.setId(pmShopFreightTem.getId());
				pmShopShippingMethod.setTemplateId(newPmShopFreightTem.getId());
				pmShopShippingMethodService.InsertTemplateId(pmShopShippingMethod);
				addMessage(redirectAttributes, "保存成功");
			}
			return "redirect:/shop/pmShopFreightTem/pmShopFreightTemList";
		}else {
			model.addAttribute("messager", "登陆失效,请重新登陆");
			return "modules/shop/login2";
		}
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "form")
	public String form(PmShopFreightTem pmShopFreightTem,HttpServletRequest request,
		HttpServletResponse response, Model model,RedirectAttributes redirectAttributes){
		EbUser ebUser=(EbUser) request.getSession().getAttribute("shopuser");
		if(ebUser==null){
			model.addAttribute("messager", "登陆失效,请重新登陆");
			return "modules/shop/login2";
		}else{
			if(pmShopFreightTem.getId()!=null){
				pmShopFreightTem=pmShopFreightTemService.findid(pmShopFreightTem.getId());
				if(pmShopFreightTem!=null){
					model.addAttribute("pmShopFreightTem", pmShopFreightTem);
					PmShopShippingMethod pmShopShippingMethod=new PmShopShippingMethod();
					pmShopShippingMethod.setTemplateId(pmShopFreightTem.getId());
					pmShopShippingMethod.setIsDefaultShipp(0);//取不默认的
					List<PmShopShippingMethod>pmShopShippingMethods=pmShopShippingMethodService.getPmShopShippingMethodList(pmShopShippingMethod);
					if(pmShopShippingMethods.size()!=0||pmShopShippingMethods!=null){
						model.addAttribute("pmShopShippingMethods", pmShopShippingMethods);
					}
					pmShopShippingMethod=pmShopShippingMethodService.findTemplateId(pmShopShippingMethod);//取默认的
					if(pmShopShippingMethod!=null){
						model.addAttribute("pmShopShippingMethod", pmShopShippingMethod);
					}
				}
				model.addAttribute("form", "form");
			}
			
			Jedis jedis = jedisPoolTilems.getResource();
			if(jedis == null){    
				throw new NullPointerException("数据库连接失败！");    
		    }
			
			try{    
				List<PmSysDistrict> pmSysDistrictList = new ArrayList<PmSysDistrict>();
				byte[] jsonPmSysDistrictList = jedis.getrange("jsonPmSysDistrictListChina".getBytes(), 0, -1);
			    if(jsonPmSysDistrictList!=null && jsonPmSysDistrictList.length > 0){
			    	//获取redis缓存数据
			    	pmSysDistrictList = (List<PmSysDistrict>) SerializeUtil.unserialize(jsonPmSysDistrictList);
			    }else{
					PmSysDistrict pmSysDistrict0=new PmSysDistrict();
					pmSysDistrict0.setId(0);//中国
					pmSysDistrictList=pmSysDistrictService.getDistrictOne(pmSysDistrict0);//国家
					if(pmSysDistrictList==null||pmSysDistrictList.size()==0){
						model.addAttribute("messager", "NO DATE");
					}else{
						for (PmSysDistrict parentId0:pmSysDistrictList) {
							PmSysDistrict pmSysDistrict1=new PmSysDistrict();
							pmSysDistrict1.setDisLevel(1);
							pmSysDistrict1.setParentId(parentId0.getId());
							List<PmSysDistrict> pmSysDistrictList1=pmSysDistrictService.getDistrictOne(pmSysDistrict1);//省
							if(pmSysDistrictList1.size()>0&&pmSysDistrictList1!=null){
								for (PmSysDistrict parentId1:pmSysDistrictList1) {
									PmSysDistrict pmSysDistrict2=new PmSysDistrict();
									pmSysDistrict2.setDisLevel(2);//市级
									pmSysDistrict2.setParentId(parentId1.getId());
									List<PmSysDistrict> pmSysDistrictList2=pmSysDistrictService.getDistrictOne(pmSysDistrict2);//市
									if(pmSysDistrictList2.size()>0&&pmSysDistrictList2!=null){
										parentId1.setPmSysDistricts(pmSysDistrictList2);
									}
								}
								parentId0.setPmSysDistricts(pmSysDistrictList1);
							}
						}
						//把查询到的结果保存到缓存
				        jedis.set("jsonPmSysDistrictListChina".getBytes(), SerializeUtil.serialize(pmSysDistrictList));
					}
			    }
			    model.addAttribute("pmSysDistrictList", pmSysDistrictList);
			}catch(Exception e){    
				jedisPoolTilems.returnBrokenResource(jedis);    
			}finally{    
				jedisPoolTilems.returnResource(jedis);    
			}   
		    return "modules/shop/freight-templateform";
		}
	}
	/**
	 * 梁威修改过两个判断
	 * @param request
	 * @param response
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "edit")
	public JSONObject edit(HttpServletRequest request,HttpServletResponse response,Model model,RedirectAttributes redirectAttributes){
		JSONObject json=new JSONObject();
		EbUser ebUser=(EbUser) request.getSession().getAttribute("shopuser");
		if(ebUser==null){
			json.put("code", "01");
			json.put("msg", "登录失效");
			return json;
			/*model.addAttribute("messager", "登陆失效,请重新登陆");
			return "modules/shop/login2";*/
		}else{
			String pmShopFreightTemId=request.getParameter("pmShopFreightTemId").trim();
			String templateName=request.getParameter("templateName").trim();
			String isFullFree=request.getParameter("isFullFree").trim();
			String fullNum=request.getParameter("fullNum");
			String areaRestricted=request.getParameter("areaRestricted").trim();
			String pmShopShippingMethodId=request.getParameter("pmShopShippingMethodId").trim();
			String shippingMethod=request.getParameter("shippingMethod").trim();
			String firstArticleKg=request.getParameter("firstArticleKg").trim();
			String firstCharge=request.getParameter("firstCharge").trim();
			String continueArticleKg=request.getParameter("continueArticleKg").trim();
			String continueCharge=request.getParameter("continueCharge").trim();
			String pmSSM=request.getParameter("pmSSM");
			PmShopFreightTem pmShopFreightTem=null;//御可贡茶_商家运费模板
			if(StringUtils.isBlank(firstCharge)){
				json.put("code", "01");
				json.put("msg", "有首重价格为空");
				return json;
			}
			if(Double.parseDouble(firstCharge)>200){
				json.put("code", "01");
				json.put("msg", "有首重价格超过200");
				return json;
			}
			if(StringUtils.isBlank(continueCharge)){
				json.put("code", "01");
				json.put("msg", "有续重价格为空");
				return json;
			}
			if(Double.parseDouble(continueCharge)>200){
				json.put("code", "01");
				json.put("msg", "有续重价格超过200");
				return json;
			}
			if(StringUtils.isNotEmpty(pmShopFreightTemId)){
				pmShopFreightTem=pmShopFreightTemService.findid(Integer.valueOf(pmShopFreightTemId));
			}else {
				pmShopFreightTem=new PmShopFreightTem();
			}
			pmShopFreightTem.setShopId(ebUser.getShopId());
			pmShopFreightTem.setTemplateName(templateName);
			pmShopFreightTem.setIsFullFree(Integer.valueOf(isFullFree));
			if(isFullFree.endsWith("1")){
				pmShopFreightTem.setIsPackageMail(1);
			}
			if(isFullFree.endsWith("0")){
				pmShopFreightTem.setIsPackageMail(0);
			}
			if(StringUtils.isNotEmpty(fullNum)){
				pmShopFreightTem.setFullNum(Integer.valueOf(fullNum));
			}
			pmShopFreightTem.setAreaRestricted(Integer.valueOf(areaRestricted));
			
			PmShopShippingMethod pmShopShippingMethod=null;//御可贡茶_商家运送方式
			if(StringUtils.isNotEmpty(pmShopShippingMethodId)){
				pmShopShippingMethod=pmShopShippingMethodService.findid(pmShopShippingMethodId);
			}else {
				pmShopShippingMethod=new PmShopShippingMethod();
			}
//			pmShopShippingMethod.setTemplateId(Integer.valueOf(pmShopFreightTemId));
			pmShopShippingMethod.setIsDefaultShipp(1);
			pmShopShippingMethod.setShippingMethod(Integer.valueOf(shippingMethod));
			pmShopShippingMethod.setFirstArticleKg(Double.parseDouble(firstArticleKg));
			pmShopShippingMethod.setFirstCharge(Double.parseDouble(firstCharge));
			pmShopShippingMethod.setContinueArticleKg(Double.parseDouble(continueArticleKg));
			pmShopShippingMethod.setContinueCharge(Double.parseDouble(continueCharge));
			if(StringUtils.isNotEmpty(pmShopFreightTemId)){
				pmShopFreightTem.setModifyUser(ebUser.getShopId().toString());
				pmShopFreightTem.setModifyTime(new Date());
				
				pmShopShippingMethod.setModifyUser(ebUser.getShopId().toString());
				pmShopShippingMethod.setModifyTime(new Date());
				
				pmShopFreightTemService.save(pmShopFreightTem);
				pmShopShippingMethodService.save(pmShopShippingMethod);
				if(StringUtils.isNotEmpty(pmSSM)){
					JSONArray pmSSMlist = JSONArray.parseArray(pmSSM);
					for (int i = 0; i < pmSSMlist.size(); i++) {
						JSONArray pmSSMlists = JSONArray.parseArray(pmSSMlist.get(i).toString());
						if(pmSSMlists!=null&&pmSSMlists.size()>0){
							if (StringUtils.isBlank(pmSSMlists.get(4).toString())) {
								json.put("code", "01");
								json.put("msg", "有首重价格为空");
								return json;
							}
							if(Double.parseDouble(pmSSMlists.get(4).toString())>200){
								json.put("code", "01");
								json.put("msg", "有首重价格超过200");
								return json;
							}
							if (StringUtils.isBlank(pmSSMlists.get(6).toString())) {
								json.put("code", "01");
								json.put("msg", "有续重价格为空");
								return json;
							}
							if(Double.parseDouble(pmSSMlists.get(6).toString())>200){
								json.put("code", "01");
								json.put("msg", "有续重价格超过200");
								return json;
							}
						}
					}
					for (int i = 0; i < pmSSMlist.size(); i++) {
//						Object[] sObjects=(Object[]) pmSSMlist.get(i);
						JSONArray pmSSMlists = JSONArray.parseArray(pmSSMlist.get(i).toString());
						if(pmSSMlists!=null&&pmSSMlists.size()>0){
							PmShopShippingMethod pmShopShippingMethod1=null;
							if(StringUtils.isNotEmpty(pmSSMlists.get(0).toString())){
								pmShopShippingMethod1=pmShopShippingMethodService.findid(pmSSMlists.get(0).toString());
							}else {
								pmShopShippingMethod1=new PmShopShippingMethod();
							}
							pmShopShippingMethod1.setTemplateId(pmShopFreightTem.getId());
							if (StringUtils.isNotEmpty(pmSSMlists.get(3).toString())) {
								pmShopShippingMethod1.setFirstArticleKg(Double.parseDouble(pmSSMlists.get(3).toString()));
							}else {
								pmShopShippingMethod1.setFirstArticleKg(0.00);
							}
							if (StringUtils.isNotEmpty(pmSSMlists.get(4).toString())) {
								pmShopShippingMethod1.setFirstCharge(Double.parseDouble(pmSSMlists.get(4).toString()));
							}else {
								pmShopShippingMethod1.setFirstCharge(0.00);
							}
							if (StringUtils.isNotEmpty(pmSSMlists.get(5).toString())) {
								pmShopShippingMethod1.setContinueArticleKg(Double.parseDouble(pmSSMlists.get(5).toString()));
							}else {
								pmShopShippingMethod1.setContinueArticleKg(0.00);
							}
							if (StringUtils.isNotEmpty(pmSSMlists.get(6).toString())) {
								pmShopShippingMethod1.setContinueCharge(Double.parseDouble(pmSSMlists.get(6).toString()));
							}else {
								pmShopShippingMethod1.setContinueCharge(0.00);
							}
							pmShopShippingMethod1.setShippingMethod(pmShopShippingMethod.getShippingMethod());
							pmShopShippingMethod1.setIsDefaultShipp(0);
							pmShopShippingMethod1.setDistrctCode(pmSSMlists.get(1).toString());
							pmShopShippingMethod1.setDistrctName(pmSSMlists.get(2).toString());
							if(StringUtils.isNotEmpty(pmSSMlists.get(0).toString())){
								pmShopShippingMethod1.setModifyUser(ebUser.getShopId().toString());
								pmShopShippingMethod1.setModifyTime(new Date());
								pmShopShippingMethodService.save(pmShopShippingMethod1);
							}else {
								pmShopShippingMethod1.setCreateUser(ebUser.getShopId().toString());
								pmShopShippingMethod1.setCreateTime(new Date());
								pmShopShippingMethod1.setModifyUser(ebUser.getShopId().toString());
								pmShopShippingMethod1.setModifyTime(new Date());
								pmShopShippingMethodService.save(pmShopShippingMethod1);
							}
						}
					}
				}
				
//				model.addAttribute("messager", "修改成功");
//				return "redirect:/shop/pmShopFreightTem/pmShopFreightTemList";
			}else {
				pmShopFreightTem.setCreateUser(ebUser.getShopId().toString());
				pmShopFreightTem.setCreateTime(new Date());
				pmShopFreightTem.setModifyUser(ebUser.getShopId().toString());
				pmShopFreightTem.setModifyTime(new Date());
				
				pmShopShippingMethod.setCreateUser(ebUser.getShopId().toString());
				pmShopShippingMethod.setCreateTime(new Date());
				pmShopShippingMethod.setModifyUser(ebUser.getShopId().toString());
				pmShopShippingMethod.setModifyTime(new Date());
				
				pmShopFreightTemService.save(pmShopFreightTem);
				pmShopShippingMethod.setTemplateId(pmShopFreightTem.getId());
				pmShopShippingMethodService.save(pmShopShippingMethod);
				if(StringUtils.isNotEmpty(pmSSM)){
					JSONArray pmSSMlist = JSONArray.parseArray(pmSSM);
					for (int i = 0; i < pmSSMlist.size(); i++) {
						JSONArray pmSSMlists = JSONArray.parseArray(pmSSMlist.get(i).toString());
						if(pmSSMlists!=null&&pmSSMlists.size()>0){
							if (StringUtils.isBlank(pmSSMlists.get(4).toString())) {
								json.put("code", "01");
								json.put("msg", "有首重价格为空");
								return json;
							}
							if(Double.parseDouble(pmSSMlists.get(4).toString())>200){
								json.put("code", "01");
								json.put("msg", "有首重价格超过200");
								return json;
							}
							if (StringUtils.isBlank(pmSSMlists.get(6).toString())) {
								json.put("code", "01");
								json.put("msg", "有续重价格为空");
								return json;
							}
							if(Double.parseDouble(pmSSMlists.get(6).toString())>200){
								json.put("code", "01");
								json.put("msg", "有续重价格超过200");
								return json;
							}
						}
					}
					for (int i = 0; i < pmSSMlist.size(); i++) {
//						Object[] sObjects=(Object[]) pmSSMlist.get(i);
						JSONArray pmSSMlists = JSONArray.parseArray(pmSSMlist.get(i).toString());
						if(pmSSMlists!=null&&pmSSMlists.size()>0){
							PmShopShippingMethod pmShopShippingMethod1=null;
							if(StringUtils.isNotEmpty(pmSSMlists.get(0).toString())){
								pmShopShippingMethod1=pmShopShippingMethodService.findid(pmSSMlists.get(0).toString());
							}else {
								pmShopShippingMethod1=new PmShopShippingMethod();
							}
							pmShopShippingMethod1.setTemplateId(pmShopFreightTem.getId());
							if (StringUtils.isNotEmpty(pmSSMlists.get(3).toString())) {
								pmShopShippingMethod1.setFirstArticleKg(Double.parseDouble(pmSSMlists.get(3).toString()));
							}else {
								pmShopShippingMethod1.setFirstArticleKg(0.00);
							}
							if (StringUtils.isNotEmpty(pmSSMlists.get(4).toString())) {
								pmShopShippingMethod1.setFirstCharge(Double.parseDouble(pmSSMlists.get(4).toString()));
							}else {
								pmShopShippingMethod1.setFirstCharge(0.00);
							}
							if (StringUtils.isNotEmpty(pmSSMlists.get(5).toString())) {
								pmShopShippingMethod1.setContinueArticleKg(Double.parseDouble(pmSSMlists.get(5).toString()));
							}else {
								pmShopShippingMethod1.setContinueArticleKg(0.00);
							}
							if (StringUtils.isNotEmpty(pmSSMlists.get(6).toString())) {
								pmShopShippingMethod1.setContinueCharge(Double.parseDouble(pmSSMlists.get(6).toString()));
							}else {
								pmShopShippingMethod1.setContinueCharge(0.00);
							}
							pmShopShippingMethod1.setShippingMethod(pmShopShippingMethod.getShippingMethod());
							pmShopShippingMethod1.setIsDefaultShipp(0);
							pmShopShippingMethod1.setDistrctCode(pmSSMlists.get(1).toString());
							pmShopShippingMethod1.setDistrctName(pmSSMlists.get(2).toString());
							if(StringUtils.isNotEmpty(pmSSMlists.get(0).toString())){
								pmShopShippingMethod1.setModifyUser(ebUser.getShopId().toString());
								pmShopShippingMethod1.setModifyTime(new Date());
								pmShopShippingMethodService.save(pmShopShippingMethod1);
							}else {
								pmShopShippingMethod1.setCreateUser(ebUser.getShopId().toString());
								pmShopShippingMethod1.setCreateTime(new Date());
								pmShopShippingMethod1.setModifyUser(ebUser.getShopId().toString());
								pmShopShippingMethod1.setModifyTime(new Date());
								pmShopShippingMethodService.save(pmShopShippingMethod1);
							}
						}
					}
				}
				json.put("code", "00");
				json.put("msg", "成功");
				return json;
			}
			json.put("code", "00");
			json.put("msg", "成功");
			return json;
		}
	}
	
	@RequestMapping(value = "pmssmdelete")
	public String pmssmdelete(HttpServletRequest request,HttpServletResponse response,Model model,RedirectAttributes redirectAttributes){
		String pmShopShippingMethodId=request.getParameter("ssid").trim();
		if(StringUtils.isNotEmpty(pmShopShippingMethodId)||!pmShopShippingMethodId.equals("undefined")){
			PmShopShippingMethod pmShopShippingMethod=new PmShopShippingMethod();
			pmShopShippingMethod.setId(Integer.valueOf(pmShopShippingMethodId));
			pmShopShippingMethodService.delete(pmShopShippingMethod);
		}
		return null;
	}
	
//	@RequestMapping(value = "maps")
//	public String maps(PmShopFreightTem pmShopFreightTem,HttpServletRequest request,
//		HttpServletResponse response, Model model,RedirectAttributes redirectAttributes){
//		EbUser ebUser=(EbUser) request.getSession().getAttribute("shopuser");
//		if(ebUser==null){
//			model.addAttribute("messager", "登陆失效,请重新登陆");
//			return "modules/shop/login2";
//		}else{
//			if(pmShopFreightTem.getId()!=null){
//				
//				model.addAttribute("form", "form");
//			}
//			PmSysDistrict pmSysDistrict0=new PmSysDistrict();
		//	pmSysDistrict0.setId(0);//中国
		//	List<PmSysDistrict> pmSysDistrictList=pmSysDistrictService.getDistrictOne(pmSysDistrict0);//国家
		//	if(pmSysDistrictList==null||pmSysDistrictList.size()==0){
		//		model.addAttribute("messager", "NO DATE");
		//	}else{
		//		for (PmSysDistrict parentId0:pmSysDistrictList) {
		//			PmSysDistrict pmSysDistrict1=new PmSysDistrict();
		//			pmSysDistrict1.setDisLevel(1);
		//			pmSysDistrict1.setParentId(parentId0.getId());
		//			List<PmSysDistrict> pmSysDistrictList1=pmSysDistrictService.getDistrictOne(pmSysDistrict1);//省
		//			if(pmSysDistrictList1.size()>0&&pmSysDistrictList1!=null){
		//				for (PmSysDistrict parentId1:pmSysDistrictList1) {
		//					PmSysDistrict pmSysDistrict2=new PmSysDistrict();
		//					pmSysDistrict2.setDisLevel(2);//市级
		//					pmSysDistrict2.setParentId(parentId1.getId());
		//					List<PmSysDistrict> pmSysDistrictList2=pmSysDistrictService.getDistrictOne(pmSysDistrict2);//市
		//					if(pmSysDistrictList2.size()>0&&pmSysDistrictList2!=null){
		//						parentId1.setPmSysDistricts(pmSysDistrictList2);
		//					}
		//				}
		//				parentId0.setPmSysDistricts(pmSysDistrictList1);
		//			}
		//		}
		//		model.addAttribute("pmSysDistrictList", pmSysDistrictList);
		//	}
//		}
//		return null;
//	}
}