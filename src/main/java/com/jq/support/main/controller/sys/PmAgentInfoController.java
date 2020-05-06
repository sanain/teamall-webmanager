package com.jq.support.main.controller.sys;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.authz.annotation.RequiresUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.jq.support.common.config.Global;
import com.jq.support.common.persistence.Page;
import com.jq.support.common.utils.StringUtils;
import com.jq.support.common.web.BaseController;
import com.jq.support.model.agent.PmAgentInfo;
import com.jq.support.model.sys.SysUser;
import com.jq.support.model.user.EbUser;
import com.jq.support.service.agent.PmAgentInfoService;
import com.jq.support.service.merchandise.user.EbUserService;
import com.jq.support.service.sys.SystemService;
import com.jq.support.service.utils.ShareCodeUtil;
import com.jq.support.service.utils.SysUserUtils;
/**
 *  合伙人管理
 * 
 * @author
 * @version
 */
@Controller
@RequestMapping(value = "${adminPath}/sys/agent")
public class PmAgentInfoController extends BaseController {

	@Autowired
	private SystemService systemService;
	@Autowired
	private PmAgentInfoService agentService;
	@Autowired
	private EbUserService ebUserService;

	/**
	 * 导航到合伙人管理
	 * 
	 * @param user
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("sys:agent:view")
	@RequestMapping("agentlist")
	public String agentlist(PmAgentInfo user, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		Page<PmAgentInfo> page = agentService.findAgent(new Page<PmAgentInfo>(
				request, response), user);
		model.addAttribute("page", page);
		return "modules/sys/agentList";
	}
 

	// 显示合伙人列表
	@RequiresPermissions("sys:agent:view")
	@RequestMapping("list1")
	public String list1(PmAgentInfo agent, Model model) {
		agent.setAgentId(1);
		model.addAttribute("agent", agent);
		List<PmAgentInfo> list = Lists.newArrayList();
		List<PmAgentInfo> sourcelist = agentService.findAllType(agent
				.getAgentType());
		for (PmAgentInfo pmAgentInfo : sourcelist) {
			pmAgentInfo.setParent(agentService.get(pmAgentInfo.getParentId()));
		}

		PmAgentInfo.sortList(list, sourcelist, agent.getAgentId());
		model.addAttribute("list", list);
		return "modules/sys/agentList1";

	}

	/***
	 * 删除合伙人
	 * 
	 * @param id
	 *            agentId
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions("sys:agent:edit")
	@RequestMapping("delete1")
	public String delete1(Integer id, RedirectAttributes redirectAttributes) {
		if (PmAgentInfo.isRoot(id)) {
			addMessage(redirectAttributes, "删除机构失败, 不允许删除顶级机构或编号空");
		} else {
			agentService.delete(id);
			addMessage(redirectAttributes, "删除机构成功");
		}
		return "redirect:" + Global.getAdminPath() + "/sys/agent/list1";
	}

	/**
	 * 编辑合伙人或添加
	 * 
	 * @param office
	 * @param model
	 * @return
	 */
	@RequiresPermissions("sys:agent:view")
	@RequestMapping("form1")
	public String form1(PmAgentInfo agent, Model model) {
		if (agent.getFlag().equals("edit")) {
			agent = agentService.get(agent.getAgentId());
			agent.setParent(agentService.get(agent.getParentId()));
			agent.setFlag("edit");
			EbUser user=ebUserService.findByPmAgentId(String.valueOf(agent.getAgentId()));
			if(user!=null){
				model.addAttribute("agentUser", user);
			}
			model.addAttribute("agent", agent);
		} else {
			agent.setParent(agentService.get(agent.getAgentId()));
			agent.setFlag("add");
			model.addAttribute("agent", agent);
		}
		return "modules/sys/agentForm1";
	}

	/***
	 * 
	 * @param office
	 *            编辑和保存合伙人并绑定用户
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */

