package com.jq.support.main.controller.merchandise.article;

import java.io.File;
import java.text.ParseException;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringEscapeUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.solr.common.util.DateUtil;
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
import com.jq.support.common.utils.DateUtils;
import com.jq.support.common.utils.FileUtils;
import com.jq.support.common.utils.StringUtils;
import com.jq.support.common.web.BaseController;
import com.jq.support.model.article.EbArticle;
import com.jq.support.model.article.EbArticleType;
import com.jq.support.model.article.EbDiscuss;
import com.jq.support.model.product.EbLabel;
import com.jq.support.model.sys.SysUser;
import com.jq.support.service.merchandise.article.EbArticleService;
import com.jq.support.service.merchandise.article.EbArticleTypeService;
import com.jq.support.service.merchandise.article.EbDiscussService;
import com.jq.support.service.merchandise.mecontent.EbLabelService;
import com.jq.support.service.utils.SysUserUtils;

/**
 * 规格属性管理Controller
 * @author Administrator
 *
 */
@Controller
@RequestMapping(value = "${adminPath}/ebArticle")
public class EbArticleController extends BaseController {
  @Autowired
  private EbArticleService ebArticleService;
  @Autowired
  private EbArticleTypeService ebArticleTypeService;
  @Autowired
  private EbLabelService ebLabelService;
  @Autowired
  private EbDiscussService ebDiscussService;
  
  
  private static String domainurl = Global.getConfig("domainurl");
  private static String innerImgPartPath = "src=\"/uploads/images/";
  private static String innerImgFullPath = "src=\"" + domainurl  + "/uploads/images/";
  
  
  
    @ModelAttribute
	public EbArticle get(@RequestParam(required=false) String articleId) {
		if (StringUtils.isNotBlank(articleId)){
			return ebArticleService.getEbArticle(articleId);
		}else{
			return new EbArticle();
		}
	}
    
    @RequiresPermissions("merchandise:ebArticle:view")
	@RequestMapping(value = "tree")
	public String tree(HttpServletRequest request, HttpServletResponse response, Model model) {
    	List<EbArticleType> ebArticleTypes= ebArticleTypeService.getEbArticleTypeTree();
		 model.addAttribute("ebArticleTypes", ebArticleTypes);
		 String url=domainurl+Global.getAdminPath()+"/ebArticle/list?articleTypeId=";
		 model.addAttribute("url", url);
		return "modules/shopping/Article/ebArticleTypeTree";
	}
    
    @RequiresPermissions("merchandise:ebArticle:view")
   	@RequestMapping(value = "commentlist")
   	public String commentlist(HttpServletRequest request, HttpServletResponse response, Model model) {
    	String articleId=request.getParameter("articleId");
    	String articleTypeId=request.getParameter("articleTypeId");
    	String discussStatus=request.getParameter("discussStatus");
    	String examineStatus=request.getParameter("examineStatus");
    	EbDiscuss parameter=new EbDiscuss();
    	if(StringUtils.isNotBlank(articleId)){
    		parameter.setArticleId(Integer.valueOf(articleId));
//    		parameter.setDiscussPid(Integer.valueOf(articleId));
    		/*parameter.setDiscussType(1);*/
			if(StringUtils.isNotBlank(discussStatus)){
				parameter.setDiscussStatus(Integer.valueOf(discussStatus));
			}
			if(StringUtils.isNotBlank(examineStatus)){
				parameter.setExamineStatus(Integer.valueOf(examineStatus));
			}
	    	Page<EbDiscuss> page=ebDiscussService.getPageList(new Page<EbDiscuss>(request, response), parameter);
	    	if(page.getCount()>0){
	    		for (int i = 0; i < page.getList().size(); i++) {
	    			EbDiscuss discusses=page.getList().get(i);
	    			if(discusses.getDiscussType()!=null && discusses.getDiscussType()==2){
	    				EbDiscuss discussfirst=ebDiscussService.getEbDiscuss(discusses.getDiscussPid().toString());
	    				if(discussfirst!=null){
	    					discusses.setEbDiscuss(discussfirst);
	    					page.getList().set(i, discusses);
	    				}
	    			}
//	    			parameter.setDiscussPid(discusses.getDiscussId());
//	    			parameter.setDiscussType(2);
//	    			parameter.setDiscussStatus(0);
//	    			List<EbDiscuss> ebDiscuss=ebDiscussService.getCommentsArticleList(parameter,0, 1);
//	    			if(CollectionUtils.isNotEmpty(ebDiscuss)){
//	    				discusses.setEbDiscusseList(ebDiscuss);
//	    				page.getList().set(i, discusses);
//	    			}
				}
			}
	    	model.addAttribute("page",page);
	    	model.addAttribute("articleId", articleId);
	    	model.addAttribute("articleTypeId", articleTypeId);
	    	model.addAttribute("discussStatus", discussStatus);
	    	model.addAttribute("examineStatus", examineStatus);
    	}
    	return "modules/shopping/Article/articleCommentList";
   	}
    
