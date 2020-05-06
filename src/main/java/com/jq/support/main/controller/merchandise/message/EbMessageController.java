package com.jq.support.main.controller.merchandise.message;

import java.io.File;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jq.support.model.product.PmShopInfo;
import com.jq.support.service.merchandise.shop.PmShopInfoService;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
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
import com.jq.support.common.persistence.Page;
import com.jq.support.common.utils.DateUtils;
import com.jq.support.common.utils.FileUtils;
import com.jq.support.common.web.BaseController;
import com.jq.support.model.agent.PmAgentInfo;
import com.jq.support.model.message.EbMessage;
import com.jq.support.model.message.EbMessageUser;
import com.jq.support.model.sys.SysDict;
import com.jq.support.model.sys.SysOffice;
import com.jq.support.model.sys.SysUser;
import com.jq.support.model.user.EbUser;
import com.jq.support.service.agent.PmAgentInfoService;
import com.jq.support.service.merchandise.user.EbUserService;
import com.jq.support.service.message.EbMessageService;
import com.jq.support.service.message.EbMessageUserService;
import com.jq.support.service.sys.SysDictService;
import com.jq.support.service.sys.SysOfficeService;
import com.jq.support.service.utils.StringUtil;
import com.jq.support.service.utils.SysUserUtils;

/**
 * 系统消息 Controller
 *
 */
@Controller
@RequestMapping(value = "${adminPath}/message")
public class EbMessageController  extends BaseController{
	@Autowired
	private SysDictService sysDictService;
	@Autowired
	private EbMessageService messageInfoService;
	@Autowired
	private EbUserService userService;
	@Autowired
	private EbMessageUserService messageInfoUserService;
	@Autowired
	private SysOfficeService officeService;
	@Autowired
	private EbUserService ebUserService;
	@Autowired
	private PmShopInfoService pmShopInfoService;

	private static String domainurl = Global.getConfig("domainurl");
	private static String innerImgPartPath = "src=\"/uploads/images/";
	private static String innerImgFullPath = "src=\"" + domainurl + "/uploads/images/";
	@Autowired
	private PmAgentInfoService agentService;

	@ModelAttribute
	public EbMessage get(@RequestParam(required=false) String id) {
		if (StringUtils.isNotBlank(id)){
			return messageInfoService.getEbMessageById(Integer.valueOf(id));
		}else{
			return new EbMessage();
		}
	}


