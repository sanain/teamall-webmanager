package com.jq.support.main.controller.shop;
import java.io.File;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.jq.support.common.config.Global;
import com.jq.support.common.utils.DateUtils;
import com.jq.support.common.utils.FileUtils;
import com.jq.support.common.web.BaseController;
import com.jq.support.dao.redis.JedisPoolTilems;
import com.jq.support.dao.redis.SerializeUtil;
import com.jq.support.model.product.PmProductType;
import com.jq.support.model.product.PmProductTypeBrand;
import com.jq.support.model.product.PmShopInfo;
import com.jq.support.model.sys.SysUser;
import com.jq.support.model.user.EbUser;
import com.jq.support.service.merchandise.product.PmProductTypeBrandService;
import com.jq.support.service.merchandise.product.PmProductTypeService;
import com.jq.support.service.merchandise.shop.PmShopInfoService;
import com.jq.support.service.utils.SysUserUtils;

import redis.clients.jedis.Jedis;

/**
 * 类别
 * @author Administrator
 *
 */
@Controller
@RequestMapping(value = "${adShopPath}/PmProductType")
public class PmShopProductTypeController extends BaseController{
	@Autowired
	private PmProductTypeService productTypeService;
	@Autowired
	private PmProductTypeService pmProductTypeService;
	@Autowired
	private PmShopInfoService pmShopInfoService;
	@Autowired
	private JedisPoolTilems jedisPoolTilems;
	@Autowired
	private PmProductTypeBrandService pmProductTypeBrandService;
	
	private static String domainurl = Global.getConfig("domainurl");

	
	@RequestMapping(value = {"show", ""})
	public String show(HttpServletRequest request, HttpServletResponse response, Model model) {
		EbUser ebUser=(EbUser) request.getSession().getAttribute("shopuser");
		PmShopInfo pmShopInfo=pmShopInfoService.getpmPmShopInfo(ebUser.getShopId()+"");
		model.addAttribute("pmShopInfo", pmShopInfo);
		return "modules/shop/shopproducttype/productTypeAll";
	}

	@RequestMapping(value = "tree")
	public String tree(HttpServletRequest request, HttpServletResponse response, Model model) {
		 String shopId=request.getParameter("shopId");
		 List<PmProductType> allProductTypes=new ArrayList<PmProductType>();
		 List<PmProductType> productTypes= productTypeService.getShopProductTypeList(shopId);
		 List<PmProductType> productTypesTwo=null,productTypesThree=null;
		 if(productTypes!=null&&productTypes.size()>0)
			 allProductTypes.addAll(productTypes);
			 for(PmProductType pmProductType:productTypes){
				    productTypesTwo=productTypeService.getShopProductTypeList(shopId,pmProductType.getId()+"");
				 if(productTypesTwo!=null&&productTypesTwo.size()>0){
					 allProductTypes.addAll(productTypesTwo);
					 for(PmProductType pmProductType1:productTypesTwo){
						productTypesThree=productTypeService.getShopProductTypeList(shopId,pmProductType1.getId()+"");
					    if(productTypesThree!=null&&productTypesThree.size()>0){
					    	allProductTypes.addAll(productTypesThree);
					    }
					 }
				 }
			}
		 
			
		 model.addAttribute("usType", 3);
		 model.addAttribute("productTypes", allProductTypes);
		 String url=domainurl+"/shop/PmProductType/form?f=1&shopId="+shopId+"&id=";
		 model.addAttribute("url", url);
		return "modules/shop/shopproducttype/productTypeTree";
	}
	