    @RequiresPermissions("merchandise:ebArticle:edit")
   	@RequestMapping(value = "commentstatus")
   	public String commentstatus(HttpServletRequest request, HttpServletResponse response, Model model,RedirectAttributes redirectAttributes) {
    	String articleId=request.getParameter("articleId");
    	String articleTypeId=request.getParameter("articleTypeId");
    	String discussId=request.getParameter("discussId");
    	String operationType=request.getParameter("operationType");//0.显示1.隐藏2.删除 3、审核通过；4、审核失败；
//    	SysUser user = SysUserUtils.getUser();
    	if(StringUtils.isNotBlank(operationType)){
    		EbDiscuss discusses=ebDiscussService.getEbDiscuss(discussId);
    		if(discusses!=null){
    			if(operationType.equals("0")){//0.显示1.隐藏2.删除 
    				discusses.setDiscussStatus(0);
    				ebDiscussService.save(discusses);
    				addMessage(redirectAttributes, "操作成功");
    			}
    			if(operationType.equals("1")){//0.显示1.隐藏2.删除
    				discusses.setDiscussStatus(1);
    				ebDiscussService.save(discusses);
    				addMessage(redirectAttributes, "操作成功");
        		}
    			if(operationType.equals("2")){//0.显示1.隐藏2.删除
    				discusses.setDiscussStatus(2);
    				ebDiscussService.save(discusses);
        			addMessage(redirectAttributes, "操作成功");
        		}
    			if(operationType.equals("3")){//3、审核通过；4、审核失败；
    				discusses.setExamineStatus(2);
    				ebDiscussService.save(discusses);
    				addMessage(redirectAttributes, "操作成功");
        		}
    			if(operationType.equals("4")){//3、审核通过；4、审核失败；
    				discusses.setExamineStatus(3);
    				ebDiscussService.save(discusses);
    				addMessage(redirectAttributes, "操作成功");
        		}
			}
    	}
    	model.addAttribute("articleId", articleId);
		model.addAttribute("articleTypeId", articleTypeId);
    	return "redirect:"+Global.getAdminPath()+"/ebArticle/commentlist?articleTypeId="+articleTypeId+"&articleId="+articleId;
   	}
    
    @RequiresPermissions("merchandise:ebArticle:view")
	@RequestMapping(value = {"show", ""})
	public String show(HttpServletRequest request, HttpServletResponse response, Model model) {
		return "modules/shopping/Article/ebArticle";
	}
    
    @RequiresPermissions("merchandise:ebArticle:view")
   	@RequestMapping(value = "list")
   	public String list(EbArticle ebArticle,String stule,HttpServletRequest request, HttpServletResponse response, Model model) {
    	//EbArticle ebArticle=new EbArticle();
    	/*ebArticle.setSpertAttrName(spertAttrName);
    	if(StringUtils.isNotBlank(productTypeId)){
    		ebArticle.setProductTypeId(Integer.parseInt(productTypeId));
    	}
    	if(StringUtils.isNotBlank(spertAttrType)){
    		ebArticle.setSpertAttrType(Integer.parseInt(spertAttrType));
    	}*/
    	if (ebArticle.getArticleTypeId()==null) {
    		ebArticle.setArticleTypeId(ebArticleTypeService.getMinTypeId());
    	}
    	Page<EbArticle> page=ebArticleService.getPageEbArticleList(new Page<EbArticle>(request, response), ebArticle,stule);
    	EbArticleType ebArticleType=ebArticleTypeService.getEbArticleType(ebArticle.getArticleTypeId()+"");
    	model.addAttribute("ebArticleType",ebArticleType);
    	model.addAttribute("stule",stule);
    	model.addAttribute("page", page);
    	model.addAttribute("ebArticle", ebArticle);
    	model.addAttribute("articleTypeId", ebArticle.getArticleTypeId());
    	return "modules/shopping/Article/ebArticleList";
   	}
    
    @RequiresPermissions("merchandise:ebArticle:view")
   	@RequestMapping(value = "from")
   	public String from(EbArticle ebArticle,HttpServletRequest request, HttpServletResponse response, Model model) {
    	EbArticleType ebArticleType=ebArticleTypeService.getEbArticleType(ebArticle.getArticleTypeId()+"");
    	createPicFold(request);
    	model.addAttribute("ebArticleType",ebArticleType);
	    model.addAttribute("ebArticle",ebArticle);
	    
    	return "modules/shopping/Article/ebArticleFrom";
   	}
    