	/**
	 * 消息列表
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping({"list", ""})
	public String messageInfoList(EbMessage messageInfo, HttpServletRequest request,HttpServletResponse response, Model model){
		Page<EbMessage> page = messageInfoService.findMessageInfoList(new Page<EbMessage>(request, response), messageInfo);
		model.addAttribute("page", page);
		model.addAttribute("messageInfo", messageInfo);
		return "modules/message/messageInfoList";
	}

	@RequestMapping({"notReadList"})
	public String notReadList(HttpServletRequest request,HttpServletResponse response, Model model){
		EbUser user = ebUserService.getShop("1");
		EbMessage message = new EbMessage();
		message.setIsRead(0);
		message.setSendUserIds(user.getUserId().toString());
		Page<EbMessage> page = messageInfoService.findMessageInfoListNotRead(new Page<EbMessage>(request, response), message);
		model.addAttribute("page", page);
		return "modules/message/messageList";
	}


	@RequiresPermissions("message:info:view")
	@RequestMapping(value = "form")
	public String form(EbMessage messageInfo, HttpServletRequest request, Model model) {
		// 创建广告图片存放目录
		createPicFold(request);
		return formSearch(messageInfo, model);
	}


	@ResponseBody
	@RequestMapping(value = "userInfoTreeData")
	public List<Map<String, Object>> userInfoTreeData(String usertype,String extId,HttpServletResponse response){
		response.setContentType("application/json; charset=UTF-8");
		List<Map<String, Object>> mapList = Lists.newArrayList();
		List<EbUser> list=null;
		//用户类型：1、所有用户；
		if (StringUtil.isNotBlank(usertype)) {
			if (usertype.equals("1")) {
				list = userService.findAllGeneralUser();
			}
		}else {
			list = userService.findAllGeneralUser();
		}


		for (int i = 0; i < list.size(); i++) {
			EbUser e = list.get(i);
			if (extId == null || (extId != null && !extId.equals(e.getUserId()))) {
				Map<String, Object> map = Maps.newHashMap();
				map.put("id", e.getUserId());
				map.put("name", e.getUsername()+"("+e.getMobile()+")");
				mapList.add(map);
			}
		}
		return mapList;
	}


	/**
	 * 获得所有门店
	 * @param shoptype
	 * @param extId
	 * @param response
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "shopInfoTreeData")
	public List<Map<String, Object>> shopInfoTreeData(String shoptype,String extId,HttpServletResponse response){
		response.setContentType("application/json; charset=UTF-8");
		List<Map<String, Object>> mapList = Lists.newArrayList();
		List<PmShopInfo> list=null;
		//用户类型：1、所有用户；
		if (StringUtil.isNotBlank(shoptype)) {
			if (shoptype.equals("1")) {
				list = pmShopInfoService.getAllShop();
			}
		}else {
			list = pmShopInfoService.getAllShop();
		}


		for (int i = 0; i < list.size(); i++) {
			PmShopInfo p = list.get(i);
			if (extId == null || (extId != null && !extId.equals(p.getId()))) {
				Map<String, Object> map = Maps.newHashMap();
				map.put("id", p.getId());
				map.put("name",p.getShopName()+"("+p.getShopCode()+")");
				mapList.add(map);
			}
		}
		return mapList;
	}


	/**
	 * 保存
	 */
	@RequiresPermissions("message:info:edit")
	@RequestMapping(value = "save")
	public String save(EbMessage messageInfo,String sendUserIds, Model model,HttpServletRequest request, RedirectAttributes redirectAttributes) {
		SysUser user=SysUserUtils.getUser();
		if (Global.isDemoMode()) {
			addMessage(redirectAttributes, "演示模式，不允许操作！");
			return "redirect:" + Global.getAdminPath() + "/basic/product";
		}
		if (messageInfo.getId()!=null) {

			messageInfo.setModifyTime(new Date());
			messageInfo.setModifyUser(user.getId());
		}else {
			messageInfo.setCreateUser(user.getId());
			messageInfo.setCreateTime(new Date());
		}
		messageInfo.setSendStatus(messageInfo.getIsTimingSend()==0?1:0);
		messageInfoService.saveflush(messageInfo);
		if (messageInfo.getIsTimingSend()==0) {
			sendMsgToUser(sendUserIds,messageInfo.getId()+"",messageInfo.getReceiverType()+"");//发消息
		}
		return "redirect:" + Global.getAdminPath() + "/message/list";
	}


	/**
	 * 删除
	 */
	@RequiresPermissions("message:info:edit")
	@RequestMapping(value = "deleteService")
	public String deleteProject(String ids[],String spackId,RedirectAttributes redirectAttributes, HttpServletRequest request) {
		for (int i = 0; i < ids.length; i++) {
			EbMessage messageInfo=messageInfoService.getEbMessageById(Integer.valueOf(ids[i]));
			if(messageInfo!=null){
				messageInfoService.delete(messageInfo);
			}
		}
		addMessage(redirectAttributes, "删除成功");
		return "redirect:" + Global.getAdminPath() + "/message/list";
	}






	/**
	 * 创建商品详情图片存放目录
	 */
	private void createPicFold(HttpServletRequest request) {
		String root = request.getSession().getServletContext().getRealPath("/");
		StringBuffer folder = new StringBuffer(root);
		folder.append("uploads");
		folder.append(File.separator);
		// ===========集群文件处理 start===============
		String wfsName = Global.getConfig("wfsName");
		if (!StringUtil.isEmpty(wfsName)) {
			folder.append(wfsName);
			folder.append(File.separator);
		}
		// ===========集群文件字段处理 end===============
		folder.append("000000" );
		folder.append(File.separator);
		folder.append("images" );
		folder.append(File.separator);
		folder.append("message");
		folder.append(File.separator);
		folder.append("messageIcon");
		folder.append(File.separator);
		folder.append(DateUtils.getYear());
		folder.append(File.separator);
		folder.append(DateUtils.getMonth());
		FileUtils.createDirectory(folder.toString());
	}


	private String formSearch(EbMessage messageInfo, Model model) {
		model.addAttribute("messageInfo", messageInfo);
		return "modules/message/messageInfoForm";
	}


