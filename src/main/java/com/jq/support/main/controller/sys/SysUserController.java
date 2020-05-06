package com.jq.support.main.controller.sys;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.ConstraintViolationException;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.authz.annotation.RequiresUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.common.collect.Lists;
import com.jq.support.common.beanvalidator.BeanValidators;
import com.jq.support.common.config.Global;
import com.jq.support.common.persistence.Page;
import com.jq.support.common.utils.DateUtils;
import com.jq.support.common.utils.StringUtils;
import com.jq.support.common.web.BaseController;
import com.jq.support.model.agent.PmAgentInfo;
import com.jq.support.model.sys.SysOffice;
import com.jq.support.model.sys.SysRole;
import com.jq.support.model.sys.SysUser;
import com.jq.support.model.user.EbUser;
import com.jq.support.service.agent.PmAgentInfoService;
import com.jq.support.service.merchandise.user.EbUserService;
import com.jq.support.service.sys.SystemService;
import com.jq.support.service.utils.SysUserUtils;
import com.jq.support.service.utils.excel.ExportExcel;
import com.jq.support.service.utils.excel.ImportExcel;

/**
 * 用户Controller
 * @author 
 * @version 
 */
@Controller
@RequestMapping(value = "${adminPath}/sys/user")
public class SysUserController extends BaseController {

	@Autowired
	private SystemService systemService;
	@Autowired
	private PmAgentInfoService agentService;
	@Autowired
	private EbUserService ebUserService;
	@ModelAttribute
	public SysUser get(@RequestParam(required=false) String id) {
		if (StringUtils.isNotBlank(id)){
			return systemService.getUser(id);
		}else{
			return new SysUser();
		}
	}
	
	@RequiresPermissions("sys:user:view")
	@RequestMapping({"list", ""})
	public String list(SysUser user, HttpServletRequest request, HttpServletResponse response, Model model) {
		if(user.getCompany()!=null){
			SysOffice company=new SysOffice();
			company.setIsAgent("0");
			user.setCompany(company);
		}
		if(user.getOffice()!=null){
			SysOffice company=new SysOffice();
			company.setIsAgent("0");
			user.setOffice(company);
		}
        Page<SysUser> page = systemService.findUser(new Page<SysUser>(request, response), user); 
        model.addAttribute("page", page);
		return "modules/sys/userList";
	}
	
