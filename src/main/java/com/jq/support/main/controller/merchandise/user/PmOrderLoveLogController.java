package com.jq.support.main.controller.merchandise.user;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import com.jq.support.common.persistence.Page;
import com.jq.support.common.utils.StringUtils;
import com.jq.support.common.web.BaseController;
import com.jq.support.model.order.PmOrderLoveLog;
import com.jq.support.model.sys.SysOffice;
import com.jq.support.model.sys.SysUser;
import com.jq.support.service.merchandise.order.PmOrderLoveLogService;
import com.jq.support.service.utils.SysUserUtils;


@Controller
@RequestMapping(value = "${adminPath}/pmOrderLoveLog")
public class PmOrderLoveLogController extends BaseController {
   @Autowired
   private PmOrderLoveLogService pmOrderLoveLogService;
   

	@ModelAttribute
	public PmOrderLoveLog get(@RequestParam(required=false) String id) {
		if (StringUtils.isNotBlank(id)){
			return pmOrderLoveLogService.getpmorLoveLog(id);
		}else{
			return new PmOrderLoveLog();
		}
	}
	/**
	 * 代理御可贡茶列表
	 */
	@RequestMapping("agentLoveList")
	public String agentLoveList(PmOrderLoveLog pmOrderLoveLog,HttpServletRequest request, HttpServletResponse response, Model model){
		SysUser user=SysUserUtils.getUser();
		SysOffice sysOffice=user.getCompany();
		pmOrderLoveLog.setObjId(sysOffice.getId());
		pmOrderLoveLog.setCurrencyType(1);
		pmOrderLoveLog.setObjType(3);
		Page<PmOrderLoveLog> page =pmOrderLoveLogService.findmyloveList(new Page<PmOrderLoveLog>(request, response),pmOrderLoveLog,"","");
		model.addAttribute("page", page);
		return "modules/shopping/user/agentLoveList";
	}
	
   
}
