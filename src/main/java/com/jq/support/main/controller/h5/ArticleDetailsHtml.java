package com.jq.support.main.controller.h5;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.jq.support.common.utils.StringUtils;
import com.jq.support.common.web.BaseController;
import com.jq.support.model.article.EbArticle;
import com.jq.support.service.merchandise.article.EbArticleService;


@Controller
@RequestMapping("/ArticleDetailsHtml")
public class ArticleDetailsHtml extends BaseController {
	@Autowired
	private EbArticleService ebArticleService;
	
	@RequestMapping(value="{id}${urlSuffix}")
	public String ArticleDetails(@PathVariable String id, HttpServletRequest request,Model model) throws Exception {
		 EbArticle ebArticle=new EbArticle();
		if(StringUtils.isNotBlank(id)){
		   ebArticle=ebArticleService.getEbArticle(id);
		 }
		double s=ebArticleService.getzhibuzhi(id);
		model.addAttribute("s", s);
		model.addAttribute("ebArticle", ebArticle);
		return "modules/h5/article-details";
	}

}
