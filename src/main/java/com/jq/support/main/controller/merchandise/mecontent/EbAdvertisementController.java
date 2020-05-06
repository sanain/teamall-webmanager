package com.jq.support.main.controller.merchandise.mecontent;

import com.jq.support.common.config.Global;
import com.jq.support.common.persistence.Page;
import com.jq.support.common.utils.DateUtils;
import com.jq.support.common.utils.FileUtils;
import com.jq.support.common.web.BaseController;
import com.jq.support.model.advertisement.EbAdvertisement;
import com.jq.support.service.advertisement.EbAdvertisementService;
import com.jq.support.service.merchandise.article.EbArticleService;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;


/**
 * 门店广告投放
 *
 */
@Controller
@RequestMapping(value = "${adminPath}/EbAdvertisement")
public class EbAdvertisementController extends BaseController {
	@Autowired
	private EbAdvertisementService ebAdvertisementService;

	private EbArticleService ebArticleService;
	private static String domainurl = Global.getConfig("domainurl");
	private static String innerImgPartPath = "src=\"/uploads/images/";
	private static String innerImgFullPath = "src=\"" + domainurl  + "/uploads/images/";

	@ModelAttribute
	public  EbAdvertisement get(@RequestParam(required=false) String id) {
		if (StringUtils.isNotBlank(id)){
			return ebAdvertisementService.getEbadAdvertisement(id);
		}else{
			return new  EbAdvertisement();
		}
	}

    /**
     * 条件分页查询
     * @param ebAdvertisement
     * @param createTime
     * @param request
     * @param response
     * @param model
     * @return
     */
	@RequiresPermissions("merchandise:EbAdvertisement:view")
	@RequestMapping(value = {"list", ""})
	public String list(
			EbAdvertisement ebAdvertisement,String createTime,
			HttpServletRequest request, HttpServletResponse response, Model model){

			Page<EbAdvertisement> page=ebAdvertisementService.getPageList(new Page<EbAdvertisement>(request, response),ebAdvertisement,createTime);

			model.addAttribute("createTime", createTime);
			model.addAttribute("page", page);
		    model.addAttribute("ebAdvertisement", ebAdvertisement);
		    return "/modules/shopping/Article/ebAdvertisementList";
	}

    /**
     * 跳转到更新或增加页面
     * @param ebAdvertisement
     * @param flag
     * @param request
     * @param response
     * @param model
     * @return
     */
	@RequiresPermissions("merchandise:EbAdvertisement:edit")
	@RequestMapping(value = "form")
	public String form(
			EbAdvertisement ebAdvertisement, String flag,
			HttpServletRequest request, HttpServletResponse response, Model model){
			//创建文件上传路径
		    createPicFold(request);

		    if(StringUtils.isNotBlank(flag) && "add".equals(flag)){
		    	model.addAttribute("flag","add");
			}else{
		    	//处理时间
				Date createTime = ebAdvertisement.getCreateTime();
				SimpleDateFormat sdf =   new SimpleDateFormat( "yyyy-MM-dd HH:mm:ss" );
				String format = sdf.format(createTime);
				model.addAttribute("createTime",format);

				/**
				 * 处理图片路径  数据库的格式 图片路径,图片路径   页面需要的路径 |图片路径|图片路径
				 */
				if(StringUtils.isNotBlank(ebAdvertisement.getAsPic())){
					String str = ebAdvertisement.getAsPic().replace(",","|");
					str = "|"+str;
					ebAdvertisement.setAsPic(str);
				}
			}

		return "/modules/shopping/Article/ebAdvertisementFrom";
	}

	/**
	 * 增加广告
	 * @param ebAdvertisement
	 * @param request
	 * @param response
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions("merchandise:EbAdvertisement:edit")
	@RequestMapping(value = "save" ,  method = RequestMethod.POST)
	public String save(
			EbAdvertisement ebAdvertisement,
			HttpServletRequest request, HttpServletResponse response, Model model,RedirectAttributes redirectAttributes){
			ebAdvertisement.setCreateTime(new Date());
			ebAdvertisement.setDel(0);

			/**
			 * 处理图片路径  原本的格式|图片路径|图片路径
			 */
			if(StringUtils.isNotBlank(ebAdvertisement.getAsPic())){
				String str = ebAdvertisement.getAsPic();
				str = str.replace("|",",");
				//防止修改图片时，把原有的图片都删掉，导致格式混乱
				if(str.indexOf("/") < 0){
					str = "";
				}else{
					str = str.substring(str.indexOf("/"));
				}
				ebAdvertisement.setAsPic(str);
			}

		    ebAdvertisementService.save(ebAdvertisement);

		    model.addAttribute("prompt", "保存成功");
			return "redirect:"+Global.getAdminPath()+"/EbAdvertisement/list";
	}

	/**
	 * 修改广告
	 * @param ebAdvertisement
	 * @param redirectAttributes
	 * @param model
	 * @return
	 */
	@RequiresPermissions("merchandise:EbAdvertisement:edit")
	@RequestMapping(value = "update" , method = RequestMethod.POST)
	public String update(
			EbAdvertisement ebAdvertisement,String createTime,RedirectAttributes redirectAttributes,Model model){
		//创建时间的转化
		SimpleDateFormat sdf =   new SimpleDateFormat( "yyyy-MM-dd HH:mm:ss" );
		try {
			Date date = sdf.parse(createTime);
			ebAdvertisement.setCreateTime(date);
		} catch (ParseException e) {
			e.printStackTrace();
		}

		//原本的路径，是为了调回修改页面的时候图片还能显示
		String oldPath = null;

		/**
		 * 处理图片路径  原本的格式|图片路径|图片路径
		 */
		if(StringUtils.isNotBlank(ebAdvertisement.getAsPic())){
			oldPath = ebAdvertisement.getAsPic();
			String str = oldPath.replace("|",",");
			//防止修改图片时，把原有的图片都删掉，导致格式混乱
			if(str.indexOf("/") < 0){
				str = "";
			}else{
				str = str.substring(str.indexOf("/"));
			}
			ebAdvertisement.setAsPic(str);
		}

		boolean result = ebAdvertisementService.update(ebAdvertisement);


		EbAdvertisement newEbAdvertisement = new EbAdvertisement();
		//把ebAdvertisement所有的属性复制到newEbAdvertisement
		BeanUtils.copyProperties(ebAdvertisement, newEbAdvertisement);
		newEbAdvertisement.setAsPic(oldPath);

		model.addAttribute("ebAdvertisement",newEbAdvertisement);
		model.addAttribute("createTime",createTime);
		String prompt = "更新失败！";
		if(result){
			prompt = "更新成功！";
		}
		model.addAttribute("prompt",prompt);
		return "/modules/shopping/Article/ebAdvertisementFrom";
	}

	/**
	 * 删除广告
	 * @param ebAdvertisement
	 * @param request
	 * @param response
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions("merchandise:EbAdvertisement:edit")
	@RequestMapping(value = "delete")
	public String delete(
			EbAdvertisement ebAdvertisement,
			HttpServletRequest request, HttpServletResponse response, Model model,RedirectAttributes redirectAttributes){
		    ebAdvertisementService.delete(ebAdvertisement);
		    addMessage(redirectAttributes, "删除成功");
			return "redirect:"+Global.getAdminPath()+"/EbAdvertisement/list";
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
		folder.append("ebAdvertisement");
		folder.append(File.separator);
		folder.append(DateUtils.getYear());
		folder.append(File.separator);
		folder.append(DateUtils.getMonth());
		FileUtils.createDirectory(folder.toString());
	}
}
