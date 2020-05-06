package com.jq.support.main.controller.merchandise.article;

import java.io.File;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
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
import com.jq.support.common.utils.DateUtils;
import com.jq.support.common.utils.FileUtils;
import com.jq.support.common.web.BaseController;
import com.jq.support.model.article.EbArticleType;
import com.jq.support.model.sys.SysUser;
import com.jq.support.model.user.EbUser;
import com.jq.support.service.merchandise.article.EbArticleService;
import com.jq.support.service.merchandise.article.EbArticleTypeService;
import com.jq.support.service.utils.InitCacheUtils;
import com.jq.support.service.utils.StringUtil;
import com.jq.support.service.utils.SysUserUtils;

/**
 * 文章类别
 * 
 */
@Controller
@RequestMapping(value = "${adminPath}/ebArticleType")
public class EbArticleTypeController extends BaseController {
	@Autowired
	private EbArticleTypeService ebArticleTypeService;
	@Autowired
	private EbArticleService ebArticleService;

	private static String domainurl = Global.getConfig("domainurl");
	private static String innerImgPartPath = "src=\"/uploads/images/";
	private static String innerImgFullPath = "src=\"" + domainurl
			+ "/uploads/images/";

	@ModelAttribute
	public EbArticleType get(@RequestParam(required = false) String id) {
		if (StringUtils.isNotBlank(id)) {
			return ebArticleTypeService.getEbArticleType(id);
		} else {
			return new EbArticleType();
		}
	}

	@RequiresPermissions("merchandise:ebArticleType:view")
	@RequestMapping(value = "tree")
	public String tree(HttpServletRequest request,
			HttpServletResponse response, Model model) {
		List<EbArticleType> ebArticleTypes = ebArticleTypeService
				.getEbArticleTypeTree();
		model.addAttribute("ebArticleTypes", ebArticleTypes);
		String url = domainurl + Global.getAdminPath()
				+ "/ebArticleType/form?id=";
		model.addAttribute("url", url);
		return "modules/shopping/Article/ebArticleTypeTree";
	}

	@RequiresPermissions("merchandise:ebArticleType:view")
	@RequestMapping(value = { "show", "" })
	public String show(EbArticleType ebArticleType, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		// List<EbUser> ebUsers=(List<EbUser>)
		// InitCacheUtils.getCache(InitCacheUtils.CACHE_EBUSER);
		List<EbArticleType> ebArticleTypesList = ebArticleTypeService
				.getEbArticleTypeTree();
		if (CollectionUtils.isNotEmpty(ebArticleTypesList)) {// 设置默认
			ebArticleType = (EbArticleType) ebArticleTypesList.get(0);
		}
		model.addAttribute("ebArticleType", ebArticleType);
		return "modules/shopping/Article/ebArticleType";
	}

	@RequiresPermissions("merchandise:ebArticleType:view")
	@RequestMapping(value = "form")
	public String form(EbArticleType ebArticleType, String refresh,
			HttpServletRequest request, HttpServletResponse response,
			Model model) {
		createPicFold(request);
		if (ebArticleType != null) {
			ebArticleType.setParentArticleTypeName(ebArticleType
					.getArticleTypeName());
		}
		if (ebArticleType != null && ebArticleType.getParentId() != null) {
			EbArticleType ParentEbArticleType = ebArticleTypeService
					.getEbArticleType(ebArticleType.getParentId() + "");
			model.addAttribute("ParentEbArticleType", ParentEbArticleType);
			ebArticleType.setParentArticleTypeName(ParentEbArticleType
					.getArticleTypeName());
		}

		model.addAttribute("ebArticleType", ebArticleType);
		model.addAttribute("refresh", refresh);
		return "modules/shopping/Article/ebArticleTypeFrom";
	}

	// 菜单删除
	@RequiresPermissions("merchandise:ebArticleType:edit")
	@RequestMapping(value = "delete")
	public String delete(EbArticleType ebArticleType,
			HttpServletRequest request, HttpServletResponse response,
			Model model) {
		if (ebArticleType != null) {
			if (ebArticleType.getParentId() != null) {
				// 文章数量
				Integer articleCount = ebArticleService
						.getArticleCount(ebArticleType.getArticleTypeId());
				if (articleCount.equals(0)) {// 类别下面有文章不能删
					ebArticleTypeService.delete(ebArticleType);
				}
			}
		}
		return "redirect:" + Global.getAdminPath()
				+ "/ebArticleType/form?refresh=1&id="
				+ ebArticleType.getParentId();
	}

