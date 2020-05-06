package com.jq.support.main.controller.merchandise.product;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.collections.CollectionUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
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
import com.jq.support.model.product.PmProductType;
import com.jq.support.model.product.PmProductTypeSpertAttr;
import com.jq.support.model.sys.SysUser;
import com.jq.support.service.merchandise.product.PmProductTypeService;
import com.jq.support.service.merchandise.product.PmProductTypeSpertAttrService;
import com.jq.support.service.utils.SysUserUtils;


/**
 * 规格属性管理Controller
 * @author Administrator
 *
 */



@Controller
@RequestMapping(value = "${adminPath}/PmProductTypeSpertAttr")
public class PmProductTypeSpertAttrController extends BaseController {
  @Autowired
  private PmProductTypeSpertAttrService pmProductTypeSpertAttrService;
  @Autowired
  private PmProductTypeService productTypeService;
  private static String domainurl = Global.getConfig("domainurl");
  
    @ModelAttribute
	public PmProductTypeSpertAttr get(@RequestParam(required=false) String id) {
		if (org.apache.commons.lang3.StringUtils.isNotBlank(id)){
			return pmProductTypeSpertAttrService.getSbProductTypeSpertAttr(id);
		}else{
			return new PmProductTypeSpertAttr();
		}
	}
    
    @RequiresPermissions("merchandise:PmProductTypeSpertAttr:view")
	@RequestMapping(value = "tree")
	public String tree(HttpServletRequest request, HttpServletResponse response, Model model) {
		 List<PmProductType> productTypes= productTypeService.getSbProductTypeTree();
		 model.addAttribute("productTypes", productTypes);
		 String url=domainurl+Global.getAdminPath()+"/PmProductTypeSpertAttr/list?productTypeId=";
		 model.addAttribute("url", url);
		return "modules/shopping/classify/sbProductTypeTree";
	}
    @RequiresPermissions("merchandise:PmProductTypeSpertAttr:view")
	@RequestMapping(value = {"show", ""})
	public String show(HttpServletRequest request, HttpServletResponse response, Model model) {
		return "modules/shopping/classify/SbProductTypeSpertAttrAll";
	}
    
    @RequiresPermissions("merchandise:PmProductTypeSpertAttr:view")
   	@RequestMapping(value = "list")
   	public String list(String productTypeId,String spertAttrName,String spertAttrType, HttpServletRequest request, HttpServletResponse response, Model model) {
    	PmProductTypeSpertAttr pmProductTypeSpertAttr=new PmProductTypeSpertAttr();
    	pmProductTypeSpertAttr.setSpertAttrName(spertAttrName);
    	if(StringUtils.isNotBlank(productTypeId)){
    		PmProductType pmProductType= productTypeService.getSbProductType(productTypeId);
    		if(pmProductType!=null){
				if(pmProductType.getLevel()==3||pmProductType.getLevel()==2){
					 model.addAttribute("fulte","1");
					 pmProductTypeSpertAttr.setProductTypeId(Integer.parseInt(productTypeId));
				}else{
					pmProductTypeSpertAttr.setProductTypeId(Integer.parseInt(productTypeId));
					model.addAttribute("fulte","0");
				}
			 }else{
				 pmProductTypeSpertAttr.setProductTypeId(Integer.parseInt(productTypeId));
				 model.addAttribute("fulte","0");
			 }
    		
    	}
    	if(StringUtils.isNotBlank(spertAttrType)){
    		pmProductTypeSpertAttr.setSpertAttrType(Integer.parseInt(spertAttrType));
    	}
    	model.addAttribute("page", pmProductTypeSpertAttrService.getPageSbProductTypeSpertAttrList(new Page<PmProductTypeSpertAttr>(request, response), pmProductTypeSpertAttr));
    	model.addAttribute("sbProductTypeSpertAttr", pmProductTypeSpertAttr);
    	model.addAttribute("productTypeId", productTypeId);
    	return "modules/shopping/classify/SbProductTypeSpertAttrList";
   	}
    
	@RequestMapping(value ="checkName")
	@ResponseBody
	public boolean checkName(PmProductTypeSpertAttr pmProductTypeSpertAttr,HttpServletRequest request, HttpServletResponse response, Model model) {
		List<PmProductTypeSpertAttr> list=pmProductTypeSpertAttrService.checkname(pmProductTypeSpertAttr);
		if (CollectionUtils.isNotEmpty(list)) {
			for(PmProductTypeSpertAttr pmProductTypeSpertAttr1:list){
				if(pmProductTypeSpertAttr.getId()!=null&&pmProductTypeSpertAttr1.getId().toString().equals(pmProductTypeSpertAttr.getId().toString())){
					return true;
				}
			}
			return false;
		}
		return true;
	}
	
    @RequiresPermissions("merchandise:PmProductTypeSpertAttr:view")
   	@RequestMapping(value = "from")
   	public String from(PmProductTypeSpertAttr pmProductTypeSpertAttr,HttpServletRequest request, HttpServletResponse response, Model model) {
    	   model.addAttribute("sbProductTypeSpertAttr",pmProductTypeSpertAttr);
    	   PmProductType pmProductType=   productTypeService.getSbProductType(pmProductTypeSpertAttr.getProductTypeId().toString());
		   model.addAttribute("sbProductType", pmProductType);
		   model.addAttribute("productTypeId", pmProductType.getId());
    	return "modules/shopping/classify/SbProductTypeSpertAttrFrom";
   	}
    
    @RequiresPermissions("merchandise:PmProductTypeSpertAttr:edit")
   	@RequestMapping(value = "save")
   	public String save(PmProductTypeSpertAttr pmProductTypeSpertAttr,HttpServletRequest request, HttpServletResponse response, Model model,RedirectAttributes redirectAttributes) {
    	SysUser user = SysUserUtils.getUser();
		if(pmProductTypeSpertAttr.getId()==null){
			pmProductTypeSpertAttr.setCreateUser(user.getName());
			pmProductTypeSpertAttr.setCreateTime(new Date());
		}else{
			pmProductTypeSpertAttr.setModifyUser(user.getName());
			pmProductTypeSpertAttr.setModifyTime(new Date());
		}
		pmProductTypeSpertAttrService.save(pmProductTypeSpertAttr);
		addMessage(redirectAttributes, "保存成功");
		return "redirect:"+Global.getAdminPath()+"/PmProductTypeSpertAttr/list?productTypeId="+pmProductTypeSpertAttr.getProductTypeId();
   	}
    
    @RequiresPermissions("merchandise:PmProductTypeSpertAttr:edit")
   	@RequestMapping(value = "delete")
   	public String delete(String id,HttpServletRequest request, HttpServletResponse response, Model model,RedirectAttributes redirectAttributes) {
    	PmProductTypeSpertAttr pmProductTypeSpertAttr = pmProductTypeSpertAttrService.getSbProductTypeSpertAttr(id);
		pmProductTypeSpertAttr.setIsDel(1);
		pmProductTypeSpertAttrService.save(pmProductTypeSpertAttr);
    	//    	pmProductTypeSpertAttrService.delete(pmProductTypeSpertAttr);
    	addMessage(redirectAttributes, "保存成功");
		return "redirect:"+Global.getAdminPath()+"/PmProductTypeSpertAttr/list?productTypeId="+pmProductTypeSpertAttr.getProductTypeId();
   	}
  
  
  
  
  
  
}
