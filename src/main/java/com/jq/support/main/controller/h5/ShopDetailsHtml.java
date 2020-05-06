package com.jq.support.main.controller.h5;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jq.support.common.utils.StringUtils;
import com.jq.support.common.web.BaseController;
import com.jq.support.model.article.EbArticle;
import com.jq.support.model.product.EbAdvertise;
import com.jq.support.model.product.EbLayouttype;
import com.jq.support.model.product.EbProduct;
import com.jq.support.model.product.EbProductcomment;
import com.jq.support.model.product.PmProductStandardDetail;
import com.jq.support.model.product.PmShopInfo;
import com.jq.support.service.merchandise.mecontent.EbAdvertiseService;
import com.jq.support.service.merchandise.mecontent.EbLayouttypeService;
import com.jq.support.service.merchandise.product.EbProductService;
import com.jq.support.service.merchandise.product.EbProductcommentService;
import com.jq.support.service.merchandise.product.PmProductStandardDetailService;
import com.jq.support.service.merchandise.shop.PmShopInfoService;


@Controller
@RequestMapping("/ShopDetailsHtml")
public class ShopDetailsHtml extends BaseController { 
	@Autowired
	private PmShopInfoService pmShopInfoService;
	@Autowired
    private EbProductcommentService ebProductcommentService;
	@Autowired
	private EbProductService ebProductService;
	@Autowired
	private PmProductStandardDetailService pmProductStandardDetailService;
	@Autowired
	private EbAdvertiseService ebAdvertiseService;
	
