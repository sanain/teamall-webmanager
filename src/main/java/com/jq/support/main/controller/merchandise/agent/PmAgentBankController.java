package com.jq.support.main.controller.merchandise.agent;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.jq.support.common.config.Global;
import com.jq.support.common.persistence.Page;
import com.jq.support.common.utils.StringUtils;
import com.jq.support.common.web.BaseController;
import com.jq.support.model.sys.SysUser;
import com.jq.support.model.user.PmAgentBank;
import com.jq.support.service.merchandise.user.PmAgentBankService;
import com.jq.support.service.utils.SysUserUtils;

/**
 * 御可贡茶_代理银行卡
 */
@Controller
@RequestMapping(value = "${adminPath}/pmAgentBank")
public class PmAgentBankController extends BaseController {

	@Autowired
	PmAgentBankService pmAgentBankService;
	
	@ModelAttribute
	public PmAgentBank get(@RequestParam(required=false) String id) {
		if (StringUtils.isNotBlank(id)){
			return pmAgentBankService.get(Integer.valueOf(id));
		}else{
			return new PmAgentBank();
		}
	}
	
	@RequestMapping(value ={"list",""})
	public String list(PmAgentBank pmAgentBank,HttpServletRequest request, HttpServletResponse response, Model model){
		SysUser user=SysUserUtils.getUser();
		pmAgentBank.setAgentId(user.getCompany().getId());
		pmAgentBank.setIsdelete(0);
		Page<PmAgentBank> page=pmAgentBankService.findPmAgentBankList( new Page<PmAgentBank>(request, response),pmAgentBank);
		model.addAttribute("page", page);
		return "modules/shopping/user/pmAgentBankList";
	}
	
	@RequestMapping(value ="form")
	public String form(PmAgentBank pmAgentBank,HttpServletRequest request, HttpServletResponse response){
		return "modules/shopping/user/pmAgentBankfrom";
	}
	
	@RequestMapping(value ="save")
	public String save(PmAgentBank pmAgentBank,HttpServletRequest request, HttpServletResponse response,RedirectAttributes redirectAttributes){
		//判断重复
		PmAgentBank agentBank=new PmAgentBank();
		SysUser user=SysUserUtils.getUser();
		agentBank.setAgentId(user.getCompany().getId());
		agentBank.setAccount(pmAgentBank.getAccount());
		if (CollectionUtils.isNotEmpty(pmAgentBankService.findPmAgentBankList(agentBank))) {
			addMessage(redirectAttributes, "银行卡重复");
			return "redirect:"+Global.getAdminPath()+"/pmAgentBank";
		}
		if (pmAgentBank.getId()==null) {
			pmAgentBank.setAgentId(user.getCompany().getId());
			pmAgentBank.setCreateTime(new Date());
			pmAgentBank.setBankType(0);
			pmAgentBank.setIsdelete(0);
		}
		pmAgentBankService.save(pmAgentBank);
		return "redirect:"+Global.getAdminPath()+"/pmAgentBank";
	}
	@RequestMapping(value ="delete")
	public String delete(PmAgentBank pmAgentBank,HttpServletRequest request, HttpServletResponse response){
		if (pmAgentBank!=null) {
			pmAgentBankService.delete(pmAgentBank);
		}
		return "redirect:"+Global.getAdminPath()+"/pmAgentBank";
	}
}