package com.jq.support.main.controller.sys;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.authz.annotation.RequiresUser;
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
import com.jq.support.model.sys.SysMenu;
import com.jq.support.service.sys.SystemService;
import com.jq.support.service.utils.SysUserUtils;


/**
 * 菜单Controller
 * @author 
 * @version 2013-3-23
 */
@Controller
@RequestMapping(value = "${adminPath}/sys/menu")
public class SysMenuController extends BaseController {

	@Autowired
	private SystemService systemService;
	
	@ModelAttribute
	public SysMenu get(@RequestParam(required=false) String id) {
		if (StringUtils.isNotBlank(id)){
			return systemService.getMenu(id);
		}else{
			return new SysMenu();
		}
	}

	@RequiresPermissions("sys:menu:view")
	@RequestMapping(value = {"list", ""})
	public String list(Model model) {
		List<SysMenu> list = Lists.newArrayList();
		List<SysMenu> sourcelist = systemService.findAllMenu();
		SysMenu.sortList(list, sourcelist, "1");
        model.addAttribute("list", list);
		return "modules/sys/menuList";
	}

	@RequiresPermissions("sys:menu:view")
	@RequestMapping(value = "form")
	public String form(SysMenu menu, Model model) {
		if (menu.getParent()==null||menu.getParent().getId()==null){
			menu.setParent(new SysMenu("1"));
		}
		menu.setParent(systemService.getMenu(menu.getParent().getId()));
		model.addAttribute("menu", menu);
		return "modules/sys/menuForm";
	}
	
	@RequiresPermissions("sys:menu:edit")
	@RequestMapping(value = "save")
	public String save(SysMenu menu, Model model, RedirectAttributes redirectAttributes) {
		if(Global.isDemoMode()){
			addMessage(redirectAttributes, "演示模式，不允许操作！");
			return "redirect:"+Global.getAdminPath()+"/sys/menu/";
		}
		if (!beanValidator(model, menu)){
			return form(menu, model);
		}
		systemService.saveMenu(menu);
		addMessage(redirectAttributes, "保存菜单'" + menu.getName() + "'成功");
		return "redirect:"+Global.getAdminPath()+"/sys/menu/";
	}
	
	@RequiresPermissions("sys:menu:edit")
	@RequestMapping(value = "delete")
	public String delete(String id, RedirectAttributes redirectAttributes) {
		if(Global.isDemoMode()){
			addMessage(redirectAttributes, "演示模式，不允许操作！");
			return "redirect:"+Global.getAdminPath()+"/sys/menu/";
		}
		if (SysMenu.isRoot(id)){
			addMessage(redirectAttributes, "删除菜单失败, 不允许删除顶级菜单或编号为空");
		}else{
			systemService.deleteMenu(id);
			addMessage(redirectAttributes, "删除菜单成功");
		}
		return "redirect:"+Global.getAdminPath()+"/sys/menu/";
	}

	@RequiresUser
	@RequestMapping(value = "tree")
	public String tree() {
		return "modules/sys/menuTree";
	}
	
	@RequestMapping(value = "treeTo")
	public String treeTo(String parentId, Model model, RedirectAttributes redirectAttributes) {
		List<SysMenu> sysMenulist = SysUserUtils.getMenuList();
		List<SysMenu> toplist=new ArrayList<SysMenu>();//头部菜单
		List<SysMenu> toplistTo=new ArrayList<SysMenu>();//二级菜单菜单
		List<SysMenu> toplistTh=new ArrayList<SysMenu>();//三级菜单菜单
		ArrayList<Map<String, Object>> leftlist = new ArrayList<Map<String, Object>>();
		
		boolean iscollapsed=true;
		
		for(SysMenu sysMenu:sysMenulist){
			if(sysMenu.getParent()!=null && sysMenu.getParent().getId().equals("1") && sysMenu.getIsShow().equals("1")){
				toplist.add(sysMenu);
				Map<String, Object> firstmap = Maps.newHashMap();
				firstmap.put("id", sysMenu.getId());
//				if(fistb){
//					firstmap.put("collapsed", true);
//					firstmap.put("homePage", "code");//默认打开的主页
//				}
				ArrayList<Map<String, Object>> leftfirstlist = new ArrayList<Map<String, Object>>();
				
				for(SysMenu leftMenu:sysMenulist){//第二级
					
					if(leftMenu.getParent()!=null && leftMenu.getParent().getId().equals(sysMenu.getId()) && leftMenu.getIsShow().equals("1")){
						toplistTo.add(leftMenu);
						//						System.out.println(leftMenu.getName());
//						Map<String, Object> secondmap = Maps.newHashMap();
//						secondmap.put("text", leftMenu.getName());
						
						ArrayList<Map<String, Object>> leftsecondlist = new ArrayList<Map<String, Object>>();
						for(SysMenu leftsecondMenu:sysMenulist){//第三级
							if(leftsecondMenu.getParent()!=null && leftsecondMenu.getParent().getId().equals(leftMenu.getId()) && leftsecondMenu.getIsShow().equals("1")){
								toplistTh.add(leftsecondMenu);
								/*System.out.println("xxx"+leftsecondMenu.getName());
								Map<String, Object> shirdmap = Maps.newHashMap();
								shirdmap.put("id", leftsecondMenu.getId());
								shirdmap.put("text", leftsecondMenu.getName());
								shirdmap.put("href", request.getContextPath()+Global.getAdminPath()+leftsecondMenu.getHref());
								if(iscollapsed){
									shirdmap.put("collapsed", false);
									iscollapsed=false;
								}
								leftsecondlist.add(shirdmap);
								*/
							}
						}
//						secondmap.put("items", leftsecondlist);
//						leftfirstlist.add(secondmap);
					}
				}
				firstmap.put("menu", leftfirstlist);
				leftlist.add(firstmap);
				
			}
		}
		model.addAttribute("toplistTh", toplistTh);
		model.addAttribute("toplistTo", toplistTo);
		model.addAttribute("parentId", parentId);
		return "modules/sys/left";
	}
	
	
	/**
	 * 批量修改菜单排序
	 */
	@RequiresPermissions("sys:menu:edit")
	@RequestMapping(value = "updateSort")
	public String updateSort(String[] ids, Integer[] sorts, RedirectAttributes redirectAttributes) {
    	int len = ids.length;
    	SysMenu[] menus = new SysMenu[len];
    	for (int i = 0; i < len; i++) {
    		menus[i] = systemService.getMenu(ids[i]);
    		menus[i].setSort(sorts[i]);
    		systemService.saveMenu(menus[i]);
    	}
    	addMessage(redirectAttributes, "保存菜单排序成功!");
		return "redirect:"+Global.getAdminPath()+"/sys/menu/";
	}
	
	@RequiresUser
	@ResponseBody
	@RequestMapping(value = "treeData")
	public List<Map<String, Object>> treeData(@RequestParam(required=false) String extId, HttpServletResponse response) {
		response.setContentType("application/json; charset=UTF-8");
		List<Map<String, Object>> mapList = Lists.newArrayList();
		List<SysMenu> list = systemService.findAllMenu();
		for (int i=0; i<list.size(); i++){
			SysMenu e = list.get(i);
			if (extId == null || (extId!=null && !extId.equals(e.getId()) && e.getParentIds().indexOf(","+extId+",")==-1)){
				Map<String, Object> map = Maps.newHashMap();
				map.put("id", e.getId());
				map.put("pId", e.getParent()!=null?e.getParent().getId():0);
				map.put("name", e.getName());
				mapList.add(map);
			}
		}
		return mapList;
	}
}
