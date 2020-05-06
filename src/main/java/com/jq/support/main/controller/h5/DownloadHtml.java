package com.jq.support.main.controller.h5;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.jq.support.common.config.Global;
import com.jq.support.common.utils.StringUtils;
import com.jq.support.common.web.BaseController;
import com.jq.support.model.article.EbArticle;
import com.jq.support.model.product.Clinetversion;
import com.jq.support.service.merchandise.article.EbArticleService;
import com.jq.support.service.merchandise.mecontent.ClinetversionService;


@Controller
@RequestMapping("/")
public class DownloadHtml extends BaseController {
	@Autowired
	private ClinetversionService clinetversionService;
	@RequestMapping("download")
	public String download(HttpServletRequest request,Model model) throws Exception {
		List<Clinetversion> list=clinetversionService.getClinetversion(new Clinetversion());
		if (CollectionUtils.isNotEmpty(list)) {
			model.addAttribute("clinetVersion", list.get(0));
			model.addAttribute("addr",Global.getConfig("domainurl") +list.get(0).getVersionSrc());
		}
		return "modules/h5/download";
	}

}
