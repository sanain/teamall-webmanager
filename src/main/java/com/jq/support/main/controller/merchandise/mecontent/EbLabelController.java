package com.jq.support.main.controller.merchandise.mecontent;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import com.jq.support.model.article.EbArticle;
import com.jq.support.model.product.EbLabel;
import com.jq.support.model.product.EbProduct;
import com.jq.support.model.sys.SysUser;
import com.jq.support.service.merchandise.article.EbArticleService;
import com.jq.support.service.merchandise.mecontent.EbLabelService;
import com.jq.support.service.merchandise.product.EbProductService;
import com.jq.support.service.utils.SysUserUtils;


@Controller
@RequestMapping(value = "${adminPath}/EbLabel")
public class EbLabelController extends BaseController{
	@Autowired
	private EbLabelService ebLabelService;
	@Autowired
	private EbProductService ebProductService;
	@Autowired
	private EbArticleService ebArticleService;
	
	@ModelAttribute
	public  EbLabel get(@RequestParam(required=false) String id) {
		if (org.apache.commons.lang3.StringUtils.isNotBlank(id)){
			return ebLabelService.getEbLabel(id);
		}else{
			return new  EbLabel();
		}
	}
	
	@RequiresPermissions("merchandise:EbLabel:view")
	@RequestMapping(value = {"list", ""})
	public String getProductList(
			EbLabel ebLabel,
			HttpServletRequest request, HttpServletResponse response, Model model){
		    Page<EbLabel> page=ebLabelService.ebLabelPage(ebLabel,new Page<EbLabel>(request, response));
		    model.addAttribute("page", page);
		    model.addAttribute("ebLabel", ebLabel);
		    return "modules/shopping/brands/Productservicelist";
	}
	
	@RequiresPermissions("merchandise:EbLabel:view")
	@RequestMapping(value = "form")
	public String form(
			EbLabel ebLabel,
			HttpServletRequest request, HttpServletResponse response, Model model){
		    model.addAttribute("ebLabel", ebLabel);
		    return "modules/shopping/brands/Productserviceform";
	}
	@ResponseBody
	@RequestMapping(value = "eblabelLs")
	public List  EblabelLs(HttpServletRequest request, HttpServletResponse response){
		 EbLabel ebLabel=new EbLabel();
		 ebLabel.setLabelType(1);
	     List<EbLabel> ebLabels=ebLabelService.ebLabelList(ebLabel);
		 return ebLabels;
	}

	
	@RequiresPermissions("merchandise:EbLabel:edit")
	@RequestMapping(value = "save")
	public String save(
			EbLabel ebLabel,
		 	HttpServletRequest request, HttpServletResponse response, Model model,RedirectAttributes redirectAttributes){
		    SysUser sysUser= SysUserUtils.getUser();    
		    if(ebLabel.getId()==null){
		    	ebLabel.setCreateTime(new Date());
		    	ebLabel.setCreateUser(sysUser.getLoginName());
		    }else{
		    	List<EbProduct> ebProduct= ebProductService.getpList(ebLabel.getId().toString(),null);
		    	for (EbProduct ebProduct2 : ebProduct) {
		    		if(ebProduct2.getProductTags()!=null){
		    			String[] tag=ebProduct2.getProductTags().split(",");
		    			if(tag!=null){
		    				String ids="";
		    		    	String name="";
		    				  for (int i = 0; i < tag.length; i++) {
		    					  ids+=""+tag[i]+",";
		    					  EbLabel ebLabels= ebLabelService.getEbLabel(tag[i]);
		    					  name+=""+ebLabels.getName()+",";
		    				  }
		    				ebProduct2.setProductTags(ids);
		  		    		ebProduct2.setProductTagsName(name);
		  	    		    ebProductService.saveProduct(ebProduct2);
		    			  }
		    		 }
				}
		    	//文章
		    	List<EbArticle> ebArticles= ebArticleService.getEbArticleProductTypeId(ebLabel.getId().toString());
		    	for (EbArticle ebArticle : ebArticles) {
		    		if(ebArticle.getLabelIds()!=null){
		    			String[] tag=ebArticle.getLabelIds().split(",");
		    			if(tag!=null){
		    				String id="";
		    		    	String names="";
		    				for (int i = 0; i < tag.length; i++) {
		    					  id+=""+tag[i]+",";
		    					  EbLabel ebLabels= ebLabelService.getEbLabel(tag[i]);
		    					  names+=""+ebLabels.getName()+",";
		    				  }
		    				ebArticle.setLabelIds(id);
		  		    		ebArticle.setLabelNames(names);
		  		    		ebArticleService.save(ebArticle);
		    			  }
		    		 }
				}
		    	
		    	
		    	ebLabel.setModifyTime(new Date());
		    	ebLabel.setModifyUser(sysUser.getLoginName());
		    }
		    ebLabelService.save(ebLabel);
		    addMessage(redirectAttributes, "保存成功");
			return "redirect:"+Global.getAdminPath()+"/EbLabel/list";
	}
	
	
	@RequiresPermissions("merchandise:EbLabel:edit")
	@RequestMapping(value = "delete")
	public String delete(
			EbLabel ebLabel,
			HttpServletRequest request, HttpServletResponse response, Model model,RedirectAttributes redirectAttributes){
		    //删除商品标签
	    	List<EbProduct> ebProduct= ebProductService.getpList(ebLabel.getId().toString(),null);
	    	if(ebProduct!=null&&ebProduct.size()>0){
		    	for (EbProduct ebProduct2 : ebProduct) {
		    		if(ebProduct2.getProductTags()!=null){
		    			String ids=ebProduct2.getProductTags().replaceAll(ebLabel.getId().toString()+",", "");
		    			EbLabel ebLabels= ebLabelService.getEbLabel(ebLabel.getId().toString());
		    			String name=ebProduct2.getProductTagsName().replaceAll(ebLabels.getName()+",", "");
		    				ebProduct2.setProductTags(ids);
		  		    		ebProduct2.setProductTagsName(name);
		  			        ebProductService.saveProduct(ebProduct2);
		    			  }
		    		 }
		    	}
	    	//文章
	    	List<EbArticle> ebArticles= ebArticleService.getEbArticleProductTypeId(ebLabel.getId().toString());
	    	if(ebArticles!=null&&ebArticles.size()>0){
	    		for (EbArticle ebArticle : ebArticles) {
	    			String id=ebArticle.getLabelIds().replaceAll(ebLabel.getId().toString()+",", "");
	    			EbLabel ebLabels= ebLabelService.getEbLabel(ebLabel.getId().toString());
	    			String name=ebArticle.getLabelNames().replaceAll(ebLabels.getName()+",", "");
	    			ebArticle.setLabelIds(id);
  		    		ebArticle.setLabelNames(name);
  		    		ebArticleService.save(ebArticle);
				}
	    	}
		    ebLabelService.delete(ebLabel);
		    addMessage(redirectAttributes, "删除成功");
			return "redirect:"+Global.getAdminPath()+"/EbLabel/list";
	}
	
}