	@RequiresPermissions("merchandise:ebArticleType:edit")
	@RequestMapping(value = "save")
	public String save(EbArticleType ebArticleType, HttpServletRequest request,
			HttpServletResponse response, Model model,
			RedirectAttributes redirectAttributes) {
		SysUser user = SysUserUtils.getUser();
		// if(ebArticleType.getParentId()!=null){
		EbArticleType ebArticleTypes = ebArticleTypeService
				.getEbArticleType(ebArticleType.getArticleTypeId() + "");
		if (ebArticleTypes != null && ebArticleTypes.getParentId() == null) {
			ebArticleType.setArticleTypeId(null);
			ebArticleType.setArticleTypeCode(ebArticleTypes
					.getArticleTypeCode());
			ebArticleType.setParentId(ebArticleTypes.getArticleTypeId());
			ebArticleType.setCreateUser(user.getLoginName());
			ebArticleType.setCreateTime(new Date());
			// ebArticleType.setModifyTime(new Date());
			ebArticleTypeService.save(ebArticleType);
		} else {
			if (ebArticleTypes != null
					&& ebArticleType.getArticleTypeId() != null) {
				ebArticleTypes = ebArticleTypeService
						.getEbArticleType(ebArticleType.getParentId() + "");
				if (ebArticleTypes != null) {
					if (ebArticleTypes.getParentId() == null) {
						ebArticleType.setModifyUser(user.getName());
						ebArticleType.setModifyTime(new Date());
						ebArticleType.setArticleTypeCode(ebArticleTypes
								.getArticleTypeCode());
						ebArticleTypeService.save(ebArticleType);
					} else {
						addMessage(redirectAttributes, "不能添加第三级菜单");
					}
				}
			}

		}
		// }
		// else{
		/*
		 * List<EbArticleType>
		 * ebArticleTypes=ebArticleTypeService.getEbArticleTypeListParentId
		 * (ebArticleType.getParentId()+"");
		 * if(ebArticleTypes!=null&&ebArticleTypes.size()>0){ EbArticleType
		 * parent=ebArticleTypes.get(0);
		 * ebArticleType.setParentId(parent.getArticleTypeId()); }
		 * ebArticleType.setModifyUser(user.getName());
		 * ebArticleType.setModifyTime(new Date());
		 */
		// }
		if (ebArticleType != null) {
			ebArticleType.setParentArticleTypeName(ebArticleType
					.getArticleTypeName());
		}
		if (ebArticleType != null && ebArticleType.getParentId() != null) {
			EbArticleType ParentEbArticleType = ebArticleTypeService
					.getEbArticleType(ebArticleType.getParentId() + "");
			model.addAttribute("ParentEbArticleType", ParentEbArticleType);
			ebArticleType.setParentArticleTypeName(ParentEbArticleType
					.getArticleTypeName());
		}
		model.addAttribute("ebArticleType", ebArticleType);
		model.addAttribute("refresh", 1);
		return "modules/shopping/Article/ebArticleTypeFrom";
	}

	@RequiresUser
	@ResponseBody
	@RequestMapping(value = "treeData")
	public List<Map<String, Object>> treeData(
			@RequestParam(required = false) Long extId,
			HttpServletResponse response) {
		response.setContentType("application/json; charset=UTF-8");
		List<Map<String, Object>> mapList = Lists.newArrayList();
		List<EbArticleType> list = ebArticleTypeService
				.getEbArticleTypeParentTree();
		for (int i = 0; i < list.size(); i++) {
			EbArticleType e = list.get(i);
			if (extId == null
					|| (extId != null && !extId.equals(e.getArticleTypeId()))) {
				Map<String, Object> map = Maps.newHashMap();
				map.put("id", e.getArticleTypeId());
				map.put("pId", e.getParentId() != null ? e.getParentId() : 0);
				map.put("name", e.getArticleTypeName());
				mapList.add(map);
			}
		}
		return mapList;
	}

	@ResponseBody
	@RequestMapping(value = "getTo")
	public List getTo(HttpServletRequest request, HttpServletResponse response) {
		response.setContentType("application/json; charset=UTF-8");
		List<Map<String, Object>> mapList = Lists.newArrayList();
		List<EbArticleType> list = ebArticleTypeService.getEbArticleTypeTree();
		return list;
	}

	/**
	 * 创建图片存放目录
	 */
	private void createPicFold(HttpServletRequest request) {
		String root = request.getSession().getServletContext().getRealPath("/");
		StringBuffer folder = new StringBuffer(root);
		folder.append("uploads");
		folder.append(File.separator);
		// ===========集群文件处理 start===============
		String wfsName = Global.getConfig("wfsName");
		if (StringUtils.isNotBlank(wfsName)) {
			folder.append(wfsName);
			folder.append(File.separator);
		}
		// ===========集群文件字段处理 end===============
		folder.append("000000");
		folder.append(File.separator);
		folder.append("images");
		folder.append(File.separator);
		folder.append("merchandise");
		folder.append(File.separator);
		folder.append("article");
		folder.append(File.separator);
		folder.append(DateUtils.getYear());
		folder.append(File.separator);
		folder.append(DateUtils.getMonth());
		FileUtils.createDirectory(folder.toString());
	}

}
