package com.jq.support.main.controller.merchandise.shop;

import java.io.File;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.common.collect.Lists;
import com.jq.support.common.config.Global;
import com.jq.support.common.persistence.Page;
import com.jq.support.common.utils.DateUtils;
import com.jq.support.common.utils.FileUtils;
import com.jq.support.common.utils.StringUtils;
import com.jq.support.common.web.BaseController;
import com.jq.support.model.product.PmProductType;
import com.jq.support.model.product.PmShopCooperType;
import com.jq.support.model.product.PmShopInfo;
import com.jq.support.model.sys.SysUser;
import com.jq.support.service.merchandise.shop.PmShopCooperTypeService;
import com.jq.support.service.utils.SysUserUtils;

/**
 * 商户合作分类
 * @author Administrator
 *
 */
@Controller
@RequestMapping(value = "${adminPath}/PmShopCooperType")
public class PmShopCooperTypeController extends BaseController {
	@Autowired
	private PmShopCooperTypeService pmShopCooperTypeService;
	
	private static String domainurl = Global.getConfig("domainurl");
	private static String innerImgPartPath = "src=\"/uploads/images/";
	private static String innerImgFullPath = "src=\"" + domainurl  + "/uploads/images/";
	
	@ModelAttribute
	public  PmShopCooperType get(@RequestParam(required=false) String id) {
		if (org.apache.commons.lang3.StringUtils.isNotBlank(id)){
			return pmShopCooperTypeService.getPmShopCooperType(id);
		}else{
			return new  PmShopCooperType();
		}
	}
	
	@RequiresPermissions("merchandise:PmShopInfo:view")
	@RequestMapping(value = {"list", ""})
	public String list(
			PmShopCooperType pmShopCooperType,String name,
			HttpServletRequest request, HttpServletResponse response, Model model){
		    Page<PmShopCooperType> page=pmShopCooperTypeService.getPageList(new Page<PmShopCooperType>(request, response),pmShopCooperType,name);
		    model.addAttribute("page", page);
		    model.addAttribute("name", name);
		    model.addAttribute("shopId", pmShopCooperType.getShopId());
		    model.addAttribute("pmShopCooperType", pmShopCooperType);
		    return "modules/shopping/shop/pmShopCooperTypelist";
	}
	
	@RequiresPermissions("merchandise:PmShopInfo:view")
	@RequestMapping(value = "form")
	public String form(
			PmShopCooperType pmShopCooperType,
			HttpServletRequest request, HttpServletResponse response, Model model){
		    model.addAttribute("pmShopCooperType", pmShopCooperType);
		    return "modules/shopping/shop/pmShopCooperTypefrom";
	}

	
	@RequiresPermissions("merchandise:pmShopCooperType:edit")
	@RequestMapping(value = "save")
	public String save(
			PmShopCooperType pmShopCooperType,
			HttpServletRequest request, HttpServletResponse response, Model model,RedirectAttributes redirectAttributes){
		List<PmShopCooperType> cooperTypes= pmShopCooperTypeService.getList(pmShopCooperType, "");
		    if(cooperTypes.size()>1){
		    	addMessage(redirectAttributes, "该类被已存在");
		    }else{
		    	 pmShopCooperTypeService.save(pmShopCooperType);
		    	  addMessage(redirectAttributes, "保存成功");
		    }
			return "redirect:"+Global.getAdminPath()+"/PmShopCooperType/list?shopId="+pmShopCooperType.getShopId();
	}
	
	
	@RequiresPermissions("merchandise:pmShopInfo:edit")
	@RequestMapping(value = "delete")
	public String delete(
			PmShopCooperType pmShopCooperType,
			HttpServletRequest request, HttpServletResponse response, Model model,RedirectAttributes redirectAttributes){
		    pmShopCooperTypeService.delete(pmShopCooperType);
		    addMessage(redirectAttributes, "删除成功");
			return "redirect:"+Global.getAdminPath()+"/PmShopCooperType/list";
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
		String userShopId = "000000";
		if(request.getSession().getAttribute("userShopId")!=null){
	    	  userShopId = (String)request.getSession().getAttribute("userShopId");
	    }
		folder.append(userShopId);
		folder.append(File.separator);
		folder.append("images" );
		folder.append(File.separator);
		folder.append("merchandise");
		folder.append(File.separator);
		folder.append("pmShopCooperType");
		folder.append(File.separator);
		folder.append(DateUtils.getYear());
		folder.append(File.separator);
		folder.append(DateUtils.getMonth());
		FileUtils.createDirectory(folder.toString());
	}
	
}
