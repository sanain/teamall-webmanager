package com.jq.support.main.controller.sys;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
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
import com.jq.support.common.web.BaseController;
import com.jq.support.model.sys.SysDict;
import com.jq.support.service.sys.SysDictService;

/**
 * 字典Controller
 * @author 
 * @version 
 */
@Controller
@RequestMapping(value = "${adminPath}/sys/dict")
public class SysDictController extends BaseController {

	@Autowired
	private SysDictService dictService;
	
	@ModelAttribute
	public SysDict get(@RequestParam(required=false) String id) {
		if (StringUtils.isNotBlank(id)){
			return dictService.get(id);
		}else{
			return new SysDict();
		}
	}
	
	@RequiresPermissions("sys:dict:view")
	@RequestMapping(value = {"list", ""})
	public String list(SysDict dict, HttpServletRequest request, HttpServletResponse response, Model model) {
		List<String> typeList = dictService.findTypeList();
		model.addAttribute("typeList", typeList);
        Page<SysDict> page = dictService.find(new Page<SysDict>(request, response), dict); 
        model.addAttribute("page", page);
		return "modules/sys/dictList";
	}

	@RequiresPermissions("sys:dict:view")
	@RequestMapping(value = "form")
	public String form(SysDict dict, Model model, HttpServletRequest request) {
		String addnew = request.getParameter("addnew");
		if(StringUtils.isNotBlank(addnew)) {
			SysDict newdict = new SysDict();
			newdict.setType(dict.getType());
			newdict.setDescription(dict.getDescription());
			newdict.setSort(dict.getSort()+10);
			model.addAttribute("dict", newdict);
		} else {
			model.addAttribute("dict", dict);
		}
		return "modules/sys/dictForm";
	}

	@RequiresPermissions("sys:dict:edit")
	@RequestMapping(value = "save")//@Valid 
	public String save(SysDict dict, HttpServletRequest request, Model model, RedirectAttributes redirectAttributes) {
		
		if (!beanValidator(model, dict)){
			return form(dict, model,request);
		}
		if(dictService.findDictCountByValueType(dict)) {
			dictService.save(dict);
			addMessage(redirectAttributes, "保存字典'" + dict.getLabel() + "'成功");
			return "redirect:"+Global.getAdminPath()+"/sys/dict/?repage&type="+dict.getType();
		} else {
			addMessage(model, "保存字典失败，键值类型已经存在，请修改");
			return form(dict,model,request);
		}
	}
	
	@RequiresPermissions("sys:dict:edit")
	@RequestMapping(value = "delete")
	public String delete(String id, RedirectAttributes redirectAttributes) {
		
		dictService.delete(id);
		addMessage(redirectAttributes, "删除字典成功");
		return "redirect:"+Global.getAdminPath()+"/sys/dict/?repage";
	}

}