    @RequiresPermissions("merchandise:ebArticle:edit")
   	@RequestMapping(value = "save")
   	public String save(EbArticle ebArticle,HttpServletRequest request, HttpServletResponse response, Model model,RedirectAttributes redirectAttributes) throws ParseException {
    	SysUser user = SysUserUtils.getUser();
		if(ebArticle.getArticleId()==null){
			if(user.getCompany()!=null&&StringUtils.isNotBlank(user.getCompany().getId())){
				ebArticle.setAgentId(user.getCompany().getId());
			}
			ebArticle.setSortNum(0);
		}
		if (ebArticle.getArticleContent()!=null){
			ebArticle.setArticleContent(StringEscapeUtils.unescapeHtml4(ebArticle.getArticleContent()));
		}
		/*String statrDate=request.getParameter("statrDate");
		if(StringUtils.isNotBlank(statrDate)){
			ebArticle.setReleasetime(DateUtil.parseDate(statrDate));
		}*/
		ebArticleService.save(ebArticle);
		
		//设置排序号
		if (ebArticle.getSortNum()==0) {
			ebArticle.setSortNum(ebArticle.getArticleId());
			ebArticleService.save(ebArticle);
		}
		addMessage(redirectAttributes, "保存成功");
		return "redirect:"+Global.getAdminPath()+"/ebArticle/list?articleTypeId="+ebArticle.getArticleTypeId();
   	}

    @RequiresPermissions("merchandise:ebArticle:view")
   	@RequestMapping(value = "detail")
   	public String detail(EbArticle ebArticle,HttpServletRequest request, HttpServletResponse response, Model model) {
	    model.addAttribute("ebArticle",ebArticle);
    	return "modules/shopping/Article/ebArticleDetail";
   	}
    
    //排序 交换排序id
    @RequestMapping(value = "sort")
    @ResponseBody
    public String sort(String  oneId,String twoId,HttpServletRequest request, HttpServletResponse response, Model model) {
    	if (StringUtils.isNotBlank(oneId)&&StringUtils.isNotBlank(twoId)) {
    		EbArticle one=ebArticleService.getEbArticle(oneId);
    		EbArticle two=ebArticleService.getEbArticle(twoId);
    		if (one!=null&&two!=null) {
    			int oneSortnum=one.getSortNum();
    			one.setSortNum(two.getSortNum());
    			two.setSortNum(oneSortnum);
    			ebArticleService.save(one);
    			ebArticleService.save(two);
			}
		}
    	return "00";
    }
    
    
    @RequiresPermissions("merchandise:ebArticle:edit")
   	@RequestMapping(value = "delete")
   	public String delete(String id,HttpServletRequest request, HttpServletResponse response, Model model,RedirectAttributes redirectAttributes) {
    	EbArticle ebArticle = ebArticleService.getEbArticle(id);
    	if (ebArticle!=null) {
    		ebArticleService.delete(ebArticle);
		}
    	addMessage(redirectAttributes, "删除成功");
		return "redirect:"+Global.getAdminPath()+"/ebArticle/list?articleTypeId="+ebArticle.getArticleTypeId();
   	}
    @RequestMapping(value = "saveTags")
	public String saveTags(String id,HttpServletRequest request, HttpServletResponse response) {
		String[] tag=request.getParameterValues("tag");
		String ids="";
		String name="";
		if(StringUtils.isNotBlank(id)){
			EbArticle ebArticle = ebArticleService.getEbArticle(id);
		  if(tag!=null){
			  for (int i = 0; i < tag.length; i++) {
				  ids+=""+tag[i]+",";
				  EbLabel ebLabels= ebLabelService.getEbLabel(tag[i]);
				  name+=""+ebLabels.getName()+",";
			}
		  }
		  ebArticle.setLabelIds(ids);
		  ebArticle.setLabelNames(name);
		  ebArticleService.save(ebArticle);
		  return "redirect:"+Global.getAdminPath()+"/ebArticle/list?articleTypeId="+ebArticle.getArticleTypeId();
		}
		return "redirect:"+Global.getAdminPath()+"/ebArticle/list";
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
		folder.append("article");
		folder.append(File.separator);
		folder.append("adImg");
		folder.append(File.separator);
		folder.append(DateUtils.getYear());
		folder.append(File.separator);
		folder.append(DateUtils.getMonth());
		FileUtils.createDirectory(folder.toString());
		
//		StringBuffer folder_1 = new StringBuffer(root);
//		folder_1.append("uploads");
//		folder_1.append(File.separator);
//		// ===========集群文件处理 start===============
//		if (StringUtils.isNotBlank(wfsName)) {
//			folder_1.append(wfsName);
//			folder_1.append(File.separator);
//		}
//		// ===========集群文件字段处理 end===============
//		folder_1.append("000000");
//		folder_1.append(File.separator);
//		folder_1.append("images" );
//		folder_1.append(File.separator);
//		folder_1.append("img");
//		FileUtils.createDirectory(folder_1.toString());
	}
	
  
  
  
}
