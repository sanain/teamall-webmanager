package com.jq.support.main.controller.shop;

import java.io.IOException;
import java.util.Date;
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
import com.jq.support.model.order.EbOrder;
import com.jq.support.model.product.EbProductcomment;
import com.jq.support.model.user.EbUser;
import com.jq.support.service.merchandise.order.EbOrderService;
import com.jq.support.service.merchandise.product.EbProductcommentService;


//商家端 商品评论
@Controller
@RequestMapping(value = "${adShopPath}/EbProductcomment")
public class EbProductcommentController extends BaseController{
	@Autowired
	private EbProductcommentService ebProductcommentService;
	@Autowired
	private EbOrderService ebOrderService;
	
	@ModelAttribute
	public EbProductcomment get(@RequestParam(required=false) String id) {
		if (StringUtils.isNotBlank(id)){
			return ebProductcommentService.get(Integer.valueOf(id));
		}else{
			return new EbProductcomment();
		}
	}
	
	@RequiresPermissions("shop:EbProductcomment:view")
	@RequestMapping(value = {"list", ""})
	public String list(EbProductcomment ebProductcomment,String star,String startTime,String endTime, HttpServletRequest request, HttpServletResponse response, Model model){
		EbUser ebUser=(EbUser) request.getSession().getAttribute("shopuser");
		ebProductcomment.setShopId(ebUser.getShopId());
	    Page<EbProductcomment> page=ebProductcommentService.findebProductcommentList(new Page<EbProductcomment>(request, response),ebProductcomment,star,startTime,endTime);
	    model.addAttribute("page", page);
	    model.addAttribute("star", star);
	    model.addAttribute("startTime", startTime);
	    model.addAttribute("endTime", endTime);
	    return "modules/shop/productcommentList";
	}
	
	
	@RequiresPermissions("shop:EbProductcomment:view")
	@RequestMapping(value = "form")
	public String form(EbProductcomment ebProductcomment, HttpServletRequest request, HttpServletResponse response, Model model){
		model.addAttribute("ebProductcomment", ebProductcomment);
		 return "modules/shop/EbProductcommentFrom";
	}
	
	@RequiresPermissions("shop:EbProductcomment:view")
	@RequestMapping(value = "show")
	public String show(EbProductcomment ebProductcomment, HttpServletRequest request, HttpServletResponse response, Model model){
		if(ebProductcomment!=null){
		   EbOrder ebOrder=	ebOrderService.getEbOrderById(ebProductcomment.getOrderId());
		   ebProductcomment.setEbOrder(ebOrder);
		}
		model.addAttribute("ebProductcomment", ebProductcomment);
		return "modules/shop/evaluate-details";
	}
	@RequiresPermissions("shop:EbProductcomment:edit")
	@RequestMapping(value = "save")
	public String save(EbProductcomment ebProductcomment, HttpServletRequest request, HttpServletResponse response, Model model,RedirectAttributes redirectAttributes) throws IOException{
		      ebProductcommentService.save(ebProductcomment);
		      addMessage(redirectAttributes, "保存成功");
	  	return "redirect:"+Global.getAdminPath()+"/EbProductcomment/list";
	}
	
	
	@RequiresPermissions("shop:EbProductcomment:edit")
	@RequestMapping(value = "delete")
	public String delete(EbProductcomment ebProductcomment, HttpServletRequest request, HttpServletResponse response, Model model,RedirectAttributes redirectAttributes) throws IOException{
		     // ebProductcommentService.delete(ebProductcomment);
		      addMessage(redirectAttributes, "删除成功");
	  	return "redirect:"+Global.getAdminPath()+"/EbProductcomment/list";
	}
	
	
}
