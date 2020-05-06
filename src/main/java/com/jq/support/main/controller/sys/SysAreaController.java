package com.jq.support.main.controller.sys;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.authz.annotation.RequiresUser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.jq.support.common.config.Global;
import com.jq.support.common.utils.StringUtils;
import com.jq.support.common.web.BaseController;
import com.jq.support.model.sys.SysArea;
import com.jq.support.service.sys.SysAreaService;
import com.jq.support.service.utils.SysUserUtils;


@Controller
@RequestMapping(value = "${adminPath}/sys/area")
public class SysAreaController extends BaseController{
	
	private static Logger logger = LoggerFactory.getLogger(SysAreaController.class);

   
	@Autowired
	private SysAreaService areaService;
	
	
	@ModelAttribute
	public SysArea get(@RequestParam(required=false) String id) {
		if (StringUtils.isNotBlank(id)){
			return areaService.get(id);
		}else{
			return new SysArea();
		}
	}
	
	
	/**
	 * 区域信息表单
	 * @param area
	 * @param model
	 * @return
	 */
	@RequiresPermissions("sys:area:view")
	@RequestMapping(value = "form")
	public String form(SysArea area, Model model) {
		if (area.getParent()==null||area.getParent().getId()==null){
			area.setParent(SysUserUtils.getUser().getOffice().getArea());
		}
		area.setParent(areaService.get(area.getParent().getId()));
		model.addAttribute("area", area);
		return "modules/sys/areaForm";
	}
	
	/**
	 * 保存区域信息
	 * @param area
	 * @param model
	 * @param redirectAttributes 重定向传参
	 * @return
	 */
	@RequiresPermissions("sys:area:edit")
	@RequestMapping(value = "save")
	public String save(SysArea area, Model model, RedirectAttributes redirectAttributes) {
		if(Global.isDemoMode()){
			addMessage(redirectAttributes, "演示模式，不允许操作！");
			return "redirect:"+Global.getAdminPath()+"/sys/area";
		}
		if (!beanValidator(model, area)){
			return form(area, model);
		}
		areaService.save(area);
		addMessage(redirectAttributes, "保存区域'" + area.getName() + "'成功");
		return "redirect:"+Global.getAdminPath()+"/sys/area/";
	}
	
	
	/**
	 * 删除区域
	 * @param id
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions("sys:area:edit")
	@RequestMapping(value = "delete")
	public String delete(String id, RedirectAttributes redirectAttributes) {
		if (SysArea.isAdmin(id)){
			addMessage(redirectAttributes, "删除区域失败, 不允许删除顶级区域或编号为空");
		}else{
			areaService.delete(id);
			addMessage(redirectAttributes, "删除区域成功");
		}
		return "redirect:"+Global.getAdminPath()+"/sys/area/";
	}
	
	
	/**
	 * 返回树结构数据
	 * @param extId
	 * @param response
	 * @return
	 */
	@RequiresUser
	@ResponseBody
	@RequestMapping(value = "treeData")
	public List<Map<String, Object>> treeData(@RequestParam(required=false) String extId, HttpServletResponse response) {
		response.setContentType("application/json; charset=UTF-8");
		List<Map<String, Object>> mapList = Lists.newArrayList();
//		User user = UserUtils.getUser();
		List<SysArea> list = areaService.findAll();
		for (int i=0; i<list.size(); i++){
			SysArea e = list.get(i);
			if (extId == null || (extId!=null && !extId.equals(e.getId()) && e.getParentIds().indexOf(","+extId+",")==-1)){
				Map<String, Object> map = Maps.newHashMap();
				map.put("id", e.getId());
//				map.put("pId", !user.isAdmin()&&e.getId().equals(user.getArea().getId())?0:e.getParent()!=null?e.getParent().getId():0);
				map.put("pId", e.getParent()!=null?e.getParent().getId():0);
				map.put("name", e.getName());
				mapList.add(map);
			}
		}
		return mapList;
	}
	
	/**
	 * 区域列表
	 * @param area
	 * @param model
	 * @return
	 */
	@RequiresPermissions("sys:area:view")
	@RequestMapping(value = {"list", ""})
	public String list(SysArea area, Model model) {
		area.setId("1");
		model.addAttribute("area", area);
		List<SysArea> list = Lists.newArrayList();
		List<SysArea> sourcelist = areaService.findAll();
		SysArea.sortList(list, sourcelist, area.getId());
        model.addAttribute("list", list);
		return "modules/sys/areaList";
	}
	
	

	
}
