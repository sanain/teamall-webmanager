package com.jq.support.main.controller.h5;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alipay.api.domain.ShopInfo;
import com.google.common.collect.Lists;
import com.jq.support.common.utils.StringUtils;
import com.jq.support.common.web.BaseController;
import com.jq.support.model.product.EbProduct;
import com.jq.support.model.product.EbProductFreightModel;
import com.jq.support.model.product.EbProductcomment;
import com.jq.support.model.product.PmProductStandardDetail;
import com.jq.support.model.product.PmProductType;
import com.jq.support.model.product.PmShopInfo;
import com.jq.support.model.shop.PmShopShippingMethod;
import com.jq.support.service.merchandise.product.EbProductFreightModelService;
import com.jq.support.service.merchandise.product.EbProductService;
import com.jq.support.service.merchandise.product.EbProductcommentService;
import com.jq.support.service.merchandise.product.PmProductPropertyStandardService;
import com.jq.support.service.merchandise.product.PmProductStandardDetailService;
import com.jq.support.service.merchandise.shop.PmShopInfoService;
import com.jq.support.service.merchandise.shop.PmShopShippingMethodService;


@Controller
@RequestMapping("/ProductDetailsHtml")
public class ProductDetailsHtml extends BaseController {
    @Autowired
    private EbProductService ebProductService;
    @Autowired
    private PmShopInfoService pmShopInfoService;
    @Autowired
	private EbProductcommentService ebProductcommentService;
    @Autowired
    private PmProductPropertyStandardService pmProductPropertyStandardService;
    @Autowired
    private PmProductStandardDetailService pmProductStandardDetailService;
    @Autowired
    private PmShopShippingMethodService pmShopShippingMethodService;
	@Autowired
	private EbProductFreightModelService ebProductFreightModelService;
    
