package com.jq.support.main.controller.sys;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
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

import com.alipay.util.httpClient.HttpRequest;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.jq.support.common.config.Global;
import com.jq.support.common.security.Md5Encrypt;
import com.jq.support.common.utils.StringUtils;
import com.jq.support.common.web.BaseController;
import com.jq.support.model.sys.SysOffice;
import com.jq.support.model.sys.SysUser;
import com.jq.support.service.sys.SysOfficeService;
import com.jq.support.service.utils.ShareCodeUtil;
import com.jq.support.service.utils.SysUserUtils;

/**
 * 机构Controller
 * @author 
 * @version 
 */
@Controller
@RequestMapping(value = "${adminPath}/sys/office")
public class SysOfficeController extends BaseController {

	@Autowired
	private SysOfficeService officeService;
	
	@ModelAttribute
	public SysOffice get(@RequestParam(required = false) String id) {
		if (StringUtils.isNotBlank(id)) {
			return officeService.get(id);
		} else {
			return new SysOffice();
		}
	}

	@RequiresPermissions("sys:office:view")
	@RequestMapping({"list", ""})
	public String list(SysOffice office, Model model) {
//		User user = UserUtils.getUser();
//		if(user.isAdmin()){
			office.setId("1");
//		}else{
//			office.setId(user.getOffice().getId());
//		}
		model.addAttribute("office", office);
		List<SysOffice> list = Lists.newArrayList();
		List<SysOffice> sourcelist = officeService.findAllType(office.getIsAgent(),office.getType());
		SysOffice.sortList(list, sourcelist, office.getId());
        model.addAttribute("list", list);
		return "modules/sys/officeList";
	}
	@RequiresPermissions("sys:office:view")
	@RequestMapping("list1")
	public String list1(SysOffice office, Model model) {
		office.setId("1");
		model.addAttribute("office", office);
		List<SysOffice> list = Lists.newArrayList();
		List<SysOffice> sourcelist = officeService.findAllType(office.getIsAgent(),office.getType());
		SysOffice.sortList(list, sourcelist, office.getId());
        model.addAttribute("list", list);
		return "modules/sys/officeList1";
	}
	@RequiresPermissions("sys:office:view")
	@RequestMapping("form1")
	public String form1(SysOffice office, Model model) {
		SysUser user = SysUserUtils.getUser();
		if (office.getParent() == null || office.getParent().getId() == null) {
			office.setParent(user.getOffice());
		}else{
			office.setParent(officeService.get(office.getParent().getId()));
		}
		if (office.getArea() == null) {
			office.setArea(office.getParent().getArea());
		}
		model.addAttribute("office", office);
		return "modules/sys/officeForm1";
	}
	@RequiresPermissions("sys:office:view")
	@RequestMapping("form")
	public String form(SysOffice office, Model model) {
		SysUser user = SysUserUtils.getUser();
		if (office.getParent() == null || office.getParent().getId() == null) {
			office.setParent(user.getOffice());
		}
		office.setParent(officeService.get(office.getParent().getId()));
		if (office.getArea() == null) {
			office.setArea(office.getParent().getArea());
		}
		model.addAttribute("office", office);
		return "modules/sys/officeForm";
	}
	@RequiresPermissions("sys:office:view")
	@RequestMapping("form2")
	public String form2(SysOffice office, Model model) {
		SysUser user = SysUserUtils.getUser();
		if (office.getParent() == null || office.getParent().getId() == null) {
			office.setParent(user.getOffice());
		}
		office.setParent(officeService.get(office.getParent().getId()));
		if (office.getArea() == null) {
			office.setArea(office.getParent().getArea());
		}
		model.addAttribute("office", office);
		return "modules/sys/officeForm2";
	}
	
