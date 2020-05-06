package com.jq.support.main.controller.merchandise.product;

import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.jq.support.common.config.Global;
import com.jq.support.common.persistence.Page;
import com.jq.support.common.web.BaseController;
import com.jq.support.model.product.EbProductcomment;
import com.jq.support.model.user.EbUser;
import com.jq.support.service.merchandise.product.EbProductcommentService;
import com.jq.support.service.merchandise.user.EbUserService;

//后台管理 商品评论
@Controller
@RequestMapping(value = "${adminPath}/productcomment")
public class ProductcommentController extends BaseController {
	@Autowired
	private EbProductcommentService ebProductcommentService;
	@Autowired
	private EbUserService ebUserService;

	@ModelAttribute
	public EbProductcomment get(@RequestParam(required = false) String id) {
		if (StringUtils.isNotBlank(id)) {
			return ebProductcommentService.get(Integer.valueOf(id));
		} else {
			return new EbProductcomment();
		}
	}

	@RequiresPermissions("shop:EbProductcomment:view")
	@RequestMapping(value = { "list", "" })
	public String list(EbProductcomment ebProductcomment, String star,
			String startTime, String endTime, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		Page<EbProductcomment> page = ebProductcommentService
				.findProductcommentList(new Page<EbProductcomment>(request,
						response), ebProductcomment, star);
		if (page.getCount() > 0) {
			for (int i = 0; i < page.getList().size(); i++) {
				Integer isAnonymous = page.getList().get(i).getIsAnonymous();
				if (isAnonymous == 1) {
					System.out.println(page.getList().get(i).getUserId()
							.toString());
					EbUser username = ebUserService.getEbUser(page.getList()
							.get(i).getUserId().toString());
					if (username != null) {
						page.getList().get(i)
								.setUsername("(匿名)" + username.getUsername());
					}
				}
			}
		}
		model.addAttribute("page", page);
		model.addAttribute("star", star);
		return "modules/shop/product-commentList";
	}

	@RequiresPermissions("shop:EbProductcomment:view")
	@RequestMapping(value = "form")
	public String form(EbProductcomment ebProductcomment,
			HttpServletRequest request, HttpServletResponse response,
			Model model) {
		model.addAttribute("ebProductcomment", ebProductcomment);
		return "modules/shop/EbProductcommentFrom";
	}

	@RequiresPermissions("shop:EbProductcomment:edit")
	@RequestMapping(value = "save")
	public String save(EbProductcomment ebProductcomment,
			HttpServletRequest request, HttpServletResponse response,
			Model model, RedirectAttributes redirectAttributes)
			throws IOException {
		ebProductcommentService.save(ebProductcomment);
		addMessage(redirectAttributes, "保存成功");
		return "redirect:" + Global.getAdminPath() + "/EbProductcomment/list";
	}

	// 回复评论
	@ResponseBody
	@RequiresPermissions("shop:EbProductcomment:edit")
	@RequestMapping(value = "resave")
	public Map<String, String> resave(String commentId, String recontents,
			HttpServletRequest request, HttpServletResponse response,
			Model model, RedirectAttributes redirectAttributes)
			throws IOException {
		Map<String, String> map = new HashMap<String, String>();
		if (StringUtils.isBlank(commentId)) {
			map.put("msg", "评论id不能为空");
			map.put("code", "01");
		} else if (StringUtils.isBlank(recontents)) {
			map.put("msg", "回复内容不能为空");
			map.put("code", "01");
		} else {
			EbProductcomment ebProductcomment = ebProductcommentService
					.get(Integer.valueOf(commentId));
			ebProductcomment.setRecontents(recontents);// 回复内容
			ebProductcomment.setRecommentTime(new Date());// 回复时间
			ebProductcomment.setStatus(1);
			ebProductcommentService.save(ebProductcomment);
			map.put("msg", "回复评论成功");
			map.put("code", "00");
		}
		return map;
	}

	@RequiresPermissions("shop:EbProductcomment:edit")
	@RequestMapping(value = "delete")
	public String delete(EbProductcomment ebProductcomment,
			HttpServletRequest request, HttpServletResponse response,
			Model model, RedirectAttributes redirectAttributes)
			throws IOException {
		ebProductcommentService.delete(ebProductcomment);
		addMessage(redirectAttributes, "删除成功");
		return "redirect:" + Global.getAdminPath() + "/productcomment/list";
	}

	/**
	 * 删除
	 */
	@RequiresPermissions("shop:EbProductcomment:edit")
	@RequestMapping(value = "deleteService")
	public String deleteProject(String ids[],
			RedirectAttributes redirectAttributes, HttpServletRequest request) {
		for (int i = 0; i < ids.length; i++) {
			EbProductcomment exc = ebProductcommentService.get(Integer
					.valueOf(ids[i]));
			if (exc != null) {
				ebProductcommentService.delete(exc);
			}
		}
		addMessage(redirectAttributes, "删除成功");
		return "redirect:" + Global.getAdminPath() + "/productcomment/list";
	}
}
