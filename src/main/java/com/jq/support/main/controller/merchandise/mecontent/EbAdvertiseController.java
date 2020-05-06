package com.jq.support.main.controller.merchandise.mecontent;

import java.io.File;
import java.util.List;

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
import com.jq.support.common.utils.DateUtils;
import com.jq.support.common.utils.FileUtils;
import com.jq.support.common.web.BaseController;
import com.jq.support.model.article.EbArticle;
import com.jq.support.model.product.EbAdvertise;
import com.jq.support.model.product.EbLayouttype;
import com.jq.support.model.product.EbProduct;
import com.jq.support.model.product.PmShopInfo;
import com.jq.support.model.sys.SysOffice;
import com.jq.support.model.sys.SysUser;
import com.jq.support.model.user.EbUser;
import com.jq.support.service.merchandise.article.EbArticleService;
import com.jq.support.service.merchandise.mecontent.EbAdvertiseService;
import com.jq.support.service.merchandise.mecontent.EbLayouttypeService;
import com.jq.support.service.merchandise.product.EbProductService;
import com.jq.support.service.merchandise.shop.PmShopInfoService;
import com.jq.support.service.utils.SysUserUtils;



/**
 * 广告模板
 * @author Administrator
 *
 */
@Controller
@RequestMapping(value = "${adminPath}/EbAdvertise")
public class EbAdvertiseController extends BaseController {
	@Autowired
	private EbAdvertiseService ebAdvertiseService;
	@Autowired
	private EbLayouttypeService ebLayouttypeService;
	@Autowired
	private EbProductService ebProductService;
	@Autowired
	private PmShopInfoService pmShopInfoService;
	@Autowired
	private EbArticleService ebArticleService;
	private static String domainurl = Global.getConfig("domainurl");
	private static String innerImgPartPath = "src=\"/uploads/images/";
	private static String innerImgFullPath = "src=\"" + domainurl  + "/uploads/images/";
	
	@ModelAttribute
	public  EbAdvertise get(@RequestParam(required=false) String id) {
		if (org.apache.commons.lang3.StringUtils.isNotBlank(id)){
			return ebAdvertiseService.getebadAdvertise(id);
		}else{
			return new  EbAdvertise();
		}
	}
	
	@RequiresPermissions("merchandise:EbAdvertise:view")
	@RequestMapping(value = {"list", ""})
	public String list(
			EbAdvertise ebAdvertise,
			HttpServletRequest request, HttpServletResponse response, Model model){
		    Page<EbAdvertise> page=ebAdvertiseService.getPageList(new Page<EbAdvertise>(request, response),ebAdvertise);
		    model.addAttribute("page", page);
		    model.addAttribute("ebAdvertise", ebAdvertise);
		    return "modules/shopping/Article/ebAdvertiselist";
	}
	