	/**
	 * 发消息给用户
	 * @param userids 用户ids
	 * @param messageId
	 * @param receiverType 发送类型：1.所有用户;2.所有商家;3.所有买家;4.指定用户;5、指定代理；6、所有代理；
	 */
	@ResponseBody
	@RequestMapping(value = "sendMsgToUser")
	private String sendMsgToUser(String userids, String messageId,String receiverType) {

		EbMessage eMessage=null;
		if (StringUtil.isBlank(messageId)) {
			return "消息不存在！";
		}else {
			eMessage=messageInfoService.getEbMessageById(Integer.valueOf(messageId));
		}

		if(StringUtil.isBlank(userids)&&receiverType.equals("1")) {//1. 所有用户
			List<Integer > userIdList=userService.findAllUserToIds(receiverType);
			for (int i = 0; i < userIdList.size(); i++) {
				Integer userId=userIdList.get(i);
				EbMessageUser messageInfoUser=new EbMessageUser();
				messageInfoUser.setUserId(userId);
				messageInfoUser.setMessageInfo(eMessage);
				messageInfoUser.setState(3);
				messageInfoUser.setUserType(1);
				messageInfoUser.setSendTime(new Date());
				messageInfoUser.setCreateTime(new Date());
				messageInfoUser.setCreateUser(SysUserUtils.getUser().getId());
				messageInfoUserService.sqlsaveEbMessage(messageInfoUser);
				//推送
				messageInfoUserService.sendMsgJgEbMessageUser(userId,eMessage);
			}
		}else if (StringUtil.isBlank(userids)&&receiverType.equals("2")) {//所有商家
			List<Integer  > shopIdList =pmShopInfoService.getAllShopId();
			for (int i = 0; i < shopIdList.size(); i++) {
				Integer shopId =shopIdList.get(i);
				EbUser ebUser = ebUserService.getByShopId(shopId);
				if(ebUser == null){
					continue;
				}
				EbMessageUser messageInfoUser=new EbMessageUser();
				messageInfoUser.setUserId(ebUser.getUserId());
				messageInfoUser.setMessageInfo(eMessage);
				messageInfoUser.setState(3);
				messageInfoUser.setUserType(2);
				messageInfoUser.setSendTime(new Date());
				messageInfoUser.setCreateTime(new Date());
				messageInfoUser.setCreateUser(SysUserUtils.getUser().getId());
				messageInfoUserService.sqlsaveEbMessage(messageInfoUser);
				//推送
				messageInfoUserService.sendMsgJgEbMessageUser(ebUser.getUserId(),eMessage);
			}
		}else if (StringUtil.isNotBlank(userids)&&receiverType.equals("7")) {//7.指定门店
			String[] arr=userids.split(",");
			for (int i = 0; i < arr.length; i++) {
				EbUser ebUser = ebUserService.getByShopId(Integer.valueOf(arr[i]));
				if(ebUser == null){
					continue;
				}
				EbMessageUser messageInfoUser=new EbMessageUser();
				messageInfoUser.setUserId(ebUser.getUserId());
				eMessage.setId(Integer.valueOf(messageId));
				messageInfoUser.setMessageInfo(eMessage);
				//messageInfoUser.setMessageId(Integer.valueOf(messageId));
				messageInfoUser.setState(3);
				messageInfoUser.setUserType(2);
				messageInfoUser.setSendTime(new Date());
				messageInfoUser.setCreateTime(new Date());
				messageInfoUser.setCreateUser(SysUserUtils.getUser().getId());
				messageInfoUserService.sqlsaveEbMessage(messageInfoUser);
//                messageInfoUserService.save(messageInfoUser);
				//推送
				messageInfoUserService.sendMsgJgEbMessageUser(ebUser.getUserId(),eMessage);

			}
		}else if (StringUtil.isNotBlank(userids)&&receiverType.equals("4")) {//4.指定用户
			String[] arr=userids.split(",");
			for (int i = 0; i < arr.length; i++) {
				EbMessageUser messageInfoUser=new EbMessageUser();
				messageInfoUser.setUserId(Integer.valueOf(arr[i]));
				eMessage.setId(Integer.valueOf(messageId));
				messageInfoUser.setMessageInfo(eMessage);
				//messageInfoUser.setMessageId(Integer.valueOf(messageId));
				messageInfoUser.setState(3);
				messageInfoUser.setUserType(1);
				messageInfoUser.setSendTime(new Date());
				messageInfoUser.setCreateTime(new Date());
				messageInfoUser.setCreateUser(SysUserUtils.getUser().getId());
				messageInfoUserService.sqlsaveEbMessage(messageInfoUser);
//                messageInfoUserService.save(messageInfoUser);
				//推送
				messageInfoUserService.sendMsgJgEbMessageUser(Integer.valueOf(arr[i]),eMessage);

			}
		}

		return "消息发送成功！";

		//		EbMessage eMessage=null;
//		if (StringUtil.isBlank(messageId)) {
//			return "消息不存在！";
//		}else {
//			eMessage=messageInfoService.getEbMessageById(Integer.valueOf(messageId));
//		}
//
//		if (StringUtil.isBlank(userids)&&receiverType.equals("1")||receiverType.equals("2")||receiverType.equals("3")) {//1. 2. 3
//				List<Integer  > userIdList=userService.findAllUserToIds(receiverType);
//				for (int i = 0; i < userIdList.size(); i++) {
//					Integer userId=userIdList.get(i);
//					EbMessageUser messageInfoUser=new EbMessageUser();
//					messageInfoUser.setUserId(userId);
//					messageInfoUser.setMessageInfo(eMessage);
//					messageInfoUser.setState(3);
//					messageInfoUser.setUserType(1);
//					messageInfoUser.setCreateUser(SysUserUtils.getUser().getId());
//					messageInfoUserService.sqlsaveEbMessage(messageInfoUser);
//					//推送
//					messageInfoUserService.sendMsgJgEbMessageUser(userId,eMessage.getMessageObjId(),eMessage.getMessageTitle(), eMessage.getMessageAbstract(), eMessage.getMessageType());
//				}
//		}else if (StringUtil.isNotBlank(userids)&&receiverType.equals("5")) {//5、指定代理；
//				String[] arr=userids.split(",");
//				for (int i = 0; i < arr.length; i++) {
////					SysOffice office=new SysOffice();
////					office.setId(arr[i]);
//					EbMessageUser messageInfoUser=new EbMessageUser();
//					messageInfoUser.setObjType("2");
//					messageInfoUser.setAgentId(arr[i]);
////					messageInfoUser.setOffice(office);
//					messageInfoUser.setMessageInfo(eMessage);
//					messageInfoUser.setState(3);
//					messageInfoUser.setCreateUser(SysUserUtils.getUser().getId());
//					messageInfoUserService.sqlsaveEbMessage(messageInfoUser);
//			}
//
//		}else if (StringUtil.isBlank(userids)&&receiverType.equals("6")) {//6、所有代理
////			List<SysOffice> list = officeService.findAll();
//			List<PmAgentInfo> list = agentService.findAllType(null);
////			SysOffice office=new SysOffice();
//			for (int i=0; i<list.size(); i++){
////				SysOffice e = list.get(i);
////				if (e.getIsAgent()!=null&&e.getIsAgent().equals("1")) {
////					office.setId(e.getId());
//					EbMessageUser messageInfoUser=new EbMessageUser();
//					messageInfoUser.setObjType("2");
//					messageInfoUser.setAgentId(list.get(i).getAgentId()+"");
////					messageInfoUser.setOffice(office);
//					messageInfoUser.setMessageInfo(eMessage);
//					messageInfoUser.setState(3);
//					messageInfoUser.setCreateUser(SysUserUtils.getUser().getId());
//					messageInfoUserService.sqlsaveEbMessage(messageInfoUser);
//				}
////			}
//
//		}else if (StringUtil.isNotBlank(userids)&&receiverType.equals("4")) {//4.指定用户
//			String[] arr=userids.split(",");
//			for (int i = 0; i < arr.length; i++) {
//				EbMessageUser messageInfoUser=new EbMessageUser();
//				messageInfoUser.setUserId(Integer.valueOf(arr[i]));
//				eMessage.setId(Integer.valueOf(messageId));
//				messageInfoUser.setMessageInfo(eMessage);
//				//messageInfoUser.setMessageId(Integer.valueOf(messageId));
//				messageInfoUser.setState(3);
//				messageInfoUser.setSendTime(new Date());
//				messageInfoUser.setCreateTime(new Date());
//				messageInfoUser.setCreateUser(SysUserUtils.getUser().getId());
//				//messageInfoUserService.sqlsaveEbMessage(messageInfoUser);
//				messageInfoUserService.save(messageInfoUser);
//				//推送
//				messageInfoUserService.sendMsgJgEbMessageUser(Integer.valueOf(arr[i]),eMessage.getMessageObjId(), eMessage.getMessageTitle(), eMessage.getMessageAbstract(), eMessage.getMessageType());
//
//			}
//		 }
//
//		return "消息发送成功！";
	}




}