	@RequestMapping(value = "form")
	public String form(PmProductType pmProductType,String f,String ys, HttpServletRequest request, HttpServletResponse response, Model model) {
		createPicFold(request);
		EbUser ebUser=(EbUser) request.getSession().getAttribute("shopuser");
		PmShopInfo pmShopInfo=pmShopInfoService.getpmPmShopInfo(ebUser.getShopId()+"");
		if(pmProductType.getId()==null&&StringUtils.isBlank(ys)){
			List<PmProductType> productTypes= productTypeService.getShopProductTypeList(pmProductType.getShopId()+"");
			if(productTypes!=null&&productTypes.size()>0){
				pmProductType=productTypes.get(0);
			}
		}else{
			if(StringUtils.isNotBlank(ys)&&"lk".equals(ys)){
			  if(pmProductType.getId()==null){
				  Integer parentId=pmProductType.getParentId();
				  if(parentId!=null){
					  pmProductType.setId(parentId);
				  }else{
					  List<PmProductType> productTypes= productTypeService.getShopProductTypeList(pmProductType.getShopId()+"");
					  if(productTypes!=null&&productTypes.size()>0){
							pmProductType=productTypes.get(0);
						}  
				  }
			  }else{
			     pmProductType=productTypeService.getID(pmProductType.getId());
			  }
			}else if(StringUtils.isNotBlank(ys)&&"ad".equals(ys)){
				PmProductType pmProductType2=productTypeService.getID(pmProductType.getParentId());
				pmProductType.setProductTypeStr(pmProductType2.getProductTypeStr());
			}else{
				pmProductType=productTypeService.getID(pmProductType.getId());
			}
		   
		}
		model.addAttribute("sbProductType", pmProductType);
		model.addAttribute("pmShopInfo",pmShopInfo);
		model.addAttribute("f", f);
		return "modules/shop/shopproducttype/productTypeFrom";
	}
	
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "savetype")
	public String savetype(PmProductType pmProductType, String isfshow, HttpServletRequest request, HttpServletResponse response, Model model) {
		EbUser user=(EbUser) request.getSession().getAttribute("shopuser");
		PmShopInfo pmShopInfo=pmShopInfoService.getpmPmShopInfo(user.getShopId()+"");
		pmProductType.setIsShowShop(1);
		pmProductType.setIsPublic(1);
		if(pmProductType.getId()==null){
			List<PmProductType> pmProductTypes=productTypeService.getSbProductTypeHQLListParentId(""+pmProductType.getParentId(),"");
			if(pmProductTypes!=null&&pmProductTypes.size()>0){
				PmProductType pmProductType2=pmProductTypes.get(0);
				if(pmProductType2!=null&&pmProductType2.getLevel()<3){
					pmProductType.setCreateUser(user.getUsername());
					pmProductType.setCreateTime(new Date());
					pmProductType.setLevel(pmProductType2.getLevel()+1);
					productTypeService.save(pmProductType);
					pmProductType.setProductTypeIdStr(pmProductType2.getProductTypeIdStr()+","+pmProductType.getId());
					pmProductType.setProductTypeStr(pmProductType2.getProductTypeStr()+">"+pmProductType.getProductTypeName());
					pmProductType.setShopId(pmShopInfo.getId());
					productTypeService.save(pmProductType);
				}else{
					model.addAttribute("message", "最多三级分类");
				}
			}else{
				pmProductType.setCreateUser(user.getUsername());
				pmProductType.setCreateTime(new Date());
				pmProductType.setStatus(1);
				pmProductType.setProductTypeStr(pmProductType.getProductTypeName());
				pmProductType.setLevel(1);
				pmProductType.setTypeLink("#");
				pmProductType.setParentId(0);
				pmProductType.setShopId(pmShopInfo.getId());
				productTypeService.save(pmProductType);
				pmProductType.setProductTypeIdStr(","+pmProductType.getId());
			}
		}else{
			if(pmProductType.getParentId()!=null&&pmProductType.getParentId()!=0){
				PmProductType productType=  productTypeService.getSbProductType(pmProductType.getParentId().toString());
				if(productType!=null&&productType.getLevel()<3){

					List<PmProductType> pmProductType1TwoList = pmProductTypeService.getSbProductTwoParentList(pmProductType.getId()+"");
					List<PmProductType> pmProductType1OneList = pmProductTypeService.getSbProductTwoParentList(pmProductType.getId()+"");
					if(productType.getLevel()==1){
						if(pmProductType1TwoList==null||pmProductType1TwoList.size()==0){
							if(CollectionUtils.isNotEmpty(pmProductType1OneList)){
								for(PmProductType pmPt1:pmProductType1OneList){
									pmPt1.setLevel(3);
									productTypeService.save(pmPt1);
								}
							}
							pmProductType.setProductTypeIdStr(productType.getProductTypeIdStr()+","+pmProductType.getId());
							pmProductType.setProductTypeStr(productType.getProductTypeStr()+">"+pmProductType.getProductTypeName());
							pmProductType.setModifyUser(user.getUsername());
							pmProductType.setModifyTime(new Date());
							pmProductType.setLevel(2);
							pmProductType.setShopId(pmShopInfo.getId());
							productTypeService.save(pmProductType);
						}else{
							model.addAttribute("message", "最多三级分类");
						}

					}else if(productType.getLevel()==2&&(pmProductType1OneList==null||pmProductType1OneList.size()==0)){
						pmProductType.setProductTypeIdStr(productType.getProductTypeIdStr()+","+pmProductType.getId());
						pmProductType.setProductTypeStr(productType.getProductTypeStr()+">"+pmProductType.getProductTypeName());
						pmProductType.setModifyUser(user.getUsername());
						pmProductType.setModifyTime(new Date());
						pmProductType.setLevel(productType.getLevel()+1);
						pmProductType.setShopId(pmShopInfo.getId());
						productTypeService.save(pmProductType);
					}else{
						model.addAttribute("message", "最多三级分类");
					}

				}else{
					model.addAttribute("message", "最多三级分类");
				}
			}else{
				if(pmProductType.getParentId()==null){
					pmProductType.setParentId(0);
				}
				if(pmProductType.getLevel()>1&&pmProductType.getLevel()<3){
					PmProductType parameterProductType = new PmProductType();
					parameterProductType.setLevel(3);
					parameterProductType.setParentId(pmProductType.getId());
					List<PmProductType> pmProductType1List = pmProductTypeService.getSbProductTypeList(parameterProductType);
					if(CollectionUtils.isNotEmpty(pmProductType1List)){
						for(PmProductType pmPt1:pmProductType1List){
							pmPt1.setLevel(2);
							productTypeService.save(pmPt1);
						}
					}
					pmProductType.setLevel(1);
				}
				pmProductType.setModifyUser(user.getUsername());
				pmProductType.setModifyTime(new Date());
				pmProductType.setShopId(pmShopInfo.getId());
				productTypeService.save(pmProductType);
			}
		}
		if(pmProductType.getId()!=null){
			//PmProductType oldPmProductType=pmProductTypeService.getID(pmProductType.getId());
			//if(!pmProductType.getIsShowFront().toString().equals(isfshow)){
			PmProductType parameterProductType = new PmProductType();
			parameterProductType.setStatus(1);
			parameterProductType.setLevel(1);
			parameterProductType.setIsShowFront(1);
			List<PmProductType> pmProductType1List = new ArrayList<PmProductType>();
			pmProductType1List = pmProductTypeService.getSbProductTypeList(parameterProductType);
			if(CollectionUtils.isNotEmpty(pmProductType1List)){
				for(PmProductType pmPt1:pmProductType1List){
					String whereStr="";
					parameterProductType.setLevel(2);
					parameterProductType.setParentId(pmPt1.getId());
					parameterProductType.setIsShowFront(1);
					List<PmProductType> pmProductType2List = pmProductTypeService.getSbProductTypeList(parameterProductType);
					pmPt1.setPmProductTypes(pmProductType2List);
					if(CollectionUtils.isNotEmpty(pmProductType2List)){
						for(int i=0; i<pmProductType2List.size(); i++){
							PmProductType pmPt2 = pmProductType2List.get(i);
							parameterProductType.setLevel(3);
							parameterProductType.setIsShowFront(1);
							parameterProductType.setParentId(pmPt2.getId());
							List<PmProductType> pmProductType3List = pmProductTypeService.getSbProductTypeList(parameterProductType);
							pmPt2.setPmProductTypes(pmProductType3List);

							if(i==0){
								whereStr+="product_type_id="+pmPt2.getId();
							}else{
								whereStr+=" or product_type_id="+pmPt2.getId();
							}
						}
					}
					//分类下的品牌列表
					if(StringUtils.isNotBlank(whereStr)){
						List<PmProductTypeBrand> pmProductTypeBrandList = new ArrayList();
						List<Object> brandObjectList = pmProductTypeBrandService.getBrandObjectListByWhere(" and ("+whereStr+")");
						if(CollectionUtils.isNotEmpty(brandObjectList)){
							for(int i=0; i<brandObjectList.size(); i++){
								Object[] objs = (Object[])brandObjectList.get(i);
								if(objs[0]!=null && objs[1]!=null){
									PmProductTypeBrand pmProductTypeBrand = new PmProductTypeBrand();
									pmProductTypeBrand.setId(Integer.parseInt(objs[2].toString()));
									pmProductTypeBrand.setProductTypeId(Integer.parseInt(objs[3].toString()));
									pmProductTypeBrand.setBrandName(objs[0].toString());
									pmProductTypeBrand.setBrandLogo(objs[1].toString());
									pmProductTypeBrandList.add(pmProductTypeBrand);
								}
							}
						}
						pmPt1.setPmProductTypeBrandList(pmProductTypeBrandList);
					}

				}
			}
			Jedis jedis = jedisPoolTilems.getResource();
			if(jedis == null){
				throw new NullPointerException("数据库连接失败！");
			}

			try{
				//把查询到的结果保存到redis缓存
				jedis.set("jsonPmProductTypeList".getBytes(), SerializeUtil.serialize(pmProductType1List));
			}catch(Exception e){
				jedisPoolTilems.returnBrokenResource(jedis);
			}finally{
				jedisPoolTilems.returnResource(jedis);
			}
			//}
		}
		model.addAttribute("sbProductType", pmProductType);
		return "modules/shop/shopproducttype/productTypeFrom";
	}
	
	
	@RequestMapping(value ="checkName")
	@ResponseBody
	public boolean checkName(PmProductType pmProductType,HttpServletRequest request, HttpServletResponse response, Model model) {
		List<PmProductType> list=productTypeService.chenckname(pmProductType);
		if (CollectionUtils.isNotEmpty(list)) {
			return false;
		}
		return true;
	}
	
	@RequestMapping(value ="delete")
	public String delete(PmProductType pmProductType,HttpServletRequest request, HttpServletResponse response, Model model) {
		pmProductTypeService.delete(pmProductType);
		/*PmProductType type=new PmProductType();
		type.setParentId(pmProductType.getId());
		List<PmProductType> list=pmProductTypeService.getSbProductTypeList(type);
		for (PmProductType pmProductType2 : list) {
			pmProductTypeService.delete(pmProductType2);
		}*/
		return "redirect:"+domainurl+"/shop/PmProductType/form";
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
		folder.append("images" );
		folder.append(File.separator);
		folder.append("merchandise");
		folder.append(File.separator);
		folder.append("category");
		folder.append(File.separator);
		folder.append(DateUtils.getYear());
		folder.append(File.separator);
		folder.append(DateUtils.getMonth());
		FileUtils.createDirectory(folder.toString());
	}
	

}
