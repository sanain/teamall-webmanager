package com.jq.support.main.controller.merchandise.user;
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
import com.jq.support.model.user.LogUserlogin;
import com.jq.support.service.loginLog.LogUserLoginService;
import com.jq.support.service.merchandise.user.EbUserService;
/**
 * 用户登录日志
 * @author Administrator
 *
 */
@Controller
@RequestMapping(value= "${adminPath}/LogUserlogin")
public class LogUserloginController extends BaseController{
    @Autowired
	private LogUserLoginService logUserLoginService;
	@Autowired
	private EbUserService ebUserService;
    @ModelAttribute
	public LogUserlogin get(@RequestParam(required=false) String id) {
		if (StringUtils.isNotBlank(id)){
			return logUserLoginService.get(id);
		}else{
			return new LogUserlogin();
		}
	}
    
    
	@RequiresPermissions("sys:log:view")
	@RequestMapping(value = {"list", ""})
	public String list(LogUserlogin logUserlogin, HttpServletRequest request, HttpServletResponse response, Model model){
		Page<LogUserlogin> page = logUserLoginService.find(new Page<LogUserlogin>(request, response), logUserlogin);
		for(LogUserlogin loUser:page.getList()){
			if(loUser.getUserId()!=null)
			loUser.setEbUser(ebUserService.getEbUser(loUser.getUserId()+""));
		}
		model.addAttribute("page", page);
		return "modules/user/logList";
	}
}
