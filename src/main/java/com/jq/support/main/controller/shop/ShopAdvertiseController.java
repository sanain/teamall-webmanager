package com.jq.support.main.controller.shop;

import java.io.File;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import com.jq.support.common.config.Global;
import com.jq.support.common.persistence.Page;
import com.jq.support.common.utils.DateUtils;
import com.jq.support.common.utils.FileUtils;
import com.jq.support.common.utils.StringUtils;
import com.jq.support.common.web.BaseController;
import com.jq.support.model.product.EbAdvertise;
import com.jq.support.model.product.EbLayouttype;
import com.jq.support.model.product.EbProduct;
import com.jq.support.model.user.EbUser;
import com.jq.support.service.merchandise.mecontent.EbAdvertiseService;
import com.jq.support.service.merchandise.mecontent.EbLayouttypeService;
import com.jq.support.service.merchandise.product.EbProductService;

/**
 * 商户退货管理
 * EbAftersaleController
 * @author Li-qi
 */
@Controller
@RequestMapping(value = "${adShopPath}/ShopAdvertise/")
public class ShopAdvertiseController extends BaseController{
	
	@Autowired
	private EbAdvertiseService ebAdvertiseService;
	@Autowired
	private EbLayouttypeService ebLayouttypeService;
	@Autowired
	private EbProductService ebProductService;
	
	@RequestMapping(value = "list")
	public String list(HttpServletRequest request, HttpServletResponse response,Model model){
		EbUser ebUser=(EbUser) request.getSession().getAttribute("shopuser");
		String layouttypeName= request.getParameter("layouttypeName");
		String advertiseType= request.getParameter("advertiseType");
		String layouttypeId= request.getParameter("layouttypeId");
		EbAdvertise ebAdvertise=new EbAdvertise();
		if(StringUtils.isNotBlank(layouttypeName)){
			ebAdvertise.setLayouttypeName(layouttypeName);
		}
		if(StringUtils.isNotBlank(advertiseType)){
			ebAdvertise.setAdvertiseType(Integer.valueOf(advertiseType));
		}
		ebAdvertise.setStatus(2);
		ebAdvertise.setShopId(ebUser.getShopId());
		Page<EbAdvertise>page=ebAdvertiseService.getPageList(new Page<EbAdvertise>(request,response), ebAdvertise);
		if(page.getCount()!=0){
			model.addAttribute("page", page);
		}
		EbLayouttype layouttype=new EbLayouttype();
		layouttype.setObjAdModule("5");//对应业务广告模板：1、线上商城（天猫）；2、线下门店（美团/附近）；3、善于发现（什么值得买）；4、御可贡茶商学院；5、商家；
		layouttype.setStatus(1);
		layouttype.setShopId(ebUser.getShopId());
		List<EbLayouttype>layouttypes=ebLayouttypeService.getList(layouttype);
		if(CollectionUtils.isNotEmpty(layouttypes)){
			model.addAttribute("layouttypes", layouttypes);
		}
		model.addAttribute("advertiseType", advertiseType);
		model.addAttribute("layouttypeName", layouttypeName);
		model.addAttribute("layouttypeId", layouttypeId);
		return "modules/shop/fitment";
	}
	
	@RequestMapping(value = "edit")
	public String edit(HttpServletRequest request, HttpServletResponse response,Model model){
		String layouttypeId= request.getParameter("layouttypeId");
		String advertiseid= request.getParameter("advertiseid");
		if(StringUtils.isNotBlank(layouttypeId)){
			if(StringUtils.isNotBlank(advertiseid)){
				EbAdvertise advertise=ebAdvertiseService.getebadAdvertise(advertiseid);
				if(advertise!=null){
					if(advertise.getAdvertiseType()!=null){
						if(advertise.getAdvertiseType()==2){
							if(advertise.getAdvertiseTypeObjId()!=null){
								EbProduct ebProduct= ebProductService.getEbProduct(advertise.getAdvertiseTypeObjId().toString());
								advertise.setEbProduct(ebProduct);
							}
						 }
					}
					model.addAttribute("advertise", advertise);
				}
			}
			createPicFold(request);
			EbLayouttype layouttype=ebLayouttypeService.geteblLayouttype(layouttypeId);
			if(layouttype!=null){
				model.addAttribute("layouttype", layouttype);
			}
			return "modules/shop/fitment-edit";
		}else {
			EbLayouttype layouttype=new EbLayouttype();
			layouttype.setObjAdModule("5");//对应业务广告模板：1、线上商城（天猫）；2、线下门店（美团/附近）；3、善于发现（什么值得买）；4、御可贡茶商学院；5、商家；
			layouttype.setStatus(1);
			List<EbLayouttype>layouttypes=ebLayouttypeService.getList(layouttype);
			if(CollectionUtils.isNotEmpty(layouttypes)){
				model.addAttribute("layouttypes", layouttypes);
			}
			return "modules/shop/fitment-add";
		}
	}
	