	@RequiresPermissions("sys:user:view")
	@RequestMapping("daililist")
	public String daililist(SysUser user, HttpServletRequest request, HttpServletResponse response, Model model) {
        Page<SysUser> page = systemService.findUser(new Page<SysUser>(request, response), user); 
        model.addAttribute("page", page);
		return "modules/sys/userDList";
	}
	/**
	 * 查询区代用户
	 * @param user
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("sys:user:view")
	@RequestMapping("openDaililist")
	public String openDaililist(PmAgentInfo user, HttpServletRequest request, HttpServletResponse response, Model model) {
//        Page<SysUser> page = systemService.findUser(new Page<SysUser>(request, response), user); 
		user.setAgentType(3);
        Page<PmAgentInfo> page =agentService.findAgent(new Page<PmAgentInfo>(request, response), user); 
        for(PmAgentInfo pmAgentInfo:page.getList()){
        	EbUser ebUser=ebUserService.findByPmAgentId(pmAgentInfo.getAgentId()+"");
        	pmAgentInfo.setUser(ebUser);
        }
        model.addAttribute("page", page);
        model.addAttribute("user", user);

		return "modules/sys/openUserDList";
	}


	@RequiresPermissions("sys:user:view")
	@RequestMapping("form")
	public String form(SysUser user, Model model) {
		if (user.getCompany() == null || user.getCompany().getId() == null) {
			user.setCompany(SysUserUtils.getUser().getCompany());
		}
		if (user.getOffice() == null || user.getOffice().getId() == null) {
			user.setOffice(SysUserUtils.getUser().getOffice());
		}

		// 判断显示的用户是否在授权范围内
		String officeId = user.getCompany().getId();//user.getOffice().getId();
		SysUser currentUser = SysUserUtils.getUser();
		if (!currentUser.isAdmin()) {
			String dataScope = systemService.getDataScope(currentUser);
			// System.out.println(dataScope);
			if (dataScope.indexOf("office.id=") != -1) {
				String AuthorizedOfficeId = dataScope.substring(dataScope.indexOf("office.id=") + 10, dataScope.indexOf(" or"));
				if (!AuthorizedOfficeId.equalsIgnoreCase(officeId)) {
					return "error/403";
				}
			}
		}

		model.addAttribute("user", user);
		model.addAttribute("allRoles", systemService.findPartRole());
		return "modules/sys/userForm";
	}

	
	@RequiresPermissions("sys:user:view")
	@RequestMapping("form1")
	public String form1(SysUser user, Model model) {
		if (user.getCompany() == null || user.getCompany().getId() == null) {
			//user.setCompany(SysUserUtils.getUser().getCompany());
		}
		if (user.getOffice() == null || user.getOffice().getId() == null) {
			//user.setOffice(SysUserUtils.getUser().getOffice());
		}
		String officeId = "";
        if(user.getCompany() != null && user.getCompany().getId() != null){
        	// 判断显示的用户是否在授权范围内
    		 officeId = user.getCompany().getId();//user.getOffice().getId();
        }
		SysUser currentUser = SysUserUtils.getUser();
		if (!currentUser.isAdmin()) {
			String dataScope = systemService.getDataScope(currentUser);
			// System.out.println(dataScope);
			if (dataScope.indexOf("office.id=") != -1) {
				String AuthorizedOfficeId = dataScope.substring(dataScope.indexOf("office.id=") + 10, dataScope.indexOf(" or"));
				if (!AuthorizedOfficeId.equalsIgnoreCase(officeId)) {
					return "error/403";
				}
			}
		}
		model.addAttribute("user", user);
		model.addAttribute("allRoles", systemService.findAllRole());
		return "modules/sys/userFormTo";
	}


	@RequiresPermissions("sys:user:edit")
	@RequestMapping("save")
	public String save(SysUser user, String oldLoginName, String newPassword, HttpServletRequest request, Model model, RedirectAttributes redirectAttributes) {
		// 修正引用赋值问题，不知道为何，Company和Office引用的一个实例地址，修改了一个，另外一个跟着修改。
		user.setCompany(new SysOffice(request.getParameter("company.id")));
		user.setOffice(new SysOffice(request.getParameter("office.id")));
		
		// 如果新密码为空，则不更换密码
		if (StringUtils.isNotBlank(newPassword)) {
			user.setPassword(SystemService.entryptPassword(newPassword));
		}
		if (!beanValidator(model, user)) {
			return form(user, model);
		}
		if (!"true".equals(checkLoginName(oldLoginName, user.getLoginName()))) {
			addMessage(model, "保存用户'" + user.getLoginName() + "'失败，登录名已存在");
			return form(user, model);
		}
		
		// 角色数据有效性验证，过滤不在授权内的角色
		List<SysRole> roleList = Lists.newArrayList();
		List<String> roleIdList = user.getRoleIdList();
		for (SysRole r : systemService.findAllRole()) {
			if (roleIdList.contains(r.getId())) {
				roleList.add(r);
			}
		}
		user.setRoleList(roleList);
		// 保存用户信息
		systemService.saveUser(user);
		// 清除当前用户缓存
		if (user.getLoginName().equals(SysUserUtils.getUser().getLoginName())) {
			SysUserUtils.getCacheMap().clear();
		}
		
		addMessage(redirectAttributes, "保存用户'" + user.getLoginName() + "'成功");
		return "redirect:" + Global.getAdminPath() + "/sys/user/list?office.isAgent=0&company.isAgent=0";
	}
	
	@RequiresPermissions("sys:user:edit")
	@RequestMapping("save1")
	public String save1(SysUser user, String oldLoginName, String newPassword, HttpServletRequest request, Model model, RedirectAttributes redirectAttributes) {
		// 修正引用赋值问题，不知道为何，Company和Office引用的一个实例地址，修改了一个，另外一个跟着修改。
		user.setCompany(new SysOffice(request.getParameter("company.id")));
		user.setOffice(new SysOffice(request.getParameter("office.id")));
		
		// 如果新密码为空，则不更换密码
		if (StringUtils.isNotBlank(newPassword)) {
			user.setPassword(SystemService.entryptPassword(newPassword));
		}
		if (!beanValidator(model, user)) {
			return form(user, model);
		}
		if (!"true".equals(checkLoginName(oldLoginName, user.getLoginName()))) {
			addMessage(model, "保存用户'" + user.getLoginName() + "'失败，登录名已存在");
			return form(user, model);
		}
		
		// 角色数据有效性验证，过滤不在授权内的角色
		List<SysRole> roleList = Lists.newArrayList();
		List<String> roleIdList = user.getRoleIdList();
		for (SysRole r : systemService.findAllRole()) {
			if (roleIdList.contains(r.getId())) {
				roleList.add(r);
			}
		}
		user.setRoleList(roleList);
		// 保存用户信息
		systemService.saveUser(user);
		// 清除当前用户缓存
		if (user.getLoginName().equals(SysUserUtils.getUser().getLoginName())) {
			SysUserUtils.getCacheMap().clear();
		}
		
		addMessage(redirectAttributes, "保存用户'" + user.getLoginName() + "'成功");
		return "redirect:" + Global.getAdminPath() + "/sys/user/daililist?office.isAgent=1&company.isAgent=1";
	}
	
	@RequiresPermissions("sys:user:edit")
	@RequestMapping("delete")
	public String delete(String id, RedirectAttributes redirectAttributes) {
		if (Global.isDemoMode()) {
			addMessage(redirectAttributes, "演示模式，不允许操作！");
			return "redirect:" + Global.getAdminPath() + "/sys/user/list?office.isAgent=0&company.isAgent=0";
		}
		
		if (SysUserUtils.getUser().getId().equals(id)) {
			addMessage(redirectAttributes, "删除用户失败, 不允许删除当前用户");
		} else if (SysUser.isAdmin(id)) {
			addMessage(redirectAttributes, "删除用户失败, 不允许删除超级管理员用户");
		} else {
			systemService.deleteUser(id);
			addMessage(redirectAttributes, "删除用户成功");
		}
		return "redirect:" + Global.getAdminPath() + "/sys/user/list?office.isAgent=0&company.isAgent=0";
	}
	@RequiresPermissions("sys:user:edit")
	@RequestMapping("delete1")
	public String delete1(String id, RedirectAttributes redirectAttributes) {
		if (Global.isDemoMode()) {
			addMessage(redirectAttributes, "演示模式，不允许操作！");
			return "redirect:" + Global.getAdminPath() + "/sys/user/daililist?office.isAgent=1&company.isAgent=1";
		}
		
		if (SysUserUtils.getUser().getId().equals(id)) {
			addMessage(redirectAttributes, "删除用户失败, 不允许删除当前代理用户");
		} else if (SysUser.isAdmin(id)) {
			addMessage(redirectAttributes, "删除用户失败, 不允许删除超级管理员用户");
		} else {
			systemService.deleteUser(id);
			addMessage(redirectAttributes, "删除代理用户成功");
		}
		return "redirect:" + Global.getAdminPath() + "/sys/user/daililist?office.isAgent=1&company.isAgent=1";
	}
	
	@RequiresPermissions("sys:user:view")
    @RequestMapping(value = "export", method=RequestMethod.POST)
    public String exportFile(SysUser user, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
			String fileName = "用户数据" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx"; 
    		Page<SysUser> page = systemService.findUser(new Page<SysUser>(request, response, -1), user); 
    		new ExportExcel("用户数据", SysUser.class).setDataList(page.getList()).write(response, fileName).dispose();
    		return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出用户失败！失败信息："+e.getMessage());
		}
		return "redirect:" + Global.getAdminPath() + "/sys/user/?repage";
    }

	@RequiresPermissions("sys:user:edit")
    @RequestMapping(value = "import", method=RequestMethod.POST)
    public String importFile(MultipartFile file, RedirectAttributes redirectAttributes) {
		if(Global.isDemoMode()){
			addMessage(redirectAttributes, "演示模式，不允许操作！");
			return "redirect:" + Global.getAdminPath() + "/sys/user/?repage";
		}
		
		try {
			int successNum = 0;
			int failureNum = 0;
			StringBuilder failureMsg = new StringBuilder();
			ImportExcel ei = new ImportExcel(file, 1, 0);
			List<SysUser> list = ei.getDataList(SysUser.class);
			for (SysUser user : list){
				try{
					if ("true".equals(checkLoginName("", user.getLoginName()))){
						user.setPassword(SystemService.entryptPassword("123456"));
						BeanValidators.validateWithException(validator, user);
						systemService.saveUser(user);
						successNum++;
					}else{
						failureMsg.append("<br/>登录名 " + user.getLoginName() + " 已存在; ");
						failureNum++;
					}
				}catch(ConstraintViolationException ex){
					failureMsg.append("<br/>登录名 " + user.getLoginName() + " 导入失败：");
					List<String> messageList = BeanValidators.extractPropertyAndMessageAsList(ex, ": ");
					for (String message : messageList){
						failureMsg.append(message+"; ");
						failureNum++;
					}
				}catch (Exception ex) {
					failureMsg.append("<br/>登录名 " + user.getLoginName() + " 导入失败：" + ex.getMessage());
				}
			}
			if (failureNum>0){
				failureMsg.insert(0, "，失败 "+failureNum+" 条用户，导入信息如下：");
			}
			addMessage(redirectAttributes, "已成功导入 " + successNum+" 条用户" + failureMsg);
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入用户失败！失败信息：" + e.getMessage());
		}
		return "redirect:" + Global.getAdminPath() + "/sys/user/?repage";
    }
	
	@RequiresPermissions("sys:user:view")
    @RequestMapping("import/template")
    public String importFileTemplate(HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
			String fileName = "用户数据导入模板.xlsx";
			List<SysUser> list = Lists.newArrayList();
			list.add(SysUserUtils.getUser());
			new ExportExcel("用户数据", SysUser.class, 2).setDataList(list).write(response, fileName).dispose();
			return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入模板下载失败！失败信息：" + e.getMessage());
		}
		return "redirect:" + Global.getAdminPath() + "/sys/user/?repage";
    }

	@ResponseBody
	@RequiresPermissions("sys:user:edit")
	@RequestMapping("checkLoginName")
	public String checkLoginName(String oldLoginName, String loginName) {
		if (loginName != null && loginName.equals(oldLoginName)) {
			return "true";
		} else if (loginName != null && systemService.getUserByLoginName(loginName) == null) {
			return "true";
		}
		return "false";
	}
	/**
	 * 核实当前输入密码是否与原密码相同
	 * @param initOldPassword 原密文密码
	 * @param oldPassword 当前明文密码
	 * @return
	 */
	@ResponseBody
	@RequiresPermissions("sys:user:edit")
	@RequestMapping("checkUserPassword")
	public String checkUserPassword(String initOldPassword, String oldPassword) {
		if (StringUtils.isNotBlank(oldPassword) && SystemService.validatePassword(oldPassword,initOldPassword)) {
			//如果与原密码相同则返回true
			return "true";
		}
		return "false";
	}
	
