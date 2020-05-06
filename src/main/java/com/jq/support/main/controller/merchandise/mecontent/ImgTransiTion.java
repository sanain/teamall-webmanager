package com.jq.support.main.controller.merchandise.mecontent;

import java.awt.Image;
import java.io.File;
import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.List;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jq.support.common.config.Global;
import com.jq.support.common.web.BaseController;
import com.jq.support.model.sys.SysDict;
import com.jq.support.service.utils.DictUtils;
import com.jq.support.service.utils.ScaleImageUtils;
import com.jq.support.service.utils.ScaleImageUtils.ImageQuality;
import com.sun.image.codec.jpeg.ImageFormatException;


@Controller
@RequestMapping(value = "/")
public class ImgTransiTion extends BaseController {
	private static String domainurl = Global.getConfig("domainurl");
	private static String insideDomainurl = Global.getConfig("insideDomainurl");
	
	@SuppressWarnings("restriction")
	@RequestMapping(value = "ImgTransiTionUs")
	public  String  ImgTransiTionUs(String url,String proportion,HttpServletRequest request, HttpServletResponse response, Model model) {
		String newUrl="";
		try {
			newUrl = ScaleImageUtils.resize(Float.parseFloat(proportion), insideDomainurl+url, new URL(insideDomainurl+url),request);
		} catch (NumberFormatException e) {
			e.printStackTrace();
		} catch (ImageFormatException e) {
			e.printStackTrace();
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return "redirect:"+domainurl+newUrl;
	}

}