	@RequestMapping(value="{id}${urlSuffix}")
	public String ProductDetails(@PathVariable String id, HttpServletRequest request,Model model) throws Exception {
		EbProduct ebProduct=new EbProduct();
		if(StringUtils.isNotBlank(id)){
			 ebProduct= ebProductService.getEbProduct(id);
			 ebProduct= ebProductService.getProduct(ebProduct);
			//获取商户
			PmShopInfo pmShopInfo = pmShopInfoService.getpmPmShopInfo(ebProduct.getShopId().toString());
			if(pmShopInfo!=null){
				//获取物流评分
				pmShopInfo.setLogiscore(ebProductcommentService.getScore("2", pmShopInfo.getId().toString()));
				//获取服务评分
				pmShopInfo.setService(ebProductcommentService.getScore("1", pmShopInfo.getId().toString()));
				//获取综合评分
				pmShopInfo.setOverallMerit(ebProductcommentService.getScore("3", pmShopInfo.getId().toString()));
				ebProduct.setPmShopInfo(pmShopInfo);
			}
			//获取评价
			EbProductcomment ebProductcomment=new EbProductcomment();
			ebProductcomment.setProductId(Integer.valueOf(id));
			List<EbProductcomment> ebProductcomments= ebProductcommentService.getPageList(0, 1, ebProductcomment);
			ebProduct.setEbProductcomments(ebProductcomments);
			//获取运费
			if(ebProduct.getFreightType()!=null){
				if(ebProduct.getFreightType()==2){
					if(ebProduct.getUserFreightTemp()==1){
//						PmShopShippingMethod pmShopShippingMethod=new PmShopShippingMethod();
//						pmShopShippingMethod.setTemplateId(ebProduct.getFreightTempId());
//						pmShopShippingMethod.setIsDefaultShipp(1);
//						PmShopShippingMethod pmShopShippingMethod2= pmShopShippingMethodService.findTemplateId(pmShopShippingMethod);
//						ebProduct.setCourier(pmShopShippingMethod2.getFirstCharge());
						EbProductFreightModel ebProductFreightModel = ebProductFreightModelService
								.getEbProductFreightModelByShopId(1);
						ebProduct.setCourier(ebProductFreightModel
								.getNormalFreight());
						ebProduct.setFullFreight(ebProductFreightModel
								.getFullFreight());
					}
				}
			}
		}
		model.addAttribute("ebProduct", ebProduct);
		return "modules/h5/commodity-home";
	 }
	@RequestMapping(value="ProductDetailsId/{id}${urlSuffix}")
	public String ProductDetailsId(@PathVariable String id, HttpServletRequest request,Model model) throws Exception {
		EbProduct ebProduct=new EbProduct();
		if(StringUtils.isNotBlank(id)){
			 ebProduct= ebProductService.getEbProduct(id);
		}
		model.addAttribute("ebProduct", ebProduct);
		return "modules/h5/commodity-details";
	 }
	@RequestMapping(value="EbProductcomment/{id}${urlSuffix}")
	public String EbProductcomment(@PathVariable String id, HttpServletRequest request,Model model) throws Exception {
		EbProduct ebProduct=new EbProduct();
		if(StringUtils.isNotBlank(id)){
			 ebProduct= ebProductService.getEbProduct(id);
			EbProductcomment ebProductcomment=new EbProductcomment();
			ebProductcomment.setProductId(Integer.valueOf(id));
			List commentCounts=ebProductcommentService.getCount(ebProductcomment);
			if(commentCounts.size()>0&&commentCounts!=null){
				Object[] objects=(Object[]) commentCounts.get(0);
				model.addAttribute("all", objects[0]);
				model.addAttribute("picture", objects[1]);
				model.addAttribute("good", objects[2]);
				model.addAttribute("middle", objects[3]);
				model.addAttribute("bad", objects[4]);
			}
		}
		model.addAttribute("ebProduct", ebProduct);
		return "modules/h5/commodity-evaluate";
	 }
	@ResponseBody
	@RequestMapping(value = "EbProductcomment/jsonTo")
	public Map<String, Object> jsonTo(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> map=new HashMap<String, Object>();
		response.setContentType("application/json; charset=UTF-8");
		String id=request.getParameter("id");
		String operationType=request.getParameter("operationType");
		String stateRow=request.getParameter("stateRow");
		String endRow=request.getParameter("endRow");
		Integer stateNum = 0;// 开始行数
		if (StringUtils.isNotBlank(stateRow)) {
			stateNum = Integer.parseInt(stateRow);
		}
		Integer endNum = 10;// 结束行数
		if (StringUtils.isNotBlank(endRow)) {
			endNum = Integer.parseInt(endRow);
		}
		EbProductcomment ebProductcomment=new EbProductcomment();
		ebProductcomment.setProductId(Integer.valueOf(id));
		List<EbProductcomment> ebProductcommentsList=new ArrayList<EbProductcomment>();
		if(operationType.equals("0")){//0.全部 1.有图 2.好评 3.中评 4.差评
			ebProductcommentsList=ebProductcommentService.getPageList(stateNum, endNum, ebProductcomment);
		}
		if(operationType.equals("1")){
			ebProductcomment.setPicture("1");//有无图片：0无，1有
			ebProductcommentsList=ebProductcommentService.getPageList(stateNum, endNum, ebProductcomment);
		}
		if(operationType.equals("2")){
			ebProductcomment.setPoint(3);//3好评 2中评 1差评
			ebProductcommentsList=ebProductcommentService.getPageList(stateNum, endNum, ebProductcomment);
		}
		if(operationType.equals("3")){
			ebProductcomment.setPoint(2);//3好评 2中评 1差评
			ebProductcommentsList=ebProductcommentService.getPageList(stateNum, endNum, ebProductcomment);
		}
		if(operationType.equals("4")){				
			ebProductcomment.setPoint(1);//3好评 2中评 1差评
			ebProductcommentsList=ebProductcommentService.getPageList(stateNum, endNum, ebProductcomment);
	     }
		map.put("endRow", endRow);
		map.put("stateRow", stateRow);
		map.put("operationType", operationType);
		map.put("ebProductcommentsList", ebProductcommentsList);
		return map;
	}
	
	
	
	
}
