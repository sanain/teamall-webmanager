package com.jq.support.main.controller.shop;

import java.io.File;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.jq.support.common.utils.StringUtils;
import com.jq.support.common.web.BaseController;
import com.jq.support.model.product.EbProductFreightModel;
import com.jq.support.service.merchandise.product.EbProductFreightModelService;

import com.jq.support.service.utils.SysUserUtils;

/**
 * 
 * @author HP 平台商品价格运费模板
 */

@Controller
@RequestMapping(value = "${adminPath}/productfeight")
public class EbProductFreightModelController extends BaseController {

	@Autowired
	private EbProductFreightModelService ebProductFreightModelService;

	/**
	 * 运费模板
	 * 
	 * @param ebProductFreightModel
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("merchandise:feight:edit")
	@RequestMapping(value = "feightEdit")
	public String feightEdit(EbProductFreightModel ebProductFreightModel,
			HttpServletRequest request, HttpServletResponse response,
			Model model) {

		ebProductFreightModel = ebProductFreightModelService.getEbProductFreightModelByShopId(1);
		model.addAttribute("ebProductFreightModel", ebProductFreightModel);
		return "modules/freight/freightedit";
	}

	/**
	 * 运费添加或者修改
	 *
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequiresPermissions("merchandise:feight:edit")
	@RequestMapping(value = "savefeight")
	@Transactional
	@ResponseBody
	public Map<String, Object> saveSupplyuser(
			EbProductFreightModel ebProductFreightModel,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
//		String freightModelId = request.getParameter("freightModelId");
//		String normalFreight = request
//				.getParameter("normalFreight");// 省内运费
//		String fullFreight = request
//				.getParameter("fullFreight");// 省内满多少免邮
//		String provinceOutNormalFreight = request
//				.getParameter("provinceOutNormalFreight");// 省外运费
//		String provinceOutFullFreight = request
//				.getParameter("provinceOutFullFreight");// 省外满多少免邮

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("code", "01");
		if (ebProductFreightModel.getNormalFreight() == null) {
			map.put("msg", "请填写运费");
			return map;
		} else if (ebProductFreightModel.getFullFreight() == null) {
			map.put("msg", "请填写满免");
			return map;
		}

		EbProductFreightModel oldModel = ebProductFreightModelService.getFreightModelId(ebProductFreightModel.getFreightModelId());
		oldModel.setModifyTime(new Date());
		oldModel.setModifyUser(SysUserUtils.getUser().getId());
		oldModel.setNormalFreight(ebProductFreightModel.getNormalFreight());
		oldModel.setFullFreight(ebProductFreightModel.getFullFreight());

		ebProductFreightModelService.save(oldModel);
		map.put("code", "00");
		map.put("msg", "保存运费成功！");
		return map;
	}

}