	@RequestMapping(value = "status")
	public String status(HttpServletRequest request, HttpServletResponse response,Model model) throws Exception{
		String advertiseid=request.getParameter("advertiseid");
		String status=request.getParameter("status");
		if(StringUtils.isNotBlank(advertiseid)){
			EbAdvertise advertise=ebAdvertiseService.getebadAdvertise(advertiseid);
			if(advertise!=null){
				if(status.equals("0")){//0,显示1隐藏2，删除
					advertise.setStatus(0);
				}
				if(status.equals("1")){//0,显示1隐藏2，删除
					advertise.setStatus(1);
				}
				if(status.equals("2")){//0,显示1隐藏2，删除
					advertise.setStatus(2);
				}
				ebAdvertiseService.save(advertise);
			}
		}
		return "redirect:/shop/ShopAdvertise/list";
	}
	
	@RequestMapping(value = "add")
	public String add(HttpServletRequest request, HttpServletResponse response,Model model) throws Exception{
		EbUser ebUser=(EbUser) request.getSession().getAttribute("shopuser");
		String advertiseid=request.getParameter("advertiseid");
		String orderNo=request.getParameter("orderNo");
		String mo=request.getParameter("mo");
		String advertiseType=request.getParameter("advertiseType");
		String advertuseImg=request.getParameter("advertuseImg");
		String advertiseTitle=request.getParameter("advertiseTitle");
		String sellPrice=request.getParameter("sellPrice");
		String charitySize=request.getParameter("charitySize");
		String layouttypeId=request.getParameter("layouttypeId");
		String lamoduleTitle=request.getParameter("lamoduleTitle");//模板名称
		String advertiseTypeObjId=request.getParameter("advertiseTypeObjId");//对象id
		String linkUrl=request.getParameter("linkUrl");//链接
		EbAdvertise ebAdvertise=null;
		if(StringUtils.isNotBlank(advertiseid)){
			ebAdvertise=ebAdvertiseService.getebadAdvertise(advertiseid);
		}else{
			ebAdvertise=new EbAdvertise();
		}
		if(ebAdvertise!=null){
			Date nowDate=new Date();
			ebAdvertise.setLayouttypeId(layouttypeId);
			ebAdvertise.setLayouttypeName(lamoduleTitle);
			ebAdvertise.setAdvertiseTitle(advertiseTitle);
//			ebAdvertise.setAdvertiseName(advertiseName);//广告名称
			ebAdvertise.setAdvertiseType(Integer.valueOf(advertiseType));
			ebAdvertise.setAdvertuseImg(advertuseImg);
			if(StringUtils.isNotBlank(advertiseTypeObjId)){
				ebAdvertise.setAdvertiseTypeObjId(Integer.parseInt(advertiseTypeObjId));
			}
//			ebAdvertise.setAdcertuseDetails(adcertuseDetails);//广告详情
			ebAdvertise.setStatus(Integer.valueOf(mo));
//			ebAdvertise.setIsBack(isBack);//滚动1.不滚动，2，滚动 3，置顶滚动
//			ebAdvertise.setPints(pints);//热点1，是2，否
			ebAdvertise.setLinkUrl(linkUrl);//链接
			ebAdvertise.setOrderNo(Integer.valueOf(orderNo));
			ebAdvertise.setShopId(ebUser.getShopId());
			//ebAdvertise.setSellPrice(Double.parseDouble(sellPrice));
			//ebAdvertise.setCharitySize(charitySize);
			if(StringUtils.isNotBlank(advertiseid)){
				ebAdvertise.setModifyTime(nowDate);
				ebAdvertise.setModifyUser("shopID:"+ebUser.getShopId());
			}else {
				ebAdvertise.setCreateTime(nowDate);
				ebAdvertise.setCreateUser("shopID:"+ebUser.getShopId());
				ebAdvertise.setModifyTime(nowDate);
				ebAdvertise.setModifyUser("shopID:"+ebUser.getShopId());
			}
			ebAdvertiseService.save(ebAdvertise);
		}
		return "redirect:/shop/ShopAdvertise/list";
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
		String userShopId="";
		// ===========集群文件字段处理 end===============
		if(request.getSession().getAttribute("userShopId")!=null){
			  userShopId = (String)request.getSession().getAttribute("userShopId");
	    }
		 folder.append(userShopId);
		 folder.append(File.separator);
		 folder.append("images");
		 folder.append(File.separator);
		 folder.append(File.separator);
		 folder.append("shopImg");
		 folder.append(File.separator);
		 folder.append(DateUtils.getYear());
		 folder.append(File.separator);
		 folder.append(DateUtils.getMonth());
		 FileUtils.createDirectory(folder.toString());
	}
}