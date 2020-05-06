package com.jq.support.main.controller.merchandise.product;

import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.collections.CollectionUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import redis.clients.jedis.Jedis;

import com.jq.support.common.config.Global;
import com.jq.support.common.persistence.Page;
import com.jq.support.common.utils.DateUtils;
import com.jq.support.common.utils.FileUtils;
import com.jq.support.common.utils.StringUtils;
import com.jq.support.common.web.BaseController;
import com.jq.support.dao.redis.JedisPoolTilems;
import com.jq.support.dao.redis.SerializeUtil;
import com.jq.support.model.product.PmProductType;
import com.jq.support.model.product.PmProductTypeBrand;
import com.jq.support.model.sys.SysUser;
import com.jq.support.service.merchandise.product.PmProductTypeBrandService;
import com.jq.support.service.merchandise.product.PmProductTypeService;
import com.jq.support.service.utils.SysUserUtils;


/**
 * 品牌
 * @author Administrator
 */

@Controller
@RequestMapping(value = "${adminPath}/PmProductTypeBrand")
public class PmProductTypeBrandController extends BaseController {
	@Autowired
	private PmProductTypeBrandService pmProductTypeBrandService;
	@Autowired
	private PmProductTypeService productTypeService;
	@Autowired
	private JedisPoolTilems jedisPoolTilems;
	@Autowired
	private PmProductTypeService pmProductTypeService;
	
	private static String domainurl = Global.getConfig("domainurl");
	private static String innerImgPartPath = "src=\"/uploads/images/";
	private static String innerImgFullPath = "src=\"" + domainurl  + "/uploads/images/";
	
	@ModelAttribute
	public  PmProductTypeBrand get(@RequestParam(required=false) String id) {
		if (org.apache.commons.lang3.StringUtils.isNotBlank(id)){
			return pmProductTypeBrandService.getSbProductTypeBrand(id);
		}else{
			return new  PmProductTypeBrand();
		}
	}
	
	@RequiresPermissions("merchandise:PmProductTypeBrand:view")
	@RequestMapping(value = "tree")
	public String tree(HttpServletRequest request, HttpServletResponse response, Model model) {
		// List<PmProductType> productTypes= productTypeService.getSbProductTypeTree();
		 List<PmProductType> productTypes= productTypeService.getSbProductTypeHQLListLevels("1,2");
		 model.addAttribute("productTypes", productTypes);
		 String url=domainurl+Global.getAdminPath()+"/PmProductTypeBrand/list?productTypeId=";
		 model.addAttribute("url", url);
		return "modules/shopping/classify/sbProductTypeTree";
	}
	