	@RequiresUser
	@RequestMapping("info")
	public String info(SysUser user, Model model) {
		SysUser currentUser = SysUserUtils.getUser();
		if (StringUtils.isNotBlank(user.getName())){
			if(Global.isDemoMode()){
				model.addAttribute("message", "演示模式，不允许操作！");
				return "modules/sys/userInfo";
			}
			
			currentUser = SysUserUtils.getUser(true);
			currentUser.setEmail(user.getEmail());
			currentUser.setPhone(user.getPhone());
			currentUser.setMobile(user.getMobile());
			currentUser.setRemarks(user.getRemarks());
			systemService.saveUser(currentUser);
			model.addAttribute("message", "保存用户信息成功");
		}
		model.addAttribute("allRoles", systemService.findAllRole());
		model.addAttribute("user", currentUser);
		return "modules/sys/userInfo";
	}
	
	@RequiresUser
	@RequiresPermissions("sys:user:edit")
	@RequestMapping("modifyPwd")
	public String modifyPwd(String oldPassword, String newPassword, Model model) {
		SysUser user = SysUserUtils.getUser();
		if (StringUtils.isNotBlank(oldPassword) && StringUtils.isNotBlank(newPassword)){
//			if(Global.isDemoMode()){
//				model.addAttribute("message", "演示模式，不允许操作！");
//				return "modules/sys/userModifyPwd";
//			}
			if ("true".equals(checkUserPassword(user.getPassword(), oldPassword))){//再次验证原密码是否正确
				systemService.updatePasswordById(user.getId(), user.getLoginName(), newPassword);
				user = SysUserUtils.getUser(true);//重新从数据库获取user
				model.addAttribute("message", "修改密码成功");
			}else{
				model.addAttribute("message", "修改密码失败，旧密码错误");
			}
		}
		model.addAttribute("user", user);
		return "modules/sys/userModifyPwd";
	}
    
//	@InitBinder
//	public void initBinder(WebDataBinder b) {
//		b.registerCustomEditor(List.class, "roleList", new PropertyEditorSupport(){
//			@Autowired
//			private SystemService systemService;
//			@Override
//			public void setAsText(String text) throws IllegalArgumentException {
//				String[] ids = StringUtils.split(text, ",");
//				List<Role> roles = new ArrayList<Role>();
//				for (String id : ids) {
//					Role role = systemService.getRole(Long.valueOf(id));
//					roles.add(role);
//				}
//				setValue(roles);
//			}
//			@Override
//			public String getAsText() {
//				return Collections3.extractToString((List) getValue(), "id", ",");
//			}
//		});
//	}
}
