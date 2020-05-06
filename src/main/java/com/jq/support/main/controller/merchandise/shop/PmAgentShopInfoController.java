package com.jq.support.main.controller.merchandise.shop;

import java.io.File;
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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.jq.support.common.config.Global;
import com.jq.support.common.persistence.Page;
import com.jq.support.common.utils.DateUtils;
import com.jq.support.common.utils.FileUtils;
import com.jq.support.common.utils.StringUtils;
import com.jq.support.common.web.BaseController;
import com.jq.support.model.shop.PmAgentShopInfo;
import com.jq.support.model.sys.SysUser;
import com.jq.support.service.merchandise.shop.PmAgentShopInfoService;
import com.jq.support.service.sys.SysOfficeService;
import com.jq.support.service.utils.SysUserUtils;

/**
 * 御可贡茶_代理分场信息表 Controller
 * @author Li-qi
 */
@Controller
@RequestMapping(value = "${adminPath}/AgentShopInfo")
public class PmAgentShopInfoController extends BaseController {

	@Autowired
	PmAgentShopInfoService pmAgentShopInfoService;
	@Autowired
	SysOfficeService sysOfficeService;
	
	@ModelAttribute
	public  PmAgentShopInfo get(@RequestParam(required=false) String id) {
		if (org.apache.commons.lang3.StringUtils.isNotBlank(id)){
			return pmAgentShopInfoService.findid(Integer.valueOf(id));
		}else{
			return new  PmAgentShopInfo();
		}
	}
	
	@RequiresPermissions("merchandise:AgentShopInfo:view")
	@RequestMapping(value ={"list",""})
	public String list(HttpServletRequest request, HttpServletResponse response, Model model){
		String agentShopType= request.getParameter("agentShopType");
		String agentId= request.getParameter("agentId");
		PmAgentShopInfo pmAgentShopInfo=new PmAgentShopInfo();
		if(StringUtils.isNotBlank(agentShopType)){
			pmAgentShopInfo.setAgentShopType(Integer.valueOf(agentShopType));
		}
		if(StringUtils.isNotBlank(agentId)){
			pmAgentShopInfo.setAgentId(agentId);
		}
		Page<PmAgentShopInfo>page=pmAgentShopInfoService.pageAgentShopInfoList(pmAgentShopInfo, new Page<PmAgentShopInfo>(request, response));
		if(page.getCount()>0){
			model.addAttribute("page", page);
		}
		model.addAttribute("agentShopType", agentShopType);
		model.addAttribute("agentId", agentId);
		return "modules/shopping/shop/pmAgentShopInfofromList";
	}
	
	@RequiresPermissions("merchandise:AgentShopInfo:view")
	@RequestMapping(value ="form")
	public String form(HttpServletRequest request, HttpServletResponse response, Model model){
		String id= request.getParameter("id");
		createPicFold(request);
		if(StringUtils.isNotBlank(id)){
			PmAgentShopInfo pmAgentShopInfo=pmAgentShopInfoService.findid(Integer.valueOf(id));
			if(pmAgentShopInfo!=null){
				model.addAttribute("pmAgentShopInfo", pmAgentShopInfo);
			}
			return "modules/shopping/shop/pmAgentShopInfofrom";
		}else {
			SysUser user = SysUserUtils.getUser();
//			String isAgentCount=sysOfficeService.getisAgentCount(user.getCompany().getId());
//			if(isAgentCount.equals("0")){
//				PmAgentShopInfo agentShopInfo=new PmAgentShopInfo();
//				if(user.getCompany().getId().equals("1")){
//					agentShopInfo.setAgentShopType(1);//分场类型：1、御可贡茶；2、代理分场
//				}else {					
//					agentShopInfo.setAgentShopType(2);//分场类型：1、御可贡茶；2、代理分场
//				}
//				agentShopInfo.setAgentId(user.getCompany().getId());
//				PmAgentShopInfo pmAgentShopInfo=pmAgentShopInfoService.getAgentShopInfo(agentShopInfo);
//				if(pmAgentShopInfo!=null){
//					model.addAttribute("pmAgentShopInfo", pmAgentShopInfo);
//				}
//			}else{
				PmAgentShopInfo parmeter=new PmAgentShopInfo();
				parmeter.setAgentId(user.getCompany().getId());
				List<PmAgentShopInfo> pmAgentShopInfos=pmAgentShopInfoService.getAgentShopInfos(parmeter);
				if(CollectionUtils.isNotEmpty(pmAgentShopInfos)){
					model.addAttribute("pmAgentShopInfo", pmAgentShopInfos.get(0));
				}
//			}
			return "modules/shopping/shop/pmAgentShopInfofrom";
		}
	}
	
	@RequiresPermissions("merchandise:AgentShopInfo:edit")
	@RequestMapping(value = "save")
	public String save(PmAgentShopInfo pmAgentShopInfo,HttpServletRequest request, HttpServletResponse response, Model model,RedirectAttributes redirectAttributes){
		SysUser user = SysUserUtils.getUser();
		if(pmAgentShopInfo.getId()!=null){
			pmAgentShopInfo.setModifyUser(user.getLoginName());
			pmAgentShopInfo.setModifyTime(new Date());
			addMessage(redirectAttributes, "修改成功");
		}else {
			if(user.getCompany().getId().equals("1")){
				pmAgentShopInfo.setAgentShopType(1);//分场类型：1、御可贡茶；2、代理分场
			}else {					
				pmAgentShopInfo.setAgentShopType(2);//分场类型：1、御可贡茶；2、代理分场
			}
			pmAgentShopInfo.setAgentId(user.getCompany().getId());
			Date nowDate=new Date();
			pmAgentShopInfo.setCreateUser(user.getLoginName());
			pmAgentShopInfo.setCreateTime(nowDate);
			pmAgentShopInfo.setModifyUser(user.getLoginName());
			pmAgentShopInfo.setModifyTime(nowDate);
			addMessage(redirectAttributes, "保存成功");
		}
		pmAgentShopInfo.setIsDelete(0);
		pmAgentShopInfoService.save(pmAgentShopInfo);
		return "redirect:"+Global.getAdminPath()+"/AgentShopInfo/form";
	}
	
	@RequiresPermissions("merchandise:AgentShopInfo:edit")
	@RequestMapping(value = "isDelete")
	public String isDelete(HttpServletRequest request, HttpServletResponse response, Model model,RedirectAttributes redirectAttributes){
		String id=request.getParameter("id");
		String isDelete=request.getParameter("isDelete");
		if(StringUtils.isNotBlank(id)&&StringUtils.isNotBlank(isDelete)){
			pmAgentShopInfoService.isDelete(Integer.valueOf(isDelete), Integer.valueOf(id));
			addMessage(redirectAttributes, "修改成功");
		}
		return "redirect:"+Global.getAdminPath()+"/AgentShopInfo/list";
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
		folder.append("images" );
		folder.append(File.separator);
		folder.append("merchandise");
		folder.append(File.separator);
		folder.append("AgentShopInfo");
		folder.append(File.separator);
		folder.append(DateUtils.getYear());
		folder.append(File.separator);
		folder.append(DateUtils.getMonth());
		FileUtils.createDirectory(folder.toString());
	}
}