	@RequiresPermissions("merchandise:PmProductTypeBrand:view")
	@RequestMapping(value = {"show", ""})
	public String show(HttpServletRequest request, HttpServletResponse response, Model model) {
		return "modules/shopping/classify/SbProductTypeBrandAll";
	}
	
	
	@RequiresPermissions("merchandise:PmProductTypeBrand:view")
	@RequestMapping(value = "list")
	public String show(String productTypeId,String brandName, HttpServletRequest request, HttpServletResponse response, Model model){
		PmProductTypeBrand	pmProductTypeBrand=new PmProductTypeBrand();
		pmProductTypeBrand.setBrandName(brandName);
		if(StringUtils.isNotBlank(productTypeId)){
			PmProductType pmProductType= productTypeService.getSbProductType(productTypeId);
			if(pmProductType!=null){
				if(pmProductType.getLevel()==2){
					 model.addAttribute("fulte","1");
					 pmProductTypeBrand.setProductTypeId(Integer.parseInt(productTypeId));
				}else{
					pmProductTypeBrand.setProductTypeId(Integer.parseInt(productTypeId));
					model.addAttribute("fulte","0");
				}
			 }else{
				 pmProductTypeBrand.setProductTypeId(Integer.parseInt(productTypeId));
				 model.addAttribute("fulte","0");
			 }
		}else{
			 model.addAttribute("fulte","0");
		}
		Page<PmProductTypeBrand> page=	pmProductTypeBrandService.getPageList(new Page<PmProductTypeBrand>(request, response), pmProductTypeBrand);
		model.addAttribute("page", page);
		/*PmProductTypeBrand pmProductTypeBrand2=  pmProductTypeBrandService.getSbProductTypeBrand(productTypeId);
		 if(pmProductTypeBrand2!=null){
			
		 }else{
			 model.addAttribute("fulte","0");
		 }*/
		model.addAttribute("productTypeId", productTypeId);
		model.addAttribute("sbProductTypeBrand", pmProductTypeBrand);
		return "modules/shopping/classify/SbProductTypeBrandList";
	}
	
	
	@RequiresPermissions("merchandise:PmProductTypeBrand:view")
	@RequestMapping(value = "from")
	public String from(PmProductTypeBrand pmProductTypeBrand,HttpServletRequest request, HttpServletResponse response, Model model){
		   model.addAttribute("sbProductTypeBrand", pmProductTypeBrand);
		   PmProductType pmProductType=   productTypeService.getSbProductType(pmProductTypeBrand.getProductTypeId().toString());
		   model.addAttribute("sbProductType", pmProductType);
		   model.addAttribute("productTypeId", pmProductType.getId());
		   createPicFold(request);
		   return "modules/shopping/classify/SbProductTypeBrandFrom";
	}
	
	@RequiresPermissions("merchandise:PmProductTypeBrand:edit")
	@RequestMapping(value = "save")
	public String save(PmProductTypeBrand pmProductTypeBrand,HttpServletRequest request, HttpServletResponse response, Model model,RedirectAttributes redirectAttributes){
		SysUser user = SysUserUtils.getUser();
		if(pmProductTypeBrand.getId()==null){
			pmProductTypeBrand.setCreateUser(user.getName());
			pmProductTypeBrand.setCreateTime(new Date());
		}else{
			pmProductTypeBrand.setModifyUser(user.getName());
			pmProductTypeBrand.setModifyTime(new Date());
		}
		pmProductTypeBrandService.save(pmProductTypeBrand);
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
								PmProductTypeBrand pmProductTypeBrand1 = new PmProductTypeBrand();
								pmProductTypeBrand1.setId(Integer.parseInt(objs[2].toString()));
								pmProductTypeBrand1.setProductTypeId(Integer.parseInt(objs[3].toString()));
								pmProductTypeBrand1.setBrandName(objs[0].toString());
								pmProductTypeBrand1.setBrandLogo(objs[1].toString());
								pmProductTypeBrandList.add(pmProductTypeBrand1);
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
		addMessage(redirectAttributes, "保存成功");
		return "redirect:"+Global.getAdminPath()+"/PmProductTypeBrand/list?productTypeId="+pmProductTypeBrand.getProductTypeId();
	}
	@RequiresPermissions("merchandise:PmProductTypeBrand:edit")
	@RequestMapping(value = "delete")
	public String delete(String id,HttpServletRequest request, HttpServletResponse response, Model model,RedirectAttributes redirectAttributes){
		PmProductTypeBrand pmProductTypeBrand= pmProductTypeBrandService.getSbProductTypeBrand(id);
		pmProductTypeBrandService.delete(pmProductTypeBrand);
		addMessage(redirectAttributes, "删除成功");
		return "redirect:"+Global.getAdminPath()+"/PmProductTypeBrand/list?productTypeId="+pmProductTypeBrand.getProductTypeId();
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
		folder.append("PmProductTypeBrand");
		folder.append(File.separator);
		folder.append(DateUtils.getYear());
		folder.append(File.separator);
		folder.append(DateUtils.getMonth());
		FileUtils.createDirectory(folder.toString());
	}
	
	

}