	@RequiresPermissions("sys:office:edit")
	@RequestMapping("save")
	public String save(SysOffice office, Model model, RedirectAttributes redirectAttributes) {
		if (Global.isDemoMode()) {
			addMessage(redirectAttributes, "演示模式，不允许操作！");
			return "redirect:" + Global.getAdminPath() + "/sys/office/";
		}

		if (!beanValidator(model, office)) {
			return form(office, model);
		}
		Integer Grade=0;
		  SysOffice sysOffice=	officeService.get(office.getParent().getId());
		   if(sysOffice!=null){
			   if( StringUtils.isNotBlank(sysOffice.getGrade())){
					 Grade=Integer.parseInt(sysOffice.getGrade());
				} 
		   }
		office.setGrade((Grade+1)+"");
		office.setIsAgent("0");
		officeService.save(office);
		addMessage(redirectAttributes, "保存机构'" + office.getName() + "'成功");
		return "redirect:" + Global.getAdminPath() + "/sys/office/list?isAgent=0";
	}
	@RequiresPermissions("sys:office:edit")
	@RequestMapping("save2")
	public String save2(SysOffice office, Model model, RedirectAttributes redirectAttributes,HttpServletRequest request) {
		if (Global.isDemoMode()) {
			addMessage(redirectAttributes, "演示模式，不允许操作！");
			return "redirect:" + Global.getAdminPath() + "/sys/office/";
		}
		if (!beanValidator(model, office)) {
			return form(office, model);
		}
		String id=request.getParameter("id");
		String type=request.getParameter("type");
		String yfid=request.getParameter("yfid");
		String fatype=request.getParameter("fatype");
		String newModel=request.getParameter("newModel");
		String nameModel=request.getParameter("nameModel");
		String password=request.getParameter("password");
		String inToNu=request.getParameter("inToNu");
        if(newModel.equals("1")){
        	nameModel="";
        	password="";
		}else{
			password=Md5Encrypt.getMD5Str(password).toLowerCase();
		}
		if(StringUtils.isBlank(fatype)){
			fatype="0";
		}
		officeService.findAllType3("'"+id+"'", type, "'"+yfid+"'", fatype, "'"+nameModel+"'","'"+password+"'", inToNu);
		List<SysOffice> list = officeService.findAllType2("1","1","3");
		for (SysOffice sysOffice : list) {
			if(StringUtils.isBlank(sysOffice.getAgentInvitationCode())){
				SysOffice sysOffice2=new SysOffice();
				sysOffice2.setParent(office.getParent());
				sysOffice2.setType(office.getType());
				String toSerialCode=ShareCodeUtil.toSerialCode(1);
				sysOffice2.setAgentInvitationCode("AG_"+toSerialCode);
				sysOffice2.setGrade("4");
				List<SysOffice> sysOffices2= officeService.findAllTypes(sysOffice2);
				while(sysOffices2!=null&&sysOffices2.size()>0) {
					toSerialCode=ShareCodeUtil.toSerialCode(1);
					sysOffice2.setAgentInvitationCode("AG_"+toSerialCode);
					sysOffices2= officeService.findAllTypes(sysOffice2);
					//循环内容
				}
				sysOffice.setAgentInvitationCode("AG_"+toSerialCode);
				officeService.save(sysOffice);
			}
		}
		addMessage(redirectAttributes, "成功'" + office.getName() + "'成功");
		return "redirect:" + Global.getAdminPath() + "/sys/office/list1?isAgent=1";
	}
	@RequiresPermissions("sys:office:edit")
	@RequestMapping("save1")
	public String save1(SysOffice office, Model model, RedirectAttributes redirectAttributes) {
		if (Global.isDemoMode()) {
			addMessage(redirectAttributes, "演示模式，不允许操作！");
			return "redirect:" + Global.getAdminPath() + "/sys/office/list1?isAgent=1";
		}
		if(office.getParent()!=null&&StringUtils.isNotBlank(office.getParent().getId() )){
			 SysOffice sysOffice=	officeService.get(office.getParent().getId());
			if(sysOffice.getGrade().equals("3")&&office.getType().equals("1")){
				addMessage(redirectAttributes, "保存四级公司!失败--不能保存第四级");
				return "redirect:" + Global.getAdminPath() + "/sys/office/list1?isAgent=1";
			}
		}
		if(StringUtils.isBlank(office.getId())){
			if(StringUtils.isNotBlank(office.getType())){
				if(office.getType().equals("2")){
					SysOffice sysOffice2=new SysOffice();
					sysOffice2.setParent(office.getParent());
					sysOffice2.setType("2");
					sysOffice2.setDelFlag("0");
					if(!office.getParent().getId().equals("1")){
						List<SysOffice> sysOffices= officeService.findAllTypes(sysOffice2);
						if(sysOffices!=null&&sysOffices.size()>0){
							addMessage(redirectAttributes, "失败！一个公司不能加第二个部门");
							return "redirect:" + Global.getAdminPath() + "/sys/office/list1?isAgent=1";
						}
					}
				}
			}
			
			
		}
		if (!beanValidator(model, office)) {
			return form(office, model);
		}
		String code="00001";
		Integer Grade=0;
	    SysOffice sysOffice=	officeService.get(office.getParent().getId());
	   if(sysOffice!=null){
		   if( StringUtils.isNotBlank(sysOffice.getGrade())){
				 Grade=Integer.parseInt(sysOffice.getGrade());
				 code=sysOffice.getCode();
			} 
	   }
		office.setGrade((Grade+1)+"");
		office.setIsAgent("1");
		SysOffice sysOffic=new SysOffice();
		sysOffic.setGrade((Grade+1)+"");
		sysOffic.setParent(office.getParent());
		sysOffic.setType(office.getType());
		if(office.getType().equals("1")){
			int  defaultLength=5;//默认编码长度
			List<SysOffice> sysOffices= officeService.findAllTypes(sysOffic);
			if(sysOffices!=null&&sysOffices.size()>0){
				code=sysOffices.get(0).getCode();
				if(!StringUtils.isEmpty(code)){
					String nowNum="";
					if(office.getGrade().equals("1")){
						System.out.println(code.substring(0,5));
						nowNum=Integer.parseInt(code.substring(0,5))+1+"";
					}
					if(office.getGrade().equals("2")){
						System.out.println(code.substring(6,10));
						nowNum=Integer.parseInt(code.substring(6,10))+1+"";
					}
					if(office.getGrade().equals("3")){
						System.out.println(code.substring(10,15));
						nowNum=Integer.parseInt(code.substring(10,15))+1+"";
					}
					if(office.getGrade().equals("4")){
						System.out.println(code.substring(15,20));
						nowNum=Integer.parseInt(code.substring(15,20))+1+"";
					}
					if(nowNum.length()<defaultLength){
						int nowNumLength=nowNum.toString().length();
						for(int i=0;i<defaultLength-nowNumLength;i++){
							nowNum="0"+nowNum;
						}
					}
					if(office.getGrade().equals("1")){
						code=nowNum;
					}
					if(office.getGrade().equals("2")){
						code=code.substring(0,5)+nowNum;
					}
					if(office.getGrade().equals("3")){
						code=code.substring(0,10)+nowNum;
						if(StringUtils.isNotBlank(office.getId())){
							if(StringUtils.isBlank(office.getAgentInvitationCode())){
								SysOffice sysOffice2=new SysOffice();
								sysOffice2.setParent(office.getParent());
								sysOffice2.setType(office.getType());
								String toSerialCode=ShareCodeUtil.toSerialCode(1);
								sysOffice2.setAgentInvitationCode("AG_"+toSerialCode);
								sysOffice2.setGrade("4");
								List<SysOffice> sysOffices2= officeService.findAllTypes(sysOffice2);
								while(sysOffices2!=null&&sysOffices2.size()>0) {
									toSerialCode=ShareCodeUtil.toSerialCode(1);
									sysOffice2.setAgentInvitationCode("AG_"+toSerialCode);
									sysOffices2= officeService.findAllTypes(sysOffice2);
									//循环内容
								}
								office.setAgentInvitationCode("AG_"+toSerialCode);
							}
						}else{
							SysOffice sysOffice2=new SysOffice();
							sysOffice2.setParent(office.getParent());
							sysOffice2.setType(office.getType());
							String toSerialCode=ShareCodeUtil.toSerialCode(1);
							sysOffice2.setAgentInvitationCode("AG_"+toSerialCode);
							sysOffice2.setGrade("4");
							List<SysOffice> sysOffices2= officeService.findAllTypes(sysOffice2);
							while(sysOffices2!=null&&sysOffices2.size()>0) {
								toSerialCode=ShareCodeUtil.toSerialCode(1);
								sysOffice2.setAgentInvitationCode("AG_"+toSerialCode);
								sysOffices2= officeService.findAllTypes(sysOffice2);
								//循环内容
							}
							office.setAgentInvitationCode("AG_"+toSerialCode);
						}
					}
					if(sysOffices.get(0).getGrade().equals("4")){
						code=code.substring(0,15)+nowNum;
					}
					
					office.setCode(code);
				}
			}else{
				office.setCode(code+"00001");
				if(office.getGrade().equals("3")){
					if(StringUtils.isNotBlank(office.getId())){
						if(StringUtils.isBlank(office.getAgentInvitationCode())){
							SysOffice sysOffice2=new SysOffice();
							sysOffice2.setParent(office.getParent());
							sysOffice2.setType(office.getType());
							String toSerialCode=ShareCodeUtil.toSerialCode(1);
							sysOffice2.setAgentInvitationCode("AG_"+toSerialCode);
							sysOffice2.setGrade("4");
							List<SysOffice> sysOffices2= officeService.findAllTypes(sysOffice2);
							while(sysOffices2!=null&&sysOffices2.size()>0) {
								toSerialCode=ShareCodeUtil.toSerialCode(1);
								sysOffice2.setAgentInvitationCode("AG_"+toSerialCode);
								sysOffices2= officeService.findAllTypes(sysOffice2);
								//循环内容
							}
							office.setAgentInvitationCode("AG_"+toSerialCode);
						}
					}else{
						SysOffice sysOffice2=new SysOffice();
						sysOffice2.setParent(office.getParent());
						sysOffice2.setType(office.getType());
						String toSerialCode=ShareCodeUtil.toSerialCode(1);
						sysOffice2.setAgentInvitationCode("AG_"+toSerialCode);
						sysOffice2.setGrade("4");
						List<SysOffice> sysOffices2= officeService.findAllTypes(sysOffice2);
						while(sysOffices2!=null&&sysOffices2.size()>0) {
							toSerialCode=ShareCodeUtil.toSerialCode(1);
							sysOffice2.setAgentInvitationCode("AG_"+toSerialCode);
							sysOffices2= officeService.findAllTypes(sysOffice2);
							//循环内容
						}
						office.setAgentInvitationCode("AG_"+toSerialCode);
					}
				}
			}
		}else{
			
		}
		officeService.save(office);
		addMessage(redirectAttributes, "保存机构'" + office.getName() + "'成功");
		return "redirect:" + Global.getAdminPath() + "/sys/office/list1?isAgent=1";
	}
	