	@RequiresPermissions("merchandise:EbAdvertise:view")
	@RequestMapping(value = "form")
	public String form(
			EbAdvertise ebAdvertise,
			HttpServletRequest request, HttpServletResponse response, Model model){
		    createPicFold(request);
		    EbLayouttype ebLayouttypes= ebLayouttypeService.geteblLayouttype(ebAdvertise.getLayouttypeId());
		    model.addAttribute("ebLayouttypes", ebLayouttypes);
		    model.addAttribute("ebAdvertise", ebAdvertise);
		    if(ebAdvertise.getId()!=null){
		    	//广告类型（1、类别；2、商品；3、链接（广告图片）；4、商家；5、文章；6、关键字；7、专区倍数；）
		    	if(ebAdvertise.getAdvertiseType()==2){
		    		EbProduct ebProduct= ebProductService.getEbProduct(ebAdvertise.getAdvertiseTypeObjId().toString());
		    		if(ebProduct!=null){
		    			ebAdvertise.setEbProduct(ebProduct);
			    		model.addAttribute("advertiseTypeObjIds", ebProduct.getProductId());
		    		}
		    	}else if(ebAdvertise.getAdvertiseType()==4){
		    		PmShopInfo pmShopInfo= pmShopInfoService.getpmPmShopInfo(ebAdvertise.getAdvertiseTypeObjId().toString());
		    		if(pmShopInfo!=null){
		    			ebAdvertise.setPmShopInfo(pmShopInfo);
			    		model.addAttribute("advertiseTypeObjIds", pmShopInfo.getId());
		    		}
		    	}else if(ebAdvertise.getAdvertiseType()==5){
		    		EbArticle ebArticle= ebArticleService.getEbArticle(ebAdvertise.getAdvertiseTypeObjId().toString());
		    		if(ebArticle!=null){
		    			ebAdvertise.setEbArticle(ebArticle);
			    		model.addAttribute("advertiseTypeObjIds", ebArticle.getArticleId());
		    		}
		    	}
		    }
		    return "modules/shopping/Article/ebAdvertisefrom";
	}

	
	@RequiresPermissions("merchandise:EbAdvertise:edit")
	@RequestMapping(value = "save")
	public String save(
			EbAdvertise ebAdvertise,String advertiseTypeObjIds,
			HttpServletRequest request, HttpServletResponse response, Model model,RedirectAttributes redirectAttributes){
		    EbLayouttype ebLayouttypes= ebLayouttypeService.geteblLayouttype(ebAdvertise.getLayouttypeId());   
		    ebAdvertise.setLayouttypeName(ebLayouttypes.getModuleTitle());
	    	if(ebAdvertise.getAdvertiseType()==2){
	    		EbProduct ebProduct= ebProductService.getEbProduct(advertiseTypeObjIds);
	    		if(ebProduct!=null){
	    			ebAdvertise.setAdvertiseTypeObjName(ebProduct.getProductName());
	    		}
	    		ebAdvertise.setAdvertiseTypeObjId(Integer.parseInt(advertiseTypeObjIds));
	    	}else if(ebAdvertise.getAdvertiseType()==4){
	    		PmShopInfo pmShopInfo= pmShopInfoService.getpmPmShopInfo(advertiseTypeObjIds);
	    		if(pmShopInfo!=null){
	    			ebAdvertise.setAdvertiseTypeObjName(pmShopInfo.getShopName());
	    		}
	    		ebAdvertise.setAdvertiseTypeObjId(Integer.parseInt(advertiseTypeObjIds));
	    	}else if(ebAdvertise.getAdvertiseType()==5){
	    		EbArticle ebArticle= ebArticleService.getEbArticle(advertiseTypeObjIds);
	    		if(ebArticle!=null){
	    			ebAdvertise.setAdvertiseTypeObjName(ebArticle.getArticleTitle());
	    		}
	    		ebAdvertise.setAdvertiseTypeObjId(Integer.parseInt(advertiseTypeObjIds));
	    	}
		    	
		    ebAdvertiseService.save(ebAdvertise);
		    addMessage(redirectAttributes, "保存成功");
			return "redirect:"+Global.getAdminPath()+"/EbAdvertise/list?layouttypeId="+ebAdvertise.getLayouttypeId();
	}
	
	
	@RequiresPermissions("merchandise:EbAdvertise:edit")
	@RequestMapping(value = "delete")
	public String delete(
			EbAdvertise ebAdvertise,
			HttpServletRequest request, HttpServletResponse response, Model model,RedirectAttributes redirectAttributes){
		    ebAdvertiseService.delete(ebAdvertise);
		    addMessage(redirectAttributes, "删除成功");
			return "redirect:"+Global.getAdminPath()+"/EbAdvertise/list?layouttypeId="+ebAdvertise.getLayouttypeId();
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
		folder.append("ebAdvertise");
		folder.append(File.separator);
		folder.append(DateUtils.getYear());
		folder.append(File.separator);
		folder.append(DateUtils.getMonth());
		FileUtils.createDirectory(folder.toString());
	}
}
