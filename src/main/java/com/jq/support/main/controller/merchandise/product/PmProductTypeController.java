package com.jq.support.main.controller.merchandise.product;
import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jq.support.common.persistence.Page;
import com.jq.support.model.product.EbProductCharging;
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
import com.jq.support.model.sys.SysUser;
import com.jq.support.service.merchandise.product.PmProductTypeBrandService;
import com.jq.support.service.merchandise.product.PmProductTypeService;
import com.jq.support.service.utils.SysUserUtils;

import redis.clients.jedis.Jedis;

/**
 * 类别
 * @author Administrator
 *
 */
@Controller
@RequestMapping(value = "${adminPath}/PmProductType")
public class PmProductTypeController extends BaseController{
	@Autowired
	private PmProductTypeService productTypeService;
	@Autowired
	private PmProductTypeService pmProductTypeService;
	@Autowired
	private JedisPoolTilems jedisPoolTilems;
	@Autowired
	private PmProductTypeBrandService pmProductTypeBrandService;
	
	private static String domainurl = Global.getConfig("domainurl");
	private static String innerImgPartPath = "src=\"/uploads/images/";
	private static String innerImgFullPath = "src=\"" + domainurl  + "/uploads/images/";
	
	
	
	@ModelAttribute
	public PmProductType get(@RequestParam(required=false) String id) {
		if (org.apache.commons.lang3.StringUtils.isNotBlank(id)){
			return productTypeService.getSbProductType(id);
		}else{
			return new PmProductType();
		}
	}
	@RequiresPermissions("merchandise:PmProductType:view")
	@RequestMapping(value = "tree")
	public String tree(HttpServletRequest request, HttpServletResponse response, Model model) {
		PmProductType pmProductType=new PmProductType();
		 List<PmProductType> productTypes= productTypeService.getSbProductTypeList(pmProductType);
		 model.addAttribute("usType", 3);
		 model.addAttribute("productTypes", productTypes);
		 String url=domainurl+Global.getAdminPath()+"/PmProductType/form?f=1&id=";
		 model.addAttribute("url", url);
		return "modules/shopping/classify/sbProductTypeTree";
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
	
	@RequiresPermissions("merchandise:PmProductType:edit")
	@RequestMapping(value ="delete")
	public String delete(PmProductType pmProductType,HttpServletRequest request, HttpServletResponse response, Model model) {
		pmProductTypeService.delete(pmProductType);
		/*PmProductType type=new PmProductType();
		type.setParentId(pmProductType.getId());
		List<PmProductType> list=pmProductTypeService.getSbProductTypeList(type);
		for (PmProductType pmProductType2 : list) {
			pmProductTypeService.delete(pmProductType2);
		}*/
		return "redirect:"+Global.getAdminPath()+"/PmProductType/form";
	}
	
	@RequiresPermissions("merchandise:PmProductType:view")
	@RequestMapping(value = {"show", ""})
	public String show(HttpServletRequest request, HttpServletResponse response, Model model) {
		return "modules/shopping/classify/sbProductTypeAll";
	}
	
	@RequiresPermissions("merchandise:PmProductType:view")
	@RequestMapping(value = "form")
	public String form(PmProductType pmProductType,String f,String ys, HttpServletRequest request, HttpServletResponse response, Model model) {
		createPicFold(request);
		System.out.println(ys);
		if(StringUtils.isNotBlank(ys)){
			List<PmProductType> productTypes= productTypeService.getSbProductTypeTree();
			if(productTypes!=null&&productTypes.size()>0){
				pmProductType=productTypes.get(0);
			}
		}
		model.addAttribute("sbProductType", pmProductType);
		model.addAttribute("f", f);
		return "modules/shopping/classify/sbProductTypeFrom";
	}
	@SuppressWarnings("unchecked")
	@RequiresPermissions("merchandise:PmProductType:edit")
	@RequestMapping(value = "savetype")
	public String savetype(PmProductType pmProductType, String isfshow, HttpServletRequest request, HttpServletResponse response, Model model) {
		SysUser user = SysUserUtils.getUser();
		if(pmProductType.getId()==null){
			List<PmProductType> pmProductTypes=productTypeService.getSbProductTypeHQLListParentId(""+pmProductType.getParentId(),"");
			if(pmProductTypes!=null&&pmProductTypes.size()>0){
				PmProductType pmProductType2=pmProductTypes.get(0);
				if(pmProductType2!=null&&pmProductType2.getLevel()<3){
					pmProductType.setCreateUser(user.getName());
					pmProductType.setCreateTime(new Date());
					pmProductType.setLevel(pmProductType2.getLevel()+1);
					productTypeService.save(pmProductType);
					pmProductType.setProductTypeIdStr(pmProductType2.getProductTypeIdStr()+","+pmProductType.getId());
					pmProductType.setProductTypeStr(pmProductType2.getProductTypeStr()+">"+pmProductType.getProductTypeName());
					productTypeService.save(pmProductType);
				}else{
					model.addAttribute("message", "最多三级分类");
				}
			}else{
				pmProductType.setCreateUser(user.getName());
				pmProductType.setCreateTime(new Date());
				pmProductType.setStatus(1);
				pmProductType.setProductTypeStr(pmProductType.getProductTypeName());
				pmProductType.setLevel(1);
				pmProductType.setTypeLink("#");
				pmProductType.setParentId(0);
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
							pmProductType.setModifyUser(user.getName());
							pmProductType.setModifyTime(new Date());
							pmProductType.setLevel(2);
							productTypeService.save(pmProductType);
						}else{
							model.addAttribute("message", "最多三级分类");
						}

					}else if(productType.getLevel()==2&&(pmProductType1OneList==null||pmProductType1OneList.size()==0)){
						pmProductType.setProductTypeIdStr(productType.getProductTypeIdStr()+","+pmProductType.getId());
						pmProductType.setProductTypeStr(productType.getProductTypeStr()+">"+pmProductType.getProductTypeName());
						pmProductType.setModifyUser(user.getName());
						pmProductType.setModifyTime(new Date());
						pmProductType.setLevel(productType.getLevel()+1);
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
				pmProductType.setModifyUser(user.getName());
				pmProductType.setModifyTime(new Date());
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
//		else {
//
//
//			PmProductType parameterProductType = new PmProductType();
//			parameterProductType.setStatus(1);
//			parameterProductType.setLevel(1);
//			parameterProductType.setIsShowFront(1);
//			List<PmProductType> pmProductType1List = new ArrayList<PmProductType>();
//			pmProductType1List = pmProductTypeService.getSbProductTypeList(parameterProductType);
//			if(CollectionUtils.isNotEmpty(pmProductType1List)){
//				for(PmProductType pmPt1:pmProductType1List){
//					String whereStr="";
//					parameterProductType.setLevel(2);
//					parameterProductType.setParentId(pmPt1.getId());
//					parameterProductType.setIsShowFront(1);
//					List<PmProductType> pmProductType2List = pmProductTypeService.getSbProductTypeList(parameterProductType);
//					pmPt1.setPmProductTypes(pmProductType2List);
//					if(CollectionUtils.isNotEmpty(pmProductType2List)){
//						for(int i=0; i<pmProductType2List.size(); i++){
//							PmProductType pmPt2 = pmProductType2List.get(i);
//							parameterProductType.setLevel(3);
//							parameterProductType.setIsShowFront(1);
//							parameterProductType.setParentId(pmPt2.getId());
//							List<PmProductType> pmProductType3List = pmProductTypeService.getSbProductTypeList(parameterProductType);
//							pmPt2.setPmProductTypes(pmProductType3List);
//							if(i==0){
//								whereStr+="product_type_id="+pmPt2.getId();
//							}else{
//								whereStr+=" or product_type_id="+pmPt2.getId();
//							}
//						}
//					}
//					//分类下的品牌列表
//					if(StringUtils.isNotBlank(whereStr)){
//						List<PmProductTypeBrand> pmProductTypeBrandList = new ArrayList();
//						List<Object> brandObjectList = pmProductTypeBrandService.getBrandObjectListByWhere(" and ("+whereStr+")");
//						if(CollectionUtils.isNotEmpty(brandObjectList)){
//							for(int i=0; i<brandObjectList.size(); i++){
//								Object[] objs = (Object[])brandObjectList.get(i);
//								if(objs[0]!=null && objs[1]!=null){
//									PmProductTypeBrand pmProductTypeBrand = new PmProductTypeBrand();
//									pmProductTypeBrand.setId(Integer.parseInt(objs[2].toString()));
//									pmProductTypeBrand.setProductTypeId(Integer.parseInt(objs[3].toString()));
//									pmProductTypeBrand.setBrandName(objs[0].toString());
//									pmProductTypeBrand.setBrandLogo(objs[1].toString());
//									pmProductTypeBrandList.add(pmProductTypeBrand);
//								}
//							}
//						}
//						pmPt1.setPmProductTypeBrandList(pmProductTypeBrandList);
//					}
//
//				}
//			}
//			Jedis jedis = jedisPoolTilems.getResource();
//			if(jedis == null){
//				throw new NullPointerException("数据库连接失败！");
//		    }
//
//			try{
//				//把查询到的结果保存到redis缓存
//		        jedis.set("jsonPmProductTypeList".getBytes(), SerializeUtil.serialize(pmProductType1List));
//			}catch(Exception e){
//				jedisPoolTilems.returnBrokenResource(jedis);
//			}finally{
//				jedisPoolTilems.returnResource(jedis);
//			}
//		}

		model.addAttribute("sbProductType", pmProductType);
		return "modules/shopping/classify/sbProductTypeFrom";
	}

	@SuppressWarnings("unchecked")
	@RequiresPermissions("merchandise:PmProductType:edit")
	@RequestMapping(value = "save")
	public String save(PmProductType pmProductType, String isfshow, HttpServletRequest request, HttpServletResponse response, Model model) {
		SysUser user = SysUserUtils.getUser();
		if(pmProductType.getId()==null){
			List<PmProductType> pmProductTypes=productTypeService.getSbProductTypeHQLListParentId(""+pmProductType.getParentId(),"");
			if(pmProductTypes!=null&&pmProductTypes.size()>0){
				PmProductType pmProductType2=pmProductTypes.get(0);
				pmProductType.setCreateUser(user.getName());
				pmProductType.setCreateTime(new Date());
				pmProductType.setLevel(pmProductType2.getLevel()+1);
				productTypeService.save(pmProductType);
				pmProductType.setProductTypeIdStr(pmProductType2.getProductTypeIdStr()+","+pmProductType.getId());
				pmProductType.setProductTypeStr(pmProductType2.getProductTypeStr()+">"+pmProductType.getProductTypeName());
				productTypeService.save(pmProductType);
			}else{
				pmProductType.setCreateUser(user.getName());
				pmProductType.setCreateTime(new Date());
				pmProductType.setStatus(1);
				pmProductType.setProductTypeStr(pmProductType.getProductTypeName());
				pmProductType.setLevel(1);
				pmProductType.setTypeLink("#");
				pmProductType.setParentId(0);
				productTypeService.save(pmProductType);
				pmProductType.setProductTypeIdStr(","+pmProductType.getId());
			}
		}else{
			if(pmProductType.getParentId()!=null&&pmProductType.getParentId()!=0){
				PmProductType productType=  productTypeService.getSbProductType(pmProductType.getParentId().toString());
			    pmProductType.setProductTypeIdStr(productType.getProductTypeIdStr()+","+pmProductType.getId());
				pmProductType.setProductTypeStr(productType.getProductTypeStr()+">"+pmProductType.getProductTypeName());
				pmProductType.setModifyUser(user.getName());
				pmProductType.setModifyTime(new Date());
				pmProductType.setLevel(productType.getLevel()+1);
				productTypeService.save(pmProductType);
			}else{
				if(pmProductType.getParentId()==null){
					pmProductType.setParentId(0);
				}
				pmProductType.setModifyUser(user.getName());
				pmProductType.setModifyTime(new Date());
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
		}else {
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
		}
       
		model.addAttribute("sbProductType", pmProductType);
		return "modules/shopping/classify/sbProductTypeFrom";
	}
	
	@RequiresUser
	@ResponseBody
	@RequestMapping(value = "treeData")
	public List<Map<String, Object>> treeData(@RequestParam(required=false) Long extId, HttpServletResponse response) {
		response.setContentType("application/json; charset=UTF-8");
		List<Map<String, Object>> mapList = Lists.newArrayList();
		List<PmProductType> list = productTypeService.getSbProductTypeHQLList("");
		for (int i=0; i<list.size(); i++){
			if(list.get(i)!=null){
		    	PmProductType e = list.get(i);
				if (extId == null || (extId!=null && !extId.equals(e.getId()) && e.getProductTypeIdStr().indexOf(","+extId+",")==-1)){
					Map<String, Object> map = Maps.newHashMap();
					map.put("id", e.getId());
					map.put("pId", e.getParentId()!=null?e.getParentId():0);
					map.put("name", e.getProductTypeName());
					mapList.add(map);
				}
			}
		}
		return mapList;
	}
	@ResponseBody
	@RequestMapping(value = "getTo")
	public List getTo(HttpServletRequest request, HttpServletResponse response) {
		response.setContentType("application/json; charset=UTF-8");
		List<Map<String, Object>> mapList = Lists.newArrayList();
		List<PmProductType> list = productTypeService.getSbProductTypeHQLListLevel("1");
		return list;
	}

	/**
	 * 查询三级分类列表
	 * @param model
	 * @param type
	 * @param request
	 * @param response
	 * @return
	 */
	@RequiresPermissions("merchandise:PmProductType:view")
	@RequestMapping("threeLevelList")
	public String threeLevelList(Model model ,PmProductType type ,  HttpServletRequest request , HttpServletResponse response){

		Page<PmProductType> page=pmProductTypeService.getPageList(new Page<PmProductType>(request, response),type);

		model.addAttribute("pmProductType",type);
		model.addAttribute("page",page);
		return "modules/shopping/brands/threeLevelList";
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
