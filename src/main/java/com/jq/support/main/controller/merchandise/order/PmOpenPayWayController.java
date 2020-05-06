package com.jq.support.main.controller.merchandise.order;
import java.io.File;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import com.jq.support.model.pay.PmOpenPayWay;
import com.jq.support.model.sys.SysUser;
import com.jq.support.service.pay.PmOpenPayWayService;
import com.jq.support.service.utils.SysUserUtils;


/**
 * 支付方式
 * @author Lw
 *
 */
@Controller
@RequestMapping(value = "${adminPath}/PmOpenPayWay")
public class PmOpenPayWayController extends BaseController {
	@Autowired
	private PmOpenPayWayService pmOpenPayWayService;
	
	
	@ModelAttribute
	public PmOpenPayWay get(@RequestParam(required=false) String id) {
		if (org.apache.commons.lang3.StringUtils.isNotBlank(id)){
			return pmOpenPayWayService.getOpenPayWay(id);
		}else{
			return new PmOpenPayWay();
		}
	}
	
	@RequiresPermissions("merchandise:PmOpenPayWay:view")
	@RequestMapping(value = {"list",""})
	public String aftersalelist(PmOpenPayWay pmOpenPayWay, HttpServletRequest request, HttpServletResponse response, Model model){
		Page<PmOpenPayWay> page=pmOpenPayWayService.getPageList(new Page<PmOpenPayWay>(request,response), pmOpenPayWay);
		model.addAttribute("page", page);
		model.addAttribute("pmOpenPayWay", pmOpenPayWay);
		return "modules/shopping/order/pmOpenPayWayList";
	}
	
	@RequiresPermissions("merchandise:PmOpenPayWay:view")
	@RequestMapping(value = "form")
	public String form(PmOpenPayWay pmOpenPayWay, HttpServletRequest request, HttpServletResponse response, Model model){
	    model.addAttribute("pmOpenPayWay", pmOpenPayWay);
	    createPicFold(request);
		return "modules/shopping/order/pmOpenPayWayFrom";
	}
	
	@RequiresPermissions("merchandise:PmOpenPayWay:edit")
	@RequestMapping(value = "save")
	public String save(PmOpenPayWay pmOpenPayWay, HttpServletRequest request, HttpServletResponse response, Model model,RedirectAttributes redirectAttributes){
	    SysUser sysUser=SysUserUtils.getUser();
		if(pmOpenPayWay.getId()==null){
		   pmOpenPayWay.setCreateTime(new Date());
		   pmOpenPayWay.setCreateUser(sysUser.getLoginName());
		}else{
		   pmOpenPayWay.setModifyTime(new Date());
		   pmOpenPayWay.setModifyUser(sysUser.getLoginName());
		}
		pmOpenPayWayService.save(pmOpenPayWay);
		addMessage(redirectAttributes, "保存成功");
		return "redirect:"+Global.getAdminPath()+"/PmOpenPayWay/list";
	}
	
	@RequiresPermissions("merchandise:PmOpenPayWay:edit")
	@RequestMapping(value = "status")
	public String status(PmOpenPayWay pmOpenPayWay, HttpServletRequest request, HttpServletResponse response, Model model,RedirectAttributes redirectAttributes){
	    SysUser sysUser=SysUserUtils.getUser();
		if(pmOpenPayWay.getId()==null){
		   pmOpenPayWay.setCreateTime(new Date());
		   pmOpenPayWay.setCreateUser(sysUser.getLoginName());
		}else{
		   pmOpenPayWay.setModifyTime(new Date());
		   pmOpenPayWay.setModifyUser(sysUser.getLoginName());
		}
		if(pmOpenPayWay.getStatus()==0){
			pmOpenPayWay.setStatus(1);
		}else{
			pmOpenPayWay.setStatus(0);
		}
		pmOpenPayWayService.save(pmOpenPayWay);
		addMessage(redirectAttributes, "保存成功");
		return "redirect:"+Global.getAdminPath()+"/PmOpenPayWay/list";
	}
	
	@RequiresPermissions("merchandise:PmOpenPayWay:edit")
	@RequestMapping(value = "delete")
	public String delete(PmOpenPayWay pmOpenPayWay, HttpServletRequest request, HttpServletResponse response, Model model,RedirectAttributes redirectAttributes){
		pmOpenPayWayService.delete(pmOpenPayWay);
		addMessage(redirectAttributes, "删除成功");
		return "redirect:"+Global.getAdminPath()+"/PmOpenPayWay/list";
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
		folder.append("pmOpenPayWay");
		folder.append(File.separator);
		folder.append(DateUtils.getYear());
		folder.append(File.separator);
		folder.append(DateUtils.getMonth());
		FileUtils.createDirectory(folder.toString());
	}
	

}