	@RequiresPermissions("sys:office:edit")
	@RequestMapping("delete")
	public String delete(String id, RedirectAttributes redirectAttributes) {
		if (SysOffice.isRoot(id)) {
			addMessage(redirectAttributes, "删除机构失败, 不允许删除顶级机构或编号空");
		} else {
			officeService.delete(id);
			addMessage(redirectAttributes, "删除机构成功");
		}
		return "redirect:" + Global.getAdminPath() + "/sys/office/list?isAgent=0";
	}
	@RequiresPermissions("sys:office:edit")
	@RequestMapping("delete1")
	public String delete1(String id, RedirectAttributes redirectAttributes) {
		if (SysOffice.isRoot(id)) {
			addMessage(redirectAttributes, "删除机构失败, 不允许删除顶级机构或编号空");
		} else {
			officeService.delete(id);
			addMessage(redirectAttributes, "删除机构成功");
		}
		return "redirect:" + Global.getAdminPath() + "/sys/office/list1?isAgent=1";
	}

	@RequiresUser
	@ResponseBody
	@RequestMapping("treeData")
	public List<Map<String, Object>> treeData(HttpServletResponse response,
			@RequestParam(required = false) Long extId,
			@RequestParam(required = false) Long type,
			@RequestParam(required = false) Long grade,
			@RequestParam(required = false) Long isAgent,
			@RequestParam(required = false) String companyId
			) {
		
		response.setContentType("application/json; charset=UTF-8");
		List<Map<String, Object>> mapList = Lists.newArrayList();
		
//		User user = UserUtils.getUser();
		List<SysOffice> list = officeService.findAllType(isAgent==null?null:isAgent.toString(),type==null?null:type.toString());
		for (int i=0; i<list.size(); i++){
			SysOffice e = list.get(i);
			
			if ((extId == null || (extId!=null && !extId.equals(e.getId()) && e.getParentIds().indexOf(","+extId+",")==-1))
					&& (type == null || (type != null && Integer.parseInt(e.getType()) <= type.intValue()))
					&& (grade == null || (grade != null && Integer.parseInt(e.getGrade()) <= grade.intValue()))
					&& (isAgent == null || (isAgent != null && Integer.parseInt(e.getIsAgent()) == isAgent.intValue()))
					&& (StringUtils.isBlank(companyId) || (StringUtils.isNotBlank(companyId) && e.getParent().getId().equals(companyId)))
				){
				
				Map<String, Object> map = Maps.newHashMap();
				map.put("id", e.getId());
//				map.put("pId", !user.isAdmin() && e.getId().equals(user.getOffice().getId())?0:e.getParent()!=null?e.getParent().getId():0);
				map.put("pId", e.getParent() != null ? e.getParent().getId() : 0);
				map.put("name", e.getName());
				mapList.add(map);
			}
		}
		return mapList;
	}

