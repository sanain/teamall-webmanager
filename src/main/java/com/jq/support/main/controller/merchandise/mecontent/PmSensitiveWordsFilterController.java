package com.jq.support.main.controller.merchandise.mecontent;

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

import com.jq.support.common.config.Global;
import com.jq.support.common.persistence.Page;
import com.jq.support.common.web.BaseController;
import com.jq.support.model.article.EbDiscuss;
import com.jq.support.model.product.EbProduct;
import com.jq.support.model.product.EbProductcomment;
import com.jq.support.model.user.PmSensitiveWordsFilter;
import com.jq.support.service.merchandise.article.EbDiscussService;
import com.jq.support.service.merchandise.mecontent.PmSensitiveWordsFilterService;
import com.jq.support.service.merchandise.product.EbProductService;
import com.jq.support.service.merchandise.product.EbProductcommentService;



@Controller
@RequestMapping(value = "${adminPath}/PmSensitiveWordsFilter")
public class PmSensitiveWordsFilterController extends BaseController {
	@Autowired
	private PmSensitiveWordsFilterService pmSensitiveWordsFilterService;
	@Autowired
	private EbProductService ebProductService;
	@Autowired
	private EbProductcommentService ebProductcommentService;
	@Autowired
	private EbDiscussService ebDiscussService;
	
	@ModelAttribute
	public PmSensitiveWordsFilter get(@RequestParam(required=false) String id) {
		if (org.apache.commons.lang3.StringUtils.isNotBlank(id)){
			return pmSensitiveWordsFilterService.getPmSensitiveWordsFilter(id);
		}else{
			return new PmSensitiveWordsFilter();
		}
	}
	
	@RequiresPermissions("merchandise:PmSensitiveWordsFilter:view")
	@RequestMapping(value = {"list", ""})
	public String getList(PmSensitiveWordsFilter pmSensitiveWordsFilter, HttpServletRequest request, HttpServletResponse response, Model model){
		    Page<PmSensitiveWordsFilter> page=pmSensitiveWordsFilterService.getPageList(pmSensitiveWordsFilter, new Page<PmSensitiveWordsFilter>(request, response));
		    if(page.getList()!=null&&page.getList().size()>0){
		    	for (PmSensitiveWordsFilter sensitiveWordsFilter : page.getList()) {
					if(sensitiveWordsFilter.getFilterObjType()==1){
						EbProduct ebProduct=ebProductService.getEbProduct(sensitiveWordsFilter.getFilterObjId().toString());
						sensitiveWordsFilter.setEbProduct(ebProduct);
					}else if(sensitiveWordsFilter.getFilterObjType()==2){
						EbProductcomment ebProductcomment=ebProductcommentService.get(sensitiveWordsFilter.getFilterObjId());
						sensitiveWordsFilter.setEbProductcomment(ebProductcomment);
					}else {
						EbDiscuss ebDiscuss=ebDiscussService.getEbDiscuss(sensitiveWordsFilter.getFilterObjId().toString());
						sensitiveWordsFilter.setEbDiscuss(ebDiscuss);
					 }
				}
		    }
		    model.addAttribute("page", page);
		    model.addAttribute("pmSensitiveWordsFilter", pmSensitiveWordsFilter);
		    return "modules/shopping/Article/pmSensitiveWordsFilterlist";
	}
    @ResponseBody
	@RequiresPermissions("merchandise:PmSensitiveWordsFilter:edit")
	@RequestMapping(value ="guolv")
	public String guolv(PmSensitiveWordsFilter pmSensitiveWordsFilter, HttpServletRequest request, HttpServletResponse response, Model model){
		 pmSensitiveWordsFilterService.guolv(pmSensitiveWordsFilter.getId().toString());
		return "redirect:"+Global.getAdminPath()+"/PmSensitiveWordsFilter";
	}
	
	
}
