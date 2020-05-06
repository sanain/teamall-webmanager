package com.jq.support.main.controller.sys;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import com.jq.support.common.persistence.Page;
import com.jq.support.common.utils.StringUtils;
import com.jq.support.common.web.BaseController;
import com.jq.support.model.sys.SysLog;
import com.jq.support.service.sys.SysLogService;

@Controller
@RequestMapping(value= "${adminPath}/sys")
public class SysLogController extends BaseController{
    @Autowired
	private SysLogService sysLogService;
    
    @ModelAttribute
	public SysLog get(@RequestParam(required=false) String id) {
		if (StringUtils.isNotBlank(id)){
			return sysLogService.get(id);
		}else{
			return new SysLog();
		}
	}
    
    
	@RequiresPermissions("sys:log:view")
	@RequestMapping(value = {"list", ""})
	public String list(SysLog sysLog, HttpServletRequest request, HttpServletResponse response, Model model){
		Page<SysLog> page = sysLogService.find(new Page<SysLog>(request, response), sysLog);
		model.addAttribute("page", page);
		return "modules/sys/logList";
	}
	
	@RequiresPermissions("sys:log:view")
	@RequestMapping(value = "form")
	public String form(SysLog sysLog,HttpServletRequest request, Model model){
		return formSearch(sysLog, model);
	}

	public String formSearch(SysLog sysLog, Model model) {
		model.addAttribute("log", sysLog);
		return "modules/sys/log";
	}
	@RequiresPermissions("sys:log:view")
	@RequestMapping(value = "detail")
	public String detail(SysLog sysLog, Model model) {
		model.addAttribute("log", sysLog);
		return "modules/sys/logInfo";
	}
}