	@RequiresUser
	@ResponseBody
	@RequestMapping(value = "checkName")
	public String checkName(String oldName, String name) {
		if(name!=null && !"".equals(name) && oldName!=null && name.equals(oldName)) {
			return "true";
		} else if(name!=null && !"".equals(name) && officeService.findOfficeByName(name)==0) {
			return "true";
		}
		return "false";
	}

	
	@ResponseBody
	@RequestMapping("treeData2")
	public List<Map<String, Object>> treeData2(HttpServletResponse response ,HttpServletRequest request) {
		String isAgent=request.getParameter("isAgent");
		String type=request.getParameter("type");
		String grade=request.getParameter("grade");
		List<Map<String, Object>> mapList = Lists.newArrayList();
		List<SysOffice> list = officeService.findAllType2(isAgent,type,grade);
		for (SysOffice sysOffice : list) {
			Map<String, Object> map =new HashMap<String, Object>();
			map.put("id", sysOffice.getId());
			map.put("name", sysOffice.getName());
			mapList.add(map);
		}
		return mapList;
	}
	
	@RequiresUser
	@ResponseBody
	@RequestMapping("treeData3")
	public List<Map<String, Object>> treeData3(HttpServletResponse response,
			@RequestParam(required = false) Long extId,
			@RequestParam(required = false) Long type,
			@RequestParam(required = false) Long grade,
			@RequestParam(required = false) Long isAgent
			) {
		
		response.setContentType("application/json; charset=UTF-8");
		List<Map<String, Object>> mapList = Lists.newArrayList();
		
//		User user = UserUtils.getUser();
		List<SysOffice> list = officeService.findAllType(isAgent==null?null:isAgent.toString(),type==null?null:type.toString());
		for (int i=0; i<list.size(); i++){
			SysOffice e = list.get(i);
			
			if ((extId == null || (extId!=null && !extId.equals(e.getId()) && e.getParentIds().indexOf(","+extId+",")==-1))
					&& (type == null || (type != null && Integer.parseInt(e.getType()) <= type.intValue()))
					&& (grade == null || (grade != null && Integer.parseInt(e.getGrade()) <= grade.intValue()))
					&& (isAgent == null || (isAgent != null && Integer.parseInt(e.getIsAgent()) == isAgent.intValue()))
					
				){
				
				Map<String, Object> map = Maps.newHashMap();
				map.put("id", e.getId());
//				map.put("pId", !user.isAdmin() && e.getId().equals(user.getOffice().getId())?0:e.getParent()!=null?e.getParent().getId():0);
				map.put("pId", e.getParent() != null ? e.getParent().getId() : 0);
				map.put("name", e.getName());
				mapList.add(map);
			}
		}
		return mapList;
	}
	
	
	
}

