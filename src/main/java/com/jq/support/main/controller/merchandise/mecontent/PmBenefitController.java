package com.jq.support.main.controller.merchandise.mecontent;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jq.support.common.persistence.Page;
import com.jq.support.common.utils.StringUtils;
import com.jq.support.common.web.BaseController;
import com.jq.support.model.product.Clinetversion;
import com.jq.support.model.sys.SysDict;
import com.jq.support.service.sys.SysDictService;
import com.jq.support.service.utils.DictUtils;



@Controller
@RequestMapping(value = "${adminPath}/PmBenefit")
public class PmBenefitController extends BaseController {
	@Autowired
	private SysDictService sysDictService;
	
	@RequiresPermissions("merchandise:PmBenefit:view")
	@RequestMapping(value = {"list", ""})
	public String getProductList(HttpServletRequest request, HttpServletResponse response, Model model){
		 SysDict sysDict=new SysDict();
	     sysDict.setType("gyconfig");
	     sysDict.setDelFlag("0");
		 List<SysDict> sysDicts=sysDictService.getDicts(sysDict);
	     model.addAttribute("sysDicts", sysDicts);
		 return "modules/shopping/Article/platform-configuration";
	}
	
	@ResponseBody
	@RequestMapping(value = "save")
	public SysDict save(String id,String val,HttpServletRequest request, HttpServletResponse response, Model model){
	     List<SysDict> sysDicts=DictUtils.getDictList("gyconfig");
	     SysDict sysDict= sysDictService.get(id);
	     if(StringUtils.isNotBlank(id)){
	    	 if(StringUtils.isNotBlank(val)){
	    		 sysDict.setValue(val);
	    	 }else{
	    		 sysDict.setValue("0");
	    	 }
	      }
	     sysDictService.save(sysDict);
		 return sysDict;
	}
}