	@RequiresPermissions("sys:office:edit")
	@RequestMapping("save1")
	public String save1(PmAgentInfo agent, Model model,
			RedirectAttributes redirectAttributes, HttpServletRequest request) {
		String bindStatus = "";
		SysUser user = SysUserUtils.getUser();
		if (Global.isDemoMode()) {
			addMessage(redirectAttributes, "演示模式，不允许操作！");
			return "redirect:" + Global.getAdminPath()
					+ "/sys/office/list1?isAgent=1";
		}
		if (agent.getParent() != null && agent.getParent().getAgentId() != null) {
			PmAgentInfo pmAgentInfo = agentService.get(agent.getParent()
					.getAgentId());
			if (pmAgentInfo.getAgentType() == 3 && agent.getAgentType() == 1) {
				addMessage(redirectAttributes, "保存四级公司失败--不能保存第四级");
				return "redirect:" + Global.getAdminPath() + "/sys/agent/list1";
			}
		}

		if (agent.getAgentId() != null) {
			if (agent.getFlag().equals("edit")) { // 修改
				PmAgentInfo upagent=new PmAgentInfo();
				if(agent.getEbind()!=null){
					if(agent.getEbind()==1){//解绑用户
						 if (agent.getUser().getUserId()!=null) {
							EbUser ebindUser=new EbUser();
							ebindUser.setPmAgentInfoId(null);
							ebindUser.setUserId(agent.getUser().getUserId());
							int result = ebUserService.bindAgent(ebindUser);
							if(result>0){
								bindStatus="并解绑用户";
								upagent.setBindTime(null);
							}
						}
					}else{
						if (agent.getUser().getUserId() != null) {// 绑定用户
							EbUser userAgent = new EbUser();
							userAgent.setUserId(agent.getUser().getUserId());
							userAgent.setPmAgentInfoId(agent.getAgentId());
							int result2 = ebUserService.bindAgent(userAgent);
							if (result2 > 0) {
								bindStatus = "并绑定'"
										+ agent.getUser().getMobile() + "'";
								upagent.setBindTime(new Date());
							}
						}
					} 
				}
				
				upagent.setAgentId(agent.getAgentId());
				upagent.setAgentName(agent.getAgentName());
				int result = agentService.updateAgentName(upagent,user.getLoginName());
				if (result > 0) {
					addMessage(redirectAttributes, "修改"+bindStatus+"成功！");
					return "redirect:" + Global.getAdminPath()
							+ "/sys/agent/list1";
				} else {
					addMessage(redirectAttributes, "修改失败！");
					return "redirect:" + Global.getAdminPath()
							+ "/sys/agent/list1";
				}

			} else if (agent.getFlag().equals("add")) {// 添加
				String code = "00001";
				PmAgentInfo parent = agentService.get(agent.getAgentId());
				if (parent != null) {
					if (parent.getAgentType() != null) {
						code = parent.getAgentCode();
					}
					if (parent.getAgentType() == 0 && agent.getAgentType() != 1) {
						addMessage(redirectAttributes, "添加失败，此机构下级只能添加钻石合伙人！");
						return "redirect:" + Global.getAdminPath()
								+ "/sys/agent/list1";
					}
					if (parent.getAgentType() == 3
							&& agent.getAgentType() != null) {
						addMessage(redirectAttributes, "添加失败，不能保存第四级合伙人！");
						return "redirect:" + Global.getAdminPath()
								+ "/sys/agent/list1";
					}
					if (parent.getAgentType() == 2 && agent.getAgentType() == 1) {
						addMessage(redirectAttributes, "添加失败，不能越级添加合伙人！");
						return "redirect:" + Global.getAdminPath()
								+ "/sys/agent/list1";
					}
					if ((parent.getAgentType()+"").equals(agent.getAgentType()+"")) {
						addMessage(redirectAttributes, "添加失败，不能添加同级合伙人！");
						return "redirect:" + Global.getAdminPath()
								+ "/sys/agent/list1";
					}
					if (parent.getAgentType() == 1 && agent.getAgentType() == 3) {
						addMessage(redirectAttributes, "添加失败，不能越级添加合伙人！");
						return "redirect:" + Global.getAdminPath()
								+ "/sys/agent/list1";
					} else {
						PmAgentInfo pmAgentInfoc = new PmAgentInfo();
						int defaultLength = 5;// 默认编码长度
						String nowNum = "";
						pmAgentInfoc.setParentId(agent.getAgentId()); // 上级代理
						List<PmAgentInfo> pmAgentInfos = agentService
								.findAllTypes(pmAgentInfoc); // 上级代理的子代理

						if (pmAgentInfos != null && pmAgentInfos.size() > 0) {
							code = pmAgentInfos.get(0).getAgentCode();
						} else {
							code = parent.getAgentCode(); // 没有子代理
						}
						if (agent.getAgentType() == 1) {// 钻石合伙人
							if (!StringUtils.isEmpty(code)) {
								nowNum = Integer.parseInt(code.substring(0, 5))
										+ 1 + "";
								if (nowNum.length() < defaultLength) {
									int nowNumLength = nowNum.toString()
											.length();
									for (int i = 0; i < defaultLength
											- nowNumLength; i++) {
										nowNum = "0" + nowNum;
									}
								}
								System.out.println(nowNum);
								pmAgentInfoc.setAgentCode(nowNum);
								pmAgentInfoc.setAgentType(agent.getAgentType());
								pmAgentInfoc.setCreateTime(new Date());
								pmAgentInfoc.setCreateUser(user.getLoginName());
								pmAgentInfoc.setAgentName(agent.getAgentName());
								pmAgentInfoc.setParentIds(String.valueOf(agent.getParentId()));
								pmAgentInfoc.setDelFlag("0");
								agentService.save(pmAgentInfoc);

							}

						}
						if (agent.getAgentType() == 2) {// 金牌合伙人
							if (!StringUtils.isEmpty(code)) {
								if (code.length() > 5) {
									nowNum = Integer.parseInt(code.substring(6,
											10)) + 1 + "";
								} else {
									nowNum = "1";
								}
								System.out.println(nowNum);
								if (nowNum.length() < defaultLength) {
									int nowNumLength = nowNum.toString()
											.length();
									for (int i = 0; i < defaultLength
											- nowNumLength; i++) {
										nowNum = "0" + nowNum;
									}
								}
								System.out.println(code.substring(0, 5)
										+ nowNum);
								pmAgentInfoc.setAgentCode(code.substring(0, 5)
										+ nowNum);
								pmAgentInfoc.setAgentType(agent.getAgentType());
								pmAgentInfoc.setCreateTime(new Date());
								pmAgentInfoc.setCreateUser(user.getLoginName());
								pmAgentInfoc.setAgentName(agent.getAgentName());
								pmAgentInfoc.setParentIds(String.valueOf(agent.getParentId()));
								pmAgentInfoc.setDelFlag("0");
								agentService.save(pmAgentInfoc);
							}
						}
						if (agent.getAgentType() == 3) {// 银牌合伙人
							if (!StringUtils.isEmpty(code)) {
								if (code.length() > 10) {
									nowNum = Integer.parseInt(code.substring(
											10, 15)) + 1 + "";
								} else {
									nowNum = "1";
								}
								if (nowNum.length() < defaultLength) {
									int nowNumLength = nowNum.toString()
											.length();
									for (int i = 0; i < defaultLength
											- nowNumLength; i++) {
										nowNum = "0" + nowNum;
									}
								}
								String toSerialCode = ShareCodeUtil
										.toSerialCode(1);
								pmAgentInfoc.setAgentInvitationCode("AG_"
										+ toSerialCode);
								pmAgentInfoc.setAgentCode(code.substring(0, 10)
										+ nowNum);
								pmAgentInfoc.setAgentType(agent.getAgentType());
								pmAgentInfoc.setCreateTime(new Date());
								pmAgentInfoc.setCreateUser(user.getLoginName());
								pmAgentInfoc.setAgentName(agent.getAgentName());
								pmAgentInfoc.setParentIds(String.valueOf(agent.getParentId()));
								pmAgentInfoc.setDelFlag("0");
								agentService.save(pmAgentInfoc);
							}
						}
						if (agent.getUser().getUserId() != null) {// 绑定合伙人
							EbUser userAgent = new EbUser();
							userAgent.setUserId(agent.getUser().getUserId());
							userAgent.setPmAgentInfoId(pmAgentInfoc
									.getAgentId());
							userAgent.setIsAgent(1);
							int result = ebUserService.bindAgent(userAgent);
							if (result > 0) {
								bindStatus = "并绑定'"
										+ agent.getUser().getMobile() + "'";
								pmAgentInfoc.setBindTime(new Date());
							}
						}
					}

				}
			}
		}
		addMessage(redirectAttributes, "保存合伙人'" + agent.getAgentName() + "'"
				+ bindStatus + "'成功");
		return "redirect:" + Global.getAdminPath() + "/sys/agent/list1";
	}