	@RequestMapping(value="Details/{id}${urlSuffix}")
	public String ShopDetails(@PathVariable String id, HttpServletRequest request,Model model) throws Exception {
		PmShopInfo pmShopInfo=new PmShopInfo();
		if(StringUtils.isNotBlank(id)){
			pmShopInfo=pmShopInfoService.getpmPmShopInfo(id);
			//获取物流评分
			pmShopInfo.setLogiscore(ebProductcommentService.getScore("2", id));
			//获取服务评分
			pmShopInfo.setService(ebProductcommentService.getScore("1", id));
			//获取综合评分
			pmShopInfo.setOverallMerit(ebProductcommentService.getScore("3", id));
		 }
		model.addAttribute("pmShopInfo", pmShopInfo);
		return "modules/h5/shop-details";
	}
	@RequestMapping(value="HomePage/{id}${urlSuffix}")
	public String HomePage(@PathVariable  String id, HttpServletRequest request,Model model) throws Exception {
		PmShopInfo pmShopInfo=new PmShopInfo();
		if(StringUtils.isNotBlank(id)){
			pmShopInfo=pmShopInfoService.getpmPmShopInfo(id);
			EbAdvertise ebAdvertise=new EbAdvertise();
			ebAdvertise.setShopId(Integer.parseInt(id));
			List<EbAdvertise> ebAdvertises=ebAdvertiseService.getList(ebAdvertise);
			model.addAttribute("ebAdvertises", ebAdvertises);
			List<EbProduct> objlist=	ebProductService.getShopList(id);
			if (CollectionUtils.isNotEmpty(objlist)) {
				for (EbProduct ebProduct2 : objlist) {
					List<PmProductStandardDetail> pmProductStandardDetails=  pmProductStandardDetailService.getProductIdPmProductStandardDetail(ebProduct2.getProductId().toString());
					if(pmProductStandardDetails!=null&&pmProductStandardDetails.size()>0){
						Integer mus=0;
					    List<PmProductStandardDetail> max=pmProductStandardDetailService.getProductIdPmProductStandardMaximum(ebProduct2.getProductId().toString());
					    for (PmProductStandardDetail pmProductStandardDetail : max) {
					    	mus+=pmProductStandardDetail.getDetailInventory();
						}
					    List<PmProductStandardDetail> min=pmProductStandardDetailService.getProductIdPmProductStandardMinimum(ebProduct2.getProductId().toString());
						if(max!=null&&max.size()>0&&min!=null&&max.size()>0){
							if(min.get(0).getDetailPrices()==max.get(0).getDetailPrices()){
								ebProduct2.setReasonablePrice(min.get(0).getDetailPrices()+"");
							}else{
							    ebProduct2.setReasonablePrice(min.get(0).getDetailPrices()+"~"+max.get(0).getDetailPrices());
							}
						}
					  }else{
						        ebProduct2.setReasonablePrice(ebProduct2.getSellPrice()+"");
					 }
				}
			}
			model.addAttribute("ebProducts", objlist);
		 }
		
		model.addAttribute("pmShopInfo", pmShopInfo);
		return "modules/h5/shop-home";
	}
	@RequestMapping(value="ShopDetailsList/{id}${urlSuffix}")
	public String ShopDetailsList(@PathVariable String id,HttpServletRequest request,Model model) throws Exception {
		PmShopInfo pmShopInfo=new PmShopInfo();
		if(StringUtils.isNotBlank(id)){
			pmShopInfo=pmShopInfoService.getpmPmShopInfo(id);
			model.addAttribute("pmShopInfo", pmShopInfo);
		 }
		return "modules/h5/shop-sale";
	}
	
	
	@ResponseBody
	@RequestMapping(value = "ShopDetailsList/jsonTo")
	public Map<String, Object> jsonTo(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> map=new HashMap<String, Object>();
		response.setContentType("application/json; charset=UTF-8");
		String id=request.getParameter("id");
		if(StringUtils.isNotBlank(id)){
		String salesVolume=request.getParameter("salesVolume");
		String update=request.getParameter("update");//最新 0否1是
		String stateRow=request.getParameter("stateRow");
		String endRow=request.getParameter("endRow");
		String priceTrue=request.getParameter("priceTrue");
		Integer stateNum = 0;// 开始行数
		if (StringUtils.isNotBlank(stateRow)) {
			stateNum = Integer.parseInt(stateRow);
		}
		Integer endNum = 10;// 结束行数
		if (StringUtils.isNotBlank(endRow)) {
			endNum = Integer.parseInt(endRow);
		}
		EbProduct ebProduct=new EbProduct();
		ebProduct.setShopId(Integer.parseInt(id));
		ebProduct.setPrdouctStatus(1);
		ebProduct.setProductViewMall(1);
		List<EbProduct> objlist =ebProductService.getAppEbProductList(stateNum,endNum,ebProduct,null,priceTrue,salesVolume,null,null,null,null,update,null,"",null,"","","","","",null);
		if (CollectionUtils.isNotEmpty(objlist)) {
			for (EbProduct ebProduct2 : objlist) {
				List<PmProductStandardDetail> pmProductStandardDetails=  pmProductStandardDetailService.getProductIdPmProductStandardDetail(ebProduct2.getProductId().toString());
				if(pmProductStandardDetails!=null&&pmProductStandardDetails.size()>0){
					Integer mus=0;
				    List<PmProductStandardDetail> max=pmProductStandardDetailService.getProductIdPmProductStandardMaximum(ebProduct2.getProductId().toString());
				    for (PmProductStandardDetail pmProductStandardDetail : max) {
				    	mus+=pmProductStandardDetail.getDetailInventory();
					}
				    ebProduct.setStoreNums(mus);
				    List<PmProductStandardDetail> min=pmProductStandardDetailService.getProductIdPmProductStandardMinimum(ebProduct2.getProductId().toString());
					if(max!=null&&max.size()>0&&min!=null&&max.size()>0){
						if(min.get(0).getDetailPrices()==max.get(0).getDetailPrices()){
							ebProduct2.setReasonablePrice(min.get(0).getDetailPrices()+"");
						}else{
						    ebProduct2.setReasonablePrice(min.get(0).getDetailPrices()+"~"+max.get(0).getDetailPrices());
						}
					}
				  }else{
					        ebProduct2.setReasonablePrice(ebProduct2.getSellPrice()+"");
				 }
			}
		}
		
		map.put("endRow", endRow);
		map.put("stateRow", stateRow);
		map.put("priceTrue", priceTrue);
		map.put("salesVolume", salesVolume);
		map.put("objlist", objlist);
		}
		return map;
	}
	
	

}
