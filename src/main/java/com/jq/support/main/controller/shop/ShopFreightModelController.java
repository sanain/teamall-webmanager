package com.jq.support.main.controller.shop;

import com.jq.support.common.utils.StringUtils;
import com.jq.support.common.web.BaseController;
import com.jq.support.model.product.EbProductFreightModel;
import com.jq.support.model.user.EbUser;
import com.jq.support.service.merchandise.product.EbProductFreightModelService;
import com.jq.support.service.utils.SysUserUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * 
 * @author HP 配送费
 */

@Controller
@RequestMapping(value = "${adShopPath}/shopinfofeight")
public class ShopFreightModelController extends BaseController {

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
	@RequestMapping(value = "feightEdit")
	public String feightEdit(EbProductFreightModel ebProductFreightModel,
			HttpServletRequest request, HttpServletResponse response,
			Model model) {
		EbUser ebUser= (EbUser) request.getSession().getAttribute("shopuser");
		ebProductFreightModel = ebProductFreightModelService.getEbProductFreightModelByShopId(ebUser.getShopId());
		model.addAttribute("ebProductFreightModel", ebProductFreightModel);
		return "modules/freight/shopfreightedit";
	}

	/**
	 * 运费添加或者修改
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "savefeight")
	@Transactional
	@ResponseBody
	public Map<String, Object> saveSupplyuser(
			EbProductFreightModel ebProductFreightModel,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		EbUser ebUser= (EbUser) request.getSession().getAttribute("shopuser");
		String freightModelId = request.getParameter("freightModelId");
		String normalFreight = request
				.getParameter("normalFreight");// 配送费
		String fullFreight = request
				.getParameter("fullFreight");// 满多少免配送

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("code", "01");
		if (!StringUtils.isNotBlank(normalFreight)) {
			map.put("msg", "请填写配送费");
			return map;
		} else if (!StringUtils.isNotBlank(fullFreight)) {
			map.put("msg", "请填写满多少免配送");
			return map;
		}
		if (StringUtils.isNotBlank(freightModelId)) {
			ebProductFreightModel = ebProductFreightModelService.getFreightModelId(Integer.parseInt(freightModelId));
		} else{
			ebProductFreightModel=new EbProductFreightModel();
			ebProductFreightModel.setCreateTime(new Date());
			ebProductFreightModel.setShopId(ebUser.getShopId());
		}

		ebProductFreightModel.setModifyTime(new Date());
//		ebProductFreightModel.setModifyUser(SysUserUtils.getUser().getId());
		ebProductFreightModel.setNormalFreight(Double.parseDouble(normalFreight));
		ebProductFreightModel.setFullFreight(Double.parseDouble(fullFreight));

		ebProductFreightModelService.save(ebProductFreightModel);
		map.put("code", "00");
		map.put("msg", "保存配送费成功！");
		return map;
	}

}