	@RequiresPermissions("sys:agent:view")
	@RequestMapping("form")
	public String form(PmAgentInfo agent, Model model) {

		if (agent.getParent() == null || agent.getParent().getAgentId() == null) {
			PmAgentInfo current = agentService.get(agent.getAgentId());
			agent.setParent(agentService.get(current.getParentId()));
		}
		agent.setParent(agentService.get(agent.getParent().getParentId()));
		model.addAttribute("agent", agent);
		return "modules/sys/officeForm";
	}

	/***
	 * 
	 * @param response
	 *            显示树级合伙人
	 * @param extId
	 * @param agentType
	 * @return
	 */
	@RequiresUser
	@ResponseBody
	@RequestMapping("treeData")
	public List<Map<String, Object>> treeData(HttpServletResponse response,
			@RequestParam(required = false) Integer extId,
			@RequestParam(required = false) Integer agentType) {
		response.setContentType("application/json; charset=UTF-8");
		List<Map<String, Object>> mapList = Lists.newArrayList();
		List<PmAgentInfo> list = agentService.findAllType(agentType);
		for (int i = 0; i < list.size(); i++) {
			PmAgentInfo e = list.get(i);
			Map<String, Object> map = Maps.newHashMap();
			map.put("id", e.getAgentId());
			map.put("pId", e.getParentId() != null ? e.getParentId() : 0);
			map.put("name", e.getAgentName());
			mapList.add(map);
		}
		return mapList;
	}
	/***
	 * 
	 * @param response
	 *            显示所有合伙人非树级
	 * @param extId
	 * @param agentType
	 * @return
	 */
	@RequiresUser
	@ResponseBody
	@RequestMapping("treeData1")
	public List<Map<String, Object>> treeData1(HttpServletResponse response,
			@RequestParam(required = false) Integer extId,
			@RequestParam(required = false) Integer agentType) {
		response.setContentType("application/json; charset=UTF-8");
		List<Map<String, Object>> mapList = Lists.newArrayList();
		List<PmAgentInfo> list = agentService.findAllType(agentType);
		for (int i = 0; i < list.size(); i++) {
			PmAgentInfo e = list.get(i);
			Map<String, Object> map = Maps.newHashMap();
			map.put("id", e.getAgentId());
//			map.put("pId", e.getParentId() != null ? e.getParentId() : 0);
			map.put("name", e.getAgentName());
			mapList.add(map);
		}
		return mapList;
	}
	/****
	 * 绑定合伙人，显示用户列表
	 * 
	 * @param response
	 * @return
	 */
	@RequiresUser
	@ResponseBody
	@RequestMapping("treeUserData")
	public List<Map<String, Object>> treeUserData(HttpServletResponse response) {
		response.setContentType("application/json; charset=UTF-8");
		List<Map<String, Object>> mapList = Lists.newArrayList();
		List<EbUser> list = ebUserService.findAll();
		for (int i = 0; i < list.size(); i++) {
			EbUser e = list.get(i);
			Map<String, Object> map = Maps.newHashMap();
			map.put("id", e.getUserId());
			map.put("name", e.getMobile());
			mapList.add(map);

		}
		return mapList;
	}
	
	
 
}
